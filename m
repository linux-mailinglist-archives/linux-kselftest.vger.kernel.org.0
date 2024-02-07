Return-Path: <linux-kselftest+bounces-4253-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4F584D067
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 19:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B007B1C260A0
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 18:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B49A126F09;
	Wed,  7 Feb 2024 17:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Om/u3VeJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A9684A21;
	Wed,  7 Feb 2024 17:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328748; cv=none; b=aNjBYsuzjuD80R+jQZjVb7zj9WSEloF60t4Nf489NMzRUmOkyDdBVYPxE20S4AxlCjwqxwrujPIYRzLN8hRwWdrVpEDzsKRTcmmvFPNWGSpeRDK2A23KXZtALwChliNMIWvrXoqGV6aC/CLpoXKbiJnKbScBCFqMTcztzzZIZ/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328748; c=relaxed/simple;
	bh=4kdSkys88FpdgTkppEIsXzYqXf5ahVowuZYtgN30c0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I43TCW+eravJ71VVkIjqeS65GixU4+1ssCXretImo/in7btVFvhh5caTDsRhBSNkXdSaWYKbRYDIdZ/eg2Pybw6VHciTDn/HyRxQnHtZZmdFu9AsZe7YwziWrmAqMWQ53s1TlN9FhONneRvOo+x8hLO+UNP9fbbWjb8myyF4UKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Om/u3VeJ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707328743; x=1738864743;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4kdSkys88FpdgTkppEIsXzYqXf5ahVowuZYtgN30c0w=;
  b=Om/u3VeJxKG+wOQ616W7Sr+RkErjHXzuBzXMsrLz+wVPm7qZdCjvnRi4
   0vJPPwsuI30E5Z62dyxg70N98AH7G27dQiOAQxOZJKwi+pcKazpPiPe+H
   iI9f5WjQCTxl29OG9uwU6x0cK5vhvxpKTu2JW9MnXnale0rsSINc88arP
   NayUZR0LzF5u3oQGLazYFlEU+mPLywl3GaQJYB2p4e4SbOoC4Qz5hmtxU
   h9/NWCUf7hBNZGpvZ8C+bVrb4IN4jWyYokXEGRR8nnXFbpRV8gv0hg/Td
   la1oj7kqDh2mI/jPMTEp3wuJcAmS9yYikkLKxDfcfOzoDCxEFxObBUAWR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="11622533"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="11622533"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 09:58:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="6020710"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmviesa004.fm.intel.com with ESMTP; 07 Feb 2024 09:58:54 -0800
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
Subject: [PATCH v2 06/25] KVM: VMX: Defer enabling FRED MSRs save/load until after set CPUID
Date: Wed,  7 Feb 2024 09:26:26 -0800
Message-ID: <20240207172646.3981-7-xin3.li@intel.com>
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

Clear FRED VM entry/exit controls when initializing a vCPU, and set
these controls only if FRED is enumerated after set CPUID.

FRED VM entry/exit controls need to be set to establish context
sufficient to support FRED event delivery immediately after VM entry
and exit.  However it is not required to save/load FRED MSRs for
a non-FRED guest, which aren't supposed to access FRED MSRs.

Signed-off-by: Xin Li <xin3.li@intel.com>
Tested-by: Shan Kang <shan.kang@intel.com>
---

Changes since v1:
* Use kvm_cpu_cap_has() instead of cpu_feature_enabled() (Chao Gao).
* Clear FRED VM entry/exit controls if FRED is not enumerated (Chao Gao).
* Use guest_can_use() to trace FRED enumeration in a vcpu (Chao Gao).
---
 arch/x86/kvm/governed_features.h |  1 +
 arch/x86/kvm/vmx/vmx.c           | 32 +++++++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/governed_features.h b/arch/x86/kvm/governed_features.h
index ad463b1ed4e4..507ca73e52e9 100644
--- a/arch/x86/kvm/governed_features.h
+++ b/arch/x86/kvm/governed_features.h
@@ -17,6 +17,7 @@ KVM_GOVERNED_X86_FEATURE(PFTHRESHOLD)
 KVM_GOVERNED_X86_FEATURE(VGIF)
 KVM_GOVERNED_X86_FEATURE(VNMI)
 KVM_GOVERNED_X86_FEATURE(LAM)
+KVM_GOVERNED_X86_FEATURE(FRED)
 
 #undef KVM_GOVERNED_X86_FEATURE
 #undef KVM_GOVERNED_FEATURE
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 4023474ea002..34b6676f60d8 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4402,6 +4402,9 @@ static u32 vmx_vmentry_ctrl(void)
 	if (cpu_has_perf_global_ctrl_bug())
 		vmentry_ctrl &= ~VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL;
 
+	/* Whether to load guest FRED MSRs is deferred until after set CPUID */
+	vmentry_ctrl &= ~VM_ENTRY_LOAD_IA32_FRED;
+
 	return vmentry_ctrl;
 }
 
@@ -4430,7 +4433,13 @@ static u32 vmx_vmexit_ctrl(void)
 
 static u64 vmx_secondary_vmexit_ctrl(void)
 {
-	return vmcs_config.secondary_vmexit_ctrl;
+	u64 secondary_vmexit_ctrl = vmcs_config.secondary_vmexit_ctrl;
+
+	/* Whether to save/load FRED MSRs is deferred until after set CPUID */
+	secondary_vmexit_ctrl &= ~(SECONDARY_VM_EXIT_SAVE_IA32_FRED |
+				   SECONDARY_VM_EXIT_LOAD_IA32_FRED);
+
+	return secondary_vmexit_ctrl;
 }
 
 static void vmx_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
@@ -7762,10 +7771,31 @@ static void update_intel_pt_cfg(struct kvm_vcpu *vcpu)
 		vmx->pt_desc.ctl_bitmask &= ~(0xfULL << (32 + i * 4));
 }
 
+static void vmx_vcpu_config_fred_after_set_cpuid(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+
+	kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_FRED);
+
+	if (guest_can_use(vcpu, X86_FEATURE_FRED)) {
+		vm_entry_controls_setbit(vmx, VM_ENTRY_LOAD_IA32_FRED);
+		secondary_vm_exit_controls_setbit(vmx,
+						  SECONDARY_VM_EXIT_SAVE_IA32_FRED |
+						  SECONDARY_VM_EXIT_LOAD_IA32_FRED);
+	} else {
+		vm_entry_controls_clearbit(vmx, VM_ENTRY_LOAD_IA32_FRED);
+		secondary_vm_exit_controls_clearbit(vmx,
+						    SECONDARY_VM_EXIT_SAVE_IA32_FRED |
+						    SECONDARY_VM_EXIT_LOAD_IA32_FRED);
+	}
+}
+
 static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
+	vmx_vcpu_config_fred_after_set_cpuid(vcpu);
+
 	/*
 	 * XSAVES is effectively enabled if and only if XSAVE is also exposed
 	 * to the guest.  XSAVES depends on CR4.OSXSAVE, and CR4.OSXSAVE can be
-- 
2.43.0


