Return-Path: <linux-kselftest+bounces-1724-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 535FE80F817
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 21:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4198DB20ED9
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 20:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9C564152;
	Tue, 12 Dec 2023 20:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zw4YqO1S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48527BC
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 12:47:01 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-28a30542c37so2194549a91.1
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 12:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702414021; x=1703018821; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UNdApJhYNj7CgDTo7NNKspnxbte38oVK+sy/EZvIraM=;
        b=Zw4YqO1SsN6p5n6nViyAYTvRkLApiffzbYU96GwXUb/gE28rvRhX2jNe8Tn+3ekN5L
         l+Gw9Oh0GNu15Kfc478dxNtXGUPKExWMlbN3v6zwD8RnIEw6tCvx2BxD6IwZ7FSUj4bD
         SNPnA8XCv5xjVlfJjE9S9fHQGNEnBRmOgrRw4j6y+/5AwdfawcfW9WUaaoWpSEpjSSv5
         7yY8/FRyYisG2tFX679X61QGysg88bmaa2XHufNlxKK5Y7NsHlZThUmk/oCHRc8EOewp
         976MGRJWpEvj//RpdhDW4TDhvaNz6a2c3kdJkXtmXiw5E/qDV7K2JX6O8HJSJDs/T7pw
         UMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702414021; x=1703018821;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UNdApJhYNj7CgDTo7NNKspnxbte38oVK+sy/EZvIraM=;
        b=tWa5C0d3jZy09FkApitVNbntd9nxdruOjoXQqGBDTFmuG7vJSwFrkEf0B1cyIxSnxs
         eAxnZKvB+KPJiWG0sugy6yNCTYnbOsvCNMne0/ZJi0fDz2Xmz5zRi8uxkjECmq5LLTBf
         yoYna+BFtFZDgTrJmx4zM2s3ILuqmnmNC/X94Z5IoeDAWeSQ0bF5bFqjCE8bXA/Wdvx9
         Tf2qN5BEFbj4pibajxIXHsDaxfvyOx8QUsZo9F4wzQLyqY6+3tZnKqHoB91f6KC2zqWk
         jbW7lQSGbf9liGSRs4itLVwtc2ch/FoH/uzPrCT9hRIq7hU0dXYwvRxaZ7FNgsxMCqHQ
         /cwg==
X-Gm-Message-State: AOJu0YxvxYzvgsfbJE1eN76o7NDwMuy4G+hfzE16yEEW/sgwvQ+X+dFK
	kYsY7SM2s9Yy5E6NHJGGBYcp8xT5WOwxf1naXeSevpTu/O4TZhJm/R9s1x7XSHaG3uIfBDh3poJ
	XIsjeEebx7enItDTKamVwv96Ezsa6SBfh17PUxbZrWGqVU8G+Zj2Yy8UoTwU+XX8bYK/rNTA=
X-Google-Smtp-Source: AGHT+IFZJwJRZcoWgNgtpTbykf4LZtBAxjnj8x3+a2qkplSA1n0mJv6jcJdIXWysboMlPxbmymXIpA//uQ==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a17:902:db09:b0:1d0:8fff:cd75 with SMTP id
 m9-20020a170902db0900b001d08fffcd75mr51402plx.10.1702414019454; Tue, 12 Dec
 2023 12:46:59 -0800 (PST)
Date: Tue, 12 Dec 2023 12:46:16 -0800
In-Reply-To: <20231212204647.2170650-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231212204647.2170650-1-sagis@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231212204647.2170650-2-sagis@google.com>
Subject: [RFC PATCH v5 01/29] KVM: selftests: Add function to allow one-to-one
 GVA to GPA mappings
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

From: Ackerley Tng <ackerleytng@google.com>

One-to-one GVA to GPA mappings can be used in the guest to set up boot
sequences during which paging is enabled, hence requiring a transition
from using physical to virtual addresses in consecutive instructions.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h     |  2 +
 tools/testing/selftests/kvm/lib/kvm_util.c    | 63 ++++++++++++++++---
 2 files changed, 55 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 1426e88ebdc7..c2e5c5f25dfc 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -564,6 +564,8 @@ vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
 vm_vaddr_t __vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
 			    enum kvm_mem_region_type type);
 vm_vaddr_t vm_vaddr_alloc_shared(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
+vm_vaddr_t vm_vaddr_alloc_1to1(struct kvm_vm *vm, size_t sz,
+			       vm_vaddr_t vaddr_min, uint32_t data_memslot);
 vm_vaddr_t vm_vaddr_alloc_pages(struct kvm_vm *vm, int nr_pages);
 vm_vaddr_t __vm_vaddr_alloc_page(struct kvm_vm *vm,
 				 enum kvm_mem_region_type type);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index febc63d7a46b..4f1ae0f1eef0 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1388,17 +1388,37 @@ vm_vaddr_t vm_vaddr_unused_gap(struct kvm_vm *vm, size_t sz,
 	return pgidx_start * vm->page_size;
 }
 
+/*
+ * VM Virtual Address Allocate Shared/Encrypted
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   sz - Size in bytes
+ *   vaddr_min - Minimum starting virtual address
+ *   paddr_min - Minimum starting physical address
+ *   data_memslot - memslot number to allocate in
+ *   encrypt - Whether the region should be handled as encrypted
+ *
+ * Output Args: None
+ *
+ * Return:
+ *   Starting guest virtual address
+ *
+ * Allocates at least sz bytes within the virtual address space of the vm
+ * given by vm.  The allocated bytes are mapped to a virtual address >=
+ * the address given by vaddr_min.  Note that each allocation uses a
+ * a unique set of pages, with the minimum real allocation being at least
+ * a page.
+ */
 static vm_vaddr_t ____vm_vaddr_alloc(struct kvm_vm *vm, size_t sz,
-				     vm_vaddr_t vaddr_min,
-				     enum kvm_mem_region_type type,
-				     bool encrypt)
+				     vm_vaddr_t vaddr_min, vm_paddr_t paddr_min,
+				     uint32_t data_memslot, bool encrypt)
 {
 	uint64_t pages = (sz >> vm->page_shift) + ((sz % vm->page_size) != 0);
 
 	virt_pgd_alloc(vm);
-	vm_paddr_t paddr = _vm_phy_pages_alloc(vm, pages,
-					      KVM_UTIL_MIN_PFN * vm->page_size,
-					      vm->memslots[type], encrypt);
+	vm_paddr_t paddr = _vm_phy_pages_alloc(vm, pages, paddr_min,
+					       data_memslot, encrypt);
 
 	/*
 	 * Find an unused range of virtual page addresses of at least
@@ -1408,8 +1428,7 @@ static vm_vaddr_t ____vm_vaddr_alloc(struct kvm_vm *vm, size_t sz,
 
 	/* Map the virtual pages. */
 	for (vm_vaddr_t vaddr = vaddr_start; pages > 0;
-		pages--, vaddr += vm->page_size, paddr += vm->page_size) {
-
+	     pages--, vaddr += vm->page_size, paddr += vm->page_size) {
 		virt_pg_map(vm, vaddr, paddr);
 
 		sparsebit_set(vm->vpages_mapped, vaddr >> vm->page_shift);
@@ -1421,12 +1440,16 @@ static vm_vaddr_t ____vm_vaddr_alloc(struct kvm_vm *vm, size_t sz,
 vm_vaddr_t __vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
 			    enum kvm_mem_region_type type)
 {
-	return ____vm_vaddr_alloc(vm, sz, vaddr_min, type, vm->protected);
+	return ____vm_vaddr_alloc(vm, sz, vaddr_min,
+				  KVM_UTIL_MIN_PFN * vm->page_size,
+				  vm->memslots[type], vm->protected);
 }
 
 vm_vaddr_t vm_vaddr_alloc_shared(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min)
 {
-	return ____vm_vaddr_alloc(vm, sz, vaddr_min, MEM_REGION_TEST_DATA, false);
+	return ____vm_vaddr_alloc(vm, sz, vaddr_min,
+				  KVM_UTIL_MIN_PFN * vm->page_size,
+				  vm->memslots[MEM_REGION_TEST_DATA], false);
 }
 
 /*
@@ -1453,6 +1476,26 @@ vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min)
 	return __vm_vaddr_alloc(vm, sz, vaddr_min, MEM_REGION_TEST_DATA);
 }
 
+/**
+ * Allocate memory in @vm of size @sz in memslot with id @data_memslot,
+ * beginning with the desired address of @vaddr_min.
+ *
+ * If there isn't enough memory at @vaddr_min, find the next possible address
+ * that can meet the requested size in the given memslot.
+ *
+ * Return the address where the memory is allocated.
+ */
+vm_vaddr_t vm_vaddr_alloc_1to1(struct kvm_vm *vm, size_t sz,
+			       vm_vaddr_t vaddr_min, uint32_t data_memslot)
+{
+	vm_vaddr_t gva = ____vm_vaddr_alloc(vm, sz, vaddr_min,
+					    (vm_paddr_t)vaddr_min, data_memslot,
+					    vm->protected);
+	TEST_ASSERT_EQ(gva, addr_gva2gpa(vm, gva));
+
+	return gva;
+}
+
 /*
  * VM Virtual Address Allocate Pages
  *
-- 
2.43.0.472.g3155946c3a-goog


