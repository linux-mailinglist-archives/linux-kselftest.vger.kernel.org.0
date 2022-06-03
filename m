Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B2653CB8D
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jun 2022 16:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245095AbiFCOdX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Jun 2022 10:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244009AbiFCOdW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Jun 2022 10:33:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0B02E68E;
        Fri,  3 Jun 2022 07:33:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 736431F8BF;
        Fri,  3 Jun 2022 14:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654266798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NSPXQ/alN0ux9FJaO4TLiu3taFbhHlZLpc0dmFnta4s=;
        b=DMg3jm0zuw0UiBPS5hTIuR3xpqBGXxf6X9niTYzGnm8MH6FSDkd0odX6fMkle0LYYucy/Q
        xcWdUq1FJ+Lu+LS6InJ5SK65g4eXGcJGp5ATupL9t8BPX9LR6Sd6DrmN4hOtgqPkcK/RIW
        R+jr7ufnQygGmYnBctZ3/P/jaZ3MPrY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 16C9313AA2;
        Fri,  3 Jun 2022 14:33:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OORVM6sbmmIqGgAAMHmgww
        (envelope-from <mpdesouza@suse.com>); Fri, 03 Jun 2022 14:33:15 +0000
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
To:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     shuah@kernel.org, jpoimboe@redhat.com, mbenes@suse.cz,
        pmladek@suse.com, Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH 1/2] livepatch: Move tests from lib/livepatch to selftests/livepatch
Date:   Fri,  3 Jun 2022 11:32:41 -0300
Message-Id: <20220603143242.870-2-mpdesouza@suse.com>
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

It allows writing more complex tests, for example, an userspace C code
that would use the livepatched kernel code. As a bonus it allows to use
"gen_tar" to export the livepatch selftests, rebuild the modules by
running make in selftests/livepatch directory and simplifies the process
of creating and debugging new selftests.

It keeps the ability to execute the tests by running the shell scripts,
like "test-livepatch.sh", but beware that the kernel modules
might not be up-to-date.

Remove 'modprobe --dry-run' call as the modules will be built before
running the tests. Also remove the TEST_LIVEPATCH Kconfig since the
modules won't be build based on a Kconfig.

Adjust functions.sh to call insmod and fix the check_result strings to
reflect the change.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 arch/s390/configs/debug_defconfig             |  1 -
 arch/s390/configs/defconfig                   |  1 -
 lib/Kconfig.debug                             | 22 --------
 lib/Makefile                                  |  2 -
 lib/livepatch/Makefile                        | 14 ------
 tools/testing/selftests/livepatch/Makefile    | 27 +++++++++-
 tools/testing/selftests/livepatch/README      |  5 +-
 tools/testing/selftests/livepatch/config      |  1 -
 .../testing/selftests/livepatch/functions.sh  | 34 +++++--------
 .../selftests/livepatch/test-callbacks.sh     | 50 +++++++++----------
 .../selftests/livepatch/test-ftrace.sh        |  6 +--
 .../selftests/livepatch/test-livepatch.sh     | 10 ++--
 .../selftests/livepatch/test-shadow-vars.sh   |  2 +-
 .../testing/selftests/livepatch/test-state.sh | 18 +++----
 .../selftests/livepatch/test_modules/Makefile | 24 +++++++++
 .../test_modules}/test_klp_atomic_replace.c   |  0
 .../test_modules}/test_klp_callbacks_busy.c   |  0
 .../test_modules}/test_klp_callbacks_demo.c   |  0
 .../test_modules}/test_klp_callbacks_demo2.c  |  0
 .../test_modules}/test_klp_callbacks_mod.c    |  0
 .../test_modules}/test_klp_livepatch.c        |  0
 .../test_modules}/test_klp_shadow_vars.c      |  0
 .../livepatch/test_modules}/test_klp_state.c  |  0
 .../livepatch/test_modules}/test_klp_state2.c |  0
 .../livepatch/test_modules}/test_klp_state3.c |  0
 25 files changed, 107 insertions(+), 110 deletions(-)
 delete mode 100644 lib/livepatch/Makefile
 create mode 100644 tools/testing/selftests/livepatch/test_modules/Makefile
 rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_atomic_replace.c (100%)
 rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_callbacks_busy.c (100%)
 rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_callbacks_demo.c (100%)
 rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_callbacks_demo2.c (100%)
 rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_callbacks_mod.c (100%)
 rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_livepatch.c (100%)
 rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_shadow_vars.c (100%)
 rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_state.c (100%)
 rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_state2.c (100%)
 rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_state3.c (100%)

diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index 498bed9b261b..c97e1b5399b2 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -876,4 +876,3 @@ CONFIG_ATOMIC64_SELFTEST=y
 CONFIG_STRING_SELFTEST=y
 CONFIG_TEST_BITOPS=m
 CONFIG_TEST_BPF=m
-CONFIG_TEST_LIVEPATCH=m
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index 61e36b999f67..57d653714f55 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -807,4 +807,3 @@ CONFIG_KPROBES_SANITY_TEST=m
 CONFIG_PERCPU_TEST=m
 CONFIG_ATOMIC64_SELFTEST=y
 CONFIG_TEST_BPF=m
-CONFIG_TEST_LIVEPATCH=m
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 14b89aa37c5c..9f7ec929e1f2 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2562,28 +2562,6 @@ config TEST_MEMCAT_P
 
 	  If unsure, say N.
 
-config TEST_LIVEPATCH
-	tristate "Test livepatching"
-	default n
-	depends on DYNAMIC_DEBUG
-	depends on LIVEPATCH
-	depends on m
-	help
-	  Test kernel livepatching features for correctness.  The tests will
-	  load test modules that will be livepatched in various scenarios.
-
-	  To run all the livepatching tests:
-
-	  make -C tools/testing/selftests TARGETS=livepatch run_tests
-
-	  Alternatively, individual tests may be invoked:
-
-	  tools/testing/selftests/livepatch/test-callbacks.sh
-	  tools/testing/selftests/livepatch/test-livepatch.sh
-	  tools/testing/selftests/livepatch/test-shadow-vars.sh
-
-	  If unsure, say N.
-
 config TEST_OBJAGG
 	tristate "Perform selftest on object aggreration manager"
 	default n
diff --git a/lib/Makefile b/lib/Makefile
index 300f569c626b..d7322e07c6b5 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -128,8 +128,6 @@ endif
 obj-$(CONFIG_TEST_FPU) += test_fpu.o
 CFLAGS_test_fpu.o += $(FPU_CFLAGS)
 
-obj-$(CONFIG_TEST_LIVEPATCH) += livepatch/
-
 obj-$(CONFIG_KUNIT) += kunit/
 
 ifeq ($(CONFIG_DEBUG_KOBJECT),y)
diff --git a/lib/livepatch/Makefile b/lib/livepatch/Makefile
deleted file mode 100644
index dcc912b3478f..000000000000
--- a/lib/livepatch/Makefile
+++ /dev/null
@@ -1,14 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# Makefile for livepatch test code.
-
-obj-$(CONFIG_TEST_LIVEPATCH) += test_klp_atomic_replace.o \
-				test_klp_callbacks_demo.o \
-				test_klp_callbacks_demo2.o \
-				test_klp_callbacks_busy.o \
-				test_klp_callbacks_mod.o \
-				test_klp_livepatch.o \
-				test_klp_shadow_vars.o \
-				test_klp_state.o \
-				test_klp_state2.o \
-				test_klp_state3.o
diff --git a/tools/testing/selftests/livepatch/Makefile b/tools/testing/selftests/livepatch/Makefile
index 1acc9e1fa3fb..5ef492b87bb1 100644
--- a/tools/testing/selftests/livepatch/Makefile
+++ b/tools/testing/selftests/livepatch/Makefile
@@ -1,5 +1,20 @@
 # SPDX-License-Identifier: GPL-2.0
 
+TEST_FILES := settings \
+		test_modules
+
+# We need the test_modules dir in order to make gen_tar and install to work
+TEST_GEN_PROGS_EXTENDED := test_modules/test_klp_atomic_replace.ko \
+			test_modules/test_klp_callbacks_busy.ko \
+			test_modules/test_klp_callbacks_demo.ko \
+			test_modules/test_klp_callbacks_demo2.ko \
+			test_modules/test_klp_callbacks_mod.ko \
+			test_modules/test_klp_livepatch.ko \
+			test_modules/test_klp_state.ko \
+			test_modules/test_klp_state2.ko \
+			test_modules/test_klp_state3.ko \
+			test_modules/test_klp_shadow_vars.ko
+
 TEST_PROGS_EXTENDED := functions.sh
 TEST_PROGS := \
 	test-livepatch.sh \
@@ -8,6 +23,16 @@ TEST_PROGS := \
 	test-state.sh \
 	test-ftrace.sh
 
-TEST_FILES := settings
+# override lib.mk's default rules
+OVERRIDE_TARGETS := 1
+override define CLEAN
+	rm -f $(TEST_GEN_PROGS_EXTENDED)
+	make -C test_modules clean
+endef
 
 include ../lib.mk
+
+# Here we remove the test_modules path from the module.ko to match the Makefile
+# rule in test_modules directory
+%.ko:
+	make -C test_modules $(notdir $@)
diff --git a/tools/testing/selftests/livepatch/README b/tools/testing/selftests/livepatch/README
index 0942dd5826f8..33d0b016d8a0 100644
--- a/tools/testing/selftests/livepatch/README
+++ b/tools/testing/selftests/livepatch/README
@@ -13,10 +13,7 @@ the message buffer for only the duration of each individual test.)
 Config
 ------
 
-Set these config options and their prerequisites:
-
-CONFIG_LIVEPATCH=y
-CONFIG_TEST_LIVEPATCH=m
+Set CONFIG_LIVEPATCH=y option and it's prerequisite.
 
 
 Running the tests
diff --git a/tools/testing/selftests/livepatch/config b/tools/testing/selftests/livepatch/config
index ad23100cb27c..e88bf518a23a 100644
--- a/tools/testing/selftests/livepatch/config
+++ b/tools/testing/selftests/livepatch/config
@@ -1,3 +1,2 @@
 CONFIG_LIVEPATCH=y
 CONFIG_DYNAMIC_DEBUG=y
-CONFIG_TEST_LIVEPATCH=m
diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index 846c7ed71556..130e0f7a245b 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -110,16 +110,14 @@ function loop_until() {
 	done
 }
 
-function assert_mod() {
-	local mod="$1"
-
-	modprobe --dry-run "$mod" &>/dev/null
-}
-
 function is_livepatch_mod() {
 	local mod="$1"
 
-	if [[ $(modinfo "$mod" | awk '/^livepatch:/{print $NF}') == "Y" ]]; then
+	if [[ ! -f "test_modules/$mod.ko" ]]; then
+		die "Can't find \"test_modules/$mod.ko\", try \"make\""
+	fi
+
+	if [[ $(modinfo "test_modules/$mod.ko" | awk '/^livepatch:/{print $NF}') == "Y" ]]; then
 		return 0
 	fi
 
@@ -129,9 +127,9 @@ function is_livepatch_mod() {
 function __load_mod() {
 	local mod="$1"; shift
 
-	local msg="% modprobe $mod $*"
+	local msg="% insmod test_modules/$mod.ko $*"
 	log "${msg%% }"
-	ret=$(modprobe "$mod" "$@" 2>&1)
+	ret=$(insmod "test_modules/$mod.ko" "$@" 2>&1)
 	if [[ "$ret" != "" ]]; then
 		die "$ret"
 	fi
@@ -144,13 +142,10 @@ function __load_mod() {
 
 # load_mod(modname, params) - load a kernel module
 #	modname - module name to load
-#	params  - module parameters to pass to modprobe
+#	params  - module parameters to pass to insmod
 function load_mod() {
 	local mod="$1"; shift
 
-	assert_mod "$mod" ||
-		skip "unable to load module ${mod}, verify CONFIG_TEST_LIVEPATCH=m and run self-tests as root"
-
 	is_livepatch_mod "$mod" &&
 		die "use load_lp() to load the livepatch module $mod"
 
@@ -160,13 +155,10 @@ function load_mod() {
 # load_lp_nowait(modname, params) - load a kernel module with a livepatch
 #			but do not wait on until the transition finishes
 #	modname - module name to load
-#	params  - module parameters to pass to modprobe
+#	params  - module parameters to pass to insmod
 function load_lp_nowait() {
 	local mod="$1"; shift
 
-	assert_mod "$mod" ||
-		skip "unable to load module ${mod}, verify CONFIG_TEST_LIVEPATCH=m and run self-tests as root"
-
 	is_livepatch_mod "$mod" ||
 		die "module $mod is not a livepatch"
 
@@ -179,7 +171,7 @@ function load_lp_nowait() {
 
 # load_lp(modname, params) - load a kernel module with a livepatch
 #	modname - module name to load
-#	params  - module parameters to pass to modprobe
+#	params  - module parameters to pass to insmod
 function load_lp() {
 	local mod="$1"; shift
 
@@ -192,13 +184,13 @@ function load_lp() {
 
 # load_failing_mod(modname, params) - load a kernel module, expect to fail
 #	modname - module name to load
-#	params  - module parameters to pass to modprobe
+#	params  - module parameters to pass to insmod
 function load_failing_mod() {
 	local mod="$1"; shift
 
-	local msg="% modprobe $mod $*"
+	local msg="% insmod test_modules/$mod.ko $*"
 	log "${msg%% }"
-	ret=$(modprobe "$mod" "$@" 2>&1)
+	ret=$(insmod "test_modules/$mod.ko" "$@" 2>&1)
 	if [[ "$ret" == "" ]]; then
 		die "$mod unexpectedly loaded"
 	fi
diff --git a/tools/testing/selftests/livepatch/test-callbacks.sh b/tools/testing/selftests/livepatch/test-callbacks.sh
index 90b26dbb2626..32b150e25b10 100755
--- a/tools/testing/selftests/livepatch/test-callbacks.sh
+++ b/tools/testing/selftests/livepatch/test-callbacks.sh
@@ -34,9 +34,9 @@ disable_lp $MOD_LIVEPATCH
 unload_lp $MOD_LIVEPATCH
 unload_mod $MOD_TARGET
 
-check_result "% modprobe $MOD_TARGET
+check_result "% insmod test_modules/$MOD_TARGET.ko
 $MOD_TARGET: ${MOD_TARGET}_init
-% modprobe $MOD_LIVEPATCH
+% insmod test_modules/$MOD_LIVEPATCH.ko
 livepatch: enabling patch '$MOD_LIVEPATCH'
 livepatch: '$MOD_LIVEPATCH': initializing patching transition
 $MOD_LIVEPATCH: pre_patch_callback: vmlinux
@@ -81,7 +81,7 @@ disable_lp $MOD_LIVEPATCH
 unload_lp $MOD_LIVEPATCH
 unload_mod $MOD_TARGET
 
-check_result "% modprobe $MOD_LIVEPATCH
+check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
 livepatch: enabling patch '$MOD_LIVEPATCH'
 livepatch: '$MOD_LIVEPATCH': initializing patching transition
 $MOD_LIVEPATCH: pre_patch_callback: vmlinux
@@ -89,7 +89,7 @@ livepatch: '$MOD_LIVEPATCH': starting patching transition
 livepatch: '$MOD_LIVEPATCH': completing patching transition
 $MOD_LIVEPATCH: post_patch_callback: vmlinux
 livepatch: '$MOD_LIVEPATCH': patching complete
-% modprobe $MOD_TARGET
+% insmod test_modules/$MOD_TARGET.ko
 livepatch: applying patch '$MOD_LIVEPATCH' to loading module '$MOD_TARGET'
 $MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET -> [MODULE_STATE_COMING] Full formed, running module_init
 $MOD_LIVEPATCH: post_patch_callback: $MOD_TARGET -> [MODULE_STATE_COMING] Full formed, running module_init
@@ -129,9 +129,9 @@ unload_mod $MOD_TARGET
 disable_lp $MOD_LIVEPATCH
 unload_lp $MOD_LIVEPATCH
 
-check_result "% modprobe $MOD_TARGET
+check_result "% insmod test_modules/$MOD_TARGET.ko
 $MOD_TARGET: ${MOD_TARGET}_init
-% modprobe $MOD_LIVEPATCH
+% insmod test_modules/$MOD_LIVEPATCH.ko
 livepatch: enabling patch '$MOD_LIVEPATCH'
 livepatch: '$MOD_LIVEPATCH': initializing patching transition
 $MOD_LIVEPATCH: pre_patch_callback: vmlinux
@@ -177,7 +177,7 @@ unload_mod $MOD_TARGET
 disable_lp $MOD_LIVEPATCH
 unload_lp $MOD_LIVEPATCH
 
-check_result "% modprobe $MOD_LIVEPATCH
+check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
 livepatch: enabling patch '$MOD_LIVEPATCH'
 livepatch: '$MOD_LIVEPATCH': initializing patching transition
 $MOD_LIVEPATCH: pre_patch_callback: vmlinux
@@ -185,7 +185,7 @@ livepatch: '$MOD_LIVEPATCH': starting patching transition
 livepatch: '$MOD_LIVEPATCH': completing patching transition
 $MOD_LIVEPATCH: post_patch_callback: vmlinux
 livepatch: '$MOD_LIVEPATCH': patching complete
-% modprobe $MOD_TARGET
+% insmod test_modules/$MOD_TARGET.ko
 livepatch: applying patch '$MOD_LIVEPATCH' to loading module '$MOD_TARGET'
 $MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET -> [MODULE_STATE_COMING] Full formed, running module_init
 $MOD_LIVEPATCH: post_patch_callback: $MOD_TARGET -> [MODULE_STATE_COMING] Full formed, running module_init
@@ -219,7 +219,7 @@ load_lp $MOD_LIVEPATCH
 disable_lp $MOD_LIVEPATCH
 unload_lp $MOD_LIVEPATCH
 
-check_result "% modprobe $MOD_LIVEPATCH
+check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
 livepatch: enabling patch '$MOD_LIVEPATCH'
 livepatch: '$MOD_LIVEPATCH': initializing patching transition
 $MOD_LIVEPATCH: pre_patch_callback: vmlinux
@@ -254,9 +254,9 @@ load_mod $MOD_TARGET
 load_failing_mod $MOD_LIVEPATCH pre_patch_ret=-19
 unload_mod $MOD_TARGET
 
-check_result "% modprobe $MOD_TARGET
+check_result "% insmod test_modules/$MOD_TARGET.ko
 $MOD_TARGET: ${MOD_TARGET}_init
-% modprobe $MOD_LIVEPATCH pre_patch_ret=-19
+% insmod test_modules/$MOD_LIVEPATCH.ko pre_patch_ret=-19
 livepatch: enabling patch '$MOD_LIVEPATCH'
 livepatch: '$MOD_LIVEPATCH': initializing patching transition
 test_klp_callbacks_demo: pre_patch_callback: vmlinux
@@ -265,7 +265,7 @@ livepatch: failed to enable patch '$MOD_LIVEPATCH'
 livepatch: '$MOD_LIVEPATCH': canceling patching transition, going to unpatch
 livepatch: '$MOD_LIVEPATCH': completing unpatching transition
 livepatch: '$MOD_LIVEPATCH': unpatching complete
-modprobe: ERROR: could not insert '$MOD_LIVEPATCH': No such device
+insmod: ERROR: could not insert module test_modules/$MOD_LIVEPATCH.ko: No such device
 % rmmod $MOD_TARGET
 $MOD_TARGET: ${MOD_TARGET}_exit"
 
@@ -295,7 +295,7 @@ load_failing_mod $MOD_TARGET
 disable_lp $MOD_LIVEPATCH
 unload_lp $MOD_LIVEPATCH
 
-check_result "% modprobe $MOD_LIVEPATCH
+check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
 livepatch: enabling patch '$MOD_LIVEPATCH'
 livepatch: '$MOD_LIVEPATCH': initializing patching transition
 $MOD_LIVEPATCH: pre_patch_callback: vmlinux
@@ -304,12 +304,12 @@ livepatch: '$MOD_LIVEPATCH': completing patching transition
 $MOD_LIVEPATCH: post_patch_callback: vmlinux
 livepatch: '$MOD_LIVEPATCH': patching complete
 % echo -19 > /sys/module/$MOD_LIVEPATCH/parameters/pre_patch_ret
-% modprobe $MOD_TARGET
+% insmod test_modules/$MOD_TARGET.ko
 livepatch: applying patch '$MOD_LIVEPATCH' to loading module '$MOD_TARGET'
 $MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET -> [MODULE_STATE_COMING] Full formed, running module_init
 livepatch: pre-patch callback failed for object '$MOD_TARGET'
 livepatch: patch '$MOD_LIVEPATCH' failed for module '$MOD_TARGET', refusing to load module '$MOD_TARGET'
-modprobe: ERROR: could not insert '$MOD_TARGET': No such device
+insmod: ERROR: could not insert module test_modules/$MOD_TARGET.ko: No such device
 % echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
 livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
 $MOD_LIVEPATCH: pre_unpatch_callback: vmlinux
@@ -340,11 +340,11 @@ disable_lp $MOD_LIVEPATCH
 unload_lp $MOD_LIVEPATCH
 unload_mod $MOD_TARGET_BUSY
 
-check_result "% modprobe $MOD_TARGET_BUSY block_transition=N
+check_result "% insmod test_modules/$MOD_TARGET_BUSY.ko block_transition=N
 $MOD_TARGET_BUSY: ${MOD_TARGET_BUSY}_init
 $MOD_TARGET_BUSY: busymod_work_func enter
 $MOD_TARGET_BUSY: busymod_work_func exit
-% modprobe $MOD_LIVEPATCH
+% insmod test_modules/$MOD_LIVEPATCH.ko
 livepatch: enabling patch '$MOD_LIVEPATCH'
 livepatch: '$MOD_LIVEPATCH': initializing patching transition
 $MOD_LIVEPATCH: pre_patch_callback: vmlinux
@@ -354,7 +354,7 @@ livepatch: '$MOD_LIVEPATCH': completing patching transition
 $MOD_LIVEPATCH: post_patch_callback: vmlinux
 $MOD_LIVEPATCH: post_patch_callback: $MOD_TARGET_BUSY -> [MODULE_STATE_LIVE] Normal state
 livepatch: '$MOD_LIVEPATCH': patching complete
-% modprobe $MOD_TARGET
+% insmod test_modules/$MOD_TARGET.ko
 livepatch: applying patch '$MOD_LIVEPATCH' to loading module '$MOD_TARGET'
 $MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET -> [MODULE_STATE_COMING] Full formed, running module_init
 $MOD_LIVEPATCH: post_patch_callback: $MOD_TARGET -> [MODULE_STATE_COMING] Full formed, running module_init
@@ -421,16 +421,16 @@ disable_lp $MOD_LIVEPATCH
 unload_lp $MOD_LIVEPATCH
 unload_mod $MOD_TARGET_BUSY
 
-check_result "% modprobe $MOD_TARGET_BUSY block_transition=Y
+check_result "% insmod test_modules/$MOD_TARGET_BUSY.ko block_transition=Y
 $MOD_TARGET_BUSY: ${MOD_TARGET_BUSY}_init
 $MOD_TARGET_BUSY: busymod_work_func enter
-% modprobe $MOD_LIVEPATCH
+% insmod test_modules/$MOD_LIVEPATCH.ko
 livepatch: enabling patch '$MOD_LIVEPATCH'
 livepatch: '$MOD_LIVEPATCH': initializing patching transition
 $MOD_LIVEPATCH: pre_patch_callback: vmlinux
 $MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET_BUSY -> [MODULE_STATE_LIVE] Normal state
 livepatch: '$MOD_LIVEPATCH': starting patching transition
-% modprobe $MOD_TARGET
+% insmod test_modules/$MOD_TARGET.ko
 livepatch: applying patch '$MOD_LIVEPATCH' to loading module '$MOD_TARGET'
 $MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET -> [MODULE_STATE_COMING] Full formed, running module_init
 $MOD_TARGET: ${MOD_TARGET}_init
@@ -467,7 +467,7 @@ disable_lp $MOD_LIVEPATCH
 unload_lp $MOD_LIVEPATCH2
 unload_lp $MOD_LIVEPATCH
 
-check_result "% modprobe $MOD_LIVEPATCH
+check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
 livepatch: enabling patch '$MOD_LIVEPATCH'
 livepatch: '$MOD_LIVEPATCH': initializing patching transition
 $MOD_LIVEPATCH: pre_patch_callback: vmlinux
@@ -475,7 +475,7 @@ livepatch: '$MOD_LIVEPATCH': starting patching transition
 livepatch: '$MOD_LIVEPATCH': completing patching transition
 $MOD_LIVEPATCH: post_patch_callback: vmlinux
 livepatch: '$MOD_LIVEPATCH': patching complete
-% modprobe $MOD_LIVEPATCH2
+% insmod test_modules/$MOD_LIVEPATCH2.ko
 livepatch: enabling patch '$MOD_LIVEPATCH2'
 livepatch: '$MOD_LIVEPATCH2': initializing patching transition
 $MOD_LIVEPATCH2: pre_patch_callback: vmlinux
@@ -523,7 +523,7 @@ disable_lp $MOD_LIVEPATCH2
 unload_lp $MOD_LIVEPATCH2
 unload_lp $MOD_LIVEPATCH
 
-check_result "% modprobe $MOD_LIVEPATCH
+check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
 livepatch: enabling patch '$MOD_LIVEPATCH'
 livepatch: '$MOD_LIVEPATCH': initializing patching transition
 $MOD_LIVEPATCH: pre_patch_callback: vmlinux
@@ -531,7 +531,7 @@ livepatch: '$MOD_LIVEPATCH': starting patching transition
 livepatch: '$MOD_LIVEPATCH': completing patching transition
 $MOD_LIVEPATCH: post_patch_callback: vmlinux
 livepatch: '$MOD_LIVEPATCH': patching complete
-% modprobe $MOD_LIVEPATCH2 replace=1
+% insmod test_modules/$MOD_LIVEPATCH2.ko replace=1
 livepatch: enabling patch '$MOD_LIVEPATCH2'
 livepatch: '$MOD_LIVEPATCH2': initializing patching transition
 $MOD_LIVEPATCH2: pre_patch_callback: vmlinux
diff --git a/tools/testing/selftests/livepatch/test-ftrace.sh b/tools/testing/selftests/livepatch/test-ftrace.sh
index 552e165512f4..08ab42c64013 100755
--- a/tools/testing/selftests/livepatch/test-ftrace.sh
+++ b/tools/testing/selftests/livepatch/test-ftrace.sh
@@ -34,7 +34,7 @@ disable_lp $MOD_LIVEPATCH
 unload_lp $MOD_LIVEPATCH
 
 check_result "livepatch: kernel.ftrace_enabled = 0
-% modprobe $MOD_LIVEPATCH
+% insmod test_modules/$MOD_LIVEPATCH.ko
 livepatch: enabling patch '$MOD_LIVEPATCH'
 livepatch: '$MOD_LIVEPATCH': initializing patching transition
 livepatch: failed to register ftrace handler for function 'cmdline_proc_show' (-16)
@@ -43,9 +43,9 @@ livepatch: failed to enable patch '$MOD_LIVEPATCH'
 livepatch: '$MOD_LIVEPATCH': canceling patching transition, going to unpatch
 livepatch: '$MOD_LIVEPATCH': completing unpatching transition
 livepatch: '$MOD_LIVEPATCH': unpatching complete
-modprobe: ERROR: could not insert '$MOD_LIVEPATCH': Device or resource busy
+insmod: ERROR: could not insert module test_modules/$MOD_LIVEPATCH.ko: Device or resource busy
 livepatch: kernel.ftrace_enabled = 1
-% modprobe $MOD_LIVEPATCH
+% insmod test_modules/$MOD_LIVEPATCH.ko
 livepatch: enabling patch '$MOD_LIVEPATCH'
 livepatch: '$MOD_LIVEPATCH': initializing patching transition
 livepatch: '$MOD_LIVEPATCH': starting patching transition
diff --git a/tools/testing/selftests/livepatch/test-livepatch.sh b/tools/testing/selftests/livepatch/test-livepatch.sh
index 5fe79ac34be1..e3455a6b1158 100755
--- a/tools/testing/selftests/livepatch/test-livepatch.sh
+++ b/tools/testing/selftests/livepatch/test-livepatch.sh
@@ -31,7 +31,7 @@ if [[ "$(cat /proc/cmdline)" == "$MOD_LIVEPATCH: this has been live patched" ]]
 	die "livepatch kselftest(s) failed"
 fi
 
-check_result "% modprobe $MOD_LIVEPATCH
+check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
 livepatch: enabling patch '$MOD_LIVEPATCH'
 livepatch: '$MOD_LIVEPATCH': initializing patching transition
 livepatch: '$MOD_LIVEPATCH': starting patching transition
@@ -75,14 +75,14 @@ unload_lp $MOD_LIVEPATCH
 grep 'live patched' /proc/cmdline > /dev/kmsg
 grep 'live patched' /proc/meminfo > /dev/kmsg
 
-check_result "% modprobe $MOD_LIVEPATCH
+check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
 livepatch: enabling patch '$MOD_LIVEPATCH'
 livepatch: '$MOD_LIVEPATCH': initializing patching transition
 livepatch: '$MOD_LIVEPATCH': starting patching transition
 livepatch: '$MOD_LIVEPATCH': completing patching transition
 livepatch: '$MOD_LIVEPATCH': patching complete
 $MOD_LIVEPATCH: this has been live patched
-% modprobe $MOD_REPLACE replace=0
+% insmod test_modules/$MOD_REPLACE.ko replace=0
 livepatch: enabling patch '$MOD_REPLACE'
 livepatch: '$MOD_REPLACE': initializing patching transition
 livepatch: '$MOD_REPLACE': starting patching transition
@@ -135,14 +135,14 @@ unload_lp $MOD_REPLACE
 grep 'live patched' /proc/cmdline > /dev/kmsg
 grep 'live patched' /proc/meminfo > /dev/kmsg
 
-check_result "% modprobe $MOD_LIVEPATCH
+check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
 livepatch: enabling patch '$MOD_LIVEPATCH'
 livepatch: '$MOD_LIVEPATCH': initializing patching transition
 livepatch: '$MOD_LIVEPATCH': starting patching transition
 livepatch: '$MOD_LIVEPATCH': completing patching transition
 livepatch: '$MOD_LIVEPATCH': patching complete
 $MOD_LIVEPATCH: this has been live patched
-% modprobe $MOD_REPLACE replace=1
+% insmod test_modules/$MOD_REPLACE.ko replace=1
 livepatch: enabling patch '$MOD_REPLACE'
 livepatch: '$MOD_REPLACE': initializing patching transition
 livepatch: '$MOD_REPLACE': starting patching transition
diff --git a/tools/testing/selftests/livepatch/test-shadow-vars.sh b/tools/testing/selftests/livepatch/test-shadow-vars.sh
index e04cb354f56b..1218c155bffe 100755
--- a/tools/testing/selftests/livepatch/test-shadow-vars.sh
+++ b/tools/testing/selftests/livepatch/test-shadow-vars.sh
@@ -16,7 +16,7 @@ start_test "basic shadow variable API"
 load_mod $MOD_TEST
 unload_mod $MOD_TEST
 
-check_result "% modprobe $MOD_TEST
+check_result "% insmod test_modules/$MOD_TEST.ko
 $MOD_TEST: klp_shadow_get(obj=PTR1, id=0x1234) = PTR0
 $MOD_TEST:   got expected NULL result
 $MOD_TEST: shadow_ctor: PTR3 -> PTR2
diff --git a/tools/testing/selftests/livepatch/test-state.sh b/tools/testing/selftests/livepatch/test-state.sh
index 38656721c958..10a52ac06185 100755
--- a/tools/testing/selftests/livepatch/test-state.sh
+++ b/tools/testing/selftests/livepatch/test-state.sh
@@ -19,7 +19,7 @@ load_lp $MOD_LIVEPATCH
 disable_lp $MOD_LIVEPATCH
 unload_lp $MOD_LIVEPATCH
 
-check_result "% modprobe $MOD_LIVEPATCH
+check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
 livepatch: enabling patch '$MOD_LIVEPATCH'
 livepatch: '$MOD_LIVEPATCH': initializing patching transition
 $MOD_LIVEPATCH: pre_patch_callback: vmlinux
@@ -51,7 +51,7 @@ unload_lp $MOD_LIVEPATCH
 disable_lp $MOD_LIVEPATCH2
 unload_lp $MOD_LIVEPATCH2
 
-check_result "% modprobe $MOD_LIVEPATCH
+check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
 livepatch: enabling patch '$MOD_LIVEPATCH'
 livepatch: '$MOD_LIVEPATCH': initializing patching transition
 $MOD_LIVEPATCH: pre_patch_callback: vmlinux
@@ -61,7 +61,7 @@ livepatch: '$MOD_LIVEPATCH': completing patching transition
 $MOD_LIVEPATCH: post_patch_callback: vmlinux
 $MOD_LIVEPATCH: fix_console_loglevel: fixing console_loglevel
 livepatch: '$MOD_LIVEPATCH': patching complete
-% modprobe $MOD_LIVEPATCH2
+% insmod test_modules/$MOD_LIVEPATCH2.ko
 livepatch: enabling patch '$MOD_LIVEPATCH2'
 livepatch: '$MOD_LIVEPATCH2': initializing patching transition
 $MOD_LIVEPATCH2: pre_patch_callback: vmlinux
@@ -96,7 +96,7 @@ disable_lp $MOD_LIVEPATCH2
 unload_lp $MOD_LIVEPATCH2
 unload_lp $MOD_LIVEPATCH3
 
-check_result "% modprobe $MOD_LIVEPATCH2
+check_result "% insmod test_modules/$MOD_LIVEPATCH2.ko
 livepatch: enabling patch '$MOD_LIVEPATCH2'
 livepatch: '$MOD_LIVEPATCH2': initializing patching transition
 $MOD_LIVEPATCH2: pre_patch_callback: vmlinux
@@ -106,7 +106,7 @@ livepatch: '$MOD_LIVEPATCH2': completing patching transition
 $MOD_LIVEPATCH2: post_patch_callback: vmlinux
 $MOD_LIVEPATCH2: fix_console_loglevel: fixing console_loglevel
 livepatch: '$MOD_LIVEPATCH2': patching complete
-% modprobe $MOD_LIVEPATCH3
+% insmod test_modules/$MOD_LIVEPATCH3.ko
 livepatch: enabling patch '$MOD_LIVEPATCH3'
 livepatch: '$MOD_LIVEPATCH3': initializing patching transition
 $MOD_LIVEPATCH3: pre_patch_callback: vmlinux
@@ -117,7 +117,7 @@ $MOD_LIVEPATCH3: post_patch_callback: vmlinux
 $MOD_LIVEPATCH3: fix_console_loglevel: taking over the console_loglevel change
 livepatch: '$MOD_LIVEPATCH3': patching complete
 % rmmod $MOD_LIVEPATCH2
-% modprobe $MOD_LIVEPATCH2
+% insmod test_modules/$MOD_LIVEPATCH2.ko
 livepatch: enabling patch '$MOD_LIVEPATCH2'
 livepatch: '$MOD_LIVEPATCH2': initializing patching transition
 $MOD_LIVEPATCH2: pre_patch_callback: vmlinux
@@ -149,7 +149,7 @@ load_failing_mod $MOD_LIVEPATCH
 disable_lp $MOD_LIVEPATCH2
 unload_lp $MOD_LIVEPATCH2
 
-check_result "% modprobe $MOD_LIVEPATCH2
+check_result "% insmod test_modules/$MOD_LIVEPATCH2.ko
 livepatch: enabling patch '$MOD_LIVEPATCH2'
 livepatch: '$MOD_LIVEPATCH2': initializing patching transition
 $MOD_LIVEPATCH2: pre_patch_callback: vmlinux
@@ -159,9 +159,9 @@ livepatch: '$MOD_LIVEPATCH2': completing patching transition
 $MOD_LIVEPATCH2: post_patch_callback: vmlinux
 $MOD_LIVEPATCH2: fix_console_loglevel: fixing console_loglevel
 livepatch: '$MOD_LIVEPATCH2': patching complete
-% modprobe $MOD_LIVEPATCH
+% insmod test_modules/$MOD_LIVEPATCH.ko
 livepatch: Livepatch patch ($MOD_LIVEPATCH) is not compatible with the already installed livepatches.
-modprobe: ERROR: could not insert '$MOD_LIVEPATCH': Invalid argument
+insmod: ERROR: could not insert module test_modules/$MOD_LIVEPATCH.ko: Invalid parameters
 % echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH2/enabled
 livepatch: '$MOD_LIVEPATCH2': initializing unpatching transition
 $MOD_LIVEPATCH2: pre_unpatch_callback: vmlinux
diff --git a/tools/testing/selftests/livepatch/test_modules/Makefile b/tools/testing/selftests/livepatch/test_modules/Makefile
new file mode 100644
index 000000000000..375180bc1b16
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test_modules/Makefile
@@ -0,0 +1,24 @@
+TESTMODS_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
+
+ifdef building_out_of_srctree
+KDIR ?= /lib/modules/$(shell uname -r)/build
+else
+KDIR ?= $(abspath $(TESTMODS_DIR)/../../../../..)
+endif
+
+obj-m += test_klp_atomic_replace.o \
+	test_klp_callbacks_busy.o \
+	test_klp_callbacks_demo.o \
+	test_klp_callbacks_demo2.o \
+	test_klp_callbacks_mod.o \
+	test_klp_livepatch.o \
+	test_klp_state.o \
+	test_klp_state2.o \
+	test_klp_state3.o \
+	test_klp_shadow_vars.o
+
+%.ko:
+	make -C $(KDIR) M=$(TESTMODS_DIR) $@
+
+clean:
+	make -C $(KDIR) M=$(TESTMODS_DIR) clean
diff --git a/lib/livepatch/test_klp_atomic_replace.c b/tools/testing/selftests/livepatch/test_modules/test_klp_atomic_replace.c
similarity index 100%
rename from lib/livepatch/test_klp_atomic_replace.c
rename to tools/testing/selftests/livepatch/test_modules/test_klp_atomic_replace.c
diff --git a/lib/livepatch/test_klp_callbacks_busy.c b/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_busy.c
similarity index 100%
rename from lib/livepatch/test_klp_callbacks_busy.c
rename to tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_busy.c
diff --git a/lib/livepatch/test_klp_callbacks_demo.c b/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo.c
similarity index 100%
rename from lib/livepatch/test_klp_callbacks_demo.c
rename to tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo.c
diff --git a/lib/livepatch/test_klp_callbacks_demo2.c b/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c
similarity index 100%
rename from lib/livepatch/test_klp_callbacks_demo2.c
rename to tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c
diff --git a/lib/livepatch/test_klp_callbacks_mod.c b/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_mod.c
similarity index 100%
rename from lib/livepatch/test_klp_callbacks_mod.c
rename to tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_mod.c
diff --git a/lib/livepatch/test_klp_livepatch.c b/tools/testing/selftests/livepatch/test_modules/test_klp_livepatch.c
similarity index 100%
rename from lib/livepatch/test_klp_livepatch.c
rename to tools/testing/selftests/livepatch/test_modules/test_klp_livepatch.c
diff --git a/lib/livepatch/test_klp_shadow_vars.c b/tools/testing/selftests/livepatch/test_modules/test_klp_shadow_vars.c
similarity index 100%
rename from lib/livepatch/test_klp_shadow_vars.c
rename to tools/testing/selftests/livepatch/test_modules/test_klp_shadow_vars.c
diff --git a/lib/livepatch/test_klp_state.c b/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
similarity index 100%
rename from lib/livepatch/test_klp_state.c
rename to tools/testing/selftests/livepatch/test_modules/test_klp_state.c
diff --git a/lib/livepatch/test_klp_state2.c b/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
similarity index 100%
rename from lib/livepatch/test_klp_state2.c
rename to tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
diff --git a/lib/livepatch/test_klp_state3.c b/tools/testing/selftests/livepatch/test_modules/test_klp_state3.c
similarity index 100%
rename from lib/livepatch/test_klp_state3.c
rename to tools/testing/selftests/livepatch/test_modules/test_klp_state3.c
-- 
2.35.3

