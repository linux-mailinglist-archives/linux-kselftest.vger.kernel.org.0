Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9161F5A2F
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jun 2020 19:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgFJRVL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Jun 2020 13:21:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43038 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727955AbgFJRVL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Jun 2020 13:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591809668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1LRhykQpOmb1H2bCeoxEXO6dMe5cNt02JGn/mkXab/Q=;
        b=akq3zEyGbwINvJ3BKmFoa3YxAKynHeySMNbX37PRhg5iUJGXpbYOdNknILlh9pZrcrvDjP
        +0XWOw/dYW5IxxYV/p/UI2DhpLRiMCZ3n+2zTDAuQSOmCAzW2HQoezGa/V6PPlzfeJT9Sp
        EqiOxbLLYZTl27L6XJDSxtEmp1yz2Ig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-Huc58XV9OZ2rj3aMzGslxg-1; Wed, 10 Jun 2020 13:21:04 -0400
X-MC-Unique: Huc58XV9OZ2rj3aMzGslxg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9461801504;
        Wed, 10 Jun 2020 17:21:03 +0000 (UTC)
Received: from jlaw-desktop.redhat.com (ovpn-117-142.rdu2.redhat.com [10.10.117.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B4711944D;
        Wed, 10 Jun 2020 17:21:03 +0000 (UTC)
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 1/3] selftests/livepatch: Don't clear dmesg when running tests
Date:   Wed, 10 Jun 2020 13:20:59 -0400
Message-Id: <20200610172101.21910-2-joe.lawrence@redhat.com>
In-Reply-To: <20200610172101.21910-1-joe.lawrence@redhat.com>
References: <20200610172101.21910-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
 .../testing/selftests/livepatch/functions.sh  | 16 +++++-
 .../selftests/livepatch/test-callbacks.sh     | 55 ++++---------------
 .../selftests/livepatch/test-ftrace.sh        |  5 +-
 .../selftests/livepatch/test-livepatch.sh     | 15 +----
 .../selftests/livepatch/test-shadow-vars.sh   |  5 +-
 .../testing/selftests/livepatch/test-state.sh | 20 ++-----
 7 files changed, 43 insertions(+), 89 deletions(-)

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
index 2aab9791791d..e84375a33852 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -243,13 +243,25 @@ function set_pre_patch_ret {
 		die "failed to set pre_patch_ret parameter for $mod module"
 }
 
+function start_test {
+	local test="$1"
+
+	# Save existing dmesg so we can detect new content below
+	SAVED_DMESG=$(mktemp --tmpdir -t klp-dmesg-XXXXXX)
+	dmesg > "$SAVED_DMESG"
+
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
@@ -257,4 +269,6 @@ function check_result {
 		echo -e "not ok\n\n$(diff -upr --label expected --label result <(echo "$expect") <(echo "$result"))\n"
 		die "livepatch kselftest(s) failed"
 	fi
+
+	rm -f "$SAVED_DMESG"
 }
diff --git a/tools/testing/selftests/livepatch/test-callbacks.sh b/tools/testing/selftests/livepatch/test-callbacks.sh
index 32b57ba07f4f..c3d949da5bb7 100755
--- a/tools/testing/selftests/livepatch/test-callbacks.sh
+++ b/tools/testing/selftests/livepatch/test-callbacks.sh
@@ -12,7 +12,7 @@ MOD_TARGET_BUSY=test_klp_callbacks_busy
 setup_config
 
 
-# TEST: target module before livepatch
+start_test "target module before livepatch"
 #
 # Test a combination of loading a kernel module and a livepatch that
 # patches a function in the first module.  Load the target module
@@ -28,9 +28,6 @@ setup_config
 #   unpatching transition starts.  klp_objects are reverted, post-patch
 #   callbacks execute and the transition completes.
 
-echo -n "TEST: target module before livepatch ... "
-dmesg -C
-
 load_mod $MOD_TARGET
 load_lp $MOD_LIVEPATCH
 disable_lp $MOD_LIVEPATCH
@@ -63,7 +60,7 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 $MOD_TARGET: ${MOD_TARGET}_exit"
 
 
-# TEST: module_coming notifier
+start_test "module_coming notifier"
 #
 # This test is similar to the previous test, but (un)load the livepatch
 # module before the target kernel module.  This tests the livepatch
@@ -78,9 +75,6 @@ $MOD_TARGET: ${MOD_TARGET}_exit"
 # - On livepatch disable, all currently loaded klp_objects' (vmlinux and
 #   $MOD_TARGET) pre/post-unpatch callbacks are executed.
 
-echo -n "TEST: module_coming notifier ... "
-dmesg -C
-
 load_lp $MOD_LIVEPATCH
 load_mod $MOD_TARGET
 disable_lp $MOD_LIVEPATCH
@@ -114,7 +108,7 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 $MOD_TARGET: ${MOD_TARGET}_exit"
 
 
-# TEST: module_going notifier
+start_test "module_going notifier"
 #
 # Test loading the livepatch after a targeted kernel module, then unload
 # the kernel module before disabling the livepatch.  This tests the
@@ -129,9 +123,6 @@ $MOD_TARGET: ${MOD_TARGET}_exit"
 # - When the livepatch is disabled, pre and post-unpatch callbacks are
 #   run for the remaining klp_object, vmlinux.
 
-echo -n "TEST: module_going notifier ... "
-dmesg -C
-
 load_mod $MOD_TARGET
 load_lp $MOD_LIVEPATCH
 unload_mod $MOD_TARGET
@@ -165,7 +156,7 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 % rmmod $MOD_LIVEPATCH"
 
 
-# TEST: module_coming and module_going notifiers
+start_test "module_coming and module_going notifiers"
 #
 # This test is similar to the previous test, however the livepatch is
 # loaded first.  This tests the livepatch core's module_coming and
@@ -180,9 +171,6 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 #   from the $MOD_TARGET klp_object.  As such, only pre and
 #   post-unpatch callbacks are executed when this occurs.
 
-echo -n "TEST: module_coming and module_going notifiers ... "
-dmesg -C
-
 load_lp $MOD_LIVEPATCH
 load_mod $MOD_TARGET
 unload_mod $MOD_TARGET
@@ -217,7 +205,7 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 % rmmod $MOD_LIVEPATCH"
 
 
-# TEST: target module not present
+start_test "target module not present"
 #
 # A simple test of loading a livepatch without one of its patch target
 # klp_objects ever loaded ($MOD_TARGET).
@@ -227,9 +215,6 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 # - As expected, only pre/post-(un)patch handlers are executed for
 #   vmlinux.
 
-echo -n "TEST: target module not present ... "
-dmesg -C
-
 load_lp $MOD_LIVEPATCH
 disable_lp $MOD_LIVEPATCH
 unload_lp $MOD_LIVEPATCH
@@ -252,7 +237,7 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 % rmmod $MOD_LIVEPATCH"
 
 
-# TEST: pre-patch callback -ENODEV
+start_test "pre-patch callback -ENODEV"
 #
 # Test a scenario where a vmlinux pre-patch callback returns a non-zero
 # status (ie, failure).
@@ -265,9 +250,6 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 #   The result is that the insmod command refuses to load the livepatch
 #   module.
 
-echo -n "TEST: pre-patch callback -ENODEV ... "
-dmesg -C
-
 load_mod $MOD_TARGET
 load_failing_mod $MOD_LIVEPATCH pre_patch_ret=-19
 unload_mod $MOD_TARGET
@@ -288,7 +270,7 @@ modprobe: ERROR: could not insert '$MOD_LIVEPATCH': No such device
 $MOD_TARGET: ${MOD_TARGET}_exit"
 
 
-# TEST: module_coming + pre-patch callback -ENODEV
+start_test "module_coming + pre-patch callback -ENODEV"
 #
 # Similar to the previous test, setup a livepatch such that its vmlinux
 # pre-patch callback returns success.  However, when a targeted kernel
@@ -307,9 +289,6 @@ $MOD_TARGET: ${MOD_TARGET}_exit"
 #
 # - Pre/post-unpatch callbacks are run for the vmlinux klp_object.
 
-echo -n "TEST: module_coming + pre-patch callback -ENODEV ... "
-dmesg -C
-
 load_lp $MOD_LIVEPATCH
 set_pre_patch_ret $MOD_LIVEPATCH -19
 load_failing_mod $MOD_TARGET
@@ -341,7 +320,7 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 % rmmod $MOD_LIVEPATCH"
 
 
-# TEST: multiple target modules
+start_test "multiple target modules"
 #
 # Test loading multiple targeted kernel modules.  This test-case is
 # mainly for comparing with the next test-case.
@@ -353,9 +332,6 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 #   module.  Post-patch callbacks are executed and the transition
 #   completes quickly.
 
-echo -n "TEST: multiple target modules ... "
-dmesg -C
-
 load_mod $MOD_TARGET_BUSY block_transition=N
 load_lp $MOD_LIVEPATCH
 load_mod $MOD_TARGET
@@ -402,7 +378,7 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 $MOD_TARGET_BUSY: ${MOD_TARGET_BUSY}_exit"
 
 
-# TEST: busy target module
+start_test "busy target module"
 #
 # A similar test as the previous one, but force the "busy" kernel module
 # to block the livepatch transition.
@@ -431,9 +407,6 @@ $MOD_TARGET_BUSY: ${MOD_TARGET_BUSY}_exit"
 #   klp_object's post-patch callbacks executed, the remaining
 #   klp_object's pre-unpatch callbacks are skipped.
 
-echo -n "TEST: busy target module ... "
-dmesg -C
-
 load_mod $MOD_TARGET_BUSY block_transition=Y
 load_lp_nowait $MOD_LIVEPATCH
 
@@ -478,7 +451,7 @@ $MOD_TARGET_BUSY: busymod_work_func exit
 $MOD_TARGET_BUSY: ${MOD_TARGET_BUSY}_exit"
 
 
-# TEST: multiple livepatches
+start_test "multiple livepatches"
 #
 # Test loading multiple livepatches.  This test-case is mainly for comparing
 # with the next test-case.
@@ -487,9 +460,6 @@ $MOD_TARGET_BUSY: ${MOD_TARGET_BUSY}_exit"
 #   execute as each patch progresses through its (un)patching
 #   transition.
 
-echo -n "TEST: multiple livepatches ... "
-dmesg -C
-
 load_lp $MOD_LIVEPATCH
 load_lp $MOD_LIVEPATCH2
 disable_lp $MOD_LIVEPATCH2
@@ -531,7 +501,7 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 % rmmod $MOD_LIVEPATCH"
 
 
-# TEST: atomic replace
+start_test "atomic replace"
 #
 # Load multiple livepatches, but the second as an 'atomic-replace'
 # patch.  When the latter loads, the original livepatch should be
@@ -547,9 +517,6 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 # - Once the atomic replace module is loaded, only its pre and post
 #   unpatch callbacks are executed.
 
-echo -n "TEST: atomic replace ... "
-dmesg -C
-
 load_lp $MOD_LIVEPATCH
 load_lp $MOD_LIVEPATCH2 replace=1
 disable_lp $MOD_LIVEPATCH2
diff --git a/tools/testing/selftests/livepatch/test-ftrace.sh b/tools/testing/selftests/livepatch/test-ftrace.sh
index e2a76887f40a..c839f906ffc2 100755
--- a/tools/testing/selftests/livepatch/test-ftrace.sh
+++ b/tools/testing/selftests/livepatch/test-ftrace.sh
@@ -9,14 +9,11 @@ MOD_LIVEPATCH=test_klp_livepatch
 setup_config
 
 
-# TEST: livepatch interaction with ftrace_enabled sysctl
+start_test "livepatch interaction with ftrace_enabled sysctl"
 # - turn ftrace_enabled OFF and verify livepatches can't load
 # - turn ftrace_enabled ON and verify livepatch can load
 # - verify that ftrace_enabled can't be turned OFF while a livepatch is loaded
 
-echo -n "TEST: livepatch interaction with ftrace_enabled sysctl ... "
-dmesg -C
-
 set_ftrace_enabled 0
 load_failing_mod $MOD_LIVEPATCH
 
diff --git a/tools/testing/selftests/livepatch/test-livepatch.sh b/tools/testing/selftests/livepatch/test-livepatch.sh
index 493e3df415a1..3b84ee34fe71 100755
--- a/tools/testing/selftests/livepatch/test-livepatch.sh
+++ b/tools/testing/selftests/livepatch/test-livepatch.sh
@@ -10,14 +10,11 @@ MOD_REPLACE=test_klp_atomic_replace
 setup_config
 
 
-# TEST: basic function patching
+start_test "basic function patching"
 # - load a livepatch that modifies the output from /proc/cmdline and
 #   verify correct behavior
 # - unload the livepatch and make sure the patch was removed
 
-echo -n "TEST: basic function patching ... "
-dmesg -C
-
 load_lp $MOD_LIVEPATCH
 
 if [[ "$(cat /proc/cmdline)" != "$MOD_LIVEPATCH: this has been live patched" ]] ; then
@@ -47,16 +44,13 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 % rmmod $MOD_LIVEPATCH"
 
 
-# TEST: multiple livepatches
+start_test "multiple livepatches"
 # - load a livepatch that modifies the output from /proc/cmdline and
 #   verify correct behavior
 # - load another livepatch and verify that both livepatches are active
 # - unload the second livepatch and verify that the first is still active
 # - unload the first livepatch and verify none are active
 
-echo -n "TEST: multiple livepatches ... "
-dmesg -C
-
 load_lp $MOD_LIVEPATCH
 
 grep 'live patched' /proc/cmdline > /dev/kmsg
@@ -109,7 +103,7 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 % rmmod $MOD_LIVEPATCH"
 
 
-# TEST: atomic replace livepatch
+start_test "atomic replace livepatch"
 # - load a livepatch that modifies the output from /proc/cmdline and
 #   verify correct behavior
 # - load an atomic replace livepatch and verify that only the second is active
@@ -117,9 +111,6 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 #   is still active
 # - remove the atomic replace livepatch and verify that none are active
 
-echo -n "TEST: atomic replace livepatch ... "
-dmesg -C
-
 load_lp $MOD_LIVEPATCH
 
 grep 'live patched' /proc/cmdline > /dev/kmsg
diff --git a/tools/testing/selftests/livepatch/test-shadow-vars.sh b/tools/testing/selftests/livepatch/test-shadow-vars.sh
index 7c016548c2ea..71990d0b5d19 100755
--- a/tools/testing/selftests/livepatch/test-shadow-vars.sh
+++ b/tools/testing/selftests/livepatch/test-shadow-vars.sh
@@ -9,12 +9,9 @@ MOD_TEST=test_klp_shadow_vars
 setup_config
 
 
-# TEST: basic shadow variable API
+start_test "basic shadow variable API"
 # - load a module that exercises the shadow variable API
 
-echo -n "TEST: basic shadow variable API ... "
-dmesg -C
-
 load_mod $MOD_TEST
 unload_mod $MOD_TEST
 
diff --git a/tools/testing/selftests/livepatch/test-state.sh b/tools/testing/selftests/livepatch/test-state.sh
index a08212708115..bf8db1613961 100755
--- a/tools/testing/selftests/livepatch/test-state.sh
+++ b/tools/testing/selftests/livepatch/test-state.sh
@@ -10,10 +10,7 @@ MOD_LIVEPATCH3=test_klp_state3
 
 setup_config
 
-# TEST: Loading and removing a module that modifies the system state
-
-echo -n "TEST: system state modification ... "
-dmesg -C
+start_test "Loading and removing a module that modifies the system state"
 
 load_lp $MOD_LIVEPATCH
 disable_lp $MOD_LIVEPATCH
@@ -41,10 +38,7 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 % rmmod $MOD_LIVEPATCH"
 
 
-# TEST: Take over system state change by a cumulative patch
-
-echo -n "TEST: taking over system state modification ... "
-dmesg -C
+start_test "Take over system state change by a cumulative patch"
 
 load_lp $MOD_LIVEPATCH
 load_lp $MOD_LIVEPATCH2
@@ -85,10 +79,7 @@ livepatch: '$MOD_LIVEPATCH2': unpatching complete
 % rmmod $MOD_LIVEPATCH2"
 
 
-# TEST: Take over system state change by a cumulative patch
-
-echo -n "TEST: compatible cumulative livepatches ... "
-dmesg -C
+start_test "Take over system state change by a cumulative patch"
 
 load_lp $MOD_LIVEPATCH2
 load_lp $MOD_LIVEPATCH3
@@ -142,10 +133,7 @@ livepatch: '$MOD_LIVEPATCH2': unpatching complete
 % rmmod $MOD_LIVEPATCH3"
 
 
-# TEST: Failure caused by incompatible cumulative livepatches
-
-echo -n "TEST: incompatible cumulative livepatches ... "
-dmesg -C
+start_test "Failure caused by incompatible cumulative livepatches"
 
 load_lp $MOD_LIVEPATCH2
 load_failing_mod $MOD_LIVEPATCH
-- 
2.21.3

