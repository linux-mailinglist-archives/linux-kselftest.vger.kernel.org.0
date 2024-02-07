Return-Path: <linux-kselftest+bounces-4252-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BB684D066
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 19:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 258A01C25CE0
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 18:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A904126F06;
	Wed,  7 Feb 2024 17:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yf1TkA9I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DC585959;
	Wed,  7 Feb 2024 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328748; cv=none; b=JXmMnVtx0NFQNtnTTJ5qVAPrWn4Hf//37ye+t3bxfDHZvm2noKm4Kgq4lPq1UyFMQVZc9kFvnweiXOUMAS/luOtkN7pNW7hHRwMmEIcqHli8xjrvnj+WkwLr87EBUsvceo24pqUpUXpvBVWO4gZ1Aq9prWsjYLKPUXshN0jM6Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328748; c=relaxed/simple;
	bh=d3GcbZGq1+iZzuECARn9elrUw2PwCYl4eSLifsdjifc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S01aD9mLRwXyLCeucwdE/Dq+6j0RWCQUQJwK6VyRn0a3AkD2EtGWg1rX3YbxCD9qrqRDy1fhlDjdpGmQTqxiBC3xreIrwSJOx1Ot/HGroIExlSyJEaPvSm99+2/cdhKe6c0uICY+pifIkrVF5KpDenFFAJR7hh6m8URAZdEd1og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yf1TkA9I; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707328747; x=1738864747;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d3GcbZGq1+iZzuECARn9elrUw2PwCYl4eSLifsdjifc=;
  b=Yf1TkA9Iu3Hq/O4aec0aUdDb1I64fB37U1BcNpPNrJf7ScJKd3y/Wk46
   +1QDP2aBZYY7kHi3FnEgJEEwOqm9gsSenLlcVHdRBLxKzrAovjdFIHSPc
   hpb3fdW12L0zjBbBif41x7R9lWMewO+E3UMCyIfofCwvHX/vGFrVyddrz
   UHHkrkj17OwV0tbC6kb7QzAZ5EeNW1vSyqVmkDne7mUf8EEjme9i2wPG2
   hs2ahsdqAt1anaEwZ4JqrbzmeV0amp7Rr8PybF/9c+RGB8YNV+2y7i8TT
   4XyOe1HdjAF3q4KdiBJaCbAO0fYH/tCfQgbJV1gCSs64gHEUiLzLggG1l
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="11622538"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="11622538"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 09:58:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="6020714"
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
Subject: [PATCH v2 07/25] KVM: VMX: Set intercept for FRED MSRs
Date: Wed,  7 Feb 2024 09:26:27 -0800
Message-ID: <20240207172646.3981-8-xin3.li@intel.com>
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

Add FRED MSRs to the valid passthrough MSR list and set FRED MSRs intercept
based on FRED enumeration.

Signed-off-by: Xin Li <xin3.li@intel.com>
Tested-by: Shan Kang <shan.kang@intel.com>
---

Change since v1:
* Enable FRED MSRs intercept if FRED is no longer enumerated in CPUID
  (Chao Gao).
---
 arch/x86/kvm/vmx/vmx.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 34b6676f60d8..d58ed2d3d379 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -693,6 +693,9 @@ static bool is_valid_passthrough_msr(u32 msr)
 	case MSR_LBR_CORE_TO ... MSR_LBR_CORE_TO + 8:
 		/* LBR MSRs. These are handled in vmx_update_intercept_for_lbr_msrs() */
 		return true;
+	case MSR_IA32_FRED_RSP0 ... MSR_IA32_FRED_CONFIG:
+		/* FRED MSRs should be passthrough to FRED guests only */
+		return true;
 	}
 
 	r = possible_passthrough_msr_slot(msr) != -ENOENT;
@@ -7774,10 +7777,12 @@ static void update_intel_pt_cfg(struct kvm_vcpu *vcpu)
 static void vmx_vcpu_config_fred_after_set_cpuid(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	bool fred_enumerated;
 
 	kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_FRED);
+	fred_enumerated = guest_can_use(vcpu, X86_FEATURE_FRED);
 
-	if (guest_can_use(vcpu, X86_FEATURE_FRED)) {
+	if (fred_enumerated) {
 		vm_entry_controls_setbit(vmx, VM_ENTRY_LOAD_IA32_FRED);
 		secondary_vm_exit_controls_setbit(vmx,
 						  SECONDARY_VM_EXIT_SAVE_IA32_FRED |
@@ -7788,6 +7793,16 @@ static void vmx_vcpu_config_fred_after_set_cpuid(struct kvm_vcpu *vcpu)
 						    SECONDARY_VM_EXIT_SAVE_IA32_FRED |
 						    SECONDARY_VM_EXIT_LOAD_IA32_FRED);
 	}
+
+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP0, MSR_TYPE_RW, !fred_enumerated);
+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP1, MSR_TYPE_RW, !fred_enumerated);
+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP2, MSR_TYPE_RW, !fred_enumerated);
+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP3, MSR_TYPE_RW, !fred_enumerated);
+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_STKLVLS, MSR_TYPE_RW, !fred_enumerated);
+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_SSP1, MSR_TYPE_RW, !fred_enumerated);
+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_SSP2, MSR_TYPE_RW, !fred_enumerated);
+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_SSP3, MSR_TYPE_RW, !fred_enumerated);
+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_CONFIG, MSR_TYPE_RW, !fred_enumerated);
 }
 
 static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
-- 
2.43.0


