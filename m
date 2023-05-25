Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FEB711AAC
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 May 2023 01:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjEYXaa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 May 2023 19:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbjEYXa3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 May 2023 19:30:29 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A003119
        for <linux-kselftest@vger.kernel.org>; Thu, 25 May 2023 16:30:27 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-33164ec77ccso58725ab.0
        for <linux-kselftest@vger.kernel.org>; Thu, 25 May 2023 16:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685057427; x=1687649427;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4/gvj957+vHh0HO+ZMY38hJH9AL09d+Ox9tRjqfJjh4=;
        b=nm6GBkydzD7nr/1GCL98MTRLAeM1wbpuy7+l6I7QYtufYil7yJnR/baAeWQlRJpGr5
         UNX88I0khdWPpn3QHWXJRuB71u9hVJ7S+NJCpQKGxPUKeK7jO9j+qb3In6nPhCpiG/7a
         7HcM5fWiyLYs5oAoFc5wgim1gY50x6Oqwsh+biKwhy5XEfVgDFd3ww/+RKxuUpr0/y5S
         xi6ZrOiJAbNjjQ1U3nmxxUdXS6UQGefbzinzKQerCzxVPS93LYXjHgJEDuojkc96dTdi
         JiZS3yU/5PffVKYmpakTFLWorTUQjwYmoRgX2abJS/IGS21is52YeppbuNZawNHDGDi5
         nRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685057427; x=1687649427;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4/gvj957+vHh0HO+ZMY38hJH9AL09d+Ox9tRjqfJjh4=;
        b=kOWBqH6Qpii1CG+RBUC1xEY3OjjnCr70/9aYKLvRNaXw8794tnLzePzHJReQhWesGL
         PXiI/IpW6nONCrmwyji2gIc74+1WkA2Mrk5SXDukjLlmCq41T5Bx1yBK9V9JKBORpesl
         UR1jzCpdkHULk04XeTB8YCYTm++CA/RrDsIyFe+Lp0jLX8ewCsOsgdITRm59YQB+MeRH
         En2DfcbOY6k/c0GdWrpgfp4mlVVOKoG0UNpyrDRTzcx3op7wVXIJSntEz9AOjJHG/sHt
         vlmHud/D/JDvqV9QhDeV/Hu9NsUl5/vln7SKMbs96cwA+Mb2FNsahIsrpW8JhioYtwsp
         GFEw==
X-Gm-Message-State: AC+VfDx5oqWqU81OaEtHa0JyXm4U57Mzq5zx0/X3Yxf7LR9PowzxoWv5
        kofrUvMbfuR6X19Vz6w/yEgITxO9zCixBupiPxkikLk1W8M3X4VaGfEezw==
X-Google-Smtp-Source: ACHHUZ5mJG4LtnXSJe9zSN3qODBVhhH/gFaxY1w9iFLVjtPSsdD5eRilXK6JYNBAALtvWms6jaA3I/fdbVEqHqOf35o=
X-Received: by 2002:a05:6e02:b4e:b0:331:2623:c5f4 with SMTP id
 f14-20020a056e020b4e00b003312623c5f4mr4130ilu.1.1685057426723; Thu, 25 May
 2023 16:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230517111816.984-1-michal.wajdeczko@intel.com> <20230517111816.984-4-michal.wajdeczko@intel.com>
In-Reply-To: <20230517111816.984-4-michal.wajdeczko@intel.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 26 May 2023 07:30:13 +0800
Message-ID: <CABVgOSnHe7GTQC-cacozwQoSsj6bKsc2n3OXfvhT_R7JuCnEAg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] kunit: Update kunit_print_ok_not_ok function
To:     Michal Wajdeczko <michal.wajdeczko@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000604ec705fc8d01c9"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--000000000000604ec705fc8d01c9
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 May 2023 at 19:20, Michal Wajdeczko
<michal.wajdeczko@intel.com> wrote:
>
> There is no need use opaque test_or_suite pointer and is_test flag
> as we don't use anything from the suite struct. Always expect test
> pointer and use NULL as indication that provided results are from
> the suite so we can treat them differently.
>
> Since results could be from nested tests, like parameterized tests,
> add explicit level parameter to properly indent output messages and
> thus allow to reuse this function from other places.
>
> While around, remove small code duplication near skip directive.
>
> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> ---

This looks good to me, thanks.

As a note, this seems to trigger a bug in checkpatch.pl:
substr outside of string at ./scripts/checkpatch.pl line 1664.
Use of uninitialized value $fmt in substitution (s///) at
./scripts/checkpatch.pl line 6899.
Use of uninitialized value $fmt in pattern match (m//) at
./scripts/checkpatch.pl line 6901.

I haven't dug into that myself, yet (it's something to do with format
strings), but I don't think we need to change this patch to work
around it.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  include/kunit/test.h |  1 +
>  lib/kunit/test.c     | 45 +++++++++++++++++++++++++++-----------------
>  2 files changed, 29 insertions(+), 17 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 3028a1a3fcad..d717fc055e06 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -47,6 +47,7 @@ struct kunit;
>   * sub-subtest.  See the "Subtests" section in
>   * https://node-tap.org/tap-protocol/
>   */
> +#define KUNIT_INDENT_LEN               4
>  #define KUNIT_SUBTEST_INDENT           "    "
>  #define KUNIT_SUBSUBTEST_INDENT                "        "
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index af48d0761d26..6bc92ced82ee 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -185,16 +185,28 @@ static void kunit_print_suite_start(struct kunit_suite *suite)
>                   kunit_suite_num_test_cases(suite));
>  }
>
> -static void kunit_print_ok_not_ok(void *test_or_suite,
> -                                 bool is_test,
> +/* Currently supported test levels */
> +enum {
> +       KUNIT_LEVEL_SUITE = 0,
> +       KUNIT_LEVEL_CASE,
> +       KUNIT_LEVEL_CASE_PARAM,
> +};
> +
> +static void kunit_print_ok_not_ok(struct kunit *test,
> +                                 unsigned int test_level,
>                                   enum kunit_status status,
>                                   size_t test_number,
>                                   const char *description,
>                                   const char *directive)
>  {
> -       struct kunit_suite *suite = is_test ? NULL : test_or_suite;
> -       struct kunit *test = is_test ? test_or_suite : NULL;
>         const char *directive_header = (status == KUNIT_SKIPPED) ? " # SKIP " : "";
> +       const char *directive_body = (status == KUNIT_SKIPPED) ? directive : "";
> +
> +       /*
> +        * When test is NULL assume that results are from the suite
> +        * and today suite results are expected at level 0 only.
> +        */
> +       WARN(!test && test_level, "suite test level can't be %u!\n", test_level);
>
>         /*
>          * We do not log the test suite results as doing so would
> @@ -203,17 +215,18 @@ static void kunit_print_ok_not_ok(void *test_or_suite,
>          * separately seq_printf() the suite results for the debugfs
>          * representation.
>          */
> -       if (suite)
> +       if (!test)
>                 pr_info("%s %zd %s%s%s\n",
>                         kunit_status_to_ok_not_ok(status),
>                         test_number, description, directive_header,
> -                       (status == KUNIT_SKIPPED) ? directive : "");
> +                       directive_body);
>         else
>                 kunit_log(KERN_INFO, test,
> -                         KUNIT_SUBTEST_INDENT "%s %zd %s%s%s",
> +                         "%*s%s %zd %s%s%s",
> +                         KUNIT_INDENT_LEN * test_level, "",
>                           kunit_status_to_ok_not_ok(status),
>                           test_number, description, directive_header,
> -                         (status == KUNIT_SKIPPED) ? directive : "");
> +                         directive_body);
>  }
>
>  enum kunit_status kunit_suite_has_succeeded(struct kunit_suite *suite)
> @@ -239,7 +252,7 @@ static size_t kunit_suite_counter = 1;
>
>  static void kunit_print_suite_end(struct kunit_suite *suite)
>  {
> -       kunit_print_ok_not_ok((void *)suite, false,
> +       kunit_print_ok_not_ok(NULL, KUNIT_LEVEL_SUITE,
>                               kunit_suite_has_succeeded(suite),
>                               kunit_suite_counter++,
>                               suite->name,
> @@ -625,13 +638,11 @@ int kunit_run_tests(struct kunit_suite *suite)
>                                                  "param-%d", test.param_index);
>                                 }
>
> -                               kunit_log(KERN_INFO, &test,
> -                                         KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
> -                                         "%s %d %s%s%s",
> -                                         kunit_status_to_ok_not_ok(test.status),
> -                                         test.param_index + 1, param_desc,
> -                                         test.status == KUNIT_SKIPPED ? " # SKIP " : "",
> -                                         test.status == KUNIT_SKIPPED ? test.status_comment : "");
> +                               kunit_print_ok_not_ok(&test, KUNIT_LEVEL_CASE_PARAM,
> +                                                     test.status,
> +                                                     test.param_index + 1,
> +                                                     param_desc,
> +                                                     test.status_comment);
>
>                                 /* Get next param. */
>                                 param_desc[0] = '\0';
> @@ -645,7 +656,7 @@ int kunit_run_tests(struct kunit_suite *suite)
>
>                 kunit_print_test_stats(&test, param_stats);
>
> -               kunit_print_ok_not_ok(&test, true, test_case->status,
> +               kunit_print_ok_not_ok(&test, KUNIT_LEVEL_CASE, test_case->status,
>                                       kunit_test_case_num(suite, test_case),
>                                       test_case->name,
>                                       test.status_comment);
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20230517111816.984-4-michal.wajdeczko%40intel.com.

--000000000000604ec705fc8d01c9
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
9IGQSBx2i4m+hGXJpET+MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQCRI3Z4cAidgFcv
Usqdz765x6KMZSfg/WtFrYg8ewsP2NpCxVM2+EhPyyEQ0k0DhtzdtGoI/Ug+jdFDyCKB9P2+EPLh
iMjMnFILp7Zs4r18ECHlvZuDZfH9m0BchXIxu5jLIuQyKUWrCRDZZEDNr510ZhhVfYSFPA8ms1nk
jyzYFOHYQyv5IfML/3IBFKlON5OZa+V8EZYULYcNkp03DdWglafj7SXZ1/XgAbVYrC381UvrsYN8
jndVvoa1GWwe+NVlIIK7Q3uAjV3qLEDQpaNPg1rr0oAn6YmvTccjVMqj2YNwN+RHhKNzgRGxY5ct
FaN+8fXZhRhpv3bVbAWuPZXoMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBD
QR5OT7saYp/TusfFjcKQZf5/GMKBNjMD83QmUaehgjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA1MjUyMzMwMjdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAl7anzK7ym26+DseILfyq
GIWyNsvClZZkwIp+DBVZ8fNuH4Xv1mpYTYjBS4jLMCoBZEyx7X1onPuKy349zlVKdA7ajzXdabwe
nsCnoxPw8dXrFLE2mlyFCcu1AFtkkBmR1C4gMUh5Eup5uRwf28pf66CgkNJKg23PDDvnppq9QTIm
vBOntDJbw/z39YM7f3mf6Wuh0k/zgaQd/ncR+XzU47M/Pcgm/hK/eugH/Gb5EBd1683Deyi6pERY
O6f0u08l7oGEWos3XYS6edK4sRtP/v4lQdB5ghr83ZErNi1a3B7CQ33y1fTDV11IjCSaFmnm1oWH
ECL06JsQdH9uvd6urA==
--000000000000604ec705fc8d01c9--
