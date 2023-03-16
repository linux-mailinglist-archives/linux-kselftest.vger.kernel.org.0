Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712056BCF87
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 13:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjCPMb7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Mar 2023 08:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjCPMb6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Mar 2023 08:31:58 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7BAC88B4
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Mar 2023 05:31:57 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-541942bfdccso13771087b3.14
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Mar 2023 05:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678969916;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=87DZZv3zvWxq1JNrpUvBlJXCIWW+Rra/IVtOi+lv2AY=;
        b=qCtLERy62hEhlxSG/0eouCyDubA5IlOQzhKT2mnHloimO+vyrKei3sI8aJq1Tfj3qo
         14b4Ounm+uimNdlEK6Gl1oKiwLH2oXLtNv7TDzmIibqjvnhVsYKbFeHnWom15qxZpv7E
         5tOLPt/Rhk6QEnPn8W1CABp2zBMKp0CBPEXm1BE2uMklheDAqZWfiip3/rl6zFZvRNo1
         r2Z8izryfAq4Y83tOgyd4a84rYY84JZ4Xsr8I1WQTjjxx5eNPvCps/nAEOnaV8B1vU7D
         3V/f1c1bck0wJUie1OxMnbvg8BDG+pUfLdOJT4U31Beb6tiecEyvJAK/k9YvtACNmOeC
         /+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678969916;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=87DZZv3zvWxq1JNrpUvBlJXCIWW+Rra/IVtOi+lv2AY=;
        b=nfKv95IGP5nOEhkZ45kHLmqeVf7yaLvcPNT9V+1rp2kVlyctoTctaOgUKcXE24byxX
         fkQGC/TJDntY7KqU7fv1T9AkK/52SBytz0V7aXD+gszMDQiydK4AAohnBHUtN6NYiK3r
         yokN8sZoxsEh9RPgEqJ77o3P9P34POZbjvGTI/lnSK7Z3L/9O8iDyvghENwtop0L1Lqg
         y6LVuVkqKKMNt10WXTjtDGswBlutnJ9ClviVjH0qU1sMxUkaBXoHhlZcucCRmvG4ETRk
         jUyf3ozFmDb0DekIK9p8bLGwPDsTyd8mxFUXjtZJKwg4wrMBTYYJYZxcRR2oAsIfQ5d7
         Zigg==
X-Gm-Message-State: AO0yUKXP+tIA0eiIkU7kopgJ2c9vpRvWpCPN0RuY/dxzMTPIg7gJpxza
        a7ng/QTcPUWGQ+pfxdOaLZ8uqGu2qg==
X-Google-Smtp-Source: AK7set8JP+8/fO1CBDiuj35SBYwSWx/12DvLYxR4mHEgN+gX3ZM7tBbPLfdlKovQQ+AeL7C/2ao8pYromw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:f359:6b95:96e:1317])
 (user=elver job=sendgmr) by 2002:a81:b306:0:b0:541:61aa:9e60 with SMTP id
 r6-20020a81b306000000b0054161aa9e60mr2038578ywh.6.1678969916701; Thu, 16 Mar
 2023 05:31:56 -0700 (PDT)
Date:   Thu, 16 Mar 2023 13:30:27 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230316123028.2890338-1-elver@google.com>
Subject: [PATCH v6 1/2] posix-timers: Prefer delivery of signals to the
 current thread
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Dmitry Vyukov <dvyukov@google.com>

POSIX timers using the CLOCK_PROCESS_CPUTIME_ID clock prefer the main
thread of a thread group for signal delivery.     However, this has a
significant downside: it requires waking up a potentially idle thread.

Instead, prefer to deliver signals to the current thread (in the same
thread group) if SIGEV_THREAD_ID is not set by the user. This does not
change guaranteed semantics, since POSIX process CPU time timers have
never guaranteed that signal delivery is to a specific thread (without
SIGEV_THREAD_ID set).

The effect is that we no longer wake up potentially idle threads, and
the kernel is no longer biased towards delivering the timer signal to
any particular thread (which better distributes the timer signals esp.
when multiple timers fire concurrently).

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Marco Elver <elver@google.com>
---
v6:
- Split test from this patch.
- Update wording on what this patch aims to improve.

v5:
- Rebased onto v6.2.

v4:
- Restructured checks in send_sigqueue() as suggested.

v3:
- Switched to the completely different implementation (much simpler)
  based on the Oleg's idea.

RFC v2:
- Added additional Cc as Thomas asked.
---
 kernel/signal.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 8cb28f1df294..605445fa27d4 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1003,8 +1003,7 @@ static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
 	/*
 	 * Now find a thread we can wake up to take the signal off the queue.
 	 *
-	 * If the main thread wants the signal, it gets first crack.
-	 * Probably the least surprising to the average bear.
+	 * Try the suggested task first (may or may not be the main thread).
 	 */
 	if (wants_signal(sig, p))
 		t = p;
@@ -1970,8 +1969,23 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
 
 	ret = -1;
 	rcu_read_lock();
+	/*
+	 * This function is used by POSIX timers to deliver a timer signal.
+	 * Where type is PIDTYPE_PID (such as for timers with SIGEV_THREAD_ID
+	 * set), the signal must be delivered to the specific thread (queues
+	 * into t->pending).
+	 *
+	 * Where type is not PIDTYPE_PID, signals must just be delivered to the
+	 * current process. In this case, prefer to deliver to current if it is
+	 * in the same thread group as the target, as it avoids unnecessarily
+	 * waking up a potentially idle task.
+	 */
 	t = pid_task(pid, type);
-	if (!t || !likely(lock_task_sighand(t, &flags)))
+	if (!t)
+		goto ret;
+	if (type != PIDTYPE_PID && same_thread_group(t, current))
+		t = current;
+	if (!likely(lock_task_sighand(t, &flags)))
 		goto ret;
 
 	ret = 1; /* the signal is ignored */
@@ -1993,6 +2007,11 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
 	q->info.si_overrun = 0;
 
 	signalfd_notify(t, sig);
+	/*
+	 * If the type is not PIDTYPE_PID, we just use shared_pending, which
+	 * won't guarantee that the specified task will receive the signal, but
+	 * is sufficient if t==current in the common case.
+	 */
 	pending = (type != PIDTYPE_PID) ? &t->signal->shared_pending : &t->pending;
 	list_add_tail(&q->list, &pending->list);
 	sigaddset(&pending->signal, sig);
-- 
2.40.0.rc1.284.g88254d51c5-goog

