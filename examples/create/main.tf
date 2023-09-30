terraform {
  required_providers {
    fusionauth = {
      source  = "gpsinsight/fusionauth"
      version = "0.1.96"
    }
  }
}

provider "fusionauth" {
  api_key = var.fusionauth_api_key
  host    = var.fusionauth_host
}
#tag::defaultDataSource[]
data "fusionauth_tenant" "Default" {
  name = "Default"
}

data "fusionauth_application" "FusionAuth" {
  name = "FusionAuth"
}
#end::defaultDataSource[]
#tag::createForumTenant[]
resource "fusionauth_tenant" "forum" {
  lifecycle {
    prevent_destroy = true
  }
  issuer   = "forum"
  name     = "Forum"
  theme_id = var.fusionauth_default_theme_id
  multi_factor_configuration {
    login_policy = "Disabled"
  }
  login_configuration {
    require_authentication = false
  }
  external_identifier_configuration {
    authorization_grant_id_time_to_live_in_seconds = 30
    change_password_id_generator {
      length = 32
      type   = "randomBytes"
    }
    change_password_id_time_to_live_in_seconds = 600
    device_code_time_to_live_in_seconds        = 300
    device_user_code_id_generator {
      length = 6
      type   = "randomAlphaNumeric"
    }
    email_verification_id_generator {
      length = 32
      type   = "randomBytes"
    }
    email_verification_id_time_to_live_in_seconds = 86400
    email_verification_one_time_code_generator {
      length = 6
      type   = "randomAlphaNumeric"
    }
    external_authentication_id_time_to_live_in_seconds = 300
    one_time_password_time_to_live_in_seconds          = 60
    passwordless_login_generator {
      length = 32
      type   = "randomBytes"
    }
    passwordless_login_time_to_live_in_seconds = 180
    registration_verification_id_generator {
      length = 32
      type   = "randomBytes"
    }
    registration_verification_id_time_to_live_in_seconds = 86400
    registration_verification_one_time_code_generator {
      length = 6
      type   = "randomAlphaNumeric"
    }
    saml_v2_authn_request_id_ttl_seconds = 300
    setup_password_id_generator {
      length = 32
      type   = "randomBytes"
    }
    setup_password_id_time_to_live_in_seconds = 86400
    two_factor_id_time_to_live_in_seconds     = 300
    two_factor_one_time_code_id_generator {
      length = 6
      type   = "randomDigits"
    }
    two_factor_trust_id_time_to_live_in_seconds = 2592000
  }
  jwt_configuration {
    refresh_token_time_to_live_in_minutes = 43200
    time_to_live_in_seconds               = 3600
  }
  email_configuration {
    host = var.fusionauth_email_configuration_host
    port = var.fusionauth_email_configuration_port
    forgot_password_email_template_id = fusionauth_email.change-password.id
    set_password_email_template_id = fusionauth_email.setup-password.id
  }
}
#end::createForumTenant[]
#tag::createForumApplication[]
resource "fusionauth_application" "forum" {
  tenant_id = fusionauth_tenant.forum.id
  name      = "forum"
  jwt_configuration {
    access_token_id = fusionauth_key.forum-access-token.id
  }
}
#end::createForumApplication[]
#tag::createForumApplicationRoles[]
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
#end::createForumApplicationRoles[]
#tag::createKey[]
resource "fusionauth_key" "forum-access-token" {
  algorithm = "HS512"
  name      = "Forum Application Access Token Key"
}
#end::createKey[]

resource "fusionauth_email" "breached-password" {
  name                  = "Breached Password"
  default_from_name     = "Breached Password"
  default_html_template = file("${path.module}/email_templates/breached-password.html.ftl")
  default_subject       = "Breached Password"
  default_text_template = file("${path.module}/email_templates/breached-password.txt.ftl")
  from_email            = "example@local.fusionauth.io"
}

resource "fusionauth_email" "change-password" {
  name                  = "Change Password"
  default_from_name     = "Change Password"
  default_html_template = file("${path.module}/email_templates/change-password.html.ftl")
  default_subject       = "Change Password"
  default_text_template = file("${path.module}/email_templates/change-password.txt.ftl")
  from_email            = "example@local.fusionauth.io"
}

resource "fusionauth_email" "confirm-child" {
  name                  = "Confirm Child"
  default_from_name     = "Confirm Child"
  default_html_template = file("${path.module}/email_templates/confirm-child.html.ftl")
  default_subject       = "Confirm Child"
  default_text_template = file("${path.module}/email_templates/confirm-child.txt.ftl")
  from_email            = "example@local.fusionauth.io"
}

resource "fusionauth_email" "coppa-email-plus-notice" {
  name                  = "COPPA Email Plus Notice"
  default_from_name     = "COPPA Email Plus Notice"
  default_html_template = file("${path.module}/email_templates/coppa-email-plus-notice.html.ftl")
  default_subject       = "COPPA Email Plus Notice"
  default_text_template = file("${path.module}/email_templates/coppa-email-plus-notice.txt.ftl")
  from_email            = "example@local.fusionauth.io"
}

resource "fusionauth_email" "coppa-notice" {
  name                  = "COPPA Notice"
  default_from_name     = "COPPA Notice"
  default_html_template = file("${path.module}/email_templates/coppa-notice.html.ftl")
  default_subject       = "COPPA Notice"
  default_text_template = file("${path.module}/email_templates/coppa-notice.txt.ftl")
  from_email            = "example@local.fusionauth.io"
}

resource "fusionauth_email" "email-verification" {
  name                  = "Email Verification"
  default_from_name     = "Email Verification"
  default_html_template = file("${path.module}/email_templates/email-verification.html.ftl")
  default_subject       = "Email Verification"
  default_text_template = file("${path.module}/email_templates/email-verification.txt.ftl")
  from_email            = "example@local.fusionauth.io"
}

resource "fusionauth_email" "parent-registration-request" {
  name                  = "Parent Registration"
  default_from_name     = "Parent Registration"
  default_html_template = file("${path.module}/email_templates/parent-registration-request.html.ftl")
  default_subject       = "Parent Registration"
  default_text_template = file("${path.module}/email_templates/parent-registration-request.txt.ftl")
  from_email            = "example@local.fusionauth.io"
}

resource "fusionauth_email" "passwordless-login" {
  name                  = "Passwordless Login"
  default_from_name     = "Passwordless Login"
  default_html_template = file("${path.module}/email_templates/passwordless-login.html.ftl")
  default_subject       = "Passwordless Login"
  default_text_template = file("${path.module}/email_templates/passwordless-login.txt.ftl")
  from_email            = "example@local.fusionauth.io"
}

resource "fusionauth_email" "registration-verification" {
  name                  = "Registration Verification"
  default_from_name     = "Registration Verification"
  default_html_template = file("${path.module}/email_templates/registration-verification.html.ftl")
  default_subject       = "Registration Verification"
  default_text_template = file("${path.module}/email_templates/registration-verification.txt.ftl")
  from_email            = "example@local.fusionauth.io"
}

resource "fusionauth_email" "setup-password" {
  name                  = "Setup Password"
  default_from_name     = "Setup Password"
  default_html_template = file("${path.module}/email_templates/setup-password.html.ftl")
  default_subject       = "Setup Password"
  default_text_template = file("${path.module}/email_templates/setup-password.txt.ftl")
  from_email            = "example@local.fusionauth.io"
}

resource "fusionauth_email" "thread-detected" {
  name                  = "Thread Detected"
  default_from_name     = "Thread Detected"
  default_html_template = file("${path.module}/email_templates/threat-detected.html.ftl")
  default_subject       = "Thread Detected"
  default_text_template = file("${path.module}/email_templates/threat-detected.txt.ftl")
  from_email            = "example@local.fusionauth.io"
}

resource "fusionauth_email" "two-factor-authentication" {
  name                  = "Two Factor Authentication"
  default_from_name     = "Two Factor Authentication"
  default_html_template = file("${path.module}/email_templates/two-factor-authentication.html.ftl")
  default_subject       = "Two Factor Authentication"
  default_text_template = file("${path.module}/email_templates/two-factor-authentication.txt.ftl")
  from_email            = "example@local.fusionauth.io"
}

resource "fusionauth_email" "two-factor-authentication-method-added" {
  name                  = "Two Factor Authentication Method Added"
  default_from_name     = "Two Factor Authentication Method Added"
  default_html_template = file("${path.module}/email_templates/two-factor-authentication-method-added.html.ftl")
  default_subject       = "Two Factor Authentication Method Added"
  default_text_template = file("${path.module}/email_templates/two-factor-authentication-method-added.txt.ftl")
  from_email            = "example@local.fusionauth.io"
}

resource "fusionauth_email" "two-factor-authentication-method-removed" {
  name                  = "Two Factor Authentication Method Removed"
  default_from_name     = "Two Factor Authentication Method Removed"
  default_html_template = file("${path.module}/email_templates/two-factor-authentication-method-removed.html.ftl")
  default_subject       = "Two Factor Authentication Method Removed"
  default_text_template = file("${path.module}/email_templates/two-factor-authentication-method-removed.txt.ftl")
  from_email            = "example@local.fusionauth.io"
}
