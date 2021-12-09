Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4AB46E0AC
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Dec 2021 03:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhLICGw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Dec 2021 21:06:52 -0500
Received: from mga17.intel.com ([192.55.52.151]:9219 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhLICGw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Dec 2021 21:06:52 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="218682638"
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="218682638"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 18:03:11 -0800
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="503306622"
Received: from cxia1-mobl.ccr.corp.intel.com (HELO lkp-zhoujie.ccr.corp.intel.com) ([10.255.28.13])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 18:03:06 -0800
From:   Jie2x Zhou <jie2x.zhou@intel.com>
To:     davem@davemloft.net, kuba@kernel.org, shuah@kernel.org,
        dsahern@gmail.com
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com, xinjianx.ma@intel.com,
        zhijianx.li@intel.com, Philip Li <philip.li@intel.com>,
        Jie2x Zhou <jie2x.zhou@intel.com>
Subject: [PATCH v3] selftests: net: Correct ping6 expected rc from 2 to 1
Date:   Thu,  9 Dec 2021 10:02:30 +0800
Message-Id: <20211209020230.37270-1-jie2x.zhou@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

./fcnal-test.sh -v -t ipv6_ping
TEST: ping out, VRF bind - ns-B IPv6 LLA                                      [FAIL]
TEST: ping out, VRF bind - multicast IP                                       [FAIL]

ping6 is failing as it should.
COMMAND: ip netns exec ns-A /bin/ping6 -c1 -w1 fe80::7c4c:bcff:fe66:a63a%red
strace of ping6 shows it is failing with '1',
so change the expected rc from 2 to 1.

Fixes: c0644e71df33 ("selftests: Add ipv6 ping tests to fcnal-test")
Reported-by: kernel test robot <lkp@intel.com>
Suggested-by: David Ahern <dsahern@gmail.com>
Signed-off-by: Jie2x Zhou <jie2x.zhou@intel.com>
---
 tools/testing/selftests/net/fcnal-test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/fcnal-test.sh b/tools/testing/selftests/net/fcnal-test.sh
index 7f5b265fcb90..966787c2f9f0 100755
--- a/tools/testing/selftests/net/fcnal-test.sh
+++ b/tools/testing/selftests/net/fcnal-test.sh
@@ -2191,7 +2191,7 @@ ipv6_ping_vrf()
 		log_start
 		show_hint "Fails since VRF device does not support linklocal or multicast"
 		run_cmd ${ping6} -c1 -w1 ${a}
-		log_test_addr ${a} $? 2 "ping out, VRF bind"
+		log_test_addr ${a} $? 1 "ping out, VRF bind"
 	done
 
 	for a in ${NSB_IP6} ${NSB_LO_IP6} ${NSB_LINKIP6}%${NSA_DEV} ${MCAST}%${NSA_DEV}
-- 
2.31.1

