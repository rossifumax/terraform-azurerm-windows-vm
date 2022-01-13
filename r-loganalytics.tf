resource "azurerm_virtual_machine_extension" "log_extension" {
  count = var.enable_log_analytics_extension ? 1 : 0

  name = "${local.vm_name}-logextension"

  publisher                  = "Microsoft.EnterpriseCloud.Monitoring"
  type                       = "MicrosoftMonitoringAgent"
  type_handler_version       = var.log_analytics_agent_version
  auto_upgrade_minor_version = true

  virtual_machine_id = azurerm_windows_virtual_machine.vm.id

  settings = <<SETTINGS
  {
    "workspaceId": "${var.log_analytics_workspace_guid}"
  }
SETTINGS

  protected_settings = <<SETTINGS
  {
    "workspaceKey": "${var.log_analytics_workspace_key}"
  }
SETTINGS
}
