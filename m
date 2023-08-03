Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960A276E2D2
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 10:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234484AbjHCIVE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 04:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbjHCIUk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 04:20:40 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C25F6A74
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Aug 2023 01:15:49 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fe32ec7201so52485e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Aug 2023 01:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691050548; x=1691655348;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BiM+4dSjfBsVl7canuXcNoRsm5/7H0M0KGKMOvT+RLw=;
        b=wvcZ4XdNzK2YcVyl20cbCnhgZQu00DS7f6/AFkNXDQRMfXK7X29HlIWmVexHukb5pF
         EHfdZwogBdTdJA403MwF8XZ0tqxHTRCWobKfNcSgtgjZ69+VI3SvJdpy2xs81FU4ow1X
         42L2l0GSbF7eKVy7zj5bjLfbrNavGYHa/ayzq1rKp7Rq0KV3cazO3Opqkz7c/k0JfuL2
         erEQ54rnGDwz+BvsQq3e6tItbOq18BPKPlrqI86mEW5MRCWukT66zFxavYQ/yBE3IEnR
         y2mww77RrlixQIthz3l5uLgxn7hz87CW1P8NJ4KBGdWJGAfW/7wrCi1SQ5euR/QKc+GS
         WT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691050548; x=1691655348;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BiM+4dSjfBsVl7canuXcNoRsm5/7H0M0KGKMOvT+RLw=;
        b=becDG2Y+AhIAsN0DItaiJdsglw94gTpRqfXUICHSOU7MdcSsnIlvBp3s5Pkz1yuxPI
         yBCcSXWhbyxXnv//UWdKeFwMjQBqBWhrLplcmn5aeE4sPfsmFY0Mcg8IM2XM8Oimc/S1
         JFDkfAaKC0oefJzC1TswWkCvvTTlui6uyrFgx7AHhG8F37suX24DRrp3Gs30WAzjitBD
         b7mHPEeh6/8G/y25+R7RdHWlI0rofH64x21CsHcGVN741USOFLH7I73oWL1SjO9lCap3
         scoOho7bgwI8F3d8SFf7IbLY/PqXv5zYGzAnyhOkVcekIUNXhY7ls80zFhAVf5x/CyIN
         6cHA==
X-Gm-Message-State: ABy/qLY/WEeZtZ8OY8i0E9W58bktfrMuNwYHELBIrw4apz2v4gdwLjRi
        isiOR8PMptsGR0KQCkY/hn2HxXlwCeqXq2sUz78f+g==
X-Google-Smtp-Source: APBJJlFf4EetmXpIrlrhTA6x90iasT+njiUn4COPCwyzd1VcWog9z+dnkSX0hQMZt8YiW+7IDjrPsljNZkxp6x4Ylb4=
X-Received: by 2002:a7b:cbcd:0:b0:3fd:e15:6d5 with SMTP id n13-20020a7bcbcd000000b003fd0e1506d5mr488371wmi.2.1691050548293;
 Thu, 03 Aug 2023 01:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230802212834.761327-1-rmoar@google.com>
In-Reply-To: <20230802212834.761327-1-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 3 Aug 2023 16:15:34 +0800
Message-ID: <CABVgOSkGL2QhcQ7067NddajXGOJvjN88O7OjdTs3YY2xgMSZPQ@mail.gmail.com>
Subject: Re: [PATCH -next] kunit: fix uninitialized variables bug in
 attributes filtering
To:     Rae Moar <rmoar@google.com>
Cc:     shuah@kernel.org, brendan.higgins@linux.dev, ruanjinjie@huawei.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000004081d506020063f8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--0000000000004081d506020063f8
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Aug 2023 at 05:28, Rae Moar <rmoar@google.com> wrote:
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

These fixes look good, especially the ones in attributes.c.

There's still a possibility of returning uninitialised or freed
pointers in executor.c. If we can keep 'filtered' valid at all times,
this should be easier to deal with, e.g.:

- Initialise 'filtered' to {NULL, NULL}, which is a valid "empty" value.
- Only ever set start and end at the same time, so don't set 'start'
immediately after allocation.
- Wait until the filtering is complete and successful (i.e., where
'end' is set now), and set 'start' there as well.
- Then return filtered will definitely either return the completely
filtered value, or a valid empty suite_set.

Otherwise, this looks good.

-- David

>
> Note that this is rebased on top of the recent fix:
> ("kunit: fix possible memory leak in kunit_filter_suites()").
>
>  lib/kunit/attributes.c | 40 +++++++++++++++++-----------------------
>  lib/kunit/executor.c   | 10 +++++++---
>  2 files changed, 24 insertions(+), 26 deletions(-)
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
> index 481901d245d0..b6e07de2876a 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -130,7 +130,7 @@ static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
>         struct kunit_suite **copy, *filtered_suite, *new_filtered_suite;
>         struct suite_set filtered;
>         struct kunit_glob_filter parsed_glob;
> -       struct kunit_attr_filter *parsed_filters;
> +       struct kunit_attr_filter *parsed_filters = NULL;
>
>         const size_t max = suite_set->end - suite_set->start;
>
> @@ -147,7 +147,11 @@ static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
>         /* Parse attribute filters */
>         if (filters) {
>                 filter_count = kunit_get_filter_count(filters);
> -               parsed_filters = kcalloc(filter_count + 1, sizeof(*parsed_filters), GFP_KERNEL);
> +               parsed_filters = kcalloc(filter_count, sizeof(*parsed_filters), GFP_KERNEL);
> +               if (!parsed_filters) {
> +                       kfree(copy);
> +                       return filtered;

Is 'filtered' properly initialised here?
filtered.start is already set to 'copy' by this point (so, having
freed 'copy', this would now be an invalid pointer).
filtered.end is uninitialised.

Can we instead initialise filtered to {NULL, NULL} at the start, and
only set start and end after the filtering has succeeded?

> +               }
>                 for (j = 0; j < filter_count; j++)
>                         parsed_filters[j] = kunit_next_attr_filter(&filters, err);
>                 if (*err)
> @@ -166,7 +170,7 @@ static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
>                                 goto err;
>                         }
>                 }
> -               if (filter_count) {
> +               if (filter_count > 0 && parsed_filters != NULL) {
>                         for (k = 0; k < filter_count; k++) {
>                                 new_filtered_suite = kunit_filter_attr_tests(filtered_suite,
>                                                 parsed_filters[k], filter_action, err);
>
> base-commit: 3bffe185ad11e408903d2782727877388d08d94e
> --
> 2.41.0.585.gd2178a4bd4-goog
>

--0000000000004081d506020063f8
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
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDV
eAtnEqmpNX2czJtg7AmAhFo5dhowdn/aLiAUOe3KcTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA4MDMwODE1NDhaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAIPVZNFrfbeoajipFxH7q
q2a3fJh3CcE+sgUxbVg0S5BksKga2Fvv8xFHU0bsHKL54XlgSAC/ZqhLBGY0B8NbjBOzQkSmN+Hr
Gk0JBQaapeYp1sc6kOqDAyMvOT0LeQuVvTzyFlTnMAKwNMsGD8Q/Ba6KKumdn+a15G+xHWQSHkld
v8ZZaE6p+DMtm6G9USpMPbeyNPuf8pWgb5+amYhBVUwxH5j9pzzYsiBNaaw/Kq1RD55Y8jxRRK9R
srhVQuoHa5ELbg6tiSQPnpTU97k653QjKt2ze+4+aQwCxvH6qaeco2WhwmFL66qZfvcs0rw7vAR5
n2nVKoM0l0siWmJ5hw==
--0000000000004081d506020063f8--
