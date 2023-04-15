Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FD06E3010
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Apr 2023 11:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjDOJZ3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Apr 2023 05:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjDOJZ2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Apr 2023 05:25:28 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C930C4223
        for <linux-kselftest@vger.kernel.org>; Sat, 15 Apr 2023 02:25:26 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id q5so11449270wmo.4
        for <linux-kselftest@vger.kernel.org>; Sat, 15 Apr 2023 02:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681550725; x=1684142725;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rOgu+4Kn/lm1fvk0vlEdFJoNQxYHZ+nrA2J2gzwIs/M=;
        b=oyENweAuNRu5fqhK2lpcBibUXc/CitrONBX0eXUF3mvLJzTPYiUc65oM1pVUaJ/JV7
         CWqxz3SJSzcSRuLBiVZ/tq8E1JeTgCrEGmTyIfPCPUILaU5CJl6srzJeQozezRbXLdow
         gpT5q+3Q5vmremC4GKSZS8k+QyFzF284WZ69ojAUGz71DwifTSYxzJssZhw/+7j+ID4U
         CuTZYMygodZ9xdtSviigQegZ39rmpatR75F8KIrL6aY2MTjf3ei4WAcEYEXdsOa+nPh4
         z+QGSJkFg+BJYcSJma9t63bWr0xEXZY7/9aTYaRUXZyD+L12+V7J7iV3QyWVGiHwY4xn
         /xHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681550725; x=1684142725;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rOgu+4Kn/lm1fvk0vlEdFJoNQxYHZ+nrA2J2gzwIs/M=;
        b=QEP/6FPEWOzus5Vv5dmRBzfEBBUa4uOdF3gv4Z2owFPSOKXwFpQ34FZaWqJfSBY+nY
         Jw6gbtbh/Xs+lqJPf0fZDxFwdtZalrMkHJjhdD5a0mThUdWlMGknLji1WIwCkD1Yunvp
         0VjQYwKn6FOTGQO2Yr+iwtWoYGii7LQ46thUkhzaj71dFkugX9rt6qb2e4usiX6ug/H2
         vE9ighYoAXaUWXLiejkm+eAOkgQmcdRMyQka3fZzctkQEnKT2zMlgI3x6ldBo7xdeNKZ
         gx35lQVvSJ8ybfdukliqnglr9KRAtXVdYXd13wj//IZ08YzPydlFe4tgWJhkCfHPPeZg
         UnHQ==
X-Gm-Message-State: AAQBX9deVv6bwprRx/00JAsSSbznNnMPg89mnMzvW0IFSyawZcp8ghd+
        MKmW+xS+ldpX+69t2gnNt39qIEKHmJLlLgBf1inncA==
X-Google-Smtp-Source: AKy350YzAcnA5PE3Rwr8xENXNHQp8rDYqsKmyR22MfQJqZCWg8gJrSmz6pjSej/mQ35AAyDB3N2Ax3qXpGw8rgT5HqM=
X-Received: by 2002:a05:600c:210d:b0:3f1:6faa:1944 with SMTP id
 u13-20020a05600c210d00b003f16faa1944mr25175wml.3.1681550725122; Sat, 15 Apr
 2023 02:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230414152737.1630-1-michal.wajdeczko@intel.com> <20230414152737.1630-4-michal.wajdeczko@intel.com>
In-Reply-To: <20230414152737.1630-4-michal.wajdeczko@intel.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 15 Apr 2023 17:25:12 +0800
Message-ID: <CABVgOSkDW41kG7HaM3Ghi9puS52mBzDV1+Cy1fAY7-OKvmGdnA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] kunit: Update kunit_print_ok_not_ok function
To:     Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Rae Moar <rmoar@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000ab6b9305f95c8998"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--000000000000ab6b9305f95c8998
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Apr 2023 at 23:28, Michal Wajdeczko
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

From a quick glance, this looks pretty good to me, thanks.

It'll need rebasing on top of the kselftest/kunit[1] tree: there are
some conflicts with the debugfs fixes.

I can do that if you'd prefer: I'll need to do so before giving it a
more thorough review next week.

Cheers,
-- David

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=kunit
>  include/kunit/test.h |  1 +
>  lib/kunit/test.c     | 45 +++++++++++++++++++++++++++-----------------
>  2 files changed, 29 insertions(+), 17 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 08d3559dd703..5e5af167e7f8 100644
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
> index 5679197b5f8a..ca636c9f793c 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -154,16 +154,28 @@ static void kunit_print_suite_start(struct kunit_suite *suite)
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
> @@ -173,17 +185,18 @@ static void kunit_print_ok_not_ok(void *test_or_suite,
>          * separately seq_printf() the suite status for the debugfs
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
> @@ -209,7 +222,7 @@ static size_t kunit_suite_counter = 1;
>
>  static void kunit_print_suite_end(struct kunit_suite *suite)
>  {
> -       kunit_print_ok_not_ok((void *)suite, false,
> +       kunit_print_ok_not_ok(NULL, KUNIT_LEVEL_SUITE,
>                               kunit_suite_has_succeeded(suite),
>                               kunit_suite_counter++,
>                               suite->name,
> @@ -554,13 +567,11 @@ int kunit_run_tests(struct kunit_suite *suite)
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
> @@ -574,7 +585,7 @@ int kunit_run_tests(struct kunit_suite *suite)
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

--000000000000ab6b9305f95c8998
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
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAM
t9v+Hn2u0KVF+obcEAz0EVQtT8ju3yMdNvu93kRybjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA0MTUwOTI1MjVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAVXTOOjlHkL1BBz0tXk2i
gUo9nsDc/Ixqw6JpSsdhcOqrRGKfh+x7qaJN1UHfzIk6vHQADjM3qtt0fNjO1HvZxYNshLt3Ssh2
D7foPPWxOJtwS8lfvAPuLtrR6xphyQ1jTAyV32njB+qmJ4O1c96vei/xUyHEnGrgqhTEiOfsVxtq
5PG9WBNlHusvFxvqR4tueXTYnaibjAi76PNJ6IOuqObcqQwJ33OB+IMqQcJOMeafCsHWz/O1hPBp
j7zst7X8HVMoYaM+vpPLmhvWc+b4TVhBLrEvjGr+dxxETBDbCCW4xs8enbhFiY1KMB48HOSvFVKr
i3EmZKPNlmvENc8aKQ==
--000000000000ab6b9305f95c8998--
