Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671F135D6B3
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Apr 2021 07:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhDMFBC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Apr 2021 01:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbhDMFBB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Apr 2021 01:01:01 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBCAC061574
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Apr 2021 22:00:42 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id r22so7246152ljc.5
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Apr 2021 22:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mPg3FjdC+Ron6j6mLledYc2zlaUR4YAILZJM7uj79lI=;
        b=aW46/KmmbwJ80jQ1RICnPwvecJYlTiKPtRHdmrBch7UOCP7UoH5cJPU1Ns4QM7yomA
         3Qw+esqW1d/vOS3wi9aKbsGmmqdnIUakHY4uvb4IWY5opQIKzocc1x7jEHAJzTNnU9t+
         bLdV2gGOPiPLOj4qfGSSnFgqUptcQjirjrfCnR7hnCmMs6llbrKV9MR5wajGLVF2SbUT
         jVsrbnkbU8SwzF/oACJbKeRJTH8A8oKUqV6kV2JczhhWDbjtFtqBu2zwjbT/xvJKU5TJ
         TwU3DYgrG6Xc8eJ8KIf/Fmc7Jkp1v3Ef2u0p+UYyu3Q5t8R83+Uacylw1OOCUiKLuyZ6
         wrxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mPg3FjdC+Ron6j6mLledYc2zlaUR4YAILZJM7uj79lI=;
        b=fwiE25lZvo8VaRyV8IFHOKoLwhh43pz4KxbaT5u0g/acdNysZ8gIeQjMJ55ypHePA8
         Eecn7HlYr3VVOiofaUmNjk7ZLK+n6syNAv00GUoXXKuPgIZMLfzvLs4XvFKn3C/9WN5F
         6r+2etTV2KHop3xDdo6rk9bkJmOVN/0nW7ZSYykY4DmTfyqtLRfnuFL0MVl8zF9bu/yZ
         Od0r/fDGIwGqBi2nCbrkj0dR07qENFGZf8GYKgaYNlaWU3aw9JYmaP6ac+7QbmmxF5cp
         b0GFKbsIAW33v3YeE6V2oOd8PMqUASlVBxZBxPJIAdAfCvncYN/x3Xz33g2m3Ip6L3xU
         AVfQ==
X-Gm-Message-State: AOAM531tKYDfIAkuNBhEbM4ZEVB3TUxitlUYaLW4ngWWQBH2p9Azmovr
        jDMkdYytCb5wwXU+hoIP3gUcVVhn9GQt/Vd/Q+1YKg==
X-Google-Smtp-Source: ABdhPJw1y1QEVUSZgkQketBsoMM5NeL76zfb3fLyDOF1OXa3XSYe77ImLYKyXvW1BCSL/hRh2+wXJZMOoxaPMSHeFss=
X-Received: by 2002:a2e:8053:: with SMTP id p19mr19895619ljg.89.1618290040878;
 Mon, 12 Apr 2021 22:00:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210413000803.778099-1-dlatypov@google.com>
In-Reply-To: <20210413000803.778099-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 13 Apr 2021 13:00:29 +0800
Message-ID: <CABVgOSm7ywx8KNQVLULgCPvJ9tcLsaS3Rk4zkre05bOdk9gfeg@mail.gmail.com>
Subject: Re: [PATCH] kunit: add unit test for filtering suites by names
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000000fec5105bfd383e3"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--0000000000000fec5105bfd383e3
Content-Type: text/plain; charset="UTF-8"

On Tue, Apr 13, 2021 at 8:08 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> This adds unit tests for kunit_filter_subsuite() and
> kunit_filter_suites().
>
> Note: what the executor means by "subsuite" is the array of suites
> corresponding to each test file.
>
> This patch lightly refactors executor.c to avoid the use of global
> variables to make it testable.
> It also includes a clever `kfree_at_end()` helper that makes this test
> easier to write than it otherwise would have been.
>
> Tested by running just the new tests using itself
> $ ./tools/testing/kunit/kunit.py run '*exec*'
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

I really like this test, thanks.

A few small notes below, including what I think is a missing
kfree_at_end() call.

Assuming that one issue is fixed (or I'm mistaken):
Reviewed-by: David Gow <davidgow@google.com>

-- David

> ---
>  lib/kunit/executor.c      |  26 ++++----
>  lib/kunit/executor_test.c | 132 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 147 insertions(+), 11 deletions(-)
>  create mode 100644 lib/kunit/executor_test.c
>
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index 15832ed44668..96a4ae983786 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -19,7 +19,7 @@ MODULE_PARM_DESC(filter_glob,
>                 "Filter which KUnit test suites run at boot-time, e.g. list*");
>
>  static struct kunit_suite * const *
> -kunit_filter_subsuite(struct kunit_suite * const * const subsuite)
> +kunit_filter_subsuite(struct kunit_suite * const * const subsuite, const char *filter_glob)
>  {
>         int i, n = 0;
>         struct kunit_suite **filtered;
> @@ -52,19 +52,14 @@ struct suite_set {
>         struct kunit_suite * const * const *end;
>  };
>
> -static struct suite_set kunit_filter_suites(void)
> +static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
> +                                           const char *filter_glob)
>  {
>         int i;
>         struct kunit_suite * const **copy, * const *filtered_subsuite;
>         struct suite_set filtered;
>
> -       const size_t max = __kunit_suites_end - __kunit_suites_start;
> -
> -       if (!filter_glob) {
> -               filtered.start = __kunit_suites_start;
> -               filtered.end = __kunit_suites_end;
> -               return filtered;
> -       }
> +       const size_t max = suite_set->end - suite_set->start;
>
>         copy = kmalloc_array(max, sizeof(*filtered.start), GFP_KERNEL);
>         filtered.start = copy;
> @@ -74,7 +69,7 @@ static struct suite_set kunit_filter_suites(void)
>         }
>
>         for (i = 0; i < max; ++i) {
> -               filtered_subsuite = kunit_filter_subsuite(__kunit_suites_start[i]);
> +               filtered_subsuite = kunit_filter_subsuite(suite_set->start[i], filter_glob);
>                 if (filtered_subsuite)
>                         *copy++ = filtered_subsuite;
>         }
> @@ -98,8 +93,13 @@ static void kunit_print_tap_header(struct suite_set *suite_set)
>  int kunit_run_all_tests(void)
>  {
>         struct kunit_suite * const * const *suites;
> +       struct suite_set suite_set = {
> +               .start = __kunit_suites_start,
> +               .end = __kunit_suites_end,
> +       };
>
> -       struct suite_set suite_set = kunit_filter_suites();
> +       if (filter_glob)
> +               suite_set = kunit_filter_suites(&suite_set, filter_glob);
>
>         kunit_print_tap_header(&suite_set);
>
> @@ -115,4 +115,8 @@ int kunit_run_all_tests(void)
>         return 0;
>  }
>
> +#if IS_BUILTIN(CONFIG_KUNIT_TEST)
> +#include "executor_test.c"
> +#endif
> +
>  #endif /* IS_BUILTIN(CONFIG_KUNIT) */
> diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
> new file mode 100644
> index 000000000000..8e925395beeb
> --- /dev/null
> +++ b/lib/kunit/executor_test.c
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit test for the KUnit executor.
> + *
> + * Copyright (C) 2021, Google LLC.
> + * Author: Daniel Latypov <dlatypov@google.com>
> + */
> +
> +#include <kunit/test.h>
> +
> +static void kfree_at_end(struct kunit *test, const void *to_free);
> +static struct kunit_suite *alloc_fake_suite(struct kunit *test,
> +                                           const char *suite_name);
> +
> +static void filter_subsuite_test(struct kunit *test)
> +{
> +       struct kunit_suite *subsuite[3] = {NULL, NULL, NULL};
> +       struct kunit_suite * const *filtered;
> +
> +       subsuite[0] = alloc_fake_suite(test, "suite1");
> +       subsuite[1] = alloc_fake_suite(test, "suite2");
> +
> +       /* Want: suite1, suite2, NULL -> suite2, NULL */
> +       filtered = kunit_filter_subsuite(subsuite, "suite2*");
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered);
> +       kfree_at_end(test, filtered);
> +
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered[0]);
> +       KUNIT_EXPECT_STREQ(test, (const char *)filtered[0]->name, "suite2");

Is it worth testing that filtered[0] == subsuite[1], not just the
name? (I suspect it doesn't really matter, but that seems to be what's
happening in filter_suites_test() below.)

> +
> +       KUNIT_EXPECT_FALSE(test, filtered[1]);
> +}
> +
> +static void filter_subsuite_to_empty_test(struct kunit *test)
> +{
> +       struct kunit_suite *subsuite[3] = {NULL, NULL, NULL};
> +       struct kunit_suite * const *filtered;
> +
> +       subsuite[0] = alloc_fake_suite(test, "suite1");
> +       subsuite[1] = alloc_fake_suite(test, "suite2");
> +
> +       filtered = kunit_filter_subsuite(subsuite, "not_found");
> +       kfree_at_end(test, filtered); /* just in case */
> +
> +       KUNIT_EXPECT_FALSE_MSG(test, filtered,
> +                              "should be NULL to indicate no match");
> +}
> +
> +static void kfree_subsuites_at_end(struct kunit *test, struct suite_set *suite_set)
> +{
> +       struct kunit_suite * const * const *suites;
> +
> +       for (suites = suite_set->start; suites < suite_set->end; suites++)
> +               kfree_at_end(test, *suites);
> +}
> +
> +static void filter_suites_test(struct kunit *test)
> +{
> +       /* Suites per-file are stored as a NULL terminated array */
> +       struct kunit_suite *subsuites[2][2] = {
> +               {NULL, NULL},
> +               {NULL, NULL},
> +       };
> +       /* Match the memory layout of suite_set */
> +       struct kunit_suite * const * const suites[2] = {
> +               subsuites[0], subsuites[1],
> +       };
> +
> +       const struct suite_set suite_set = {
> +               .start = suites,
> +               .end = suites + 2,
> +       };
> +       struct suite_set filtered = {.start = NULL, .end = NULL};
> +
> +       /* Emulate two files, each having one suite */
> +       subsuites[0][0] = alloc_fake_suite(test, "suite0");
> +       subsuites[1][0] = alloc_fake_suite(test, "suite1");
> +
> +       /* Filter out suite1 */
> +       filtered = kunit_filter_suites(&suite_set, "suite0");
> +       kfree_subsuites_at_end(test, &filtered); /* let us use ASSERTs without leaking */

Do we also need to kfree_at_end(test, &filtered.start) here?

> +       KUNIT_ASSERT_EQ(test, filtered.end - filtered.start, (ptrdiff_t) 1);
> +
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered.start);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered.start[0]);
> +       KUNIT_EXPECT_PTR_EQ(test, filtered.start[0][0], subsuites[0][0]);
> +}
> +
> +static struct kunit_case executor_test_cases[] = {
> +       KUNIT_CASE(filter_subsuite_test),
> +       KUNIT_CASE(filter_subsuite_to_empty_test),
> +       KUNIT_CASE(filter_suites_test),
> +       {}
> +};
> +
> +static struct kunit_suite executor_test_suite = {
> +       .name = "kunit_executor_test",
> +       .test_cases = executor_test_cases,
> +};
> +
> +kunit_test_suites(&executor_test_suite);
> +
> +/* Test helpers */
> +
> +static void kfree_res_free(struct kunit_resource *res)
> +{
> +       kfree(res->data);
> +}
> +
> +/* Use the resource API to register a call to kfree(to_free).
> + * Since we never actually use the resource, it's safe to use on const data.
> + */
> +static void kfree_at_end(struct kunit *test, const void *to_free)
> +{
> +       /* kfree() handles NULL already, but avoid allocating a no-op cleanup. */
> +       if (IS_ERR_OR_NULL(to_free))
> +               return;
> +       kunit_alloc_and_get_resource(test, NULL, kfree_res_free, GFP_KERNEL,
> +                                    (void *)to_free);
> +}

This actually seems useful enough to move out of this test and have as
part of the KUnit framework proper. Admittedly, I normally am very
sceptical about doing this when there's only one user, but this does
seem more obviously useful than most things. As a bonus, it could
reuse the kunit_kmalloc_free() function, rather than having its own
kfree_res_free() helper.

> +
> +static struct kunit_suite *alloc_fake_suite(struct kunit *test,
> +                                           const char *suite_name)
> +{
> +       struct kunit_suite *suite;
> +
> +       /* We normally never expect to allocate suites, hence the non-const cast. */
> +       suite = kunit_kzalloc(test, sizeof(*suite), GFP_KERNEL);
> +       strncpy((char *)suite->name, suite_name, sizeof(suite->name));
> +
> +       return suite;
> +}
>
> base-commit: 1678e493d530e7977cce34e59a86bb86f3c5631e
> --
> 2.31.1.295.g9ea45b61b8-goog
>

--0000000000000fec5105bfd383e3
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnAYJKoZIhvcNAQcCoIIPjTCCD4kCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz2MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
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
ILbFHw0h01NI0v+AeczGMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwgZoGCCsGAQUF
BwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9nc2F0
bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNv
bS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouseLHIb
0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vY2Ev
Z3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQCNr3LBERPjVctGdVEb
/hN6/N6F2eUWxZLSUbuV7fOle0OvI8xz2AUBrOYQLp94ox9LqmsATKPsBl2uiktsvfs/AXNMcmOz
qsWHzfqp4XlvNgQsC/UyUMWxZoEyTDfTSat09yQjkFJ7viwzrqqscmTx5oTZz8TPRt0mbxwx3qry
wDzYxadSUQXNpNnfi0FBDYUUfuCLFWPsPsAXmgh483u0RbNik9OY/ozNq1Gvg/U0jQOlJf2IiKbE
kUL5Vq8gDDu6bETx5bHmRmSjHhwo7eVbxywczpzdFsU3dauZ3BzqhLy2pRGGzZybSH/3mf7o9y15
gmRHE7WzPLrsULHG/TM8MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xv
YmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAyMDIw
AhABm/kO+4pd09krN7Fjk8ypMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBGaoVd
duZEohRdGHpz8/oMWBX/lpwlVxyF1/+fu/L+LTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yMTA0MTMwNTAwNDFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqG
SIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAl+oXz2cYakW0Jjbcmmg+7LqA
aLCvhPPYBG4nvcIMgab04Rq04vBlrwyWbmfHIsPCuEzQYWTZhia3uraB/0R2zE/o04V4YaU1gfyg
yje6Si9GtgM8hktmah4t+c8fHIFDYGgjUkdYTSPrlmPSBMAs7MgLNaL6IBY4eGfqrbUjx+FYtBZ4
f61y+scZS11Top8XCSlc+sRSVdO320u3esM1jmyP1D8aIy8hYbqG1LtJI8Mqvw4XizMIxTqztaX7
ZBnARlzrdju/Vnu84Om8plKv+0cwAPnMVzP/iLfQnVhsehydI7W6p2OynRrSTk4cHDchJhZ5Cs8Q
SSBnOYOIQGfkTw==
--0000000000000fec5105bfd383e3--
