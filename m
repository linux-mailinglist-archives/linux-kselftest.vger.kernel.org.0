Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D363F0861
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Aug 2021 17:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239944AbhHRPs0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Aug 2021 11:48:26 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:39730 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239971AbhHRPsV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Aug 2021 11:48:21 -0400
Received: by mail-lj1-f171.google.com with SMTP id q21so5921693ljj.6;
        Wed, 18 Aug 2021 08:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xo/kWZ/Q6p5cSot9iJCnbo6zu7GIyqYV9mIUYePGUPs=;
        b=NOv0gGkjHoTNC0CQlIN69hx9RLXPmtmI4R83d3Gbb702SzPfsbKzHa+Expd4sqArXy
         MbrEXZm5qeZklckthQxxnJY8lnF4t37RCRbEFrjGMeLw/ycmpEgEsR3icb67lo/Q0Mpd
         7T+CYKyYedqBw9RmoG298rnAHk0VE+2TUEs5g72lPinx81cVKvv4DxC2IlCVmTmwGlWv
         TTBO0eh0rkM5o+EMn09QdcY2qidQscEIdM4+t0tPtmuCt6yRzutECEQajRnZLZlMJuqc
         ce0vPSYbThSc7hNM3Z16fTFbJzgazPWziIQsSngkKU9vtawirelI7tId0q3Cia989AGn
         rcrA==
X-Gm-Message-State: AOAM533e1nWfRyBBhdR87Y0dGy+uEps9sJUUiL4QAG5yNI/OdBTxLSLJ
        Ib5EFpNg9eXaMe3EWbe6XFjfnD5NAchUlOBd
X-Google-Smtp-Source: ABdhPJxWF6fSa4HMmYCAKmmj7d8BhZWiADsgdS+XXkQEe9jmoJPWjoybpGBMZ/QnMyBgkUA5Q6Iz7g==
X-Received: by 2002:a2e:509:: with SMTP id 9mr8362496ljf.453.1629301664689;
        Wed, 18 Aug 2021 08:47:44 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.googlemail.com with ESMTPSA id j4sm23808ljh.120.2021.08.18.08.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 08:47:44 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-kselftest@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Jiri Kosina <jkosina@suse.cz>, Willy Tarreau <w@1wt.eu>
Subject: [RFC PATCH 4/5] selftests: floppy: add basic tests for a readonly disk
Date:   Wed, 18 Aug 2021 18:46:45 +0300
Message-Id: <20210818154646.925351-5-efremov@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210818154646.925351-1-efremov@linux.com>
References: <20210818154646.925351-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add basic tests for a floppy with a readonly disk. "rdonly" test
works under following assumptions:
 - there is a readonly disk in "/dev/fd0"
 - the disk is VFAT formatted
 - there is "test" file with "TEST" in it on the disk

"run_rdonly.sh" script simulates the conditions and automates the
testing process.

The tests cover the regression:
 - commit f2791e7eadf4 ("Revert "floppy: refactor open() flags handling"")

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 tools/testing/selftests/floppy/.gitignore    |  2 +
 tools/testing/selftests/floppy/Makefile      |  6 +-
 tools/testing/selftests/floppy/lib.sh        |  6 ++
 tools/testing/selftests/floppy/rdonly.c      | 99 ++++++++++++++++++++
 tools/testing/selftests/floppy/run_rdonly.sh | 22 +++++
 5 files changed, 132 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/floppy/rdonly.c
 create mode 100755 tools/testing/selftests/floppy/run_rdonly.sh

diff --git a/tools/testing/selftests/floppy/.gitignore b/tools/testing/selftests/floppy/.gitignore
index a9fdf1dbaa97..7642dc0ef281 100644
--- a/tools/testing/selftests/floppy/.gitignore
+++ b/tools/testing/selftests/floppy/.gitignore
@@ -1,5 +1,7 @@
 init
 cpio_list
 initrd
+testdir/
 
 empty
+rdonly
diff --git a/tools/testing/selftests/floppy/Makefile b/tools/testing/selftests/floppy/Makefile
index 83e18cd63210..ed8fdeb79aea 100644
--- a/tools/testing/selftests/floppy/Makefile
+++ b/tools/testing/selftests/floppy/Makefile
@@ -1,10 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS := -static -I../../../../usr/include
 
-TEST_PROGS := run_empty.sh
-TEST_GEN_FILES := init empty
+TEST_PROGS := run_empty.sh run_rdonly.sh
+TEST_GEN_FILES := init empty rdonly
 TEST_FILES := lib.sh
 
 include ../lib.mk
 
-EXTRA_CLEAN := initrd cpio_list
+EXTRA_CLEAN := initrd cpio_list testdir
diff --git a/tools/testing/selftests/floppy/lib.sh b/tools/testing/selftests/floppy/lib.sh
index 22b711ec32ee..9988be187bc9 100644
--- a/tools/testing/selftests/floppy/lib.sh
+++ b/tools/testing/selftests/floppy/lib.sh
@@ -55,3 +55,9 @@ run_qemu_empty() {
   detect_debug "$1"
   $run -drive index=0,if=floppy
 }
+
+run_qemu_rdonly_fat() {
+  detect_debug "$2"
+  $run -drive file=fat:floppy:"$1",index=0,if=floppy,readonly
+}
+
diff --git a/tools/testing/selftests/floppy/rdonly.c b/tools/testing/selftests/floppy/rdonly.c
new file mode 100644
index 000000000000..fa60d069540b
--- /dev/null
+++ b/tools/testing/selftests/floppy/rdonly.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <errno.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/mount.h>
+#include <sys/ioctl.h>
+#include <linux/fd.h>
+#include "../kselftest_harness.h"
+
+FIXTURE(floppy) {
+	const char *dev;
+};
+
+FIXTURE_SETUP(floppy)
+{
+	int fd;
+	struct floppy_drive_params params;
+
+	self->dev = "/dev/fd0";
+	if (access(self->dev, F_OK))
+		ksft_exit_skip("No floppy device found\n");
+	if (access(self->dev, R_OK))
+		ksft_exit_skip("Floppy is not read accessible\n");
+
+	fd = open(self->dev, O_ACCMODE|O_NDELAY);
+	EXPECT_EQ(0, ioctl(fd, FDGETDRVPRM, &params));
+	params.flags |= FTD_MSG|FD_DEBUG;
+	EXPECT_EQ(0, ioctl(fd, FDSETDRVPRM, &params));
+	close(fd);
+}
+
+FIXTURE_TEARDOWN(floppy)
+{
+}
+
+TEST_F(floppy, read)
+{
+	int fd, test;
+
+	fd = open(self->dev, O_RDONLY);
+	ASSERT_GT(fd, 0);
+	ASSERT_EQ(read(fd, &test, sizeof(test)), sizeof(test));
+	ASSERT_EQ(close(fd), 0);
+}
+
+TEST_F(floppy, open_write_fail)
+{
+	ASSERT_LT(open(self->dev, O_WRONLY), 0);
+}
+
+TEST_F(floppy, open_rdwr_fail)
+{
+	ASSERT_LT(open(self->dev, O_RDWR), 0);
+}
+
+TEST_F(floppy, ioctl_disk_writable)
+{
+	int fd;
+	struct floppy_drive_struct drive;
+
+	fd = open(self->dev, O_RDONLY|O_NDELAY);
+	ASSERT_GT(fd, 0);
+	ASSERT_EQ(0, ioctl(fd, FDGETDRVSTAT, &drive));
+	ASSERT_FALSE(drive.flags & FD_DISK_WRITABLE);
+	ASSERT_EQ(close(fd), 0);
+}
+
+TEST_F(floppy, mount)
+{
+	int fd;
+	char test[5] = {};
+
+	mount(self->dev, "/mnt", "vfat", MS_RDONLY, NULL);
+	ASSERT_EQ(0, errno);
+
+	fd = open("/mnt/test", O_RDONLY);
+	read(fd, &test, sizeof(test));
+	ASSERT_EQ(0, strncmp(test, "TEST", 4));
+}
+
+TEST_F(floppy, open_ndelay_write_fail)
+{
+#define TEST_DATA "TEST_FAIL_WRITE"
+	int fd;
+	char test[] = TEST_DATA;
+
+	fd = open(self->dev, O_RDWR|O_NDELAY);
+	ASSERT_GT(fd, 0);
+
+	write(fd, test, sizeof(test));
+	read(fd, test, sizeof(test));
+	ASSERT_NE(0, strncmp(TEST_DATA, test, sizeof(TEST_DATA)));
+
+	ASSERT_EQ(close(fd), 0);
+#undef TEST_DATA
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/floppy/run_rdonly.sh b/tools/testing/selftests/floppy/run_rdonly.sh
new file mode 100755
index 000000000000..a358a1b6e58d
--- /dev/null
+++ b/tools/testing/selftests/floppy/run_rdonly.sh
@@ -0,0 +1,22 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+source "$(dirname $0)"/lib.sh
+
+while getopts d flag; do
+  case "${flag}" in
+    d) debug=1;;
+  esac
+done
+
+if [ -z $debug ]; then
+  trap "rm -rf testdir" EXIT
+fi
+mkdir -p testdir
+echo -n TEST > testdir/test
+
+gen_cpio_list rdonly
+gen_initrd rdonly
+run_qemu_rdonly_fat testdir $debug
-- 
2.31.1

