Return-Path: <linux-kselftest+bounces-41100-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3019CB50C2A
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 05:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B32214E6C7E
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 03:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F23425BEFD;
	Wed, 10 Sep 2025 03:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="V63k7WyG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out198-20.us.a.mail.aliyun.com (out198-20.us.a.mail.aliyun.com [47.90.198.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C604925B2F4;
	Wed, 10 Sep 2025 03:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757473531; cv=none; b=A5sg+dCG4axTr8y/+u9GZfVDg3xS9yRzbmmSlU+K+7Bw5ZTj4VBK7+eN8NFT0Qcijo6UYX4kAEfyoaj/q8tJLNzUk/kMD4Pr/rLpg/t93ZjTy+COW3Ksl7ldXPYfjYpJiqZ98kwiS2aU9fU7tFExOD/2ok3fXoWohHgXMuOx6jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757473531; c=relaxed/simple;
	bh=OPf2QR2k6DAiKqVX0oVySRjxE6j2hrfdjMNsYF+M5Xs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fC/Vk1OZkY0ihNrpe4SIYBIvXIapWcQnvkucGqfFbxZ03+vDYRREzL4r36KwTW2r+5/b8gz2hYPw7llcbog1ttaeWcYFrytZcvJFAlCTumctZIDpeXoB/rHr+1wIJZ8mWJbsob5OX5zlTJYYgLBcVUIj79WQV9KtrbbLrJgC1TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=V63k7WyG; arc=none smtp.client-ip=47.90.198.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1757473514; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=E93cY9FHGBGF8PLSftp1VfXTr3kQA09+IbltBz6T4yc=;
	b=V63k7WyG1wUTbdCfT7qVAta4EaGh01O9+eyOwslzy6DaWNpodzj4qOcmDF7XdCkdK2RpdfYxlw36TG05AW0tZUt2jN9F6IJrWMUMaHXUL/ZYKjY1UBRZ0dcVfZyxX2uDGR0Q+AZveTJFbmGHH+3e/pe/DrnMHmj4oXWNDEfeWn4=
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.ebeulmh_1757472571 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 10 Sep 2025 10:49:31 +0800
From: Hou Wenlong <houwenlong.hwl@antgroup.com>
To: kvm@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] KVM: selftests: Verify 'BS' bit checking in pending debug exception during VM entry
Date: Wed, 10 Sep 2025 10:49:19 +0800
Message-Id: <3c0686934fc33ebb484aa5cc71443a22504df7ca.1757416809.git.houwenlong.hwl@antgroup.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1757416809.git.houwenlong.hwl@antgroup.com>
References: <cover.1757416809.git.houwenlong.hwl@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the x86's debug_regs test, add a test case to cover the scenario where
single-step with STI in VMX sets the 'BS' bit in pending debug
exceptions for #DB interception and instruction emulation in both cases.

Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
---
 .../selftests/kvm/include/x86/processor.h     |  3 +-
 tools/testing/selftests/kvm/x86/debug_regs.c  | 41 +++++++++++++++++--
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 488d516c4f6f..f5827cca813e 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -34,7 +34,8 @@ extern uint64_t guest_tsc_khz;
 
 #define NMI_VECTOR		0x02
 
-#define X86_EFLAGS_FIXED	 (1u << 1)
+#define X86_EFLAGS_FIXED	(1u << 1)
+#define X86_EFLAGS_TF		(1u << 8)
 
 #define X86_CR4_VME		(1ul << 0)
 #define X86_CR4_PVI		(1ul << 1)
diff --git a/tools/testing/selftests/kvm/x86/debug_regs.c b/tools/testing/selftests/kvm/x86/debug_regs.c
index ba80b77c2869..60dea0116b21 100644
--- a/tools/testing/selftests/kvm/x86/debug_regs.c
+++ b/tools/testing/selftests/kvm/x86/debug_regs.c
@@ -15,11 +15,31 @@
 
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
+}
 
 static void guest_code(void)
 {
@@ -69,13 +89,25 @@ static void guest_code(void)
 	if (is_forced_emulation_enabled) {
 		/* DR6.BD test for emulation */
 		asm volatile(KVM_FEP "fep_bd_start: mov %%dr0, %%rax" : : : "rax");
+
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
 	}
 
 	GUEST_DONE();
 }
 
-#define  CAST_TO_RIP(v)  ((unsigned long long)&(v))
-
 static void vcpu_skip_insn(struct kvm_vcpu *vcpu, int insn_len)
 {
 	struct kvm_regs regs;
@@ -110,6 +142,9 @@ int main(void)
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 	run = vcpu->run;
 
+	vm_install_exception_handler(vm, DB_VECTOR, guest_db_handler);
+	vm_install_exception_handler(vm, IRQ_VECTOR, guest_irq_handler);
+
 	/* Test software BPs - int3 */
 	memset(&debug, 0, sizeof(debug));
 	debug.control = KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_SW_BP;
-- 
2.31.1


