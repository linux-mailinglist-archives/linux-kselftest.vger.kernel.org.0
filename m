Return-Path: <linux-kselftest+bounces-4269-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A98C984D0B1
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 19:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6162E281D8F
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 18:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA8D136987;
	Wed,  7 Feb 2024 17:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FiLjyUpL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700AA135A52;
	Wed,  7 Feb 2024 17:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328764; cv=none; b=hNo+02CgTLO67lKkZu3SkfRZTtAkbrwmZUyOADubUd7xYnNbAJYI7hiaqmND1rkzjkRdFggKo7x1Bxw5FblZaG81rIsWrVPvno3PJxjM0jZD+gGknRtbXSRjJ/4FkNwLdKN2GOx6SNXtKn/ubNhEg7CKXe8dsm3llq0jaoKk1DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328764; c=relaxed/simple;
	bh=pn5l9wgQCKTBHaMYVbWpY+69QPu5DgR37XqofOuD9KA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=obyEL/sGAG5FDCHmBkFoQIxAGI6cDCUa8zV3uQn567VDruYPJhvbHX3a76fsbgcVe4ULMXquTlR8V2ahsPHgr1Pa8Ubb6aKHFpujLBnG2C40mAmtKiHoFw2wXQOl5qhdyX0TVnjYDbEx0LJlRKaLx81OU8NDudtdjMJvENYIk50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FiLjyUpL; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707328763; x=1738864763;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pn5l9wgQCKTBHaMYVbWpY+69QPu5DgR37XqofOuD9KA=;
  b=FiLjyUpLningK7sG0Wzl16D8+mb2CJhySD/AaJmPbR/lCmGGVN/eZd0s
   9iz4BfKxuePI/VHBQ3rdW8zBz07syq6GJXnW/YplSFnJOZ6M+81+20Fve
   N5kKnEwIAmLN1ZdFdMt92jIS3P6/lXxDfed/EqUJnkR1jYtTiDpO2sxO8
   dpk+NHeBl9l/rzoffC4XMWus4opeGkj+k6cW25+RSWMPDvHp6+8PN/6jc
   MfUFXFCIq6km4NVnN/474rteAD90mpfbGRaioo2BXI/2G4m1+UPy4QJmb
   DHPmPc26AqC4Hj3FWg64zuBW/0ZY1RYGlbqjHVhS91nKbud3TifzxCRr/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="11622685"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="11622685"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 09:59:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="6020768"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmviesa004.fm.intel.com with ESMTP; 07 Feb 2024 09:58:59 -0800
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
Subject: [PATCH v2 23/25] KVM: selftests: Run debug_regs test with FRED enabled
Date: Wed,  7 Feb 2024 09:26:43 -0800
Message-ID: <20240207172646.3981-24-xin3.li@intel.com>
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

Run another round of debug_regs test with FRED enabled if FRED is
available.

Signed-off-by: Xin Li <xin3.li@intel.com>
---
 .../selftests/kvm/include/x86_64/processor.h  |  4 ++
 .../testing/selftests/kvm/x86_64/debug_regs.c | 50 ++++++++++++++-----
 2 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index a84863503fcb..bc5cd8628a20 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -48,6 +48,7 @@ extern bool host_cpu_is_amd;
 #define X86_CR4_SMEP		(1ul << 20)
 #define X86_CR4_SMAP		(1ul << 21)
 #define X86_CR4_PKE		(1ul << 22)
+#define X86_CR4_FRED		(1ul << 32)
 
 struct xstate_header {
 	u64				xstate_bv;
@@ -164,6 +165,9 @@ struct kvm_x86_cpu_feature {
 #define	X86_FEATURE_SPEC_CTRL		KVM_X86_CPU_FEATURE(0x7, 0, EDX, 26)
 #define	X86_FEATURE_ARCH_CAPABILITIES	KVM_X86_CPU_FEATURE(0x7, 0, EDX, 29)
 #define	X86_FEATURE_PKS			KVM_X86_CPU_FEATURE(0x7, 0, ECX, 31)
+#define	X86_FEATURE_FRED		KVM_X86_CPU_FEATURE(0x7, 1, EAX, 17)
+#define	X86_FEATURE_LKGS		KVM_X86_CPU_FEATURE(0x7, 1, EAX, 18)
+#define	X86_FEATURE_WRMSRNS		KVM_X86_CPU_FEATURE(0x7, 1, EAX, 19)
 #define	X86_FEATURE_XTILECFG		KVM_X86_CPU_FEATURE(0xD, 0, EAX, 17)
 #define	X86_FEATURE_XTILEDATA		KVM_X86_CPU_FEATURE(0xD, 0, EAX, 18)
 #define	X86_FEATURE_XSAVES		KVM_X86_CPU_FEATURE(0xD, 1, EAX, 3)
diff --git a/tools/testing/selftests/kvm/x86_64/debug_regs.c b/tools/testing/selftests/kvm/x86_64/debug_regs.c
index f6b295e0b2d2..69055e764f15 100644
--- a/tools/testing/selftests/kvm/x86_64/debug_regs.c
+++ b/tools/testing/selftests/kvm/x86_64/debug_regs.c
@@ -20,7 +20,7 @@ uint32_t guest_value;
 
 extern unsigned char sw_bp, hw_bp, write_data, ss_start, bd_start;
 
-static void guest_code(void)
+static void guest_test_code(void)
 {
 	/* Create a pending interrupt on current vCPU */
 	x2apic_enable();
@@ -61,6 +61,15 @@ static void guest_code(void)
 
 	/* DR6.BD test */
 	asm volatile("bd_start: mov %%dr0, %%rax" : : : "rax");
+}
+
+static void guest_code(void)
+{
+	guest_test_code();
+
+	if (get_cr4() & X86_CR4_FRED)
+		guest_test_code();
+
 	GUEST_DONE();
 }
 
@@ -75,19 +84,15 @@ static void vcpu_skip_insn(struct kvm_vcpu *vcpu, int insn_len)
 	vcpu_regs_set(vcpu, &regs);
 }
 
-int main(void)
+void run_test(struct kvm_vcpu *vcpu)
 {
 	struct kvm_guest_debug debug;
+	struct kvm_run *run = vcpu->run;
 	unsigned long long target_dr6, target_rip;
-	struct kvm_vcpu *vcpu;
-	struct kvm_run *run;
-	struct kvm_vm *vm;
-	struct ucall uc;
-	uint64_t cmd;
 	int i;
 	/* Instruction lengths starting at ss_start */
 	int ss_size[6] = {
-		1,		/* sti*/
+		1,		/* sti */
 		2,		/* xor */
 		2,		/* cpuid */
 		5,		/* mov */
@@ -95,11 +100,6 @@ int main(void)
 		1,		/* cli */
 	};
 
-	TEST_REQUIRE(kvm_has_cap(KVM_CAP_SET_GUEST_DEBUG));
-
-	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
-	run = vcpu->run;
-
 	/* Test software BPs - int3 */
 	memset(&debug, 0, sizeof(debug));
 	debug.control = KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_SW_BP;
@@ -202,6 +202,30 @@ int main(void)
 	/* Disable all debug controls, run to the end */
 	memset(&debug, 0, sizeof(debug));
 	vcpu_guest_debug_set(vcpu, &debug);
+}
+
+int main(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+	uint64_t cmd;
+
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_SET_GUEST_DEBUG));
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+
+	run_test(vcpu);
+
+	if (kvm_cpu_has(X86_FEATURE_FRED)) {
+		struct kvm_sregs sregs;
+
+		vcpu_sregs_get(vcpu, &sregs);
+		sregs.cr4 |= X86_CR4_FRED;
+		vcpu_sregs_set(vcpu, &sregs);
+
+		run_test(vcpu);
+	}
 
 	vcpu_run(vcpu);
 	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
-- 
2.43.0


