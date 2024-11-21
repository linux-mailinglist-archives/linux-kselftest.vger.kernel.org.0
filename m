Return-Path: <linux-kselftest+bounces-22397-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF64B9D4B4C
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 12:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31DCD1F2367F
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 11:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C551D0E2F;
	Thu, 21 Nov 2024 11:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lkr0OnMc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FC374068
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Nov 2024 11:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732187542; cv=none; b=ev581GW/8S2axUtY13CiMvNQufQA5ZcD78j7UeRRV89yfAW4se6RNOWpSuMfmP8HXGVC5ZlaL9rafvRWnjaes8Irz5ROXk9P2LSalP6MeecLfqxjXkLoNBEZv3frZQqlpWz3LjyLhGPxWnD3/HEmCZn7dR3P0DSdUYiuAi9FhWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732187542; c=relaxed/simple;
	bh=0RoZ1k0MIgJtAZZxA/cydZniSVik3az1/fVvoPV/yVY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KH9u/pAZxp5SClhlssHn08rMaEv411YIjVgudOm5W7atCY69gJ1cbVa53zDn+uFMrTI0VDzKMJwBP3e3B9VH6PXS7LbdLO/WsBtlDWELro5KifpVmRV+D9SXEfSCI8Pwl5GeBNmuoIh7HCuE7R1LLo6heQ1Evkde7IqWTtDQ6m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lkr0OnMc; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732187536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QC2F/Cd3ACvzMp5vlB3mOJU9ZI9rcfOM57+5Z/lBLds=;
	b=lkr0OnMc/EuTVAPMOcLvk0SbwXKHIPI2zqoChck/Hp4gumMm+pD0uTYiJWu6OuO1YJ/Ssg
	vLobk25mOBjyuGIQavvaRncaYx3vQaU6lh1OZSNj1w/Up/vyok29z11bmOcNhA50CqtX9y
	uqspN0hhX8Qqw8+el8/wAiPkWiRnDSc=
From: George Guo <dongtai.guo@linux.dev>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	shuah@kernel.org
Cc: live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH livepatch/master v1 1/6] selftests/livepatch: fix test-callbacks.sh execution error
Date: Thu, 21 Nov 2024 19:11:30 +0800
Message-Id: <20241121111135.2125391-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

The script test-callbacks.sh fails with the following error:
$ sudo ./test-callbacks.sh
TEST: target module before livepatch ... not ok

- expected
+ result
 test_klp_callbacks_mod: test_klp_callbacks_mod_init
 % insmod test_modules/test_klp_callbacks_demo.ko
 livepatch: enabling patch 'test_klp_callbacks_demo'
-livepatch: 'test_klp_callbacks_demo': initializing patching transition
+transition: 'test_klp_callbacks_demo': initializing patching transition
 test_klp_callbacks_demo: pre_patch_callback: vmlinux
 test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
-livepatch: 'test_klp_callbacks_demo': starting patching transition
-livepatch: 'test_klp_callbacks_demo': completing patching transition
+transition: 'test_klp_callbacks_demo': starting patching transition
+transition: 'test_klp_callbacks_demo': completing patching transition
 test_klp_callbacks_demo: post_patch_callback: vmlinux
 test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
-livepatch: 'test_klp_callbacks_demo': patching complete
+transition: 'test_klp_callbacks_demo': patching complete
 % echo 0 > /sys/kernel/livepatch/test_klp_callbacks_demo/enabled
-livepatch: 'test_klp_callbacks_demo': initializing unpatching transition
+transition: 'test_klp_callbacks_demo': initializing unpatching transition
 test_klp_callbacks_demo: pre_unpatch_callback: vmlinux
 test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
-livepatch: 'test_klp_callbacks_demo': starting unpatching transition
-livepatch: 'test_klp_callbacks_demo': completing unpatching transition
+transition: 'test_klp_callbacks_demo': starting unpatching transition
+transition: 'test_klp_callbacks_demo': completing unpatching transition
 test_klp_callbacks_demo: post_unpatch_callback: vmlinux
 test_klp_callbacks_demo: post_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
-livepatch: 'test_klp_callbacks_demo': unpatching complete
+transition: 'test_klp_callbacks_demo': unpatching complete
 % rmmod test_klp_callbacks_demo
 % rmmod test_klp_callbacks_mod
 test_klp_callbacks_mod: test_klp_callbacks_mod_exit

ERROR: livepatch kselftest(s) failed

The issue arises due to a mismatch in expected log output during livepatch
transition. Specifically, the logs previously contained "livepatch:" but have
now been updated to "transition:". This results in test failures when comparing
the output with the expected values.

This patch updates the expected test output to reflect the new log format.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 .../selftests/livepatch/test-callbacks.sh     | 188 +++++++++---------
 1 file changed, 94 insertions(+), 94 deletions(-)

diff --git a/tools/testing/selftests/livepatch/test-callbacks.sh b/tools/testing/selftests/livepatch/test-callbacks.sh
index 32b150e25b10..08a33c15bb29 100755
--- a/tools/testing/selftests/livepatch/test-callbacks.sh
+++ b/tools/testing/selftests/livepatch/test-callbacks.sh
@@ -38,23 +38,23 @@ check_result "% insmod test_modules/$MOD_TARGET.ko
 $MOD_TARGET: ${MOD_TARGET}_init
 % insmod test_modules/$MOD_LIVEPATCH.ko
 livepatch: enabling patch '$MOD_LIVEPATCH'
-livepatch: '$MOD_LIVEPATCH': initializing patching transition
+transition: '$MOD_LIVEPATCH': initializing patching transition
 $MOD_LIVEPATCH: pre_patch_callback: vmlinux
 $MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET -> [MODULE_STATE_LIVE] Normal state
-livepatch: '$MOD_LIVEPATCH': starting patching transition
-livepatch: '$MOD_LIVEPATCH': completing patching transition
+transition: '$MOD_LIVEPATCH': starting patching transition
+transition: '$MOD_LIVEPATCH': completing patching transition
 $MOD_LIVEPATCH: post_patch_callback: vmlinux
 $MOD_LIVEPATCH: post_patch_callback: $MOD_TARGET -> [MODULE_STATE_LIVE] Normal state
-livepatch: '$MOD_LIVEPATCH': patching complete
+transition: '$MOD_LIVEPATCH': patching complete
 % echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
-livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
+transition: '$MOD_LIVEPATCH': initializing unpatching transition
 $MOD_LIVEPATCH: pre_unpatch_callback: vmlinux
 $MOD_LIVEPATCH: pre_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_LIVE] Normal state
-livepatch: '$MOD_LIVEPATCH': starting unpatching transition
-livepatch: '$MOD_LIVEPATCH': completing unpatching transition
+transition: '$MOD_LIVEPATCH': starting unpatching transition
+transition: '$MOD_LIVEPATCH': completing unpatching transition
 $MOD_LIVEPATCH: post_unpatch_callback: vmlinux
 $MOD_LIVEPATCH: post_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_LIVE] Normal state
-livepatch: '$MOD_LIVEPATCH': unpatching complete
+transition: '$MOD_LIVEPATCH': unpatching complete
 % rmmod $MOD_LIVEPATCH
 % rmmod $MOD_TARGET
 $MOD_TARGET: ${MOD_TARGET}_exit"
@@ -83,26 +83,26 @@ unload_mod $MOD_TARGET
 
 check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
 livepatch: enabling patch '$MOD_LIVEPATCH'
-livepatch: '$MOD_LIVEPATCH': initializing patching transition
+transition: '$MOD_LIVEPATCH': initializing patching transition
 $MOD_LIVEPATCH: pre_patch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH': starting patching transition
-livepatch: '$MOD_LIVEPATCH': completing patching transition
+transition: '$MOD_LIVEPATCH': starting patching transition
+transition: '$MOD_LIVEPATCH': completing patching transition
 $MOD_LIVEPATCH: post_patch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH': patching complete
+transition: '$MOD_LIVEPATCH': patching complete
 % insmod test_modules/$MOD_TARGET.ko
 livepatch: applying patch '$MOD_LIVEPATCH' to loading module '$MOD_TARGET'
 $MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET -> [MODULE_STATE_COMING] Full formed, running module_init
 $MOD_LIVEPATCH: post_patch_callback: $MOD_TARGET -> [MODULE_STATE_COMING] Full formed, running module_init
 $MOD_TARGET: ${MOD_TARGET}_init
 % echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
-livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
+transition: '$MOD_LIVEPATCH': initializing unpatching transition
 $MOD_LIVEPATCH: pre_unpatch_callback: vmlinux
 $MOD_LIVEPATCH: pre_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_LIVE] Normal state
-livepatch: '$MOD_LIVEPATCH': starting unpatching transition
-livepatch: '$MOD_LIVEPATCH': completing unpatching transition
+transition: '$MOD_LIVEPATCH': starting unpatching transition
+transition: '$MOD_LIVEPATCH': completing unpatching transition
 $MOD_LIVEPATCH: post_unpatch_callback: vmlinux
 $MOD_LIVEPATCH: post_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_LIVE] Normal state
-livepatch: '$MOD_LIVEPATCH': unpatching complete
+transition: '$MOD_LIVEPATCH': unpatching complete
 % rmmod $MOD_LIVEPATCH
 % rmmod $MOD_TARGET
 $MOD_TARGET: ${MOD_TARGET}_exit"
@@ -133,26 +133,26 @@ check_result "% insmod test_modules/$MOD_TARGET.ko
 $MOD_TARGET: ${MOD_TARGET}_init
 % insmod test_modules/$MOD_LIVEPATCH.ko
 livepatch: enabling patch '$MOD_LIVEPATCH'
-livepatch: '$MOD_LIVEPATCH': initializing patching transition
+transition: '$MOD_LIVEPATCH': initializing patching transition
 $MOD_LIVEPATCH: pre_patch_callback: vmlinux
 $MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET -> [MODULE_STATE_LIVE] Normal state
-livepatch: '$MOD_LIVEPATCH': starting patching transition
-livepatch: '$MOD_LIVEPATCH': completing patching transition
+transition: '$MOD_LIVEPATCH': starting patching transition
+transition: '$MOD_LIVEPATCH': completing patching transition
 $MOD_LIVEPATCH: post_patch_callback: vmlinux
 $MOD_LIVEPATCH: post_patch_callback: $MOD_TARGET -> [MODULE_STATE_LIVE] Normal state
-livepatch: '$MOD_LIVEPATCH': patching complete
+transition: '$MOD_LIVEPATCH': patching complete
 % rmmod $MOD_TARGET
 $MOD_TARGET: ${MOD_TARGET}_exit
 $MOD_LIVEPATCH: pre_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_GOING] Going away
 livepatch: reverting patch '$MOD_LIVEPATCH' on unloading module '$MOD_TARGET'
 $MOD_LIVEPATCH: post_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_GOING] Going away
 % echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
-livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
+transition: '$MOD_LIVEPATCH': initializing unpatching transition
 $MOD_LIVEPATCH: pre_unpatch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH': starting unpatching transition
-livepatch: '$MOD_LIVEPATCH': completing unpatching transition
+transition: '$MOD_LIVEPATCH': starting unpatching transition
+transition: '$MOD_LIVEPATCH': completing unpatching transition
 $MOD_LIVEPATCH: post_unpatch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH': unpatching complete
+transition: '$MOD_LIVEPATCH': unpatching complete
 % rmmod $MOD_LIVEPATCH"
 
 
@@ -179,12 +179,12 @@ unload_lp $MOD_LIVEPATCH
 
 check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
 livepatch: enabling patch '$MOD_LIVEPATCH'
-livepatch: '$MOD_LIVEPATCH': initializing patching transition
+transition: '$MOD_LIVEPATCH': initializing patching transition
 $MOD_LIVEPATCH: pre_patch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH': starting patching transition
-livepatch: '$MOD_LIVEPATCH': completing patching transition
+transition: '$MOD_LIVEPATCH': starting patching transition
+transition: '$MOD_LIVEPATCH': completing patching transition
 $MOD_LIVEPATCH: post_patch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH': patching complete
+transition: '$MOD_LIVEPATCH': patching complete
 % insmod test_modules/$MOD_TARGET.ko
 livepatch: applying patch '$MOD_LIVEPATCH' to loading module '$MOD_TARGET'
 $MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET -> [MODULE_STATE_COMING] Full formed, running module_init
@@ -196,12 +196,12 @@ $MOD_LIVEPATCH: pre_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_GOING] Going
 livepatch: reverting patch '$MOD_LIVEPATCH' on unloading module '$MOD_TARGET'
 $MOD_LIVEPATCH: post_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_GOING] Going away
 % echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
-livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
+transition: '$MOD_LIVEPATCH': initializing unpatching transition
 $MOD_LIVEPATCH: pre_unpatch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH': starting unpatching transition
-livepatch: '$MOD_LIVEPATCH': completing unpatching transition
+transition: '$MOD_LIVEPATCH': starting unpatching transition
+transition: '$MOD_LIVEPATCH': completing unpatching transition
 $MOD_LIVEPATCH: post_unpatch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH': unpatching complete
+transition: '$MOD_LIVEPATCH': unpatching complete
 % rmmod $MOD_LIVEPATCH"
 
 
@@ -221,19 +221,19 @@ unload_lp $MOD_LIVEPATCH
 
 check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
 livepatch: enabling patch '$MOD_LIVEPATCH'
-livepatch: '$MOD_LIVEPATCH': initializing patching transition
+transition: '$MOD_LIVEPATCH': initializing patching transition
 $MOD_LIVEPATCH: pre_patch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH': starting patching transition
-livepatch: '$MOD_LIVEPATCH': completing patching transition
+transition: '$MOD_LIVEPATCH': starting patching transition
+transition: '$MOD_LIVEPATCH': completing patching transition
 $MOD_LIVEPATCH: post_patch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH': patching complete
+transition: '$MOD_LIVEPATCH': patching complete
 % echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
-livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
+transition: '$MOD_LIVEPATCH': initializing unpatching transition
 $MOD_LIVEPATCH: pre_unpatch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH': starting unpatching transition
-livepatch: '$MOD_LIVEPATCH': completing unpatching transition
+transition: '$MOD_LIVEPATCH': starting unpatching transition
+transition: '$MOD_LIVEPATCH': completing unpatching transition
 $MOD_LIVEPATCH: post_unpatch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH': unpatching complete
+transition: '$MOD_LIVEPATCH': unpatching complete
 % rmmod $MOD_LIVEPATCH"
 
 
@@ -258,13 +258,13 @@ check_result "% insmod test_modules/$MOD_TARGET.ko
 $MOD_TARGET: ${MOD_TARGET}_init
 % insmod test_modules/$MOD_LIVEPATCH.ko pre_patch_ret=-19
 livepatch: enabling patch '$MOD_LIVEPATCH'
-livepatch: '$MOD_LIVEPATCH': initializing patching transition
+transition: '$MOD_LIVEPATCH': initializing patching transition
 test_klp_callbacks_demo: pre_patch_callback: vmlinux
 livepatch: pre-patch callback failed for object 'vmlinux'
 livepatch: failed to enable patch '$MOD_LIVEPATCH'
-livepatch: '$MOD_LIVEPATCH': canceling patching transition, going to unpatch
-livepatch: '$MOD_LIVEPATCH': completing unpatching transition
-livepatch: '$MOD_LIVEPATCH': unpatching complete
+transition: '$MOD_LIVEPATCH': canceling patching transition, going to unpatch
+transition: '$MOD_LIVEPATCH': completing unpatching transition
+transition: '$MOD_LIVEPATCH': unpatching complete
 insmod: ERROR: could not insert module test_modules/$MOD_LIVEPATCH.ko: No such device
 % rmmod $MOD_TARGET
 $MOD_TARGET: ${MOD_TARGET}_exit"
@@ -297,12 +297,12 @@ unload_lp $MOD_LIVEPATCH
 
 check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
 livepatch: enabling patch '$MOD_LIVEPATCH'
-livepatch: '$MOD_LIVEPATCH': initializing patching transition
+transition: '$MOD_LIVEPATCH': initializing patching transition
 $MOD_LIVEPATCH: pre_patch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH': starting patching transition
-livepatch: '$MOD_LIVEPATCH': completing patching transition
+transition: '$MOD_LIVEPATCH': starting patching transition
+transition: '$MOD_LIVEPATCH': completing patching transition
 $MOD_LIVEPATCH: post_patch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH': patching complete
+transition: '$MOD_LIVEPATCH': patching complete
 % echo -19 > /sys/module/$MOD_LIVEPATCH/parameters/pre_patch_ret
 % insmod test_modules/$MOD_TARGET.ko
 livepatch: applying patch '$MOD_LIVEPATCH' to loading module '$MOD_TARGET'
@@ -311,12 +311,12 @@ livepatch: pre-patch callback failed for object '$MOD_TARGET'
 livepatch: patch '$MOD_LIVEPATCH' failed for module '$MOD_TARGET', refusing to load module '$MOD_TARGET'
 insmod: ERROR: could not insert module test_modules/$MOD_TARGET.ko: No such device
 % echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
-livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
+transition: '$MOD_LIVEPATCH': initializing unpatching transition
 $MOD_LIVEPATCH: pre_unpatch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH': starting unpatching transition
-livepatch: '$MOD_LIVEPATCH': completing unpatching transition
+transition: '$MOD_LIVEPATCH': starting unpatching transition
+transition: '$MOD_LIVEPATCH': completing unpatching transition
 $MOD_LIVEPATCH: post_unpatch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH': unpatching complete
+transition: '$MOD_LIVEPATCH': unpatching complete
 % rmmod $MOD_LIVEPATCH"
 
 
@@ -346,14 +346,14 @@ $MOD_TARGET_BUSY: busymod_work_func enter
 $MOD_TARGET_BUSY: busymod_work_func exit
 % insmod test_modules/$MOD_LIVEPATCH.ko
 livepatch: enabling patch '$MOD_LIVEPATCH'
-livepatch: '$MOD_LIVEPATCH': initializing patching transition
+transition: '$MOD_LIVEPATCH': initializing patching transition
 $MOD_LIVEPATCH: pre_patch_callback: vmlinux
 $MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET_BUSY -> [MODULE_STATE_LIVE] Normal state
-livepatch: '$MOD_LIVEPATCH': starting patching transition
-livepatch: '$MOD_LIVEPATCH': completing patching transition
+transition: '$MOD_LIVEPATCH': starting patching transition
+transition: '$MOD_LIVEPATCH': completing patching transition
 $MOD_LIVEPATCH: post_patch_callback: vmlinux
 $MOD_LIVEPATCH: post_patch_callback: $MOD_TARGET_BUSY -> [MODULE_STATE_LIVE] Normal state
-livepatch: '$MOD_LIVEPATCH': patching complete
+transition: '$MOD_LIVEPATCH': patching complete
 % insmod test_modules/$MOD_TARGET.ko
 livepatch: applying patch '$MOD_LIVEPATCH' to loading module '$MOD_TARGET'
 $MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET -> [MODULE_STATE_COMING] Full formed, running module_init
@@ -365,14 +365,14 @@ $MOD_LIVEPATCH: pre_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_GOING] Going
 livepatch: reverting patch '$MOD_LIVEPATCH' on unloading module '$MOD_TARGET'
 $MOD_LIVEPATCH: post_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_GOING] Going away
 % echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
-livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
+transition: '$MOD_LIVEPATCH': initializing unpatching transition
 $MOD_LIVEPATCH: pre_unpatch_callback: vmlinux
 $MOD_LIVEPATCH: pre_unpatch_callback: $MOD_TARGET_BUSY -> [MODULE_STATE_LIVE] Normal state
-livepatch: '$MOD_LIVEPATCH': starting unpatching transition
-livepatch: '$MOD_LIVEPATCH': completing unpatching transition
+transition: '$MOD_LIVEPATCH': starting unpatching transition
+transition: '$MOD_LIVEPATCH': completing unpatching transition
 $MOD_LIVEPATCH: post_unpatch_callback: vmlinux
 $MOD_LIVEPATCH: post_unpatch_callback: $MOD_TARGET_BUSY -> [MODULE_STATE_LIVE] Normal state
-livepatch: '$MOD_LIVEPATCH': unpatching complete
+transition: '$MOD_LIVEPATCH': unpatching complete
 % rmmod $MOD_LIVEPATCH
 % rmmod $MOD_TARGET_BUSY
 $MOD_TARGET_BUSY: ${MOD_TARGET_BUSY}_exit"
@@ -426,10 +426,10 @@ $MOD_TARGET_BUSY: ${MOD_TARGET_BUSY}_init
 $MOD_TARGET_BUSY: busymod_work_func enter
 % insmod test_modules/$MOD_LIVEPATCH.ko
 livepatch: enabling patch '$MOD_LIVEPATCH'
-livepatch: '$MOD_LIVEPATCH': initializing patching transition
+transition: '$MOD_LIVEPATCH': initializing patching transition
 $MOD_LIVEPATCH: pre_patch_callback: vmlinux
 $MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET_BUSY -> [MODULE_STATE_LIVE] Normal state
-livepatch: '$MOD_LIVEPATCH': starting patching transition
+transition: '$MOD_LIVEPATCH': starting patching transition
 % insmod test_modules/$MOD_TARGET.ko
 livepatch: applying patch '$MOD_LIVEPATCH' to loading module '$MOD_TARGET'
 $MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET -> [MODULE_STATE_COMING] Full formed, running module_init
@@ -439,12 +439,12 @@ $MOD_TARGET: ${MOD_TARGET}_exit
 livepatch: reverting patch '$MOD_LIVEPATCH' on unloading module '$MOD_TARGET'
 $MOD_LIVEPATCH: post_unpatch_callback: $MOD_TARGET -> [MODULE_STATE_GOING] Going away
 % echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
-livepatch: '$MOD_LIVEPATCH': reversing transition from patching to unpatching
-livepatch: '$MOD_LIVEPATCH': starting unpatching transition
-livepatch: '$MOD_LIVEPATCH': completing unpatching transition
+transition: '$MOD_LIVEPATCH': reversing transition from patching to unpatching
+transition: '$MOD_LIVEPATCH': starting unpatching transition
+transition: '$MOD_LIVEPATCH': completing unpatching transition
 $MOD_LIVEPATCH: post_unpatch_callback: vmlinux
 $MOD_LIVEPATCH: post_unpatch_callback: $MOD_TARGET_BUSY -> [MODULE_STATE_LIVE] Normal state
-livepatch: '$MOD_LIVEPATCH': unpatching complete
+transition: '$MOD_LIVEPATCH': unpatching complete
 % rmmod $MOD_LIVEPATCH
 % rmmod $MOD_TARGET_BUSY
 $MOD_TARGET_BUSY: busymod_work_func exit
@@ -469,34 +469,34 @@ unload_lp $MOD_LIVEPATCH
 
 check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
 livepatch: enabling patch '$MOD_LIVEPATCH'
-livepatch: '$MOD_LIVEPATCH': initializing patching transition
+transition: '$MOD_LIVEPATCH': initializing patching transition
 $MOD_LIVEPATCH: pre_patch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH': starting patching transition
-livepatch: '$MOD_LIVEPATCH': completing patching transition
+transition: '$MOD_LIVEPATCH': starting patching transition
+transition: '$MOD_LIVEPATCH': completing patching transition
 $MOD_LIVEPATCH: post_patch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH': patching complete
+transition: '$MOD_LIVEPATCH': patching complete
 % insmod test_modules/$MOD_LIVEPATCH2.ko
 livepatch: enabling patch '$MOD_LIVEPATCH2'
-livepatch: '$MOD_LIVEPATCH2': initializing patching transition
+transition: '$MOD_LIVEPATCH2': initializing patching transition
 $MOD_LIVEPATCH2: pre_patch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH2': starting patching transition
-livepatch: '$MOD_LIVEPATCH2': completing patching transition
+transition: '$MOD_LIVEPATCH2': starting patching transition
+transition: '$MOD_LIVEPATCH2': completing patching transition
 $MOD_LIVEPATCH2: post_patch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH2': patching complete
+transition: '$MOD_LIVEPATCH2': patching complete
 % echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH2/enabled
-livepatch: '$MOD_LIVEPATCH2': initializing unpatching transition
+transition: '$MOD_LIVEPATCH2': initializing unpatching transition
 $MOD_LIVEPATCH2: pre_unpatch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH2': starting unpatching transition
-livepatch: '$MOD_LIVEPATCH2': completing unpatching transition
+transition: '$MOD_LIVEPATCH2': starting unpatching transition
+transition: '$MOD_LIVEPATCH2': completing unpatching transition
 $MOD_LIVEPATCH2: post_unpatch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH2': unpatching complete
+transition: '$MOD_LIVEPATCH2': unpatching complete
 % echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
-livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
+transition: '$MOD_LIVEPATCH': initializing unpatching transition
 $MOD_LIVEPATCH: pre_unpatch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH': starting unpatching transition
-livepatch: '$MOD_LIVEPATCH': completing unpatching transition
+transition: '$MOD_LIVEPATCH': starting unpatching transition
+transition: '$MOD_LIVEPATCH': completing unpatching transition
 $MOD_LIVEPATCH: post_unpatch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH': unpatching complete
+transition: '$MOD_LIVEPATCH': unpatching complete
 % rmmod $MOD_LIVEPATCH2
 % rmmod $MOD_LIVEPATCH"
 
@@ -525,27 +525,27 @@ unload_lp $MOD_LIVEPATCH
 
 check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
 livepatch: enabling patch '$MOD_LIVEPATCH'
-livepatch: '$MOD_LIVEPATCH': initializing patching transition
+transition: '$MOD_LIVEPATCH': initializing patching transition
 $MOD_LIVEPATCH: pre_patch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH': starting patching transition
-livepatch: '$MOD_LIVEPATCH': completing patching transition
+transition: '$MOD_LIVEPATCH': starting patching transition
+transition: '$MOD_LIVEPATCH': completing patching transition
 $MOD_LIVEPATCH: post_patch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH': patching complete
+transition: '$MOD_LIVEPATCH': patching complete
 % insmod test_modules/$MOD_LIVEPATCH2.ko replace=1
 livepatch: enabling patch '$MOD_LIVEPATCH2'
-livepatch: '$MOD_LIVEPATCH2': initializing patching transition
+transition: '$MOD_LIVEPATCH2': initializing patching transition
 $MOD_LIVEPATCH2: pre_patch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH2': starting patching transition
-livepatch: '$MOD_LIVEPATCH2': completing patching transition
+transition: '$MOD_LIVEPATCH2': starting patching transition
+transition: '$MOD_LIVEPATCH2': completing patching transition
 $MOD_LIVEPATCH2: post_patch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH2': patching complete
+transition: '$MOD_LIVEPATCH2': patching complete
 % echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH2/enabled
-livepatch: '$MOD_LIVEPATCH2': initializing unpatching transition
+transition: '$MOD_LIVEPATCH2': initializing unpatching transition
 $MOD_LIVEPATCH2: pre_unpatch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH2': starting unpatching transition
-livepatch: '$MOD_LIVEPATCH2': completing unpatching transition
+transition: '$MOD_LIVEPATCH2': starting unpatching transition
+transition: '$MOD_LIVEPATCH2': completing unpatching transition
 $MOD_LIVEPATCH2: post_unpatch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH2': unpatching complete
+transition: '$MOD_LIVEPATCH2': unpatching complete
 % rmmod $MOD_LIVEPATCH2
 % rmmod $MOD_LIVEPATCH"
 
-- 
2.39.2


