package tests

import (
	"fmt"
	"os"
	"os/exec"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/azure"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

type LinuxVirtualMachine struct {
	Name                string            `json:"name"`
	ResourceGroupName   string            `json:"resource_group_name"`
	Size                string            `json:"size"`
	AdminUsername       string            `json:"admin_username"`
	Tags                map[string]string `json:"tags"`
	NetworkInterfaceIDs []string          `json:"network_interface_ids"`
}

var expectedLinuxVM *LinuxVirtualMachine = nil
var RequiredTags []string = []string{
	"Environment",
	"Deployment",
	"Project",
}

func AssertLinuxVMExists(t *testing.T) {
	vm := azure.GetVirtualMachine(t, expectedLinuxVM.Name, expectedLinuxVM.ResourceGroupName, "")
	assert.Equal(t, expectedLinuxVM.Name, *vm.Name)
}

func AssertLinuxVMSize(t *testing.T) {
	vm := azure.GetVirtualMachine(t, expectedLinuxVM.Name, expectedLinuxVM.ResourceGroupName, "")

	assert.NotNil(t, vm.Properties)
	assert.NotNil(t, vm.Properties.HardwareProfile)
	assert.NotNil(t, vm.Properties.HardwareProfile.VMSize)

	actualSize := string(*vm.Properties.HardwareProfile.VMSize)

	assert.Equal(t, expectedLinuxVM.Size, actualSize)

}

func AssertLinuxVMIsTagged(t *testing.T) {
	vm := azure.GetVirtualMachine(t, expectedLinuxVM.Name, expectedLinuxVM.ResourceGroupName, "")
	actualTags := vm.Tags

	if len(actualTags) < 1 {
		err := fmt.Errorf("base tags not applied")
		t.Errorf("%v", err)
	}

	for _, key := range RequiredTags {
		if _, exists := actualTags[key]; !exists {
			err := fmt.Errorf("required tag key not found in tagset: %s", key)
			t.Errorf("%v", err)
			fmt.Printf("%v and %v", actualTags, key)
		}
	}
}

func setAzureEnvFromCLI(t *testing.T) {
	getValue := func(cmd ...string) string {
		out, err := exec.Command(cmd[0], cmd[1:]...).Output()
		if err != nil {
			t.Fatalf("Failed to run command %v: %v", cmd, err)
		}
		return strings.TrimSpace(string(out))
	}

	// Get the default subscription ID
	subID := getValue("az", "account", "show", "--query", "id", "-o", "tsv")
	tenantID := getValue("az", "account", "show", "--query", "tenantId", "-o", "tsv")

	// Set required env vars for Terratest
	os.Setenv("ARM_SUBSCRIPTION_ID", subID)
	os.Setenv("ARM_TENANT_ID", tenantID)
}

func TestAzureLinuxVirtualMachine(t *testing.T) {
	t.Parallel()
	setAzureEnvFromCLI(t)

	tfOpts := &terraform.Options{
		TerraformDir: "../example", // Adjust if your Terraform files are in a different location
		VarFiles: []string{
			"terraform.tfvars", // Ensure this file has the necessary variables
		},
	}

	defer terraform.Destroy(t, tfOpts)
	terraform.InitAndApply(t, tfOpts)

	expectedLinuxVM = &LinuxVirtualMachine{}
	terraform.OutputStruct(t, tfOpts, "linux_vm", expectedLinuxVM)

	assert.NotEmpty(t, expectedLinuxVM.Name)
	assert.NotEmpty(t, expectedLinuxVM.ResourceGroupName)

	fmt.Printf("Linux VM: %+v\n", expectedLinuxVM)

	t.Run("LinuxVM_exists", AssertLinuxVMExists)
	t.Run("LinuxVM_is_tagged_correctly", AssertLinuxVMIsTagged)

	t.Run("LinuxVM_is_properly_sized", AssertLinuxVMSize)
}
