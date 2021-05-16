Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F03B382068
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 May 2021 20:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhEPSkO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 16 May 2021 14:40:14 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:43132 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229490AbhEPSkO (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 16 May 2021 14:40:14 -0400
Received: from MUA
        by vps-vb.mhejs.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1liLf3-0007Sk-Gk; Sun, 16 May 2021 20:38:45 +0200
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2 1/2] KVM: selftests: Keep track of memslots more efficiently
Date:   Sun, 16 May 2021 20:38:38 +0200
Message-Id: <7f739f0bd675ed34ce6fceec16c13deaa789f2fd.1621190044.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

The KVM selftest framework was using a simple list for keeping track of
the memslots currently in use.
This resulted in lookups and adding a single memslot being O(n), the
later due to linear scanning of the existing memslot set to check for
the presence of any conflicting entries.

Before this change, benchmarking high count of memslots was more or less
impossible as pretty much all the benchmark time was spent in the
selftest framework code.

We can simply use a rbtree for keeping track of both of gfn and hva.
We don't need an interval tree for hva here as we can't have overlapping
memslots because we allocate a completely new memory chunk for each new
memslot.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
---

This is just a resend of this patch without any changes.

 tools/testing/selftests/kvm/Makefile          |   2 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    | 141 ++++++++++++++----
 .../selftests/kvm/lib/kvm_util_internal.h     |  15 +-
 tools/testing/selftests/kvm/lib/rbtree.c      |   1 +
 4 files changed, 124 insertions(+), 35 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/lib/rbtree.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index e439d027939d..a8c30f888d40 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -33,7 +33,7 @@ ifeq ($(ARCH),s390)
 	UNAME_M := s390x
 endif
 
-LIBKVM = lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/sparsebit.c lib/test_util.c lib/guest_modes.c lib/perf_test_util.c
+LIBKVM = lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/rbtree.c lib/sparsebit.c lib/test_util.c lib/guest_modes.c lib/perf_test_util.c
 LIBKVM_x86_64 = lib/x86_64/processor.c lib/x86_64/vmx.c lib/x86_64/svm.c lib/x86_64/ucall.c lib/x86_64/handlers.S
 LIBKVM_aarch64 = lib/aarch64/processor.c lib/aarch64/ucall.c
 LIBKVM_s390x = lib/s390x/processor.c lib/s390x/ucall.c lib/s390x/diag318_test_handler.c
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index fc83f6c5902d..646e94cc101b 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -203,7 +203,9 @@ struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm)
 	TEST_ASSERT(vm != NULL, "Insufficient Memory");
 
 	INIT_LIST_HEAD(&vm->vcpus);
-	INIT_LIST_HEAD(&vm->userspace_mem_regions);
+	vm->regions.gpa_tree = RB_ROOT;
+	vm->regions.hva_tree = RB_ROOT;
+	hash_init(vm->regions.slot_hash);
 
 	vm->mode = mode;
 	vm->type = 0;
@@ -355,13 +357,14 @@ struct kvm_vm *vm_create_default(uint32_t vcpuid, uint64_t extra_mem_pages,
  */
 void kvm_vm_restart(struct kvm_vm *vmp, int perm)
 {
+	int ctr;
 	struct userspace_mem_region *region;
 
 	vm_open(vmp, perm);
 	if (vmp->has_irqchip)
 		vm_create_irqchip(vmp);
 
-	list_for_each_entry(region, &vmp->userspace_mem_regions, list) {
+	hash_for_each(vmp->regions.slot_hash, ctr, region, slot_node) {
 		int ret = ioctl(vmp->fd, KVM_SET_USER_MEMORY_REGION, &region->region);
 		TEST_ASSERT(ret == 0, "KVM_SET_USER_MEMORY_REGION IOCTL failed,\n"
 			    "  rc: %i errno: %i\n"
@@ -424,14 +427,21 @@ uint32_t kvm_vm_reset_dirty_ring(struct kvm_vm *vm)
 static struct userspace_mem_region *
 userspace_mem_region_find(struct kvm_vm *vm, uint64_t start, uint64_t end)
 {
-	struct userspace_mem_region *region;
+	struct rb_node *node;
 
-	list_for_each_entry(region, &vm->userspace_mem_regions, list) {
+	for (node = vm->regions.gpa_tree.rb_node; node; ) {
+		struct userspace_mem_region *region =
+			container_of(node, struct userspace_mem_region, gpa_node);
 		uint64_t existing_start = region->region.guest_phys_addr;
 		uint64_t existing_end = region->region.guest_phys_addr
 			+ region->region.memory_size - 1;
 		if (start <= existing_end && end >= existing_start)
 			return region;
+
+		if (start < existing_start)
+			node = node->rb_left;
+		else
+			node = node->rb_right;
 	}
 
 	return NULL;
@@ -546,11 +556,16 @@ void kvm_vm_release(struct kvm_vm *vmp)
 }
 
 static void __vm_mem_region_delete(struct kvm_vm *vm,
-				   struct userspace_mem_region *region)
+				   struct userspace_mem_region *region,
+				   bool unlink)
 {
 	int ret;
 
-	list_del(&region->list);
+	if (unlink) {
+		rb_erase(&region->gpa_node, &vm->regions.gpa_tree);
+		rb_erase(&region->hva_node, &vm->regions.hva_tree);
+		hash_del(&region->slot_node);
+	}
 
 	region->region.memory_size = 0;
 	ret = ioctl(vm->fd, KVM_SET_USER_MEMORY_REGION, &region->region);
@@ -569,14 +584,16 @@ static void __vm_mem_region_delete(struct kvm_vm *vm,
  */
 void kvm_vm_free(struct kvm_vm *vmp)
 {
-	struct userspace_mem_region *region, *tmp;
+	int ctr;
+	struct hlist_node *node;
+	struct userspace_mem_region *region;
 
 	if (vmp == NULL)
 		return;
 
 	/* Free userspace_mem_regions. */
-	list_for_each_entry_safe(region, tmp, &vmp->userspace_mem_regions, list)
-		__vm_mem_region_delete(vmp, region);
+	hash_for_each_safe(vmp->regions.slot_hash, ctr, node, region, slot_node)
+		__vm_mem_region_delete(vmp, region, false);
 
 	/* Free sparsebit arrays. */
 	sparsebit_free(&vmp->vpages_valid);
@@ -658,6 +675,57 @@ int kvm_memcmp_hva_gva(void *hva, struct kvm_vm *vm, vm_vaddr_t gva, size_t len)
 	return 0;
 }
 
+static void vm_userspace_mem_region_gpa_insert(struct rb_root *gpa_tree,
+					       struct userspace_mem_region *region)
+{
+	struct rb_node **cur, *parent;
+
+	for (cur = &gpa_tree->rb_node, parent = NULL; *cur; ) {
+		struct userspace_mem_region *cregion;
+
+		cregion = container_of(*cur, typeof(*cregion), gpa_node);
+		parent = *cur;
+		if (region->region.guest_phys_addr <
+		    cregion->region.guest_phys_addr)
+			cur = &(*cur)->rb_left;
+		else {
+			TEST_ASSERT(region->region.guest_phys_addr !=
+				    cregion->region.guest_phys_addr,
+				    "Duplicate GPA in region tree");
+
+			cur = &(*cur)->rb_right;
+		}
+	}
+
+	rb_link_node(&region->gpa_node, parent, cur);
+	rb_insert_color(&region->gpa_node, gpa_tree);
+}
+
+static void vm_userspace_mem_region_hva_insert(struct rb_root *hva_tree,
+					       struct userspace_mem_region *region)
+{
+	struct rb_node **cur, *parent;
+
+	for (cur = &hva_tree->rb_node, parent = NULL; *cur; ) {
+		struct userspace_mem_region *cregion;
+
+		cregion = container_of(*cur, typeof(*cregion), hva_node);
+		parent = *cur;
+		if (region->host_mem < cregion->host_mem)
+			cur = &(*cur)->rb_left;
+		else {
+			TEST_ASSERT(region->host_mem !=
+				    cregion->host_mem,
+				    "Duplicate HVA in region tree");
+
+			cur = &(*cur)->rb_right;
+		}
+	}
+
+	rb_link_node(&region->hva_node, parent, cur);
+	rb_insert_color(&region->hva_node, hva_tree);
+}
+
 /*
  * VM Userspace Memory Region Add
  *
@@ -722,7 +790,8 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 			(uint64_t) region->region.memory_size);
 
 	/* Confirm no region with the requested slot already exists. */
-	list_for_each_entry(region, &vm->userspace_mem_regions, list) {
+	hash_for_each_possible(vm->regions.slot_hash, region, slot_node,
+			       slot) {
 		if (region->region.slot != slot)
 			continue;
 
@@ -793,8 +862,10 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 		ret, errno, slot, flags,
 		guest_paddr, (uint64_t) region->region.memory_size);
 
-	/* Add to linked-list of memory regions. */
-	list_add(&region->list, &vm->userspace_mem_regions);
+	/* Add to quick lookup data structures */
+	vm_userspace_mem_region_gpa_insert(&vm->regions.gpa_tree, region);
+	vm_userspace_mem_region_hva_insert(&vm->regions.hva_tree, region);
+	hash_add(vm->regions.slot_hash, &region->slot_node, slot);
 }
 
 /*
@@ -817,10 +888,10 @@ memslot2region(struct kvm_vm *vm, uint32_t memslot)
 {
 	struct userspace_mem_region *region;
 
-	list_for_each_entry(region, &vm->userspace_mem_regions, list) {
+	hash_for_each_possible(vm->regions.slot_hash, region, slot_node,
+			       memslot)
 		if (region->region.slot == memslot)
 			return region;
-	}
 
 	fprintf(stderr, "No mem region with the requested slot found,\n"
 		"  requested slot: %u\n", memslot);
@@ -905,7 +976,7 @@ void vm_mem_region_move(struct kvm_vm *vm, uint32_t slot, uint64_t new_gpa)
  */
 void vm_mem_region_delete(struct kvm_vm *vm, uint32_t slot)
 {
-	__vm_mem_region_delete(vm, memslot2region(vm, slot));
+	__vm_mem_region_delete(vm, memslot2region(vm, slot), true);
 }
 
 /*
@@ -1177,16 +1248,14 @@ void *addr_gpa2hva(struct kvm_vm *vm, vm_paddr_t gpa)
 {
 	struct userspace_mem_region *region;
 
-	list_for_each_entry(region, &vm->userspace_mem_regions, list) {
-		if ((gpa >= region->region.guest_phys_addr)
-			&& (gpa <= (region->region.guest_phys_addr
-				+ region->region.memory_size - 1)))
-			return (void *) ((uintptr_t) region->host_mem
-				+ (gpa - region->region.guest_phys_addr));
+	region = userspace_mem_region_find(vm, gpa, gpa);
+	if (!region) {
+		TEST_FAIL("No vm physical memory at 0x%lx", gpa);
+		return NULL;
 	}
 
-	TEST_FAIL("No vm physical memory at 0x%lx", gpa);
-	return NULL;
+	return (void *)((uintptr_t)region->host_mem
+		+ (gpa - region->region.guest_phys_addr));
 }
 
 /*
@@ -1208,15 +1277,22 @@ void *addr_gpa2hva(struct kvm_vm *vm, vm_paddr_t gpa)
  */
 vm_paddr_t addr_hva2gpa(struct kvm_vm *vm, void *hva)
 {
-	struct userspace_mem_region *region;
+	struct rb_node *node;
+
+	for (node = vm->regions.hva_tree.rb_node; node; ) {
+		struct userspace_mem_region *region =
+			container_of(node, struct userspace_mem_region, hva_node);
+
+		if (hva >= region->host_mem) {
+			if (hva <= (region->host_mem
+				+ region->region.memory_size - 1))
+				return (vm_paddr_t)((uintptr_t)
+					region->region.guest_phys_addr
+					+ (hva - (uintptr_t)region->host_mem));
 
-	list_for_each_entry(region, &vm->userspace_mem_regions, list) {
-		if ((hva >= region->host_mem)
-			&& (hva <= (region->host_mem
-				+ region->region.memory_size - 1)))
-			return (vm_paddr_t) ((uintptr_t)
-				region->region.guest_phys_addr
-				+ (hva - (uintptr_t) region->host_mem));
+			node = node->rb_right;
+		} else
+			node = node->rb_left;
 	}
 
 	TEST_FAIL("No mapping to a guest physical address, hva: %p", hva);
@@ -1822,6 +1898,7 @@ int kvm_device_access(int dev_fd, uint32_t group, uint64_t attr,
  */
 void vm_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
 {
+	int ctr;
 	struct userspace_mem_region *region;
 	struct vcpu *vcpu;
 
@@ -1829,7 +1906,7 @@ void vm_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
 	fprintf(stream, "%*sfd: %i\n", indent, "", vm->fd);
 	fprintf(stream, "%*spage_size: 0x%x\n", indent, "", vm->page_size);
 	fprintf(stream, "%*sMem Regions:\n", indent, "");
-	list_for_each_entry(region, &vm->userspace_mem_regions, list) {
+	hash_for_each(vm->regions.slot_hash, ctr, region, slot_node) {
 		fprintf(stream, "%*sguest_phys: 0x%lx size: 0x%lx "
 			"host_virt: %p\n", indent + 2, "",
 			(uint64_t) region->region.guest_phys_addr,
diff --git a/tools/testing/selftests/kvm/lib/kvm_util_internal.h b/tools/testing/selftests/kvm/lib/kvm_util_internal.h
index 91ce1b5d480b..b30e8c7b119b 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util_internal.h
+++ b/tools/testing/selftests/kvm/lib/kvm_util_internal.h
@@ -8,6 +8,9 @@
 #ifndef SELFTEST_KVM_UTIL_INTERNAL_H
 #define SELFTEST_KVM_UTIL_INTERNAL_H
 
+#include "linux/hashtable.h"
+#include "linux/rbtree.h"
+
 #include "sparsebit.h"
 
 struct userspace_mem_region {
@@ -18,7 +21,9 @@ struct userspace_mem_region {
 	void *host_mem;
 	void *mmap_start;
 	size_t mmap_size;
-	struct list_head list;
+	struct rb_node gpa_node;
+	struct rb_node hva_node;
+	struct hlist_node slot_node;
 };
 
 struct vcpu {
@@ -31,6 +36,12 @@ struct vcpu {
 	uint32_t dirty_gfns_count;
 };
 
+struct userspace_mem_regions {
+	struct rb_root gpa_tree;
+	struct rb_root hva_tree;
+	DECLARE_HASHTABLE(slot_hash, 9);
+};
+
 struct kvm_vm {
 	int mode;
 	unsigned long type;
@@ -43,7 +54,7 @@ struct kvm_vm {
 	unsigned int va_bits;
 	uint64_t max_gfn;
 	struct list_head vcpus;
-	struct list_head userspace_mem_regions;
+	struct userspace_mem_regions regions;
 	struct sparsebit *vpages_valid;
 	struct sparsebit *vpages_mapped;
 	bool has_irqchip;
diff --git a/tools/testing/selftests/kvm/lib/rbtree.c b/tools/testing/selftests/kvm/lib/rbtree.c
new file mode 100644
index 000000000000..a703f0194ea3
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/rbtree.c
@@ -0,0 +1 @@
+#include "../../../../lib/rbtree.c"
