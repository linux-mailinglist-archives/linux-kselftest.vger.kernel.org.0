Return-Path: <linux-kselftest+bounces-38519-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5298CB1DE1C
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 22:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE95D3AA4A8
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 20:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7EC280CC1;
	Thu,  7 Aug 2025 20:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R1X7Uczk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1761027FD7C
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Aug 2025 20:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754597837; cv=none; b=WxF6/lwMFlCkTwOnBD84xkxAQ7M9dsUv3RuWOsRDUIKVToaIPLFX1OGhyRW2Cn7FmYJcP3kz//5VrX39/YxtB/9rFO07pF1LShcEOn36OtjzriGKElqwrT/njg8lpKbTsuDWaCBhJNc59PXriFIRAiqBKhYP/YJiyYbKwBSLoFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754597837; c=relaxed/simple;
	bh=CFukzjZq/1pgwTOu4oDAaQDChh7pnujoWzTOhp2nE4k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K8S3gb6HafeJm8GRCAUaP0/n0rII4Nknd7QM3lrlggSGCnUyeKdcxEg76h8rXd65k53AW1xusdHDWho2VKkr479rwpv2Nd9ERywDVkmkdbgSgCEwwKZNqLdApoTPt567MaAUVz02DXp+Nls7T6PPZ8x5KVjAngaweigUhj5iCqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R1X7Uczk; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b3928ad6176so1180077a12.3
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Aug 2025 13:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754597834; x=1755202634; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j1U4zqJkCnUTzEIFqbPfzhS8WqwxaoFKWnc0WvJH/fI=;
        b=R1X7UczkLyj3Esm/Hy706lh5WPckLPvm+LImPsA4nYxMq0ZVNdCiw0puEn2no2osat
         xurpj8l9qb2yX59b0c0hCJQYUVziIDvblpzJg+JNZaUkfGMTEveWLuP8b4Li1QBJBpQl
         N4GpTsTfR473EkFyEDAuQ57qK6o1K+p7nC1M/JKvfKjPuwWxz8GuG1dgP60wjkneyXRH
         sKZMUQ1pjjlfMEcwYOlXBP7kfK7LzWKKEWBPH4srw1BooNYsTiFe71cASm7IOs4fK/KE
         1eKuYoAGtVO2JuVA6mhzR1/LxSiqqowKkKwzCuxvWWxzQx9FWaK9cU+PogzhrvrWoAVJ
         oHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754597834; x=1755202634;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j1U4zqJkCnUTzEIFqbPfzhS8WqwxaoFKWnc0WvJH/fI=;
        b=Cz7TSHyBXe2NuNWAfKIBY5GFBMbATvURUl/C7O18dcKxK9ZR29aR8DcPcm8Kn4IulF
         5rJDYMFoYvswgAoSMg//CuGAbZb1vkdsaCYrpewAZox2acD3DhT5b5ZONb66FbG8LS9m
         xs6IeRFR5Um992US21+gNNy03OGDsP2SdjYhmtnbCg5MkNtD2nOs4AQM18lX/uOyFT8R
         xNVYPj9I4BzyltDVu3+1IMqF1T7b9Uk4a9wNbEzx9l6SlAP9KLcc/2w21p+mQ+0n/Vsu
         tleJBPbDPW/U4EweSA4GCs5fu8uMiC61lqObfCV6hjcMRsngZu4cX43hEwFso/vMC/B+
         K/FA==
X-Gm-Message-State: AOJu0YxnA1wGxa6CEGGS7o0dG7nGBZV8g7MlLQEfSbmYIsF66JPvp7SY
	acna4f4k11iU5P2wbBU0CknLdXIA8UViyyCfshtKFjYtpAxta82ahsD+Ekq7z2dem/FfINwClWL
	ADUndaIdw/RSzzXK42yQxMhQ+KWEYnxb5ZGJArQIBHU83LeIvwAXoxzdUuCxJxbItNrBIm1D7/P
	9HpvGVRVjEMNaTZvZPWYLr59iePlMwDyGouoxl4oy+678=
X-Google-Smtp-Source: AGHT+IEPsLciEJiNH2hoU3Se3hluI14HHOYMagza7uQX3fjQnAy/LHEhFb4uM748Ovvqjw/ve/fcvyIkrA==
X-Received: from pjqf9.prod.google.com ([2002:a17:90a:a789:b0:312:e914:4548])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2b4f:b0:31f:335d:3424
 with SMTP id 98e67ed59e1d1-32183c481d4mr457672a91.27.1754597834136; Thu, 07
 Aug 2025 13:17:14 -0700 (PDT)
Date: Thu,  7 Aug 2025 13:16:20 -0700
In-Reply-To: <20250807201628.1185915-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250807201628.1185915-25-sagis@google.com>
Subject: [PATCH v8 24/30] KVM: selftests: TDX: Add shared memory test
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ryan Afranji <afranji@google.com>

Test that host and guest can exchange data via shared memory.

Set up shared memory by first allocating as private and then mapping
the same GPA as shared. The guest starts with a request to map a
page of memory to shared. This request is done via a hypercall
(TDG.VP.VMCALL<MapGPA>) from the guest that the kernel converts to
KVM_EXIT_HYPERCALL with KVM_HC_MAP_GPA_RANGE that is sent back to the
test for handling.  Handle the guest's request using the
KVM_SET_MEMORY_ATTRIBUTES ioctl().

After the shared memory is set up the guest writes to it and notifies the
host from where the data is verified. In return, the host writes to the
same memory that is verified by the guest.

Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/include/x86/tdx/tdx.h       |   4 +
 .../selftests/kvm/include/x86/tdx/tdx_util.h  |   2 +
 tools/testing/selftests/kvm/lib/x86/tdx/tdx.c |  26 ++++
 .../selftests/kvm/lib/x86/tdx/tdx_util.c      |  32 +++++
 .../selftests/kvm/x86/tdx_shared_mem_test.c   | 129 ++++++++++++++++++
 6 files changed, 194 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/tdx_shared_mem_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 4a147d498bd2..bdeb40a258e1 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -152,6 +152,7 @@ TEST_GEN_PROGS_x86 += steal_time
 TEST_GEN_PROGS_x86 += system_counter_offset_test
 TEST_GEN_PROGS_x86 += pre_fault_memory_test
 TEST_GEN_PROGS_x86 += x86/tdx_vm_test
+TEST_GEN_PROGS_x86 += x86/tdx_shared_mem_test
 
 # Compiled outputs used by test targets
 TEST_GEN_PROGS_EXTENDED_x86 += x86/nx_huge_pages_test
diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
index 801ca879664e..88f3571df16f 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
@@ -9,6 +9,7 @@
 #define TDG_VP_INFO 1
 
 #define TDG_VP_VMCALL_GET_TD_VM_CALL_INFO 0x10000
+#define TDG_VP_VMCALL_MAP_GPA 0x10001
 #define TDG_VP_VMCALL_REPORT_FATAL_ERROR 0x10003
 
 #define TDG_VP_VMCALL_INSTRUCTION_CPUID 10
@@ -18,6 +19,8 @@
 #define TDG_VP_VMCALL_INSTRUCTION_WRMSR 32
 #define TDG_VP_VMCALL_VE_REQUEST_MMIO 48
 
+void handle_userspace_map_gpa(struct kvm_vcpu *vcpu);
+
 uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
 				      uint64_t write, uint64_t *data);
 void tdg_vp_vmcall_report_fatal_error(uint64_t error_code, uint64_t data_gpa);
@@ -36,5 +39,6 @@ uint64_t tdg_vp_vmcall_instruction_cpuid(uint32_t eax, uint32_t ecx,
 uint64_t tdg_vp_info(uint64_t *rcx, uint64_t *rdx,
 		     uint64_t *r8, uint64_t *r9,
 		     uint64_t *r10, uint64_t *r11);
+uint64_t tdg_vp_vmcall_map_gpa(uint64_t address, uint64_t size, uint64_t *data_out);
 
 #endif // SELFTEST_TDX_TDX_H
diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
index c942aec7ad26..ae39b78aa4af 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
@@ -17,5 +17,7 @@ void td_initialize(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 		   uint64_t attributes);
 void td_finalize(struct kvm_vm *vm);
 void td_vcpu_run(struct kvm_vcpu *vcpu);
+void handle_memory_conversion(struct kvm_vm *vm, uint32_t vcpu_id, uint64_t gpa,
+			      uint64_t size, bool shared_to_private);
 
 #endif // SELFTESTS_TDX_KVM_UTIL_H
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
index ab6fd3d7ae4b..bae84c34c19e 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
@@ -1,11 +1,21 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/kvm_para.h>
 #include <string.h>
 
 #include "tdx/tdcall.h"
 #include "tdx/tdx.h"
+#include "tdx/tdx_util.h"
 #include "tdx/test_util.h"
 
+void handle_userspace_map_gpa(struct kvm_vcpu *vcpu)
+{
+	handle_memory_conversion(vcpu->vm, vcpu->id, vcpu->run->hypercall.args[0],
+				 vcpu->run->hypercall.args[1] << 12,
+				 vcpu->run->hypercall.args[2] & KVM_MAP_GPA_RANGE_ENCRYPTED);
+	vcpu->run->hypercall.ret = 0;
+}
+
 uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
 				      uint64_t write, uint64_t *data)
 {
@@ -189,3 +199,19 @@ uint64_t tdg_vp_info(uint64_t *rcx, uint64_t *rdx,
 
 	return ret;
 }
+
+uint64_t tdg_vp_vmcall_map_gpa(uint64_t address, uint64_t size, uint64_t *data_out)
+{
+	struct tdx_hypercall_args args = {
+		.r11 = TDG_VP_VMCALL_MAP_GPA,
+		.r12 = address,
+		.r13 = size
+	};
+	uint64_t ret;
+
+	ret = __tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT);
+
+	if (data_out)
+		*data_out = args.r11;
+	return ret;
+}
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
index 5e4455be828a..c5bee67099c5 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -608,4 +608,36 @@ void td_finalize(struct kvm_vm *vm)
 void td_vcpu_run(struct kvm_vcpu *vcpu)
 {
 	vcpu_run(vcpu);
+
+	/* Handle TD VMCALLs that require userspace handling. */
+	if (vcpu->run->exit_reason == KVM_EXIT_HYPERCALL &&
+	    vcpu->run->hypercall.nr == KVM_HC_MAP_GPA_RANGE) {
+		handle_userspace_map_gpa(vcpu);
+	}
+}
+
+/*
+ * Handle conversion of memory with @size beginning @gpa for @vm. Set
+ * @shared_to_private to true for shared to private conversions and false
+ * otherwise.
+ *
+ * Since this is just for selftests, just keep both pieces of backing
+ * memory allocated and not deallocate/allocate memory; just do the
+ * minimum of calling KVM_MEMORY_ENCRYPT_REG_REGION and
+ * KVM_MEMORY_ENCRYPT_UNREG_REGION.
+ */
+void handle_memory_conversion(struct kvm_vm *vm, uint32_t vcpu_id, uint64_t gpa,
+			      uint64_t size, bool shared_to_private)
+{
+	struct kvm_memory_attributes range;
+
+	range.address = gpa;
+	range.size = size;
+	range.attributes = shared_to_private ? KVM_MEMORY_ATTRIBUTE_PRIVATE : 0;
+	range.flags = 0;
+
+	pr_debug("\t... call KVM_SET_MEMORY_ATTRIBUTES ioctl from vCPU %u with gpa=%#lx, size=%#lx, attributes=%#llx\n",
+		 vcpu_id, gpa, size, range.attributes);
+
+	vm_ioctl(vm, KVM_SET_MEMORY_ATTRIBUTES, &range);
 }
diff --git a/tools/testing/selftests/kvm/x86/tdx_shared_mem_test.c b/tools/testing/selftests/kvm/x86/tdx_shared_mem_test.c
new file mode 100644
index 000000000000..79745e36ce3a
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/tdx_shared_mem_test.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/kvm.h>
+#include <stdint.h>
+
+#include "kvm_util.h"
+#include "processor.h"
+#include "tdx/tdcall.h"
+#include "tdx/tdx.h"
+#include "tdx/tdx_util.h"
+#include "tdx/test_util.h"
+#include "test_util.h"
+
+#define TDX_SHARED_MEM_TEST_PRIVATE_GVA (0x80000000)
+#define TDX_SHARED_MEM_TEST_VADDR_SHARED_MASK BIT_ULL(30)
+#define TDX_SHARED_MEM_TEST_SHARED_GVA     \
+	(TDX_SHARED_MEM_TEST_PRIVATE_GVA | \
+	 TDX_SHARED_MEM_TEST_VADDR_SHARED_MASK)
+
+#define TDX_SHARED_MEM_TEST_GUEST_WRITE_VALUE (0xcafecafe)
+#define TDX_SHARED_MEM_TEST_HOST_WRITE_VALUE (0xabcdabcd)
+
+#define TDX_SHARED_MEM_TEST_INFO_PORT 0x87
+
+/*
+ * Shared variable between guest and host
+ */
+static uint64_t test_mem_shared_gpa;
+
+void guest_shared_mem(void)
+{
+	uint32_t *test_mem_shared_gva =
+		(uint32_t *)TDX_SHARED_MEM_TEST_SHARED_GVA;
+
+	uint64_t placeholder;
+	uint64_t ret;
+
+	/* Map gpa as shared */
+	ret = tdg_vp_vmcall_map_gpa(test_mem_shared_gpa, PAGE_SIZE,
+				    &placeholder);
+	if (ret)
+		tdx_test_fatal_with_data(ret, __LINE__);
+
+	*test_mem_shared_gva = TDX_SHARED_MEM_TEST_GUEST_WRITE_VALUE;
+
+	/* Exit so host can read shared value */
+	ret = tdg_vp_vmcall_instruction_io(TDX_SHARED_MEM_TEST_INFO_PORT, 4,
+					   PORT_WRITE, &placeholder);
+	if (ret)
+		tdx_test_fatal_with_data(ret, __LINE__);
+
+	/* Read value written by host and send it back out for verification */
+	ret = tdg_vp_vmcall_instruction_io(TDX_SHARED_MEM_TEST_INFO_PORT, 4,
+					   PORT_WRITE,
+					   (uint64_t *)test_mem_shared_gva);
+	if (ret)
+		tdx_test_fatal_with_data(ret, __LINE__);
+}
+
+int verify_shared_mem(void)
+{
+	vm_vaddr_t test_mem_private_gva;
+	uint64_t test_mem_private_gpa;
+	uint32_t *test_mem_hva;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+	vcpu = td_vcpu_add(vm, 0, guest_shared_mem);
+
+	/*
+	 * Set up shared memory page for testing by first allocating as private
+	 * and then mapping the same GPA again as shared. This way, the TD does
+	 * not have to remap its page tables at runtime.
+	 */
+	test_mem_private_gva = vm_vaddr_alloc(vm, vm->page_size,
+					      TDX_SHARED_MEM_TEST_PRIVATE_GVA);
+	TEST_ASSERT_EQ(test_mem_private_gva, TDX_SHARED_MEM_TEST_PRIVATE_GVA);
+
+	test_mem_hva = addr_gva2hva(vm, test_mem_private_gva);
+	TEST_ASSERT(test_mem_hva,
+		    "Guest address not found in guest memory regions\n");
+
+	test_mem_private_gpa = addr_gva2gpa(vm, test_mem_private_gva);
+	virt_map_shared(vm, TDX_SHARED_MEM_TEST_SHARED_GVA, test_mem_private_gpa, 1);
+
+	test_mem_shared_gpa = test_mem_private_gpa | vm->arch.s_bit;
+	sync_global_to_guest(vm, test_mem_shared_gpa);
+
+	td_finalize(vm);
+
+	vm_enable_cap(vm, KVM_CAP_EXIT_HYPERCALL, BIT_ULL(KVM_HC_MAP_GPA_RANGE));
+
+	printf("Verifying shared memory accesses for TDX\n");
+
+	/* Begin guest execution; guest writes to shared memory. */
+	printf("\t ... Starting guest execution\n");
+
+	/* Handle map gpa as shared */
+	tdx_run(vcpu);
+
+	tdx_run(vcpu);
+	tdx_test_assert_io(vcpu, TDX_SHARED_MEM_TEST_INFO_PORT, 4, PORT_WRITE);
+	TEST_ASSERT_EQ(*test_mem_hva, TDX_SHARED_MEM_TEST_GUEST_WRITE_VALUE);
+
+	*test_mem_hva = TDX_SHARED_MEM_TEST_HOST_WRITE_VALUE;
+	tdx_run(vcpu);
+	tdx_test_assert_io(vcpu, TDX_SHARED_MEM_TEST_INFO_PORT, 4, PORT_WRITE);
+	TEST_ASSERT_EQ(*(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset),
+		       TDX_SHARED_MEM_TEST_HOST_WRITE_VALUE);
+
+	printf("\t ... PASSED\n");
+
+	kvm_vm_free(vm);
+
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	if (!is_tdx_enabled()) {
+		printf("TDX is not supported by the KVM\n"
+		       "Skipping the TDX tests.\n");
+		return 0;
+	}
+
+	return verify_shared_mem();
+}
-- 
2.51.0.rc0.155.g4a0f42376b-goog


