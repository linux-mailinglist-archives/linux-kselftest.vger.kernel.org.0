Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 829E62FBE00
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jan 2021 18:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403783AbhASOvH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jan 2021 09:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393050AbhASMcG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jan 2021 07:32:06 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C129CC061574;
        Tue, 19 Jan 2021 04:31:25 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id o20so3738376pfu.0;
        Tue, 19 Jan 2021 04:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4IWaFMUdPKIWxoafPQ6eL/161AFysSuRmhdJ6Woludk=;
        b=qNCHDZhBo8nI1TIvEBMJW+0gq7NBneboag+mcyEl7d1rao5t+BIbcIIx1QScirfldt
         sH10xChB3zUpv0zVIWEQiuceI7txqd1isFjmwVFMg8eTMOZp5NX9BQgF4ENOeRzXQsl6
         6qckjD/1+OHnQ0/IBspINauc2Gl5niFtAqcbDmxIvZsEAUxsmUSUuKm0oCf5a2KNW5M6
         WvZQRT/nvBvTJ0ru7Y8iCXQQ/ntZVgxcXzEps8mu1c+/u3hCEq1+dgwrjKP/2gSu6CED
         ezVx6duSxmshwHPvMusmFmp/sWljeRDNUm4YQsk4MD5fiKPR26qJZmob/GObM6jdZo4D
         u/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4IWaFMUdPKIWxoafPQ6eL/161AFysSuRmhdJ6Woludk=;
        b=L10VEiHrfSEedrAAKYk120c2TlR5Yy/zLeLxYKW1toUdWEGEyI2s7SFAiCw1KIvJI8
         viAj4WFOoKIDTXQkEOjd5ToKMQ2MtZYhQ1cIWK3kylwEKEbwJL4WcGpPf6+epx8B5alp
         KOS1QL3zM1J0okQCBhDiJss6VzjmBtRuTg53JHkDg5h3gBmCZr2Vq1cJKzoj6PBJBbrw
         mMVVyewBWkri4gIWhVDlpMe537SpFpVQ/GjgItOnoqnL3ym+XaF6AB/xrQYG2uj4sfJR
         ucTkptDaOu9HI3N9iIDIZiLRQkq5+lKe5Elu+FMbTeEKwpWtcH9mYle1XvlQ58qViXWH
         00ag==
X-Gm-Message-State: AOAM5333gk3VuBEBQ3PogH2l/iJM82A8ReaYI+RHR8QGd5zdPWLxfYmO
        aHqZGD6MCcBMoVEK1OnktVwFCGM6JFs=
X-Google-Smtp-Source: ABdhPJx6o8x+SYlOoKQhJnA0D9DTcDYOUq23j6zuPzFa1dAL5lZQAKs8gi7AKLaBAUxrKU3e0yZbgQ==
X-Received: by 2002:a63:d04a:: with SMTP id s10mr4250216pgi.32.1611059484340;
        Tue, 19 Jan 2021 04:31:24 -0800 (PST)
Received: from sol.lan (106-69-181-154.dyn.iinet.net.au. [106.69.181.154])
        by smtp.gmail.com with ESMTPSA id q4sm19283052pgr.39.2021.01.19.04.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 04:31:23 -0800 (PST)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kselftest@vger.kernel.org, bgolaszewski@baylibre.com,
        linus.walleij@linaro.org, shuah@kernel.org, bamv2005@gmail.com
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v3 1/7] selftests: gpio: rework and simplify test implementation
Date:   Tue, 19 Jan 2021 20:30:53 +0800
Message-Id: <20210119123059.102004-2-warthog618@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210119123059.102004-1-warthog618@gmail.com>
References: <20210119123059.102004-1-warthog618@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The GPIO mockup selftests are overly complicated with separate
implementations of the tests for sysfs and cdev uAPI, and with the cdev
implementation being dependent on tools/gpio and libmount.

Rework the test implementation to provide a common test suite with a
simplified pluggable uAPI interface.  The cdev implementation utilises
the GPIO uAPI directly to remove the dependence on tools/gpio.
The simplified uAPI interface removes the need for any file system mount
checks in C, and so removes the dependence on libmount.

The rework also fixes the sysfs test implementation which has been broken
since the device created in the multiple gpiochip case was split into
separate devices.

Fixes: 8a39f597bcfd ("gpio: mockup: rework device probing")
Signed-off-by: Kent Gibson <warthog618@gmail.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 tools/testing/selftests/gpio/Makefile         |  26 +-
 .../testing/selftests/gpio/gpio-mockup-cdev.c | 139 +++++
 .../selftests/gpio/gpio-mockup-sysfs.sh       | 168 ++----
 tools/testing/selftests/gpio/gpio-mockup.sh   | 490 ++++++++++++------
 4 files changed, 535 insertions(+), 288 deletions(-)
 create mode 100644 tools/testing/selftests/gpio/gpio-mockup-cdev.c

diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
index 41582fe485ee..39f2bbe8dd3d 100644
--- a/tools/testing/selftests/gpio/Makefile
+++ b/tools/testing/selftests/gpio/Makefile
@@ -1,31 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
-VAR_CFLAGS := $(shell pkg-config --cflags mount 2>/dev/null)
-VAR_LDLIBS := $(shell pkg-config --libs mount 2>/dev/null)
-ifeq ($(VAR_LDLIBS),)
-VAR_LDLIBS := -lmount -I/usr/include/libmount
-endif
-
-CFLAGS += -O2 -g -std=gnu99 -Wall -I../../../../usr/include/ $(VAR_CFLAGS)
-LDLIBS += $(VAR_LDLIBS)
-
 TEST_PROGS := gpio-mockup.sh
 TEST_FILES := gpio-mockup-sysfs.sh
-TEST_GEN_PROGS_EXTENDED := gpio-mockup-chardev
+TEST_GEN_PROGS_EXTENDED := gpio-mockup-cdev
 
-KSFT_KHDR_INSTALL := 1
 include ../lib.mk
-
-GPIODIR := $(realpath ../../../gpio)
-GPIOOUT := $(OUTPUT)/tools-gpio/
-GPIOOBJ := $(GPIOOUT)/gpio-utils.o
-
-CLEAN += ; $(RM) -rf $(GPIOOUT)
-
-$(TEST_GEN_PROGS_EXTENDED): $(GPIOOBJ)
-
-$(GPIOOUT):
-	mkdir -p $@
-
-$(GPIOOBJ): $(GPIOOUT)
-	$(MAKE) OUTPUT=$(GPIOOUT) -C $(GPIODIR)
diff --git a/tools/testing/selftests/gpio/gpio-mockup-cdev.c b/tools/testing/selftests/gpio/gpio-mockup-cdev.c
new file mode 100644
index 000000000000..3a7fc3ac1349
--- /dev/null
+++ b/tools/testing/selftests/gpio/gpio-mockup-cdev.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * GPIO mockup cdev test helper
+ *
+ * Copyright (C) 2020 Kent Gibson
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <linux/gpio.h>
+
+#define CONSUMER	"gpio-mockup-cdev"
+
+static int request_line_v1(int cfd, unsigned int offset,
+			   uint32_t flags, unsigned int val)
+{
+	struct gpiohandle_request req;
+	int ret;
+
+	memset(&req, 0, sizeof(req));
+	req.lines = 1;
+	req.lineoffsets[0] = offset;
+	req.flags = flags;
+	strcpy(req.consumer_label, CONSUMER);
+	if (flags & GPIOHANDLE_REQUEST_OUTPUT)
+		req.default_values[0] = val;
+
+	ret = ioctl(cfd, GPIO_GET_LINEHANDLE_IOCTL, &req);
+	if (ret == -1)
+		return -errno;
+	return req.fd;
+}
+
+static int get_value_v1(int lfd)
+{
+	struct gpiohandle_data vals;
+	int ret;
+
+	memset(&vals, 0, sizeof(vals));
+	ret = ioctl(lfd, GPIOHANDLE_GET_LINE_VALUES_IOCTL, &vals);
+	if (ret == -1)
+		return -errno;
+	return vals.values[0];
+}
+
+static void usage(char *prog)
+{
+	printf("Usage: %s [-l] [-b <bias>] [-s <value>] [-u <uAPI>] <gpiochip> <offset>\n", prog);
+	printf("        -b: set line bias to one of pull-down, pull-up, disabled\n");
+	printf("               (default is to leave bias unchanged):\n");
+	printf("        -l: set line active low (default is active high)\n");
+	printf("        -s: set line value (default is to get line value)\n");
+	exit(-1);
+}
+
+static int wait_signal(void)
+{
+	int sig;
+	sigset_t wset;
+
+	sigemptyset(&wset);
+	sigaddset(&wset, SIGHUP);
+	sigaddset(&wset, SIGINT);
+	sigaddset(&wset, SIGTERM);
+	sigwait(&wset, &sig);
+
+	return sig;
+}
+
+int main(int argc, char *argv[])
+{
+	char *chip;
+	int opt, ret, cfd, lfd;
+	unsigned int offset, val;
+	uint32_t flags_v1;
+
+	ret = 0;
+	flags_v1 = GPIOHANDLE_REQUEST_INPUT;
+
+	while ((opt = getopt(argc, argv, "lb:s:u:")) != -1) {
+		switch (opt) {
+		case 'l':
+			flags_v1 |= GPIOHANDLE_REQUEST_ACTIVE_LOW;
+			break;
+		case 'b':
+			if (strcmp("pull-up", optarg) == 0)
+				flags_v1 |= GPIOHANDLE_REQUEST_BIAS_PULL_UP;
+			else if (strcmp("pull-down", optarg) == 0)
+				flags_v1 |= GPIOHANDLE_REQUEST_BIAS_PULL_DOWN;
+			else if (strcmp("disabled", optarg) == 0)
+				flags_v1 |= GPIOHANDLE_REQUEST_BIAS_DISABLE;
+			break;
+		case 's':
+			val = atoi(optarg);
+			flags_v1 &= ~GPIOHANDLE_REQUEST_INPUT;
+			flags_v1 |= GPIOHANDLE_REQUEST_OUTPUT;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+
+	if (argc < optind + 2)
+		usage(argv[0]);
+
+	chip = argv[optind];
+	offset = atoi(argv[optind + 1]);
+
+	cfd = open(chip, 0);
+	if (cfd == -1) {
+		fprintf(stderr, "Failed to open %s: %s\n", chip, strerror(errno));
+		return -errno;
+	}
+
+	lfd = request_line_v1(cfd, offset, flags_v1, val);
+
+	close(cfd);
+
+	if (lfd < 0) {
+		fprintf(stderr, "Failed to request %s:%d: %s\n", chip, offset, strerror(-lfd));
+		return lfd;
+	}
+
+	if (flags_v1 & GPIOHANDLE_REQUEST_OUTPUT)
+		wait_signal();
+	else
+		ret = get_value_v1(lfd);
+
+	close(lfd);
+
+	return ret;
+}
diff --git a/tools/testing/selftests/gpio/gpio-mockup-sysfs.sh b/tools/testing/selftests/gpio/gpio-mockup-sysfs.sh
index dd269d877562..2d2e5d8763b6 100755
--- a/tools/testing/selftests/gpio/gpio-mockup-sysfs.sh
+++ b/tools/testing/selftests/gpio/gpio-mockup-sysfs.sh
@@ -1,135 +1,77 @@
 
 # SPDX-License-Identifier: GPL-2.0
-is_consistent()
-{
-	val=
-
-	active_low_sysfs=`cat $GPIO_SYSFS/gpio$nr/active_low`
-	val_sysfs=`cat $GPIO_SYSFS/gpio$nr/value`
-	dir_sysfs=`cat $GPIO_SYSFS/gpio$nr/direction`
 
-	gpio_this_debugfs=`cat $GPIO_DEBUGFS |grep "gpio-$nr" | sed "s/(.*)//g"`
-	dir_debugfs=`echo $gpio_this_debugfs | awk '{print $2}'`
-	val_debugfs=`echo $gpio_this_debugfs | awk '{print $3}'`
-	if [ $val_debugfs = "lo" ]; then
-		val=0
-	elif [ $val_debugfs = "hi" ]; then
-		val=1
-	fi
+# Overrides functions in gpio-mockup.sh to test using the GPIO SYSFS uAPI
 
-	if [ $active_low_sysfs = "1" ]; then
-		if [ $val = "0" ]; then
-			val="1"
-		else
-			val="0"
-		fi
-	fi
+SYSFS=`grep -w sysfs /proc/mounts | cut -f2 -d' '`
+[ -d "$SYSFS" ] || skip "sysfs is not mounted"
 
-	if [ $val_sysfs = $val ] && [ $dir_sysfs = $dir_debugfs ]; then
-		echo -n "."
-	else
-		echo "test fail, exit"
-		die
-	fi
-}
+GPIO_SYSFS="${SYSFS}/class/gpio"
+[ -d "$GPIO_SYSFS" ] || skip "CONFIG_GPIO_SYSFS is not selected"
 
-test_pin_logic()
-{
-	nr=$1
-	direction=$2
-	active_low=$3
-	value=$4
+PLATFORM_SYSFS=$SYSFS/devices/platform
 
-	echo $direction > $GPIO_SYSFS/gpio$nr/direction
-	echo $active_low > $GPIO_SYSFS/gpio$nr/active_low
-	if [ $direction = "out" ]; then
-		echo $value > $GPIO_SYSFS/gpio$nr/value
-	fi
-	is_consistent $nr
-}
+sysfs_nr=
+sysfs_ldir=
 
-test_one_pin()
+# determine the sysfs GPIO number given the $chip and $offset
+# e.g. gpiochip1:32
+find_sysfs_nr()
 {
-	nr=$1
-
-	echo -n "test pin<$nr>"
-
-	echo $nr > $GPIO_SYSFS/export 2>/dev/null
-
-	if [ X$? != X0 ]; then
-		echo "test GPIO pin $nr failed"
-		die
-	fi
-
-	#"Checking if the sysfs is consistent with debugfs: "
-	is_consistent $nr
-
-	#"Checking the logic of active_low: "
-	test_pin_logic $nr out 1 1
-	test_pin_logic $nr out 1 0
-	test_pin_logic $nr out 0 1
-	test_pin_logic $nr out 0 0
-
-	#"Checking the logic of direction: "
-	test_pin_logic $nr in 1 1
-	test_pin_logic $nr out 1 0
-	test_pin_logic $nr low 0 1
-	test_pin_logic $nr high 0 0
-
-	echo $nr > $GPIO_SYSFS/unexport
-
-	echo "successful"
+	# e.g. /sys/devices/platform/gpio-mockup.1/gpiochip1
+	local platform=$(find $PLATFORM_SYSFS -mindepth 2 -maxdepth 2 -type d -name $chip)
+	[ "$platform" ] || fail "can't find platform of $chip"
+	# e.g. /sys/devices/platform/gpio-mockup.1/gpio/gpiochip508/base
+	local base=$(find ${platform%/*}/gpio/ -mindepth 2 -maxdepth 2 -type f -name base)
+	[ "$base" ] || fail "can't find base of $chip"
+	sysfs_nr=$(($(< "$base") + $offset))
+	sysfs_ldir="$GPIO_SYSFS/gpio$sysfs_nr"
 }
 
-test_one_pin_fail()
+acquire_line()
 {
-	nr=$1
-
-	echo $nr > $GPIO_SYSFS/export 2>/dev/null
-
-	if [ X$? != X0 ]; then
-		echo "test invalid pin $nr successful"
-	else
-		echo "test invalid pin $nr failed"
-		echo $nr > $GPIO_SYSFS/unexport 2>/dev/null
-		die
-	fi
+	[ "$sysfs_nr" ] && return
+	find_sysfs_nr
+	echo "$sysfs_nr" > "$GPIO_SYSFS/export"
 }
 
-list_chip()
+# The helpers being overridden...
+get_line()
 {
-	echo `ls -d $GPIO_DRV_SYSFS/gpiochip* 2>/dev/null`
+	[ -e "$sysfs_ldir/value" ] && echo $(< "$sysfs_ldir/value")
 }
 
-test_chip()
+set_line()
 {
-	chip=$1
-	name=`basename $chip`
-	base=`cat $chip/base`
-	ngpio=`cat $chip/ngpio`
-	printf "%-10s %-5s %-5s\n" $name $base $ngpio
-	if [ $ngpio = "0" ]; then
-		echo "number of gpio is zero is not allowed".
-	fi
-	test_one_pin $base
-	test_one_pin $(($base + $ngpio - 1))
-	test_one_pin $((( RANDOM % $ngpio )  + $base ))
+	acquire_line
+
+	for option in $*; do
+		case $option in
+		active-high)
+			echo 0 > "$sysfs_ldir/active_low"
+			;;
+		active-low)
+			echo 1 > "$sysfs_ldir/active_low"
+			;;
+		input)
+			echo "in" > "$sysfs_ldir/direction"
+			;;
+		0)
+			echo "out" > "$sysfs_ldir/direction"
+			echo 0 > "$sysfs_ldir/value"
+			;;
+		1)
+			echo "out" > "$sysfs_ldir/direction"
+			echo 1 > "$sysfs_ldir/value"
+			;;
+		esac
+	done
 }
 
-test_chips_sysfs()
+release_line()
 {
-       gpiochip=`list_chip $module`
-       if [ X"$gpiochip" = X ]; then
-               if [ X"$valid" = Xfalse ]; then
-                       echo "successful"
-               else
-                       echo "fail"
-                       die
-               fi
-       else
-               for chip in $gpiochip; do
-                       test_chip $chip
-               done
-       fi
+	[ "$sysfs_nr" ] || return 0
+	echo "$sysfs_nr" > "$GPIO_SYSFS/unexport"
+	sysfs_nr=
+	sysfs_ldir=
 }
-
diff --git a/tools/testing/selftests/gpio/gpio-mockup.sh b/tools/testing/selftests/gpio/gpio-mockup.sh
index 7f35b9880485..0aa8e4294de1 100755
--- a/tools/testing/selftests/gpio/gpio-mockup.sh
+++ b/tools/testing/selftests/gpio/gpio-mockup.sh
@@ -1,72 +1,55 @@
-#!/bin/bash
+#!/bin/bash -efu
 # SPDX-License-Identifier: GPL-2.0
 
 #exit status
-#1: Internal error
-#2: sysfs/debugfs not mount
-#3: insert module fail when gpio-mockup is a module.
-#4: Skip test including run as non-root user.
-#5: other reason.
-
-SYSFS=
-GPIO_SYSFS=
-GPIO_DRV_SYSFS=
+#0: success
+#1: fail
+#4: skip test - including run as non-root user
+
+BASE=${0%/*}
 DEBUGFS=
 GPIO_DEBUGFS=
-dev_type=
-module=
+dev_type="cdev"
+module="gpio-mockup"
+verbose=
+full_test=
+random=
+active_opt=
+bias_opt=
+line_set_pid=
 
-# Kselftest framework requirement - SKIP code is 4.
+# Kselftest return codes
+ksft_fail=1
 ksft_skip=4
 
 usage()
 {
 	echo "Usage:"
-	echo "$0 [-f] [-m name] [-t type]"
-	echo "-f:  full test. It maybe conflict with existence gpio device."
-	echo "-m:  module name, default name is gpio-mockup. It could also test"
-	echo "     other gpio device."
-	echo "-t:  interface type: chardev(char device) and sysfs(being"
-	echo "     deprecated). The first one is default"
-	echo ""
-	echo "$0 -h"
-	echo "This usage"
+	echo "$0 [-frv] [-t type]"
+	echo "-f:  full test (minimal set run by default)"
+	echo "-r:  test random lines as well as fence posts"
+	echo "-t:  interface type:"
+	echo "      cdev (character device ABI) - default"
+	echo "      sysfs (deprecated SYSFS ABI)"
+	echo "-v:  verbose progress reporting"
+	exit $ksft_fail
 }
 
-prerequisite()
+skip()
 {
-	msg="skip all tests:"
-	if [ $UID != 0 ]; then
-		echo $msg must be run as root >&2
-		exit $ksft_skip
-	fi
-	SYSFS=`mount -t sysfs | head -1 | awk '{ print $3 }'`
-	if [ ! -d "$SYSFS" ]; then
-		echo $msg sysfs is not mounted >&2
-		exit 2
-	fi
-	GPIO_SYSFS=`echo $SYSFS/class/gpio`
-	GPIO_DRV_SYSFS=`echo $SYSFS/devices/platform/$module/gpio`
-	DEBUGFS=`mount -t debugfs | head -1 | awk '{ print $3 }'`
-	if [ ! -d "$DEBUGFS" ]; then
-		echo $msg debugfs is not mounted >&2
-		exit 2
-	fi
-	GPIO_DEBUGFS=`echo $DEBUGFS/gpio`
-	source gpio-mockup-sysfs.sh
+	echo "$*" >&2
+	echo "GPIO $module test SKIP"
+	exit $ksft_skip
 }
 
-try_insert_module()
+prerequisite()
 {
-	if [ -d "$GPIO_DRV_SYSFS" ]; then
-		echo "$GPIO_DRV_SYSFS exist. Skip insert module"
-	else
-		modprobe -q $module $1
-		if [ X$? != X0 ]; then
-			echo $msg insmod $module failed >&2
-			exit 3
-		fi
-	fi
+	[ $(id -u) -eq 0 ] || skip "must be run as root"
+
+	DEBUGFS=$(grep -w debugfs /proc/mounts | cut -f2 -d' ')
+	[ -d "$DEBUGFS" ] || skip "debugfs is not mounted"
+
+	GPIO_DEBUGFS=$DEBUGFS/$module
 }
 
 remove_module()
@@ -74,133 +57,340 @@ remove_module()
 	modprobe -r -q $module
 }
 
-die()
+cleanup()
 {
+	set +e
+	release_line
 	remove_module
-	exit 5
+	jobs -p | xargs -r kill > /dev/null 2>&1
 }
 
-test_chips()
+fail()
 {
-	if [ X$dev_type = Xsysfs ]; then
-		echo "WARNING: sysfs ABI of gpio is going to deprecated."
-		test_chips_sysfs $*
-	else
-		$BASE/gpio-mockup-chardev $*
-	fi
+	echo "test failed: $*" >&2
+	echo "GPIO $module test FAIL"
+	exit $ksft_fail
+}
+
+try_insert_module()
+{
+	modprobe -q $module "$1" || fail "insert $module failed with error $?"
+}
+
+log()
+{
+	[ -z "$verbose" ] || echo "$*"
 }
 
-gpio_test()
+# The following line helpers, release_Line, get_line and set_line, all
+# make use of the global $chip and $offset variables.
+#
+# This implementation drives the GPIO character device (cdev) uAPI.
+# Other implementations may override these to test different uAPIs.
+
+# Release any resources related to the line
+release_line()
 {
-	param=$1
-	valid=$2
+	[ "$line_set_pid" ] && kill $line_set_pid && wait $line_set_pid || true
+	line_set_pid=
+}
 
-	if [ X"$param" = X ]; then
-		die
+# Read the current value of the line
+get_line()
+{
+	release_line
+
+	$BASE/gpio-mockup-cdev $active_opt /dev/$chip $offset
+	echo $?
+}
+
+# Set the state of the line
+#
+# Changes to line configuration are provided as parameters.
+# The line is assumed to be an output if the line value 0 or 1 is
+# specified, else an input.
+set_line()
+{
+	local val=
+
+	release_line
+
+	# parse config options...
+	for option in $*; do
+		case $option in
+		active-low)
+			active_opt="-l "
+			;;
+		active-high)
+			active_opt=
+			;;
+		bias-none)
+			bias_opt=
+			;;
+		pull-down)
+			bias_opt="-bpull-down "
+			;;
+		pull-up)
+			bias_opt="-bpull-up "
+			;;
+		0)
+			val=0
+			;;
+		1)
+			val=1
+			;;
+		esac
+	done
+
+	local cdev_opts=${active_opt}
+	if [ "$val" ]; then
+		$BASE/gpio-mockup-cdev $cdev_opts -s$val /dev/$chip $offset &
+		# failure to set is detected by reading mockup and toggling values
+		line_set_pid=$!
+		# allow for gpio-mockup-cdev to launch and request line
+		# (there is limited value in checking if line has been requested)
+		sleep 0.01
+	elif [ "$bias_opt" ]; then
+		cdev_opts=${cdev_opts}${bias_opt}
+		$BASE/gpio-mockup-cdev $cdev_opts /dev/$chip $offset || true
 	fi
-	try_insert_module "gpio_mockup_ranges=$param"
-	echo -n "GPIO $module test with ranges: <"
-	echo "$param>: "
-	printf "%-10s %s\n" $param
-	test_chips $module $valid
-	remove_module
 }
 
-BASE=`dirname $0`
+assert_line()
+{
+	local val
+	# don't need any retry here as set_mock allows for propagation
+	val=$(get_line)
+	[ "$val" = "$1" ] || fail "line value is ${val:-empty} when $1 was expected"
+}
+
+# The following mockup helpers all make use of the $mock_line
+assert_mock()
+{
+	local backoff_wait=10
+	local retry=0
+	local val
+	# retry allows for set propagation from uAPI to mockup
+	while true; do
+		val=$(< $mock_line)
+		[ "$val" = "$1" ] && break
+		retry=$((retry + 1))
+		[ $retry -lt 5 ] || fail "mockup $mock_line value ${val:-empty} when $1 expected"
+		sleep $(printf "%0.2f" $((backoff_wait))e-3)
+		backoff_wait=$((backoff_wait * 2))
+	done
+}
+
+set_mock()
+{
+	echo "$1" > $mock_line
+	# allow for set propagation - so we won't be in a race with set_line
+	assert_mock "$1"
+}
 
-dev_type=
-TEMP=`getopt -o fhm:t: -n '$0' -- "$@"`
+# test the functionality of a line
+#
+# The line is set from the mockup side and is read from the userspace side
+# (input), and is set from the userspace side and is read from the mockup side
+# (output).
+#
+# Setting the mockup pull using the userspace interface bias settings is
+# tested where supported by the userspace interface (cdev).
+test_line()
+{
+	chip=$1
+	offset=$2
+	log "test_line $chip $offset"
+	mock_line=$GPIO_DEBUGFS/$chip/$offset
+	[ -e "$mock_line" ] || fail "missing line $chip:$offset"
 
-if [ "$?" != "0" ]; then
-        echo "Parameter process failed, Terminating..." >&2
-        exit 1
-fi
+	# test input active-high
+	set_mock 1
+	set_line input active-high
+	assert_line 1
+	set_mock 0
+	assert_line 0
+	set_mock 1
+	assert_line 1
+
+	if [ "$full_test" ]; then
+		if [ "$dev_type" != "sysfs" ]; then
+			# test pulls
+			set_mock 0
+			set_line input pull-up
+			assert_line 1
+			set_mock 0
+			assert_line 0
+
+			set_mock 1
+			set_line input pull-down
+			assert_line 0
+			set_mock 1
+			assert_line 1
+
+			set_line bias-none
+		fi
+
+		# test input active-low
+		set_mock 0
+		set_line active-low
+		assert_line 1
+		set_mock 1
+		assert_line 0
+		set_mock 0
+		assert_line 1
+
+		# test output active-high
+		set_mock 1
+		set_line active-high 0
+		assert_mock 0
+		set_line 1
+		assert_mock 1
+		set_line 0
+		assert_mock 0
+	fi
+
+	# test output active-low
+	set_mock 0
+	set_line active-low 0
+	assert_mock 1
+	set_line 1
+	assert_mock 0
+	set_line 0
+	assert_mock 1
+
+	release_line
+}
+
+test_no_line()
+{
+	log test_no_line "$*"
+	[ ! -e "$GPIO_DEBUGFS/$1/$2" ] || fail "unexpected line $1:$2"
+}
 
-# Note the quotes around `$TEMP': they are essential!
-eval set -- "$TEMP"
+# Load the module and check that the expected number of gpiochips, with the
+# expected number of lines, are created and are functional.
+#
+# $1 is the gpio_mockup_ranges parameter for the module
+# The remaining parameters are the number of lines, n, expected for each of
+# the gpiochips expected to be created.
+#
+# For each gpiochip the fence post lines, 0 and n-1, are tested, and the
+# line on the far side of the fence post, n, is tested to not exist.
+#
+# If the $random flag is set then a random line in the middle of the
+# gpiochip is tested as well.
+insmod_test()
+{
+	local ranges=
+	local gc=
+	local width=
 
-while true; do
-	case $1 in
-	-f)
+	[ "${1:-}" ] || fail "missing ranges"
+	ranges=$1 ; shift
+	try_insert_module "gpio_mockup_ranges=$ranges"
+	log "GPIO $module test with ranges: <$ranges>:"
+	# e.g. /sys/kernel/debug/gpio-mockup/gpiochip1
+	gpiochip=$(find "$DEBUGFS/$module/" -name gpiochip* -type d | sort)
+	for chip in $gpiochip; do
+		gc=${chip##*/}
+		[ "${1:-}" ] || fail "unexpected chip - $gc"
+		width=$1 ; shift
+		test_line $gc 0
+		if [ "$random" -a $width -gt 2 ]; then
+			test_line $gc $((RANDOM % ($width - 2) + 1))
+		fi
+		test_line $gc $(($width - 1))
+		test_no_line $gc $width
+	done
+	[ "${1:-}" ] && fail "missing expected chip of width $1"
+	remove_module || fail "failed to remove module with error $?"
+}
+
+while getopts ":frvt:" opt; do
+	case $opt in
+	f)
 		full_test=true
-		shift
-		;;
-	-h)
-		usage
-		exit
 		;;
-	-m)
-		module=$2
-		shift 2
+	r)
+		random=true
 		;;
-	-t)
-		dev_type=$2
-		shift 2
+	t)
+		dev_type=$OPTARG
 		;;
-	--)
-		shift
-		break
+	v)
+		verbose=true
 		;;
 	*)
-		echo "Internal error!"
-		exit 1
+		usage
 		;;
 	esac
 done
+shift $((OPTIND - 1))
 
-if [ X"$module" = X ]; then
-	module="gpio-mockup"
-fi
-
-if [ X$dev_type != Xsysfs ]; then
-	dev_type="chardev"
-fi
+[ "${1:-}" ] && fail "unknown argument '$1'"
 
 prerequisite
 
-echo "1.  Test dynamic allocation of gpio successful means insert gpiochip and"
-echo "    manipulate gpio pin successful"
-gpio_test "-1,32" true
-gpio_test "-1,32,-1,32" true
-gpio_test "-1,32,-1,32,-1,32" true
-if [ X$full_test = Xtrue ]; then
-	gpio_test "-1,32,32,64" true
-	gpio_test "-1,32,40,64,-1,5" true
-	gpio_test "-1,32,32,64,-1,32" true
-	gpio_test "0,32,32,64,-1,32,-1,32" true
-	gpio_test "-1,32,-1,32,0,32,32,64" true
-	echo "2.  Do basic test: successful means insert gpiochip and"
-	echo "    manipulate gpio pin successful"
-	gpio_test "0,32" true
-	gpio_test "0,32,32,64" true
-	gpio_test "0,32,40,64,64,96" true
+trap 'exit $ksft_fail' SIGTERM SIGINT
+trap cleanup EXIT
+
+case "$dev_type" in
+sysfs)
+	source $BASE/gpio-mockup-sysfs.sh
+	echo "WARNING: gpio sysfs ABI is deprecated."
+	;;
+cdev)
+	;;
+*)
+	fail "unknown interface type: $dev_type"
+	;;
+esac
+
+remove_module || fail "can't remove existing $module module"
+
+# manual gpio allocation tests fail if a physical chip already exists
+[ "$full_test" -a -e "/dev/gpiochip0" ] && skip "full tests conflict with gpiochip0"
+
+echo "1.  Module load tests"
+echo "1.1.  dynamic allocation of gpio"
+insmod_test "-1,32" 32
+insmod_test "-1,23,-1,32" 23 32
+insmod_test "-1,23,-1,26,-1,32" 23 26 32
+if [ "$full_test" ]; then
+	echo "1.2.  manual allocation of gpio"
+	insmod_test "0,32" 32
+	insmod_test "0,32,32,60" 32 28
+	insmod_test "0,32,40,64,64,96" 32 24 32
+	echo "1.3.  dynamic and manual allocation of gpio"
+	insmod_test "-1,32,32,62" 32 30
+	insmod_test "-1,22,-1,23,0,24,32,64" 22 23 24 32
+	insmod_test "-1,32,32,60,-1,29" 32 28 29
+	insmod_test "-1,32,40,64,-1,5" 32 24 5
+	insmod_test "0,32,32,44,-1,22,-1,31" 32 12 22 31
 fi
-echo "3.  Error test: successful means insert gpiochip failed"
-echo "3.1 Test number of gpio overflow"
-#Currently: The max number of gpio(1024) is defined in arm architecture.
-gpio_test "-1,32,-1,1024" false
-if [ X$full_test = Xtrue ]; then
-	echo "3.2 Test zero line of gpio"
-	gpio_test "0,0" false
-	echo "3.3 Test range overlap"
-	echo "3.3.1 Test corner case"
-	gpio_test "0,32,0,1" false
-	gpio_test "0,32,32,64,32,40" false
-	gpio_test "0,32,35,64,35,45" false
-	gpio_test "0,32,31,32" false
-	gpio_test "0,32,32,64,36,37" false
-	gpio_test "0,32,35,64,34,36" false
-	echo "3.3.2 Test inserting invalid second gpiochip"
-	gpio_test "0,32,30,35" false
-	gpio_test "0,32,1,5" false
-	gpio_test "10,32,9,14" false
-	gpio_test "10,32,30,35" false
-	echo "3.3.3 Test others"
-	gpio_test "0,32,40,56,39,45" false
-	gpio_test "0,32,40,56,30,33" false
-	gpio_test "0,32,40,56,30,41" false
-	gpio_test "0,32,40,56,20,21" false
+echo "2.  Module load error tests"
+echo "2.1 gpio overflow"
+# Currently: The max number of gpio(1024) is defined in arm architecture.
+insmod_test "-1,1024"
+if [ "$full_test" ]; then
+	echo "2.2 no lines defined"
+	insmod_test "0,0"
+	echo "2.3 ignore range overlap"
+	insmod_test "0,32,0,1" 32
+	insmod_test "0,32,1,5" 32
+	insmod_test "0,32,30,35" 32
+	insmod_test "0,32,31,32" 32
+	insmod_test "10,32,30,35" 22
+	insmod_test "10,32,9,14" 22
+	insmod_test "0,32,20,21,40,56" 32 16
+	insmod_test "0,32,32,64,32,40" 32 32
+	insmod_test "0,32,32,64,36,37" 32 32
+	insmod_test "0,32,35,64,34,36" 32 29
+	insmod_test "0,30,35,64,35,45" 30 29
+	insmod_test "0,32,40,56,30,33" 32 16
+	insmod_test "0,32,40,56,30,41" 32 16
+	insmod_test "0,32,40,56,39,45" 32 16
 fi
 
-echo GPIO test PASS
-
+echo "GPIO $module test PASS"
-- 
2.30.0

