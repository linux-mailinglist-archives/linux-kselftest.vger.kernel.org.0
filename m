Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBB56761F8
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jan 2023 01:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjAUAQV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Jan 2023 19:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjAUAQU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Jan 2023 19:16:20 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F981A19A9
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:16:16 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-4dabfe825b4so65856237b3.16
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ubxGTk6gAS1cIf2CC99mo1vpnAlsFSvC6HXfL0FfYMo=;
        b=IB1WGTuvu8nhLqPJU6KIdsFohzOBKSI4NnuM0fwFx8tGKjnp0lx6I8O1+Ev+HPMvNt
         KtBBAMvONZubRoRoIahe13qF3I7FnV79jYBJVhT21MPmGWCWSormgW0W4/8sY2Bfrivh
         VGH+WQwesc8Ed/S2AIivkxK84nf6Ldyb0/jWJrqi36WR6ZIMyLRy/E8VD4zeDtqM3N8J
         BNaDwctQ7qJWu6xRrSOW0/oLrLgIvf+R8pMO5/YAZoPuy3ZKXsRGnA85QLxFtVPGqNNB
         wYucvMLaUOTUCPUT3GEv5oJAzhoKFt/zNUBRjX+oPVmggUmLN91tMe1jGx2/afChYK1F
         +0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ubxGTk6gAS1cIf2CC99mo1vpnAlsFSvC6HXfL0FfYMo=;
        b=nlyyhtixOH9uDysMJhVqjcxmhOCl7zgZVeA3wYTrjmwLG3PX0hSa5l9+gctr6kg0v6
         7W9rTYxGfocn2R5mfItjMCZUR4mjUlRwx5zLJHLv4tcY+Y1BHi1SOVDqU+IfjFEhWagd
         59d62nmtlKjWRo6qn1V7Jbpxtwta7QoeO7W3jevMYfWX5TnouXrduCrh+toH0ZdscSBi
         8Iduwqldi5I1kyacS6d/XxmVml5FjdFBLak4+0vP9Tk5tFf/mAsnyYsrtn9cLlRUiRVQ
         HduqLnTzToECyyLTuFTPsjhZ1+st1noXSnJEde2dP4FxyYSUc74saL3uEp4wVAzHr6L/
         /1uA==
X-Gm-Message-State: AFqh2kpgs8KUlkqnGsz3vEH0rRzkt8e9dpXHAApNQHi7k95DUyQ2X7JJ
        or+7x4f8yS6jZmSxTtDlsY18n8xHiLT2VAPutloCpC6Yq+tNzCFJTV8CMNUkTSPGYZFvn7MqBsa
        DWw9BCvb4Q1YZjJoGfVzeCS+crqMAGuYsCVQHbUZ/55wk4er79Bo29gnifGqq+Whi1kYE1R0NbQ
        TWj74xq9ZU36o=
X-Google-Smtp-Source: AMrXdXvR4ngP8OHu6BGxNu6WmvbrozuSzGpPfbhE1kHKUamx/22mwB0GXXs6Zy+c1rqPTIpgCwWWkaq6iKRnwG5Eqg==
X-Received: from ackerleytng-cloudtop-sg.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:b30])
 (user=ackerleytng job=sendgmr) by 2002:a25:d10a:0:b0:7ff:48e9:4d09 with SMTP
 id i10-20020a25d10a000000b007ff48e94d09mr506496ybg.440.1674260174863; Fri, 20
 Jan 2023 16:16:14 -0800 (PST)
Date:   Sat, 21 Jan 2023 00:15:12 +0000
In-Reply-To: <20230121001542.2472357-1-ackerleytng@google.com>
Mime-Version: 1.0
References: <20230121001542.2472357-1-ackerleytng@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230121001542.2472357-2-ackerleytng@google.com>
Subject: [RFC PATCH v3 01/31] KVM: selftests: Add function to allow one-to-one
 GVA to GPA mappings
From:   Ackerley Tng <ackerleytng@google.com>
To:     linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, seanjc@google.com, isaku.yamahata@intel.com,
        sagis@google.com, erdemaktas@google.com, afranji@google.com,
        runanwang@google.com, shuah@kernel.org, drjones@redhat.com,
        maz@kernel.org, bgardon@google.com, jmattson@google.com,
        dmatlack@google.com, peterx@redhat.com, oupton@google.com,
        ricarkol@google.com, yang.zhong@intel.com, wei.w.wang@intel.com,
        xiaoyao.li@intel.com, pgonda@google.com, marcorr@google.com,
        eesposit@redhat.com, borntraeger@de.ibm.com, eric.auger@redhat.com,
        wangyanan55@huawei.com, aaronlewis@google.com, vkuznets@redhat.com,
        pshier@google.com, axelrasmussen@google.com,
        zhenzhong.duan@intel.com, maciej.szmigiero@oracle.com,
        like.xu@linux.intel.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

One-to-one GVA to GPA mappings can be used in the guest to set up boot
sequences during which paging is enabled, hence requiring a transition
from using physical to virtual addresses in consecutive instructions.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h     |  2 ++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 35 ++++++++++++++++---
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 8dac0f49d20b9..0db5cd4b8383a 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -402,6 +402,8 @@ void vm_mem_region_delete(struct kvm_vm *vm, uint32_t slot);
 struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id);
 vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
 vm_vaddr_t vm_vaddr_alloc_shared(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
+vm_vaddr_t vm_vaddr_alloc_1to1(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
+			       uint32_t data_memslot);
 vm_vaddr_t vm_vaddr_alloc_pages(struct kvm_vm *vm, int nr_pages);
 vm_vaddr_t vm_vaddr_alloc_page(struct kvm_vm *vm);
 
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index fa8aea97cdb62..5257bce6f546d 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1237,6 +1237,8 @@ static vm_vaddr_t vm_vaddr_unused_gap(struct kvm_vm *vm, size_t sz,
  *   vm - Virtual Machine
  *   sz - Size in bytes
  *   vaddr_min - Minimum starting virtual address
+ *   paddr_min - Minimum starting physical address
+ *   data_memslot - memslot number to allocate in
  *   encrypt - Whether the region should be handled as encrypted
  *
  * Output Args: None
@@ -1251,14 +1253,15 @@ static vm_vaddr_t vm_vaddr_unused_gap(struct kvm_vm *vm, size_t sz,
  * a page.
  */
 static vm_vaddr_t
-_vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min, bool encrypt)
+_vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
+		vm_paddr_t paddr_min, uint32_t data_memslot, bool encrypt)
 {
 	uint64_t pages = (sz >> vm->page_shift) + ((sz % vm->page_size) != 0);
 
 	virt_pgd_alloc(vm);
 	vm_paddr_t paddr = _vm_phy_pages_alloc(vm, pages,
-					       KVM_UTIL_MIN_PFN * vm->page_size,
-					       0, encrypt);
+					       paddr_min,
+					       data_memslot, encrypt);
 
 	/*
 	 * Find an unused range of virtual page addresses of at least
@@ -1281,12 +1284,34 @@ _vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min, bool encrypt
 
 vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min)
 {
-	return _vm_vaddr_alloc(vm, sz, vaddr_min, vm->protected);
+	return _vm_vaddr_alloc(vm, sz, vaddr_min,
+			       KVM_UTIL_MIN_PFN * vm->page_size, 0,
+			       vm->protected);
 }
 
 vm_vaddr_t vm_vaddr_alloc_shared(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min)
 {
-	return _vm_vaddr_alloc(vm, sz, vaddr_min, false);
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
2.39.0.246.g2a6d74b583-goog

