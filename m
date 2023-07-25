Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9315B762596
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 00:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjGYWDw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 18:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbjGYWDI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 18:03:08 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9965135B7
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:43 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-584375eacacso9039517b3.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690322551; x=1690927351;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Vk6fb359Stuhm1VcuGIgWqQRYkL2YWLdsbYVpUx5xo=;
        b=3isJhOUvSruS/8cztZ/vPjCuapGQPFiQqyfoyCyDr1i19srvz/gFuhAYszripqjF++
         zj5y/djO90jVg+NWQ++1x81HXrIqATvkCywjPSpixoaXW7Qtz+Qkczfc0KvgaMIjzm7q
         +mqct2o/rQq7e4PoIDn3W63uqMiWWH+lLYX4R4uOUB5TcjIvjoywlQog9Awd/IEdito1
         0y541Lrx3Cml256bSbVNGjE211P67v2SNF42rceDqtBQcqKEUjSULNfJclR1Tzk5n979
         EwjRq4LvFY+6YZOsq6U/iM3KFGWFkiyQV1yqh2YfQg5NebW/lGI41/iBRlguY/O8TgFR
         T7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690322551; x=1690927351;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Vk6fb359Stuhm1VcuGIgWqQRYkL2YWLdsbYVpUx5xo=;
        b=h+L83sP7SKBpixI9nzHePRxq83bYgZZ58BLl2GS2mKJLVUzpOD6y6d64yumuzEY55s
         rmL4CAAAUE1LPP1AWbIVTOXM5CadIY2mALzBQBZVakeiFlR+a1hAMsr63a7XFbtQejYO
         vHU+TRimdygP64hXTB3EKThYRrv9Y76mqVlC8GSzwaJc4D7EMPVUMlojap8y/esy0zna
         5xJryqzjAuAi+H+tnTIaMqaNwje+gK6407Qbehw3OQ0fgIkXGiLnjIu8UEWxgGGKn9Qm
         x2RlmzdmulojCiLiPRubyEjR9d4MnmqFi+/Dsu6+uppFEaPivHGx4+vXZ/kgjW1/D0ra
         Y+bA==
X-Gm-Message-State: ABy/qLYMJbqlT3G1hVXUadz/blkMsE2TLEzVPeR2McM/7g1mf7D8HqLe
        7VJZF/i1V5yF7xJCJDORLE3fiaRwOYKKlIrBhsfQme279Wie4XnRRpqwSJeVfc4JElLTRf/M5un
        7Qs5mJUw7OAkJjotwkRixEqKCTRtDzO7aE4Wwupo7fzcuzI0EUyEsXuQUELN4VkEHVc3/ShBxUv
        tO
X-Google-Smtp-Source: APBJJlHJNxVmKIptLSML/VG4jEgkiSCBKPUmdc9INK2SjwujEF39iUWqohr1WVYdAnswUzxQMrqsysxI7Hux
X-Received: from afranji.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:47f1])
 (user=afranji job=sendgmr) by 2002:a81:ae49:0:b0:580:e6dc:e2df with SMTP id
 g9-20020a81ae49000000b00580e6dce2dfmr3713ywk.9.1690322550887; Tue, 25 Jul
 2023 15:02:30 -0700 (PDT)
Date:   Tue, 25 Jul 2023 22:01:15 +0000
In-Reply-To: <20230725220132.2310657-1-afranji@google.com>
Mime-Version: 1.0
References: <20230725220132.2310657-1-afranji@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725220132.2310657-23-afranji@google.com>
Subject: [PATCH v4 22/28] KVM: selftests: Add functions to allow mapping as shared
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

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Change-Id: I27676cf732276c544c9abd7e9b8589ca8ffd6ba5
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h     | 24 ++++++++++++++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 32 +++++++++++++++++++
 .../selftests/kvm/lib/x86_64/processor.c      | 15 +++++++--
 3 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 6ed57162b49d..d793355599e1 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -524,6 +524,8 @@ vm_vaddr_t vm_vaddr_alloc_page(struct kvm_vm *vm);
 
 void virt_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
 	      unsigned int npages);
+void virt_map_shared(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
+		     unsigned int npages);
 void *addr_gpa2hva(struct kvm_vm *vm, vm_paddr_t gpa);
 void *addr_gva2hva(struct kvm_vm *vm, vm_vaddr_t gva);
 vm_paddr_t addr_hva2gpa(struct kvm_vm *vm, void *hva);
@@ -983,6 +985,28 @@ static inline void virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr
 	virt_arch_pg_map(vm, vaddr, paddr);
 }
 
+/*
+ * VM Virtual Page Map as Shared
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   vaddr - VM Virtual Address
+ *   paddr - VM Physical Address
+ *   memslot - Memory region slot for new virtual translation tables
+ *
+ * Output Args: None
+ *
+ * Return: None
+ *
+ * Within @vm, creates a virtual translation for the page starting
+ * at @vaddr to the page starting at @paddr.
+ */
+void virt_arch_pg_map_shared(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr);
+
+static inline void virt_pg_map_shared(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr)
+{
+	virt_arch_pg_map_shared(vm, vaddr, paddr);
+}
 
 /*
  * Address Guest Virtual to Guest Physical
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index e2a0d979b54f..7db9437505d7 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1551,6 +1551,38 @@ void virt_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
 	}
 }
 
+/*
+ * Map a range of VM virtual address to the VM's physical address as shared
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   vaddr - Virtuall address to map
+ *   paddr - VM Physical Address
+ *   npages - The number of pages to map
+ *
+ * Output Args: None
+ *
+ * Return: None
+ *
+ * Within the VM given by @vm, creates a virtual translation for
+ * @npages starting at @vaddr to the page range starting at @paddr.
+ */
+void virt_map_shared(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
+		     unsigned int npages)
+{
+	size_t page_size = vm->page_size;
+	size_t size = npages * page_size;
+
+	TEST_ASSERT(vaddr + size > vaddr, "Vaddr overflow");
+	TEST_ASSERT(paddr + size > paddr, "Paddr overflow");
+
+	while (npages--) {
+		virt_pg_map_shared(vm, vaddr, paddr);
+		vaddr += page_size;
+		paddr += page_size;
+	}
+}
+
 /*
  * Address VM Physical to Host Virtual
  *
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 4893a778fff5..9283c1e4961e 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -183,7 +183,8 @@ static uint64_t *virt_create_upper_pte(struct kvm_vm *vm,
 	return pte;
 }
 
-void __virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr, int level)
+static void ___virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
+			   int level, bool protected)
 {
 	const uint64_t pg_size = PG_LEVEL_SIZE(level);
 	uint64_t *pml4e, *pdpe, *pde;
@@ -229,17 +230,27 @@ void __virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr, int level)
 		    "PTE already present for 4k page at vaddr: 0x%lx\n", vaddr);
 	*pte = PTE_PRESENT_MASK | PTE_WRITABLE_MASK | (paddr & PHYSICAL_PAGE_MASK);
 
-	if (vm_is_gpa_protected(vm, paddr))
+	if (protected)
 		*pte |= vm->arch.c_bit;
 	else
 		*pte |= vm->arch.s_bit;
 }
 
+void __virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr, int level)
+{
+	___virt_pg_map(vm, vaddr, paddr, level, vm_is_gpa_protected(vm, paddr));
+}
+
 void virt_arch_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr)
 {
 	__virt_pg_map(vm, vaddr, paddr, PG_LEVEL_4K);
 }
 
+void virt_arch_pg_map_shared(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr)
+{
+	___virt_pg_map(vm, vaddr, paddr, PG_LEVEL_4K, false);
+}
+
 void virt_map_level(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
 		    uint64_t nr_bytes, int level)
 {
-- 
2.41.0.487.g6d72f3e995-goog

