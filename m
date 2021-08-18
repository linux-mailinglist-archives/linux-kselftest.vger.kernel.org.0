Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11EC03F0864
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Aug 2021 17:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240107AbhHRPs2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Aug 2021 11:48:28 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:43712 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240125AbhHRPs0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Aug 2021 11:48:26 -0400
Received: by mail-lf1-f44.google.com with SMTP id i9so5535008lfg.10;
        Wed, 18 Aug 2021 08:47:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9bvaZZWUnooV8Jw75jd8qrJDvM8A6y9DHRPhc6M+/sI=;
        b=chnDyw5zPdhgShW1Q4A0tvohOju0LM8CNqRVMsT4x0h+OeeXph8jlNa+WcdcHzedst
         7WDLIxf0bdE8vyV6e1wvuhNoOKyjv9y+rqZbcnPV96/3Jn1VL8RbnH0hUMj5ihychl5k
         F1w2wGwcuudm51JtjWcd6Lb8h8DNYe+XQsQwW0QdhKK3rVT+crWHKQ8GrMyrZGf6g+Zj
         J1HjL9eRU7GfN0gN0iVltRprU6zR3SVgCvkto5doyP45TcY3oN5u1KzSZbq7o91bh8HF
         OZnTBaClSIlphquOBSwhRr6GlZBhzb7tc5ZImGwAOU1/W/kdN8lOL7Z2RU9QoFwI60Py
         ovrg==
X-Gm-Message-State: AOAM531YqiF0Yvj+krmrPtzz2Xn62hiTlTbR6AqWMNn4MlF1UYl7b04G
        AVQkXknJavb0gt1QG2xdXoXUeRF74WogIqXu
X-Google-Smtp-Source: ABdhPJyr8G1yfTuq0VreQDkFsJJ0P7+twk1JxBRGT3Ai6uEwI88aRpUUOkMZx89CEUKflZadKZdEpQ==
X-Received: by 2002:a05:6512:3091:: with SMTP id z17mr7043553lfd.207.1629301670115;
        Wed, 18 Aug 2021 08:47:50 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.googlemail.com with ESMTPSA id j4sm23808ljh.120.2021.08.18.08.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 08:47:49 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-kselftest@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Jiri Kosina <jkosina@suse.cz>, Willy Tarreau <w@1wt.eu>
Subject: [RFC PATCH 5/5] selftests: floppy: add basic rdwr tests
Date:   Wed, 18 Aug 2021 18:46:46 +0300
Message-Id: <20210818154646.925351-6-efremov@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210818154646.925351-1-efremov@linux.com>
References: <20210818154646.925351-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add basic tests for a floppy with writable disk. "rdwr" test
works under following assumptions:
 - writable disk in "/dev/fd0"

To simulate the conditions and automate the testing process there is
"run_rdwr.sh".

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 tools/testing/selftests/floppy/.gitignore  |  1 +
 tools/testing/selftests/floppy/Makefile    |  4 +-
 tools/testing/selftests/floppy/lib.sh      |  4 ++
 tools/testing/selftests/floppy/rdwr.c      | 67 ++++++++++++++++++++++
 tools/testing/selftests/floppy/run_rdwr.sh | 22 +++++++
 5 files changed, 96 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/floppy/rdwr.c
 create mode 100755 tools/testing/selftests/floppy/run_rdwr.sh

diff --git a/tools/testing/selftests/floppy/.gitignore b/tools/testing/selftests/floppy/.gitignore
index 7642dc0ef281..f53e70197edd 100644
--- a/tools/testing/selftests/floppy/.gitignore
+++ b/tools/testing/selftests/floppy/.gitignore
@@ -5,3 +5,4 @@ testdir/
 
 empty
 rdonly
+rdwr
diff --git a/tools/testing/selftests/floppy/Makefile b/tools/testing/selftests/floppy/Makefile
index ed8fdeb79aea..c5d010dd4445 100644
--- a/tools/testing/selftests/floppy/Makefile
+++ b/tools/testing/selftests/floppy/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS := -static -I../../../../usr/include
 
-TEST_PROGS := run_empty.sh run_rdonly.sh
-TEST_GEN_FILES := init empty rdonly
+TEST_PROGS := run_empty.sh run_rdonly.sh run_rdwr.sh
+TEST_GEN_FILES := init empty rdonly rdwr
 TEST_FILES := lib.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/floppy/lib.sh b/tools/testing/selftests/floppy/lib.sh
index 9988be187bc9..0eab702b355a 100644
--- a/tools/testing/selftests/floppy/lib.sh
+++ b/tools/testing/selftests/floppy/lib.sh
@@ -61,3 +61,7 @@ run_qemu_rdonly_fat() {
   $run -drive file=fat:floppy:"$1",index=0,if=floppy,readonly
 }
 
+run_qemu_rdwr_img() {
+  detect_debug "$2"
+  $run -drive file="$1",index=0,if=floppy,format=raw
+}
diff --git a/tools/testing/selftests/floppy/rdwr.c b/tools/testing/selftests/floppy/rdwr.c
new file mode 100644
index 000000000000..44ad18701530
--- /dev/null
+++ b/tools/testing/selftests/floppy/rdwr.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/mount.h>
+#include <errno.h>
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
+	if (access(self->dev, W_OK))
+		ksft_exit_skip("Floppy is not write accessible\n");
+
+	fd = open("/dev/fd0", O_ACCMODE|O_NDELAY);
+	EXPECT_EQ(0, ioctl(fd, FDGETDRVPRM, &params));
+	params.flags |= FD_DEBUG;
+	EXPECT_EQ(0, ioctl(fd, FDSETDRVPRM, &params));
+	close(fd);
+}
+
+FIXTURE_TEARDOWN(floppy)
+{
+}
+
+TEST_F(floppy, write)
+{
+#define TEST_DATA "TEST_WRITE"
+	int fd;
+	char test[] = TEST_DATA;
+
+	fd = open(self->dev, O_RDWR);
+	ASSERT_GT(fd, 0);
+
+	ASSERT_EQ(sizeof(test), write(fd, test, sizeof(test)));
+	ASSERT_EQ(sizeof(test), read(fd, test, sizeof(test)));
+	ASSERT_NE(0, strncmp(TEST_DATA, test, sizeof(TEST_DATA)));
+
+	ASSERT_EQ(close(fd), 0);
+#undef TEST_DATA
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
+	ASSERT_TRUE(drive.flags & FD_DISK_WRITABLE);
+	ASSERT_EQ(close(fd), 0);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/floppy/run_rdwr.sh b/tools/testing/selftests/floppy/run_rdwr.sh
new file mode 100755
index 000000000000..0ebe8bd6bc69
--- /dev/null
+++ b/tools/testing/selftests/floppy/run_rdwr.sh
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
+head -c 1474560 /dev/zero > testdir/floppy.raw
+
+gen_cpio_list rdwr
+gen_initrd rdwr
+run_qemu_rdwr_img testdir/floppy.raw $debug
-- 
2.31.1

