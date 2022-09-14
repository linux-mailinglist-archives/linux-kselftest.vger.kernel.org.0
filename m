Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0085B85DC
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Sep 2022 12:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbiINKBI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Sep 2022 06:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiINKBC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Sep 2022 06:01:02 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4C1696F2;
        Wed, 14 Sep 2022 03:00:48 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MSG4h58XtzHnsH;
        Wed, 14 Sep 2022 17:58:44 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 14 Sep
 2022 18:00:45 +0800
From:   Zhengchao Shao <shaozhengchao@huawei.com>
To:     <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <jhs@mojatatu.com>,
        <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <shuah@kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>, <weiyongjun1@huawei.com>,
        <yuehaibing@huawei.com>, <shaozhengchao@huawei.com>
Subject: [PATCH net-next,v2 8/9] selftests/tc-testings: add selftests for tcindex filter
Date:   Wed, 14 Sep 2022 18:02:20 +0800
Message-ID: <20220914100221.386855-9-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220914100221.386855-1-shaozhengchao@huawei.com>
References: <20220914100221.386855-1-shaozhengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Test 8293: Add tcindex filter with default action
Test 7281: Add tcindex filter with hash size and pass action
Test b294: Add tcindex filter with mask shift and reclassify action
Test 0532: Add tcindex filter with pass_on and continue actions
Test d473: Add tcindex filter with pipe action
Test 2940: Add tcindex filter with miltiple actions
Test 1893: List tcindex filters
Test 2041: Change tcindex filter with pass action
Test 9203: Replace tcindex filter with pass action
Test 7957: Delete tcindex filter with drop action

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 .../tc-testing/tc-tests/filters/tcindex.json  | 227 ++++++++++++++++++
 1 file changed, 227 insertions(+)
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/filters/tcindex.json

diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/tcindex.json b/tools/testing/selftests/tc-testing/tc-tests/filters/tcindex.json
new file mode 100644
index 000000000000..22c63392a322
--- /dev/null
+++ b/tools/testing/selftests/tc-testing/tc-tests/filters/tcindex.json
@@ -0,0 +1,227 @@
+[
+    {
+        "id": "8293",
+        "name": "Add tcindex filter with default action",
+        "category": [
+            "filter",
+            "tcindex"
+        ],
+	"plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 ingress"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DEV1 parent ffff: handle 1 protocol ip prio 1 tcindex classid 1:1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC filter get dev $DEV1 parent ffff: handle 1 prio 1 protocol ip tcindex",
+        "matchPattern": "^filter parent ffff: protocol ip pref 1 tcindex chain 0 handle 0x0001 classid 1:1",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 ingress"
+        ]
+    },
+    {
+        "id": "7281",
+        "name": "Add tcindex filter with hash size and pass action",
+        "category": [
+            "filter",
+            "tcindex"
+        ],
+	"plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 ingress"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DEV1 parent ffff: handle 1 protocol ip prio 1 tcindex hash 32 fall_through classid 1:1 action pass",
+        "expExitCode": "0",
+        "verifyCmd": "$TC filter get dev $DEV1 parent ffff: handle 1 prio 1 protocol ip tcindex",
+        "matchPattern": "^filter parent ffff: protocol ip pref.*tcindex chain [0-9]+ handle 0x0001 classid 1:1.*action order [0-9]+: gact action pass",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 ingress"
+        ]
+    },
+    {
+        "id": "b294",
+        "name": "Add tcindex filter with mask shift and reclassify action",
+        "category": [
+            "filter",
+            "tcindex"
+        ],
+	"plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 ingress"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DEV1 parent ffff: handle 1 protocol ip prio 1 tcindex hash 32 mask 1 shift 2 fall_through classid 1:1 action reclassify",
+        "expExitCode": "0",
+        "verifyCmd": "$TC filter get dev $DEV1 parent ffff: handle 1 prio 1 protocol ip tcindex",
+        "matchPattern": "^filter parent ffff: protocol ip pref.*tcindex chain [0-9]+ handle 0x0001 classid 1:1.*action order [0-9]+: gact action reclassify",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 ingress"
+        ]
+    },
+    {
+        "id": "0532",
+        "name": "Add tcindex filter with pass_on and continue actions",
+        "category": [
+            "filter",
+            "tcindex"
+        ],
+	"plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 ingress"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DEV1 parent ffff: handle 1 protocol ip prio 1 tcindex hash 32 mask 1 shift 2 pass_on classid 1:1 action continue",
+        "expExitCode": "0",
+        "verifyCmd": "$TC filter get dev $DEV1 parent ffff: handle 1 prio 1 protocol ip tcindex",
+        "matchPattern": "^filter parent ffff: protocol ip pref.*tcindex chain [0-9]+ handle 0x0001 classid 1:1.*action order [0-9]+: gact action continue",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 ingress"
+        ]
+    },
+    {
+        "id": "d473",
+        "name": "Add tcindex filter with pipe action",
+        "category": [
+            "filter",
+            "tcindex"
+        ],
+	"plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 ingress"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DEV1 parent ffff: handle 1 protocol ip prio 1 tcindex hash 32 mask 1 shift 2 fall_through classid 1:1 action pipe",
+        "expExitCode": "0",
+        "verifyCmd": "$TC filter get dev $DEV1 parent ffff: handle 1 prio 1 protocol ip tcindex",
+        "matchPattern": "^filter parent ffff: protocol ip pref.*tcindex chain [0-9]+ handle 0x0001 classid 1:1.*action order [0-9]+: gact action pipe",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 ingress"
+        ]
+    },
+    {
+        "id": "2940",
+        "name": "Add tcindex filter with miltiple actions",
+        "category": [
+            "filter",
+            "tcindex"
+        ],
+	"plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 ingress"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DEV1 parent ffff: handle 1 protocol ip prio 7 tcindex hash 32 mask 1 shift 2 fall_through classid 1:1 action skbedit mark 7 pipe action gact drop",
+        "expExitCode": "0",
+        "verifyCmd": "$TC filter get dev $DEV1 parent ffff: handle 1 prio 7 protocol ip tcindex",
+        "matchPattern": "^filter parent ffff: protocol ip pref 7 tcindex.*handle 0x0001.*action.*skbedit.*mark 7 pipe.*action.*gact action drop",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 ingress"
+        ]
+    },
+    {
+        "id": "1893",
+        "name": "List tcindex filters",
+        "category": [
+            "filter",
+            "tcindex"
+        ],
+	"plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 ingress",
+            "$TC filter add dev $DEV1 parent ffff: handle 1 protocol ip prio 1 tcindex classid 1:1",
+	    "$TC filter add dev $DEV1 parent ffff: handle 2 protocol ip prio 1 tcindex classid 1:1"
+        ],
+        "cmdUnderTest": "$TC filter show dev $DEV1 parent ffff:",
+        "expExitCode": "0",
+        "verifyCmd": "$TC filter show dev $DEV1 parent ffff:",
+        "matchPattern": "handle 0x000[0-9]+ classid 1:1",
+        "matchCount": "2",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 ingress"
+        ]
+    },
+    {
+        "id": "2041",
+        "name": "Change tcindex filter with pass action",
+        "category": [
+            "filter",
+            "tcindex"
+        ],
+	"plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 ingress",
+            "$TC filter add dev $DEV1 parent ffff: handle 1 protocol ip prio 1 tcindex classid 1:1 action drop"
+        ],
+        "cmdUnderTest": "$TC filter change dev $DEV1 parent ffff: handle 1 protocol ip prio 1 tcindex classid 1:1 action pass",
+        "expExitCode": "0",
+        "verifyCmd": "$TC filter get dev $DEV1 parent ffff: handle 1 prio 1 protocol ip tcindex",
+        "matchPattern": "handle 0x0001 classid 1:1.*action order [0-9]+: gact action pass",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 ingress"
+        ]
+    },
+    {
+        "id": "9203",
+        "name": "Replace tcindex filter with pass action",
+        "category": [
+            "filter",
+            "tcindex"
+        ],
+	"plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 ingress",
+            "$TC filter add dev $DEV1 parent ffff: handle 1 protocol ip prio 1 tcindex classid 1:1 action drop"
+        ],
+        "cmdUnderTest": "$TC filter replace dev $DEV1 parent ffff: handle 1 protocol ip prio 1 tcindex classid 1:1 action pass",
+        "expExitCode": "0",
+        "verifyCmd": "$TC filter get dev $DEV1 parent ffff: handle 1 prio 1 protocol ip tcindex",
+        "matchPattern": "handle 0x0001 classid 1:1.*action order [0-9]+: gact action pass",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 ingress"
+        ]
+    },
+    {
+        "id": "7957",
+        "name": "Delete tcindex filter with drop action",
+        "category": [
+            "filter",
+            "tcindex"
+        ],
+	"plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 ingress",
+            "$TC filter add dev $DEV1 parent ffff: handle 1 protocol ip prio 1 tcindex classid 1:1 action drop"
+        ],
+        "cmdUnderTest": "$TC filter del dev $DEV1 parent ffff: handle 1 protocol ip prio 1 tcindex classid 1:1 action drop",
+        "expExitCode": "0",
+        "verifyCmd": "$TC filter get dev $DEV1 parent ffff: handle 1 prio 1 protocol ip tcindex",
+        "matchPattern": "handle 0x0001 classid 1:1.*action order [0-9]+: gact action drop",
+        "matchCount": "0",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 ingress"
+        ]
+    }
+]
-- 
2.17.1

