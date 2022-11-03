Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049FC6176C6
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 07:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiKCGh7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 02:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKCGh6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 02:37:58 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118341704C
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Nov 2022 23:37:58 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id 128so985595vsz.12
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Nov 2022 23:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AqubiIN/A48vKygy2hX58qFSMBIHK7nTJnhDeq9Cjgw=;
        b=cblqQTCYfiSAwa0Uhh0kzlQT3/CA+8H0KBP8dMil4J3AqJ380No+dIHo4VQBEsDc0Z
         UaL0I+dHgrDP1FhuzaAGKnlsmoxtxVcqh2C71jir+ZFlOIF5cGyhxOuAK+CxkMr0oxJb
         Uxsb1Sz5e1OWeF1U+S3ZAnDtivGo09z5yP2zRY3HRdl8M+LaHAmUj24ld6+aQCDa/QvG
         FqikBunqTMoJHsRrtMnBdSDo+gbdXHOoiOAfzQaIe+ZRVrY659BlLnvhS7JG5DWPMcwo
         AlAQeXEYiLWAaLtiALenJvIQXONyCzJUIahG9+0TidT19+/oaG1qnz/DOlxCgqNQGaC9
         wvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AqubiIN/A48vKygy2hX58qFSMBIHK7nTJnhDeq9Cjgw=;
        b=p/Yz+EYVr/uVI1q3W0gX+hXymaw6cwjdVfbNn7FfnFjYheO9W1JZPml9dip9U6isz3
         xqmzm8q3drM8KhYC/EnjBfxCfcxq0Ea0B06LKM3ojQorr2PICcYYKuw/WqAS1jplRCYF
         urftQ5jCYKel2nIeU0FepHJh4lMPSr4yqmPU8fHJb2902mbVt+nhHEwUbC5vBQnPhmGF
         5Ny+OiGGYnvDgT6lGvR7dqeg0to94G0uplNHWkKnLgxInrqEfTpeCDlTmud5VuD3glA8
         r0svGbZ4y3QTaVX9jDnCLx9O2hjoZ5gG8SbgKsHjOki7ulB3kf+DZVkdhKO0oBsVTCfh
         jQ2g==
X-Gm-Message-State: ACrzQf1ac82scwydPKZCzOIIlvwzgtDK6bvM/cyPjCa3IPeUt3Bj4Ko/
        vairp19v2gaGGAgdaptfYfrXvE4Y2FfwafRhQb04jg==
X-Google-Smtp-Source: AMsMyM5eUIcWB+JqmrEkjKB1XhyNcd/evxtRi4UrhRLeA2euVTiR/MaexJl9dBjsAGC9gnTGrMsjgZttwh0FGpM4Xgc=
X-Received: by 2002:a67:b105:0:b0:3ac:39ae:806b with SMTP id
 w5-20020a67b105000000b003ac39ae806bmr16258131vsl.38.1667457477001; Wed, 02
 Nov 2022 23:37:57 -0700 (PDT)
MIME-Version: 1.0
References: <20221102164005.2516646-1-dlatypov@google.com>
In-Reply-To: <20221102164005.2516646-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 3 Nov 2022 14:37:44 +0800
Message-ID: <CABVgOSkPnJ122=4WSWR+3WLiHmGcJnk59pmmnix1GW=Mj8DtTA@mail.gmail.com>
Subject: Re: [PATCH 1/3] kunit: tool: make TestCounts a dataclass
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, rmoar@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000009cdeb905ec8b3208"
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

--0000000000009cdeb905ec8b3208
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 3, 2022 at 12:40 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Since we're using Python 3.7+, we can use dataclasses to tersen the
> code.
>
> It also lets us create pre-populated TestCounts() objects and compare
> them in our unit test. (Before, you could only create empty ones).
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Looks good, thanks.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  tools/testing/kunit/kunit_parser.py    | 25 ++++++++-----------------
>  tools/testing/kunit/kunit_tool_test.py |  4 +---
>  2 files changed, 9 insertions(+), 20 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> index 1ae873e3e341..f022966858f2 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -10,6 +10,7 @@
>  # Author: Rae Moar <rmoar@google.com>
>
>  from __future__ import annotations
> +from dataclasses import dataclass
>  import re
>  import sys
>
> @@ -67,27 +68,17 @@ class TestStatus(Enum):
>         NO_TESTS = auto()
>         FAILURE_TO_PARSE_TESTS = auto()
>
> +@dataclass
>  class TestCounts:
>         """
>         Tracks the counts of statuses of all test cases and any errors within
>         a Test.
> -
> -       Attributes:
> -       passed : int - the number of tests that have passed
> -       failed : int - the number of tests that have failed
> -       crashed : int - the number of tests that have crashed
> -       skipped : int - the number of tests that have skipped
> -       errors : int - the number of errors in the test and subtests
> -       """
> -       def __init__(self):
> -               """Creates TestCounts object with counts of all test
> -               statuses and test errors set to 0.
> -               """
> -               self.passed = 0
> -               self.failed = 0
> -               self.crashed = 0
> -               self.skipped = 0
> -               self.errors = 0
> +       """
> +       passed: int = 0
> +       failed: int = 0
> +       crashed: int = 0
> +       skipped: int = 0
> +       errors: int = 0
>
>         def __str__(self) -> str:
>                 """Returns the string representation of a TestCounts object."""
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index e2cd2cc2e98f..9fa4babb2506 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -179,9 +179,7 @@ class KUnitParserTest(unittest.TestCase):
>                                 kunit_parser.extract_tap_lines(
>                                 file.readlines()))
>                 # A missing test plan is not an error.
> -               self.assertEqual(0, result.counts.errors)
> -               # All tests should be accounted for.
> -               self.assertEqual(10, result.counts.total())
> +               self.assertEqual(result.counts, kunit_parser.TestCounts(passed=10, errors=0))
>                 self.assertEqual(
>                         kunit_parser.TestStatus.SUCCESS,
>                         result.status)
>
> base-commit: 5aaef24b5c6d4246b2cac1be949869fa36577737
> --
> 2.38.1.273.g43a17bfeac-goog
>

--0000000000009cdeb905ec8b3208
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
MDIwAhABj4peqtakTCOMXLZ2mEqRMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAb
GQbpKvL/ligAl5OU5OI0zu6GHVu+98UUWMHKTgIg5TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjExMDMwNjM3NTdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAl48S4t01sHCS3Q88/5VU
eH5iLQSBJTcpEGcmXis5eFJh/hYzaighiC4obun/tE+XxWkIRndr/ptuxF4tvyGBHlqQ0/YUCKX9
enMbRsYe169pPhtM0DHNsvMZlYP2GGqN52sbLEoRFAUMgPgHJ49F3BznOqwT3R0yGw/jAEDkKwHl
dY/mz+tw//r7MeyLtCtqKA00NiJ32MX6QrV8P1Bx4beoEw+fEmWw1zN8Z2Z+AUGJB2dcogTL5AHV
3uK4/5wrdmopzgCX4i26GqSTaOp5JKB3HWNlkH38RGaJCWnZyYmC2q46ylk4bSSw6wFxlFSK6kLz
x9X5s80idirml9H79A==
--0000000000009cdeb905ec8b3208--
