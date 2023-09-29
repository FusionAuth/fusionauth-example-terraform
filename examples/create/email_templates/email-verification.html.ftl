[#if user.verified]
Pro tip, your email has already been verified, but feel free to complete the verification process to verify your verification of your email address.
[/#if]

[#if verificationOneTimeCode??]
<p> Complete email verification by entering this code into the verification form. </p>
<p> ${verificationOneTimeCode} </p>
[#else]
To complete your email verification click on the following link.
<p>
  <a href="https://local.fusionauth.io/email/verify/${verificationId}?tenantId=${user.tenantId}">
    https://local.fusionauth.io/email/verify/${verificationId}?tenantId=${user.tenantId}
  </a>
</p>
[/#if]

- FusionAuth Admin
