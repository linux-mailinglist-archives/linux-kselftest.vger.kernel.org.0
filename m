Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 611E516390C
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2020 02:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgBSBKP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Feb 2020 20:10:15 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:35356 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgBSBKP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Feb 2020 20:10:15 -0500
Received: by mail-yw1-f66.google.com with SMTP id i190so10367776ywc.2;
        Tue, 18 Feb 2020 17:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bS+U54DjsgQNo9GfjbSCLoaYX+dLyFR/r7jmpQKCWk8=;
        b=P8kgMly9R3u7pKzCBU7l+CeQAdqNV+/fyxFtfNbjG2opSFGvnhm5le4j9X5Wmbs1Ve
         M+quyww9BlbPz5wClxndkZNa+DBWY78e58MrviexRH38YYLxq7KcLHFhbOyYL2GUW2EC
         MYWx5imAs/l65Xj55/IW6bP5yGoW3F6Cp/VWWdd9c3y05XipIOyTfPTmsHjSX1BqmMj+
         UFHZ1s9F+J7S0/ZLMq4EyDetx2A1Ea2ygPMNqkLM6AIFCuExsbzI7ny1xuk87UHjsnIj
         6bBq+Ul+EpVY7mgGTrVJNV4hgAnHDlC2YPLXEXcqSRCXi4YHgwXLit7cOJExpLMYusCB
         8gww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bS+U54DjsgQNo9GfjbSCLoaYX+dLyFR/r7jmpQKCWk8=;
        b=c2fYg64FTYZbzdqAiJt/6r3W93ib2PdKH1wRvV3budeMWDxn1TljDVtcnNsteFe++5
         AVtyj+VrMSM80QO/IvZy323inQeYTlgJ6Guy2rj3fF1vV1TQNypeh+LveT/ZCpdoY0mP
         4dFE7jq/H8S6SfXrw9mYs4fPfb9RxmLEdlY9Ml165d2/CZ55kCOAKhqRBdhgJd6LvpEl
         Ki3wswbMvXwQqz5nAY2q4pO9X3808VXQbGj3PWFERyqOqIBS95CqB1lr+RPC+hq4UoiT
         HMUouoIpS/lyJroqlKxPL6TsmCI3z54Pr9kLAmw0kZOPG8bGUTBPlTN1PdeqQWkko7Zl
         BM3g==
X-Gm-Message-State: APjAAAVa+y/+QzUkIy53myyEYa2cLhtdvnYQzTm5Cvka67SJIsbfpRr3
        amMxu2x+ao3PWG7LGX0S0jE=
X-Google-Smtp-Source: APXvYqz9DPR032habVY7AVSF/Mi+6soG7v/Rc99RwQUTawaNGeIhSNv5zT9WF5BqcWJAVk/gz3HOBA==
X-Received: by 2002:a81:b402:: with SMTP id h2mr18148571ywi.365.1582074612733;
        Tue, 18 Feb 2020 17:10:12 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id i17sm244180ywg.66.2020.02.18.17.10.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Feb 2020 17:10:12 -0800 (PST)
Subject: Re: [PATCH v3 kunit-next 1/2] kunit: add debugfs
 /sys/kernel/debug/kunit/<suite>/results display
To:     Brendan Higgins <brendanhiggins@google.com>,
        "Bird, Timothy" <Tim.Bird@sony.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>, shuah <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Gow <davidgow@google.com>
References: <1581094694-6513-1-git-send-email-alan.maguire@oracle.com>
 <1581094694-6513-2-git-send-email-alan.maguire@oracle.com>
 <c42ac237-476a-526f-b445-61e7a63bc101@gmail.com>
 <CAFd5g47p9wnbz=HrNh0U2bbc=0ZaJ7n0U+_=E8yp8yPMrqwzaA@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <91f11247-d015-92b8-64cf-ecd8fba6ba23@gmail.com>
Date:   Tue, 18 Feb 2020 19:10:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFd5g47p9wnbz=HrNh0U2bbc=0ZaJ7n0U+_=E8yp8yPMrqwzaA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/18/20 1:46 PM, Brendan Higgins wrote:
> On Wed, Feb 12, 2020 at 7:25 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 2/7/20 10:58 AM, Alan Maguire wrote:
>>> add debugfs support for displaying kunit test suite results; this is
>>> especially useful for module-loaded tests to allow disentangling of
>>> test result display from other dmesg events.
>>>
>>> As well as printk()ing messages, we append them to a per-test log.
>>>
>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>> ---
>>>  include/kunit/test.h   |  52 ++++++++++++++++---
>>>  lib/kunit/Makefile     |   3 +-
>>>  lib/kunit/debugfs.c    | 105 ++++++++++++++++++++++++++++++++++++++
>>>  lib/kunit/debugfs.h    |  16 ++++++
>>>  lib/kunit/kunit-test.c |   4 +-
>>>  lib/kunit/test.c       | 136 ++++++++++++++++++++++++++++++++++++++-----------
>>>  6 files changed, 274 insertions(+), 42 deletions(-)
>>>  create mode 100644 lib/kunit/debugfs.c
>>>  create mode 100644 lib/kunit/debugfs.h
>>>
>>> diff --git a/include/kunit/test.h b/include/kunit/test.h
>>> index 2dfb550..6a73c4e 100644
>>> --- a/include/kunit/test.h
>>> +++ b/include/kunit/test.h
>>> @@ -81,6 +81,9 @@ struct kunit_resource {
>>>
>>>  struct kunit;
>>>
>>> +/* Size of "lastrun" log associated with test. */
>>> +#define KUNIT_LOG_SIZE       512
>>> +
>>>  /**
>>>   * struct kunit_case - represents an individual test case.
>>>   *
>>> @@ -123,8 +126,14 @@ struct kunit_case {
>>>
>>>       /* private: internal use only. */
>>>       bool success;
>>> +     char *log;
>>>  };
>>>
>>> +static inline char *kunit_status_to_string(bool status)
>>> +{
>>> +     return status ? "ok" : "not ok";
>>> +}
>>> +
>>>  /**
>>>   * KUNIT_CASE - A helper for creating a &struct kunit_case
>>>   *
>>> @@ -157,6 +166,10 @@ struct kunit_suite {
>>>       int (*init)(struct kunit *test);
>>>       void (*exit)(struct kunit *test);
>>>       struct kunit_case *test_cases;
>>> +
>>> +     /* private - internal use only */
>>> +     struct dentry *debugfs;
>>> +     char *log;
>>>  };
>>>
>>>  /**
>>> @@ -175,6 +188,7 @@ struct kunit {
>>>
>>>       /* private: internal use only. */
>>>       const char *name; /* Read only after initialization! */
>>> +     char *log; /* Points at case log after initialization */
>>>       struct kunit_try_catch try_catch;
>>>       /*
>>>        * success starts as true, and may only be set to false during a
>>> @@ -193,10 +207,19 @@ struct kunit {
>>>       struct list_head resources; /* Protected by lock. */
>>>  };
>>>
>>> -void kunit_init_test(struct kunit *test, const char *name);
>>> +void kunit_init_test(struct kunit *test, const char *name, char *log);
>>>
>>>  int kunit_run_tests(struct kunit_suite *suite);
>>>
>>> +size_t kunit_suite_num_test_cases(struct kunit_suite *suite);
>>> +
>>> +unsigned int kunit_test_case_num(struct kunit_suite *suite,
>>> +                              struct kunit_case *test_case);
>>> +
>>> +int __kunit_test_suites_init(struct kunit_suite **suites);
>>> +
>>> +void __kunit_test_suites_exit(struct kunit_suite **suites);
>>> +
>>>  /**
>>>   * kunit_test_suites() - used to register one or more &struct kunit_suite
>>>   *                    with KUnit.
>>> @@ -226,20 +249,24 @@ struct kunit {
>>>       static struct kunit_suite *suites[] = { __VA_ARGS__, NULL};     \
>>>       static int kunit_test_suites_init(void)                         \
>>>       {                                                               \
>>> -             unsigned int i;                                         \
>>> -             for (i = 0; suites[i] != NULL; i++)                     \
>>> -                     kunit_run_tests(suites[i]);                     \
>>> -             return 0;                                               \
>>> +             return __kunit_test_suites_init(suites);                \
>>>       }                                                               \
>>>       late_initcall(kunit_test_suites_init);                          \
>>>       static void __exit kunit_test_suites_exit(void)                 \
>>>       {                                                               \
>>> -             return;                                                 \
>>> +             return __kunit_test_suites_exit(suites);                \
>>>       }                                                               \
>>>       module_exit(kunit_test_suites_exit)
>>>
>>>  #define kunit_test_suite(suite)      kunit_test_suites(&suite)
>>>
>>> +#define kunit_suite_for_each_test_case(suite, test_case)             \
>>> +     for (test_case = suite->test_cases;                             \
>>> +          test_case && test_case->run_case;                          \
>>
>> test_case does not become NULL for the final entry in suite->test_cases
>> so do not test for such.
>>
>>
>>> +          test_case++)
>>> +
>>> +bool kunit_suite_has_succeeded(struct kunit_suite *suite);
>>> +
>>>  /*
>>>   * Like kunit_alloc_resource() below, but returns the struct kunit_resource
>>>   * object that contains the allocation. This is mostly for testing purposes.
>>> @@ -356,8 +383,17 @@ static inline void *kunit_kzalloc(struct kunit *test, size_t size, gfp_t gfp)
>>>
>>>  void kunit_cleanup(struct kunit *test);
>>>
>>> -#define kunit_printk(lvl, test, fmt, ...) \
>>> -     printk(lvl "\t# %s: " fmt, (test)->name, ##__VA_ARGS__)
>>> +/* printk and log to per-test or per-suite log buffer */
>>> +#define kunit_log(lvl, test, fmt, ...)                               \
>>
>> 'test' can be either a test or a suite, so this name is misleading.  I suggest
>> changing it to test_or_suite.
>>
>>
>>> +     do {                                                            \
>>> +             printk(lvl fmt, ##__VA_ARGS__);                         \
>>> +             snprintf((test)->log, KUNIT_LOG_SIZE,                   \
>>> +                       "%s" fmt "\n",                                \
>>> +                      (test)->log, ##__VA_ARGS__);                   \
>>> +     } while (0)
>>> +
>>
>> If kunit_log() is called multiple times in a test run for a single test case,
>> does each call overwrite the previous value of (test)->log?  For example,
>> kunit_print_subtest_start() calls kunit_log() twice.
>>
>>
>>> +#define kunit_printk(lvl, test, fmt, ...)                            \
>>> +     kunit_log(lvl, test, "\t# %s: " fmt, (test)->name, ##__VA_ARGS__)
>>>
>>>  /**
>>>   * kunit_info() - Prints an INFO level message associated with @test.
>>> diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
>>> index fab5564..869aab0 100644
>>> --- a/lib/kunit/Makefile
>>> +++ b/lib/kunit/Makefile
>>> @@ -3,7 +3,8 @@ obj-$(CONFIG_KUNIT) +=                        kunit.o
>>>  kunit-objs +=                                test.o \
>>>                                       string-stream.o \
>>>                                       assert.o \
>>> -                                     try-catch.o
>>> +                                     try-catch.o \
>>> +                                     debugfs.o
>>>
>>>  obj-$(CONFIG_KUNIT_TEST) +=          kunit-test.o
>>>
>>
>> Please make debugfs.o configurable distinctly from KUNIT.  Or it
>> might be possible to make KUNIT_LOG_SIZE zero (and make sure the
>> code handles a NULL log) if that is easier to implement.
>>
>> The data size of the log buffers could otherwise be excessively
>> large for a tiny resource constrained embedded platform.  For
>> example, with the proposed KUNIT_LOG_SIZE of 512, if there were
>> 200 test cases enabled, the log space would be 100k bytes.  If
>> 2000 test cases were enabled, the log space would be 1000k bytes.
>>
>> I can easily imagine a user configuring an acceptance test with
>> tens of thousands of test cases.
>>
>>
>>> diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
>>> new file mode 100644
>>> index 0000000..b856d6b
>>> --- /dev/null
>>> +++ b/lib/kunit/debugfs.c
>>> @@ -0,0 +1,105 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright (c) 2020, Oracle and/or its affiliates.
>>> + *    Author: Alan Maguire <alan.maguire@oracle.com>
>>> + */
>>> +
>>> +#include <linux/debugfs.h>
>>> +#include <linux/module.h>
>>> +
>>> +#include <kunit/test.h>
>>> +
>>> +#include "string-stream.h"
>>> +
>>> +#define KUNIT_DEBUGFS_ROOT             "kunit"
>>> +#define KUNIT_DEBUGFS_RESULTS          "results"
>>> +
>>> +/*
>>> + * Create a debugfs representation of test suites:
>>> + *
>>> + * Path                                              Semantics
>>> + * /sys/kernel/debug/kunit/<testsuite>/results       Show results of last run for
>>> + *                                           testsuite
>>> + *
>>> + */
>>> +
>>> +static struct dentry *debugfs_rootdir;
>>> +
>>> +void kunit_debugfs_cleanup(void)
>>> +{
>>> +     debugfs_remove_recursive(debugfs_rootdir);
>>> +}
>>> +
>>> +void kunit_debugfs_init(void)
>>> +{
>>> +     if (!debugfs_rootdir)
>>> +             debugfs_rootdir = debugfs_create_dir(KUNIT_DEBUGFS_ROOT, NULL);
>>> +}
>>> +
>>> +static void debugfs_print_result(struct seq_file *seq,
>>> +                              struct kunit_suite *suite,
>>> +                              struct kunit_case *test_case)
>>> +{
>>> +     if (!test_case)
>>> +             return;
>>> +
>>> +     seq_printf(seq, "%s", test_case->log);
>>> +}
>>> +
>>> +/*
>>> + * /sys/kernel/debug/kunit/<testsuite>/results shows all results for testsuite.
>>> + */
>>> +static int debugfs_print_results(struct seq_file *seq, void *v)
>>> +{
>>> +     struct kunit_suite *suite = (struct kunit_suite *)seq->private;
>>> +     bool success = kunit_suite_has_succeeded(suite);
>>> +     struct kunit_case *test_case;
>>> +
>>> +     if (!suite)
>>> +             return 0;
>>> +
>>> +     seq_printf(seq, "%s", suite->log);
>>> +
>>> +     kunit_suite_for_each_test_case(suite, test_case)
>>> +             debugfs_print_result(seq, suite, test_case);
>>> +
>>> +     seq_printf(seq, "%s %d - %s\n",
>>> +                kunit_status_to_string(success), 1, suite->name);
>>> +     return 0;
>>> +}
>>> +
>>> +static int debugfs_release(struct inode *inode, struct file *file)
>>> +{
>>> +     return single_release(inode, file);
>>> +}
>>> +
>>> +static int debugfs_results_open(struct inode *inode, struct file *file)
>>> +{
>>> +     struct kunit_suite *suite;
>>> +
>>> +     suite = (struct kunit_suite *)inode->i_private;
>>> +
>>> +     return single_open(file, debugfs_print_results, suite);
>>> +}
>>> +
>>> +static const struct file_operations debugfs_results_fops = {
>>> +     .open = debugfs_results_open,
>>> +     .read = seq_read,
>>> +     .llseek = seq_lseek,
>>> +     .release = debugfs_release,
>>> +};
>>> +
>>> +void kunit_debugfs_create_suite(struct kunit_suite *suite)
>>> +{
>>> +     /* First add /sys/kernel/debug/kunit/<testsuite> */
>>> +     suite->debugfs = debugfs_create_dir(suite->name, debugfs_rootdir);
>>> +
>>> +     debugfs_create_file(KUNIT_DEBUGFS_RESULTS, S_IFREG | 0444,
>>> +                         suite->debugfs,
>>> +                         suite, &debugfs_results_fops);
>>> +}
>>> +
>>> +void kunit_debugfs_destroy_suite(struct kunit_suite *suite)
>>> +{
>>> +     debugfs_remove_recursive(suite->debugfs);
>>> +}
>>> diff --git a/lib/kunit/debugfs.h b/lib/kunit/debugfs.h
>>> new file mode 100644
>>> index 0000000..9a92d5e
>>> --- /dev/null
>>> +++ b/lib/kunit/debugfs.h
>>> @@ -0,0 +1,16 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +/*
>>> + * Copyright (C) 2020, Oracle and/or its affiliates.
>>> + */
>>> +
>>> +#ifndef _KUNIT_DEBUGFS_H
>>> +#define _KUNIT_DEBUGFS_H
>>> +
>>> +#include <kunit/test.h>
>>> +
>>> +void kunit_debugfs_create_suite(struct kunit_suite *suite);
>>> +void kunit_debugfs_destroy_suite(struct kunit_suite *suite);
>>> +void kunit_debugfs_init(void);
>>> +void kunit_debugfs_cleanup(void);
>>> +
>>> +#endif /* _KUNIT_DEBUGFS_H */
>>> diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
>>> index ccb8d2e..aceb5bf 100644
>>> --- a/lib/kunit/kunit-test.c
>>> +++ b/lib/kunit/kunit-test.c
>>> @@ -134,7 +134,7 @@ static void kunit_resource_test_init_resources(struct kunit *test)
>>>  {
>>>       struct kunit_test_resource_context *ctx = test->priv;
>>>
>>> -     kunit_init_test(&ctx->test, "testing_test_init_test");
>>> +     kunit_init_test(&ctx->test, "testing_test_init_test", NULL);
>>>
>>>       KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
>>>  }
>>> @@ -301,7 +301,7 @@ static int kunit_resource_test_init(struct kunit *test)
>>>
>>>       test->priv = ctx;
>>>
>>> -     kunit_init_test(&ctx->test, "test_test_context");
>>> +     kunit_init_test(&ctx->test, "test_test_context", NULL);
>>>
>>>       return 0;
>>>  }
>>> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
>>> index 9242f93..aec607f 100644
>>> --- a/lib/kunit/test.c
>>> +++ b/lib/kunit/test.c
>>> @@ -10,6 +10,7 @@
>>>  #include <linux/kernel.h>
>>>  #include <linux/sched/debug.h>
>>>
>>> +#include "debugfs.h"
>>>  #include "string-stream.h"
>>>  #include "try-catch-impl.h"
>>>
>>> @@ -28,73 +29,91 @@ static void kunit_print_tap_version(void)
>>>       }
>>>  }
>>>
>>> -static size_t kunit_test_cases_len(struct kunit_case *test_cases)
>>> +size_t kunit_suite_num_test_cases(struct kunit_suite *suite)
>>>  {
>>>       struct kunit_case *test_case;
>>>       size_t len = 0;
>>>
>>> -     for (test_case = test_cases; test_case->run_case; test_case++)
>>> +     kunit_suite_for_each_test_case(suite, test_case)
>>>               len++;
>>>
>>>       return len;
>>>  }
>>> +EXPORT_SYMBOL_GPL(kunit_suite_num_test_cases);
>>>
>>>  static void kunit_print_subtest_start(struct kunit_suite *suite)
>>>  {
>>>       kunit_print_tap_version();
>>> -     pr_info("\t# Subtest: %s\n", suite->name);
>>> -     pr_info("\t1..%zd\n", kunit_test_cases_len(suite->test_cases));
>>> +     kunit_log(KERN_INFO, suite, "# Subtest: %s", suite->name);
>>> +     kunit_log(KERN_INFO, suite, "1..%zd",
>>> +               kunit_suite_num_test_cases(suite));
>>
>> The subtest 'is a TAP stream indented 4 spaces'.  (So the old code was
>> also incorrect since it indented with a tab.)
> 
> Whoops.
> 
> I agree that fixing tabs to spaces is probably the easiest thing to do
> here; nevertheless, I think this might be a good time to talk about
> other deviations from the spec and what to do about it. This might
> also be a good time to bring up Tim's comment at LPC last year about
> forking TAP. Arguably I already have given that TAP14 is still under
> review and is consequently subject to change.

Talking about other deviations would be good.  Some of that is already
in my plans, as I have been reading through KUnit in preparation for
moving devicetree unittests over to KUnit.  There are a few things
I want to bring up, but I first want to make sure that my understanding
of KUnit behavior is correct.

> 
> Additionally, the way I report expectation/assertion failures are my
> own extension to the TAP spec. I did this because at the time I wasn't
> ready to open the can of worms that was adding a YAML serializer to
> the Linux kernel; I mentioned adding a YAML serializer at LPC and
> people didn't seem super thrilled with the idea.

I had glanced at the KUnit expectation/assertion failure format, and
at first glance (not deep analysis) it seemed to meet the spirit of
the type of information that TAP wants in the 'YAML' block.  (I
would suggest a more neutral wording of that data block such as
'test anomaly report'.  I think it is bad spec writing to call it
a YAML block, which is really an implementation detail, not a
description of what the purpose of the block is.)  And the current
working draft of the TAP spec even admits that there is no
specification for the 'test anomaly report' - they simply have some
examples of what one might look like.

> 
> Further both the TAP implementation here as well as what is in
> kselftest have arbitrary kernel output mixed in with TAP output, which
> seems to be a further deviation from the spec.

That is another problem with the TAP spec that I was going to bring
up.  TAP seems to be envisioning an application program being
tested.  It explicitly says:

   (1) A harness interpreting a subprocess MUST only read TAP output from
   standard output and not from standard error.

The standard is a bit fractured, but if you put the pieces together,
you also get:

   (2) "Any line matching the pattern `/^\s*#.*$/` is treated as a diagnostic
   comment, and MAY be reported to the user or ignored, but MUST be
   ignored for the purposes of interpreting test output semantics."

   (3) Various descriptions of 'the plan'.

   (4) "The test line":
   "Lines written to standard output matching `/^(not)? ok\b/` must be
   interpreted as test lines. After a test line a block of lines starting
   with `/^ {2}---$/` and ending with `/^ {2}\.\.\.$/` will be interpreted as an
   inline YAML document providing extended diagnostic information about
   the preceding test."

   (4.1) "... diagnostic comment, and MAY be reported to the user
   or ignored, but MUST be ignored for the purposes of interpreting
   test output semantics."

   (5) "All other lines must not be considered test output."

   (6) Version - "The Version is always `TAP version 14`"

So it seems ok to have arbitrary kernel output mixed in with TAP
output, according to (5).  And that you can have additional test
related kernel output if it is in the format of a diagnostic
comment (2).

Arbitrary kernel output is an issue I will need to bring up for
devicetree unittest.  One of the problems unittest has faced over
the years is that it triggers kernel warning and/or error messages
from normal code that is not part of the test code.  These messages
appear on the console (or in dmesg or logfile) and it is not obvious
to the casual developer (or even to me as the maintainer unless I
actually chase them down) whether the messages are valid (triggered
by the test) or instead reporting an actual bug.  In a recent patch
series to unittest I added some printk()s to report what error message
was expected to be triggered.  That allows the presence of an
unexpected error message or lack of an expected error message to be
detected.  I expect to discuss the exact syntax of that feature to
be part of any KUnit devicetree unittest patch series that I submit.

As part of my expected error message syntax, the report of an expected
error message would be in the format of a diagnostic comment, and
would occur after the start of the related test and before the
test line.

> 
> In an effort to do this, and so that at the very least I could
> document what I have done here, I have been looking into getting a
> copy of TAP into the kernel. Unfortunately, TAP appears to have some
> licensing issues. TAP says that it can be used/modified "under the
> same terms as Perl itself" and then provides a dead link. I filed a
> pull request to update the licence to the Perl Artistic Licence 1.0

I went down that same rat hole, and found two different licenses connected
to PERL, and decided to ignore that issue for now.

> since I believe that is what they are referencing; however, I have not
> heard back from them yet.

Another deviation (I think - again I wanted to test actual behavior
before getting into this discussion) is that TAP has one line
reporting either 'ok' or 'not ok' per test, followed by the
test anomaly report.  If I understand correctly, KUnit has
one or more expects and/or assertions for a single test, with
a single 'ok' or 'not ok' line, but potentially a block of
information within the test anomaly report for each failed
expect or assert (or alternatively a fully formed test anomaly
block per failed expect or assert.  It seems to me that each
expect or assert should result in an 'ok' or 'not ok' along
with the option test anomaly report.

-Frank

> 
>> kunit_print_ok_not_ok() has a similar indentation issue.
>>
>>
>>>  }
>>>
>>> -static void kunit_print_ok_not_ok(bool should_indent,
>>> +static void kunit_print_ok_not_ok(void *test_or_suite,
>>> +                               bool is_test,
>>>                                 bool is_ok,
>>>                                 size_t test_number,
>>>                                 const char *description)
>>>  {
>>> -     const char *indent, *ok_not_ok;
>>> +     struct kunit_suite *suite = is_test ? NULL : test_or_suite;
>>> +     struct kunit *test = is_test ? test_or_suite : NULL;
>>>
>>> -     if (should_indent)
>>> -             indent = "\t";
>>> -     else
>>> -             indent = "";
>>> -
>>> -     if (is_ok)
>>> -             ok_not_ok = "ok";
>>> +     /*
>>> +      * We do not log the test suite results as doing so would
>>> +      * mean debugfs display would consist of the test suite
>>> +      * description and status prior to individual test results.
>>> +      * Hence directly printk the suite status, and we will
>>> +      * separately seq_printf() the suite status for the debugfs
>>> +      * representation.
>>> +      */
>>> +     if (suite)
>>> +             pr_info("%s %zd - %s",
>>> +                     kunit_status_to_string(is_ok),
>>> +                     test_number, description);
>>>       else
>>> -             ok_not_ok = "not ok";
>>> -
>>> -     pr_info("%s%s %zd - %s\n", indent, ok_not_ok, test_number, description);
>>> +             kunit_log(KERN_INFO, test, "\t%s %zd - %s",
>>> +                       kunit_status_to_string(is_ok),
>>> +                       test_number, description);
>>>  }
>>>
>>> -static bool kunit_suite_has_succeeded(struct kunit_suite *suite)
>>> +bool kunit_suite_has_succeeded(struct kunit_suite *suite)
>>>  {
>>>       const struct kunit_case *test_case;
>>>
>>> -     for (test_case = suite->test_cases; test_case->run_case; test_case++)
>>> +     kunit_suite_for_each_test_case(suite, test_case) {
>>>               if (!test_case->success)
>>>                       return false;
>>> +     }
>>>
>>>       return true;
>>>  }
>>> +EXPORT_SYMBOL_GPL(kunit_suite_has_succeeded);
>>>
>>>  static void kunit_print_subtest_end(struct kunit_suite *suite)
>>>  {
>>>       static size_t kunit_suite_counter = 1;
>>>
>>> -     kunit_print_ok_not_ok(false,
>>> +     kunit_print_ok_not_ok((void *)suite, false,
>>>                             kunit_suite_has_succeeded(suite),
>>>                             kunit_suite_counter++,
>>>                             suite->name);
>>>  }
>>>
>>> -static void kunit_print_test_case_ok_not_ok(struct kunit_case *test_case,
>>> -                                         size_t test_number)
>>> +unsigned int kunit_test_case_num(struct kunit_suite *suite,
>>> +                              struct kunit_case *test_case)
>>>  {
>>> -     kunit_print_ok_not_ok(true,
>>> -                           test_case->success,
>>> -                           test_number,
>>> -                           test_case->name);
>>> +     struct kunit_case *tc;
>>> +     unsigned int i = 1;
>>> +
>>> +     kunit_suite_for_each_test_case(suite, tc) {
>>> +             if (tc == test_case)
>>> +                     return i;
>>> +             i++;
>>> +     }
>>> +
>>> +     return 0;
>>>  }
>>> +EXPORT_SYMBOL_GPL(kunit_test_case_num);
>>>
>>>  static void kunit_print_string_stream(struct kunit *test,
>>>                                     struct string_stream *stream)
>>> @@ -102,6 +121,9 @@ static void kunit_print_string_stream(struct kunit *test,
>>>       struct string_stream_fragment *fragment;
>>>       char *buf;
>>>
>>> +     if (string_stream_is_empty(stream))
>>> +             return;
>>> +
>>>       buf = string_stream_get_string(stream);
>>>       if (!buf) {
>>>               kunit_err(test,
>>> @@ -175,11 +197,14 @@ void kunit_do_assertion(struct kunit *test,
>>>  }
>>>  EXPORT_SYMBOL_GPL(kunit_do_assertion);
>>>
>>> -void kunit_init_test(struct kunit *test, const char *name)
>>> +void kunit_init_test(struct kunit *test, const char *name, char *log)
>>>  {
>>>       spin_lock_init(&test->lock);
>>>       INIT_LIST_HEAD(&test->resources);
>>>       test->name = name;
>>> +     test->log = log;
>>> +     if (test->log)
>>> +             test->log[0] = '\0';
>>>       test->success = true;
>>>  }
>>>  EXPORT_SYMBOL_GPL(kunit_init_test);
>>> @@ -290,7 +315,7 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
>>>       struct kunit_try_catch *try_catch;
>>>       struct kunit test;
>>>
>>> -     kunit_init_test(&test, test_case->name);
>>> +     kunit_init_test(&test, test_case->name, test_case->log);
>>>       try_catch = &test.try_catch;
>>>
>>>       kunit_try_catch_init(try_catch,
>>> @@ -303,19 +328,20 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
>>>       kunit_try_catch_run(try_catch, &context);
>>>
>>>       test_case->success = test.success;
>>> +
>>> +     kunit_print_ok_not_ok(&test, true, test_case->success,
>>> +                           kunit_test_case_num(suite, test_case),
>>> +                           test_case->name);
>>>  }
>>>
>>>  int kunit_run_tests(struct kunit_suite *suite)
>>>  {
>>>       struct kunit_case *test_case;
>>> -     size_t test_case_count = 1;
>>>
>>>       kunit_print_subtest_start(suite);
>>>
>>> -     for (test_case = suite->test_cases; test_case->run_case; test_case++) {
>>> +     kunit_suite_for_each_test_case(suite, test_case)
>>>               kunit_run_case_catch_errors(suite, test_case);
>>> -             kunit_print_test_case_ok_not_ok(test_case, test_case_count++);
>>> -     }
>>>
>>>       kunit_print_subtest_end(suite);
>>>
>>> @@ -323,6 +349,51 @@ int kunit_run_tests(struct kunit_suite *suite)
>>>  }
>>>  EXPORT_SYMBOL_GPL(kunit_run_tests);
>>>
>>> +static void kunit_init_suite(struct kunit_suite *suite)
>>> +{
>>> +     struct kunit_case *test_case;
>>> +
>>> +     /* Allocate logs before creating debugfs representation. */
>>> +     suite->log = kzalloc(KUNIT_LOG_SIZE, GFP_KERNEL);
>>> +     kunit_suite_for_each_test_case(suite, test_case)
>>> +             test_case->log = kzalloc(KUNIT_LOG_SIZE, GFP_KERNEL);
>>> +
>>> +     kunit_debugfs_create_suite(suite);
>>> +}
>>> +
>>> +int __kunit_test_suites_init(struct kunit_suite **suites)
>>> +{
>>> +     unsigned int i;
>>> +
>>> +     for (i = 0; suites[i] != NULL; i++) {
>>> +             kunit_init_suite(suites[i]);
>>> +             kunit_run_tests(suites[i]);
>>> +     }
>>> +     return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(__kunit_test_suites_init);
>>> +
>>> +static void kunit_exit_suite(struct kunit_suite *suite)
>>> +{
>>> +     struct kunit_case *test_case;
>>> +
>>> +     /* Destroy debugfs representation before freeing logs used by it. */
>>> +     kunit_debugfs_destroy_suite(suite);
>>> +
>>> +     kfree(suite->log);
>>> +     kunit_suite_for_each_test_case(suite, test_case)
>>> +             kfree(test_case->log);
>>> +}
>>> +
>>> +void __kunit_test_suites_exit(struct kunit_suite **suites)
>>> +{
>>> +     unsigned int i;
>>> +
>>> +     for (i = 0; suites[i] != NULL; i++)
>>> +             kunit_exit_suite(suites[i]);
>>> +}
>>> +EXPORT_SYMBOL_GPL(__kunit_test_suites_exit);
>>> +
>>>  struct kunit_resource *kunit_alloc_and_get_resource(struct kunit *test,
>>>                                                   kunit_resource_init_t init,
>>>                                                   kunit_resource_free_t free,
>>> @@ -489,12 +560,15 @@ void kunit_cleanup(struct kunit *test)
>>>
>>>  static int __init kunit_init(void)
>>>  {
>>> +     kunit_debugfs_init();
>>> +
>>>       return 0;
>>>  }
>>>  late_initcall(kunit_init);
>>>
>>>  static void __exit kunit_exit(void)
>>>  {
>>> +     kunit_debugfs_cleanup();
>>>  }
>>>  module_exit(kunit_exit);
>>>
>>>
>>
> 

