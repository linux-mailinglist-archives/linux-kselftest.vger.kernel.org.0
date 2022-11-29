Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD26363BBAD
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Nov 2022 09:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiK2Ice (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Nov 2022 03:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiK2Ibk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Nov 2022 03:31:40 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54A8630C
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 00:31:17 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id c26so4772669uak.5
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 00:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aYPPf7b9E9iRoCSM5g8PEeoYFjJfiHGfWhsQXlSx9xk=;
        b=qS7nrPYrjQFloskBdI8eVYuDRDkztw9d8B4iTkDLDh+cEKRV4X4psz6Ibp1RIGZ9+g
         wRybc9BHcCB0z8/BnQAC5MH7PIBo4Ie4CXEfw8Iv+zbVqIfDp+igOoU6QPC52H2hibtd
         G2NzHqGczr3jiL5JmN2MdvgCim0yABAkQ6dxeDs1AWhsuYPeHxFCKxBHaxFx05iBpPhu
         Jqny0dgwDkHA2yb+2w9Q8RFK+st8mHDJyReTbVOQP1Dd2mw+sm/ZOEvCk2Tvl2VWU8yf
         C5tKDRXp0LQgGAAyIAPxF9onskiduKeBQfsSFqBYxsjFsIgt1osmLqOwFwDpCnZUWh+I
         cukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aYPPf7b9E9iRoCSM5g8PEeoYFjJfiHGfWhsQXlSx9xk=;
        b=I5PSZatI21qDOLjQdnxrFrLAiQWNJkfV5X0hzRv648eo+hHdubVOQYxQHNJDmn6xjR
         Hc35ib7ff+Z+06+0NombIxyqB2FUYIgd9vFuEneB836xYgD8Zyj0p1hrJqYrg4++67oB
         EYaCnaAnXQdqc92tzWGw/X1wNR06D6e2lvG9vXplVowhsjLBwUIBr/Cw2sps1O+bh2PL
         tH1tpI13aCteAUTv5V+5JV1vzvDkNmQLjdR4qI+QquOie4aIQhMX/nh2ftTSRlc8f3YS
         /Tz2vmpdYyNWoVGPWfgKGuVGCDvvgyyYb2ab8mTrSs+JprNOERVDWR4RryJILlviTvVq
         4NhA==
X-Gm-Message-State: ANoB5pltQBgmOHJ/oV+DdysygDcVvAfG3Fc4dGSx+JCrBJxu26mwL57D
        L4LFD3MBXOQUop1eR/U9VVcUUzqndOwJTzxPQriDRQ==
X-Google-Smtp-Source: AA0mqf5nIPQytSsjfQjoW7qXJ7k0WbaT4So7ZTuoQ9COYOh3XRW5qLbFvBu5lDFKrI/sjACUkIpaU4W9NbbywSj/tLc=
X-Received: by 2002:ab0:7258:0:b0:418:c0a0:556d with SMTP id
 d24-20020ab07258000000b00418c0a0556dmr22734898uap.104.1669710676840; Tue, 29
 Nov 2022 00:31:16 -0800 (PST)
MIME-Version: 1.0
References: <20221129001234.606653-1-dlatypov@google.com>
In-Reply-To: <20221129001234.606653-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 29 Nov 2022 16:31:05 +0800
Message-ID: <CABVgOS=6nx2SGRVjN1Ek1htsXehcnU1fnp6FMc0ATdOJfRd0iQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: don't include KTAP headers and the like in
 the test log
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, rmoar@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000ca8acd05ee97cfe4"
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

--000000000000ca8acd05ee97cfe4
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 29, 2022 at 8:12 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> We print the "test log" on failure.
> This is meant to be all the kernel output that happened during the test.
>
> But we also include the special KTAP lines in it, which are often
> redundant.
>
> E.g. we include the "not ok" line in the log, right before we print
> that the test case failed...
> [13:51:48] Expected 2 + 1 == 2, but
> [13:51:48] 2 + 1 == 3 (0x3)
> [13:51:48] not ok 1 example_simple_test
> [13:51:48] [FAILED] example_simple_test
>
> More full example after this patch:
> [13:51:48] =================== example (4 subtests) ===================
> [13:51:48] # example_simple_test: initializing
> [13:51:48] # example_simple_test: EXPECTATION FAILED at lib/kunit/kunit-example-test.c:29
> [13:51:48] Expected 2 + 1 == 2, but
> [13:51:48] 2 + 1 == 3 (0x3)
> [13:51:48] [FAILED] example_simple_test
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

I totally agree we should skip these from the log. (Unless
--raw_output is enabled, but that obviously doesn't apply.)

Going forward, I think we should also probably disable
kunit.stats_enabled when running via kunit.py, too (again, unless
--raw_output is used.)

In any case, this looks good and works well here.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  tools/testing/kunit/kunit_parser.py    |  8 ++++----
>  tools/testing/kunit/kunit_tool_test.py | 17 +++++++++++++++++
>  2 files changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> index 4cc2f8b7ecd0..99b8f058db40 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -295,7 +295,7 @@ def parse_ktap_header(lines: LineStream, test: Test) -> bool:
>                 check_version(version_num, TAP_VERSIONS, 'TAP', test)
>         else:
>                 return False
> -       test.log.append(lines.pop())
> +       lines.pop()
>         return True
>
>  TEST_HEADER = re.compile(r'^# Subtest: (.*)$')
> @@ -318,8 +318,8 @@ def parse_test_header(lines: LineStream, test: Test) -> bool:
>         match = TEST_HEADER.match(lines.peek())
>         if not match:
>                 return False
> -       test.log.append(lines.pop())
>         test.name = match.group(1)
> +       lines.pop()
>         return True
>
>  TEST_PLAN = re.compile(r'1\.\.([0-9]+)')
> @@ -345,9 +345,9 @@ def parse_test_plan(lines: LineStream, test: Test) -> bool:
>         if not match:
>                 test.expected_count = None
>                 return False
> -       test.log.append(lines.pop())
>         expected_count = int(match.group(1))
>         test.expected_count = expected_count
> +       lines.pop()
>         return True
>
>  TEST_RESULT = re.compile(r'^(ok|not ok) ([0-9]+) (- )?([^#]*)( # .*)?$')
> @@ -409,7 +409,7 @@ def parse_test_result(lines: LineStream, test: Test,
>         # Check if line matches test result line format
>         if not match:
>                 return False
> -       test.log.append(lines.pop())
> +       lines.pop()
>
>         # Set name of test object
>         if skip_match:
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index d7f669cbf2a8..1ef921ac4331 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -84,6 +84,10 @@ class KUnitParserTest(unittest.TestCase):
>                 self.print_mock = mock.patch('kunit_printer.Printer.print').start()
>                 self.addCleanup(mock.patch.stopall)
>
> +       def noPrintCallContains(self, substr: str):
> +               for call in self.print_mock.mock_calls:
> +                       self.assertNotIn(substr, call.args[0])
> +
>         def assertContains(self, needle: str, haystack: kunit_parser.LineStream):
>                 # Clone the iterator so we can print the contents on failure.
>                 copy, backup = itertools.tee(haystack)
> @@ -327,6 +331,19 @@ class KUnitParserTest(unittest.TestCase):
>                         result = kunit_parser.parse_run_tests(file.readlines())
>                 self.print_mock.assert_any_call(StrContains('suite (1 subtest)'))
>
> +       def test_show_test_output_on_failure(self):
> +               output = """
> +               KTAP version 1
> +               1..1
> +                 Test output.
> +               not ok 1 test1
> +               """
> +               result = kunit_parser.parse_run_tests(output.splitlines())
> +               self.assertEqual(kunit_parser.TestStatus.FAILURE, result.status)
> +
> +               self.print_mock.assert_any_call(StrContains('Test output.'))
> +               self.noPrintCallContains('not ok 1 test1')
> +
>  def line_stream_from_strs(strs: Iterable[str]) -> kunit_parser.LineStream:
>         return kunit_parser.LineStream(enumerate(strs, start=1))
>
>
> base-commit: 11300092f6f4dc4103ac4bd950d62f94effc736a
> --
> 2.38.1.584.g0f3c55d4c2-goog
>

--000000000000ca8acd05ee97cfe4
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
MDIwAhABj4peqtakTCOMXLZ2mEqRMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCD2
N3EN/uzE6yMWq2VXhwwvdp0SUQUBAFSE+nNiBoCfXzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjExMjkwODMxMTdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAQ5Pru9XkP9AxF47fqAfF
/uQoRwX6V6WkiedL/9bQAobq8up/R0+49P8ws49HEYHCsSMuTCxUQguw1yOqW5xaJxcF+vX2cAsU
7RLiQhZQIEb0qmGWLFbVJFRiwE5qkA4IJLa+fPaAi6Ufj0Aq0uzsN0AdvH1xW0Kst3yi4CCUl729
YPe+vRxmWaZvldxyH8YfnVJCZLopDKQv6IvbXOtI9fpMnP4mzHiacJ+iLGBcR18UagPRQiJlgUE+
jq0Sul1+co2UfSGP5ndfkP6dsZwRC/4uNKKcSXkzKg6SkJx+36eKTO6LJxhgAFSTSXj5slsWrftX
L0ORRDgteZ/e5fS1qg==
--000000000000ca8acd05ee97cfe4--
