Return-Path: <linux-kselftest+bounces-29655-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E62A6E0F7
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 18:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF6D9171E11
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 17:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713E426561E;
	Mon, 24 Mar 2025 17:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="geUbrIM8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CBC264F96
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 17:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837581; cv=none; b=H0ZOHDadB68YPrCQkP0+YqJqIz7dZkCuj+yuH2Yw5AQRGpePhfuYY+MMMsm2BhqbzOTy0ZrBY7Tlu98SlRWS3n73i3LNTvZXkQKKBDBsBDigpI2PY0IGABOcKy/lE8rvoKaO1LJO5EAudc4rzP/QK95fQHHhBa5tXz/ajHNjpOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837581; c=relaxed/simple;
	bh=2BuPXqNLxQTdVsROf7TWyuiDpNEn5WKq6vsqxN17VCM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YGpXO3FQqGJ9WPhgP43pARUZiGEELPBv1bdIdAvNL0naRV/6AVGz5gw/yokJmAHxr21STMwkT4Vu8TGIxGQkYW35W0r8YOwLP2y53J2yeID0hBCJa+nepRKE4FrDKEEHXLTiMxvA+RsxKFGQapPsxLN4PE0YSXRNHMS0uIjlZzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=geUbrIM8; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2242ce15cc3so72759565ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 10:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742837578; x=1743442378; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=DpGhOlvCPgKwpoUjFAthOd+ucVcRh8xk9vyIDZMuNkk=;
        b=geUbrIM8eV8759iJ9cKsQDvEHstkqzGsqNLsZWbJp44mjgDyXRp+nzZoNHQzrUQPFx
         /2HnQ81hs3YN9uNai84nwbDqzUTEomy7fovrofSwHCb8f1e2BeHCvAsWvZcnZtQwFl2G
         ehWvID2M2TDi8y0fRXUZ6OzcIVzXo3qgt9Wrn9fajPaf8PhzkkowTZ1hyUpKuSnMMsDQ
         xSVH/sHljYusntZKgu/N9GHe2/QFpoE0mm0l/zU3Q2KtWLSVIRmARML2KEOzRfGI67pt
         xCV3Amq8drJIhD5YA41Zt/QRezGwggtgqZVw3D8CqxdhvD7zT/0E5s4Qv3XUrLKniplA
         83qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837578; x=1743442378;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DpGhOlvCPgKwpoUjFAthOd+ucVcRh8xk9vyIDZMuNkk=;
        b=uYfsaqhl7yD9hqhqUAF9ZLazjjiXkAmIMZ7S/fFL3CX3MYJGuWisfExGa+bU+w4/M7
         TZ9V/R7iuwaBj94MN1lHDiJEewe72BjeqMUcHQj75UQiMl3XGabP7WfJmr7Oiff/PRMs
         JbP8y4C35vztpWmNrnfAXQQ/ZjH3J9npchyP7r5D5r/ldb04W7nnQefYGzThqirC6Si+
         Dx3XTtFSKQxbzfwnzXWLiEL9mlOzqLRFpYQ7DuSaC8yxt1MgrPbNf6N2n+seWOGZXByB
         8Zubtfy7P48O6zqh8nbSY+UJQlHHMHgFmegpj+591XDlMvXvTYWajtcRKLwUbLpn01Il
         n1ng==
X-Forwarded-Encrypted: i=1; AJvYcCXEJdrhyLdRGFhRk1lQEQlQdYV0kM5pdjvsK4KAbtGichm5dwzCTTLaAqcnHEY6SllY4/eFK9U5FDpylAeNYrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM+vUeeYQT20vwOdG5g2VTlbjNYqeGWRy5xMt2QvzcPATjM069
	GnGI4SUYrnCpbYEh8IHZs/zMpo0dlN9a9w7hyqtiGgQAHP/nKi14wXt45xv2UpKgOXH8SjYlMrW
	ZNhdU+w==
X-Google-Smtp-Source: AGHT+IGryWCSjn4U2oVJze2RmD1k3aYNzs0hpCNsDBsQwmo6nkByTnFp5J0ou7ECx0mltCSXSeaOMOhc8kYM
X-Received: from plxq18.prod.google.com ([2002:a17:902:dad2:b0:223:49f0:9077])
 (user=mizhang job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:40cb:b0:223:f9a4:3f9c
 with SMTP id d9443c01a7336-22780c536bcmr198778035ad.9.1742837578076; Mon, 24
 Mar 2025 10:32:58 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon, 24 Mar 2025 17:30:44 +0000
In-Reply-To: <20250324173121.1275209-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324173121.1275209-5-mizhang@google.com>
Subject: [PATCH v4 04/38] perf: Add a EVENT_GUEST flag
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

Current perf doesn't explicitly schedule out all exclude_guest events
while the guest is running. There is no problem with the current
emulated vPMU. Because perf owns all the PMU counters. It can mask the
counter which is assigned to an exclude_guest event when a guest is
running (Intel way), or set the corresponding HOSTONLY bit in evsentsel
(AMD way). The counter doesn't count when a guest is running.

However, either way doesn't work with the introduced passthrough vPMU.
A guest owns all the PMU counters when it's running. The host should not
mask any counters. The counter may be used by the guest. The evsentsel
may be overwritten.

Perf should explicitly schedule out all exclude_guest events to release
the PMU resources when entering a guest, and resume the counting when
exiting the guest.

It's possible that an exclude_guest event is created when a guest is
running. The new event should not be scheduled in as well.

The ctx time is shared among different PMUs. The time cannot be stopped
when a guest is running. It is required to calculate the time for events
from other PMUs, e.g., uncore events. Add timeguest to track the guest
run time. For an exclude_guest event, the elapsed time equals
the ctx time - guest time.
Cgroup has dedicated times. Use the same method to deduct the guest time
from the cgroup time as well.

Co-developed-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 include/linux/perf_event.h |   6 ++
 kernel/events/core.c       | 209 +++++++++++++++++++++++++++++--------
 2 files changed, 169 insertions(+), 46 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index a2fd1bdc955c..7bda1e20be12 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -999,6 +999,11 @@ struct perf_event_context {
 	 */
 	struct perf_time_ctx		time;
 
+	/*
+	 * Context clock, runs when in the guest mode.
+	 */
+	struct perf_time_ctx		timeguest;
+
 	/*
 	 * These fields let us detect when two contexts have both
 	 * been cloned (inherited) from a common ancestor.
@@ -1089,6 +1094,7 @@ struct bpf_perf_event_data_kern {
  */
 struct perf_cgroup_info {
 	struct perf_time_ctx		time;
+	struct perf_time_ctx		timeguest;
 	int				active;
 };
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index e38c8b5e8086..7a2115b2c5c1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -163,7 +163,8 @@ enum event_type_t {
 	/* see ctx_resched() for details */
 	EVENT_CPU	= 0x10,
 	EVENT_CGROUP	= 0x20,
-	EVENT_FLAGS	= EVENT_CGROUP,
+	EVENT_GUEST	= 0x40,
+	EVENT_FLAGS	= EVENT_CGROUP | EVENT_GUEST,
 	/* compound helpers */
 	EVENT_ALL         = EVENT_FLEXIBLE | EVENT_PINNED,
 	EVENT_TIME_FROZEN = EVENT_TIME | EVENT_FROZEN,
@@ -435,6 +436,7 @@ static atomic_t nr_include_guest_events __read_mostly;
 
 static atomic_t nr_mediated_pmu_vms;
 static DEFINE_MUTEX(perf_mediated_pmu_mutex);
+static DEFINE_PER_CPU(bool, perf_in_guest);
 
 /* !exclude_guest event of PMU with PERF_PMU_CAP_MEDIATED_VPMU */
 static inline bool is_include_guest_event(struct perf_event *event)
@@ -738,6 +740,9 @@ static bool perf_skip_pmu_ctx(struct perf_event_pmu_context *pmu_ctx,
 {
 	if ((event_type & EVENT_CGROUP) && !pmu_ctx->nr_cgroups)
 		return true;
+	if ((event_type & EVENT_GUEST) &&
+	    !(pmu_ctx->pmu->capabilities & PERF_PMU_CAP_MEDIATED_VPMU))
+		return true;
 	return false;
 }
 
@@ -788,6 +793,39 @@ static inline void update_perf_time_ctx(struct perf_time_ctx *time, u64 now, boo
 	WRITE_ONCE(time->offset, time->time - time->stamp);
 }
 
+static_assert(offsetof(struct perf_event_context, timeguest) -
+	      offsetof(struct perf_event_context, time) ==
+	      sizeof(struct perf_time_ctx));
+
+#define T_TOTAL		0
+#define T_GUEST		1
+
+static inline u64 __perf_event_time_ctx(struct perf_event *event,
+					struct perf_time_ctx *times)
+{
+	u64 time = times[T_TOTAL].time;
+
+	if (event->attr.exclude_guest)
+		time -= times[T_GUEST].time;
+
+	return time;
+}
+
+static inline u64 __perf_event_time_ctx_now(struct perf_event *event,
+					    struct perf_time_ctx *times,
+					    u64 now)
+{
+	if (event->attr.exclude_guest && __this_cpu_read(perf_in_guest)) {
+		/*
+		 * (now + times[total].offset) - (now + times[guest].offset) :=
+		 * times[total].offset - times[guest].offset
+		 */
+		return READ_ONCE(times[T_TOTAL].offset) - READ_ONCE(times[T_GUEST].offset);
+	}
+
+	return now + READ_ONCE(times[T_TOTAL].offset);
+}
+
 #ifdef CONFIG_CGROUP_PERF
 
 static inline bool
@@ -824,12 +862,16 @@ static inline int is_cgroup_event(struct perf_event *event)
 	return event->cgrp != NULL;
 }
 
+static_assert(offsetof(struct perf_cgroup_info, timeguest) -
+	      offsetof(struct perf_cgroup_info, time) ==
+	      sizeof(struct perf_time_ctx));
+
 static inline u64 perf_cgroup_event_time(struct perf_event *event)
 {
 	struct perf_cgroup_info *t;
 
 	t = per_cpu_ptr(event->cgrp->info, event->cpu);
-	return t->time.time;
+	return __perf_event_time_ctx(event, &t->time);
 }
 
 static inline u64 perf_cgroup_event_time_now(struct perf_event *event, u64 now)
@@ -838,9 +880,21 @@ static inline u64 perf_cgroup_event_time_now(struct perf_event *event, u64 now)
 
 	t = per_cpu_ptr(event->cgrp->info, event->cpu);
 	if (!__load_acquire(&t->active))
-		return t->time.time;
-	now += READ_ONCE(t->time.offset);
-	return now;
+		return __perf_event_time_ctx(event, &t->time);
+
+	return __perf_event_time_ctx_now(event, &t->time, now);
+}
+
+static inline void __update_cgrp_guest_time(struct perf_cgroup_info *info, u64 now, bool adv)
+{
+	update_perf_time_ctx(&info->timeguest, now, adv);
+}
+
+static inline void update_cgrp_time(struct perf_cgroup_info *info, u64 now)
+{
+	update_perf_time_ctx(&info->time, now, true);
+	if (__this_cpu_read(perf_in_guest))
+		__update_cgrp_guest_time(info, now, true);
 }
 
 static inline void update_cgrp_time_from_cpuctx(struct perf_cpu_context *cpuctx, bool final)
@@ -856,7 +910,7 @@ static inline void update_cgrp_time_from_cpuctx(struct perf_cpu_context *cpuctx,
 			cgrp = container_of(css, struct perf_cgroup, css);
 			info = this_cpu_ptr(cgrp->info);
 
-			update_perf_time_ctx(&info->time, now, true);
+			update_cgrp_time(info, now);
 			if (final)
 				__store_release(&info->active, 0);
 		}
@@ -879,11 +933,11 @@ static inline void update_cgrp_time_from_event(struct perf_event *event)
 	 * Do not update time when cgroup is not active
 	 */
 	if (info->active)
-		update_perf_time_ctx(&info->time, perf_clock(), true);
+		update_cgrp_time(info, perf_clock());
 }
 
 static inline void
-perf_cgroup_set_timestamp(struct perf_cpu_context *cpuctx)
+perf_cgroup_set_timestamp(struct perf_cpu_context *cpuctx, bool guest)
 {
 	struct perf_event_context *ctx = &cpuctx->ctx;
 	struct perf_cgroup *cgrp = cpuctx->cgrp;
@@ -903,8 +957,12 @@ perf_cgroup_set_timestamp(struct perf_cpu_context *cpuctx)
 	for (css = &cgrp->css; css; css = css->parent) {
 		cgrp = container_of(css, struct perf_cgroup, css);
 		info = this_cpu_ptr(cgrp->info);
-		update_perf_time_ctx(&info->time, ctx->time.stamp, false);
-		__store_release(&info->active, 1);
+		if (guest) {
+			__update_cgrp_guest_time(info, ctx->time.stamp, false);
+		} else {
+			update_perf_time_ctx(&info->time, ctx->time.stamp, false);
+			__store_release(&info->active, 1);
+		}
 	}
 }
 
@@ -1104,7 +1162,7 @@ static inline int perf_cgroup_connect(pid_t pid, struct perf_event *event,
 }
 
 static inline void
-perf_cgroup_set_timestamp(struct perf_cpu_context *cpuctx)
+perf_cgroup_set_timestamp(struct perf_cpu_context *cpuctx, bool guest)
 {
 }
 
@@ -1514,16 +1572,24 @@ static void perf_unpin_context(struct perf_event_context *ctx)
  */
 static void __update_context_time(struct perf_event_context *ctx, bool adv)
 {
-	u64 now = perf_clock();
+	lockdep_assert_held(&ctx->lock);
+
+	update_perf_time_ctx(&ctx->time, perf_clock(), adv);
+}
 
+static void __update_context_guest_time(struct perf_event_context *ctx, bool adv)
+{
 	lockdep_assert_held(&ctx->lock);
 
-	update_perf_time_ctx(&ctx->time, now, adv);
+	/* must be called after __update_context_time(); */
+	update_perf_time_ctx(&ctx->timeguest, ctx->time.stamp, adv);
 }
 
 static void update_context_time(struct perf_event_context *ctx)
 {
 	__update_context_time(ctx, true);
+	if (__this_cpu_read(perf_in_guest))
+		__update_context_guest_time(ctx, true);
 }
 
 static u64 perf_event_time(struct perf_event *event)
@@ -1536,7 +1602,7 @@ static u64 perf_event_time(struct perf_event *event)
 	if (is_cgroup_event(event))
 		return perf_cgroup_event_time(event);
 
-	return ctx->time.time;
+	return __perf_event_time_ctx(event, &ctx->time);
 }
 
 static u64 perf_event_time_now(struct perf_event *event, u64 now)
@@ -1550,10 +1616,9 @@ static u64 perf_event_time_now(struct perf_event *event, u64 now)
 		return perf_cgroup_event_time_now(event, now);
 
 	if (!(__load_acquire(&ctx->is_active) & EVENT_TIME))
-		return ctx->time.time;
+		return __perf_event_time_ctx(event, &ctx->time);
 
-	now += READ_ONCE(ctx->time.offset);
-	return now;
+	return __perf_event_time_ctx_now(event, &ctx->time, now);
 }
 
 static enum event_type_t get_event_type(struct perf_event *event)
@@ -2384,20 +2449,23 @@ group_sched_out(struct perf_event *group_event, struct perf_event_context *ctx)
 }
 
 static inline void
-__ctx_time_update(struct perf_cpu_context *cpuctx, struct perf_event_context *ctx, bool final)
+__ctx_time_update(struct perf_cpu_context *cpuctx, struct perf_event_context *ctx,
+		  bool final, enum event_type_t event_type)
 {
 	if (ctx->is_active & EVENT_TIME) {
 		if (ctx->is_active & EVENT_FROZEN)
 			return;
+
 		update_context_time(ctx);
-		update_cgrp_time_from_cpuctx(cpuctx, final);
+		/* vPMU should not stop time */
+		update_cgrp_time_from_cpuctx(cpuctx, !(event_type & EVENT_GUEST) && final);
 	}
 }
 
 static inline void
 ctx_time_update(struct perf_cpu_context *cpuctx, struct perf_event_context *ctx)
 {
-	__ctx_time_update(cpuctx, ctx, false);
+	__ctx_time_update(cpuctx, ctx, false, 0);
 }
 
 /*
@@ -3405,7 +3473,7 @@ ctx_sched_out(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t
 	 *
 	 * would only update time for the pinned events.
 	 */
-	__ctx_time_update(cpuctx, ctx, ctx == &cpuctx->ctx);
+	__ctx_time_update(cpuctx, ctx, ctx == &cpuctx->ctx, event_type);
 
 	/*
 	 * CPU-release for the below ->is_active store,
@@ -3431,7 +3499,18 @@ ctx_sched_out(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t
 			cpuctx->task_ctx = NULL;
 	}
 
-	is_active ^= ctx->is_active; /* changed bits */
+	if (event_type & EVENT_GUEST) {
+		/*
+		 * Schedule out all exclude_guest events of PMU
+		 * with PERF_PMU_CAP_MEDIATED_VPMU.
+		 */
+		is_active = EVENT_ALL;
+		__update_context_guest_time(ctx, false);
+		perf_cgroup_set_timestamp(cpuctx, true);
+		barrier();
+	} else {
+		is_active ^= ctx->is_active; /* changed bits */
+	}
 
 	for_each_epc(pmu_ctx, ctx, pmu, event_type)
 		__pmu_ctx_sched_out(pmu_ctx, is_active);
@@ -3926,10 +4005,15 @@ static inline void group_update_userpage(struct perf_event *group_event)
 		event_update_userpage(event);
 }
 
+struct merge_sched_data {
+	int can_add_hw;
+	enum event_type_t event_type;
+};
+
 static int merge_sched_in(struct perf_event *event, void *data)
 {
 	struct perf_event_context *ctx = event->ctx;
-	int *can_add_hw = data;
+	struct merge_sched_data *msd = data;
 
 	if (event->state <= PERF_EVENT_STATE_OFF)
 		return 0;
@@ -3937,13 +4021,22 @@ static int merge_sched_in(struct perf_event *event, void *data)
 	if (!event_filter_match(event))
 		return 0;
 
-	if (group_can_go_on(event, *can_add_hw)) {
+	/*
+	 * Don't schedule in any host events from PMU with
+	 * PERF_PMU_CAP_MEDIATED_VPMU, while a guest is running.
+	 */
+	if (__this_cpu_read(perf_in_guest) &&
+	    event->pmu_ctx->pmu->capabilities & PERF_PMU_CAP_MEDIATED_VPMU &&
+	    !(msd->event_type & EVENT_GUEST))
+		return 0;
+
+	if (group_can_go_on(event, msd->can_add_hw)) {
 		if (!group_sched_in(event, ctx))
 			list_add_tail(&event->active_list, get_event_list(event));
 	}
 
 	if (event->state == PERF_EVENT_STATE_INACTIVE) {
-		*can_add_hw = 0;
+		msd->can_add_hw = 0;
 		if (event->attr.pinned) {
 			perf_cgroup_event_disable(event, ctx);
 			perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
@@ -3962,11 +4055,15 @@ static int merge_sched_in(struct perf_event *event, void *data)
 
 static void pmu_groups_sched_in(struct perf_event_context *ctx,
 				struct perf_event_groups *groups,
-				struct pmu *pmu)
+				struct pmu *pmu,
+				enum event_type_t event_type)
 {
-	int can_add_hw = 1;
+	struct merge_sched_data msd = {
+		.can_add_hw = 1,
+		.event_type = event_type,
+	};
 	visit_groups_merge(ctx, groups, smp_processor_id(), pmu,
-			   merge_sched_in, &can_add_hw);
+			   merge_sched_in, &msd);
 }
 
 static void __pmu_ctx_sched_in(struct perf_event_pmu_context *pmu_ctx,
@@ -3975,9 +4072,9 @@ static void __pmu_ctx_sched_in(struct perf_event_pmu_context *pmu_ctx,
 	struct perf_event_context *ctx = pmu_ctx->ctx;
 
 	if (event_type & EVENT_PINNED)
-		pmu_groups_sched_in(ctx, &ctx->pinned_groups, pmu_ctx->pmu);
+		pmu_groups_sched_in(ctx, &ctx->pinned_groups, pmu_ctx->pmu, event_type);
 	if (event_type & EVENT_FLEXIBLE)
-		pmu_groups_sched_in(ctx, &ctx->flexible_groups, pmu_ctx->pmu);
+		pmu_groups_sched_in(ctx, &ctx->flexible_groups, pmu_ctx->pmu, event_type);
 }
 
 static void
@@ -3994,9 +4091,11 @@ ctx_sched_in(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t
 		return;
 
 	if (!(is_active & EVENT_TIME)) {
+		/* EVENT_TIME should be active while the guest runs */
+		WARN_ON_ONCE(event_type & EVENT_GUEST);
 		/* start ctx time */
 		__update_context_time(ctx, false);
-		perf_cgroup_set_timestamp(cpuctx);
+		perf_cgroup_set_timestamp(cpuctx, false);
 		/*
 		 * CPU-release for the below ->is_active store,
 		 * see __load_acquire() in perf_event_time_now()
@@ -4012,7 +4111,23 @@ ctx_sched_in(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t
 			WARN_ON_ONCE(cpuctx->task_ctx != ctx);
 	}
 
-	is_active ^= ctx->is_active; /* changed bits */
+	if (event_type & EVENT_GUEST) {
+		/*
+		 * Schedule in the required exclude_guest events of PMU
+		 * with PERF_PMU_CAP_MEDIATED_VPMU.
+		 */
+		is_active = event_type & EVENT_ALL;
+
+		/*
+		 * Update ctx time to set the new start time for
+		 * the exclude_guest events.
+		 */
+		update_context_time(ctx);
+		update_cgrp_time_from_cpuctx(cpuctx, false);
+		barrier();
+	} else {
+		is_active ^= ctx->is_active; /* changed bits */
+	}
 
 	/*
 	 * First go through the list and put on any pinned groups
@@ -4020,13 +4135,13 @@ ctx_sched_in(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t
 	 */
 	if (is_active & EVENT_PINNED) {
 		for_each_epc(pmu_ctx, ctx, pmu, event_type)
-			__pmu_ctx_sched_in(pmu_ctx, EVENT_PINNED);
+			__pmu_ctx_sched_in(pmu_ctx, EVENT_PINNED | (event_type & EVENT_GUEST));
 	}
 
 	/* Then walk through the lower prio flexible groups */
 	if (is_active & EVENT_FLEXIBLE) {
 		for_each_epc(pmu_ctx, ctx, pmu, event_type)
-			__pmu_ctx_sched_in(pmu_ctx, EVENT_FLEXIBLE);
+			__pmu_ctx_sched_in(pmu_ctx, EVENT_FLEXIBLE | (event_type & EVENT_GUEST));
 	}
 }
 
@@ -6285,23 +6400,25 @@ void perf_event_update_userpage(struct perf_event *event)
 	if (!rb)
 		goto unlock;
 
-	/*
-	 * compute total_time_enabled, total_time_running
-	 * based on snapshot values taken when the event
-	 * was last scheduled in.
-	 *
-	 * we cannot simply called update_context_time()
-	 * because of locking issue as we can be called in
-	 * NMI context
-	 */
-	calc_timer_values(event, &now, &enabled, &running);
-
-	userpg = rb->user_page;
 	/*
 	 * Disable preemption to guarantee consistent time stamps are stored to
 	 * the user page.
 	 */
 	preempt_disable();
+
+	/*
+	 * compute total_time_enabled, total_time_running
+	 * based on snapshot values taken when the event
+	 * was last scheduled in.
+	 *
+	 * we cannot simply called update_context_time()
+	 * because of locking issue as we can be called in
+	 * NMI context
+	 */
+	calc_timer_values(event, &now, &enabled, &running);
+
+	userpg = rb->user_page;
+
 	++userpg->lock;
 	barrier();
 	userpg->index = perf_event_index(event);
-- 
2.49.0.395.g12beb8f557-goog


