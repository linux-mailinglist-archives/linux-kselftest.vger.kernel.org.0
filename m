Return-Path: <linux-kselftest+bounces-4256-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D16084D07C
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 19:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09F76284ABB
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 18:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AEA83CBD;
	Wed,  7 Feb 2024 17:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OqRqpmSU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC6282D73;
	Wed,  7 Feb 2024 17:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328754; cv=none; b=lBLKyqabVjohPyQMj1oePFchhuxK6zv7X3focyDvB18j8KjRHayhp0XFnjxTgM4q+DsvwD/5JcN22t1SvTRULaOHrSidbrFYkOfRQtnMHPRZygsPA97W7XqtLkBgQawbiKqpt7sbYiH9B92D0e6N0NP6zLQiUXye2bB8ox+qP88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328754; c=relaxed/simple;
	bh=6/oClMkl2sbDD+4zBb79Jk5H49m2BcEbnOgVbHYMoUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jqw1hlWYe9osrY6yGqqoBF6YfvmXpFC9GpGtgPZlaqA1VSg73HxknzmjK/K+kKDRMtnf5TED2XqakYX1tQtelqh8A3i46GJ5cNRMFmpElly7IKwJhmM6brjrnz4AN79ALDvxpxWThFli1mxP2V+b9mBx/eQ7wCemMOsD4qTyEJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OqRqpmSU; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707328748; x=1738864748;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6/oClMkl2sbDD+4zBb79Jk5H49m2BcEbnOgVbHYMoUk=;
  b=OqRqpmSU1B94ZXlNRGKGCWDIkq8WSfar/jjrsFZSvCf7JU284m6BnNiU
   irBs+b2aIBI5RFv0srbm0W98KylWtLXswn0virWg4ezBC2gD3sqRCMyrm
   bVD6qx5ksHCvHzAnl3UdzHXAHHkGeve6sJ3VEu9w9ZJeBoINtHy46njvv
   w37h+LWUZ3zVy1dz+JW8WbAc8xkOgPNlCRWuxVFdh8zS1g3Di+xA9kCPb
   ODDnYV9SkU565wHF0AAzAwtQypT8iKl21QXPJ3tA27DILiHXaKXH2lEnt
   i/y/tNfc55i7tjboruM7CBuxGE6ddKDNDtAX+PPRD96YsFNyVGZ7kt27G
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="11622548"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="11622548"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 09:58:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="6020718"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmviesa004.fm.intel.com with ESMTP; 07 Feb 2024 09:58:55 -0800
From: Xin Li <xin3.li@intel.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	corbet@lwn.net,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	shuah@kernel.org,
	vkuznets@redhat.com,
	peterz@infradead.org,
	ravi.v.shankar@intel.com,
	xin@zytor.com
Subject: [PATCH v2 08/25] KVM: VMX: Initialize VMCS FRED fields
Date: Wed,  7 Feb 2024 09:26:28 -0800
Message-ID: <20240207172646.3981-9-xin3.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207172646.3981-1-xin3.li@intel.com>
References: <20240207172646.3981-1-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initialize host VMCS FRED fields with host FRED MSRs' value and
guest VMCS FRED fields to 0.

FRED CPU states are managed in 9 new FRED MSRs, as well as a few
existing CPU registers and MSRs, e.g., CR4.FRED.  To support FRED
context management, new VMCS fields corresponding to most of FRED
CPU state MSRs are added to both the host-state and guest-state
areas of VMCS.

Specifically no VMCS fields are added for FRED RSP0 and SSP0 MSRs,
because the 2 FRED MSRs are used during ring 3 event delivery only,
thus KVM, running on ring 0, can run safely even with guest FRED
RSP0 and SSP0.  It can be deferred to load host FRED RSP0 and SSP0
until before returning to user level.

Signed-off-by: Xin Li <xin3.li@intel.com>
Tested-by: Shan Kang <shan.kang@intel.com>
---

Changes since v1:
* Use kvm_cpu_cap_has() instead of cpu_feature_enabled() to decouple
  KVM's capability to virtualize a feature and host's enabling of a
  feature (Chao Gao).
* Move guest FRED states init into __vmx_vcpu_reset() (Chao Gao).
---
 arch/x86/include/asm/vmx.h | 16 ++++++++++++++++
 arch/x86/kvm/vmx/vmx.c     | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index cb14f7e315f5..4889754415b5 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -280,12 +280,28 @@ enum vmcs_field {
 	GUEST_BNDCFGS_HIGH              = 0x00002813,
 	GUEST_IA32_RTIT_CTL		= 0x00002814,
 	GUEST_IA32_RTIT_CTL_HIGH	= 0x00002815,
+	GUEST_IA32_FRED_CONFIG		= 0x0000281a,
+	GUEST_IA32_FRED_RSP1		= 0x0000281c,
+	GUEST_IA32_FRED_RSP2		= 0x0000281e,
+	GUEST_IA32_FRED_RSP3		= 0x00002820,
+	GUEST_IA32_FRED_STKLVLS		= 0x00002822,
+	GUEST_IA32_FRED_SSP1		= 0x00002824,
+	GUEST_IA32_FRED_SSP2		= 0x00002826,
+	GUEST_IA32_FRED_SSP3		= 0x00002828,
 	HOST_IA32_PAT			= 0x00002c00,
 	HOST_IA32_PAT_HIGH		= 0x00002c01,
 	HOST_IA32_EFER			= 0x00002c02,
 	HOST_IA32_EFER_HIGH		= 0x00002c03,
 	HOST_IA32_PERF_GLOBAL_CTRL	= 0x00002c04,
 	HOST_IA32_PERF_GLOBAL_CTRL_HIGH	= 0x00002c05,
+	HOST_IA32_FRED_CONFIG		= 0x00002c08,
+	HOST_IA32_FRED_RSP1		= 0x00002c0a,
+	HOST_IA32_FRED_RSP2		= 0x00002c0c,
+	HOST_IA32_FRED_RSP3		= 0x00002c0e,
+	HOST_IA32_FRED_STKLVLS		= 0x00002c10,
+	HOST_IA32_FRED_SSP1		= 0x00002c12,
+	HOST_IA32_FRED_SSP2		= 0x00002c14,
+	HOST_IA32_FRED_SSP3		= 0x00002c16,
 	PIN_BASED_VM_EXEC_CONTROL       = 0x00004000,
 	CPU_BASED_VM_EXEC_CONTROL       = 0x00004002,
 	EXCEPTION_BITMAP                = 0x00004004,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index d58ed2d3d379..b7b772183ee4 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1470,6 +1470,18 @@ void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cpu,
 				    (unsigned long)(cpu_entry_stack(cpu) + 1));
 		}
 
+#ifdef CONFIG_X86_64
+		/* Per-CPU FRED MSRs */
+		if (kvm_cpu_cap_has(X86_FEATURE_FRED)) {
+			vmcs_write64(HOST_IA32_FRED_RSP1, read_msr(MSR_IA32_FRED_RSP1));
+			vmcs_write64(HOST_IA32_FRED_RSP2, read_msr(MSR_IA32_FRED_RSP2));
+			vmcs_write64(HOST_IA32_FRED_RSP3, read_msr(MSR_IA32_FRED_RSP3));
+			vmcs_write64(HOST_IA32_FRED_SSP1, read_msr(MSR_IA32_FRED_SSP1));
+			vmcs_write64(HOST_IA32_FRED_SSP2, read_msr(MSR_IA32_FRED_SSP2));
+			vmcs_write64(HOST_IA32_FRED_SSP3, read_msr(MSR_IA32_FRED_SSP3));
+		}
+#endif
+
 		vmx->loaded_vmcs->cpu = cpu;
 	}
 }
@@ -4321,6 +4333,15 @@ void vmx_set_constant_host_state(struct vcpu_vmx *vmx)
 	 */
 	vmcs_write16(HOST_DS_SELECTOR, 0);
 	vmcs_write16(HOST_ES_SELECTOR, 0);
+
+	/*
+	 * FRED MSRs are per-cpu, however FRED CONFIG and STKLVLS MSRs
+	 * are the same on all CPUs, thus they are initialized here.
+	 */
+	if (kvm_cpu_cap_has(X86_FEATURE_FRED)) {
+		vmcs_write64(HOST_IA32_FRED_CONFIG, read_msr(MSR_IA32_FRED_CONFIG));
+		vmcs_write64(HOST_IA32_FRED_STKLVLS, read_msr(MSR_IA32_FRED_STKLVLS));
+	}
 #else
 	vmcs_write16(HOST_DS_SELECTOR, __KERNEL_DS);  /* 22.2.4 */
 	vmcs_write16(HOST_ES_SELECTOR, __KERNEL_DS);  /* 22.2.4 */
@@ -4865,6 +4886,19 @@ static void __vmx_vcpu_reset(struct kvm_vcpu *vcpu)
 	 */
 	vmx->pi_desc.nv = POSTED_INTR_VECTOR;
 	vmx->pi_desc.sn = 1;
+
+#ifdef CONFIG_X86_64
+	if (kvm_cpu_cap_has(X86_FEATURE_FRED)) {
+		vmcs_write64(GUEST_IA32_FRED_CONFIG, 0);
+		vmcs_write64(GUEST_IA32_FRED_RSP1, 0);
+		vmcs_write64(GUEST_IA32_FRED_RSP2, 0);
+		vmcs_write64(GUEST_IA32_FRED_RSP3, 0);
+		vmcs_write64(GUEST_IA32_FRED_STKLVLS, 0);
+		vmcs_write64(GUEST_IA32_FRED_SSP1, 0);
+		vmcs_write64(GUEST_IA32_FRED_SSP2, 0);
+		vmcs_write64(GUEST_IA32_FRED_SSP3, 0);
+	}
+#endif
 }
 
 static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
-- 
2.43.0


