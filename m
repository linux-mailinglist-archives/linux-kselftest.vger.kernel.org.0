Return-Path: <linux-kselftest+bounces-44222-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B7AC16F2E
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 22:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5DC8A50729F
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 21:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA8D357726;
	Tue, 28 Oct 2025 21:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fdgVSBV+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0945350D63
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 21:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686468; cv=none; b=QNNVau+nOawm2RthQLzlvuxMyfv79/GgrlQ5IGStXLVq72X2jdPP4ll9bnIogV6cvtUhMHEsLugbUJAKYCcTI8CURO2MkT0HkmRVo5syrL6jbhP9gjvP+/tCMxlwHIRKNeXChA2EJ8KR9QgzM+u8si8nlO5UQinp+F9+1GvwzCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686468; c=relaxed/simple;
	bh=h+BtiPzVy2gWivSMFIqWnCmHMSFsal+CXe23zn8LbkQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZRHbn3RgiIcV0pTrL+zBxkavZEAnpr1f4POjWtclbPCHXKuYMIHWSPAbeacVUXPXALMK0Xs5GdRRlnK6n4tpENeUuFzkbOCwzVudcmvVh5mnUR40mWZsMRM66eAt9o+Wi/bLr9+4nkKyJLv17vD1EcJVVXgs9y+CeExQRSN1kaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fdgVSBV+; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-93e7ece2ff4so2022077839f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 14:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761686466; x=1762291266; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PnRis7314sxjOj0Rh6H340e0+BpA55H88Cr2h5cu4AY=;
        b=fdgVSBV+sJ+MOWLn4uBqBX9j7MuqNRnEuoi5NEstlqWtJJtx+oQHLiUNOEXr9h+kge
         vwAJGs1e9CYE9Ew/GNKwb5onQsxuM4Nmnwu86OivT4iIR3MskigPm6Ya5plxRPCyNaZP
         H3p0EmcTM1SNPSTBJj5hU6uxRV4ZY3WlZM1Gb1AMV6saBZlqfq9Uk3xhecuXkTAfKOi9
         1PvEpcsH6vrEpEAIo9srUq4F+rEhOzttM/irMvxBqkr5FDiYKSlzVfXyPSP+HwSulo2+
         uDaXFIrVZIp1d1BJoW6N73Nh6l//KnDd/39GQfC1Wyx4K99NLaYKUBt5jNNnym+KiNYV
         ewvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686466; x=1762291266;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PnRis7314sxjOj0Rh6H340e0+BpA55H88Cr2h5cu4AY=;
        b=r/ILAsIO8MJmg9iosP3rf0ruJdlnYs7A14XhoKhXLiXRppwGHmhCUmtegvJmtRdTqO
         H21KAk1/gf5kkSlTbkkbIjshz81d4i67rW9CtmRvSvgEJGIoMt2AJv4eMf0AnDusVCb6
         IU9DtsbMutI5cEnqyRDEkSseKMugdzpwUv7FTq2xPcqv4B1KAlSoUYIsW8HydxM/spbw
         1h7aTUuhg+8dXsisUqOhKq2x1WGVHyVgyhTMFP8BIy1m+TxbEE8Iosj98BiERaakSmDL
         0D471f02xSbKWkQQYj5fPXTqi5/LJzvuFHF+dBwHsFf5iIE8kXr10w3UFnN4Qg3XAChC
         oCLw==
X-Gm-Message-State: AOJu0YwKSpPCy1evHOsLa+H4JYQTZ9oY2jZrpXbjBKoqMoamoqLolk4v
	HIhl/13RTtXPxvsc6PsIGKOZY+fo47Ud1V1wf31RNzp605OxT0pYurvIf514lJYIOgYBa4W5WJf
	fXFpzjGrvkXsEvcwL1jMMvNHw4uHpHaEb0rg/oRLBuUhgtRuQ/SUPHzmCyKgdDMOVRlSFOGHH4u
	LM0dOX7Mt/HprhrFXggDoLVvjAm16PWTQjJv6jAdsd5iM=
X-Google-Smtp-Source: AGHT+IFFotzwJGtcAawKS1Bi4VJy5fzH8cXmMVxBeTy7ud7wRUCgQ0kdS8CGAINF03YwqDm76lS1B0wIdA==
X-Received: from iobby9.prod.google.com ([2002:a05:6602:3a09:b0:93e:ac34:407d])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6602:134a:b0:940:df70:3a48
 with SMTP id ca18e2360f4ac-945c9841230mr147217139f.10.1761686465936; Tue, 28
 Oct 2025 14:21:05 -0700 (PDT)
Date: Tue, 28 Oct 2025 21:20:37 +0000
In-Reply-To: <20251028212052.200523-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028212052.200523-1-sagis@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028212052.200523-12-sagis@google.com>
Subject: [PATCH v12 11/23] KVM: selftests: Set up TDX boot parameters region
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Allocate memory for TDX boot parameters and define the utility functions
necessary to fill this memory with the boot parameters.

Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>

---------------------------------------------

Changes from v10:
 * Removed code for setting up X86_CR4_OSXMMEXCPT bit. At least for now
   it is not needed and the test pass without it.
---
 .../selftests/kvm/include/x86/tdx/tdx_util.h  |  4 ++
 .../selftests/kvm/lib/x86/tdx/tdx_util.c      | 72 +++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
index ec05bcd59145..dafdc7e46abe 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
@@ -12,5 +12,9 @@ static inline bool is_tdx_vm(struct kvm_vm *vm)
 }
 
 void vm_tdx_setup_boot_code_region(struct kvm_vm *vm);
+void vm_tdx_setup_boot_parameters_region(struct kvm_vm *vm, uint32_t nr_runnable_vcpus);
+void vm_tdx_load_common_boot_parameters(struct kvm_vm *vm);
+void vm_tdx_load_vcpu_boot_parameters(struct kvm_vm *vm, struct kvm_vcpu *vcpu);
+void vm_tdx_set_vcpu_entry_point(struct kvm_vcpu *vcpu, void *guest_code);
 
 #endif // SELFTESTS_TDX_TDX_UTIL_H
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
index a1cf12de9d56..f3b69923e928 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -5,10 +5,12 @@
 #include "kvm_util.h"
 #include "processor.h"
 #include "tdx/td_boot.h"
+#include "tdx/td_boot_asm.h"
 #include "tdx/tdx_util.h"
 
 /* Arbitrarily selected to avoid overlaps with anything else */
 #define TD_BOOT_CODE_SLOT	20
+#define TD_BOOT_PARAMETERS_SLOT	21
 
 #define X86_RESET_VECTOR	0xfffffff0ul
 #define X86_RESET_VECTOR_SIZE	16
@@ -52,3 +54,73 @@ void vm_tdx_setup_boot_code_region(struct kvm_vm *vm)
 	hva[1] = 256 - 2 - TD_BOOT_CODE_SIZE;
 	hva[2] = 0xcc;
 }
+
+void vm_tdx_setup_boot_parameters_region(struct kvm_vm *vm, uint32_t nr_runnable_vcpus)
+{
+	size_t boot_params_size =
+		sizeof(struct td_boot_parameters) +
+		nr_runnable_vcpus * sizeof(struct td_per_vcpu_parameters);
+	int npages = DIV_ROUND_UP(boot_params_size, PAGE_SIZE);
+	vm_paddr_t gpa;
+
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
+				    TD_BOOT_PARAMETERS_GPA,
+				    TD_BOOT_PARAMETERS_SLOT, npages,
+				    KVM_MEM_GUEST_MEMFD);
+	gpa = vm_phy_pages_alloc(vm, npages, TD_BOOT_PARAMETERS_GPA, TD_BOOT_PARAMETERS_SLOT);
+	TEST_ASSERT(gpa == TD_BOOT_PARAMETERS_GPA, "Failed vm_phy_pages_alloc\n");
+
+	virt_map(vm, TD_BOOT_PARAMETERS_GPA, TD_BOOT_PARAMETERS_GPA, npages);
+}
+
+void vm_tdx_load_common_boot_parameters(struct kvm_vm *vm)
+{
+	struct td_boot_parameters *params =
+		addr_gpa2hva(vm, TD_BOOT_PARAMETERS_GPA);
+	uint32_t cr4;
+
+	TEST_ASSERT_EQ(vm->mode, VM_MODE_PXXV48_4K);
+
+	cr4 = kvm_get_default_cr4();
+
+	/* TDX spec 11.6.2: CR4 bit MCE is fixed to 1 */
+	cr4 |= X86_CR4_MCE;
+
+	/* TDX spec 11.6.2: CR4 bit VMXE and SMXE are fixed to 0 */
+	cr4 &= ~(X86_CR4_VMXE | X86_CR4_SMXE);
+
+	/* Set parameters! */
+	params->cr0 = kvm_get_default_cr0();
+	params->cr3 = vm->pgd;
+	params->cr4 = cr4;
+	params->idtr.base = vm->arch.idt;
+	params->idtr.limit = kvm_get_default_idt_limit();
+	params->gdtr.base = vm->arch.gdt;
+	params->gdtr.limit = kvm_get_default_gdt_limit();
+
+	TEST_ASSERT(params->cr0 != 0, "cr0 should not be 0");
+	TEST_ASSERT(params->cr3 != 0, "cr3 should not be 0");
+	TEST_ASSERT(params->cr4 != 0, "cr4 should not be 0");
+	TEST_ASSERT(params->gdtr.base != 0, "gdt base address should not be 0");
+	TEST_ASSERT(params->idtr.base != 0, "idt base address should not be 0");
+}
+
+void vm_tdx_load_vcpu_boot_parameters(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
+{
+	struct td_boot_parameters *params =
+		addr_gpa2hva(vm, TD_BOOT_PARAMETERS_GPA);
+	struct td_per_vcpu_parameters *vcpu_params =
+		&params->per_vcpu[vcpu->id];
+
+	vcpu_params->esp_gva = kvm_allocate_vcpu_stack(vm);
+}
+
+void vm_tdx_set_vcpu_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
+{
+	struct td_boot_parameters *params =
+		addr_gpa2hva(vcpu->vm, TD_BOOT_PARAMETERS_GPA);
+	struct td_per_vcpu_parameters *vcpu_params =
+		&params->per_vcpu[vcpu->id];
+
+	vcpu_params->guest_code = (uint64_t)guest_code;
+}
-- 
2.51.1.851.g4ebd6896fd-goog


