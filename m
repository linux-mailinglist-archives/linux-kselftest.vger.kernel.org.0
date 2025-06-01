Return-Path: <linux-kselftest+bounces-34119-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A06ACA53F
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 02:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A028F7A5AEE
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 00:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF223024E8;
	Sun,  1 Jun 2025 23:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dX5mjCsJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEF326B09D;
	Sun,  1 Jun 2025 23:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748821016; cv=none; b=Qw79r/ZU7AHyrj7tBy2Gs0WYL2g3PoAH0Mo7t40gJ9u41IOihIR5XDWxGtJWmaTguFF64SiCI6G5TUhcggBG3xIckQp68sABn9Z2nR5ZNZ9Di1om4rKhjFiUqFaLAR3tt+/VVBRJ90Wl/egDPKbx41az+KJG9CkwqPgATnEOwXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748821016; c=relaxed/simple;
	bh=8Tp3AU6og9BHvtwofmSrID3yJJnOozXAX6ODrCrL0/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k82aNaEGKBt6oUE93TPZA1hjUuty8b9tPJpYlYh1HiPcxfnTmOW1GV+OLmG0//qBOZjqDGrap4JQ/FkPihaTKptWgKn4q7fTM/KfAWciqqhnJaCvPaSroyGMLb8DsUYdEYQneOW1JCWSlpSiC+wtRxJt1ux4s81eczuOYe0HCuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dX5mjCsJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D9DC4CEF2;
	Sun,  1 Jun 2025 23:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748821016;
	bh=8Tp3AU6og9BHvtwofmSrID3yJJnOozXAX6ODrCrL0/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dX5mjCsJooeVyMC/mqe4zvbWv/HS8FxuS+Os9pUrFpfELYqisFwbEtPXNMuIREh00
	 UH70ELOMRe5jvKUdXN8Xrpjuq+PvCGy6Gf4JZF8I2B8c4p69BVeroRcUx0XM427+Wp
	 HHWqmtIobkLCHzHeGdv665f+kAFBWSwcgWNLRmIPqAFGbzyIQTPajZwd8Lqd+w6Lrv
	 DcPfnIKWC7WsIpuJ0qlj4eiSQ9cAw9jciOxttS9PpwL/MJyat1rkQ1xMCTKcW7ACM/
	 upKIlilCkdVMtKxzWYKF087ymIzv8GNV2ntMrxyQ/Bd6mPPhgMo05kGZZ37jvRXjCN
	 9ck9CUn3cNfyw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Sasha Levin <sashal@kernel.org>,
	kees@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 69/93] selftests: harness: Mark functions without prototypes static
Date: Sun,  1 Jun 2025 19:33:36 -0400
Message-Id: <20250601233402.3512823-69-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601233402.3512823-1-sashal@kernel.org>
References: <20250601233402.3512823-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.31
Content-Transfer-Encoding: 8bit

From: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

[ Upstream commit c2bcc8e9577a35f9cf4707f8bb0b58bce30991aa ]

With -Wmissing-prototypes the compiler will warn about non-static
functions which don't have a prototype defined.
As they are not used from a different compilation unit they don't need to
be defined globally.

Avoid the issue by marking the functions static.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Link: https://lore.kernel.org/r/20250505-nolibc-kselftest-harness-v4-4-ee4dd5257135@linutronix.de
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees.
**Rationale:** 1. **Legitimate Build Fix**: The commit addresses a real
compiler warning issue (`-Wmissing-prototypes`) that affects build
cleanliness and code quality. Modern build systems increasingly use
stricter warning flags, making this fix valuable for stable trees. 2.
**Zero Functional Risk**: The changes are purely cosmetic from a runtime
perspective. Adding `static` to functions that were already internal has
no impact on functionality, memory layout, or behavior - it only affects
compiler symbol visibility and warnings. 3. **Minimal and Contained**:
The diff is extremely small (4 function signatures with `static` added)
and isolated to the kselftest harness framework. There are no complex
logic changes or cross-subsystem impacts. 4. **Testing Infrastructure
Improvement**: While the kselftest framework isn't critical runtime
code, it's important for kernel testing and validation. Improving build
compliance in testing infrastructure benefits stable kernel maintenance.
5. **Standard Practice**: Compiler warning fixes of this nature (adding
missing `static` keywords) are routinely backported to stable trees as
they represent good coding practices without functional risk. 6.
**Different from Similar Commits**: Unlike the referenced similar
commits (all marked "NO") which involved feature additions, API changes,
or structural modifications, this commit is purely a build compliance
fix with no behavioral changes. The commit meets all stable tree
criteria: it fixes an issue (compiler warnings), has minimal risk (no
functional changes), and improves code quality without introducing new
features or architectural changes. Tools like `kselftest_harness.h:241`,
`kselftest_harness.h:290`, `kselftest_harness.h:970`, and
`kselftest_harness.h:1188` are the specific locations where these low-
risk improvements are made.

 tools/testing/selftests/kselftest_harness.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 666c9fde76da9..7c337b4fa054d 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -258,7 +258,7 @@
  * A bare "return;" statement may be used to return early.
  */
 #define FIXTURE_SETUP(fixture_name) \
-	void fixture_name##_setup( \
+	static void fixture_name##_setup( \
 		struct __test_metadata __attribute__((unused)) *_metadata, \
 		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self, \
 		const FIXTURE_VARIANT(fixture_name) \
@@ -307,7 +307,7 @@
 	__FIXTURE_TEARDOWN(fixture_name)
 
 #define __FIXTURE_TEARDOWN(fixture_name) \
-	void fixture_name##_teardown( \
+	static void fixture_name##_teardown( \
 		struct __test_metadata __attribute__((unused)) *_metadata, \
 		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self, \
 		const FIXTURE_VARIANT(fixture_name) \
@@ -987,7 +987,7 @@ static void __timeout_handler(int sig, siginfo_t *info, void *ucontext)
 	kill(-(t->pid), SIGKILL);
 }
 
-void __wait_for_test(struct __test_metadata *t)
+static void __wait_for_test(struct __test_metadata *t)
 {
 	struct sigaction action = {
 		.sa_sigaction = __timeout_handler,
@@ -1205,9 +1205,9 @@ static bool test_enabled(int argc, char **argv,
 	return !has_positive;
 }
 
-void __run_test(struct __fixture_metadata *f,
-		struct __fixture_variant_metadata *variant,
-		struct __test_metadata *t)
+static void __run_test(struct __fixture_metadata *f,
+		       struct __fixture_variant_metadata *variant,
+		       struct __test_metadata *t)
 {
 	struct __test_xfail *xfail;
 	char test_name[1024];
-- 
2.39.5


