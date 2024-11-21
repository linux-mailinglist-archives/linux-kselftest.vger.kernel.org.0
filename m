Return-Path: <linux-kselftest+bounces-22401-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4993F9D4B5A
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 12:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1C4B1F23ECD
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 11:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8B31D4325;
	Thu, 21 Nov 2024 11:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kBCwBzxn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDC61D4169
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Nov 2024 11:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732187569; cv=none; b=Y3LU2Z39Bkfxk55tyGhd4h9upU8z6W5IMRqVu+luC9DV7sWdnyAjGIaZlsw4tWB4XLFUczjAPsjZ8VQewpl2+g7/n2sA8cxQtC3Qt6j8G01LRLOR7WY4eS7EJwb47xcl/CUk2VMiJzK/6+7FH1meJVpJexAuA/6Y/dMkbu5/3m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732187569; c=relaxed/simple;
	bh=RRtJFy3H+j5Va2Ad03syX0ml7ZhdIHJZUwcDEOUERak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=klI8p7KWLMVOW99QG98/Hh7u1lgVxJdft13wemE2UVfLbHbf2o2KKjrco2jRWPkJcfxRYjWpD5KphTa7pgUrs69U8iqelwuamboHVZs68KAMveQp8hQABwZU6YQd7t/W7KBtvdSivWtXyhCIzOEqtym/wWLl2VCYY47H/fXCBQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kBCwBzxn; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732187565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MgYqTMe5Lo0DxiDXXWlq/mu1KpAbTwPFzNCKycN/3KA=;
	b=kBCwBzxn8dV1dQvTC1NtvK2wUI5wbJzztiZJ6bEP+vWgDZO8b9fDT8qrfLaHtaykjAgiyq
	6Je7JPeFq4XFf0fAs4ZFX5ceNmVcis0zm4sqfGO24ht+lplF2Kg9ZACJT4hlz/zLX4+7k9
	a+DteLKcyBczGn7FCOXkU2g8keZUxKQ=
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
Subject: [PATCH livepatch/master v1 4/6] selftests/livepatch: fix test-state.sh execution error
Date: Thu, 21 Nov 2024 19:11:33 +0800
Message-Id: <20241121111135.2125391-4-dongtai.guo@linux.dev>
In-Reply-To: <20241121111135.2125391-1-dongtai.guo@linux.dev>
References: <20241121111135.2125391-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

$ sudo ./test-state.sh
TEST: system state modification ... not ok

- expected
+ result
 % insmod test_modules/test_klp_state.ko
 livepatch: enabling patch 'test_klp_state'
-livepatch: 'test_klp_state': initializing patching transition
+transition: 'test_klp_state': initializing patching transition
 test_klp_state: pre_patch_callback: vmlinux
 test_klp_state: allocate_loglevel_state: allocating space to store console_loglevel
-livepatch: 'test_klp_state': starting patching transition
-livepatch: 'test_klp_state': completing patching transition
+transition: 'test_klp_state': starting patching transition
+transition: 'test_klp_state': completing patching transition
 test_klp_state: post_patch_callback: vmlinux
 test_klp_state: fix_console_loglevel: fixing console_loglevel
-livepatch: 'test_klp_state': patching complete
+transition: 'test_klp_state': patching complete
 % echo 0 > /sys/kernel/livepatch/test_klp_state/enabled
-livepatch: 'test_klp_state': initializing unpatching transition
+transition: 'test_klp_state': initializing unpatching transition
 test_klp_state: pre_unpatch_callback: vmlinux
 test_klp_state: restore_console_loglevel: restoring console_loglevel
-livepatch: 'test_klp_state': starting unpatching transition
-livepatch: 'test_klp_state': completing unpatching transition
+transition: 'test_klp_state': starting unpatching transition
+transition: 'test_klp_state': completing unpatching transition
 test_klp_state: post_unpatch_callback: vmlinux
 test_klp_state: free_loglevel_state: freeing space for the stored console_loglevel
-livepatch: 'test_klp_state': unpatching complete
+transition: 'test_klp_state': unpatching complete
 % rmmod test_klp_state

ERROR: livepatch kselftest(s) failed

The issue arises due to a mismatch in expected log output during livepatch
transition. Specifically, the logs previously contained "livepatch:" but have
now been updated to "transition:". This results in test failures when comparing
the output with the expected values.

This patch updates the expected test output to reflect the new log format.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 .../testing/selftests/livepatch/test-state.sh | 88 +++++++++----------
 1 file changed, 44 insertions(+), 44 deletions(-)

diff --git a/tools/testing/selftests/livepatch/test-state.sh b/tools/testing/selftests/livepatch/test-state.sh
index 10a52ac06185..887e9b4e8a77 100755
--- a/tools/testing/selftests/livepatch/test-state.sh
+++ b/tools/testing/selftests/livepatch/test-state.sh
@@ -21,23 +21,23 @@ unload_lp $MOD_LIVEPATCH
 
 check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
 livepatch: enabling patch '$MOD_LIVEPATCH'
-livepatch: '$MOD_LIVEPATCH': initializing patching transition
+transition: '$MOD_LIVEPATCH': initializing patching transition
 $MOD_LIVEPATCH: pre_patch_callback: vmlinux
 $MOD_LIVEPATCH: allocate_loglevel_state: allocating space to store console_loglevel
-livepatch: '$MOD_LIVEPATCH': starting patching transition
-livepatch: '$MOD_LIVEPATCH': completing patching transition
+transition: '$MOD_LIVEPATCH': starting patching transition
+transition: '$MOD_LIVEPATCH': completing patching transition
 $MOD_LIVEPATCH: post_patch_callback: vmlinux
 $MOD_LIVEPATCH: fix_console_loglevel: fixing console_loglevel
-livepatch: '$MOD_LIVEPATCH': patching complete
+transition: '$MOD_LIVEPATCH': patching complete
 % echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
-livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
+transition: '$MOD_LIVEPATCH': initializing unpatching transition
 $MOD_LIVEPATCH: pre_unpatch_callback: vmlinux
 $MOD_LIVEPATCH: restore_console_loglevel: restoring console_loglevel
-livepatch: '$MOD_LIVEPATCH': starting unpatching transition
-livepatch: '$MOD_LIVEPATCH': completing unpatching transition
+transition: '$MOD_LIVEPATCH': starting unpatching transition
+transition: '$MOD_LIVEPATCH': completing unpatching transition
 $MOD_LIVEPATCH: post_unpatch_callback: vmlinux
 $MOD_LIVEPATCH: free_loglevel_state: freeing space for the stored console_loglevel
-livepatch: '$MOD_LIVEPATCH': unpatching complete
+transition: '$MOD_LIVEPATCH': unpatching complete
 % rmmod $MOD_LIVEPATCH"
 
 
@@ -53,34 +53,34 @@ unload_lp $MOD_LIVEPATCH2
 
 check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
 livepatch: enabling patch '$MOD_LIVEPATCH'
-livepatch: '$MOD_LIVEPATCH': initializing patching transition
+transition: '$MOD_LIVEPATCH': initializing patching transition
 $MOD_LIVEPATCH: pre_patch_callback: vmlinux
 $MOD_LIVEPATCH: allocate_loglevel_state: allocating space to store console_loglevel
-livepatch: '$MOD_LIVEPATCH': starting patching transition
-livepatch: '$MOD_LIVEPATCH': completing patching transition
+transition: '$MOD_LIVEPATCH': starting patching transition
+transition: '$MOD_LIVEPATCH': completing patching transition
 $MOD_LIVEPATCH: post_patch_callback: vmlinux
 $MOD_LIVEPATCH: fix_console_loglevel: fixing console_loglevel
-livepatch: '$MOD_LIVEPATCH': patching complete
+transition: '$MOD_LIVEPATCH': patching complete
 % insmod test_modules/$MOD_LIVEPATCH2.ko
 livepatch: enabling patch '$MOD_LIVEPATCH2'
-livepatch: '$MOD_LIVEPATCH2': initializing patching transition
+transition: '$MOD_LIVEPATCH2': initializing patching transition
 $MOD_LIVEPATCH2: pre_patch_callback: vmlinux
 $MOD_LIVEPATCH2: allocate_loglevel_state: space to store console_loglevel already allocated
-livepatch: '$MOD_LIVEPATCH2': starting patching transition
-livepatch: '$MOD_LIVEPATCH2': completing patching transition
+transition: '$MOD_LIVEPATCH2': starting patching transition
+transition: '$MOD_LIVEPATCH2': completing patching transition
 $MOD_LIVEPATCH2: post_patch_callback: vmlinux
 $MOD_LIVEPATCH2: fix_console_loglevel: taking over the console_loglevel change
-livepatch: '$MOD_LIVEPATCH2': patching complete
+transition: '$MOD_LIVEPATCH2': patching complete
 % rmmod $MOD_LIVEPATCH
 % echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH2/enabled
-livepatch: '$MOD_LIVEPATCH2': initializing unpatching transition
+transition: '$MOD_LIVEPATCH2': initializing unpatching transition
 $MOD_LIVEPATCH2: pre_unpatch_callback: vmlinux
 $MOD_LIVEPATCH2: restore_console_loglevel: restoring console_loglevel
-livepatch: '$MOD_LIVEPATCH2': starting unpatching transition
-livepatch: '$MOD_LIVEPATCH2': completing unpatching transition
+transition: '$MOD_LIVEPATCH2': starting unpatching transition
+transition: '$MOD_LIVEPATCH2': completing unpatching transition
 $MOD_LIVEPATCH2: post_unpatch_callback: vmlinux
 $MOD_LIVEPATCH2: free_loglevel_state: freeing space for the stored console_loglevel
-livepatch: '$MOD_LIVEPATCH2': unpatching complete
+transition: '$MOD_LIVEPATCH2': unpatching complete
 % rmmod $MOD_LIVEPATCH2"
 
 
@@ -98,44 +98,44 @@ unload_lp $MOD_LIVEPATCH3
 
 check_result "% insmod test_modules/$MOD_LIVEPATCH2.ko
 livepatch: enabling patch '$MOD_LIVEPATCH2'
-livepatch: '$MOD_LIVEPATCH2': initializing patching transition
+transition: '$MOD_LIVEPATCH2': initializing patching transition
 $MOD_LIVEPATCH2: pre_patch_callback: vmlinux
 $MOD_LIVEPATCH2: allocate_loglevel_state: allocating space to store console_loglevel
-livepatch: '$MOD_LIVEPATCH2': starting patching transition
-livepatch: '$MOD_LIVEPATCH2': completing patching transition
+transition: '$MOD_LIVEPATCH2': starting patching transition
+transition: '$MOD_LIVEPATCH2': completing patching transition
 $MOD_LIVEPATCH2: post_patch_callback: vmlinux
 $MOD_LIVEPATCH2: fix_console_loglevel: fixing console_loglevel
-livepatch: '$MOD_LIVEPATCH2': patching complete
+transition: '$MOD_LIVEPATCH2': patching complete
 % insmod test_modules/$MOD_LIVEPATCH3.ko
 livepatch: enabling patch '$MOD_LIVEPATCH3'
-livepatch: '$MOD_LIVEPATCH3': initializing patching transition
+transition: '$MOD_LIVEPATCH3': initializing patching transition
 $MOD_LIVEPATCH3: pre_patch_callback: vmlinux
 $MOD_LIVEPATCH3: allocate_loglevel_state: space to store console_loglevel already allocated
-livepatch: '$MOD_LIVEPATCH3': starting patching transition
-livepatch: '$MOD_LIVEPATCH3': completing patching transition
+transition: '$MOD_LIVEPATCH3': starting patching transition
+transition: '$MOD_LIVEPATCH3': completing patching transition
 $MOD_LIVEPATCH3: post_patch_callback: vmlinux
 $MOD_LIVEPATCH3: fix_console_loglevel: taking over the console_loglevel change
-livepatch: '$MOD_LIVEPATCH3': patching complete
+transition: '$MOD_LIVEPATCH3': patching complete
 % rmmod $MOD_LIVEPATCH2
 % insmod test_modules/$MOD_LIVEPATCH2.ko
 livepatch: enabling patch '$MOD_LIVEPATCH2'
-livepatch: '$MOD_LIVEPATCH2': initializing patching transition
+transition: '$MOD_LIVEPATCH2': initializing patching transition
 $MOD_LIVEPATCH2: pre_patch_callback: vmlinux
 $MOD_LIVEPATCH2: allocate_loglevel_state: space to store console_loglevel already allocated
-livepatch: '$MOD_LIVEPATCH2': starting patching transition
-livepatch: '$MOD_LIVEPATCH2': completing patching transition
+transition: '$MOD_LIVEPATCH2': starting patching transition
+transition: '$MOD_LIVEPATCH2': completing patching transition
 $MOD_LIVEPATCH2: post_patch_callback: vmlinux
 $MOD_LIVEPATCH2: fix_console_loglevel: taking over the console_loglevel change
-livepatch: '$MOD_LIVEPATCH2': patching complete
+transition: '$MOD_LIVEPATCH2': patching complete
 % echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH2/enabled
-livepatch: '$MOD_LIVEPATCH2': initializing unpatching transition
+transition: '$MOD_LIVEPATCH2': initializing unpatching transition
 $MOD_LIVEPATCH2: pre_unpatch_callback: vmlinux
 $MOD_LIVEPATCH2: restore_console_loglevel: restoring console_loglevel
-livepatch: '$MOD_LIVEPATCH2': starting unpatching transition
-livepatch: '$MOD_LIVEPATCH2': completing unpatching transition
+transition: '$MOD_LIVEPATCH2': starting unpatching transition
+transition: '$MOD_LIVEPATCH2': completing unpatching transition
 $MOD_LIVEPATCH2: post_unpatch_callback: vmlinux
 $MOD_LIVEPATCH2: free_loglevel_state: freeing space for the stored console_loglevel
-livepatch: '$MOD_LIVEPATCH2': unpatching complete
+transition: '$MOD_LIVEPATCH2': unpatching complete
 % rmmod $MOD_LIVEPATCH2
 % rmmod $MOD_LIVEPATCH3"
 
@@ -151,26 +151,26 @@ unload_lp $MOD_LIVEPATCH2
 
 check_result "% insmod test_modules/$MOD_LIVEPATCH2.ko
 livepatch: enabling patch '$MOD_LIVEPATCH2'
-livepatch: '$MOD_LIVEPATCH2': initializing patching transition
+transition: '$MOD_LIVEPATCH2': initializing patching transition
 $MOD_LIVEPATCH2: pre_patch_callback: vmlinux
 $MOD_LIVEPATCH2: allocate_loglevel_state: allocating space to store console_loglevel
-livepatch: '$MOD_LIVEPATCH2': starting patching transition
-livepatch: '$MOD_LIVEPATCH2': completing patching transition
+transition: '$MOD_LIVEPATCH2': starting patching transition
+transition: '$MOD_LIVEPATCH2': completing patching transition
 $MOD_LIVEPATCH2: post_patch_callback: vmlinux
 $MOD_LIVEPATCH2: fix_console_loglevel: fixing console_loglevel
-livepatch: '$MOD_LIVEPATCH2': patching complete
+transition: '$MOD_LIVEPATCH2': patching complete
 % insmod test_modules/$MOD_LIVEPATCH.ko
 livepatch: Livepatch patch ($MOD_LIVEPATCH) is not compatible with the already installed livepatches.
 insmod: ERROR: could not insert module test_modules/$MOD_LIVEPATCH.ko: Invalid parameters
 % echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH2/enabled
-livepatch: '$MOD_LIVEPATCH2': initializing unpatching transition
+transition: '$MOD_LIVEPATCH2': initializing unpatching transition
 $MOD_LIVEPATCH2: pre_unpatch_callback: vmlinux
 $MOD_LIVEPATCH2: restore_console_loglevel: restoring console_loglevel
-livepatch: '$MOD_LIVEPATCH2': starting unpatching transition
-livepatch: '$MOD_LIVEPATCH2': completing unpatching transition
+transition: '$MOD_LIVEPATCH2': starting unpatching transition
+transition: '$MOD_LIVEPATCH2': completing unpatching transition
 $MOD_LIVEPATCH2: post_unpatch_callback: vmlinux
 $MOD_LIVEPATCH2: free_loglevel_state: freeing space for the stored console_loglevel
-livepatch: '$MOD_LIVEPATCH2': unpatching complete
+transition: '$MOD_LIVEPATCH2': unpatching complete
 % rmmod $MOD_LIVEPATCH2"
 
 exit 0
-- 
2.39.2


