Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE0A6334C9
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Nov 2022 06:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiKVFqb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Nov 2022 00:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiKVFq2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Nov 2022 00:46:28 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4201DF2D
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Nov 2022 21:46:26 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id p1so4809750uak.11
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Nov 2022 21:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yJubHHDT2wIZmk2KamFcNQVUSb8Q68mzgR6kdY9BlRY=;
        b=Dhi5UfxyzZc9h+PmTAjB+KaqBuZh79lvHPAIQ3TnAqFxVaBjvRU6wA1y+hR3XgTIJb
         8SpTS+oRXu7mgbItHJovmHmix6eMflHjUKbMLBqk4lEZJ7iNWX9k2pdPpHhQJd7E1jSc
         DB2QNIDcsh1SAgD9jhs5Acfw7I+l3LuKVJY7VsjPU0vYqCpab1I2RLXPQeDekFtHEEm+
         HcNoCaFMgUDfh0zYkT2rnYYhFc8tORMgpQk03QozdOdVUHasg1h7JY0VMrFdbawkp6dm
         WrmNuCMLLUsn//243RcO9pntnQM/wtkomVhjKGARBQPMPJTdd27IxOQABw35wLOYcvZx
         Atmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yJubHHDT2wIZmk2KamFcNQVUSb8Q68mzgR6kdY9BlRY=;
        b=CsK/fjBzpNTf1YqGLm16Cm0dnd4/cP3nCi/78KBVASxlRvTQf/ox2803Cr6YMOh91M
         si138ir/FM82NkG8YvUPwonIC0sBL3uwStr2t3nTlgOtxmYDUaPFekiZpgLluXvTv05C
         9AOt7ew12cgiXskrBbUq0oiEEyq4QvD/3+4z50F+mI4PTmBnjVcp9UptMOYAoKkEdbF3
         BGmHeeXaNtwg7AJkgQikACva1Z6aIterL2G69V27WiRdUu1lbLK0h3bkKiqmeZr2/2OP
         67kCYEatiRsYGfBZO7ernMafEd3JYDHr1GBu3G/bXSmfvOVHCpBS+9Tdnhpq8x/zuP87
         7JWA==
X-Gm-Message-State: ANoB5plEQYCoQs1cPyLEnfUW+X1YJ/H3EerfZQ4LvCK6k5emmBfU3nI4
        CB4/55Cu57YwzDFf+QsDdG1fyi91xsdjvsX5/6YfhA==
X-Google-Smtp-Source: AA0mqf4hVwUCeIVTvspwEfs5b6ir6LVKvghxEwUux372jf7Pmixuhohc0R2cXLWoOma/Vrkn4J9a9BYb7nLJJ9Npnlk=
X-Received: by 2002:ab0:1e4a:0:b0:418:ba6a:523e with SMTP id
 n10-20020ab01e4a000000b00418ba6a523emr6724484uak.26.1669095985922; Mon, 21
 Nov 2022 21:46:25 -0800 (PST)
MIME-Version: 1.0
References: <20221121195526.425882-1-dlatypov@google.com>
In-Reply-To: <20221121195526.425882-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 22 Nov 2022 13:46:14 +0800
Message-ID: <CABVgOSmh2x-Bf=Ts3AHiNAuOfHQV=ECiFhm2yFfOyJtidVt5ig@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: make --json do nothing if --raw_ouput is set
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, rmoar@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000005b7d1305ee08b17d"
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

--0000000000005b7d1305ee08b17d
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 22, 2022 at 3:55 AM 'Daniel Latypov' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> When --raw_output is set (to any value), we don't actually parse the
> test results. So asking to print the test results as json doesn't make
> sense.
>
> We internally create a fake test with one passing subtest, so --json
> would actually print out something misleading.
>
> This patch:
> * Rewords the flag descriptions so hopefully this is more obvious.
> * Also updates --raw_output's description to note the default behavior
>   is to print out only "KUnit" results (actually any KTAP results)
> * also renames and refactors some related logic for clarity (e.g.
>   test_result => test, it's a kunit_parser.Test object).
>
> Notably, this patch does not make it an error to specify --json and
> --raw_output together. This is an edge case, but I know of at least one
> wrapper around kunit.py that always sets --json. You'd never be able to
> use --raw_output with that wrapper.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

This seems sensible enough to me (and works fine here).

I really like the new flag descriptions, too.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  tools/testing/kunit/kunit.py | 34 ++++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 16 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index 4d4663fb578b..e7b6549712d6 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -192,12 +192,11 @@ def _map_to_overall_status(test_status: kunit_parser.TestStatus) -> KunitStatus:
>  def parse_tests(request: KunitParseRequest, metadata: kunit_json.Metadata, input_data: Iterable[str]) -> Tuple[KunitResult, kunit_parser.Test]:
>         parse_start = time.time()
>
> -       test_result = kunit_parser.Test()
> -
>         if request.raw_output:
>                 # Treat unparsed results as one passing test.
> -               test_result.status = kunit_parser.TestStatus.SUCCESS
> -               test_result.counts.passed = 1
> +               fake_test = kunit_parser.Test()
> +               fake_test.status = kunit_parser.TestStatus.SUCCESS
> +               fake_test.counts.passed = 1
>
>                 output: Iterable[str] = input_data
>                 if request.raw_output == 'all':
> @@ -206,14 +205,17 @@ def parse_tests(request: KunitParseRequest, metadata: kunit_json.Metadata, input
>                         output = kunit_parser.extract_tap_lines(output, lstrip=False)
>                 for line in output:
>                         print(line.rstrip())
> +               parse_time = time.time() - parse_start
> +               return KunitResult(KunitStatus.SUCCESS, parse_time), fake_test
>
> -       else:
> -               test_result = kunit_parser.parse_run_tests(input_data)
> -       parse_end = time.time()
> +
> +       # Actually parse the test results.
> +       test = kunit_parser.parse_run_tests(input_data)
> +       parse_time = time.time() - parse_start
>
>         if request.json:
>                 json_str = kunit_json.get_json_result(
> -                                       test=test_result,
> +                                       test=test,
>                                         metadata=metadata)
>                 if request.json == 'stdout':
>                         print(json_str)
> @@ -223,10 +225,10 @@ def parse_tests(request: KunitParseRequest, metadata: kunit_json.Metadata, input
>                         stdout.print_with_timestamp("Test results stored in %s" %
>                                 os.path.abspath(request.json))
>
> -       if test_result.status != kunit_parser.TestStatus.SUCCESS:
> -               return KunitResult(KunitStatus.TEST_FAILURE, parse_end - parse_start), test_result
> +       if test.status != kunit_parser.TestStatus.SUCCESS:
> +               return KunitResult(KunitStatus.TEST_FAILURE, parse_time), test
>
> -       return KunitResult(KunitStatus.SUCCESS, parse_end - parse_start), test_result
> +       return KunitResult(KunitStatus.SUCCESS, parse_time), test
>
>  def run_tests(linux: kunit_kernel.LinuxSourceTree,
>               request: KunitRequest) -> KunitResult:
> @@ -359,14 +361,14 @@ def add_exec_opts(parser) -> None:
>                             choices=['suite', 'test'])
>
>  def add_parse_opts(parser) -> None:
> -       parser.add_argument('--raw_output', help='If set don\'t format output from kernel. '
> -                           'If set to --raw_output=kunit, filters to just KUnit output.',
> +       parser.add_argument('--raw_output', help='If set don\'t parse output from kernel. '
> +                           'By default, filters to just KUnit output. Use '
> +                           '--raw_output=all to show everything',
>                              type=str, nargs='?', const='all', default=None, choices=['all', 'kunit'])
>         parser.add_argument('--json',
>                             nargs='?',
> -                           help='Stores test results in a JSON, and either '
> -                           'prints to stdout or saves to file if a '
> -                           'filename is specified',
> +                           help='Prints parsed test results as JSON to stdout or a file if '
> +                           'a filename is specified. Does nothing if --raw_output is set.',
>                             type=str, const='stdout', default=None, metavar='FILE')
>
>
>
> base-commit: 870f63b7cd78d0055902d839a60408f7428b4e84
> --
> 2.38.1.584.g0f3c55d4c2-goog
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20221121195526.425882-1-dlatypov%40google.com.

--0000000000005b7d1305ee08b17d
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
MDIwAhABj4peqtakTCOMXLZ2mEqRMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCe
+JB4r8IHhB3QmD8h6odOkBYliqHgdRnEu7KKF+SMiDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjExMjIwNTQ2MjZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAzhSSf5n46dq+TohFfpQC
B/zugRz45qMItBHKaJ714SJh+Txd+lTgJWywWdMI8Sd2rUwOAu/rrYlyqqRm0MnNmFNeoAC9xrJD
ZldW3HoluwHsgMXBC1AQ7jplUm4Ke9FD7gPpt9pKMCMYjuKuyO6eNQWUkdQdfN+/3IYjFj9toYa0
N+HR59GnO4pANDCGBTiltnTPk09nydOeLmk6nRgKd7yFbUFE1bMmzlyw0pWryzLNvxDkxZshFeVZ
aqX0mVZAZpExSRQiyZQQqj6owj4yEPHdVi1YWi2+IJTmGAnCCBq+Zq155Et2qKnD3t/QHlEsdOOY
d+hUeKRzq7LAQhCQNA==
--0000000000005b7d1305ee08b17d--
