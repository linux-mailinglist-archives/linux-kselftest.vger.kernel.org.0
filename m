Return-Path: <linux-kselftest+bounces-22402-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D71D99D4B5D
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 12:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71FEF28360A
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 11:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622CB1D5171;
	Thu, 21 Nov 2024 11:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fqfKs6xh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D5E1D47C0
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Nov 2024 11:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732187574; cv=none; b=EKJZJuKLzUVIoZge3PlEzV5OUF/+wNDWzus2e41G+2eI/M/ALdHc/UgkbCM1B5EskbSLT2rlPYCRtdXIQr8RdzqPSAX+Seaqsdqx+v71eJ05aQDf0wXw/NBRGs5baKJqPVc0hcHTqZSxP7mQH21mJ9an+mMM5fpIk3VYzo5m97E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732187574; c=relaxed/simple;
	bh=NaCa9ic4fK0FA3M6dlX08gXSUhjXD1mlxn3SJNVLMQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DOMt/3oGgMJk57eG7nElcpdBdAb+GXp8FOo1gImqtuDmJohRa/6pHnU+yapEM5Ih1ENB4XQ90BNYJwT+ufpmblhIpHLDiK5XQDk034KrRjloBsVZwQcfoND4288M8IhHDfileG3AUSnbk9LfyZt9Rw4WmlgUfPALFoa0O2dzfFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fqfKs6xh; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732187570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7RY+9QBcT+pSq0hO9Bjo07xtHlAvNSWQsuP/+tIPeRM=;
	b=fqfKs6xh+DxfvcqeVVp7uT/0aCNIxsiEq2h7kQx1Qw+vUYs4C0dXaU0+DA3bZGrSLLOzHQ
	3qPu6gDa9yEhh8I/8pTjRyOWH2bJ0sS+J00o1A9HpO+s+mTkGgP2S6obG+BVgMMHWOoMTb
	5enRTTa9HxLdPcss7fl/EPua0nsbczA=
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
Subject: [PATCH livepatch/master v1 5/6] selftests/livepatch: fix test-syscall.sh execution error
Date: Thu, 21 Nov 2024 19:11:34 +0800
Message-Id: <20241121111135.2125391-5-dongtai.guo@linux.dev>
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

The script test-syscall.sh fails with the following error:

$ sudo ./test-syscall.sh
TEST: patch getpid syscall while being heavily hammered ... not ok

- expected
+ result
 % insmod test_modules/test_klp_syscall.ko klp_pids=18484,18485,18486,18487,18488,18489,18490,...
 livepatch: enabling patch 'test_klp_syscall'
-livepatch: 'test_klp_syscall': initializing patching transition
-livepatch: 'test_klp_syscall': starting patching transition
-livepatch: 'test_klp_syscall': completing patching transition
-livepatch: 'test_klp_syscall': patching complete
+transition: 'test_klp_syscall': initializing patching transition
+transition: 'test_klp_syscall': starting patching transition
+transition: 'test_klp_syscall': completing patching transition
+transition: 'test_klp_syscall': patching complete
 test_klp_syscall: Remaining not livepatched processes: 0
 % echo 0 > /sys/kernel/livepatch/test_klp_syscall/enabled
-livepatch: 'test_klp_syscall': initializing unpatching transition
-livepatch: 'test_klp_syscall': starting unpatching transition
-livepatch: 'test_klp_syscall': completing unpatching transition
-livepatch: 'test_klp_syscall': unpatching complete
+transition: 'test_klp_syscall': initializing unpatching transition
+transition: 'test_klp_syscall': starting unpatching transition
+transition: 'test_klp_syscall': completing unpatching transition
+transition: 'test_klp_syscall': unpatching complete
 % rmmod test_klp_syscall

ERROR: livepatch kselftest(s) failed

The issue arises due to a mismatch in expected log output during livepatch
transition. Specifically, the logs previously contained "livepatch:" but have
now been updated to "transition:". This results in test failures when comparing
the output with the expected values.

This patch updates the expected test output to reflect the new log format.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 .../testing/selftests/livepatch/test-syscall.sh  | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/livepatch/test-syscall.sh b/tools/testing/selftests/livepatch/test-syscall.sh
index 289eb7d4c4b3..6493e1115add 100755
--- a/tools/testing/selftests/livepatch/test-syscall.sh
+++ b/tools/testing/selftests/livepatch/test-syscall.sh
@@ -41,16 +41,16 @@ unload_lp $MOD_SYSCALL
 
 check_result "% insmod test_modules/$MOD_SYSCALL.ko klp_pids=$pid_list
 livepatch: enabling patch '$MOD_SYSCALL'
-livepatch: '$MOD_SYSCALL': initializing patching transition
-livepatch: '$MOD_SYSCALL': starting patching transition
-livepatch: '$MOD_SYSCALL': completing patching transition
-livepatch: '$MOD_SYSCALL': patching complete
+transition: '$MOD_SYSCALL': initializing patching transition
+transition: '$MOD_SYSCALL': starting patching transition
+transition: '$MOD_SYSCALL': completing patching transition
+transition: '$MOD_SYSCALL': patching complete
 $MOD_SYSCALL: Remaining not livepatched processes: 0
 % echo 0 > /sys/kernel/livepatch/$MOD_SYSCALL/enabled
-livepatch: '$MOD_SYSCALL': initializing unpatching transition
-livepatch: '$MOD_SYSCALL': starting unpatching transition
-livepatch: '$MOD_SYSCALL': completing unpatching transition
-livepatch: '$MOD_SYSCALL': unpatching complete
+transition: '$MOD_SYSCALL': initializing unpatching transition
+transition: '$MOD_SYSCALL': starting unpatching transition
+transition: '$MOD_SYSCALL': completing unpatching transition
+transition: '$MOD_SYSCALL': unpatching complete
 % rmmod $MOD_SYSCALL"
 
 exit 0
-- 
2.39.2


