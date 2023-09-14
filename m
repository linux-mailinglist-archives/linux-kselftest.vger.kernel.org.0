Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B0379FF86
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 11:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236695AbjINJGl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Sep 2023 05:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237293AbjINJG3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Sep 2023 05:06:29 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A9C1BF2
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Sep 2023 02:06:24 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-402bec56ca6so59585e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Sep 2023 02:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694682383; x=1695287183; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oW078Qik9aBUF1qxqvh6tI9D0b25YtuCO00ZQI0E2dc=;
        b=WiAGWQPOOS25WL16vvWo+kf1E7rdqCiw9rSQlfeGtpk2GqY01Bp5NDDZgOVKSuGnwt
         q3gI7BlPFWSRaNmEt5vHPA/JTUI3t8jYWv1EfqOzjGa26j+lRPqRy7g9gDBsoLIUFgY8
         FpkIiCXjL3A7+PgRyP1HpiWuaWzF1gU2bIrhbsu/F7rWebSUPGINWz8qvNA+5GgtsaKN
         CZznKUTq9xZTEKSNVHG7tc63CIVModvAua4UOhUP/NNhqGhvifaNwX03fhyspWedMq6U
         QqQqxEJZzc97vNrpG6lkkfmY7GS2ilwGms4xp1Y7g5Wc988q0pawN2DWmn8pFdHFdpKM
         ck4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694682383; x=1695287183;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oW078Qik9aBUF1qxqvh6tI9D0b25YtuCO00ZQI0E2dc=;
        b=PpxuobV8vclxlgyx+CUQgRUh2prQRTSJGAMXJ9VrWfWTAKVSeOt17expqPm+MHF7A1
         h5JZWqsFJjeg9DNDNrkeM+ARg1pn1V7Zhhh/fiMz4Jv4ifGDAKHpqseSeg48RKIR9E9J
         yM8ZK/m5T3Crm2e5ljorwduUmSn0b+11huo7WKrpAcjLbWnjt+hU07IT6xVe4RNBvYFF
         B4tp/VJGEXudy7M2pnMfbwUxc2tAYzYmwgn56jKX5qsvwCgHZgYbSlyoqe18ij+/xBoF
         SL6S/ajIum8PwlIlPNvrBrNRApS859qI1Y6j/t8DE+IDqR47KkzzbGR2SLQa1ehnrmYG
         jmRw==
X-Gm-Message-State: AOJu0Yz7ijCM57jjZMx+BtKLRxbhpbQpKo7mZqLnu2M5hRpUskdM7sUY
        6l0C4/rzZNT/rWgNXt30ZJgM6vW8jLoppieEqsuDMw==
X-Google-Smtp-Source: AGHT+IEg27lWBSdW+CbUv+CgKOCnvKBq2YwHVx6FDCPtZIa0HpYGWeG8ydnLRUY9gE7G/BZA/aGpJQf45a+NukdLEm8=
X-Received: by 2002:a7b:c3c8:0:b0:400:fffe:edf6 with SMTP id
 t8-20020a7bc3c8000000b00400fffeedf6mr249595wmj.1.1694682383030; Thu, 14 Sep
 2023 02:06:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230908213148.3610108-1-rmoar@google.com>
In-Reply-To: <20230908213148.3610108-1-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 14 Sep 2023 17:06:08 +0800
Message-ID: <CABVgOSnTGFgzje3QZfN69We+26oWrWKoJQQP_=zphSLk4PG1xA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kunit: add ability to run tests after boot using debugfs
To:     Rae Moar <rmoar@google.com>
Cc:     shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev,
        sadiyakazi@google.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000007a8a7606054dfd0b"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--0000000000007a8a7606054dfd0b
Content-Type: text/plain; charset="UTF-8"

On Sat, 9 Sept 2023 at 05:31, Rae Moar <rmoar@google.com> wrote:
>
> Add functionality to run built-in tests after boot by writing to a
> debugfs file.
>
> Add a new debugfs file labeled "run" for each test suite to use for
> this purpose.
>
> As an example, write to the file using the following:
>
> echo "any string" > /sys/kernel/debugfs/kunit/<testsuite>/run
>
> This will trigger the test suite to run and will print results to the
> kernel log.
>
> Note that what you "write" to the debugfs file will not be saved.
>
> To guard against running tests concurrently with this feature, add a
> mutex lock around running kunit. This supports the current practice of
> not allowing tests to be run concurrently on the same kernel.
>
> This functionality may not work for all tests.
>
> This new functionality could be used to design a parameter
> injection feature in the future.
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---

This is looking pretty good, but I have a few nitpicks below and one big issue.

The big issue is that this doesn't seem to exclude test suites created
with kunit_test_init_section_suite{,s}(). The init section versions of
the suite declarations, by definition, won't work if run after the
kernel has finished booting. At the moment, these macros just pass
through to the normal versions (because we've not been able to run
after boot until now), but we'll need to implement it (maybe as a
separate linker section, maybe as an attribute, etc) now. I expect
that the correct solution here would be to not create the 'run'
debugfs file for these tests. But I could be convinced to have it
exist, but to just say "this test cannot be run after boot" if you've
got a good argument. In any case, grep 'test.h' for "NOTE TO KUNIT
DEVS" and you'll see the details.

My one other not-totally-related thought (and this extends to module
loading, too, so is possibly more useful as a separate patch) is that
we're continually incrementing the test number still. This doesn't
matter if we read the results from debugfs though, and it may make
more sense to have this continue to increment (and thus treat all of
dmesg as one long KTAP document). We could always add a reset option
to debugfs in a follow-up patch if we want. But that's not something
I'd hold this up with.

>
> Changes since v1:
> - Removed second patch as this problem has been fixed
> - Added Documentation patch
> - Made changes to work with new dynamically-extending log feature
>
> Note that these patches now rely on (and are rebased on) the patch series:
> https://lore.kernel.org/all/20230828104111.2394344-1-rf@opensource.cirrus.com/
>
>  lib/kunit/debugfs.c | 66 +++++++++++++++++++++++++++++++++++++++++++++
>  lib/kunit/test.c    | 13 +++++++++
>  2 files changed, 79 insertions(+)
>
> diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
> index 270d185737e6..8c0a970321ce 100644
> --- a/lib/kunit/debugfs.c
> +++ b/lib/kunit/debugfs.c
> @@ -8,12 +8,14 @@
>  #include <linux/module.h>
>
>  #include <kunit/test.h>
> +#include <kunit/test-bug.h>
>
>  #include "string-stream.h"
>  #include "debugfs.h"
>
>  #define KUNIT_DEBUGFS_ROOT             "kunit"
>  #define KUNIT_DEBUGFS_RESULTS          "results"
> +#define KUNIT_DEBUGFS_RUN              "run"
>
>  /*
>   * Create a debugfs representation of test suites:
> @@ -21,6 +23,8 @@
>   * Path                                                Semantics
>   * /sys/kernel/debug/kunit/<testsuite>/results Show results of last run for
>   *                                             testsuite
> + * /sys/kernel/debug/kunit/<testsuite>/run     Write to this file to trigger
> + *                                             testsuite to run
>   *
>   */
>
> @@ -99,6 +103,51 @@ static int debugfs_results_open(struct inode *inode, struct file *file)
>         return single_open(file, debugfs_print_results, suite);
>  }
>
> +/*
> + * Print a usage message to the debugfs "run" file
> + * (/sys/kernel/debug/kunit/<testsuite>/run) if opened.
> + */
> +static int debugfs_print_run(struct seq_file *seq, void *v)
> +{
> +       struct kunit_suite *suite = (struct kunit_suite *)seq->private;
> +
> +       seq_puts(seq, "Write to this file to trigger the test suite to run.\n");
> +       seq_printf(seq, "usage: echo \"any string\" > /sys/kernel/debugfs/kunit/%s/run\n",
> +                       suite->name);
> +       return 0;
> +}
> +
> +/*
> + * The debugfs "run" file (/sys/kernel/debug/kunit/<testsuite>/run)
> + * contains no information. Write to the file to trigger the test suite
> + * to run.
> + */
> +static int debugfs_run_open(struct inode *inode, struct file *file)
> +{
> +       struct kunit_suite *suite;
> +
> +       suite = (struct kunit_suite *)inode->i_private;
> +
> +       return single_open(file, debugfs_print_run, suite);
> +}
> +
> +/*
> + * Trigger a test suite to run by writing to the suite's "run" debugfs
> + * file found at: /sys/kernel/debug/kunit/<testsuite>/run
> + *
> + * Note: what is written to this file will not be saved.
> + */
> +static ssize_t debugfs_run(struct file *file,
> +               const char __user *buf, size_t count, loff_t *ppos)
> +{
> +       struct inode *f_inode = file->f_inode;
> +       struct kunit_suite *suite = (struct kunit_suite *) f_inode->i_private;
> +
> +       __kunit_test_suites_init(&suite, 1);
> +
> +       return count;
> +}
> +
>  static const struct file_operations debugfs_results_fops = {
>         .open = debugfs_results_open,
>         .read = seq_read,
> @@ -106,10 +155,23 @@ static const struct file_operations debugfs_results_fops = {
>         .release = debugfs_release,
>  };
>
> +static const struct file_operations debugfs_run_fops = {
> +       .open = debugfs_run_open,
> +       .read = seq_read,
> +       .write = debugfs_run,
> +       .llseek = seq_lseek,
> +       .release = debugfs_release,
> +};
> +
>  void kunit_debugfs_create_suite(struct kunit_suite *suite)
>  {
>         struct kunit_case *test_case;
>
> +       if (suite->log) {
> +               /* Clear the suite log that's leftover from a previous run. */
> +               string_stream_clear(suite->log);
> +               return;
> +       }

Can we just move this to kunit_init_suite() in test.c. It doesn't feel
quite debugfs-y enough, and the return here tripped me up for a little
too long.

Ideally, we'd then split up kunit_init_suite() into a one-time
initialisation (which calls kunit_debugfs_create_suite()), and a reset
function (which resets the state of the suite back to the beginning).
We then only call init once, but reset on every execution.
>         /* Allocate logs before creating debugfs representation. */
>         suite->log = alloc_string_stream(GFP_KERNEL);
>         string_stream_set_append_newlines(suite->log, true);
> @@ -124,6 +186,10 @@ void kunit_debugfs_create_suite(struct kunit_suite *suite)
>         debugfs_create_file(KUNIT_DEBUGFS_RESULTS, S_IFREG | 0444,
>                             suite->debugfs,
>                             suite, &debugfs_results_fops);
> +
> +       debugfs_create_file(KUNIT_DEBUGFS_RUN, S_IFREG | 0644,
> +                           suite->debugfs,
> +                           suite, &debugfs_run_fops);
>  }
>
>  void kunit_debugfs_destroy_suite(struct kunit_suite *suite)
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 651cbda9f250..d376b886d72d 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -13,6 +13,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
> +#include <linux/mutex.h>
>  #include <linux/panic.h>
>  #include <linux/sched/debug.h>
>  #include <linux/sched.h>
> @@ -22,6 +23,8 @@
>  #include "string-stream.h"
>  #include "try-catch-impl.h"
>
> +static struct mutex kunit_run_lock;
> +

Should we use DEFINE_MUTEX() here rather than initialising it at runtime?

>  /*
>   * Hook to fail the current test and print an error message to the log.
>   */
> @@ -668,6 +671,11 @@ int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_
>                 return 0;
>         }
>
> +       /* Use mutex lock to guard against running tests concurrently. */
> +       if (mutex_lock_interruptible(&kunit_run_lock)) {
> +               pr_err("kunit: test interrupted\n");
> +               return -EINTR;
> +       }
>         static_branch_inc(&kunit_running);
>
>         for (i = 0; i < num_suites; i++) {
> @@ -676,6 +684,7 @@ int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_
>         }
>
>         static_branch_dec(&kunit_running);
> +       mutex_unlock(&kunit_run_lock);
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(__kunit_test_suites_init);
> @@ -836,6 +845,10 @@ static int __init kunit_init(void)
>         kunit_install_hooks();
>
>         kunit_debugfs_init();
> +
> +       /* Initialize lock to guard against running tests concurrently. */
> +       mutex_init(&kunit_run_lock);
> +

As I understand it, we can just use DEFINE_MUTEX() above.


>  #ifdef CONFIG_MODULES
>         return register_module_notifier(&kunit_mod_nb);
>  #else
>
> base-commit: b754593274e04fc840482a658b29791bc8f8b933
> --
> 2.42.0.283.g2d96d420d3-goog
>

--0000000000007a8a7606054dfd0b
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
ddIn9n5Jt6Z1o79zxraLMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQBtHFwIgQZjer5K
H+4Q+wns10k7qN+4wN2Uf+JsyOYjukaMEgdLErfA1wwtQ9uHkoYQZcWBuVVkQFa5hI+sqI2m1Weq
riMCFSiU38s1tADdMX12IMfJRN60Nznhrw+nPyDRZqRhUTW24TwnHorkDnFPW8PHo7fAw4FrpI0n
impZAng7ccvvK09K3ZuhwTIxJMsPXCZYsrXWORTw5sczRAP6XvKbPBJnsJoSTe5dFBPBHOQJOGhU
qWfEfWnWMJPF3LxSGLpLFQXO3RwQqmxv08avwXfVPouh1xuB3FX7rpDabT8YDhu9JgIZkLEKko7L
yQt6zWwng7k8YF/jGbiAta6VMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDH
MmBeipXJ4VWNj3jl018ILe9Czs5b5Aq4gg57hrFjoDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA5MTQwOTA2MjNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAEpMvVu/qNIHGFnzjRqLc
OSQvlJkacFG6ASnicCH+jpLr70a+FvzFn2FxbUM66t6iYPgmTObT+1W4kaQVo/iAgrxUu2KRUub1
OYyQtl0szfTVlUT0pQszQkgIfvwS1bayiy7jU84BhUoYhhy6O2WF6UPjdRoYeAg1ykCrTwwqXfYd
Z2ixpAtBAgOz7DYnBAeP9qyjto/YD2hx/ajcbZBwvL647ypl93bCsRZAmW20gvHlRVSiVnKxVnFJ
+rooMcpEgeGKNiXS+9t+ulm19pXUcPrq5CxRoykPGlZrAx/gSVDi6jq3H4YN9n/1f3MPMZOkm5hW
CDWyaEnZskHn8y9Taw==
--0000000000007a8a7606054dfd0b--
