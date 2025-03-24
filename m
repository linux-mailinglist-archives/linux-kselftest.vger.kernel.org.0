Return-Path: <linux-kselftest+bounces-29652-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F06A6E0E1
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 18:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DD631892200
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 17:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3194264A67;
	Mon, 24 Mar 2025 17:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oPryfCnr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D7B264628
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 17:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837575; cv=none; b=AgcVEzry893GZkqTWCQcQtWUUtpQN3qUpWbnKztO0eRomroqnFF0U28t0RCJLzIDKAI3VS5TGcqeWHYcQkT/7pw5JQwxijwu420zg19JjdYi8aVYNLcX+wG4WhZJimRbDsrgKyivgSfysQVhNLcYygMrjm+YNYVihhdiBK0kJtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837575; c=relaxed/simple;
	bh=jqeh4Xsv0CfKNigyiQO9yN1pSEojv6cGJrdFDQycpnA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VeydidzgaN+0bMrEVHzSpUNNlIoI0JYbtO7zek51o4cmLD/HUrc81kUVNzw7qO1J1LWWEk0lA78DhNPLUuMibYsz8FGtgU7OkkSLM3rlOQiCwOTUFjzj1JVR4LymRJq+l/tM0bc2HZSdVGZ2Zbg2EdbimooyHAfr3tgr7iV1U2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oPryfCnr; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff7aecba07so7830114a91.2
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 10:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742837573; x=1743442373; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=1Ya/oFtnNY7+pGYqinZGprl0k84EEnI1q0ZfiObPFs0=;
        b=oPryfCnrKtpuKA6tboavd6yT+pxkFANrE3KQ+RSArD94HF0q3uM7ie/NBcvt53j8Q9
         fkVkohFX2K2Z9WFpOJ60GQujjHKkGW6p+OTPcJ1fcS0PPVeI+zpj1r6ibNT+kdoLTjod
         0Pspe3tjIgPiDwU9iejXo83Lol59q4JeyjbhqP+DwNrqMyUezWVA0R1sZhbnwGqUjomQ
         +SZGiJGB13x8fMJfsTzf3O3Wu9fnJM3yP9dmUa6SHwe/GD+BPg57GXDQ4D2Q4yP3ZiJ1
         6GXyVYTBFhtMFkH5BL8VtUdZzL/QAf35TN0kSGvmneNa0EBjdyriceBBvqm9HRTammuP
         sU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837573; x=1743442373;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Ya/oFtnNY7+pGYqinZGprl0k84EEnI1q0ZfiObPFs0=;
        b=k0bM5sKpXHzhYPpS/cJBpKA+VP1ScCaX4t1DqSV5HgQGQacCzZE8aB3rXDryW03GM8
         20E9ID1/lnLktFoomYDaWzgZ4dQ37eb/WkBboPk6ooj5HkN3EENTqTGQ24vGOm7UkO9v
         PaMI2qVX8DyTvIN6ZvXkYCpPerbqtiPKasD3XsJ+drQd8CfqHiSo7/P68MT/nYLQGeSN
         A4hv9S2xz0bxybhwvU6LjVxP3LyoHbI6h6tcTzfxA324emlI/sk3n+Fiw+46+mOb1bQv
         SmxjjYuUu1Oe85jhS7kJghogqenmKx1Bn+gN0NDLce+UAuRLWiYpApLRZFDpvLnm9i/Z
         Ewhg==
X-Forwarded-Encrypted: i=1; AJvYcCVbXwOn/9U4RaGmSkTtb60ahx0pdd9yuK72FCjbF/TFNI3/YHSydRbJP7ACm2nzAM/nsDrL8NYNsIAGP81Do/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcAFVBQCOaBUatCZcirNQjmkEm4nNxp77XEFh2Kk9WZM4Uzkyn
	FCLn3oJ84kunmvJGms38QDTEfC/BDn8UZ5VPhZhtq9k8jq2wVnVSuW0FNHH/kHNBKUUsfCMfWVF
	RNaAILA==
X-Google-Smtp-Source: AGHT+IGpguu4/NyJujzClyWSa0WQRqb1Suj/mOYzqbowa3BrBAeAJiAlTWZpsBT1An9QqH4xJtO2xBiGOtyQ
X-Received: from pjd6.prod.google.com ([2002:a17:90b:54c6:b0:2e5:5ffc:1c36])
 (user=mizhang job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d008:b0:2fe:a545:4c84
 with SMTP id 98e67ed59e1d1-3030ff03212mr18790033a91.34.1742837573143; Mon, 24
 Mar 2025 10:32:53 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon, 24 Mar 2025 17:30:41 +0000
In-Reply-To: <20250324173121.1275209-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324173121.1275209-2-mizhang@google.com>
Subject: [PATCH v4 01/38] perf: Support get/put mediated PMU interfaces
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

Currently, the guest and host share the PMU resources when a guest is
running. KVM has to create an extra virtual event to simulate the
guest's event, which brings several issues, e.g., high overhead, not
accuracy and etc.

A new mediated PMU method is proposed to address the issue. It requires
that the PMU resources can be fully occupied by the guest while it's
running. Two new interfaces are implemented to fulfill the requirement.
The hypervisor should invoke the interface while creating a guest which
wants the mediated PMU capability.

The PMU resources should only be temporarily occupied as a whole when a
guest is running. When the guest is out, the PMU resources are still
shared among different users.

The exclude_guest event modifier is used to guarantee the exclusive
occupation of the PMU resources. When creating a guest, the hypervisor
should check whether there are !exclude_guest events in the system.
If yes, the creation should fail. Because some PMU resources have been
occupied by other users.
If no, the PMU resources can be safely accessed by the guest directly.
Perf guarantees that no new !exclude_guest events are created when a
guest is running.

Only the mediated PMU is affected, but not for other PMU e.g., uncore
and SW PMU. The behavior of those PMUs are not changed. The guest
enter/exit interfaces should only impact the supported PMUs.
Add a new PERF_PMU_CAP_MEDIATED_VPMU flag to indicate the PMUs that
support the feature.

Add nr_include_guest_events to track the !exclude_guest events of PMU
with PERF_PMU_CAP_MEDIATED_VPMU.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 include/linux/perf_event.h | 11 +++++++
 kernel/events/core.c       | 66 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 8333f132f4a9..54018dd0b2a4 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -301,6 +301,8 @@ struct perf_event_pmu_context;
 #define PERF_PMU_CAP_AUX_OUTPUT			0x0080
 #define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0100
 #define PERF_PMU_CAP_AUX_PAUSE			0x0200
+/* Support to passthrough whole PMU resoure to guest */
+#define PERF_PMU_CAP_MEDIATED_VPMU		0x0400
 
 /**
  * pmu::scope
@@ -1811,6 +1813,8 @@ extern void perf_event_task_tick(void);
 extern int perf_event_account_interrupt(struct perf_event *event);
 extern int perf_event_period(struct perf_event *event, u64 value);
 extern u64 perf_event_pause(struct perf_event *event, bool reset);
+int perf_get_mediated_pmu(void);
+void perf_put_mediated_pmu(void);
 #else /* !CONFIG_PERF_EVENTS: */
 static inline void *
 perf_aux_output_begin(struct perf_output_handle *handle,
@@ -1901,6 +1905,13 @@ static inline int perf_exclude_event(struct perf_event *event, struct pt_regs *r
 {
 	return 0;
 }
+
+static inline int perf_get_mediated_pmu(void)
+{
+	return 0;
+}
+
+static inline void perf_put_mediated_pmu(void)			{ }
 #endif
 
 #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_INTEL)
diff --git a/kernel/events/core.c b/kernel/events/core.c
index bcb09e011e9e..be623701dc48 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -431,6 +431,20 @@ static atomic_t nr_bpf_events __read_mostly;
 static atomic_t nr_cgroup_events __read_mostly;
 static atomic_t nr_text_poke_events __read_mostly;
 static atomic_t nr_build_id_events __read_mostly;
+static atomic_t nr_include_guest_events __read_mostly;
+
+static atomic_t nr_mediated_pmu_vms;
+static DEFINE_MUTEX(perf_mediated_pmu_mutex);
+
+/* !exclude_guest event of PMU with PERF_PMU_CAP_MEDIATED_VPMU */
+static inline bool is_include_guest_event(struct perf_event *event)
+{
+	if ((event->pmu->capabilities & PERF_PMU_CAP_MEDIATED_VPMU) &&
+	    !event->attr.exclude_guest)
+		return true;
+
+	return false;
+}
 
 static LIST_HEAD(pmus);
 static DEFINE_MUTEX(pmus_lock);
@@ -5320,6 +5334,9 @@ static void _free_event(struct perf_event *event)
 
 	unaccount_event(event);
 
+	if (is_include_guest_event(event))
+		atomic_dec(&nr_include_guest_events);
+
 	security_perf_event_free(event);
 
 	if (event->rb) {
@@ -5877,6 +5894,36 @@ u64 perf_event_pause(struct perf_event *event, bool reset)
 }
 EXPORT_SYMBOL_GPL(perf_event_pause);
 
+/*
+ * Currently invoked at VM creation to
+ * - Check whether there are existing !exclude_guest events of PMU with
+ *   PERF_PMU_CAP_MEDIATED_VPMU
+ * - Set nr_mediated_pmu_vms to prevent !exclude_guest event creation on
+ *   PMUs with PERF_PMU_CAP_MEDIATED_VPMU
+ *
+ * No impact for the PMU without PERF_PMU_CAP_MEDIATED_VPMU. The perf
+ * still owns all the PMU resources.
+ */
+int perf_get_mediated_pmu(void)
+{
+	guard(mutex)(&perf_mediated_pmu_mutex);
+	if (atomic_inc_not_zero(&nr_mediated_pmu_vms))
+		return 0;
+
+	if (atomic_read(&nr_include_guest_events))
+		return -EBUSY;
+
+	atomic_inc(&nr_mediated_pmu_vms);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(perf_get_mediated_pmu);
+
+void perf_put_mediated_pmu(void)
+{
+	atomic_dec(&nr_mediated_pmu_vms);
+}
+EXPORT_SYMBOL_GPL(perf_put_mediated_pmu);
+
 /*
  * Holding the top-level event's child_mutex means that any
  * descendant process that has inherited this event will block
@@ -12210,6 +12257,17 @@ static void account_event(struct perf_event *event)
 	account_pmu_sb_event(event);
 }
 
+static int perf_account_include_guest_event(void)
+{
+	guard(mutex)(&perf_mediated_pmu_mutex);
+
+	if (atomic_read(&nr_mediated_pmu_vms))
+		return -EOPNOTSUPP;
+
+	atomic_inc(&nr_include_guest_events);
+	return 0;
+}
+
 /*
  * Allocate and initialize an event structure
  */
@@ -12435,11 +12493,19 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	if (err)
 		goto err_callchain_buffer;
 
+	if (is_include_guest_event(event)) {
+		err = perf_account_include_guest_event();
+		if (err)
+			goto err_security_alloc;
+	}
+
 	/* symmetric to unaccount_event() in _free_event() */
 	account_event(event);
 
 	return event;
 
+err_security_alloc:
+	security_perf_event_free(event);
 err_callchain_buffer:
 	if (!event->parent) {
 		if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
-- 
2.49.0.395.g12beb8f557-goog


