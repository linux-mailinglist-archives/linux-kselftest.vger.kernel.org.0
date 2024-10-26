Return-Path: <linux-kselftest+bounces-20760-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8239B1A8E
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Oct 2024 21:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0A9CB21591
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Oct 2024 19:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AB054277;
	Sat, 26 Oct 2024 19:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4Z2vMcE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C032F36;
	Sat, 26 Oct 2024 19:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729970194; cv=none; b=JI0hFmtVZkkob7dErsKwrRVbsTwoRo/seqjR88pFLNPf5uHNawM6b1CsECeHuQklqMsWpMm4EDdJqih/CmqmtSdgKR0aUuDoJC70LJtqp0sdfrK9JbXGYNisb2VouNZRPcrhk9iPllw5LdZvYXEaNHgc4b5AoL/IfaWazdwtd7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729970194; c=relaxed/simple;
	bh=5mJgG8FZELFrxdEtu73Y69omdia1hdCOMqZtpQA29lU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ct2h0vsM9BImeoRlh4LDezo3ni/Z8LSj0JEEnmZ+hwrRkP0CJ7KfHRqt25eXZkOQZ6R/nViOXr7kWTPGj8rSd1oD6P3OoOoopJWLlsnZn4NWRSYohJXKpeQG8Xqk7hEr4SbQAKXp3pQDsKMCWJ8z4ThcYM1F88HX5C7bbbyRXS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4Z2vMcE; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e2e88cb0bbso2336637a91.3;
        Sat, 26 Oct 2024 12:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729970191; x=1730574991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YpvaN5KPcpwOwyPkqoJSqwKRhVGT/3QKcsfz4Jmu9NM=;
        b=W4Z2vMcENqTmn5foO3Us3AlgHQAIh4tT14x0IHM+ELoUNXGUMkx0giOUx/wnOo/zV1
         p6XkoQzytNigT+Vf+L+amxu1vffHuooS0P2wQoHy12Mk8XbrBNm6zDcYaGvm9jGQzw+C
         hbkwzc/djo3qevE595PUuJTy212kQfYBTTA+B/0exrOsUF+S+0j9voHf45QvSUdGwi4D
         xLWDNE6TIOs3QPTkt//dtDsjhowZ9pamayAlyyfh9bJyKqFtXSsfpC1ca//ekDFdzSDG
         4uO5rbCKTm3U/DSrBijpsf+OrBP2VjHRkwigkc38OKO307g0pzZCL3l7gbaudlVSDTgZ
         GXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729970191; x=1730574991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YpvaN5KPcpwOwyPkqoJSqwKRhVGT/3QKcsfz4Jmu9NM=;
        b=fBuauL/JW1hA2IaoIWkaX9jSJqXwSZA6JA3HG0uonRc/RmsWRbZFiwXEbf8rZEa7wd
         BvgB2D5LRy9hln/iWEQDvOJyjnN/EW135HZQD3mH6ch0PutDKaWUNIutWqAj3BsjGgtl
         W+84yJQ52KMIQF8a+ILx8b36pKx9OihLfPnefy5xTa6N/OUy2FF7tJjSRcyHCTzBnBgm
         0uU9sbE6a3SS7ruGED0GGC0mLsXEQwynBp6+gfw7G58QFRxGLJixu8MWfBQUror7md4T
         C4bbJ7E5C2roF+LSX8awwEsYzS5zzE0cKpQaEwpeUsYYB3r/tM1eFORsZXOiLO8fZto+
         S0Hw==
X-Forwarded-Encrypted: i=1; AJvYcCXdQHLxQoHxQBoFRSU3LPNq6IwjFJ8q/DJhvc8VNV3kn97oMf7Ms4l6rxDutjCXvcaj+09/LHQR71Eisis=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF1Td/SrMLDVz94pqDXFjagf8MY+75Pof/pr3EGD12AY7AYKkK
	c51t4vUUhP8MbRAQh8kbo8gh5wNklJqte4+A1sYCysJJap+KkZXs
X-Google-Smtp-Source: AGHT+IGVk6qNtK2x37b+RYV876g9E0RDjd+xb/Uw69AsHLaeZc4+Y8g6H8yPuy7qm/tr+fNpO0WxlQ==
X-Received: by 2002:a17:90a:c70e:b0:2e5:5ab5:ba4b with SMTP id 98e67ed59e1d1-2e8f107b5b4mr4383666a91.22.1729970191290;
        Sat, 26 Oct 2024 12:16:31 -0700 (PDT)
Received: from 2abb50c-lcedt.nvidia.com ([203.200.25.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e3572e69sm3880915a91.16.2024.10.26.12.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 12:16:31 -0700 (PDT)
From: Shivam Chaudhary <cvam0000@gmail.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shivam Chaudhary <cvam0000@gmail.com>
Subject: [PATCH v2] selftests: tmpfs: Add kselftest support to tmpfs
Date: Sun, 27 Oct 2024 00:46:21 +0530
Message-Id: <20241026191621.2860376-1-cvam0000@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kselftest support for open, linkat, unshare, mount tests

- Replace direct error handling with
 `ksft_test_result_*` macros for better reporting
  of test outcomes.

- Add `ksft_print_header()` and `ksft_set_plan()`
 to structure test outputs more effectively.

- Introduce the helper function `is_unshare()` to
  handle unshare() related checks.

- Improve the test flow by adding more detailed pass/fail
  reporting for unshare, mounting, file opening, and linking
  operations.

- Skip the test if it's not run as root, providing an
  appropriate Warning.

Test logs:

Before change:

- Without root
 error: unshare, errno 1

- With root
 No, output

After change:

- Without root
 TAP version 13
 1..1
 ok 1 # SKIP This test needs root to run

- With root
 TAP version 13
 1..1
 ok 1 unshare(): we have a new mount namespace.
 1..2
 ok 2 mount(): Root filesystem private mount: Success
 1..3
 ok 3 mount(): Mounting tmpfs on /tmp: Success
 1..4
 ok 4 openat(): Open first temporary file: Success
 1..5
 ok 5 linkat(): Linking the temporary file: Success
 1..6
 ok 6 openat(): Opening the second temporary file: Success
 # Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
---
Notes:
	Changes in v2:
  		- Make the commit message more clear.
    
	link to v1: https://lore.kernel.org/all/20241024200228.1075840-1-cvam0000@gmail.com/T/#u

 .../selftests/tmpfs/bug-link-o-tmpfile.c      | 72 +++++++++++++++----
 1 file changed, 58 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
index b5c3ddb90942..26dea19c1614 100644
--- a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
+++ b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
@@ -23,45 +23,89 @@
 #include <sys/mount.h>
 #include <unistd.h>
 
-int main(void)
-{
-	int fd;
+#include "../kselftest.h"
 
-	if (unshare(CLONE_NEWNS) == -1) {
+static int is_unshare(int flag)
+{
+	if (unshare(flag) == -1) {
 		if (errno == ENOSYS || errno == EPERM) {
-			fprintf(stderr, "error: unshare, errno %d\n", errno);
-			return 4;
+			ksft_test_result_fail("error: unshare, errno %d\n", errno);
+			return -1; // Return -1 for failure
 		}
 		fprintf(stderr, "error: unshare, errno %d\n", errno);
+		return -1;
+	}
+
+	return 0; // Return 0 for success
+}
+
+int main(void)
+{
+	int fd;
+
+	// Setting up kselftest framework
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	// Check if test is run as root
+	if (geteuid()) {
+		ksft_test_result_skip("This test needs root to run!\n");
 		return 1;
 	}
-	if (mount(NULL, "/", NULL, MS_PRIVATE|MS_REC, NULL) == -1) {
-		fprintf(stderr, "error: mount '/', errno %d\n", errno);
+
+	if (is_unshare(CLONE_NEWNS) == 0) {
+		ksft_test_result_pass("unshare(): we have a new mount namespace.\n");
+	} else {
+		ksft_test_result_fail("unshare(): failed\n");
 		return 1;
 	}
 
+	ksft_set_plan(2);
+
+	if (mount(NULL, "/", NULL, MS_PRIVATE | MS_REC, NULL) == -1) {
+		ksft_test_result_fail("mount(): Root filesystem private mount: Fail %d\n", errno);
+		return 1;
+	} else {
+		ksft_test_result_pass("mount(): Root filesystem private mount: Success\n");
+	}
+
+	ksft_set_plan(3);
 	/* Our heroes: 1 root inode, 1 O_TMPFILE inode, 1 permanent inode. */
 	if (mount(NULL, "/tmp", "tmpfs", 0, "nr_inodes=3") == -1) {
-		fprintf(stderr, "error: mount tmpfs, errno %d\n", errno);
+		ksft_test_result_fail("mount(): Mounting tmpfs on /tmp: Fail %d\n", errno);
 		return 1;
+	} else {
+		ksft_test_result_pass("mount(): Mounting tmpfs on /tmp: Success\n");
 	}
 
-	fd = openat(AT_FDCWD, "/tmp", O_WRONLY|O_TMPFILE, 0600);
+	ksft_set_plan(4);
+	fd = openat(AT_FDCWD, "/tmp", O_WRONLY | O_TMPFILE, 0600);
 	if (fd == -1) {
-		fprintf(stderr, "error: open 1, errno %d\n", errno);
+		ksft_test_result_fail("openat(): Open first temporary file: Fail %d\n", errno);
 		return 1;
+	} else {
+		ksft_test_result_pass("openat(): Open first temporary file: Success\n");
 	}
+
+	ksft_set_plan(5);
 	if (linkat(fd, "", AT_FDCWD, "/tmp/1", AT_EMPTY_PATH) == -1) {
-		fprintf(stderr, "error: linkat, errno %d\n", errno);
+		ksft_test_result_fail("linkat(): Linking the temporary file: Fail %d\n", errno);
+		close(fd); // Ensure fd is closed on failure
 		return 1;
+	} else {
+		ksft_test_result_pass("linkat(): Linking the temporary file: Success\n");
 	}
 	close(fd);
 
-	fd = openat(AT_FDCWD, "/tmp", O_WRONLY|O_TMPFILE, 0600);
+	ksft_set_plan(6);
+	fd = openat(AT_FDCWD, "/tmp", O_WRONLY | O_TMPFILE, 0600);
 	if (fd == -1) {
-		fprintf(stderr, "error: open 2, errno %d\n", errno);
+		ksft_test_result_fail("openat(): Opening the second temporary file: Fail %d\n", errno);
 		return 1;
+	} else {
+		ksft_test_result_pass("openat(): Opening the second temporary file: Success\n");
 	}
 
+	ksft_exit_pass();
 	return 0;
 }
-- 
2.34.1


