Return-Path: <linux-kselftest+bounces-34767-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 965A6AD6109
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 23:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 691493AB258
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 21:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2CD255E40;
	Wed, 11 Jun 2025 21:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yW4OwMA5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9CF24EA85
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 21:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749676631; cv=none; b=qQhDYMt+SAkrS7mZH4EyIkfP2T7RO5XHer2pkCyWde33vUYRqGkjnDH3rzFACZTFfQmx0ZvDoXdnNFBpdzlRqh66AYn7ZTjPzSB8A0NQ+E3r7X2DmxttpnDrwCcrHNHFdOalVYEeAAB9FlgAjbJ5ZK8oPGJHgjrC6OkqzOl71eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749676631; c=relaxed/simple;
	bh=9bHODc+L3jY8CU4AGA0f9Uj2uodDYKTbx2LQsdLuFe8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dup8Ihed6FsBPIoLCha9zQPpfIpgaOJzLtg6x7aEczECqfrSLCYH1Ua/rpodQ+K5IiH7YaBIUsUX2xc+WxHs8v69Edvx4qyvAmu2cV4pIG3+Z+5+7Uf02jNMwCkBnMmY9+3UpeeywYhFzGy/X9TaPcDTgxWJmKdz8qfw4p8irwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yW4OwMA5; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-747d84fe5f8so149235b3a.3
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 14:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749676629; x=1750281429; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ssjnbQ4kJflk7fXBHBaf7ALVkd5j+ovjxWVLHw4vo40=;
        b=yW4OwMA5+E3hWIoxPhcBzfrFkWa/ZxvxscuiJyItpBbf32NStZuTgoNAket1hu0HCN
         RNTOg6fWhNGCtoMKBt9MvSWs3Bht0wsj8KGvGBPY8BiWyrtrnfzC0iRG7fKOLmGUalVm
         5OaSu4i7OIE91w8ILEbFbXzKSSfWDSQX3PHijTAjLurasKbzC2D0vkvXL6Du9WFBhs/x
         H22bKbu2IjNZzP6HQRFC7dED+uD+7bxucl3nM5J06l+FKzhWYmPkvkFzXgpJAHNrkAZ/
         OXBbQ3bgenhidqd7qFJOVVag7ptjyke2Mpzh+MTH3boyjXIOiPR9s0kOjUFqxbooCvyp
         nSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749676629; x=1750281429;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ssjnbQ4kJflk7fXBHBaf7ALVkd5j+ovjxWVLHw4vo40=;
        b=Wqen3TH2KQe7dJ12sVybVr85YuWZHpoXSsbvBjSu/md7Jybir0PVMrmjkI2cVzHMYT
         0JdxwbqbL40oaKCP/35ssTajWthGZD/cvfF6RTIgQYBMGPxThTxKYGERkHlB9g/DtR3J
         QCjkXAxLtSnuakqgjz6Kgwa1eig4tFBuSo0pYFraSyaRb8t1ZXu3To9c1HD4yZs58WGu
         64Spyy+XMOp6AAiWigAuLqNcaS7e7P3xU5dbvHsKbHVebYz+fAnENLVXvQfiKHJU8AnI
         hKGz+mLDJRTOcYv6bwJvxLoJc0l7HM/jrkAcr65V9NGbro05ypizea1P4wUtux5cQ7Qx
         rYXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxofTmaFg28chBQndD257i33vE/G+rTfEfOTiJkqeKsU+/5/M4y4L3xI6tcC/v5y8JPjdfzae4D43qm5rUsaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnB4tzFweyGkOUCbcWcUseHXz56goWL+94s4QtXb8yQ+s7wjRu
	GmovxO5dkgviJEr3rO4V8FjYX6B/r2WSc2hdJHxoLfiYl1RZmtEBqUA5w67bIps8vLXrulpHUp5
	f3Ade4HU4QA==
X-Google-Smtp-Source: AGHT+IGt8itXpNhAIFBj62DiJ64U9JmDFLzjGyRqSV6OdShtMpiACjneNt3RcQvG2dGMamb53/SKPyXvNeW+
X-Received: from pfbfr17.prod.google.com ([2002:a05:6a00:8111:b0:73e:665:360])
 (user=afranji job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:8882:0:b0:73d:ff02:8d83
 with SMTP id d2e1a72fcca58-7486cb21c08mr7425055b3a.3.1749676628808; Wed, 11
 Jun 2025 14:17:08 -0700 (PDT)
Date: Wed, 11 Jun 2025 21:16:35 +0000
In-Reply-To: <cover.1749672978.git.afranji@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1749672978.git.afranji@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <92f22ace98238b79c25bd8759c75a1143d82a741.1749672978.git.afranji@google.com>
Subject: [RFC PATCH v2 08/10] KVM: selftests: TDX: Add tests for TDX in-place migration
From: Ryan Afranji <afranji@google.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
Cc: sagis@google.com, bp@alien8.de, chao.p.peng@linux.intel.com, 
	dave.hansen@linux.intel.com, dmatlack@google.com, erdemaktas@google.com, 
	isaku.yamahata@intel.com, kai.huang@intel.com, mingo@redhat.com, 
	pbonzini@redhat.com, seanjc@google.com, tglx@linutronix.de, 
	zhi.wang.linux@gmail.com, ackerleytng@google.com, andrew.jones@linux.dev, 
	david@redhat.com, hpa@zytor.com, kirill.shutemov@linux.intel.com, 
	linux-kselftest@vger.kernel.org, tabba@google.com, vannapurve@google.com, 
	yan.y.zhao@intel.com, rick.p.edgecombe@intel.com, 
	Ryan Afranji <afranji@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Sagi Shahar <sagis@google.com>

Adds selftests for TDX in-place migration.

Signed-off-by: Ryan Afranji <afranji@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../testing/selftests/kvm/include/kvm_util.h  |  20 +
 .../selftests/kvm/include/x86/tdx/tdx_util.h  |   1 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  50 ++-
 .../selftests/kvm/lib/x86/tdx/tdx_util.c      |   3 +-
 .../selftests/kvm/x86/tdx_migrate_tests.c     | 358 ++++++++++++++++++
 6 files changed, 429 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/tdx_migrate_tests.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 1c7ea61e9031..d4c8cfb5910f 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -155,6 +155,7 @@ TEST_GEN_PROGS_x86 += pre_fault_memory_test
 TEST_GEN_PROGS_x86 += x86/tdx_vm_test
 TEST_GEN_PROGS_x86 += x86/tdx_shared_mem_test
 TEST_GEN_PROGS_x86 += x86/tdx_upm_test
+TEST_GEN_PROGS_x86 += x86/tdx_migrate_tests
 
 # Compiled outputs used by test targets
 TEST_GEN_PROGS_EXTENDED_x86 += x86/nx_huge_pages_test
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 267f78f3f16f..1b6489081e74 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -110,6 +110,9 @@ struct kvm_vm {
 
 	struct kvm_binary_stats stats;
 
+	/* VM was migrated using KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM */
+	bool enc_migrated;
+
 	/*
 	 * KVM region slots. These are the default memslots used by page
 	 * allocators, e.g., lib/elf uses the memslots[MEM_REGION_CODE]
@@ -673,6 +676,7 @@ static inline bool vm_arch_has_protected_memory(struct kvm_vm *vm)
 
 void vm_mem_region_set_flags(struct kvm_vm *vm, uint32_t slot, uint32_t flags);
 void vm_mem_region_move(struct kvm_vm *vm, uint32_t slot, uint64_t new_gpa);
+void vm_migrate_mem_regions(struct kvm_vm *dst_vm, struct kvm_vm *src_vm);
 void vm_mem_region_delete(struct kvm_vm *vm, uint32_t slot);
 struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id);
 void vm_populate_vaddr_bitmap(struct kvm_vm *vm);
@@ -1132,6 +1136,22 @@ static inline struct kvm_vcpu *vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
 	return vcpu;
 }
 
+/*
+ * Adds a vCPU with no defaults. This vcpu will be used for migration
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   vcpu_id - The id of the VCPU to add to the VM.
+ */
+struct kvm_vcpu *vm_arch_vcpu_add_for_migration(struct kvm_vm *vm,
+						uint32_t vcpu_id);
+
+static inline struct kvm_vcpu *vm_vcpu_add_for_migration(struct kvm_vm *vm,
+							 uint32_t vcpu_id)
+{
+	return vm_arch_vcpu_add_for_migration(vm, vcpu_id);
+}
+
 /* Re-create a vCPU after restarting a VM, e.g. for state save/restore tests. */
 struct kvm_vcpu *vm_arch_vcpu_recreate(struct kvm_vm *vm, uint32_t vcpu_id);
 
diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
index ae39b78aa4af..9b495e621225 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
@@ -9,6 +9,7 @@
 extern uint64_t tdx_s_bit;
 void tdx_filter_cpuid(struct kvm_vm *vm, struct kvm_cpuid2 *cpuid_data);
 void __tdx_mask_cpuid_features(struct kvm_cpuid_entry2 *entry);
+void tdx_enable_capabilities(struct kvm_vm *vm);
 
 struct kvm_vcpu *td_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id, void *guest_code);
 
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 3c131718b81a..9dc3c7bf0443 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -805,8 +805,10 @@ static void __vm_mem_region_delete(struct kvm_vm *vm,
 
 	sparsebit_free(&region->unused_phy_pages);
 	sparsebit_free(&region->protected_phy_pages);
-	ret = munmap(region->mmap_start, region->mmap_size);
-	TEST_ASSERT(!ret, __KVM_SYSCALL_ERROR("munmap()", ret));
+	if (!vm->enc_migrated) {
+		ret = munmap(region->mmap_start, region->mmap_size);
+		TEST_ASSERT(!ret, __KVM_SYSCALL_ERROR("munmap()", ret));
+	}
 	if (region->fd >= 0) {
 		/* There's an extra map when using shared memory. */
 		ret = munmap(region->mmap_alias, region->mmap_size);
@@ -1287,6 +1289,50 @@ void vm_mem_region_move(struct kvm_vm *vm, uint32_t slot, uint64_t new_gpa)
 		    ret, errno, slot, new_gpa);
 }
 
+static void vm_migrate_mem_region(struct kvm_vm *dst_vm, struct kvm_vm *src_vm,
+				  struct userspace_mem_region *src_region)
+{
+	struct userspace_mem_region *dst_region;
+	int dst_guest_memfd;
+
+	dst_guest_memfd =
+		vm_link_guest_memfd(dst_vm, src_region->region.guest_memfd, 0);
+
+	dst_region = vm_mem_region_alloc(
+			dst_vm, src_region->region.guest_phys_addr,
+			src_region->region.slot,
+			src_region->region.memory_size / src_vm->page_size,
+			src_region->region.flags);
+
+	dst_region->mmap_size = src_region->mmap_size;
+	dst_region->mmap_start = src_region->mmap_start;
+	dst_region->host_mem = src_region->host_mem;
+
+	src_region->mmap_start = 0;
+	src_region->host_mem = 0;
+
+	dst_region->region.guest_memfd = dst_guest_memfd;
+	dst_region->region.guest_memfd_offset =
+		src_region->region.guest_memfd_offset;
+
+	userspace_mem_region_commit(dst_vm, dst_region);
+}
+
+void vm_migrate_mem_regions(struct kvm_vm *dst_vm, struct kvm_vm *src_vm)
+{
+	int bkt;
+	struct hlist_node *node;
+	struct userspace_mem_region *region;
+
+	hash_for_each_safe(src_vm->regions.slot_hash, bkt, node, region,
+			   slot_node) {
+		TEST_ASSERT(region->region.guest_memfd >= 0,
+			    "Migrating mem regions is only supported for GUEST_MEMFD");
+
+		vm_migrate_mem_region(dst_vm, src_vm, region);
+	}
+}
+
 /*
  * VM Memory Region Delete
  *
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
index c5bee67099c5..ef03d42f58d0 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -344,7 +344,7 @@ static void register_encrypted_memory_region(struct kvm_vm *vm,
  * TD creation/setup/finalization
  */
 
-static void tdx_enable_capabilities(struct kvm_vm *vm)
+void tdx_enable_capabilities(struct kvm_vm *vm)
 {
 	int rc;
 
@@ -574,7 +574,6 @@ void td_initialize(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 	uint64_t nr_pages_required;
 
 	tdx_enable_capabilities(vm);
-
 	tdx_td_init(vm, attributes);
 
 	nr_pages_required = vm_nr_pages_required(VM_MODE_DEFAULT, 1, 0);
diff --git a/tools/testing/selftests/kvm/x86/tdx_migrate_tests.c b/tools/testing/selftests/kvm/x86/tdx_migrate_tests.c
new file mode 100644
index 000000000000..e15da2aa0437
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/tdx_migrate_tests.c
@@ -0,0 +1,358 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "tdx/tdcall.h"
+#include "tdx/tdx.h"
+#include "tdx/tdx_util.h"
+#include "tdx/test_util.h"
+#include <processor.h>
+#include <sys/wait.h>
+
+#define NR_MIGRATE_TEST_VMS 10
+#define TDX_IOEXIT_TEST_PORT 0x50
+
+static int __tdx_migrate_from(int dst_fd, int src_fd)
+{
+	struct kvm_enable_cap cap = {
+		.cap = KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM,
+		.args = { src_fd }
+	};
+
+	return ioctl(dst_fd, KVM_ENABLE_CAP, &cap);
+}
+
+
+static void tdx_migrate_from(struct kvm_vm *dst_vm, struct kvm_vm *src_vm)
+{
+	int ret;
+
+	vm_migrate_mem_regions(dst_vm, src_vm);
+	ret = __tdx_migrate_from(dst_vm->fd, src_vm->fd);
+	TEST_ASSERT(!ret, "Migration failed, ret: %d, errno: %d\n", ret, errno);
+	src_vm->enc_migrated = true;
+}
+
+void guest_code(void)
+{
+	int ret;
+	uint64_t data;
+
+	data = 1;
+	ret = tdg_vp_vmcall_instruction_io(TDX_IOEXIT_TEST_PORT, 1,
+					   PORT_WRITE,
+					   &data);
+	if (ret)
+		tdx_test_fatal_with_data(ret, __LINE__);
+
+	data++;
+	ret = tdg_vp_vmcall_instruction_io(TDX_IOEXIT_TEST_PORT, 1,
+					   PORT_WRITE,
+					   &data);
+	if (ret)
+		tdx_test_fatal_with_data(ret, __LINE__);
+
+	tdx_test_success();
+}
+
+static void test_tdx_migrate_vm_with_private_memory(void)
+{
+	struct kvm_vm *src_vm;
+	struct kvm_vm *dst_vm;
+	struct kvm_vcpu *dst_vcpu;
+	uint32_t data;
+
+	printf("Verifying migration of VM with private memory:\n");
+
+	src_vm = td_create();
+	td_initialize(src_vm, VM_MEM_SRC_ANONYMOUS, 0);
+	td_vcpu_add(src_vm, 0, guest_code);
+	td_finalize(src_vm);
+
+	dst_vm = td_create();
+	tdx_enable_capabilities(dst_vm);
+	dst_vcpu = vm_vcpu_recreate(dst_vm, 0);
+
+	tdx_migrate_from(dst_vm, src_vm);
+
+	kvm_vm_free(src_vm);
+
+	tdx_run(dst_vcpu);
+	tdx_test_assert_io(dst_vcpu, TDX_IOEXIT_TEST_PORT, 1,
+			   PORT_WRITE);
+	data = *(uint8_t *)((void *)dst_vcpu->run +
+			    dst_vcpu->run->io.data_offset);
+	TEST_ASSERT_EQ(data, 1);
+
+	tdx_run(dst_vcpu);
+	tdx_test_assert_io(dst_vcpu, TDX_IOEXIT_TEST_PORT, 1,
+			   PORT_WRITE);
+	data = *(uint8_t *)((void *)dst_vcpu->run +
+			    dst_vcpu->run->io.data_offset);
+	TEST_ASSERT_EQ(data, 2);
+
+	tdx_run(dst_vcpu);
+	tdx_test_assert_success(dst_vcpu);
+
+	kvm_vm_free(dst_vm);
+
+	printf("\t ... PASSED\n");
+}
+
+static void test_tdx_migrate_running_vm(void)
+{
+	struct kvm_vm *src_vm;
+	struct kvm_vm *dst_vm;
+	struct kvm_vcpu *src_vcpu;
+	struct kvm_vcpu *dst_vcpu;
+	uint32_t data;
+
+	printf("Verifying migration of a running VM:\n");
+
+	src_vm = td_create();
+	td_initialize(src_vm, VM_MEM_SRC_ANONYMOUS, 0);
+	src_vcpu = td_vcpu_add(src_vm, 0, guest_code);
+	td_finalize(src_vm);
+
+	dst_vm = td_create();
+	tdx_enable_capabilities(dst_vm);
+	dst_vcpu = vm_vcpu_recreate(dst_vm, 0);
+
+	tdx_run(src_vcpu);
+	tdx_test_assert_io(src_vcpu, TDX_IOEXIT_TEST_PORT, 1,
+			   PORT_WRITE);
+	data = *(uint8_t *)((void *)src_vcpu->run +
+			    src_vcpu->run->io.data_offset);
+	TEST_ASSERT_EQ(data, 1);
+
+	tdx_migrate_from(dst_vm, src_vm);
+
+	kvm_vm_free(src_vm);
+
+	tdx_run(dst_vcpu);
+	tdx_test_assert_io(dst_vcpu, TDX_IOEXIT_TEST_PORT, 1,
+			   PORT_WRITE);
+	data = *(uint8_t *)((void *)dst_vcpu->run +
+			    dst_vcpu->run->io.data_offset);
+	TEST_ASSERT_EQ(data, 2);
+
+	tdx_run(dst_vcpu);
+	tdx_test_assert_success(dst_vcpu);
+
+	kvm_vm_free(dst_vm);
+
+	printf("\t ... PASSED\n");
+}
+
+#define TDX_SHARED_MEM_TEST_PRIVATE_GVA (0x80000000)
+#define TDX_SHARED_MEM_TEST_VADDR_SHARED_MASK BIT_ULL(30)
+#define TDX_SHARED_MEM_TEST_SHARED_GVA     \
+	(TDX_SHARED_MEM_TEST_PRIVATE_GVA | \
+	 TDX_SHARED_MEM_TEST_VADDR_SHARED_MASK)
+
+#define TDX_SHARED_MEM_TEST_PRIVATE_VALUE (100)
+#define TDX_SHARED_MEM_TEST_SHARED_VALUE (200)
+#define TDX_SHARED_MEM_TEST_DIFF_VALUE (1)
+
+
+static uint64_t test_mem_private_gpa;
+static uint64_t test_mem_shared_gpa;
+
+void guest_with_shared_mem(void)
+{
+	uint64_t *test_mem_shared_gva =
+		(uint64_t *)TDX_SHARED_MEM_TEST_SHARED_GVA;
+
+	uint64_t *private_data, *shared_data;
+	uint64_t placeholder;
+	uint64_t failed_gpa;
+	uint64_t data;
+	int ret;
+
+	/* Map gpa as shared */
+	tdg_vp_vmcall_map_gpa(test_mem_shared_gpa, PAGE_SIZE,
+			      &failed_gpa);
+
+	shared_data = test_mem_shared_gva;
+	private_data = &data;
+
+	*private_data = TDX_SHARED_MEM_TEST_PRIVATE_VALUE;
+	*shared_data = TDX_SHARED_MEM_TEST_SHARED_VALUE;
+
+	ret = tdg_vp_vmcall_instruction_io(TDX_IOEXIT_TEST_PORT, 4,
+					   PORT_WRITE,
+					   private_data);
+	if (ret)
+		tdx_test_fatal_with_data(ret, __LINE__);
+
+	/* Exit so host can read shared value */
+	ret = tdg_vp_vmcall_instruction_io(TDX_IOEXIT_TEST_PORT, 4,
+					   PORT_WRITE,
+					   &placeholder);
+	if (ret)
+		tdx_test_fatal_with_data(ret, __LINE__);
+
+	*private_data += TDX_SHARED_MEM_TEST_DIFF_VALUE;
+	*shared_data += TDX_SHARED_MEM_TEST_DIFF_VALUE;
+
+	ret = tdg_vp_vmcall_instruction_io(TDX_IOEXIT_TEST_PORT, 4,
+					   PORT_WRITE,
+					   private_data);
+	if (ret)
+		tdx_test_fatal_with_data(ret, __LINE__);
+
+	/* Exit so host can read shared value */
+	ret = tdg_vp_vmcall_instruction_io(TDX_IOEXIT_TEST_PORT, 4,
+					   PORT_WRITE,
+					   &placeholder);
+	if (ret)
+		tdx_test_fatal_with_data(ret, __LINE__);
+
+	tdx_test_success();
+}
+
+static void test_tdx_migrate_vm_with_shared_mem(void)
+{
+	uint32_t private_data;
+	vm_vaddr_t test_mem_private_gva;
+	uint32_t *test_mem_hva;
+	struct kvm_vm *src_vm;
+	struct kvm_vm *dst_vm;
+	struct kvm_vcpu *src_vcpu;
+	struct kvm_vcpu *dst_vcpu;
+
+	printf("Verifying migration of a VM with shared memory:\n");
+
+	src_vm = td_create();
+	td_initialize(src_vm, VM_MEM_SRC_ANONYMOUS, 0);
+	src_vcpu = td_vcpu_add(src_vm, 0, guest_with_shared_mem);
+
+	/*
+	 * Set up shared memory page for testing by first allocating as private
+	 * and then mapping the same GPA again as shared. This way, the TD does
+	 * not have to remap its page tables at runtime.
+	 */
+	test_mem_private_gva = vm_vaddr_alloc(src_vm, src_vm->page_size,
+					      TDX_SHARED_MEM_TEST_PRIVATE_GVA);
+	TEST_ASSERT_EQ(test_mem_private_gva, TDX_SHARED_MEM_TEST_PRIVATE_GVA);
+
+	test_mem_hva = addr_gva2hva(src_vm, test_mem_private_gva);
+	TEST_ASSERT(test_mem_hva != NULL,
+		    "Guest address not found in guest memory regions\n");
+
+	test_mem_private_gpa = addr_gva2gpa(src_vm, test_mem_private_gva);
+	virt_map_shared(src_vm, TDX_SHARED_MEM_TEST_SHARED_GVA,
+			test_mem_private_gpa, 1);
+
+	test_mem_shared_gpa = test_mem_private_gpa | src_vm->arch.s_bit;
+	sync_global_to_guest(src_vm, test_mem_shared_gpa);
+
+	td_finalize(src_vm);
+
+	dst_vm = td_create();
+	tdx_enable_capabilities(dst_vm);
+	dst_vcpu = vm_vcpu_recreate(dst_vm, 0);
+
+	vm_enable_cap(src_vm, KVM_CAP_EXIT_HYPERCALL,
+		      BIT_ULL(KVM_HC_MAP_GPA_RANGE));
+
+	printf("Verifying shared memory accesses for TDX\n");
+
+	/* Begin guest execution; guest writes to shared memory. */
+	printf("\t ... Starting guest execution\n");
+
+	/* Handle map gpa as shared */
+	tdx_run(src_vcpu);
+
+	tdx_run(src_vcpu);
+	tdx_test_assert_io(src_vcpu, TDX_IOEXIT_TEST_PORT, 4, PORT_WRITE);
+	TEST_ASSERT_EQ(*(uint32_t *)((void *)src_vcpu->run +
+				     src_vcpu->run->io.data_offset),
+		       TDX_SHARED_MEM_TEST_PRIVATE_VALUE);
+
+	tdx_run(src_vcpu);
+	tdx_test_assert_io(src_vcpu, TDX_IOEXIT_TEST_PORT, 4, PORT_WRITE);
+	TEST_ASSERT_EQ(*test_mem_hva, TDX_SHARED_MEM_TEST_SHARED_VALUE);
+
+	tdx_migrate_from(dst_vm, src_vm);
+
+	kvm_vm_free(src_vm);
+
+	tdx_run(dst_vcpu);
+	tdx_test_assert_io(dst_vcpu, TDX_IOEXIT_TEST_PORT, 4,
+			   PORT_WRITE);
+	private_data = *(uint32_t *)((void *)dst_vcpu->run +
+				     dst_vcpu->run->io.data_offset);
+	TEST_ASSERT_EQ(private_data, TDX_SHARED_MEM_TEST_PRIVATE_VALUE +
+		       TDX_SHARED_MEM_TEST_DIFF_VALUE);
+
+	tdx_run(dst_vcpu);
+	tdx_test_assert_io(dst_vcpu, TDX_IOEXIT_TEST_PORT, 4,
+			   PORT_WRITE);
+	TEST_ASSERT_EQ(*test_mem_hva, TDX_SHARED_MEM_TEST_SHARED_VALUE +
+		       TDX_SHARED_MEM_TEST_DIFF_VALUE);
+
+	tdx_run(dst_vcpu);
+	tdx_test_assert_success(dst_vcpu);
+
+	kvm_vm_free(dst_vm);
+
+	printf("\t ... PASSED\n");
+}
+
+void guest_code_empty(void)
+{
+	tdx_test_success();
+}
+
+static void test_tdx_migrate_multiple_vms(void)
+{
+	struct kvm_vm *src_vm;
+	struct kvm_vm *dst_vms[NR_MIGRATE_TEST_VMS];
+	int i, ret;
+
+	printf("Verifying migration between multiple VMs:\n");
+
+	src_vm = td_create();
+	td_initialize(src_vm, VM_MEM_SRC_ANONYMOUS, 0);
+	td_vcpu_add(src_vm, 0, guest_code_empty);
+	td_finalize(src_vm);
+
+	for (i = 0; i < NR_MIGRATE_TEST_VMS; ++i) {
+		dst_vms[i] = td_create();
+		tdx_enable_capabilities(dst_vms[i]);
+		vm_vcpu_recreate(dst_vms[i], 0);
+	}
+
+	/* Initial migration from the src to the first dst. */
+	tdx_migrate_from(dst_vms[0], src_vm);
+
+	for (i = 1; i < NR_MIGRATE_TEST_VMS; i++)
+		tdx_migrate_from(dst_vms[i], dst_vms[i - 1]);
+
+	/* Migrate the guest back to the original VM. */
+	ret = __tdx_migrate_from(src_vm->fd,
+				 dst_vms[NR_MIGRATE_TEST_VMS - 1]->fd);
+	TEST_ASSERT(ret == -1 && errno == EIO,
+		    "VM that was migrated from should be dead. ret %d, errno: %d\n",
+		    ret, errno);
+
+	kvm_vm_free(src_vm);
+	for (i = 0; i < NR_MIGRATE_TEST_VMS; ++i)
+		kvm_vm_free(dst_vms[i]);
+
+	printf("\t ... PASSED\n");
+}
+
+int main(int argc, char *argv[])
+{
+	if (!is_tdx_enabled()) {
+		print_skip("TDX is not supported by the KVM");
+		exit(KSFT_SKIP);
+	}
+
+	run_in_new_process(&test_tdx_migrate_vm_with_private_memory);
+	run_in_new_process(&test_tdx_migrate_running_vm);
+	run_in_new_process(&test_tdx_migrate_vm_with_shared_mem);
+	run_in_new_process(&test_tdx_migrate_multiple_vms);
+
+	return 0;
+}
-- 
2.50.0.rc1.591.g9c95f17f64-goog


