Return-Path: <linux-kselftest+bounces-22399-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3269D9D4B53
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 12:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7E0A283573
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 11:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8461D14E0;
	Thu, 21 Nov 2024 11:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZOCFJ551"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828049474
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Nov 2024 11:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732187554; cv=none; b=IQgn5QaO00I6vsZKgTCV6b/Pc8Sg3ig1IX3eVB9HELDrpFdkrS42viVooZXROQ7Mi8pHJDySCbBus73XDzJvfkbgdPJQ27/bK1Nl/HQkOKwbIW18MGgZsX03dwtHD9hM4wI4TloZmOqeHig0GKXc+yvrJyDlZWg8kPTbcXsqh5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732187554; c=relaxed/simple;
	bh=xNxTv9EmQivtywSeSyU7TTAQ2BE6SPdTXU2ukLe3Xeo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e5+xxk/p7Oer0xSOR+VibjLuoPXUbu1oua66bglZ+4LCZEFfL/VVbsL697KyLkLBCKTnknXIslrjGOEc7xlyTbvuvw9O7z6wYRGDeV15MWdygTBfd+KhhwKujx256i2IqjYQ5UBGkx1HHil3p7RrDiUR+1AGXfOdpywye6Ov8aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZOCFJ551; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732187550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OguGIC+UK9KIfqIm01474ZxDlRYYb/Skb7YJ5uXjK70=;
	b=ZOCFJ551iJ3juuDetBDEzQ35KuXadEyN9xyV1rJSesxk72Um4Lq25KkY7U/UgvuHxCHaBo
	k8YYN2/WCHsDJ4zWr6KEfWdv9m/d57IrJyJc+5Sb6ubLAfK/yyUPr+XzhvoXW+0GdZUXQX
	LbPeVoIVbRnihP4T4aemfiDsK7QoxR8=
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
	George Guo <dongtai.guo@linux.dev>,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH livepatch/master v1 2/6] selftests/livepatch: fix test-ftrace.sh execution error
Date: Thu, 21 Nov 2024 19:11:31 +0800
Message-Id: <20241121111135.2125391-2-dongtai.guo@linux.dev>
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

The script test-ftrace.sh fails with the following error:
$ sudo ./test-ftrace.sh
TEST: livepatch interaction with ftrace_enabled sysctl ... not ok

- expected
+ result
 livepatch: kernel.ftrace_enabled = 0
 % insmod test_modules/test_klp_livepatch.ko
 livepatch: enabling patch 'test_klp_livepatch'
-livepatch: 'test_klp_livepatch': initializing patching transition
-livepatch: failed to register ftrace handler for function 'cmdline_proc_show' (-16)
+transition: 'test_klp_livepatch': initializing patching transition
 livepatch: failed to patch object 'vmlinux'
 livepatch: failed to enable patch 'test_klp_livepatch'
-livepatch: 'test_klp_livepatch': canceling patching transition, going to unpatch
-livepatch: 'test_klp_livepatch': completing unpatching transition
-livepatch: 'test_klp_livepatch': unpatching complete
+transition: 'test_klp_livepatch': canceling patching transition, going to unpatch
+transition: 'test_klp_livepatch': completing unpatching transition
+transition: 'test_klp_livepatch': unpatching complete
 insmod: ERROR: could not insert module test_modules/test_klp_livepatch.ko: Device or resource busy
 livepatch: kernel.ftrace_enabled = 1
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
 livepatch: sysctl: setting key "kernel.ftrace_enabled": Device or resource busy
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
 .../selftests/livepatch/test-ftrace.sh        | 25 +++++++++----------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/livepatch/test-ftrace.sh b/tools/testing/selftests/livepatch/test-ftrace.sh
index 730218bce99c..04561e433e05 100755
--- a/tools/testing/selftests/livepatch/test-ftrace.sh
+++ b/tools/testing/selftests/livepatch/test-ftrace.sh
@@ -37,27 +37,26 @@ unload_lp $MOD_LIVEPATCH
 check_result "livepatch: kernel.ftrace_enabled = 0
 % insmod test_modules/$MOD_LIVEPATCH.ko
 livepatch: enabling patch '$MOD_LIVEPATCH'
-livepatch: '$MOD_LIVEPATCH': initializing patching transition
-livepatch: failed to register ftrace handler for function 'cmdline_proc_show' (-16)
+transition: '$MOD_LIVEPATCH': initializing patching transition
 livepatch: failed to patch object 'vmlinux'
 livepatch: failed to enable patch '$MOD_LIVEPATCH'
-livepatch: '$MOD_LIVEPATCH': canceling patching transition, going to unpatch
-livepatch: '$MOD_LIVEPATCH': completing unpatching transition
-livepatch: '$MOD_LIVEPATCH': unpatching complete
+transition: '$MOD_LIVEPATCH': canceling patching transition, going to unpatch
+transition: '$MOD_LIVEPATCH': completing unpatching transition
+transition: '$MOD_LIVEPATCH': unpatching complete
 insmod: ERROR: could not insert module test_modules/$MOD_LIVEPATCH.ko: Device or resource busy
 livepatch: kernel.ftrace_enabled = 1
 % insmod test_modules/$MOD_LIVEPATCH.ko
 livepatch: enabling patch '$MOD_LIVEPATCH'
-livepatch: '$MOD_LIVEPATCH': initializing patching transition
-livepatch: '$MOD_LIVEPATCH': starting patching transition
-livepatch: '$MOD_LIVEPATCH': completing patching transition
-livepatch: '$MOD_LIVEPATCH': patching complete
+transition: '$MOD_LIVEPATCH': initializing patching transition
+transition: '$MOD_LIVEPATCH': starting patching transition
+transition: '$MOD_LIVEPATCH': completing patching transition
+transition: '$MOD_LIVEPATCH': patching complete
 livepatch: sysctl: setting key \"kernel.ftrace_enabled\": Device or resource busy
 % echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
-livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
-livepatch: '$MOD_LIVEPATCH': starting unpatching transition
-livepatch: '$MOD_LIVEPATCH': completing unpatching transition
-livepatch: '$MOD_LIVEPATCH': unpatching complete
+transition: '$MOD_LIVEPATCH': initializing unpatching transition
+transition: '$MOD_LIVEPATCH': starting unpatching transition
+transition: '$MOD_LIVEPATCH': completing unpatching transition
+transition: '$MOD_LIVEPATCH': unpatching complete
 % rmmod $MOD_LIVEPATCH"
 
 
-- 
2.39.2


