Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8194700F0
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 13:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241289AbhLJMs1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 07:48:27 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:53756 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241161AbhLJMs1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 07:48:27 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DF93C1F3A1;
        Fri, 10 Dec 2021 12:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639140290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZSdh1gU5+gv5s2SwWyfKYGVCnMibI3IcD2jbR4Olt5U=;
        b=o0L4K8r19DIv4SKTa+ol0udxMOxOM9LPec1nUiUvFQn8uUzXrxK/uUEGTdZXuir+Mp5k+0
        m4YJKMZfIwzo2TNqYLwICSJXba+jnD6mred/pOZznjK5tjOUEZD64xIFcTZTHl3ZULGumC
        M1nRAEGh9iBOYpsIM6bUOW/X3jfs4RY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639140290;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZSdh1gU5+gv5s2SwWyfKYGVCnMibI3IcD2jbR4Olt5U=;
        b=ipIo9A67s6Jpt57dSa3A+UUNoeZaB4aQ9TYaMYaxC6+ReD1DwBxQjJ3wWGz3YA3kQGVYno
        D0mfSWwk0UjFwaDw==
Received: from san.suse.cz (san.suse.cz [10.100.12.79])
        by relay2.suse.de (Postfix) with ESMTP id C6C61A3B91;
        Fri, 10 Dec 2021 12:44:50 +0000 (UTC)
From:   Miroslav Benes <mbenes@suse.cz>
To:     jpoimboe@redhat.com, jikos@kernel.org, pmladek@suse.com,
        joe.lawrence@redhat.com
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 2/2] selftests/livepatch: Test of the API for specifying functions to search for on a stack
Date:   Fri, 10 Dec 2021 13:44:49 +0100
Message-Id: <20211210124449.21537-3-mbenes@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211210124449.21537-1-mbenes@suse.cz>
References: <20211210124449.21537-1-mbenes@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add tests for the API which allows the user to specify functions which
are then searched for on any tasks's stack during a transition process.

Signed-off-by: Miroslav Benes <mbenes@suse.cz>
---
 lib/livepatch/Makefile                        |   5 +-
 lib/livepatch/test_klp_func_stack_only_demo.c |  66 ++++++++
 .../test_klp_func_stack_only_demo2.c          |  61 +++++++
 lib/livepatch/test_klp_func_stack_only_mod.c  |  70 ++++++++
 tools/testing/selftests/livepatch/Makefile    |   3 +-
 .../livepatch/test-func-stack-only.sh         | 159 ++++++++++++++++++
 6 files changed, 362 insertions(+), 2 deletions(-)
 create mode 100644 lib/livepatch/test_klp_func_stack_only_demo.c
 create mode 100644 lib/livepatch/test_klp_func_stack_only_demo2.c
 create mode 100644 lib/livepatch/test_klp_func_stack_only_mod.c
 create mode 100755 tools/testing/selftests/livepatch/test-func-stack-only.sh

diff --git a/lib/livepatch/Makefile b/lib/livepatch/Makefile
index dcc912b3478f..ee149b74b20d 100644
--- a/lib/livepatch/Makefile
+++ b/lib/livepatch/Makefile
@@ -11,4 +11,7 @@ obj-$(CONFIG_TEST_LIVEPATCH) += test_klp_atomic_replace.o \
 				test_klp_shadow_vars.o \
 				test_klp_state.o \
 				test_klp_state2.o \
-				test_klp_state3.o
+				test_klp_state3.o \
+				test_klp_func_stack_only_mod.o \
+				test_klp_func_stack_only_demo.o \
+				test_klp_func_stack_only_demo2.o
diff --git a/lib/livepatch/test_klp_func_stack_only_demo.c b/lib/livepatch/test_klp_func_stack_only_demo.c
new file mode 100644
index 000000000000..db0a85d57f2e
--- /dev/null
+++ b/lib/livepatch/test_klp_func_stack_only_demo.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2021 Miroslav Benes <mbenes@suse.cz>
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/livepatch.h>
+
+static int func_stack_only;
+module_param(func_stack_only, int, 0644);
+MODULE_PARM_DESC(func_stack_only, "func_stack_only (default=0)");
+
+static void livepatch_child_function(void)
+{
+	pr_info("%s\n", __func__);
+}
+
+static struct klp_func funcs[] = {
+	{
+		.old_name = "child_function",
+		.new_func = livepatch_child_function,
+	}, {}
+};
+
+/* Used if func_stack_only module parameter is true */
+static struct klp_func funcs_stack_only[] = {
+	{
+		.old_name = "child_function",
+		.new_func = livepatch_child_function,
+	}, {
+		.old_name = "parent_function",
+		.stack_only = true,
+	}, {}
+};
+
+static struct klp_object objs[] = {
+	{
+		.name = "test_klp_func_stack_only_mod",
+		.funcs = funcs,
+	}, {}
+};
+
+static struct klp_patch patch = {
+	.mod = THIS_MODULE,
+	.objs = objs,
+};
+
+static int test_klp_func_stack_only_demo_init(void)
+{
+	if (func_stack_only)
+		objs[0].funcs = funcs_stack_only;
+
+	return klp_enable_patch(&patch);
+}
+
+static void test_klp_func_stack_only_demo_exit(void)
+{
+}
+
+module_init(test_klp_func_stack_only_demo_init);
+module_exit(test_klp_func_stack_only_demo_exit);
+MODULE_LICENSE("GPL");
+MODULE_INFO(livepatch, "Y");
+MODULE_AUTHOR("Miroslav Benes <mbenes@suse.cz>");
+MODULE_DESCRIPTION("Livepatch test: func_stack_only demo");
diff --git a/lib/livepatch/test_klp_func_stack_only_demo2.c b/lib/livepatch/test_klp_func_stack_only_demo2.c
new file mode 100644
index 000000000000..e1e166db73e6
--- /dev/null
+++ b/lib/livepatch/test_klp_func_stack_only_demo2.c
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
+static void livepatch_child_function(void)
+{
+	pr_info("%s\n", __func__);
+}
+
+static struct klp_func funcs_stack_only[] = {
+	{
+		.old_name = "child_function",
+		.new_func = livepatch_child_function,
+	}, {
+		.old_name = "parent_function",
+		.stack_only = true,
+	}, {}
+};
+
+static struct klp_func busymod_funcs[] = {
+	{
+		.old_name = "busymod_work_func",
+		.stack_only = true,
+	}, {}
+};
+
+static struct klp_object objs[] = {
+	{
+		.name = "test_klp_func_stack_only_mod",
+		.funcs = funcs_stack_only,
+	}, {
+		.name = "test_klp_callback_busy",
+		.funcs = busymod_funcs,
+	}, {}
+};
+
+static struct klp_patch patch = {
+	.mod = THIS_MODULE,
+	.objs = objs,
+};
+
+static int test_klp_func_stack_only_demo2_init(void)
+{
+	return klp_enable_patch(&patch);
+}
+
+static void test_klp_func_stack_only_demo2_exit(void)
+{
+}
+
+module_init(test_klp_func_stack_only_demo2_init);
+module_exit(test_klp_func_stack_only_demo2_exit);
+MODULE_LICENSE("GPL");
+MODULE_INFO(livepatch, "Y");
+MODULE_AUTHOR("Miroslav Benes <mbenes@suse.cz>");
+MODULE_DESCRIPTION("Livepatch test: func_stack_only demo 2");
diff --git a/lib/livepatch/test_klp_func_stack_only_mod.c b/lib/livepatch/test_klp_func_stack_only_mod.c
new file mode 100644
index 000000000000..0876c7bcc671
--- /dev/null
+++ b/lib/livepatch/test_klp_func_stack_only_mod.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2021 Miroslav Benes <mbenes@suse.cz>
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/completion.h>
+#include <linux/workqueue.h>
+
+/* Controls whether parent_function() waits for completion */
+static bool block_transition;
+module_param(block_transition, bool, 0644);
+MODULE_PARM_DESC(block_transition, "block_transition (default=false)");
+
+/*
+ * work_started completion allows the _init function to make sure that the work
+ *              (parent_function() is really scheduled and executed before
+ *              returning. It solves a possible race.
+ * finish completion causes parent_function() to wait (if block_transition is
+ *        true) and thus it might block the live patching transition if
+ *        parent_function() is specified as stack_only function.
+ */
+static DECLARE_COMPLETION(work_started);
+static DECLARE_COMPLETION(finish);
+
+static noinline void child_function(void)
+{
+	pr_info("%s\n", __func__);
+}
+
+static void parent_function(struct work_struct *work)
+{
+	pr_info("%s enter\n", __func__);
+
+	complete(&work_started);
+
+	child_function();
+
+	if (block_transition)
+		wait_for_completion(&finish);
+
+	pr_info("%s exit\n", __func__);
+}
+
+static DECLARE_WORK(work, parent_function);
+
+static int test_klp_func_stack_only_mod_init(void)
+{
+	pr_info("%s\n", __func__);
+
+	schedule_work(&work);
+	wait_for_completion(&work_started);
+
+	return 0;
+}
+
+static void test_klp_func_stack_only_mod_exit(void)
+{
+	pr_info("%s\n", __func__);
+
+	complete(&finish);
+	flush_work(&work);
+}
+
+module_init(test_klp_func_stack_only_mod_init);
+module_exit(test_klp_func_stack_only_mod_exit);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Miroslav Benes <mbenes@suse.cz>");
+MODULE_DESCRIPTION("Livepatch test: func_stack_only module");
diff --git a/tools/testing/selftests/livepatch/Makefile b/tools/testing/selftests/livepatch/Makefile
index 1acc9e1fa3fb..1223e90d9f05 100644
--- a/tools/testing/selftests/livepatch/Makefile
+++ b/tools/testing/selftests/livepatch/Makefile
@@ -6,7 +6,8 @@ TEST_PROGS := \
 	test-callbacks.sh \
 	test-shadow-vars.sh \
 	test-state.sh \
-	test-ftrace.sh
+	test-ftrace.sh \
+	test-func-stack-only.sh
 
 TEST_FILES := settings
 
diff --git a/tools/testing/selftests/livepatch/test-func-stack-only.sh b/tools/testing/selftests/livepatch/test-func-stack-only.sh
new file mode 100755
index 000000000000..326b002f9297
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test-func-stack-only.sh
@@ -0,0 +1,159 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 Miroslav Benes <mbenes@suse.cz>
+
+# The tests for stack_only API which allows users to specify functions to be
+# search for on a stack.
+
+. $(dirname $0)/functions.sh
+
+MOD_TARGET=test_klp_func_stack_only_mod
+MOD_TARGET_BUSY=test_klp_callbacks_busy
+MOD_LIVEPATCH=test_klp_func_stack_only_demo
+MOD_LIVEPATCH2=test_klp_func_stack_only_demo2
+MOD_REPLACE=test_klp_atomic_replace
+
+setup_config
+
+# Non-blocking test. parent_function() calls child_function() and sleeps. The
+# live patch patches child_function(). The test does not use stack_only API and
+# the live patching transition finishes immediately.
+#
+# - load a target module and let its parent_function() sleep
+# - load a live patch which patches child_function()
+# - the transition does not block, because parent_function() is not checked for
+#   its presence on a stack
+# - clean up afterwards
+
+start_test "non-blocking patching without the function on a stack"
+
+load_mod $MOD_TARGET block_transition=1
+load_lp $MOD_LIVEPATCH
+disable_lp $MOD_LIVEPATCH
+unload_lp $MOD_LIVEPATCH
+unload_mod $MOD_TARGET
+
+check_result "% modprobe $MOD_TARGET block_transition=1
+$MOD_TARGET: ${MOD_TARGET}_init
+$MOD_TARGET: parent_function enter
+$MOD_TARGET: child_function
+% modprobe $MOD_LIVEPATCH
+livepatch: enabling patch '$MOD_LIVEPATCH'
+livepatch: '$MOD_LIVEPATCH': initializing patching transition
+livepatch: '$MOD_LIVEPATCH': starting patching transition
+livepatch: '$MOD_LIVEPATCH': completing patching transition
+livepatch: '$MOD_LIVEPATCH': patching complete
+% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
+livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
+livepatch: '$MOD_LIVEPATCH': starting unpatching transition
+livepatch: '$MOD_LIVEPATCH': completing unpatching transition
+livepatch: '$MOD_LIVEPATCH': unpatching complete
+% rmmod $MOD_LIVEPATCH
+% rmmod $MOD_TARGET
+$MOD_TARGET: ${MOD_TARGET}_exit
+$MOD_TARGET: parent_function exit"
+
+# Blocking version of the previous test. stack_only is now set for
+# parent_function(). The transition is blocked.
+#
+# - load a target module and let its parent_function() sleep
+# - load a live patch which patches child_function() and specifies
+#   parent_function() as a stack_only function
+# - the transition blocks, because parent_function() is present on a stack
+#   while sleeping there
+# - clean up afterwards
+
+start_test "patching blocked due to the function on a stack"
+
+load_mod $MOD_TARGET block_transition=1
+load_lp_nowait $MOD_LIVEPATCH func_stack_only=1
+
+# Wait until the livepatch reports in-transition state, i.e. that it's
+# stalled on $MOD_TARGET::parent_function()
+loop_until 'grep -q '^1$' /sys/kernel/livepatch/$MOD_LIVEPATCH/transition' ||
+	die "failed to stall transition"
+
+disable_lp $MOD_LIVEPATCH
+unload_lp $MOD_LIVEPATCH
+unload_mod $MOD_TARGET
+
+check_result "% modprobe $MOD_TARGET block_transition=1
+$MOD_TARGET: ${MOD_TARGET}_init
+$MOD_TARGET: parent_function enter
+$MOD_TARGET: child_function
+% modprobe $MOD_LIVEPATCH func_stack_only=1
+livepatch: enabling patch '$MOD_LIVEPATCH'
+livepatch: '$MOD_LIVEPATCH': initializing patching transition
+livepatch: '$MOD_LIVEPATCH': starting patching transition
+% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
+livepatch: '$MOD_LIVEPATCH': reversing transition from patching to unpatching
+livepatch: '$MOD_LIVEPATCH': starting unpatching transition
+livepatch: '$MOD_LIVEPATCH': completing unpatching transition
+livepatch: '$MOD_LIVEPATCH': unpatching complete
+% rmmod $MOD_LIVEPATCH
+% rmmod $MOD_TARGET
+$MOD_TARGET: ${MOD_TARGET}_exit
+$MOD_TARGET: parent_function exit"
+
+# Test an atomic replace live patch on top of stack_only live patch. The aim is
+# to test the correct handling of nop functions in stack_only environment.
+#
+# - load a target module and do not let its parent_function() sleep
+# - load a busy target module but do not let its busymod_work_func() sleep.
+#   This is only to have another target module loaded for the next steps.
+# - load a stack_only live patch. It patches the first target module and
+#   defines parent_function() to be stack_only. So there is a klp_object with
+#   both !stack_only and stack_only functions. The live patch also has another
+#   klp_object with busymod_work_func() as stack_only function (and nothing
+#   else). The live patch is smoothly applied because there is no blocking
+#   involved.
+# - load atomic replace live patch which patches a function in vmlinux. No nop
+#   function should be created for stack_only functions
+# - clean up afterwards
+
+start_test "atomic replace on top of a stack_only live patch"
+
+load_mod $MOD_TARGET
+load_mod $MOD_TARGET_BUSY
+load_lp $MOD_LIVEPATCH2
+load_lp $MOD_REPLACE replace=1
+disable_lp $MOD_REPLACE
+unload_lp $MOD_REPLACE
+unload_lp $MOD_LIVEPATCH2
+unload_mod $MOD_TARGET_BUSY
+unload_mod $MOD_TARGET
+
+check_result "% modprobe $MOD_TARGET
+$MOD_TARGET: ${MOD_TARGET}_init
+$MOD_TARGET: parent_function enter
+$MOD_TARGET: child_function
+$MOD_TARGET: parent_function exit
+% modprobe $MOD_TARGET_BUSY
+$MOD_TARGET_BUSY: ${MOD_TARGET_BUSY}_init
+$MOD_TARGET_BUSY: busymod_work_func enter
+$MOD_TARGET_BUSY: busymod_work_func exit
+% modprobe $MOD_LIVEPATCH2
+livepatch: enabling patch '$MOD_LIVEPATCH2'
+livepatch: '$MOD_LIVEPATCH2': initializing patching transition
+livepatch: '$MOD_LIVEPATCH2': starting patching transition
+livepatch: '$MOD_LIVEPATCH2': completing patching transition
+livepatch: '$MOD_LIVEPATCH2': patching complete
+% modprobe $MOD_REPLACE replace=1
+livepatch: enabling patch '$MOD_REPLACE'
+livepatch: '$MOD_REPLACE': initializing patching transition
+livepatch: '$MOD_REPLACE': starting patching transition
+livepatch: '$MOD_REPLACE': completing patching transition
+livepatch: '$MOD_REPLACE': patching complete
+% echo 0 > /sys/kernel/livepatch/$MOD_REPLACE/enabled
+livepatch: '$MOD_REPLACE': initializing unpatching transition
+livepatch: '$MOD_REPLACE': starting unpatching transition
+livepatch: '$MOD_REPLACE': completing unpatching transition
+livepatch: '$MOD_REPLACE': unpatching complete
+% rmmod $MOD_REPLACE
+% rmmod $MOD_LIVEPATCH2
+% rmmod $MOD_TARGET_BUSY
+$MOD_TARGET_BUSY: ${MOD_TARGET_BUSY}_exit
+% rmmod $MOD_TARGET
+$MOD_TARGET: ${MOD_TARGET}_exit"
+
+exit 0
-- 
2.34.1

