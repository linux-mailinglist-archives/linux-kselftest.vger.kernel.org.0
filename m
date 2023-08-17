Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AFC77F006
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Aug 2023 07:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347861AbjHQFHT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 01:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347725AbjHQFGx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 01:06:53 -0400
X-Greylist: delayed 3497 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Aug 2023 22:06:52 PDT
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131B71BF8;
        Wed, 16 Aug 2023 22:06:51 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:40088)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qWUJD-00BV35-MI; Wed, 16 Aug 2023 22:08:31 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:41098 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qWUJB-000nJO-ON; Wed, 16 Aug 2023 22:08:31 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Petr Skocik <pskocik@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com,
        Frederic Weisbecker <frederic@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Mike Christie <michael.christie@oracle.com>,
        Marco Elver <elver@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "haifeng.xu" <haifeng.xu@shopee.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20230814210508.never.871-kees@kernel.org>
Date:   Wed, 16 Aug 2023 23:08:21 -0500
In-Reply-To: <20230814210508.never.871-kees@kernel.org> (Kees Cook's message
        of "Mon, 14 Aug 2023 14:05:12 -0700")
Message-ID: <87bkf68g5m.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1qWUJB-000nJO-ON;;;mid=<87bkf68g5m.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19bfqe96MqsVOjFxcODXAV3vKGoe2wqSKQ=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1258 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 12 (0.9%), b_tie_ro: 10 (0.8%), parse: 1.67
        (0.1%), extract_message_metadata: 40 (3.2%), get_uri_detail_list: 7
        (0.6%), tests_pri_-2000: 37 (3.0%), tests_pri_-1000: 3.4 (0.3%),
        tests_pri_-950: 1.30 (0.1%), tests_pri_-900: 1.09 (0.1%),
        tests_pri_-200: 0.91 (0.1%), tests_pri_-100: 23 (1.8%), tests_pri_-90:
        426 (33.8%), check_bayes: 394 (31.3%), b_tokenize: 20 (1.6%),
        b_tok_get_all: 281 (22.3%), b_comp_prob: 4.4 (0.3%), b_tok_touch_all:
        84 (6.6%), b_finish: 0.95 (0.1%), tests_pri_0: 695 (55.3%),
        check_dkim_signature: 0.70 (0.1%), check_dkim_adsp: 9 (0.7%),
        poll_dns_idle: 0.62 (0.0%), tests_pri_10: 3.0 (0.2%), tests_pri_500: 9
        (0.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] [RFC] signal: Add KUnit tests
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> This is a continuation of the proposal[1] for mocking init_task for
> KUnit testing. Changing the behavior of kill_something_info() is moving
> forward[2] and I'd _really_ like to have some unit tests in place to
> actually test the behavioral changes.
>
> I tried to incorporate feedback from Daniel and David, and I think the
> result is fairly workable -- the only tricky part is building valid
> task_struct instances. :)
>
> Notably, I haven't actually gotten as far as testing the actual proposed
> behavioral change since I wanted to make sure this approach wasn't going
> to totally crash and burn.
>
> Thoughts?

Overall this looks like a nice start.  More comments below.

I do wonder though.  Would it perhaps be easier to create a pid
namespace with just the processes you want in it?

I am wondering because you failed to mock find_vpid and so you
are actually testing sending signals to kernel threads.

Eric

> [1] https://lore.kernel.org/all/202212012008.D6F6109@keescook/
> [2] https://lore.kernel.org/all/87jzu12pjh.fsf_-_@email.froward.int.ebiederm.org
>
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Cc: David Gow <davidgow@google.com>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Petr Skocik <pskocik@gmail.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/kunit/resource.h     |  15 ++++
>  include/linux/sched/signal.h |  11 ++-
>  kernel/signal.c              | 135 +++++++++++++++++++++++++++++++++++
>  3 files changed, 158 insertions(+), 3 deletions(-)
>
> diff --git a/include/kunit/resource.h b/include/kunit/resource.h
> index c7383e90f5c9..dbf84a58f7a6 100644
> --- a/include/kunit/resource.h
> +++ b/include/kunit/resource.h
> @@ -479,4 +479,19 @@ void kunit_remove_action(struct kunit *test,
>  void kunit_release_action(struct kunit *test,
>  			  kunit_action_t *action,
>  			  void *ctx);
> +
> +#define kunit_get_mock_pointer(name, actual) ({			\
> +	typeof(*(actual)) *ptr = actual;			\
> +	struct kunit_resource *resource;			\
> +								\
> +	if (kunit_get_current_test()) {				\
> +		resource = kunit_find_named_resource(current->kunit_test, name); \
> +		if (resource) {					\
> +			ptr = resource->data;			\
> +			kunit_put_resource(resource);		\
> +		}						\
> +	}							\
> +	ptr;							\
> +})
> +
>  #endif /* _KUNIT_RESOURCE_H */
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index 669e8cff40c7..700271f43491 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -637,14 +637,19 @@ static inline unsigned long sigsp(unsigned long sp, struct ksignal *ksig)
>  extern void __cleanup_sighand(struct sighand_struct *);
>  extern void flush_itimer_signals(void);
>  
> +/* This is used for KUnit mocking. */
> +#ifndef __init_task_ptr
> +#define __init_task_ptr	(&init_task)
> +#endif
> +
>  #define tasklist_empty() \
> -	list_empty(&init_task.tasks)
> +	list_empty(&__init_task_ptr->tasks)

This exposes an implementation detail that makes my brain hurt.

I think somewhere we should just have a global variable
"struct list_head tasklist;" and use all of the modern list accessors
on it.  Instead of placing that list in the first idle task for no
reason.  That would allow decoupling all of the idle threads not
just the first one from the tasklist.

More importantly this has only a single user and that user is an assert
that the per_cpu idle tasks come up before we start any other tasks.

So we can just skip instrumenting this.


Given what your tests have to do to emulate the init_task without
it actually being an init_task in the long term it probably makes
sense to form the cleanup and just get init_task out of the
picture entirely.

Maybe that is too much right now, but it feels like the clean way
to handle this situation.

>  #define next_task(p) \
>  	list_entry_rcu((p)->tasks.next, struct task_struct, tasks)
>  
>  #define for_each_process(p) \
> -	for (p = &init_task ; (p = next_task(p)) != &init_task ; )
> +	for (p = __init_task_ptr ; (p = next_task(p)) != __init_task_ptr ; )
>  
>  extern bool current_is_single_threaded(void);
>  
> @@ -653,7 +658,7 @@ extern bool current_is_single_threaded(void);
>   *          'break' will not work as expected - use goto instead.
>   */
>  #define do_each_thread(g, t) \
> -	for (g = t = &init_task ; (g = t = next_task(g)) != &init_task ; ) do
> +	for (g = t = __init_task_ptr ; (g = t = next_task(g)) != __init_task_ptr ; ) do
>

Arguably we can skip this as well.  There are only 3 uses of
do_each_thread (pivot_root, SAK, and ia64 backtrace) and they all should
be changed to be for_each_process_thread.

>  #define while_each_thread(g, t) \
>  	while ((t = next_thread(t)) != g)
> diff --git a/kernel/signal.c b/kernel/signal.c
> index b5370fe5c198..7607d302ebb9 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -11,6 +11,14 @@
>   *		to allow signals to be sent reliably.
>   */
>  
> +#if IS_ENABLED(CONFIG_KUNIT)
> +/* This must be defined before we include include/linux/sched/signal.h */
> +#define __init_task_ptr kunit_get_mock_pointer("mock_init_task", &init_task)
> +
> +#include <kunit/resource.h>
> +#include <kunit/test-bug.h>
> +#endif
> +
>  #include <linux/slab.h>
>  #include <linux/export.h>
>  #include <linux/init.h>
> @@ -4842,3 +4850,130 @@ void kdb_send_sig(struct task_struct *t, int sig)
>  		kdb_printf("Signal %d is sent to process %d.\n", sig, t->pid);
>  }
>  #endif	/* CONFIG_KGDB_KDB */
> +
> +#if IS_ENABLED(CONFIG_KUNIT)
> +static void test_empty_task_list(struct kunit *test)
> +{
> +	struct kunit_resource resource;
> +	static struct task_struct empty_task_list = {
> +			.tasks	= LIST_HEAD_INIT(empty_task_list.tasks),
> +		};
> +	struct task_struct *p;
> +	int count = 0;
> +
> +	kunit_add_named_resource(test, NULL, NULL, &resource,
> +				 "mock_init_task", &empty_task_list);
> +
> +	KUNIT_EXPECT_TRUE(test, tasklist_empty());
> +
> +	for_each_process(p)
> +		count++;
> +
> +	/* System hangs without this... */
> +	kunit_remove_resource(test, &resource);
> +
> +	KUNIT_EXPECT_EQ(test, count, 0);
> +}

We should be able to just skip this test.

> +
> +static void test_for_each_process(struct kunit *test)
> +{
> +	struct kunit_resource resource;
> +	static struct task_struct task1 = {
> +			.pid = 1,
> +			.tasks	= LIST_HEAD_INIT(task1.tasks),
> +		};
> +	static struct task_struct task2 = {
> +			.pid = 2,
> +		}, task3 = {
> +			.pid = 3,
> +		};

Note that these pid values in the tasks are not used by
signal delivery. 

> +	struct task_struct *p;
> +	int count = 0;
> +
> +	list_add(&task2.tasks, &task1.tasks);
> +	list_add(&task3.tasks, &task1.tasks);
        ^^^^^
To match fork these should be list_add_tail.
> +
> +	kunit_add_named_resource(test, NULL, NULL, &resource,
> +				 "mock_init_task", &task1);
> +
> +	/* Walk the process list backwards. */

The comment is wrong. You built your list backwards, the process list is
not walked backwards.

> +	for_each_process(p) {
> +		KUNIT_EXPECT_EQ(test, 3 - count, p->pid);
> +		count++;
> +	}
> +
> +	/* System hangs without this... */
> +	kunit_remove_resource(test, &resource);
> +
> +	/* init_task isn't counted... */
> +	KUNIT_EXPECT_EQ(test, count, 2);
> +}
> +
> +static void test_kill_something_info(struct kunit *test)
> +{
> +	struct kunit_resource resource;
> +	static struct task_struct task1 = {
> +			.pid = 1,
> +			.tasks	= LIST_HEAD_INIT(task1.tasks),
> +		};
> +	static struct task_struct task2 = {
> +			.pid = 2,
> +		}, task3 = {
> +			.pid = 3,
> +		};
> +	struct kernel_siginfo siginfo = {
> +			.si_code = SI_KERNEL,
> +		};
> +	struct task_struct *p;
> +	int count = 0;
> +
> +	list_add(&task2.tasks, &task1.tasks);
> +	list_add(&task3.tasks, &task1.tasks);

These should also be list_add_tail.

> +
> +	kunit_add_named_resource(test, NULL, NULL, &resource,
> +				 "mock_init_task", &task1);
> +
> +	/* Make sure we have a process list. */
> +	for_each_process(p)
> +		count++;
> +	KUNIT_EXPECT_EQ(test, count, 2);
> +
> +	/* INT_MIN pid must return ESRCH */
> +	KUNIT_EXPECT_EQ(test, -ESRCH,
> +		kill_something_info(SIGHUP, SEND_SIG_NOINFO, INT_MIN));
> +
> +	/* Invalid signal: EINVAL */
> +	KUNIT_EXPECT_EQ(test, -EINVAL,
> +		kill_something_info(_NSIG + 1, SEND_SIG_NOINFO, 2));
> +
> +	/* Missing pid: ESRCH */
> +	KUNIT_EXPECT_EQ(test, -ESRCH,
> +		kill_something_info(SIGHUP, SEND_SIG_NOINFO, 42));

This confirms you don't have a process with pid #42 your system when
the test is run.

> +	/* Bypass permission checks with SEND_SIG_NOINFO. */
> +	KUNIT_EXPECT_EQ(test, 0,
> +		kill_something_info(SIGHUP, SEND_SIG_NOINFO, 2));

This confirms you a process with pid #2 aka kthread on your system when
the test is run.

> +
> +	/* XXX: Hm, I was expecting this to explode in cred deref... */
> +	KUNIT_EXPECT_EQ(test, 0,
> +		kill_something_info(SIGHUP, &siginfo, 3));

This confirms you have a process with pid #3 on your system when the
test is run.  Pid #3 on my system refers to a kthread.

> +
> +	/* XXX more tests here, perhaps after mocking out group_send_sig_info() ... */
> +

You need to mock find_vpid before you test sending to processes.

Right now your tests are not testing sending signals to your mocked
tasks but instead to real tasks.

> +	/* System hangs without this... */
> +	kunit_remove_resource(test, &resource);
> +}
> +
> +static struct kunit_case test_cases[] = {
> +	KUNIT_CASE(test_empty_task_list),
> +	KUNIT_CASE(test_for_each_process),
> +	KUNIT_CASE(test_kill_something_info),
> +	{}
> +};
> +
> +static struct kunit_suite test_suite = {
> +	.name = "signal",
> +	.test_cases = test_cases,
> +};
> +kunit_test_suite(test_suite);
> +#endif	/* CONFIG_KUNIT */
