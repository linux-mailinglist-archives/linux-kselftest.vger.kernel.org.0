Return-Path: <linux-kselftest+bounces-8802-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9EE8B1102
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 19:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F404AB25514
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 17:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C499F16F0CD;
	Wed, 24 Apr 2024 17:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wf7uOyy7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F7F16EC1C;
	Wed, 24 Apr 2024 17:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713979493; cv=none; b=F0sLoktt2ZqJHpQaH4FEYR2BSvzyTpwGhsOtXiCfhrenRVdyeT84hSCNDmCM8YpWLfzRPOLLi3U0nb4r7HxMpXiAue5QoJBKdP0bvfo9mc6F2s+pBQG5durRSltWUZvrKQKSsBgLzzqJ2oFgEYbkixO7iTi3s564ArUkcwHuS0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713979493; c=relaxed/simple;
	bh=jLnC6a51kXShlJw2qowP2td/Td80RuzryZnAn9alooQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PtR0Em4oSWwabzR03W2Vc6Nbvh6S/pWMLAgYhgIkk62vbpW6ni1DqktMFfPIHdDCOSvvDsVzKtxoXfwyS/BVcrmtMxicmu/jdNe36vap4ntfx5tfmG7SLvvMqfGy4MgYxuZdeW10CAAo8oDw/Sht8USfk+7bA9MabTam/Psj7kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wf7uOyy7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51EDC32782;
	Wed, 24 Apr 2024 17:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713979493;
	bh=jLnC6a51kXShlJw2qowP2td/Td80RuzryZnAn9alooQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Wf7uOyy7k7KnS1BWaCftOUBBDmNwEqjDxrD2bRGq3sqLpzDu66SEp5QzmNLVwpTfl
	 OQi/YyWlbrexteK+VwwTWbS+Ql6xMP2+EppRESjhdm+l1zetkgi2iFI9M2bN2e2fsr
	 ZOP8yleTVnYvzSAH8P/nYu1vKN4IrBOx8vFQkItBnmkBFZe4GqyLxiCSz8Quaa6sWI
	 TJxpuFsK5jZEc0UKyk5AQj9dUwVktSLP6AbXRU9ojT7de7xQMYfAci/kCK49jSM9LD
	 6Qh5hK5KH4bprzAA26LROwUBWSFES6E1kuYrAAa07juuWXrSUMcZLq8zRScznC4iUx
	 fjnFNIGqHplHQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 24 Apr 2024 10:24:13 -0700
Subject: [PATCH v2 10/10] selftests: kselftest: Make ksft_exit functions
 return void instead of int
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-ksft-exit-int-to-void-v2-10-c35f3b8c9ca0@kernel.org>
References: <20240424-ksft-exit-int-to-void-v2-0-c35f3b8c9ca0@kernel.org>
In-Reply-To: <20240424-ksft-exit-int-to-void-v2-0-c35f3b8c9ca0@kernel.org>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2619; i=nathan@kernel.org;
 h=from:subject:message-id; bh=jLnC6a51kXShlJw2qowP2td/Td80RuzryZnAn9alooQ=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDGmaDnFWTGLpkbE/c97N0rukZGv/etKc3Z+DTyzmXBC/o
 SJY+y1LRykLgxgXg6yYIkv1Y9XjhoZzzjLeODUJZg4rE8gQBi5OAZjIwWeMDB3WvA8+tyje8Kl5
 sNpY9XCeYkFjzsOOvcZ8S97P+KBy+w8jw5/IzW9n3mxau0d7Gouv689JYUsUt62XZE98/2x1fYK
 DMxsA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Commit f7d5bcd35d42 ("selftests: kselftest: Mark functions that
unconditionally call exit() as __noreturn") marked functions that call
exit() as __noreturn but it did not change the return type of these
functions from 'void' to 'int' like it should have (since a noreturn
function by definition cannot return an integer because it does not
return...) because there were many tests that return the result of the
ksft_exit functions, even though it has never been used due to calling
exit().

Now that all uses of 'return ksft_exit...()' have been cleaned up
properly, change the types of the ksft_exit...() functions to void to
match their __noreturn nature.

Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 tools/testing/selftests/kselftest.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 9bb1664bcf95..f4221691a7da 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -327,13 +327,13 @@ void ksft_test_result_code(int exit_code, const char *test_name,
 		break;						\
 	} } while (0)
 
-static inline __noreturn int ksft_exit_pass(void)
+static inline __noreturn void ksft_exit_pass(void)
 {
 	ksft_print_cnts();
 	exit(KSFT_PASS);
 }
 
-static inline __noreturn int ksft_exit_fail(void)
+static inline __noreturn void ksft_exit_fail(void)
 {
 	ksft_print_cnts();
 	exit(KSFT_FAIL);
@@ -360,7 +360,7 @@ static inline __noreturn int ksft_exit_fail(void)
 		  ksft_cnt.ksft_xfail +	\
 		  ksft_cnt.ksft_xskip)
 
-static inline __noreturn __printf(1, 2) int ksft_exit_fail_msg(const char *msg, ...)
+static inline __noreturn __printf(1, 2) void ksft_exit_fail_msg(const char *msg, ...)
 {
 	int saved_errno = errno;
 	va_list args;
@@ -388,19 +388,19 @@ static inline __noreturn void ksft_exit_fail_perror(const char *msg)
 #endif
 }
 
-static inline __noreturn int ksft_exit_xfail(void)
+static inline __noreturn void ksft_exit_xfail(void)
 {
 	ksft_print_cnts();
 	exit(KSFT_XFAIL);
 }
 
-static inline __noreturn int ksft_exit_xpass(void)
+static inline __noreturn void ksft_exit_xpass(void)
 {
 	ksft_print_cnts();
 	exit(KSFT_XPASS);
 }
 
-static inline __noreturn __printf(1, 2) int ksft_exit_skip(const char *msg, ...)
+static inline __noreturn __printf(1, 2) void ksft_exit_skip(const char *msg, ...)
 {
 	int saved_errno = errno;
 	va_list args;

-- 
2.44.0


