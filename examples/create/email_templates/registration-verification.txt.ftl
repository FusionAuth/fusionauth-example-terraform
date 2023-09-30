[#if registration.verified]
Pro tip, your registration has already been verified, but feel free to complete the verification process to verify your verification of your registration.
[/#if]

[#if verificationOneTimeCode??]
To complete your registration verification, the this code into the registration verification form.

${verificationOneTimeCode}
[#else]
To complete your registration verification click on the following link.

https://local.fusionauth.io/registration/verify/${verificationId}?tenantId=${user.tenantId}
[/#if]

- FusionAuth Admin
