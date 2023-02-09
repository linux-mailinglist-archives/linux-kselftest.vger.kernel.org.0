Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0445B68FF9E
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 06:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjBIFGc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 00:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjBIFG1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 00:06:27 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2279E2367C
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Feb 2023 21:06:26 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id bg26so661126wmb.0
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Feb 2023 21:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wnjLIcHzh6w7bmU85C5blkZ1yA+Qero1yt6xkV6EF6Q=;
        b=F2zmEwvcs+EkhlVHw1aFcGVElxRZcRdwS+sa4j9s9UIHbaJnLIvcmnRD8zifOQ14R5
         l60YO4Jk15aC6S3p/IG+roEfg1mTm7f0u4A7Jx9o7QpuKzByX2W2kg7ELhGGwjhqadtq
         vpSgbs0JJFMGTVZmM0jKpW1zOwJ3DRnGViUnAXydlHtma+wX4ysRhWXsi3fBALo/LXF1
         iHqZFhX1kIPnPaR3A1aIFaA8kcqQrIGWqsm7fz6KYHxFl7B7JgW7o7cZek+4KKDkJUlN
         hH0CbhfbcRyfS4xRCoZX2UgIgqAe0WZNy1ALRO8x3mQT1RE71kNWP4HAIn2JsnByRa+4
         6BYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wnjLIcHzh6w7bmU85C5blkZ1yA+Qero1yt6xkV6EF6Q=;
        b=kJfqcuiCJMSlntYhzIYyXcIaKqrdnLbHTRmnAQYUyeeXdyJGb8hwOAau3KDesSlaUY
         bWO0j1g5W7Gs/0xkCma2bahpkGSa3GJ/RO5fluzHU7qdFEA/vxELiI91UK8yLcwc7JTw
         61QVOmtunVOCDnVOAZLwndynyrLMcnKba8REQRiQQ5ToK3vSUMohf+KgL+I3+TxsNU6e
         2gHL9aAAdSqI39RfLKoiZ7Ft2IRz0hrv5PpFO/caLAkXdeRp8WdEM4Meo7A8iNqQoy29
         kKtF0miY4N6g1Gp+EnxKRWgKLoZIoq81GYLWnkFprl+R90cyohAfCPu6/zFipKX0U46m
         1I1g==
X-Gm-Message-State: AO0yUKWhnJWP1TC20zKyZXCubXrfXhaM/eE/DqjnlEcavnlOkSMOZKC3
        JtWrL+V+nQ/gdGC3lUoYWnBrQcbenuXYOm42FkQ99g==
X-Google-Smtp-Source: AK7set8V06jYzrBH8asXuf2TNXXBgYAT2tsP7SXgmOb/GXUJbFycagJ2XrIa8ST7zxnVFmB2rCNr2V3Cm7Wsi2gSGAQ=
X-Received: by 2002:a05:600c:a386:b0:3e1:2ab:81de with SMTP id
 hn6-20020a05600ca38600b003e102ab81demr576224wmb.85.1675919184617; Wed, 08 Feb
 2023 21:06:24 -0800 (PST)
MIME-Version: 1.0
References: <20230131220355.1603527-1-rmoar@google.com> <20230131220355.1603527-3-rmoar@google.com>
In-Reply-To: <20230131220355.1603527-3-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 9 Feb 2023 13:06:10 +0800
Message-ID: <CABVgOSk_jWzywAKASy1U2mQOC=SM_TDt753VyF1hUtwWzoszPw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] kunit: fix bug in the order of lines in debugfs logs
To:     Rae Moar <rmoar@google.com>
Cc:     brendanhiggins@google.com, dlatypov@google.com,
        skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000b02c1805f43d579a"
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

--000000000000b02c1805f43d579a
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Feb 2023 at 06:04, Rae Moar <rmoar@google.com> wrote:
>
> Fix bug in debugfs logs that causes an incorrect order of lines in the
> debugfs log.
>
> Currently, any suite diagnostic lines, including the test counts lines
> that show the number of tests passed, failed, and skipped,
> appear prior to the individual results, which is a bug.
>
> Ensure the order of printing for the debugfs log is correct.
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---

I think this is overall an improvement, but there are a few remaining
issues (some new, some old).

First, as with the previous patches, could we have a before/after
comparison in the commit description?

Secondly, I think it'd be nice to either add an extra KTAP header to
the start, so that each debugfs results file is a valid KTAP document
by itself, or at least document that you'll need to prepend one for
this to work.
I'm personally leaning towards the latter, even if it loses us the
ability to just concatenate result files together, because of the
third issue below.

Finally, with this patch, the final result line's suite number is
recorded from its initial run, rather than always being '1'. This
means that if multiple suites are run (e.g. list-test.ko), then the
result file could contain a single suite, with "ok 2 ..." or similar
as a result line. This might help a bit if we were concatenating
result files, but otherwise leaves us with a parse error due to the
mismatched number.

Personally, I'd prefer we change those to always use suite number 1,
and to add the KTAP header to the start. Adding the header should be
easy, the suite number perhaps less so...

Cheers,
-- David

>  lib/kunit/debugfs.c | 13 ++++++++-----
>  lib/kunit/test.c    | 24 ++++++++++++------------
>  2 files changed, 20 insertions(+), 17 deletions(-)
>
> diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
> index de0ee2e03ed6..fbc645590701 100644
> --- a/lib/kunit/debugfs.c
> +++ b/lib/kunit/debugfs.c
> @@ -52,19 +52,22 @@ static void debugfs_print_result(struct seq_file *seq,
>  static int debugfs_print_results(struct seq_file *seq, void *v)
>  {
>         struct kunit_suite *suite = (struct kunit_suite *)seq->private;
> -       enum kunit_status success = kunit_suite_has_succeeded(suite);
>         struct kunit_case *test_case;
>
> -       if (!suite || !suite->log)
> +       if (!suite)
>                 return 0;
>
> -       seq_printf(seq, "%s", suite->log);
> +       /* Print suite header because it is not stored in the test logs. */
> +       seq_puts(seq, KUNIT_SUBTEST_INDENT "KTAP version 1\n");

We probably want to print this twice, once without the indent, to
start the whole document, once with it.

> +       seq_printf(seq, KUNIT_SUBTEST_INDENT "# Subtest: %s\n", suite->name);
> +       seq_printf(seq, KUNIT_SUBTEST_INDENT "1..%zd\n", kunit_suite_num_test_cases(suite));
>
>         kunit_suite_for_each_test_case(suite, test_case)
>                 debugfs_print_result(seq, suite, test_case);
>
> -       seq_printf(seq, "%s %d %s\n",
> -                  kunit_status_to_ok_not_ok(success), 1, suite->name);

We probably still want to output the suite number as '1'...

> +       if (suite->log)
> +               seq_printf(seq, "%s", suite->log);
> +
>         return 0;
>  }
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 66ba93b8222c..27763f0b420c 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -147,10 +147,18 @@ EXPORT_SYMBOL_GPL(kunit_suite_num_test_cases);
>
>  static void kunit_print_suite_start(struct kunit_suite *suite)
>  {
> -       kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "KTAP version 1\n");
> -       kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "# Subtest: %s",
> +       /*
> +        * We do not log the test suite header as doing so would
> +        * mean debugfs display would consist of the test suite
> +        * header prior to individual test results.
> +        * Hence directly printk the suite status, and we will
> +        * separately seq_printf() the suite header for the debugfs
> +        * representation.
> +        */
> +       pr_info(KUNIT_SUBTEST_INDENT "KTAP version 1\n");
> +       pr_info(KUNIT_SUBTEST_INDENT "# Subtest: %s",
>                   suite->name);
> -       kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "1..%zd",
> +       pr_info(KUNIT_SUBTEST_INDENT "1..%zd",
>                   kunit_suite_num_test_cases(suite));
>  }
>
> @@ -165,16 +173,8 @@ static void kunit_print_ok_not_ok(void *test_or_suite,
>         struct kunit *test = is_test ? test_or_suite : NULL;
>         const char *directive_header = (status == KUNIT_SKIPPED) ? " # SKIP " : "";
>
> -       /*
> -        * We do not log the test suite results as doing so would
> -        * mean debugfs display would consist of the test suite
> -        * description and status prior to individual test results.
> -        * Hence directly printk the suite status, and we will
> -        * separately seq_printf() the suite status for the debugfs
> -        * representation.
> -        */
>         if (suite)
> -               pr_info("%s %zd %s%s%s\n",
> +               kunit_log(KERN_INFO, suite, "%s %zd %s%s%s\n",

Changing this breaks the code to ensure the suite number is always '1'...


>                         kunit_status_to_ok_not_ok(status),
>                         test_number, description, directive_header,
>                         (status == KUNIT_SKIPPED) ? directive : "");
> --
> 2.39.1.456.gfc5497dd1b-goog
>

--000000000000b02c1805f43d579a
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
64VRg2IjDI2fJVE9RD6aMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQA2lZLYRLu7foeR
cHo1VeNA974FZBiCm08Kd44/aCMEzdTJvxAE9xbUJf7hS1i6eW49qxuSp3/YLn6U7uatwAcmZcwp
Zma19ftf3LH+9Hvffk+X8fbPKe6uHkJhR2LktrhRzF159jj67NvXyGQv8J4n7UNeEVP0d5ByvRwv
tF2bJwlOwRGLoxasKSyDHIyUpwTfWYPq7XvjoGqQ/tDS7Khcc5WncJl0/ZEj7EKjtoGbsDbLdXEF
m/6vdcYKJzF9ghHewtV3YIU4RE3pEM4aCWWRtJwbExzeue6fI7RqURbNCAyQuSpWv0YQvzsX3ZX3
c1otrs50n1N0Sf8/rfJxq7sWMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBE
3ETTshVdeDJcOYd9SnFjMKUZwO0XgQTLrgXJu6fcRTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAyMDkwNTA2MjRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAgmj43lDDkmGs4ECC/5tD
EaAIrB817iR1DqFJ5Vk6SANjhb/UDJGJ1EXFTiWci1P2k+OMUwtbMmq72gPIbPHBogaBtuXeA+GI
yu1K18tP104PfXDAhjgOV/nokune1/u/RRwQB/mzreTQ/SRJv+sCPAQlR3mFqyO0X2FFv/2hOdu0
+sbtjCF5mnp+3B3XEyrimYIPeXA7rxJiWRRdP9tbRBJqGX/DcGHgcxq1kb5AvYNPOrPr286MXJbS
tuzgOQvpQuBe7uXIHl6xgoqz6hV5TmbgqxiM6t9nbeohC1uifTmo7kqLXS9gP/S9XmN95tnnwY47
xFSvhwNUGCNXJspxCQ==
--000000000000b02c1805f43d579a--
