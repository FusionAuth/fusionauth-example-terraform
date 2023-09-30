[#if registration.verified]
Pro tip, your registration has already been verified, but feel free to complete the verification process to verify your verification of your registration.
[/#if]

[#if verificationOneTimeCode??]
<p> To complete your registration verification, enter this code into the verification form. </p>
<p> ${verificationOneTimeCode} </p>
[#else]
To complete your registration verification click on the following link.
<p>
  <a href="https://local.fusionauth.io/registration/verify/${verificationId}?tenantId=${user.tenantId}">
    https://local.fusionauth.io/registration/verify/${verificationId}?tenantId=${user.tenantId}
  </a>
</p>
[/#if]

- FusionAuth Admin
