Return-Path: <linux-kselftest+bounces-8797-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E29AE8B10F4
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 19:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EF44B2B401
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 17:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FFA16D9D7;
	Wed, 24 Apr 2024 17:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMmmYxFm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCBA16D31D;
	Wed, 24 Apr 2024 17:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713979490; cv=none; b=h3StIh3Zjg9VzuynidpEraKOrNtjuJEkVhQNcWgaJQFRbd/5jXvUuj1JII0ImIFDDh6k8RL0IinKJ3Ot402CxAYiJ9iU1ydRBsc6AmpwXdhJtT4C2RZ4rvDm6+B39Kr/qXe6KY2reiS5cftpjgr3iosmi5EI2uqBTuDsTs/6T48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713979490; c=relaxed/simple;
	bh=GnpqSQLHhE9QIs4mApLVYgT9NC1Q6eMd9yABsVnk8j8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JEtfp4iEOKxQaJkNFlD8ZTeuG7Wb4WsIh+znbOmHwQtk8L6a+oBSF/hOIVDFc37ck0Qy2LIUEPzYJT3dp1yRQacGeg3mDlVF5haBIxqsQKl9g/afhRctmNk7iqgHBPQPYdTCGaV7z6wfpFHBHKWiSu2KCLyGY4hU+ZxduI90YXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMmmYxFm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C07C32782;
	Wed, 24 Apr 2024 17:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713979490;
	bh=GnpqSQLHhE9QIs4mApLVYgT9NC1Q6eMd9yABsVnk8j8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZMmmYxFmkxqr6EGMIEdJOKDUoe4iwcxYecdSsASu3l9kgwWQuPWYPWzOP8TrAvktt
	 ItDxhEjcJCgroyYbYzP0/iNRlQ4kv70QTPHrhJ/4SbBrXq2k3YtMLI4TngXuDJS9Rl
	 0xPiYYSsOHviWC4igwp/8Wg7aLwWYurqdrzEkP93hGdN9bCcd0HccnXBGrSI5u/wPu
	 mk6J1mxtBAU6IuLyvJ24VrKyEmSYeaPzsbT3B8WKzaJYUGj8/fT6lz/mokM1YS1Ig+
	 zY8LNidK7GdtQSStD1vhtpsbokkWO9pgNM4mmhoYtdiiW70+7SFK5WHmRKK+rUofsu
	 jR9A8Z79i4VeA==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 24 Apr 2024 10:24:08 -0700
Subject: [PATCH v2 05/10] selftests: pidfd: ksft_exit functions do not
 return
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-ksft-exit-int-to-void-v2-5-c35f3b8c9ca0@kernel.org>
References: <20240424-ksft-exit-int-to-void-v2-0-c35f3b8c9ca0@kernel.org>
In-Reply-To: <20240424-ksft-exit-int-to-void-v2-0-c35f3b8c9ca0@kernel.org>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Nathan Chancellor <nathan@kernel.org>, 
 brauner@kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3118; i=nathan@kernel.org;
 h=from:subject:message-id; bh=GnpqSQLHhE9QIs4mApLVYgT9NC1Q6eMd9yABsVnk8j8=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDGmaDrER567ENQR2/vHeM/WakPvFHfa/xUWtu4vyved3M
 aetmWXYUcrCIMbFICumyFL9WPW4oeGcs4w3Tk2CmcPKBDKEgYtTACYi/Yvhvw8nXxHbhX0huXqm
 7vzCp5nuX1Dg+vBTTbkr86uV3RQDO0aG+7Jzmje/tmi7lTXvq/IsR5s5jlciuuqrl9aZXgmRVCp
 jBAA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After commit f7d5bcd35d42 ("selftests: kselftest: Mark functions that
unconditionally call exit() as __noreturn"), ksft_exit_...() functions
are marked as __noreturn, which means the return type should not be
'int' but 'void' because they are not returning anything (and never were
since exit() has always been called).

To facilitate updating the return type of these functions, remove
'return' before the calls to ksft_exit_{pass,fail}(), as __noreturn
prevents the compiler from warning that a caller of the ksft_exit
functions does not return a value because the program will terminate
upon calling these functions.

Just removing 'return' would have resulted in

  !ret ? ksft_exit_pass() : ksft_exit_fail();

so convert that into the more idiomatic

  if (ret)
    ksft_exit_fail();
  ksft_exit_pass();

Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Cc: brauner@kernel.org
---
 tools/testing/selftests/pidfd/pidfd_fdinfo_test.c | 2 +-
 tools/testing/selftests/pidfd/pidfd_open_test.c   | 4 +++-
 tools/testing/selftests/pidfd/pidfd_poll_test.c   | 2 +-
 tools/testing/selftests/pidfd/pidfd_test.c        | 2 +-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
index 01cc37bf611c..f062a986e382 100644
--- a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
@@ -307,5 +307,5 @@ int main(int argc, char **argv)
 	test_pidfd_fdinfo_nspid();
 	test_pidfd_dead_fdinfo();
 
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/pidfd/pidfd_open_test.c b/tools/testing/selftests/pidfd/pidfd_open_test.c
index 8a59438ccc78..c62564c264b1 100644
--- a/tools/testing/selftests/pidfd/pidfd_open_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_open_test.c
@@ -159,5 +159,7 @@ int main(int argc, char **argv)
 	if (pidfd >= 0)
 		close(pidfd);
 
-	return !ret ? ksft_exit_pass() : ksft_exit_fail();
+	if (ret)
+		ksft_exit_fail();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/pidfd/pidfd_poll_test.c b/tools/testing/selftests/pidfd/pidfd_poll_test.c
index 610811275357..55d74a50358f 100644
--- a/tools/testing/selftests/pidfd/pidfd_poll_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_poll_test.c
@@ -112,5 +112,5 @@ int main(int argc, char **argv)
 	}
 
 	ksft_test_result_pass("pidfd poll test: pass\n");
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index c081ae91313a..9faa686f90e4 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -572,5 +572,5 @@ int main(int argc, char **argv)
 	test_pidfd_send_signal_exited_fail();
 	test_pidfd_send_signal_recycled_pid_fail();
 
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }

-- 
2.44.0


