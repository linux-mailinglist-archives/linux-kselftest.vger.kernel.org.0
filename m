Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C13512C6B
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Apr 2022 09:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244875AbiD1HO4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Apr 2022 03:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238550AbiD1HOz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Apr 2022 03:14:55 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2888A308
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Apr 2022 00:11:41 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j15so5468686wrb.2
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Apr 2022 00:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iu3mIIhkdHRhMN6GOW58dhA4eauvdiodsg/LZz7IWg4=;
        b=d7gJf+zbY9APUXx4ZFXUjnUGdVfMD05P6kW+zUs1+QxzQne1JrH6fDXZ/jVV3RXRuK
         IDqzuus21BOQYV00QQvSqvZchAKL3jqARfzOzccoHymxcojk1wsE099d1sk0w4qm3ZEU
         vShqEqCmkbH1SFxENOen045FRw8Ens7Bi87NUqHQ2rfPHrk8P6csvSA7Caz0xQ3OVclY
         fBLovBNTNQagFG8iN3SGRAhPqgEv1U4jMM9QN3MhIc1MMZIdytKmyaSaHeBg7f690w1t
         SiK9Ewtgj1l6FlBjSmy3LaWPiN3yL/0KuNDHcFt+uD8akMwUguR9wyxbK/URRjGRlafz
         6now==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iu3mIIhkdHRhMN6GOW58dhA4eauvdiodsg/LZz7IWg4=;
        b=lLFg22iDrvMYmGBwCAfHOo9TmyPFHkfo/FNnIBv5y8bFwxkzh4C3Nttx666pcjc5i9
         jpTGgwsN84yn1yX2oZOrJqxkSyPbFP58qsgHVoQF7QtcoZNeQ8+18rn/3Ovhl2eKOFiq
         4Wyc8NqHU/Sq3e1bU55mKnVEPbBZyRhZ0SWdCH0JUiVBubQDjlzlkUT6cb/0ypd0rDuS
         9Ezl6BusZl+3X3f5xB3kuqBiYewJQBsFOX0bjcbSnhW668pag+KPMwdN2fIcMlEBdJ9T
         KNFNBXJLK8dsVzrdWhJnxcGr0CzygTaZnKFNIq7mFlWpbPf7mjXso9xLV//8K9w2os4w
         1EwA==
X-Gm-Message-State: AOAM5305eRKjNO0Qw6rGBxyxRyvU9Gc6Ii3e3oTtiq/Gn3sTSPCuIFPz
        bXe08si+fRX9im0kVdmq68nU1SBlo/10Y8QU2RxE5g==
X-Google-Smtp-Source: ABdhPJynw129WxSoiRF+0KV01QKi5IdYv9hb7+w2GmS6FYd37WSY/yro399Y+JizHvvtlOizQ4Gai3QSgJtsW3N7THw=
X-Received: by 2002:a5d:4307:0:b0:207:9f82:e238 with SMTP id
 h7-20020a5d4307000000b002079f82e238mr26530424wrq.430.1651129900141; Thu, 28
 Apr 2022 00:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220426173334.3871399-1-dlatypov@google.com> <20220426173334.3871399-3-dlatypov@google.com>
In-Reply-To: <20220426173334.3871399-3-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 28 Apr 2022 15:11:28 +0800
Message-ID: <CABVgOS=Tx+d_O9atHoexbCL=H-1LRuVC7OwKKBay0c4jnmBFcg@mail.gmail.com>
Subject: Re: [PATCH 3/3] kunit: tool: minor cosmetic cleanups in kunit_parser.py
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000033a6a005ddb1a334"
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

--00000000000033a6a005ddb1a334
Content-Type: text/plain; charset="UTF-8"

On Wed, Apr 27, 2022 at 1:33 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> There should be no behavioral changes from this patch.
>
> This patch removes redundant comment text, inlines a function used in
> only one place, and other such minor tweaks.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

These all look pretty sensible to me.

Reviewed-by: David Gow <davidgow@google.com>

-- David

>  tools/testing/kunit/kunit_parser.py | 71 +++++++----------------------
>  1 file changed, 17 insertions(+), 54 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> index 45c2c5837281..d56d530fab24 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -46,10 +46,8 @@ class Test(object):
>
>         def __str__(self) -> str:
>                 """Returns string representation of a Test class object."""
> -               return ('Test(' + str(self.status) + ', ' + self.name +
> -                       ', ' + str(self.expected_count) + ', ' +
> -                       str(self.subtests) + ', ' + str(self.log) + ', ' +
> -                       str(self.counts) + ')')
> +               return (f'Test({self.status}, {self.name}, {self.expected_count}, '
> +                       f'{self.subtests}, {self.log}, {self.counts})')
>
>         def __repr__(self) -> str:
>                 """Returns string representation of a Test class object."""
> @@ -58,7 +56,7 @@ class Test(object):
>         def add_error(self, error_message: str) -> None:
>                 """Records an error that occurred while parsing this test."""
>                 self.counts.errors += 1
> -               print_error('Test ' + self.name + ': ' + error_message)
> +               print_with_timestamp(red('[ERROR]') + f' Test: {self.name}: {error_message}')
>
>  class TestStatus(Enum):
>         """An enumeration class to represent the status of a test."""
> @@ -92,8 +90,7 @@ class TestCounts:
>                 self.errors = 0
>
>         def __str__(self) -> str:
> -               """Returns the string representation of a TestCounts object.
> -               """
> +               """Returns the string representation of a TestCounts object."""
>                 return ('Passed: ' + str(self.passed) +
>                         ', Failed: ' + str(self.failed) +
>                         ', Crashed: ' + str(self.crashed) +
> @@ -130,30 +127,19 @@ class TestCounts:
>                 if self.total() == 0:
>                         return TestStatus.NO_TESTS
>                 elif self.crashed:
> -                       # If one of the subtests crash, the expected status
> -                       # of the Test is crashed.
> +                       # Crashes should take priority.
>                         return TestStatus.TEST_CRASHED
>                 elif self.failed:
> -                       # Otherwise if one of the subtests fail, the
> -                       # expected status of the Test is failed.
>                         return TestStatus.FAILURE
>                 elif self.passed:
> -                       # Otherwise if one of the subtests pass, the
> -                       # expected status of the Test is passed.
> +                       # No failures or crashes, looks good!
>                         return TestStatus.SUCCESS
>                 else:
> -                       # Finally, if none of the subtests have failed,
> -                       # crashed, or passed, the expected status of the
> -                       # Test is skipped.
> +                       # We have only skipped tests.
>                         return TestStatus.SKIPPED
>
>         def add_status(self, status: TestStatus) -> None:
> -               """
> -               Increments count of inputted status.
> -
> -               Parameters:
> -               status - status to be added to the TestCounts object
> -               """
> +               """Increments the count for `status`."""
>                 if status == TestStatus.SUCCESS:
>                         self.passed += 1
>                 elif status == TestStatus.FAILURE:
> @@ -283,11 +269,9 @@ def check_version(version_num: int, accepted_versions: List[int],
>         test - Test object for current test being parsed
>         """
>         if version_num < min(accepted_versions):
> -               test.add_error(version_type +
> -                       ' version lower than expected!')
> +               test.add_error(f'{version_type} version lower than expected!')
>         elif version_num > max(accepted_versions):
> -               test.add_error(
> -                       version_type + ' version higher than expected!')
> +               test.add_error(f'{version_type} version higer than expected!')
>
>  def parse_ktap_header(lines: LineStream, test: Test) -> bool:
>         """
> @@ -440,8 +424,7 @@ def parse_test_result(lines: LineStream, test: Test,
>         # Check test num
>         num = int(match.group(2))
>         if num != expected_num:
> -               test.add_error('Expected test number ' +
> -                       str(expected_num) + ' but found ' + str(num))
> +               test.add_error(f'Expected test number {expected_num} but found {num}')
>
>         # Set status of test object
>         status = match.group(1)
> @@ -529,7 +512,7 @@ def format_test_divider(message: str, len_message: int) -> str:
>                 # calculate number of dashes for each side of the divider
>                 len_1 = int(difference / 2)
>                 len_2 = difference - len_1
> -       return ('=' * len_1) + ' ' + message + ' ' + ('=' * len_2)
> +       return ('=' * len_1) + f' {message} ' + ('=' * len_2)
>
>  def print_test_header(test: Test) -> None:
>         """
> @@ -545,20 +528,13 @@ def print_test_header(test: Test) -> None:
>         message = test.name
>         if test.expected_count:
>                 if test.expected_count == 1:
> -                       message += (' (' + str(test.expected_count) +
> -                               ' subtest)')
> +                       message += ' (1 subtest)'
>                 else:
> -                       message += (' (' + str(test.expected_count) +
> -                               ' subtests)')
> +                       message += f' ({test.expected_count} subtests)'
>         print_with_timestamp(format_test_divider(message, len(message)))
>
>  def print_log(log: Iterable[str]) -> None:
> -       """
> -       Prints all strings in saved log for test in yellow.
> -
> -       Parameters:
> -       log - Iterable object with all strings saved in log for test
> -       """
> +       """Prints all strings in saved log for test in yellow."""
>         for m in log:
>                 print_with_timestamp(yellow(m))
>
> @@ -635,20 +611,7 @@ def print_summary_line(test: Test) -> None:
>                 color = yellow
>         else:
>                 color = red
> -       counts = test.counts
> -       print_with_timestamp(color('Testing complete. ' + str(counts)))
> -
> -def print_error(error_message: str) -> None:
> -       """
> -       Prints error message with error format.
> -
> -       Example:
> -       "[ERROR] Test example: missing test plan!"
> -
> -       Parameters:
> -       error_message - message describing error
> -       """
> -       print_with_timestamp(red('[ERROR] ') + error_message)
> +       print_with_timestamp(color(f'Testing complete. {test.counts}'))
>
>  # Other methods:
>
> @@ -794,7 +757,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
>  def parse_run_tests(kernel_output: Iterable[str]) -> Test:
>         """
>         Using kernel output, extract KTAP lines, parse the lines for test
> -       results and print condensed test results and summary line .
> +       results and print condensed test results and summary line.
>
>         Parameters:
>         kernel_output - Iterable object contains lines of kernel output
> --
> 2.36.0.rc2.479.g8af0fa9b8e-goog
>

--00000000000033a6a005ddb1a334
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
MDIwAhABQeVybOOpR4bOOXZYL5T3MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAK
CnuliaSFic4i0b/Bhvb8byaCWFKYabeYCOW/hFTFUjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA0MjgwNzExNDBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAj5Bn3Jbh44oEbAPX7VnJ
iY+re0/XOTvDDC4vkYvvrF3e0cN7mc49sFvny7wCFw4zZXfRtDkIob4MALWF9uamGWV4SC87CdYq
AELBB5Vxag3gncuTHbIliv15HNCDlOQBolntmCbQjJW3dTzRq8BN7fwnGhAj5DZKlQEfyBeXUR/a
Qj9Z8MJDcCoPHcAnuWysLTHMS98mP9Coku4CiB8mhH6VIRLTkY3Szs1GI/jbsQ8JeT4ZB1Rc6YaX
bpBDG8Tpeufmrqca97mq4YSjz2Yr4mMXBLv3H1Lvlc/r0v1YtK9ECjmTOQKos/lX6NI6uFdJAjw1
pNENb4Qo6e6yKd1q0Q==
--00000000000033a6a005ddb1a334--
