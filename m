Return-Path: <linux-kselftest+bounces-29653-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A437A6E0EA
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 18:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB6BC3AB7E7
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 17:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729E0264A92;
	Mon, 24 Mar 2025 17:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FZcODbSk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E16D264A61
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 17:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837577; cv=none; b=IhctRpENirvgXg59frHxIm2lg+txZm49iXyCrUap9vF5lRUpWL6uXPtEpyC0YQGw0APU+qRe2LTUCXXIWX2wnp0f+9asP608QLg+XAExPFW4twg+bwWyJJPiDl75t/3zcJSeGDPMDdCDWiOM0B+idcrwzAnnLL7an0WQKSmORCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837577; c=relaxed/simple;
	bh=/f1zw2NQVdrvC1p5SxX0ny1y+81MhhF+V4C2TQ4BIug=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SQcHsJLN0rQj8FTwhDdeMrCcPFoN06UXX4HjX3dPk4YiCfdOgfLlkUxITVCBnjwQyj2OBMxoVKycT027EknOivWIONHUWWs6zB6XrF7M2JQKfCnpABbm7WrTf5rD3Ku/Sg3rb5SD28I5Oys97VUvID7LgDtncRlmABb2wGHxER8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FZcODbSk; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff7f9a0b9bso8045811a91.0
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 10:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742837575; x=1743442375; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=NpZkmVtYxhQ/ofswPdkBbPONzCRhKPTufy96IjDt+/w=;
        b=FZcODbSkBG9ZF8cZNTkkFG5AyEqtTKCZkjQpnbZi1NU2khHaEsOldyaSJtcSmbDXzL
         qGcrH3m50Rgbo7HlLfaonp0+iipQHNqKkJw30xAlz3V1TGDN5KLi9jmuCfER1dTkjyml
         PUgatp6W6/1vh0tbzhAtmRLwRLvsjrDYoYMhYoR9a0Hui2SY76YJCCFAkPjMeHAs58fF
         KEkBUIw099MyqaO0Pln/3d+NfSOCuhzu8EwDxmJLRceUQ+XhK/F0ateb+ojeFOP/ASmD
         fW8lMHFH/ezfeQWrG454xatACMMyKdHBqHa1/bKjB++9IF36CjLv+5/xd7pOj4CEUDc0
         c3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837575; x=1743442375;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NpZkmVtYxhQ/ofswPdkBbPONzCRhKPTufy96IjDt+/w=;
        b=U+v5KxtFLhNF5UW/6wK6VnOp3nz6uNWX3FupCVqMVayZLF+EfHgglYUAQbmYzMCqqI
         v1BI27aPt9D0wo0Cy1LzDV1sfIruKZnuZwVvrd/WgnZRUY/+nOIgewiF/SF1N1xEqBu4
         OLVLlZTqCpXwga4bmLoBV0Tx71P1yheNpd1zoKt/GmaneBG2PnGWOYdTparAM1j82ndz
         y8296V8bjYsuQEYwhjGIS6YdjIPY82B9I3a5LkEAR8yBxDsomp9SNp51H1pRPvgwq6dy
         a6KaVbVx/+0WrW7jo8Oxx77yRZm74yjJbqjCVlQWubePL1o+tJ4bHiIwPKTl07OThMGV
         IxOw==
X-Forwarded-Encrypted: i=1; AJvYcCUNSH4A1ifu1L5joc/gmfNkzPsnhFQ3QnXmIt3wwCcDXWPp+5aKGCh2POLhhx7YlfWoCvR2UftXErXicaBs9QA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAgZFLQC1q44fIG/VtKSAJgL9r6EeDTtCdCjxbyO+Eoh60f2Ox
	udguwv4pQ+w76X51kOifTvqVQqdFNKPyz7EIBa+17/YuhCLTa9Zf+0JnUMV+J22g4vrwEE50IAP
	1093r7w==
X-Google-Smtp-Source: AGHT+IF7xewnBsDRdx97NTiWXEVuLkQEPX52IbGBsRyPp1wqsjb1vaTTVeIfoBjFih/I+7gdk4u7wG31sMt1
X-Received: from pjk8.prod.google.com ([2002:a17:90b:5588:b0:2fc:ccfe:368])
 (user=mizhang job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c52:b0:2fe:e9c6:689e
 with SMTP id 98e67ed59e1d1-3030fe87ea4mr21917270a91.8.1742837574859; Mon, 24
 Mar 2025 10:32:54 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon, 24 Mar 2025 17:30:42 +0000
In-Reply-To: <20250324173121.1275209-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324173121.1275209-3-mizhang@google.com>
Subject: [PATCH v4 02/38] perf: Skip pmu_ctx based on event_type
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

To optimize the cgroup context switch, the perf_event_pmu_context
iteration skips the PMUs without cgroup events. A bool cgroup was
introduced to indicate the case. It can work, but this way is hard to
extend for other cases, e.g. skipping non-passthrough PMUs. It doesn't
make sense to keep adding bool variables.

Pass the event_type instead of the specific bool variable. Check both
the event_type and related pmu_ctx variables to decide whether skipping
a PMU.

Event flags, e.g., EVENT_CGROUP, should be cleard in the ctx->is_active.
Add EVENT_FLAGS to indicate such event flags.

No functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 kernel/events/core.c | 73 ++++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 33 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index be623701dc48..8d3a0cc59fb4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -163,7 +163,7 @@ enum event_type_t {
 	/* see ctx_resched() for details */
 	EVENT_CPU	= 0x10,
 	EVENT_CGROUP	= 0x20,
-
+	EVENT_FLAGS	= EVENT_CGROUP,
 	/* compound helpers */
 	EVENT_ALL         = EVENT_FLEXIBLE | EVENT_PINNED,
 	EVENT_TIME_FROZEN = EVENT_TIME | EVENT_FROZEN,
@@ -733,27 +733,37 @@ do {									\
 	___p;								\
 })
 
-#define for_each_epc(_epc, _ctx, _pmu, _cgroup)				\
+static bool perf_skip_pmu_ctx(struct perf_event_pmu_context *pmu_ctx,
+			      enum event_type_t event_type)
+{
+	if ((event_type & EVENT_CGROUP) && !pmu_ctx->nr_cgroups)
+		return true;
+	return false;
+}
+
+#define for_each_epc(_epc, _ctx, _pmu, _event_type)			\
 	list_for_each_entry(_epc, &((_ctx)->pmu_ctx_list), pmu_ctx_entry) \
-		if (_cgroup && !_epc->nr_cgroups)			\
+		if (perf_skip_pmu_ctx(_epc, _event_type))		\
 			continue;					\
 		else if (_pmu && _epc->pmu != _pmu)			\
 			continue;					\
 		else
 
-static void perf_ctx_disable(struct perf_event_context *ctx, bool cgroup)
+static void perf_ctx_disable(struct perf_event_context *ctx,
+			     enum event_type_t event_type)
 {
 	struct perf_event_pmu_context *pmu_ctx;
 
-	for_each_epc(pmu_ctx, ctx, NULL, cgroup)
+	for_each_epc(pmu_ctx, ctx, NULL, event_type)
 		perf_pmu_disable(pmu_ctx->pmu);
 }
 
-static void perf_ctx_enable(struct perf_event_context *ctx, bool cgroup)
+static void perf_ctx_enable(struct perf_event_context *ctx,
+			    enum event_type_t event_type)
 {
 	struct perf_event_pmu_context *pmu_ctx;
 
-	for_each_epc(pmu_ctx, ctx, NULL, cgroup)
+	for_each_epc(pmu_ctx, ctx, NULL, event_type)
 		perf_pmu_enable(pmu_ctx->pmu);
 }
 
@@ -913,7 +923,7 @@ static void perf_cgroup_switch(struct task_struct *task)
 		return;
 
 	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
-	perf_ctx_disable(&cpuctx->ctx, true);
+	perf_ctx_disable(&cpuctx->ctx, EVENT_CGROUP);
 
 	ctx_sched_out(&cpuctx->ctx, NULL, EVENT_ALL|EVENT_CGROUP);
 	/*
@@ -929,7 +939,7 @@ static void perf_cgroup_switch(struct task_struct *task)
 	 */
 	ctx_sched_in(&cpuctx->ctx, NULL, EVENT_ALL|EVENT_CGROUP);
 
-	perf_ctx_enable(&cpuctx->ctx, true);
+	perf_ctx_enable(&cpuctx->ctx, EVENT_CGROUP);
 	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
 }
 
@@ -2796,11 +2806,11 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
 
 	event_type &= EVENT_ALL;
 
-	for_each_epc(epc, &cpuctx->ctx, pmu, false)
+	for_each_epc(epc, &cpuctx->ctx, pmu, 0)
 		perf_pmu_disable(epc->pmu);
 
 	if (task_ctx) {
-		for_each_epc(epc, task_ctx, pmu, false)
+		for_each_epc(epc, task_ctx, pmu, 0)
 			perf_pmu_disable(epc->pmu);
 
 		task_ctx_sched_out(task_ctx, pmu, event_type);
@@ -2820,11 +2830,11 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
 
 	perf_event_sched_in(cpuctx, task_ctx, pmu);
 
-	for_each_epc(epc, &cpuctx->ctx, pmu, false)
+	for_each_epc(epc, &cpuctx->ctx, pmu, 0)
 		perf_pmu_enable(epc->pmu);
 
 	if (task_ctx) {
-		for_each_epc(epc, task_ctx, pmu, false)
+		for_each_epc(epc, task_ctx, pmu, 0)
 			perf_pmu_enable(epc->pmu);
 	}
 }
@@ -3374,11 +3384,10 @@ static void
 ctx_sched_out(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t event_type)
 {
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
+	enum event_type_t active_type = event_type & ~EVENT_FLAGS;
 	struct perf_event_pmu_context *pmu_ctx;
 	int is_active = ctx->is_active;
-	bool cgroup = event_type & EVENT_CGROUP;
 
-	event_type &= ~EVENT_CGROUP;
 
 	lockdep_assert_held(&ctx->lock);
 
@@ -3409,7 +3418,7 @@ ctx_sched_out(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t
 	 * see __load_acquire() in perf_event_time_now()
 	 */
 	barrier();
-	ctx->is_active &= ~event_type;
+	ctx->is_active &= ~active_type;
 
 	if (!(ctx->is_active & EVENT_ALL)) {
 		/*
@@ -3430,7 +3439,7 @@ ctx_sched_out(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t
 
 	is_active ^= ctx->is_active; /* changed bits */
 
-	for_each_epc(pmu_ctx, ctx, pmu, cgroup)
+	for_each_epc(pmu_ctx, ctx, pmu, event_type)
 		__pmu_ctx_sched_out(pmu_ctx, is_active);
 }
 
@@ -3622,7 +3631,7 @@ perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
 		raw_spin_lock_nested(&next_ctx->lock, SINGLE_DEPTH_NESTING);
 		if (context_equiv(ctx, next_ctx)) {
 
-			perf_ctx_disable(ctx, false);
+			perf_ctx_disable(ctx, 0);
 
 			/* PMIs are disabled; ctx->nr_no_switch_fast is stable. */
 			if (local_read(&ctx->nr_no_switch_fast) ||
@@ -3647,7 +3656,7 @@ perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
 			perf_ctx_sched_task_cb(ctx, false);
 			perf_event_swap_task_ctx_data(ctx, next_ctx);
 
-			perf_ctx_enable(ctx, false);
+			perf_ctx_enable(ctx, 0);
 
 			/*
 			 * RCU_INIT_POINTER here is safe because we've not
@@ -3671,13 +3680,13 @@ perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
 
 	if (do_switch) {
 		raw_spin_lock(&ctx->lock);
-		perf_ctx_disable(ctx, false);
+		perf_ctx_disable(ctx, 0);
 
 inside_switch:
 		perf_ctx_sched_task_cb(ctx, false);
 		task_ctx_sched_out(ctx, NULL, EVENT_ALL);
 
-		perf_ctx_enable(ctx, false);
+		perf_ctx_enable(ctx, 0);
 		raw_spin_unlock(&ctx->lock);
 	}
 }
@@ -3981,11 +3990,9 @@ static void
 ctx_sched_in(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t event_type)
 {
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
+	enum event_type_t active_type = event_type & ~EVENT_FLAGS;
 	struct perf_event_pmu_context *pmu_ctx;
 	int is_active = ctx->is_active;
-	bool cgroup = event_type & EVENT_CGROUP;
-
-	event_type &= ~EVENT_CGROUP;
 
 	lockdep_assert_held(&ctx->lock);
 
@@ -4003,7 +4010,7 @@ ctx_sched_in(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t
 		barrier();
 	}
 
-	ctx->is_active |= (event_type | EVENT_TIME);
+	ctx->is_active |= active_type | EVENT_TIME;
 	if (ctx->task) {
 		if (!(is_active & EVENT_ALL))
 			cpuctx->task_ctx = ctx;
@@ -4018,13 +4025,13 @@ ctx_sched_in(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t
 	 * in order to give them the best chance of going on.
 	 */
 	if (is_active & EVENT_PINNED) {
-		for_each_epc(pmu_ctx, ctx, pmu, cgroup)
+		for_each_epc(pmu_ctx, ctx, pmu, event_type)
 			__pmu_ctx_sched_in(pmu_ctx, EVENT_PINNED);
 	}
 
 	/* Then walk through the lower prio flexible groups */
 	if (is_active & EVENT_FLEXIBLE) {
-		for_each_epc(pmu_ctx, ctx, pmu, cgroup)
+		for_each_epc(pmu_ctx, ctx, pmu, event_type)
 			__pmu_ctx_sched_in(pmu_ctx, EVENT_FLEXIBLE);
 	}
 }
@@ -4041,11 +4048,11 @@ static void perf_event_context_sched_in(struct task_struct *task)
 
 	if (cpuctx->task_ctx == ctx) {
 		perf_ctx_lock(cpuctx, ctx);
-		perf_ctx_disable(ctx, false);
+		perf_ctx_disable(ctx, 0);
 
 		perf_ctx_sched_task_cb(ctx, true);
 
-		perf_ctx_enable(ctx, false);
+		perf_ctx_enable(ctx, 0);
 		perf_ctx_unlock(cpuctx, ctx);
 		goto rcu_unlock;
 	}
@@ -4058,7 +4065,7 @@ static void perf_event_context_sched_in(struct task_struct *task)
 	if (!ctx->nr_events)
 		goto unlock;
 
-	perf_ctx_disable(ctx, false);
+	perf_ctx_disable(ctx, 0);
 	/*
 	 * We want to keep the following priority order:
 	 * cpu pinned (that don't need to move), task pinned,
@@ -4068,7 +4075,7 @@ static void perf_event_context_sched_in(struct task_struct *task)
 	 * events, no need to flip the cpuctx's events around.
 	 */
 	if (!RB_EMPTY_ROOT(&ctx->pinned_groups.tree)) {
-		perf_ctx_disable(&cpuctx->ctx, false);
+		perf_ctx_disable(&cpuctx->ctx, 0);
 		ctx_sched_out(&cpuctx->ctx, NULL, EVENT_FLEXIBLE);
 	}
 
@@ -4077,9 +4084,9 @@ static void perf_event_context_sched_in(struct task_struct *task)
 	perf_ctx_sched_task_cb(cpuctx->task_ctx, true);
 
 	if (!RB_EMPTY_ROOT(&ctx->pinned_groups.tree))
-		perf_ctx_enable(&cpuctx->ctx, false);
+		perf_ctx_enable(&cpuctx->ctx, 0);
 
-	perf_ctx_enable(ctx, false);
+	perf_ctx_enable(ctx, 0);
 
 unlock:
 	perf_ctx_unlock(cpuctx, ctx);
-- 
2.49.0.395.g12beb8f557-goog


