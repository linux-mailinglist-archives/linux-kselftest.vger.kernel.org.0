Return-Path: <linux-kselftest+bounces-4255-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 777F184D078
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 19:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07F2FB29406
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 18:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF671292EB;
	Wed,  7 Feb 2024 17:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XUXI/ocY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524F7126F11;
	Wed,  7 Feb 2024 17:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328750; cv=none; b=Zq9bX+sJQv3uDnmtPSUxXj/lZBscefVE/JuccvRVF/LTO6lXH2gAisaBvxyvMSf0KA0OC2QL/02cSbiMUC2H/W4rNAWYZhhJx0xYO1Hevxz+t/EGNRWJwMN3WQY79flyqscPLZq2xV9bdQfV2jlE22vBW8rBD7MnT5PSv0IRHfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328750; c=relaxed/simple;
	bh=GjnwgyBkd3KBWam4oCzszCoyfvTgjRR1j1p0QWV6WrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tk2+dHkEF9p9yzj9B3z0BzSxRaNz+hCibqjKpkHFnk9Qb3Lr4/qkoLs8vRRe5vwlzw//aXPw9f3uxBa7s13AJ5XXazUyFG+WS8dZgRMYebjeqEcOZnELw35nDbGBwfv6wkLxT5g8pgqdMy/+lQBn8IqgGn1cpirYdPpEeyGzosc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XUXI/ocY; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707328749; x=1738864749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GjnwgyBkd3KBWam4oCzszCoyfvTgjRR1j1p0QWV6WrM=;
  b=XUXI/ocYcY/xOo4Dsm41ycUIIOVqJEY+5OPjRfc4q1sdOrxggzSSA/Kr
   viPiXoYX1wj8+4duCntrLrwSp1v+H6VQ1mH+iD+YZZtciaaWlCOWf499F
   F2fSp/B1BehqSPSEEtNDaCCDU7ndrzI71wfmrqkfa4pDmBKvRVM+pdtbu
   oHLCvxDgCTPmJsWqbfNiLhk+7D1OqYQjCZU9mTYGoJX8awZsslOT5LNVk
   Ll3mm86A5dlcWX2AOMcsUpNTU/gyRvpo/XACdi04zwIYgg3gcuRDrkdHd
   kT5wZZ699GibQJkPAD4eNrAeBCCmqbdrBF9Hawo8EgNpqqplv5SfuLJE8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="11622554"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="11622554"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 09:58:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="6020721"
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
Subject: [PATCH v2 09/25] KVM: VMX: Switch FRED RSP0 between host and guest
Date: Wed,  7 Feb 2024 09:26:29 -0800
Message-ID: <20240207172646.3981-10-xin3.li@intel.com>
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

Switch MSR_IA32_FRED_RSP0 between host and guest in
vmx_prepare_switch_to_{host,guest}().

MSR_IA32_FRED_RSP0 is used during ring 3 event delivery only, thus
KVM, running on ring 0, can run safely with guest FRED RSP0, i.e.,
no need to switch between host/guest FRED RSP0 during VM entry and
exit.

KVM should switch to host FRED RSP0 before returning to user level,
and switch to guest FRED RSP0 before entering guest mode.

Signed-off-by: Xin Li <xin3.li@intel.com>
Tested-by: Shan Kang <shan.kang@intel.com>
---

Changes since v1:
* Don't use guest_cpuid_has() in vmx_prepare_switch_to_{host,guest}(),
  which are called from IRQ-disabled context (Chao Gao).
* Reset msr_guest_fred_rsp0 in __vmx_vcpu_reset() (Chao Gao).
---
 arch/x86/kvm/vmx/vmx.c | 17 +++++++++++++++++
 arch/x86/kvm/vmx/vmx.h |  2 ++
 2 files changed, 19 insertions(+)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b7b772183ee4..264378c3b784 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1337,6 +1337,16 @@ void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 	}
 
 	wrmsrl(MSR_KERNEL_GS_BASE, vmx->msr_guest_kernel_gs_base);
+
+	if (guest_can_use(vcpu, X86_FEATURE_FRED)) {
+		/*
+		 * MSR_IA32_FRED_RSP0 is top of task stack, which never changes.
+		 * Thus it should be initialized only once.
+		 */
+		if (unlikely(vmx->msr_host_fred_rsp0 == 0))
+			vmx->msr_host_fred_rsp0 = read_msr(MSR_IA32_FRED_RSP0);
+		wrmsrl(MSR_IA32_FRED_RSP0, vmx->msr_guest_fred_rsp0);
+	}
 #else
 	savesegment(fs, fs_sel);
 	savesegment(gs, gs_sel);
@@ -1381,6 +1391,11 @@ static void vmx_prepare_switch_to_host(struct vcpu_vmx *vmx)
 	invalidate_tss_limit();
 #ifdef CONFIG_X86_64
 	wrmsrl(MSR_KERNEL_GS_BASE, vmx->msr_host_kernel_gs_base);
+
+	if (guest_can_use(&vmx->vcpu, X86_FEATURE_FRED)) {
+		vmx->msr_guest_fred_rsp0 = read_msr(MSR_IA32_FRED_RSP0);
+		wrmsrl(MSR_IA32_FRED_RSP0, vmx->msr_host_fred_rsp0);
+	}
 #endif
 	load_fixmap_gdt(raw_smp_processor_id());
 	vmx->guest_state_loaded = false;
@@ -4889,6 +4904,8 @@ static void __vmx_vcpu_reset(struct kvm_vcpu *vcpu)
 
 #ifdef CONFIG_X86_64
 	if (kvm_cpu_cap_has(X86_FEATURE_FRED)) {
+		vmx->msr_guest_fred_rsp0 = 0;
+
 		vmcs_write64(GUEST_IA32_FRED_CONFIG, 0);
 		vmcs_write64(GUEST_IA32_FRED_RSP1, 0);
 		vmcs_write64(GUEST_IA32_FRED_RSP2, 0);
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 3ad52437f426..176ad39be406 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -278,6 +278,8 @@ struct vcpu_vmx {
 #ifdef CONFIG_X86_64
 	u64		      msr_host_kernel_gs_base;
 	u64		      msr_guest_kernel_gs_base;
+	u64		      msr_host_fred_rsp0;
+	u64		      msr_guest_fred_rsp0;
 #endif
 
 	u64		      spec_ctrl;
-- 
2.43.0


