Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9684B58F4B2
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Aug 2022 01:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbiHJXMN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Aug 2022 19:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbiHJXMM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Aug 2022 19:12:12 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BCA76450
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Aug 2022 16:12:11 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id q14so8167717vke.9
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Aug 2022 16:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=OPWk4Q6YaXXrachOYsQuYg1hcvF1/Hr+7UXwEdaIokU=;
        b=LoV8suOCJBqoQ99ubg38FC2C7XUaFGt+I+7+qqtZO8aZ0KrD7GHTBECRgp5lLBmWg4
         IbxYtzt3wSy6hu6r/cMiw/1s5M2DU/tWr6O9yI3C3uqdikzPGMEHxWCwtaM6tGcqGxo9
         DD15Bbuj6Dywsf3I5xe4xR/AuEv8tLz05cA4m179GlHatRoKjtCqP8o7zkhphTNhjvmn
         V2Q1ZLo3gWkM7ziSRp6XyidVAe28p9G+2XOi+gcH7oYnZrp5iOExSvI9GjGS+XRhtXrj
         J6wQKBSnpmbLFI5BqYVrni4cZ9Nk7QiTqoQqfYc01mogdGfaRXr86yPz3tYWOtTuUTwv
         74LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=OPWk4Q6YaXXrachOYsQuYg1hcvF1/Hr+7UXwEdaIokU=;
        b=a3qN/BPm02ZsyPRzqYdUP2dw2tGkwAMxtioW/ZV+irpzzvaLsoonrcDbgpcwq3o9BA
         BrRa09pb2QpT0SojJ1DBpbUWd7l0zzeieN/7F7tLAS/Z3MrPLQi71XRsbHfeoT+U7xsd
         UVyk7GB/dxLTLpq3StHKF2GsZHhKJHCXArTeBi8CWDpNHgnqQj+icteu2wi/4FDa39bF
         Nc/EjdWzeywCfO0quJyBb6NsQvDUZGDTN1perS5j5ZmydoIxtlICMD978+Wehjunqsr4
         13PvIS6DBzWzZeAUwK72Pho7lnOLqzgecf85ulXbac2yZn8DJq4MduQYaxhjuDttGVNq
         EV0g==
X-Gm-Message-State: ACgBeo0nM5l/NEAOqtLgNNfEUDiwJxWyGKC1m+NLrC9dOt6v/NfcxKxQ
        P9WEhEHCFGOrQwmJCXeW+RUBjq6x6mld7+EDISYekA==
X-Google-Smtp-Source: AA6agR4DTtzB5ayQvqadMij11me4vX4uhDSzg/+g7Y2E7kSuV062OKwheOuZ1bWr1mq6kXf7BVqKD8CQnZVC1/6krag=
X-Received: by 2002:a05:6122:817:b0:377:59fa:3193 with SMTP id
 23-20020a056122081700b0037759fa3193mr13061804vkj.4.1660173130049; Wed, 10 Aug
 2022 16:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220810230258.3933707-1-dlatypov@google.com>
In-Reply-To: <20220810230258.3933707-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 11 Aug 2022 07:11:59 +0800
Message-ID: <CABVgOSke6aOsWuDu3LN3+gNbtPBHgb69u_2kZU3+oiFjniK0fQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: make --raw_output=kunit (aka --raw_output)
 preserve leading spaces
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000b3567e05e5eb2d15"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--000000000000b3567e05e5eb2d15
Content-Type: text/plain; charset="UTF-8"

On Thu, Aug 11, 2022 at 7:03 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> With
> $ kunit.py run --raw_output=all ...
> you get the raw output from the kernel, e.g. something like
> > TAP version 14
> > 1..26
> >     # Subtest: time_test_cases
> >     1..1
> >     ok 1 - time64_to_tm_test_date_range
> > ok 1 - time_test_cases
>
> But --raw_output=kunit or equivalently --raw_output, you get
> > TAP version 14
> > 1..26
> > # Subtest: time_test_cases
> > 1..1
> > ok 1 - time64_to_tm_test_date_range
> > ok 1 - time_test_cases
>
> It looks less readable in my opinion, and it also isn't "raw output."
>
> This is due to sharing code with kunit_parser.py, which wants to strip
> leading whitespace since it uses anchored regexes.
> We could update the kunit_parser.py code to tolerate leaading spaces,
> but this patch takes the easier way out and adds a bool flag.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Looks good to me. I think we'll probably want to update the parser
code to actually keep track of indentation at some point, as it could
help with some ambiguity which otherwise would exist when there are
nested tests without test plan lines.

For the moment, though, this is definitely an improvement.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  tools/testing/kunit/kunit.py        |  2 +-
>  tools/testing/kunit/kunit_parser.py | 10 ++++++----
>  2 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index e132b0654029..161a3b1b0217 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -206,7 +206,7 @@ def parse_tests(request: KunitParseRequest, metadata: kunit_json.Metadata, input
>                 if request.raw_output == 'all':
>                         pass
>                 elif request.raw_output == 'kunit':
> -                       output = kunit_parser.extract_tap_lines(output)
> +                       output = kunit_parser.extract_tap_lines(output, lstrip=False)
>                 for line in output:
>                         print(line.rstrip())
>
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> index 12d3ec77f427..1ae873e3e341 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -218,7 +218,7 @@ TAP_START = re.compile(r'TAP version ([0-9]+)$')
>  KTAP_END = re.compile('(List of all partitions:|'
>         'Kernel panic - not syncing: VFS:|reboot: System halted)')
>
> -def extract_tap_lines(kernel_output: Iterable[str]) -> LineStream:
> +def extract_tap_lines(kernel_output: Iterable[str], lstrip=True) -> LineStream:
>         """Extracts KTAP lines from the kernel output."""
>         def isolate_ktap_output(kernel_output: Iterable[str]) \
>                         -> Iterator[Tuple[int, str]]:
> @@ -244,9 +244,11 @@ def extract_tap_lines(kernel_output: Iterable[str]) -> LineStream:
>                                 # stop extracting KTAP lines
>                                 break
>                         elif started:
> -                               # remove prefix and any indention and yield
> -                               # line with line number
> -                               line = line[prefix_len:].lstrip()
> +                               # remove the prefix and optionally any leading
> +                               # whitespace. Our parsing logic relies on this.
> +                               line = line[prefix_len:]
> +                               if lstrip:
> +                                       line = line.lstrip()
>                                 yield line_num, line
>         return LineStream(lines=isolate_ktap_output(kernel_output))
>
>
> base-commit: aeb6e6ac18c73ec287b3b1e2c913520699358c13
> --
> 2.37.1.559.g78731f0fdb-goog
>

--000000000000b3567e05e5eb2d15
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
hO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/XzCCBNgwggPAoAMCAQICEAGH0uAg+eV8wUdHQOJ7
yfswDQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjMgU01JTUUgQ0EgMjAyMDAeFw0yMjA2MjAw
MjAzNTNaFw0yMjEyMTcwMjAzNTNaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5j
b20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCv9aO5pJtu5ZPHSb99iASzp2mcnJtk
JIh8xsJ+fNj9OOm0B7Rbg2l0+F4c19b1DyIzz/DHXIX9Gc55kfd4TBzhITOJmB+WdbaWS8Lnr9gu
SVO8OISymO6uVA0Lmkfne3zV0TwRtFkEeff0+P+MqdaLutOmOcLQRp8eAzb/TNKToSROBYmBRcuA
hDOMCVZZozIJ7T4nHBjfOrR+nJ4mjBIDRnDucs4dazypyiYiHYLfedCxp8vldywHMsTxl59Ue9Yk
RVewDw3HWvWUIMbc+Y636UXdUn4axP1TXN0khUpexMoc5qCHxpBIE/AyeS4WPASlE8uVY9Qg8dT6
kJmeOT+ZAgMBAAGjggHUMIIB0DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1Ud
DwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFDyAvtuc
z/tQRXr3iPeVmZCr7nttMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAx+EQjLATc/sze
VoZkH7OLz+/no1+y31x4BQ3wjW7lKfay9DAAVym896b7ECttSo95GEvS7pYMikzud57WypK7Bjpi
ep8YLarLRDrvyyvBuYtyDrIewkuASHtV1oy5E6QZZe2VOxMm6e2oJnFFjbflot4A08D3SwqDwV0i
OOYwT0BUtHYR/3903Dmdx5Alq+NDvUHDjozgo0f6oIkwDXT3yBV36utQ/jFisd36C8RD5mM+NFpu
3aqLXARRbKtxw29ErCwulof2dcAonG7cd5j+gmS84sLhKU+BhL1OQVXnJ5tj7xZ5Ri5I23brcwk0
lk/gWqfgs3ppT9Xk7zVit9q8MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAa
i3OIQlLGfOMiECGt47mHGeiZ84QicJea6ntYXsj1+jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA4MTAyMzEyMTBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAYeVBeIUKqeIdc1DbMih/
b8HU6p2EJbt11TyEWf3BsNZCzkyH4PjLR1S9FKVMe6bvEF6uoomH7YzRr+H4cFHeWwjpzCI6XIgs
r8g7T+nV2rOvceSzboO/8iZ024jItnsZwrOb+Ws2EnodoAtViMpm2o309bCD3Ciq2KbOoLKD0Sai
FhbwTGvXSNA+4M4Yzag/Kfqx81w7y4FN/fR/Pap3tVFLz4CPixVn7SbWr01dFFIdHEUkar71vlFq
5QDavh9yPiVocmsKY7rcN6FpF7iEO4dMtaq9r72qIhdkKziLkHHEEsINiJPbiF0Qhz2dZuHI2N2A
Y3ivp41we+PhW0tyYA==
--000000000000b3567e05e5eb2d15--
