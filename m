Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8565645B962
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Nov 2021 12:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241821AbhKXLqc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Nov 2021 06:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241779AbhKXLq0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Nov 2021 06:46:26 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267D3C06175B
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Nov 2021 03:43:08 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id k37-20020a05600c1ca500b00330cb84834fso5138710wms.2
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Nov 2021 03:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hwly1RCfwZ6v/FmR8kaOQU7+G0XGMvdAoue1GOwD+54=;
        b=0dgl3TVCPXC7FfNjQVLR4CALFi3QR1/fcl83imQs7azrjAk+zCXCdcNMGi0MqjDSQx
         bS8A3KMDHL8nT3VuAQIerWERvz3eCKZUXaeD9RuHoTJ97XtiAyJNDZSLpnQtLxvcAuwQ
         ucF3rmtdINU1PFx80en5D1xeHEBwmK8uY/gwEYcxlP8+aWKsQ/ec3AepmfuF8r2o3MgY
         07A6bbOpM2imqIojKIAmeNcWUg6eWQpMXMlfybLMIjfpTv0dIhCmX7zZucf47m9bjGhz
         8zmqspPGYx+IWI4WgJ7FEfL2b9Z4FpA0zr3OetpCRdEbVniJLZ4qXFc+NrWXhC5IFs7s
         ylMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hwly1RCfwZ6v/FmR8kaOQU7+G0XGMvdAoue1GOwD+54=;
        b=wWJ/KJHtwlAaIZazMtAPnt5I7CW8avu7Yqvxt1THOj62Kl46VBk1Isr0tdkwheni4Y
         MYOq/588rvh7GSWtufOqa+aqCnrDwBbowb5H50QKZ+UuNHuleW7zvwBMgrGpM9wHgbzU
         lriDs73sHizPWkPD8Jse8wENtMfLEnK1CRobtD7kK4PD/RdYjkVYoBWDsWbkZzUI94Zu
         /N8basfahtdr4unF/0YcFjotPF+gLKAKRr11NK6b5l2ZmISP3ZyFfJ1yxPVEoS7sHUlq
         PfxiAVmozfF+Vp4fAratvnK6ewRB1CvJN6/aX/5S7pYiok9+b1fFtHi/ZgdUMCVdsUJ/
         sbMw==
X-Gm-Message-State: AOAM530FMwdNc8Y3H521xJ8Ac+AiDdhxYcyKUwDKy+vx5ScodUta/kjP
        RWro0+IlSycEzCTEfLv9p/F3Tw==
X-Google-Smtp-Source: ABdhPJw5D53wq06caOYuh+qCXHMnmggV5nAMrCEl5Yd7YfEj/ooB0oH20ldDcH/ISvA4qDE6xhlqWw==
X-Received: by 2002:a05:600c:3b83:: with SMTP id n3mr13884065wms.116.1637754186581;
        Wed, 24 Nov 2021 03:43:06 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:334:ac00:7d50:ff5:f5c1:e225])
        by smtp.gmail.com with ESMTPSA id s63sm5165173wme.22.2021.11.24.03.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 03:43:06 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v10 5/5] selftests: gpio: add test cases for gpio-sim
Date:   Wed, 24 Nov 2021 12:42:57 +0100
Message-Id: <20211124114257.19878-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20211124114257.19878-1-brgl@bgdev.pl>
References: <20211124114257.19878-1-brgl@bgdev.pl>
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
 tools/testing/selftests/gpio/gpio-sim.sh | 306 +++++++++++++++++++++++
 3 files changed, 308 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/gpio/gpio-sim.sh

diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
index 293aa9749408..71b306602368 100644
--- a/tools/testing/selftests/gpio/Makefile
+++ b/tools/testing/selftests/gpio/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-TEST_PROGS := gpio-mockup.sh
+TEST_PROGS := gpio-mockup.sh gpio-sim.sh
 TEST_FILES := gpio-mockup-sysfs.sh
 TEST_GEN_PROGS_EXTENDED := gpio-mockup-cdev gpio-chip-info gpio-line-name
 CFLAGS += -O2 -g -Wall -I../../../../usr/include/
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
index 000000000000..4d8759d29eac
--- /dev/null
+++ b/tools/testing/selftests/gpio/gpio-sim.sh
@@ -0,0 +1,306 @@
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
+			if [ -e $CONFIGFS_DIR/$CHIP/$LINE/hog ]; then
+				rmdir $CONFIGFS_DIR/$CHIP/$LINE/hog || fail "Unable to remove the hog"
+			fi
+
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
+	local SYSFSPATH="/sys/devices/platform/`configfs_dev_name $CHIP`/sim_gpio$OFFSET/pull"
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
+echo "2.6. Line config can remain unused if offset is greater than number of lines"
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
+echo "2.9. Can't modify settings when chip is live"
+create_chip chip
+enable_chip chip
+echo foobar > $CONFIGFS_DIR/chip/label 2> /dev/null && fail "Setting label of a live chip should fail"
+echo 8 > $CONFIGFS_DIR/chip/num_lines 2> /dev/null && fail "Setting number of lines of a live chip should fail"
+remove_chip chip
+
+echo "2.10. Can't create line items when chip is live"
+create_chip chip
+enable_chip chip
+mkdir $CONFIGFS_DIR/chip/line0 2> /dev/null && fail "Creating line item should fail"
+remove_chip chip
+
+echo "2.11. Probe errors are propagated to user-space"
+create_chip chip
+set_num_lines chip 99999
+echo 1 > $CONFIGFS_DIR/chip/live 2> /dev/null && fail "Probe error was not propagated"
+remove_chip chip
+
+echo "3. Controlling simulated chips"
+
+echo "3.1. Pull can be set over sysfs"
+create_chip chip
+set_num_lines chip 8
+enable_chip chip
+sysfs_set_pull chip 0 pull-up
+$BASE_DIR/gpio-mockup-cdev /dev/`configfs_chip_name chip` 0
+test "$?" = "1" || fail "pull set incorrectly"
+sysfs_set_pull chip 0 pull-down
+$BASE_DIR/gpio-mockup-cdev /dev/`configfs_chip_name chip` 1
+test "$?" = "0" || fail "pull set incorrectly"
+remove_chip chip
+
+echo "3.2. Pull can be read from sysfs"
+create_chip chip
+set_num_lines chip 8
+enable_chip chip
+SYSFS_PATH=/sys/devices/platform/`configfs_dev_name chip`/sim_gpio0/pull
+test `cat $SYSFS_PATH` = "pull-down" || fail "reading the pull failed"
+sysfs_set_pull chip 0 pull-up
+test `cat $SYSFS_PATH` = "pull-up" || fail "reading the pull failed"
+remove_chip chip
+
+echo "3.3. Incorrect input in sysfs is rejected"
+create_chip chip
+set_num_lines chip 8
+enable_chip chip
+SYSFS_PATH="/sys/devices/platform/`configfs_dev_name chip`/sim_gpio0/pull"
+echo foobar > $SYSFS_PATH 2> /dev/null && fail "invalid input not detected"
+remove_chip chip
+
+echo "3.4. Can't write to value"
+create_chip chip
+enable_chip chip
+SYSFS_PATH=/sys/devices/platform/`configfs_dev_name chip`/sim_gpio0/value
+echo 1 > $SYSFS_PATH 2> /dev/null && fail "writing to 'value' succeeded unexpectedly"
+remove_chip chip
+
+echo "4. Simulated GPIO chips are functional"
+
+echo "4.1. Values can be read from sysfs"
+create_chip chip
+set_num_lines chip 8
+enable_chip chip
+SYSFS_PATH="/sys/devices/platform/`configfs_dev_name chip`/sim_gpio0/value"
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

