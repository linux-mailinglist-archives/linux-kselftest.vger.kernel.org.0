Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460DE5F04E7
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Sep 2022 08:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiI3Gjr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Sep 2022 02:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiI3Gjp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Sep 2022 02:39:45 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA4310561;
        Thu, 29 Sep 2022 23:39:42 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mf0pd4xQCzlVk4;
        Fri, 30 Sep 2022 14:35:21 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 14:39:40 +0800
From:   Zhao Gongyi <zhaogongyi@huawei.com>
To:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>
CC:     <akinobu.mita@gmail.com>, <corbet@lwn.net>, <david@redhat.com>,
        <osalvador@suse.de>, <shuah@kernel.org>, <zhaogongyi@huawei.com>
Subject: [PATCH -next v5 3/4] selftests/memory-hotplug: Adjust log info for maintainability
Date:   Fri, 30 Sep 2022 14:35:26 +0800
Message-ID: <20220930063527.108389-4-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220930063527.108389-1-zhaogongyi@huawei.com>
References: <20220930063527.108389-1-zhaogongyi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Redirect misleading error message to /dev/null for
offline_memory_expect_success(), And, add an output
for online->offline test.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 tools/testing/selftests/memory-hotplug/mem-on-off-test.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh b/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
index 91a7457616bb..74ee5067a8ce 100755
--- a/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
+++ b/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
@@ -207,8 +207,11 @@ echo -e "\t trying to offline $target out of $hotpluggable_num memory block(s):"
 for memory in `hotpluggable_online_memory`; do
 	if [ "$target" -gt 0 ]; then
 		echo "online->offline memory$memory"
-		if offline_memory_expect_success $memory; then
+		if offline_memory_expect_success $memory &>/dev/null; then
 			target=$(($target - 1))
+			echo "-> Success"
+		else
+			echo "-> Failure"
 		fi
 	fi
 done
@@ -267,7 +270,7 @@ prerequisite_extra
 echo 0 > $NOTIFIER_ERR_INJECT_DIR/actions/MEM_GOING_OFFLINE/error
 for memory in `hotpluggable_online_memory`; do
 	if [ $((RANDOM % 100)) -lt $ratio ]; then
-		offline_memory_expect_success $memory
+		offline_memory_expect_success $memory &>/dev/null
 	fi
 done

--
2.17.1

