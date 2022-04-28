Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA697512C6E
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Apr 2022 09:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244910AbiD1HPD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Apr 2022 03:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244914AbiD1HPA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Apr 2022 03:15:00 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF688AE61
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Apr 2022 00:11:46 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id m62so2360876wme.5
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Apr 2022 00:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s8i59739+6muxbLkcWz22T3FATUP2gXsekD82HLloo4=;
        b=Iunx1wvzKNLjLa1I1zOtcibkjVM0atfzjVthCpTc4mrrR+xZ1zoKoy4VYbGhinREDS
         A+tHd5oX/cbOSfvePKpzldlnMAW2z5XVqxw231GvyjVH4KuB5odLs11vjpmT2emK6un3
         eWZKqsZE/kUR/Ihxf1H6hWcH+iQ0eAeqokuk0Dnv8CVIrLboRoCq8d2oHzX9Jd0swZ/f
         BX8RMnR1OMB1NlMKvBntNhHJk2UW2s6H02egHZqJdTO7e54mePgC5INgqpWQzP0jbezw
         g5MIe8zVk/QX+QgHR0kfkfb52V+2nK2Uj5LoxcXc/aKPrr+c8tRaHWPyN3g/YPLaWTp9
         l0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s8i59739+6muxbLkcWz22T3FATUP2gXsekD82HLloo4=;
        b=ovMEXbhas1it79qJrNizj5RBCyF9zazpPPxgLRj/rrenBDUe/xlGqIThEXgZIvJ50P
         kZpHz1fbzDfnuhJvBXlPNHtDKDb4i5rJOy7CaqDrK4cPElG1+mjySa90fI1ca6UDEnU7
         AIKm2XRNbkFgBGZu+rA7U6JheC+Qzi4tLb7/in3xNwFkkmgTuyzV33uP/UosAU529OoT
         19bZMzlM7GgKsrCHf6juCC4N5fCUk8MCAV380ZiL9GOK/4k5tsDVx9HtAJmfy008hFw7
         bJbupgk3HP5nZWq2anFzYNaFQEFPgyOO9/AnevUxQEaHaKmD4RxDlLAH+qdJbdayYu+V
         MEdA==
X-Gm-Message-State: AOAM530xVCmeBICdl/mgEmQOmcAuwx8F8hUrf/tb+YHTNtobcd3wzhrF
        3SNAVpEaQr8hvBWR8pBlJeNTfSoFPfU9lNEKf6JjMQ==
X-Google-Smtp-Source: ABdhPJxDpztLmixuzm3dnWhMGVY7xXnSwNgZqFXrSY1bWQeQgKapazX6IEbAGxNZfrrnyfCHY2fwG82CX4mYEh60GC4=
X-Received: by 2002:a7b:c8d5:0:b0:392:b12e:fd11 with SMTP id
 f21-20020a7bc8d5000000b00392b12efd11mr29551523wml.96.1651129904774; Thu, 28
 Apr 2022 00:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220426173334.3871399-1-dlatypov@google.com>
In-Reply-To: <20220426173334.3871399-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 28 Apr 2022 15:11:33 +0800
Message-ID: <CABVgOSkLQdXL_X2UhhQ6a3=Gexg1Mp7n5mmMVtA_z5w1EnYgCQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] kunit: tool: remove dead parse_crash_in_log() logic
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000007908ec05ddb1a36f"
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

--0000000000007908ec05ddb1a36f
Content-Type: text/plain; charset="UTF-8"

On Wed, Apr 27, 2022 at 1:33 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> This logic depends on the kernel logging a message containing
> 'kunit test case crashed', but there is no corresponding logic to do so.
>
> This is likely a relic of the revision process KUnit initially went
> through when being upstreamed.
>
> Delete it given
> 1) it's been missing for years and likely won't get implemented
> 2) the parser has been moving to be a more general KTAP parser,
>    kunit-only magic like this isn't how we'd want to implement it.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Makes sense, thanks!

Reviewed-by: David Gow <davidgow@google.com>

-- David

>  tools/testing/kunit/kunit_parser.py           | 21 ------
>  tools/testing/kunit/kunit_tool_test.py        | 17 ++---
>  .../test_data/test_is_test_passed-crash.log   | 70 -------------------
>  3 files changed, 4 insertions(+), 104 deletions(-)
>  delete mode 100644 tools/testing/kunit/test_data/test_is_test_passed-crash.log
>
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> index 807ed2bd6832..7a0faf527a98 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -475,26 +475,6 @@ def parse_diagnostic(lines: LineStream) -> List[str]:
>                 log.append(lines.pop())
>         return log
>
> -DIAGNOSTIC_CRASH_MESSAGE = re.compile(r'^# .*?: kunit test case crashed!$')
> -
> -def parse_crash_in_log(test: Test) -> bool:
> -       """
> -       Iterate through the lines of the log to parse for crash message.
> -       If crash message found, set status to crashed and return True.
> -       Otherwise return False.
> -
> -       Parameters:
> -       test - Test object for current test being parsed
> -
> -       Return:
> -       True if crash message found in log
> -       """
> -       for line in test.log:
> -               if DIAGNOSTIC_CRASH_MESSAGE.match(line):
> -                       test.status = TestStatus.TEST_CRASHED
> -                       return True
> -       return False
> -
>
>  # Printing helper methods:
>
> @@ -682,7 +662,6 @@ def bubble_up_test_results(test: Test) -> None:
>         Parameters:
>         test - Test object for current test being parsed
>         """
> -       parse_crash_in_log(test)
>         subtests = test.subtests
>         counts = test.counts
>         status = test.status
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index 210df0f443e6..1200e451c418 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -230,15 +230,6 @@ class KUnitParserTest(unittest.TestCase):
>                 print_mock.stop()
>                 self.assertEqual(0, len(result.subtests))
>
> -       def test_crashed_test(self):
> -               crashed_log = test_data_path('test_is_test_passed-crash.log')
> -               with open(crashed_log) as file:
> -                       result = kunit_parser.parse_run_tests(
> -                               file.readlines())
> -               self.assertEqual(
> -                       kunit_parser.TestStatus.TEST_CRASHED,
> -                       result.status)
> -
>         def test_skipped_test(self):
>                 skipped_log = test_data_path('test_skip_tests.log')
>                 with open(skipped_log) as file:
> @@ -478,10 +469,10 @@ class KUnitJsonTest(unittest.TestCase):
>                         result["sub_groups"][1]["test_cases"][0])
>
>         def test_crashed_test_json(self):
> -               result = self._json_for('test_is_test_passed-crash.log')
> +               result = self._json_for('test_kernel_panic_interrupt.log')
>                 self.assertEqual(
> -                       {'name': 'example_simple_test', 'status': 'ERROR'},
> -                       result["sub_groups"][1]["test_cases"][0])
> +                       {'name': '', 'status': 'ERROR'},
> +                       result["sub_groups"][2]["test_cases"][1])
>
>         def test_skipped_test_json(self):
>                 result = self._json_for('test_skip_tests.log')
> @@ -562,7 +553,7 @@ class KUnitMainTest(unittest.TestCase):
>         def test_exec_no_tests(self):
>                 self.linux_source_mock.run_kernel = mock.Mock(return_value=['TAP version 14', '1..0'])
>                 with self.assertRaises(SystemExit) as e:
> -                  kunit.main(['run'], self.linux_source_mock)
> +                 kunit.main(['run'], self.linux_source_mock)

Noting that this is just an indentation fix.


>                 self.linux_source_mock.run_kernel.assert_called_once_with(
>                         args=None, build_dir='.kunit', filter_glob='', timeout=300)
>                 self.print_mock.assert_any_call(StrContains(' 0 tests run!'))
> diff --git a/tools/testing/kunit/test_data/test_is_test_passed-crash.log b/tools/testing/kunit/test_data/test_is_test_passed-crash.log
> deleted file mode 100644
> index 4d97f6708c4a..000000000000
> --- a/tools/testing/kunit/test_data/test_is_test_passed-crash.log
> +++ /dev/null
> @@ -1,70 +0,0 @@
> -printk: console [tty0] enabled
> -printk: console [mc-1] enabled
> -TAP version 14
> -1..2
> -       # Subtest: sysctl_test
> -       1..8
> -       # sysctl_test_dointvec_null_tbl_data: sysctl_test_dointvec_null_tbl_data passed
> -       ok 1 - sysctl_test_dointvec_null_tbl_data
> -       # sysctl_test_dointvec_table_maxlen_unset: sysctl_test_dointvec_table_maxlen_unset passed
> -       ok 2 - sysctl_test_dointvec_table_maxlen_unset
> -       # sysctl_test_dointvec_table_len_is_zero: sysctl_test_dointvec_table_len_is_zero passed
> -       ok 3 - sysctl_test_dointvec_table_len_is_zero
> -       # sysctl_test_dointvec_table_read_but_position_set: sysctl_test_dointvec_table_read_but_position_set passed
> -       ok 4 - sysctl_test_dointvec_table_read_but_position_set
> -       # sysctl_test_dointvec_happy_single_positive: sysctl_test_dointvec_happy_single_positive passed
> -       ok 5 - sysctl_test_dointvec_happy_single_positive
> -       # sysctl_test_dointvec_happy_single_negative: sysctl_test_dointvec_happy_single_negative passed
> -       ok 6 - sysctl_test_dointvec_happy_single_negative
> -       # sysctl_test_dointvec_single_less_int_min: sysctl_test_dointvec_single_less_int_min passed
> -       ok 7 - sysctl_test_dointvec_single_less_int_min
> -       # sysctl_test_dointvec_single_greater_int_max: sysctl_test_dointvec_single_greater_int_max passed
> -       ok 8 - sysctl_test_dointvec_single_greater_int_max
> -kunit sysctl_test: all tests passed
> -ok 1 - sysctl_test
> -       # Subtest: example
> -       1..2
> -init_suite
> -       # example_simple_test: initializing
> -Stack:
> - 6016f7db 6f81bd30 6f81bdd0 60021450
> - 6024b0e8 60021440 60018bbe 16f81bdc0
> - 00000001 6f81bd30 6f81bd20 6f81bdd0
> -Call Trace:
> - [<6016f7db>] ? kunit_try_run_case+0xab/0xf0
> - [<60021450>] ? set_signals+0x0/0x60
> - [<60021440>] ? get_signals+0x0/0x10
> - [<60018bbe>] ? kunit_um_run_try_catch+0x5e/0xc0
> - [<60021450>] ? set_signals+0x0/0x60
> - [<60021440>] ? get_signals+0x0/0x10
> - [<60018bb3>] ? kunit_um_run_try_catch+0x53/0xc0
> - [<6016f321>] ? kunit_run_case_catch_errors+0x121/0x1a0
> - [<60018b60>] ? kunit_um_run_try_catch+0x0/0xc0
> - [<600189e0>] ? kunit_um_throw+0x0/0x180
> - [<6016f730>] ? kunit_try_run_case+0x0/0xf0
> - [<6016f600>] ? kunit_catch_run_case+0x0/0x130
> - [<6016edd0>] ? kunit_vprintk+0x0/0x30
> - [<6016ece0>] ? kunit_fail+0x0/0x40
> - [<6016eca0>] ? kunit_abort+0x0/0x40
> - [<6016ed20>] ? kunit_printk_emit+0x0/0xb0
> - [<6016f200>] ? kunit_run_case_catch_errors+0x0/0x1a0
> - [<6016f46e>] ? kunit_run_tests+0xce/0x260
> - [<6005b390>] ? unregister_console+0x0/0x190
> - [<60175b70>] ? suite_kunit_initexample_test_suite+0x0/0x20
> - [<60001cbb>] ? do_one_initcall+0x0/0x197
> - [<60001d47>] ? do_one_initcall+0x8c/0x197
> - [<6005cd20>] ? irq_to_desc+0x0/0x30
> - [<60002005>] ? kernel_init_freeable+0x1b3/0x272
> - [<6005c5ec>] ? printk+0x0/0x9b
> - [<601c0086>] ? kernel_init+0x26/0x160
> - [<60014442>] ? new_thread_handler+0x82/0xc0
> -
> -       # example_simple_test: kunit test case crashed!
> -       # example_simple_test: example_simple_test failed
> -       not ok 1 - example_simple_test
> -       # example_mock_test: initializing
> -       # example_mock_test: example_mock_test passed
> -       ok 2 - example_mock_test
> -kunit example: one or more tests failed
> -not ok 2 - example
> -List of all partitions:
>
> base-commit: 59729170afcd4900e08997a482467ffda8d88c7f
> --
> 2.36.0.rc2.479.g8af0fa9b8e-goog
>

--0000000000007908ec05ddb1a36f
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
hO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/XzCCBNgwggPAoAMCAQICEAFB5XJs46lHhs45dlgv
lPcwDQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjMgU01JTUUgQ0EgMjAyMDAeFw0yMjAyMDcy
MDA0MDZaFw0yMjA4MDYyMDA0MDZaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5j
b20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC0RBy/38QAswohnM4+BbSvCjgfqx6l
RZ05OpnPrwqbR8foYkoeQ8fvsoU+MkOAQlzaA5IaeOc6NZYDYl7PyNLLSdnRwaXUkHOJIn09IeqE
9aKAoxWV8wiieIh3izFAHR+qm0hdG+Uet3mU85dzScP5UtFgctSEIH6Ay6pa5E2gdPEtO5frCOq2
PpOgBNfXVa5nZZzgWOqtL44txbQw/IsOJ9VEC8Y+4+HtMIsnAtHem5wcQJ+MqKWZ0okg/wYl/PUj
uaq2nM/5+Waq7BlBh+Wh4NoHIJbHHeGzAxeBcOU/2zPbSHpAcZ4WtpAKGvp67PlRYKSFXZvbORQz
LdciYl8fAgMBAAGjggHUMIIB0DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1Ud
DwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFKbSiBVQ
G7p3AiuB2sgfq6cOpbO5MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQBsL34EJkCtu9Nu
2+R6l1Qzno5Gl+N2Cm6/YLujukDGYa1JW27txXiilR9dGP7yl60HYyG2Exd5i6fiLDlaNEw0SqzE
dw9ZSIak3Qvm2UybR8zcnB0deCUiwahqh7ZncEPlhnPpB08ETEUtwBEqCEnndNEkIN67yz4kniCZ
jZstNF/BUnI3864fATiXSbnNqBwlJS3YkoaCTpbI9qNTrf5VIvnbryT69xJ6f25yfmxrXNJJe5OG
ncB34Cwnb7xQyk+uRLZ465yUBkbjk9pC/yamL0O7SOGYUclrQl2c5zzGuVBD84YcQGDOK6gSPj6w
QuBfOooZPOyZZZ8AMih7J980MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABQeVybOOpR4bOOXZYL5T3MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBW
la67y8SRkofF1O5f+LhWUNxBtVGuJVhvY5E13FTnATAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA0MjgwNzExNDVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAAvJZYI135FLkoqH63gfz
NmmCe14NGH8tjKY7qt2ZMoAsxJNsJGxzJlj4oVaNV/E1zfy0pzMl3kiJTJXr56WvD66c7ZrpOzLG
VoqyzjYvkZMcRT7un9l79XBDxXo7BjoBJ320nekhC3+rHrZB+3iWsPsDAARKVhzLvcS2/aEqYCrG
+UkqxR7KTx/foCfnriyAgxDbsAIvQqfM11gemDVOdtsxg5uMkm4E1twbOOb5L8nDT9IoQooIdfpc
+6qWIU+eSGoHvDV4hXjZMYfXyVflBo46HKUu/LHCbx18g08i5CCODvLAkhjNg5VXjENgDbNXR13j
gHW51Lc4ufDfwDEmUw==
--0000000000007908ec05ddb1a36f--
