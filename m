Return-Path: <linux-kselftest+bounces-47712-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49707CCC376
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 15:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94A8B30A925E
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 14:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060D6346E50;
	Thu, 18 Dec 2025 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="oWjP2RHD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out198-5.us.a.mail.aliyun.com (out198-5.us.a.mail.aliyun.com [47.90.198.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAFA346AF3;
	Thu, 18 Dec 2025 14:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766066497; cv=none; b=MSsjlq4ObZHWj0Cv7QYMYaiMuoY9icNTZbVUmyp5oKI+eFTa+oVrbSh3oa36ysZ/vzd1M/JNZulb5sKtkUQTyHq8sA6eJqoF/vYaEbanVuuTDPd2GtqImkIp/IaiSL53PMZio4YglUjau6Zd5s0FhOS/zF56mWXpOHhJiidHsAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766066497; c=relaxed/simple;
	bh=jFQ9DqTQpSQm6rmmDOGm2HA29ydwb/S36l19nCg7/Yo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AcfcFennzxZC8k508Fmv9vDkbxWI0R7BSMRIWJz2G7RvfnbJSivFAz/DlaPYJXH4aRz0qyJ64H/8EdIPn8uSiFFnpREHtSj1yX9yYVw+4U+kkxxRYDOxMGk7w6hh7DHoTHC4xeo9rYIR4Jxfdw9kPVNwb02VVSTNKeXbbHlHhD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=oWjP2RHD; arc=none smtp.client-ip=47.90.198.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1766066471; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=vZ8aCloaky+agOBSy+/0Gbj8Rcqx0E6cXjSVIBuLkAE=;
	b=oWjP2RHDOWmF5OsLzzKNWdJh5GNvNqBpQPYhEvlsKyTArzen+dCo7wfvbuKwmDg3h941JlvNcqVZaruxkx4Lz15Du7MU+LnmHr7lVIHUxZw6KZ18lkc2+nPOl2PmBhCgi+YtWS35Ku+UppQZhhcaGSGuOzIqjhW2OO5uJ3j7wqk=
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.fniMiYE_1766066470 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 18 Dec 2025 22:01:11 +0800
From: Hou Wenlong <houwenlong.hwl@antgroup.com>
To: kvm@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 9/9] KVM: selftests: Verify 'BS' bit checking in pending debug exception state during VM-Entry
Date: Thu, 18 Dec 2025 22:00:44 +0800
Message-Id: <e0df5d6812da0f508cdf697ac7627693199c8293.1766066076.git.houwenlong.hwl@antgroup.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1766066076.git.houwenlong.hwl@antgroup.com>
References: <cover.1766066076.git.houwenlong.hwl@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the x86's debug_regs test, add a test case to cover the scenario
where single-step with STI in VMX sets the 'BS' bit in pending debug
exceptions state for #DB interception and instruction emulation in both
cases.

Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
---
 .../selftests/kvm/include/x86/processor.h     |  3 +-
 tools/testing/selftests/kvm/x86/debug_regs.c  | 53 +++++++++++++++++--
 2 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 57d62a425109..1992d98016d4 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -36,7 +36,8 @@ extern uint64_t guest_tsc_khz;

 const char *ex_str(int vector);

-#define X86_EFLAGS_FIXED	 (1u << 1)
+#define X86_EFLAGS_FIXED	(1u << 1)
+#define X86_EFLAGS_TF		(1u << 8)

 #define X86_CR4_VME		(1ul << 0)
 #define X86_CR4_PVI		(1ul << 1)
diff --git a/tools/testing/selftests/kvm/x86/debug_regs.c b/tools/testing/selftests/kvm/x86/debug_regs.c
index bd34cf2a96b7..84d3103a05fc 100644
--- a/tools/testing/selftests/kvm/x86/debug_regs.c
+++ b/tools/testing/selftests/kvm/x86/debug_regs.c
@@ -15,11 +15,35 @@

 #define IRQ_VECTOR 0xAA

+#define  CAST_TO_RIP(v)  ((unsigned long long)&(v))
+
 /* For testing data access debug BP */
 uint32_t guest_value;

 extern unsigned char sw_bp, hw_bp, write_data, ss_start, bd_start;
-extern unsigned char fep_bd_start;
+extern unsigned char fep_bd_start, fep_sti_start, fep_sti_end;
+
+static void guest_db_handler(struct ex_regs *regs)
+{
+	static int count;
+	unsigned long target_rips[2] = {
+		CAST_TO_RIP(fep_sti_start),
+		CAST_TO_RIP(fep_sti_end),
+	};
+
+	__GUEST_ASSERT(regs->rip == target_rips[count], "STI: unexpected rip 0x%lx (should be 0x%lx)",
+		       regs->rip, target_rips[count]);
+	regs->rflags &= ~X86_EFLAGS_TF;
+	count++;
+}
+
+static void guest_irq_handler(struct ex_regs *regs)
+{
+	unsigned long target_rip = CAST_TO_RIP(fep_bd_start);
+
+	__GUEST_ASSERT(regs->rip == target_rip, "IRQ: unexpected rip 0x%lx (should be 0x%lx)",
+		       regs->rip, target_rip);
+}

 static void guest_code(void)
 {
@@ -66,14 +90,27 @@ static void guest_code(void)
 	/* DR6.BD test */
 	asm volatile("bd_start: mov %%dr0, %%rax" : : : "rax");

-	if (is_forced_emulation_enabled)
+	if (is_forced_emulation_enabled) {
 		asm volatile(KVM_FEP "fep_bd_start: mov %%dr0, %%rax" : : : "rax");

+		/* pending debug exceptions for emulation */
+		asm volatile("pushf\n\t"
+			     "orq $" __stringify(X86_EFLAGS_TF) ", (%rsp)\n\t"
+			     "popf\n\t"
+			     "sti\n\t"
+			     "fep_sti_start:"
+			     "cli\n\t"
+			     "pushf\n\t"
+			     "orq $" __stringify(X86_EFLAGS_TF) ", (%rsp)\n\t"
+			     "popf\n\t"
+			     KVM_FEP "sti\n\t"
+			     "fep_sti_end:"
+			     "cli\n\t");
+	}
+
 	GUEST_DONE();
 }

-#define  CAST_TO_RIP(v)  ((unsigned long long)&(v))
-
 static void vcpu_skip_insn(struct kvm_vcpu *vcpu, int insn_len)
 {
 	struct kvm_regs regs;
@@ -227,6 +264,14 @@ int main(void)
 	memset(&debug, 0, sizeof(debug));
 	vcpu_guest_debug_set(vcpu, &debug);

+	vm_install_exception_handler(vm, DB_VECTOR, guest_db_handler);
+	/*
+	 * Install a dummy IRQ handler, as the single-step #DB delivery after
+	 * STI removes the interrupt shadow, so the pending interrupt will be
+	 * delivered after #DB handling.
+	 */
+	vm_install_exception_handler(vm, IRQ_VECTOR, guest_irq_handler);
+
 	vcpu_run(vcpu);
 	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
 	cmd = get_ucall(vcpu, &uc);
--
2.31.1


