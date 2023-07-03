Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF4C745AAD
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 12:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjGCK6o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 06:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjGCK6l (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 06:58:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DB1C9;
        Mon,  3 Jul 2023 03:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688381921; x=1719917921;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5O3ycQ0jPsLOdFx+EoGLPYvpt2BkiJe1rCk/xqPkFJk=;
  b=BsZ8+tLjErBDZ9RebRsDrDtNKv722D3sFvJTvhqv6ljnEiZrfhEtcbBu
   KZ5rXel7klJYXpMRJEe3o4zzqCrv0numy5cD27LbUW9eEdXyWJ2CMVj4q
   IzFnOEF3JR2gm0/LIIt8ju3WrDQVzDWpq/YbJzQZO1RfcLa4sRyavBChq
   qZzKdfOhCZElYFvFXg8fL0ooGP60XyDMqXEP4x3pziMQmBShCs0Za/9qb
   MACK7auPjc+kuERriwOzt9e01VgqAxAibb2BhoQLnBCj59HMSsUQhFy+O
   ugWtaXH5fPRiQEBSeSnfbkL5T9DlJXjdUa1JQ2eRNUgSZaNNVvCDrIMhA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="360329715"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="360329715"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 03:58:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="748108255"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="748108255"
Received: from agrabezh-mobl1.ccr.corp.intel.com (HELO tkristo-desk.intel.com) ([10.252.48.27])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 03:58:27 -0700
From:   Tero Kristo <tero.kristo@linux.intel.com>
To:     shuah@kernel.org, tglx@linutronix.de, x86@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, mingo@redhat.com
Cc:     ast@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, bpf@vger.kernel.org
Subject: [PATCH 1/2] x86/tsc: Add new BPF helper call bpf_rdtsc
Date:   Mon,  3 Jul 2023 13:57:44 +0300
Message-Id: <20230703105745.1314475-2-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230703105745.1314475-1-tero.kristo@linux.intel.com>
References: <20230703105745.1314475-1-tero.kristo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently the raw TSC counter can be read within kernel via rdtsc_ordered()
and friends, and additionally even userspace has access to it via the
RDTSC assembly instruction. BPF programs on the other hand don't have
direct access to the TSC counter, but alternatively must go through the
performance subsystem (bpf_perf_event_read), which only provides relative
value compared to the start point of the program, and is also much slower
than the direct read. Add a new BPF helper definition for bpf_rdtsc() which
can be used for any accurate profiling needs.

A use-case for the new API is for example wakeup latency tracing via
eBPF on Intel architecture, where it is extremely beneficial to be able
to get raw TSC timestamps and compare these directly to the value
programmed to the MSR_IA32_TSC_DEADLINE register. This way a direct
latency value from the hardware interrupt to the execution of the
interrupt handler can be calculated. Having the functionality within
eBPF also has added benefits of allowing to filter any other relevant
data like C-state residency values, and also to drop any irrelevant
data points directly in the kernel context, without passing all the
data to userspace for post-processing.

Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
 arch/x86/include/asm/msr.h |  1 +
 arch/x86/kernel/tsc.c      | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 65ec1965cd28..3dde673cb563 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -309,6 +309,7 @@ struct msr *msrs_alloc(void);
 void msrs_free(struct msr *msrs);
 int msr_set_bit(u32 msr, u8 bit);
 int msr_clear_bit(u32 msr, u8 bit);
+u64 bpf_rdtsc(void);
 
 #ifdef CONFIG_SMP
 int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h);
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 344698852146..ded857abef81 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -15,6 +15,8 @@
 #include <linux/timex.h>
 #include <linux/static_key.h>
 #include <linux/static_call.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
 
 #include <asm/hpet.h>
 #include <asm/timer.h>
@@ -29,6 +31,7 @@
 #include <asm/intel-family.h>
 #include <asm/i8259.h>
 #include <asm/uv/uv.h>
+#include <asm/tlbflush.h>
 
 unsigned int __read_mostly cpu_khz;	/* TSC clocks / usec, not used here */
 EXPORT_SYMBOL(cpu_khz);
@@ -1551,6 +1554,24 @@ void __init tsc_early_init(void)
 	tsc_enable_sched_clock();
 }
 
+u64 bpf_rdtsc(void)
+{
+	/* Check if Time Stamp is enabled only in ring 0 */
+	if (cr4_read_shadow() & X86_CR4_TSD)
+		return 0;
+
+	return rdtsc_ordered();
+}
+
+BTF_SET8_START(tsc_bpf_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_rdtsc)
+BTF_SET8_END(tsc_bpf_kfunc_ids)
+
+static const struct btf_kfunc_id_set tsc_bpf_kfunc_set = {
+	.owner		= THIS_MODULE,
+	.set		= &tsc_bpf_kfunc_ids,
+};
+
 void __init tsc_init(void)
 {
 	if (!cpu_feature_enabled(X86_FEATURE_TSC)) {
@@ -1594,6 +1615,8 @@ void __init tsc_init(void)
 
 	clocksource_register_khz(&clocksource_tsc_early, tsc_khz);
 	detect_art();
+
+	register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &tsc_bpf_kfunc_set);
 }
 
 #ifdef CONFIG_SMP
-- 
2.25.1

