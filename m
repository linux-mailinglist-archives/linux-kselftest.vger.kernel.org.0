Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5299676259F
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 00:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjGYWD7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 18:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjGYWDL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 18:03:11 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7591C3A80
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:44 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-584126c65d1so22786777b3.3
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690322553; x=1690927353;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+jWpwLGoiO00PqKraSe9yL9ZcFFqCCXtFH7Ui+PqeI=;
        b=7C/rqA/U6bN6xBNMmm/ayVcAct7xb4t9fJY5X3WFvLoFoFl4+WQxs+SZCLxhgyQ8Lg
         ArioXJ8BviwzMCXTBkk7YRI2pt+bMvYWeTMxR+jnnklJaiuRns102LpA2rF1zQx7ajgd
         L+wlH8PZQ12RSqr9BXvtw4kAJaVr27ZiVOxNvSEqenTf+sb6UJtISimPKT+RJ3fIuNNM
         5jWCA3QQ0HQkuHWteD9HrEVWD3gdvOZ84Vm3fyRVfTPKjuXRGmdAtIlnrcrRfVKEGvKs
         RDOgK8AJG/j3EIC9Y3/A53SgmSz/mmuL2ZNSzUZg5y5iqKQ5T6aAjy44dPyDZEIOF4qb
         VMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690322553; x=1690927353;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+jWpwLGoiO00PqKraSe9yL9ZcFFqCCXtFH7Ui+PqeI=;
        b=bz4350qnhMDA7QbyTzJ/aMAfwYvYsRW159OAwLB8m1H/3/lhn3bL7kf2SO62dG6Wwb
         gqFtH1u6dQb9zY+nMPEltrHbPqpQ9t2gXdfSw2Eqy4+lI0cCw9ju7TBYQR3X6SC9cM/v
         41Ydwm7DCyJvZkL/WsETF5N/O7oclzEJzizWgszmBvfrbvgVz4FWgHK/TdAKiygCIyRo
         zEGu915YebSk4w4EmriFu+S2YHJJfl8hg7pL8N0+C9Fu3LZvjpH5DGjPb10uGJ3a5aO2
         qSEmO5GYZUiXNF1NwwIzSI/Qf6q8rJ8hGyRTqdyxa2tVTaXnHea0v7Zfee+XQ2VG8rtk
         zFIA==
X-Gm-Message-State: ABy/qLaJQiELGxq/rOdCfRJ9kSUSRCa2qJ9AvsG1OjLsCC6qjEUNU6+/
        9ervy9lO2RJ9eaJV917LtsgOXjNGXR+WCir6+3Hco+syHTfT8yCysn8rhI1Co6Ud3oydhsKmGdI
        d5dbLO+cFWUg4iKCf8CFgoEKPBR6/c2wg1JQK+3+k6QUxtgUg79zPne831K53ZIu2Qmr0khbW4p
        Hm
X-Google-Smtp-Source: APBJJlFRDk4GQfTdbNlw86NI9O5K0YkX8BX6a8rAXsilc+zyNbzGk+Zf4vD8gggvDLLoEzyrFpaRbyrub+hf
X-Received: from afranji.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:47f1])
 (user=afranji job=sendgmr) by 2002:a81:ad48:0:b0:573:3897:c925 with SMTP id
 l8-20020a81ad48000000b005733897c925mr4026ywk.6.1690322553071; Tue, 25 Jul
 2023 15:02:33 -0700 (PDT)
Date:   Tue, 25 Jul 2023 22:01:16 +0000
In-Reply-To: <20230725220132.2310657-1-afranji@google.com>
Mime-Version: 1.0
References: <20230725220132.2310657-1-afranji@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725220132.2310657-24-afranji@google.com>
Subject: [PATCH v4 23/28] KVM: selftests: TDX: Add shared memory test
From:   Ryan Afranji <afranji@google.com>
To:     linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, seanjc@google.com, isaku.yamahata@intel.com,
        sagis@google.com, erdemaktas@google.com, afranji@google.com,
        runanwang@google.com, shuah@kernel.org, drjones@redhat.com,
        maz@kernel.org, bgardon@google.com, jmattson@google.com,
        dmatlack@google.com, peterx@redhat.com, oupton@google.com,
        ricarkol@google.com, yang.zhong@intel.com, wei.w.wang@intel.com,
        xiaoyao.li@intel.com, pgonda@google.com, eesposit@redhat.com,
        borntraeger@de.ibm.com, eric.auger@redhat.com,
        wangyanan55@huawei.com, aaronlewis@google.com, vkuznets@redhat.com,
        pshier@google.com, axelrasmussen@google.com,
        zhenzhong.duan@intel.com, maciej.szmigiero@oracle.com,
        like.xu@linux.intel.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, ackerleytng@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Adds a test that sets up shared memory between the host and guest.

Signed-off-by: Ryan Afranji <afranji@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Change-Id: I95b15afb84790c046d4af2a58b03e57b5ea6439b
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/include/x86_64/tdx/tdx.h    |   2 +
 .../kvm/include/x86_64/tdx/tdx_util.h         |   2 +
 .../selftests/kvm/lib/x86_64/tdx/tdx.c        |  26 ++++
 .../selftests/kvm/lib/x86_64/tdx/tdx_util.c   |  25 ++++
 .../kvm/x86_64/tdx_shared_mem_test.c          | 134 ++++++++++++++++++
 6 files changed, 190 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/tdx_shared_mem_test.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 5cdced288025..cb2aaa7820c3 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -140,6 +140,7 @@ TEST_GEN_PROGS_x86_64 += steal_time
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
index c8591480b412..453ede061347 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
@@ -538,3 +538,28 @@ void td_vcpu_run(struct kvm_vcpu *vcpu)
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
index 000000000000..6ebaddba0e11
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/tdx_shared_mem_test.c
@@ -0,0 +1,134 @@
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
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_SHARED_MEM_TEST_INFO_PORT, 4,
+			   TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
+	ASSERT_EQ(*test_mem_hva, TDX_SHARED_MEM_TEST_GUEST_WRITE_VALUE);
+
+	*test_mem_hva = TDX_SHARED_MEM_TEST_HOST_WRITE_VALUE;
+	td_vcpu_run(vcpu);
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
2.41.0.487.g6d72f3e995-goog

