Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C69718FE6
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jun 2023 03:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjFABPK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 May 2023 21:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjFABPK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 May 2023 21:15:10 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A651B125;
        Wed, 31 May 2023 18:15:08 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QWp3728NCz18LSq;
        Thu,  1 Jun 2023 09:10:27 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 1 Jun
 2023 09:15:05 +0800
From:   Zhengchao Shao <shaozhengchao@huawei.com>
To:     <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
        <shuah@kernel.org>
CC:     <kuba@kernel.org>, <victor@mojatatu.com>,
        <peilin.ye@bytedance.com>, <weiyongjun1@huawei.com>,
        <yuehaibing@huawei.com>, <shaozhengchao@huawei.com>,
        <pctammela@mojatatu.com>
Subject: [PATCH net-next,v2] selftests/tc-testing: replace mq with invalid parent ID
Date:   Thu, 1 Jun 2023 09:22:50 +0800
Message-ID: <20230601012250.52738-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The test case shown in [1] triggers the kernel to access the null pointer.
Therefore, add related test cases to mq.
The test results are as follows:

./tdc.py -e 0531
1..1
ok 1 0531 - Replace mq with invalid parent ID

./tdc.py -c mq
1..8
ok 1 ce7d - Add mq Qdisc to multi-queue device (4 queues)
ok 2 2f82 - Add mq Qdisc to multi-queue device (256 queues)
ok 3 c525 - Add duplicate mq Qdisc
ok 4 128a - Delete nonexistent mq Qdisc
ok 5 03a9 - Delete mq Qdisc twice
ok 6 be0f - Add mq Qdisc to single-queue device
ok 7 1023 - Show mq class
ok 8 0531 - Replace mq with invalid parent ID

[1] https://lore.kernel.org/all/20230527093747.3583502-1-shaozhengchao@huawei.com/
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 .../tc-testing/tc-tests/qdiscs/mq.json        | 25 ++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/mq.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/mq.json
index 44fbfc6caec7..e3d2de5c184f 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/mq.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/mq.json
@@ -155,5 +155,28 @@
             "teardown": [
                 "echo \"1\" > /sys/bus/netdevsim/del_device"
             ]
-        }
+	},
+	{
+		"id": "0531",
+		"name": "Replace mq with invalid parent ID",
+		"category": [
+			"qdisc",
+			"mq"
+		],
+		"plugins": {
+			"requires": "nsPlugin"
+		},
+		"setup": [
+			"echo \"1 1 16\" > /sys/bus/netdevsim/new_device",
+			"$TC qdisc add dev $ETH root handle ffff: mq"
+		],
+		"cmdUnderTest": "$TC qdisc replace dev $ETH parent ffff:fff1 handle ffff: mq",
+		"expExitCode": "2",
+		"verifyCmd": "$TC qdisc show dev $ETH",
+		"matchPattern": "qdisc [a-zA-Z0-9_]+ 0: parent ffff",
+		"matchCount": "16",
+		"teardown": [
+			"echo \"1\" > /sys/bus/netdevsim/del_device"
+		]
+	}
 ]
-- 
2.34.1

