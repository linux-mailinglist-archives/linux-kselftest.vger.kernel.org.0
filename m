Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9468B37A6AB
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 May 2021 14:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbhEKMbf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 May 2021 08:31:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:23526 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230225AbhEKMbe (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 May 2021 08:31:34 -0400
IronPort-SDR: CvsD45L9PuIr9SJD+hpXmTpC498oL5h+Diw2b5r324ektfrmS9fJ9DcNydyfTbu7uKgZGxOJ2B
 rPifdYLvgSgw==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="199108946"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="199108946"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 05:30:28 -0700
IronPort-SDR: LSSDBtLdcphiCsXB/4quGD+UMacuYngM3MvfRNb4+AkMb2XnYUyoQ61Y+0Fmg5ds/XySGXAQHA
 JYDZEo5ljoDw==
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="436634148"
Received: from duan-client-optiplex-7080.bj.intel.com ([10.238.156.114])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 05:30:26 -0700
From:   Zhenzhong Duan <zhenzhong.duan@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, shuah@kernel.org,
        Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH] selftests: kvm: Fix a potential elf loading issue
Date:   Wed, 12 May 2021 12:31:07 +0800
Message-Id: <20210512043107.30076-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210512043107.30076-1-zhenzhong.duan@intel.com>
References: <20210512043107.30076-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

vm_vaddr_alloc() setup GVA to GPA mapping page by page, then GPA may not be
continuous if same memslot is used for data and page table allocation.

kvm_vm_elf_load() expects a continuous memory of GPA or else it need to
read file data page by page. Fix it by adding a check in vm_vaddr_alloc()
to ensure memory is allocated in a whole if same memslot is used for data
and page table.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 159f4d62241d..6118a2f8906e 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1097,9 +1097,14 @@ vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
 			  uint32_t data_memslot, uint32_t pgd_memslot)
 {
 	uint64_t pages = (sz >> vm->page_shift) + ((sz % vm->page_size) != 0);
+	vm_paddr_t paddr_start = 0;
 
 	virt_pgd_alloc(vm, pgd_memslot);
 
+	if (data_memslot == pgd_memslot)
+		paddr_start = vm_phy_pages_alloc(vm, pages,
+				KVM_UTIL_MIN_PFN * vm->page_size, data_memslot);
+
 	/*
 	 * Find an unused range of virtual page addresses of at least
 	 * pages in length.
@@ -1111,8 +1116,12 @@ vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
 		pages--, vaddr += vm->page_size) {
 		vm_paddr_t paddr;
 
-		paddr = vm_phy_page_alloc(vm,
-				KVM_UTIL_MIN_PFN * vm->page_size, data_memslot);
+		if (paddr_start) {
+			paddr = paddr_start;
+			paddr_start += vm->page_size;
+		} else
+			paddr = vm_phy_page_alloc(vm,
+					KVM_UTIL_MIN_PFN * vm->page_size, data_memslot);
 
 		virt_pg_map(vm, vaddr, paddr, pgd_memslot);
 
-- 
2.25.1

