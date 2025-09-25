Return-Path: <linux-kselftest+bounces-42377-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A12BBA0DD0
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 19:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41AD61C21227
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 17:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC2531BCAA;
	Thu, 25 Sep 2025 17:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a157fuen"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14807313260
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 17:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821359; cv=none; b=HC04ORMgIePPChrSrQyF0ez8j83woDLpOG+9fLs8YNKu4dEpvotYyQF1s1fhfXuzbHg7zVLlV90b4MFIYv6T90JUkkVx5CjOILspOb4T830mGagHjeZkCSjD6fxa1jOCPpZYH91Fb4PoUCxKt8Vrr5eQ3edN9UZOh/wzO2xvTkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821359; c=relaxed/simple;
	bh=Bu94ep6LXVCBGk9mhGFiOfvC3iFU5bTCmLww/QF+Y0w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GZnGORuRVc87GhtDKsMmtrAzM4e8J823C91Ba5dd0lzmgEdy6LznnjzOpLEDtydfhZpHTpjmSLnaBf8qrIQUu1AghTWqzLN6gy2GJwinZypBUlqfwJ+4N5CPnvf4eTN9DQv3aNaEyFO+2WIe8+EjEIdpT0TF/7b4MpLF9/M+C7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a157fuen; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b552f91033cso1607505a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 10:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758821356; x=1759426156; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+dlLssYObMpDc3Mig0BnX1nAYbBtGHYEAQU3DA8pmFQ=;
        b=a157fuenyUnGcWey9HMUtsceb49OOctA1xOEjoRKrG3L/uf4LqLE0kfOQL83L/ilkv
         xXXaH5BYv0keQ+offAgB2ziw209O3gykypDj/401xRBdtA3isq9GfO/EOFPBRE/D8Imh
         Kh4VQKoYoXwPiPTQLc18KkWBgQsT4ozDV0yNRZEEjTG7pdbkSygqLhqDvujwDHG/IlfG
         eNcESJoeYexTN62M5YzEyk5niu4IqW0GjAjBx7jDUFjYjary4f78zaywmnQ2P5Vdq2s2
         iVjU3jdxgwRZcDIVmObfW87zcACE/TYBJ5vGIEOAVzjL55TkkQy2oJaJBQjh1a5+OspU
         rROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758821356; x=1759426156;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+dlLssYObMpDc3Mig0BnX1nAYbBtGHYEAQU3DA8pmFQ=;
        b=Hx6maplVAZ4bXalUuuOkY1ov6kZNNcM7aaVgcyE2uCzySWFxPQxgZh4CJFHXY3cLyJ
         SJwrc0tMnGKzNTe8XP4NmIB49uwGGNvp0u2DILnjo87OxmdaPhVq5niMvoNoM5/Z+rtO
         LD3XS92c40XMABznmwBP1pzmBejebkjpJ0fje+l22DjwKEsvuoA3pP2g7QHo8aL2ALN/
         MQ/gJ4du2oo1ueACXhAVoat5PZ4eNMt/i6H8XuY9AEksQR607b5M/aT8RLbH3MisqoMW
         A2ld/pWSWDbsEXBkTdTYzI3/o0iplDLSlPVgfHqx339gvfHmuDo3hQgGTywtEw3bKAg3
         E23Q==
X-Gm-Message-State: AOJu0Yw+EG+GeRGCwMy5ErtnA5YjDLHoSivOROKs9QeWgZLeleB1Jv3D
	4fSWomXkgmgWIwWtIr0/su+GyJIImuOim8Dv03WDt8tb8YAwypOVIPP3iHWPBreh6qps764unq5
	FmUsKj4Z77j4AtQDTty0TPl9grTuDpMqeYe68PMotdwYyO9KKa2UkK19fdYSj7xmMFl9z/jFAkn
	0yLyc91T/U+Akix8zi13Y7pFzx73uy9MFvK6SFeBYxCn8=
X-Google-Smtp-Source: AGHT+IE73CoIJzyKmVA8thi2OhWNCikU0g0L+pUzECN/cCGBVKYk3F06bo+KSf76r+1vZuQUYCZQe/QjcA==
X-Received: from pfbkh3.prod.google.com ([2002:a05:6a00:9443:b0:772:749b:de38])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:244e:b0:24e:84c9:e986
 with SMTP id adf61e73a8af0-2e7c79c5ac6mr5667587637.15.1758821356049; Thu, 25
 Sep 2025 10:29:16 -0700 (PDT)
Date: Thu, 25 Sep 2025 10:28:38 -0700
In-Reply-To: <20250925172851.606193-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250925172851.606193-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250925172851.606193-11-sagis@google.com>
Subject: [PATCH v11 10/21] KVM: selftests: Set up TDX boot parameters region
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
2.51.0.536.g15c5d4f767-goog


