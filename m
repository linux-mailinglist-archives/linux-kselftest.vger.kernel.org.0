Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986BC5BB672
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Sep 2022 07:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiIQFEF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 17 Sep 2022 01:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiIQFEC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 17 Sep 2022 01:04:02 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEF0B6D09;
        Fri, 16 Sep 2022 22:04:01 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MTzHs67h9zMmxR;
        Sat, 17 Sep 2022 12:59:21 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 17 Sep
 2022 13:03:59 +0800
From:   Zhengchao Shao <shaozhengchao@huawei.com>
To:     <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <toke@toke.dk>, <vinicius.gomes@intel.com>,
        <stephen@networkplumber.org>, <shuah@kernel.org>,
        <victor@mojatatu.com>
CC:     <zhijianx.li@intel.com>, <weiyongjun1@huawei.com>,
        <yuehaibing@huawei.com>, <shaozhengchao@huawei.com>
Subject: [PATCH net-next,v2 15/18] selftests/tc-testings: add show class case for ingress qdisc
Date:   Sat, 17 Sep 2022 13:05:43 +0800
Message-ID: <20220917050543.132615-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Test 0521: Show ingress class

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 .../tc-testing/tc-tests/qdiscs/ingress.json   | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/ingress.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/ingress.json
index d99dba6e2b1a..11d33362408c 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/ingress.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/ingress.json
@@ -98,5 +98,25 @@
         "teardown": [
             "$IP link del dev $DUMMY type dummy"
         ]
+    },
+    {
+        "id": "0521",
+        "name": "Show ingress class",
+        "category": [
+            "qdisc",
+            "ingress"
+        ],
+        "setup": [
+            "$IP link add dev $DUMMY type dummy || /bin/true"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY ingress",
+        "expExitCode": "0",
+        "verifyCmd": "$TC class show dev $DUMMY",
+        "matchPattern": "class ingress",
+        "matchCount": "0",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY ingress",
+            "$IP link del dev $DUMMY type dummy"
+        ]
     }
 ]
-- 
2.17.1

