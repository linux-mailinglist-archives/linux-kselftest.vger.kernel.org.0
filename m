Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE47456C11
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Nov 2021 10:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbhKSJGe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Nov 2021 04:06:34 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:53990 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233845AbhKSJGb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Nov 2021 04:06:31 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E8CEE2170E;
        Fri, 19 Nov 2021 09:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637312608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yr1/cvzgX2Oc+f3PB8NBBdQ0jQcpbd7E13OWVfePSbs=;
        b=xXdwPUHIWUVsSSaRzorAY8R0dLTO36vOJqlv253syWS15xIhphWh063F7PAfTSvrAT4T4g
        Moo/g0ZuudfljYlsyOEWJ3F+vuK67PmCoSih00BWQTRRmLrF+D78yEVUkXxmFL1sy16TPQ
        hkV0bpIXUAnZLRRJh7O/mJS/kWodRhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637312608;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yr1/cvzgX2Oc+f3PB8NBBdQ0jQcpbd7E13OWVfePSbs=;
        b=2YOd9T6VbLOjigofQoasH1iC+nDZsb3mFPmr/gYT2YSfa8gFloexJGQW/XAxMYhO161VJe
        gfwAUww2OVub2PAw==
Received: from san.suse.cz (san.suse.cz [10.100.12.79])
        by relay2.suse.de (Postfix) with ESMTP id D1A10A3B81;
        Fri, 19 Nov 2021 09:03:28 +0000 (UTC)
From:   Miroslav Benes <mbenes@suse.cz>
To:     jpoimboe@redhat.com, jikos@kernel.org, pmladek@suse.com,
        joe.lawrence@redhat.com
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 3/3] selftests/livepatch: Test of the API for specifying functions to search for on a stack
Date:   Fri, 19 Nov 2021 10:03:27 +0100
Message-Id: <20211119090327.12811-4-mbenes@suse.cz>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211119090327.12811-1-mbenes@suse.cz>
References: <20211119090327.12811-1-mbenes@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a test for the API which allows the user to specify functions which
are then searched for on any tasks's stack during a transition process.

Signed-off-by: Miroslav Benes <mbenes@suse.cz>
---
 lib/Kconfig.debug                             |  1 +
 lib/livepatch/Makefile                        |  4 +-
 lib/livepatch/test_klp_funcstack_demo.c       | 61 +++++++++++++
 lib/livepatch/test_klp_funcstack_mod.c        | 72 +++++++++++++++
 tools/testing/selftests/livepatch/Makefile    |  3 +-
 .../selftests/livepatch/test-func-stack.sh    | 88 +++++++++++++++++++
 6 files changed, 227 insertions(+), 2 deletions(-)
 create mode 100644 lib/livepatch/test_klp_funcstack_demo.c
 create mode 100644 lib/livepatch/test_klp_funcstack_mod.c
 create mode 100755 tools/testing/selftests/livepatch/test-func-stack.sh

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 9ef7ce18b4f5..aa4c97098f41 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2529,6 +2529,7 @@ config TEST_LIVEPATCH
 	default n
 	depends on DYNAMIC_DEBUG
 	depends on LIVEPATCH
+	depends on DEBUG_FS
 	depends on m
 	help
 	  Test kernel livepatching features for correctness.  The tests will
diff --git a/lib/livepatch/Makefile b/lib/livepatch/Makefile
index dcc912b3478f..584e3b8b5415 100644
--- a/lib/livepatch/Makefile
+++ b/lib/livepatch/Makefile
@@ -11,4 +11,6 @@ obj-$(CONFIG_TEST_LIVEPATCH) += test_klp_atomic_replace.o \
 				test_klp_shadow_vars.o \
 				test_klp_state.o \
 				test_klp_state2.o \
-				test_klp_state3.o
+				test_klp_state3.o \
+				test_klp_funcstack_mod.o \
+				test_klp_funcstack_demo.o
diff --git a/lib/livepatch/test_klp_funcstack_demo.c b/lib/livepatch/test_klp_funcstack_demo.c
new file mode 100644
index 000000000000..902798077f05
--- /dev/null
+++ b/lib/livepatch/test_klp_funcstack_demo.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2021 Miroslav Benes <mbenes@suse.cz>
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/livepatch.h>
+
+static int funcstack;
+module_param(funcstack, int, 0644);
+MODULE_PARM_DESC(funcstack, "func_stack (default=0)");
+
+static noinline void livepatch_child2_function(void)
+{
+	pr_info("%s\n", __func__);
+}
+
+static struct klp_func funcs[] = {
+	{
+		.old_name = "child2_function",
+		.new_func = livepatch_child2_function,
+	}, {}
+};
+
+static struct klp_func funcs_stack[] = {
+	{
+		.old_name = "parent_function",
+	}, {}
+};
+
+static struct klp_object objs[] = {
+	{
+		.name = "test_klp_funcstack_mod",
+		.funcs = funcs,
+	}, {}
+};
+
+static struct klp_patch patch = {
+	.mod = THIS_MODULE,
+	.objs = objs,
+};
+
+static int test_klp_funcstack_demo_init(void)
+{
+	if (funcstack)
+		objs[0].funcs_stack = funcs_stack;
+
+	return klp_enable_patch(&patch);
+}
+
+static void test_klp_funcstack_demo_exit(void)
+{
+}
+
+module_init(test_klp_funcstack_demo_init);
+module_exit(test_klp_funcstack_demo_exit);
+MODULE_LICENSE("GPL");
+MODULE_INFO(livepatch, "Y");
+MODULE_AUTHOR("Miroslav Benes <mbenes@suse.cz>");
+MODULE_DESCRIPTION("Livepatch test: func_stack demo");
diff --git a/lib/livepatch/test_klp_funcstack_mod.c b/lib/livepatch/test_klp_funcstack_mod.c
new file mode 100644
index 000000000000..127c6093d890
--- /dev/null
+++ b/lib/livepatch/test_klp_funcstack_mod.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2021 Miroslav Benes <mbenes@suse.cz>
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+
+static int sleep_length = 10000;
+module_param(sleep_length, int, 0644);
+MODULE_PARM_DESC(sleep_length, "length of sleep in seconds (default=10)");
+
+static noinline void child_function(void)
+{
+	pr_info("%s enter\n", __func__);
+	msleep(sleep_length);
+	pr_info("%s exit\n", __func__);
+}
+
+static noinline void child2_function(void)
+{
+	pr_info("%s\n", __func__);
+}
+
+static noinline void parent_function(void)
+{
+	pr_info("%s enter\n", __func__);
+	child_function();
+	child2_function();
+	pr_info("%s exit\n", __func__);
+}
+
+static int parent_function_get(void *data, u64 *val)
+{
+	*val = 0;
+	parent_function();
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_parent_function, parent_function_get, NULL, "%llu\n");
+
+static struct dentry *debugfs_dir;
+
+static int test_klp_funcstack_mod_init(void)
+{
+	struct dentry *d;
+
+	debugfs_dir = debugfs_create_dir("test_klp_funcstack", NULL);
+	if (IS_ERR(debugfs_dir))
+		return PTR_ERR(debugfs_dir);
+
+	d = debugfs_create_file("parent_function", 0400, debugfs_dir, NULL,
+				&fops_parent_function);
+	if (IS_ERR(d))
+		debugfs_remove_recursive(debugfs_dir);
+
+	return 0;
+}
+
+static void test_klp_funcstack_mod_exit(void)
+{
+	debugfs_remove_recursive(debugfs_dir);
+}
+
+module_init(test_klp_funcstack_mod_init);
+module_exit(test_klp_funcstack_mod_exit);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Miroslav Benes <mbenes@suse.cz>");
+MODULE_DESCRIPTION("Livepatch test: func_stack module");
diff --git a/tools/testing/selftests/livepatch/Makefile b/tools/testing/selftests/livepatch/Makefile
index 1acc9e1fa3fb..40f8a3a2e9aa 100644
--- a/tools/testing/selftests/livepatch/Makefile
+++ b/tools/testing/selftests/livepatch/Makefile
@@ -6,7 +6,8 @@ TEST_PROGS := \
 	test-callbacks.sh \
 	test-shadow-vars.sh \
 	test-state.sh \
-	test-ftrace.sh
+	test-ftrace.sh \
+	test-func-stack.sh
 
 TEST_FILES := settings
 
diff --git a/tools/testing/selftests/livepatch/test-func-stack.sh b/tools/testing/selftests/livepatch/test-func-stack.sh
new file mode 100755
index 000000000000..b7da62c9f5a1
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test-func-stack.sh
@@ -0,0 +1,88 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 Miroslav Benes <mbenes@suse.cz>
+
+. $(dirname $0)/functions.sh
+
+MOD_TARGET=test_klp_funcstack_mod
+MOD_LIVEPATCH=test_klp_funcstack_demo
+
+setup_config
+
+# - load a target module and call its parent_function(). It will sleep in its
+#   child_function() callee.
+# - load a live patch with new child2_function() called from parent_function()
+#   too. The patching does not wait for child_function() to return, because
+#   child2_function() is not on any stack.
+# - clean up afterwards
+
+start_test "non-blocking patching without the function on a stack"
+
+load_mod $MOD_TARGET
+
+(cat /sys/kernel/debug/test_klp_funcstack/parent_function) >/dev/null &
+PID=$!
+
+load_lp $MOD_LIVEPATCH
+
+wait $PID
+
+disable_lp $MOD_LIVEPATCH
+unload_lp $MOD_LIVEPATCH
+unload_mod $MOD_TARGET
+
+check_result "% modprobe $MOD_TARGET
+$MOD_TARGET: parent_function enter
+$MOD_TARGET: child_function enter
+% modprobe $MOD_LIVEPATCH
+livepatch: enabling patch '$MOD_LIVEPATCH'
+livepatch: '$MOD_LIVEPATCH': initializing patching transition
+livepatch: '$MOD_LIVEPATCH': starting patching transition
+livepatch: '$MOD_LIVEPATCH': completing patching transition
+livepatch: '$MOD_LIVEPATCH': patching complete
+$MOD_TARGET: child_function exit
+$MOD_LIVEPATCH: livepatch_child2_function
+$MOD_TARGET: parent_function exit
+% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
+livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
+livepatch: '$MOD_LIVEPATCH': starting unpatching transition
+livepatch: '$MOD_LIVEPATCH': completing unpatching transition
+livepatch: '$MOD_LIVEPATCH': unpatching complete
+% rmmod $MOD_LIVEPATCH
+% rmmod $MOD_TARGET"
+
+# Similar to the previous test but now the patching has to wait for
+# child2_function() to return, because parent_function() is also checked for.
+
+start_test "patching delayed due to the function on a stack"
+
+load_mod $MOD_TARGET
+
+(cat /sys/kernel/debug/test_klp_funcstack/parent_function) >/dev/null &
+
+load_lp $MOD_LIVEPATCH funcstack=1
+disable_lp $MOD_LIVEPATCH
+unload_lp $MOD_LIVEPATCH
+unload_mod $MOD_TARGET
+
+check_result "% modprobe $MOD_TARGET
+$MOD_TARGET: parent_function enter
+$MOD_TARGET: child_function enter
+% modprobe $MOD_LIVEPATCH funcstack=1
+livepatch: enabling patch '$MOD_LIVEPATCH'
+livepatch: '$MOD_LIVEPATCH': initializing patching transition
+livepatch: '$MOD_LIVEPATCH': starting patching transition
+$MOD_TARGET: child_function exit
+$MOD_TARGET: child2_function
+$MOD_TARGET: parent_function exit
+livepatch: '$MOD_LIVEPATCH': completing patching transition
+livepatch: '$MOD_LIVEPATCH': patching complete
+% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
+livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
+livepatch: '$MOD_LIVEPATCH': starting unpatching transition
+livepatch: '$MOD_LIVEPATCH': completing unpatching transition
+livepatch: '$MOD_LIVEPATCH': unpatching complete
+% rmmod $MOD_LIVEPATCH
+% rmmod $MOD_TARGET"
+
+exit 0
-- 
2.33.1

