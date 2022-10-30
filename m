Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3151C612AE2
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Oct 2022 15:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiJ3OFD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 30 Oct 2022 10:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJ3OFD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 30 Oct 2022 10:05:03 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D1DB485
        for <linux-kselftest@vger.kernel.org>; Sun, 30 Oct 2022 07:05:01 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id e26so4091462uaa.7
        for <linux-kselftest@vger.kernel.org>; Sun, 30 Oct 2022 07:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MHDNtWG+F22UsDL3ep7Y7/lpmdUPY0AVP81UIjtrxnM=;
        b=JwVUmZapmSbEXsq0f+GPnLMVAYYtCzCTb1hgF9LnvY2GBlM5KM1gFTKpTjc0DiMTK3
         e/fLLLZwtaceTYdnzV+UoGCm53UHTTZ0FhSGSdHxv/HYunXmStN4DtkMMQWhKcoAh5AD
         bOpcPziVEgNdEZ0W2xtVeoaxWHgbJDjmOaIyzhlTs5kWY2Vuga/kGKKbu7Jd2QBltD7G
         wuYszpyTUI57ui1wTffafayh4+cLp89ATDAji/4u4bBQqccpsQ538h33//uAI1e6QT8B
         SAoU6vOSTQQ+1sh37Xaf09ajjww3uSqc1IB2+26d2aI2LOPnVaCaGygXAhiSawlxCTG/
         auSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MHDNtWG+F22UsDL3ep7Y7/lpmdUPY0AVP81UIjtrxnM=;
        b=f5uc8xVopR1Tey1tGxu3vMhAotNPtlTUzGPoh7vMXe+3xiIwyNdXKc4t/b+FGg9iov
         Z4yeoJCvVcdSeTSGRtu9vOc5QhtnmkqWauy6znxofId8e5asnAtNpqCOYhaI8UWWG2W4
         Jxx3sCotRajnLFMKubTCSmPQDpA8gXzeZx9hml5uYnv+C8vuGuCTllooi1ArdvsXV8lE
         rZr5S5KTgTc1jy2v6/zsV3bLW6tH3as6pG0qBgwdRPs7NsvKWjLHl5NhAgTseGeZ8nxa
         octFcq8wuQXyvh8mtfgeBLtMjIW816W8UuBv5XX17r+/OIJoKQKaxD2UVzuCLRBXi/Kr
         yNIg==
X-Gm-Message-State: ACrzQf3UMJ8YrdpCrHV8kFexc3K3AARB78hAI9XJobjxAQS0Sc1bHaIU
        HEbckEF5e+SwPDCuMrsGk/fpYCjPJuaFcVygIngCcCRDkco=
X-Google-Smtp-Source: AMsMyM6x3Qbmzmkj01qJ+fIGD8mPtgzBYLa32VstWP6VkROAd9oOTVsXhcM/C1wv8oSwckqLX7dhhRzaN5A/9G+R1Pk=
X-Received: by 2002:ab0:132b:0:b0:3e4:ac2d:9e0f with SMTP id
 g40-20020ab0132b000000b003e4ac2d9e0fmr3138708uae.107.1667138700451; Sun, 30
 Oct 2022 07:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <20221028210256.3776835-1-dlatypov@google.com> <20221028210256.3776835-2-dlatypov@google.com>
In-Reply-To: <20221028210256.3776835-2-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Sun, 30 Oct 2022 22:04:49 +0800
Message-ID: <CABVgOSkXE-nYnWyJmCdEZ0b1xCBj-p_cpE5YzBCZvW4cdk8LOw@mail.gmail.com>
Subject: Re: [PATCH 2/2] kunit: tool: print summary of failed tests if a few
 failed out of a lot
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, rmoar@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000000dba0305ec40fa54"
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

--0000000000000dba0305ec40fa54
Content-Type: text/plain; charset="UTF-8"

On Sat, Oct 29, 2022 at 5:03 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> E.g. all the hw_breakpoint tests are failing right now.
> So if I run `kunit.py run --altests --arch=x86_64`, then I see
> > Testing complete. Ran 408 tests: passed: 392, failed: 9, skipped: 7
>
> Seeing which 9 tests failed out of the hundreds is annoying.
> If my terminal doesn't have scrollback support, I have to resort to
> looking at `.kunit/test.log` for the `not ok` lines.
>
> Teach kunit.py to print a summarized list of failures if the # of tests
> reachs an arbitrary threshold (>=100 tests).
>
> To try and keep the output from being too long/noisy, this new logic
> a) just reports "parent_test failed" if every child test failed
> b) won't print anything if there are >10 failures (also arbitrary).
>
> With this patch, we get an extra line of output showing:
> > Testing complete. Ran 408 tests: passed: 392, failed: 9, skipped: 7
> > Failures: hw_breakpoint
>
> This also works with parameterized tests, e.g. if I add a fake failure
> > Failures: kcsan.test_atomic_builtins_missing_barrier.threads=6
>
> Note: we didn't have enough tests for this to be a problem before.
> But with commit 980ac3ad0512 ("kunit: tool: rename all_test_uml.config,
> use it for --alltests"), --alltests works and thus running >100 tests
> will probably become more common.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

I like it! I do think we'll ultimately want some more options for the
main results display as well (e.g., only display failed tests, limit
the depth of nested results, etc), but this would be useful even then,
as the number of tests displayed could still be large. (And you might
not know what failures you'd be looking for in advance.)

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  tools/testing/kunit/kunit_parser.py    | 47 ++++++++++++++++++++++++++
>  tools/testing/kunit/kunit_tool_test.py | 22 ++++++++++++
>  2 files changed, 69 insertions(+)
>
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> index 1ae873e3e341..94dba66feec5 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -58,6 +58,10 @@ class Test:
>                 self.counts.errors += 1
>                 stdout.print_with_timestamp(stdout.red('[ERROR]') + f' Test: {self.name}: {error_message}')
>
> +       def ok_status(self) -> bool:
> +               """Returns true if the status was ok, i.e. passed or skipped."""
> +               return self.status in (TestStatus.SUCCESS, TestStatus.SKIPPED)
> +
>  class TestStatus(Enum):
>         """An enumeration class to represent the status of a test."""
>         SUCCESS = auto()
> @@ -565,6 +569,40 @@ def print_test_footer(test: Test) -> None:
>         stdout.print_with_timestamp(format_test_divider(message,
>                 len(message) - stdout.color_len()))
>
> +
> +
> +def _summarize_failed_tests(test: Test) -> str:
> +       """Tries to summarize all the failing subtests in `test`."""
> +
> +       def failed_names(test: Test, parent_name: str) -> List[str]:
> +               # Note: we use 'main' internally for the top-level test.
> +               if not parent_name or parent_name == 'main':
> +                       full_name = test.name
> +               else:
> +                       full_name = parent_name + '.' + test.name
> +
> +               if not test.subtests:  # this is a leaf node
> +                       return [full_name]
> +
> +               # If all the children failed, just say this subtest failed.
> +               # Don't summarize it down "the top-level test failed", though.
> +               failed_subtests = [sub for sub in test.subtests if not sub.ok_status()]
> +               if parent_name and len(failed_subtests) ==  len(test.subtests):
> +                       return [full_name]
> +
> +               all_failures = []  # type: List[str]
> +               for t in failed_subtests:
> +                       all_failures.extend(failed_names(t, full_name))
> +               return all_failures
> +
> +       failures = failed_names(test, '')
> +       # If there are too many failures, printing them out will just be noisy.
> +       if len(failures) > 10:  # this is an arbitrary limit
> +               return ''
> +
> +       return 'Failures: ' + ', '.join(failures)
> +
> +
>  def print_summary_line(test: Test) -> None:
>         """
>         Prints summary line of test object. Color of line is dependent on
> @@ -587,6 +625,15 @@ def print_summary_line(test: Test) -> None:
>                 color = stdout.red
>         stdout.print_with_timestamp(color(f'Testing complete. {test.counts}'))
>
> +       # Summarize failures that might have gone off-screen since we had a lot
> +       # of tests (arbitrarily defined as >=100 for now).
> +       if test.ok_status() or test.counts.total() < 100:
> +               return
> +       summarized = _summarize_failed_tests(test)
> +       if not summarized:
> +               return
> +       stdout.print_with_timestamp(color(summarized))
> +
>  # Other methods:
>
>  def bubble_up_test_results(test: Test) -> None:
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index a6e53945656e..7dcd67003b23 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -312,6 +312,28 @@ class KUnitParserTest(unittest.TestCase):
>                                 result.status)
>                         self.assertEqual('kunit-resource-test', result.subtests[0].name)
>
> +       def test_summarize_failures(self):
> +               output = """
> +               KTAP version 1
> +               1..2
> +                       # Subtest: all_failed_suite
> +                       1..2
> +                       not ok 1 - test1
> +                       not ok 2 - test2
> +               not ok 1 - all_failed_suite
> +                       # Subtest: some_failed_suite
> +                       1..2
> +                       ok 1 - test1
> +                       not ok 2 - test2
> +               not ok 1 - some_failed_suite
> +               """
> +               result = kunit_parser.parse_run_tests(output.splitlines())
> +               self.assertEqual(kunit_parser.TestStatus.FAILURE, result.status)
> +
> +               self.assertEqual(kunit_parser._summarize_failed_tests(result),
> +                       'Failures: all_failed_suite, some_failed_suite.test2')
> +
> +
>  def line_stream_from_strs(strs: Iterable[str]) -> kunit_parser.LineStream:
>         return kunit_parser.LineStream(enumerate(strs, start=1))
>
> --
> 2.38.1.273.g43a17bfeac-goog
>

--0000000000000dba0305ec40fa54
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
MDIwAhABj4peqtakTCOMXLZ2mEqRMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBt
dYwIMsOx6ONTjONA36y317px7CBalxm2GpBE2k8VJzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjEwMzAxNDA1MDBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAEYXcumunAyBOg8c8SUt7
wwEpgoVk+X3GKgdyG82peu0XahZeK1CLPvi/OEUGebmYd1klMwsxtEOt6GXBLJ/jH/snJgXZLIRg
XpMz21HD+AQAp9kzcywUGfAysWnA8yKsdDPGGDEkBDL0vEY5tINu4/vVR5Brdbe9NHQlsOwJuZmr
g5++v03k1Wl1PNVYYkecGPNBjDFBsB7GQiP/eA4CsFhfy3zr31BMEKtaYUqY2ds0FVJa7uNX/7ZA
b4bCXF1SCbMt5ed1DnNC2Til4Vi2NZF4n4Fwufyod+LUBBzdckqT8nSgdulAxgZESB5eKtvrqCS2
TXhZrzOwdeGwkuxQGw==
--0000000000000dba0305ec40fa54--
