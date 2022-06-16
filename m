Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B5854DC0D
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jun 2022 09:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242049AbiFPHmU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jun 2022 03:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359264AbiFPHmT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jun 2022 03:42:19 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680BA5D194;
        Thu, 16 Jun 2022 00:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655365338; x=1686901338;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QVIx4qVuVd8wCYaFS31911D6k3+63SEBMiaY928x8UE=;
  b=JmSgkhxTmNCHG8xCvnHnhpAtOycJEJyIq9R33hlZedO144uE4lHyqKVK
   43VXvY2N2PQ1GLdZWFDTfLDqfnZt1hB6kStdCVvwfPSsRUHfPv3Gm+YkS
   ApdzIrTK3Pyz81CCRSm/7BaWTf/AYmsTVffOgmsTkcvFw8TmBTkFi1Vio
   VOQVKtP/PYdGHMy5s9qjmEEvsclhEMJX8Gn/YIR+gqYediJ0AgwLD5YQ2
   p7t8FB9rDypX/oJLlji/BhYal0Ph/35cAkvCXYa/GSj+kMmfTPcQWaFc+
   gn87SBlTJ9VAOIn53SgwkovD2c78MXJoaOJM1OQ5SD/3DaEqsW/SlETNP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="279905787"
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="279905787"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 00:42:10 -0700
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="641418725"
Received: from yxiao-mobl1.ccr.corp.intel.com (HELO jiezho4x-mobl1.ccr.corp.intel.com) ([10.255.28.222])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 00:42:06 -0700
From:   Jie2x Zhou <jie2x.zhou@intel.com>
To:     jie2x.zhou@intel.com, shuah@kernel.org, pablo@netfilter.org,
        sbrivio@redhat.com, liuhangbin@gmail.com, fw@strlen.de
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] selftests: netfilter: correct PKTGEN_SCRIPT_PATHS in nft_concat_range.sh
Date:   Thu, 16 Jun 2022 15:40:46 +0800
Message-Id: <20220616074046.49349-1-jie2x.zhou@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Before change:
make -C netfilter
 TEST: performance
   net,port                                                      [SKIP]
   perf not supported
   port,net                                                      [SKIP]
   perf not supported
   net6,port                                                     [SKIP]
   perf not supported
   port,proto                                                    [SKIP]
   perf not supported
   net6,port,mac                                                 [SKIP]
   perf not supported
   net6,port,mac,proto                                           [SKIP]
   perf not supported
   net,mac                                                       [SKIP]
   perf not supported

After change:
   net,mac                                                       [ OK ]
     baseline (drop from netdev hook):               2061098pps
     baseline hash (non-ranged entries):             1606741pps
     baseline rbtree (match on first field only):    1191607pps
     set with  1000 full, ranged entries:            1639119pps
ok 8 selftests: netfilter: nft_concat_range.sh

Fixes: 611973c1e06f ("selftests: netfilter: Introduce tests for sets with range concatenation")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jie2x Zhou <jie2x.zhou@intel.com>
---
 tools/testing/selftests/netfilter/nft_concat_range.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/netfilter/nft_concat_range.sh b/tools/testing/selftests/netfilter/nft_concat_range.sh
index b35010cc7f6a..a6991877e50c 100755
--- a/tools/testing/selftests/netfilter/nft_concat_range.sh
+++ b/tools/testing/selftests/netfilter/nft_concat_range.sh
@@ -31,7 +31,7 @@ BUGS="flush_remove_add reload"
 
 # List of possible paths to pktgen script from kernel tree for performance tests
 PKTGEN_SCRIPT_PATHS="
-	../../../samples/pktgen/pktgen_bench_xmit_mode_netif_receive.sh
+	../../../../samples/pktgen/pktgen_bench_xmit_mode_netif_receive.sh
 	pktgen/pktgen_bench_xmit_mode_netif_receive.sh"
 
 # Definition of set types:
-- 
2.34.1

