Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74BBA1F9E6B
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jun 2020 19:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731179AbgFOR2M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Jun 2020 13:28:12 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20932 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730701AbgFOR2I (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Jun 2020 13:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592242085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9S5C17KTvbneCxeppsrgBPiLMf0Y0EaiwRVXjNY5uyo=;
        b=RkFCQFZ5eXM75fo+Ab9rjrHhqOVhX3Hvb7GKIHmGqPmaGZM7OC4PB3nIglLcSvbxdmbusn
        /g0+3GGQ6b9E/TLGIFK3uVAxFQ0PmQZ+80QwbevLgCDfvTP5DWgyFdqaFCccFDD/PQMpz9
        +LHbkr4yH/WGgusO6pfzXs/Uj1E+HbQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-ehUxeh0ONhCP18_K7PiEjA-1; Mon, 15 Jun 2020 13:28:01 -0400
X-MC-Unique: ehUxeh0ONhCP18_K7PiEjA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94B27184D146;
        Mon, 15 Jun 2020 17:27:59 +0000 (UTC)
Received: from jlaw-desktop.redhat.com (ovpn-112-56.rdu2.redhat.com [10.10.112.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D62F119C66;
        Mon, 15 Jun 2020 17:27:58 +0000 (UTC)
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 1/4] selftests/livepatch: Don't clear dmesg when running tests
Date:   Mon, 15 Jun 2020 13:27:53 -0400
Message-Id: <20200615172756.12912-2-joe.lawrence@redhat.com>
In-Reply-To: <20200615172756.12912-1-joe.lawrence@redhat.com>
References: <20200615172756.12912-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Inspired by commit f131d9edc29d ("selftests/lkdtm: Don't clear dmesg
when running tests"), keep a reference dmesg copy when beginning each
test.  This way check_result() can compare against the initial copy
rather than relying upon an empty log.

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 tools/testing/selftests/livepatch/README      | 16 +++---
 .../testing/selftests/livepatch/functions.sh  | 31 ++++++++++-
 .../selftests/livepatch/test-callbacks.sh     | 55 ++++---------------
 .../selftests/livepatch/test-ftrace.sh        |  4 +-
 .../selftests/livepatch/test-livepatch.sh     | 12 +---
 .../selftests/livepatch/test-shadow-vars.sh   |  4 +-
 .../testing/selftests/livepatch/test-state.sh | 21 +++----
 7 files changed, 62 insertions(+), 81 deletions(-)

diff --git a/tools/testing/selftests/livepatch/README b/tools/testing/selftests/livepatch/README
index 621d325425c2..0942dd5826f8 100644
--- a/tools/testing/selftests/livepatch/README
+++ b/tools/testing/selftests/livepatch/README
@@ -6,8 +6,8 @@ This is a small set of sanity tests for the kernel livepatching.
 
 The test suite loads and unloads several test kernel modules to verify
 livepatch behavior.  Debug information is logged to the kernel's message
-buffer and parsed for expected messages.  (Note: the tests will clear
-the message buffer between individual tests.)
+buffer and parsed for expected messages.  (Note: the tests will compare
+the message buffer for only the duration of each individual test.)
 
 
 Config
@@ -35,9 +35,9 @@ Adding tests
 ------------
 
 See the common functions.sh file for the existing collection of utility
-functions, most importantly setup_config() and check_result().  The
-latter function greps the kernel's ring buffer for "livepatch:" and
-"test_klp" strings, so tests be sure to include one of those strings for
-result comparison.  Other utility functions include general module
-loading and livepatch loading helpers (waiting for patch transitions,
-sysfs entries, etc.)
+functions, most importantly setup_config(), start_test() and
+check_result().  The latter function greps the kernel's ring buffer for
+"livepatch:" and "test_klp" strings, so tests be sure to include one of
+those strings for result comparison.  Other utility functions include
+general module loading and livepatch loading helpers (waiting for patch
+transitions, sysfs entries, etc.)
diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index 2aab9791791d..7ac3aa20f403 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -41,6 +41,17 @@ function die() {
 	exit 1
 }
 
+# save existing dmesg so we can detect new content
+function save_dmesg() {
+	SAVED_DMESG=$(mktemp --tmpdir -t klp-dmesg-XXXXXX)
+	dmesg > "$SAVED_DMESG"
+}
+
+# cleanup temporary dmesg file from save_dmesg()
+function cleanup_dmesg_file() {
+	rm -f "$SAVED_DMESG"
+}
+
 function push_config() {
 	DYNAMIC_DEBUG=$(grep '^kernel/livepatch' /sys/kernel/debug/dynamic_debug/control | \
 			awk -F'[: ]' '{print "file " $1 " line " $2 " " $4}')
@@ -68,6 +79,11 @@ function set_ftrace_enabled() {
 	echo "livepatch: $result" > /dev/kmsg
 }
 
+function cleanup() {
+	pop_config
+	cleanup_dmesg_file
+}
+
 # setup_config - save the current config and set a script exit trap that
 #		 restores the original config.  Setup the dynamic debug
 #		 for verbose livepatching output and turn on
@@ -77,7 +93,7 @@ function setup_config() {
 	push_config
 	set_dynamic_debug
 	set_ftrace_enabled 1
-	trap pop_config EXIT INT TERM HUP
+	trap cleanup EXIT INT TERM HUP
 }
 
 # loop_until(cmd) - loop a command until it is successful or $MAX_RETRIES,
@@ -243,13 +259,22 @@ function set_pre_patch_ret {
 		die "failed to set pre_patch_ret parameter for $mod module"
 }
 
+function start_test {
+	local test="$1"
+
+	save_dmesg
+	echo -n "TEST: $test ... "
+}
+
 # check_result() - verify dmesg output
 #	TODO - better filter, out of order msgs, etc?
 function check_result {
 	local expect="$*"
 	local result
 
-	result=$(dmesg | grep -v 'tainting' | grep -e 'livepatch:' -e 'test_klp' | sed 's/^\[[ 0-9.]*\] //')
+	result=$(dmesg | diff --changed-group-format='%>' --unchanged-group-format='' "$SAVED_DMESG" - | \
+		 grep -v 'tainting' | grep -e 'livepatch:' -e 'test_klp' | \
+		 sed 's/^\[[ 0-9.]*\] //')
 
 	if [[ "$expect" == "$result" ]] ; then
 		echo "ok"
@@ -257,4 +282,6 @@ function check_result {
 		echo -e "not ok\n\n$(diff -upr --label expected --label result <(echo "$expect") <(echo "$result"))\n"
 		die "livepatch kselftest(s) failed"
 	fi
+
+	cleanup_dmesg_file
 }
diff --git a/tools/testing/selftests/livepatch/test-callbacks.sh b/tools/testing/selftests/livepatch/test-callbacks.sh
index 32b57ba07f4f..90b26dbb2626 100755
--- a/tools/testing/selftests/livepatch/test-callbacks.sh
+++ b/tools/testing/selftests/livepatch/test-callbacks.sh
@@ -12,8 +12,6 @@ MOD_TARGET_BUSY=test_klp_callbacks_busy
 setup_config
 
 
-# TEST: target module before livepatch
-#
 # Test a combination of loading a kernel module and a livepatch that
 # patches a function in the first module.  Load the target module
 # before the livepatch module.  Unload them in the same order.
@@ -28,8 +26,7 @@ setup_config
 #   unpatching transition starts.  klp_objects are reverted, post-patch
 #   callbacks execute and the transition completes.
 
-echo -n "TEST: target module before livepatch ... "
-dmesg -C
+start_test "target module before livepatch"
 
 load_mod $MOD_TARGET
 load_lp $MOD_LIVEPATCH
@@ -63,8 +60,6 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 $MOD_TARGET: ${MOD_TARGET}_exit"
 
 
-# TEST: module_coming notifier
-#
 # This test is similar to the previous test, but (un)load the livepatch
 # module before the target kernel module.  This tests the livepatch
 # core's module_coming handler.
@@ -78,8 +73,7 @@ $MOD_TARGET: ${MOD_TARGET}_exit"
 # - On livepatch disable, all currently loaded klp_objects' (vmlinux and
 #   $MOD_TARGET) pre/post-unpatch callbacks are executed.
 
-echo -n "TEST: module_coming notifier ... "
-dmesg -C
+start_test "module_coming notifier"
 
 load_lp $MOD_LIVEPATCH
 load_mod $MOD_TARGET
@@ -114,8 +108,6 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 $MOD_TARGET: ${MOD_TARGET}_exit"
 
 
-# TEST: module_going notifier
-#
 # Test loading the livepatch after a targeted kernel module, then unload
 # the kernel module before disabling the livepatch.  This tests the
 # livepatch core's module_going handler.
@@ -129,8 +121,7 @@ $MOD_TARGET: ${MOD_TARGET}_exit"
 # - When the livepatch is disabled, pre and post-unpatch callbacks are
 #   run for the remaining klp_object, vmlinux.
 
-echo -n "TEST: module_going notifier ... "
-dmesg -C
+start_test "module_going notifier"
 
 load_mod $MOD_TARGET
 load_lp $MOD_LIVEPATCH
@@ -165,8 +156,6 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 % rmmod $MOD_LIVEPATCH"
 
 
-# TEST: module_coming and module_going notifiers
-#
 # This test is similar to the previous test, however the livepatch is
 # loaded first.  This tests the livepatch core's module_coming and
 # module_going handlers.
@@ -180,8 +169,7 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 #   from the $MOD_TARGET klp_object.  As such, only pre and
 #   post-unpatch callbacks are executed when this occurs.
 
-echo -n "TEST: module_coming and module_going notifiers ... "
-dmesg -C
+start_test "module_coming and module_going notifiers"
 
 load_lp $MOD_LIVEPATCH
 load_mod $MOD_TARGET
@@ -217,8 +205,6 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 % rmmod $MOD_LIVEPATCH"
 
 
-# TEST: target module not present
-#
 # A simple test of loading a livepatch without one of its patch target
 # klp_objects ever loaded ($MOD_TARGET).
 #
@@ -227,8 +213,7 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 # - As expected, only pre/post-(un)patch handlers are executed for
 #   vmlinux.
 
-echo -n "TEST: target module not present ... "
-dmesg -C
+start_test "target module not present"
 
 load_lp $MOD_LIVEPATCH
 disable_lp $MOD_LIVEPATCH
@@ -252,8 +237,6 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 % rmmod $MOD_LIVEPATCH"
 
 
-# TEST: pre-patch callback -ENODEV
-#
 # Test a scenario where a vmlinux pre-patch callback returns a non-zero
 # status (ie, failure).
 #
@@ -265,8 +248,7 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 #   The result is that the insmod command refuses to load the livepatch
 #   module.
 
-echo -n "TEST: pre-patch callback -ENODEV ... "
-dmesg -C
+start_test "pre-patch callback -ENODEV"
 
 load_mod $MOD_TARGET
 load_failing_mod $MOD_LIVEPATCH pre_patch_ret=-19
@@ -288,8 +270,6 @@ modprobe: ERROR: could not insert '$MOD_LIVEPATCH': No such device
 $MOD_TARGET: ${MOD_TARGET}_exit"
 
 
-# TEST: module_coming + pre-patch callback -ENODEV
-#
 # Similar to the previous test, setup a livepatch such that its vmlinux
 # pre-patch callback returns success.  However, when a targeted kernel
 # module is later loaded, have the livepatch return a failing status
@@ -307,8 +287,7 @@ $MOD_TARGET: ${MOD_TARGET}_exit"
 #
 # - Pre/post-unpatch callbacks are run for the vmlinux klp_object.
 
-echo -n "TEST: module_coming + pre-patch callback -ENODEV ... "
-dmesg -C
+start_test "module_coming + pre-patch callback -ENODEV"
 
 load_lp $MOD_LIVEPATCH
 set_pre_patch_ret $MOD_LIVEPATCH -19
@@ -341,8 +320,6 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 % rmmod $MOD_LIVEPATCH"
 
 
-# TEST: multiple target modules
-#
 # Test loading multiple targeted kernel modules.  This test-case is
 # mainly for comparing with the next test-case.
 #
@@ -353,8 +330,7 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 #   module.  Post-patch callbacks are executed and the transition
 #   completes quickly.
 
-echo -n "TEST: multiple target modules ... "
-dmesg -C
+start_test "multiple target modules"
 
 load_mod $MOD_TARGET_BUSY block_transition=N
 load_lp $MOD_LIVEPATCH
@@ -402,8 +378,6 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 $MOD_TARGET_BUSY: ${MOD_TARGET_BUSY}_exit"
 
 
-# TEST: busy target module
-#
 # A similar test as the previous one, but force the "busy" kernel module
 # to block the livepatch transition.
 #
@@ -431,8 +405,7 @@ $MOD_TARGET_BUSY: ${MOD_TARGET_BUSY}_exit"
 #   klp_object's post-patch callbacks executed, the remaining
 #   klp_object's pre-unpatch callbacks are skipped.
 
-echo -n "TEST: busy target module ... "
-dmesg -C
+start_test "busy target module"
 
 load_mod $MOD_TARGET_BUSY block_transition=Y
 load_lp_nowait $MOD_LIVEPATCH
@@ -478,8 +451,6 @@ $MOD_TARGET_BUSY: busymod_work_func exit
 $MOD_TARGET_BUSY: ${MOD_TARGET_BUSY}_exit"
 
 
-# TEST: multiple livepatches
-#
 # Test loading multiple livepatches.  This test-case is mainly for comparing
 # with the next test-case.
 #
@@ -487,8 +458,7 @@ $MOD_TARGET_BUSY: ${MOD_TARGET_BUSY}_exit"
 #   execute as each patch progresses through its (un)patching
 #   transition.
 
-echo -n "TEST: multiple livepatches ... "
-dmesg -C
+start_test "multiple livepatches"
 
 load_lp $MOD_LIVEPATCH
 load_lp $MOD_LIVEPATCH2
@@ -531,8 +501,6 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 % rmmod $MOD_LIVEPATCH"
 
 
-# TEST: atomic replace
-#
 # Load multiple livepatches, but the second as an 'atomic-replace'
 # patch.  When the latter loads, the original livepatch should be
 # disabled and *none* of its pre/post-unpatch callbacks executed.  On
@@ -547,8 +515,7 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 # - Once the atomic replace module is loaded, only its pre and post
 #   unpatch callbacks are executed.
 
-echo -n "TEST: atomic replace ... "
-dmesg -C
+start_test "atomic replace"
 
 load_lp $MOD_LIVEPATCH
 load_lp $MOD_LIVEPATCH2 replace=1
diff --git a/tools/testing/selftests/livepatch/test-ftrace.sh b/tools/testing/selftests/livepatch/test-ftrace.sh
index e2a76887f40a..9160c9ec3b6f 100755
--- a/tools/testing/selftests/livepatch/test-ftrace.sh
+++ b/tools/testing/selftests/livepatch/test-ftrace.sh
@@ -9,13 +9,11 @@ MOD_LIVEPATCH=test_klp_livepatch
 setup_config
 
 
-# TEST: livepatch interaction with ftrace_enabled sysctl
 # - turn ftrace_enabled OFF and verify livepatches can't load
 # - turn ftrace_enabled ON and verify livepatch can load
 # - verify that ftrace_enabled can't be turned OFF while a livepatch is loaded
 
-echo -n "TEST: livepatch interaction with ftrace_enabled sysctl ... "
-dmesg -C
+start_test "livepatch interaction with ftrace_enabled sysctl"
 
 set_ftrace_enabled 0
 load_failing_mod $MOD_LIVEPATCH
diff --git a/tools/testing/selftests/livepatch/test-livepatch.sh b/tools/testing/selftests/livepatch/test-livepatch.sh
index 493e3df415a1..5fe79ac34be1 100755
--- a/tools/testing/selftests/livepatch/test-livepatch.sh
+++ b/tools/testing/selftests/livepatch/test-livepatch.sh
@@ -10,13 +10,11 @@ MOD_REPLACE=test_klp_atomic_replace
 setup_config
 
 
-# TEST: basic function patching
 # - load a livepatch that modifies the output from /proc/cmdline and
 #   verify correct behavior
 # - unload the livepatch and make sure the patch was removed
 
-echo -n "TEST: basic function patching ... "
-dmesg -C
+start_test "basic function patching"
 
 load_lp $MOD_LIVEPATCH
 
@@ -47,15 +45,13 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 % rmmod $MOD_LIVEPATCH"
 
 
-# TEST: multiple livepatches
 # - load a livepatch that modifies the output from /proc/cmdline and
 #   verify correct behavior
 # - load another livepatch and verify that both livepatches are active
 # - unload the second livepatch and verify that the first is still active
 # - unload the first livepatch and verify none are active
 
-echo -n "TEST: multiple livepatches ... "
-dmesg -C
+start_test "multiple livepatches"
 
 load_lp $MOD_LIVEPATCH
 
@@ -109,7 +105,6 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 % rmmod $MOD_LIVEPATCH"
 
 
-# TEST: atomic replace livepatch
 # - load a livepatch that modifies the output from /proc/cmdline and
 #   verify correct behavior
 # - load an atomic replace livepatch and verify that only the second is active
@@ -117,8 +112,7 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 #   is still active
 # - remove the atomic replace livepatch and verify that none are active
 
-echo -n "TEST: atomic replace livepatch ... "
-dmesg -C
+start_test "atomic replace livepatch"
 
 load_lp $MOD_LIVEPATCH
 
diff --git a/tools/testing/selftests/livepatch/test-shadow-vars.sh b/tools/testing/selftests/livepatch/test-shadow-vars.sh
index 7c016548c2ea..e04cb354f56b 100755
--- a/tools/testing/selftests/livepatch/test-shadow-vars.sh
+++ b/tools/testing/selftests/livepatch/test-shadow-vars.sh
@@ -9,11 +9,9 @@ MOD_TEST=test_klp_shadow_vars
 setup_config
 
 
-# TEST: basic shadow variable API
 # - load a module that exercises the shadow variable API
 
-echo -n "TEST: basic shadow variable API ... "
-dmesg -C
+start_test "basic shadow variable API"
 
 load_mod $MOD_TEST
 unload_mod $MOD_TEST
diff --git a/tools/testing/selftests/livepatch/test-state.sh b/tools/testing/selftests/livepatch/test-state.sh
index a08212708115..38656721c958 100755
--- a/tools/testing/selftests/livepatch/test-state.sh
+++ b/tools/testing/selftests/livepatch/test-state.sh
@@ -10,10 +10,10 @@ MOD_LIVEPATCH3=test_klp_state3
 
 setup_config
 
-# TEST: Loading and removing a module that modifies the system state
 
-echo -n "TEST: system state modification ... "
-dmesg -C
+# Load and remove a module that modifies the system state
+
+start_test "system state modification"
 
 load_lp $MOD_LIVEPATCH
 disable_lp $MOD_LIVEPATCH
@@ -41,10 +41,9 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 % rmmod $MOD_LIVEPATCH"
 
 
-# TEST: Take over system state change by a cumulative patch
+# Take over system state change by a cumulative patch
 
-echo -n "TEST: taking over system state modification ... "
-dmesg -C
+start_test "taking over system state modification"
 
 load_lp $MOD_LIVEPATCH
 load_lp $MOD_LIVEPATCH2
@@ -85,10 +84,9 @@ livepatch: '$MOD_LIVEPATCH2': unpatching complete
 % rmmod $MOD_LIVEPATCH2"
 
 
-# TEST: Take over system state change by a cumulative patch
+# Take over system state change by a cumulative patch
 
-echo -n "TEST: compatible cumulative livepatches ... "
-dmesg -C
+start_test "compatible cumulative livepatches"
 
 load_lp $MOD_LIVEPATCH2
 load_lp $MOD_LIVEPATCH3
@@ -142,10 +140,9 @@ livepatch: '$MOD_LIVEPATCH2': unpatching complete
 % rmmod $MOD_LIVEPATCH3"
 
 
-# TEST: Failure caused by incompatible cumulative livepatches
+# Failure caused by incompatible cumulative livepatches
 
-echo -n "TEST: incompatible cumulative livepatches ... "
-dmesg -C
+start_test "incompatible cumulative livepatches"
 
 load_lp $MOD_LIVEPATCH2
 load_failing_mod $MOD_LIVEPATCH
-- 
2.21.3

