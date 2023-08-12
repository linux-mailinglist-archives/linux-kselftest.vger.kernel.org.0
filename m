Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CC9779E39
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Aug 2023 10:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbjHLIgK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 12 Aug 2023 04:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233662AbjHLIgH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 12 Aug 2023 04:36:07 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C612696;
        Sat, 12 Aug 2023 01:36:09 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RNDVh1TDDz1GDY9;
        Sat, 12 Aug 2023 16:34:52 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 12 Aug
 2023 16:36:06 +0800
From:   Zhengchao Shao <shaozhengchao@huawei.com>
To:     <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <shuah@kernel.org>
CC:     <j.vosburgh@gmail.com>, <andy@greyhouse.net>,
        <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <shaozhengchao@huawei.com>
Subject: [PATCH net-next] selftests: bonding: remove redundant delete action of device link1_1
Date:   Sat, 12 Aug 2023 16:40:36 +0800
Message-ID: <20230812084036.1834188-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When run command "ip netns delete client", device link1_1 has been
deleted. So, it is no need to delete link1_1 again. Remove it.

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 .../drivers/net/bonding/bond-arp-interval-causes-panic.sh        | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh b/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh
index 71c00bfafbc9..7b2d421f09cf 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh
@@ -11,7 +11,6 @@ finish()
 {
 	ip netns delete server || true
 	ip netns delete client || true
-	ip link del link1_1 || true
 }
 
 trap finish EXIT
-- 
2.34.1

