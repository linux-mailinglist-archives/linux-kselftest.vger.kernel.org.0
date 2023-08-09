Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F22776AC5
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 23:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjHIVK1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 17:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjHIVK0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 17:10:26 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E239138
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Aug 2023 14:10:25 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5232ce75e26so1051a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Aug 2023 14:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691615423; x=1692220223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUUJG0MgUPIhVfE7XO1eY6FEDQeALpXzOJ8XwzAW1vI=;
        b=pVNJfDYoimKs5NalFx4gxf/0Lqv99U2PoRNgcWvM80UAmKcOc/Q1G+yTi3Le+KcxCE
         rD5/OhxnAPH4uWHHEeWfzD5nFG3D8puqeLFqd3fjyWQdx+3k0BoZvEclFQwqDRkHCe9l
         wzBZTsBdnLOAcuQbOeuCbM+XKRjBodzx8btNshHR/mfAd1kPeYcTVPc+j00S8aZJ6aCx
         lS0zhxc36Fv/1DyOxRLsB/V1NdQ310wb0yBOh4rT6r808rA0No99rFds977poVNPEAf3
         F/NeyQ5SnDK3JpSmSquKnpbUQUXmT9+cu4JPytt+NGjGJP51K7xEDbIdR62Mt2rIKzBX
         GEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691615423; x=1692220223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUUJG0MgUPIhVfE7XO1eY6FEDQeALpXzOJ8XwzAW1vI=;
        b=AnfK7YS54jJBSnslEhSJZFYZfnrIEwHNeO1L5/ydR6ZSg8T2ka+iPB0iLbX1UXXcub
         HMsDZPLc/HMTvQhy2h2iYCAx4wsu7y+ntHvcBwwhWemY9goj2j1lDKY2axQ5OCkiaPPR
         DrQnjJXkZBcMMCYK6vfxz/7+Skxszf7v1u0+bYj/QzS+ZzVCyFCP00xLGWt2LjMCf65Z
         PRHIwdLg64n6V0YQwPE2A05f26wvfI+zakuXV4rEJ8MqAnHR94hYEaJWP8UuO0snaNG0
         6HQQ6jA3NA2C0rNOtEqgLiJTfklHUKqUX6/7mJXPLV6JoVxnPTeYgtD3Og5tTcu54934
         buwA==
X-Gm-Message-State: AOJu0YwWKU6AdtaoTtL3wVEtzRY/sScUxTe8h+rzQAECFXaFddhqYUxm
        Mo2osjOmSD4IP19Zk0nJmUxmQ6+XxTgDdCT8qrnj1w==
X-Google-Smtp-Source: AGHT+IHPu0xHWCL7IYW9JpAVRCVN9SFYN8/ra5QnSOBvLsLmm70ZvRI97pTD2EqICi+WHdjcG7Ao2PJ/MdCdexLPl+A=
X-Received: by 2002:a50:c35d:0:b0:506:b280:4993 with SMTP id
 q29-20020a50c35d000000b00506b2804993mr188666edb.2.1691615423376; Wed, 09 Aug
 2023 14:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230809155438.22470-1-rf@opensource.cirrus.com> <20230809155438.22470-2-rf@opensource.cirrus.com>
In-Reply-To: <20230809155438.22470-2-rf@opensource.cirrus.com>
From:   Rae Moar <rmoar@google.com>
Date:   Wed, 9 Aug 2023 17:10:11 -0400
Message-ID: <CA+GJov78V_8OE7Pveik-hv8+HRFSFzaWejoZLY32GCWg2gNOPA@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] kunit: Replace fixed-size log with
 dynamically-extending buffer
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     brendan.higgins@linux.dev, davidgow@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 9, 2023 at 11:54=E2=80=AFAM Richard Fitzgerald
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
> kunit_log_append() now attempts to append to the last kunit_log_frag in
> the list. If there isn't enough space it will append a new kunit_log_frag
> to the list. This simple implementation does not attempt to completely
> fill the buffer in every kunit_log_frag.
>
> The 'log' member of kunit_suite, kunit_test_case and kunit_suite must be =
a
> pointer because the API of kunit_log() requires that is the same type in
> all  three structs. As kunit.log is a pointer to the 'log' of the current
> kunit_case, it must be a pointer in the other two structs.
>
> The existing kunit-test.c log tests have been updated to build against th=
e
> new fragmented log implementation. If the test fails the new function
> get_concatenated_log() constructs a single contiguous string from the
> log fragments so that the whole log can be emitted in the failure
> message.

Hello!

All the tests now pass for me and this patch now looks good to me. I
have tested it and it seems to be working well.

I just have a few nits below. But I am overall happy with this patch.

Reviewed-by: Rae Moar <rmoar@google.com>

-Rae

>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  include/kunit/test.h   | 25 +++++++++++-----
>  lib/kunit/debugfs.c    | 65 ++++++++++++++++++++++++++++++++++--------
>  lib/kunit/kunit-test.c | 48 +++++++++++++++++++++++++------
>  lib/kunit/test.c       | 63 ++++++++++++++++++++++++++++------------
>  4 files changed, 155 insertions(+), 46 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index d33114097d0d..cb5082efc91c 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -33,8 +33,8 @@ DECLARE_STATIC_KEY_FALSE(kunit_running);
>
>  struct kunit;
>
> -/* Size of log associated with test. */
> -#define KUNIT_LOG_SIZE 2048
> +/* Size of log buffer fragments. */
> +#define KUNIT_LOG_FRAGMENT_SIZE (256 - sizeof(struct list_head))
>
>  /* Maximum size of parameter description string. */
>  #define KUNIT_PARAM_DESC_SIZE 128
> @@ -85,6 +85,17 @@ struct kunit_attributes {
>         enum kunit_speed speed;
>  };
>
> +struct kunit_log_frag {
> +       struct list_head list;
> +       char buf[KUNIT_LOG_FRAGMENT_SIZE];
> +};
> +
> +static inline void kunit_init_log_frag(struct kunit_log_frag *frag)
> +{
> +       INIT_LIST_HEAD(&frag->list);
> +       frag->buf[0] =3D '\0';
> +}
> +
>  /**
>   * struct kunit_case - represents an individual test case.
>   *
> @@ -132,7 +143,7 @@ struct kunit_case {
>         /* private: internal use only. */
>         enum kunit_status status;
>         char *module_name;
> -       char *log;
> +       struct list_head *log;
>  };
>
>  static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
> @@ -252,7 +263,7 @@ struct kunit_suite {
>         /* private: internal use only */
>         char status_comment[KUNIT_STATUS_COMMENT_SIZE];
>         struct dentry *debugfs;
> -       char *log;
> +       struct list_head *log;
>         int suite_init_err;
>  };
>
> @@ -278,7 +289,7 @@ struct kunit {
>
>         /* private: internal use only. */
>         const char *name; /* Read only after initialization! */
> -       char *log; /* Points at case log after initialization */
> +       struct list_head *log; /* Points at case log after initialization=
 */

To respond to some of the comments from the previous version, I am
fine with the list_head being a pointer considering there can only be
one list_head in this struct definition.

>         struct kunit_try_catch try_catch;
>         /* param_value is the current parameter value for a test case. */
>         const void *param_value;
> @@ -314,7 +325,7 @@ const char *kunit_filter_glob(void);
>  char *kunit_filter(void);
>  char *kunit_filter_action(void);
>
> -void kunit_init_test(struct kunit *test, const char *name, char *log);
> +void kunit_init_test(struct kunit *test, const char *name, struct list_h=
ead *log);
>
>  int kunit_run_tests(struct kunit_suite *suite);
>
> @@ -472,7 +483,7 @@ static inline void *kunit_kcalloc(struct kunit *test,=
 size_t n, size_t size, gfp
>
>  void kunit_cleanup(struct kunit *test);
>
> -void __printf(2, 3) kunit_log_append(char *log, const char *fmt, ...);
> +void __printf(2, 3) kunit_log_append(struct list_head *log, const char *=
fmt, ...);
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
>                 debugfs_rootdir =3D debugfs_create_dir(KUNIT_DEBUGFS_ROOT=
, NULL);
>  }
>
> -static void debugfs_print_result(struct seq_file *seq,
> -                                struct kunit_suite *suite,
> -                                struct kunit_case *test_case)
> +static void debugfs_print_log(struct seq_file *seq, const struct list_he=
ad *log)
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
> @@ -69,10 +71,9 @@ static int debugfs_print_results(struct seq_file *seq,=
 void *v)
>         seq_printf(seq, KUNIT_SUBTEST_INDENT "1..%zd\n", kunit_suite_num_=
test_cases(suite));
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
> @@ -100,14 +101,53 @@ static const struct file_operations debugfs_results=
_fops =3D {
>         .release =3D debugfs_release,
>  };
>
> +static struct list_head *kunit_debugfs_alloc_log(void)
> +{
> +       struct list_head *log;
> +       struct kunit_log_frag *frag;
> +
> +       log =3D kzalloc(sizeof(*log), GFP_KERNEL);
> +       if (!log)
> +               return NULL;
> +
> +       INIT_LIST_HEAD(log);
> +
> +       frag =3D kmalloc(sizeof(*frag), GFP_KERNEL);
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
> -       suite->log =3D kzalloc(KUNIT_LOG_SIZE, GFP_KERNEL);
> +       suite->log =3D kunit_debugfs_alloc_log();
> +
>         kunit_suite_for_each_test_case(suite, test_case)
> -               test_case->log =3D kzalloc(KUNIT_LOG_SIZE, GFP_KERNEL);
> +               test_case->log =3D kunit_debugfs_alloc_log();
>
>         suite->debugfs =3D debugfs_create_dir(suite->name, debugfs_rootdi=
r);
>
> @@ -121,7 +161,8 @@ void kunit_debugfs_destroy_suite(struct kunit_suite *=
suite)
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
> index 83d8e90ca7a2..a199f83bac67 100644
> --- a/lib/kunit/kunit-test.c
> +++ b/lib/kunit/kunit-test.c
> @@ -530,12 +530,37 @@ static struct kunit_suite kunit_resource_test_suite=
 =3D {
>         .test_cases =3D kunit_resource_test_cases,
>  };
>
> +static char *get_concatenated_log(struct kunit *test, const struct list_=
head *log)
> +{
> +       struct kunit_log_frag *frag;
> +       size_t len =3D 0;
> +       char *p;

I wonder if we could change the name of p to be a bit more
descriptive. Maybe concat_log?

> +
> +       list_for_each_entry(frag, log, list)
> +               len +=3D strlen(frag->buf);
> +
> +       len++; /* for terminating '\0' */
> +       p =3D kunit_kzalloc(test, len, GFP_KERNEL);
> +
> +       list_for_each_entry(frag, log, list)
> +               strlcat(p, frag->buf, len);
> +
> +       return p;
> +}
> +
>  static void kunit_log_test(struct kunit *test)
>  {
>         struct kunit_suite suite;
> +       struct kunit_log_frag *frag;
>
> -       suite.log =3D kunit_kzalloc(test, KUNIT_LOG_SIZE, GFP_KERNEL);
> +       suite.log =3D kunit_kzalloc(test, sizeof(*suite.log), GFP_KERNEL)=
;
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, suite.log);
> +       INIT_LIST_HEAD(suite.log);

This section of the test is pretty dense. I would love to see at least
one comment in this section. Maybe it could be here and say something
like:
"/* Allocate, initialize, and then add the first fragment of log */"

> +       frag =3D kunit_kmalloc(test, sizeof(*frag), GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, frag);
> +       kunit_init_log_frag(frag);
> +       KUNIT_EXPECT_EQ(test, frag->buf[0], '\0');
> +       list_add_tail(&frag->list, suite.log);
>
>         kunit_log(KERN_INFO, test, "put this in log.");
>         kunit_log(KERN_INFO, test, "this too.");
> @@ -543,14 +568,17 @@ static void kunit_log_test(struct kunit *test)
>         kunit_log(KERN_INFO, &suite, "along with this.");
>
>  #ifdef CONFIG_KUNIT_DEBUGFS
> +       frag =3D list_first_entry(test->log, struct kunit_log_frag, list)=
;
>         KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
> -                                    strstr(test->log, "put this in log."=
));
> +                                    strstr(frag->buf, "put this in log."=
));
>         KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
> -                                    strstr(test->log, "this too."));
> +                                    strstr(frag->buf, "this too."));
> +
> +       frag =3D list_first_entry(suite.log, struct kunit_log_frag, list)=
;
>         KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
> -                                    strstr(suite.log, "add to suite log.=
"));
> +                                    strstr(frag->buf, "add to suite log.=
"));
>         KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
> -                                    strstr(suite.log, "along with this."=
));
> +                                    strstr(frag->buf, "along with this."=
));
>  #else
>         KUNIT_EXPECT_NULL(test, test->log);

This test passes when CONFIG_KUNIT_DEBUGFS=3Dn while most of the other
tests are skipped. Should this test be skipped instead?

I'm assuming since the assert/expect statements at the beginning are
run even if CONFIG_KUNIT_DEBUGFS=3Dn, this test should not be skipped
but I just wanted to check.

>  #endif
> @@ -558,11 +586,15 @@ static void kunit_log_test(struct kunit *test)
>
>  static void kunit_log_newline_test(struct kunit *test)
>  {
> +       struct kunit_log_frag *frag;
> +
>         kunit_info(test, "Add newline\n");
>         if (test->log) {

This is a small nit but I would prefer that the if statements to
decide whether CONFIG_KUNIT_DEBUGFS is enabled were uniform. So I
would prefer that we choose between if (test->log) and #ifdef
CONFIG_KUNIT_DEBUGFS. I think we originally chose to use if
(test->log) here to avoid the compile-time #ifdef.

> -               KUNIT_ASSERT_NOT_NULL_MSG(test, strstr(test->log, "Add ne=
wline\n"),
> -                       "Missing log line, full log:\n%s", test->log);
> -               KUNIT_EXPECT_NULL(test, strstr(test->log, "Add newline\n\=
n"));
> +               frag =3D list_first_entry(test->log, struct kunit_log_fra=
g, list);
> +               KUNIT_ASSERT_NOT_NULL_MSG(test, strstr(frag->buf, "Add ne=
wline\n"),
> +                       "Missing log line, full log:\n%s",
> +                       get_concatenated_log(test, test->log));
> +               KUNIT_EXPECT_NULL(test, strstr(frag->buf, "Add newline\n\=
n"));
>         } else {
>                 kunit_skip(test, "only useful when debugfs is enabled");
>         }
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 49698a168437..dfe51bc2b387 100644
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
> @@ -114,46 +115,66 @@ static void kunit_print_test_stats(struct kunit *te=
st,
>   * already present.
>   * @log: The log to add the newline to.
>   */
> -static void kunit_log_newline(char *log)
> +static void kunit_log_newline(struct kunit_log_frag *frag)
>  {
>         int log_len, len_left;
>
> -       log_len =3D strlen(log);
> -       len_left =3D KUNIT_LOG_SIZE - log_len - 1;
> +       log_len =3D strlen(frag->buf);
> +       len_left =3D sizeof(frag->buf) - log_len - 1;
>
> -       if (log_len > 0 && log[log_len - 1] !=3D '\n')
> -               strncat(log, "\n", len_left);
> +       if (log_len > 0 && frag->buf[log_len - 1] !=3D '\n')
> +               strncat(frag->buf, "\n", len_left);
>  }
>
> -/*
> - * Append formatted message to log, size of which is limited to
> - * KUNIT_LOG_SIZE bytes (including null terminating byte).
> - */
> -void kunit_log_append(char *log, const char *fmt, ...)
> +static struct kunit_log_frag *kunit_log_extend(struct list_head *log)

I would love to see just a short comment describing kunit_log_extend
to prevent confusion with kunit_log_append.



> +{
> +       struct kunit_log_frag *frag;
> +
> +       frag =3D kmalloc(sizeof(*frag), GFP_KERNEL);
> +       if (!frag)
> +               return NULL;
> +
> +       kunit_init_log_frag(frag);
> +       list_add_tail(&frag->list, log);
> +
> +       return frag;
> +}
> +
> +/* Append formatted message to log, extending the log buffer if necessar=
y. */
> +void kunit_log_append(struct list_head *log, const char *fmt, ...)
>  {
>         va_list args;
> +       struct kunit_log_frag *frag;
>         int len, log_len, len_left;
>
>         if (!log)
>                 return;
>
> -       log_len =3D strlen(log);
> -       len_left =3D KUNIT_LOG_SIZE - log_len - 1;
> -       if (len_left <=3D 0)
> -               return;
> +       frag =3D list_last_entry(log, struct kunit_log_frag, list);
> +       log_len =3D strlen(frag->buf);
> +       len_left =3D sizeof(frag->buf) - log_len - 1;
>
>         /* Evaluate length of line to add to log */
>         va_start(args, fmt);
>         len =3D vsnprintf(NULL, 0, fmt, args) + 1;
>         va_end(args);
>
> +       if (len > len_left) {
> +               frag =3D kunit_log_extend(log);
> +               if (!frag)
> +                       return;
> +
> +               len_left =3D sizeof(frag->buf) - 1;
> +               log_len =3D 0;
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
> @@ -359,14 +380,18 @@ void __kunit_do_failed_assertion(struct kunit *test=
,
>  }
>  EXPORT_SYMBOL_GPL(__kunit_do_failed_assertion);
>
> -void kunit_init_test(struct kunit *test, const char *name, char *log)
> +void kunit_init_test(struct kunit *test, const char *name, struct list_h=
ead *log)
>  {
>         spin_lock_init(&test->lock);
>         INIT_LIST_HEAD(&test->resources);
>         test->name =3D name;
>         test->log =3D log;
> -       if (test->log)
> -               test->log[0] =3D '\0';
> +       if (test->log) {
> +               struct kunit_log_frag *frag =3D list_first_entry(test->lo=
g,
> +                                                              struct kun=
it_log_frag,
> +                                                              list);
> +               frag->buf[0] =3D '\0';
> +       }
>         test->status =3D KUNIT_SUCCESS;
>         test->status_comment[0] =3D '\0';
>  }
> --
> 2.30.2
>
