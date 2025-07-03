Return-Path: <linux-kselftest+bounces-36467-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D40AF7D69
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 18:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07C8E4E76E3
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 16:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7695E2F0E28;
	Thu,  3 Jul 2025 16:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZlNlyTt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0892F0C72;
	Thu,  3 Jul 2025 16:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751558778; cv=none; b=bb3yg2BEBeZXXBPZ4YylKjPqRt87lDNdenjBBnhR/YafTzOj9Hivr/NEXtXftsPmWbuxOHSYVWZQsoMXp31Ch8pQ37HJk3l/B4VIUUXPmg6Nt4G50A9kyzq80smr6WTGtoB+m7/RJO3kJSzAGxHdbtSSu0YsUfpGBjOwrR9Y6G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751558778; c=relaxed/simple;
	bh=k95pgC8uYho6a+kXi0z4LRYhCqPs5d/JUrw8wGO3J2U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h9UiBBWeov7NEyFEqPt9YNC0oFJ9EBoihBIBO3jgA2gydMp0DJ1oGaZeYr0uKL2jjJv75SHLditSl+je+2Bldld7fNeoIo930CvLJzJkbim1CXBFek+A6jib9sDZ5uYVLNdFG+SwwFVZ89JoCs4alTMeG8tLrtex2BACcmJV3Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZlNlyTt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1670C4CEEE;
	Thu,  3 Jul 2025 16:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751558777;
	bh=k95pgC8uYho6a+kXi0z4LRYhCqPs5d/JUrw8wGO3J2U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sZlNlyTttCKjCKDEo8ZvK65gLEsZunjGIXsP5gHiBfqrFJbIFhcXTs6X3P5LOtxPm
	 VgDQNJD4JdNzbPL5OWGyWLWFHmAiHV21mBI5VjqiTGkAUqk9sY/78KWKK+ONvC+onB
	 k5QMMuBXcSqpvs5xjg+qLQJz3mhhev98wO6GUX1ueaxXDNmPorRoJxboxe9rDVIRqG
	 gnNoiMcD42iPK6tG+fBR78lcSX/alafSN/bFlvYAgpUaMrn5Uflmo+Q5KEeLyivCe5
	 7pybOZVPCUmJcKKYOkEoucLTz2QQ86DBvfgZENH/0EJzTUBUMTP/tyQIeNF6ThXJVf
	 AysWdl4zV3alQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 03 Jul 2025 17:00:18 +0100
Subject: [PATCH v3 4/4] selftests/nolibc: Add coverage of vfork()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-arm64-gcs-vfork-exit-v3-4-1e9a9d2ddbbe@kernel.org>
References: <20250703-arm64-gcs-vfork-exit-v3-0-1e9a9d2ddbbe@kernel.org>
In-Reply-To: <20250703-arm64-gcs-vfork-exit-v3-0-1e9a9d2ddbbe@kernel.org>
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Christian Brauner <brauner@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=2649; i=broonie@kernel.org;
 h=from:subject:message-id; bh=k95pgC8uYho6a+kXi0z4LRYhCqPs5d/JUrw8wGO3J2U=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoZqpp3i92RBIH/xgX25THZxzWR1YIDTNkbJkXN
 aX0+ZotRh2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaGaqaQAKCRAk1otyXVSH
 0EP3B/9g2ihNKWqWkt4iW9QbyCgKDPCPqf+nZBPeEOOS7APQmwzTyQnuCfYmcEBB1fqKDN8wgss
 gBxNEKi9+ZtR4twbwAqnOr4+44Tq1oU1/hyBKt/6gFP0NkojKMOuKDVt1Z9b9Ac8qjGW/Z+zqcT
 tnnAFa5iY2+8MSMd8cO04Jc9FYZ8IeF+oKwfXfHL/1e6gpvSKS7cY7pcgil6Fiqx4TdYahvBdmq
 S2t4AeIyE5WcHgJdxol0nkzHlXry4UMz0tYsWsdlnkrzwovKBSTGtbkAqBjRrqoYTKuvoMvdz8t
 LKTVIDb5ETcI1KEUqCcSbZBVeXpDSJeYAS80FxSbHyKQAoxN
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


