Return-Path: <linux-kselftest+bounces-23458-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC0F9F55CA
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 19:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52D281887E31
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 18:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693971F8AF6;
	Tue, 17 Dec 2024 18:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tAgmEVVf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960321F8930;
	Tue, 17 Dec 2024 18:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734459322; cv=none; b=VocAIzr8liB4ADSpC26Fj4RjBWH7zZRN7kgTNUuHg8eaaoR4AVLOq3jNmlKTSD/lrWvARSQAbJA58h2Td+7aANVUjuo3Le9lROmg12R6hQpztx8q/xRmzpo65WRntV7a53QYzvdQuw4mhYRYNXbOCGIRmf/ojBLOnlL2M6w/q1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734459322; c=relaxed/simple;
	bh=MzRUkp1l5huWcvHODxn7UEXAHpVA4OorMAWVDvugiS8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j+5fLnp9SqKwqQt6GLFD+fTU1KGwJb3E7XZKZFeTNz16aVPHD2MRIZArAT2yj940bpsEGZaGXZ+TTsBt7tzWJ8sDKIliBlNjR/mStLd5/ATjYaSiVpXY6W3tHEo97IfOMqP9gGrehdbSwB0PrFjcb5bw1ORWEFIZsKjICsN4GiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=tAgmEVVf; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734459227; x=1765995227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4u/ng5qZ3A4+uh9KY/4GLCugKda2yo4r1YX7BgEse9w=;
  b=tAgmEVVf2GKCdHVPtF+2I/nXesmOCrzhqGvFkUR9KCdXNUHUD9eO5TJm
   GJVaRCM0xr7OtVnr+TNpGn4RtNXvTVOxJ0u7sE6Gi0NE38nykbj46k2C6
   Gg02dYbAbznbqttH/a25wYD7tmJNF4TI03eyzElxCyRt7QksGrw1dqBf5
   A=;
X-IronPort-AV: E=Sophos;i="6.12,242,1728950400"; 
   d="scan'208";a="6733997"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 18:13:43 +0000
Received: from EX19MTAUEA001.ant.amazon.com [10.0.0.204:12819]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.24.38:2525] with esmtp (Farcaster)
 id f9a17de5-d760-4f0d-9434-baddac6a13f8; Tue, 17 Dec 2024 18:15:16 +0000 (UTC)
X-Farcaster-Flow-ID: f9a17de5-d760-4f0d-9434-baddac6a13f8
Received: from EX19D008UEC002.ant.amazon.com (10.252.135.242) by
 EX19MTAUEA001.ant.amazon.com (10.252.134.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 17 Dec 2024 18:15:15 +0000
Received: from EX19MTAUWB002.ant.amazon.com (10.250.64.231) by
 EX19D008UEC002.ant.amazon.com (10.252.135.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 17 Dec 2024 18:15:15 +0000
Received: from email-imr-corp-prod-pdx-1box-2b-8c2c6aed.us-west-2.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.228) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Tue, 17 Dec 2024 18:15:15 +0000
Received: from dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com (dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com [10.253.74.38])
	by email-imr-corp-prod-pdx-1box-2b-8c2c6aed.us-west-2.amazon.com (Postfix) with ESMTPS id 29677A0723;
	Tue, 17 Dec 2024 18:15:13 +0000 (UTC)
From: Ivan Orlov <iorlov@amazon.com>
To: <bp@alien8.de>, <dave.hansen@linux.intel.com>, <mingo@redhat.com>,
	<pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<tglx@linutronix.de>
CC: Ivan Orlov <iorlov@amazon.com>, <hpa@zytor.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<x86@kernel.org>, <dwmw@amazon.co.uk>, <pdurrant@amazon.co.uk>,
	<jalliste@amazon.co.uk>
Subject: [PATCH v3 4/7] KVM: VMX: Handle vectoring error in check_emulate_instruction
Date: Tue, 17 Dec 2024 18:14:55 +0000
Message-ID: <20241217181458.68690-5-iorlov@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241217181458.68690-1-iorlov@amazon.com>
References: <20241217181458.68690-1-iorlov@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Move unhandleable vmexit during vectoring error detection
into check_emulate_instruction. Implement the function which prohibits
the emulation if EMULTYPE_PF is set when vectoring, otherwise such a
situation may occur:

1. CPU executes an instruction and hits a #GP
2. While vectoring the #GP, a shadow #PF occurs
3. On vmexit, KVM re-injects #GP
4. KVM emulates because of the write-protected page
5. KVM "successfully" emulates and also detects the #GP
6. KVM synthesizes a #GP, and since #GP has already been injected,
incorrectly escalates to a #DF.

Fix the comment about EMULTYPE_PF as this flag doesn't necessarily
mean MMIO anymore: it can also be set due to the write protection
violation.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Ivan Orlov <iorlov@amazon.com>
---
V1 -> V2:
- Detect the unhandleable vectoring error in vmx_check_emulate_instruction
instead of handling it in the common MMU code (which is specific for
cached MMIO)
V2 -> V3:
- Prohibit any emulation during vectoring if it happens due to an
intercepted #PF.

 arch/x86/include/asm/kvm_host.h |  9 +++++++--
 arch/x86/kvm/vmx/vmx.c          | 23 +++++++++--------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index de8fb1ab230c..f3a1d050e1d6 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2019,8 +2019,8 @@ u64 vcpu_tsc_khz(struct kvm_vcpu *vcpu);
  *			VMware backdoor emulation handles select instructions
  *			and reinjects the #GP for all other cases.
  *
- * EMULTYPE_PF - Set when emulating MMIO by way of an intercepted #PF, in which
- *		 case the CR2/GPA value pass on the stack is valid.
+ * EMULTYPE_PF - Set when an intercepted #PF triggers the emulation, in which case
+ *		 the CR2/GPA value pass on the stack is valid.
  *
  * EMULTYPE_COMPLETE_USER_EXIT - Set when the emulator should update interruptibility
  *				 state and inject single-step #DBs after skipping
@@ -2055,6 +2055,11 @@ u64 vcpu_tsc_khz(struct kvm_vcpu *vcpu);
 #define EMULTYPE_COMPLETE_USER_EXIT (1 << 7)
 #define EMULTYPE_WRITE_PF_TO_SP	    (1 << 8)
 
+static inline bool kvm_can_emulate_event_vectoring(int emul_type)
+{
+	return !(emul_type & EMULTYPE_PF);
+}
+
 int kvm_emulate_instruction(struct kvm_vcpu *vcpu, int emulation_type);
 int kvm_emulate_instruction_from_buffer(struct kvm_vcpu *vcpu,
 					void *insn, int insn_len);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index acc2f0e0a339..89ddbe1175c7 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1705,6 +1705,12 @@ int vmx_check_emulate_instruction(struct kvm_vcpu *vcpu, int emul_type,
 		kvm_queue_exception(vcpu, UD_VECTOR);
 		return X86EMUL_PROPAGATE_FAULT;
 	}
+
+	/* Check that emulation is possible during event vectoring */
+	if ((to_vmx(vcpu)->idt_vectoring_info & VECTORING_INFO_VALID_MASK) &&
+	    !kvm_can_emulate_event_vectoring(emul_type))
+		return X86EMUL_UNHANDLEABLE_VECTORING;
+
 	return X86EMUL_CONTINUE;
 }
 
@@ -6543,26 +6549,15 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 		return 0;
 	}
 
-	/*
-	 * Note:
-	 * Do not try to fix EXIT_REASON_EPT_MISCONFIG if it caused by
-	 * delivery event since it indicates guest is accessing MMIO.
-	 * The vm-exit can be triggered again after return to guest that
-	 * will cause infinite loop.
-	 */
 	if ((vectoring_info & VECTORING_INFO_VALID_MASK) &&
 	    (exit_reason.basic != EXIT_REASON_EXCEPTION_NMI &&
 	     exit_reason.basic != EXIT_REASON_EPT_VIOLATION &&
 	     exit_reason.basic != EXIT_REASON_PML_FULL &&
 	     exit_reason.basic != EXIT_REASON_APIC_ACCESS &&
 	     exit_reason.basic != EXIT_REASON_TASK_SWITCH &&
-	     exit_reason.basic != EXIT_REASON_NOTIFY)) {
-		gpa_t gpa = INVALID_GPA;
-
-		if (exit_reason.basic == EXIT_REASON_EPT_MISCONFIG)
-			gpa = vmcs_read64(GUEST_PHYSICAL_ADDRESS);
-
-		kvm_prepare_event_vectoring_exit(vcpu, gpa);
+	     exit_reason.basic != EXIT_REASON_NOTIFY &&
+	     exit_reason.basic != EXIT_REASON_EPT_MISCONFIG)) {
+		kvm_prepare_event_vectoring_exit(vcpu, INVALID_GPA);
 		return 0;
 	}
 
-- 
2.43.0


