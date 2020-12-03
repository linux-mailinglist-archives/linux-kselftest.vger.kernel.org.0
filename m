Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82DE2CE1D2
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Dec 2020 23:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731919AbgLCWec (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Dec 2020 17:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731909AbgLCWe3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Dec 2020 17:34:29 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35ABDC09424B
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Dec 2020 14:32:32 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id n7so2308946pgg.2
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Dec 2020 14:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=oIMlBnB15JVo5GvJtYOEjnoSMHizrpybMOv5lys41nw=;
        b=wMe5VvfF5acd4U/J42MRxAWyGBynt3IN4/CeVj8vsMQNIeUiNzCDweFMZUDVazkVME
         UKIxOdRqH859A96aWpy13kHBZVX4RGAF1GS4w5yzy9vOP1wiQfIuY2gds7nB5RhARdQv
         oCdO3ysOlUY/TGOjQyutqicGezgEQrqUsx+veg3wfkqa4hf0Wbfd21F6pdqqeHnIfiay
         e4vXtHXAGgWvCwT36C7167/tqANmibsaOJtc1tCoQZmCs11OQdQsObhAJ988rvdBioV6
         lr7f7oqyrwqyMy98byHyepUV4uANk29LzjMHzWp7GhOjHbvqWbHz/IaSnPuIXeEf3zh7
         hKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=oIMlBnB15JVo5GvJtYOEjnoSMHizrpybMOv5lys41nw=;
        b=p9KTRRj+7NrNuK1ldeG/MF7L9HKiMtNJi+KIIbTzyCmRDHkDulyXqF6iBFDVUvdTCs
         IQEoAFP/HNam5hSg6DMGXHEgCFX/8m93CB7fXMmJFel/aqubLcWs8pZNyPhcfWcDwgZu
         tLGacBk4F4289aaTOQXa5b8AJhBJhO1uYrQqyjc20UpZJRH4gvYurD/SwKO9mJuBrzhx
         dv3AcOSYPgP/fVs8tku5fBVFZ75/UuDe2INYcnY/jYbohFmWvWydOmAXSuFozzxJtZ/a
         4ngPgqnUaC9gfwD6Ab8oEYZimOuJuxjnyCKOfZSDhg8vL3PXGC3++lSbP7nZ2EmMF9sR
         8GGw==
X-Gm-Message-State: AOAM5303NSSUiDNRFSTax/syQb6ZslqfrXTq2umAgPSt7Q+myoLqB1rR
        Bm0j9uRJh2Cx1BA5TsQ1JRch3Q==
X-Google-Smtp-Source: ABdhPJza/ryMS859XzWd8bYQIWub0aqq0ai/rq1L5WfJpINiXZi0oBdW/6g/jNlcAIeujSn6Hsmvow==
X-Received: by 2002:a05:6a00:1506:b029:18b:5a31:ed87 with SMTP id q6-20020a056a001506b029018b5a31ed87mr951347pfu.55.1607034751382;
        Thu, 03 Dec 2020 14:32:31 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id x4sm1879678pgg.94.2020.12.03.14.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 14:32:30 -0800 (PST)
Subject: [PATCH v1 4/5] selftests/dm-user: A handful of tests for dm-user
Date:   Thu,  3 Dec 2020 13:58:58 -0800
Message-Id: <20201203215859.2719888-5-palmer@dabbelt.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201203215859.2719888-1-palmer@dabbelt.com>
References: <20201203215859.2719888-1-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc:     corbet@lwn.net, song@kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>, shuah@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     dm-devel@redhat.com, agk@redhat.com, snitzer@redhat.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

These tests ruly on fsstress and fio to generate accesses to a block
device backed by a dm-user daemon.

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>

---

I've lumped these all together rather than splitting them up.  The tests
themselves are independent, but the associated build/run infastructure
is pretty simple and I got tired of handling all the merge conflicts
that came from juggling each test as its own patch.

The tests themselves sholud be portable, but the harness will only run
in my environment (ie, QEMU).  That's kind of ugly, but I'm not really
sure how to do this in a more reasonable way.  I run the tests as
follows:

    $ rm -f scratch
    $ truncate scratch --size=10G
    $ qemu-system-x86_64 \
            -m 8G -smp 32 -cpu host -accel kvm \
            -kernel "${TREE}"/arch/x86_64/boot/bzImage \
            -initrd buildroot/output/images/rootfs.cpio \
            -append "console=ttyS0" \
            -drive
            file="${TREE}"/tools/testing/selftests/kselftest_install/kselftest-packages/kselftest.squashfs,if=virtio
            \
            -drive
            file=scratch,if=virtio \
            -nographic |&
            tee log
---
 tools/testing/selftests/.gitignore            |   3 +
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/dm-user/.gitignore    |   3 +
 tools/testing/selftests/dm-user/Makefile      |  23 ++
 tools/testing/selftests/dm-user/README        |  20 ++
 .../selftests/dm-user/daemon-example.c        | 186 ++++++++++++++
 .../selftests/dm-user/daemon-parallel.c       | 240 ++++++++++++++++++
 .../testing/selftests/dm-user/daemon-short.c  | 196 ++++++++++++++
 .../selftests/dm-user/fio-rand-read-1G.fio    |  16 ++
 .../selftests/dm-user/fio-verify-1G.fio       |  10 +
 .../testing/selftests/dm-user/harness-fio.sh  |  45 ++++
 .../selftests/dm-user/harness-fsstress.sh     |  44 ++++
 .../selftests/dm-user/include/logging.h       | 148 +++++++++++
 tools/testing/selftests/dm-user/run.sh        |  74 ++++++
 14 files changed, 1009 insertions(+)
 create mode 100644 tools/testing/selftests/dm-user/.gitignore
 create mode 100644 tools/testing/selftests/dm-user/Makefile
 create mode 100644 tools/testing/selftests/dm-user/README
 create mode 100644 tools/testing/selftests/dm-user/daemon-example.c
 create mode 100644 tools/testing/selftests/dm-user/daemon-parallel.c
 create mode 100644 tools/testing/selftests/dm-user/daemon-short.c
 create mode 100644 tools/testing/selftests/dm-user/fio-rand-read-1G.fio
 create mode 100644 tools/testing/selftests/dm-user/fio-verify-1G.fio
 create mode 100755 tools/testing/selftests/dm-user/harness-fio.sh
 create mode 100755 tools/testing/selftests/dm-user/harness-fsstress.sh
 create mode 100644 tools/testing/selftests/dm-user/include/logging.h
 create mode 100755 tools/testing/selftests/dm-user/run.sh

diff --git a/tools/testing/selftests/.gitignore b/tools/testing/selftests/.gitignore
index 055a5019b13c..88b1938ea5e6 100644
--- a/tools/testing/selftests/.gitignore
+++ b/tools/testing/selftests/.gitignore
@@ -8,3 +8,6 @@ tpm2/SpaceTest.log
 # Python bytecode and cache
 __pycache__/
 *.py[cod]
+
+# selftest install dir
+/kselftest_install/
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index d9c283503159..f5e0f61c4384 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -9,6 +9,7 @@ TARGETS += clone3
 TARGETS += core
 TARGETS += cpufreq
 TARGETS += cpu-hotplug
+TARGETS += dm-user
 TARGETS += drivers/dma-buf
 TARGETS += efivarfs
 TARGETS += exec
diff --git a/tools/testing/selftests/dm-user/.gitignore b/tools/testing/selftests/dm-user/.gitignore
new file mode 100644
index 000000000000..7b0aa3e4a738
--- /dev/null
+++ b/tools/testing/selftests/dm-user/.gitignore
@@ -0,0 +1,3 @@
+/daemon-example
+/daemon-parallel
+/daemon-short
diff --git a/tools/testing/selftests/dm-user/Makefile b/tools/testing/selftests/dm-user/Makefile
new file mode 100644
index 000000000000..98ff4f5d0fad
--- /dev/null
+++ b/tools/testing/selftests/dm-user/Makefile
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0
+.PHONY: all clean
+
+top_srcdir = ../../../..
+INCLUDES := -I../ -Iinclude/ -I$(top_srcdir)/usr/include
+CFLAGS := $(CFLAGS) -g -O2 -Wall -static -D_GNU_SOURCE -pthread $(INCLUDES)
+KSFT_KHDR_INSTALL := 1
+
+TEST_GEN_FILES := \
+	daemon-example \
+	daemon-parallel \
+	daemon-short
+
+TEST_PROGS := \
+	fio-rand-read-1G.fio \
+	fio-verify-1G.fio \
+	harness-fio.sh \
+	harness-fsstress.sh \
+	run.sh
+
+$(TEST_GEN_FILES): khdr
+
+include ../lib.mk
diff --git a/tools/testing/selftests/dm-user/README b/tools/testing/selftests/dm-user/README
new file mode 100644
index 000000000000..213de27db35d
--- /dev/null
+++ b/tools/testing/selftests/dm-user/README
@@ -0,0 +1,20 @@
+dm-user Tests
+=============
+Tests for dm-user.
+
+Quick Start
+-----------
+It's probably a bad idea to just run this blindly, but all you need to do is:
+
+# make
+# ./run.sh
+
+Slow Start
+----------
+These tests use `dmsetup` to manage device mapper nodes, which is part of lvm2.
+Some use `fio`, and some use the `fsstress` from xfstests.  Some of the tests
+also expect "/dev/vdb" to exist and to be at least 10G.
+
+I use a simple buildroot-based initramfs to run the tests.  I've added an
+xfstests package to get fsstress, but I haven't sent out the patches yet.  I
+run everything in QEMU.
diff --git a/tools/testing/selftests/dm-user/daemon-example.c b/tools/testing/selftests/dm-user/daemon-example.c
new file mode 100644
index 000000000000..b245fad192bf
--- /dev/null
+++ b/tools/testing/selftests/dm-user/daemon-example.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2020 Google, Inc
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <getopt.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <poll.h>
+#include <pthread.h>
+#include <linux/dm-user.h>
+#include <sys/prctl.h>
+#include "logging.h"
+
+#define SECTOR_SIZE 512
+
+#define MAX(a, b) ((a) > (b) ? (a) : (b))
+
+int write_all(int fd, void *buf, size_t len)
+{
+	char *buf_c = buf;
+	ssize_t total = 0;
+	ssize_t once;
+
+	while (total < len) {
+		once = write(fd, buf_c + total, len - total);
+		if (once <= 0)
+			return once;
+		total += once;
+	}
+
+	return total;
+}
+
+int read_all(int fd, void *buf, size_t len)
+{
+	char *buf_c = buf;
+	ssize_t total = 0;
+	ssize_t once;
+
+	while (total < len) {
+		once = read(fd, buf_c + total, len - total);
+		if (once <= 0)
+			return once;
+		total += once;
+	}
+
+	return total;
+}
+
+int simple_daemon(char *control_dev,
+		  size_t block_bytes,
+		  char *store)
+
+{
+	int control_fd = open(control_dev, O_RDWR);
+
+	if (control_fd < 0) {
+		ksft_print_msg("Unable to open control device %s\n", control_dev);
+		return RET_FAIL;
+	}
+
+	while (1) {
+		struct dm_user_message msg;
+		__u64 type;
+		char *base;
+
+		if (read_all(control_fd, &msg, sizeof(msg)) < 0) {
+			if (errno == ENOTBLK)
+				return RET_PASS;
+
+			perror("unable to read msg");
+			return RET_FAIL;
+		}
+
+		base = store + msg.sector * SECTOR_SIZE;
+		if (base + msg.len > store + block_bytes) {
+			fprintf(stderr, "access out of bounds\n");
+			return RET_FAIL;
+		}
+
+		type = msg.type;
+		switch (type) {
+		case DM_USER_REQ_MAP_WRITE:
+			msg.type = DM_USER_RESP_SUCCESS;
+			if (read_all(control_fd, base, msg.len) < 0) {
+				if (errno == ENOTBLK)
+					return RET_PASS;
+
+				perror("unable to read buf");
+				return RET_FAIL;
+			}
+			break;
+		case DM_USER_REQ_MAP_FLUSH:
+			/* Nothing extra to do on flush, we're in memory. */
+		case DM_USER_REQ_MAP_READ:
+			msg.type = DM_USER_RESP_SUCCESS;
+			break;
+		default:
+			msg.type = DM_USER_RESP_UNSUPPORTED;
+			break;
+		}
+
+		if (write_all(control_fd, &msg, sizeof(msg)) < 0) {
+			if (errno == ENOTBLK)
+				return RET_PASS;
+
+			perror("unable to write msg");
+			return RET_FAIL;
+		}
+
+		if (type == DM_USER_REQ_MAP_READ) {
+			if (write_all(control_fd, base, msg.len) < 0) {
+				if (errno == ENOTBLK)
+					return RET_PASS;
+
+				perror("unable to write buf");
+				return RET_FAIL;
+			}
+		}
+	}
+
+	/* The daemon doesn't actully terminate for this test. */
+	perror("Unable to read from control device");
+	return RET_FAIL;
+}
+
+void usage(char *prog)
+{
+	printf("Usage: %s\n", prog);
+	printf("  -h			Display this help message\n");
+	printf("  -v L			Verbosity level: %d=QUIET %d=CRITICAL %d=INFO\n",
+	       VQUIET, VCRITICAL, VINFO);
+	printf("  -c <control dev>	Control device to use for the test\n");
+	printf("  -s <sectors>		The number of sectors in the device\n");
+}
+
+int main(int argc, char *argv[])
+{
+	int ret = RET_PASS;
+	int c;
+	char *control_dev = NULL;
+	long block_bytes = 1024;
+	char *store;
+
+	prctl(PR_SET_IO_FLUSHER, 0, 0, 0, 0);
+
+	while ((c = getopt(argc, argv, "h:v:c:s:")) != -1) {
+		switch (c) {
+		case 'h':
+			usage(basename(argv[0]));
+			exit(0);
+		case 'v':
+			log_verbosity(atoi(optarg));
+			break;
+		case 'c':
+			control_dev = strdup(optarg);
+			break;
+		case 's':
+			block_bytes = atoi(optarg) * SECTOR_SIZE;
+			break;
+		default:
+			usage(basename(argv[0]));
+			exit(1);
+		}
+	}
+
+	ksft_print_header();
+	ksft_set_plan(1);
+	ksft_print_msg("%s: block_bytes=%zu\n",
+		       basename(argv[0]),
+		       block_bytes);
+
+	store = malloc(block_bytes);
+	for (size_t i = 0; i < block_bytes/sizeof(size_t); ++i)
+		((size_t *)(store))[i] = i;
+
+	ret = simple_daemon(control_dev, block_bytes, store);
+
+	print_result(basename(argv[0]), ret);
+	exit(ret);
+	return ret;
+}
diff --git a/tools/testing/selftests/dm-user/daemon-parallel.c b/tools/testing/selftests/dm-user/daemon-parallel.c
new file mode 100644
index 000000000000..9e5303f02241
--- /dev/null
+++ b/tools/testing/selftests/dm-user/daemon-parallel.c
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2020 Google, Inc
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <getopt.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <poll.h>
+#include <pthread.h>
+#include <linux/dm-user.h>
+#include <sys/prctl.h>
+#include <sys/mman.h>
+#include "logging.h"
+
+#define SECTOR_SIZE 512
+#define MAX_WORKER_COUNT 256
+
+#define MAX(a, b) ((a) > (b) ? (a) : (b))
+
+struct test_context {
+	char *control_dev;
+	size_t block_bytes;
+	char *store;
+	long worker_count;
+	char *backing_path;
+};
+
+int write_all(int fd, void *buf, size_t len)
+{
+	char *buf_c = buf;
+	ssize_t total = 0;
+	ssize_t once;
+
+	while (total < len) {
+		once = write(fd, buf_c + total, len - total);
+		if (once <= 0)
+			return once;
+		total += once;
+	}
+
+	return total;
+}
+
+int read_all(int fd, void *buf, size_t len)
+{
+	char *buf_c = buf;
+	ssize_t total = 0;
+	ssize_t once;
+
+	while (total < len) {
+		once = read(fd, buf_c + total, len - total);
+		if (once <= 0)
+			return once;
+		total += once;
+	}
+
+	return total;
+}
+
+void *simple_daemon(void *context_uc)
+{
+	struct test_context *context = context_uc;
+	char *store = context->store;
+	int control_fd = open(context->control_dev, O_RDWR);
+
+	if (control_fd < 0) {
+		ksft_print_msg("Unable to open control device %s\n", context->control_dev);
+		return (void *)(RET_FAIL);
+	}
+
+	while (1) {
+		struct dm_user_message msg;
+		__u64 type;
+		char *base;
+
+		if (read_all(control_fd, &msg, sizeof(msg)) < 0) {
+			if (errno == ENOTBLK)
+				return (void *)(RET_PASS);
+
+			perror("unable to read msg");
+			return (void *)(RET_FAIL);
+		}
+
+		base = store + msg.sector * SECTOR_SIZE;
+		if (base + msg.len > store + context->block_bytes) {
+			fprintf(stderr, "access out of bounds\n");
+			return (void *)(RET_FAIL);
+		}
+
+		type = msg.type;
+		switch (type) {
+		case DM_USER_REQ_MAP_READ:
+			msg.type = DM_USER_RESP_SUCCESS;
+			break;
+		case DM_USER_REQ_MAP_WRITE:
+			msg.type = DM_USER_RESP_SUCCESS;
+			if (read_all(control_fd, base, msg.len) < 0) {
+				if (errno == ENOTBLK)
+					return (void *)(RET_PASS);
+
+				perror("unable to read buf");
+				return (void *)(RET_FAIL);
+			}
+			break;
+		case DM_USER_REQ_MAP_FLUSH:
+			msg.type = DM_USER_RESP_SUCCESS;
+			sync();
+			break;
+		default:
+			msg.type = DM_USER_RESP_UNSUPPORTED;
+			break;
+		}
+
+		if (write_all(control_fd, &msg, sizeof(msg)) < 0) {
+			if (errno == ENOTBLK)
+				return (void *)(RET_PASS);
+
+			perror("unable to write msg");
+			return (void *)(RET_FAIL);
+		}
+
+		if (type == DM_USER_REQ_MAP_READ) {
+			if (write_all(control_fd, base, msg.len) < 0) {
+				if (errno == ENOTBLK)
+					return (void *)(RET_PASS);
+
+				perror("unable to write buf");
+				return (void *)(RET_FAIL);
+			}
+		}
+	}
+
+	/* The daemon doesn't actully terminate for this test. */
+	perror("Unable to read from control device");
+	return (void *)(RET_FAIL);
+}
+
+void usage(char *prog)
+{
+	printf("Usage: %s\n", prog);
+	printf("  -h			Display this help message\n");
+	printf("  -v L			Verbosity level: %d=QUIET %d=CRITICAL %d=INFO\n",
+	       VQUIET, VCRITICAL, VINFO);
+	printf("  -c <control dev>	Control device to use for the test\n");
+	printf("  -s <sectors>		The number of sectors in the device\n");
+}
+
+int main(int argc, char *argv[])
+{
+	int ret = RET_PASS;
+	int done = 0;
+	int c;
+	struct test_context context = {
+		.control_dev	= NULL,
+		.block_bytes	= 0,
+		.worker_count   = 1,
+		.backing_path   = NULL,
+	};
+	pthread_t daemon[MAX_WORKER_COUNT];
+	void *pthread_ret;
+
+	prctl(PR_SET_IO_FLUSHER, 0, 0, 0, 0);
+
+	while ((c = getopt(argc, argv, "h:v:c:s:w:b:")) != -1) {
+		switch (c) {
+		case 'h':
+			usage(basename(argv[0]));
+			exit(0);
+		case 'v':
+			log_verbosity(atoi(optarg));
+			break;
+		case 'c':
+			context.control_dev = strdup(optarg);
+			break;
+		case 's':
+			context.block_bytes = atoi(optarg) * SECTOR_SIZE;
+			break;
+		case 'w':
+			context.worker_count = atoi(optarg);
+			break;
+		case 'b':
+			context.backing_path = strdup(optarg);
+			break;
+		default:
+			usage(basename(argv[0]));
+			exit(1);
+		}
+	}
+
+	ksft_print_header();
+	ksft_set_plan(1);
+	ksft_print_msg("%s: block_bytes=%zu\n",
+		       basename(argv[0]),
+		       context.block_bytes);
+
+	ret = RET_PASS;
+
+	if (context.backing_path == NULL) {
+		ksft_print_msg("Using an in-memory backing store\n");
+		context.store = malloc(context.block_bytes);
+		for (size_t i = 0; i < context.block_bytes/sizeof(size_t); ++i)
+			((size_t *)(context.store))[i] = i;
+	} else {
+		int backing_fd = open(context.backing_path, O_RDWR);
+
+		ksft_print_msg("Using %s as a backing store\n", context.backing_path);
+		if (backing_fd < 0) {
+			perror("Unable to open backing store");
+			ksft_print_msg("Unable to open backing store %s\n", context.backing_path);
+			return RET_FAIL;
+		}
+
+		context.store = mmap(NULL, context.block_bytes,
+				     PROT_READ | PROT_WRITE, MAP_SHARED,
+				     backing_fd, 0);
+	}
+
+	for (size_t i = 0; i < context.worker_count; ++i)
+		if (pthread_create(&daemon[i], NULL, &simple_daemon, &context) < 0)
+			ret = RET_ERROR;
+
+	while (!done)  {
+		for (size_t i = 0; i < context.worker_count; ++i) {
+			if (pthread_tryjoin_np(daemon[i], &pthread_ret) == 0) {
+				if (pthread_ret != RET_PASS)
+					ret = RET_ERROR;
+				done = 1;
+			}
+		}
+
+		sleep(1);
+	}
+
+	print_result(basename(argv[0]), ret);
+	exit(ret);
+}
diff --git a/tools/testing/selftests/dm-user/daemon-short.c b/tools/testing/selftests/dm-user/daemon-short.c
new file mode 100644
index 000000000000..40fd114cb390
--- /dev/null
+++ b/tools/testing/selftests/dm-user/daemon-short.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2020 Google, Inc
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <getopt.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <poll.h>
+#include <pthread.h>
+#include <linux/dm-user.h>
+#include <sys/prctl.h>
+#include "logging.h"
+
+#define SECTOR_SIZE 512
+
+#define MAX(a, b) ((a) > (b) ? (a) : (b))
+
+int write_all(int fd, void *buf, size_t len)
+{
+	char *buf_c = buf;
+	ssize_t total = 0;
+	ssize_t once;
+
+	while (total < len) {
+		size_t max = len - total;
+
+		if (max > 3)
+			max = max / 3;
+
+		once = write(fd, buf_c + total, max);
+		if (once <= 0)
+			return once;
+		total += once;
+	}
+
+	return total;
+}
+
+int read_all(int fd, void *buf, size_t len)
+{
+	char *buf_c = buf;
+	ssize_t total = 0;
+	ssize_t once;
+
+	while (total < len) {
+		size_t max = len - total;
+
+		if (max > 3)
+			max = max / 3;
+
+		once = read(fd, buf_c + total, max);
+		if (once <= 0)
+			return once;
+		total += once;
+	}
+
+	return total;
+}
+
+int simple_daemon(char *control_dev,
+		  size_t block_bytes,
+		  char *store)
+
+{
+	int control_fd = open(control_dev, O_RDWR);
+
+	if (control_fd < 0) {
+		ksft_print_msg("Unable to open control device %s\n", control_dev);
+		return RET_FAIL;
+	}
+
+	while (1) {
+		struct dm_user_message msg;
+		__u64 type;
+		char *base;
+
+		if (read_all(control_fd, &msg, sizeof(msg)) < 0) {
+			if (errno == ENOTBLK)
+				return RET_PASS;
+
+			perror("unable to read msg");
+			return RET_FAIL;
+		}
+
+		base = store + msg.sector * SECTOR_SIZE;
+		if (base + msg.len > store + block_bytes) {
+			fprintf(stderr, "access out of bounds\n");
+			return RET_FAIL;
+		}
+
+		type = msg.type;
+		switch (type) {
+		case DM_USER_REQ_MAP_WRITE:
+			msg.type = DM_USER_RESP_SUCCESS;
+			if (read_all(control_fd, base, msg.len) < 0) {
+				if (errno == ENOTBLK)
+					return RET_PASS;
+
+				perror("unable to read buf");
+				return RET_FAIL;
+			}
+			break;
+		case DM_USER_REQ_MAP_FLUSH:
+			/* Nothing extra to do on flush, we're in memory. */
+		case DM_USER_REQ_MAP_READ:
+			msg.type = DM_USER_RESP_SUCCESS;
+			break;
+		default:
+			msg.type = DM_USER_RESP_UNSUPPORTED;
+			break;
+		}
+
+		if (write_all(control_fd, &msg, sizeof(msg)) < 0) {
+			if (errno == ENOTBLK)
+				return RET_PASS;
+
+			perror("unable to write msg");
+			return RET_FAIL;
+		}
+
+		if (type == DM_USER_REQ_MAP_READ) {
+			if (write_all(control_fd, base, msg.len) < 0) {
+				if (errno == ENOTBLK)
+					return RET_PASS;
+
+				perror("unable to write buf");
+				return RET_FAIL;
+			}
+		}
+	}
+
+	/* The daemon doesn't actully terminate for this test. */
+	perror("Unable to read from control device");
+	return RET_FAIL;
+}
+
+void usage(char *prog)
+{
+	printf("Usage: %s\n", prog);
+	printf("  -h			Display this help message\n");
+	printf("  -v L			Verbosity level: %d=QUIET %d=CRITICAL %d=INFO\n",
+	       VQUIET, VCRITICAL, VINFO);
+	printf("  -c <control dev>	Control device to use for the test\n");
+	printf("  -s <sectors>		The number of sectors in the device\n");
+}
+
+int main(int argc, char *argv[])
+{
+	int ret = RET_PASS;
+	int c;
+	char *control_dev = NULL;
+	long block_bytes = 1024;
+	char *store;
+
+	prctl(PR_SET_IO_FLUSHER, 0, 0, 0, 0);
+
+	while ((c = getopt(argc, argv, "h:v:c:s:")) != -1) {
+		switch (c) {
+		case 'h':
+			usage(basename(argv[0]));
+			exit(0);
+		case 'v':
+			log_verbosity(atoi(optarg));
+			break;
+		case 'c':
+			control_dev = strdup(optarg);
+			break;
+		case 's':
+			block_bytes = atoi(optarg) * SECTOR_SIZE;
+			break;
+		default:
+			usage(basename(argv[0]));
+			exit(1);
+		}
+	}
+
+	ksft_print_header();
+	ksft_set_plan(1);
+	ksft_print_msg("%s: block_bytes=%zu\n",
+		       basename(argv[0]),
+		       block_bytes);
+
+	store = malloc(block_bytes);
+	for (size_t i = 0; i < block_bytes/sizeof(size_t); ++i)
+		((size_t *)(store))[i] = i;
+
+	ret = simple_daemon(control_dev, block_bytes, store);
+
+	print_result(basename(argv[0]), ret);
+	exit(ret);
+	return ret;
+}
diff --git a/tools/testing/selftests/dm-user/fio-rand-read-1G.fio b/tools/testing/selftests/dm-user/fio-rand-read-1G.fio
new file mode 100644
index 000000000000..f971483e0e27
--- /dev/null
+++ b/tools/testing/selftests/dm-user/fio-rand-read-1G.fio
@@ -0,0 +1,16 @@
+; fio-rand-read.job for fiotest
+
+[global]
+name=fio-rand-read-1G
+filename=fio-rand-read-1G
+rw=randread
+bs=4K
+direct=0
+numjobs=1
+time_based=1
+runtime=30
+
+[file1]
+size=1G
+ioengine=io_uring
+iodepth=16
diff --git a/tools/testing/selftests/dm-user/fio-verify-1G.fio b/tools/testing/selftests/dm-user/fio-verify-1G.fio
new file mode 100644
index 000000000000..4b626271ce7c
--- /dev/null
+++ b/tools/testing/selftests/dm-user/fio-verify-1G.fio
@@ -0,0 +1,10 @@
+# The most basic form of data verification. Write the device randomly
+# in 4K chunks, then read it back and verify the contents.
+[write-and-verify]
+rw=randwrite
+bs=4k
+ioengine=libaio
+iodepth=16
+direct=1
+verify=crc32c
+size=1G
diff --git a/tools/testing/selftests/dm-user/harness-fio.sh b/tools/testing/selftests/dm-user/harness-fio.sh
new file mode 100755
index 000000000000..4b95c9f5efd8
--- /dev/null
+++ b/tools/testing/selftests/dm-user/harness-fio.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright 2020 Google, Inc
+
+# Just a fixed size for now, but it's passed to the tests and they're supposed
+# to respect it.
+SIZE=1024
+BLOCK=kselftest-dm-user-block
+CONTROL=kselftest-dm-user-control
+unset FIO
+
+while [ x"$1" != x"--" ]
+do
+    case "$1" in
+    "-s")    SIZE="$2";                             shift 2;;
+    "-f")    FIO="$2";                              shift 2;;
+    *)       echo "$0: unknown argument $1" >&2;    exit  1;;
+    esac
+done
+shift
+
+# Run the benchmark again via dm-user, to see what the overhead is.
+dmsetup create $BLOCK << EOF
+0 $SIZE user 0 $SIZE $CONTROL
+EOF
+
+dmsetup resume $BLOCK
+
+"$@" -s $SIZE -c /dev/dm-user/$CONTROL &
+
+yes | mkfs.ext2 /dev/mapper/$BLOCK
+mount /dev/mapper/$BLOCK /mnt
+cp "$FIO" /mnt/benchmark.fio
+(cd /mnt; fio benchmark.fio)
+umount /mnt
+
+# Mount again and read the whole thing, just to see if there's any corruption.
+mount /dev/mapper/$BLOCK /mnt
+find /mnt -type f | xargs cat > /dev/null
+umount /mnt
+
+dmsetup remove $BLOCK
+
+# Make sure the daemon actually responds to DM closing it.
+wait
diff --git a/tools/testing/selftests/dm-user/harness-fsstress.sh b/tools/testing/selftests/dm-user/harness-fsstress.sh
new file mode 100755
index 000000000000..265c0ff636ca
--- /dev/null
+++ b/tools/testing/selftests/dm-user/harness-fsstress.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright 2020 Google, Inc
+
+BLOCK=kselftest-dm-user-block
+CONTROL=kselftest-dm-user-control
+unset SIZE
+unset NPROC
+unset NOP
+
+while [ x"$1" != x"--" ]
+do
+    case "$1" in
+    "-s")    SIZE="$2";                             shift 2;;
+    "-n")    NOP="$2";                              shift 2;;
+    "-p")    NPROC="$2";                            shift 2;;
+    *)       echo "$0: unknown argument $1" >&2;    exit  1;;
+    esac
+done
+shift
+
+# Runs the fs stress tests
+dmsetup create $BLOCK << EOF
+0 $SIZE user 0 $SIZE $CONTROL
+EOF
+
+dmsetup resume $BLOCK
+
+"$@" -s $SIZE -c /dev/dm-user/$CONTROL &
+
+yes | mkfs.ext2 /dev/mapper/$BLOCK
+mount /dev/mapper/$BLOCK /mnt
+/usr/xfstests/ltp/fsstress -d /mnt/ -n "$NOP" -p "$NPROC"
+umount /mnt
+
+# Mount again and read the whole thing, just to see if there's any corruption.
+mount /dev/mapper/$BLOCK /mnt
+find /mnt -type f | xargs cat > /dev/null
+umount /mnt
+
+dmsetup remove $BLOCK
+
+# Make sure the daemon actually responds to DM closing it.
+wait
diff --git a/tools/testing/selftests/dm-user/include/logging.h b/tools/testing/selftests/dm-user/include/logging.h
new file mode 100644
index 000000000000..874c69ce5cce
--- /dev/null
+++ b/tools/testing/selftests/dm-user/include/logging.h
@@ -0,0 +1,148 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/******************************************************************************
+ *
+ *   Copyright © International Business Machines  Corp., 2009
+ *
+ * DESCRIPTION
+ *      Glibc independent futex library for testing kernel functionality.
+ *
+ * AUTHOR
+ *      Darren Hart <dvhart@linux.intel.com>
+ *
+ * HISTORY
+ *      2009-Nov-6: Initial version by Darren Hart <dvhart@linux.intel.com>
+ *
+ *****************************************************************************/
+
+#ifndef _LOGGING_H
+#define _LOGGING_H
+
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <linux/futex.h>
+#include "kselftest.h"
+
+/*
+ * Define PASS, ERROR, and FAIL strings with and without color escape
+ * sequences, default to no color.
+ */
+#define ESC 0x1B, '['
+#define BRIGHT '1'
+#define GREEN '3', '2'
+#define YELLOW '3', '3'
+#define RED '3', '1'
+#define ESCEND 'm'
+#define BRIGHT_GREEN ESC, BRIGHT, ';', GREEN, ESCEND
+#define BRIGHT_YELLOW ESC, BRIGHT, ';', YELLOW, ESCEND
+#define BRIGHT_RED ESC, BRIGHT, ';', RED, ESCEND
+#define RESET_COLOR ESC, '0', 'm'
+static const char PASS_COLOR[] = {BRIGHT_GREEN, ' ', 'P', 'A', 'S', 'S',
+				  RESET_COLOR, 0};
+static const char ERROR_COLOR[] = {BRIGHT_YELLOW, 'E', 'R', 'R', 'O', 'R',
+				   RESET_COLOR, 0};
+static const char FAIL_COLOR[] = {BRIGHT_RED, ' ', 'F', 'A', 'I', 'L',
+				  RESET_COLOR, 0};
+static const char INFO_NORMAL[] = " INFO";
+static const char PASS_NORMAL[] = " PASS";
+static const char ERROR_NORMAL[] = "ERROR";
+static const char FAIL_NORMAL[] = " FAIL";
+const char *INFO = INFO_NORMAL;
+const char *PASS = PASS_NORMAL;
+const char *ERROR = ERROR_NORMAL;
+const char *FAIL = FAIL_NORMAL;
+
+/* Verbosity setting for INFO messages */
+#define VQUIET    0
+#define VCRITICAL 1
+#define VINFO     2
+#define VMAX      VINFO
+int _verbose = VCRITICAL;
+
+/* Functional test return codes */
+#define RET_PASS   0
+#define RET_ERROR -1
+#define RET_FAIL  -2
+
+/**
+ * log_color() - Use colored output for PASS, ERROR, and FAIL strings
+ * @use_color:	use color (1) or not (0)
+ */
+void log_color(int use_color)
+{
+	if (use_color) {
+		PASS = PASS_COLOR;
+		ERROR = ERROR_COLOR;
+		FAIL = FAIL_COLOR;
+	} else {
+		PASS = PASS_NORMAL;
+		ERROR = ERROR_NORMAL;
+		FAIL = FAIL_NORMAL;
+	}
+}
+
+/**
+ * log_verbosity() - Set verbosity of test output
+ * @verbose:	Enable (1) verbose output or not (0)
+ *
+ * Currently setting verbose=1 will enable INFO messages and 0 will disable
+ * them. FAIL and ERROR messages are always displayed.
+ */
+void log_verbosity(int level)
+{
+	if (level > VMAX)
+		level = VMAX;
+	else if (level < 0)
+		level = 0;
+	_verbose = level;
+}
+
+/**
+ * print_result() - Print standard PASS | ERROR | FAIL results
+ * @ret:	the return value to be considered: 0 | RET_ERROR | RET_FAIL
+ *
+ * print_result() is primarily intended for functional tests.
+ */
+void print_result(const char *test_name, int ret)
+{
+	switch (ret) {
+	case RET_PASS:
+		ksft_test_result_pass("%s\n", test_name);
+		ksft_print_cnts();
+		return;
+	case RET_ERROR:
+		ksft_test_result_error("%s\n", test_name);
+		ksft_print_cnts();
+		return;
+	case RET_FAIL:
+		ksft_test_result_fail("%s\n", test_name);
+		ksft_print_cnts();
+		return;
+	}
+}
+
+/* log level macros */
+#define info(message, vargs...) \
+do { \
+	if (_verbose >= VINFO) \
+		fprintf(stderr, "\t%s: "message, INFO, ##vargs); \
+} while (0)
+
+#define error(message, err, args...) \
+do { \
+	if (_verbose >= VCRITICAL) {\
+		if (err) \
+			fprintf(stderr, "\t%s: %s: "message, \
+				ERROR, strerror(err), ##args); \
+		else \
+			fprintf(stderr, "\t%s: "message, ERROR, ##args); \
+	} \
+} while (0)
+
+#define fail(message, args...) \
+do { \
+	if (_verbose >= VCRITICAL) \
+		fprintf(stderr, "\t%s: "message, FAIL, ##args); \
+} while (0)
+
+#endif
diff --git a/tools/testing/selftests/dm-user/run.sh b/tools/testing/selftests/dm-user/run.sh
new file mode 100755
index 000000000000..2ed2581e4a57
--- /dev/null
+++ b/tools/testing/selftests/dm-user/run.sh
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2020 Palmer Dabbelt <palmerdabbelt@google.com>
+
+# Top-level run script for dm-user kernel self tests.  This just runs a bunch
+# of different tests back to back, relying on the kernel selftest infrastructure
+# to tease out the success/failure of each.  The tests all use the same global
+# directories and such, so it's not like there's a whole lot
+#
+# The actual test code should be fairly portable, but the scripts that run it
+# aren't.  See the README for more information.
+
+# Runs various FIO scripts against an ext2-based filesystem backed by dm-user.
+if test -e /usr/bin/fio
+then
+    ./harness-fio.sh      -s 3000000 -f fio-rand-read-1G.fio -- ./daemon-example
+    ./harness-fio.sh      -s 3000000 -f fio-rand-read-1G.fio -- ./daemon-short
+    ./harness-fio.sh      -s 3000000 -f fio-rand-read-1G.fio -- ./daemon-parallel -w   1
+    ./harness-fio.sh      -s 3000000 -f fio-rand-read-1G.fio -- ./daemon-parallel -w   4
+    ./harness-fio.sh      -s 3000000 -f fio-rand-read-1G.fio -- ./daemon-parallel -w  16
+    ./harness-fio.sh      -s 3000000 -f fio-rand-read-1G.fio -- ./daemon-parallel -w  64
+    ./harness-fio.sh      -s 3000000 -f fio-rand-read-1G.fio -- ./daemon-parallel -w 256
+    ./harness-fio.sh      -s 3000000 -f fio-rand-read-1G.fio -- ./daemon-parallel -w   1 -b /dev/vdb
+    ./harness-fio.sh      -s 3000000 -f fio-rand-read-1G.fio -- ./daemon-parallel -w   4 -b /dev/vdb
+    ./harness-fio.sh      -s 3000000 -f fio-rand-read-1G.fio -- ./daemon-parallel -w  16 -b /dev/vdb
+    ./harness-fio.sh      -s 3000000 -f fio-rand-read-1G.fio -- ./daemon-parallel -w  64 -b /dev/vdb
+    ./harness-fio.sh      -s 3000000 -f fio-rand-read-1G.fio -- ./daemon-parallel -w 256 -b /dev/vdb
+
+    ./harness-fio.sh      -s 3000000 -f fio-verify-1G.fio    -- ./daemon-example
+    ./harness-fio.sh      -s 3000000 -f fio-verify-1G.fio    -- ./daemon-short
+    ./harness-fio.sh      -s 3000000 -f fio-verify-1G.fio    -- ./daemon-parallel -w   1
+    ./harness-fio.sh      -s 3000000 -f fio-verify-1G.fio    -- ./daemon-parallel -w   4
+    ./harness-fio.sh      -s 3000000 -f fio-verify-1G.fio    -- ./daemon-parallel -w  16
+    ./harness-fio.sh      -s 3000000 -f fio-verify-1G.fio    -- ./daemon-parallel -w  64
+    ./harness-fio.sh      -s 3000000 -f fio-verify-1G.fio    -- ./daemon-parallel -w 256
+    ./harness-fio.sh      -s 3000000 -f fio-verify-1G.fio    -- ./daemon-parallel -w   1 -b /dev/vdb
+    ./harness-fio.sh      -s 3000000 -f fio-verify-1G.fio    -- ./daemon-parallel -w   4 -b /dev/vdb
+    ./harness-fio.sh      -s 3000000 -f fio-verify-1G.fio    -- ./daemon-parallel -w  16 -b /dev/vdb
+    ./harness-fio.sh      -s 3000000 -f fio-verify-1G.fio    -- ./daemon-parallel -w  64 -b /dev/vdb
+    ./harness-fio.sh      -s 3000000 -f fio-verify-1G.fio    -- ./daemon-parallel -w 256 -b /dev/vdb
+else
+    echo "Unable to find /usr/bin/fio"
+fi
+
+# Runs fsstress from xfstests against an ext2-based filesystem backed by
+# dm-user.
+if test -e /usr/xfstests/ltp/fsstress
+then
+    ./harness-fsstress.sh -s 3000000 -p   1 -n 10000 -- ./daemon-example
+    ./harness-fsstress.sh -s 3000000 -p   4 -n 10000 -- ./daemon-example
+    ./harness-fsstress.sh -s 3000000 -p  16 -n 10000 -- ./daemon-example
+    ./harness-fsstress.sh -s 3000000 -p  64 -n 10000 -- ./daemon-example
+    ./harness-fsstress.sh -s 3000000 -p 256 -n 10000 -- ./daemon-example
+
+    ./harness-fsstress.sh -s 3000000 -p   1 -n 10000 -- ./daemon-short
+    ./harness-fsstress.sh -s 3000000 -p   4 -n 10000 -- ./daemon-short
+    ./harness-fsstress.sh -s 3000000 -p  16 -n 10000 -- ./daemon-short
+    ./harness-fsstress.sh -s 3000000 -p  64 -n 10000 -- ./daemon-short
+    ./harness-fsstress.sh -s 3000000 -p 256 -n 10000 -- ./daemon-short
+
+    ./harness-fsstress.sh -s 3000000 -p 64 -n 10000 -- ./daemon-parallel -w    1
+    ./harness-fsstress.sh -s 3000000 -p 64 -n 10000 -- ./daemon-parallel -w    4
+    ./harness-fsstress.sh -s 3000000 -p 64 -n 10000 -- ./daemon-parallel -w   16
+    ./harness-fsstress.sh -s 3000000 -p 64 -n 10000 -- ./daemon-parallel -w   64
+    ./harness-fsstress.sh -s 3000000 -p 64 -n 10000 -- ./daemon-parallel -w  256
+
+    ./harness-fsstress.sh -s 3000000 -p  1 -n 10000 -- ./daemon-parallel -w    1 -b /dev/vdb
+    ./harness-fsstress.sh -s 3000000 -p 64 -n 10000 -- ./daemon-parallel -w    1 -b /dev/vdb
+    ./harness-fsstress.sh -s 3000000 -p 64 -n 10000 -- ./daemon-parallel -w    4 -b /dev/vdb
+    ./harness-fsstress.sh -s 3000000 -p 64 -n 10000 -- ./daemon-parallel -w   16 -b /dev/vdb
+    ./harness-fsstress.sh -s 3000000 -p 64 -n 10000 -- ./daemon-parallel -w   64 -b /dev/vdb
+    ./harness-fsstress.sh -s 3000000 -p 64 -n 10000 -- ./daemon-parallel -w  256 -b /dev/vdb
+else
+    echo "Unable to find /usr/xfstests/ltp/fsstress"
+fi
-- 
2.29.2.454.gaff20da3a2-goog

