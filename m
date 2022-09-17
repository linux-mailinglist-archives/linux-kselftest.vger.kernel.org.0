Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A5D5BB666
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Sep 2022 07:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiIQFCj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 17 Sep 2022 01:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiIQFCi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 17 Sep 2022 01:02:38 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84A7B24AB;
        Fri, 16 Sep 2022 22:02:37 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MTzJR65vVzpStp;
        Sat, 17 Sep 2022 12:59:51 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 17 Sep
 2022 13:02:35 +0800
From:   Zhengchao Shao <shaozhengchao@huawei.com>
To:     <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <toke@toke.dk>, <vinicius.gomes@intel.com>,
        <stephen@networkplumber.org>, <shuah@kernel.org>,
        <victor@mojatatu.com>
CC:     <zhijianx.li@intel.com>, <weiyongjun1@huawei.com>,
        <yuehaibing@huawei.com>, <shaozhengchao@huawei.com>
Subject: [PATCH net-next,v2 09/18] selftests/tc-testings: add selftests for hfsc qdisc
Date:   Sat, 17 Sep 2022 13:04:18 +0800
Message-ID: <20220917050418.131667-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Test 3254: Create HFSC with default setting
Test 0289: Create HFSC with class sc and ul rate setting
Test 846a: Create HFSC with class sc umax and dmax setting
Test 5413: Create HFSC with class rt and ls rate setting
Test 9312: Create HFSC with class rt umax and dmax setting
Test 6931: Delete HFSC with handle
Test 8436: Show HFSC class

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 .../tc-testing/tc-tests/qdiscs/hfsc.json      | 167 ++++++++++++++++++
 1 file changed, 167 insertions(+)
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/qdiscs/hfsc.json

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hfsc.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hfsc.json
new file mode 100644
index 000000000000..af27b2c20e17
--- /dev/null
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hfsc.json
@@ -0,0 +1,167 @@
+[
+    {
+        "id": "3254",
+        "name": "Create HFSC with default setting",
+        "category": [
+            "qdisc",
+            "hfsc"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link add dev $DUMMY type dummy || /bin/true"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root hfsc",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc hfsc 1: root refcnt [0-9]+",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root",
+            "$IP link del dev $DUMMY type dummy"
+        ]
+    },
+    {
+        "id": "0289",
+        "name": "Create HFSC with class sc and ul rate setting",
+        "category": [
+            "qdisc",
+            "hfsc"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link add dev $DUMMY type dummy || /bin/true",
+            "$TC qdisc add dev $DUMMY handle 1: root hfsc default 11"
+        ],
+        "cmdUnderTest": "$TC class add dev $DUMMY parent 1: classid 1:1 hfsc sc rate 20000 ul rate 10000",
+        "expExitCode": "0",
+        "verifyCmd": "$TC class show dev $DUMMY",
+        "matchPattern": "class hfsc 1:1 parent 1: sc m1 0bit d 0us m2 20Kbit ul m1 0bit d 0us m2 10Kbit",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root",
+            "$IP link del dev $DUMMY type dummy"
+        ]
+    },
+    {
+        "id": "846a",
+        "name": "Create HFSC with class sc umax and dmax setting",
+        "category": [
+            "qdisc",
+            "hfsc"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link add dev $DUMMY type dummy || /bin/true",
+            "$TC qdisc add dev $DUMMY handle 1: root hfsc default 11"
+        ],
+        "cmdUnderTest": "$TC class add dev $DUMMY parent 1: classid 1:1 hfsc sc umax 1540 dmax 5ms rate 10000 ul rate 10000",
+        "expExitCode": "0",
+        "verifyCmd": "$TC class show dev $DUMMY",
+        "matchPattern": "class hfsc 1:1 parent 1: sc m1 2464Kbit d 5ms m2 10Kbit ul m1 0bit d 0us m2 10Kbit",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root",
+            "$IP link del dev $DUMMY type dummy"
+        ]
+    },
+    {
+        "id": "5413",
+        "name": "Create HFSC with class rt and ls rate setting",
+        "category": [
+            "qdisc",
+            "hfsc"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link add dev $DUMMY type dummy || /bin/true",
+            "$TC qdisc add dev $DUMMY handle 1: root hfsc default 11"
+        ],
+        "cmdUnderTest": "$TC class add dev $DUMMY parent 1: classid 1:1 hfsc rt rate 20000 ls rate 10000",
+        "expExitCode": "0",
+        "verifyCmd": "$TC class show dev $DUMMY",
+        "matchPattern": "class hfsc 1:1 parent 1: rt m1 0bit d 0us m2 20Kbit ls m1 0bit d 0us m2 10Kbit",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root",
+            "$IP link del dev $DUMMY type dummy"
+        ]
+    },
+    {
+        "id": "9312",
+        "name": "Create HFSC with class rt umax and dmax setting",
+        "category": [
+            "qdisc",
+            "hfsc"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link add dev $DUMMY type dummy || /bin/true",
+            "$TC qdisc add dev $DUMMY handle 1: root hfsc default 11"
+        ],
+        "cmdUnderTest": "$TC class add dev $DUMMY parent 1: classid 1:1 hfsc rt umax 1540 dmax 5ms rate 10000 ls rate 10000",
+        "expExitCode": "0",
+        "verifyCmd": "$TC class show dev $DUMMY",
+        "matchPattern": "class hfsc 1:1 parent 1: rt m1 2464Kbit d 5ms m2 10Kbit ls m1 0bit d 0us m2 10Kbit",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root",
+            "$IP link del dev $DUMMY type dummy"
+        ]
+    },
+    {
+        "id": "6931",
+        "name": "Delete HFSC with handle",
+        "category": [
+            "qdisc",
+            "hfsc"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link add dev $DUMMY type dummy || /bin/true",
+            "$TC qdisc add dev $DUMMY handle 1: root hfsc default 11"
+        ],
+        "cmdUnderTest": "$TC qdisc del dev $DUMMY handle 1: root",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc hfsc 1: root refcnt [0-9]+",
+        "matchCount": "0",
+        "teardown": [
+            "$IP link del dev $DUMMY type dummy"
+        ]
+    },
+    {
+        "id": "8436",
+        "name": "Show HFSC class",
+        "category": [
+            "qdisc",
+            "hfsc"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link add dev $DUMMY type dummy || /bin/true"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root hfsc",
+        "expExitCode": "0",
+        "verifyCmd": "$TC class show dev $DUMMY",
+        "matchPattern": "class hfsc 1: root",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root",
+            "$IP link del dev $DUMMY type dummy"
+        ]
+    }
+]
-- 
2.17.1

