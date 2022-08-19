Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF06659A305
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Aug 2022 20:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350212AbiHSSBE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Aug 2022 14:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351418AbiHSSAl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Aug 2022 14:00:41 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E91210976B
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Aug 2022 10:47:49 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id bd20-20020a056a00279400b0053609a39408so1341921pfb.3
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Aug 2022 10:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=dv/VsCKISe4XLQ/adqAzQumoi9iqOUxkYS0i2UxBP3I=;
        b=A4agjpKcSu6/kPWlIthpUoZueo3UcltCGmBNFoj9HUB7vMKlXZnphdejH4rh+uwECS
         0eeIWtQyrFG/6KKguA5+dKENb41p+bncSzVLGdMO5NqhlFTaLzpVJuIO0VSvbinCxiH2
         jZV6KiJLRXBYXV1jcNGGQx2iwgCN+dKiPrZHt0iAyRm/8hn+mGmOFFR+hZu8G48nhsP5
         Aj2WOGR01iteAHL6RhXfErkxEtxSINRZvFAkHlM6ucQxyESYgGR/+ZnR8R0OUpHMP+CM
         xjrL8Z8v5iMh5T6gek18hvdn1jph4V3kmvJGii1Kqht+V2YKpTxMMS7lktVvEaA5pZbL
         Mdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=dv/VsCKISe4XLQ/adqAzQumoi9iqOUxkYS0i2UxBP3I=;
        b=mUsqoW89xwAzl1E790sDB6n5V50evLIsuH4Bdixrivb0Aumy32owqONG9+tiEneIBg
         Rzze0SdC1so9qFdlWkq3mD2xFM1WF400qnoBFQQj4Hfp/1Zm+9WMxpc3sGG3n/N5dtPU
         ELAtiS6bcc0jYZBWYmInSgBMq3L0iCsIWfCj9GU5hUEteGIZObrYhM8chpBqZasNOeHV
         qxrIFqN9miC3m6vywFOk+fd0TuhUNxD6lLhcGyPQFHvM4JT3T9XEDud5MB9/hE/ByTX9
         f3E0TZkVFthfYNqkHLWuPzPn5CunS1hfR56Hu9wZpfsDZzqFCePraYXLjV0FxTEzBtMh
         EZMw==
X-Gm-Message-State: ACgBeo2949dzLVpCuHeUMRrhv94e69izHlCu2HmJBeYbdLAKd6NsRPVF
        MJ5C3miAx8noMf+uf9ce8+TKpxcZ9D9kdCj3
X-Google-Smtp-Source: AA6agR45WcPgNXju/DqeyAETJOUtsihagTn67GcHVksMPZA4f6EE62Wig/51CgBefg7030k9YmlAa8WXjoi1a5wc
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a05:6a00:1145:b0:52b:78c:fa26 with SMTP
 id b5-20020a056a00114500b0052b078cfa26mr8897082pfm.27.1660931268817; Fri, 19
 Aug 2022 10:47:48 -0700 (PDT)
Date:   Fri, 19 Aug 2022 17:46:58 +0000
In-Reply-To: <20220819174659.2427983-1-vannapurve@google.com>
Message-Id: <20220819174659.2427983-6-vannapurve@google.com>
Mime-Version: 1.0
References: <20220819174659.2427983-1-vannapurve@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [RFC V3 PATCH 5/6] selftests: kvm: x86: Execute VMs with private memory
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shuah@kernel.org, yang.zhong@intel.com,
        drjones@redhat.com, ricarkol@google.com, aaronlewis@google.com,
        wei.w.wang@intel.com, kirill.shutemov@linux.intel.com,
        corbet@lwn.net, hughd@google.com, jlayton@kernel.org,
        bfields@fieldses.org, akpm@linux-foundation.org,
        chao.p.peng@linux.intel.com, yu.c.zhang@linux.intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com,
        michael.roth@amd.com, qperret@google.com, steven.price@arm.com,
        ak@linux.intel.com, david@redhat.com, luto@kernel.org,
        vbabka@suse.cz, marcorr@google.com, erdemaktas@google.com,
        pgonda@google.com, nikunj@amd.com, seanjc@google.com,
        diviness@google.com, maz@kernel.org, dmatlack@google.com,
        axelrasmussen@google.com, maciej.szmigiero@oracle.com,
        mizhang@google.com, bgardon@google.com,
        Vishal Annapurve <vannapurve@google.com>
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

Introduce a set of APIs to execute VM with private memslots.

Host userspace APIs for:
1) Setting up and executing VM having private memslots
2) Backing/unbacking guest private memory

Guest APIs for:
1) Changing memory access type and memory type
2) Setting ucall page access type as shared

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../kvm/include/x86_64/private_mem.h          |  51 +++
 .../selftests/kvm/lib/x86_64/private_mem.c    | 297 ++++++++++++++++++
 3 files changed, 349 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/private_mem.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/private_mem.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 41fd1171fbd8..8fe72a60aef0 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -51,6 +51,7 @@ LIBKVM += lib/ucall_common.c
 LIBKVM_x86_64 += lib/x86_64/apic.c
 LIBKVM_x86_64 += lib/x86_64/handlers.S
 LIBKVM_x86_64 += lib/x86_64/perf_test_util.c
+LIBKVM_x86_64 += lib/x86_64/private_mem.c
 LIBKVM_x86_64 += lib/x86_64/processor.c
 LIBKVM_x86_64 += lib/x86_64/svm.c
 LIBKVM_x86_64 += lib/x86_64/ucall.c
diff --git a/tools/testing/selftests/kvm/include/x86_64/private_mem.h b/tools/testing/selftests/kvm/include/x86_64/private_mem.h
new file mode 100644
index 000000000000..00cab7b84f2c
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86_64/private_mem.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2022, Google LLC.
+ */
+
+#ifndef SELFTEST_KVM_PRIVATE_MEM_H
+#define SELFTEST_KVM_PRIVATE_MEM_H
+
+#include <stdint.h>
+#include <kvm_util.h>
+
+enum mem_conversion_type {
+	TO_PRIVATE,
+	TO_SHARED
+};
+
+void guest_update_mem_access(enum mem_conversion_type type, uint64_t gpa,
+	uint64_t size);
+void guest_update_mem_map(enum mem_conversion_type type, uint64_t gpa,
+	uint64_t size);
+
+void guest_map_ucall_page_shared(void);
+
+enum mem_op {
+	ALLOCATE_MEM,
+	UNBACK_MEM
+};
+
+void vm_update_private_mem(struct kvm_vm *vm, uint64_t gpa, uint64_t size,
+	enum mem_op op);
+
+typedef void (*guest_code_fn)(void);
+typedef void (*io_exit_handler)(struct kvm_vm *vm, uint32_t uc_arg1);
+
+struct test_setup_info {
+	uint64_t test_area_gpa;
+	uint64_t test_area_size;
+	uint32_t test_area_slot;
+};
+
+struct vm_setup_info {
+	enum vm_mem_backing_src_type vm_mem_src;
+	uint32_t memslot0_pages;
+	struct test_setup_info test_info;
+	guest_code_fn guest_fn;
+	io_exit_handler ioexit_cb;
+};
+
+void execute_vm_with_private_mem(struct vm_setup_info *info);
+
+#endif /* SELFTEST_KVM_PRIVATE_MEM_H */
diff --git a/tools/testing/selftests/kvm/lib/x86_64/private_mem.c b/tools/testing/selftests/kvm/lib/x86_64/private_mem.c
new file mode 100644
index 000000000000..000584219045
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86_64/private_mem.c
@@ -0,0 +1,297 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * tools/testing/selftests/kvm/lib/kvm_util.c
+ *
+ * Copyright (C) 2022, Google LLC.
+ */
+#define _GNU_SOURCE /* for program_invocation_name */
+#include <fcntl.h>
+#include <limits.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+
+#include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <linux/kvm_para.h>
+
+#include <test_util.h>
+#include <kvm_util.h>
+#include <private_mem.h>
+#include <processor.h>
+
+/*
+ * Execute KVM hypercall to change memory access type for a given gpa range.
+ *
+ * Input Args:
+ *   type - memory conversion type TO_SHARED/TO_PRIVATE
+ *   gpa - starting gpa address
+ *   size - size of the range starting from gpa for which memory access needs
+ *     to be changed
+ *
+ * Output Args: None
+ *
+ * Return: None
+ *
+ * Function called by guest logic in selftests to update the memory access type
+ * for a given gpa range. This API is useful in exercising implicit conversion
+ * path.
+ */
+void guest_update_mem_access(enum mem_conversion_type type, uint64_t gpa,
+	uint64_t size)
+{
+	int ret = kvm_hypercall(KVM_HC_MAP_GPA_RANGE, gpa, size >> MIN_PAGE_SHIFT,
+		type == TO_PRIVATE ? KVM_MARK_GPA_RANGE_ENC_ACCESS :
+			KVM_CLR_GPA_RANGE_ENC_ACCESS, 0);
+	GUEST_ASSERT_1(!ret, ret);
+}
+
+/*
+ * Execute KVM hypercall to change memory type for a given gpa range.
+ *
+ * Input Args:
+ *   type - memory conversion type TO_SHARED/TO_PRIVATE
+ *   gpa - starting gpa address
+ *   size - size of the range starting from gpa for which memory type needs
+ *     to be changed
+ *
+ * Output Args: None
+ *
+ * Return: None
+ *
+ * Function called by guest logic in selftests to update the memory type for a
+ * given gpa range. This API is useful in exercising explicit conversion path.
+ */
+void guest_update_mem_map(enum mem_conversion_type type, uint64_t gpa,
+	uint64_t size)
+{
+	int ret = kvm_hypercall(KVM_HC_MAP_GPA_RANGE, gpa, size >> MIN_PAGE_SHIFT,
+		type == TO_PRIVATE ? KVM_MAP_GPA_RANGE_ENCRYPTED :
+			KVM_MAP_GPA_RANGE_DECRYPTED, 0);
+	GUEST_ASSERT_1(!ret, ret);
+}
+
+/*
+ * Execute KVM hypercall to change memory access type for ucall page.
+ *
+ * Input Args: None
+ *
+ * Output Args: None
+ *
+ * Return: None
+ *
+ * Function called by guest logic in selftests to update the memory access type
+ * for ucall page since by default all the accesses from guest to private
+ * memslot are treated as private accesses.
+ */
+void guest_map_ucall_page_shared(void)
+{
+	vm_paddr_t ucall_paddr = get_ucall_pool_paddr();
+
+	guest_update_mem_access(TO_SHARED, ucall_paddr, 1 << MIN_PAGE_SHIFT);
+}
+
+/*
+ * Execute KVM ioctl to back/unback private memory for given gpa range.
+ *
+ * Input Args:
+ *   vm - kvm_vm handle
+ *   gpa - starting gpa address
+ *   size - size of the gpa range
+ *   op - mem_op indicating whether private memory needs to be allocated or
+ *     unbacked
+ *
+ * Output Args: None
+ *
+ * Return: None
+ *
+ * Function called by host userspace logic in selftests to back/unback private
+ * memory for gpa ranges. This function is useful to setup initial boot private
+ * memory and then convert memory during runtime.
+ */
+void vm_update_private_mem(struct kvm_vm *vm, uint64_t gpa, uint64_t size,
+	enum mem_op op)
+{
+	int priv_memfd;
+	uint64_t priv_offset, guest_phys_base, fd_offset;
+	struct kvm_enc_region enc_region;
+	struct kvm_userspace_memory_region_ext *region_ext;
+	struct kvm_userspace_memory_region *region;
+	int fallocate_mode = 0;
+	int ret;
+
+	region_ext = kvm_userspace_memory_region_ext_find(vm, gpa, gpa + size);
+	TEST_ASSERT(region_ext != NULL, "Region not found");
+	region = &region_ext->region;
+	TEST_ASSERT(region->flags & KVM_MEM_PRIVATE,
+		"Can not update private memfd for non-private memslot\n");
+	priv_memfd = region_ext->private_fd;
+	priv_offset = region_ext->private_offset;
+	guest_phys_base = region->guest_phys_addr;
+	fd_offset = priv_offset + (gpa - guest_phys_base);
+
+	if (op == UNBACK_MEM)
+		fallocate_mode = (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE);
+
+	printf("priv_memfd %d fallocate_mode 0x%x for offset 0x%lx size 0x%lx\n",
+		priv_memfd, fallocate_mode, fd_offset, size);
+	ret = fallocate(priv_memfd, fallocate_mode, fd_offset, size);
+	TEST_ASSERT(ret == 0, "fallocate failed\n");
+	enc_region.addr = gpa;
+	enc_region.size = size;
+	if (op == ALLOCATE_MEM) {
+		printf("doing encryption for gpa 0x%lx size 0x%lx\n", gpa, size);
+		vm_ioctl(vm, KVM_MEMORY_ENCRYPT_REG_REGION, &enc_region);
+	} else {
+		printf("undoing encryption for gpa 0x%lx size 0x%lx\n", gpa, size);
+		vm_ioctl(vm, KVM_MEMORY_ENCRYPT_UNREG_REGION, &enc_region);
+	}
+}
+
+static void handle_vm_exit_map_gpa_hypercall(struct kvm_vm *vm,
+				volatile struct kvm_run *run)
+{
+	uint64_t gpa, npages, attrs, size;
+
+	TEST_ASSERT(run->hypercall.nr == KVM_HC_MAP_GPA_RANGE,
+		"Unhandled Hypercall %lld\n", run->hypercall.nr);
+	gpa = run->hypercall.args[0];
+	npages = run->hypercall.args[1];
+	size = npages << MIN_PAGE_SHIFT;
+	attrs = run->hypercall.args[2];
+	pr_info("Explicit conversion off 0x%lx size 0x%lx to %s\n", gpa, size,
+		(attrs & KVM_MAP_GPA_RANGE_ENCRYPTED) ? "private" : "shared");
+
+	if (attrs & KVM_MAP_GPA_RANGE_ENCRYPTED)
+		vm_update_private_mem(vm, gpa, size, ALLOCATE_MEM);
+	else
+		vm_update_private_mem(vm, gpa, size, UNBACK_MEM);
+
+	run->hypercall.ret = 0;
+}
+
+static void handle_vm_exit_memory_error(struct kvm_vm *vm, volatile struct kvm_run *run)
+{
+	uint64_t gpa, size, flags;
+
+	gpa = run->memory.gpa;
+	size = run->memory.size;
+	flags = run->memory.flags;
+	pr_info("Implicit conversion off 0x%lx size 0x%lx to %s\n", gpa, size,
+		(flags & KVM_MEMORY_EXIT_FLAG_PRIVATE) ? "private" : "shared");
+	if (flags & KVM_MEMORY_EXIT_FLAG_PRIVATE)
+		vm_update_private_mem(vm, gpa, size, ALLOCATE_MEM);
+	else
+		vm_update_private_mem(vm, gpa, size, UNBACK_MEM);
+}
+
+static void vcpu_work(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
+	struct vm_setup_info *info)
+{
+	volatile struct kvm_run *run;
+	struct ucall uc;
+	uint64_t cmd;
+
+	/*
+	 * Loop until the guest is done.
+	 */
+	run = vcpu->run;
+
+	while (true) {
+		vcpu_run(vcpu);
+
+		if (run->exit_reason == KVM_EXIT_IO) {
+			cmd = get_ucall(vcpu, &uc);
+			if (cmd != UCALL_SYNC)
+				break;
+
+			TEST_ASSERT(info->ioexit_cb, "ioexit cb not present");
+			info->ioexit_cb(vm, uc.args[1]);
+			continue;
+		}
+
+		if (run->exit_reason == KVM_EXIT_HYPERCALL) {
+			handle_vm_exit_map_gpa_hypercall(vm, run);
+			continue;
+		}
+
+		if (run->exit_reason == KVM_EXIT_MEMORY_FAULT) {
+			handle_vm_exit_memory_error(vm, run);
+			continue;
+		}
+
+		TEST_FAIL("Unhandled VCPU exit reason %d\n", run->exit_reason);
+		break;
+	}
+
+	if (run->exit_reason == KVM_EXIT_IO && cmd == UCALL_ABORT)
+		TEST_FAIL("%s at %s:%ld, val = %lu", (const char *)uc.args[0],
+			  __FILE__, uc.args[1], uc.args[2]);
+}
+
+/*
+ * Execute guest vm with private memory memslots.
+ *
+ * Input Args:
+ *   info - pointer to a structure containing information about setting up a VM
+ *     with private memslots
+ *
+ * Output Args: None
+ *
+ * Return: None
+ *
+ * Function called by host userspace logic in selftests to execute guest vm
+ * logic. It will install two memslots:
+ * 1) memslot 0 : containing all the boot code/stack pages
+ * 2) test_mem_slot : containing the region of memory that would be used to test
+ *   private/shared memory accesses to a memory backed by private memslots
+ */
+void execute_vm_with_private_mem(struct vm_setup_info *info)
+{
+	struct kvm_vm *vm;
+	struct kvm_enable_cap cap;
+	struct kvm_vcpu *vcpu;
+	uint32_t memslot0_pages = info->memslot0_pages;
+	uint64_t test_area_gpa, test_area_size;
+	struct test_setup_info *test_info = &info->test_info;
+
+	vm = vm_create_barebones();
+	vm_set_memory_encryption(vm, true, false, 0);
+	vm->use_ucall_pool = true;
+	vm_userspace_mem_region_add(vm, info->vm_mem_src, 0, 0,
+		memslot0_pages, KVM_MEM_PRIVATE);
+	kvm_vm_elf_load(vm, program_invocation_name);
+	vm_create_irqchip(vm);
+	TEST_ASSERT(info->guest_fn, "guest_fn not present");
+	vcpu = vm_vcpu_add(vm, 0, info->guest_fn);
+
+	vm_check_cap(vm, KVM_CAP_EXIT_HYPERCALL);
+	cap.cap = KVM_CAP_EXIT_HYPERCALL;
+	cap.flags = 0;
+	cap.args[0] = (1 << KVM_HC_MAP_GPA_RANGE);
+	vm_ioctl(vm, KVM_ENABLE_CAP, &cap);
+
+	TEST_ASSERT(test_info->test_area_size, "Test mem size not present");
+
+	test_area_size = test_info->test_area_size;
+	test_area_gpa = test_info->test_area_gpa;
+	vm_userspace_mem_region_add(vm, info->vm_mem_src, test_area_gpa,
+		test_info->test_area_slot, test_area_size / vm->page_size,
+		KVM_MEM_PRIVATE);
+	vm_update_private_mem(vm, test_area_gpa, test_area_size, ALLOCATE_MEM);
+
+	pr_info("Mapping test memory pages 0x%zx page_size 0x%x\n",
+		test_area_size/vm->page_size, vm->page_size);
+	virt_map(vm, test_area_gpa, test_area_gpa, test_area_size/vm->page_size);
+
+	ucall_init(vm, NULL);
+	vm_update_private_mem(vm, 0, (memslot0_pages << MIN_PAGE_SHIFT), ALLOCATE_MEM);
+
+	vcpu_work(vm, vcpu, info);
+
+	ucall_uninit(vm);
+	kvm_vm_free(vm);
+}
-- 
2.37.1.595.g718a3a8f04-goog

