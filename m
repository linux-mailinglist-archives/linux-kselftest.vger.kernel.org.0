Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB56077C210
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 23:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbjHNVFZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 17:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbjHNVFY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 17:05:24 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2F6DE
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Aug 2023 14:05:23 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bc7b25c699so29252695ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Aug 2023 14:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692047123; x=1692651923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rbAqdxFtoX3bkDfM4kN5C0n/JYAhX0IdvmwRc1W7v3E=;
        b=aU1riK9M1P7N+89kCy8Te9dMZuoQB8HuURBX7Sr5hfor3VlfCzKzpOFaL4jdvqZaBh
         GubU/DiG1dcOLQsD9bSYv+UQxc3ROrfo6bvgyb54pURtJzzZeOmKU1/9RAD9yyF6syQC
         9i1nx3a+96L/srFeZicMFIvxQHoY6GS7oYYgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692047123; x=1692651923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rbAqdxFtoX3bkDfM4kN5C0n/JYAhX0IdvmwRc1W7v3E=;
        b=iipfHdztNkVrFCo8JqhRr87p2kaxZxPhsVU7Bk/znzW0cqRkueTnJ6GYr4oMzaJxOb
         JeD3cwOxbX6kEHvEQR5YprBkeimhomllEljpajZm+cVEBfrCpoOMyij4W8mHXbZkrmPy
         XHXebgFDktLLVPqEhztghH6lt4RzIwp4AhQY0UCsnCbeDNbkzv92Ll1kuhluo1nkBlhE
         LsAcTPKh0NZuBSHBXmAne8jq0bpzRbqcvvfJKtuYctDCXjsWfvZld0NX5fP+2FppCpjH
         pZH1uTnxU2hLORhnUAPQGfMqcZS82CuXCyn2yNqzVhR4dHirEXt7sQLxB8+OAbfjpBmw
         jEMw==
X-Gm-Message-State: AOJu0YxBoFYA8RolMHzMxWxil7xKSwKKJJnxUbt3ZWt4IO7db5KMJF30
        SB9dkqn4YFrdB12becDWYJNR9GUw2mSA/QBooA0=
X-Google-Smtp-Source: AGHT+IHOyv6KjV38QRfIiFQ0899WKF/5k7KLFAQqKabq/9I1n/gQ3lqbSVx4EKttbStm2ZO1+AKozg==
X-Received: by 2002:a17:902:db05:b0:1bb:c971:ef92 with SMTP id m5-20020a170902db0500b001bbc971ef92mr9928350plx.59.1692047122793;
        Mon, 14 Aug 2023 14:05:22 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u18-20020a170903125200b001b53953f306sm9905125plh.178.2023.08.14.14.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 14:05:22 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Brendan Higgins <brendan.higgins@linux.dev>
Cc:     Kees Cook <keescook@chromium.org>, David Gow <davidgow@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
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
Subject: [PATCH] [RFC] signal: Add KUnit tests
Date:   Mon, 14 Aug 2023 14:05:12 -0700
Message-Id: <20230814210508.never.871-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7560; i=keescook@chromium.org;
 h=from:subject:message-id; bh=PF2MobMOQslBs357nkGARKlzx63FBChyOYfmSJC+BxQ=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk2pcIIK4kP2LoF7unJCvNcio7tUwScsAvQ3EDT
 GBzEOhmGJuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZNqXCAAKCRCJcvTf3G3A
 JtlTD/98HMw5S03yxakwDr6hYsu4qQvVnrvfZ8hdgJPMEQMpRFZgSMej0/hW1+bIraY/Qb1RliA
 KEY0hxPvy74YgihZOqpokV2KwA3xp9VguHLMYShkUzY8kpag9eeFHvWraqR8hudJivoEYN3CZP7
 BdGahPBGtGq/dIEvKJ/dScCrODM6B9sJzXIkugQ2zsgnAR9ThR2TFEqM8HdnvSPtZu5BvFngmft
 1lh91CSKOA8w9xSefd4HxUqaUItmIen8pIDBvzE5LbfmcY3u2IO0IlZdjAcTSpO3ykqWoBGUKl7
 vdcdT32v7ihsqmzJFq2lYhndA2aKd0cq9Hl7bOnRpjUXCwki0STfqVBDBUJch2TJBOboroaWv5x
 6FLH2TujmMvP6ZmRW0C/JTYdQo8RdWOQvKnQN8cLNW8azXwNcRbvHmLtUFb1b4wXopaP7iazlvz
 wiL9XAfwJceLR3UgcADT2W+nYDktcU4M3QX3/EMg6K/rGepdky9QNFNEgl+GbUZ9bL/+xw/fMWd
 GPi24csOyaXK/sydgiIalwwLlqAVw1P2D1IANttv35NhQWqs/XQzOz/PgipcapnHuCPigwchP4j
 6cCiitzVyXMt5uqNKfbOI8PvtJhu4LtOFdrpJFCzqxevHLxEprt5Rq49rxWCmNwb51CqL6O4wxe
 i2Wm1ma TkkHA0Rg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a continuation of the proposal[1] for mocking init_task for
KUnit testing. Changing the behavior of kill_something_info() is moving
forward[2] and I'd _really_ like to have some unit tests in place to
actually test the behavioral changes.

I tried to incorporate feedback from Daniel and David, and I think the
result is fairly workable -- the only tricky part is building valid
task_struct instances. :)

Notably, I haven't actually gotten as far as testing the actual proposed
behavioral change since I wanted to make sure this approach wasn't going
to totally crash and burn.

Thoughts?

[1] https://lore.kernel.org/all/202212012008.D6F6109@keescook/
[2] https://lore.kernel.org/all/87jzu12pjh.fsf_-_@email.froward.int.ebiederm.org

Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Petr Skocik <pskocik@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-kselftest@vger.kernel.org
Cc: kunit-dev@googlegroups.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/kunit/resource.h     |  15 ++++
 include/linux/sched/signal.h |  11 ++-
 kernel/signal.c              | 135 +++++++++++++++++++++++++++++++++++
 3 files changed, 158 insertions(+), 3 deletions(-)

diff --git a/include/kunit/resource.h b/include/kunit/resource.h
index c7383e90f5c9..dbf84a58f7a6 100644
--- a/include/kunit/resource.h
+++ b/include/kunit/resource.h
@@ -479,4 +479,19 @@ void kunit_remove_action(struct kunit *test,
 void kunit_release_action(struct kunit *test,
 			  kunit_action_t *action,
 			  void *ctx);
+
+#define kunit_get_mock_pointer(name, actual) ({			\
+	typeof(*(actual)) *ptr = actual;			\
+	struct kunit_resource *resource;			\
+								\
+	if (kunit_get_current_test()) {				\
+		resource = kunit_find_named_resource(current->kunit_test, name); \
+		if (resource) {					\
+			ptr = resource->data;			\
+			kunit_put_resource(resource);		\
+		}						\
+	}							\
+	ptr;							\
+})
+
 #endif /* _KUNIT_RESOURCE_H */
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 669e8cff40c7..700271f43491 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -637,14 +637,19 @@ static inline unsigned long sigsp(unsigned long sp, struct ksignal *ksig)
 extern void __cleanup_sighand(struct sighand_struct *);
 extern void flush_itimer_signals(void);
 
+/* This is used for KUnit mocking. */
+#ifndef __init_task_ptr
+#define __init_task_ptr	(&init_task)
+#endif
+
 #define tasklist_empty() \
-	list_empty(&init_task.tasks)
+	list_empty(&__init_task_ptr->tasks)
 
 #define next_task(p) \
 	list_entry_rcu((p)->tasks.next, struct task_struct, tasks)
 
 #define for_each_process(p) \
-	for (p = &init_task ; (p = next_task(p)) != &init_task ; )
+	for (p = __init_task_ptr ; (p = next_task(p)) != __init_task_ptr ; )
 
 extern bool current_is_single_threaded(void);
 
@@ -653,7 +658,7 @@ extern bool current_is_single_threaded(void);
  *          'break' will not work as expected - use goto instead.
  */
 #define do_each_thread(g, t) \
-	for (g = t = &init_task ; (g = t = next_task(g)) != &init_task ; ) do
+	for (g = t = __init_task_ptr ; (g = t = next_task(g)) != __init_task_ptr ; ) do
 
 #define while_each_thread(g, t) \
 	while ((t = next_thread(t)) != g)
diff --git a/kernel/signal.c b/kernel/signal.c
index b5370fe5c198..7607d302ebb9 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -11,6 +11,14 @@
  *		to allow signals to be sent reliably.
  */
 
+#if IS_ENABLED(CONFIG_KUNIT)
+/* This must be defined before we include include/linux/sched/signal.h */
+#define __init_task_ptr kunit_get_mock_pointer("mock_init_task", &init_task)
+
+#include <kunit/resource.h>
+#include <kunit/test-bug.h>
+#endif
+
 #include <linux/slab.h>
 #include <linux/export.h>
 #include <linux/init.h>
@@ -4842,3 +4850,130 @@ void kdb_send_sig(struct task_struct *t, int sig)
 		kdb_printf("Signal %d is sent to process %d.\n", sig, t->pid);
 }
 #endif	/* CONFIG_KGDB_KDB */
+
+#if IS_ENABLED(CONFIG_KUNIT)
+static void test_empty_task_list(struct kunit *test)
+{
+	struct kunit_resource resource;
+	static struct task_struct empty_task_list = {
+			.tasks	= LIST_HEAD_INIT(empty_task_list.tasks),
+		};
+	struct task_struct *p;
+	int count = 0;
+
+	kunit_add_named_resource(test, NULL, NULL, &resource,
+				 "mock_init_task", &empty_task_list);
+
+	KUNIT_EXPECT_TRUE(test, tasklist_empty());
+
+	for_each_process(p)
+		count++;
+
+	/* System hangs without this... */
+	kunit_remove_resource(test, &resource);
+
+	KUNIT_EXPECT_EQ(test, count, 0);
+}
+
+static void test_for_each_process(struct kunit *test)
+{
+	struct kunit_resource resource;
+	static struct task_struct task1 = {
+			.pid = 1,
+			.tasks	= LIST_HEAD_INIT(task1.tasks),
+		};
+	static struct task_struct task2 = {
+			.pid = 2,
+		}, task3 = {
+			.pid = 3,
+		};
+	struct task_struct *p;
+	int count = 0;
+
+	list_add(&task2.tasks, &task1.tasks);
+	list_add(&task3.tasks, &task1.tasks);
+
+	kunit_add_named_resource(test, NULL, NULL, &resource,
+				 "mock_init_task", &task1);
+
+	/* Walk the process list backwards. */
+	for_each_process(p) {
+		KUNIT_EXPECT_EQ(test, 3 - count, p->pid);
+		count++;
+	}
+
+	/* System hangs without this... */
+	kunit_remove_resource(test, &resource);
+
+	/* init_task isn't counted... */
+	KUNIT_EXPECT_EQ(test, count, 2);
+}
+
+static void test_kill_something_info(struct kunit *test)
+{
+	struct kunit_resource resource;
+	static struct task_struct task1 = {
+			.pid = 1,
+			.tasks	= LIST_HEAD_INIT(task1.tasks),
+		};
+	static struct task_struct task2 = {
+			.pid = 2,
+		}, task3 = {
+			.pid = 3,
+		};
+	struct kernel_siginfo siginfo = {
+			.si_code = SI_KERNEL,
+		};
+	struct task_struct *p;
+	int count = 0;
+
+	list_add(&task2.tasks, &task1.tasks);
+	list_add(&task3.tasks, &task1.tasks);
+
+	kunit_add_named_resource(test, NULL, NULL, &resource,
+				 "mock_init_task", &task1);
+
+	/* Make sure we have a process list. */
+	for_each_process(p)
+		count++;
+	KUNIT_EXPECT_EQ(test, count, 2);
+
+	/* INT_MIN pid must return ESRCH */
+	KUNIT_EXPECT_EQ(test, -ESRCH,
+		kill_something_info(SIGHUP, SEND_SIG_NOINFO, INT_MIN));
+
+	/* Invalid signal: EINVAL */
+	KUNIT_EXPECT_EQ(test, -EINVAL,
+		kill_something_info(_NSIG + 1, SEND_SIG_NOINFO, 2));
+
+	/* Missing pid: ESRCH */
+	KUNIT_EXPECT_EQ(test, -ESRCH,
+		kill_something_info(SIGHUP, SEND_SIG_NOINFO, 42));
+
+	/* Bypass permission checks with SEND_SIG_NOINFO. */
+	KUNIT_EXPECT_EQ(test, 0,
+		kill_something_info(SIGHUP, SEND_SIG_NOINFO, 2));
+
+	/* XXX: Hm, I was expecting this to explode in cred deref... */
+	KUNIT_EXPECT_EQ(test, 0,
+		kill_something_info(SIGHUP, &siginfo, 3));
+
+	/* XXX more tests here, perhaps after mocking out group_send_sig_info() ... */
+
+	/* System hangs without this... */
+	kunit_remove_resource(test, &resource);
+}
+
+static struct kunit_case test_cases[] = {
+	KUNIT_CASE(test_empty_task_list),
+	KUNIT_CASE(test_for_each_process),
+	KUNIT_CASE(test_kill_something_info),
+	{}
+};
+
+static struct kunit_suite test_suite = {
+	.name = "signal",
+	.test_cases = test_cases,
+};
+kunit_test_suite(test_suite);
+#endif	/* CONFIG_KUNIT */
-- 
2.34.1

