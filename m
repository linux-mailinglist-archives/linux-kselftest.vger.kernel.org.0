Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD4D5AD33E
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Sep 2022 14:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236987AbiIEMtf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Sep 2022 08:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237087AbiIEMtW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Sep 2022 08:49:22 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E646F6362;
        Mon,  5 Sep 2022 05:49:18 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MLpCX67yjzjXbk;
        Mon,  5 Sep 2022 20:45:44 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 5 Sep 2022 20:49:16 +0800
From:   Zhao Gongyi <zhaogongyi@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC:     <shuah@kernel.org>, <akpm@linux-foundation.org>,
        <akinobu.mita@gmail.com>, Zhao Gongyi <zhaogongyi@huawei.com>
Subject: [PATCH -next v2 4/5] selftests/cpu-hotplug: Reserve one cpu online at least
Date:   Mon, 5 Sep 2022 20:45:24 +0800
Message-ID: <20220905124525.130067-5-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220905124525.130067-1-zhaogongyi@huawei.com>
References: <20220905124525.130067-1-zhaogongyi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

Considering that we can not offline all cpus in any cases,
we need to reserve one cpu online when the test offline all
hotpluggable online cpus, otherwise the test will fail forever.

Fixes: d89dffa976bc ("fault-injection: add selftests for cpu
and memory hotplug")

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 .../selftests/cpu-hotplug/cpu-on-off-test.sh  | 40 ++++++++++---------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh b/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
index 184156763ccb..d5dc7e0dc726 100755
--- a/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
+++ b/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
@@ -149,6 +149,25 @@ offline_cpu_expect_fail()
 	fi
 }

+online_all_hot_pluggable_cpus()
+{
+	for cpu in `hotplaggable_offline_cpus`; do
+		online_cpu_expect_success $cpu
+	done
+}
+
+offline_all_hot_pluggable_cpus()
+{
+	local reserve_cpu=$online_max
+	for cpu in `hotpluggable_online_cpus`; do
+		# Reserve one cpu oneline at least.
+		if [ $cpu -eq $reserve_cpu ];then
+			continue
+		fi
+		offline_cpu_expect_success $cpu
+	done
+}
+
 allcpus=0
 online_cpus=0
 online_max=0
@@ -197,25 +216,10 @@ else
 	echo -e "\t online all offline cpus"
 fi

-#
-# Online all hot-pluggable CPUs
-#
-for cpu in `hotplaggable_offline_cpus`; do
-	online_cpu_expect_success $cpu
-done
+online_all_hot_pluggable_cpus

-#
-# Offline all hot-pluggable CPUs
-#
-for cpu in `hotpluggable_online_cpus`; do
-	offline_cpu_expect_success $cpu
-done
+offline_all_hot_pluggable_cpus

-#
-# Online all hot-pluggable CPUs again
-#
-for cpu in `hotplaggable_offline_cpus`; do
-	online_cpu_expect_success $cpu
-done
+online_all_hot_pluggable_cpus

 exit $retval
--
2.17.1

