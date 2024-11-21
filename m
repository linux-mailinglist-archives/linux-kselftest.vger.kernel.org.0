Return-Path: <linux-kselftest+bounces-22400-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 965569D4B58
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 12:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6728B24E12
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 11:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E206A1D2207;
	Thu, 21 Nov 2024 11:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bSdBf8Ud"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FAA1D12E0
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Nov 2024 11:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732187563; cv=none; b=VVRrCx4kj70nJ1TL4u6ssn4j97Gaw4Nc1DL60RciGKVcojuQZlKoiGu9I80sg4F0aSGJmNI8oE5ntpQiOrMtlAcPcMgvf/G0VCzyCyaHOt5bSL3f0OheNHVdQzzpqLEDA2OpecF64qZ72JLB1dv9IXM0eblGbPIvaqQd9BMduTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732187563; c=relaxed/simple;
	bh=cuSWXdblIY4jzjhsbnCq7V0LEkWVfYfZ9OO8BaovfQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kc3s3DuxoENTzTnwOqikEZtT0Bdh/urIJkwxXPHVW1ZcMy73CW1NawdYbZ20ebJART6Z9gQhF6GVRy/XoMST79vv+wn+U7nu3In/XasHPDoG0tn2pbW2dbGd1jYfcoT2CuFQCf+/9Lz7GwWlzZEqjxee7Y/xyLKzB1loNTJB8WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bSdBf8Ud; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732187560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Maji7FxozMUFLkaNeeOZzfTm4x1U5petjUrW+pAnx8M=;
	b=bSdBf8UddCdj/BfpeG7XflSm6+KUfbBntOpTyHItXufBhf/F+U8mWsspupm4ohXmCNRQ9m
	7jw9CaN9O3w4cs/7Js1I0tEVORBqcLMq8BaMjtC9D3uW+l8exPI+VDv9//fO/RSFT0thT7
	u7Cv6xNIZGd+bm4k9JmajQXjUeoAaQs=
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
Subject: [PATCH livepatch/master v1 3/6] selftests/livepatch: fix test-livepatch.sh execution error
Date: Thu, 21 Nov 2024 19:11:32 +0800
Message-Id: <20241121111135.2125391-3-dongtai.guo@linux.dev>
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

The script test-callbacks.sh fails with the following error:
$ sudo ./test-livepatch.sh
TEST: basic function patching ... not ok

- expected
+ result
 % insmod test_modules/test_klp_livepatch.ko
 livepatch: enabling patch 'test_klp_livepatch'
-livepatch: 'test_klp_livepatch': initializing patching transition
-livepatch: 'test_klp_livepatch': starting patching transition
-livepatch: 'test_klp_livepatch': completing patching transition
-livepatch: 'test_klp_livepatch': patching complete
+transition: 'test_klp_livepatch': initializing patching transition
+transition: 'test_klp_livepatch': starting patching transition
+transition: 'test_klp_livepatch': completing patching transition
+transition: 'test_klp_livepatch': patching complete
 % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
-livepatch: 'test_klp_livepatch': initializing unpatching transition
-livepatch: 'test_klp_livepatch': starting unpatching transition
-livepatch: 'test_klp_livepatch': completing unpatching transition
-livepatch: 'test_klp_livepatch': unpatching complete
+transition: 'test_klp_livepatch': initializing unpatching transition
+transition: 'test_klp_livepatch': starting unpatching transition
+transition: 'test_klp_livepatch': completing unpatching transition
+transition: 'test_klp_livepatch': unpatching complete
 % rmmod test_klp_livepatch

ERROR: livepatch kselftest(s) failed

The issue arises due to a mismatch in expected log output during livepatch
transition. Specifically, the logs previously contained "livepatch:" but have
now been updated to "transition:". This results in test failures when comparing
the output with the expected values.

This patch updates the expected test output to reflect the new log format.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 .../selftests/livepatch/test-livepatch.sh     | 88 +++++++++----------
 1 file changed, 44 insertions(+), 44 deletions(-)

diff --git a/tools/testing/selftests/livepatch/test-livepatch.sh b/tools/testing/selftests/livepatch/test-livepatch.sh
index bd13257bfdfe..1297a6bf2bdd 100755
--- a/tools/testing/selftests/livepatch/test-livepatch.sh
+++ b/tools/testing/selftests/livepatch/test-livepatch.sh
@@ -35,15 +35,15 @@ fi
 
 check_result "% insmod test_modules/$MOD_LIVEPATCH1.ko
 livepatch: enabling patch '$MOD_LIVEPATCH1'
-livepatch: '$MOD_LIVEPATCH1': initializing patching transition
-livepatch: '$MOD_LIVEPATCH1': starting patching transition
-livepatch: '$MOD_LIVEPATCH1': completing patching transition
-livepatch: '$MOD_LIVEPATCH1': patching complete
+transition: '$MOD_LIVEPATCH1': initializing patching transition
+transition: '$MOD_LIVEPATCH1': starting patching transition
+transition: '$MOD_LIVEPATCH1': completing patching transition
+transition: '$MOD_LIVEPATCH1': patching complete
 % echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH1/enabled
-livepatch: '$MOD_LIVEPATCH1': initializing unpatching transition
-livepatch: '$MOD_LIVEPATCH1': starting unpatching transition
-livepatch: '$MOD_LIVEPATCH1': completing unpatching transition
-livepatch: '$MOD_LIVEPATCH1': unpatching complete
+transition: '$MOD_LIVEPATCH1': initializing unpatching transition
+transition: '$MOD_LIVEPATCH1': starting unpatching transition
+transition: '$MOD_LIVEPATCH1': completing unpatching transition
+transition: '$MOD_LIVEPATCH1': unpatching complete
 % rmmod $MOD_LIVEPATCH1"
 
 
@@ -79,31 +79,31 @@ grep 'live patched' /proc/meminfo > /dev/kmsg
 
 check_result "% insmod test_modules/$MOD_LIVEPATCH1.ko
 livepatch: enabling patch '$MOD_LIVEPATCH1'
-livepatch: '$MOD_LIVEPATCH1': initializing patching transition
-livepatch: '$MOD_LIVEPATCH1': starting patching transition
-livepatch: '$MOD_LIVEPATCH1': completing patching transition
-livepatch: '$MOD_LIVEPATCH1': patching complete
+transition: '$MOD_LIVEPATCH1': initializing patching transition
+transition: '$MOD_LIVEPATCH1': starting patching transition
+transition: '$MOD_LIVEPATCH1': completing patching transition
+transition: '$MOD_LIVEPATCH1': patching complete
 $MOD_LIVEPATCH1: this has been live patched
 % insmod test_modules/$MOD_REPLACE.ko replace=0
 livepatch: enabling patch '$MOD_REPLACE'
-livepatch: '$MOD_REPLACE': initializing patching transition
-livepatch: '$MOD_REPLACE': starting patching transition
-livepatch: '$MOD_REPLACE': completing patching transition
-livepatch: '$MOD_REPLACE': patching complete
+transition: '$MOD_REPLACE': initializing patching transition
+transition: '$MOD_REPLACE': starting patching transition
+transition: '$MOD_REPLACE': completing patching transition
+transition: '$MOD_REPLACE': patching complete
 $MOD_LIVEPATCH1: this has been live patched
 $MOD_REPLACE: this has been live patched
 % echo 0 > /sys/kernel/livepatch/$MOD_REPLACE/enabled
-livepatch: '$MOD_REPLACE': initializing unpatching transition
-livepatch: '$MOD_REPLACE': starting unpatching transition
-livepatch: '$MOD_REPLACE': completing unpatching transition
-livepatch: '$MOD_REPLACE': unpatching complete
+transition: '$MOD_REPLACE': initializing unpatching transition
+transition: '$MOD_REPLACE': starting unpatching transition
+transition: '$MOD_REPLACE': completing unpatching transition
+transition: '$MOD_REPLACE': unpatching complete
 % rmmod $MOD_REPLACE
 $MOD_LIVEPATCH1: this has been live patched
 % echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH1/enabled
-livepatch: '$MOD_LIVEPATCH1': initializing unpatching transition
-livepatch: '$MOD_LIVEPATCH1': starting unpatching transition
-livepatch: '$MOD_LIVEPATCH1': completing unpatching transition
-livepatch: '$MOD_LIVEPATCH1': unpatching complete
+transition: '$MOD_LIVEPATCH1': initializing unpatching transition
+transition: '$MOD_LIVEPATCH1': starting unpatching transition
+transition: '$MOD_LIVEPATCH1': completing unpatching transition
+transition: '$MOD_LIVEPATCH1': unpatching complete
 % rmmod $MOD_LIVEPATCH1"
 
 
@@ -158,41 +158,41 @@ grep 'live patched' /proc/meminfo > /dev/kmsg
 
 check_result "% insmod test_modules/$MOD_LIVEPATCH1.ko
 livepatch: enabling patch '$MOD_LIVEPATCH1'
-livepatch: '$MOD_LIVEPATCH1': initializing patching transition
-livepatch: '$MOD_LIVEPATCH1': starting patching transition
-livepatch: '$MOD_LIVEPATCH1': completing patching transition
-livepatch: '$MOD_LIVEPATCH1': patching complete
+transition: '$MOD_LIVEPATCH1': initializing patching transition
+transition: '$MOD_LIVEPATCH1': starting patching transition
+transition: '$MOD_LIVEPATCH1': completing patching transition
+transition: '$MOD_LIVEPATCH1': patching complete
 $MOD_LIVEPATCH1: this has been live patched
 % insmod test_modules/$MOD_LIVEPATCH2.ko
 livepatch: enabling patch '$MOD_LIVEPATCH2'
-livepatch: '$MOD_LIVEPATCH2': initializing patching transition
-livepatch: '$MOD_LIVEPATCH2': starting patching transition
-livepatch: '$MOD_LIVEPATCH2': completing patching transition
-livepatch: '$MOD_LIVEPATCH2': patching complete
+transition: '$MOD_LIVEPATCH2': initializing patching transition
+transition: '$MOD_LIVEPATCH2': starting patching transition
+transition: '$MOD_LIVEPATCH2': completing patching transition
+transition: '$MOD_LIVEPATCH2': patching complete
 % insmod test_modules/$MOD_LIVEPATCH3.ko
 livepatch: enabling patch '$MOD_LIVEPATCH3'
-livepatch: '$MOD_LIVEPATCH3': initializing patching transition
+transition: '$MOD_LIVEPATCH3': initializing patching transition
 $MOD_LIVEPATCH3: pre_patch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH3': starting patching transition
-livepatch: '$MOD_LIVEPATCH3': completing patching transition
+transition: '$MOD_LIVEPATCH3': starting patching transition
+transition: '$MOD_LIVEPATCH3': completing patching transition
 $MOD_LIVEPATCH3: post_patch_callback: vmlinux
-livepatch: '$MOD_LIVEPATCH3': patching complete
+transition: '$MOD_LIVEPATCH3': patching complete
 % insmod test_modules/$MOD_REPLACE.ko replace=1
 livepatch: enabling patch '$MOD_REPLACE'
-livepatch: '$MOD_REPLACE': initializing patching transition
-livepatch: '$MOD_REPLACE': starting patching transition
-livepatch: '$MOD_REPLACE': completing patching transition
-livepatch: '$MOD_REPLACE': patching complete
+transition: '$MOD_REPLACE': initializing patching transition
+transition: '$MOD_REPLACE': starting patching transition
+transition: '$MOD_REPLACE': completing patching transition
+transition: '$MOD_REPLACE': patching complete
 $MOD_REPLACE: this has been live patched
 % rmmod $MOD_LIVEPATCH3
 % rmmod $MOD_LIVEPATCH2
 % rmmod $MOD_LIVEPATCH1
 $MOD_REPLACE: this has been live patched
 % echo 0 > /sys/kernel/livepatch/$MOD_REPLACE/enabled
-livepatch: '$MOD_REPLACE': initializing unpatching transition
-livepatch: '$MOD_REPLACE': starting unpatching transition
-livepatch: '$MOD_REPLACE': completing unpatching transition
-livepatch: '$MOD_REPLACE': unpatching complete
+transition: '$MOD_REPLACE': initializing unpatching transition
+transition: '$MOD_REPLACE': starting unpatching transition
+transition: '$MOD_REPLACE': completing unpatching transition
+transition: '$MOD_REPLACE': unpatching complete
 % rmmod $MOD_REPLACE"
 
 
-- 
2.39.2


