terraform {
  required_providers {
    fusionauth = {
      source = "gpsinsight/fusionauth"
      version = "0.1.96"
    }
  }
}

provider "fusionauth" {
  api_key = var.fusionauth_api_key
  host = var.fusionauth_host
}

data "fusionauth_tenant" "Default" {
  name = "Default"
}

data "fusionauth_application" "FusionAuth" {
  name = "FusionAuth"
}

resource "fusionauth_application" "forum" {
  tenant_id = data.fusionauth_tenant.Default.id
  name = "forum"
}

resource "fusionauth_application_role" "forum_admin_role" {
  application_id = fusionauth_application.forum.id
  is_default     = false
  is_super_role  = true
  name           = "admin"
}

resource "fusionauth_application_role" "forum_user_role" {
  application_id = fusionauth_application.forum.id
  is_default     = true
  is_super_role  = false
  name           = "user"
}

resource "fusionauth_user" "forum-user1" {
  email                    = "forum-user1@email.internal"
  first_name               = "John"
  last_name                = "Doe"
  middle_name              = "William"
  password_change_required = true
  password                 = "%WLTvrsYELsyPqC^R7FMUNxt##VyDf6XaWk2R7!gS$oL76Ww"
  username_status          = "ACTIVE"
}

resource "fusionauth_user" "forum-admin1" {
  email                    = "forum-admin1@email.internal"
  first_name               = "John"
  last_name                = "Doe"
  middle_name              = "William"
  password_change_required = true
  password                 = "@CfosPAVT3&hCzz5c^&#2F5BxNUY$X!@s!7Wx9bd6Yon54e3"
  username_status          = "ACTIVE"
}

resource "fusionauth_registration" "forum-admin1-admin-role" {
  user_id        = fusionauth_user.forum-admin1.id
  application_id = fusionauth_application.forum.id
  roles          = ["admin"]
}

resource "fusionauth_registration" "forum-user1-user-role" {
  user_id        = fusionauth_user.forum-user1.id
  application_id = fusionauth_application.forum.id
  roles          = ["user"]
}
