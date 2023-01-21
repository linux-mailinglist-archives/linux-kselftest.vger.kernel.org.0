Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C4A67623D
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jan 2023 01:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjAUATh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Jan 2023 19:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjAUATh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Jan 2023 19:19:37 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A6D917C8
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:18:57 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5028c723d28so15762527b3.15
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qgs5pu4Pv7Wf9vNe8L7K5ZmvD76+tBP6dpa2LmoyCUU=;
        b=T4NQVLwp+ULAZcEcdAw57oxiGpFr/RONT531Im2TPN67OLpKTwUfxzgpkZZ8uunSMX
         dkyNSWQ/L7Tu+So5I7wbrkFzVfaW9IuwmY+yYJ7qhgKkvByN0obxXFtnIHEgPL0i2eq3
         pxeBePkZ1l8I89pHNrMgnwBHqoIu/vblkDyBozkoTYEdRBBG/TCOQrvVBmYdEE8Tf9wv
         uYdu7UgfIp9qYPbySTgxB+/J1i2FKhYpbntfaEeg2V4tvmFHzv8sOdlAXRM6V2NcGvmv
         bt2gylOZJ/pfE1OfUAoscnV4B9H2qlJSiU1SlaRdBqlstu/GEr5FfLq7FB0Y9qcmlHMg
         e/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qgs5pu4Pv7Wf9vNe8L7K5ZmvD76+tBP6dpa2LmoyCUU=;
        b=KWrEDGr8ryKnqa2RgBfKgyb0jagc+fwDJK7xx4J+ZNS8XQRXmONIEky/PhVXqCQ3F3
         tu9+/fes0G6ukbQP6UizYh47CezNmLNEqcNVIQ1+IsHip4DxVJRXuZXdjcIBPbZUMeLP
         EliKZBFrITZLsbQdgFiYHFhJVMRTISL60US8ewzy+1yt7KZYySQO6ZGh8yjr8i3qgTlc
         5nSbQyugOJZxx9l9GqpGlcTptbCwKRWBEC0g4YXTgNPkM8/UBzBpwZxovYwg6BxMBXkq
         mETfnATdUUpNgEVXbjQ/1erJl8GFIFyu42R6ZOJzHltDa2L3if7o5lWFY9bi1i+Bgq9P
         CKqg==
X-Gm-Message-State: AFqh2kpQ/YlMrMQHZMgRRmbdmPyntdyYN9r6PpVSj2kqWHXjKA90oxsJ
        brArMJjzgQ2OQeDBmHvr1gxtQjQZ9cLg0224E5+NLA1+/LLxB+P2EUG90rEA2ulhZ6hzc9r+ziW
        r3IsBOx0HcKkdl+UlKxu30/dlTtkOshCtTySNaWbWfQsF+M0L/caZXvi5Tmp5BRI0u6hATxa2rP
        Ey4nmIcQYEMcQ=
X-Google-Smtp-Source: AMrXdXtBuwm+DqlckwCu71vZzLrG1Vgb32MTZndSh1dDwCy2nUyHqG8XU7x+YA1HKtT/8c5uvm3Q7OnQwe0YOQpoyw==
X-Received: from ackerleytng-cloudtop-sg.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:b30])
 (user=ackerleytng job=sendgmr) by 2002:a0d:e786:0:b0:500:b5eb:cdd with SMTP
 id q128-20020a0de786000000b00500b5eb0cddmr446822ywe.95.1674260277278; Fri, 20
 Jan 2023 16:17:57 -0800 (PST)
Date:   Sat, 21 Jan 2023 00:15:35 +0000
In-Reply-To: <20230121001542.2472357-1-ackerleytng@google.com>
Mime-Version: 1.0
References: <20230121001542.2472357-1-ackerleytng@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230121001542.2472357-25-ackerleytng@google.com>
Subject: [RFC PATCH v3 24/31] KVM: selftests: TDX: Add shared memory test
From:   Ackerley Tng <ackerleytng@google.com>
To:     linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, seanjc@google.com, isaku.yamahata@intel.com,
        sagis@google.com, erdemaktas@google.com, afranji@google.com,
        runanwang@google.com, shuah@kernel.org, drjones@redhat.com,
        maz@kernel.org, bgardon@google.com, jmattson@google.com,
        dmatlack@google.com, peterx@redhat.com, oupton@google.com,
        ricarkol@google.com, yang.zhong@intel.com, wei.w.wang@intel.com,
        xiaoyao.li@intel.com, pgonda@google.com, marcorr@google.com,
        eesposit@redhat.com, borntraeger@de.ibm.com, eric.auger@redhat.com,
        wangyanan55@huawei.com, aaronlewis@google.com, vkuznets@redhat.com,
        pshier@google.com, axelrasmussen@google.com,
        zhenzhong.duan@intel.com, maciej.szmigiero@oracle.com,
        like.xu@linux.intel.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ryan Afranji <afranji@google.com>

Adds a test that sets up shared memory between the host and guest.

Signed-off-by: Ryan Afranji <afranji@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/include/x86_64/tdx/tdx.h    |   2 +
 .../kvm/include/x86_64/tdx/tdx_util.h         |   3 +
 .../selftests/kvm/lib/x86_64/tdx/tdx.c        |  16 ++
 .../selftests/kvm/lib/x86_64/tdx/tdx_util.c   |  30 ++++
 .../kvm/x86_64/tdx_shared_mem_test.c          | 137 ++++++++++++++++++
 7 files changed, 190 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/tdx_shared_mem_test.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 370d6430b32b4..e1663b0f809b4 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -66,6 +66,7 @@
 /x86_64/vmx_pmu_caps_test
 /x86_64/triple_fault_event_test
 /x86_64/tdx_vm_tests
+/x86_64/tdx_shared_mem_test
 /access_tracking_perf_test
 /demand_paging_test
 /dirty_log_test
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 9f289322a4933..27e9148212fa5 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -152,6 +152,7 @@ TEST_GEN_PROGS_x86_64 += steal_time
 TEST_GEN_PROGS_x86_64 += kvm_binary_stats_test
 TEST_GEN_PROGS_x86_64 += system_counter_offset_test
 TEST_GEN_PROGS_x86_64 += x86_64/tdx_vm_tests
+TEST_GEN_PROGS_x86_64 += x86_64/tdx_shared_mem_test
 
 # Compiled outputs used by test targets
 TEST_GEN_PROGS_EXTENDED_x86_64 += x86_64/nx_huge_pages_test
diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
index ffab2c3ca312b..857a297e51ac6 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
@@ -7,6 +7,7 @@
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
index 274b245f200bf..58374453b4b7e 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx_util.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx_util.h
@@ -13,4 +13,7 @@ void td_initialize(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 		   uint64_t attributes);
 void td_finalize(struct kvm_vm *vm);
 
+void handle_memory_conversion(struct kvm_vm *vm, uint64_t gpa, uint64_t size,
+			bool shared_to_private);
+
 #endif // SELFTESTS_TDX_KVM_UTIL_H
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
index a280136634d3b..e0a39f29a0662 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
@@ -189,3 +189,19 @@ uint64_t tdg_vp_info(uint64_t *rcx, uint64_t *rdx,
 
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
index 2e9679d24a843..4d6615b97770a 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
@@ -505,3 +505,33 @@ void td_finalize(struct kvm_vm *vm)
 
 	tdx_td_finalizemr(vm);
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
+	struct kvm_enc_region range;
+	char *ioctl_string = shared_to_private
+		? "KVM_MEMORY_ENCRYPT_REG_REGION"
+		: "KVM_MEMORY_ENCRYPT_UNREG_REGION";
+
+	range.addr = gpa;
+	range.size = size;
+
+	printf("\t ... calling %s ioctl with gpa=%#lx, size=%#lx\n",
+		ioctl_string, gpa, size);
+
+	if (shared_to_private)
+		vm_ioctl(vm, KVM_MEMORY_ENCRYPT_REG_REGION, &range);
+	else
+		vm_ioctl(vm, KVM_MEMORY_ENCRYPT_UNREG_REGION, &range);
+}
diff --git a/tools/testing/selftests/kvm/x86_64/tdx_shared_mem_test.c b/tools/testing/selftests/kvm/x86_64/tdx_shared_mem_test.c
new file mode 100644
index 0000000000000..eb4cf64ae83a8
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/tdx_shared_mem_test.c
@@ -0,0 +1,137 @@
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
+	ASSERT_EQ(test_mem_private_gva, TDX_SHARED_MEM_TEST_PRIVATE_GVA);
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
+	/* TODO: MapGPA should exit to the host VMM, but now it doesn't */
+	// vcpu_run(vcpu);
+	// ASSERT_EQ(vcpu->run->exit_reason, KVM_EXIT_MEMORY_FAULT);
+	// handle_memory_conversion(vm, vcpu->run->memory.gpa, vcpu->run->memory.size,
+	//                          vcpu->run->memory.flags == KVM_MEMORY_EXIT_FLAG_PRIVATE);
+
+	vcpu_run(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_SHARED_MEM_TEST_INFO_PORT, 4,
+			   TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
+	ASSERT_EQ(*test_mem_hva, TDX_SHARED_MEM_TEST_GUEST_WRITE_VALUE);
+
+	*test_mem_hva = TDX_SHARED_MEM_TEST_HOST_WRITE_VALUE;
+	vcpu_run(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_SHARED_MEM_TEST_INFO_PORT, 4,
+			   TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
+	ASSERT_EQ(*(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset),
+		  TDX_SHARED_MEM_TEST_HOST_WRITE_VALUE);
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
2.39.0.246.g2a6d74b583-goog

