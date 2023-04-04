Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA6C6D5713
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Apr 2023 05:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbjDDDPy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Apr 2023 23:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjDDDPx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Apr 2023 23:15:53 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1124F1718
        for <linux-kselftest@vger.kernel.org>; Mon,  3 Apr 2023 20:15:52 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id c1so27240746vsk.2
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Apr 2023 20:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680578151;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RnTWn/Fgt7n20TZ6OfFbn9lzdD/k0zoT8IvlJ3VA/kA=;
        b=s6punurGehHUlvBEY3c+NYjesoZKBBDNevR6djEF/XMAZjvd63mDscDEXLH3l6obCH
         g3efjJM8swZ15v+83FCIMblOm7IUY0/+p2GFHsc5ubepmSs2I1sRIMW7gTNfqZ5tljrQ
         3981x3Gbr/tAAD+N9jVSV4rQQOAjYddMtse81IgFAPnJzZX5YE1lFIllhusJBNIGoGfY
         i6fGYxv0K2GzICTjKN+L2OVWEfSeLw1dknnwbk5roEjas0MRNgRcPAyJC5/KzxuvrIK0
         QfIdU2wy6lp5OsPZE6wKJHDRMkS8R07kx/RCEOKDmtgFjnfYw9TRm1RZ53wPoD9Rfudf
         eL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680578151;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RnTWn/Fgt7n20TZ6OfFbn9lzdD/k0zoT8IvlJ3VA/kA=;
        b=Ot2v5o49hFTDiCd9Ky+OAAgdgUgGrr6tMLs2kKQ9Ab76SwecV/1mx4Qg4KZenkCTmF
         9NiHubaeSIN15z+SJNcBPUlzky3nq+U5nrvGOaNBW0u3RtWSa+Uw8aaNr2Bhf6lMk3bL
         sKlKSYCc7PTNz32O4Qi73j2GcQ3UqcQagIR2XuSvRWecPYA5n9a2okc68xXMDngtQQ12
         QrxHRmrebOANXYFZHe8Bgekb9A4Bh1Y0ktqlChOdA38fethhg5tpmBMwGcYT9NajXb5i
         hSb/n4gC7e5QPsXT7kTNNJy1EVAww3vIoyPXptmjrrjue9qkDPLpFJ2sRBCb855yP3Hb
         yIbg==
X-Gm-Message-State: AAQBX9fRyNW0VCXVleNhTokma3FZlrAxDIVCRiOuw0RXQH0cWwMftBLw
        GpNyn0H56mki/6GahX85ji/H1Aoel7kFlPoWY3vl4ixWDQTBUnw2w9o=
X-Google-Smtp-Source: AKy350Yn4XLtgHOpdGPB+6WOQHaRrEJ61wo/FNTjORSDCPl9iJ72D68+D5KRbuqPUfi4+dmDCN8v8dRiJ7KfOk1ieBo=
X-Received: by 2002:a67:d286:0:b0:426:da10:2408 with SMTP id
 z6-20020a67d286000000b00426da102408mr1251985vsi.5.1680578151024; Mon, 03 Apr
 2023 20:15:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1677579750.git.geert+renesas@glider.be> <f12e6f606a2612fab4d1038d088959710a423a9f.1677579750.git.geert+renesas@glider.be>
In-Reply-To: <f12e6f606a2612fab4d1038d088959710a423a9f.1677579750.git.geert+renesas@glider.be>
From:   David Gow <davidgow@google.com>
Date:   Tue, 4 Apr 2023 11:15:39 +0800
Message-ID: <CABVgOS=nE44djUDmh6QENXqZxf9mvrL_guz-N1U1nDhLez8jjg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: tool: Add support for overriding the QEMU
 serial port
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-sh@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000bb36bc05f87a1784"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--000000000000bb36bc05f87a1784
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Feb 2023 at 18:31, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> On some platforms, the console is not the first serial port.  To make
> this work, the first serial port in QEMU must be set to "null".
>
> Add support for this by adding an optional "serial" parameter, which
> defaults to "stdio", and can be overridden by platform-specific
> configuration.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Seems good to me, cheers!

Reviewed-by: David Gow <davidgow@google.com>

Thanks,
-- David

>  tools/testing/kunit/kunit_kernel.py | 3 ++-
>  tools/testing/kunit/qemu_config.py  | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index 53e90c3358348dbe..64262875993ff070 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -106,6 +106,7 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
>                 self._kernel_path = qemu_arch_params.kernel_path
>                 self._kernel_command_line = qemu_arch_params.kernel_command_line + ' kunit_shutdown=reboot'
>                 self._extra_qemu_params = qemu_arch_params.extra_qemu_params
> +               self._serial = qemu_arch_params.serial
>
>         def make_arch_config(self, base_kunitconfig: kunit_config.Kconfig) -> kunit_config.Kconfig:
>                 kconfig = kunit_config.parse_from_string(self._kconfig)
> @@ -121,7 +122,7 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
>                                 '-append', ' '.join(params + [self._kernel_command_line]),
>                                 '-no-reboot',
>                                 '-nographic',
> -                               '-serial', 'stdio'] + self._extra_qemu_params
> +                               '-serial', self._serial] + self._extra_qemu_params
>                 # Note: shlex.join() does what we want, but requires python 3.8+.
>                 print('Running tests with:\n$', ' '.join(shlex.quote(arg) for arg in qemu_command))
>                 return subprocess.Popen(qemu_command,
> diff --git a/tools/testing/kunit/qemu_config.py b/tools/testing/kunit/qemu_config.py
> index 0b6a80398cccb50f..b1fba9016eed00d0 100644
> --- a/tools/testing/kunit/qemu_config.py
> +++ b/tools/testing/kunit/qemu_config.py
> @@ -17,3 +17,4 @@ class QemuArchParams:
>    kernel_path: str
>    kernel_command_line: str
>    extra_qemu_params: List[str]
> +  serial: str = 'stdio'
> --
> 2.34.1
>

--000000000000bb36bc05f87a1784
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
64VRg2IjDI2fJVE9RD6aMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQA2lZLYRLu7foeR
cHo1VeNA974FZBiCm08Kd44/aCMEzdTJvxAE9xbUJf7hS1i6eW49qxuSp3/YLn6U7uatwAcmZcwp
Zma19ftf3LH+9Hvffk+X8fbPKe6uHkJhR2LktrhRzF159jj67NvXyGQv8J4n7UNeEVP0d5ByvRwv
tF2bJwlOwRGLoxasKSyDHIyUpwTfWYPq7XvjoGqQ/tDS7Khcc5WncJl0/ZEj7EKjtoGbsDbLdXEF
m/6vdcYKJzF9ghHewtV3YIU4RE3pEM4aCWWRtJwbExzeue6fI7RqURbNCAyQuSpWv0YQvzsX3ZX3
c1otrs50n1N0Sf8/rfJxq7sWMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDF
f8mBewhIzJpKYyREImvUxBJt07z9zHqxaEg1diSMQTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA0MDQwMzE1NTFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAcVyF4wpRLRRaPOTZbVnu
/mBeAcPx/iMn7A5ucgJM0FusGKI9WNjjEdjVxcaAdfn7rQSpgx6azt+E2C1OrtV9WIOR0gze2zSN
V/uVwgiBn8u6nL11EwdEe0K6Kyx8C5t6v2qGjFhllSHMhe9dSopT9FbT05e71cRrTtysAdsaM1AW
2jXS1ntgA09dVa7bQW4HL1qZGu8O8qgpw1mmSa3T+cxsqSwKGL3d+P4QbHjV2xsIi50Z3YizSTeW
HanmfZqDCdv9JDWtj0Z7h1wfbabTIosJfjdLJhJvVWles0pFLvU62sX+NpebONbs8AwQS4csL5ud
lmz92J3SbkLbjTVM7A==
--000000000000bb36bc05f87a1784--
