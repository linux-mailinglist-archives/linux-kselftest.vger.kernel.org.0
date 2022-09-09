Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A4A5B310C
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 09:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiIIH5W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Sep 2022 03:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiIIH4y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Sep 2022 03:56:54 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE7B10B552;
        Fri,  9 Sep 2022 00:55:39 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MP7Wx5qhBznVDK;
        Fri,  9 Sep 2022 15:53:01 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 15:55:37 +0800
From:   Zhao Gongyi <zhaogongyi@huawei.com>
To:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>
CC:     <akinobu.mita@gmail.com>, <corbet@lwn.net>, <david@redhat.com>,
        <osalvador@suse.de>, <shuah@kernel.org>,
        Zhao Gongyi <zhaogongyi@huawei.com>
Subject: [PATCH -next 3/5] selftests/memory-hotplug: Add checking after online or offline
Date:   Fri, 9 Sep 2022 15:51:58 +0800
Message-ID: <20220909075200.198363-4-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220909075200.198363-1-zhaogongyi@huawei.com>
References: <20220909075200.198363-1-zhaogongyi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add checking for online_memory_expect_success()/
offline_memory_expect_success()/offline_memory_expect_fail(), or
the test would exit 0 although the functions return 1.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 .../memory-hotplug/mem-on-off-test.sh          | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh b/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
index f1a9d81b934c..3bdf3c4d6d06 100755
--- a/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
+++ b/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
@@ -267,7 +267,11 @@ done
 printf %#x $error > $NOTIFIER_ERR_INJECT_DIR/actions/MEM_GOING_ONLINE/erro

 for memory in `hotpluggable_offline_memory`; do
-	online_memory_expect_fail $memory
+	online_memory_expect_fail $memory || {
+		echo "online memory $memory: unexpected success"
+		retval=1
+	}
+
 done

 #
@@ -275,7 +279,11 @@ done
 #
 echo 0 > $NOTIFIER_ERR_INJECT_DIR/actions/MEM_GOING_ONLINE/error
 for memory in `hotpluggable_offline_memory`; do
-	online_memory_expect_success $memory
+	online_memory_expect_success $memory || {
+		echo "online memory $memory: unexpected fail"
+		retval=1
+	}
+
 done

 #
@@ -284,7 +292,11 @@ done
 printf %#x $error > $NOTIFIER_ERR_INJECT_DIR/actions/MEM_GOING_OFFLINE/error
 for memory in `hotpluggable_online_memory`; do
 	if [ $((RANDOM % 100)) -lt $ratio ]; then
-		offline_memory_expect_fail $memory
+		offline_memory_expect_fail $memory || {
+			echo "offline memory $memory: unexpected success"
+			retval=1
+		}
+
 	fi
 done

--
2.17.1

