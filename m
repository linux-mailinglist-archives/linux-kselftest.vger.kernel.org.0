Return-Path: <linux-kselftest+bounces-4264-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C76484D0A0
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 19:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7E61C22167
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 18:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3BA1353FD;
	Wed,  7 Feb 2024 17:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e2PmbUVb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE751350DE;
	Wed,  7 Feb 2024 17:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328761; cv=none; b=TucjSMNmGAvflBFgt8A/J0AQvaXrhsl41jFoni2eAGh6qtqE6zK5yQHAlITAREpl3mCebx8S2h2W7e/4P1HwgErhpcNhYQsTre5X1irXIHvi+tAR1087yyvYqzxwqq6fSbG23oasJcM7BauNkslezX/bzyEVV3iNKcpxKrC7GTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328761; c=relaxed/simple;
	bh=a4uFS7UxOu09WT9Xt4fj2tzuZKx0iXCkQwXaF3SS9Qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dWUzhVHWgwoFPP+HROO9WaDdOCMv/P5Wq9BynDIXLWh+9EjTSwsPZdCnEx1QUnL+h6tmVBkucknrhThrPkKZf5mL0sizhB66tM8UThd5IQXwYsLqiahcYRzEY1oDLoUmOdhbmZ9mnOH4IubgyoVZUsCYyVbRjv6xEQw9C9Hets8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e2PmbUVb; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707328760; x=1738864760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a4uFS7UxOu09WT9Xt4fj2tzuZKx0iXCkQwXaF3SS9Qo=;
  b=e2PmbUVbayY+2PoajfMt/IamGHPN7QYChqhWT27L3UEK3KxxaGppZeiE
   xsvH81JtgrGr26Id/Ls5nZExKdAKDyaPwP7gBNYx3QjLy/Tp94zU1znZh
   PwiwxTiVvLo6bsUnW577336Fz+gNaOump8J+M9BZgY27o7gTyErCCv1LZ
   G5aiLoHSVm6y3ffxaO7kY3+l1HxjSUo534/09eFFjiwDvC8QJNfBw/cMi
   dngnZbZ3dQEK8ojLFr0nzc2o5hTlsB44nPA1oSXfydL8X2cF0KS6g73iW
   av44F1p1Y3yKnzJHuZtOGFZFfjrK0x6zKNR0aES406gyeu+xEUkrTGKj/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="11622667"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="11622667"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 09:59:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="6020759"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmviesa004.fm.intel.com with ESMTP; 07 Feb 2024 09:58:58 -0800
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
Subject: [PATCH v2 20/25] KVM: nVMX: Add support for VMX FRED controls
Date: Wed,  7 Feb 2024 09:26:40 -0800
Message-ID: <20240207172646.3981-21-xin3.li@intel.com>
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

Add VMX FRED controls to nested VMX controls and set the VMX
nested-exception support bit (bit 58) in the nested IA32_VMX_BASIC MSR
when FRED is enabled.

Signed-off-by: Xin Li <xin3.li@intel.com>
Tested-by: Shan Kang <shan.kang@intel.com>
---
 arch/x86/kvm/vmx/nested.c | 14 ++++++++++----
 arch/x86/kvm/vmx/vmx.c    |  1 +
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index f9c1fbeac302..04a9cdb0361f 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -1239,10 +1239,12 @@ static bool is_bitwise_subset(u64 superset, u64 subset, u64 mask)
 #define VMX_BASIC_FEATURES_MASK			\
 	(VMX_BASIC_DUAL_MONITOR_TREATMENT |	\
 	 VMX_BASIC_INOUT |			\
-	 VMX_BASIC_TRUE_CTLS)
+	 VMX_BASIC_TRUE_CTLS |			\
+	 VMX_BASIC_NESTED_EXCEPTION)
 
-#define VMX_BASIC_RESERVED_BITS			\
-	(GENMASK_ULL(63, 56) | GENMASK_ULL(47, 45) | BIT_ULL(31))
+#define VMX_BASIC_RESERVED_BITS				\
+	(GENMASK_ULL(63, 59) | GENMASK_ULL(57, 56) |	\
+	 GENMASK_ULL(47, 45) | BIT_ULL(31))
 
 static int vmx_restore_vmx_basic(struct vcpu_vmx *vmx, u64 data)
 {
@@ -6988,7 +6990,8 @@ static void nested_vmx_setup_entry_ctls(struct vmcs_config *vmcs_conf,
 #ifdef CONFIG_X86_64
 		VM_ENTRY_IA32E_MODE |
 #endif
-		VM_ENTRY_LOAD_IA32_PAT | VM_ENTRY_LOAD_BNDCFGS;
+		VM_ENTRY_LOAD_IA32_PAT | VM_ENTRY_LOAD_BNDCFGS |
+		VM_ENTRY_LOAD_IA32_FRED;
 	msrs->entry_ctls_high |=
 		(VM_ENTRY_ALWAYSON_WITHOUT_TRUE_MSR | VM_ENTRY_LOAD_IA32_EFER |
 		 VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL);
@@ -7147,6 +7150,9 @@ static void nested_vmx_setup_basic(struct nested_vmx_msrs *msrs)
 
 	if (cpu_has_vmx_basic_inout())
 		msrs->basic |= VMX_BASIC_INOUT;
+
+	if (kvm_cpu_cap_has(X86_FEATURE_FRED))
+		msrs->basic |= VMX_BASIC_NESTED_EXCEPTION;
 }
 
 static void nested_vmx_setup_cr_fixed(struct nested_vmx_msrs *msrs)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index fc808d599493..1005b6a57d23 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7915,6 +7915,7 @@ static void nested_vmx_cr_fixed1_bits_update(struct kvm_vcpu *vcpu)
 
 	entry = kvm_find_cpuid_entry_index(vcpu, 0x7, 1);
 	cr4_fixed1_update(X86_CR4_LAM_SUP,    eax, feature_bit(LAM));
+	cr4_fixed1_update(X86_CR4_FRED,       eax, feature_bit(FRED));
 
 #undef cr4_fixed1_update
 }
-- 
2.43.0


