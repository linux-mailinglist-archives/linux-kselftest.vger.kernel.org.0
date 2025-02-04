Return-Path: <linux-kselftest+bounces-25632-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A48A2694B
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 02:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76588165912
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 01:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5E61428E7;
	Tue,  4 Feb 2025 01:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RA4tLFeL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE5A141987;
	Tue,  4 Feb 2025 01:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738631799; cv=none; b=HzcZHrANtACn1Ef82Snfn9eFuXz1SIk/xJ0SQ9xrtj8PKgRpKsDr5cFCKUVuWc3FvlQv/wjdkUiF8lzY880bkdDNCwXj5mylJ+yNXLM6T+bjgRgKHJWbUr6ZYu/bgl/BfcWutCrw2M0rehJx58csYkTH1az+WYLhBrUR237Ixy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738631799; c=relaxed/simple;
	bh=AZYnpZH02SrGHDneIoHNp5RsnbeIUYf5hZihOJgorME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=srK2WVuvmO42n4gLA8BuGXuUHHNk6NPf9EAIt6zXnTtYAZZfNr/MgNwmP4X0Av9b86UMyvy0GFzg00+yhVFqboQXFGXkJ/jWLtF6Il6njt6/ZMb0fLbbm5fL/F6lk+gSFYMNdyW1AcTN4GKU44zV6cXmQoajWO3Qh7OBU2QX2CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RA4tLFeL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5967FC4CEE6;
	Tue,  4 Feb 2025 01:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738631798;
	bh=AZYnpZH02SrGHDneIoHNp5RsnbeIUYf5hZihOJgorME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RA4tLFeLcvMgDjOfOEPJ9NZiZvjWHHtNnjEYdSlbfqk1Pgo+ifkHUijYOuYAH85cn
	 /sVot7K7QpBY0Wsx5tmTXMbQ+y6m1VkISlPzZ6kQH+D8VUc1Tj18Zpfv+i7Vc58QnZ
	 nGI+DblLXQzZrTRIMyFwG0G+tTtowVdlxmP6dlfdT46lfHy9PJFaheQSeqEduXH42B
	 SV/H+nfRu+322nsz+fu9du1vGdIg4zdB7vcKBmKdsq6jXl+xOcKctSrfODttpUubZt
	 J5ATIQ7DTdd9mmQ72Z22XtZWc9EVvGwL8gN4eWViP62RVGOvK1zryCQ4PfaYRY7DGa
	 FGYe5F8hK3VKw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Koichiro Den <koichiro.den@canonical.com>,
	kernel test robot <oliver.sang@intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	bamv2005@gmail.com,
	shuah@kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 4/5] selftests: gpio: gpio-sim: Fix missing chip disablements
Date: Mon,  3 Feb 2025 20:16:26 -0500
Message-Id: <20250204011627.2206261-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250204011627.2206261-1-sashal@kernel.org>
References: <20250204011627.2206261-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.1
Content-Transfer-Encoding: 8bit

From: Koichiro Den <koichiro.den@canonical.com>

[ Upstream commit f8524ac33cd452aef5384504b3264db6039a455e ]

Since upstream commit 8bd76b3d3f3a ("gpio: sim: lock up configfs that an
instantiated device depends on"), rmdir for an active virtual devices
been prohibited.

Update gpio-sim selftest to align with the change.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202501221006.a1ca5dfa-lkp@intel.com
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
Link: https://lore.kernel.org/r/20250122043309.304621-1-koichiro.den@canonical.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/gpio/gpio-sim.sh | 31 +++++++++++++++++++-----
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/gpio/gpio-sim.sh b/tools/testing/selftests/gpio/gpio-sim.sh
index 6fb66a687f173..bbc29ed9c60a9 100755
--- a/tools/testing/selftests/gpio/gpio-sim.sh
+++ b/tools/testing/selftests/gpio/gpio-sim.sh
@@ -46,12 +46,6 @@ remove_chip() {
 	rmdir $CONFIGFS_DIR/$CHIP || fail "Unable to remove the chip"
 }
 
-configfs_cleanup() {
-	for CHIP in `ls $CONFIGFS_DIR/`; do
-		remove_chip $CHIP
-	done
-}
-
 create_chip() {
 	local CHIP=$1
 
@@ -105,6 +99,13 @@ disable_chip() {
 	echo 0 > $CONFIGFS_DIR/$CHIP/live || fail "Unable to disable the chip"
 }
 
+configfs_cleanup() {
+	for CHIP in `ls $CONFIGFS_DIR/`; do
+		disable_chip $CHIP
+		remove_chip $CHIP
+	done
+}
+
 configfs_chip_name() {
 	local CHIP=$1
 	local BANK=$2
@@ -181,6 +182,7 @@ create_chip chip
 create_bank chip bank
 enable_chip chip
 test -n `cat $CONFIGFS_DIR/chip/bank/chip_name` || fail "chip_name doesn't work"
+disable_chip chip
 remove_chip chip
 
 echo "1.2. chip_name returns 'none' if the chip is still pending"
@@ -195,6 +197,7 @@ create_chip chip
 create_bank chip bank
 enable_chip chip
 test -n `cat $CONFIGFS_DIR/chip/dev_name` || fail "dev_name doesn't work"
+disable_chip chip
 remove_chip chip
 
 echo "2. Creating and configuring simulated chips"
@@ -204,6 +207,7 @@ create_chip chip
 create_bank chip bank
 enable_chip chip
 test "`get_chip_num_lines chip bank`" = "1" || fail "default number of lines is not 1"
+disable_chip chip
 remove_chip chip
 
 echo "2.2. Number of lines can be specified"
@@ -212,6 +216,7 @@ create_bank chip bank
 set_num_lines chip bank 16
 enable_chip chip
 test "`get_chip_num_lines chip bank`" = "16" || fail "number of lines is not 16"
+disable_chip chip
 remove_chip chip
 
 echo "2.3. Label can be set"
@@ -220,6 +225,7 @@ create_bank chip bank
 set_label chip bank foobar
 enable_chip chip
 test "`get_chip_label chip bank`" = "foobar" || fail "label is incorrect"
+disable_chip chip
 remove_chip chip
 
 echo "2.4. Label can be left empty"
@@ -227,6 +233,7 @@ create_chip chip
 create_bank chip bank
 enable_chip chip
 test -z "`cat $CONFIGFS_DIR/chip/bank/label`" || fail "label is not empty"
+disable_chip chip
 remove_chip chip
 
 echo "2.5. Line names can be configured"
@@ -238,6 +245,7 @@ set_line_name chip bank 2 bar
 enable_chip chip
 test "`get_line_name chip bank 0`" = "foo" || fail "line name is incorrect"
 test "`get_line_name chip bank 2`" = "bar" || fail "line name is incorrect"
+disable_chip chip
 remove_chip chip
 
 echo "2.6. Line config can remain unused if offset is greater than number of lines"
@@ -248,6 +256,7 @@ set_line_name chip bank 5 foobar
 enable_chip chip
 test "`get_line_name chip bank 0`" = "" || fail "line name is incorrect"
 test "`get_line_name chip bank 1`" = "" || fail "line name is incorrect"
+disable_chip chip
 remove_chip chip
 
 echo "2.7. Line configfs directory names are sanitized"
@@ -267,6 +276,7 @@ for CHIP in $CHIPS; do
 	enable_chip $CHIP
 done
 for CHIP in $CHIPS; do
+  disable_chip $CHIP
 	remove_chip $CHIP
 done
 
@@ -278,6 +288,7 @@ echo foobar > $CONFIGFS_DIR/chip/bank/label 2> /dev/null && \
 	fail "Setting label of a live chip should fail"
 echo 8 > $CONFIGFS_DIR/chip/bank/num_lines 2> /dev/null && \
 	fail "Setting number of lines of a live chip should fail"
+disable_chip chip
 remove_chip chip
 
 echo "2.10. Can't create line items when chip is live"
@@ -285,6 +296,7 @@ create_chip chip
 create_bank chip bank
 enable_chip chip
 mkdir $CONFIGFS_DIR/chip/bank/line0 2> /dev/null && fail "Creating line item should fail"
+disable_chip chip
 remove_chip chip
 
 echo "2.11. Probe errors are propagated to user-space"
@@ -316,6 +328,7 @@ mkdir -p $CONFIGFS_DIR/chip/bank/line4/hog
 enable_chip chip
 $BASE_DIR/gpio-mockup-cdev -s 1 /dev/`configfs_chip_name chip bank` 4 2> /dev/null && \
 	fail "Setting the value of a hogged line shouldn't succeed"
+disable_chip chip
 remove_chip chip
 
 echo "3. Controlling simulated chips"
@@ -331,6 +344,7 @@ test "$?" = "1" || fail "pull set incorrectly"
 sysfs_set_pull chip bank 0 pull-down
 $BASE_DIR/gpio-mockup-cdev /dev/`configfs_chip_name chip bank` 1
 test "$?" = "0" || fail "pull set incorrectly"
+disable_chip chip
 remove_chip chip
 
 echo "3.2. Pull can be read from sysfs"
@@ -344,6 +358,7 @@ SYSFS_PATH=/sys/devices/platform/$DEVNAME/$CHIPNAME/sim_gpio0/pull
 test `cat $SYSFS_PATH` = "pull-down" || fail "reading the pull failed"
 sysfs_set_pull chip bank 0 pull-up
 test `cat $SYSFS_PATH` = "pull-up" || fail "reading the pull failed"
+disable_chip chip
 remove_chip chip
 
 echo "3.3. Incorrect input in sysfs is rejected"
@@ -355,6 +370,7 @@ DEVNAME=`configfs_dev_name chip`
 CHIPNAME=`configfs_chip_name chip bank`
 SYSFS_PATH="/sys/devices/platform/$DEVNAME/$CHIPNAME/sim_gpio0/pull"
 echo foobar > $SYSFS_PATH 2> /dev/null && fail "invalid input not detected"
+disable_chip chip
 remove_chip chip
 
 echo "3.4. Can't write to value"
@@ -365,6 +381,7 @@ DEVNAME=`configfs_dev_name chip`
 CHIPNAME=`configfs_chip_name chip bank`
 SYSFS_PATH="/sys/devices/platform/$DEVNAME/$CHIPNAME/sim_gpio0/value"
 echo 1 > $SYSFS_PATH 2> /dev/null && fail "writing to 'value' succeeded unexpectedly"
+disable_chip chip
 remove_chip chip
 
 echo "4. Simulated GPIO chips are functional"
@@ -382,6 +399,7 @@ $BASE_DIR/gpio-mockup-cdev -s 1 /dev/`configfs_chip_name chip bank` 0 &
 sleep 0.1 # FIXME Any better way?
 test `cat $SYSFS_PATH` = "1" || fail "incorrect value read from sysfs"
 kill $!
+disable_chip chip
 remove_chip chip
 
 echo "4.2. Bias settings work correctly"
@@ -394,6 +412,7 @@ CHIPNAME=`configfs_chip_name chip bank`
 SYSFS_PATH="/sys/devices/platform/$DEVNAME/$CHIPNAME/sim_gpio0/value"
 $BASE_DIR/gpio-mockup-cdev -b pull-up /dev/`configfs_chip_name chip bank` 0
 test `cat $SYSFS_PATH` = "1" || fail "bias setting does not work"
+disable_chip chip
 remove_chip chip
 
 echo "GPIO $MODULE test PASS"
-- 
2.39.5


