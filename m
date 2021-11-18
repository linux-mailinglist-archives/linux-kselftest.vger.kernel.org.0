Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A23455EA3
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Nov 2021 15:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhKROzE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Nov 2021 09:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbhKROzC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Nov 2021 09:55:02 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DC1C06175C
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Nov 2021 06:52:01 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id b12so12073829wrh.4
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Nov 2021 06:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=78PfciJSEN4Uakaa+IsxmjA05b80ii/PRhNw0tkI3OA=;
        b=vUdxnvD6Aa/o+MNz/lWWLrdUX6UjBlC14m1qYIOfl54MJhap4mkDYKGABwhXgDB8JI
         hVytRIoZMhfhgLEK9fAANZZuqU5R/hdNaFA1BZY3zGliCgrrMEQimwGGmaMk280p1dT/
         MQ5N2816HfdnhrYCqVZB/LeHUF/4vIL7zNEyYo7nMVv9l5fHYNjZj6Jx35t9X/miZzjA
         IAyx9zGaIY/SrAfNk0rDQATMBl1wqUbpTMEHN02Rpe7rBhAZQw663rNtYbOb1hqMp8PQ
         O3T7mBn0FbbCKtGCEJv62nb95IdhPiALXBNeHLTLLz+7YOcF6YzNQERy6IOmJsfNrZcZ
         7KDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=78PfciJSEN4Uakaa+IsxmjA05b80ii/PRhNw0tkI3OA=;
        b=RjO5JoQ0zSo7Fu7xdYXnS2y1XpBAwDCKsK0G/lRqv3trsjS1YZcPNuGakj1Qz6PI3j
         dXMzg1zLrrlMJPfkfzSzGLWUWHPzHjmK+x/YB0o5F2cvil5LHex2UIxsjrPL0GQoNvNm
         DDEPoAYh5nxhjB5T1UWjViy/QNMpS/3lMl+8280SjlFW2yEE2h8MMpCW7kqko8tH/6Ry
         e13vTC73kmOAx4xbB/hC/4zL6OsPq+ZWlFPMIwhFP7OGvtLEObQfW/sG230f3BM80l9m
         PEHaY9ZoIldhru3kgBQwcTnmJMq3ntlU6rHsCJ7z/3sVG02eBnw4L/y35sxRnOOQ9rKY
         IWiw==
X-Gm-Message-State: AOAM531HDDKfhnCE5WXiBGkL089fx2h08kg9iytG0HX2VyRf8a1FZW8x
        dbbnoV0kfBqbajb8jud2SN7Hsw==
X-Google-Smtp-Source: ABdhPJzh13ZUgw1FTZ2fwe3zVHBzrUfBRRiUe/fB/yJTnQ6to18FirztNKtISs8ayK7CbHCtVpftuw==
X-Received: by 2002:a5d:5651:: with SMTP id j17mr31983038wrw.166.1637247120218;
        Thu, 18 Nov 2021 06:52:00 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:334:ac00:7d50:ff5:f5c1:e225])
        by smtp.gmail.com with ESMTPSA id f7sm63154wri.74.2021.11.18.06.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 06:51:59 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v9 4/4] selftests: gpio: add test cases for gpio-sim
Date:   Thu, 18 Nov 2021 15:51:42 +0100
Message-Id: <20211118145142.14519-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20211118145142.14519-1-brgl@bgdev.pl>
References: <20211118145142.14519-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a set of tests for the new gpio-sim module. This is a pure shell
test-suite and uses the helper programs available in the gpio selftests
directory. These test-cases only test the functionalities exposed by the
gpio-sim driver, not those handled by core gpiolib code.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 tools/testing/selftests/gpio/Makefile    |   2 +-
 tools/testing/selftests/gpio/config      |   1 +
 tools/testing/selftests/gpio/gpio-sim.sh | 266 +++++++++++++++++++++++
 3 files changed, 268 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/gpio/gpio-sim.sh

diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
index d7d8f1985d99..4c6df61c76a8 100644
--- a/tools/testing/selftests/gpio/Makefile
+++ b/tools/testing/selftests/gpio/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-TEST_PROGS := gpio-mockup.sh
+TEST_PROGS := gpio-mockup.sh gpio-sim.sh
 TEST_FILES := gpio-mockup-sysfs.sh
 TEST_GEN_PROGS_EXTENDED := gpio-mockup-cdev gpio-chip-info gpio-line-name
 
diff --git a/tools/testing/selftests/gpio/config b/tools/testing/selftests/gpio/config
index ce100342c20b..409a8532facc 100644
--- a/tools/testing/selftests/gpio/config
+++ b/tools/testing/selftests/gpio/config
@@ -1,3 +1,4 @@
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_CDEV=y
 CONFIG_GPIO_MOCKUP=m
+CONFIG_GPIO_SIM=m
diff --git a/tools/testing/selftests/gpio/gpio-sim.sh b/tools/testing/selftests/gpio/gpio-sim.sh
new file mode 100755
index 000000000000..99ce808d772a
--- /dev/null
+++ b/tools/testing/selftests/gpio/gpio-sim.sh
@@ -0,0 +1,266 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 Bartosz Golaszewski <brgl@bgdev.pl>
+
+BASE_DIR=`dirname $0`
+CONFIGFS_DIR="/sys/kernel/config/gpio-sim"
+MODULE="gpio-sim"
+
+fail() {
+	echo "$*" >&2
+	echo "GPIO $MODULE test FAIL"
+	exit 1
+}
+
+skip() {
+	echo "$*" >&2
+	echo "GPIO $MODULE test SKIP"
+	exit 4
+}
+
+remove_chip() {
+	local CHIP=$1
+
+	LINES=`ls $CONFIGFS_DIR/$CHIP/ | egrep ^line`
+	if [ "$?" == 0 ]; then
+		for LINE in $LINES; do
+			rmdir $CONFIGFS_DIR/$CHIP/$LINE || fail "Unable to remove the line"
+		done
+	fi
+
+	rmdir $CONFIGFS_DIR/$CHIP || fail "Unable to remove the chip"
+}
+
+configfs_cleanup() {
+	for CHIP in `ls $CONFIGFS_DIR/`; do
+		remove_chip $CHIP
+	done
+}
+
+create_chip() {
+	local CHIP=$1
+	local CHIP_DIR="$CONFIGFS_DIR/$CHIP"
+
+	mkdir $CHIP_DIR
+}
+
+set_label() {
+	local CHIP=$1
+	local LABEL=$2
+
+	echo $LABEL > $CONFIGFS_DIR/$CHIP/label || fail "Unable to set the chip label"
+}
+
+set_num_lines() {
+	local CHIP=$1
+	local NUM_LINES=$2
+
+	echo $NUM_LINES > $CONFIGFS_DIR/$CHIP/num_lines || fail "Unable to set the number of lines"
+}
+
+set_line_name() {
+	local CHIP=$1
+	local OFFSET=$2
+	local NAME=$3
+	local LINE_DIR=$CONFIGFS_DIR/$CHIP/line$OFFSET
+
+	test -d $LINE_DIR || mkdir $LINE_DIR
+	echo $NAME > $LINE_DIR/name || fail "Unable to set the line name"
+}
+
+enable_chip() {
+	local CHIP=$1
+
+	echo 1 > $CONFIGFS_DIR/$CHIP/live || fail "Unable to enable the chip"
+}
+
+disable_chip() {
+	local CHIP=$1
+
+	echo 0 > $CONFIGFS_DIR/$CHIP/live || fail "Unable to disable the chip"
+}
+
+configfs_chip_name() {
+	local CHIP="$1"
+
+	cat $CONFIGFS_DIR/$CHIP/chip_name 2> /dev/null || return 1
+}
+
+configfs_dev_name() {
+	local CHIP="$1"
+
+	cat $CONFIGFS_DIR/$CHIP/dev_name 2> /dev/null || return 1
+}
+
+get_chip_num_lines() {
+	local CHIP="$1"
+
+	$BASE_DIR/gpio-chip-info /dev/`configfs_chip_name $CHIP` num-lines
+}
+
+get_chip_label() {
+	local CHIP="$1"
+
+	$BASE_DIR/gpio-chip-info /dev/`configfs_chip_name $CHIP` label
+}
+
+get_line_name() {
+	local CHIP="$1"
+	local OFFSET="$2"
+
+	$BASE_DIR/gpio-line-name /dev/`configfs_chip_name $CHIP` $OFFSET
+}
+
+sysfs_set_pull() {
+	local CHIP="$1"
+	local OFFSET="$2"
+	local PULL="$3"
+	local SYSFSPATH="/sys/devices/platform/`configfs_dev_name $CHIP`/control/gpio$OFFSET"
+
+	echo $PULL > $SYSFSPATH || fail "Unable to set line pull in sysfs"
+}
+
+# Load the gpio-sim module. This will pull in configfs if needed too.
+modprobe gpio-sim || skip "unable to load the gpio-sim module"
+# Make sure configfs is mounted at /sys/kernel/config. Wait a bit if needed.
+for IDX in `seq 5`; do
+	if [ "$IDX" -eq "5" ]; then
+		skip "configfs not mounted at /sys/kernel/config"
+	fi
+
+	mountpoint -q /sys/kernel/config && break
+	sleep 0.1
+done
+# If the module was already loaded: remove all previous chips
+configfs_cleanup
+
+trap "exit 1" SIGTERM SIGINT
+trap configfs_cleanup EXIT
+
+echo "1. chip_name and dev_name attributes"
+
+echo "1.1. Chip name is communicated to user"
+create_chip chip
+enable_chip chip
+test -n `cat $CONFIGFS_DIR/chip/chip_name` || fail "chip_name doesn't work"
+remove_chip chip
+
+echo "1.2. chip_name returns 'none' if the chip is still pending"
+create_chip chip
+test "`cat $CONFIGFS_DIR/chip/chip_name`" = "none" || fail "chip_name doesn't return 'none' for a pending chip"
+remove_chip chip
+
+echo "1.3. Device name is communicated to user"
+create_chip chip
+enable_chip chip
+test -n `cat $CONFIGFS_DIR/chip/dev_name` || fail "dev_name doesn't work"
+remove_chip chip
+
+echo "2. Creating and configuring simulated chips"
+
+echo "2.1. Default number of lines is 1"
+create_chip chip
+enable_chip chip
+test "`get_chip_num_lines chip`" = "1" || fail "default number of lines is not 1"
+remove_chip chip
+
+echo "2.2. Number of lines can be specified"
+create_chip chip
+set_num_lines chip 16
+enable_chip chip
+test "`get_chip_num_lines chip`" = "16" || fail "number of lines is not 16"
+remove_chip chip
+
+echo "2.3. Label can be set"
+create_chip chip
+set_label chip foobar
+enable_chip chip
+test "`get_chip_label chip`" = "foobar" || fail "label is incorrect"
+remove_chip chip
+
+echo "2.4. Label can be left empty"
+create_chip chip
+enable_chip chip
+test -z "`cat $CONFIGFS_DIR/chip/label`" || fail "label is not empty"
+remove_chip chip
+
+echo "2.5. Line names can be configured"
+create_chip chip
+set_num_lines chip 16
+set_line_name chip 0 foo
+set_line_name chip 2 bar
+enable_chip chip
+test "`get_line_name chip 0`" = "foo" || fail "line name is incorrect"
+test "`get_line_name chip 2`" = "bar" || fail "line name is incorrect"
+remove_chip chip
+
+echo "2.6. Line name can remain unused"
+create_chip chip
+set_num_lines chip 2
+set_line_name chip 5 foobar
+enable_chip chip
+test "`get_line_name chip 0`" = "" || fail "line name is incorrect"
+test "`get_line_name chip 1`" = "" || fail "line name is incorrect"
+remove_chip chip
+
+echo "2.7. Line configfs directory names are sanitized"
+create_chip chip
+mkdir $CONFIGFS_DIR/chip/line12foobar 2> /dev/null && fail "invalid configfs line name accepted"
+mkdir $CONFIGFS_DIR/chip/line_no_offset 2> /dev/null && fail "invalid configfs line name accepted"
+remove_chip chip
+
+echo "2.8. Multiple chips can be created"
+CHIPS="chip0 chip1 chip2"
+for CHIP in $CHIPS; do
+	create_chip $CHIP
+	enable_chip $CHIP
+done
+for CHIP in $CHIPS; do
+	remove_chip $CHIP
+done
+
+echo "3. Controlling simulated chips"
+
+echo "3.3. Pull can be set over sysfs"
+create_chip chip
+set_num_lines chip 8
+enable_chip chip
+sysfs_set_pull chip 0 1
+$BASE_DIR/gpio-mockup-cdev /dev/`configfs_chip_name chip` 0
+test "$?" = "1" || fail "pull set incorrectly"
+sysfs_set_pull chip 0 0
+$BASE_DIR/gpio-mockup-cdev /dev/`configfs_chip_name chip` 1
+test "$?" = "0" || fail "pull set incorrectly"
+remove_chip chip
+
+echo "3.4. Incorrect input in sysfs is rejected"
+create_chip chip
+set_num_lines chip 8
+enable_chip chip
+SYSFS_PATH="/sys/devices/platform/`configfs_dev_name chip`/control/gpio0"
+echo 2 > $SYSFS_PATH 2> /dev/null && fail "invalid input not detected"
+remove_chip chip
+
+echo "4. Simulated GPIO chips are functional"
+
+echo "4.1. Values can be read from sysfs"
+create_chip chip
+set_num_lines chip 8
+enable_chip chip
+SYSFS_PATH="/sys/devices/platform/`configfs_dev_name chip`/control/gpio0"
+test `cat $SYSFS_PATH` = "0" || fail "incorrect value read from sysfs"
+$BASE_DIR/gpio-mockup-cdev -s 1 /dev/`configfs_chip_name chip` 0 &
+sleep 0.1 # FIXME Any better way?
+test `cat $SYSFS_PATH` = "1" || fail "incorrect value read from sysfs"
+kill $!
+remove_chip chip
+
+echo "4.2. Bias settings work correctly"
+create_chip chip
+set_num_lines chip 8
+enable_chip chip
+$BASE_DIR/gpio-mockup-cdev -b pull-up /dev/`configfs_chip_name chip` 0
+test `cat $SYSFS_PATH` = "1" || fail "bias setting does not work"
+remove_chip chip
+
+echo "GPIO $MODULE test PASS"
-- 
2.25.1

