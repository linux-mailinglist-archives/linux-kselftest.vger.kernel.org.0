Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D4C5AD31E
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Sep 2022 14:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237606AbiIEMta (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Sep 2022 08:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237022AbiIEMtW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Sep 2022 08:49:22 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25716354;
        Mon,  5 Sep 2022 05:49:17 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MLpCX0cfKzjXbd;
        Mon,  5 Sep 2022 20:45:44 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 5 Sep 2022 20:49:15 +0800
From:   Zhao Gongyi <zhaogongyi@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC:     <shuah@kernel.org>, <akpm@linux-foundation.org>,
        <akinobu.mita@gmail.com>, Zhao Gongyi <zhaogongyi@huawei.com>
Subject: [PATCH -next v2 3/5] selftests/cpu-hotplug: Delete fault injection related code
Date:   Mon, 5 Sep 2022 20:45:23 +0800
Message-ID: <20220905124525.130067-4-zhaogongyi@huawei.com>
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

Delete fault injection related code since the module has been deleted.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 .../selftests/cpu-hotplug/cpu-on-off-test.sh  | 87 ++-----------------
 1 file changed, 6 insertions(+), 81 deletions(-)

diff --git a/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh b/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
index bd2e791fe887..184156763ccb 100755
--- a/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
+++ b/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
@@ -116,10 +116,10 @@ online_cpu_expect_fail()

 	if online_cpu $cpu 2> /dev/null; then
 		echo $FUNCNAME $cpu: unexpected success >&2
-		exit 1
+		retval=1
 	elif ! cpu_is_offline $cpu; then
 		echo $FUNCNAME $cpu: unexpected online >&2
-		exit 1
+		retval=1
 	fi
 }

@@ -142,16 +142,14 @@ offline_cpu_expect_fail()

 	if offline_cpu $cpu 2> /dev/null; then
 		echo $FUNCNAME $cpu: unexpected success >&2
-		exit 1
+		retval=1
 	elif ! cpu_is_online $cpu; then
 		echo $FUNCNAME $cpu: unexpected offline >&2
-		exit 1
+		retval=1
 	fi
 }

-error=-12
 allcpus=0
-priority=0
 online_cpus=0
 online_max=0
 offline_cpus=0
@@ -159,31 +157,20 @@ offline_max=0
 present_cpus=0
 present_max=0

-while getopts e:ahp: opt; do
+while getopts ah opt; do
 	case $opt in
-	e)
-		error=$OPTARG
-		;;
 	a)
 		allcpus=1
 		;;
 	h)
-		echo "Usage $0 [ -a ] [ -e errno ] [ -p notifier-priority ]"
+		echo "Usage $0 [ -a ]"
 		echo -e "\t default offline one cpu"
 		echo -e "\t run with -a option to offline all cpus"
 		exit
 		;;
-	p)
-		priority=$OPTARG
-		;;
 	esac
 done

-if ! [ "$error" -ge -4095 -a "$error" -lt 0 ]; then
-	echo "error code must be -4095 <= errno < 0" >&2
-	exit 1
-fi
-
 prerequisite

 #
@@ -231,66 +218,4 @@ for cpu in `hotplaggable_offline_cpus`; do
 	online_cpu_expect_success $cpu
 done

-#
-# Test with cpu notifier error injection
-#
-
-DEBUGFS=`mount -t debugfs | head -1 | awk '{ print $3 }'`
-NOTIFIER_ERR_INJECT_DIR=$DEBUGFS/notifier-error-inject/cpu
-
-prerequisite_extra()
-{
-	msg="skip extra tests:"
-
-	/sbin/modprobe -q -r cpu-notifier-error-inject
-	/sbin/modprobe -q cpu-notifier-error-inject priority=$priority
-
-	if [ ! -d "$DEBUGFS" ]; then
-		echo $msg debugfs is not mounted >&2
-		exit $ksft_skip
-	fi
-
-	if [ ! -d $NOTIFIER_ERR_INJECT_DIR ]; then
-		echo $msg cpu-notifier-error-inject module is not available >&2
-		exit $ksft_skip
-	fi
-}
-
-prerequisite_extra
-
-#
-# Offline all hot-pluggable CPUs
-#
-echo 0 > $NOTIFIER_ERR_INJECT_DIR/actions/CPU_DOWN_PREPARE/error
-for cpu in `hotpluggable_online_cpus`; do
-	offline_cpu_expect_success $cpu
-done
-
-#
-# Test CPU hot-add error handling (offline => online)
-#
-echo $error > $NOTIFIER_ERR_INJECT_DIR/actions/CPU_UP_PREPARE/error
-for cpu in `hotplaggable_offline_cpus`; do
-	online_cpu_expect_fail $cpu
-done
-
-#
-# Online all hot-pluggable CPUs
-#
-echo 0 > $NOTIFIER_ERR_INJECT_DIR/actions/CPU_UP_PREPARE/error
-for cpu in `hotplaggable_offline_cpus`; do
-	online_cpu_expect_success $cpu
-done
-
-#
-# Test CPU hot-remove error handling (online => offline)
-#
-echo $error > $NOTIFIER_ERR_INJECT_DIR/actions/CPU_DOWN_PREPARE/error
-for cpu in `hotpluggable_online_cpus`; do
-	offline_cpu_expect_fail $cpu
-done
-
-echo 0 > $NOTIFIER_ERR_INJECT_DIR/actions/CPU_DOWN_PREPARE/error
-/sbin/modprobe -q -r cpu-notifier-error-inject
-
 exit $retval
--
2.17.1

