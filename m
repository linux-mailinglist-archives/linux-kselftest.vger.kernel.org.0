Return-Path: <linux-kselftest+bounces-21769-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC7C9C3BDE
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 11:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E19DA1C217A5
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 10:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9B118A6DB;
	Mon, 11 Nov 2024 10:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qPMFgRDk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A2D189F5E;
	Mon, 11 Nov 2024 10:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731320892; cv=none; b=loOFs2SahH9DiZX2E642OHB/eOA+l9Ub8HHaLa15WcJ2rZ05JeiZVA8uUSFMSG40QqImzjGuZwQshfAwfBXt+2gdZiMDdcTVX5NVcHIIXU/uwcCGXyTDVL0ilbQR8XnL1WyqdjdwFezxCrl+5lcJn/rX0L8xBvudxbku/5+olVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731320892; c=relaxed/simple;
	bh=ohNXBix2lGd/+l3bdOKxJJO4C2FcC+DKAm6tGvIqO50=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uvfNnEzuzgjFy2e7CSQrfYzApd9+qRyRY2uK2hKtX+zG8Jfwc0f6fDA2hObG9FK7hVDB/syucqSCdg+Uz0Tt3MYpkGm6aBX7sPSsYUm52KYJWXRp99TacNFUKdd6V4M93AB6YA0/8eMzx8Yc2mv0HAqGz+nE+R1BEQTS9pdkmSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=qPMFgRDk; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731320890; x=1762856890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KTrrp1GTNpGgd12PqLg3Bp8SktPUeTIRjQJhDKcx3Bk=;
  b=qPMFgRDkLK0VYn7B4b18mpaZN+NlkAB8/Fz0J02QPZAv6gYWWVpTOW2p
   HbxhO/n+9wXEAQ4PcxZgluu6ADI7YQbJAAraxuLqTzs+siXQMzVq2vBJ+
   jBtolbSaxn/WEeiMrJgZCkRN0YvjocvepSHHVHH2fnRiilJ5uC4MoB2hZ
   8=;
X-IronPort-AV: E=Sophos;i="6.12,144,1728950400"; 
   d="scan'208";a="146201047"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 10:28:09 +0000
Received: from EX19MTAUEA002.ant.amazon.com [10.0.29.78:23109]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.90.76:2525] with esmtp (Farcaster)
 id 2d037141-0914-4fc5-b5bc-40a12fecb131; Mon, 11 Nov 2024 10:28:09 +0000 (UTC)
X-Farcaster-Flow-ID: 2d037141-0914-4fc5-b5bc-40a12fecb131
Received: from EX19D008UEC003.ant.amazon.com (10.252.135.194) by
 EX19MTAUEA002.ant.amazon.com (10.252.134.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 11 Nov 2024 10:28:06 +0000
Received: from EX19MTAUWB002.ant.amazon.com (10.250.64.231) by
 EX19D008UEC003.ant.amazon.com (10.252.135.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 11 Nov 2024 10:28:06 +0000
Received: from email-imr-corp-prod-iad-all-1b-3ae3de11.us-east-1.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.228) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Mon, 11 Nov 2024 10:28:06 +0000
Received: from dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com (dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com [10.253.74.38])
	by email-imr-corp-prod-iad-all-1b-3ae3de11.us-east-1.amazon.com (Postfix) with ESMTPS id 465EFA0227;
	Mon, 11 Nov 2024 10:28:04 +0000 (UTC)
From: Ivan Orlov <iorlov@amazon.com>
To: <bp@alien8.de>, <dave.hansen@linux.intel.com>, <mingo@redhat.com>,
	<pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<tglx@linutronix.de>
CC: Ivan Orlov <iorlov@amazon.com>, <hpa@zytor.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<x86@kernel.org>, <pdurrant@amazon.co.uk>, <dwmw@amazon.co.uk>
Subject: [PATCH v2 3/6] KVM: VMX: Handle vectoring error in check_emulate_instruction
Date: Mon, 11 Nov 2024 10:27:46 +0000
Message-ID: <20241111102749.82761-4-iorlov@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241111102749.82761-1-iorlov@amazon.com>
References: <20241111102749.82761-1-iorlov@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Move unhandleable vmexit due to MMIO during vectoring error detection
into check_emulate_instruction. Implement a function which checks if
emul_type indicates MMIO so it can be used for both VMX and SVM.

Fix the comment about EMULTYPE_PF as this flag doesn't necessarily
mean MMIO anymore: it can also be set due to the write protection
violation.

Signed-off-by: Ivan Orlov <iorlov@amazon.com>
---
V1 -> V2:
- Detect the unhandleable vectoring error in vmx_check_emulate_instruction
instead of handling it in the common MMU code (which is specific for
cached MMIO)

 arch/x86/include/asm/kvm_host.h | 10 ++++++++--
 arch/x86/kvm/vmx/vmx.c          | 25 ++++++++++++-------------
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index eb413079b7c6..3de9702a9135 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2017,8 +2017,8 @@ u64 vcpu_tsc_khz(struct kvm_vcpu *vcpu);
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
@@ -2053,6 +2053,12 @@ u64 vcpu_tsc_khz(struct kvm_vcpu *vcpu);
 #define EMULTYPE_COMPLETE_USER_EXIT (1 << 7)
 #define EMULTYPE_WRITE_PF_TO_SP	    (1 << 8)
 
+static inline bool kvm_is_emul_type_mmio(int emul_type)
+{
+	return (emul_type & EMULTYPE_PF) &&
+		!(emul_type & EMULTYPE_WRITE_PF_TO_SP);
+}
+
 int kvm_emulate_instruction(struct kvm_vcpu *vcpu, int emulation_type);
 int kvm_emulate_instruction_from_buffer(struct kvm_vcpu *vcpu,
 					void *insn, int insn_len);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index f92740e7e107..a10f35d9704b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1693,6 +1693,8 @@ static int vmx_rtit_ctl_check(struct kvm_vcpu *vcpu, u64 data)
 int vmx_check_emulate_instruction(struct kvm_vcpu *vcpu, int emul_type,
 				  void *insn, int insn_len)
 {
+	bool is_vect;
+
 	/*
 	 * Emulation of instructions in SGX enclaves is impossible as RIP does
 	 * not point at the failing instruction, and even if it did, the code
@@ -1704,6 +1706,13 @@ int vmx_check_emulate_instruction(struct kvm_vcpu *vcpu, int emul_type,
 		kvm_queue_exception(vcpu, UD_VECTOR);
 		return X86EMUL_PROPAGATE_FAULT;
 	}
+
+	is_vect = to_vmx(vcpu)->idt_vectoring_info & VECTORING_INFO_VALID_MASK;
+
+	/* Emulation is not possible when MMIO happens during event vectoring. */
+	if (kvm_is_emul_type_mmio(emul_type) && is_vect)
+		return X86EMUL_UNHANDLEABLE_VECTORING_IO;
+
 	return X86EMUL_CONTINUE;
 }
 
@@ -6452,7 +6461,6 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 	union vmx_exit_reason exit_reason = vmx->exit_reason;
 	u32 vectoring_info = vmx->idt_vectoring_info;
 	u16 exit_handler_index;
-	gpa_t gpa;
 
 	/*
 	 * Flush logged GPAs PML buffer, this will make dirty_bitmap more
@@ -6537,24 +6545,15 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
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
-		gpa = exit_reason.basic == EXIT_REASON_EPT_MISCONFIG
-		      ? vmcs_read64(GUEST_PHYSICAL_ADDRESS) : INVALID_GPA;
-
-		kvm_prepare_event_vectoring_exit(vcpu, gpa);
+	     exit_reason.basic != EXIT_REASON_NOTIFY &&
+	     exit_reason.basic != EXIT_REASON_EPT_MISCONFIG)) {
+		kvm_prepare_event_vectoring_exit(vcpu, INVALID_GPA);
 		return 0;
 	}
 
-- 
2.43.0


