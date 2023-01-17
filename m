Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E35B66D9BC
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jan 2023 10:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbjAQJYJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Jan 2023 04:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236574AbjAQJXe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Jan 2023 04:23:34 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591563346B
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jan 2023 01:19:22 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id i188so31534532vsi.8
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jan 2023 01:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QFgIqLImYZjdtQ+pMpdeII6BUK6lj9DKCYX0MYl+lGY=;
        b=VibXummNzZ2vQv4ove0ynqxrUwA7z7/UprV7zm7b9zW5QUTWAHCuhMLtT+teJXBXLA
         FHA7wYODz2ghqNI34NRrU87P8pY3yS1a7+JcAckd4NeIGZCR6FkboIvAzToGjeXzTSXm
         WFlNUYMfhHtp7UUxXCYxt936LcgXysDz5wCf26v2GSvG/yp4Obc6WzNHJGKSGthyDaOZ
         f/38eCFmdiGFrAWGjAbkifLxHz732BQg48DeE5LIj3IOcQiSmuBa7cC+DxWQygTe3xqN
         Rrz/XPFMkjiDoRtYmyqwcEuBjj2kRe7zDQdC+MBPKgAVLEBZY34Ez2j/du7gfGlZ7E3d
         PR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QFgIqLImYZjdtQ+pMpdeII6BUK6lj9DKCYX0MYl+lGY=;
        b=VG0nqzKIfVVieu8hcTvJDk4UMSBHx7m4m96B4Up+X336V2v4dqEmNiwPTN8cG1sQa7
         BJFfjYNm8DzYVzwAL8FstzfHXfPSrRY5vAYa6fKIM8pX1JZEHpnb1PC7InmbQTidhkyl
         MKcvp+bvewemtnuqrXt631yWQUhfggdnOFbYljnBIALOrBy/bMbrSd3eegV+1QnFAWeh
         vmc/Wu+ltDO4Oev4QHpPldDKYcMtVpTa8VlmLnli1kJZUuigcWsgQwSQY+SdkA4Q7626
         XBMTHHu6WOb20Fj4ElQsm/6Cd9PtUKnxciawb1G5tYgNOPzF6bj9f3PNrr1ATCWSD/Jh
         CanQ==
X-Gm-Message-State: AFqh2krdlxEqLlUCZNjCIvVsdyBryLraaLFnVy5rrX+n1IXGN4jGekmc
        cZbSwVtjkqNRNZ1p03FcmlIuvrp/aahUTwWZQoXQxNpZoMSsCw==
X-Google-Smtp-Source: AMrXdXvejjPPvE/eqidQ6SOf7P/i1Am1jVa3gYdJlaSjX8KG9lIcssr0Fp+43T62S6+nPeeQUGTOY0ywdjhB9cb3EP0=
X-Received: by 2002:a05:6102:358b:b0:3b5:1de3:19fa with SMTP id
 h11-20020a056102358b00b003b51de319famr241511vsu.35.1673947161081; Tue, 17 Jan
 2023 01:19:21 -0800 (PST)
MIME-Version: 1.0
References: <20230115210535.4085-1-apantykhin@gmail.com>
In-Reply-To: <20230115210535.4085-1-apantykhin@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 17 Jan 2023 17:19:09 +0800
Message-ID: <CABVgOSkXpbfLy5-40oqhmdLP9c84S=1FN=f_+Fw768QVUBBQPg@mail.gmail.com>
Subject: Re: [PATCH] tools/testing/kunit/kunit.py: remove redundant double check
To:     Alexander Pantyukhin <apantykhin@gmail.com>
Cc:     brendan.higgins@linux.dev, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000eef3f705f2723149"
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

--000000000000eef3f705f2723149
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Jan 2023 at 05:05, Alexander Pantyukhin <apantykhin@gmail.com> wrote:
>
> The build_tests function contained the doulbe checking for not success
Nit: "double" -> "double"

> result. It is fixed in the current patch. Additional small
> simplifications of code like useing ternary if were applied (avoid use
Nit: "useing" -> "using"
> the same operation by calculation times differ in two places).
>
> Signed-off-by: Alexander Pantyukhin <apantykhin@gmail.com>
> ---
Thanks for catching these!
This looks good to me, save for a few typos (which you should fix if
there's a v2, but it isn't important enough to do another version...)

Unless someone with more Python knowledge than me jumps in and
complains, this is:

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  tools/testing/kunit/kunit.py | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index 43fbe96318fe..481c213818bd 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -77,10 +77,8 @@ def config_tests(linux: kunit_kernel.LinuxSourceTree,
>         config_start = time.time()
>         success = linux.build_reconfig(request.build_dir, request.make_options)
>         config_end = time.time()
> -       if not success:
> -               return KunitResult(KunitStatus.CONFIG_FAILURE,
> -                                  config_end - config_start)
> -       return KunitResult(KunitStatus.SUCCESS,
> +       status = KunitStatus.SUCCESS if success else KunitStatus.CONFIG_FAILURE
> +       return KunitResult(status,
>                            config_end - config_start)
>
>  def build_tests(linux: kunit_kernel.LinuxSourceTree,
> @@ -92,13 +90,8 @@ def build_tests(linux: kunit_kernel.LinuxSourceTree,
>                                      request.build_dir,
>                                      request.make_options)
>         build_end = time.time()
> -       if not success:
> -               return KunitResult(KunitStatus.BUILD_FAILURE,
> -                                  build_end - build_start)
> -       if not success:
> -               return KunitResult(KunitStatus.BUILD_FAILURE,
> -                                  build_end - build_start)
> -       return KunitResult(KunitStatus.SUCCESS,
> +       status = KunitStatus.SUCCESS if success else KunitStatus.BUILD_FAILURE
> +       return KunitResult(status,
>                            build_end - build_start)
>
>  def config_and_build_tests(linux: kunit_kernel.LinuxSourceTree,
> @@ -145,7 +138,7 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -
>                 tests = _list_tests(linux, request)
>                 if request.run_isolated == 'test':
>                         filter_globs = tests
> -               if request.run_isolated == 'suite':
> +               elif request.run_isolated == 'suite':
>                         filter_globs = _suites_from_test_list(tests)
>                         # Apply the test-part of the user's glob, if present.
>                         if '.' in request.filter_glob:
> --
> 2.25.1
>

--000000000000eef3f705f2723149
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
hO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/XzCCBNgwggPAoAMCAQICEAGPil6q1qRMI4xctnaY
SpEwDQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjMgU01JTUUgQ0EgMjAyMDAeFw0yMjEwMjMw
ODQ3MTFaFw0yMzA0MjEwODQ3MTFaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5j
b20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDOy5O2GPVtBg1bBqW4oCdA74F9u0dQ
yp4AdicypXD/HnquyuG5F25nYDqJtIueywO1V0kAbUCUNJS002MWjXx329Y1bv0p5GeXQ1isO49U
E86YZb+H0Gjz/kU2EUNllD7499UnJUx/36cMNRZ1BytreL0lLR0XNMJnPNzB6nCnWUf2X3sEZKOD
w+7PhYB7CjsyK8n3MrKkMG3uVxoatKMvdsX3DbllFE/ixNbGLfWTTCaPZYOblLYq7hNuvbb3yGSx
UWkinNXOLCsVGVLeGsQyMCfs8m4u3MBGfRHWc2svYunGHGheG8ErIVL2jl2Ly1nIJpPzZPui17Kd
4TY9v0THAgMBAAGjggHUMIIB0DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1Ud
DwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFCNkhjo/
N0A3bgltvER3q1cGraQJMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAxS21FdvRtCQVc
jgEj+xxSnUr0N9reJlI5J9zRiBCWGxm5yhz965IDka3XVFEbj+beJj/gyHoxbaTGf2AjOufpcMqy
p4mtqc2l4Csudl8QeiBaOUDx4VKADbgxqpjvwD5zRpSKVj4S9y3BJi9xrRdPOm1Z2ZZYxRUxUz7d
2MXoxQsFucGJO5a4CwDBaGgJAqvwCXU5Q64rKVIUBk6mtcd3cDwX+PXqx4QrhHFGq6b6oi37YQ8B
+bhlXqlkLrbPlPFk+4Rh4EaW92iD5g8kvtXCOwvIIvs+15Io0dbpIe2W5UKo2OcyDDFvrOACmUOE
/GuEkhENcyDVyEs/4/N2u9WYMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABj4peqtakTCOMXLZ2mEqRMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDy
ZcMEl8yMYO6YIzy3RpQs553jqNRFg5YBfpubmCDlMTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAxMTcwOTE5MjFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAlmFDQehg+SJBKlYQev3z
YAeIz92FTanLz3eEaWF486PZGQbINnuMkJUVGZIAQmTlpApCW++BQmDAeysoFYuMbo4CkA4BWbMv
9Z3dIBbcMm2Fb/2N8iUZXk66Om33e9v25DTqqbq5a7M7uoCwkehRY3K6Hj+XYqupntXAw/F6niAh
q0ZVNzxObSvsabLCgopN6kIFNA4WU4RSEI0DdsGePei+CwthWLIMuGvzvS87Wod2bikqfF9oaX/Z
wDLS8RK4xmZ6ZrmlyAoAhKIMcno5xndINlhuW5hM+RvdCATVar6voYSmQSDEj+L0Qmm5S6rZpjwA
yasG8IyXkhkGpfr+ZA==
--000000000000eef3f705f2723149--
