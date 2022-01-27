Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9F449DD6E
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jan 2022 10:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbiA0JMF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jan 2022 04:12:05 -0500
Received: from mail1.bemta34.messagelabs.com ([195.245.231.2]:13563 "EHLO
        mail1.bemta34.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232420AbiA0JMF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jan 2022 04:12:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1643274723; i=@fujitsu.com;
        bh=ki/5zyaZS43Yr2LeyCztzVlTFGTt3gKINTWFM2aZ1EE=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=a4DvL+kghNEDAmO/uMYedMHIT9fo8uWFS0AnvBCastCBw/zUysirEBsH7XDKGZigV
         tOe+xVT5SIiPPUbcrLhQAPwesd6QHTdX2yhile7aW00p6Q8hlIR98rwA0sPJGQ2Enk
         cyi5SZaZKsbi7HEpV1TzTA9uL8I7ag75dOEN/ICM4oTjxUSbBsvTL4yObTzuByhlTP
         MaAuDbV2uW5FFfWk+1DRKAJ/h9AF+0JQOXuANl7jE751xctLBBddPu2XyAmPuSscll
         BwbKRPMsneaHex893lBk2NKe0XOGMLfeDSHuGwsW8wI0tbwbcwfkzI+E3Azquwr3oX
         VAJ6Y2yIXO31g==
Received: from [100.115.34.7] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.eu-west-2.aws.ess.symcld.net id 73/EB-12680-3E162F16; Thu, 27 Jan 2022 09:12:03 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRWlGSWpSXmKPExsViZ8ORqPs48VO
  iwZEuFYvLu+awWUy/857N4tYnfosft26wWOydvozVgdXjzrU9bB77565h9ziz4Ai7x+dNcgEs
  UayZeUn5FQmsGR/uLWAt6HOtmPb7IFsD42WLLkYuDiGBLYwS75Y3MkM4C5gkVt3rYOti5ARy9
  jBKrJwdAWKzCWhKPOtcwAxiiwg4SWy82s0IYjMLlEt8vX8IrF5YIFLiaMNzsBoWAVWJ1inbwO
  K8Ah4S2yZ/ZQKxJQQUJKY8fA9WwyngKXFv72l2iMUtjBK97R3MEA2CEidnPmGBWCAhcfDFC2a
  IZkWJSx3fGCHsColZs9qghqpJXD23iXkCo+AsJO2zkLQvYGRaxWidVJSZnlGSm5iZo2toYKBr
  aGiqa2yha2hkrpdYpZuol1qqW55aXKJrpJdYXqyXWlysV1yZm5yTopeXWrKJERgLKcVq9TsYX
  6z8qXeIUZKDSUmUd4n5p0QhvqT8lMqMxOKM+KLSnNTiQ4wyHBxKErz5sUA5waLU9NSKtMwcYF
  zCpCU4eJREeP0SgNK8xQWJucWZ6RCpU4y6HDtPL17ELMSSl5+XKiXO6wZSJABSlFGaBzcCliI
  uMcpKCfMyMjAwCPEUpBblZpagyr9iFOdgVBLmTQOZwpOZVwK36RXQEUxAR/w+/w7kiJJEhJRU
  A5O2QF7H9wqdauk/B14zqUl9X/2xvd/IKODZvh2nDeZN2bZpF7vZ6WXlWbkqc3vMpx5fw133S
  ai0WmXi4h+flAoEOg2Wh/QfWZVkxLd53/edZR5yy6w9nf//4SxcVxJ4yfuxx0a5F+slBB2WSD
  daM1nnKbOaiaQy9c9c+eP21t331v9orHpi9/HmHNOE3L//JPVkTzVFO71kW2Mb0VVe4RR8VFY
  jkvWN0pH1vnXHaxn8ytWO/M01ui7XqaK/2XJt3mO+X7FXl/lzG3dl7K6ZzZj30FJVQi+lrdrl
  d5Vt65dn7VWMTK4vP5rpemZsyjl6Wi+jzmaq3FdW8+CLc/8LvPkjmqfHuVHXXYX1uNJOJZbij
  ERDLeai4kQANtbXVYwDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-11.tower-548.messagelabs.com!1643274723!11199!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 17138 invoked from network); 27 Jan 2022 09:12:03 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-11.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 27 Jan 2022 09:12:03 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 1CDD710019A;
        Thu, 27 Jan 2022 09:12:03 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 0F77310018B;
        Thu, 27 Jan 2022 09:12:03 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Thu, 27 Jan 2022 09:11:45 +0000
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <linux-kselftest@vger.kernel.org>, <skhan@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <naresh.kamboju@linaro.org>,
        <pvorel@suse.cz>, Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v2 3/3] selftests/zram: Adapt the situation that /dev/zram0 is being used
Date:   Thu, 27 Jan 2022 17:11:37 +0800
Message-ID: <1643274697-3393-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1643274697-3393-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <590c1f1c-2da1-583a-d055-83c15969cf80@linuxfoundation.org>
 <1643274697-3393-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If zram-generator package is installed and works, then we can not remove
zram module because zram swap is being used. This case needs a clean zram
environment, change this test by using hot_add/hot_remove interface. So
even zram device is being used, we still can add zram device and remove
them in cleanup.

The two interface was introduced since kernel commit 6566d1a32bf7("zram:
add dynamic device add/remove functionality") in v4.2-rc1. If kernel
supports these two interface, we use hot_add/hot_remove to slove this
problem, if not, just check whether zram is being used or built in, then
skip it on old kernel.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
fix this ie the following ltp commit does
https://github.com/linux-test-project/ltp/commit/caed7833
also removing useless zram_unload
 tools/testing/selftests/zram/zram.sh     |  15 +---
 tools/testing/selftests/zram/zram01.sh   |   3 +-
 tools/testing/selftests/zram/zram02.sh   |   1 -
 tools/testing/selftests/zram/zram_lib.sh | 110 +++++++++++++----------
 4 files changed, 66 insertions(+), 63 deletions(-)

diff --git a/tools/testing/selftests/zram/zram.sh b/tools/testing/selftests/zram/zram.sh
index 232e958ec454..b0b91d9b0dc2 100755
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
@@ -18,14 +15,4 @@ echo ""
 
 check_prereqs
 
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
index e9e9eb777e2c..8f4affe34f3e 100755
--- a/tools/testing/selftests/zram/zram01.sh
+++ b/tools/testing/selftests/zram/zram01.sh
@@ -33,7 +33,7 @@ zram_algs="lzo"
 
 zram_fill_fs()
 {
-	for i in $(seq 0 $(($dev_num - 1))); do
+	for i in $(seq $dev_start $dev_end); do
 		echo "fill zram$i..."
 		local b=0
 		while [ true ]; do
@@ -67,7 +67,6 @@ zram_mount
 
 zram_fill_fs
 zram_cleanup
-zram_unload
 
 if [ $ERR_CODE -ne 0 ]; then
 	echo "$TCID : [FAIL]"
diff --git a/tools/testing/selftests/zram/zram02.sh b/tools/testing/selftests/zram/zram02.sh
index e83b404807c0..2418b0c4ed13 100755
--- a/tools/testing/selftests/zram/zram02.sh
+++ b/tools/testing/selftests/zram/zram02.sh
@@ -36,7 +36,6 @@ zram_set_memlimit
 zram_makeswap
 zram_swapoff
 zram_cleanup
-zram_unload
 
 if [ $ERR_CODE -ne 0 ]; then
 	echo "$TCID : [FAIL]"
diff --git a/tools/testing/selftests/zram/zram_lib.sh b/tools/testing/selftests/zram/zram_lib.sh
index f47fc0f27e99..21ec1966de76 100755
--- a/tools/testing/selftests/zram/zram_lib.sh
+++ b/tools/testing/selftests/zram/zram_lib.sh
@@ -5,10 +5,12 @@
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 # Modified: Naresh Kamboju <naresh.kamboju@linaro.org>
 
-MODULE=0
 dev_makeswap=-1
 dev_mounted=-1
-
+dev_start=0
+dev_end=-1
+module_load=-1
+sys_control=-1
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
 kernel_version=`uname -r | cut -d'.' -f1,2`
@@ -46,57 +48,72 @@ zram_cleanup()
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
 		rm -rf zram$i
 	done
 
-}
+	if [ $sys_control -eq 1 ]; then
+		for i in $(seq $dev_start $dev_end); do
+			echo $i > /sys/class/zram-control/hot_remove
+		done
+	fi
 
-zram_unload()
-{
-	if [ $MODULE -ne 0 ] ; then
-		echo "zram rmmod zram"
+	if [ $module_load -eq 1 ]; then
 		rmmod zram > /dev/null 2>&1
 	fi
 }
 
 zram_load()
 {
-	# check zram module exists
-	MODULE_PATH=/lib/modules/`uname -r`/kernel/drivers/block/zram/zram.ko
-	if [ -f $MODULE_PATH ]; then
-		MODULE=1
-		echo "create '$dev_num' zram device(s)"
-		modprobe zram num_devices=$dev_num
-		if [ $? -ne 0 ]; then
-			echo "failed to insert zram module"
-			exit 1
-		fi
-
-		dev_num_created=$(ls /dev/zram* | wc -w)
+	echo "create '$dev_num' zram device(s)"
+
+	# zram module loaded, new kernel
+	if [ -d "/sys/class/zram-control" ]; then
+		echo "zram modules already loaded, kernel supports" \
+			"zram-control interface"
+		dev_start=$(ls /dev/zram* | wc -w)
+		dev_end=$(($dev_start + $dev_num - 1))
+		sys_control=1
+
+		for i in $(seq $dev_start $dev_end); do
+			cat /sys/class/zram-control/hot_add > /dev/null
+		done
+
+		echo "all zram devices (/dev/zram$dev_start~$dev_end" \
+			"successfully created"
+		return 0
+	fi
 
-		if [ "$dev_num_created" -ne "$dev_num" ]; then
-			echo "unexpected num of devices: $dev_num_created"
-			ERR_CODE=-1
+	# detect old kernel or built-in
+	modprobe zram num_devices=$dev_num
+	if [ ! -d "/sys/class/zram-control" ]; then
+		if grep -q '^zram' /proc/modules; then
+			rmmod zram > /dev/null 2>&1
+			if [ $? -ne 0 ]; then
+				echo "zram module is being used on old kernel" \
+					"without zram-control interface"
+				exit $ksft_skip
+			fi
 		else
-			echo "zram load module successful"
+			echo "test needs CONFIG_ZRAM=m on old kernel without" \
+				"zram-control interface"
+			exit $ksft_skip
 		fi
-	elif [ -b /dev/zram0 ]; then
-		echo "/dev/zram0 device file found: OK"
-	else
-		echo "ERROR: No zram.ko module or no /dev/zram0 device found"
-		echo "$TCID : CONFIG_ZRAM is not set"
-		exit 1
+		modprobe zram num_devices=$dev_num
 	fi
+
+	module_load=1
+	dev_end=$(($dev_num - 1))
+	echo "all zram devices (/dev/zram0~$dev_end) successfully created"
 }
 
 zram_max_streams()
@@ -110,7 +127,7 @@ zram_max_streams()
 		return 0
 	fi
 
-	local i=0
+	local i=$dev_start
 	for max_s in $zram_max_streams; do
 		local sys_path="/sys/block/zram${i}/max_comp_streams"
 		echo $max_s > $sys_path || \
@@ -122,7 +139,7 @@ zram_max_streams()
 			echo "FAIL can't set max_streams '$max_s', get $max_stream"
 
 		i=$(($i + 1))
-		echo "$sys_path = '$max_streams' ($i/$dev_num)"
+		echo "$sys_path = '$max_streams'"
 	done
 
 	echo "zram max streams: OK"
@@ -132,15 +149,16 @@ zram_compress_alg()
 {
 	echo "test that we can set compression algorithm"
 
-	local algs=$(cat /sys/block/zram0/comp_algorithm)
+	local i=$dev_start
+	local algs=$(cat /sys/block/zram${i}/comp_algorithm)
 	echo "supported algs: $algs"
-	local i=0
+
 	for alg in $zram_algs; do
 		local sys_path="/sys/block/zram${i}/comp_algorithm"
 		echo "$alg" >	$sys_path || \
 			echo "FAIL can't set '$alg' to $sys_path"
 		i=$(($i + 1))
-		echo "$sys_path = '$alg' ($i/$dev_num)"
+		echo "$sys_path = '$alg'"
 	done
 
 	echo "zram set compression algorithm: OK"
@@ -149,14 +167,14 @@ zram_compress_alg()
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
@@ -166,14 +184,14 @@ zram_set_memlimit()
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
@@ -182,8 +200,8 @@ zram_set_memlimit()
 zram_makeswap()
 {
 	echo "make swap with zram device(s)"
-	local i=0
-	for i in $(seq 0 $(($dev_num - 1))); do
+	local i=$dev_start
+	for i in $(seq $dev_start $dev_end); do
 		mkswap /dev/zram$i > err.log 2>&1
 		if [ $? -ne 0 ]; then
 			cat err.log
@@ -206,7 +224,7 @@ zram_makeswap()
 zram_swapoff()
 {
 	local i=
-	for i in $(seq 0 $dev_makeswap); do
+	for i in $(seq $dev_start $dev_end); do
 		swapoff /dev/zram$i > err.log 2>&1
 		if [ $? -ne 0 ]; then
 			cat err.log
@@ -220,7 +238,7 @@ zram_swapoff()
 
 zram_makefs()
 {
-	local i=0
+	local i=$dev_start
 	for fs in $zram_filesystems; do
 		# if requested fs not supported default it to ext2
 		which mkfs.$fs > /dev/null 2>&1 || fs=ext2
@@ -239,7 +257,7 @@ zram_makefs()
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

