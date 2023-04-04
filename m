Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBCA6D5716
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Apr 2023 05:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjDDDQB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Apr 2023 23:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjDDDQA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Apr 2023 23:16:00 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9221FD6
        for <linux-kselftest@vger.kernel.org>; Mon,  3 Apr 2023 20:15:59 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id l23so3538967uac.6
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Apr 2023 20:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680578158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FCtIVPMAWAoD8qdg5/pYJNltOkc0yl/6YWH/2l1KME4=;
        b=B9xyPbHeoRfKyhkLGYAJQEB3Oi3NZDzHkXDeKDU5NUwvnq947Sqj5E5S9g/uURF4Ji
         O2greI9YdvxCJ4vodC4a4GDDgoDrbfmxzYMIpu2k/WJiRpTJZ4LYwuEjWzkR9vasijC3
         6sKd9t1VrkPv+NTiPl4+smZNNIPAl7BGWO0I3+ue5GVBFELClc69bh1epwnbxmfP9mS6
         ZuFCgubKa5N5/FSU2hV/h7FBv6Q+xasLk4Balrmr7WVfrd//cMmLIPnHaFN5S4apJwpy
         1r54D90gyoTVmYnCjEj7kfQi2tbiZKVlAzkEqsmb5sEUpOeM/5d95HQ8CCMEgCPidQVv
         YFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680578158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FCtIVPMAWAoD8qdg5/pYJNltOkc0yl/6YWH/2l1KME4=;
        b=5ZkunZ963nXja5ns6uCZpIFJXcRfRr3yBFn0lJOY7ZrDbEHIddcCwoGlbnb4Vmly5I
         gPKzwpTxEcurUzehyvredtKY73UCbZjnIbodaI4gW6m3lB+5zzd4PT3l07OHuT88wDxX
         hQhZT52pcTunEOcK8y0BlEzkENE6P5OwOKaTaE/U+Dh04Jq6cGwtfhky7ufEgDGjmsI7
         d/4FQtR060nOIwM9UF1JkkArsDbzzeJb1Qld2o5obuMurE668INYeH9Kv/zPmf3vQSCG
         8gA/HY2Wbs6IKgbghyScp4Enbz9IaV0iLhpHZMlTGSBKAzffCCqL4dnqOQq6LbW6Q+cq
         ZEOQ==
X-Gm-Message-State: AAQBX9ckNHgTTh2foZ3QnvimgdDfG2we5v4SRQ5g505W+czESvEUu0L0
        +bhzT8Yw0eI4wkAc4mZsWtgki9pir7qqDPVcN/lCnNjfmkWdHZ9TWd0=
X-Google-Smtp-Source: AKy350a3/Rlm1WmMqLEJtH852amtNKjYdti/UH4UiDDjewfRI7TsAFjfDhP0pLeF3RT8PaMr1AEKZFWfeNGsX+YtwgM=
X-Received: by 2002:a1f:a7c4:0:b0:40e:fee9:667a with SMTP id
 q187-20020a1fa7c4000000b0040efee9667amr1147067vke.3.1680578158365; Mon, 03
 Apr 2023 20:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1677579750.git.geert+renesas@glider.be> <c72e5884711da51424ad2f9c7933bb294129aef3.1677579750.git.geert+renesas@glider.be>
In-Reply-To: <c72e5884711da51424ad2f9c7933bb294129aef3.1677579750.git.geert+renesas@glider.be>
From:   David Gow <davidgow@google.com>
Date:   Tue, 4 Apr 2023 11:15:47 +0800
Message-ID: <CABVgOSnh6643FAAx9qt+2V_DJUrsFEOxb=O10qqxiO8ED44YMA@mail.gmail.com>
Subject: Re: [PATCH 2/2] kunit: tool: Add support for SH under QEMU
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-sh@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000002aafdc05f87a1816"
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

--0000000000002aafdc05f87a1816
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Feb 2023 at 18:31, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Add basic support to run SH under QEMU via kunit_tool using the
> virtualized r2d platform.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

I finally managed to get this working: it's fine under openSUSE
tumbleweed (with the kernel.org toolchain), and in a debian stable
container, so I'll chalk the problems I was having up to my
Google-ified setup here.

Even if that turns out to be a more widespread issue, it'll be easier
to track down with these patches applied,

So,
Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David



> All tests succeed, except for the usual suspects.
> drivers/clk/.kunitconfig cannot be run as CONFIG_COMMON_CLK is not
> available.
> ---
>  tools/testing/kunit/qemu_configs/sh.py | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 tools/testing/kunit/qemu_configs/sh.py
>
> diff --git a/tools/testing/kunit/qemu_configs/sh.py b/tools/testing/kunit/qemu_configs/sh.py
> new file mode 100644
> index 0000000000000000..78a474a5b95f3a7d
> --- /dev/null
> +++ b/tools/testing/kunit/qemu_configs/sh.py
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +from ..qemu_config import QemuArchParams
> +
> +QEMU_ARCH = QemuArchParams(linux_arch='sh',
> +                          kconfig='''
> +CONFIG_CPU_SUBTYPE_SH7751R=y
> +CONFIG_MEMORY_START=0x0c000000
> +CONFIG_SH_RTS7751R2D=y
> +CONFIG_RTS7751R2D_PLUS=y
> +CONFIG_SERIAL_SH_SCI=y''',
> +                          qemu_arch='sh4',
> +                          kernel_path='arch/sh/boot/zImage',
> +                          kernel_command_line='console=ttySC1',
> +                          serial='null',
> +                          extra_qemu_params=[
> +                                           '-machine', 'r2d',
> +                                           '-serial', 'mon:stdio'])
> --
> 2.34.1
>

--0000000000002aafdc05f87a1816
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
LmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5n
bG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG9w0BAQsFAAOCAQEANyYcO+9JZYyqQt41
TMwvFWAw3vLoLOQIfIn48/yea/ekOcParTb0mbhsvVSZ6sGn+txYAZb33wIb1f4wK4xQ7+RUYBfI
TuTPL7olF9hDpojC2F6Eu8nuEf1XD9qNI8zFd4kfjg4rb+AME0L81WaCL/WhP2kDCnRU4jm6TryB
CHhZqtxkIvXGPGHjwJJazJBnX5NayIce4fGuUEJ7HkuCthVZ3Rws0UyHSAXesT/0tXATND4mNr1X
El6adiSQy619ybVERnRi5aDe1PTwE+qNiotEEaeujz1a/+yYaaTY+k+qJcVxi7tbyQ0hi0UB3myM
A/z2HmGEwO8hx7hDjKmKbDCCA18wggJHoAMCAQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUA
MEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWdu
MRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEg
MB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzAR
BgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4
Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0EXyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuu
l9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+JJ5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJ
pij2aTv2y8gokeWdimFXN6x0FNx04Druci8unPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh
6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTvriBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti
+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGjQjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8E
BTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5NUPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEA
S0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigHM8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9u
bG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmUY/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaM
ld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88
q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcya5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/f
hO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/XzCCBNgwggPAoAMCAQICEAHHLXCbS0CYcocWQtL1
FY8wDQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjMgU01JTUUgQ0EgMjAyMDAeFw0yMzAxMjkw
NjQ2MThaFw0yMzA3MjgwNjQ2MThaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5j
b20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC+31G8qfgjYj6KzASqulKfP5LGLw1o
hZ6j8Uv9o+fA+zL+2wOPYHLNIb6jyAS16+FwevgTr7d9QynTPBiCGE9Wb/i2ob9aBcupQVtBjlJZ
I6qUXdVBlo5zsORdNV7/XEqlpu+X5MK5gNHlWhe8gNpAhADSib2H4rjBvFF2yi9BHBAYZU95f0IN
cSS0WDNSSCktPaXtAGsI3tslroyjFYUluwGklmQms/tV8f/52zc7A5lzX+hxnnJdsRgirJRI9Sb6
Uypzk06KLxOO2Pg9SFn6MwbAO6LuInpokhxcULUz3g/CMQBmEMSEzPPnfDIAqwDI0Kqh0NAin+V4
fQxJfDCZAgMBAAGjggHUMIIB0DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1Ud
DwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFJyglaiY
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
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDB
cQcUWIJ4etMUztUqqwdAQW78DvmnNLgz/8LKI6YIZzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA0MDQwMzE1NThaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAHKCFgwvacIn6cBCAw+pN
ZVuPcnj5wXmuI9jqUO6lFxuT6IG4Qvq0z51Dk4VWeuPSOGhtaIvLdfh8aPklo4DYcLAB17HJskc5
dS0yvUcboZrdyObklvY5+WPLe8Mxh1HIvZ208dgv4Q8v3t0K9DteCpbKEdlV5NUzez+lu/OtHcMm
oDQEa9DugNq1rBVgCVxnqP37/ySWoFkqZLMYBfqkDVBKOfRby3P2ghyNXnZpgawgh+0kYkYM+QfK
eXhQN0TWXhg19qc3jpoSxdKMNVdoiJiF/CkgDa9S2bztoQ2zZmfKjdqJEjrYHqhEdKA78J0QFFSR
K8a+/k3DHun80+CNDg==
--0000000000002aafdc05f87a1816--
