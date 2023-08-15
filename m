Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9CE77CA48
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 11:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235984AbjHOJSy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 05:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236194AbjHOJSL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 05:18:11 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2252F2D69
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Aug 2023 02:17:14 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe32ec7201so53455e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Aug 2023 02:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692091032; x=1692695832;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GowF5CTLVR7Avf9e8beD6iYwXoQ+CRQxPiz2QfNik1I=;
        b=BfPcREk2dM9/BJY5f9sJlyxLJEnxyAEtcbOHs6O/+TsIiVONEV5YxQslJDQ5te6p9n
         K6kHfOdF4oW/MjzhN1fpYb62GqkUBC9vms1rEX24MyOIYSMTozdD/e6sZ0/0bQG0+iva
         OOxEztQvMygDUP+qKfXhJ55BPL/n8m+5i+GOwUs6RKccVvuUKPcnmd+gt2ZrULIwc36A
         AlxSDMcxrLe7yP5Q0fvgsOv5FxkomSwkH8lCPdyJRc95si4S1i0Y41lhHkDZYjA4P6Dd
         YbqP/zU3g5sBGBKZHWoJj9/1HzecgzTWs3wCcjU5NBYYjMTB8ngoV1W9gUmhYo55mP02
         h7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692091032; x=1692695832;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GowF5CTLVR7Avf9e8beD6iYwXoQ+CRQxPiz2QfNik1I=;
        b=IDV/kjqebMVs3CBfKNdYqhaE5lLjpF5wAH+n0++RZqRVTTVPl62wBZHbIkYG71JQh2
         DiMDrv3q22EyXrOGBRXdUvb6cCKc7wWFsKcLPpuQLBtDCYoZeFRrwGYIWjRJqG6Qgz6v
         R6EB8PJmiMNqu7xaZUnW/ezjZOper1Jhj+GaKaMf8VDQ7iHVnIwnCj5RGj9QF7fky150
         PMfkNhUPY0uABoVg4CByfYoH11ntVeJaZT9O5eek5SHfEXNwD1IERkuHQyzCijs2p7KB
         me/+sl2axZYH8wT4RkOrzmSF9FS3YNiJfiox5/oDQBzSNOAjXHtCfvljgeQ4NNU1s6xZ
         GsRg==
X-Gm-Message-State: AOJu0YypksXwt/kxaOtKOkMcgCI7Ec4nMf8OXuOCQHmLysuDNt4Gl4V1
        ib+/h9nBQ75hXVclCxWOT55Zpw+s9DUbnS4dnqjr4Q==
X-Google-Smtp-Source: AGHT+IH7NENnkb2762z3k+rO3X2TULZLhNtmRS4BtWaJ8tp1cEmmOq/bR8CP7HqYQMaDVetzSMsbeP0Cw8lphOr1OUw=
X-Received: by 2002:a05:600c:1d84:b0:3f1:73b8:b5fe with SMTP id
 p4-20020a05600c1d8400b003f173b8b5femr368187wms.3.1692091032704; Tue, 15 Aug
 2023 02:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132309.32641-1-rf@opensource.cirrus.com> <20230814132309.32641-10-rf@opensource.cirrus.com>
In-Reply-To: <20230814132309.32641-10-rf@opensource.cirrus.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 15 Aug 2023 17:17:00 +0800
Message-ID: <CABVgOSn8eKwCAKwk7befTn1BYNRTTrGzEVBykNdXpqUZYqy7Hw@mail.gmail.com>
Subject: Re: [PATCH v4 09/10] kunit: Use string_stream for test log
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     brendan.higgins@linux.dev, rmoar@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000f22d7b0602f2a480"
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

--000000000000f22d7b0602f2a480
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Aug 2023 at 21:23, Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> Replace the fixed-size log buffer with a string_stream so that the
> log can grow as lines are added.
>
> The existing kunit log tests have been updated for using a
> string_stream as the log. As they now depend on string_stream
> functions they cannot build when kunit-test is a module. They have
> been moved to a separate source file to be built only if kunit-test
> is built-in.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---

Yay! This is much nicer.

A part of me wonders if it makes sense to do something to allow the
tests to continue to work as a module (either exporting the needed
string stream functions, or moving the tests into the main KUnit
module, and just exporting the suite definition to a stub module).
Probably not worth it, though...

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  include/kunit/test.h   | 14 ++++----
>  lib/kunit/Makefile     |  5 +--
>  lib/kunit/debugfs.c    | 36 +++++++++++++--------
>  lib/kunit/kunit-test.c | 52 +-----------------------------
>  lib/kunit/log-test.c   | 72 ++++++++++++++++++++++++++++++++++++++++++
>  lib/kunit/test.c       | 44 +++-----------------------
>  6 files changed, 110 insertions(+), 113 deletions(-)
>  create mode 100644 lib/kunit/log-test.c
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index d33114097d0d..b915a0fe93c0 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -32,9 +32,7 @@
>  DECLARE_STATIC_KEY_FALSE(kunit_running);
>
>  struct kunit;
> -
> -/* Size of log associated with test. */
> -#define KUNIT_LOG_SIZE 2048
> +struct string_stream;
>
>  /* Maximum size of parameter description string. */
>  #define KUNIT_PARAM_DESC_SIZE 128
> @@ -132,7 +130,7 @@ struct kunit_case {
>         /* private: internal use only. */
>         enum kunit_status status;
>         char *module_name;
> -       char *log;
> +       struct string_stream *log;
>  };
>
>  static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
> @@ -252,7 +250,7 @@ struct kunit_suite {
>         /* private: internal use only */
>         char status_comment[KUNIT_STATUS_COMMENT_SIZE];
>         struct dentry *debugfs;
> -       char *log;
> +       struct string_stream *log;
>         int suite_init_err;
>  };
>
> @@ -278,7 +276,7 @@ struct kunit {
>
>         /* private: internal use only. */
>         const char *name; /* Read only after initialization! */
> -       char *log; /* Points at case log after initialization */
> +       struct string_stream *log; /* Points at case log after initialization */
>         struct kunit_try_catch try_catch;
>         /* param_value is the current parameter value for a test case. */
>         const void *param_value;
> @@ -314,7 +312,7 @@ const char *kunit_filter_glob(void);
>  char *kunit_filter(void);
>  char *kunit_filter_action(void);
>
> -void kunit_init_test(struct kunit *test, const char *name, char *log);
> +void kunit_init_test(struct kunit *test, const char *name, struct string_stream *log);
>
>  int kunit_run_tests(struct kunit_suite *suite);
>
> @@ -472,7 +470,7 @@ static inline void *kunit_kcalloc(struct kunit *test, size_t n, size_t size, gfp
>
>  void kunit_cleanup(struct kunit *test);
>
> -void __printf(2, 3) kunit_log_append(char *log, const char *fmt, ...);
> +void __printf(2, 3) kunit_log_append(struct string_stream *log, const char *fmt, ...);
>
>  /**
>   * kunit_mark_skipped() - Marks @test_or_suite as skipped
> diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> index 46f75f23dfe4..65735c2e1d14 100644
> --- a/lib/kunit/Makefile
> +++ b/lib/kunit/Makefile
> @@ -18,9 +18,10 @@ obj-y +=                             hooks.o
>
>  obj-$(CONFIG_KUNIT_TEST) +=            kunit-test.o
>
> -# string-stream-test compiles built-in only.
> +# string-stream-test and log-test compiles built-in only.
>  ifeq ($(CONFIG_KUNIT_TEST),y)
> -obj-$(CONFIG_KUNIT_TEST) +=            string-stream-test.o
> +obj-$(CONFIG_KUNIT_TEST) +=            string-stream-test.o \
> +                                       log-test.o
>  endif
>
>  obj-$(CONFIG_KUNIT_EXAMPLE_TEST) +=    kunit-example-test.o
> diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
> index 22c5c496a68f..ab53a7e5c898 100644
> --- a/lib/kunit/debugfs.c
> +++ b/lib/kunit/debugfs.c
> @@ -37,14 +37,21 @@ void kunit_debugfs_init(void)
>                 debugfs_rootdir = debugfs_create_dir(KUNIT_DEBUGFS_ROOT, NULL);
>  }
>
> -static void debugfs_print_result(struct seq_file *seq,
> -                                struct kunit_suite *suite,
> -                                struct kunit_case *test_case)
> +static void debugfs_print_result(struct seq_file *seq, struct string_stream *log)
>  {
> -       if (!test_case || !test_case->log)
> +       struct string_stream_fragment *frag_container;
> +
> +       if (!log)
>                 return;
>
> -       seq_printf(seq, "%s", test_case->log);
> +       /*
> +        * Walk the fragments so we don't need to allocate a temporary
> +        * buffer to hold the entire string.
> +        */
> +       spin_lock(&log->lock);
> +       list_for_each_entry(frag_container, &log->fragments, node)
> +               seq_printf(seq, "%s", frag_container->fragment);
> +       spin_unlock(&log->lock);
>  }
>
>  /*
> @@ -69,10 +76,9 @@ static int debugfs_print_results(struct seq_file *seq, void *v)
>         seq_printf(seq, KUNIT_SUBTEST_INDENT "1..%zd\n", kunit_suite_num_test_cases(suite));
>
>         kunit_suite_for_each_test_case(suite, test_case)
> -               debugfs_print_result(seq, suite, test_case);
> +               debugfs_print_result(seq, test_case->log);
>
> -       if (suite->log)
> -               seq_printf(seq, "%s", suite->log);
> +       debugfs_print_result(seq, suite->log);
>
>         seq_printf(seq, "%s %d %s\n",
>                    kunit_status_to_ok_not_ok(success), 1, suite->name);
> @@ -105,9 +111,13 @@ void kunit_debugfs_create_suite(struct kunit_suite *suite)
>         struct kunit_case *test_case;
>
>         /* Allocate logs before creating debugfs representation. */
> -       suite->log = kzalloc(KUNIT_LOG_SIZE, GFP_KERNEL);
> -       kunit_suite_for_each_test_case(suite, test_case)
> -               test_case->log = kzalloc(KUNIT_LOG_SIZE, GFP_KERNEL);
> +       suite->log = raw_alloc_string_stream(GFP_KERNEL);
> +       string_stream_set_append_newlines(suite->log, true);
> +
> +       kunit_suite_for_each_test_case(suite, test_case) {
> +               test_case->log = raw_alloc_string_stream(GFP_KERNEL);
> +               string_stream_set_append_newlines(test_case->log, true);
> +       }
>
>         suite->debugfs = debugfs_create_dir(suite->name, debugfs_rootdir);
>
> @@ -121,7 +131,7 @@ void kunit_debugfs_destroy_suite(struct kunit_suite *suite)
>         struct kunit_case *test_case;
>
>         debugfs_remove_recursive(suite->debugfs);
> -       kfree(suite->log);
> +       raw_free_string_stream(suite->log);
>         kunit_suite_for_each_test_case(suite, test_case)
> -               kfree(test_case->log);
> +               raw_free_string_stream(test_case->log);
>  }
> diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
> index 83d8e90ca7a2..ecc39d5f7411 100644
> --- a/lib/kunit/kunit-test.c
> +++ b/lib/kunit/kunit-test.c
> @@ -530,55 +530,6 @@ static struct kunit_suite kunit_resource_test_suite = {
>         .test_cases = kunit_resource_test_cases,
>  };
>
> -static void kunit_log_test(struct kunit *test)
> -{
> -       struct kunit_suite suite;
> -
> -       suite.log = kunit_kzalloc(test, KUNIT_LOG_SIZE, GFP_KERNEL);
> -       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, suite.log);
> -
> -       kunit_log(KERN_INFO, test, "put this in log.");
> -       kunit_log(KERN_INFO, test, "this too.");
> -       kunit_log(KERN_INFO, &suite, "add to suite log.");
> -       kunit_log(KERN_INFO, &suite, "along with this.");
> -
> -#ifdef CONFIG_KUNIT_DEBUGFS
> -       KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
> -                                    strstr(test->log, "put this in log."));
> -       KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
> -                                    strstr(test->log, "this too."));
> -       KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
> -                                    strstr(suite.log, "add to suite log."));
> -       KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
> -                                    strstr(suite.log, "along with this."));
> -#else
> -       KUNIT_EXPECT_NULL(test, test->log);
> -#endif
> -}
> -
> -static void kunit_log_newline_test(struct kunit *test)
> -{
> -       kunit_info(test, "Add newline\n");
> -       if (test->log) {
> -               KUNIT_ASSERT_NOT_NULL_MSG(test, strstr(test->log, "Add newline\n"),
> -                       "Missing log line, full log:\n%s", test->log);
> -               KUNIT_EXPECT_NULL(test, strstr(test->log, "Add newline\n\n"));
> -       } else {
> -               kunit_skip(test, "only useful when debugfs is enabled");
> -       }
> -}
> -
> -static struct kunit_case kunit_log_test_cases[] = {
> -       KUNIT_CASE(kunit_log_test),
> -       KUNIT_CASE(kunit_log_newline_test),
> -       {}
> -};
> -
> -static struct kunit_suite kunit_log_test_suite = {
> -       .name = "kunit-log-test",
> -       .test_cases = kunit_log_test_cases,
> -};
> -
>  static void kunit_status_set_failure_test(struct kunit *test)
>  {
>         struct kunit fake;
> @@ -658,7 +609,6 @@ static struct kunit_suite kunit_current_test_suite = {
>  };
>
>  kunit_test_suites(&kunit_try_catch_test_suite, &kunit_resource_test_suite,
> -                 &kunit_log_test_suite, &kunit_status_test_suite,
> -                 &kunit_current_test_suite);
> +                 &kunit_status_test_suite, &kunit_current_test_suite);
>
>  MODULE_LICENSE("GPL v2");
> diff --git a/lib/kunit/log-test.c b/lib/kunit/log-test.c
> new file mode 100644
> index 000000000000..a93d87112fea
> --- /dev/null
> +++ b/lib/kunit/log-test.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit test for logging.
> + *
> + * Based on code:
> + * Copyright (C) 2019, Google LLC.
> + * Author: Brendan Higgins <brendanhiggins@google.com>
> + */
> +#include <kunit/test.h>
> +
> +#include "string-stream.h"
> +
> +static void kunit_log_test(struct kunit *test)
> +{
> +       struct kunit_suite suite;
> +       char *full_log;
> +
> +       suite.log = alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, suite.log);
> +       string_stream_set_append_newlines(suite.log, true);
> +
> +       kunit_log(KERN_INFO, test, "put this in log.");
> +       kunit_log(KERN_INFO, test, "this too.");
> +       kunit_log(KERN_INFO, &suite, "add to suite log.");
> +       kunit_log(KERN_INFO, &suite, "along with this.");
> +
> +#ifdef CONFIG_KUNIT_DEBUGFS
> +       KUNIT_EXPECT_TRUE(test, test->log->append_newlines);
> +
> +       full_log = string_stream_get_string(test, test->log, GFP_KERNEL);
> +       KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
> +                                    strstr(full_log, "put this in log."));
> +       KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
> +                                    strstr(full_log, "this too."));
> +
> +       full_log = string_stream_get_string(test, suite.log, GFP_KERNEL);
> +       KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
> +                                    strstr(full_log, "add to suite log."));
> +       KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
> +                                    strstr(full_log, "along with this."));
> +#else
> +       KUNIT_EXPECT_NULL(test, test->log);
> +#endif
> +}
> +
> +static void kunit_log_newline_test(struct kunit *test)
> +{
> +       char *full_log;
> +
> +       kunit_info(test, "Add newline\n");
> +       if (test->log) {
> +               full_log = string_stream_get_string(test, test->log, GFP_KERNEL);
> +               KUNIT_ASSERT_NOT_NULL_MSG(test, strstr(full_log, "Add newline\n"),
> +                       "Missing log line, full log:\n%s", full_log);
> +               KUNIT_EXPECT_NULL(test, strstr(full_log, "Add newline\n\n"));
> +       } else {
> +               kunit_skip(test, "only useful when debugfs is enabled");
> +       }
> +}
> +
> +static struct kunit_case kunit_log_test_cases[] = {
> +       KUNIT_CASE(kunit_log_test),
> +       KUNIT_CASE(kunit_log_newline_test),
> +       {}
> +};
> +
> +static struct kunit_suite kunit_log_test_suite = {
> +       .name = "kunit-log-test",
> +       .test_cases = kunit_log_test_cases,
> +};
> +
> +kunit_test_suites(&kunit_log_test_suite);
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 4b69d12dfc96..14e889e80129 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -109,51 +109,17 @@ static void kunit_print_test_stats(struct kunit *test,
>                   stats.total);
>  }
>
> -/**
> - * kunit_log_newline() - Add newline to the end of log if one is not
> - * already present.
> - * @log: The log to add the newline to.
> - */
> -static void kunit_log_newline(char *log)
> -{
> -       int log_len, len_left;
> -
> -       log_len = strlen(log);
> -       len_left = KUNIT_LOG_SIZE - log_len - 1;
> -
> -       if (log_len > 0 && log[log_len - 1] != '\n')
> -               strncat(log, "\n", len_left);
> -}
> -
> -/*
> - * Append formatted message to log, size of which is limited to
> - * KUNIT_LOG_SIZE bytes (including null terminating byte).
> - */
> -void kunit_log_append(char *log, const char *fmt, ...)
> +/* Append formatted message to log. */
> +void kunit_log_append(struct string_stream *log, const char *fmt, ...)
>  {
>         va_list args;
> -       int len, log_len, len_left;
>
>         if (!log)
>                 return;
>
> -       log_len = strlen(log);
> -       len_left = KUNIT_LOG_SIZE - log_len - 1;
> -       if (len_left <= 0)
> -               return;
> -
> -       /* Evaluate length of line to add to log */
>         va_start(args, fmt);
> -       len = vsnprintf(NULL, 0, fmt, args) + 1;
> +       string_stream_vadd(log, fmt, args);
>         va_end(args);
> -
> -       /* Print formatted line to the log */
> -       va_start(args, fmt);
> -       vsnprintf(log + log_len, min(len, len_left), fmt, args);
> -       va_end(args);
> -
> -       /* Add newline to end of log if not already present. */
> -       kunit_log_newline(log);
>  }
>  EXPORT_SYMBOL_GPL(kunit_log_append);
>
> @@ -359,14 +325,14 @@ void __kunit_do_failed_assertion(struct kunit *test,
>  }
>  EXPORT_SYMBOL_GPL(__kunit_do_failed_assertion);
>
> -void kunit_init_test(struct kunit *test, const char *name, char *log)
> +void kunit_init_test(struct kunit *test, const char *name, struct string_stream *log)
>  {
>         spin_lock_init(&test->lock);
>         INIT_LIST_HEAD(&test->resources);
>         test->name = name;
>         test->log = log;
>         if (test->log)
> -               test->log[0] = '\0';
> +               string_stream_clear(log);
>         test->status = KUNIT_SUCCESS;
>         test->status_comment[0] = '\0';
>  }
> --
> 2.30.2
>

--000000000000f22d7b0602f2a480
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
LmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5n
bG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG9w0BAQsFAAOCAQEANyYcO+9JZYyqQt41
TMwvFWAw3vLoLOQIfIn48/yea/ekOcParTb0mbhsvVSZ6sGn+txYAZb33wIb1f4wK4xQ7+RUYBfI
TuTPL7olF9hDpojC2F6Eu8nuEf1XD9qNI8zFd4kfjg4rb+AME0L81WaCL/WhP2kDCnRU4jm6TryB
CHhZqtxkIvXGPGHjwJJazJBnX5NayIce4fGuUEJ7HkuCthVZ3Rws0UyHSAXesT/0tXATND4mNr1X
El6adiSQy619ybVERnRi5aDe1PTwE+qNiotEEaeujz1a/+yYaaTY+k+qJcVxi7tbyQ0hi0UB3myM
A/z2HmGEwO8hx7hDjKmKbDCCA18wggJHoAMCAQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUA
MEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWdu
MRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEg
MB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzAR
BgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4
Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0EXyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuu
l9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+JJ5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJ
pij2aTv2y8gokeWdimFXN6x0FNx04Druci8unPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh
6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTvriBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti
+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGjQjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8E
BTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5NUPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEA
S0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigHM8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9u
bG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmUY/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaM
ld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88
q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcya5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/f
hO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/XzCCBNgwggPAoAMCAQICEAHOBX7j6YmdTMbtcPLp
3a4wDQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjMgU01JTUUgQ0EgMjAyMDAeFw0yMzA4MTUw
MjQyNDNaFw0yNDAyMTEwMjQyNDNaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5j
b20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCnYKS3ueVXUlVatkXVQgk8pbgZH4/s
KBKSGW9Z8e4hylAI35vqFf5f5D4U5KhUYUyG0+AYhurwEiUyZUhGcLqRNmSroohx9nbZjXDXjkVV
LXBAr7xaCU3DDQcA1SaxmALxBC7u4zlcVHfUKope2JNJ2xn5kU0Z/kr01tZuJD5/jn+2hp68jdym
tbFd3zzOJmtG6hb4ULJNXSi1qkjtZp6SyDLEsliQGRuI5AIha7GQPeSNsFmIpi+V5UxhrznuAv0y
Uxd27MtO+/mgSMpLmUb4vuSjy2zuftatzVYvFG00pfHldrnJ1od+kW8lAl6gyahVgMp+j3GAlO2M
oGCkihK9AgMBAAGjggHUMIIB0DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1Ud
DwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFJO3Y8Jq
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDi
/zrIVDDDqQzRfBT8ogUek3FH/593Th6h+/v18YvFGDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA4MTUwOTE3MTJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAJltIJQ3AdI1MpuYUk2r9
1JjknYVx3AemAfCAnPotqnHCZN31+/3xzgHMPvx0xy/tzWhtEQ14OMW+6JBMLnpjEU1VWF21f2W5
xxoD5ETsRX39d1s/TBMCyQOy/+1AzG4xMDEX41qfv7OGo0RKPEMsEydXPM40y8pQokRND+Qz2OFa
Xzk7wtZ/r0kqTtlf+C3sOCOh8Vky0OO4/8QKzFduLYQPSkXmbM6cYGeqlQ10XUHCw/bsdX3ZbyWH
3pSNTswSLXHKx9o2t+IaQx1fyKct0TM1EGwpJkylTvk6AxeW4BoB3vGaVF87bkxlAF2hykUGBjZC
vfdog7iBxh7mJ+/XTw==
--000000000000f22d7b0602f2a480--
