Return-Path: <linux-kselftest+bounces-49115-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79424D2DD9F
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 09:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F61E30638B2
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 08:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668232F744A;
	Fri, 16 Jan 2026 08:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5vO8CVT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423372F1FED;
	Fri, 16 Jan 2026 08:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768551103; cv=none; b=MOG/z3CnX+5L7U+NS+xlSH/eTvVsmzadZoZ63y7B56thRZVIu9ywkjXOdHVeqJCHCDGJ1Knws/quKETdJrG0vxAWLOinrCmSZNNsTnrEcwLKlG0YfpUCtJahbiwx7ceFRlgvCTtngoRFSBqjDT1QQHmQFYAXVs31vYcIc/PGBmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768551103; c=relaxed/simple;
	bh=lWQInDyziXUi4zeNG7ZJFumjbZjMF0Beksl/rO//Wi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qy269R+2xDG38DTEtWryo+KyuAgOArdPcED3SxNqvzH8I97JaFwuT68MsAppxBjBi7QJEYMcOHEulsiYoPICNeCK/+ASl9MLQvcmrqkp4xqxlECAvP/IT4hvSENDS4eblp4RR/8NhsoCUckg+pLWLk+g9ncY86y2gaH20aRnSBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5vO8CVT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40662C19423;
	Fri, 16 Jan 2026 08:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768551100;
	bh=lWQInDyziXUi4zeNG7ZJFumjbZjMF0Beksl/rO//Wi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M5vO8CVT+I1KGv/dYG+N0sHlMo4UI0TtCcFj2OR9N9U+svwxVgtPZSTLZ/ElRR6JJ
	 eJRjZ+vJfWaulSznSnD+iexgyEQ+OrykrQwEB4RE5bifQruO832tF3tfrgn9oBy0Lm
	 M7QUaPKKul0AQdl8oj0pwxy8fSid0yRJM3Vao3MJ0tLPf8cgWvhOuwF/gPaoeqS15Z
	 0xFBxqNzgpfY+8ZsBHTCePhCRPC90J8WVz9IBAmgMYqQM92QCJlgB2u6UR+I56kx17
	 i1pGm8Vqs6fvZSu/erzxcQuIzX0aimJit9aLGVrlU55Ve4bnT54Tg+O9EAwoUIrUAC
	 S0SdS8ECBwh3A==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linusw@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	tzungbi@kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	linux-gpio@vger.kernel.org
Subject: [PATCH 11/23] selftests: gpio: Add gpio-cdev-uaf tests
Date: Fri, 16 Jan 2026 08:10:24 +0000
Message-ID: <20260116081036.352286-12-tzungbi@kernel.org>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
In-Reply-To: <20260116081036.352286-1-tzungbi@kernel.org>
References: <20260116081036.352286-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for gpiolib-cdev to make sure accessing to dangling resources
via the opening FD won't crash the system after the underlying resource
providers have gone.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 tools/testing/selftests/gpio/Makefile         |   5 +-
 tools/testing/selftests/gpio/gpio-cdev-uaf.c  | 320 ++++++++++++++++++
 tools/testing/selftests/gpio/gpio-cdev-uaf.sh |  67 ++++
 3 files changed, 390 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/gpio/gpio-cdev-uaf.c
 create mode 100755 tools/testing/selftests/gpio/gpio-cdev-uaf.sh

diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
index 7bfe315f7001..741ab21e1260 100644
--- a/tools/testing/selftests/gpio/Makefile
+++ b/tools/testing/selftests/gpio/Makefile
@@ -1,8 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 
-TEST_PROGS := gpio-mockup.sh gpio-sim.sh gpio-aggregator.sh
+TEST_PROGS := gpio-mockup.sh gpio-sim.sh gpio-aggregator.sh gpio-cdev-uaf.sh
 TEST_FILES := gpio-mockup-sysfs.sh
-TEST_GEN_PROGS_EXTENDED := gpio-mockup-cdev gpio-chip-info gpio-line-name
+TEST_GEN_PROGS_EXTENDED := gpio-mockup-cdev gpio-chip-info gpio-line-name \
+			   gpio-cdev-uaf
 CFLAGS += -O2 -g -Wall $(KHDR_INCLUDES)
 
 include ../lib.mk
diff --git a/tools/testing/selftests/gpio/gpio-cdev-uaf.c b/tools/testing/selftests/gpio/gpio-cdev-uaf.c
new file mode 100644
index 000000000000..28c651998279
--- /dev/null
+++ b/tools/testing/selftests/gpio/gpio-cdev-uaf.c
@@ -0,0 +1,320 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * GPIO character device helper for UAF tests.
+ *
+ * Copyright 2026 Google LLC
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/gpio.h>
+#include <poll.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#define CONFIGFS_DIR "/sys/kernel/config/gpio-sim"
+#define PROCFS_DIR "/proc"
+
+static void print_usage(void)
+{
+	printf("usage:\n");
+	printf("  gpio-cdev-uaf [chip|handle|event|req] "
+	       "[poll|read|ioctl|fdinfo]\n");
+}
+
+static int _create_chip(const char *name, int create)
+{
+	char path[64];
+
+	snprintf(path, sizeof(path), CONFIGFS_DIR "/%s", name);
+
+	if (create)
+		return mkdir(path, 0755);
+	else
+		return rmdir(path);
+}
+
+static int create_chip(const char *name)
+{
+	return _create_chip(name, 1);
+}
+
+static void remove_chip(const char *name)
+{
+	_create_chip(name, 0);
+}
+
+static int _create_bank(const char *chip_name, const char *name, int create)
+{
+	char path[64];
+
+	snprintf(path, sizeof(path), CONFIGFS_DIR "/%s/%s", chip_name, name);
+
+	if (create)
+		return mkdir(path, 0755);
+	else
+		return rmdir(path);
+}
+
+static int create_bank(const char *chip_name, const char *name)
+{
+	return _create_bank(chip_name, name, 1);
+}
+
+static void remove_bank(const char *chip_name, const char *name)
+{
+	_create_bank(chip_name, name, 0);
+}
+
+static int _enable_chip(const char *name, int enable)
+{
+	char path[64];
+	int fd, ret;
+
+	snprintf(path, sizeof(path), CONFIGFS_DIR "/%s/live", name);
+
+	fd = open(path, O_WRONLY);
+	if (fd == -1)
+		return fd;
+
+	if (enable)
+		ret = write(fd, "1", 1);
+	else
+		ret = write(fd, "0", 1);
+
+	close(fd);
+	return ret == 1 ? 0 : -1;
+}
+
+static int enable_chip(const char *name)
+{
+	return _enable_chip(name, 1);
+}
+
+static void disable_chip(const char *name)
+{
+	_enable_chip(name, 0);
+}
+
+static int open_chip(const char *chip_name, const char *bank_name)
+{
+	char path[64], dev_name[32];
+	int ret, fd;
+
+	ret = create_chip(chip_name);
+	if (ret) {
+		fprintf(stderr, "failed to create chip\n");
+		return ret;
+	}
+
+	ret = create_bank(chip_name, bank_name);
+	if (ret) {
+		fprintf(stderr, "failed to create bank\n");
+		goto err_remove_chip;
+	}
+
+	ret = enable_chip(chip_name);
+	if (ret) {
+		fprintf(stderr, "failed to enable chip\n");
+		goto err_remove_bank;
+	}
+
+	snprintf(path, sizeof(path), CONFIGFS_DIR "/%s/%s/chip_name",
+		 chip_name, bank_name);
+
+	fd = open(path, O_RDONLY);
+	if (fd == -1) {
+		ret = fd;
+		fprintf(stderr, "failed to open %s\n", path);
+		goto err_disable_chip;
+	}
+
+	ret = read(fd, dev_name, sizeof(dev_name) - 1);
+	close(fd);
+	if (ret == -1) {
+		fprintf(stderr, "failed to read %s\n", path);
+		goto err_disable_chip;
+	}
+	dev_name[ret] = '\0';
+	if (ret && dev_name[ret - 1] == '\n')
+		dev_name[ret - 1] = '\0';
+
+	snprintf(path, sizeof(path), "/dev/%s", dev_name);
+
+	fd = open(path, O_RDWR);
+	if (fd == -1) {
+		ret = fd;
+		fprintf(stderr, "failed to open %s\n", path);
+		goto err_disable_chip;
+	}
+
+	return fd;
+err_disable_chip:
+	disable_chip(chip_name);
+err_remove_bank:
+	remove_bank(chip_name, bank_name);
+err_remove_chip:
+	remove_chip(chip_name);
+	return ret;
+}
+
+static void close_chip(const char *chip_name, const char *bank_name)
+{
+	disable_chip(chip_name);
+	remove_bank(chip_name, bank_name);
+	remove_chip(chip_name);
+}
+
+static int test_poll(int fd)
+{
+	struct pollfd pfds;
+
+	pfds.fd = fd;
+	pfds.events = POLLIN;
+	pfds.revents = 0;
+
+	if (poll(&pfds, 1, 0) == -1)
+		return -1;
+
+	return (pfds.revents & ~(POLLHUP | POLLERR)) ? -1 : 0;
+}
+
+static int test_read(int fd)
+{
+	char data;
+
+	if (read(fd, &data, 1) == -1 && errno == ENODEV)
+		return 0;
+	return -1;
+}
+
+static int test_ioctl(int fd)
+{
+	if (ioctl(fd, 0, NULL) == -1 && errno == ENODEV)
+		return 0;
+	return -1;
+}
+
+static int test_fdinfo(int fd)
+{
+	char path[64], fdinfo[128];
+	int pfd, ret;
+
+	snprintf(path, sizeof(path), PROCFS_DIR "/%d/fdinfo/%d", getpid(), fd);
+
+	pfd = open(path, O_RDONLY);
+	if (pfd == -1)
+		return -1;
+
+	ret = read(pfd, fdinfo, sizeof(fdinfo));
+	close(pfd);
+	if (ret == -1)
+		return -1;
+
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	int cfd, fd, ret;
+	int (*test_func)(int);
+
+	if (argc != 3) {
+		print_usage();
+		return EXIT_FAILURE;
+	}
+
+	if (strcmp(argv[1], "chip") == 0 || strcmp(argv[1], "event") == 0) {
+		if (strcmp(argv[2], "poll") &&
+		    strcmp(argv[2], "read") &&
+		    strcmp(argv[2], "ioctl")) {
+			fprintf(stderr, "unknown command: %s\n", argv[2]);
+			return EXIT_FAILURE;
+		}
+	} else if (strcmp(argv[1], "req") == 0) {
+		if (strcmp(argv[2], "poll") &&
+		    strcmp(argv[2], "read") &&
+		    strcmp(argv[2], "ioctl") &&
+		    strcmp(argv[2], "fdinfo")) {
+			fprintf(stderr, "unknown command: %s\n", argv[2]);
+			return EXIT_FAILURE;
+		}
+	} else if (strcmp(argv[1], "handle") == 0) {
+		if (strcmp(argv[2], "ioctl")) {
+			fprintf(stderr, "unknown command: %s\n", argv[2]);
+			return EXIT_FAILURE;
+		}
+	} else {
+		fprintf(stderr, "unknown command: %s\n", argv[1]);
+		return EXIT_FAILURE;
+	}
+
+	if (strcmp(argv[2], "poll") == 0)
+		test_func = test_poll;
+	else if (strcmp(argv[2], "read") == 0)
+		test_func = test_read;
+	else if (strcmp(argv[2], "ioctl") == 0)
+		test_func = test_ioctl;
+	else	/* strcmp(argv[2], "fdinfo") == 0 */
+		test_func = test_fdinfo;
+
+	cfd = open_chip("chip", "bank");
+	if (cfd == -1) {
+		fprintf(stderr, "failed to open chip\n");
+		return EXIT_FAILURE;
+	}
+
+	/* Step 1: Hold a FD to the test target. */
+	if (strcmp(argv[1], "chip") == 0) {
+		fd = cfd;
+	} else if (strcmp(argv[1], "handle") == 0) {
+		struct gpiohandle_request req = {0};
+
+		req.lines = 1;
+		if (ioctl(cfd, GPIO_GET_LINEHANDLE_IOCTL, &req) == -1) {
+			fprintf(stderr, "failed to get handle FD\n");
+			goto err_close_chip;
+		}
+
+		close(cfd);
+		fd = req.fd;
+	} else if (strcmp(argv[1], "event") == 0) {
+		struct gpioevent_request req = {0};
+
+		if (ioctl(cfd, GPIO_GET_LINEEVENT_IOCTL, &req) == -1) {
+			fprintf(stderr, "failed to get event FD\n");
+			goto err_close_chip;
+		}
+
+		close(cfd);
+		fd = req.fd;
+	} else {	/* strcmp(argv[1], "req") == 0 */
+		struct gpio_v2_line_request req = {0};
+
+		req.num_lines = 1;
+		if (ioctl(cfd, GPIO_V2_GET_LINE_IOCTL, &req) == -1) {
+			fprintf(stderr, "failed to get req FD\n");
+			goto err_close_chip;
+		}
+
+		close(cfd);
+		fd = req.fd;
+	}
+
+	/* Step 2: Free the chip. */
+	close_chip("chip", "bank");
+
+	/* Step 3: Access the dangling FD to trigger UAF. */
+	ret = test_func(fd);
+	close(fd);
+	return ret ? EXIT_FAILURE : EXIT_SUCCESS;
+err_close_chip:
+	close(cfd);
+	close_chip("chip", "bank");
+	return EXIT_FAILURE;
+}
diff --git a/tools/testing/selftests/gpio/gpio-cdev-uaf.sh b/tools/testing/selftests/gpio/gpio-cdev-uaf.sh
new file mode 100755
index 000000000000..910bcdb14841
--- /dev/null
+++ b/tools/testing/selftests/gpio/gpio-cdev-uaf.sh
@@ -0,0 +1,67 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2026 Google LLC
+
+BASE_DIR=`dirname $0`
+MODULE="gpio-cdev-uaf"
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
+# Load the gpio-sim module. This will pull in configfs if needed too.
+modprobe gpio-sim || skip "unable to load the gpio-sim module"
+# Make sure configfs is mounted at /sys/kernel/config. Wait a bit if needed.
+for _ in `seq 5`; do
+	mountpoint -q /sys/kernel/config && break
+	mount -t configfs none /sys/kernel/config
+	sleep 0.1
+done
+mountpoint -q /sys/kernel/config || \
+	skip "configfs not mounted at /sys/kernel/config"
+
+echo "1. GPIO"
+
+echo "1.1. poll"
+$BASE_DIR/gpio-cdev-uaf chip poll || fail "failed to test chip poll"
+echo "1.2. read"
+$BASE_DIR/gpio-cdev-uaf chip read || fail "failed to test chip read"
+echo "1.3. ioctl"
+$BASE_DIR/gpio-cdev-uaf chip ioctl || fail "failed to test chip ioctl"
+
+echo "2. linehandle"
+
+echo "2.1. ioctl"
+$BASE_DIR/gpio-cdev-uaf handle ioctl || fail "failed to test handle ioctl"
+
+echo "3. lineevent"
+
+echo "3.1. read"
+$BASE_DIR/gpio-cdev-uaf event read || fail "failed to test event read"
+echo "3.2. poll"
+$BASE_DIR/gpio-cdev-uaf event poll || fail "failed to test event poll"
+echo "3.3. ioctl"
+$BASE_DIR/gpio-cdev-uaf event ioctl || fail "failed to test event ioctl"
+
+echo "4. linereq"
+
+echo "4.1. read"
+$BASE_DIR/gpio-cdev-uaf req read || fail "failed to test req read"
+echo "4.2. poll"
+$BASE_DIR/gpio-cdev-uaf req poll || fail "failed to test req poll"
+echo "4.3. ioctl"
+$BASE_DIR/gpio-cdev-uaf req ioctl || fail "failed to test req ioctl"
+echo "4.4. fdinfo"
+if mountpoint -q /proc; then
+	$BASE_DIR/gpio-cdev-uaf req fdinfo || fail "failed to test req fdinfo"
+fi
+
+echo "GPIO $MODULE test PASS"
-- 
2.52.0.457.g6b5491de43-goog


