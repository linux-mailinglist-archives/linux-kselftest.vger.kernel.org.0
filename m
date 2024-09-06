Return-Path: <linux-kselftest+bounces-17394-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D52096F4EE
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 15:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0582A1C22AFD
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 13:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F2F1CEE95;
	Fri,  6 Sep 2024 13:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cOK7nYW+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5361CDA29;
	Fri,  6 Sep 2024 13:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725627661; cv=none; b=dsH0oQSp97v/WFO+qIQZtBBUX5fXcOCvfrQHJl4V/CCIHG5eRL4hyyB942P5FR9pTVFopy9xUcZXm8xnmeM14GsdlpCf0wuHSsxVX88CwhREjTI+1eJzwzZ51Et6NqQuPxQOoNZVqPm6XKGaxycwALWC8fkqSXQbGfHGclNe2pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725627661; c=relaxed/simple;
	bh=23xLPnLcIJ3JnL1Ne5LUKvuS9CEAsOMYayEynog+iI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sT37CoZPA61Ec0HLGK1i+WEmm95Bv7fdfeD1okSyRQLNOkxspJNIgR84KCULYB1qraqtFkXyq7wVNhh5yOQfrM8awQM48xtZgK3wrsB7jz0dh9KmH4JVuSnqYCNOBV2Qp2NEysHSqhEE7h4inZOi6m8N/lU7FzXkYubidZi0lFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cOK7nYW+; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725627660; x=1757163660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=23xLPnLcIJ3JnL1Ne5LUKvuS9CEAsOMYayEynog+iI8=;
  b=cOK7nYW+bXKRQ+bNpkJaMyucro6MIroePsUTBwQzubh2KlhRWoEsEe9V
   FwQ5VNEhAojXYpr9OIh5B1FcVr/a+pTRq6mgVOfw6vOvdrEFii1d+IzI1
   0LUv9bFO218LWJAXdzh5RvlXDzIBqQPIL3sAY4vqhHbRD7bXrdPVXIlGx
   oqNStXr3WV+FgoexlDLGzAbHUslqidUdSMcv6zVfk28jQLD6b0Jpms8kh
   xPE1cyeZd6D28VUv7mReAK7Yw5zR+lOgGCyD1lEhE24pShcczEdCyD5IV
   oSZiQfH/BMG9aopEbUcPexVZVvvrsFqro8eDiQtD9nRMMkCzOaxqyeMEG
   Q==;
X-CSE-ConnectionGUID: rcYGcv82QWCjQOp9Ymhh5Q==
X-CSE-MsgGUID: a5u+HSzfTc6zbddq+Qznzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="34959954"
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="34959954"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 06:00:59 -0700
X-CSE-ConnectionGUID: coVNmF1AQ+OM4pLU4exV3w==
X-CSE-MsgGUID: vIh6kxQhQVS55t14laL8vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="65929546"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.115.59])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 06:00:53 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>,
	kvm@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	H Peter Anvin <hpa@zytor.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 2/3] KVM: x86: Fix Intel PT Host/Guest mode when host tracing also
Date: Fri,  6 Sep 2024 16:00:25 +0300
Message-ID: <20240906130026.10705-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240906130026.10705-1-adrian.hunter@intel.com>
References: <20240906130026.10705-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Ensure Intel PT tracing is disabled before VM-Entry in Intel PT Host/Guest
mode.

Intel PT has 2 modes for tracing virtual machines. The default is System
mode whereby host and guest output to the host trace buffer. The other is
Host/Guest mode whereby host and guest output to their own buffers.
Host/Guest mode is selected by kvm_intel module parameter pt_mode=1.

In Host/Guest mode, the following rule must be followed:

	If the logical processor is operating with Intel PT enabled
	(if IA32_RTIT_CTL.TraceEn = 1) at the time of VM entry, the
	"load IA32_RTIT_CTL" VM-entry control must be 0.

However, "load IA32_RTIT_CTL" VM-entry control is always 1 in Host/Guest
mode, so IA32_RTIT_CTL.TraceEn must always be 0 at VM entry, irrespective
of whether guest IA32_RTIT_CTL.TraceEn is 1.

Fix by stopping host Intel PT tracing always at VM entry in Host/Guest
mode. That also fixes the issue whereby the Intel PT NMI handler would
set IA32_RTIT_CTL.TraceEn back to 1 after KVM has just set it to 0.

Fixes: 2ef444f1600b ("KVM: x86: Add Intel PT context switch for each vcpu")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 arch/x86/events/intel/pt.c      | 131 +++++++++++++++++++++++++++++++-
 arch/x86/events/intel/pt.h      |  10 +++
 arch/x86/include/asm/intel_pt.h |   4 +
 arch/x86/kvm/vmx/vmx.c          |  23 ++----
 arch/x86/kvm/vmx/vmx.h          |   1 -
 5 files changed, 147 insertions(+), 22 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index fd4670a6694e..a4c8feb94040 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -480,16 +480,20 @@ static u64 pt_config_filters(struct perf_event *event)
 		 */
 
 		/* avoid redundant msr writes */
-		if (pt->filters.filter[range].msr_a != filter->msr_a) {
+		if (pt->filters.filter[range].msr_a != filter->msr_a ||
+		    pt->write_filter_msrs[range]) {
 			wrmsrl(pt_address_ranges[range].msr_a, filter->msr_a);
 			pt->filters.filter[range].msr_a = filter->msr_a;
 		}
 
-		if (pt->filters.filter[range].msr_b != filter->msr_b) {
+		if (pt->filters.filter[range].msr_b != filter->msr_b ||
+		    pt->write_filter_msrs[range]) {
 			wrmsrl(pt_address_ranges[range].msr_b, filter->msr_b);
 			pt->filters.filter[range].msr_b = filter->msr_b;
 		}
 
+		pt->write_filter_msrs[range] = false;
+
 		rtit_ctl |= (u64)filter->config << pt_address_ranges[range].reg_off;
 	}
 
@@ -534,6 +538,11 @@ static void pt_config(struct perf_event *event)
 	reg |= (event->attr.config & PT_CONFIG_MASK);
 
 	event->hw.aux_config = reg;
+
+	/* Configuration is complete, it is now OK to handle an NMI */
+	barrier();
+	WRITE_ONCE(pt->handle_nmi, 1);
+
 	pt_config_start(event);
 }
 
@@ -945,6 +954,7 @@ static void pt_handle_status(struct pt *pt)
 		pt_buffer_advance(buf);
 
 	wrmsrl(MSR_IA32_RTIT_STATUS, status);
+	pt->status = status;
 }
 
 /**
@@ -1583,7 +1593,6 @@ static void pt_event_start(struct perf_event *event, int mode)
 			goto fail_end_stop;
 	}
 
-	WRITE_ONCE(pt->handle_nmi, 1);
 	hwc->state = 0;
 
 	pt_config_buffer(buf);
@@ -1638,6 +1647,104 @@ static void pt_event_stop(struct perf_event *event, int mode)
 	}
 }
 
+#define PT_VM_NO_TRANSITION	0
+#define PT_VM_ENTRY		1
+#define PT_VM_EXIT		2
+
+void intel_pt_vm_entry(bool guest_trace_enable)
+{
+	struct pt *pt = this_cpu_ptr(&pt_ctx);
+	struct perf_event *event;
+
+	pt->restart_event = NULL;
+	pt->stashed_buf_sz = 0;
+
+	WRITE_ONCE(pt->vm_transition, PT_VM_ENTRY);
+	barrier();
+
+	if (READ_ONCE(pt->handle_nmi)) {
+		/* Must stop handler before reading pt->handle.event */
+		WRITE_ONCE(pt->handle_nmi, 0);
+		barrier();
+		event = pt->handle.event;
+		if (event && !event->hw.state) {
+			struct pt_buffer *buf = perf_get_aux(&pt->handle);
+
+			if (buf && buf->snapshot)
+				pt->stashed_buf_sz = buf->nr_pages << PAGE_SHIFT;
+			pt->restart_event = event;
+			pt_event_stop(event, PERF_EF_UPDATE);
+		}
+	}
+
+	/*
+	 * If guest_trace_enable, MSRs need to be saved, but the values are
+	 * either already cached or not needed:
+	 *	MSR_IA32_RTIT_CTL		event->hw.aux_config
+	 *	MSR_IA32_RTIT_STATUS		pt->status
+	 *	MSR_IA32_RTIT_CR3_MATCH		not used
+	 *	MSR_IA32_RTIT_OUTPUT_BASE	pt->output_base
+	 *	MSR_IA32_RTIT_OUTPUT_MASK	pt->output_mask
+	 *	MSR_IA32_RTIT_ADDR...		pt->filters
+	 */
+}
+EXPORT_SYMBOL_GPL(intel_pt_vm_entry);
+
+void intel_pt_vm_exit(bool guest_trace_enable)
+{
+	struct pt *pt = this_cpu_ptr(&pt_ctx);
+	u64 base = pt->output_base;
+	u64 mask = pt->output_mask;
+
+	WRITE_ONCE(pt->vm_transition, PT_VM_EXIT);
+	barrier();
+
+	/*
+	 * If guest_trace_enable, MSRs need to be restored, but that is handled
+	 * in different ways:
+	 *	MSR_IA32_RTIT_CTL		written next start
+	 *	MSR_IA32_RTIT_STATUS		restored below
+	 *	MSR_IA32_RTIT_CR3_MATCH		not used
+	 *	MSR_IA32_RTIT_OUTPUT_BASE	written next start or restored
+	 *					further below
+	 *	MSR_IA32_RTIT_OUTPUT_MASK	written next start or restored
+	 *					further below
+	 *	MSR_IA32_RTIT_ADDR...		flagged to be written when
+	 *					needed
+	 */
+	if (guest_trace_enable) {
+		wrmsrl(MSR_IA32_RTIT_STATUS, pt->status);
+		/*
+		 * Force address filter MSR writes during reconfiguration,
+		 * refer pt_config_filters().
+		 */
+		for (int range = 0; range < PT_FILTERS_NUM; range++)
+			pt->write_filter_msrs[range] = true;
+	}
+
+	if (pt->restart_event) {
+		if (guest_trace_enable) {
+			/* Invalidate to force buffer reconfiguration */
+			pt->output_base = ~0ULL;
+			pt->output_mask = 0;
+		}
+		pt_event_start(pt->restart_event, 0);
+		pt->restart_event = NULL;
+	}
+
+	/* If tracing wasn't started, restore buffer configuration */
+	if (guest_trace_enable && !READ_ONCE(pt->handle_nmi)) {
+		wrmsrl(MSR_IA32_RTIT_OUTPUT_BASE, base);
+		wrmsrl(MSR_IA32_RTIT_OUTPUT_MASK, mask);
+		pt->output_base = base;
+		pt->output_mask = mask;
+	}
+
+	barrier();
+	WRITE_ONCE(pt->vm_transition, PT_VM_NO_TRANSITION);
+}
+EXPORT_SYMBOL_GPL(intel_pt_vm_exit);
+
 static long pt_event_snapshot_aux(struct perf_event *event,
 				  struct perf_output_handle *handle,
 				  unsigned long size)
@@ -1646,6 +1753,24 @@ static long pt_event_snapshot_aux(struct perf_event *event,
 	struct pt_buffer *buf = perf_get_aux(&pt->handle);
 	unsigned long from = 0, to;
 	long ret;
+	int tr;
+
+	/*
+	 * Special handling during VM transition. At VM-Entry stage, once
+	 * tracing is stopped, as indicated by buf == NULL, snapshot using the
+	 * saved head position. At VM-Exit do that also until tracing is
+	 * reconfigured as indicated by handle_nmi.
+	 */
+	tr = READ_ONCE(pt->vm_transition);
+	if ((tr == PT_VM_ENTRY && !buf) || (tr == PT_VM_EXIT && !READ_ONCE(pt->handle_nmi))) {
+		if (WARN_ON_ONCE(!pt->stashed_buf_sz))
+			return 0;
+		to = pt->handle.head;
+		if (to < size)
+			from = pt->stashed_buf_sz;
+		from += to - size;
+		return perf_output_copy_aux(&pt->handle, handle, from, to);
+	}
 
 	if (WARN_ON_ONCE(!buf))
 		return 0;
diff --git a/arch/x86/events/intel/pt.h b/arch/x86/events/intel/pt.h
index f5e46c04c145..ecaaf112b923 100644
--- a/arch/x86/events/intel/pt.h
+++ b/arch/x86/events/intel/pt.h
@@ -119,6 +119,11 @@ struct pt_filters {
  * @vmx_on:		1 if VMX is ON on this cpu
  * @output_base:	cached RTIT_OUTPUT_BASE MSR value
  * @output_mask:	cached RTIT_OUTPUT_MASK MSR value
+ * @status:		cached RTIT_STATUS MSR value
+ * @vm_transition:	VM transition (snapshot_aux needs special handling)
+ * @write_filter_msrs:	write address filter MSRs during configuration
+ * @stashed_buf_sz:	buffer size during VM transition
+ * @restart_event:	event to restart after VM-Exit
  */
 struct pt {
 	struct perf_output_handle handle;
@@ -127,6 +132,11 @@ struct pt {
 	int			vmx_on;
 	u64			output_base;
 	u64			output_mask;
+	u64			status;
+	int			vm_transition;
+	bool			write_filter_msrs[PT_FILTERS_NUM];
+	unsigned long		stashed_buf_sz;
+	struct perf_event	*restart_event;
 };
 
 #endif /* __INTEL_PT_H__ */
diff --git a/arch/x86/include/asm/intel_pt.h b/arch/x86/include/asm/intel_pt.h
index c796e9bc98b6..a673ac3a825e 100644
--- a/arch/x86/include/asm/intel_pt.h
+++ b/arch/x86/include/asm/intel_pt.h
@@ -30,11 +30,15 @@ enum pt_capabilities {
 void cpu_emergency_stop_pt(void);
 extern u32 intel_pt_validate_hw_cap(enum pt_capabilities cap);
 extern u32 intel_pt_validate_cap(u32 *caps, enum pt_capabilities cap);
+extern void intel_pt_vm_entry(bool guest_trace_enable);
+extern void intel_pt_vm_exit(bool guest_trace_enable);
 extern int is_intel_pt_event(struct perf_event *event);
 #else
 static inline void cpu_emergency_stop_pt(void) {}
 static inline u32 intel_pt_validate_hw_cap(enum pt_capabilities cap) { return 0; }
 static inline u32 intel_pt_validate_cap(u32 *caps, enum pt_capabilities capability) { return 0; }
+static inline void intel_pt_vm_entry(bool guest_trace_enable) {}
+static inline void intel_pt_vm_exit(bool guest_trace_enable) {}
 static inline int is_intel_pt_event(struct perf_event *event) { return 0; }
 #endif
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 3f1e3be552c0..d20458d83829 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1224,16 +1224,10 @@ static void pt_guest_enter(struct vcpu_vmx *vmx)
 	if (vmx_pt_mode_is_system())
 		return;
 
-	/*
-	 * GUEST_IA32_RTIT_CTL is already set in the VMCS.
-	 * Save host state before VM entry.
-	 */
-	rdmsrl(MSR_IA32_RTIT_CTL, vmx->pt_desc.host.ctl);
-	if (vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN) {
-		wrmsrl(MSR_IA32_RTIT_CTL, 0);
-		pt_save_msr(&vmx->pt_desc.host, vmx->pt_desc.num_address_ranges);
+	intel_pt_vm_entry(vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN);
+
+	if (vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN)
 		pt_load_msr(&vmx->pt_desc.guest, vmx->pt_desc.num_address_ranges);
-	}
 }
 
 static void pt_guest_exit(struct vcpu_vmx *vmx)
@@ -1241,17 +1235,10 @@ static void pt_guest_exit(struct vcpu_vmx *vmx)
 	if (vmx_pt_mode_is_system())
 		return;
 
-	if (vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN) {
+	if (vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN)
 		pt_save_msr(&vmx->pt_desc.guest, vmx->pt_desc.num_address_ranges);
-		pt_load_msr(&vmx->pt_desc.host, vmx->pt_desc.num_address_ranges);
-	}
 
-	/*
-	 * KVM requires VM_EXIT_CLEAR_IA32_RTIT_CTL to expose PT to the guest,
-	 * i.e. RTIT_CTL is always cleared on VM-Exit.  Restore it if necessary.
-	 */
-	if (vmx->pt_desc.host.ctl)
-		wrmsrl(MSR_IA32_RTIT_CTL, vmx->pt_desc.host.ctl);
+	intel_pt_vm_exit(vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN);
 }
 
 void vmx_set_host_fs_gs(struct vmcs_host_state *host, u16 fs_sel, u16 gs_sel,
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 42498fa63abb..e1616282d97f 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -67,7 +67,6 @@ struct pt_desc {
 	u64 ctl_bitmask;
 	u32 num_address_ranges;
 	u32 caps[PT_CPUID_REGS_NUM * PT_CPUID_LEAVES];
-	struct pt_ctx host;
 	struct pt_ctx guest;
 };
 
-- 
2.43.0


