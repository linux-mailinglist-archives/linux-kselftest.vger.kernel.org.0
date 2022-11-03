Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BBA6176C8
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 07:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiKCGiP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 02:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiKCGiN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 02:38:13 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729BE1838E
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Nov 2022 23:38:12 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id g16so370645vkl.11
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Nov 2022 23:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rjYc6CzMGmfr1OO5wP42pS21IyQnBdGzrn8iSxiHmGQ=;
        b=ciX7scQkV6RXF9xvGzRO3jhCgNMHDytTn/+ESYiCyksfQUyYMmubzC0P+gdN5MgkhK
         qjUEFKZf8ZG2sN6nbJMM5jgQ2F3Q/ifsLhWObwHrw4P7bXNonZd+NPAjxCCQlr/UdJoN
         sFM7ieR+aDNkrHiqHsbXLxI6IwLfFprc6aOIKALOkdd5caE9N9ghlA6yjmHfbx1c7exm
         sCK9KynvV/ZLJlJu2GiL+n6Dx2R3uElduIyUEul9Cy0xfb5HUKqFwNReXIhmkbhUt3jt
         XHEJpZZr1T48jpXu92HL1K+/VkqXCIqJ2Dvx3tV4M/t4MC2kd3p1G5e5teJdn7qGyNNK
         Ay3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rjYc6CzMGmfr1OO5wP42pS21IyQnBdGzrn8iSxiHmGQ=;
        b=RytGhKzKxD059BhNrTrTrSr1kLR1W+nz/1GDm+HF8xiAGrQ+uLtngQ48u5UkWCO1IP
         YSe9/e30eFd8oQFIHUD1VcEoX0gwBDKG06pqBmldvfaLjBlGz4VOUq53V17OFqqLEGep
         xt8n6PV1NX3sJqPgz73DwKKnBhEcEfem+BvXLywJuyieTq2crBMPa1IvcgGubTZvsA+H
         iGcX4GpCSCkzunpJvDulU+l3edow94fDj4c3cgKKyzk1UCQkin9KHlgokquwUJyZf3Ji
         VqjwIRbgZFNDA4XmqhCPe91AQIHxyF4TyGKf4m75xYLof4vLjrpBMX9UNGOcFDys4Kt/
         TMpQ==
X-Gm-Message-State: ACrzQf0GNSb2hJxbgFoXkq2l9EfkPhAoe25iJKhyF9wcQArq05gDZKUy
        5J240lNSsRODYrfJAdSA7efxpZgg/UShvH3e86RO2A==
X-Google-Smtp-Source: AMsMyM6rgOtykrNCGcsY0XNZ1w4EzaaYgVtBZPbnAGsEvn9SwQ/L4DeKhqertJiiw8fRemlz+w45eYO4I/sF0pCTMto=
X-Received: by 2002:a1f:ad49:0:b0:3b6:d5d4:99dc with SMTP id
 w70-20020a1fad49000000b003b6d5d499dcmr16375527vke.37.1667457491460; Wed, 02
 Nov 2022 23:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <20221102164005.2516646-1-dlatypov@google.com> <20221102164005.2516646-2-dlatypov@google.com>
In-Reply-To: <20221102164005.2516646-2-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 3 Nov 2022 14:38:00 +0800
Message-ID: <CABVgOSki2WnA_JyYTwdzQJB+fJDPkFRWjmwW60vih+aEJ2QmLg@mail.gmail.com>
Subject: Re: [PATCH 2/3] kunit: tool: unit tests all check parser errors,
 standardize formatting a bit
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, rmoar@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000079fe5405ec8b3378"
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

--00000000000079fe5405ec8b3378
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 3, 2022 at 12:40 AM 'Daniel Latypov' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Let's verify that the parser isn't reporting any errors for valid
> inputs.
>
> This change also
> * does result.status checking on one line
> * makes sure we consistently do it outside of the `with` block
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Looks good, thanks.

Note that this patch does conflict with "kunit: tool: print summary of
failed tests if a few failed out of a lot":
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit&id=f19dd011d8de6f0c1d20abea5158aa4f5d9cea44
It's only a context line issue, though.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  tools/testing/kunit/kunit_tool_test.py | 93 +++++++++++---------------
>  1 file changed, 38 insertions(+), 55 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index 9fa4babb2506..0063773c0fc4 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -133,33 +133,29 @@ class KUnitParserTest(unittest.TestCase):
>                 all_passed_log = test_data_path('test_is_test_passed-all_passed.log')
>                 with open(all_passed_log) as file:
>                         result = kunit_parser.parse_run_tests(file.readlines())
> -               self.assertEqual(
> -                       kunit_parser.TestStatus.SUCCESS,
> -                       result.status)
> +               self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
> +               self.assertEqual(result.counts.errors, 0)
>
>         def test_parse_successful_nested_tests_log(self):
>                 all_passed_log = test_data_path('test_is_test_passed-all_passed_nested.log')
>                 with open(all_passed_log) as file:
>                         result = kunit_parser.parse_run_tests(file.readlines())
> -               self.assertEqual(
> -                       kunit_parser.TestStatus.SUCCESS,
> -                       result.status)
> +               self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
> +               self.assertEqual(result.counts.errors, 0)
>
>         def test_kselftest_nested(self):
>                 kselftest_log = test_data_path('test_is_test_passed-kselftest.log')
>                 with open(kselftest_log) as file:
>                         result = kunit_parser.parse_run_tests(file.readlines())
> -                       self.assertEqual(
> -                               kunit_parser.TestStatus.SUCCESS,
> -                               result.status)
> +               self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
> +               self.assertEqual(result.counts.errors, 0)
>
>         def test_parse_failed_test_log(self):
>                 failed_log = test_data_path('test_is_test_passed-failure.log')
>                 with open(failed_log) as file:
>                         result = kunit_parser.parse_run_tests(file.readlines())
> -               self.assertEqual(
> -                       kunit_parser.TestStatus.FAILURE,
> -                       result.status)
> +               self.assertEqual(kunit_parser.TestStatus.FAILURE, result.status)
> +               self.assertEqual(result.counts.errors, 0)
>
>         def test_no_header(self):
>                 empty_log = test_data_path('test_is_test_passed-no_tests_run_no_header.log')
> @@ -167,9 +163,8 @@ class KUnitParserTest(unittest.TestCase):
>                         result = kunit_parser.parse_run_tests(
>                                 kunit_parser.extract_tap_lines(file.readlines()))
>                 self.assertEqual(0, len(result.subtests))
> -               self.assertEqual(
> -                       kunit_parser.TestStatus.FAILURE_TO_PARSE_TESTS,
> -                       result.status)
> +               self.assertEqual(kunit_parser.TestStatus.FAILURE_TO_PARSE_TESTS, result.status)
> +               self.assertEqual(result.counts.errors, 1)
>
>         def test_missing_test_plan(self):
>                 missing_plan_log = test_data_path('test_is_test_passed-'
> @@ -180,9 +175,7 @@ class KUnitParserTest(unittest.TestCase):
>                                 file.readlines()))
>                 # A missing test plan is not an error.
>                 self.assertEqual(result.counts, kunit_parser.TestCounts(passed=10, errors=0))
> -               self.assertEqual(
> -                       kunit_parser.TestStatus.SUCCESS,
> -                       result.status)
> +               self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
>
>         def test_no_tests(self):
>                 header_log = test_data_path('test_is_test_passed-no_tests_run_with_header.log')
> @@ -190,9 +183,8 @@ class KUnitParserTest(unittest.TestCase):
>                         result = kunit_parser.parse_run_tests(
>                                 kunit_parser.extract_tap_lines(file.readlines()))
>                 self.assertEqual(0, len(result.subtests))
> -               self.assertEqual(
> -                       kunit_parser.TestStatus.NO_TESTS,
> -                       result.status)
> +               self.assertEqual(kunit_parser.TestStatus.NO_TESTS, result.status)
> +               self.assertEqual(result.counts.errors, 1)
>
>         def test_no_tests_no_plan(self):
>                 no_plan_log = test_data_path('test_is_test_passed-no_tests_no_plan.log')
> @@ -203,7 +195,7 @@ class KUnitParserTest(unittest.TestCase):
>                 self.assertEqual(
>                         kunit_parser.TestStatus.NO_TESTS,
>                         result.subtests[0].subtests[0].status)
> -               self.assertEqual(1, result.counts.errors)
> +               self.assertEqual(result.counts, kunit_parser.TestCounts(passed=1, errors=1))
>
>
>         def test_no_kunit_output(self):
> @@ -215,6 +207,7 @@ class KUnitParserTest(unittest.TestCase):
>                 print_mock.assert_any_call(StrContains('could not find any KTAP output!'))
>                 print_mock.stop()
>                 self.assertEqual(0, len(result.subtests))
> +               self.assertEqual(result.counts.errors, 1)
>
>         def test_skipped_test(self):
>                 skipped_log = test_data_path('test_skip_tests.log')
> @@ -222,18 +215,16 @@ class KUnitParserTest(unittest.TestCase):
>                         result = kunit_parser.parse_run_tests(file.readlines())
>
>                 # A skipped test does not fail the whole suite.
> -               self.assertEqual(
> -                       kunit_parser.TestStatus.SUCCESS,
> -                       result.status)
> +               self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
> +               self.assertEqual(result.counts, kunit_parser.TestCounts(passed=4, skipped=1))
>
>         def test_skipped_all_tests(self):
>                 skipped_log = test_data_path('test_skip_all_tests.log')
>                 with open(skipped_log) as file:
>                         result = kunit_parser.parse_run_tests(file.readlines())
>
> -               self.assertEqual(
> -                       kunit_parser.TestStatus.SKIPPED,
> -                       result.status)
> +               self.assertEqual(kunit_parser.TestStatus.SKIPPED, result.status)
> +               self.assertEqual(result.counts, kunit_parser.TestCounts(skipped=5))
>
>         def test_ignores_hyphen(self):
>                 hyphen_log = test_data_path('test_strip_hyphen.log')
> @@ -241,9 +232,7 @@ class KUnitParserTest(unittest.TestCase):
>                         result = kunit_parser.parse_run_tests(file.readlines())
>
>                 # A skipped test does not fail the whole suite.
> -               self.assertEqual(
> -                       kunit_parser.TestStatus.SUCCESS,
> -                       result.status)
> +               self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
>                 self.assertEqual(
>                         "sysctl_test",
>                         result.subtests[0].name)
> @@ -257,55 +246,49 @@ class KUnitParserTest(unittest.TestCase):
>                 prefix_log = test_data_path('test_config_printk_time.log')
>                 with open(prefix_log) as file:
>                         result = kunit_parser.parse_run_tests(file.readlines())
> -                       self.assertEqual(
> -                               kunit_parser.TestStatus.SUCCESS,
> -                               result.status)
> -                       self.assertEqual('kunit-resource-test', result.subtests[0].name)
> +               self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
> +               self.assertEqual('kunit-resource-test', result.subtests[0].name)
> +               self.assertEqual(result.counts.errors, 0)
>
>         def test_ignores_multiple_prefixes(self):
>                 prefix_log = test_data_path('test_multiple_prefixes.log')
>                 with open(prefix_log) as file:
>                         result = kunit_parser.parse_run_tests(file.readlines())
> -                       self.assertEqual(
> -                               kunit_parser.TestStatus.SUCCESS,
> -                               result.status)
> -                       self.assertEqual('kunit-resource-test', result.subtests[0].name)
> +               self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
> +               self.assertEqual('kunit-resource-test', result.subtests[0].name)
> +               self.assertEqual(result.counts.errors, 0)
>
>         def test_prefix_mixed_kernel_output(self):
>                 mixed_prefix_log = test_data_path('test_interrupted_tap_output.log')
>                 with open(mixed_prefix_log) as file:
>                         result = kunit_parser.parse_run_tests(file.readlines())
> -                       self.assertEqual(
> -                               kunit_parser.TestStatus.SUCCESS,
> -                               result.status)
> -                       self.assertEqual('kunit-resource-test', result.subtests[0].name)
> +               self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
> +               self.assertEqual('kunit-resource-test', result.subtests[0].name)
> +               self.assertEqual(result.counts.errors, 0)
>
>         def test_prefix_poundsign(self):
>                 pound_log = test_data_path('test_pound_sign.log')
>                 with open(pound_log) as file:
>                         result = kunit_parser.parse_run_tests(file.readlines())
> -                       self.assertEqual(
> -                               kunit_parser.TestStatus.SUCCESS,
> -                               result.status)
> -                       self.assertEqual('kunit-resource-test', result.subtests[0].name)
> +               self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
> +               self.assertEqual('kunit-resource-test', result.subtests[0].name)
> +               self.assertEqual(result.counts.errors, 0)
>
>         def test_kernel_panic_end(self):
>                 panic_log = test_data_path('test_kernel_panic_interrupt.log')
>                 with open(panic_log) as file:
>                         result = kunit_parser.parse_run_tests(file.readlines())
> -                       self.assertEqual(
> -                               kunit_parser.TestStatus.TEST_CRASHED,
> -                               result.status)
> -                       self.assertEqual('kunit-resource-test', result.subtests[0].name)
> +               self.assertEqual(kunit_parser.TestStatus.TEST_CRASHED, result.status)
> +               self.assertEqual('kunit-resource-test', result.subtests[0].name)
> +               self.assertGreaterEqual(result.counts.errors, 1)
>
>         def test_pound_no_prefix(self):
>                 pound_log = test_data_path('test_pound_no_prefix.log')
>                 with open(pound_log) as file:
>                         result = kunit_parser.parse_run_tests(file.readlines())
> -                       self.assertEqual(
> -                               kunit_parser.TestStatus.SUCCESS,
> -                               result.status)
> -                       self.assertEqual('kunit-resource-test', result.subtests[0].name)
> +               self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
> +               self.assertEqual('kunit-resource-test', result.subtests[0].name)
> +               self.assertEqual(result.counts.errors, 0)
>
>  def line_stream_from_strs(strs: Iterable[str]) -> kunit_parser.LineStream:
>         return kunit_parser.LineStream(enumerate(strs, start=1))
> --
> 2.38.1.273.g43a17bfeac-goog
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20221102164005.2516646-2-dlatypov%40google.com.

--00000000000079fe5405ec8b3378
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
MDIwAhABj4peqtakTCOMXLZ2mEqRMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAM
OOf0i1ca+034ogEL4kIDX6HYKMDc8+sBad8b/0Gb9zAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjExMDMwNjM4MTFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAo1woLv2VN8wjaXqrX4VT
8y3+zk+v/So4dF3mp/PoVe6PsFBczc4+FkWnTsffBBwaLLGc2NwdtpSzPNLclU+DT5ypfaHx2dQU
gQs836hbA0evqd4QLEHdwJa47soEUpGQS69z55jbEo78nLkRBLjQ18p78WM+hsx/lDUI/gVb/Ca1
PAk//3r2QYmX80kAdo86BBFLx8H5DQRvJRlUwP6VJhfVikraQBXhM97s1ME8oKNui6I1d2vEh7Jo
KKOdV8DMxdORrFelW0m8/gDUu67kPv0LtYJ2F36xh5wW+MJ2ktVarQ8C6P2SofWW6tgEj0pLIyqX
61OfYqqomgZ/npfJkA==
--00000000000079fe5405ec8b3378--
