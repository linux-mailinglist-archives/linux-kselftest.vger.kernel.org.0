Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451775BF3EC
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Sep 2022 04:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiIUCtl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Sep 2022 22:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiIUCte (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Sep 2022 22:49:34 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFE4B70;
        Tue, 20 Sep 2022 19:49:31 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MXN6m2bvJzMnmW;
        Wed, 21 Sep 2022 10:44:48 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 21 Sep
 2022 10:49:29 +0800
From:   Zhengchao Shao <shaozhengchao@huawei.com>
To:     <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
        <shuah@kernel.org>, <victor@mojatatu.com>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <shaozhengchao@huawei.com>
Subject: [PATCH net-next,v2 08/15] selftests/tc-testing: add selftests for pfifo_fast qdisc
Date:   Wed, 21 Sep 2022 10:50:45 +0800
Message-ID: <20220921025052.23465-9-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220921025052.23465-1-shaozhengchao@huawei.com>
References: <20220921025052.23465-1-shaozhengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Test 900c: Create pfifo_fast with default setting
Test 7470: Dump pfifo_fast stats
Test b974: Replace pfifo_fast with different handle
Test 3240: Delete pfifo_fast with valid handle
Test 4385: Delete pfifo_fast with invalid handle

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 .../tc-tests/qdiscs/pfifo_fast.json           | 119 ++++++++++++++++++
 1 file changed, 119 insertions(+)
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/qdiscs/pfifo_fast.json

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/pfifo_fast.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/pfifo_fast.json
new file mode 100644
index 000000000000..ab53238f4c5a
--- /dev/null
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/pfifo_fast.json
@@ -0,0 +1,119 @@
+[
+    {
+        "id": "900c",
+        "name": "Create pfifo_fast with default setting",
+        "category": [
+            "qdisc",
+            "pfifo_fast"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link add dev $DUMMY type dummy || /bin/true"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root pfifo_fast",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc pfifo_fast 1: root refcnt [0-9]+ bands 3 priomap",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root",
+            "$IP link del dev $DUMMY type dummy"
+        ]
+    },
+    {
+        "id": "7470",
+        "name": "Dump pfifo_fast stats",
+        "category": [
+            "qdisc",
+            "pfifo_fast"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link add dev $DUMMY type dummy || /bin/true"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root pfifo_fast",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DUMMY",
+        "matchPattern": "Sent.*bytes.*pkt \\(dropped.*overlimits.*requeues .*\\)",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root",
+            "$IP link del dev $DUMMY type dummy"
+        ]
+    },
+    {
+        "id": "b974",
+        "name": "Replace pfifo_fast with different handle",
+        "category": [
+            "qdisc",
+            "pfifo_fast"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link add dev $DUMMY type dummy || /bin/true",
+            "$TC qdisc add dev $DUMMY handle 1: root pfifo_fast"
+        ],
+        "cmdUnderTest": "$TC qdisc replace dev $DUMMY handle 2: root pfifo_fast",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc pfifo_fast 2: root refcnt [0-9]+ bands 3 priomap",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 2: root",
+            "$IP link del dev $DUMMY type dummy"
+        ]
+    },
+    {
+        "id": "3240",
+        "name": "Delete pfifo_fast with valid handle",
+        "category": [
+            "qdisc",
+            "pfifo_fast"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link add dev $DUMMY type dummy || /bin/true",
+            "$TC qdisc add dev $DUMMY handle 1: root pfifo_fast"
+        ],
+        "cmdUnderTest": "$TC qdisc del dev $DUMMY handle 1: root",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc pfifo_fast 1: root refcnt [0-9]+ bands 3 priomap",
+        "matchCount": "0",
+        "teardown": [
+            "$IP link del dev $DUMMY type dummy"
+        ]
+    },
+    {
+        "id": "4385",
+        "name": "Delete pfifo_fast with invalid handle",
+        "category": [
+            "qdisc",
+            "pfifo_fast"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link add dev $DUMMY type dummy || /bin/true",
+            "$TC qdisc add dev $DUMMY handle 1: root pfifo_fast"
+        ],
+        "cmdUnderTest": "$TC qdisc del dev $DUMMY handle 2: root",
+        "expExitCode": "2",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc pfifo_fast 1: root refcnt [0-9]+ bands 3 priomap",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root",
+            "$IP link del dev $DUMMY type dummy"
+        ]
+    }
+]
-- 
2.17.1

