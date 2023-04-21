Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042D26EAC9E
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Apr 2023 16:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjDUOSA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 10:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbjDUORz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 10:17:55 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989FFE50
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 07:17:53 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54fc35ab48fso9379957b3.2
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 07:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682086673; x=1684678673;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BuRpJ8asAkuXVj/aByE26xnYMHbcW3VWyH6v7oH/F3A=;
        b=YF6mH/8C6d2LEICnoqqT4IlypJNJI7h7vMGL3vmU8nm89xmj7nFwuuIi0Wugm9WY7S
         LZT7Lgv38D5hvS66vh1juZA/85ZJAPR2JWb6rtiB3SRpL/EO75XCQVejewfggFNY6tFf
         RzHFp1/kP+25z9AnutEzY4IoniQvEzo16VK7X+sycwpCy3UwwvKbnqksNfF1U7vt2PHV
         bSJAcLXepaAKacebZQY18LDeX7Zs7xw1hB+gldk/e7vBIaWUaSVtYUz6W4roqTjhSZJG
         HMyd3SE7sDxYTWk7s5ZqTodFH5yuHwd0x1uf+1epjoOsNQcwdzTFPBgd9pwdMOellgcs
         H4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682086673; x=1684678673;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BuRpJ8asAkuXVj/aByE26xnYMHbcW3VWyH6v7oH/F3A=;
        b=KLtvrBCz40Z3gYkAQ8yHTjtSWPLK2FLQ27mEeEjfaMaA2rrcW3O0FpQhIj0YjKLco/
         TRjMTtgaij8dELB+BuYzVOg8MEPwxVPJwdpQNEg67iArDBp3XmGZsCx8PtZRcs9VduJ9
         upaHsuSzjp9x7+xMqjSlEaoLR3gg2kFfZlxQKNev3cyCvhwvmImwRlQGnZabz6XbM+Zv
         eTPUtEQPJMRNLphV+YhPSnLUw+ppxWUXrW0BiymZpj8QIYlVy0rtzaAYjuRE3fgpYAAO
         ZzSXq7vOeEH9dmXDNnOozVImweau6B5AgRcmfYmZvaG7F3V+G+zdzxQaZFH1EZXGYcRu
         VwjQ==
X-Gm-Message-State: AAQBX9e+3RdKJ2ZKrbt/9aHdVrrSJY/uc4KdWQIg2yEWWCa7AIo9bFl4
        QhgbC+40yoJwTOy5rcpw++8PQsQAHUxtE822IQ==
X-Google-Smtp-Source: AKy350bSfP1gP4DD2HHVEqwXmh0xWlWT1hVdE3FbvnbuPnVQDeyMt9ZPm07M+aCRtKM49nBWk/ZKtfMv2uVqwFggNA==
X-Received: from peternewman0.zrh.corp.google.com ([2a00:79e0:9d:6:c801:daa2:428c:d3fc])
 (user=peternewman job=sendgmr) by 2002:a0d:ec49:0:b0:552:b607:634b with SMTP
 id r9-20020a0dec49000000b00552b607634bmr1395087ywn.4.1682086672863; Fri, 21
 Apr 2023 07:17:52 -0700 (PDT)
Date:   Fri, 21 Apr 2023 16:17:17 +0200
In-Reply-To: <20230421141723.2405942-1-peternewman@google.com>
Mime-Version: 1.0
References: <20230421141723.2405942-1-peternewman@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230421141723.2405942-4-peternewman@google.com>
Subject: [PATCH v1 3/9] x86/resctrl: Add resctrl_mbm_flush_cpu() to collect
 CPUs' MBM events
From:   Peter Newman <peternewman@google.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>
Cc:     Babu Moger <babu.moger@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stephane Eranian <eranian@google.com>,
        James Morse <james.morse@arm.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Peter Newman <peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

AMD implementations so far are only guaranteed to provide MBM event
counts for RMIDs which are currently assigned in CPUs' PQR_ASSOC MSRs.
Hardware can reallocate the counter resources for all other RMIDs' which
are not currently assigned to those which are, zeroing the event counts
of the unassigned RMIDs.

In practice, this makes it impossible to simultaneously calculate the
memory bandwidth speed of all RMIDs on a busy system where all RMIDs are
in use. Over a multiple-second measurement window, the RMID would need
to remain assigned in all of the L3 cache domains where it has been
assigned for the duration of the measurement, otherwise portions of the
final count will be zero. In general, it is not possible to bound the
number of RMIDs which will be assigned in an L3 domain over any interval
of time.

To provide reliable MBM counts on such systems, introduce "soft" RMIDs:
when enabled, each CPU is permanently assigned a hardware RMID whose
event counts are flushed to the current soft RMID during context
switches which result in a change in soft RMID as well as whenever
userspace requests the current event count for a domain.

Implement resctrl_mbm_flush_cpu(), which collects a domain's current MBM
event counts into its current software RMID. The delta for each CPU is
determined by tracking the previous event counts in per-CPU data.  The
software byte counts reside in the arch-independent mbm_state
structures.

Co-developed-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Peter Newman <peternewman@google.com>
---
 arch/x86/include/asm/resctrl.h         |  2 +
 arch/x86/kernel/cpu/resctrl/internal.h | 10 ++--
 arch/x86/kernel/cpu/resctrl/monitor.c  | 78 ++++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 255a78d9d906..e7acf118d770 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -13,6 +13,7 @@
  * @cur_closid:	The cached Class Of Service ID
  * @default_rmid:	The user assigned Resource Monitoring ID
  * @default_closid:	The user assigned cached Class Of Service ID
+ * @hw_rmid:	The permanently-assigned RMID when soft RMIDs are in use
  *
  * The upper 32 bits of MSR_IA32_PQR_ASSOC contain closid and the
  * lower 10 bits rmid. The update to MSR_IA32_PQR_ASSOC always
@@ -27,6 +28,7 @@ struct resctrl_pqr_state {
 	u32			cur_closid;
 	u32			default_rmid;
 	u32			default_closid;
+	u32			hw_rmid;
 };
 
 DECLARE_PER_CPU(struct resctrl_pqr_state, pqr_state);
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 02a062558c67..256eee05d447 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -298,12 +298,14 @@ struct rftype {
  * @prev_bw:	The most recent bandwidth in MBps
  * @delta_bw:	Difference between the current and previous bandwidth
  * @delta_comp:	Indicates whether to compute the delta_bw
+ * @soft_rmid_bytes: Recent bandwidth count in bytes when using soft RMIDs
  */
 struct mbm_state {
-	u64	prev_bw_bytes;
-	u32	prev_bw;
-	u32	delta_bw;
-	bool	delta_comp;
+	u64		prev_bw_bytes;
+	u32		prev_bw;
+	u32		delta_bw;
+	bool		delta_comp;
+	atomic64_t	soft_rmid_bytes;
 };
 
 /**
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 2de8397f91cd..3671100d3cc7 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -404,6 +404,84 @@ static struct mbm_state *get_mbm_state(struct rdt_domain *d, u32 rmid,
 	}
 }
 
+struct mbm_soft_counter {
+	u64	prev_bytes;
+	bool	initialized;
+};
+
+struct mbm_flush_state {
+	struct mbm_soft_counter local;
+	struct mbm_soft_counter total;
+};
+
+DEFINE_PER_CPU(struct mbm_flush_state, flush_state);
+
+/*
+ * flushes the value of the cpu_rmid to the current soft rmid
+ */
+static void __mbm_flush(int evtid, struct rdt_resource *r, struct rdt_domain *d)
+{
+	struct mbm_flush_state *state = this_cpu_ptr(&flush_state);
+	u32 soft_rmid = this_cpu_ptr(&pqr_state)->cur_rmid;
+	u32 hw_rmid = this_cpu_ptr(&pqr_state)->hw_rmid;
+	struct mbm_soft_counter *counter;
+	struct mbm_state *m;
+	u64 val;
+
+	/* cache occupancy events are disabled in this mode */
+	WARN_ON(!is_mbm_event(evtid));
+
+	if (evtid == QOS_L3_MBM_LOCAL_EVENT_ID) {
+		counter = &state->local;
+	} else {
+		WARN_ON(evtid != QOS_L3_MBM_TOTAL_EVENT_ID);
+		counter = &state->total;
+	}
+
+	/*
+	 * Propagate the value read from the hw_rmid assigned to the current CPU
+	 * into the "soft" rmid associated with the current task or CPU.
+	 */
+	m = get_mbm_state(d, soft_rmid, evtid);
+	if (!m)
+		return;
+
+	if (resctrl_arch_rmid_read(r, d, hw_rmid, evtid, &val))
+		return;
+
+	/* Count bandwidth after the first successful counter read. */
+	if (counter->initialized) {
+		/* Assume that mbm_update() will prevent double-overflows. */
+		if (val != counter->prev_bytes)
+			atomic64_add(val - counter->prev_bytes,
+				     &m->soft_rmid_bytes);
+	} else {
+		counter->initialized = true;
+	}
+
+	counter->prev_bytes = val;
+}
+
+/*
+ * Called from context switch code __resctrl_sched_in() when the current soft
+ * RMID is changing or before reporting event counts to user space.
+ */
+void resctrl_mbm_flush_cpu(void)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	int cpu = smp_processor_id();
+	struct rdt_domain *d;
+
+	d = get_domain_from_cpu(cpu, r);
+	if (!d)
+		return;
+
+	if (is_mbm_local_enabled())
+		__mbm_flush(QOS_L3_MBM_LOCAL_EVENT_ID, r, d);
+	if (is_mbm_total_enabled())
+		__mbm_flush(QOS_L3_MBM_TOTAL_EVENT_ID, r, d);
+}
+
 static int __mon_event_count(u32 rmid, struct rmid_read *rr)
 {
 	struct mbm_state *m;
-- 
2.40.0.634.g4ca3ef3211-goog

