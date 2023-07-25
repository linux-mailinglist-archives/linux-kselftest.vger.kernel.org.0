Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C879C76255D
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 00:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjGYWCe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 18:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjGYWCX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 18:02:23 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36541FE6
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:01:50 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5635233876bso3129989a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690322509; x=1690927309;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbjAqcZWDEPBu4Z5VgM6o5j9i98p8IgHL/vVs/X78Tk=;
        b=UIgE/7MBAcFLmyRerXAOoLDeD7A/VMjQ+Or6J5okuNTdygnqisvlbhUFjqiNcH5mfU
         dIHeqek9tz4JhUXSrf9sDuA8gHgtKL2UH9T2AgDGGXmfPlx7dUnLgLvfPTZfrrzebC+e
         kvX/aJiHWNuIKUssqf1mgMt7q1aeZ6uErcbRzFdnFH1pk1LtE+iadkzY48WgqkalCemE
         N40BE9CE5oukPh6gJmrGtYEOXBLyo0vSOsraaJmIO3kw3bNizXCIMURK1jcE25RGFrOj
         ndhcLgVqujW0LLlszEKxT7OCXpvK6mZRmcaYBNgv6pNBJcI+2Wae/LKBXlZBNNZMoCYk
         a1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690322509; x=1690927309;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbjAqcZWDEPBu4Z5VgM6o5j9i98p8IgHL/vVs/X78Tk=;
        b=cKkrj7N9xmnRbdPsp+lIrX3wXlh+nim4Ei7Ad8rUQ9Woufl/y1SIP5PJoqzgVflUYt
         7J5hk+r4Tz0zavMBFnUlcODRcr6J3PW2SDWegCY9gp75+0wqv0+C0C5tzCXlZPAULT1M
         iL9tKIab4KPg4O9NdoCyhg7J/I8w82U6Rdy6z66Pypk/GrfNNBsccs8R34sRHo4PAjUe
         GvsLPe5qZD5qQCSe09pXMrWZQXdVrU0M1d5+RqBYESLtfyaWhFUKOPEJsSMKG+i1VsvR
         +0X+9NmInnpqDEPr57dW0ZjxmgSxhNoiRhhAi5W0daJ/GLISZRmljjspxhKV/kTbd9mv
         W6Uw==
X-Gm-Message-State: ABy/qLb3xJUbTSLaUcNiMV1Zv7kezPSA6aNwkzan6LM7og15dJns/73Y
        egbWOZUp5OIjmx7MJ20+Fd+ZON3p0yTkfXHVIGID3tJmIxw8oEa0EJfifg8z9sBgMHdWiC5HpxQ
        uPBSmNPSC2eRCMivvWiKH+ZVFfKdfyyjn+KUPCWklR8ZQ9uTAPtyPjVBCO8PVS9YV9YdtBt1uw5
        Ii
X-Google-Smtp-Source: APBJJlGvIFzyScaDHCvh1cO3MTYc7Lpg8/vEd/IveZYdr5gfm1CGYT3vx+XfuEJnvqmR1TZ+hHqPb0UhI5gJ
X-Received: from afranji.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:47f1])
 (user=afranji job=sendgmr) by 2002:a63:6f86:0:b0:55a:12cf:3660 with SMTP id
 k128-20020a636f86000000b0055a12cf3660mr2074pgc.1.1690322508626; Tue, 25 Jul
 2023 15:01:48 -0700 (PDT)
Date:   Tue, 25 Jul 2023 22:00:54 +0000
In-Reply-To: <20230725220132.2310657-1-afranji@google.com>
Mime-Version: 1.0
References: <20230725220132.2310657-1-afranji@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725220132.2310657-2-afranji@google.com>
Subject: [PATCH v4 01/28] KVM: selftests: Add function to allow one-to-one GVA
 to GPA mappings
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

From: Ackerley Tng <ackerleytng@google.com>

One-to-one GVA to GPA mappings can be used in the guest to set up boot
sequences during which paging is enabled, hence requiring a transition
from using physical to virtual addresses in consecutive instructions.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Change-Id: I5a15e241b3ce9014e17a794478bbfa65b9d8e0a1
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h     |  3 +
 tools/testing/selftests/kvm/lib/kvm_util.c    | 81 ++++++++++++++++++-
 2 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index af26c5687d86..a07ce5f5244a 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -513,6 +513,9 @@ vm_vaddr_t vm_vaddr_unused_gap(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_mi
 vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
 vm_vaddr_t __vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
 			    enum kvm_mem_region_type type);
+vm_vaddr_t vm_vaddr_alloc_shared(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
+vm_vaddr_t vm_vaddr_alloc_1to1(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
+			       uint32_t data_memslot);
 vm_vaddr_t vm_vaddr_alloc_pages(struct kvm_vm *vm, int nr_pages);
 vm_vaddr_t __vm_vaddr_alloc_page(struct kvm_vm *vm,
 				 enum kvm_mem_region_type type);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 518990ca408d..5bbcddcd6796 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1371,6 +1371,58 @@ vm_vaddr_t __vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
 	return vaddr_start;
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
+static vm_vaddr_t
+_vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
+		vm_paddr_t paddr_min, uint32_t data_memslot, bool encrypt)
+{
+	uint64_t pages = (sz >> vm->page_shift) + ((sz % vm->page_size) != 0);
+
+	virt_pgd_alloc(vm);
+	vm_paddr_t paddr = _vm_phy_pages_alloc(vm, pages,
+					       paddr_min,
+					       data_memslot, encrypt);
+
+	/*
+	 * Find an unused range of virtual page addresses of at least
+	 * pages in length.
+	 */
+	vm_vaddr_t vaddr_start = vm_vaddr_unused_gap(vm, sz, vaddr_min);
+
+	/* Map the virtual pages. */
+	for (vm_vaddr_t vaddr = vaddr_start; pages > 0;
+		pages--, vaddr += vm->page_size, paddr += vm->page_size) {
+
+		virt_pg_map(vm, vaddr, paddr);
+
+		sparsebit_set(vm->vpages_mapped,
+			vaddr >> vm->page_shift);
+	}
+
+	return vaddr_start;
+}
+
 /*
  * VM Virtual Address Allocate
  *
@@ -1392,7 +1444,34 @@ vm_vaddr_t __vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
  */
 vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min)
 {
-	return __vm_vaddr_alloc(vm, sz, vaddr_min, MEM_REGION_TEST_DATA);
+	return _vm_vaddr_alloc(vm, sz, vaddr_min,
+			       KVM_UTIL_MIN_PFN * vm->page_size, 0,
+			       vm->protected);
+}
+
+vm_vaddr_t vm_vaddr_alloc_shared(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min)
+{
+	return _vm_vaddr_alloc(vm, sz, vaddr_min,
+			       KVM_UTIL_MIN_PFN * vm->page_size, 0, false);
+}
+
+/**
+ * Allocate memory in @vm of size @sz in memslot with id @data_memslot,
+ * beginning with the desired address of @vaddr_min.
+ *
+ * If there isn't enough memory at @vaddr_min, find the next possible address
+ * that can meet the requested size in the given memslot.
+ *
+ * Return the address where the memory is allocated.
+ */
+vm_vaddr_t vm_vaddr_alloc_1to1(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
+			       uint32_t data_memslot)
+{
+	vm_vaddr_t gva = _vm_vaddr_alloc(vm, sz, vaddr_min, (vm_paddr_t) vaddr_min,
+					 data_memslot, vm->protected);
+	ASSERT_EQ(gva, addr_gva2gpa(vm, gva));
+
+	return gva;
 }
 
 /*
-- 
2.41.0.487.g6d72f3e995-goog

