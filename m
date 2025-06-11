Return-Path: <linux-kselftest+bounces-34766-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D35BAD6106
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 23:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00EAB16540A
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 21:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0CB25291F;
	Wed, 11 Jun 2025 21:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RRR0bdHH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7D724C68D
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 21:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749676630; cv=none; b=sXuGlySoyvRwGzfHzuD427JK3lFjWWsC9k2MJDSRFKaPIZeB7eZpqx8rP4TcuCnpBWcC5krLs8y54UQAyJrFgylu/LtnNkEL6BetBQl4HbpPXW/e9H2XGRGAXVLommhFND9c+g3QDl3NYxnO9DSmCx3bHDSs7NrgRHq6JcDGk74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749676630; c=relaxed/simple;
	bh=E1J5NvWvWAj9PK8Bj/QCV4SungXm4iyN66KAsLSKFdw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ViK+YgXzg+qPpqg/207jlXhKrGEb34Co2AmBDT2Vre+kFunRXz8al57RX7OMwYIP/I29rSi3OTpxwGhw1ylWXdIXQvK7HysKlE3kqsG8Pv4MMMNdgMpuXgXqGB/pzOJGDYYcH9+gtSvNl/yIInOVoOVsO01e7zsKQa3hOursce4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RRR0bdHH; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2354ba59eb6so3359145ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 14:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749676627; x=1750281427; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QRxvuTFismoVMH6kpT5Sxdu0Bq/4xhAKlCPWJnUhYZA=;
        b=RRR0bdHHF6eDnTUFrWPl04OZfdCXYpLxNz4Nd+3TbL2dyZZ5k9iv1uBJvnVZk04q+M
         2M9tKoVhSTcHhGYgWn41jI8AmN1AUssmutEtp4Cj7qvYzI8K0Te/68aI2qjfHt7JziBs
         hDsO8zr5AiAo5UDAncgM0DpZAq8EoiT+BIOoU0anA7duhZdyadEOJK2nOhh3khXPjXqM
         LezVO3ikWz87q1BRpArrBuLvk363hxKNPjv85lYFHyTEN2V3FhcOm1bZkN8iUxZvw1Fj
         cJsAAGJJHZ+rJ2hMQmyqfEtG/K3j6TwsdsYeTY1gzEPS/r9lKsoKZfgyLWnXPIaefYvP
         toGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749676627; x=1750281427;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QRxvuTFismoVMH6kpT5Sxdu0Bq/4xhAKlCPWJnUhYZA=;
        b=MO1qo6HsFkr8oOka9EHd1NjdNWz9luRcJPMaTevqMM/m6dbW8qwlFPWgp0Z0injqPJ
         ixfr863MqDkHG+DnKTS/0YNfZarW7nrLDKxqjX2H+NRxwJFxXNswkuftBolyWCL1N7dg
         UVORgYuqSuk9PgeTmqVr2Y+D5R5iH+0uJuWK6QQ9JPqCXeTfp+OKkjpRfYbddRz/yjF/
         JTCrvmwRkhmCVl9AeKLtH3ZXmqC9MT7oDyHR6DEJegbNxKOaiPBnY7j1ewveFARxw04U
         lMc6ppJakG7udDCQUX4jhvmmcxyaZaooz92ZVJ5nR35bM6GSjR5D5g3HXSIJ7GlvdJcd
         gJyw==
X-Forwarded-Encrypted: i=1; AJvYcCXe47CcD2PPdGo1sscJK5OPMyXBzQODuYQ6xEqBo9AUF21rcDkW+kYh3rmg74UMEoprZby2ua+PZADibiu/sG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTzOINeeqF8TEO21D/QiQv1QtSavQRWyTzFjtOjFnpEmFxfBXt
	LbwpN4Oswq2cAln7VLVkdDKOeDkOm4QxPHtjAwPKE41V4rPXeprF3X2Q9hs1/DWsslCs7bhJFtS
	wUVs85Ux5Wg==
X-Google-Smtp-Source: AGHT+IGH5noWtFNaTsbN875vKa4LJH+6nipS2I+HvnDRFXrBbmRj/sTqaIhQjDr9GIyLPz+Si3nAHutYaq+4
X-Received: from pldg6.prod.google.com ([2002:a17:903:3a86:b0:235:6d5:688b])
 (user=afranji job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4d0:b0:235:27b6:a891
 with SMTP id d9443c01a7336-2364ca469aamr16477225ad.28.1749676627115; Wed, 11
 Jun 2025 14:17:07 -0700 (PDT)
Date: Wed, 11 Jun 2025 21:16:34 +0000
In-Reply-To: <cover.1749672978.git.afranji@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1749672978.git.afranji@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <75edc2c08a63316135ddf59d0961f1fadbe2e264.1749672978.git.afranji@google.com>
Subject: [RFC PATCH v2 07/10] KVM: selftests: Refactor userspace_mem_region
 creation out of vm_mem_add
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

Refactor the creation and committing of userspace_mem_region to their
own functions so that they can reused by future TDX migration functions.

Signed-off-by: Ryan Afranji <afranji@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 147 +++++++++++++--------
 1 file changed, 89 insertions(+), 58 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 2b442639ee2d..3c131718b81a 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -974,50 +974,47 @@ void vm_set_user_memory_region2(struct kvm_vm *vm, uint32_t slot, uint32_t flags
 		    errno, strerror(errno));
 }
 
-
-/* FIXME: This thing needs to be ripped apart and rewritten. */
-void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
-		uint64_t guest_paddr, uint32_t slot, uint64_t npages,
-		uint32_t flags, int guest_memfd, uint64_t guest_memfd_offset)
+static struct userspace_mem_region *vm_mem_region_alloc(struct kvm_vm *vm,
+								uint64_t guest_paddr,
+								uint32_t slot,
+								size_t npages,
+								uint32_t flags)
 {
-	int ret;
 	struct userspace_mem_region *region;
-	size_t backing_src_pagesz = get_backing_src_pagesz(src_type);
-	size_t mem_size = npages * vm->page_size;
-	size_t alignment;
 
 	TEST_REQUIRE_SET_USER_MEMORY_REGION2();
 
 	TEST_ASSERT(vm_adjust_num_guest_pages(vm->mode, npages) == npages,
-		"Number of guest pages is not compatible with the host. "
-		"Try npages=%d", vm_adjust_num_guest_pages(vm->mode, npages));
+		    "Number of guest pages is not compatible with the host. "
+		    "Try npages=%d", vm_adjust_num_guest_pages(vm->mode, npages));
 
 	TEST_ASSERT((guest_paddr % vm->page_size) == 0, "Guest physical "
-		"address not on a page boundary.\n"
-		"  guest_paddr: 0x%lx vm->page_size: 0x%x",
-		guest_paddr, vm->page_size);
+		    "address not on a page boundary.\n"
+		    "  guest_paddr: 0x%lx vm->page_size: 0x%x",
+		    guest_paddr, vm->page_size);
 	TEST_ASSERT((((guest_paddr >> vm->page_shift) + npages) - 1)
-		<= vm->max_gfn, "Physical range beyond maximum "
-		"supported physical address,\n"
-		"  guest_paddr: 0x%lx npages: 0x%lx\n"
-		"  vm->max_gfn: 0x%lx vm->page_size: 0x%x",
-		guest_paddr, npages, vm->max_gfn, vm->page_size);
+		    <= vm->max_gfn, "Physical range beyond maximum "
+		    "supported physical address,\n"
+		    "  guest_paddr: 0x%lx npages: 0x%lx\n"
+		    "  vm->max_gfn: 0x%lx vm->page_size: 0x%x",
+		    guest_paddr, npages, vm->max_gfn, vm->page_size);
 
 	/*
 	 * Confirm a mem region with an overlapping address doesn't
 	 * already exist.
 	 */
 	region = (struct userspace_mem_region *) userspace_mem_region_find(
-		vm, guest_paddr, (guest_paddr + npages * vm->page_size) - 1);
+			vm, guest_paddr,
+			(guest_paddr + npages * vm->page_size) - 1);
 	if (region != NULL)
 		TEST_FAIL("overlapping userspace_mem_region already "
-			"exists\n"
-			"  requested guest_paddr: 0x%lx npages: 0x%lx "
-			"page_size: 0x%x\n"
-			"  existing guest_paddr: 0x%lx size: 0x%lx",
-			guest_paddr, npages, vm->page_size,
-			(uint64_t) region->region.guest_phys_addr,
-			(uint64_t) region->region.memory_size);
+			  "exists\n"
+			  "  requested guest_paddr: 0x%lx npages: 0x%lx "
+			  "page_size: 0x%x\n"
+			  "  existing guest_paddr: 0x%lx size: 0x%lx",
+			  guest_paddr, npages, vm->page_size,
+			  (uint64_t) region->region.guest_phys_addr,
+			  (uint64_t) region->region.memory_size);
 
 	/* Confirm no region with the requested slot already exists. */
 	hash_for_each_possible(vm->regions.slot_hash, region, slot_node,
@@ -1026,19 +1023,73 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 			continue;
 
 		TEST_FAIL("A mem region with the requested slot "
-			"already exists.\n"
-			"  requested slot: %u paddr: 0x%lx npages: 0x%lx\n"
-			"  existing slot: %u paddr: 0x%lx size: 0x%lx",
-			slot, guest_paddr, npages,
-			region->region.slot,
-			(uint64_t) region->region.guest_phys_addr,
-			(uint64_t) region->region.memory_size);
+			  "already exists.\n"
+			  "  requested slot: %u paddr: 0x%lx npages: 0x%lx\n"
+			  "  existing slot: %u paddr: 0x%lx size: 0x%lx",
+			  slot, guest_paddr, npages,
+			  region->region.slot,
+			  (uint64_t) region->region.guest_phys_addr,
+			  (uint64_t) region->region.memory_size);
 	}
 
 	/* Allocate and initialize new mem region structure. */
 	region = calloc(1, sizeof(*region));
 	TEST_ASSERT(region != NULL, "Insufficient Memory");
-	region->mmap_size = mem_size;
+
+	region->unused_phy_pages = sparsebit_alloc();
+	if (vm_arch_has_protected_memory(vm))
+		region->protected_phy_pages = sparsebit_alloc();
+	sparsebit_set_num(region->unused_phy_pages,
+			  guest_paddr >> vm->page_shift, npages);
+	region->region.slot = slot;
+	region->region.flags = flags;
+	region->region.guest_phys_addr = guest_paddr;
+	region->region.memory_size = npages * vm->page_size;
+
+	region->mmap_start = NULL;
+	region->mmap_size = 0;
+	region->host_mem = NULL;
+	region->fd = -1;
+
+	return region;
+}
+
+static void userspace_mem_region_commit(struct kvm_vm *vm,
+					struct userspace_mem_region *region)
+{
+	int ret;
+
+	region->region.userspace_addr = (uintptr_t) region->host_mem;
+	ret = __vm_ioctl(vm, KVM_SET_USER_MEMORY_REGION2, &region->region);
+	TEST_ASSERT(ret == 0, "KVM_SET_USER_MEMORY_REGION2 IOCTL failed,\n"
+		    "  rc: %i errno: %i\n"
+		    "  slot: %u flags: 0x%x\n"
+		    "  guest_phys_addr: 0x%lx size: 0x%lx guest_memfd: %d",
+		    ret, errno, region->region.slot, region->region.flags,
+		    (uint64_t) region->region.guest_phys_addr,
+		    (uint64_t) region->region.memory_size,
+		    region->region.guest_memfd);
+
+	/* Add to quick lookup data structures */
+	vm_userspace_mem_region_gpa_insert(&vm->regions.gpa_tree, region);
+	vm_userspace_mem_region_hva_insert(&vm->regions.hva_tree, region);
+	hash_add(vm->regions.slot_hash, &region->slot_node,
+		 region->region.slot);
+}
+
+/* FIXME: This thing needs to be ripped apart and rewritten. */
+void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
+		uint64_t guest_paddr, uint32_t slot, uint64_t npages,
+		uint32_t flags, int guest_memfd, uint64_t guest_memfd_offset)
+{
+	int ret;
+	struct userspace_mem_region *region;
+	size_t backing_src_pagesz = get_backing_src_pagesz(src_type);
+	size_t mem_size = npages * vm->page_size;
+	size_t alignment;
+
+	region = vm_mem_region_alloc(vm, guest_paddr, slot, npages,
+					     flags);
 
 #ifdef __s390x__
 	/* On s390x, the host address must be aligned to 1M (due to PGSTEs) */
@@ -1058,6 +1109,8 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 
 	TEST_ASSERT_EQ(guest_paddr, align_up(guest_paddr, backing_src_pagesz));
 
+	region->mmap_size = mem_size;
+
 	/* Add enough memory to align up if necessary */
 	if (alignment > 1)
 		region->mmap_size += alignment;
@@ -1117,29 +1170,7 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 		region->region.guest_memfd = -1;
 	}
 
-	region->unused_phy_pages = sparsebit_alloc();
-	if (vm_arch_has_protected_memory(vm))
-		region->protected_phy_pages = sparsebit_alloc();
-	sparsebit_set_num(region->unused_phy_pages,
-		guest_paddr >> vm->page_shift, npages);
-	region->region.slot = slot;
-	region->region.flags = flags;
-	region->region.guest_phys_addr = guest_paddr;
-	region->region.memory_size = npages * vm->page_size;
-	region->region.userspace_addr = (uintptr_t) region->host_mem;
-	ret = __vm_ioctl(vm, KVM_SET_USER_MEMORY_REGION2, &region->region);
-	TEST_ASSERT(ret == 0, "KVM_SET_USER_MEMORY_REGION2 IOCTL failed,\n"
-		"  rc: %i errno: %i\n"
-		"  slot: %u flags: 0x%x\n"
-		"  guest_phys_addr: 0x%lx size: 0x%lx guest_memfd: %d",
-		ret, errno, slot, flags,
-		guest_paddr, (uint64_t) region->region.memory_size,
-		region->region.guest_memfd);
-
-	/* Add to quick lookup data structures */
-	vm_userspace_mem_region_gpa_insert(&vm->regions.gpa_tree, region);
-	vm_userspace_mem_region_hva_insert(&vm->regions.hva_tree, region);
-	hash_add(vm->regions.slot_hash, &region->slot_node, slot);
+	userspace_mem_region_commit(vm, region);
 
 	/* If shared memory, create an alias. */
 	if (region->fd >= 0) {
-- 
2.50.0.rc1.591.g9c95f17f64-goog


