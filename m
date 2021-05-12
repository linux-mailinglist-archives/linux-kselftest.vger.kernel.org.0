Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523E637A6AD
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 May 2021 14:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbhEKMbf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 May 2021 08:31:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:23526 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231432AbhEKMbf (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 May 2021 08:31:35 -0400
IronPort-SDR: ZMp9bP8vZBOS/6OitNw0BHzbQoZBmM0F6hUTnPgbkYLOAfoot52Cemoku/6oR18g88W7twWrBp
 5W4H+qJRh4Sg==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="199108941"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="199108941"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 05:30:26 -0700
IronPort-SDR: iZsLdeOIW/rdw0bWGu15JHNiN+raV5v41OwxlkIvP9QvlOABntQoU6krP2S5Held2csza33y9g
 18uqcib9GL6g==
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="436634130"
Received: from duan-client-optiplex-7080.bj.intel.com ([10.238.156.114])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 05:30:24 -0700
From:   Zhenzhong Duan <zhenzhong.duan@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, shuah@kernel.org,
        Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH] selftests: kvm: make allocation of extra memory take effect
Date:   Wed, 12 May 2021 12:31:06 +0800
Message-Id: <20210512043107.30076-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The extra memory pages is missed to be allocated during VM creating.
perf_test_util and kvm_page_table_test use it to alloc extra memory
currently.

Fix it by adding extra_mem_pages to the total memory calculation before
allocate.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index fc83f6c5902d..159f4d62241d 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -295,7 +295,7 @@ struct kvm_vm *vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus,
 	 */
 	uint64_t vcpu_pages = (DEFAULT_STACK_PGS + num_percpu_pages) * nr_vcpus;
 	uint64_t extra_pg_pages = (extra_mem_pages + vcpu_pages) / PTES_PER_MIN_PAGE * 2;
-	uint64_t pages = DEFAULT_GUEST_PHY_PAGES + vcpu_pages + extra_pg_pages;
+	uint64_t pages = DEFAULT_GUEST_PHY_PAGES + extra_mem_pages + vcpu_pages + extra_pg_pages;
 	struct kvm_vm *vm;
 	int i;
 
-- 
2.25.1

