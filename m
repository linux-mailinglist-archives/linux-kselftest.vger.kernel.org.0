Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9113D475599
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Dec 2021 10:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241390AbhLOJ4m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Dec 2021 04:56:42 -0500
Received: from mail1.bemta34.messagelabs.com ([195.245.231.3]:24777 "EHLO
        mail1.bemta34.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241360AbhLOJ4k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Dec 2021 04:56:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1639562198; i=@fujitsu.com;
        bh=a7mWnsi59uOsydxJgMhSpYKKIoLz8lN91u6jjtmczFI=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=At0ni+J0ZK87Pnb5UTqY/NjiCkMVI/9j/Uwjib9rylBOWsLcSU8GLixvwFffcNJdt
         v+bQBF3F0WbbOtaG0Qo5paEttn07buKFerZolR+nlvXH+on0Fli1s6qUwQOVwqWbCa
         NQ+k3SLshFIR7Dg+RD0DAr2VOPwGCQXebXZ1M/QReX4pL7yszA8SicbMNGE8NooTwE
         nPrSpEfYMdYsWk2RfPOz00jXD9izOBwoGtFQ33m3KniruGHZERmlpUYi1jlG9ofxYg
         Dh7V6Om3NHVl3evIKtteGGULkwaEv9nrtQoqMKFrOX2tYwyl5keaYSsa7IqznICVyW
         cpo4QKsYxmHIg==
Received: from [100.115.34.181] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-a.eu-west-2.aws.ess.symcld.net id DA/0A-09428-6DBB9B16; Wed, 15 Dec 2021 09:56:38 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRWlGSWpSXmKPExsViZ8MxSffa7p2
  JBjMWSlvs2z+f0eLyrjlsFtPvvGezuPWJ32LKy3XsDqweR16sZvfYtKqTzePOtT1sHp83yQWw
  RLFm5iXlVySwZrzbHlzw0aji266HbA2M5zS7GLk4hAS2MEosX72PBcJZwCTR8u8qlLOHUeLXj
  RvsXYycHGwCmhLPOhcwg9giApYSux7vZQUpYhZoYZRoOH2ECSQhLBAm8Wz+HhYQm0VAVeLtlG
  tgDbwCHhINJ8+zgdgSAgoSUx6+B4tzCnhKfDp+AqxeCKjm1v5JUPWCEidnPgGLMwtISBx88YI
  ZoldR4lLHN0YIu0Ji1qw2JghbTeLquU3MExgFZyFpn4WkfQEj0ypG66SizPSMktzEzBxdQwMD
  XUNDU11jU11DE0u9xCrdRL3UUt3y1OISXSO9xPJivdTiYr3iytzknBS9vNSSTYzAWEgpVp66g
  /H0qp96hxglOZiURHnzNu1MFOJLyk+pzEgszogvKs1JLT7EKMPBoSTBy7ETKCdYlJqeWpGWmQ
  OMS5i0BAePkgjveZA0b3FBYm5xZjpE6hSjLsfO04sXMQux5OXnpUqJ8x7cBVQkAFKUUZoHNwK
  WIi4xykoJ8zIyMDAI8RSkFuVmlqDKv2IU52BUEuadBDKFJzOvBG7TK6AjmICOOJa7HeSIkkSE
  lFQD01m7b+9n7+7pdsyQ/p8zYS+bo3nr5CPL5USquOfcm7ZmVdrsjR5aH6OPiIbU3zrySrjmh
  sGiBzuWfF6Ytvb7dv04H3bpa8EOx2ZN5MvsvSf3Lajs1klXb9b/Z1atkFUqr13EujlOrGJvaP
  a7795/WKWd6piFH6p0RNx/uniB5T7nqIWyTg8SdSdt6/+xNvvoCw0pHZ/9Ug1+c87MfLSlfNc
  cvimrl7L8zXixNsVZSuDjVsZ0L5Hihfmfm0NSdRuWx9/L03kt7NGxWT0os0O6tO/Ko5zDuk85
  5V6tP3gya4LwCb+/y7vSC0SfPpveu+Ena4U0+4utkUv27/2z6MBO9e9beXfMPTWP02f1Jum1q
  /WVWIozEg21mIuKEwHEq3SUjAMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-24.tower-565.messagelabs.com!1639562198!110815!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 29661 invoked from network); 15 Dec 2021 09:56:38 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-24.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 15 Dec 2021 09:56:38 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 08CAC10044F;
        Wed, 15 Dec 2021 09:56:38 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id ED936100440;
        Wed, 15 Dec 2021 09:56:37 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Wed, 15 Dec 2021 09:56:33 +0000
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <linux-kselftest@vger.kernel.org>, <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <naresh.kamboju@linaro.org>,
        <aleksei.kodanev@bell-sw.com>, Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH 3/3] selftests/zram: Adapt the situation that /dev/zram0 is being used
Date:   Wed, 15 Dec 2021 17:56:11 +0800
Message-ID: <1639562171-4434-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1639562171-4434-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1639562171-4434-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On some linux distributions, if it used /dev/zram0 as default by zram-generate
service, then this case will fail or report EBUSY.

To fix this, use hot_add/hot_remove interface. Also, move module check code into
zram_load from zram.sh. We can use /sys/class/zram-control to detect the
module whether existed.

After this patch, we still run case pass even /dev/zram0 is being used.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 tools/testing/selftests/zram/zram.sh     | 16 +----
 tools/testing/selftests/zram/zram01.sh   |  2 +-
 tools/testing/selftests/zram/zram_lib.sh | 75 ++++++++++++------------
 3 files changed, 41 insertions(+), 52 deletions(-)

diff --git a/tools/testing/selftests/zram/zram.sh b/tools/testing/selftests/zram/zram.sh
index 232e958ec454..d002171fe86f 100755
--- a/tools/testing/selftests/zram/zram.sh
+++ b/tools/testing/selftests/zram/zram.sh
@@ -2,9 +2,6 @@
 # SPDX-License-Identifier: GPL-2.0
 TCID="zram.sh"
 
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
-
 . ./zram_lib.sh
 
 run_zram () {
@@ -17,15 +14,4 @@ echo ""
 }
 
 check_prereqs
-
-# check zram module exists
-MODULE_PATH=/lib/modules/`uname -r`/kernel/drivers/block/zram/zram.ko
-if [ -f $MODULE_PATH ]; then
-	run_zram
-elif [ -b /dev/zram0 ]; then
-	run_zram
-else
-	echo "$TCID : No zram.ko module or /dev/zram0 device file not found"
-	echo "$TCID : CONFIG_ZRAM is not set"
-	exit $ksft_skip
-fi
+run_zram
diff --git a/tools/testing/selftests/zram/zram01.sh b/tools/testing/selftests/zram/zram01.sh
index e083a4c628a8..f87cc1ebf20f 100755
--- a/tools/testing/selftests/zram/zram01.sh
+++ b/tools/testing/selftests/zram/zram01.sh
@@ -30,7 +30,7 @@ zram_algs="lzo"
 
 zram_fill_fs()
 {
-	for i in $(seq 0 $(($dev_num - 1))); do
+	for i in $(seq $dev_start $dev_end); do
 		echo "fill zram$i..."
 		local b=0
 		while [ true ]; do
diff --git a/tools/testing/selftests/zram/zram_lib.sh b/tools/testing/selftests/zram/zram_lib.sh
index 0c49f9d1d563..ee57990c322d 100755
--- a/tools/testing/selftests/zram/zram_lib.sh
+++ b/tools/testing/selftests/zram/zram_lib.sh
@@ -8,6 +8,8 @@
 MODULE=0
 dev_makeswap=-1
 dev_mounted=-1
+dev_start=-1
+dev_end=-1
 
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
@@ -29,19 +31,22 @@ zram_cleanup()
 {
 	echo "zram cleanup"
 	local i=
-	for i in $(seq 0 $dev_makeswap); do
+	for i in $(seq $dev_start $dev_makeswap); do
 		swapoff /dev/zram$i
 	done
 
-	for i in $(seq 0 $dev_mounted); do
+	for i in $(seq $dev_start $dev_mounted); do
 		umount /dev/zram$i
 	done
 
-	for i in $(seq 0 $(($dev_num - 1))); do
+	for i in $(seq $dev_start $dev_end); do
 		echo 1 > /sys/block/zram${i}/reset
-		rm -rf zram$i
+		rm -rf zram${i}
 	done
 
+	for i in $(seq $dev_start $dev_end); do
+		echo $i > /sys/class/zram-control/hot_remove
+	done
 }
 
 zram_unload()
@@ -54,32 +59,30 @@ zram_unload()
 
 zram_load()
 {
-	# check zram module exists
-	MODULE_PATH=/lib/modules/`uname -r`/kernel/drivers/block/zram/zram.ko
-	if [ -f $MODULE_PATH ]; then
-		MODULE=1
-		echo "create '$dev_num' zram device(s)"
+	echo "create '$dev_num' zram device(s)"
+
+	if [ ! -d "/sys/class/zram-control" ]; then
 		modprobe zram num_devices=$dev_num
-		if [ $? -ne 0 ]; then
-			echo "failed to insert zram module"
-			exit 1
+		if grep -q '^zram' /proc/modules; then
+			echo "ERROR: No zram.ko module"
+			echo "$TCID : CONFIG_ZRAM is not set"
+			exit $ksft_skip
 		fi
+		MODULE=1
+		dev_start=0
+		dev_end=$(($dev_num - 1))
+		echo "all zram devices(/dev/zram0~$dev_end) successfully created"
+		return
+	fi
 
-		dev_num_created=$(ls /dev/zram* | wc -w)
+	dev_start=$(ls /dev/zram* | wc -w)
+	dev_end=$(($dev_start + $dev_num - 1))
 
-		if [ "$dev_num_created" -ne "$dev_num" ]; then
-			echo "unexpected num of devices: $dev_num_created"
-			ERR_CODE=-1
-		else
-			echo "zram load module successful"
-		fi
-	elif [ -b /dev/zram0 ]; then
-		echo "/dev/zram0 device file found: OK"
-	else
-		echo "ERROR: No zram.ko module or no /dev/zram0 device found"
-		echo "$TCID : CONFIG_ZRAM is not set"
-		exit 1
-	fi
+	for i in $(seq $dev_start $dev_end); do
+		cat /sys/class/zram-control/hot_add > /dev/null
+	done
+
+	echo "all zram devices(/dev/zram$dev_start~$dev_end) successfully created"
 }
 
 zram_compress_alg()
@@ -88,13 +91,13 @@ zram_compress_alg()
 
 	local algs=$(cat /sys/block/zram0/comp_algorithm)
 	echo "supported algs: $algs"
-	local i=0
+	local i=$dev_start
 	for alg in $zram_algs; do
 		local sys_path="/sys/block/zram${i}/comp_algorithm"
 		echo "$alg" >	$sys_path || \
 			echo "FAIL can't set '$alg' to $sys_path"
 		i=$(($i + 1))
-		echo "$sys_path = '$alg' ($i/$dev_num)"
+		echo "$sys_path = '$alg'"
 	done
 
 	echo "zram set compression algorithm: OK"
@@ -103,14 +106,14 @@ zram_compress_alg()
 zram_set_disksizes()
 {
 	echo "set disk size to zram device(s)"
-	local i=0
+	local i=$dev_start
 	for ds in $zram_sizes; do
 		local sys_path="/sys/block/zram${i}/disksize"
 		echo "$ds" >	$sys_path || \
 			echo "FAIL can't set '$ds' to $sys_path"
 
 		i=$(($i + 1))
-		echo "$sys_path = '$ds' ($i/$dev_num)"
+		echo "$sys_path = '$ds'"
 	done
 
 	echo "zram set disksizes: OK"
@@ -120,14 +123,14 @@ zram_set_memlimit()
 {
 	echo "set memory limit to zram device(s)"
 
-	local i=0
+	local i=$dev_start
 	for ds in $zram_mem_limits; do
 		local sys_path="/sys/block/zram${i}/mem_limit"
 		echo "$ds" >	$sys_path || \
 			echo "FAIL can't set '$ds' to $sys_path"
 
 		i=$(($i + 1))
-		echo "$sys_path = '$ds' ($i/$dev_num)"
+		echo "$sys_path = '$ds'"
 	done
 
 	echo "zram set memory limit: OK"
@@ -137,7 +140,7 @@ zram_makeswap()
 {
 	echo "make swap with zram device(s)"
 	local i=0
-	for i in $(seq 0 $(($dev_num - 1))); do
+	for i in $(seq $dev_start $dev_end); do
 		mkswap /dev/zram$i > err.log 2>&1
 		if [ $? -ne 0 ]; then
 			cat err.log
@@ -160,7 +163,7 @@ zram_makeswap()
 zram_swapoff()
 {
 	local i=
-	for i in $(seq 0 $dev_makeswap); do
+	for i in $(seq $dev_start $dev_makeswap); do
 		swapoff /dev/zram$i > err.log 2>&1
 		if [ $? -ne 0 ]; then
 			cat err.log
@@ -174,7 +177,7 @@ zram_swapoff()
 
 zram_makefs()
 {
-	local i=0
+	local i=$dev_start
 	for fs in $zram_filesystems; do
 		# if requested fs not supported default it to ext2
 		which mkfs.$fs > /dev/null 2>&1 || fs=ext2
@@ -193,7 +196,7 @@ zram_makefs()
 zram_mount()
 {
 	local i=0
-	for i in $(seq 0 $(($dev_num - 1))); do
+	for i in $(seq $dev_start $dev_end); do
 		echo "mount /dev/zram$i"
 		mkdir zram$i
 		mount /dev/zram$i zram$i > /dev/null || \
-- 
2.23.0

