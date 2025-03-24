Return-Path: <linux-kselftest+bounces-29654-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBA7A6E0EC
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 18:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 726713B4284
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 17:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F300264FA9;
	Mon, 24 Mar 2025 17:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YMawbmN/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D09F264A8B
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 17:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837579; cv=none; b=YUaz9SwDliqTNetvyS2eBjdx1KvKtArtlstBzL9ylE7IlcD4VA5Hc7uqlnGAfVATvdinOiyKK0i5n9PGW3Hm1UnWpIRW1Q+qtXQTsx0M8SGv2wmh63hQvBXW7EJXOIKN5j4v7RjZPq8QfLJDb/oTVhpzReZdc6hnVMe9XRfiAqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837579; c=relaxed/simple;
	bh=NcnzPjuIhnNCxZC5lReB3dPlHVdpnq0sLTE3KLRRIoo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HH+JAHFQ+cSCoNbQCuq4uHTz8t8XAbKfzUlqfkAl+ZFRDUj460nJsxEXxkn4kZ0D49p+fRoRxXcb2fCAseRW2GLJhiTKyJZ9vnPOo6HfMFUP6WIWQLKltIPK3/DjH9D9sT1L6PNbQ5AdLNtGalU9eRb4u2pv3+LahWzSqqTL5iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YMawbmN/; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff798e8c93so7690683a91.2
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 10:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742837576; x=1743442376; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=KoYa355W4V2QzzqqNj1mxjyWfMrgeXRfAYA+4A7CYtI=;
        b=YMawbmN/HKbdbR0nG2L7gp3niUKQSjNcsbrZ/9XNmMKL2trg0lvFqmboHapAwaHCTg
         ItbkAVBHoRzcy2KMtZACiUXjqNJx5z6mbyRmK5ZNaW3a/kXcKQ9Mo5QOe0Hn/GQakUwx
         Aw9DgZoxg+23ROyuasdfG87mdgSkee26iOQXvhAIxnfR9RnTW2Wen0MOLP4uFUT2um5s
         zjs+LAnAcQQP244fhqhC/X3SHsxHqG6IcvKABQc2T2h7JtTkqqFKrBsV8bpSgxe4TY8Y
         nwTbtt6X0ILtGgsEdyaJKj0u/aDJ3C6i1apNXnSm+qRBR1BrTpeLcLyh0/qx7ot2fNCJ
         K7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837576; x=1743442376;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KoYa355W4V2QzzqqNj1mxjyWfMrgeXRfAYA+4A7CYtI=;
        b=U0J3OZflnXMV5QvmlACz47OV8ADkWMG1BgbbiZELvAtAE+nCpY9lBYQKVbwy4sSS2y
         La6RXFOZahsMsXaWOkydzVFqpxFIjDzrC8pqnNcqSPXbcNKNRLh2a2IAKcQ+XqCkTMYW
         X7Z3NLK7CV4h+J5SiRNET202e6MSB6LRiNGVZo6hFgySTxEqUymQF5Xb2V/Kyg/jqbqO
         3qKPoqT5OZwiPvFseAUIeepvy3SSBXoV8EGFsHByUG5l8U2LniW6GjxsUkqQk6mLWiSN
         yAEm/jsAAM7+T+jtgJnPatl5Z+m//7IdY+uZUtA6GrB9jkau208i1eAACuPMFBzK2Exc
         n+Iw==
X-Forwarded-Encrypted: i=1; AJvYcCV1Sq4iU3sAkXdObtNo4lR/NQ5wDK2V60mZe0Rnmfnj8/Toe8B+neJ/TciYtdYPOFJsPeDkjxB8CTMTtyeWGCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8H8TTUT1w6ATDg4kijOJAlZxYCnCNJ3PCFptG4jjF75e4usm6
	b6ulHlJqHUGwm2QxSSre6EY8pixBeLPvu7M0AWlGN4OehtbsegCNgH/puYqXys8N8FrFBqtvL1z
	3IjoEDA==
X-Google-Smtp-Source: AGHT+IHhB1eRQEES3YcQZzL9/Q9I1UVQ0Y8OuRAelA2GczZLgreS9vzo+vXqpeBrMgIJJXRiX0b/GiqfnHPy
X-Received: from pjbsb12.prod.google.com ([2002:a17:90b:50cc:b0:2ff:8471:8e53])
 (user=mizhang job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:53c3:b0:2fe:b77a:2eab
 with SMTP id 98e67ed59e1d1-3030ff21ed4mr19622571a91.32.1742837576464; Mon, 24
 Mar 2025 10:32:56 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon, 24 Mar 2025 17:30:43 +0000
In-Reply-To: <20250324173121.1275209-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324173121.1275209-4-mizhang@google.com>
Subject: [PATCH v4 03/38] perf: Clean up perf ctx time
From: Mingwei Zhang <mizhang@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Yongwei Ma <yongwei.ma@intel.com>, 
	Xiong Zhang <xiong.y.zhang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Jim Mattson <jmattson@google.com>, Sandipan Das <sandipan.das@amd.com>, 
	Zide Chen <zide.chen@intel.com>, Eranian Stephane <eranian@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Nikunj Dadhania <nikunj.dadhania@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Kan Liang <kan.liang@linux.intel.com>

The current perf tracks two timestamps for the normal ctx and cgroup.
The same type of variables and similar codes are used to track the
timestamps. In the following patch, the third timestamp to track the
guest time will be introduced.
To avoid the code duplication, add a new struct perf_time_ctx and factor
out a generic function update_perf_time_ctx().

No functional change.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 include/linux/perf_event.h | 13 +++----
 kernel/events/core.c       | 70 +++++++++++++++++---------------------
 2 files changed, 39 insertions(+), 44 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 54018dd0b2a4..a2fd1bdc955c 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -953,6 +953,11 @@ struct perf_event_groups {
 	u64		index;
 };
 
+struct perf_time_ctx {
+	u64		time;
+	u64		stamp;
+	u64		offset;
+};
 
 /**
  * struct perf_event_context - event context structure
@@ -992,9 +997,7 @@ struct perf_event_context {
 	/*
 	 * Context clock, runs when context enabled.
 	 */
-	u64				time;
-	u64				timestamp;
-	u64				timeoffset;
+	struct perf_time_ctx		time;
 
 	/*
 	 * These fields let us detect when two contexts have both
@@ -1085,9 +1088,7 @@ struct bpf_perf_event_data_kern {
  * This is a per-cpu dynamically allocated data structure.
  */
 struct perf_cgroup_info {
-	u64				time;
-	u64				timestamp;
-	u64				timeoffset;
+	struct perf_time_ctx		time;
 	int				active;
 };
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8d3a0cc59fb4..e38c8b5e8086 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -770,6 +770,24 @@ static void perf_ctx_enable(struct perf_event_context *ctx,
 static void ctx_sched_out(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t event_type);
 static void ctx_sched_in(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t event_type);
 
+static inline void update_perf_time_ctx(struct perf_time_ctx *time, u64 now, bool adv)
+{
+	if (adv)
+		time->time += now - time->stamp;
+	time->stamp = now;
+
+	/*
+	 * The above: time' = time + (now - timestamp), can be re-arranged
+	 * into: time` = now + (time - timestamp), which gives a single value
+	 * offset to compute future time without locks on.
+	 *
+	 * See perf_event_time_now(), which can be used from NMI context where
+	 * it's (obviously) not possible to acquire ctx->lock in order to read
+	 * both the above values in a consistent manner.
+	 */
+	WRITE_ONCE(time->offset, time->time - time->stamp);
+}
+
 #ifdef CONFIG_CGROUP_PERF
 
 static inline bool
@@ -811,7 +829,7 @@ static inline u64 perf_cgroup_event_time(struct perf_event *event)
 	struct perf_cgroup_info *t;
 
 	t = per_cpu_ptr(event->cgrp->info, event->cpu);
-	return t->time;
+	return t->time.time;
 }
 
 static inline u64 perf_cgroup_event_time_now(struct perf_event *event, u64 now)
@@ -820,22 +838,11 @@ static inline u64 perf_cgroup_event_time_now(struct perf_event *event, u64 now)
 
 	t = per_cpu_ptr(event->cgrp->info, event->cpu);
 	if (!__load_acquire(&t->active))
-		return t->time;
-	now += READ_ONCE(t->timeoffset);
+		return t->time.time;
+	now += READ_ONCE(t->time.offset);
 	return now;
 }
 
-static inline void __update_cgrp_time(struct perf_cgroup_info *info, u64 now, bool adv)
-{
-	if (adv)
-		info->time += now - info->timestamp;
-	info->timestamp = now;
-	/*
-	 * see update_context_time()
-	 */
-	WRITE_ONCE(info->timeoffset, info->time - info->timestamp);
-}
-
 static inline void update_cgrp_time_from_cpuctx(struct perf_cpu_context *cpuctx, bool final)
 {
 	struct perf_cgroup *cgrp = cpuctx->cgrp;
@@ -849,7 +856,7 @@ static inline void update_cgrp_time_from_cpuctx(struct perf_cpu_context *cpuctx,
 			cgrp = container_of(css, struct perf_cgroup, css);
 			info = this_cpu_ptr(cgrp->info);
 
-			__update_cgrp_time(info, now, true);
+			update_perf_time_ctx(&info->time, now, true);
 			if (final)
 				__store_release(&info->active, 0);
 		}
@@ -872,7 +879,7 @@ static inline void update_cgrp_time_from_event(struct perf_event *event)
 	 * Do not update time when cgroup is not active
 	 */
 	if (info->active)
-		__update_cgrp_time(info, perf_clock(), true);
+		update_perf_time_ctx(&info->time, perf_clock(), true);
 }
 
 static inline void
@@ -896,7 +903,7 @@ perf_cgroup_set_timestamp(struct perf_cpu_context *cpuctx)
 	for (css = &cgrp->css; css; css = css->parent) {
 		cgrp = container_of(css, struct perf_cgroup, css);
 		info = this_cpu_ptr(cgrp->info);
-		__update_cgrp_time(info, ctx->timestamp, false);
+		update_perf_time_ctx(&info->time, ctx->time.stamp, false);
 		__store_release(&info->active, 1);
 	}
 }
@@ -1511,20 +1518,7 @@ static void __update_context_time(struct perf_event_context *ctx, bool adv)
 
 	lockdep_assert_held(&ctx->lock);
 
-	if (adv)
-		ctx->time += now - ctx->timestamp;
-	ctx->timestamp = now;
-
-	/*
-	 * The above: time' = time + (now - timestamp), can be re-arranged
-	 * into: time` = now + (time - timestamp), which gives a single value
-	 * offset to compute future time without locks on.
-	 *
-	 * See perf_event_time_now(), which can be used from NMI context where
-	 * it's (obviously) not possible to acquire ctx->lock in order to read
-	 * both the above values in a consistent manner.
-	 */
-	WRITE_ONCE(ctx->timeoffset, ctx->time - ctx->timestamp);
+	update_perf_time_ctx(&ctx->time, now, adv);
 }
 
 static void update_context_time(struct perf_event_context *ctx)
@@ -1542,7 +1536,7 @@ static u64 perf_event_time(struct perf_event *event)
 	if (is_cgroup_event(event))
 		return perf_cgroup_event_time(event);
 
-	return ctx->time;
+	return ctx->time.time;
 }
 
 static u64 perf_event_time_now(struct perf_event *event, u64 now)
@@ -1556,9 +1550,9 @@ static u64 perf_event_time_now(struct perf_event *event, u64 now)
 		return perf_cgroup_event_time_now(event, now);
 
 	if (!(__load_acquire(&ctx->is_active) & EVENT_TIME))
-		return ctx->time;
+		return ctx->time.time;
 
-	now += READ_ONCE(ctx->timeoffset);
+	now += READ_ONCE(ctx->time.offset);
 	return now;
 }
 
@@ -11533,14 +11527,14 @@ static void task_clock_event_update(struct perf_event *event, u64 now)
 
 static void task_clock_event_start(struct perf_event *event, int flags)
 {
-	local64_set(&event->hw.prev_count, event->ctx->time);
+	local64_set(&event->hw.prev_count, event->ctx->time.time);
 	perf_swevent_start_hrtimer(event);
 }
 
 static void task_clock_event_stop(struct perf_event *event, int flags)
 {
 	perf_swevent_cancel_hrtimer(event);
-	task_clock_event_update(event, event->ctx->time);
+	task_clock_event_update(event, event->ctx->time.time);
 }
 
 static int task_clock_event_add(struct perf_event *event, int flags)
@@ -11560,8 +11554,8 @@ static void task_clock_event_del(struct perf_event *event, int flags)
 static void task_clock_event_read(struct perf_event *event)
 {
 	u64 now = perf_clock();
-	u64 delta = now - event->ctx->timestamp;
-	u64 time = event->ctx->time + delta;
+	u64 delta = now - event->ctx->time.stamp;
+	u64 time = event->ctx->time.time + delta;
 
 	task_clock_event_update(event, time);
 }
-- 
2.49.0.395.g12beb8f557-goog


