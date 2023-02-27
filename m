Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6FA6A4525
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Feb 2023 15:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjB0Oub (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Feb 2023 09:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjB0Oua (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Feb 2023 09:50:30 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7E721A3D
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Feb 2023 06:50:20 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id x14so11399474vso.9
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Feb 2023 06:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vn2L52JN+8NdQVfFdjYSoDCaZz/Sp3hs/UgPuWqQTLo=;
        b=inpdqNuwgYlEiEDCW3F6jblbyMpeGFCiZjCIh2dIeactZCnN1oTXWtiOlwEZVbeVIu
         LiQrS1ZU1sQJ8u2tIFvOPAHKTUFXAyx29KB9kAMUFv0HshXxkya2TVFRKjkxcMAy3pG1
         9YOP8VbgOdC2QiEd5Oz90cjYW2tmasIAPsZQnt9Lq+8ZFvjwfK2/IGv3+zJjrrClvREx
         XbFXl8rmsmHdYb7dtk3rvqnY9HvFBiAPlrh+ohS1dtUL75LNJB9O+LYpSzyWVImOUgbg
         nZNM4MiTWaj/Q3twcFoDS1ueGRUJ50nEMdDy0po/shEHrRHA5oUURFlua6qN+02bMaSS
         ZFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vn2L52JN+8NdQVfFdjYSoDCaZz/Sp3hs/UgPuWqQTLo=;
        b=HkgPmQj2UIjXrERUClBqiN1AORANKgP62atUAuqqRLpQ6QwPUif6gIRdM1FzpCE8BF
         McCr0IJGxV2EhYfJwaQaFbl5zS2OWqWzjlmXfApsgJ7ga8Q2j7J7sQVew1XIkd0HFjVL
         snYr8yFEhvHtR+ItCTRCVylxcsnHtbZZKCG+09yQSJaefzrl9N9nh/P/bhwKHS0XH8kZ
         GmWt3EVI+oEYdMSZkEWr3dw1s+uNmkGD4ZGq7YVsGI32PZioeoamJScinPg2Jr63FNuR
         0VA76kmVYIQIhRsuU8xI+qSZ0PsukY0UVUqDlgRYC6i5dJhX0iTw/qQ91qF69aiRi1cd
         vt6g==
X-Gm-Message-State: AO0yUKUCRsWEfN5y3ZSPvHyip+fHcjraTMrO1L/cFJVKoIzwY2HrWj4Z
        7olhIoIBmZHe2SNP6J1sKhDvooXg4mVxfY0eXToHnSAAttuBPJxVGk4=
X-Google-Smtp-Source: AK7set/s+/XuZAYWv2lO2YBoyv7EvnUTxZWG/lOUwK0HqcrWaw9LHOkQxVTj0ZpTNvIyKXObKMars6KdbgSjITFckkE=
X-Received: by 2002:a67:db0a:0:b0:414:2344:c353 with SMTP id
 z10-20020a67db0a000000b004142344c353mr7412338vsj.5.1677509419061; Mon, 27 Feb
 2023 06:50:19 -0800 (PST)
MIME-Version: 1.0
References: <108676ae57ac8cade69806ff92768866bf8dd200.1677496263.git.geert@linux-m68k.org>
In-Reply-To: <108676ae57ac8cade69806ff92768866bf8dd200.1677496263.git.geert@linux-m68k.org>
From:   David Gow <davidgow@google.com>
Date:   Mon, 27 Feb 2023 22:50:07 +0800
Message-ID: <CABVgOSmTTw8SLjXXzq4Y91Pi2udNi3MKfX6GkN4phqaMfcDDrA@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Add support for m68k under QEMU
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-m68k@lists.linux-m68k.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000000d4c9505f5af9948"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--0000000000000d4c9505f5af9948
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Feb 2023 at 19:12, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Add basic support to run m68k under QEMU via kunit_tool.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---

Thanks very much. This works fine here.

I'll look into failures for individual kunitconfigs and tests later,
but the actual kunit_tool/QEMU stuff seems good-to-go to me.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

> Does this need CONFIG_VIRTIO_CONSOLE=y? It seems to work fine without.

It's working fine here without, too, so _something_ must be sending
data to the console.

>
> drivers/clk/.kunitconfig:
>
>     Fails because m68k uses big-endian I/O ops
>
> drivers/gpu/drm/tests/.kunitconfig
>
>     kernel BUG at drivers/gpu/drm/drm_buddy.c:21!
>     (also on arm, ignored)
>
> drivers/gpu/drm/vc4/tests/.kunitconfig
>
>     Depends on arm, works on arm
>
> drivers/hid/.kunitconfig
>
>     Unable to handle kernel NULL pointer dereference at virtual address (ptrval)
>     Oops: 00000000
>     PC: [<001d7380>] uclogic_params_ugee_v2_has_battery+0x6/0x68
>     (also on arm, ignored)
>
> fs/ext4/.kunitconfig: OK
>
> fs/fat/.kunitconfig: OK
>
> kernel/kcsan/.kunitconfig
>
>     Needs HAVE_ARCH_KCSAN and SMP
>     (the former also on arm, ignored)
>
> lib/kunit/.kunitconfig: OK
>
> mm/kfence/.kunitconfig
>
>     Needs HAVE_ARCH_KFENCE
>     (fails on arm due to missing CONFIG_KFENCE_KUNIT_TEST=y, which
>     depends on TRACEPOINTS)
>
> net/sunrpc/.kunitconfig
>
>     After dropping CONFIG_STACKTRACE=y (why is this needed?) from
>     net/sunrpc/.kunitconfig:
>     Unable to handle kernel NULL pointer dereference at virtual address (ptrval)
>     (also on arm, ignored)
> ---

It  looks like there are some endianness issues with the apparmor
policy_unpack_test, too... Otherwise the default set of tests seems to
pass.

>  tools/testing/kunit/qemu_configs/m68k.py | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>  create mode 100644 tools/testing/kunit/qemu_configs/m68k.py
>
> diff --git a/tools/testing/kunit/qemu_configs/m68k.py b/tools/testing/kunit/qemu_configs/m68k.py
> new file mode 100644
> index 0000000000000000..287fc386f8a7ff16
> --- /dev/null
> +++ b/tools/testing/kunit/qemu_configs/m68k.py
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +from ..qemu_config import QemuArchParams
> +
> +QEMU_ARCH = QemuArchParams(linux_arch='m68k',
> +                          kconfig='''
> +CONFIG_VIRT=y''',
> +                          qemu_arch='m68k',
> +                          kernel_path='vmlinux',
> +                          kernel_command_line='console=hvc0',
> +                          extra_qemu_params=['-machine', 'virt'])
> --
> 2.34.1
>

--0000000000000d4c9505f5af9948
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
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBn
YvNwtGQ78LoeI021VjGpp5NdMqZPxl8T11D/wnITrjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAyMjcxNDUwMTlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAM6W9XmJQM+6wHmlDk52C
8ufek0XR4h5w93LH/bw+FNSJbm1ZcTet3H7YQwtEZ8YxmuDFMCseoDEXq24W3pFFbI6nPLUM1NR2
wZUjr5lTyciq1Mmup98Oel7JKKNOxMtU8CeMQXszwq5vzA7RwxvMZ5qzM9FkqLneuRBERDlMg10z
pWPHVYG089/ExYuXS2+y4QYh1ia+ESFM8HwJvMgZ2ESX0vKJGNFsEdHc6JhYDDNOOpfaA9qTsF4X
wknnq5OegR4dupk9b73If/X9CcPmyYbdd/9ngcmnwVZIGetTyY0zSGiMTX7lU5X5PvNgd5/jCqeL
rPw3pkZv28Dz+nhW+Q==
--0000000000000d4c9505f5af9948--
