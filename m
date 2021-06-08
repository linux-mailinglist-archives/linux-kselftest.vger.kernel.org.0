Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC7239EFC3
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jun 2021 09:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhFHHjf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Jun 2021 03:39:35 -0400
Received: from mga17.intel.com ([192.55.52.151]:17006 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhFHHje (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Jun 2021 03:39:34 -0400
IronPort-SDR: o/peA7vsMv4Efj1UdwbbzuV3LxlpvQoZF0Q/eJnsaSQ6LTkX8tLtpKnMoS1jlMnp6R8a3z/0gx
 QVUh6Zk61GNw==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="185164409"
X-IronPort-AV: E=Sophos;i="5.83,257,1616482800"; 
   d="scan'208";a="185164409"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 00:37:25 -0700
IronPort-SDR: O+l3HrptjXNdUmI0Uw9UKpX+Vt+fAHQm7l8e3GskPqNQPDPiHSm+0RdM0IRIlRS3THXmAdgjmY
 5V6tG6wLAfUA==
X-IronPort-AV: E=Sophos;i="5.83,257,1616482800"; 
   d="scan'208";a="481846541"
Received: from duan-client-optiplex-7080.bj.intel.com ([10.238.156.114])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 00:37:23 -0700
From:   Zhenzhong Duan <zhenzhong.duan@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        maciej.szmigiero@oracle.com, drjones@redhat.com,
        pbonzini@redhat.com, shuah@kernel.org,
        Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 1/3] Revert "selftests: kvm: make allocation of extra memory take effect"
Date:   Wed,  9 Jun 2021 07:38:14 +0800
Message-Id: <20210608233816.423958-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210608233816.423958-1-zhenzhong.duan@intel.com>
References: <20210608233816.423958-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This reverts commit 39fe2fc96694164723846fccf6caa42c3aee6ec4.

Parameter extra_mem_pages in vm_create_default() is used to calculate
the page table size for all the memory chunks.
Real memory allocation for non-slot0 memory happens by extra call of
vm_userspace_mem_region_add() outside of vm_create_default().

The reverted commit changed above meaning of extra_mem_pages as extra
slot0 memory size. This way made the page table size calculations
open coded in separate test.

Link: https://lkml.org/lkml/2021/6/3/551
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 28e528c19d28..63418df921f0 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -320,7 +320,7 @@ struct kvm_vm *vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus,
 	 */
 	uint64_t vcpu_pages = (DEFAULT_STACK_PGS + num_percpu_pages) * nr_vcpus;
 	uint64_t extra_pg_pages = (extra_mem_pages + vcpu_pages) / PTES_PER_MIN_PAGE * 2;
-	uint64_t pages = DEFAULT_GUEST_PHY_PAGES + extra_mem_pages + vcpu_pages + extra_pg_pages;
+	uint64_t pages = DEFAULT_GUEST_PHY_PAGES + vcpu_pages + extra_pg_pages;
 	struct kvm_vm *vm;
 	int i;
 
-- 
2.25.1

