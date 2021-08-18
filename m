Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384463F085E
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Aug 2021 17:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240058AbhHRPsS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Aug 2021 11:48:18 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:43558 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240003AbhHRPsR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Aug 2021 11:48:17 -0400
Received: by mail-lj1-f172.google.com with SMTP id x7so5874447ljn.10;
        Wed, 18 Aug 2021 08:47:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QQ1pbYxxSXDHS5PZboZJzEI8JskJZI6zkGDFpVYhurc=;
        b=JSqHCq8AMLxOfxBHNLPeraQn1EjrXLNsDFYiCYOEC2KgstobLzZb1XeHLDRUc0sQOC
         gXxY3p72G7E5HmX0pkZYDwzAfyg6YKpP/H49gJxLQupwpCijzEyFfc8+kIcdWosxjr5Z
         Y6quXaw6wKfUx3PUHlBKmcRulR3DHl8ua9sYFzOryJm6zZsgH19vLTQJ0iX8yqk8GiRy
         mEuCCYrCaKzHXM7Az1d0b3naan2Zi5lKm38rmi98dVquYK+/DJl2SdmNA7Irbt5kasFf
         vYBashZzfvV+5sJ0B6voU2kLvLWNWWcRmDfQWEz3nCq8su87XN+yZ5esV1dRIJYqj+iM
         ie0g==
X-Gm-Message-State: AOAM533XiBQZnDwobdCXMuwWOAUh34z9bJ06tiaNtthZ5gK1CUb0RRCq
        2d/qqfWOvQzHwjjHAKLGIfWCvrmw6tTBQBPV
X-Google-Smtp-Source: ABdhPJwO44fMOYzmnl7ziE9pnB6IujFYbe9/oC6OPwXYBSSAtLOzxlRdIt6yBOVs7vHOyIKhzQ3d/A==
X-Received: by 2002:a2e:5307:: with SMTP id h7mr8788219ljb.154.1629301660712;
        Wed, 18 Aug 2021 08:47:40 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.googlemail.com with ESMTPSA id j4sm23808ljh.120.2021.08.18.08.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 08:47:40 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-kselftest@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Jiri Kosina <jkosina@suse.cz>, Willy Tarreau <w@1wt.eu>
Subject: [RFC PATCH 3/5] selftests: floppy: add basic tests for opening an empty device
Date:   Wed, 18 Aug 2021 18:46:44 +0300
Message-Id: <20210818154646.925351-4-efremov@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210818154646.925351-1-efremov@linux.com>
References: <20210818154646.925351-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add basic tests for O_NDELAY and O_ACCMODE open of an empty floppy device.
"empty" test works under assumption that there is no disk in "/dev/fd0".
It's possible to run it on a real hardware. "run_empty.sh" automates the
testing process by creating a minimal initrd image with "init" and "test"
binaries and running the kernel in QEMU.

The tests cover these regressions:
 - commit f2791e7eadf4 ("Revert "floppy: refactor open() flags handling"")
 - commit ff06db1efb2a ("floppy: fix open(O_ACCMODE) for ioctl-only open")

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 MAINTAINERS                                 |  1 +
 tools/testing/selftests/floppy/.gitignore   |  5 ++
 tools/testing/selftests/floppy/Makefile     | 10 ++++
 tools/testing/selftests/floppy/config       |  1 +
 tools/testing/selftests/floppy/empty.c      | 58 +++++++++++++++++++++
 tools/testing/selftests/floppy/init.c       | 43 +++++++++++++++
 tools/testing/selftests/floppy/lib.sh       | 57 ++++++++++++++++++++
 tools/testing/selftests/floppy/run_empty.sh | 16 ++++++
 8 files changed, 191 insertions(+)
 create mode 100644 tools/testing/selftests/floppy/.gitignore
 create mode 100644 tools/testing/selftests/floppy/Makefile
 create mode 100644 tools/testing/selftests/floppy/config
 create mode 100644 tools/testing/selftests/floppy/empty.c
 create mode 100644 tools/testing/selftests/floppy/init.c
 create mode 100644 tools/testing/selftests/floppy/lib.sh
 create mode 100755 tools/testing/selftests/floppy/run_empty.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index fd25e4ecf0b9..f2a08b793b54 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7227,6 +7227,7 @@ M:	Denis Efremov <efremov@linux.com>
 L:	linux-block@vger.kernel.org
 S:	Odd Fixes
 F:	drivers/block/floppy.c
+F:	tools/testing/selftests/floppy/
 
 FLYSKY FSIA6B RC RECEIVER
 M:	Markus Koch <markus@notsyncing.net>
diff --git a/tools/testing/selftests/floppy/.gitignore b/tools/testing/selftests/floppy/.gitignore
new file mode 100644
index 000000000000..a9fdf1dbaa97
--- /dev/null
+++ b/tools/testing/selftests/floppy/.gitignore
@@ -0,0 +1,5 @@
+init
+cpio_list
+initrd
+
+empty
diff --git a/tools/testing/selftests/floppy/Makefile b/tools/testing/selftests/floppy/Makefile
new file mode 100644
index 000000000000..83e18cd63210
--- /dev/null
+++ b/tools/testing/selftests/floppy/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+CFLAGS := -static -I../../../../usr/include
+
+TEST_PROGS := run_empty.sh
+TEST_GEN_FILES := init empty
+TEST_FILES := lib.sh
+
+include ../lib.mk
+
+EXTRA_CLEAN := initrd cpio_list
diff --git a/tools/testing/selftests/floppy/config b/tools/testing/selftests/floppy/config
new file mode 100644
index 000000000000..d0c2cd8edfb2
--- /dev/null
+++ b/tools/testing/selftests/floppy/config
@@ -0,0 +1 @@
+CONFIG_BLK_DEV_FD=y
diff --git a/tools/testing/selftests/floppy/empty.c b/tools/testing/selftests/floppy/empty.c
new file mode 100644
index 000000000000..d7e2e6a74132
--- /dev/null
+++ b/tools/testing/selftests/floppy/empty.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <fcntl.h>
+#include <unistd.h>
+#include "../kselftest_harness.h"
+
+FIXTURE(floppy) {
+	const char *dev;
+	int fd;
+};
+
+FIXTURE_VARIANT(floppy) {
+	int flags;
+};
+
+/*
+ * See ff06db1efb2a ("floppy: fix open(O_ACCMODE) for ioctl-only open")
+ * fdutils use O_ACCMODE for probing and ioctl-only open
+ */
+FIXTURE_VARIANT_ADD(floppy, ACCMODE) {
+	.flags = O_ACCMODE,
+};
+
+FIXTURE_VARIANT_ADD(floppy, NACCMODE) {
+	.flags = O_ACCMODE|O_NDELAY,
+};
+
+FIXTURE_VARIANT_ADD(floppy, NRD) {
+	.flags = O_RDONLY|O_NDELAY,
+};
+
+FIXTURE_VARIANT_ADD(floppy, NWR) {
+	.flags = O_WRONLY|O_NDELAY,
+};
+
+FIXTURE_VARIANT_ADD(floppy, NRDWR) {
+	.flags = O_RDWR|O_NDELAY,
+};
+
+FIXTURE_SETUP(floppy)
+{
+	self->dev = "/dev/fd0";
+	if (access(self->dev, F_OK))
+		ksft_exit_skip("No floppy device found\n");
+};
+
+FIXTURE_TEARDOWN(floppy)
+{
+	ASSERT_EQ(close(self->fd), 0);
+}
+
+TEST_F(floppy, open)
+{
+	self->fd = open(self->dev, variant->flags);
+	ASSERT_GT(self->fd, 0);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/floppy/init.c b/tools/testing/selftests/floppy/init.c
new file mode 100644
index 000000000000..d4df4fcfd21f
--- /dev/null
+++ b/tools/testing/selftests/floppy/init.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <unistd.h>
+#include <errno.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/wait.h>
+#include <sys/reboot.h>
+
+__attribute__((noreturn)) static void poweroff(void)
+{
+	fflush(stdout);
+	fflush(stderr);
+	reboot(RB_POWER_OFF);
+	sleep(10);
+	fprintf(stderr, "\nFailed to power off\n");
+	exit(1);
+}
+
+static void panic(const char *what)
+{
+	fprintf(stderr, "\nPANIC %s: %s\n", what, strerror(errno));
+	poweroff();
+}
+
+int main(int argc, char *argv[])
+{
+	pid_t pid;
+
+	pid = fork();
+	if (pid == -1)
+		panic("fork");
+	else if (pid == 0) {
+		execl("/test", "test", NULL);
+		panic("exec");
+	}
+	if (waitpid(pid, NULL, 0) < 0)
+		panic("waitpid");
+
+	poweroff();
+	return 1;
+}
diff --git a/tools/testing/selftests/floppy/lib.sh b/tools/testing/selftests/floppy/lib.sh
new file mode 100644
index 000000000000..22b711ec32ee
--- /dev/null
+++ b/tools/testing/selftests/floppy/lib.sh
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: GPL-2.0
+
+TOP_DIR="$(realpath "$(dirname "$0")"/../../../../)"
+
+QEMU=qemu-system-x86_64
+KERNEL="$TOP_DIR"/arch/x86/boot/bzImage
+INITRD=initrd
+
+gen_cpio_list() {
+  echo "file /init init 755 0 0" > cpio_list
+  echo "file /test $1 755 0 0" >> cpio_list
+  echo "dir /dev 755 0 0" >> cpio_list
+  echo "nod /dev/console 644 0 0 c 5 1" >> cpio_list
+  echo "nod /dev/fd0 666 0 0 b 2 0" >> cpio_list
+  echo "dir /mnt 755 0 0" >> cpio_list
+}
+
+gen_initrd() {
+  "$TOP_DIR"/usr/gen_initramfs.sh -o initrd ./cpio_list
+}
+
+get_selftest_log() {
+  perl -ne '$begin = $_ =~ /^TAP version/ unless $begin;
+            if ($begin && !$end) {
+              $_ =~ s/^\s+|\s+$|\[.+//g;
+              print($_ . "\n") if $_;
+            }
+            $end = $_ =~ /^# Totals:/ unless $end;'
+}
+
+run_qemu() {
+  $QEMU -enable-kvm -nodefaults -nographic \
+    -kernel "$KERNEL" -initrd "$INITRD" \
+    -append "console=ttyS0 earlyprintk=serial" \
+    -serial stdio -monitor none -no-reboot "$@"
+}
+
+run_qemu_debug() {
+  run_qemu "$@"
+}
+
+run_qemu_nodebug() {
+  run_qemu "$@" | get_selftest_log
+}
+
+detect_debug() {
+  if [ "x$1" = "x" ]; then
+    run=run_qemu_nodebug
+  else
+    run=run_qemu_debug
+  fi
+}
+
+run_qemu_empty() {
+  detect_debug "$1"
+  $run -drive index=0,if=floppy
+}
diff --git a/tools/testing/selftests/floppy/run_empty.sh b/tools/testing/selftests/floppy/run_empty.sh
new file mode 100755
index 000000000000..f018107dc6a5
--- /dev/null
+++ b/tools/testing/selftests/floppy/run_empty.sh
@@ -0,0 +1,16 @@
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
+gen_cpio_list empty
+gen_initrd empty
+run_qemu_empty $debug
-- 
2.31.1

