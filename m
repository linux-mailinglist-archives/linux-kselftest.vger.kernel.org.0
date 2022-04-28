Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA64512C70
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Apr 2022 09:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244909AbiD1HPF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Apr 2022 03:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244926AbiD1HPE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Apr 2022 03:15:04 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657738BF18
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Apr 2022 00:11:50 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id y21so2381240wmi.2
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Apr 2022 00:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cotdj2WLYzpav7aQPE3G/TQO9fuCIUB8/WFzIctoeIM=;
        b=A7HI/q5ib8AmTAdcCk/pG/dwxZEi/cmzmtXx8CAtTVHk4Cd2M6s3z77P1MOSTzkhHE
         IxY+sQlrQDM9y0EaW8gFR8Vyz7eDMsqJ4AOsP5Lbw5235hp/a2wwEQmc+lZjLpieJiXP
         V9gna0RKahIdgK/OFy2xXPM9Yfa5/D+NOp24S8NIBwAsRNn7sAe+ldLIiN0D5gmoBFzi
         hj7f1V6C0/T4uqJDxWOy90eJrnTQQ67x7UjzpnM7bJSqIcNRQR0OIW5KTZquRIZIoVpg
         MjwFYqwYZsc+5Qy97C6y2+pWZjzDpnP/82yhf8A5t5Lzc4mAMbhV2+GEMq1S3hITpi06
         r0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cotdj2WLYzpav7aQPE3G/TQO9fuCIUB8/WFzIctoeIM=;
        b=BrWCiCwQ2+azVYF2J4RMyPzxKLmFTS3QkGfCtlHjWQaaFVPi35phs30ybjQPQVmo43
         RxdVfSey/fa+zkx1zt6YDTEEcNfhGl4ugdrfPzlsO9et9xNS7Ndod0439BTWv87+NqN/
         4em9nvoEYMPYzFWxUyG8Eb5YkEIKWoYvcprX4yjWwSfzLMYtuZkNfg2Ou5yZBGyxKnyX
         rB8pAqFVTOqbrOYWYIZhcmG7j3AGCHFUuTKhXqa9SF/cFiHwN9w3t2T0OD05RUTMyfpU
         TxRQGToO6Oee56NIp4rpX85c+9ChR26RtSnOgT3SgLdU5m6yMHw4rMUS7/kAW4GFZ2ZJ
         YaCw==
X-Gm-Message-State: AOAM532tDRz/dl+FmQ04UDXiCrvRzqoY/89yDeSlgFFynGSoz/sxH+X5
        93zk747vvLKrP7bhDXCLjGoitgZG9bN40dIeXJeNGA==
X-Google-Smtp-Source: ABdhPJz8slxP9hNuI4Yug2XNWSpy8fuGYD55YLAmBZquO8R5anURZj/W5bggTGm5hdhp1TI/e1v3/vzs6soGDZm0f3g=
X-Received: by 2002:a05:600c:601d:b0:393:fbe9:3596 with SMTP id
 az29-20020a05600c601d00b00393fbe93596mr9587504wmb.141.1651129908928; Thu, 28
 Apr 2022 00:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220426173334.3871399-1-dlatypov@google.com> <20220426173334.3871399-2-dlatypov@google.com>
In-Reply-To: <20220426173334.3871399-2-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 28 Apr 2022 15:11:37 +0800
Message-ID: <CABVgOSnQUE1e9dQg-5R+Lk=_H08c-B_doCswrhcWOWi_-fj5Mw@mail.gmail.com>
Subject: Re: [PATCH 2/3] kunit: tool: make parser stop overwriting status of
 suites w/ no_tests
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000b7473005ddb1a35d"
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

--000000000000b7473005ddb1a35d
Content-Type: text/plain; charset="UTF-8"

On Wed, Apr 27, 2022 at 1:33 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Consider this invocation
> $ ./tools/testing/kunit/kunit.py parse <<EOF
>   TAP version 14
>   1..2
>   ok 1 - suite
>     # Subtest: no_tests_suite
>     # catastrophic error!
>   not ok 1 - no_tests_suite
> EOF
>
> It will have a 0 exit code even though there's a "not ok".
>
> Consider this one:
> $ ./tools/testing/kunit/kunit.py parse <<EOF
>   TAP version 14
>   1..2
>   ok 1 - suite
>   not ok 1 - no_tests_suite
> EOF
>
> It will a non-zero exit code.
>
> Why?
> We have this line in the kunit_parser.py
> > parent_test = parse_test_header(lines, test)
> where we have special handling when we see "# Subtest" and we ignore the
> explicit reported "not ok 1" status!
>
> Also, NO_TESTS at a suite-level only results in a non-zero status code
> where then there's only one suite atm.
>
> This change is the minimal one to make sure we don't overwrite it.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

This seems sensible to me, though it doesn't change a lot in practice
given that the in-kernel KUnit will mark empty suites as skipped:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/kunit/test.c#n180

(And I think that is probably the correct thing for it to do, as "no
tests run" seems closer to skipped than to passed or failed, which are
the other options KTAP gives us.)

That being said, it's definitely true that we don't want to override a
"not ok" needlessly in kunit_tool, so this patch is definite
improvement.

Reviewed-by: David Gow <davidgow@google.com>


-- David

>  tools/testing/kunit/kunit_parser.py                        | 7 +++++--
>  .../test_data/test_is_test_passed-no_tests_no_plan.log     | 2 +-
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> index 7a0faf527a98..45c2c5837281 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -775,8 +775,11 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
>
>         # Check for there being no tests
>         if parent_test and len(subtests) == 0:
> -               test.status = TestStatus.NO_TESTS
> -               test.add_error('0 tests run!')
> +               # Don't override a bad status if this test had one reported.
> +               # Assumption: no subtests means CRASHED is from Test.__init__()
> +               if test.status in (TestStatus.TEST_CRASHED, TestStatus.SUCCESS):
> +                       test.status = TestStatus.NO_TESTS
> +                       test.add_error('0 tests run!')
>
>         # Add statuses to TestCounts attribute in Test object
>         bubble_up_test_results(test)
> diff --git a/tools/testing/kunit/test_data/test_is_test_passed-no_tests_no_plan.log b/tools/testing/kunit/test_data/test_is_test_passed-no_tests_no_plan.log
> index dd873c981108..4f81876ee6f1 100644
> --- a/tools/testing/kunit/test_data/test_is_test_passed-no_tests_no_plan.log
> +++ b/tools/testing/kunit/test_data/test_is_test_passed-no_tests_no_plan.log
> @@ -3,5 +3,5 @@ TAP version 14
>    # Subtest: suite
>    1..1
>      # Subtest: case
> -  ok 1 - case # SKIP
> +  ok 1 - case
>  ok 1 - suite
> --
> 2.36.0.rc2.479.g8af0fa9b8e-goog
>

--000000000000b7473005ddb1a35d
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
MDIwAhABQeVybOOpR4bOOXZYL5T3MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCD+
Ax5MEIABPmvQLI/04sQu3tUfo4u2Sw7zMYLJNnAC7DAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA0MjgwNzExNDlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAOwD4W2tP7vZeKc1AQR4t
XhoElD2Zd+L2MzA07d4ySAwBdCPJx9376DIjaqxXhEAP6EKlKPakdxh3fpbibfHTKjZAS/Zl75uj
spHMSo2Ky/ndAS1UbBGQRQI8DeKnUDKJyBxKDown7wpnxwXJRPz3yoqRaHDI9MCJx0aqIQPEMfbe
mrpOlX+X0uZI2eLAK1ETSwypteAD/IMowmiqbCWpqKCJHN7Mgsv2/cMr7y3jU298ithF82fK4+KJ
xAuqHIfD9VJKDz2k6NDe3FHK2KL15n839t3CHptbzSxsV+UqrRDBespZLrq0ywNELY2+bCchbQmz
JpQUFoaI6mJ1i38PmQ==
--000000000000b7473005ddb1a35d--
