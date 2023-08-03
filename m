Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E2076F5D6
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 00:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbjHCWq5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 18:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbjHCWpt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 18:45:49 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0889E2129
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Aug 2023 15:45:47 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe32ec7201so15705e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Aug 2023 15:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691102745; x=1691707545;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TyJt2lSUmMO3OJ2k3/3u5PRPTjSeHbCnS5RMZYTuA+Q=;
        b=BIzP2Fjoyeb0X9L9s8Y5uJPPEVOtvo4T1EYci5Nb4QE3ps0ktlNI/KlUAGeHM60JVM
         3/tQmgjc+r57aQFjrAtpPeK16QW8QY0fyxlUyjjEceKBbHsMypWAmonO5MTQvplbORo7
         RXkaCDO0pcZhW0vC/bQPeGrrQP21v4DTQ8YyPgrXTfCsnma68V2Aaa5+fOYNn7tXUXL0
         JQ36WZ2jNSWgSUtgcSfXP/OmiDyiSQhqCzRbJxhYLUXiPe1+sGQhx0NosGLtUDccND0x
         y58GDiVEuCZvKKSyVfvxjkIRXRSZKQZHJZgz+kJaY+rgwp/kdO+N1laRBWrvKhGdXpVd
         2Hng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691102745; x=1691707545;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TyJt2lSUmMO3OJ2k3/3u5PRPTjSeHbCnS5RMZYTuA+Q=;
        b=B717V6p/pDsxhwHAYDX2q3lpY5lYSO9e2VrAwZz/WHfxGVezURtjlNxfUhZl/yWwM9
         xZEuZKu7lcKUZ6frHoF15H3TxRcIiNErsy3TLHoMEJojpVwtgbYO6GMWqKeeLbQ39s1q
         /qByMI8LXaCii4A0jBUvXNqtzM5dAsxHTTDAjt3Rtm/7geGHMB0mjorWvXWGDJiC4ZtP
         eazWoDXWrmNpJQm123Q7huvbZxTMwKWCzQI36lXBHE6JK/HelWjoxOYgY+Qs5X31poBl
         i3XHKg7mZBcJJfqB3BASAv36LzlrBnMUlFPRbuQggZG6no/tJeoGNxAak/87cWD32qCy
         CfPw==
X-Gm-Message-State: AOJu0Yz7s33i9F8G7thggsC6EO0AgZYzGFU3eWbH+7dGAX3L0wE5pW2+
        w/UxTebOayIVWw99f+okugt30Rwh6/hCGCFY512jTcwIXFhNGlfbHpI=
X-Google-Smtp-Source: AGHT+IEY0to5g0b9UivQ/Y1OVr2JhT7BXCjIWUf4ALZj3oU9COezVrn+bW3bLHu6x0wNsSNT5ieMmHRYXddFvSgYk0g=
X-Received: by 2002:a05:600c:1f90:b0:3f1:9a3d:4f7f with SMTP id
 je16-20020a05600c1f9000b003f19a3d4f7fmr7953wmb.1.1691102745470; Thu, 03 Aug
 2023 15:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230803193635.1047337-1-rmoar@google.com>
In-Reply-To: <20230803193635.1047337-1-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 4 Aug 2023 06:45:33 +0800
Message-ID: <CABVgOS=wy+V9+E-iDeKnF405ERXTk2DyXN6ixFnaqk=RCmVp4g@mail.gmail.com>
Subject: Re: [PATCH -next v2] kunit: fix uninitialized variables bug in
 attributes filtering
To:     Rae Moar <rmoar@google.com>
Cc:     shuah@kernel.org, brendan.higgins@linux.dev, ruanjinjie@huawei.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000071344106020c8a40"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--00000000000071344106020c8a40
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Aug 2023 at 03:37, Rae Moar <rmoar@google.com> wrote:
>
> Fix smatch warnings regarding uninitialized variables in the filtering
> patch of the new KUnit Attributes feature.
>
> Fixes: 529534e8cba3 ("kunit: Add ability to filter attributes")
>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202307270610.s0w4NKEn-lkp@intel.com/
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---
>
> Change since v1:
> - Changed initialization of filtered to be {NULL, NULL} at the start and
>   only updated when ready to return.
> - Remove unnecessary +1 in memory allocation for parsed_filters in
>   executor test.
>
> Note that this is rebased on top of the recent fix:
> ("kunit: fix possible memory leak in kunit_filter_suites()").

Thanks: this looks good to me now!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>
>  lib/kunit/attributes.c    | 40 +++++++++++++++++----------------------
>  lib/kunit/executor.c      | 18 +++++++++++-------
>  lib/kunit/executor_test.c |  2 +-
>  3 files changed, 29 insertions(+), 31 deletions(-)
>
> diff --git a/lib/kunit/attributes.c b/lib/kunit/attributes.c
> index d37c40c0ce4f..5e3034b6be99 100644
> --- a/lib/kunit/attributes.c
> +++ b/lib/kunit/attributes.c
> @@ -102,7 +102,7 @@ static int int_filter(long val, const char *op, int input, int *err)
>  static int attr_enum_filter(void *attr, const char *input, int *err,
>                 const char * const str_list[], int max)
>  {
> -       int i, j, input_int;
> +       int i, j, input_int = -1;
>         long test_val = (long)attr;
>         const char *input_val = NULL;
>
> @@ -124,7 +124,7 @@ static int attr_enum_filter(void *attr, const char *input, int *err,
>                         input_int = j;
>         }
>
> -       if (!input_int) {
> +       if (input_int < 0) {
>                 *err = -EINVAL;
>                 pr_err("kunit executor: invalid filter input: %s\n", input);
>                 return false;
> @@ -186,8 +186,10 @@ static void *attr_module_get(void *test_or_suite, bool is_test)
>         // Suites get their module attribute from their first test_case
>         if (test)
>                 return ((void *) test->module_name);
> -       else
> +       else if (kunit_suite_num_test_cases(suite) > 0)
>                 return ((void *) suite->test_cases[0].module_name);
> +       else
> +               return (void *) "";
>  }
>
>  /* List of all Test Attributes */
> @@ -221,7 +223,7 @@ const char *kunit_attr_filter_name(struct kunit_attr_filter filter)
>  void kunit_print_attr(void *test_or_suite, bool is_test, unsigned int test_level)
>  {
>         int i;
> -       bool to_free;
> +       bool to_free = false;
>         void *attr;
>         const char *attr_name, *attr_str;
>         struct kunit_suite *suite = is_test ? NULL : test_or_suite;
> @@ -255,7 +257,7 @@ void kunit_print_attr(void *test_or_suite, bool is_test, unsigned int test_level
>
>  int kunit_get_filter_count(char *input)
>  {
> -       int i, comma_index, count = 0;
> +       int i, comma_index = 0, count = 0;
>
>         for (i = 0; input[i]; i++) {
>                 if (input[i] == ',') {
> @@ -272,7 +274,7 @@ int kunit_get_filter_count(char *input)
>  struct kunit_attr_filter kunit_next_attr_filter(char **filters, int *err)
>  {
>         struct kunit_attr_filter filter = {};
> -       int i, j, comma_index, new_start_index;
> +       int i, j, comma_index = 0, new_start_index = 0;
>         int op_index = -1, attr_index = -1;
>         char op;
>         char *input = *filters;
> @@ -316,7 +318,7 @@ struct kunit_attr_filter kunit_next_attr_filter(char **filters, int *err)
>                 filter.attr = &kunit_attr_list[attr_index];
>         }
>
> -       if (comma_index) {
> +       if (comma_index > 0) {
>                 input[comma_index] = '\0';
>                 filter.input = input + op_index;
>                 input = input + new_start_index;
> @@ -356,31 +358,22 @@ struct kunit_suite *kunit_filter_attr_tests(const struct kunit_suite *const suit
>
>         /* Save filtering result on default value */
>         default_result = filter.attr->filter(filter.attr->attr_default, filter.input, err);
> -       if (*err) {
> -               kfree(copy);
> -               kfree(filtered);
> -               return NULL;
> -       }
> +       if (*err)
> +               goto err;
>
>         /* Save suite attribute value and filtering result on that value */
>         suite_val = filter.attr->get_attr((void *)suite, false);
>         suite_result = filter.attr->filter(suite_val, filter.input, err);
> -       if (*err) {
> -               kfree(copy);
> -               kfree(filtered);
> -               return NULL;
> -       }
> +       if (*err)
> +               goto err;
>
>         /* For each test case, save test case if passes filtering. */
>         kunit_suite_for_each_test_case(suite, test_case) {
>                 test_val = filter.attr->get_attr((void *) test_case, true);
>                 test_result = filter.attr->filter(filter.attr->get_attr(test_case, true),
>                                 filter.input, err);
> -               if (*err) {
> -                       kfree(copy);
> -                       kfree(filtered);
> -                       return NULL;
> -               }
> +               if (*err)
> +                       goto err;
>
>                 /*
>                  * If attribute value of test case is set, filter on that value.
> @@ -406,7 +399,8 @@ struct kunit_suite *kunit_filter_attr_tests(const struct kunit_suite *const suit
>                 }
>         }
>
> -       if (n == 0) {
> +err:
> +       if (n == 0 || *err) {
>                 kfree(copy);
>                 kfree(filtered);
>                 return NULL;
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index 481901d245d0..dc295150c4e5 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -127,19 +127,18 @@ static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
>  {
>         int i, j, k;
>         int filter_count = 0;
> -       struct kunit_suite **copy, *filtered_suite, *new_filtered_suite;
> -       struct suite_set filtered;
> +       struct kunit_suite **copy, **copy_start, *filtered_suite, *new_filtered_suite;
> +       struct suite_set filtered = {NULL, NULL};
>         struct kunit_glob_filter parsed_glob;
> -       struct kunit_attr_filter *parsed_filters;
> +       struct kunit_attr_filter *parsed_filters = NULL;
>
>         const size_t max = suite_set->end - suite_set->start;
>
>         copy = kmalloc_array(max, sizeof(*filtered.start), GFP_KERNEL);
> -       filtered.start = copy;
>         if (!copy) { /* won't be able to run anything, return an empty set */
> -               filtered.end = copy;
>                 return filtered;
>         }
> +       copy_start = copy;
>
>         if (filter_glob)
>                 kunit_parse_glob_filter(&parsed_glob, filter_glob);
> @@ -147,7 +146,11 @@ static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
>         /* Parse attribute filters */
>         if (filters) {
>                 filter_count = kunit_get_filter_count(filters);
> -               parsed_filters = kcalloc(filter_count + 1, sizeof(*parsed_filters), GFP_KERNEL);
> +               parsed_filters = kcalloc(filter_count, sizeof(*parsed_filters), GFP_KERNEL);
> +               if (!parsed_filters) {
> +                       kfree(copy);
> +                       return filtered;
> +               }
>                 for (j = 0; j < filter_count; j++)
>                         parsed_filters[j] = kunit_next_attr_filter(&filters, err);
>                 if (*err)
> @@ -166,7 +169,7 @@ static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
>                                 goto err;
>                         }
>                 }
> -               if (filter_count) {
> +               if (filter_count > 0 && parsed_filters != NULL) {
>                         for (k = 0; k < filter_count; k++) {
>                                 new_filtered_suite = kunit_filter_attr_tests(filtered_suite,
>                                                 parsed_filters[k], filter_action, err);
> @@ -195,6 +198,7 @@ static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
>
>                 *copy++ = filtered_suite;
>         }
> +       filtered.start = copy_start;
>         filtered.end = copy;
>
>  err:
> diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
> index 01280cb8d451..3e0a1c99cb4e 100644
> --- a/lib/kunit/executor_test.c
> +++ b/lib/kunit/executor_test.c
> @@ -119,7 +119,7 @@ static void parse_filter_attr_test(struct kunit *test)
>         filter_count = kunit_get_filter_count(filters);
>         KUNIT_EXPECT_EQ(test, filter_count, 2);
>
> -       parsed_filters = kunit_kcalloc(test, filter_count + 1, sizeof(*parsed_filters),
> +       parsed_filters = kunit_kcalloc(test, filter_count, sizeof(*parsed_filters),
>                         GFP_KERNEL);
>         for (j = 0; j < filter_count; j++) {
>                 parsed_filters[j] = kunit_next_attr_filter(&filters, &err);
>
> base-commit: 3bffe185ad11e408903d2782727877388d08d94e
> --
> 2.41.0.585.gd2178a4bd4-goog
>

--00000000000071344106020c8a40
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
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCC6
Tm+UTSS1frg672isgiu1fdIcJ2TbHgHy5IaQ5zKu7TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA4MDMyMjQ1NDVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAIM9M1tjn57XLWjW8F8hd
XGu0tLJw+KjOL4fRzbPtJxPGRDrjuYxeCYT4nyGIl0j+MCUG0l1To2dNpQxZjhewSIoUJl5tWwec
6mz3cqjCUVuGEHi6mMfLbR7z2ZVQh2Cbeun14ktlHP49qC5SB/xS8887ludr7WF0ZzyzOx4f05RH
RAevOlHAEk9lg0IgIuXcRgSmtiLYkeUxGnG8gROW2iVZNfiEfFkNJT0sb4LplEU2sAFfxf8xTbza
42H/fW7I4xjNuw38KTDtzvnKgV+KBWxxC1AiVfyKmwdC9magG9S3I5BgK5AqygAOa6VvuzyT+o91
DxFrA6LvTUuTTxDrKQ==
--00000000000071344106020c8a40--
