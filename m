Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABEC6EAC99
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Apr 2023 16:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjDUOR7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 10:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbjDUORv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 10:17:51 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93949030
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 07:17:49 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b92309d84c1so6368143276.1
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 07:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682086669; x=1684678669;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZdT0+yxI631GXfw7STY7XxcZTuaYlRecO3uXqz7sRs=;
        b=Y2+bxGSHDI0cOeuV61GwDsFnnX9uAq9WV4Qgojc5LTOAuEP7C/2lbNBzZCmr9EdXh7
         T9jJFsDqzueATZPhTVjNwdJ4MFL89AyXFBgYcElt1FG2xsfcm9t/jgq2PV+yLwMb7P37
         sBDmeAm7DfdmrMZ0bI/85s0NTFkKfCr8eZPBFv7mbUVMz/4yNLvDgNiI8lS/+WydrCT9
         0xlrKDptRLKB0mb733akzzr1zKgHEJXS5NUA2IWaMU05W6pdg6KhkQHmIygs+G8eC3bI
         FtBXepDYkaHIXGahLzv8DVUcjVfhwk/8CZCRLk9Ay5NK+v9x3qPgWv2q/rUiCbhfuZUt
         3gxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682086669; x=1684678669;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZdT0+yxI631GXfw7STY7XxcZTuaYlRecO3uXqz7sRs=;
        b=lppX1DE5Fw4HwSqqsYdkyJilI+1aHUrocbrWU9IqkR9Mztl0Pf8/2Mx6vcDhjQLKWL
         nWlM4eMwL4dFZNBxGChwUzr4fAqrbfRPz1/90qtvzEqKx+adwIFx4C/KzQpeqixWNcT+
         kcwLSkCj+3KYHr3jcVSgTCrz5wLeOdSrDMRN33ZgrISnmHX8a1XURiVtBDEjlna/WINM
         BDhLp0WNbUvapQhKgeRxXQsyqb1A0lMMQtwZxpKGq51kAbtPVotw/3MwdVnsgAVY/xXN
         Mt5bNyBDz+xmdocXRiUQBitUoLVazgvR2IegE5FPH2dL9PlgZ0smdU4Qae+mQfNHax9o
         Y1Wg==
X-Gm-Message-State: AAQBX9f0c1cnJUWDy/Sfby2FxOXdZXMWWV83Hm4Ezi+gB5FIDHzOf0XV
        uJwoQYztb1Ty6nNL8KuWBvam70Jr0964fFat5A==
X-Google-Smtp-Source: AKy350bw3Zi5wPB0lMm8zUks5VeLUBbeduMsul45B2dWHkdZeBUg6vpt39ys1PXVjq9XFMDP/4rsZCKkUKoSq7Meng==
X-Received: from peternewman0.zrh.corp.google.com ([2a00:79e0:9d:6:c801:daa2:428c:d3fc])
 (user=peternewman job=sendgmr) by 2002:a05:690c:c8c:b0:54f:e2ca:3085 with
 SMTP id cm12-20020a05690c0c8c00b0054fe2ca3085mr1849543ywb.1.1682086669711;
 Fri, 21 Apr 2023 07:17:49 -0700 (PDT)
Date:   Fri, 21 Apr 2023 16:17:16 +0200
In-Reply-To: <20230421141723.2405942-1-peternewman@google.com>
Mime-Version: 1.0
References: <20230421141723.2405942-1-peternewman@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230421141723.2405942-3-peternewman@google.com>
Subject: [PATCH v1 2/9] x86/resctrl: Hold a spinlock in __rmid_read() on AMD
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

From: Stephane Eranian <eranian@google.com>

In AMD PQoS Versions 1.0 and 2.0, IA32_QM_EVTSEL MSR is shared by all
processors in a QOS domain.  So there's a chance it can read a different
event when two processors are reading the counter concurrently.  Add a
spinlock to prevent this race.

Co-developed-by: Peter Newman <peternewman@google.com>
Signed-off-by: Peter Newman <peternewman@google.com>
Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/kernel/cpu/resctrl/core.c     | 41 ++++++++++++++++++++++++++
 arch/x86/kernel/cpu/resctrl/internal.h |  5 ++++
 arch/x86/kernel/cpu/resctrl/monitor.c  | 14 +++++++--
 3 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 030d3b409768..47b1c37a81f8 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -25,6 +25,8 @@
 #include <asm/resctrl.h>
 #include "internal.h"
 
+DEFINE_STATIC_KEY_FALSE(rmid_read_locked);
+
 /* Mutex to protect rdtgroup access. */
 DEFINE_MUTEX(rdtgroup_mutex);
 
@@ -529,6 +531,8 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 	d->id = id;
 	cpumask_set_cpu(cpu, &d->cpu_mask);
 
+	raw_spin_lock_init(&hw_dom->evtsel_lock);
+
 	rdt_domain_reconfigure_cdp(r);
 
 	if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
@@ -829,6 +833,41 @@ static __init bool get_rdt_mon_resources(void)
 	return !rdt_get_mon_l3_config(r);
 }
 
+static __init bool amd_shared_qm_evtsel(void)
+{
+	/*
+	 * From AMD64 Technology Platform Quality of Service Extensions,
+	 * Revision 1.03:
+	 *
+	 * "For PQoS Version 1.0 and 2.0, as identified by Family/Model, the
+	 * QM_EVTSEL register is shared by all the processors in a QOS domain."
+	 *
+	 * Check the inclusive Family/Model ranges for PQoS Extension versions
+	 * 1.0 and 2.0 from the PQoS Extension Versions table.
+	 */
+	if (boot_cpu_data.x86 == 0x17)
+		/* V1.0 */
+		return boot_cpu_data.x86_model >= 0x30 &&
+			boot_cpu_data.x86_model <= 0x9f;
+
+	if (boot_cpu_data.x86 == 0x19)
+		/* V2.0 */
+		return (boot_cpu_data.x86_model <= 0xf) ||
+			((boot_cpu_data.x86_model >= 0x20) &&
+			 (boot_cpu_data.x86_model <= 0x5f));
+
+	return false;
+}
+
+static __init void __check_quirks_amd(void)
+{
+	if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL) ||
+	    rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL)) {
+		if (amd_shared_qm_evtsel())
+			static_branch_enable(&rmid_read_locked);
+	}
+}
+
 static __init void __check_quirks_intel(void)
 {
 	switch (boot_cpu_data.x86_model) {
@@ -852,6 +891,8 @@ static __init void check_quirks(void)
 {
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
 		__check_quirks_intel();
+	else if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+		__check_quirks_amd();
 }
 
 static __init bool get_rdt_resources(void)
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 85ceaf9a31ac..02a062558c67 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -325,6 +325,7 @@ struct arch_mbm_state {
  * @ctrl_val:	array of cache or mem ctrl values (indexed by CLOSID)
  * @arch_mbm_total:	arch private state for MBM total bandwidth
  * @arch_mbm_local:	arch private state for MBM local bandwidth
+ * @lock:	serializes counter reads when QM_EVTSEL MSR is shared per-domain
  *
  * Members of this structure are accessed via helpers that provide abstraction.
  */
@@ -333,6 +334,7 @@ struct rdt_hw_domain {
 	u32				*ctrl_val;
 	struct arch_mbm_state		*arch_mbm_total;
 	struct arch_mbm_state		*arch_mbm_local;
+	raw_spinlock_t			evtsel_lock;
 };
 
 static inline struct rdt_hw_domain *resctrl_to_arch_dom(struct rdt_domain *r)
@@ -428,6 +430,9 @@ extern struct rdt_hw_resource rdt_resources_all[];
 extern struct rdtgroup rdtgroup_default;
 DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
 
+/* Serialization required in resctrl_arch_rmid_read(). */
+DECLARE_STATIC_KEY_FALSE(rmid_read_locked);
+
 extern struct dentry *debugfs_resctrl;
 
 enum resctrl_res_level {
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 20952419be75..2de8397f91cd 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -146,10 +146,15 @@ static inline struct rmid_entry *__rmid_entry(u32 rmid)
 	return entry;
 }
 
-static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
+static int __rmid_read(struct rdt_hw_domain *hw_dom, u32 rmid,
+		       enum resctrl_event_id eventid, u64 *val)
 {
+	unsigned long flags;
 	u64 msr_val;
 
+	if (static_branch_likely(&rmid_read_locked))
+		raw_spin_lock_irqsave(&hw_dom->evtsel_lock, flags);
+
 	/*
 	 * As per the SDM, when IA32_QM_EVTSEL.EvtID (bits 7:0) is configured
 	 * with a valid event code for supported resource type and the bits
@@ -161,6 +166,9 @@ static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
 	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
 	rdmsrl(MSR_IA32_QM_CTR, msr_val);
 
+	if (static_branch_likely(&rmid_read_locked))
+		raw_spin_unlock_irqrestore(&hw_dom->evtsel_lock, flags);
+
 	if (msr_val & RMID_VAL_ERROR)
 		return -EIO;
 	if (msr_val & RMID_VAL_UNAVAIL)
@@ -200,7 +208,7 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
 		memset(am, 0, sizeof(*am));
 
 		/* Record any initial, non-zero count value. */
-		__rmid_read(rmid, eventid, &am->prev_msr);
+		__rmid_read(hw_dom, rmid, eventid, &am->prev_msr);
 	}
 }
 
@@ -241,7 +249,7 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
 	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
 		return -EINVAL;
 
-	ret = __rmid_read(rmid, eventid, &msr_val);
+	ret = __rmid_read(hw_dom, rmid, eventid, &msr_val);
 	if (ret)
 		return ret;
 
-- 
2.40.0.634.g4ca3ef3211-goog

