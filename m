Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8245A5E32
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Aug 2022 10:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiH3IeM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 04:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbiH3IeK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 04:34:10 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A169CC6528;
        Tue, 30 Aug 2022 01:34:06 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MH0ps3ty3zYd3T;
        Tue, 30 Aug 2022 16:29:41 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 30 Aug 2022 16:34:04 +0800
From:   Zhao Gongyi <zhaogongyi@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC:     <shuah@kernel.org>, <akpm@linux-foundation.org>,
        <akinobu.mita@gmail.com>, Zhao Gongyi <zhaogongyi@huawei.com>
Subject: [PATCH -next 2/5] selftests/cpu-hotplug: Replace exit with return
Date:   Tue, 30 Aug 2022 16:30:25 +0800
Message-ID: <20220830083028.45504-3-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220830083028.45504-1-zhaogongyi@huawei.com>
References: <20220830083028.45504-1-zhaogongyi@huawei.com>
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

Replace exit with return to avoid some offline cpu
left when offline cpus fail.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 .../selftests/cpu-hotplug/cpu-on-off-test.sh        | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh b/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
index 1169ef82b55e..19028c4c9758 100755
--- a/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
+++ b/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
@@ -4,6 +4,7 @@
 SYSFS=
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
+retval=0

 prerequisite()
 {
@@ -102,10 +103,10 @@ online_cpu_expect_success()

 	if ! online_cpu $cpu; then
 		echo $FUNCNAME $cpu: unexpected fail >&2
-		exit 1
+		let retval=$retval+1
 	elif ! cpu_is_online $cpu; then
 		echo $FUNCNAME $cpu: unexpected offline >&2
-		exit 1
+		let retval=$retval+1
 	fi
 }

@@ -128,10 +129,10 @@ offline_cpu_expect_success()

 	if ! offline_cpu $cpu; then
 		echo $FUNCNAME $cpu: unexpected fail >&2
-		exit 1
+		let retval=$retval+1
 	elif ! cpu_is_offline $cpu; then
 		echo $FUNCNAME $cpu: unexpected offline >&2
-		exit 1
+		let retval=$retval+1
 	fi
 }

@@ -201,7 +202,7 @@ if [ $allcpus -eq 0 ]; then
 		offline_cpu_expect_success $present_max
 		online_cpu $present_max
 	fi
-	exit 0
+	exit $retval
 else
 	echo "Full scope test: all hotplug cpus"
 	echo -e "\t online all offline cpus"
@@ -291,3 +292,5 @@ done

 echo 0 > $NOTIFIER_ERR_INJECT_DIR/actions/CPU_DOWN_PREPARE/error
 /sbin/modprobe -q -r cpu-notifier-error-inject
+
+exit $retval
--
2.17.1

