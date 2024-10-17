Return-Path: <linux-kselftest+bounces-20050-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AFE9A2E1E
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 22:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 978881F2214E
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 20:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433822281F6;
	Thu, 17 Oct 2024 20:01:51 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873A97E101;
	Thu, 17 Oct 2024 20:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729195311; cv=none; b=lXuImH5VNNl8O3AId4xaCsQy9Aa0JCIHKdtzcCKeKkKInzwId636W3W3pyqE3z+D63v+6Z6kWrit5hxR1fs0rX2wi2jwVnNMTgjr9/uv96DqJStOztBobr+JTtzZWEBgCJHZu85YsL2y4Cxw5wSGwNCdqxaMSHY+7lnb477yg78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729195311; c=relaxed/simple;
	bh=4t52pcNOiZBPu8B5vWmQCzEyZfX+1H5aTEHJPN7wgN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jtt0ZHSI5c7ajEvgKUqm/EkRtpQ2PWdViGGO+Yhy16Y2x5SULD6wpX/eFtNFkuOgvRsExGZQgEBIx3YcB8gwE+aoRK51v7OHZRygittA11mYQi3S8tf2VORBLIxZ1TPZIFrTYZrawGQXqLAsjAZGKMIcwjjThD8brVtZ5mc+Apw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C3D391FB51;
	Thu, 17 Oct 2024 20:01:42 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6F9313A53;
	Thu, 17 Oct 2024 20:01:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kMzkJyZtEWf1AwAAD6G6ig
	(envelope-from <mvetter@suse.com>); Thu, 17 Oct 2024 20:01:42 +0000
From: Michael Vetter <mvetter@suse.com>
To: linux-kselftest@vger.kernel.org,
	live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Michael Vetter <mvetter@suse.com>
Subject: [PATCH v5 1/3] selftests: livepatch: rename KLP_SYSFS_DIR to SYSFS_KLP_DIR
Date: Thu, 17 Oct 2024 22:01:30 +0200
Message-ID: <20241017200132.21946-2-mvetter@suse.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241017200132.21946-1-mvetter@suse.com>
References: <20241017200132.21946-1-mvetter@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: C3D391FB51
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

This naming makes more sense according to the directory structure.
Especially when we later add more paths.

Addtionally replace `/sys/kernel/livepatch` with `$SYSFS_KLP_DIR` in
the livepatch test files.

Signed-off-by: Michael Vetter <mvetter@suse.com>
---
 .../testing/selftests/livepatch/functions.sh  | 16 ++++++-------
 .../selftests/livepatch/test-callbacks.sh     | 24 +++++++++----------
 .../selftests/livepatch/test-ftrace.sh        |  2 +-
 .../selftests/livepatch/test-livepatch.sh     | 12 +++++-----
 .../testing/selftests/livepatch/test-state.sh |  8 +++----
 .../selftests/livepatch/test-syscall.sh       |  2 +-
 .../testing/selftests/livepatch/test-sysfs.sh |  8 +++----
 7 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index fc4c6a016d38..e0e7f8db894c 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -6,7 +6,7 @@
 
 MAX_RETRIES=600
 RETRY_INTERVAL=".1"	# seconds
-KLP_SYSFS_DIR="/sys/kernel/livepatch"
+SYSFS_KLP_DIR="/sys/kernel/livepatch"
 
 # Kselftest framework requirement - SKIP code is 4
 ksft_skip=4
@@ -183,7 +183,7 @@ function load_lp_nowait() {
 	__load_mod "$mod" "$@"
 
 	# Wait for livepatch in sysfs ...
-	loop_until '[[ -e "/sys/kernel/livepatch/$mod" ]]' ||
+	loop_until '[[ -e "$SYSFS_KLP_DIR/$mod" ]]' ||
 		die "failed to load module $mod (sysfs)"
 }
 
@@ -196,7 +196,7 @@ function load_lp() {
 	load_lp_nowait "$mod" "$@"
 
 	# Wait until the transition finishes ...
-	loop_until 'grep -q '^0$' /sys/kernel/livepatch/$mod/transition' ||
+	loop_until 'grep -q '^0$' $SYSFS_KLP_DIR/$mod/transition' ||
 		die "failed to complete transition"
 }
 
@@ -246,12 +246,12 @@ function unload_lp() {
 function disable_lp() {
 	local mod="$1"
 
-	log "% echo 0 > /sys/kernel/livepatch/$mod/enabled"
-	echo 0 > /sys/kernel/livepatch/"$mod"/enabled
+	log "% echo 0 > $SYSFS_KLP_DIR/$mod/enabled"
+	echo 0 > "$SYSFS_KLP_DIR"/mod"/enabled
 
 	# Wait until the transition finishes and the livepatch gets
 	# removed from sysfs...
-	loop_until '[[ ! -e "/sys/kernel/livepatch/$mod" ]]' ||
+	loop_until '[[ ! -e "$SYSFS_KLP_DIR/$mod" ]]' ||
 		die "failed to disable livepatch $mod"
 }
 
@@ -322,7 +322,7 @@ function check_sysfs_rights() {
 	local rel_path="$1"; shift
 	local expected_rights="$1"; shift
 
-	local path="$KLP_SYSFS_DIR/$mod/$rel_path"
+	local path="$SYSFS_KLP_DIR/$mod/$rel_path"
 	local rights=$(/bin/stat --format '%A' "$path")
 	if test "$rights" != "$expected_rights" ; then
 		die "Unexpected access rights of $path: $expected_rights vs. $rights"
@@ -338,7 +338,7 @@ function check_sysfs_value() {
 	local rel_path="$1"; shift
 	local expected_value="$1"; shift
 
-	local path="$KLP_SYSFS_DIR/$mod/$rel_path"
+	local path="$SYSFS_KLP_DIR/$mod/$rel_path"
 	local value=`cat $path`
 	if test "$value" != "$expected_value" ; then
 		die "Unexpected value in $path: $expected_value vs. $value"
diff --git a/tools/testing/selftests/livepatch/test-callbacks.sh b/tools/testing/selftests/livepatch/test-callbacks.sh
index 32b150e25b10..37bbc3fb2780 100755
--- a/tools/testing/selftests/livepatch/test-callbacks.sh
+++ b/tools/testing/selftests/livepatch/test-callbacks.sh
@@ -46,7 +46,7 @@ livepatch: '$MOD_LIVEPATCH': completing patching transition
 $MOD_LIVEPATCH: post_patch_callback: vmlinux
 $MOD_LIVEPATCH: post_patch_callback: $MOD_TARGET -> [MODULE_STATE_LIVE] Normal state
 livepatch: '$MOD_LIVEPATCH': patching complete
-% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
+% echo 0 > $SYSFS_KLP_DIR/$MOD_LIVEPATCH/enabled
 livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
 $MOD_LIVEPATCH: pre_unpatch_callback: vmlinux
 $MOD_LIVEPATCH: pre_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_LIVE] Normal state
@@ -94,7 +94,7 @@ livepatch: applying patch '$MOD_LIVEPATCH' to loading module '$MOD_TARGET'
 $MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET -> [MODULE_STATE_COMING] Full formed, running module_init
 $MOD_LIVEPATCH: post_patch_callback: $MOD_TARGET -> [MODULE_STATE_COMING] Full formed, running module_init
 $MOD_TARGET: ${MOD_TARGET}_init
-% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
+% echo 0 > $SYSFS_KLP_DIR/$MOD_LIVEPATCH/enabled
 livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
 $MOD_LIVEPATCH: pre_unpatch_callback: vmlinux
 $MOD_LIVEPATCH: pre_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_LIVE] Normal state
@@ -146,7 +146,7 @@ $MOD_TARGET: ${MOD_TARGET}_exit
 $MOD_LIVEPATCH: pre_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_GOING] Going away
 livepatch: reverting patch '$MOD_LIVEPATCH' on unloading module '$MOD_TARGET'
 $MOD_LIVEPATCH: post_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_GOING] Going away
-% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
+% echo 0 > $SYSFS_KLP_DIR/$MOD_LIVEPATCH/enabled
 livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
 $MOD_LIVEPATCH: pre_unpatch_callback: vmlinux
 livepatch: '$MOD_LIVEPATCH': starting unpatching transition
@@ -195,7 +195,7 @@ $MOD_TARGET: ${MOD_TARGET}_exit
 $MOD_LIVEPATCH: pre_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_GOING] Going away
 livepatch: reverting patch '$MOD_LIVEPATCH' on unloading module '$MOD_TARGET'
 $MOD_LIVEPATCH: post_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_GOING] Going away
-% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
+% echo 0 > $SYSFS_KLP_DIR/$MOD_LIVEPATCH/enabled
 livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
 $MOD_LIVEPATCH: pre_unpatch_callback: vmlinux
 livepatch: '$MOD_LIVEPATCH': starting unpatching transition
@@ -227,7 +227,7 @@ livepatch: '$MOD_LIVEPATCH': starting patching transition
 livepatch: '$MOD_LIVEPATCH': completing patching transition
 $MOD_LIVEPATCH: post_patch_callback: vmlinux
 livepatch: '$MOD_LIVEPATCH': patching complete
-% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
+% echo 0 > $SYSFS_KLP_DIR/$MOD_LIVEPATCH/enabled
 livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
 $MOD_LIVEPATCH: pre_unpatch_callback: vmlinux
 livepatch: '$MOD_LIVEPATCH': starting unpatching transition
@@ -310,7 +310,7 @@ $MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET -> [MODULE_STATE_COMING] Full fo
 livepatch: pre-patch callback failed for object '$MOD_TARGET'
 livepatch: patch '$MOD_LIVEPATCH' failed for module '$MOD_TARGET', refusing to load module '$MOD_TARGET'
 insmod: ERROR: could not insert module test_modules/$MOD_TARGET.ko: No such device
-% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
+% echo 0 > $SYSFS_KLP_DIR/$MOD_LIVEPATCH/enabled
 livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
 $MOD_LIVEPATCH: pre_unpatch_callback: vmlinux
 livepatch: '$MOD_LIVEPATCH': starting unpatching transition
@@ -364,7 +364,7 @@ $MOD_TARGET: ${MOD_TARGET}_exit
 $MOD_LIVEPATCH: pre_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_GOING] Going away
 livepatch: reverting patch '$MOD_LIVEPATCH' on unloading module '$MOD_TARGET'
 $MOD_LIVEPATCH: post_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_GOING] Going away
-% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
+% echo 0 > $SYSFS_KLP_DIR/$MOD_LIVEPATCH/enabled
 livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
 $MOD_LIVEPATCH: pre_unpatch_callback: vmlinux
 $MOD_LIVEPATCH: pre_unpatch_callback: $MOD_TARGET_BUSY -> [MODULE_STATE_LIVE] Normal state
@@ -412,7 +412,7 @@ load_lp_nowait $MOD_LIVEPATCH
 
 # Wait until the livepatch reports in-transition state, i.e. that it's
 # stalled on $MOD_TARGET_BUSY::busymod_work_func()
-loop_until 'grep -q '^1$' /sys/kernel/livepatch/$MOD_LIVEPATCH/transition' ||
+loop_until 'grep -q '^1$' $SYSFS_KLP_DIR/$MOD_LIVEPATCH/transition' ||
 	die "failed to stall transition"
 
 load_mod $MOD_TARGET
@@ -438,7 +438,7 @@ $MOD_TARGET: ${MOD_TARGET}_init
 $MOD_TARGET: ${MOD_TARGET}_exit
 livepatch: reverting patch '$MOD_LIVEPATCH' on unloading module '$MOD_TARGET'
 $MOD_LIVEPATCH: post_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_GOING] Going away
-% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
+% echo 0 > $SYSFS_KLP_DIR/$MOD_LIVEPATCH/enabled
 livepatch: '$MOD_LIVEPATCH': reversing transition from patching to unpatching
 livepatch: '$MOD_LIVEPATCH': starting unpatching transition
 livepatch: '$MOD_LIVEPATCH': completing unpatching transition
@@ -483,14 +483,14 @@ livepatch: '$MOD_LIVEPATCH2': starting patching transition
 livepatch: '$MOD_LIVEPATCH2': completing patching transition
 $MOD_LIVEPATCH2: post_patch_callback: vmlinux
 livepatch: '$MOD_LIVEPATCH2': patching complete
-% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH2/enabled
+% echo 0 > $SYSFS_KLP_DIR/$MOD_LIVEPATCH2/enabled
 livepatch: '$MOD_LIVEPATCH2': initializing unpatching transition
 $MOD_LIVEPATCH2: pre_unpatch_callback: vmlinux
 livepatch: '$MOD_LIVEPATCH2': starting unpatching transition
 livepatch: '$MOD_LIVEPATCH2': completing unpatching transition
 $MOD_LIVEPATCH2: post_unpatch_callback: vmlinux
 livepatch: '$MOD_LIVEPATCH2': unpatching complete
-% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
+% echo 0 > $SYSFS_KLP_DIR/$MOD_LIVEPATCH/enabled
 livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
 $MOD_LIVEPATCH: pre_unpatch_callback: vmlinux
 livepatch: '$MOD_LIVEPATCH': starting unpatching transition
@@ -539,7 +539,7 @@ livepatch: '$MOD_LIVEPATCH2': starting patching transition
 livepatch: '$MOD_LIVEPATCH2': completing patching transition
 $MOD_LIVEPATCH2: post_patch_callback: vmlinux
 livepatch: '$MOD_LIVEPATCH2': patching complete
-% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH2/enabled
+% echo 0 > $SYSFS_KLP_DIR/$MOD_LIVEPATCH2/enabled
 livepatch: '$MOD_LIVEPATCH2': initializing unpatching transition
 $MOD_LIVEPATCH2: pre_unpatch_callback: vmlinux
 livepatch: '$MOD_LIVEPATCH2': starting unpatching transition
diff --git a/tools/testing/selftests/livepatch/test-ftrace.sh b/tools/testing/selftests/livepatch/test-ftrace.sh
index 730218bce99c..fe14f248913a 100755
--- a/tools/testing/selftests/livepatch/test-ftrace.sh
+++ b/tools/testing/selftests/livepatch/test-ftrace.sh
@@ -53,7 +53,7 @@ livepatch: '$MOD_LIVEPATCH': starting patching transition
 livepatch: '$MOD_LIVEPATCH': completing patching transition
 livepatch: '$MOD_LIVEPATCH': patching complete
 livepatch: sysctl: setting key \"kernel.ftrace_enabled\": Device or resource busy
-% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
+% echo 0 > $SYSFS_KLP_DIR/$MOD_LIVEPATCH/enabled
 livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
 livepatch: '$MOD_LIVEPATCH': starting unpatching transition
 livepatch: '$MOD_LIVEPATCH': completing unpatching transition
diff --git a/tools/testing/selftests/livepatch/test-livepatch.sh b/tools/testing/selftests/livepatch/test-livepatch.sh
index bd13257bfdfe..6673023d2b66 100755
--- a/tools/testing/selftests/livepatch/test-livepatch.sh
+++ b/tools/testing/selftests/livepatch/test-livepatch.sh
@@ -39,7 +39,7 @@ livepatch: '$MOD_LIVEPATCH1': initializing patching transition
 livepatch: '$MOD_LIVEPATCH1': starting patching transition
 livepatch: '$MOD_LIVEPATCH1': completing patching transition
 livepatch: '$MOD_LIVEPATCH1': patching complete
-% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH1/enabled
+% echo 0 > $SYSFS_KLP_DIR/$MOD_LIVEPATCH1/enabled
 livepatch: '$MOD_LIVEPATCH1': initializing unpatching transition
 livepatch: '$MOD_LIVEPATCH1': starting unpatching transition
 livepatch: '$MOD_LIVEPATCH1': completing unpatching transition
@@ -92,14 +92,14 @@ livepatch: '$MOD_REPLACE': completing patching transition
 livepatch: '$MOD_REPLACE': patching complete
 $MOD_LIVEPATCH1: this has been live patched
 $MOD_REPLACE: this has been live patched
-% echo 0 > /sys/kernel/livepatch/$MOD_REPLACE/enabled
+% echo 0 > $SYSFS_KLP_DIR/$MOD_REPLACE/enabled
 livepatch: '$MOD_REPLACE': initializing unpatching transition
 livepatch: '$MOD_REPLACE': starting unpatching transition
 livepatch: '$MOD_REPLACE': completing unpatching transition
 livepatch: '$MOD_REPLACE': unpatching complete
 % rmmod $MOD_REPLACE
 $MOD_LIVEPATCH1: this has been live patched
-% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH1/enabled
+% echo 0 > $SYSFS_KLP_DIR/$MOD_LIVEPATCH1/enabled
 livepatch: '$MOD_LIVEPATCH1': initializing unpatching transition
 livepatch: '$MOD_LIVEPATCH1': starting unpatching transition
 livepatch: '$MOD_LIVEPATCH1': completing unpatching transition
@@ -128,7 +128,7 @@ for mod in $MOD_LIVEPATCH2 $MOD_LIVEPATCH3; do
 	load_lp "$mod"
 done
 
-mods=(/sys/kernel/livepatch/*)
+mods=($SYSFS_KLP_DIR/*)
 nmods=${#mods[@]}
 if [ "$nmods" -ne 3 ]; then
 	die "Expecting three modules listed, found $nmods"
@@ -139,7 +139,7 @@ load_lp $MOD_REPLACE replace=1
 grep 'live patched' /proc/cmdline > /dev/kmsg
 grep 'live patched' /proc/meminfo > /dev/kmsg
 
-loop_until 'mods=(/sys/kernel/livepatch/*); nmods=${#mods[@]}; [[ "$nmods" -eq 1 ]]' ||
+loop_until 'mods=($SYSFS_KLP_DIR/*); nmods=${#mods[@]}; [[ "$nmods" -eq 1 ]]' ||
         die "Expecting only one moduled listed, found $nmods"
 
 # These modules were disabled by the atomic replace
@@ -188,7 +188,7 @@ $MOD_REPLACE: this has been live patched
 % rmmod $MOD_LIVEPATCH2
 % rmmod $MOD_LIVEPATCH1
 $MOD_REPLACE: this has been live patched
-% echo 0 > /sys/kernel/livepatch/$MOD_REPLACE/enabled
+% echo 0 > $SYSFS_KLP_DIR/$MOD_REPLACE/enabled
 livepatch: '$MOD_REPLACE': initializing unpatching transition
 livepatch: '$MOD_REPLACE': starting unpatching transition
 livepatch: '$MOD_REPLACE': completing unpatching transition
diff --git a/tools/testing/selftests/livepatch/test-state.sh b/tools/testing/selftests/livepatch/test-state.sh
index 10a52ac06185..04b66380f8a0 100755
--- a/tools/testing/selftests/livepatch/test-state.sh
+++ b/tools/testing/selftests/livepatch/test-state.sh
@@ -29,7 +29,7 @@ livepatch: '$MOD_LIVEPATCH': completing patching transition
 $MOD_LIVEPATCH: post_patch_callback: vmlinux
 $MOD_LIVEPATCH: fix_console_loglevel: fixing console_loglevel
 livepatch: '$MOD_LIVEPATCH': patching complete
-% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
+% echo 0 > $SYSFS_KLP_DIR/$MOD_LIVEPATCH/enabled
 livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
 $MOD_LIVEPATCH: pre_unpatch_callback: vmlinux
 $MOD_LIVEPATCH: restore_console_loglevel: restoring console_loglevel
@@ -72,7 +72,7 @@ $MOD_LIVEPATCH2: post_patch_callback: vmlinux
 $MOD_LIVEPATCH2: fix_console_loglevel: taking over the console_loglevel change
 livepatch: '$MOD_LIVEPATCH2': patching complete
 % rmmod $MOD_LIVEPATCH
-% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH2/enabled
+% echo 0 > $SYSFS_KLP_DIR/$MOD_LIVEPATCH2/enabled
 livepatch: '$MOD_LIVEPATCH2': initializing unpatching transition
 $MOD_LIVEPATCH2: pre_unpatch_callback: vmlinux
 $MOD_LIVEPATCH2: restore_console_loglevel: restoring console_loglevel
@@ -127,7 +127,7 @@ livepatch: '$MOD_LIVEPATCH2': completing patching transition
 $MOD_LIVEPATCH2: post_patch_callback: vmlinux
 $MOD_LIVEPATCH2: fix_console_loglevel: taking over the console_loglevel change
 livepatch: '$MOD_LIVEPATCH2': patching complete
-% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH2/enabled
+% echo 0 > $SYSFS_KLP_DIR/$MOD_LIVEPATCH2/enabled
 livepatch: '$MOD_LIVEPATCH2': initializing unpatching transition
 $MOD_LIVEPATCH2: pre_unpatch_callback: vmlinux
 $MOD_LIVEPATCH2: restore_console_loglevel: restoring console_loglevel
@@ -162,7 +162,7 @@ livepatch: '$MOD_LIVEPATCH2': patching complete
 % insmod test_modules/$MOD_LIVEPATCH.ko
 livepatch: Livepatch patch ($MOD_LIVEPATCH) is not compatible with the already installed livepatches.
 insmod: ERROR: could not insert module test_modules/$MOD_LIVEPATCH.ko: Invalid parameters
-% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH2/enabled
+% echo 0 > $SYSFS_KLP_DIR/$MOD_LIVEPATCH2/enabled
 livepatch: '$MOD_LIVEPATCH2': initializing unpatching transition
 $MOD_LIVEPATCH2: pre_unpatch_callback: vmlinux
 $MOD_LIVEPATCH2: restore_console_loglevel: restoring console_loglevel
diff --git a/tools/testing/selftests/livepatch/test-syscall.sh b/tools/testing/selftests/livepatch/test-syscall.sh
index 289eb7d4c4b3..9347464a89a0 100755
--- a/tools/testing/selftests/livepatch/test-syscall.sh
+++ b/tools/testing/selftests/livepatch/test-syscall.sh
@@ -46,7 +46,7 @@ livepatch: '$MOD_SYSCALL': starting patching transition
 livepatch: '$MOD_SYSCALL': completing patching transition
 livepatch: '$MOD_SYSCALL': patching complete
 $MOD_SYSCALL: Remaining not livepatched processes: 0
-% echo 0 > /sys/kernel/livepatch/$MOD_SYSCALL/enabled
+% echo 0 > $SYSFS_KLP_DIR/$MOD_SYSCALL/enabled
 livepatch: '$MOD_SYSCALL': initializing unpatching transition
 livepatch: '$MOD_SYSCALL': starting unpatching transition
 livepatch: '$MOD_SYSCALL': completing unpatching transition
diff --git a/tools/testing/selftests/livepatch/test-sysfs.sh b/tools/testing/selftests/livepatch/test-sysfs.sh
index 05a14f5a7bfb..2c91428d2997 100755
--- a/tools/testing/selftests/livepatch/test-sysfs.sh
+++ b/tools/testing/selftests/livepatch/test-sysfs.sh
@@ -34,7 +34,7 @@ livepatch: '$MOD_LIVEPATCH': initializing patching transition
 livepatch: '$MOD_LIVEPATCH': starting patching transition
 livepatch: '$MOD_LIVEPATCH': completing patching transition
 livepatch: '$MOD_LIVEPATCH': patching complete
-% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
+% echo 0 > $SYSFS_KLP_DIR/$MOD_LIVEPATCH/enabled
 livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
 livepatch: '$MOD_LIVEPATCH': starting unpatching transition
 livepatch: '$MOD_LIVEPATCH': completing unpatching transition
@@ -75,7 +75,7 @@ test_klp_callbacks_mod: test_klp_callbacks_mod_exit
 test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
 livepatch: reverting patch 'test_klp_callbacks_demo' on unloading module 'test_klp_callbacks_mod'
 test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_GOING] Going away
-% echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
+% echo 0 > $SYSFS_KLP_DIR/test_klp_callbacks_demo/enabled
 livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
 test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
 livepatch: 'test_klp_callbacks_demo': starting unpatching transition
@@ -101,7 +101,7 @@ livepatch: '$MOD_LIVEPATCH': initializing patching transition
 livepatch: '$MOD_LIVEPATCH': starting patching transition
 livepatch: '$MOD_LIVEPATCH': completing patching transition
 livepatch: '$MOD_LIVEPATCH': patching complete
-% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
+% echo 0 > $SYSFS_KLP_DIR/$MOD_LIVEPATCH/enabled
 livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
 livepatch: '$MOD_LIVEPATCH': starting unpatching transition
 livepatch: '$MOD_LIVEPATCH': completing unpatching transition
@@ -124,7 +124,7 @@ livepatch: '$MOD_LIVEPATCH': initializing patching transition
 livepatch: '$MOD_LIVEPATCH': starting patching transition
 livepatch: '$MOD_LIVEPATCH': completing patching transition
 livepatch: '$MOD_LIVEPATCH': patching complete
-% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
+% echo 0 > $SYSFS_KLP_DIR/$MOD_LIVEPATCH/enabled
 livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
 livepatch: '$MOD_LIVEPATCH': starting unpatching transition
 livepatch: '$MOD_LIVEPATCH': completing unpatching transition
-- 
2.47.0


