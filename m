Return-Path: <linux-kselftest+bounces-41097-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFA3B50BFA
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 04:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29AFB3ABEAA
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 02:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B4924C077;
	Wed, 10 Sep 2025 02:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="Xg2y/RGc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out198-20.us.a.mail.aliyun.com (out198-20.us.a.mail.aliyun.com [47.90.198.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9413424728E;
	Wed, 10 Sep 2025 02:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472913; cv=none; b=RIgOk5EwB8CcRapV6oMfNnB9PrrFJIBVGFtRh9sW8QEjTPfjBfa5IvoaevqsCEENLirKL4Ql24PMSitVjLMtGiS0y1Rruwr0oRhsrW8ZbfPKoVH9InGmFUo+KRv0aFbTNHx9qRdRIScRe57j9SaYRXjhV1iV/KR3ZO/q89E4nGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472913; c=relaxed/simple;
	bh=2ARSwHb0F7d03WhyJZCkYnd61/DkGRfq+i6rjunIz38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RlafJ/9BlNNddQjeiYhq/5XmB8q8vG0FVi3C3A15kJ+2Pe/6S5aQsPqg1zofOYvfMi52W2YuT8rT5fQ6596XWQc7V6seSBgknEJX/3HClAnjKBko59Rgnhq1/0kAQX+AdNsCu1vFNMjT7WwdBf/f/FeftcB+QRxZccDZ6i2xxEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=Xg2y/RGc; arc=none smtp.client-ip=47.90.198.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1757472892; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=/bBvVN2boAr4G21eP2LiBWEfhWBiFGpA3TTPe04AoTc=;
	b=Xg2y/RGc+i+fRSIYg9+XWTzbR9FQTRDsJzRbek7USw7HadAnnycJRsYfqYTe7ljdB3eCsz5v5RmAG82kTwjXyaPkTsWt5iByHMOQMVQaTL773oL1ha9iNGjzuUIwYTJxBfClsDaDI0HTKy16lsXCjqv6Bu+UQ1FI3PdXe6lXqRQ=
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.ebZ4e-x_1757472570 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 10 Sep 2025 10:49:30 +0800
From: Hou Wenlong <houwenlong.hwl@antgroup.com>
To: kvm@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] KVM: selftests: Verify guest debug DR7.GD checking during instruction emulation
Date: Wed, 10 Sep 2025 10:49:18 +0800
Message-Id: <0fc4f9d4aa0b1ed41cdeea1788d1d8907326d9b4.1757416809.git.houwenlong.hwl@antgroup.com>
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

Similar to the global disable test case in x86's debug_regs test, use
'KVM_FEP' to trigger instruction emulation in order to verify the guest
debug DR7.GD checking during instruction emulation.

Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
---
 tools/testing/selftests/kvm/x86/debug_regs.c | 25 +++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/debug_regs.c b/tools/testing/selftests/kvm/x86/debug_regs.c
index 2d814c1d1dc4..ba80b77c2869 100644
--- a/tools/testing/selftests/kvm/x86/debug_regs.c
+++ b/tools/testing/selftests/kvm/x86/debug_regs.c
@@ -19,6 +19,7 @@
 uint32_t guest_value;
 
 extern unsigned char sw_bp, hw_bp, write_data, ss_start, bd_start;
+extern unsigned char fep_bd_start;
 
 static void guest_code(void)
 {
@@ -64,6 +65,12 @@ static void guest_code(void)
 
 	/* DR6.BD test */
 	asm volatile("bd_start: mov %%dr0, %%rax" : : : "rax");
+
+	if (is_forced_emulation_enabled) {
+		/* DR6.BD test for emulation */
+		asm volatile(KVM_FEP "fep_bd_start: mov %%dr0, %%rax" : : : "rax");
+	}
+
 	GUEST_DONE();
 }
 
@@ -185,7 +192,7 @@ int main(void)
 			    target_dr6);
 	}
 
-	/* Finally test global disable */
+	/* test global disable */
 	memset(&debug, 0, sizeof(debug));
 	debug.control = KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_HW_BP;
 	debug.arch.debugreg[7] = 0x400 | DR7_GD;
@@ -202,6 +209,22 @@ int main(void)
 			    run->debug.arch.pc, target_rip, run->debug.arch.dr6,
 			    target_dr6);
 
+	/* test global disable in emulation */
+	if (is_forced_emulation_enabled) {
+		/* Skip the 3-bytes "mov dr0" */
+		vcpu_skip_insn(vcpu, 3);
+		vcpu_run(vcpu);
+		TEST_ASSERT(run->exit_reason == KVM_EXIT_DEBUG &&
+			    run->debug.arch.exception == DB_VECTOR &&
+			    run->debug.arch.pc == CAST_TO_RIP(fep_bd_start) &&
+			    run->debug.arch.dr6 == target_dr6,
+			    "DR7.GD: exit %d exception %d rip 0x%llx "
+			    "(should be 0x%llx) dr6 0x%llx (should be 0x%llx)",
+			    run->exit_reason, run->debug.arch.exception,
+			    run->debug.arch.pc, target_rip, run->debug.arch.dr6,
+			    target_dr6);
+	}
+
 	/* Disable all debug controls, run to the end */
 	memset(&debug, 0, sizeof(debug));
 	vcpu_guest_debug_set(vcpu, &debug);
-- 
2.31.1


