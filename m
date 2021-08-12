Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2803E9F3D
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Aug 2021 09:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbhHLHJq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Aug 2021 03:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbhHLHJq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Aug 2021 03:09:46 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DC1C0613D3
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Aug 2021 00:09:21 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id z9so6695266wrh.10
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Aug 2021 00:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iByPYpxNFBORlIRTaC+TJe25ma2CmUEZVvXOJWnY3TI=;
        b=kj7XssJnKr7Cre37uu0IWJeSxwCaeO8j2P5wVufsu4YFJ/+GxZ1I5rF3V+HF32BfsG
         MFt4qgMIrnuJWJ80lTfIXs9KjKNa+0Ni2dBT9o7GRM/+rMsi96z407SQxwcY3QBCCUIw
         badEjq+ccuAw8t7ErNyIVMvos/H5f/X3JlHRf0QC2prsZGJySKsgeMX3DwyKeu3Vf/aU
         0jrlVsvy+eD9tkVqhE4wgU7R9vCvxF28RYrX1+ha4nl038/JHbKcYbWhYuoHh3VOrCzR
         hWxHmgyVHPus/SYpI/pLNdjDcTq9063lm+4uif/iIvR82VehDHsjqlutnFKhc3uLW9ZE
         NyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iByPYpxNFBORlIRTaC+TJe25ma2CmUEZVvXOJWnY3TI=;
        b=D/YN0WBEITH6wgNbA4UgdQuB5+aNZiGmnNz1c9epVF0fKFln+Wk1YA096bdiIRb8I6
         nCbUj7tJnYLmWqwYwVd3eR8BX8OW5vFWCY6Vvv70Jpg+B7OYOY6+aQKgpnmpL5EayyHD
         ra70xCL9mnLB91Zf6IQv1tlJs4s7c7KVpm47JmFJ//2MvqOqs9kNAuXt+tUunHG1pjcf
         Dw60K/99HSeMwPz9bLzpPFaPMXPxZjwTunL2nuQgbjzqRlwRSO3RNH5iw8ixWZTWHjxE
         u3kD9GNAo8rwGUp/R8332vppSpq0K/xxO7PaGQ8xlkDDxSzhEqZ/5KB8bheFQ/DlLRip
         ew5A==
X-Gm-Message-State: AOAM5301rK/NfaDDvEtMFDWErJMpGwJE1UYg8KEE6argarcOvxt8ZPJ9
        TbHR8r4ZVep+D3u9Kft6AHY75hnPcLTUP8tUY7ZScg==
X-Google-Smtp-Source: ABdhPJzriVaHMXK0J+1stLFfu6dz0hPAsCb0zCgKeBuYijlX8B4WWAQAjautVTL6Lmva25BZ54YzqQNTy1pzI+GC0bA=
X-Received: by 2002:a5d:4090:: with SMTP id o16mr2234008wrp.176.1628752159438;
 Thu, 12 Aug 2021 00:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210805235145.2528054-1-dlatypov@google.com> <20210805235145.2528054-2-dlatypov@google.com>
In-Reply-To: <20210805235145.2528054-2-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 12 Aug 2021 15:09:07 +0800
Message-ID: <CABVgOSmoNaYVcckw3PX7Cf32NjYPSpX3JqGESCqYJvTi6dwAsQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kunit: add 'kunit.action' param to allow listing
 out tests
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000ea932805c9576952"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--000000000000ea932805c9576952
Content-Type: text/plain; charset="UTF-8"

On Fri, Aug 6, 2021 at 7:51 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Context:
> It's difficult to map a given .kunitconfig => set of enabled tests.
>
> Having a standard, easy way of getting the list could be useful in a
> number of ways. For example, if we also extended kunit.filter_glob to
> allow filtering on tests, this would allow users to run tests cases one
> by one if they wanted to debug hermeticity issues.
>
> This patch:
> * adds a kunit.action module param with one valid non-null value, "list"
> * for the "list" action, it simply prints out "<suite>.<test>"
> * does not itself introduce kunit.py changes to make use of this [1].

I really like this feature, and could live with the implementation,
but do feel like we should probably have a more detailed idea of how
the kunit_tool changes are going to work before settling on it for
sure.

In particular, is the "<suite>.<test>" format the best way of giving
test information, or do we want something more (K)TAP-like. (e.g., a
test hierarchy with all tests marked SKIPed, or otherwise limited in
some way). Maybe that'd allow some of the parser code to be re-used,
and have fewer issues with having two separate ways of representing
the test hierarchy. (What if, e.g., there were test or suite names
with '.' in them?)

On the other hand, this format does make it easier to use the
filter_glob stuff, so it could go either way...

> Note: kunit.filter_glob is respected for this and all future actions.
> Note: we need a TAP header for kunit.py to isolate the KUnit output.

I don't mind having a TAP header here, but we could either:
(a) have a separate header for a test list, and have kunit_tool look
for that as well, to avoid treating this as TAP when it isn't; or
(b) try to standardise a "test list" format as part of KTAP:
https://lore.kernel.org/linux-kselftest/CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com/

>
> Go with a more generic "action" param, since it seems like we might
> eventually have more modes besides just running or listing tests, e.g.
> * perhaps a benchmark mode that reruns test cases and reports timing
> * perhaps a deflake mode that reruns test cases that failed
> * perhaps a mode where we randomize test order to try and catch
>   hermeticity bugs like "test a only passes if run after test b"
>

The "action" parameter is fine by me. Do we want to give the default
"run" action a name as well as making it the default?

> Tested:
> $ ./tools/testing/kunit/kunit.py run --kernel_arg=kunit.action=list --raw_output=kunit
> ...
> TAP version 14
> 1..1

I really don't like the test plan line combined with the
"<suite>.<test>" format, particularly since this example notes that
there's only one test (presumably the suite), and then proceeds to
have three top-level things afterwards. It seems pretty misleading to
me.

> example.example_simple_test
> example.example_skip_test
> example.example_mark_skipped_test
> reboot: System halted
>
> [1] The interface for this can work in a few ways. We could add a
> --list_tests flag or a new subcommand. But this change is enough to
> allow people to split each suite into its own invocation, e.g. via a
> short script like:
>
>   #!/bin/bash
>
>   cd $(git rev-parse --show-toplevel)
>
>   for suite in $(
>     ./tools/testing/kunit/kunit.py run --kernel_args=kunit.action=list --raw_output=kunit |
>     sed -n '/^TAP version/,$p' | grep -P -o '^[a-z][a-z0-9_-]+\.' | tr -d '.' | sort -u);
>   do
>     ./tools/testing/kunit/kunit.py run "${suite}"
>   done
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---
> v1 -> v2: write about potential other "actions" in commit desc.
> ---
>  lib/kunit/executor.c | 46 +++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 41 insertions(+), 5 deletions(-)
>
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index acd1de436f59..77d99ee5ed64 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -15,9 +15,16 @@ extern struct kunit_suite * const * const __kunit_suites_end[];
>  #if IS_BUILTIN(CONFIG_KUNIT)
>
>  static char *filter_glob_param;
> +static char *action_param;
> +
>  module_param_named(filter_glob, filter_glob_param, charp, 0);
>  MODULE_PARM_DESC(filter_glob,
> -               "Filter which KUnit test suites run at boot-time, e.g. list*");
> +                "Filter which KUnit test suites run at boot-time, e.g. list*");
> +module_param_named(action, action_param, charp, 0);
> +MODULE_PARM_DESC(action,
> +                "Changes KUnit executor behavior, valid values are:\n"
> +                "<none>: run the tests like normal\n"
> +                "'list' to list test names instead of running them.\n");
>
>  static char *kunit_shutdown;
>  core_param(kunit_shutdown, kunit_shutdown, charp, 0644);
> @@ -109,6 +116,33 @@ static void kunit_print_tap_header(struct suite_set *suite_set)
>         pr_info("1..%d\n", num_of_suites);
>  }
>
> +static void kunit_exec_run_tests(struct suite_set *suite_set)
> +{
> +       struct kunit_suite * const * const *suites;
> +
> +       kunit_print_tap_header(suite_set);
> +
> +       for (suites = suite_set->start; suites < suite_set->end; suites++)
> +               __kunit_test_suites_init(*suites);
> +}
> +
> +static void kunit_exec_list_tests(struct suite_set *suite_set)
> +{
> +       unsigned int i;
> +       struct kunit_suite * const * const *suites;
> +       struct kunit_case *test_case;
> +
> +       /* Hack: print a tap header so kunit.py can find the start of KUnit output. */
> +       kunit_print_tap_header(suite_set);
> +
> +       for (suites = suite_set->start; suites < suite_set->end; suites++)
> +               for (i = 0; (*suites)[i] != NULL; i++) {
> +                       kunit_suite_for_each_test_case((*suites)[i], test_case) {
> +                               pr_info("%s.%s\n", (*suites)[i]->name, test_case->name);
> +                       }
> +               }
> +}
> +
>  int kunit_run_all_tests(void)
>  {
>         struct kunit_suite * const * const *suites;
> @@ -120,10 +154,12 @@ int kunit_run_all_tests(void)
>         if (filter_glob_param)
>                 suite_set = kunit_filter_suites(&suite_set, filter_glob_param);
>
> -       kunit_print_tap_header(&suite_set);
> -
> -       for (suites = suite_set.start; suites < suite_set.end; suites++)
> -               __kunit_test_suites_init(*suites);
> +       if (!action_param)
> +               kunit_exec_run_tests(&suite_set);
> +       else if (strcmp(action_param, "list") == 0)
> +               kunit_exec_list_tests(&suite_set);
> +       else
> +               pr_err("kunit executor: unknown action '%s'\n", action_param);
>
>         if (filter_glob_param) { /* a copy was made of each array */
>                 for (suites = suite_set.start; suites < suite_set.end; suites++)
> --
> 2.32.0.605.g8dce9f2422-goog
>

--000000000000ea932805c9576952
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
/nKVAPkPCzwfEPbL1262MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwgZoGCCsGAQUF
BwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9nc2F0
bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNv
bS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouseLHIb
0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vY2Ev
Z3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQA+XCDyl6gdUzbfGv+D
Xg1PhWeHLeXCPc9+sNLwRPD9AYET0o6RJYqNAVFC77sI4quIUtKk+H44VwMwNOhX3PY+69dzUd2E
XLgutq81YK/Kt/wRUdEbgvDhvjumsVENI6xc4xZzAXAZqJLK+AR5oNtx0o9GC2el89ZF3yPI8KqH
1aOYvtgDisoXXmst9rm6Njnt9AitTax0LwWdl1yGwnA6cqJfq8h7Ehg+6X3TGW4wMM1RsB9tLL2d
osQsJT49+adAbU2yODf/XkIQevor0sIhJuxYkLay9G2GK1DCEmqUfbXWF5yQRxBkhVXHodFI2+V1
OPxk5TOVVOId6G/60Hq4MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xv
YmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAyMDIw
AhABeyW1Dfueu+w9B/G1jwK+MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCC6m4Du
l5xOgjrxsAJgKRp8KY1ppnQwnxQ4y8aax9dROzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yMTA4MTIwNzA5MTlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqG
SIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAH+ySI7QbUrCGRPjfFOlbXGJF
t6EOKf1Ox6BYVqcMNnM8lySaaUs4fd2j6BX279qJH96crPIx3CAIx5cWbpox3wvHqWKp8gsWb+sy
9gzIg7+2L+7VRO7m/0C4FC9xx+m6Ih+V+kvjElL1e97ZvhtRzP+HGj+4LlLf/NLH1CfxLTolvtgR
kti9nxoDo98Wte63h2y0ft4mfBs4GrYgoJeCJxhfL80atJWMeLDZmPgAg9Tc8rQmWa435hAWqCc2
YHNE1Enlq9H1VkZcnPgW50OM+2fMFaweKfHsNLjWwuhtzeBkRE3fPyHaR0bq2Wmsf0ZUjRofs70u
l0lrDqYeeAofGw==
--000000000000ea932805c9576952--
