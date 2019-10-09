Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19A51D1129
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2019 16:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbfJIO0D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Oct 2019 10:26:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:55874 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727769AbfJIO0D (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Oct 2019 10:26:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 67183AE55;
        Wed,  9 Oct 2019 14:26:00 +0000 (UTC)
From:   Richard Palethorpe <rpalethorpe@suse.com>
To:     ltp@lists.linux.it
Cc:     Richard Palethorpe <rpalethorpe@suse.com>,
        syzkaller@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>,
        kernelci@groups.io,
        "open list : KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        automated-testing@yoctoproject.org, shuah <shuah@kernel.org>,
        George Kennedy <george.kennedy@oracle.com>, chrubis@suse.com
Subject: [RFC PATCH] LTP Wrapper for Syzkaller reproducers
Date:   Wed,  9 Oct 2019 16:24:46 +0200
Message-Id: <20191009142446.6997-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

First attempt at wrapping the Syzkaller reproducers in the LTP library. I am
posting this in case anyone wants to experiment with it early or has a
radically different approach in mind.

This just uses exec to run the reproducer executables as per Metan's
suggestion. There is a simple script which creates a runtest file allowing it
to work with existing LTP test runners, albeit with a bit of extra work for
now.

This would benefit from the following LTP library patch:
https://patchwork.ozlabs.org/patch/935568/

Running it without KASAN and the other kernel debugging options is not a good
idea. We can easily detect when the kernel config is wrong and print a
warning or even refuse to run, but I haven't added it yet.

Having to download, compile and install the reproducers seperately is annoying
and I bet most users won't do it. We can probably automate that as part of the
install, it is just a question of how much we do as default.

---
 runtest/.gitignore                            |  1 +
 testcases/kernel/Makefile                     |  1 +
 testcases/kernel/syzkaller-repros/.gitignore  |  1 +
 testcases/kernel/syzkaller-repros/Makefile    | 10 +++
 testcases/kernel/syzkaller-repros/README.md   | 39 +++++++++
 .../kernel/syzkaller-repros/gen-runtest.sh    |  8 ++
 testcases/kernel/syzkaller-repros/syzwrap.c   | 85 +++++++++++++++++++
 7 files changed, 145 insertions(+)
 create mode 100644 runtest/.gitignore
 create mode 100644 testcases/kernel/syzkaller-repros/.gitignore
 create mode 100644 testcases/kernel/syzkaller-repros/Makefile
 create mode 100644 testcases/kernel/syzkaller-repros/README.md
 create mode 100755 testcases/kernel/syzkaller-repros/gen-runtest.sh
 create mode 100644 testcases/kernel/syzkaller-repros/syzwrap.c

diff --git a/runtest/.gitignore b/runtest/.gitignore
new file mode 100644
index 000000000..e3725dd42
--- /dev/null
+++ b/runtest/.gitignore
@@ -0,0 +1 @@
+syzkaller-repros
diff --git a/testcases/kernel/Makefile b/testcases/kernel/Makefile
index 3319b3163..0150cfb4f 100644
--- a/testcases/kernel/Makefile
+++ b/testcases/kernel/Makefile
@@ -53,6 +53,7 @@ SUBDIRS			+= connectors \
 			   sched \
 			   security \
 			   sound \
+			   syzkaller-repros \
 			   tracing \
 			   uevents \
 
diff --git a/testcases/kernel/syzkaller-repros/.gitignore b/testcases/kernel/syzkaller-repros/.gitignore
new file mode 100644
index 000000000..dbda1c71f
--- /dev/null
+++ b/testcases/kernel/syzkaller-repros/.gitignore
@@ -0,0 +1 @@
+syzwrap
diff --git a/testcases/kernel/syzkaller-repros/Makefile b/testcases/kernel/syzkaller-repros/Makefile
new file mode 100644
index 000000000..8e74805c2
--- /dev/null
+++ b/testcases/kernel/syzkaller-repros/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2019 Linux Test Project
+
+top_srcdir		?= ../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+CFLAGS			+= -D_GNU_SOURCE
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syzkaller-repros/README.md b/testcases/kernel/syzkaller-repros/README.md
new file mode 100644
index 000000000..e95ae19e2
--- /dev/null
+++ b/testcases/kernel/syzkaller-repros/README.md
@@ -0,0 +1,39 @@
+LTP wrapper for Syzkaller reproducers
+=====================================
+
+This allows you to run the autogenerated bug reproducers from the Syzkaller
+fuzzer within the LTP framework. Meaning that you may use an existing test
+runner compatible with the LTP.
+
+However some extra setup is currently required.
+
+Instructions
+------------
+
+1. Download and compile the reproducers.
+2. Build the LTP as normal
+3. Use the gen-runtest.sh script to create a runtest file
+4. Install the LTP and the reproducers to the SUT
+5. Execute the tests in the syzkaller-repros runtest file
+
+For now you can download the reproducers from here:
+https://github.com/dvyukov/syzkaller-repros. Soon they will be available on
+kernel.org.
+
+The gen-runtest takes two arguments:
+
+1. The directory where the reproducer executables are currently accessible
+2. The *absolute* path to the directory where they will be on the SUT (If
+   different, can be omitted)
+
+For example:
+```
+./gen-runtest.sh ~/qa/syzkaller-repros/bin /mnt/syzkaller-repros/bin >
+~/qa/ltp-build/runtest/syzkaller-repros
+```
+
+For the LTP, just doing `make install` will copy all the relevant files
+(assuming you put the runtest file in the runtest folder). However you will
+need to copy the reproducers yourself.
+
+
diff --git a/testcases/kernel/syzkaller-repros/gen-runtest.sh b/testcases/kernel/syzkaller-repros/gen-runtest.sh
new file mode 100755
index 000000000..091818fb2
--- /dev/null
+++ b/testcases/kernel/syzkaller-repros/gen-runtest.sh
@@ -0,0 +1,8 @@
+#!/usr/bin/sh
+
+BUILD_DIR=$1
+SUT_DIR=$2
+
+for f in $(ls $BUILD_DIR); do
+    echo $f syzwrap -d ${SUT_DIR:-$BUILD_DIR} -n $f
+done
diff --git a/testcases/kernel/syzkaller-repros/syzwrap.c b/testcases/kernel/syzkaller-repros/syzwrap.c
new file mode 100644
index 000000000..7951d1819
--- /dev/null
+++ b/testcases/kernel/syzkaller-repros/syzwrap.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Richard Palethorpe <rpalethorpe@suse.com>
+ *
+ * Run a single reproducer generated by the Syzkaller fuzzer.
+ */
+
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <signal.h>
+#include <stdio.h>
+
+#include "tst_test.h"
+#include "tst_taint.h"
+#include "tst_safe_stdio.h"
+
+static char *dir;
+static char *name;
+static char *path;
+
+static struct tst_option options[] = {
+	{"d:", &dir, "Mandatory directory containing reproducers"},
+	{"n:", &name, "Mandatory executable name of reproducer"},
+	{NULL, NULL, NULL}
+};
+
+static void setup(void)
+{
+	tst_taint_init(TST_TAINT_W | TST_TAINT_D);
+
+	if (!dir)
+		tst_brk(TBROK, "No reproducer directory specified");
+
+	if (!name)
+		tst_brk(TBROK, "No reproducer name specified");
+
+	tst_res(TINFO, "https://syzkaller.appspot.com/bug?id=%s", name);
+
+	SAFE_ASPRINTF(&path, "%s/%s", dir, name);
+	tst_res(TINFO, "%s", path);
+}
+
+static void run(void)
+{
+	unsigned int backoff = 100;
+	int rem, status, sent_kill = 0;
+	float exec_time_start = (float)tst_timeout_remaining();
+	int pid = SAFE_FORK();
+
+	if (!pid) {
+		execle(path, name, environ);
+		tst_brk(TBROK | TERRNO, "Failed to exec reproducer");
+	}
+
+	while (!waitpid(pid, &status, WNOHANG)) {
+		rem = tst_timeout_remaining();
+
+		if (!sent_kill && rem / exec_time_start < 0.98) {
+			tst_res(TINFO, "Timeout; killing reproducer");
+
+			TEST(kill(pid, SIGKILL));
+			if (TST_RET == -1)
+				tst_res(TWARN | TTERRNO, "kill() failed");
+			else
+				sent_kill = 1;
+		}
+
+		usleep(backoff);
+		backoff = MIN(2 * backoff, 1000000);
+	}
+
+	if (tst_taint_check()) {
+		tst_res(TFAIL, "Kernel is tainted");
+	} else {
+		tst_res(TPASS, "Kernel is not tainted");
+	}
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.options = options,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+};
-- 
2.23.0

