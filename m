Return-Path: <linux-kselftest+bounces-34561-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE568AD376F
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 14:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A2DD9C14F4
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 12:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AFA2D29B1;
	Tue, 10 Jun 2025 12:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsiOLuLe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B782D29AB;
	Tue, 10 Jun 2025 12:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749559359; cv=none; b=YS+NH7+QG5T26mdk58UU6uufqwTmU3C67QT01Xw9lonuUsQHgcNxq2vF10NIru0UeG/6hJ0ee/dAZ0M31fshx9wrS2GdGy+mTHAEBJSc4eyY+Tc2EwwkxIeHl4vE0zM4hdJFSDxFW57cWsRaVRAFDRSYoxFwRqgU3Wts2GkHvAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749559359; c=relaxed/simple;
	bh=k95pgC8uYho6a+kXi0z4LRYhCqPs5d/JUrw8wGO3J2U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fSs65CyMnk+9eUm+nKxP2ufUEK43YPw8T5NDDDle30k53795GRSGpnwnD+eawmxzLkdhC4wBYX78pnaXAxBgLRV7ntFFn0H/xcMg1SzswE34JudME7G3RHlLSP3hVy+EgNiQESAjvlSTrU2gJVmt+3Bobda4ttQrtEa/hrMpIfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsiOLuLe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A25C4CEED;
	Tue, 10 Jun 2025 12:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749559359;
	bh=k95pgC8uYho6a+kXi0z4LRYhCqPs5d/JUrw8wGO3J2U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fsiOLuLeWL0Xc10yYKUqloJZrMK1OEjyoEhpFU4o9QzSidpZAra4hPBB5dBZHhTiD
	 818/zMhWNXIzcABdmDfAocm2GV76ezuqm30eFM7DmhXckY6byX65N+1evCEqymg+sW
	 lu64hmcgqbkzIE7rhtT7qZTWyjAwtjLRchWyEogktA94XotyEb/R6YAmBGf0oK1qxC
	 ggKRces2B3P1Fe7CTZhEIYRWZJUB2IqqtcUQ3DNcis/3t1tYzAeGSeH0wmlTvCmp3H
	 ETpHkoqFe1JHz+R8IbIQwYSyRGaTeA4EkNLGDYRwJOwuZ+lPfqUgtAB+VRg9oVSicx
	 r/N3xxxb68ZnQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 10 Jun 2025 13:29:47 +0100
Subject: [PATCH v2 4/4] selftests/nolibc: Add coverage of vfork()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-arm64-gcs-vfork-exit-v2-4-929443dfcf82@kernel.org>
References: <20250610-arm64-gcs-vfork-exit-v2-0-929443dfcf82@kernel.org>
In-Reply-To: <20250610-arm64-gcs-vfork-exit-v2-0-929443dfcf82@kernel.org>
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Christian Brauner <brauner@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2649; i=broonie@kernel.org;
 h=from:subject:message-id; bh=k95pgC8uYho6a+kXi0z4LRYhCqPs5d/JUrw8wGO3J2U=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoSCgxDdwtoQD5Ra5mGt8UN9d0cGbAAOvD/dkn3A8W
 VjR+qxGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaEgoMQAKCRAk1otyXVSH0KAyB/
 wNxl/FZnzIgWNyszdC7wdp+VFWDFsz2+WxB5+A7fijMn1rBBYPdS9gFZ7FyJq76U9gJMF/OX53Dv+n
 0w5hk73UhIcowtY/r4Am4WrncCAQFz5TPbLI9JJBN/+O9AiSaY38wRZYEii2mKgpkOK9QQctIGh/ck
 KPDJsyo0hWQlC9gEx1qSWwa+sRGQNFPJFIUJm3mSxPdN1/ba/yacvFEa/2iHekpWMmE28bsA+eqcfz
 tvacCJX3aLeHlKjchkXnsBgVlr2chtd1Mtu67XWWLIBGhtJIfoK1eTpRPt3dFHovRdUufo6bAc+J88
 9nG2A0178MlZI1YF5zXGIYbnGlfd8b
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Generalise the existing fork() test to also cover the newly added vfork()
implementation.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index dbe13000fb1a..d682434c6442 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -877,7 +877,12 @@ int test_file_stream(void)
 	return 0;
 }
 
-int test_fork(void)
+enum fork_type {
+	FORK_STANDARD,
+	FORK_VFORK,
+};
+
+int test_fork(enum fork_type type)
 {
 	int status;
 	pid_t pid;
@@ -886,14 +891,23 @@ int test_fork(void)
 	fflush(stdout);
 	fflush(stderr);
 
-	pid = fork();
+	switch (type) {
+	case FORK_STANDARD:
+		pid = fork();
+		break;
+	case FORK_VFORK:
+		pid = vfork();
+		break;
+	default:
+		return 1;
+	}
 
 	switch (pid) {
 	case -1:
 		return 1;
 
 	case 0:
-		exit(123);
+		_exit(123);
 
 	default:
 		pid = waitpid(pid, &status, 0);
@@ -1330,7 +1344,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(dup3_m1);           tmp = dup3(-1, 100, 0); EXPECT_SYSER(1, tmp, -1, EBADF); if (tmp != -1) close(tmp); break;
 		CASE_TEST(execve_root);       EXPECT_SYSER(1, execve("/", (char*[]){ [0] = "/", [1] = NULL }, NULL), -1, EACCES); break;
 		CASE_TEST(file_stream);       EXPECT_SYSZR(1, test_file_stream()); break;
-		CASE_TEST(fork);              EXPECT_SYSZR(1, test_fork()); break;
+		CASE_TEST(fork);              EXPECT_SYSZR(1, test_fork(FORK_STANDARD)); break;
 		CASE_TEST(getdents64_root);   EXPECT_SYSNE(1, test_getdents64("/"), -1); break;
 		CASE_TEST(getdents64_null);   EXPECT_SYSER(1, test_getdents64("/dev/null"), -1, ENOTDIR); break;
 		CASE_TEST(directories);       EXPECT_SYSZR(proc, test_dirent()); break;
@@ -1374,6 +1388,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(uname_fault);       EXPECT_SYSER(1, uname(NULL), -1, EFAULT); break;
 		CASE_TEST(unlink_root);       EXPECT_SYSER(1, unlink("/"), -1, EISDIR); break;
 		CASE_TEST(unlink_blah);       EXPECT_SYSER(1, unlink("/proc/self/blah"), -1, ENOENT); break;
+		CASE_TEST(vfork);             EXPECT_SYSZR(1, test_fork(FORK_VFORK)); break;
 		CASE_TEST(wait_child);        EXPECT_SYSER(1, wait(&tmp), -1, ECHILD); break;
 		CASE_TEST(waitpid_min);       EXPECT_SYSER(1, waitpid(INT_MIN, &tmp, WNOHANG), -1, ESRCH); break;
 		CASE_TEST(waitpid_child);     EXPECT_SYSER(1, waitpid(getpid(), &tmp, WNOHANG), -1, ECHILD); break;

-- 
2.39.5


