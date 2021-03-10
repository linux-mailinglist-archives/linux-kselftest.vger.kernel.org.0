Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A718333A5C
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Mar 2021 11:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbhCJKmX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Mar 2021 05:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbhCJKl4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Mar 2021 05:41:56 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2718FC061760
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Mar 2021 02:41:56 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id h21so12432384qkl.12
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Mar 2021 02:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LX0emKbgsHYtGpYyL1x1FnLQ5ewlS0gEm+vlZ3nascQ=;
        b=N/u3p5qkgkVCIorblwjlo0ALkDKW6OemYeWX+fR+AT8w6i0Gh/XvradEyaRC0Nmutk
         j3AGpbLlTACkVr5oi/De9Cf9L/VxHIbruSwuU7HfD6sKWBig/HP45lCrnKDX1aRSOhp6
         ZgdsDxtOtDhrvcdiYBVzGE0Yz/2W3v0FmAEpbD1N+n6ggnT8qnl47gG7JmqqPv3PrAko
         qGwATz9jmqBUcMVHnIzIDgnkvckIW8Sp98YOu5u5o5EwKc4jVHB3aVNz+K9uwfv9Y1rQ
         WjLGhhIrjQcVepjxDJ+LjtV/n+fiN6L3yTzeRv74Ev9+ZDMb8KBoXkY739owMIXjSb+n
         Ursw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LX0emKbgsHYtGpYyL1x1FnLQ5ewlS0gEm+vlZ3nascQ=;
        b=KgFTvZLBSt2ZwmKGWPK4k32IEvV2t0oOLjT6rA8WieGwCy0Kk9MMGDK4SYxialu1L9
         JZJ7mc6Wfal43gsFyaHUpifA6ui7rY5T9vZrFef/GNhpd9uJqOYp4E9+gSkkJOi4YzTM
         THMxOmDR02D2nFiV3jAgJlXfm3iOhiAoZeFANd0ZkKV4y6vKSm0F3DG/MrGFS9okPU1u
         LMCa/25sPXoUbWA69TdBcdLlM27roKJ9zNtrxVxcrLCcaeiqr6fW/3De0UOPf7BW9YjF
         Ii1s3FcXdPt6hxrnr5s2qP7Kt7k+aZzyW9btWq6jT1QzpoYwATc/QUHXShkAWaaB81A0
         5/dw==
X-Gm-Message-State: AOAM530UA2hz6QcP3eJzBJ98basMjFEld0jiO3G58GqtZL7OpFahO7wx
        ECTtQwXYvbx0X9aoIEES9GQVWnJTqg==
X-Google-Smtp-Source: ABdhPJymJDYxCT4IzRtfNhWaSFV/kqnhDLbM/p7NNyqwqrXyZsRP8XQdyy5hJ1tEInGdDs/E4CUY8BMuEw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:e995:ac0b:b57c:49a4])
 (user=elver job=sendgmr) by 2002:ad4:4d82:: with SMTP id cv2mr2356657qvb.6.1615372915311;
 Wed, 10 Mar 2021 02:41:55 -0800 (PST)
Date:   Wed, 10 Mar 2021 11:41:33 +0100
In-Reply-To: <20210310104139.679618-1-elver@google.com>
Message-Id: <20210310104139.679618-3-elver@google.com>
Mime-Version: 1.0
References: <20210310104139.679618-1-elver@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH RFC v2 2/8] perf/core: Support only inheriting events if
 cloned with CLONE_THREAD
From:   Marco Elver <elver@google.com>
To:     elver@google.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, acme@kernel.org,
        mingo@redhat.com, jolsa@redhat.com, mark.rutland@arm.com,
        namhyung@kernel.org, tglx@linutronix.de
Cc:     glider@google.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
        christian@brauner.io, dvyukov@google.com, jannh@google.com,
        axboe@kernel.dk, mascasa@google.com, pcc@google.com,
        irogers@google.com, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Adds bit perf_event_attr::inherit_thread, to restricting inheriting
events only if the child was cloned with CLONE_THREAD.

This option supports the case where an event is supposed to be
process-wide only (including subthreads), but should not propagate
beyond the current process's shared environment.

Link: https://lore.kernel.org/lkml/YBvj6eJR%2FDY2TsEB@hirez.programming.kicks-ass.net/
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Add patch to series.
---
 include/linux/perf_event.h      |  5 +++--
 include/uapi/linux/perf_event.h |  3 ++-
 kernel/events/core.c            | 21 ++++++++++++++-------
 kernel/fork.c                   |  2 +-
 4 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index fab42cfbd350..982ad61c653a 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -955,7 +955,7 @@ extern void __perf_event_task_sched_in(struct task_struct *prev,
 				       struct task_struct *task);
 extern void __perf_event_task_sched_out(struct task_struct *prev,
 					struct task_struct *next);
-extern int perf_event_init_task(struct task_struct *child);
+extern int perf_event_init_task(struct task_struct *child, u64 clone_flags);
 extern void perf_event_exit_task(struct task_struct *child);
 extern void perf_event_free_task(struct task_struct *task);
 extern void perf_event_delayed_put(struct task_struct *task);
@@ -1446,7 +1446,8 @@ perf_event_task_sched_in(struct task_struct *prev,
 static inline void
 perf_event_task_sched_out(struct task_struct *prev,
 			  struct task_struct *next)			{ }
-static inline int perf_event_init_task(struct task_struct *child)	{ return 0; }
+static inline int perf_event_init_task(struct task_struct *child,
+				       u64 clone_flags)			{ return 0; }
 static inline void perf_event_exit_task(struct task_struct *child)	{ }
 static inline void perf_event_free_task(struct task_struct *task)	{ }
 static inline void perf_event_delayed_put(struct task_struct *task)	{ }
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index ad15e40d7f5d..813efb65fea8 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -389,7 +389,8 @@ struct perf_event_attr {
 				cgroup         :  1, /* include cgroup events */
 				text_poke      :  1, /* include text poke events */
 				build_id       :  1, /* use build id in mmap2 events */
-				__reserved_1   : 29;
+				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
+				__reserved_1   : 28;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index bff498766065..a8382e6c907c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11597,6 +11597,9 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 	    (attr->sample_type & PERF_SAMPLE_WEIGHT_STRUCT))
 		return -EINVAL;
 
+	if (!attr->inherit && attr->inherit_thread)
+		return -EINVAL;
+
 out:
 	return ret;
 
@@ -12820,12 +12823,13 @@ static int
 inherit_task_group(struct perf_event *event, struct task_struct *parent,
 		   struct perf_event_context *parent_ctx,
 		   struct task_struct *child, int ctxn,
-		   int *inherited_all)
+		   u64 clone_flags, int *inherited_all)
 {
 	int ret;
 	struct perf_event_context *child_ctx;
 
-	if (!event->attr.inherit) {
+	if (!event->attr.inherit ||
+	    (event->attr.inherit_thread && !(clone_flags & CLONE_THREAD))) {
 		*inherited_all = 0;
 		return 0;
 	}
@@ -12857,7 +12861,8 @@ inherit_task_group(struct perf_event *event, struct task_struct *parent,
 /*
  * Initialize the perf_event context in task_struct
  */
-static int perf_event_init_context(struct task_struct *child, int ctxn)
+static int perf_event_init_context(struct task_struct *child, int ctxn,
+				   u64 clone_flags)
 {
 	struct perf_event_context *child_ctx, *parent_ctx;
 	struct perf_event_context *cloned_ctx;
@@ -12897,7 +12902,8 @@ static int perf_event_init_context(struct task_struct *child, int ctxn)
 	 */
 	perf_event_groups_for_each(event, &parent_ctx->pinned_groups) {
 		ret = inherit_task_group(event, parent, parent_ctx,
-					 child, ctxn, &inherited_all);
+					 child, ctxn, clone_flags,
+					 &inherited_all);
 		if (ret)
 			goto out_unlock;
 	}
@@ -12913,7 +12919,8 @@ static int perf_event_init_context(struct task_struct *child, int ctxn)
 
 	perf_event_groups_for_each(event, &parent_ctx->flexible_groups) {
 		ret = inherit_task_group(event, parent, parent_ctx,
-					 child, ctxn, &inherited_all);
+					 child, ctxn, clone_flags,
+					 &inherited_all);
 		if (ret)
 			goto out_unlock;
 	}
@@ -12955,7 +12962,7 @@ static int perf_event_init_context(struct task_struct *child, int ctxn)
 /*
  * Initialize the perf_event context in task_struct
  */
-int perf_event_init_task(struct task_struct *child)
+int perf_event_init_task(struct task_struct *child, u64 clone_flags)
 {
 	int ctxn, ret;
 
@@ -12964,7 +12971,7 @@ int perf_event_init_task(struct task_struct *child)
 	INIT_LIST_HEAD(&child->perf_event_list);
 
 	for_each_task_context_nr(ctxn) {
-		ret = perf_event_init_context(child, ctxn);
+		ret = perf_event_init_context(child, ctxn, clone_flags);
 		if (ret) {
 			perf_event_free_task(child);
 			return ret;
diff --git a/kernel/fork.c b/kernel/fork.c
index d3171e8e88e5..d090366d1206 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2070,7 +2070,7 @@ static __latent_entropy struct task_struct *copy_process(
 	if (retval)
 		goto bad_fork_cleanup_policy;
 
-	retval = perf_event_init_task(p);
+	retval = perf_event_init_task(p, clone_flags);
 	if (retval)
 		goto bad_fork_cleanup_policy;
 	retval = audit_alloc(p);
-- 
2.30.1.766.gb4fecdf3b7-goog

