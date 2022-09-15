Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614255B96E5
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Sep 2022 11:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiIOJCi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Sep 2022 05:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiIOJCU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Sep 2022 05:02:20 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902D898757;
        Thu, 15 Sep 2022 02:02:16 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MSrgj5cSHzNmGT;
        Thu, 15 Sep 2022 16:57:37 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 15 Sep 2022 17:01:50 +0800
From:   Zhao Gongyi <zhaogongyi@huawei.com>
To:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>
CC:     <akinobu.mita@gmail.com>, <corbet@lwn.net>, <david@redhat.com>,
        <osalvador@suse.de>, <shuah@kernel.org>,
        Zhao Gongyi <zhaogongyi@huawei.com>
Subject: [PATCH -next v2 4/5] selftests/memory-hotplug: Restore memory before exit
Date:   Thu, 15 Sep 2022 16:57:56 +0800
Message-ID: <20220915085757.258608-5-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220915085757.258608-1-zhaogongyi@huawei.com>
References: <20220915085757.258608-1-zhaogongyi@huawei.com>
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

Some momory will be left in offline state when calling
offline_memory_expect_fail() failed. Restore it before exit.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 .../memory-hotplug/mem-on-off-test.sh         | 24 +++++++++++++------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh b/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
index 3bdf3c4d6d06..c620adf33629 100755
--- a/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
+++ b/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
@@ -134,6 +134,17 @@ offline_memory_expect_fail()
 	return 0
 }

+online_all_offline_memory()
+{
+
+	for memory in `hotpluggable_offline_memory`; do
+		online_memory_expect_success $memory || {
+			echo "online memory $memory: unexpected fail"
+			retval=1
+		}
+	done
+}
+
 error=-12
 priority=0
 # Run with default of ratio=2 for Kselftest run
@@ -278,13 +289,7 @@ done
 # Online all hot-pluggable memory
 #
 echo 0 > $NOTIFIER_ERR_INJECT_DIR/actions/MEM_GOING_ONLINE/error
-for memory in `hotpluggable_offline_memory`; do
-	online_memory_expect_success $memory || {
-		echo "online memory $memory: unexpected fail"
-		retval=1
-	}
-
-done
+online_all_offline_memory

 #
 # Test memory hot-remove error handling (online => offline)
@@ -303,4 +308,9 @@ done
 echo 0 > $NOTIFIER_ERR_INJECT_DIR/actions/MEM_GOING_OFFLINE/error
 /sbin/modprobe -q -r memory-notifier-error-inject

+#
+# Restore memory before exit
+#
+online_all_offline_memory
+
 exit $retval
--
2.17.1

