Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8B13816BD
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 May 2021 10:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhEOICy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 May 2021 04:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhEOICt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 May 2021 04:02:49 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8DEC06174A
        for <linux-kselftest@vger.kernel.org>; Sat, 15 May 2021 01:01:32 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id u133so829131wmg.1
        for <linux-kselftest@vger.kernel.org>; Sat, 15 May 2021 01:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YsHzjbl11wdqnmtP/+wuDnR0X7GXH8qb0zA0sRD87UI=;
        b=SX9utocNmcw8l7FXFyURb9YZ4OEGodncggNMQqqiknN/CrKYphxI7DJFl7zvowOiNT
         Zz7JKVFdIill0KSWdncbus33SN94Fa8IkRqRqEZV2MRc18cLRwfQkqKmsUjSNjkcqHiu
         6Gn7HIpUf7cZ/FKqRryc9ubhInjWqUX0boRotGlJhp9oY2f0lcT0S4NpMY8oqs1GkRjD
         91JOqkZTbZPlzBDYPbTb/XeHhw7hzLklOLvqXyU928IIpwRo8DBaVEJOpQxE/E9wC5/n
         XNf+zKwEwXkNqyfzLMXsf3O4RysEWnDSx425OYttlfCTvox3vvi7KU7GYBsRMZfKGSCT
         8tNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YsHzjbl11wdqnmtP/+wuDnR0X7GXH8qb0zA0sRD87UI=;
        b=LlpE8Sy5swkvT4BS+1VAIZXmR76xwdA2WRqrKfwDZcscQEgbfGu63NBA6FeNqE8/f7
         oDzySPAC+avY9ZRKTxSHolcCWfyKXLoY+KGeidN7I1gZyOS2t2tdpRjsiMlqjjB1bQDm
         4gJeHnQ1ja4XYe1aLSxEbTWi02aru8cZBb15o5M+ToBNMrhAKx9GAMC1zj1H5EsmWth8
         pfUkakpMYYHnVc6rnesiGmu46QkpWjMN7U0qGT+Ht/teHbN/13Fv/QdJXuXvTKa+yWne
         x7A9JB7x6Bj3PI92qiBkskif5V5GV3dGj8E77OuUt72dtiuTZPDThKGzBm27YfofEtpd
         MLKQ==
X-Gm-Message-State: AOAM533/tGQWseNbdFioCvSgkuxT+Jl+sb4tWfGY8DWF2ztwHuS0vsJW
        x+NRGDmIqPvI/6un1PTgY5RnRjExCO89D6ULq3vqxQ==
X-Google-Smtp-Source: ABdhPJyKPIlIZ0bxkvUSqXLXQZ9YQLa9M+aKwQT7Edx2LUu1xpXuxf0xpJtdqHQnkEjzic0CariTe6Mxs8xDoVd/PoQ=
X-Received: by 2002:a05:600c:3205:: with SMTP id r5mr53380672wmp.78.1621065691477;
 Sat, 15 May 2021 01:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210507213110.155492-1-brendanhiggins@google.com> <20210507213110.155492-5-brendanhiggins@google.com>
In-Reply-To: <20210507213110.155492-5-brendanhiggins@google.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 15 May 2021 16:01:20 +0800
Message-ID: <CABVgOSnnb=LB2hQOVqarDd3Tv17f7JHHomvSfWeQaFSsH1PD2g@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] Documentation: kunit: document support for QEMU in kunit_tool
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Daniel Latypov <dlatypov@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000b8121805c259c4a8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--000000000000b8121805c259c4a8
Content-Type: text/plain; charset="UTF-8"

On Sat, May 8, 2021 at 5:31 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> Document QEMU support, what it does, and how to use it in kunit_tool.
>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---

This is a good start, and probably meets the minimum requirements, but
I do have a number of comments and suggestions below.

Cheers,
-- David

>  Documentation/dev-tools/kunit/usage.rst | 37 +++++++++++++++++++++----
>  1 file changed, 31 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> index 650f99590df57..b74bd7c87cc20 100644
> --- a/Documentation/dev-tools/kunit/usage.rst
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -612,14 +612,39 @@ only things to be aware of when doing so.
>  The biggest impediment will likely be that certain KUnit features and
>  infrastructure may not support your target environment. For example, at this
>  time the KUnit Wrapper (``tools/testing/kunit/kunit.py``) does not work outside
> -of UML. Unfortunately, there is no way around this. Using UML (or even just a
> -particular architecture) allows us to make a lot of assumptions that make it
> -possible to do things which might otherwise be impossible.
> +of UML and QEMU. Unfortunately, there is no way around this. Using UML and QEMU
> +(or even just a particular architecture) allows us to make a lot of assumptions
> +that make it possible to do things which might otherwise be impossible.

This is a bit more awkward now, and I don't think gives quite the
right impression. Particularly the "Unfortunately, there is no way
around this." bit: there's no fundamental reason that someone couldn't
implement support for some other emulator (or even a setup which
pushed to real hardware and read results over serial), it'd just take
a bit of work to implement (like this patch series has done for qemu).

Personally, I think it'd be easiest to simplify this section and say
that kunit_tool currently only fully supports some architectures, via
UML and QEMU.

>
>  Nevertheless, all core KUnit framework features are fully supported on all
> -architectures, and using them is straightforward: all you need to do is to take
> -your kunitconfig, your Kconfig options for the tests you would like to run, and
> -merge them into whatever config your are using for your platform. That's it!
> +architectures, and using them is straightforward: Most popular architectures
> +are supported directly in the KUnit Wrapper via QEMU.  Currently, supported
> +architectures on QEMU include:
> +
> +*   i386
> +*   x86_64
> +*   arm
> +*   arm64
> +*   alpha
> +*   powerpc
> +*   riscv
> +*   s390
> +*   sparc
> +
> +In order to run KUnit tests on one of these architectures via QEMU with the
> +KUnit wrapper, all you need to do is specify the flags ``--arch`` and
> +``--cross_compile`` when invoking the KUnit Wrapper. For example, we could run
> +the default KUnit tests on ARM in the following manner (assuming we have an ARM
> +toolchain installed):
> +
> +.. code-block:: bash
> +
> +       tools/testing/kunit/kunit.py run --timeout=60 --jobs=12 --arch=arm --cross_compile=arm-linux-gnueabihf-
> +

Is it worth also documenting the --qemu_config option here?
(Particularly given the restriction on its path?) Or is that something
best added to the kunit_tool page?

That being said, changes to the kunit_tool page are probably worth
adding as a section in the updated page:
https://patchwork.kernel.org/project/linux-kselftest/patch/20210417034553.1048895-1-davidgow@google.com/

At the very least, it'd be nice to have the new QEMU-related options
documented there.


> +Alternatively, if you want to run your tests on real hardware or in some other
> +emulation environment, all you need to do is to take your kunitconfig, your
> +Kconfig options for the tests you would like to run, and merge them into
> +whatever config your are using for your platform. That's it!
>
>  For example, let's say you have the following kunitconfig:
>
> --
> 2.31.1.607.g51e8a6a459-goog
>

--000000000000b8121805c259c4a8
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnAYJKoZIhvcNAQcCoIIPjTCCD4kCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz2MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
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
hO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/XzCCBNUwggO9oAMCAQICEAGb+Q77il3T2Ss3sWOT
zKkwDQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjMgU01JTUUgQ0EgMjAyMDAeFw0yMTAyMDUy
MzQwMjdaFw0yMTA4MDQyMzQwMjdaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5j
b20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCp88g1fYbjEPVlaL9sUToZwjKCeCIS
JqYR/IR1FgbA8vq7+rNlr9/1AFLZe4/qh3CwWzh42UIERZpqut/ict9jfisWWKnXPaEQkibkZ+NL
OPIT51cC0QX5nv7zFf28tPZ6V4KewX3UtB/8JDcybfVeQlZ0S1UMVfg93wMXe59FKN/QYbLDzQSg
Yc/5ExUVV6UgoEXVbxTuJv45hvdihw6Eme65MfC0CUPeiZ1sfQjfSYi7CY517JOATvD84ZPX0GQV
cRb6N52CERoIy/7ni857uvf5fAmGdzR6VZgtGL5/nO1Jb/KmNMsat7pnRbgHx5qYLLN2+oCS8Jp7
0VoZRTiBAgMBAAGjggHRMIIBzTAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1Ud
DwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFG2lY2ZX
ILbFHw0h01NI0v+AeczGMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwgZoGCCsGAQUF
BwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9nc2F0
bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNv
bS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouseLHIb
0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vY2Ev
Z3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQCNr3LBERPjVctGdVEb
/hN6/N6F2eUWxZLSUbuV7fOle0OvI8xz2AUBrOYQLp94ox9LqmsATKPsBl2uiktsvfs/AXNMcmOz
qsWHzfqp4XlvNgQsC/UyUMWxZoEyTDfTSat09yQjkFJ7viwzrqqscmTx5oTZz8TPRt0mbxwx3qry
wDzYxadSUQXNpNnfi0FBDYUUfuCLFWPsPsAXmgh483u0RbNik9OY/ozNq1Gvg/U0jQOlJf2IiKbE
kUL5Vq8gDDu6bETx5bHmRmSjHhwo7eVbxywczpzdFsU3dauZ3BzqhLy2pRGGzZybSH/3mf7o9y15
gmRHE7WzPLrsULHG/TM8MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xv
YmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAyMDIw
AhABm/kO+4pd09krN7Fjk8ypMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCqE3J4
R8hdya2vZJzwNsq5lX45jIvSqV4aLximl+BRCzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yMTA1MTUwODAxMzFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqG
SIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEANLOdBegAVhX5dZi9kQkCgBkI
LYHabOC661IUPKvd51qwregM2+OThiZ0HyfdM5PUjLAu/U+EIvc+GymF44N5l8tCFlQGt0ysqRWj
vAh7KX24h1v9oJiUx3obCTWsi6SbOp95JzEAyA70sAm/BrIMkTgmLPtMzEFwyF5t5/Wnz1l5S7En
5U2Nttv4+SgFb0h/igeUhyWOfnBeMvmz6kpK9+y5OaJHuiPhS5cQz4n1rgFltdf9X/bZU3grzkGL
EjX4T17L3Al3JLBQCLQR4F/etdbFHAWv96jcdtpbAdIQKvYw1wE0ilbZfP/HdddHfbwLzQXCwpj4
6UobTD6PO2I22w==
--000000000000b8121805c259c4a8--
