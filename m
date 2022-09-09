Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E51A5B2B8B
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 03:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiIIB1u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Sep 2022 21:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiIIB1k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Sep 2022 21:27:40 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54621177AB;
        Thu,  8 Sep 2022 18:27:39 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MNyx16cZ1zHnlY;
        Fri,  9 Sep 2022 09:25:41 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 9 Sep
 2022 09:27:37 +0800
From:   Zhengchao Shao <shaozhengchao@huawei.com>
To:     <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
        <shuah@kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <shaozhengchao@huawei.com>
Subject: [PATCH net-next 6/8] selftests/tc-testings: add nat action deleting test case
Date:   Fri, 9 Sep 2022 09:29:34 +0800
Message-ID: <20220909012936.268433-7-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220909012936.268433-1-shaozhengchao@huawei.com>
References: <20220909012936.268433-1-shaozhengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

Test b811: Delete nat action with valid index
Test a521: Delete nat action with invalid index

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 .../tc-testing/tc-tests/actions/nat.json      | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/nat.json b/tools/testing/selftests/tc-testing/tc-tests/actions/nat.json
index bc12c1ccad30..0a3c491edbc5 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/actions/nat.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/actions/nat.json
@@ -614,5 +614,55 @@
         "teardown": [
             "$TC actions flush action nat"
         ]
+    },
+    {
+        "id": "b811",
+        "name": "Delete nat action with valid index",
+        "category": [
+            "actions",
+            "nat"
+        ],
+        "setup": [
+            [
+                "$TC actions flush action nat",
+                0,
+                1,
+                255
+            ],
+            "$TC actions add action nat ingress 1.1.1.1 2.2.2.2 drop index 20"
+        ],
+        "cmdUnderTest": "$TC actions del action nat index 20",
+        "expExitCode": "0",
+        "verifyCmd": "$TC actions ls action nat index 20",
+        "matchPattern": "action order [0-9]+:  nat ingress 1.1.1.1/32 2.2.2.2 drop.*index 20 ref",
+        "matchCount": "0",
+        "teardown": [
+            "$TC actions flush action nat"
+        ]
+    },
+    {
+        "id": "a521",
+        "name": "Delete nat action with invalid index",
+        "category": [
+            "actions",
+            "nat"
+        ],
+        "setup": [
+            [
+                "$TC actions flush action nat",
+                0,
+                1,
+                255
+            ],
+            "$TC actions add action nat ingress 1.1.1.1 2.2.2.2 drop index 20"
+        ],
+        "cmdUnderTest": "$TC actions del action nat index 10",
+        "expExitCode": "255",
+        "verifyCmd": "$TC actions ls action nat index 20",
+        "matchPattern": "action order [0-9]+:  nat ingress 1.1.1.1/32 2.2.2.2 drop.*index 20 ref",
+        "matchCount": "1",
+        "teardown": [
+            "$TC actions flush action nat"
+        ]
     }
 ]
-- 
2.17.1

