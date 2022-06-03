Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FA053CB8E
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jun 2022 16:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245103AbiFCOdZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Jun 2022 10:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244009AbiFCOdY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Jun 2022 10:33:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536052ED61;
        Fri,  3 Jun 2022 07:33:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1069B21A82;
        Fri,  3 Jun 2022 14:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654266801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hmD9vrbsq1Z0S4I7dnXkcIHxq9s5TkZQpABzmxA0LHg=;
        b=fG1gNkmvqIl8mWFH1FVRrMmK3z6Rvn8b6bNYiDpU50t0St/0FpUd7+yrkpoZ5CV8HtfCwI
        hLl0rxDgPVkZyDuTrYn8HGuRsoS6qHqwTIPYxLfVl0ibcBzD8OnZu87cQIzknFGJyI3fsZ
        JccPfIsTz525HOP/fLQC+DKoKSNHHEo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DEEA613AA2;
        Fri,  3 Jun 2022 14:33:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mMDEKK4bmmIqGgAAMHmgww
        (envelope-from <mpdesouza@suse.com>); Fri, 03 Jun 2022 14:33:18 +0000
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
To:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     shuah@kernel.org, jpoimboe@redhat.com, mbenes@suse.cz,
        pmladek@suse.com, Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH 2/2] selftests: livepatch: Test livepatching a heavily called syscall
Date:   Fri,  3 Jun 2022 11:32:42 -0300
Message-Id: <20220603143242.870-3-mpdesouza@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220603143242.870-1-mpdesouza@suse.com>
References: <20220603143242.870-1-mpdesouza@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Syscalls are called a tricky way. Test that it is possible and works.

This new test creates one userspace process per online cpu calling getpid
continuously and tries to livepatch the getpid function.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 tools/testing/selftests/livepatch/Makefile    | 12 +++-
 .../selftests/livepatch/test-syscall.sh       | 46 ++++++++++++++
 .../test_binaries/test_klp-call_getpid.c      | 48 +++++++++++++++
 .../selftests/livepatch/test_modules/Makefile |  3 +-
 .../livepatch/test_modules/test_klp_syscall.c | 60 +++++++++++++++++++
 5 files changed, 165 insertions(+), 4 deletions(-)
 create mode 100755 tools/testing/selftests/livepatch/test-syscall.sh
 create mode 100644 tools/testing/selftests/livepatch/test_binaries/test_klp-call_getpid.c
 create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c

diff --git a/tools/testing/selftests/livepatch/Makefile b/tools/testing/selftests/livepatch/Makefile
index 5ef492b87bb1..35014197184e 100644
--- a/tools/testing/selftests/livepatch/Makefile
+++ b/tools/testing/selftests/livepatch/Makefile
@@ -1,10 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0
+include ../../../build/Build.include
+include ../../../scripts/Makefile.arch
+include ../../../scripts/Makefile.include
 
 TEST_FILES := settings \
 		test_modules
 
 # We need the test_modules dir in order to make gen_tar and install to work
-TEST_GEN_PROGS_EXTENDED := test_modules/test_klp_atomic_replace.ko \
+TEST_GEN_PROGS_EXTENDED := test_binaries/test_klp-call_getpid \
+			test_modules/test_klp_atomic_replace.ko \
 			test_modules/test_klp_callbacks_busy.ko \
 			test_modules/test_klp_callbacks_demo.ko \
 			test_modules/test_klp_callbacks_demo2.ko \
@@ -13,7 +17,8 @@ TEST_GEN_PROGS_EXTENDED := test_modules/test_klp_atomic_replace.ko \
 			test_modules/test_klp_state.ko \
 			test_modules/test_klp_state2.ko \
 			test_modules/test_klp_state3.ko \
-			test_modules/test_klp_shadow_vars.ko
+			test_modules/test_klp_shadow_vars.ko \
+			test_modules/test_klp_syscall.ko
 
 TEST_PROGS_EXTENDED := functions.sh
 TEST_PROGS := \
@@ -21,7 +26,8 @@ TEST_PROGS := \
 	test-callbacks.sh \
 	test-shadow-vars.sh \
 	test-state.sh \
-	test-ftrace.sh
+	test-ftrace.sh \
+	test-syscall.sh
 
 # override lib.mk's default rules
 OVERRIDE_TARGETS := 1
diff --git a/tools/testing/selftests/livepatch/test-syscall.sh b/tools/testing/selftests/livepatch/test-syscall.sh
new file mode 100755
index 000000000000..f1d49e6ce2ee
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test-syscall.sh
@@ -0,0 +1,46 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2022 SUSE
+# Author: Marcos Paulo de Souza <mpdesouza@suse.com>
+
+. $(dirname $0)/functions.sh
+
+MOD_SYSCALL=test_klp_syscall
+
+setup_config
+
+# - Start _NRPROC processes calling getpid and load a livepatch to patch the
+#   getpid syscall
+
+start_test "patch getpid syscall while being heavily hammered"
+
+declare -a pids
+for i in $(seq 1 $(getconf _NPROCESSORS_ONLN)); do
+	./test_klp-call_getpid &
+	pids[${#pids[*]}]="$!"
+done
+
+load_lp $MOD_SYSCALL
+# Success, getpid syscall was livepatched
+
+for pid in ${pids[@]}; do
+	kill $pid || true
+done
+
+disable_lp $MOD_SYSCALL
+unload_lp $MOD_SYSCALL
+
+check_result "% insmod test_modules/$MOD_SYSCALL.ko
+livepatch: enabling patch '$MOD_SYSCALL'
+livepatch: '$MOD_SYSCALL': initializing patching transition
+livepatch: '$MOD_SYSCALL': starting patching transition
+livepatch: '$MOD_SYSCALL': completing patching transition
+livepatch: '$MOD_SYSCALL': patching complete
+% echo 0 > /sys/kernel/livepatch/$MOD_SYSCALL/enabled
+livepatch: '$MOD_SYSCALL': initializing unpatching transition
+livepatch: '$MOD_SYSCALL': starting unpatching transition
+livepatch: '$MOD_SYSCALL': completing unpatching transition
+livepatch: '$MOD_SYSCALL': unpatching complete
+% rmmod $MOD_SYSCALL"
+
+exit 0
diff --git a/tools/testing/selftests/livepatch/test_binaries/test_klp-call_getpid.c b/tools/testing/selftests/livepatch/test_binaries/test_klp-call_getpid.c
new file mode 100644
index 000000000000..be9d3110687d
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test_binaries/test_klp-call_getpid.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017 SUSE
+ * Author: Libor Pechacek <lpechacek@suse.cz>
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <signal.h>
+
+static int run = 1;
+static int sig_int;
+
+void hup_handler(int signum)
+{
+	run = 0;
+}
+
+void int_handler(int signum)
+{
+	run = 0;
+	sig_int = 1;
+}
+
+int main(int argc, char *argv[])
+{
+	pid_t orig_pid, pid;
+	long count = 0;
+
+	signal(SIGHUP, &hup_handler);
+	signal(SIGINT, &int_handler);
+
+	orig_pid = syscall(SYS_getpid);
+
+	while(run) {
+		pid = syscall(SYS_getpid);
+		if (pid != orig_pid)
+			return 1;
+		count++;
+	}
+
+	if (sig_int)
+		printf("%d iterations done\n", count);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/livepatch/test_modules/Makefile b/tools/testing/selftests/livepatch/test_modules/Makefile
index 375180bc1b16..288c65ccd080 100644
--- a/tools/testing/selftests/livepatch/test_modules/Makefile
+++ b/tools/testing/selftests/livepatch/test_modules/Makefile
@@ -15,7 +15,8 @@ obj-m += test_klp_atomic_replace.o \
 	test_klp_state.o \
 	test_klp_state2.o \
 	test_klp_state3.o \
-	test_klp_shadow_vars.o
+	test_klp_shadow_vars.o \
+	test_klp_syscall.o
 
 %.ko:
 	make -C $(KDIR) M=$(TESTMODS_DIR) $@
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c b/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c
new file mode 100644
index 000000000000..e170accfb10c
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017-2022 SUSE
+ * Authors: Libor Pechacek <lpechacek@suse.cz>
+ *          Nicolai Stange <nstange@suse.de>
+ *          Marcos Paulo de Souza <mpdesouza@suse.com>
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/livepatch.h>
+
+#if defined(__x86_64__)
+#define FN_PREFIX __x64_
+#elif defined(__s390x__)
+#define FN_PREFIX __s390x_
+#elif defined(__PPC64__)
+#define FN_PREFIX __ppc64_
+#else
+#error "livepatch not supported"
+#endif
+
+asmlinkage long lp_sys_getpid(void)
+{
+	return task_tgid_vnr(current);
+}
+
+static struct klp_func vmlinux_funcs[] = {
+	{
+		.old_name = __stringify(FN_PREFIX) "sys_getpid",
+		.new_func = lp_sys_getpid,
+	}, {}
+};
+
+static struct klp_object objs[] = {
+	{
+		/* name being NULL means vmlinux */
+		.funcs = vmlinux_funcs,
+	}, {}
+};
+
+static struct klp_patch patch = {
+	.mod = THIS_MODULE,
+	.objs = objs,
+};
+
+static int livepatch_init(void)
+{
+	return klp_enable_patch(&patch);
+}
+
+static void livepatch_exit(void)
+{
+}
+
+module_init(livepatch_init);
+module_exit(livepatch_exit);
+MODULE_LICENSE("GPL");
+MODULE_INFO(livepatch, "Y");
-- 
2.35.3

