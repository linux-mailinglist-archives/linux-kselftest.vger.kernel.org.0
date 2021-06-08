Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E441939EFC9
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jun 2021 09:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhFHHjn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Jun 2021 03:39:43 -0400
Received: from mga17.intel.com ([192.55.52.151]:17020 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhFHHjn (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Jun 2021 03:39:43 -0400
IronPort-SDR: oqegSr6O5xLLFpG3vWWrtCVxKgf/hxx6NV51envw5XxHtgdOBNA96jGlx3V6UX5CioEE9yQ83C
 Gwhdq+WSZf6g==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="185164450"
X-IronPort-AV: E=Sophos;i="5.83,257,1616482800"; 
   d="scan'208";a="185164450"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 00:37:27 -0700
IronPort-SDR: ESQDn1oVUUnLsgYy9uO23b2a++xALaKlQQlfVrk5E3znsCBt3c25rOOsv3KbXondN/waqnJQXk
 RdGdG3dqLANw==
X-IronPort-AV: E=Sophos;i="5.83,257,1616482800"; 
   d="scan'208";a="481846548"
Received: from duan-client-optiplex-7080.bj.intel.com ([10.238.156.114])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 00:37:25 -0700
From:   Zhenzhong Duan <zhenzhong.duan@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        maciej.szmigiero@oracle.com, drjones@redhat.com,
        pbonzini@redhat.com, shuah@kernel.org,
        Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 2/3] Revert "selftests: kvm: fix overlapping addresses in memslot_perf_test"
Date:   Wed,  9 Jun 2021 07:38:15 +0800
Message-Id: <20210608233816.423958-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210608233816.423958-1-zhenzhong.duan@intel.com>
References: <20210608233816.423958-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This reverts commit 000ac42953395a4f0a63d5db640c5e4c88a548c5.

As (39fe2fc96694 "selftests: kvm: make allocation of extra memory take
effect") is reverted, this relevant commit should be reverted too.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 tools/testing/selftests/kvm/memslot_perf_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/memslot_perf_test.c b/tools/testing/selftests/kvm/memslot_perf_test.c
index 9307f25d8130..11239652d805 100644
--- a/tools/testing/selftests/kvm/memslot_perf_test.c
+++ b/tools/testing/selftests/kvm/memslot_perf_test.c
@@ -267,7 +267,7 @@ static bool prepare_vm(struct vm_data *data, int nslots, uint64_t *maxslots,
 	data->hva_slots = malloc(sizeof(*data->hva_slots) * data->nslots);
 	TEST_ASSERT(data->hva_slots, "malloc() fail");
 
-	data->vm = vm_create_default(VCPU_ID, 1024, guest_code);
+	data->vm = vm_create_default(VCPU_ID, mempages, guest_code);
 
 	pr_info_v("Adding slots 1..%i, each slot with %"PRIu64" pages + %"PRIu64" extra pages last\n",
 		max_mem_slots - 1, data->pages_per_slot, rempages);
-- 
2.25.1

