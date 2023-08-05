Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FF5770F05
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Aug 2023 11:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjHEJRm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Aug 2023 05:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjHEJRl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Aug 2023 05:17:41 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FD1469E
        for <linux-kselftest@vger.kernel.org>; Sat,  5 Aug 2023 02:17:38 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe2a116565so26825e9.1
        for <linux-kselftest@vger.kernel.org>; Sat, 05 Aug 2023 02:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691227057; x=1691831857;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+zIzC0zlNuDALb2jNngsbLOjYipgtGETcBrHoZLuu5k=;
        b=3MGAVYNDINoyoiOk3Q2uV/rO4WF8JDcgGO9AVXy9IyQ3ExT3SoGrXOaGsnEDC+i1CI
         ogBcPqkFm6Y+Y6EH1CL99AVu9IKudgGzJ3VJIS2tEo+vWVOKAs4qxe9lhRot6dgXU084
         DP/hQKG2QoKso0ld+IyjoGMVkdfv8I865yH3iZQ1LWHBBCjvMoBmI3LCzDX5tCy/z3Z8
         kgG3F0peN9ZxVnxD0GIIBhuw9Gj7Hu5hhY2qiL4OilPxRVMdc0ZzKxdPupiiaMr47qXM
         yyYI7dw+h8W+1e4XbAarzxmBQJCTcnaVfhbbD6alUMY9dftvRGNHSzxzVdCijeWpsWqy
         02jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691227057; x=1691831857;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+zIzC0zlNuDALb2jNngsbLOjYipgtGETcBrHoZLuu5k=;
        b=XChTwCA7VCEUNJTfR1kMr0Qb5uitFNLu/ew0YFfO8MaA5tvZXveO9iqdHXdWhaaQYb
         dZhOIUg03y0gOHi/vmJ7j6LwQeiOdMlxeA13nPUCOjfrMm08VvijBAybuXSwAg3Nam1W
         f7dHmXgftTZYMo2MBor7a6bEqpK/D879kwcaNP2joPXZKvxle5iw5iqHQkfV9bVw2Mkm
         ZTo0a1KN6ApBd3D8x9OTyoSvAtzfmZEgc7DBzVw6clK5cfQwVefACgj9I/XZfkRTGblV
         2HG4UdJVj24zgbQzatUD6qOjE4dWfaFWaBlv1/lBANTyl+gbNkrsYZ36A1pxSvH7QSps
         aSwA==
X-Gm-Message-State: AOJu0YwD9O4r2dWo75M3a1Ldz7yzm5vsHujwUqN6pquRq7DnZNvFYuL2
        DgWMzFF2eskATwLT6zR88yZIGtdLhXhNzfJObTdgLg==
X-Google-Smtp-Source: AGHT+IEBOPIgzWEPrkCWpmD33g0+yB/c4yICiHcyrVFSnm9pg6eJIvZDZ8S7XXl7kWcRsWA4ibXnkdgzLTBWl6UwnBA=
X-Received: by 2002:a05:600c:6023:b0:3f1:70d1:21a6 with SMTP id
 az35-20020a05600c602300b003f170d121a6mr40027wmb.0.1691227057082; Sat, 05 Aug
 2023 02:17:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230804141446.21068-1-rf@opensource.cirrus.com>
In-Reply-To: <20230804141446.21068-1-rf@opensource.cirrus.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 5 Aug 2023 17:17:23 +0800
Message-ID: <CABVgOSmhj_Qu+NCCzCmVx9Z0n-pAD-s2UekbVv1Y-2kOnNN_NA@mail.gmail.com>
Subject: Re: [PATCH] kunit: Replace fixed-size log with dynamically-extending buffer
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     brendan.higgins@linux.dev, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, Rae Moar <rmoar@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000012f720602297caa"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--000000000000012f720602297caa
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Aug 2023 at 22:14, Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> Re-implement the log buffer as a list of buffer fragments that can
> be extended as the size of the log info grows.
>
> When using parameterization the test case can run many times and create
> a large amount of log. It's not really practical to keep increasing the
> size of the fixed buffer every time a test needs more space. And a big
> fixed buffer wastes memory.
>
> The original char *log pointer is replaced by a pointer to a list of
> struct kunit_log_frag, each containing a fixed-size buffer.
>
> kunit_log_append() now attempts to append to that last kunit_log_frag in
> the list. If there isn't enough space it will append a new kunit_log_frag
> to the list. This simple implementation does not attempt to completely
> fill the buffer in every kunit_log_frag.
>
> The 'log' member of kunit_suite, kunit_test_case and kunit_suite must be a
> pointer because the API of kunit_log() requires that is the same type in
> all  three structs. As kunit.log is a pointer to the 'log' of the current
> kunit_case, it must be a pointer in the other two structs.
>
> The existing kunit-test.c log tests have been updated for the new log
> buffer and a new kunit_log_extend_test() case to test extending the buffer.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---

+Rae, since she's the last person to touch the log code.

Thanks a bunch. Some way of handling longer logs has been on the to-do
list for a while, and this is probably better than the other options
of allowing per-test log sizes or using krealloc().

This mostly works okay here, but the test fails when running:
./tools/testing/kunit/kunit.py run --alltests
[17:05:12]     # kunit_log_extend_test: EXPECTATION FAILED at
lib/kunit/kunit-test.c:624
[17:05:12]     Expected sscanf(p, "The quick brown fox jumps over the
lazy penguin %d", &q) == 1, but
[17:05:12]         sscanf(p, "The quick brown fox jumps over the lazy
penguin %d", &q) == 0 (0x0)

I haven't found the cause of it, yet, but it happens both on UML and
QEMU x86_64.

>  include/kunit/test.h   | 25 +++++++++----
>  lib/kunit/debugfs.c    | 65 ++++++++++++++++++++++++++-------
>  lib/kunit/kunit-test.c | 82 +++++++++++++++++++++++++++++++++++++-----
>  lib/kunit/test.c       | 51 ++++++++++++++++----------
>  4 files changed, 177 insertions(+), 46 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 011e0d6bb506..907b30401669 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -33,8 +33,8 @@ DECLARE_STATIC_KEY_FALSE(kunit_running);
>
>  struct kunit;
>
> -/* Size of log associated with test. */
> -#define KUNIT_LOG_SIZE 2048
> +/* Initial size of log associated with test. */
> +#define KUNIT_DEFAULT_LOG_SIZE 500

Would it make more sense to call this KUNIT_LOG_FRAGMENT_SIZE or
similar, as not only is this the default size, but also the amount by
which the size is incremented.

Also, there's plenty of scope for bikeshedding the exact value of
this, two considerations being:
- Most tests have very small logs: we possibly should look into what
the average log size is.
- It may make sense to tweak the log size to fit nicely within common
allocation/page sizes. e.g., PAGE_SIZE-sizeof(struct list_head) or
something. Though that is probably too big by default.

>
>  /* Maximum size of parameter description string. */
>  #define KUNIT_PARAM_DESC_SIZE 128
> @@ -85,6 +85,11 @@ struct kunit_attributes {
>         enum kunit_speed speed;
>  };
>
> +struct kunit_log_frag {
> +       struct list_head list;
> +       char buf[KUNIT_DEFAULT_LOG_SIZE];
> +};
> +
>  /**
>   * struct kunit_case - represents an individual test case.
>   *
> @@ -132,7 +137,7 @@ struct kunit_case {
>         /* private: internal use only. */
>         enum kunit_status status;
>         char *module_name;
> -       char *log;
> +       struct list_head *log;
>  };
>
>  static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
> @@ -252,7 +257,7 @@ struct kunit_suite {
>         /* private: internal use only */
>         char status_comment[KUNIT_STATUS_COMMENT_SIZE];
>         struct dentry *debugfs;
> -       char *log;
> +       struct list_head *log;
>         int suite_init_err;
>  };
>
> @@ -272,7 +277,7 @@ struct kunit {
>
>         /* private: internal use only. */
>         const char *name; /* Read only after initialization! */
> -       char *log; /* Points at case log after initialization */
> +       struct list_head *log; /* Points at case log after initialization */
>         struct kunit_try_catch try_catch;
>         /* param_value is the current parameter value for a test case. */
>         const void *param_value;
> @@ -304,7 +309,7 @@ static inline void kunit_set_failure(struct kunit *test)
>
>  bool kunit_enabled(void);
>
> -void kunit_init_test(struct kunit *test, const char *name, char *log);
> +void kunit_init_test(struct kunit *test, const char *name, struct list_head *log);
>
>  int kunit_run_tests(struct kunit_suite *suite);
>
> @@ -317,6 +322,12 @@ int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_
>
>  void __kunit_test_suites_exit(struct kunit_suite **suites, int num_suites);
>
> +static inline void kunit_init_log_frag(struct kunit_log_frag *frag)
> +{
> +       INIT_LIST_HEAD(&frag->list);
> +       frag->buf[0] = '\0';
> +}
> +
>  #if IS_BUILTIN(CONFIG_KUNIT)
>  int kunit_run_all_tests(void);
>  #else
> @@ -451,7 +462,7 @@ static inline void *kunit_kcalloc(struct kunit *test, size_t n, size_t size, gfp
>
>  void kunit_cleanup(struct kunit *test);
>
> -void __printf(2, 3) kunit_log_append(char *log, const char *fmt, ...);
> +void __printf(2, 3) kunit_log_append(struct list_head *log, const char *fmt, ...);
>
>  /**
>   * kunit_mark_skipped() - Marks @test_or_suite as skipped
> diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
> index 22c5c496a68f..a26b6d31bd2f 100644
> --- a/lib/kunit/debugfs.c
> +++ b/lib/kunit/debugfs.c
> @@ -5,6 +5,7 @@
>   */
>
>  #include <linux/debugfs.h>
> +#include <linux/list.h>
>  #include <linux/module.h>
>
>  #include <kunit/test.h>
> @@ -37,14 +38,15 @@ void kunit_debugfs_init(void)
>                 debugfs_rootdir = debugfs_create_dir(KUNIT_DEBUGFS_ROOT, NULL);
>  }
>
> -static void debugfs_print_result(struct seq_file *seq,
> -                                struct kunit_suite *suite,
> -                                struct kunit_case *test_case)
> +static void debugfs_print_log(struct seq_file *seq, const struct list_head *log)
>  {
> -       if (!test_case || !test_case->log)
> +       struct kunit_log_frag *frag;
> +
> +       if (!log)
>                 return;
>
> -       seq_printf(seq, "%s", test_case->log);
> +       list_for_each_entry(frag, log, list)
> +               seq_puts(seq, frag->buf);
>  }
>
>  /*
> @@ -69,10 +71,9 @@ static int debugfs_print_results(struct seq_file *seq, void *v)
>         seq_printf(seq, KUNIT_SUBTEST_INDENT "1..%zd\n", kunit_suite_num_test_cases(suite));
>
>         kunit_suite_for_each_test_case(suite, test_case)
> -               debugfs_print_result(seq, suite, test_case);
> +               debugfs_print_log(seq, test_case->log);
>
> -       if (suite->log)
> -               seq_printf(seq, "%s", suite->log);
> +       debugfs_print_log(seq, suite->log);
>
>         seq_printf(seq, "%s %d %s\n",
>                    kunit_status_to_ok_not_ok(success), 1, suite->name);
> @@ -100,14 +101,53 @@ static const struct file_operations debugfs_results_fops = {
>         .release = debugfs_release,
>  };
>
> +static struct list_head *kunit_debugfs_alloc_log(void)
> +{
> +       struct list_head *log;
> +       struct kunit_log_frag *frag;
> +
> +       log = kzalloc(sizeof(*log), GFP_KERNEL);
> +       if (!log)
> +               return NULL;
> +
> +       INIT_LIST_HEAD(log);
> +
> +       frag = kmalloc(sizeof(*frag), GFP_KERNEL);
> +       if (!frag) {
> +               kfree(log);
> +               return NULL;
> +       }
> +
> +       kunit_init_log_frag(frag);
> +       list_add_tail(&frag->list, log);
> +
> +       return log;
> +}
> +
> +static void kunit_debugfs_free_log(struct list_head *log)
> +{
> +       struct kunit_log_frag *frag, *n;
> +
> +       if (!log)
> +               return;
> +
> +       list_for_each_entry_safe(frag, n, log, list) {
> +               list_del(&frag->list);
> +               kfree(frag);
> +       }
> +
> +       kfree(log);
> +}
> +
>  void kunit_debugfs_create_suite(struct kunit_suite *suite)
>  {
>         struct kunit_case *test_case;
>
>         /* Allocate logs before creating debugfs representation. */
> -       suite->log = kzalloc(KUNIT_LOG_SIZE, GFP_KERNEL);
> +       suite->log = kunit_debugfs_alloc_log();
> +
>         kunit_suite_for_each_test_case(suite, test_case)
> -               test_case->log = kzalloc(KUNIT_LOG_SIZE, GFP_KERNEL);
> +               test_case->log = kunit_debugfs_alloc_log();
>
>         suite->debugfs = debugfs_create_dir(suite->name, debugfs_rootdir);
>
> @@ -121,7 +161,8 @@ void kunit_debugfs_destroy_suite(struct kunit_suite *suite)
>         struct kunit_case *test_case;
>
>         debugfs_remove_recursive(suite->debugfs);
> -       kfree(suite->log);
> +       kunit_debugfs_free_log(suite->log);
> +
>         kunit_suite_for_each_test_case(suite, test_case)
> -               kfree(test_case->log);
> +               kunit_debugfs_free_log(test_case->log);
>  }
> diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
> index 83d8e90ca7a2..abf659c6ded4 100644
> --- a/lib/kunit/kunit-test.c
> +++ b/lib/kunit/kunit-test.c
> @@ -533,9 +533,16 @@ static struct kunit_suite kunit_resource_test_suite = {
>  static void kunit_log_test(struct kunit *test)
>  {
>         struct kunit_suite suite;
> +       struct kunit_log_frag *frag;
>
> -       suite.log = kunit_kzalloc(test, KUNIT_LOG_SIZE, GFP_KERNEL);
> +       suite.log = kunit_kzalloc(test, sizeof(*suite.log), GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, suite.log);
> +       INIT_LIST_HEAD(suite.log);
> +       frag = kunit_kmalloc(test, sizeof(*frag), GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, frag);
> +       kunit_init_log_frag(frag);
> +       KUNIT_ASSERT_EQ(test, frag->buf[0], '\0');
> +       list_add_tail(&frag->list, suite.log);
>
>         kunit_log(KERN_INFO, test, "put this in log.");
>         kunit_log(KERN_INFO, test, "this too.");
> @@ -543,14 +550,17 @@ static void kunit_log_test(struct kunit *test)
>         kunit_log(KERN_INFO, &suite, "along with this.");
>
>  #ifdef CONFIG_KUNIT_DEBUGFS
> +       frag = list_first_entry(test->log, struct kunit_log_frag, list);
>         KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
> -                                    strstr(test->log, "put this in log."));
> +                                    strstr(frag->buf, "put this in log."));
>         KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
> -                                    strstr(test->log, "this too."));
> +                                    strstr(frag->buf, "this too."));
> +
> +       frag = list_first_entry(suite.log, struct kunit_log_frag, list);
>         KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
> -                                    strstr(suite.log, "add to suite log."));
> +                                    strstr(frag->buf, "add to suite log."));
>         KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
> -                                    strstr(suite.log, "along with this."));
> +                                    strstr(frag->buf, "along with this."));
>  #else
>         KUNIT_EXPECT_NULL(test, test->log);
>  #endif
> @@ -558,19 +568,75 @@ static void kunit_log_test(struct kunit *test)
>
>  static void kunit_log_newline_test(struct kunit *test)
>  {
> +       struct kunit_log_frag *frag;
> +
>         kunit_info(test, "Add newline\n");
>         if (test->log) {
> -               KUNIT_ASSERT_NOT_NULL_MSG(test, strstr(test->log, "Add newline\n"),
> -                       "Missing log line, full log:\n%s", test->log);
> -               KUNIT_EXPECT_NULL(test, strstr(test->log, "Add newline\n\n"));
> +               frag = list_first_entry(test->log, struct kunit_log_frag, list);
> +               KUNIT_ASSERT_NOT_NULL_MSG(test, strstr(frag->buf, "Add newline\n"),
> +                       "Missing log line, full log:\n%s", frag->buf);
> +               KUNIT_EXPECT_NULL(test, strstr(frag->buf, "Add newline\n\n"));
>         } else {
>                 kunit_skip(test, "only useful when debugfs is enabled");
>         }
>  }
>
> +static void kunit_log_extend_test(struct kunit *test)
> +{
> +#ifdef CONFIG_KUNIT_DEBUGFS
> +       struct kunit_suite suite;
> +       struct kunit_log_frag *frag;
> +       char *p, *pn;
> +       size_t len;
> +       int i, q;
> +
> +       suite.log = kunit_kzalloc(test, sizeof(*suite.log), GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, suite.log);
> +       INIT_LIST_HEAD(suite.log);
> +       frag = kunit_kmalloc(test, sizeof(*frag), GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, frag);
> +       kunit_init_log_frag(frag);
> +       KUNIT_ASSERT_EQ(test, frag->buf[0], '\0');
> +       list_add_tail(&frag->list, suite.log);
> +
> +       for (i = 0; i < KUNIT_DEFAULT_LOG_SIZE; ++i) {
> +               kunit_log(KERN_INFO, &suite,
> +                         "The quick brown fox jumps over the lazy penguin %d\n", i);
> +       }
> +
> +       /* There must be more than one buffer fragment now */
> +       KUNIT_ASSERT_FALSE(test, list_is_singular(suite.log));
> +
> +       /* Copy all the data into a contiguous string for easier parsing */
> +       len = 0;
> +       list_for_each_entry(frag, suite.log, list)
> +               len += strlen(frag->buf);
> +
> +       p = kunit_kmalloc(test, len + 1, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p);
> +
> +       list_for_each_entry(frag, suite.log, list)
> +               strlcat(p, frag->buf, len);
> +
> +       i = 0;
> +       while ((pn = strchr(p, '\n')) != NULL) {
> +               *pn = '\0';
> +               KUNIT_ASSERT_EQ(test, sscanf(p,
> +                                            "The quick brown fox jumps over the lazy penguin %d\n",

Do we want the '\n' at the end of this if we're overwriting it above?

> +                                            &q), 1);
> +               KUNIT_ASSERT_EQ(test, q, i);

Could we make these KUNIT_EXPECT_EQ? I'd rather not have this kill the
test thread.

> +               p = pn + 1;
> +               ++i;
> +       }
> +#else
> +       kunit_skip(test, "only useful when debugfs is enabled");
> +#endif
> +}
> +
>  static struct kunit_case kunit_log_test_cases[] = {
>         KUNIT_CASE(kunit_log_test),
>         KUNIT_CASE(kunit_log_newline_test),
> +       KUNIT_CASE(kunit_log_extend_test),
>         {}
>  };
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index cb9797fa6303..f90e395b3656 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -11,6 +11,7 @@
>  #include <kunit/test-bug.h>
>  #include <kunit/attributes.h>
>  #include <linux/kernel.h>
> +#include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <linux/panic.h>
> @@ -114,46 +115,54 @@ static void kunit_print_test_stats(struct kunit *test,
>   * already present.
>   * @log: The log to add the newline to.
>   */
> -static void kunit_log_newline(char *log)
> +static void kunit_log_newline(struct kunit_log_frag *frag)
>  {
>         int log_len, len_left;
>
> -       log_len = strlen(log);
> -       len_left = KUNIT_LOG_SIZE - log_len - 1;
> +       log_len = strlen(frag->buf);
> +       len_left = sizeof(frag->buf) - log_len - 1;
>
> -       if (log_len > 0 && log[log_len - 1] != '\n')
> -               strncat(log, "\n", len_left);
> +       if (log_len > 0 && frag->buf[log_len - 1] != '\n')
> +               strncat(frag->buf, "\n", len_left);
>  }
>
> -/*
> - * Append formatted message to log, size of which is limited to
> - * KUNIT_LOG_SIZE bytes (including null terminating byte).
> - */
> -void kunit_log_append(char *log, const char *fmt, ...)
> +/* Append formatted message to log, extending the log buffer if necessary. */
> +void kunit_log_append(struct list_head *log, const char *fmt, ...)
>  {
>         va_list args;
> +       struct kunit_log_frag *frag;
>         int len, log_len, len_left;
>
>         if (!log)
>                 return;
>
> -       log_len = strlen(log);
> -       len_left = KUNIT_LOG_SIZE - log_len - 1;
> -       if (len_left <= 0)
> -               return;
> +       frag = list_last_entry(log, struct kunit_log_frag, list);
> +       log_len = strlen(frag->buf);
> +       len_left = sizeof(frag->buf) - log_len - 1;
>
>         /* Evaluate length of line to add to log */
>         va_start(args, fmt);
>         len = vsnprintf(NULL, 0, fmt, args) + 1;
>         va_end(args);
>
> +       if (len > len_left) {
> +               frag = kmalloc(sizeof(*frag), GFP_KERNEL);
> +               if (!frag)
> +                       return;
> +
> +               kunit_init_log_frag(frag);
> +               list_add_tail(&frag->list, log);
> +               len_left = sizeof(frag->buf) - 1;
> +               log_len = 0;
> +       }
> +
>         /* Print formatted line to the log */
>         va_start(args, fmt);
> -       vsnprintf(log + log_len, min(len, len_left), fmt, args);
> +       vsnprintf(frag->buf + log_len, min(len, len_left), fmt, args);
>         va_end(args);
>
>         /* Add newline to end of log if not already present. */
> -       kunit_log_newline(log);
> +       kunit_log_newline(frag);
>  }
>  EXPORT_SYMBOL_GPL(kunit_log_append);
>
> @@ -359,14 +368,18 @@ void __kunit_do_failed_assertion(struct kunit *test,
>  }
>  EXPORT_SYMBOL_GPL(__kunit_do_failed_assertion);
>
> -void kunit_init_test(struct kunit *test, const char *name, char *log)
> +void kunit_init_test(struct kunit *test, const char *name, struct list_head *log)
>  {
>         spin_lock_init(&test->lock);
>         INIT_LIST_HEAD(&test->resources);
>         test->name = name;
>         test->log = log;
> -       if (test->log)
> -               test->log[0] = '\0';
> +       if (test->log) {
> +               struct kunit_log_frag *frag = list_first_entry(test->log,
> +                                                              struct kunit_log_frag,
> +                                                              list);
> +               frag->buf[0] = '\0';
> +       }
>         test->status = KUNIT_SUCCESS;
>         test->status_comment[0] = '\0';
>  }
> --
> 2.30.2
>

--000000000000012f720602297caa
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
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCD8
BpmJxfLrhZUGw5cBs7P3jBwPORXVBgl+jYBHtLL0rzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA4MDUwOTE3MzdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAkq4eZvpx/KkzdmaFdpjM
2+5Jl2Wcs2Gc4QMlXBwXmlPTlpHtYr1mPzp7R/Fcq//iSaQ4DqK9a4zoMvleI7VL27LtkiuVzZlN
xBRvimn77ovFX+lBKh+SrnCSc5kLJMsvuSy8ZZqGhZriW5CXdj0SQCx6p6qoSuumRMFyjDoQq6BA
xCjTd84VnN3FWpwkd8pAV8dNDkpb8gdVeUf9TXVxH/Ia14VLkaUZVpbDrtEaHCv9NvjYXOHHBL9c
8LpkoUetVdF5sC8lAMU75pA3MUHOTIdcbYJoqh42+jThN4n3sYOrnfxkBsSMjaavlLqu+VK9JurU
Tx6gZ/6KiZ7QAiXUog==
--000000000000012f720602297caa--
