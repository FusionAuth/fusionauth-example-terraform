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
  host = "https://auth.example.com"
}

import {
  to = fusionauth_tenant.Default
  id = var.fusionauth_default_tenant_id
}

resource "fusionauth_tenant" "Default" {
  name = "Default"
  issuer = "acme.com"
  theme_id = "00000000-0000-0000-0000-000000000000"
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
    email_verification_id_time_to_live_in_seconds      = 86400
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
    setup_password_id_time_to_live_in_seconds   = 86400
    two_factor_id_time_to_live_in_seconds       = 300
    two_factor_one_time_code_id_generator {
      length = 6
      type   = "randomDigits"
    }
    two_factor_trust_id_time_to_live_in_seconds = 2592000
  }
  jwt_configuration {
    refresh_token_time_to_live_in_minutes              = 43200
    time_to_live_in_seconds                            = 3600
    refresh_token_revocation_policy_on_login_prevented = true
    refresh_token_revocation_policy_on_password_change = true
    access_token_key_id                                = "00000000-0000-0000-0000-000000000000"
    id_token_key_id                                    = "00000000-0000-0000-0000-000000000000"
  }
  login_configuration {
    require_authentication = true
  }
  email_configuration {
    default_from_email                  = "change-me@example.com"
    default_from_name                   = "FusionAuth"
    host                                = "localhost"
    implicit_email_verification_allowed = true
    port                                = 25
    security                            = "NONE"
    verification_strategy               = "ClickableLink"
    verify_email                        = false
    verify_email_when_changed           = false
    forgot_password_email_template_id   = "00000000-0000-0000-0000-000000000000"
    passwordless_email_template_id      = "00000000-0000-0000-0000-000000000000"
    set_password_email_template_id      = "00000000-0000-0000-0000-000000000000"
  }
}

import {
  to = fusionauth_application.FusionAuth
  id = var.fusionauth_default_application_id
}

resource "fusionauth_application" "FusionAuth" {
  tenant_id = fusionauth_tenant.Default.id
  name = "FusionAuth"
}

