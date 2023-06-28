Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF317417F7
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 20:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjF1SYM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 14:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjF1SYG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 14:24:06 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F01F1BE8
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Jun 2023 11:24:05 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-57003dac4a8so21297737b3.1
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Jun 2023 11:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687976644; x=1690568644;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=waAceiGJaJIZM1rTpOnkG9zmisMavGazW+tCIuQxkVs=;
        b=uztf5Fp5P1E97NMF0TnBlrtUrLMVUIP+ugYLlYTLoMigD6DZmxK1UVGc4x0qOAilGZ
         3NQuryCqq+mJLuHVnFuYq5gFv9zOc4zLevxO6JGgddH4qfYggUedW1saX8zlX/mAnAEZ
         SCb3+ZTeHSismRmZh66YwkIxzDUiJlMcqjKXMOv81gn0cA+pjTowGfXTAF/h0QGT3L9m
         FZP1kps4tKKxQkML9vtiFdJBw2zClRgrkUO01L/tPSPUW/m2olCw2HkrhuNy4Xh3WB9C
         XOQaQOKWtjn2BhMtioSImBFAAHFGF1RzbFU6oNXLA/hk3x/m52kNiphchoACPfNn058o
         WKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687976644; x=1690568644;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=waAceiGJaJIZM1rTpOnkG9zmisMavGazW+tCIuQxkVs=;
        b=lk5yvaODSSpo1Y61kcK/MDFRdFhiuY0pUQt4wiXg7eaVls3xwQ2RcZKnFYtqX86vZs
         1AFQikIphMEWuK3rWLKsyqWQ+KDYVHB4pKM79U0vxR9LhmUreHIJNyq4D+42nNB8P2Mq
         xrHuy/JFu+Zv1MND39wnA6jTfx7yP7HPauNOum8DIRIlllKuJ1LThGuieM84albQx4SU
         duxfjcpVOXo02E867YNJCuPowg4MiW0/j1O1m03I0g2po8+9uxGr0kvAnJRdkeSBMaf8
         9m/nzCNNI+flkr4Q3d4BzasAcApy463h75hn5dm+/V4CjT9sXB/M7TrfXrwrkQJ/XS3D
         QEPQ==
X-Gm-Message-State: ABy/qLZcXZYUahhq6x6YF+DfCAsqRn/IueNiqvy+UNGtJA7ftBcwZKd8
        sz8Xl2icRYldFKlj1WaunQPATa1yggU=
X-Google-Smtp-Source: APBJJlFJ6sGH4qbNrqxIT5rwqmY40tMuEfge6iB7SEY8W4FiNZZhLRUeObmDZffAE9DcMoPnJfeiEPM9npE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:ad48:0:b0:56c:f903:8678 with SMTP id
 l8-20020a81ad48000000b0056cf9038678mr30187ywk.2.1687976644502; Wed, 28 Jun
 2023 11:24:04 -0700 (PDT)
Date:   Wed, 28 Jun 2023 11:24:02 -0700
In-Reply-To: <20230408040020.868929-3-npiggin@gmail.com>
Mime-Version: 1.0
References: <20230408040020.868929-1-npiggin@gmail.com> <20230408040020.868929-3-npiggin@gmail.com>
Message-ID: <ZJx6wqgS4TOi/D4j@google.com>
Subject: Re: [PATCH v2 2/4] KVM: selftests: Add aligned guest physical page allocator
From:   Sean Christopherson <seanjc@google.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Apr 08, 2023, Nicholas Piggin wrote:
> powerpc will require this to allocate MMU tables in guest memory that
> are aligned and larger than the base page size.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  .../selftests/kvm/include/kvm_util_base.h     |  2 +
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 44 ++++++++++++-------
>  2 files changed, 29 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
> index 16425da16861..8a27bd4111ff 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util_base.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
> @@ -679,6 +679,8 @@ const char *exit_reason_str(unsigned int exit_reason);
>  
>  vm_paddr_t vm_phy_page_alloc(struct kvm_vm *vm, vm_paddr_t paddr_min,
>  			     uint32_t memslot);
> +vm_paddr_t vm_phy_pages_alloc_align(struct kvm_vm *vm, size_t num, size_t align,
> +			      vm_paddr_t paddr_min, uint32_t memslot);
>  vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
>  			      vm_paddr_t paddr_min, uint32_t memslot);
>  vm_paddr_t vm_alloc_page_table(struct kvm_vm *vm);
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 8ec20ac33de0..4f15bbbb8f5e 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1898,6 +1898,7 @@ const char *exit_reason_str(unsigned int exit_reason)
>   * Input Args:
>   *   vm - Virtual Machine
>   *   num - number of pages
> + *   align - pages alignment
>   *   paddr_min - Physical address minimum
>   *   memslot - Memory region to allocate page from
>   *
> @@ -1911,7 +1912,7 @@ const char *exit_reason_str(unsigned int exit_reason)
>   * and their base address is returned. A TEST_ASSERT failure occurs if
>   * not enough pages are available at or above paddr_min.
>   */
> -vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
> +vm_paddr_t vm_phy_pages_alloc_align(struct kvm_vm *vm, size_t num, size_t align,

I'd prefer to use double underscores, even though they are imperfect, because
appending a single specifier always seems to result in the name becoming stale
sooner or later, e.g. when another param with a default is added.

And IIUC, PPC requires the page tables to be naturally aligned, so rather than
expose the inner helper and copy+paste the rather odd KVM_GUEST_PAGE_TABLE_MIN_PADDR
and vm->memslots[MEM_REGION_PT] stuff, what if we instead have vm_alloc_page_table()
deal with the alignment?  And provide a PPC-specific wrapper so that other
architectures don't need to manually specify '1' page?

E.g.

---
 .../selftests/kvm/include/kvm_util_base.h      | 18 +++++++++++++++---
 tools/testing/selftests/kvm/lib/kvm_util.c     | 14 ++++++++------
 .../selftests/kvm/lib/powerpc/processor.c      |  8 ++------
 3 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index f14a059f58fb..e52405c9fa8b 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -700,11 +700,23 @@ const char *exit_reason_str(unsigned int exit_reason);
 
 vm_paddr_t vm_phy_page_alloc(struct kvm_vm *vm, vm_paddr_t paddr_min,
 			     uint32_t memslot);
-vm_paddr_t vm_phy_pages_alloc_align(struct kvm_vm *vm, size_t num, size_t align,
-			      vm_paddr_t paddr_min, uint32_t memslot);
 vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
 			      vm_paddr_t paddr_min, uint32_t memslot);
-vm_paddr_t vm_alloc_page_table(struct kvm_vm *vm);
+
+vm_paddr_t __vm_alloc_page_table(struct kvm_vm *vm, size_t nr_pages);
+
+/*
+ * PowerPC conditionally needs to allocate multiple pages for each page table,
+ * all other architectures consume exactly one page per table.
+ */
+#if defined(__powerpc64__
+#define vm_alloc_page_table __vm_alloc_page_table
+#else
+static inline vm_alloc_page_table(struct kvm_vm *vm)
+{
+	return __vm_alloc_page_table(vm, 1)
+}
+#endif
 
 /*
  * ____vm_create() does KVM_CREATE_VM and little else.  __vm_create() also
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 70f792ba444c..ffd18afe9725 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1946,8 +1946,9 @@ const char *exit_reason_str(unsigned int exit_reason)
  * and their base address is returned. A TEST_ASSERT failure occurs if
  * not enough pages are available at or above paddr_min.
  */
-vm_paddr_t vm_phy_pages_alloc_align(struct kvm_vm *vm, size_t num, size_t align,
-			      vm_paddr_t paddr_min, uint32_t memslot)
+static vm_paddr_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
+				       size_t align, vm_paddr_t paddr_min,
+				       uint32_t memslot)
 {
 	struct userspace_mem_region *region;
 	sparsebit_idx_t pg, base;
@@ -1992,7 +1993,7 @@ vm_paddr_t vm_phy_pages_alloc_align(struct kvm_vm *vm, size_t num, size_t align,
 vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
 			      vm_paddr_t paddr_min, uint32_t memslot)
 {
-	return vm_phy_pages_alloc_align(vm, num, 1, paddr_min, memslot);
+	return __vm_phy_pages_alloc(vm, num, 1, paddr_min, memslot);
 }
 
 vm_paddr_t vm_phy_page_alloc(struct kvm_vm *vm, vm_paddr_t paddr_min,
@@ -2001,10 +2002,11 @@ vm_paddr_t vm_phy_page_alloc(struct kvm_vm *vm, vm_paddr_t paddr_min,
 	return vm_phy_pages_alloc(vm, 1, paddr_min, memslot);
 }
 
-vm_paddr_t vm_alloc_page_table(struct kvm_vm *vm)
+vm_paddr_t __vm_alloc_page_table(struct kvm_vm *vm)
 {
-	return vm_phy_page_alloc(vm, KVM_GUEST_PAGE_TABLE_MIN_PADDR,
-				 vm->memslots[MEM_REGION_PT]);
+	return __vm_phy_pages_alloc(vm, KVM_GUEST_PAGE_TABLE_MIN_PADDR,
+				    nr_pages, nr_pages,
+				    vm->memslots[MEM_REGION_PT]);
 }
 
 /*
diff --git a/tools/testing/selftests/kvm/lib/powerpc/processor.c b/tools/testing/selftests/kvm/lib/powerpc/processor.c
index 7052ce9b5029..57d64d281467 100644
--- a/tools/testing/selftests/kvm/lib/powerpc/processor.c
+++ b/tools/testing/selftests/kvm/lib/powerpc/processor.c
@@ -44,9 +44,7 @@ void virt_arch_pgd_alloc(struct kvm_vm *vm)
 	pgd_pages = (1UL << (RADIX_PGD_INDEX_SIZE + 3)) >> vm->page_shift;
 	if (!pgd_pages)
 		pgd_pages = 1;
-	pgtb = vm_phy_pages_alloc_align(vm, pgd_pages, pgd_pages,
-					KVM_GUEST_PAGE_TABLE_MIN_PADDR,
-					vm->memslots[MEM_REGION_PT]);
+	pt = vm_alloc_page_table(vm, pgd_pages);
 	vm->pgd = pgtb;
 
 	/* Set the base page directory in the proc table */
@@ -168,9 +166,7 @@ void virt_arch_pg_map(struct kvm_vm *vm, uint64_t gva, uint64_t gpa)
 		pt_pages = (1ULL << (nls + 3)) >> vm->page_shift;
 		if (!pt_pages)
 			pt_pages = 1;
-		pt = vm_phy_pages_alloc_align(vm, pt_pages, pt_pages,
-					KVM_GUEST_PAGE_TABLE_MIN_PADDR,
-					vm->memslots[MEM_REGION_PT]);
+		pt = vm_alloc_page_table(vm, pt_pages);
 		pde = PDE_VALID | nls | pt;
 		*pdep = cpu_to_be64(pde);
 	}

base-commit: 15a281f5c83f34d4d1808e5f790403b0770c5e78
-- 

