Return-Path: <linux-kselftest+bounces-9019-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFCD8B599F
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 15:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21F391F217F4
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 13:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D640A3C482;
	Mon, 29 Apr 2024 13:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Ri+4v2kP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05C03EA71
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 13:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714396543; cv=none; b=Ke160lYTjMZp7tWphl+8vCdqx20ZDIy30bPWXvzXDLaz4cE3A/Bb46W9EXgfjgWLG0+NzdMJclfhZOBK2IdUoZjslMQ0EEYFy5rKpXKcO8Uvb8JG2685oqWxr+5Ds0heZZKqaBlsm7r2Ahib6EeINwuPlHJZAeJ5J6TdrYB1juE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714396543; c=relaxed/simple;
	bh=5ijisjBDjCgm+yNyZSUs5CJ6Yk0uBfxDT6TyioOcnpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tC9kPXFYs+LC12CyqV6NLIRH2sY/fju8bz+cqVgV4J9PBArpCRoQYwMDzDlta6ilghVnOYLb+jRGS98diQj51/oocFNxR3ZeOU8wlyYz+UVatqiKYVvfOFcaasVyr57S/Pdu01KSAFEuXUE/Xos+WF5pRk1pfvYaUQcqcaf8zs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Ri+4v2kP; arc=none smtp.client-ip=45.157.188.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VSkFL2r7kzQNK;
	Mon, 29 Apr 2024 15:09:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1714396182;
	bh=5ijisjBDjCgm+yNyZSUs5CJ6Yk0uBfxDT6TyioOcnpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ri+4v2kPb8gskcXREStZJudgEjfjgC/yTNzCP8xeqCpJjvmseWbxrwCoiQ08i65Br
	 YgYL4PijZ36BBK7x8O6go4eOKd7o5goKRfWTFQGK8f4FCUU09tDoh1y4uv0t5pix0R
	 d7I4L7KvipDtLb97YxUHSAeNjDhK/kCgenvcvejQ=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VSkFK6Xc1zhld;
	Mon, 29 Apr 2024 15:09:41 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	Shengyu Li <shengyu.li.evgeny@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"David S . Miller" <davem@davemloft.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Will Drewry <wad@chromium.org>,
	kernel test robot <oliver.sang@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 4/9] selftests/harness: Fix interleaved scheduling leading to race conditions
Date: Mon, 29 Apr 2024 15:09:26 +0200
Message-ID: <20240429130931.2394118-5-mic@digikod.net>
In-Reply-To: <20240429130931.2394118-1-mic@digikod.net>
References: <20240429130931.2394118-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Fix a race condition when running several FIXTURE_TEARDOWN() managing
the same resource.  This fixes a race condition in the Landlock file
system tests when creating or unmounting the same directory.

Using clone3() with CLONE_VFORK guarantees that the child and grandchild
test processes are sequentially scheduled.  This is implemented with a
new clone3_vfork() helper replacing the fork() call.

This avoids triggering this error in __wait_for_test():
  Test ended in some other way [127]

Cc: Christian Brauner <brauner@kernel.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Günther Noack <gnoack@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Will Drewry <wad@chromium.org>
Fixes: 41cca0542d7c ("selftests/harness: Fix TEST_F()'s vfork handling")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240429130931.2394118-5-mic@digikod.net
---
 tools/testing/selftests/kselftest_harness.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 55699a762c45..9f04638707ae 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -66,6 +66,8 @@
 #include <sys/wait.h>
 #include <unistd.h>
 #include <setjmp.h>
+#include <syscall.h>
+#include <linux/sched.h>
 
 #include "kselftest.h"
 
@@ -80,6 +82,17 @@
 #  define TH_LOG_ENABLED 1
 #endif
 
+/* Wait for the child process to end but without sharing memory mapping. */
+static pid_t __attribute__((__unused__)) clone3_vfork(void)
+{
+	struct clone_args args = {
+		.flags = CLONE_VFORK,
+		.exit_signal = SIGCHLD,
+	};
+
+	return syscall(__NR_clone3, &args, sizeof(args));
+}
+
 /**
  * TH_LOG()
  *
@@ -1183,7 +1196,7 @@ void __run_test(struct __fixture_metadata *f,
 	fflush(stdout);
 	fflush(stderr);
 
-	t->pid = fork();
+	t->pid = clone3_vfork();
 	if (t->pid < 0) {
 		ksft_print_msg("ERROR SPAWNING TEST CHILD\n");
 		t->exit_code = KSFT_FAIL;
-- 
2.44.0


