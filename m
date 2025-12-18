Return-Path: <linux-kselftest+bounces-47713-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFD4CCC2B8
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 15:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E90E30287E2
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 14:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FFE34C81F;
	Thu, 18 Dec 2025 14:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="tyIcFHvj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out28-197.mail.aliyun.com (out28-197.mail.aliyun.com [115.124.28.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF5D34C804;
	Thu, 18 Dec 2025 14:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766066801; cv=none; b=JonUSbzMeV2sKytERNRvqrWetMVBnBzwDsbyaL1sYMR4Q555Zr9q1HX0nr6JQ4qXFCy8a6umIX6i99UI3G5fBCPiFAWaWEnj9x/ylBBFYmzn0AM28/0dLoIspPhEkYvSEoOn+YWMekRkxZyJP9xXOlIPX1KJi4EFVXhDZr6ojBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766066801; c=relaxed/simple;
	bh=PYx8mw8jcMhldgO20ghRP6zsMW7Xykx16g9vZLu2V9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZW3tMc2CP+pGbFSLVKg/kawIvswoBPo2RivpcelTut7tKeuAF+QHne/G2yVgM821z9fisYR/UUigN3Tp5lxPWH1wtASbclop+qFcJNzMxON04GUoxDmdMPmeHvD2TBh/bt9a5qFd9tsGQhFT+A5Lq+bekVl3XHAnZr4SihB6L/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=tyIcFHvj; arc=none smtp.client-ip=115.124.28.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1766066796; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=MdcZ9dB/ZZC2s3JBcz4u+PMPg0Oky+AgJqGJUglEwiU=;
	b=tyIcFHvjWB2kmUOyZDVGsQv2jxXy4Zpw9cg+eMu+ktltfHxIHwltNRxiiGGswikUMKTaMR6m22Ii9EEbaQlymoJIpF3+NpVseDspsLdA1iopygsFpUXF4Ne531mVG0fZH5gFoHsuPDZhedBBOtvp+63ARKd5165BmdSt+OJtwlc=
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.fniSlgz_1766066469 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 18 Dec 2025 22:01:09 +0800
From: Hou Wenlong <houwenlong.hwl@antgroup.com>
To: kvm@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/9] KVM: selftests: Verify guest debug DR7.GD checking during instruction emulation
Date: Thu, 18 Dec 2025 22:00:43 +0800
Message-Id: <f4b5af2580a1acd4b5fe0225fc44b44d6b0ecfae.1766066076.git.houwenlong.hwl@antgroup.com>
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

Similar to the global disable test case in x86's debug_regs test, use
'KVM_FEP' to trigger instruction emulation in order to verify the guest
debug DR7.GD checking during instruction emulation.

Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
---
 tools/testing/selftests/kvm/x86/debug_regs.c | 23 +++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/debug_regs.c b/tools/testing/selftests/kvm/x86/debug_regs.c
index 2d814c1d1dc4..bd34cf2a96b7 100644
--- a/tools/testing/selftests/kvm/x86/debug_regs.c
+++ b/tools/testing/selftests/kvm/x86/debug_regs.c
@@ -19,6 +19,7 @@
 uint32_t guest_value;
 
 extern unsigned char sw_bp, hw_bp, write_data, ss_start, bd_start;
+extern unsigned char fep_bd_start;
 
 static void guest_code(void)
 {
@@ -64,6 +65,10 @@ static void guest_code(void)
 
 	/* DR6.BD test */
 	asm volatile("bd_start: mov %%dr0, %%rax" : : : "rax");
+
+	if (is_forced_emulation_enabled)
+		asm volatile(KVM_FEP "fep_bd_start: mov %%dr0, %%rax" : : : "rax");
+
 	GUEST_DONE();
 }
 
@@ -185,7 +190,7 @@ int main(void)
 			    target_dr6);
 	}
 
-	/* Finally test global disable */
+	/* test global disable */
 	memset(&debug, 0, sizeof(debug));
 	debug.control = KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_HW_BP;
 	debug.arch.debugreg[7] = 0x400 | DR7_GD;
@@ -202,6 +207,22 @@ int main(void)
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


