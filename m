Return-Path: <linux-kselftest+bounces-1746-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 722B380F858
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 21:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 954CE1C20BB8
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 20:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB53B6415E;
	Tue, 12 Dec 2023 20:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bLhz0Old"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035EB1BCC
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 12:47:41 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db547d41413so4876943276.0
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 12:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702414061; x=1703018861; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VQXzt/ExaOzeKgYGP3AjD06mEvm7Zdsq1Ks/qnyB1N0=;
        b=bLhz0OldT3Kke659UhCAWIDdEV6os50qtSkScCt+tZuVveOUZeRh9OrhTnNUQEDeGW
         P51PuJJNRjytN3FeWTqZPDtXRL25rwUhbvXEZI24VVp3na9juMVgwCfZcZTwlBqJTz8f
         7QAOyVsLLoRJlSTYCD+af+gkm5LnXyUs1EzwXQW4Oi65A0/IlPthGfDkI62RxMTfNYaQ
         emW4/G+PTOpZjx17CGFGlD1y65yA6tWBCTdSHTvSGMYNCgBejg8/AqVQPyJWnsnPystI
         VG3/m8n2UGCuaidSn5jZgMP+Lpq+jQNJA2J0fAdcHLG9/4ceB725mW2Z/P9+SHEyGNUY
         x0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702414061; x=1703018861;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VQXzt/ExaOzeKgYGP3AjD06mEvm7Zdsq1Ks/qnyB1N0=;
        b=QlA+Kp8kiUpU2r6O1/0bi5mXneO6ndnJ0giBNkAU6dxFxIGPnXguc7Pqg6o1mnOKV1
         Vtm7Uz7yS1nk1ySBtX5cEIv65XDgccDAqU/TW4hPEiKPtg4SAuAVN+klLSVy//u90FLg
         5YIhNTHcumjRsVpW4ukPzo/2PgRLqUx7+Lt5xE5830Fq18C8VG9/xmWcdQcPAf6lTQms
         Zle+uRSH3Xbpr1/Dmq8SNpTJblQKydoDoFJ4x1RJTLSC+5gtJjPyt4RKcWhOq/ITpZ0q
         ViDIDaM+jTgtYGG7sgI/KhinCYractb5f4OhCaQwS1QPzzkABqlzgpi2mHNeqRmHU1/Q
         923g==
X-Gm-Message-State: AOJu0Yxmc8twDGr6YVVJkrcbEtfOwCrxxyY6Z8tDu7RAJU3UgbPrvmxd
	W97fPxokraCEfJkYl0AuBsg16DC2wxiZI9cuShVQCL3hcQcQhRo3frp5Vm0vhjHkipX76SI6a79
	gWzNKpifWQG3l/BwKPUU3aa/ifdjEszbz2hTxftg8hY69Hqs8imANL3SsEb1483CiezeRMxY=
X-Google-Smtp-Source: AGHT+IGAWhnJ2zU5fkLTfsdPcz3icYSOWux8a19R6p37qgvN+KI3LjdJGCokxJZe2S1fKOxj9G+gkRyV5A==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a25:8150:0:b0:dbc:66ea:455 with SMTP id
 j16-20020a258150000000b00dbc66ea0455mr88876ybm.6.1702414060312; Tue, 12 Dec
 2023 12:47:40 -0800 (PST)
Date: Tue, 12 Dec 2023 12:46:38 -0800
In-Reply-To: <20231212204647.2170650-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231212204647.2170650-1-sagis@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231212204647.2170650-24-sagis@google.com>
Subject: [RFC PATCH v5 23/29] KVM: selftests: TDX: Add shared memory test
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>, 
	Ryan Afranji <afranji@google.com>, Erdem Aktas <erdemaktas@google.com>, 
	Sagi Shahar <sagis@google.com>, Isaku Yamahata <isaku.yamahata@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Peter Gonda <pgonda@google.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Roger Wang <runanwang@google.com>, Vipin Sharma <vipinsh@google.com>, jmattson@google.com, 
	dmatlack@google.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

From: Ryan Afranji <afranji@google.com>

Adds a test that sets up shared memory between the host and guest.

Signed-off-by: Ryan Afranji <afranji@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/include/x86_64/tdx/tdx.h    |   2 +
 .../kvm/include/x86_64/tdx/tdx_util.h         |   2 +
 .../selftests/kvm/lib/x86_64/tdx/tdx.c        |  26 ++++
 .../selftests/kvm/lib/x86_64/tdx/tdx_util.c   |  25 ++++
 .../kvm/x86_64/tdx_shared_mem_test.c          | 135 ++++++++++++++++++
 6 files changed, 191 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/tdx_shared_mem_test.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 80d4a50eeb9f..8c0a6b395ee5 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -156,6 +156,7 @@ TEST_GEN_PROGS_x86_64 += steal_time
 TEST_GEN_PROGS_x86_64 += kvm_binary_stats_test
 TEST_GEN_PROGS_x86_64 += system_counter_offset_test
 TEST_GEN_PROGS_x86_64 += x86_64/tdx_vm_tests
+TEST_GEN_PROGS_x86_64 += x86_64/tdx_shared_mem_test
 
 # Compiled outputs used by test targets
 TEST_GEN_PROGS_EXTENDED_x86_64 += x86_64/nx_huge_pages_test
diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
index 6b176de1e795..db4cc62abb5d 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
@@ -8,6 +8,7 @@
 #define TDG_VP_INFO 1
 
 #define TDG_VP_VMCALL_GET_TD_VM_CALL_INFO 0x10000
+#define TDG_VP_VMCALL_MAP_GPA 0x10001
 #define TDG_VP_VMCALL_REPORT_FATAL_ERROR 0x10003
 
 #define TDG_VP_VMCALL_INSTRUCTION_CPUID 10
@@ -36,5 +37,6 @@ uint64_t tdg_vp_vmcall_instruction_cpuid(uint32_t eax, uint32_t ecx,
 uint64_t tdg_vp_info(uint64_t *rcx, uint64_t *rdx,
 		     uint64_t *r8, uint64_t *r9,
 		     uint64_t *r10, uint64_t *r11);
+uint64_t tdg_vp_vmcall_map_gpa(uint64_t address, uint64_t size, uint64_t *data_out);
 
 #endif // SELFTEST_TDX_TDX_H
diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx_util.h
index 32dd6b8fda46..3e850ecb85a6 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx_util.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx_util.h
@@ -13,5 +13,7 @@ void td_initialize(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 		   uint64_t attributes);
 void td_finalize(struct kvm_vm *vm);
 void td_vcpu_run(struct kvm_vcpu *vcpu);
+void handle_memory_conversion(struct kvm_vm *vm, uint64_t gpa, uint64_t size,
+			bool shared_to_private);
 
 #endif // SELFTESTS_TDX_KVM_UTIL_H
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
index bcd9cceb3372..061a5c0bef34 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
@@ -4,9 +4,11 @@
 
 #include "tdx/tdcall.h"
 #include "tdx/tdx.h"
+#include "tdx/tdx_util.h"
 
 void handle_userspace_tdg_vp_vmcall_exit(struct kvm_vcpu *vcpu)
 {
+	struct kvm_vm *vm = vcpu->vm;
 	struct kvm_tdx_vmcall *vmcall_info = &vcpu->run->tdx.u.vmcall;
 	uint64_t vmcall_subfunction = vmcall_info->subfunction;
 
@@ -20,6 +22,14 @@ void handle_userspace_tdg_vp_vmcall_exit(struct kvm_vcpu *vcpu)
 		vcpu->run->system_event.data[2] = vmcall_info->in_r13;
 		vmcall_info->status_code = 0;
 		break;
+	case TDG_VP_VMCALL_MAP_GPA:
+		uint64_t gpa = vmcall_info->in_r12 & ~vm->arch.s_bit;
+		bool shared_to_private = !(vm->arch.s_bit &
+					   vmcall_info->in_r12);
+		handle_memory_conversion(vm, gpa, vmcall_info->in_r13,
+					 shared_to_private);
+		vmcall_info->status_code = 0;
+		break;
 	default:
 		TEST_FAIL("TD VMCALL subfunction %lu is unsupported.\n",
 			  vmcall_subfunction);
@@ -210,3 +220,19 @@ uint64_t tdg_vp_info(uint64_t *rcx, uint64_t *rdx,
 
 	return ret;
 }
+
+uint64_t tdg_vp_vmcall_map_gpa(uint64_t address, uint64_t size, uint64_t *data_out)
+{
+	uint64_t ret;
+	struct tdx_hypercall_args args = {
+		.r11 = TDG_VP_VMCALL_MAP_GPA,
+		.r12 = address,
+		.r13 = size
+	};
+
+	ret = __tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT);
+
+	if (data_out)
+		*data_out = args.r11;
+	return ret;
+}
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
index d745bb6287c1..92fa6bd13229 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
@@ -531,3 +531,28 @@ void td_vcpu_run(struct kvm_vcpu *vcpu)
 		handle_userspace_tdg_vp_vmcall_exit(vcpu);
 	}
 }
+
+/**
+ * Handle conversion of memory with @size beginning @gpa for @vm. Set
+ * @shared_to_private to true for shared to private conversions and false
+ * otherwise.
+ *
+ * Since this is just for selftests, we will just keep both pieces of backing
+ * memory allocated and not deallocate/allocate memory; we'll just do the
+ * minimum of calling KVM_MEMORY_ENCRYPT_REG_REGION and
+ * KVM_MEMORY_ENCRYPT_UNREG_REGION.
+ */
+void handle_memory_conversion(struct kvm_vm *vm, uint64_t gpa, uint64_t size,
+			bool shared_to_private)
+{
+	struct kvm_memory_attributes range;
+
+	range.address = gpa;
+	range.size = size;
+	range.attributes = shared_to_private ? KVM_MEMORY_ATTRIBUTE_PRIVATE : 0;
+	range.flags = 0;
+
+	printf("\t ... calling KVM_SET_MEMORY_ATTRIBUTES ioctl with gpa=%#lx, size=%#lx, attributes=%#llx\n", gpa, size, range.attributes);
+
+	vm_ioctl(vm, KVM_SET_MEMORY_ATTRIBUTES, &range);
+}
diff --git a/tools/testing/selftests/kvm/x86_64/tdx_shared_mem_test.c b/tools/testing/selftests/kvm/x86_64/tdx_shared_mem_test.c
new file mode 100644
index 000000000000..ba6bdc470270
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/tdx_shared_mem_test.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/kvm.h>
+#include <stdint.h>
+
+#include "kvm_util_base.h"
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
+ * Shared variables between guest and host
+ */
+static uint64_t test_mem_private_gpa;
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
+					   TDG_VP_VMCALL_INSTRUCTION_IO_WRITE,
+					   &placeholder);
+	if (ret)
+		tdx_test_fatal_with_data(ret, __LINE__);
+
+	/* Read value written by host and send it back out for verification */
+	ret = tdg_vp_vmcall_instruction_io(TDX_SHARED_MEM_TEST_INFO_PORT, 4,
+					   TDG_VP_VMCALL_INSTRUCTION_IO_WRITE,
+					   (uint64_t *)test_mem_shared_gva);
+	if (ret)
+		tdx_test_fatal_with_data(ret, __LINE__);
+}
+
+int verify_shared_mem(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+
+	vm_vaddr_t test_mem_private_gva;
+	uint32_t *test_mem_hva;
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
+	TEST_ASSERT(test_mem_hva != NULL,
+		    "Guest address not found in guest memory regions\n");
+
+	test_mem_private_gpa = addr_gva2gpa(vm, test_mem_private_gva);
+	virt_pg_map_shared(vm, TDX_SHARED_MEM_TEST_SHARED_GVA,
+			   test_mem_private_gpa);
+
+	test_mem_shared_gpa = test_mem_private_gpa | BIT_ULL(vm->pa_bits - 1);
+	sync_global_to_guest(vm, test_mem_private_gpa);
+	sync_global_to_guest(vm, test_mem_shared_gpa);
+
+	td_finalize(vm);
+
+	printf("Verifying shared memory accesses for TDX\n");
+
+	/* Begin guest execution; guest writes to shared memory. */
+	printf("\t ... Starting guest execution\n");
+
+	/* Handle map gpa as shared */
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_SHARED_MEM_TEST_INFO_PORT, 4,
+			   TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
+	TEST_ASSERT_EQ(*test_mem_hva, TDX_SHARED_MEM_TEST_GUEST_WRITE_VALUE);
+
+	*test_mem_hva = TDX_SHARED_MEM_TEST_HOST_WRITE_VALUE;
+	td_vcpu_run(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_SHARED_MEM_TEST_INFO_PORT, 4,
+			   TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
+	TEST_ASSERT_EQ(
+		*(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset),
+		TDX_SHARED_MEM_TEST_HOST_WRITE_VALUE);
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
2.43.0.472.g3155946c3a-goog


