Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD795EA8D9
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Sep 2022 16:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbiIZOpd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Sep 2022 10:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbiIZOoQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Sep 2022 10:44:16 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E3A2BD5;
        Mon, 26 Sep 2022 06:07:34 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MbjfP6sfbzHpmT;
        Mon, 26 Sep 2022 21:05:17 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 21:07:32 +0800
From:   Zhao Gongyi <zhaogongyi@huawei.com>
To:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>
CC:     <akinobu.mita@gmail.com>, <corbet@lwn.net>, <david@redhat.com>,
        <osalvador@suse.de>, <shuah@kernel.org>,
        Zhao Gongyi <zhaogongyi@huawei.com>
Subject: [PATCH -next v3 1/3] selftests/memory-hotplug: Add checking after online or offline
Date:   Mon, 26 Sep 2022 21:03:39 +0800
Message-ID: <20220926130341.253039-2-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220926130341.253039-1-zhaogongyi@huawei.com>
References: <20220926130341.253039-1-zhaogongyi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 .../selftests/memory-hotplug/mem-on-off-test.sh   | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh b/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
index 46a97f318f58..3edda1f13f7b 100755
--- a/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
+++ b/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
@@ -266,7 +266,10 @@ done
 #
 echo $error > $NOTIFIER_ERR_INJECT_DIR/actions/MEM_GOING_ONLINE/error
 for memory in `hotpluggable_offline_memory`; do
-	online_memory_expect_fail $memory
+	online_memory_expect_fail $memory || {
+		echo "online memory $memory: unexpected success"
+		retval=1
+	}
 done

 #
@@ -274,7 +277,10 @@ done
 #
 echo 0 > $NOTIFIER_ERR_INJECT_DIR/actions/MEM_GOING_ONLINE/error
 for memory in `hotpluggable_offline_memory`; do
-	online_memory_expect_success $memory
+	online_memory_expect_success $memory || {
+		echo "online memory $memory: unexpected fail"
+		retval=1
+	}
 done

 #
@@ -283,7 +289,10 @@ done
 echo $error > $NOTIFIER_ERR_INJECT_DIR/actions/MEM_GOING_OFFLINE/error
 for memory in `hotpluggable_online_memory`; do
 	if [ $((RANDOM % 100)) -lt $ratio ]; then
-		offline_memory_expect_fail $memory
+		offline_memory_expect_fail $memory || {
+			echo "offline memory $memory: unexpected success"
+			retval=1
+		}
 	fi
 done

--
2.17.1

