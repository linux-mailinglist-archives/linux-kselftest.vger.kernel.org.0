Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5040DD8FA1
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2019 13:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392794AbfJPLd1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Oct 2019 07:33:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:35654 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391089AbfJPLdW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Oct 2019 07:33:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0EBDCB18D;
        Wed, 16 Oct 2019 11:33:20 +0000 (UTC)
From:   Miroslav Benes <mbenes@suse.cz>
To:     rostedt@goodmis.org, mingo@redhat.com, jpoimboe@redhat.com,
        jikos@kernel.org, pmladek@suse.com, joe.lawrence@redhat.com
Cc:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        shuah@kernel.org, kamalesh@linux.vnet.ibm.com,
        linux-kselftest@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v3 3/3] selftests/livepatch: Test interaction with ftrace_enabled
Date:   Wed, 16 Oct 2019 13:33:15 +0200
Message-Id: <20191016113316.13415-4-mbenes@suse.cz>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016113316.13415-1-mbenes@suse.cz>
References: <20191016113316.13415-1-mbenes@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Joe Lawrence <joe.lawrence@redhat.com>

Since livepatching depends upon ftrace handlers to implement "patched"
code functionality, verify that the ftrace_enabled sysctl value
interacts with livepatch registration as expected.  At the same time,
ensure that ftrace_enabled is set and part of the test environment
configuration that is saved and restored when running the selftests.

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Miroslav Benes <mbenes@suse.cz>
---
 tools/testing/selftests/livepatch/Makefile    |  3 +-
 .../testing/selftests/livepatch/functions.sh  | 14 +++-
 .../selftests/livepatch/test-ftrace.sh        | 65 +++++++++++++++++++
 3 files changed, 80 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/livepatch/test-ftrace.sh

diff --git a/tools/testing/selftests/livepatch/Makefile b/tools/testing/selftests/livepatch/Makefile
index fd405402c3ff..1886d9d94b88 100644
--- a/tools/testing/selftests/livepatch/Makefile
+++ b/tools/testing/selftests/livepatch/Makefile
@@ -4,6 +4,7 @@ TEST_PROGS_EXTENDED := functions.sh
 TEST_PROGS := \
 	test-livepatch.sh \
 	test-callbacks.sh \
-	test-shadow-vars.sh
+	test-shadow-vars.sh \
+	test-ftrace.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index b7e5a67ae434..31eb09e38729 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -32,12 +32,16 @@ function die() {
 function push_config() {
 	DYNAMIC_DEBUG=$(grep '^kernel/livepatch' /sys/kernel/debug/dynamic_debug/control | \
 			awk -F'[: ]' '{print "file " $1 " line " $2 " " $4}')
+	FTRACE_ENABLED=$(sysctl --values kernel.ftrace_enabled)
 }
 
 function pop_config() {
 	if [[ -n "$DYNAMIC_DEBUG" ]]; then
 		echo -n "$DYNAMIC_DEBUG" > /sys/kernel/debug/dynamic_debug/control
 	fi
+	if [[ -n "$FTRACE_ENABLED" ]]; then
+		sysctl kernel.ftrace_enabled="$FTRACE_ENABLED" &> /dev/null
+	fi
 }
 
 function set_dynamic_debug() {
@@ -47,12 +51,20 @@ function set_dynamic_debug() {
 		EOF
 }
 
+function set_ftrace_enabled() {
+	local sysctl="$1"
+	result=$(sysctl kernel.ftrace_enabled="$1" 2>&1 | paste --serial --delimiters=' ')
+	echo "livepatch: $result" > /dev/kmsg
+}
+
 # setup_config - save the current config and set a script exit trap that
 #		 restores the original config.  Setup the dynamic debug
-#		 for verbose livepatching output.
+#		 for verbose livepatching output and turn on
+#		 the ftrace_enabled sysctl.
 function setup_config() {
 	push_config
 	set_dynamic_debug
+	set_ftrace_enabled 1
 	trap pop_config EXIT INT TERM HUP
 }
 
diff --git a/tools/testing/selftests/livepatch/test-ftrace.sh b/tools/testing/selftests/livepatch/test-ftrace.sh
new file mode 100755
index 000000000000..e2a76887f40a
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test-ftrace.sh
@@ -0,0 +1,65 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2019 Joe Lawrence <joe.lawrence@redhat.com>
+
+. $(dirname $0)/functions.sh
+
+MOD_LIVEPATCH=test_klp_livepatch
+
+setup_config
+
+
+# TEST: livepatch interaction with ftrace_enabled sysctl
+# - turn ftrace_enabled OFF and verify livepatches can't load
+# - turn ftrace_enabled ON and verify livepatch can load
+# - verify that ftrace_enabled can't be turned OFF while a livepatch is loaded
+
+echo -n "TEST: livepatch interaction with ftrace_enabled sysctl ... "
+dmesg -C
+
+set_ftrace_enabled 0
+load_failing_mod $MOD_LIVEPATCH
+
+set_ftrace_enabled 1
+load_lp $MOD_LIVEPATCH
+if [[ "$(cat /proc/cmdline)" != "$MOD_LIVEPATCH: this has been live patched" ]] ; then
+	echo -e "FAIL\n\n"
+	die "livepatch kselftest(s) failed"
+fi
+
+set_ftrace_enabled 0
+if [[ "$(cat /proc/cmdline)" != "$MOD_LIVEPATCH: this has been live patched" ]] ; then
+	echo -e "FAIL\n\n"
+	die "livepatch kselftest(s) failed"
+fi
+disable_lp $MOD_LIVEPATCH
+unload_lp $MOD_LIVEPATCH
+
+check_result "livepatch: kernel.ftrace_enabled = 0
+% modprobe $MOD_LIVEPATCH
+livepatch: enabling patch '$MOD_LIVEPATCH'
+livepatch: '$MOD_LIVEPATCH': initializing patching transition
+livepatch: failed to register ftrace handler for function 'cmdline_proc_show' (-16)
+livepatch: failed to patch object 'vmlinux'
+livepatch: failed to enable patch '$MOD_LIVEPATCH'
+livepatch: '$MOD_LIVEPATCH': canceling patching transition, going to unpatch
+livepatch: '$MOD_LIVEPATCH': completing unpatching transition
+livepatch: '$MOD_LIVEPATCH': unpatching complete
+modprobe: ERROR: could not insert '$MOD_LIVEPATCH': Device or resource busy
+livepatch: kernel.ftrace_enabled = 1
+% modprobe $MOD_LIVEPATCH
+livepatch: enabling patch '$MOD_LIVEPATCH'
+livepatch: '$MOD_LIVEPATCH': initializing patching transition
+livepatch: '$MOD_LIVEPATCH': starting patching transition
+livepatch: '$MOD_LIVEPATCH': completing patching transition
+livepatch: '$MOD_LIVEPATCH': patching complete
+livepatch: sysctl: setting key \"kernel.ftrace_enabled\": Device or resource busy kernel.ftrace_enabled = 0
+% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
+livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
+livepatch: '$MOD_LIVEPATCH': starting unpatching transition
+livepatch: '$MOD_LIVEPATCH': completing unpatching transition
+livepatch: '$MOD_LIVEPATCH': unpatching complete
+% rmmod $MOD_LIVEPATCH"
+
+
+exit 0
-- 
2.23.0

