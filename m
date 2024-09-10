Return-Path: <linux-kselftest+bounces-17699-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E039746F3
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 01:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46415B25A65
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 23:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F4E1C3F2F;
	Tue, 10 Sep 2024 23:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xYQYSN+a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE471AE873
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 23:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011938; cv=none; b=n7p0pyZwlvEJtEHTxQXhg6uXCbyKI3QzjzxPeRQyG6PJXLnmifRDi/H1K0uzts/aLKPz2sTIrt8c28YGXjgMIoAj/0HXLqnuIscF/2nxb9wOJHYrGIW6ErNPzfU05jY9tVU3J/CYEo81Ezt+Sm27AUhgnjs432nhTLI4Ld/IO/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011938; c=relaxed/simple;
	bh=brvMd7lYNVEoPOiD6WGoJLKaTm8Zmz7S7jm/J3yvA4o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=csQSv2Fr09Xbhxz5SDJQhmW3yUPdrxM3DYiSDKyLpTyU4M7idiEArKkZpUPzi6ePJbmH5FjTXIm+YOn6qqNEcPx1Npy/0iQE/+vIdnUIDU3ARbzNxpntQta9jpJJ03ZflNehCmrgYUkdglktMRewUmLK0uXD1jBhQFw42tQA3LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xYQYSN+a; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-20540baca29so20923615ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 16:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726011936; x=1726616736; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f/AV4772bz9qe8Bi/YmA4hlRAWxNbxHJTt16v2vi3B8=;
        b=xYQYSN+aA02dJxaLr6S5swrFSVItqnIGX43qDVo/gByZYCunO+fUGsGYMU4seslDRv
         HNtaQVKtQrIm/B8pGHdGv86+VD+5g6RdqJ83c+g0frasR95UTIpaOjKSS1hWR9aiZEFC
         E1WokatInCNhO3tcWoaRYuQOBsiiuhmCTAt+IGdY1OR79rSE575+9he01NJxQalc6OA2
         +eHmoT/aWbOmvTF4d7avPpJbuO2uxaQMFaoZDwg7VLU9sNHrRfuO+xQlyqOCgQg1NbFd
         hH0jmcxE+bsv8xukUeMyMOs2otLbF/zjNrODkXQwovP9BOUx5UNktqgYSz2TDlXtTVyE
         U2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726011936; x=1726616736;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f/AV4772bz9qe8Bi/YmA4hlRAWxNbxHJTt16v2vi3B8=;
        b=D1n0J86QTR2tpTjMVE9rH6ZwqhYr+Wre2d7FbAhdTlaKsKVBU02Gz4JiNSGkKwGt6c
         T1CJx3XmuKteaa75TFUs93HP/BhnknIFRTozD8efNV1VHFzT+PIbaLUuCDgxsJHjtD6J
         eQx6s9i4UWpx/Lq73pH/8O5rp6bLH3rQpSsdOrORhmt66JSB3UsrUfcuDEGPuyTMSddD
         28hn0ENakdiDao/4hnIO/xnYUs5f84ESVJqy5e8rIW/1NaibpqodmCF2OmDgUPAol3u2
         AR55omDjku9gR4LKKxmow/VQStw9d4po1fwrTNEvT7JQHWRfJUvCS1PMmgXmzlZ2GNN+
         4RJg==
X-Forwarded-Encrypted: i=1; AJvYcCX20ZbWnO5pva3clCWOHXp1rZ+IAQc+Zfwdpog7pWKHdy6ARybedqFds7fAiC/tYdeEp00x8nZ/fEPmi+GvXr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydlc+XRpMpsKZOsH5jXsWsxyTcgau2h5X+/AotqNSU6JOK9KOO
	gmLIBii2/saUBcPU+037oQEWRb7hrTBM9wzYd9HrLyjG0+UFTQa1ZPUNKDUMLCFVRDZ3RTt3sr3
	Ror3T76RMq4YxmcLRdyvcSQ==
X-Google-Smtp-Source: AGHT+IHXrryjP2y/Skas2BttlctleDJukyVnmiThULgyHNQcrulpwoY9Zba1IZOLxgpQ53M3aNE5Nft3kH97eZ+fNA==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a17:902:d2ca:b0:205:799f:125e with
 SMTP id d9443c01a7336-207521f4414mr358015ad.10.1726011935717; Tue, 10 Sep
 2024 16:45:35 -0700 (PDT)
Date: Tue, 10 Sep 2024 23:44:07 +0000
In-Reply-To: <cover.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <2daf579fa5d2ba223fa3a907c1048d3ea4458a57.1726009989.git.ackerleytng@google.com>
Subject: [RFC PATCH 36/39] KVM: selftests: Refactor vm_mem_add to be more flexible
From: Ackerley Tng <ackerleytng@google.com>
To: tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk, 
	jgg@nvidia.com, peterx@redhat.com, david@redhat.com, rientjes@google.com, 
	fvdl@google.com, jthoughton@google.com, seanjc@google.com, 
	pbonzini@redhat.com, zhiquan1.li@intel.com, fan.du@intel.com, 
	jun.miao@intel.com, isaku.yamahata@intel.com, muchun.song@linux.dev, 
	mike.kravetz@oracle.com
Cc: erdemaktas@google.com, vannapurve@google.com, ackerleytng@google.com, 
	qperret@google.com, jhubbard@nvidia.com, willy@infradead.org, 
	shuah@kernel.org, brauner@kernel.org, bfoster@redhat.com, 
	kent.overstreet@linux.dev, pvorel@suse.cz, rppt@kernel.org, 
	richard.weiyang@gmail.com, anup@brainfault.org, haibo1.xu@intel.com, 
	ajones@ventanamicro.com, vkuznets@redhat.com, maciej.wieczor-retman@intel.com, 
	pgonda@google.com, oliver.upton@linux.dev, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-fsdevel@kvack.org
Content-Type: text/plain; charset="UTF-8"

enum vm_mem_backing_src_type is encoding too many different
possibilities on different axes of (1) whether to mmap from an fd, (2)
granularity of mapping for THP, (3) size of hugetlb mapping, and has
yet to be extended to support guest_memfd.

When guest_memfd supports mmap() and we also want to support testing
with mmap()ing from guest_memfd, the number of combinations make
enumeration in vm_mem_backing_src_type difficult.

This refactor separates out vm_mem_backing_src_type from
userspace_mem_region. For now, vm_mem_backing_src_type remains a
possible way for tests to specify, on the command line, the
combination of backing memory to test.

vm_mem_add() is now the last place where vm_mem_backing_src_type is
interpreted, to

1. Check validity of requested guest_paddr
2. Align mmap_size appropriately based on the mapping's page_size and
   architecture
3. Install memory appropriately according to mapping's page size

mmap()ing an alias seems to be specific to userfaultfd tests and could
be refactored out of struct userspace_mem_region and localized in
userfaultfd tests in future.

This paves the way for replacing vm_mem_backing_src_type with multiple
command line flags that would specify backing memory more
flexibly. Future tests are expected to use vm_mem_region_alloc() to
allocate a struct userspace_mem_region, then use more fundamental
functions like vm_mem_region_mmap(), vm_mem_region_madvise_thp(),
kvm_memfd_create(), vm_create_guest_memfd(), and other functions in
vm_mem_add() to flexibly build up struct userspace_mem_region before
finally adding the region to the vm with vm_mem_region_add().

Signed-off-by: Ackerley Tng <ackerleytng@google.com>

---
 .../testing/selftests/kvm/include/kvm_util.h  |  29 +-
 .../testing/selftests/kvm/include/test_util.h |   2 +
 tools/testing/selftests/kvm/lib/kvm_util.c    | 413 +++++++++++-------
 tools/testing/selftests/kvm/lib/test_util.c   |  25 ++
 4 files changed, 319 insertions(+), 150 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index d336cd0c8f19..1576e7e4aefe 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -35,11 +35,26 @@ struct userspace_mem_region {
 	struct sparsebit *protected_phy_pages;
 	int fd;
 	off_t offset;
-	enum vm_mem_backing_src_type backing_src_type;
+	/*
+	 * host_mem is mmap_start aligned upwards to an address suitable for the
+	 * architecture. In most cases, host_mem and mmap_start are the same,
+	 * except for s390x, where the host address must be aligned to 1M (due
+	 * to PGSTEs).
+	 */
+#ifdef __s390x__
+#define S390X_HOST_ADDRESS_ALIGNMENT 0x100000
+#endif
 	void *host_mem;
+	/* host_alias is to mmap_alias as host_mem is to mmap_start */
 	void *host_alias;
 	void *mmap_start;
 	void *mmap_alias;
+	/*
+	 * mmap_size is possibly larger than region.memory_size because in some
+	 * cases, host_mem has to be adjusted upwards (see comment for host_mem
+	 * above). In those cases, mmap_size has to be adjusted upwards so that
+	 * enough memory is available in this memslot.
+	 */
 	size_t mmap_size;
 	struct rb_node gpa_node;
 	struct rb_node hva_node;
@@ -559,6 +574,18 @@ int __vm_set_user_memory_region2(struct kvm_vm *vm, uint32_t slot, uint32_t flag
 				 uint64_t gpa, uint64_t size, void *hva,
 				 uint32_t guest_memfd, uint64_t guest_memfd_offset);
 
+struct userspace_mem_region *vm_mem_region_alloc(struct kvm_vm *vm);
+void *vm_mem_region_mmap(struct userspace_mem_region *region, size_t length,
+			 int flags, int fd, off_t offset);
+void vm_mem_region_install_memory(struct userspace_mem_region *region,
+				  size_t memslot_size, size_t alignment);
+void vm_mem_region_madvise_thp(struct userspace_mem_region *region, int advice);
+int vm_mem_region_install_guest_memfd(struct userspace_mem_region *region,
+				      int guest_memfd);
+void *vm_mem_region_mmap_alias(struct userspace_mem_region *region, int flags,
+			       size_t alignment);
+void vm_mem_region_add(struct kvm_vm *vm, struct userspace_mem_region *region);
+
 void vm_userspace_mem_region_add(struct kvm_vm *vm,
 	enum vm_mem_backing_src_type src_type,
 	uint64_t guest_paddr, uint32_t slot, uint64_t npages,
diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index 011e757d4e2c..983adeb54c0e 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -159,6 +159,8 @@ size_t get_trans_hugepagesz(void);
 size_t get_def_hugetlb_pagesz(void);
 const struct vm_mem_backing_src_alias *vm_mem_backing_src_alias(uint32_t i);
 size_t get_backing_src_pagesz(uint32_t i);
+int backing_src_should_madvise(uint32_t i);
+int get_backing_src_madvise_advice(uint32_t i);
 bool is_backing_src_hugetlb(uint32_t i);
 void backing_src_help(const char *flag);
 enum vm_mem_backing_src_type parse_backing_src_type(const char *type_name);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 56b170b725b3..9bdd03a5da90 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -774,15 +774,12 @@ void kvm_vm_free(struct kvm_vm *vmp)
 	free(vmp);
 }
 
-int kvm_memfd_alloc(size_t size, bool hugepages)
+int kvm_create_memfd(size_t size, unsigned int flags)
 {
-	int memfd_flags = MFD_CLOEXEC;
-	int fd, r;
-
-	if (hugepages)
-		memfd_flags |= MFD_HUGETLB;
+	int fd;
+	int r;
 
-	fd = memfd_create("kvm_selftest", memfd_flags);
+	fd = memfd_create("kvm_selftest", flags);
 	TEST_ASSERT(fd != -1, __KVM_SYSCALL_ERROR("memfd_create()", fd));
 
 	r = ftruncate(fd, size);
@@ -794,6 +791,16 @@ int kvm_memfd_alloc(size_t size, bool hugepages)
 	return fd;
 }
 
+int kvm_memfd_alloc(size_t size, bool hugepages)
+{
+	int memfd_flags = MFD_CLOEXEC;
+
+	if (hugepages)
+		memfd_flags |= MFD_HUGETLB;
+
+	return kvm_create_memfd(size, memfd_flags);
+}
+
 /*
  * Memory Compare, host virtual to guest virtual
  *
@@ -973,185 +980,293 @@ void vm_set_user_memory_region2(struct kvm_vm *vm, uint32_t slot, uint32_t flags
 		    errno, strerror(errno));
 }
 
+/**
+ * Allocates and returns a struct userspace_mem_region.
+ */
+struct userspace_mem_region *vm_mem_region_alloc(struct kvm_vm *vm)
+{
+	struct userspace_mem_region *region;
 
-/* FIXME: This thing needs to be ripped apart and rewritten. */
-void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
-		uint64_t guest_paddr, uint32_t slot, uint64_t npages,
-		uint32_t flags, int guest_memfd, uint64_t guest_memfd_offset)
+	/* Allocate and initialize new mem region structure. */
+	region = calloc(1, sizeof(*region));
+	TEST_ASSERT(region != NULL, "Insufficient Memory");
+
+	region->unused_phy_pages = sparsebit_alloc();
+	if (vm_arch_has_protected_memory(vm))
+		region->protected_phy_pages = sparsebit_alloc();
+
+	region->fd = -1;
+	region->region.guest_memfd = -1;
+
+	return region;
+}
+
+static size_t compute_page_size(int mmap_flags, int madvise_advice)
+{
+	if (mmap_flags & MAP_HUGETLB) {
+		int size_flags = (mmap_flags >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK;
+		if (!size_flags)
+			return get_def_hugetlb_pagesz();
+
+		return 1ULL << size_flags;
+	}
+
+	return madvise_advice == MADV_HUGEPAGE ? get_trans_hugepagesz() : getpagesize();
+}
+
+/**
+ * Calls mmap() with @length, @flags, @fd, @offset for @region.
+ *
+ * Think of this as the struct userspace_mem_region wrapper for the mmap()
+ * syscall.
+ */
+void *vm_mem_region_mmap(struct userspace_mem_region *region, size_t length,
+			 int flags, int fd, off_t offset)
+{
+	void *mem;
+
+	if (flags & MAP_SHARED) {
+		TEST_ASSERT(fd != -1,
+			    "Ensure that fd is provided for shared mappings.");
+		TEST_ASSERT(
+			region->fd == fd || region->region.guest_memfd == fd,
+			"Ensure that fd is opened before mmap, and is either "
+			"set up in region->fd or region->region.guest_memfd.");
+	}
+
+	mem = mmap(NULL, length, PROT_READ | PROT_WRITE, flags, fd, offset);
+	TEST_ASSERT(mem != MAP_FAILED, "Couldn't mmap anonymous memory");
+
+	region->mmap_start = mem;
+	region->mmap_size = length;
+	region->offset = offset;
+
+	return mem;
+}
+
+/**
+ * Installs mmap()ed memory in @region->mmap_start as @region->host_mem,
+ * checking constraints.
+ */
+void vm_mem_region_install_memory(struct userspace_mem_region *region,
+				  size_t memslot_size, size_t alignment)
+{
+	TEST_ASSERT(region->mmap_size >= memslot_size,
+		    "mmap()ed memory insufficient for memslot");
+
+	region->host_mem = align_ptr_up(region->mmap_start, alignment);
+	region->region.userspace_addr = (uint64_t)region->host_mem;
+	region->region.memory_size = memslot_size;
+}
+
+
+/**
+ * Calls madvise with @advice for @region.
+ *
+ * Think of this as the struct userspace_mem_region wrapper for the madvise()
+ * syscall.
+ */
+void vm_mem_region_madvise_thp(struct userspace_mem_region *region, int advice)
 {
 	int ret;
-	struct userspace_mem_region *region;
-	size_t backing_src_pagesz = get_backing_src_pagesz(src_type);
-	size_t mem_size = npages * vm->page_size;
-	size_t alignment;
 
-	TEST_REQUIRE_SET_USER_MEMORY_REGION2();
+	TEST_ASSERT(
+		region->host_mem && region->mmap_size,
+		"vm_mem_region_madvise_thp() must be called after vm_mem_region_mmap()");
 
-	TEST_ASSERT(vm_adjust_num_guest_pages(vm->mode, npages) == npages,
-		"Number of guest pages is not compatible with the host. "
-		"Try npages=%d", vm_adjust_num_guest_pages(vm->mode, npages));
-
-	TEST_ASSERT((guest_paddr % vm->page_size) == 0, "Guest physical "
-		"address not on a page boundary.\n"
-		"  guest_paddr: 0x%lx vm->page_size: 0x%x",
-		guest_paddr, vm->page_size);
-	TEST_ASSERT((((guest_paddr >> vm->page_shift) + npages) - 1)
-		<= vm->max_gfn, "Physical range beyond maximum "
-		"supported physical address,\n"
-		"  guest_paddr: 0x%lx npages: 0x%lx\n"
-		"  vm->max_gfn: 0x%lx vm->page_size: 0x%x",
-		guest_paddr, npages, vm->max_gfn, vm->page_size);
+	ret = madvise(region->host_mem, region->mmap_size, advice);
+	TEST_ASSERT(ret == 0, "madvise failed, addr: %p length: 0x%lx",
+		    region->host_mem, region->mmap_size);
+}
+
+/**
+ * Installs guest_memfd by setting it up in @region.
+ *
+ * Returns the guest_memfd that was installed in the @region.
+ */
+int vm_mem_region_install_guest_memfd(struct userspace_mem_region *region,
+				      int guest_memfd)
+{
+	/*
+	 * Install a unique fd for each memslot so that the fd can be closed
+	 * when the region is deleted without needing to track if the fd is
+	 * owned by the framework or by the caller.
+	 */
+	guest_memfd = dup(guest_memfd);
+	TEST_ASSERT(guest_memfd >= 0, __KVM_SYSCALL_ERROR("dup()", guest_memfd));
+	region->region.guest_memfd = guest_memfd;
+
+	return guest_memfd;
+}
+
+/**
+ * Calls mmap() to create an alias for mmap()ed memory at region->host_mem,
+ * exactly the same size the was mmap()ed.
+ *
+ * This is used mainly for userfaultfd tests.
+ */
+void *vm_mem_region_mmap_alias(struct userspace_mem_region *region, int flags,
+			       size_t alignment)
+{
+	region->mmap_alias = mmap(NULL, region->mmap_size,
+				  PROT_READ | PROT_WRITE, flags, region->fd, 0);
+	TEST_ASSERT(region->mmap_alias != MAP_FAILED,
+		    __KVM_SYSCALL_ERROR("mmap()",  (int)(unsigned long)MAP_FAILED));
+
+	region->host_alias = align_ptr_up(region->mmap_alias, alignment);
+
+	return region->host_alias;
+}
+
+static void vm_mem_region_assert_no_duplicate(struct kvm_vm *vm, uint32_t slot,
+					      uint64_t gpa, size_t size)
+{
+	struct userspace_mem_region *region;
 
 	/*
 	 * Confirm a mem region with an overlapping address doesn't
 	 * already exist.
 	 */
-	region = (struct userspace_mem_region *) userspace_mem_region_find(
-		vm, guest_paddr, (guest_paddr + npages * vm->page_size) - 1);
-	if (region != NULL)
-		TEST_FAIL("overlapping userspace_mem_region already "
-			"exists\n"
-			"  requested guest_paddr: 0x%lx npages: 0x%lx "
-			"page_size: 0x%x\n"
-			"  existing guest_paddr: 0x%lx size: 0x%lx",
-			guest_paddr, npages, vm->page_size,
-			(uint64_t) region->region.guest_phys_addr,
-			(uint64_t) region->region.memory_size);
+	region = userspace_mem_region_find(vm, gpa, gpa + size - 1);
+	if (region != NULL) {
+		TEST_FAIL("overlapping userspace_mem_region already exists\n"
+			  "  requested gpa: 0x%lx size: 0x%lx"
+			  "  existing gpa: 0x%lx size: 0x%lx",
+			  gpa, size,
+			  (uint64_t) region->region.guest_phys_addr,
+			  (uint64_t) region->region.memory_size);
+	}
 
 	/* Confirm no region with the requested slot already exists. */
-	hash_for_each_possible(vm->regions.slot_hash, region, slot_node,
-			       slot) {
+	hash_for_each_possible(vm->regions.slot_hash, region, slot_node, slot) {
 		if (region->region.slot != slot)
 			continue;
 
-		TEST_FAIL("A mem region with the requested slot "
-			"already exists.\n"
-			"  requested slot: %u paddr: 0x%lx npages: 0x%lx\n"
-			"  existing slot: %u paddr: 0x%lx size: 0x%lx",
-			slot, guest_paddr, npages,
-			region->region.slot,
-			(uint64_t) region->region.guest_phys_addr,
-			(uint64_t) region->region.memory_size);
+		TEST_FAIL("A mem region with the requested slot already exists.\n"
+			  "  requested slot: %u paddr: 0x%lx size: 0x%lx\n"
+			  "  existing slot: %u paddr: 0x%lx size: 0x%lx",
+			  slot, gpa, size,
+			  region->region.slot,
+			  (uint64_t) region->region.guest_phys_addr,
+			  (uint64_t) region->region.memory_size);
 	}
+}
 
-	/* Allocate and initialize new mem region structure. */
-	region = calloc(1, sizeof(*region));
-	TEST_ASSERT(region != NULL, "Insufficient Memory");
-	region->mmap_size = mem_size;
+/**
+ * Add a @region to @vm. All necessary fields in region->region should already
+ * be populated.
+ *
+ * Think of this as the struct userspace_mem_region wrapper for the
+ * KVM_SET_USER_MEMORY_REGION2 ioctl.
+ */
+void vm_mem_region_add(struct kvm_vm *vm, struct userspace_mem_region *region)
+{
+	uint64_t npages;
+	uint64_t gpa;
+	int ret;
 
-#ifdef __s390x__
-	/* On s390x, the host address must be aligned to 1M (due to PGSTEs) */
-	alignment = 0x100000;
-#else
-	alignment = 1;
-#endif
+	TEST_REQUIRE_SET_USER_MEMORY_REGION2();
 
-	/*
-	 * When using THP mmap is not guaranteed to returned a hugepage aligned
-	 * address so we have to pad the mmap. Padding is not needed for HugeTLB
-	 * because mmap will always return an address aligned to the HugeTLB
-	 * page size.
-	 */
-	if (src_type == VM_MEM_SRC_ANONYMOUS_THP)
-		alignment = max(backing_src_pagesz, alignment);
+	npages = region->region.memory_size / vm->page_size;
+	TEST_ASSERT(vm_adjust_num_guest_pages(vm->mode, npages) == npages,
+		    "Number of guest pages is not compatible with the host. "
+		    "Try npages=%d", vm_adjust_num_guest_pages(vm->mode, npages));
+
+	gpa = region->region.guest_phys_addr;
+	TEST_ASSERT((gpa % vm->page_size) == 0,
+		    "Guest physical address not on a page boundary.\n"
+		    "  gpa: 0x%lx vm->page_size: 0x%x",
+		    gpa, vm->page_size);
+	TEST_ASSERT((((gpa >> vm->page_shift) + npages) - 1) <= vm->max_gfn,
+		    "Physical range beyond maximum supported physical address,\n"
+		    "  gpa: 0x%lx npages: 0x%lx\n"
+		    "  vm->max_gfn: 0x%lx vm->page_size: 0x%x",
+		    gpa, npages, vm->max_gfn, vm->page_size);
+
+	vm_mem_region_assert_no_duplicate(vm, region->region.slot, gpa,
+					  region->mmap_size);
 
-	TEST_ASSERT_EQ(guest_paddr, align_up(guest_paddr, backing_src_pagesz));
+	ret = __vm_ioctl(vm, KVM_SET_USER_MEMORY_REGION2, &region->region);
+	TEST_ASSERT(ret == 0, "KVM_SET_USER_MEMORY_REGION2 IOCTL failed,\n"
+		    "  rc: %i errno: %i\n"
+		    "  slot: %u flags: 0x%x\n"
+		    "  guest_phys_addr: 0x%lx size: 0x%llx guest_memfd: %d",
+		    ret, errno, region->region.slot, region->region.flags,
+		    gpa, region->region.memory_size,
+		    region->region.guest_memfd);
 
-	/* Add enough memory to align up if necessary */
-	if (alignment > 1)
-		region->mmap_size += alignment;
+	sparsebit_set_num(region->unused_phy_pages, gpa >> vm->page_shift, npages);
 
-	region->fd = -1;
-	if (backing_src_is_shared(src_type))
-		region->fd = kvm_memfd_alloc(region->mmap_size,
-					     src_type == VM_MEM_SRC_SHARED_HUGETLB);
-
-	region->mmap_start = mmap(NULL, region->mmap_size,
-				  PROT_READ | PROT_WRITE,
-				  vm_mem_backing_src_alias(src_type)->flag,
-				  region->fd, 0);
-	TEST_ASSERT(region->mmap_start != MAP_FAILED,
-		    __KVM_SYSCALL_ERROR("mmap()", (int)(unsigned long)MAP_FAILED));
+	/* Add to quick lookup data structures */
+	vm_userspace_mem_region_gpa_insert(&vm->regions.gpa_tree, region);
+	vm_userspace_mem_region_hva_insert(&vm->regions.hva_tree, region);
+	hash_add(vm->regions.slot_hash, &region->slot_node, region->region.slot);
+}
 
-	TEST_ASSERT(!is_backing_src_hugetlb(src_type) ||
-		    region->mmap_start == align_ptr_up(region->mmap_start, backing_src_pagesz),
-		    "mmap_start %p is not aligned to HugeTLB page size 0x%lx",
-		    region->mmap_start, backing_src_pagesz);
+void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
+		uint64_t guest_paddr, uint32_t slot, uint64_t npages,
+		uint32_t flags, int guest_memfd, uint64_t guest_memfd_offset)
+{
+	struct userspace_mem_region *region;
+	size_t mapping_page_size;
+	size_t memslot_size;
+	int madvise_advice;
+	size_t mmap_size;
+	size_t alignment;
+	int mmap_flags;
+	int memfd;
 
-	/* Align host address */
-	region->host_mem = align_ptr_up(region->mmap_start, alignment);
+	memslot_size = npages * vm->page_size;
+
+	mmap_flags = vm_mem_backing_src_alias(src_type)->flag;
+	madvise_advice = get_backing_src_madvise_advice(src_type);
+	mapping_page_size = compute_page_size(mmap_flags, madvise_advice);
+
+	TEST_ASSERT_EQ(guest_paddr, align_up(guest_paddr, mapping_page_size));
+
+	alignment = mapping_page_size;
+#ifdef __s390x__
+	alignment = max(alignment, S390X_HOST_ADDRESS_ALIGNMENT);
+#endif
 
-	/* As needed perform madvise */
-	if ((src_type == VM_MEM_SRC_ANONYMOUS ||
-	     src_type == VM_MEM_SRC_ANONYMOUS_THP) && thp_configured()) {
-		ret = madvise(region->host_mem, mem_size,
-			      src_type == VM_MEM_SRC_ANONYMOUS ? MADV_NOHUGEPAGE : MADV_HUGEPAGE);
-		TEST_ASSERT(ret == 0, "madvise failed, addr: %p length: 0x%lx src_type: %s",
-			    region->host_mem, mem_size,
-			    vm_mem_backing_src_alias(src_type)->name);
+	region = vm_mem_region_alloc(vm);
+
+	memfd = -1;
+	if (backing_src_is_shared(src_type)) {
+		unsigned int memfd_flags = MFD_CLOEXEC;
+		if (src_type == VM_MEM_SRC_SHARED_HUGETLB)
+			memfd_flags |= MFD_HUGETLB;
+
+		memfd = kvm_create_memfd(memslot_size, memfd_flags);
 	}
+	region->fd = memfd;
+
+	mmap_size = align_up(memslot_size, alignment);
+	vm_mem_region_mmap(region, mmap_size, mmap_flags, memfd, 0);
+	vm_mem_region_install_memory(region, memslot_size, alignment);
 
-	region->backing_src_type = src_type;
+	if (backing_src_should_madvise(src_type))
+		vm_mem_region_madvise_thp(region, madvise_advice);
+
+	if (backing_src_is_shared(src_type))
+		vm_mem_region_mmap_alias(region, mmap_flags, alignment);
 
 	if (flags & KVM_MEM_GUEST_MEMFD) {
 		if (guest_memfd < 0) {
-			uint32_t guest_memfd_flags = 0;
-			TEST_ASSERT(!guest_memfd_offset,
-				    "Offset must be zero when creating new guest_memfd");
-			guest_memfd = vm_create_guest_memfd(vm, mem_size, guest_memfd_flags);
-		} else {
-			/*
-			 * Install a unique fd for each memslot so that the fd
-			 * can be closed when the region is deleted without
-			 * needing to track if the fd is owned by the framework
-			 * or by the caller.
-			 */
-			guest_memfd = dup(guest_memfd);
-			TEST_ASSERT(guest_memfd >= 0, __KVM_SYSCALL_ERROR("dup()", guest_memfd));
+			TEST_ASSERT(
+				guest_memfd_offset == 0,
+				"Offset must be zero when creating new guest_memfd");
+			guest_memfd = vm_create_guest_memfd(vm, memslot_size, 0);
 		}
 
-		region->region.guest_memfd = guest_memfd;
-		region->region.guest_memfd_offset = guest_memfd_offset;
-	} else {
-		region->region.guest_memfd = -1;
+		vm_mem_region_install_guest_memfd(region, guest_memfd);
 	}
 
-	region->unused_phy_pages = sparsebit_alloc();
-	if (vm_arch_has_protected_memory(vm))
-		region->protected_phy_pages = sparsebit_alloc();
-	sparsebit_set_num(region->unused_phy_pages,
-		guest_paddr >> vm->page_shift, npages);
 	region->region.slot = slot;
 	region->region.flags = flags;
 	region->region.guest_phys_addr = guest_paddr;
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
-
-	/* If shared memory, create an alias. */
-	if (region->fd >= 0) {
-		region->mmap_alias = mmap(NULL, region->mmap_size,
-					  PROT_READ | PROT_WRITE,
-					  vm_mem_backing_src_alias(src_type)->flag,
-					  region->fd, 0);
-		TEST_ASSERT(region->mmap_alias != MAP_FAILED,
-			    __KVM_SYSCALL_ERROR("mmap()",  (int)(unsigned long)MAP_FAILED));
-
-		/* Align host alias address */
-		region->host_alias = align_ptr_up(region->mmap_alias, alignment);
-	}
+	region->region.guest_memfd_offset = guest_memfd_offset;
+	vm_mem_region_add(vm, region);
 }
 
 void vm_userspace_mem_region_add(struct kvm_vm *vm,
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index d0a9b5ee0c01..cbcc1e7ad578 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -351,6 +351,31 @@ size_t get_private_mem_backing_src_pagesz(uint32_t i)
 	}
 }
 
+int backing_src_should_madvise(uint32_t i)
+{
+	switch (i) {
+	case VM_MEM_SRC_ANONYMOUS:
+	case VM_MEM_SRC_SHMEM:
+	case VM_MEM_SRC_ANONYMOUS_THP:
+		return true;
+	default:
+		return false;
+	}
+}
+
+int get_backing_src_madvise_advice(uint32_t i)
+{
+	switch (i) {
+	case VM_MEM_SRC_ANONYMOUS:
+	case VM_MEM_SRC_SHMEM:
+		return MADV_NOHUGEPAGE;
+	case VM_MEM_SRC_ANONYMOUS_THP:
+		return MADV_NOHUGEPAGE;
+	default:
+		return 0;
+	}
+}
+
 bool is_backing_src_hugetlb(uint32_t i)
 {
 	return !!(vm_mem_backing_src_alias(i)->flag & MAP_HUGETLB);
-- 
2.46.0.598.g6f2099f65c-goog


