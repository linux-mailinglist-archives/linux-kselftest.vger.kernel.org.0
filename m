Return-Path: <linux-kselftest+bounces-39246-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 615D9B2B173
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 21:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33F6D1B22802
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 19:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90480274649;
	Mon, 18 Aug 2025 19:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VN6RNNqD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CE32737F3;
	Mon, 18 Aug 2025 19:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755544815; cv=none; b=uidoIfyGuWrp5goTblLNZBc5VRwEFX/ic+FxHAehPc1Pa2bh/zYwmTyyY6bu4qAOXgeRzjvkpzEriX/rmHpPnMTYHKeFf8puoSisCl8wkKHgLf+xuImpJ0+j1kaRG3Xy3wh0CCUewNUw72Mt6jXjGNliQGDkRMfCTBj8Hg6AIQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755544815; c=relaxed/simple;
	bh=4qseZEB1ni4WJllqQPgtgzbBKRcrHMeZ5MrHXh0v3ac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VLLdHfm88owe7ECCyv5hqkQCGG8P2AygJonfBwkBWcaObX9AaCu9Msmv3RzwiQ68z5LlNZ1hPPij5Km76PtbQPPBmqXDtrfDIX+iEylW9FO9lr3Jtvmvyt3kqCb33B69ieGBdYwD0NUbZUmdjnBL6RMGUc8Zg6swObwhvYMnETs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VN6RNNqD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC2EDC4CEEB;
	Mon, 18 Aug 2025 19:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755544814;
	bh=4qseZEB1ni4WJllqQPgtgzbBKRcrHMeZ5MrHXh0v3ac=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VN6RNNqDAXQA6Oi7PADpXSLALa21bYdRt/8O96g0n+TLddHeNBcFgbcCz1Hh1Y9cj
	 u1+2JVfS2bZBfeplYHGofze4IjfU4/wh4i9clSBr0LDNFj7mceQef2LxGCD8q5P+2T
	 V5nksQJFoVkXnMEy1ReJWApKbBSyCwVxMGpjQBipM/ex5pZssM/pC0kzcWbfP0e+BS
	 xLIzHwpx5BkF+W05OEiGlIxlOuOIqwPPS1WpZLJtZLGggCpp9EXrLds77bWMTNBNGr
	 0Vw0NXotogfMSp39IheyT2EUYxLLfBuf7qnAMBI20pU/mBp2k2s5AaljIIHhI1cFF+
	 eUwAknj9hhzpQ==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 18 Aug 2025 20:19:36 +0100
Subject: [PATCH 2/3] kselftest/filelock: Report each test in oftlocks
 separately
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-selftest-filelock-ktap-v1-2-d41af77f1396@kernel.org>
References: <20250818-selftest-filelock-ktap-v1-0-d41af77f1396@kernel.org>
In-Reply-To: <20250818-selftest-filelock-ktap-v1-0-d41af77f1396@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=4646; i=broonie@kernel.org;
 h=from:subject:message-id; bh=4qseZEB1ni4WJllqQPgtgzbBKRcrHMeZ5MrHXh0v3ac=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoo3zpId4V20uWurA1ccsawVjZHoAEyIrtm66x6
 0rLGiK4WmqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaKN86QAKCRAk1otyXVSH
 0C8cB/9ZCbThZwT+lA+c2UAjADQaR++XTveblHS9RkrehHmxO9V2CrDrZn4pi85hc+wv9O1bJK2
 vpnGDZKuCKOZcWWfdvDQbXyqBJU44Ru068/bEuxLifpihnZlxzWJqd/zwJygKKVeHeJrX+Uft3l
 bGPuRBW7C+2oWVPMvKdCgBQWZA8lL4BZlUGoiuYqy09o02xOflpFrLx3HZHAS2B8QYvt81uK4V3
 MfWIGWDY7QrNqIW1AIIT0s4uPFbOd75/id8BSUdm9/l3R/wgDR8jYYUvXT04QA8WlJfpB4j+GKH
 rqTgpdYMj9la7y+6GJOQVKqHqxvHDM+S/XwbM+JRc3wgVpIk
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The filelock test checks four different things but only reports an overall
status, convert to use ksft_test_result() for these individual tests. Each
test depends on the previous ones so we still bail out if any of them fail
but we get a bit more information from UIs parsing the results.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/filelock/ofdlocks.c | 90 +++++++++++++----------------
 1 file changed, 39 insertions(+), 51 deletions(-)

diff --git a/tools/testing/selftests/filelock/ofdlocks.c b/tools/testing/selftests/filelock/ofdlocks.c
index a59fbe6aca14..25438517f214 100644
--- a/tools/testing/selftests/filelock/ofdlocks.c
+++ b/tools/testing/selftests/filelock/ofdlocks.c
@@ -39,94 +39,82 @@ int main(void)
 	int fd = open("/tmp/aa", O_RDWR | O_CREAT | O_EXCL, 0600);
 	int fd2 = open("/tmp/aa", O_RDONLY);
 
+	ksft_print_header();
+	ksft_set_plan(4);
+
 	unlink("/tmp/aa");
 	assert(fd != -1);
 	assert(fd2 != -1);
-	ksft_print_msg("[INFO] opened fds %i %i\n", fd, fd2);
+	ksft_print_msg("opened fds %i %i\n", fd, fd2);
 
 	/* Set some read lock */
 	fl.l_type = F_RDLCK;
 	fl.l_start = 5;
 	fl.l_len = 3;
 	rc = lock_set(fd, &fl);
-	if (rc == 0) {
-		ksft_print_msg
-		    ("[SUCCESS] set OFD read lock on first fd\n");
-	} else {
-		ksft_print_msg("[FAIL] to set OFD read lock on first fd\n");
-		return -1;
-	}
+	ksft_test_result(rc == 0, "set OFD read lock on first fd\n");
+	if (rc != 0)
+		ksft_finished();
+
 	/* Make sure read locks do not conflict on different fds. */
 	fl.l_type = F_RDLCK;
 	fl.l_start = 5;
 	fl.l_len = 1;
 	rc = lock_get(fd2, &fl);
 	if (rc != 0)
-		return -1;
-	if (fl.l_type != F_UNLCK) {
-		ksft_print_msg("[FAIL] read locks conflicted\n");
-		return -1;
-	}
+		ksft_finished();
+	if (fl.l_type != F_UNLCK)
+		ksft_exit_fail_msg("read locks conflicted\n");
+
 	/* Make sure read/write locks do conflict on different fds. */
 	fl.l_type = F_WRLCK;
 	fl.l_start = 5;
 	fl.l_len = 1;
 	rc = lock_get(fd2, &fl);
 	if (rc != 0)
-		return -1;
-	if (fl.l_type != F_UNLCK) {
-		ksft_print_msg
-		    ("[SUCCESS] read and write locks conflicted\n");
-	} else {
-		ksft_print_msg
-		    ("[SUCCESS] read and write locks not conflicted\n");
-		return -1;
-	}
+		ksft_finished();
+	ksft_test_result(fl.l_type != F_UNLCK,
+			 "read and write locks conflicted\n");
+	if (fl.l_type == F_UNLCK)
+		ksft_finished();
+
 	/* Get info about the lock on first fd. */
 	fl.l_type = F_UNLCK;
 	fl.l_start = 5;
 	fl.l_len = 1;
 	rc = lock_get(fd, &fl);
-	if (rc != 0) {
-		ksft_print_msg
-		    ("[FAIL] F_OFD_GETLK with F_UNLCK not supported\n");
-		return -1;
-	}
-	if (fl.l_type != F_UNLCK) {
-		ksft_print_msg
-		    ("[SUCCESS] F_UNLCK test returns: locked, type %i pid %i len %zi\n",
-		     fl.l_type, fl.l_pid, fl.l_len);
-	} else {
-		ksft_print_msg
-		    ("[FAIL] F_OFD_GETLK with F_UNLCK did not return lock info\n");
-		return -1;
-	}
+	if (rc != 0)
+		ksft_exit_fail_msg("F_OFD_GETLK with F_UNLCK not supported\n");
+	ksft_test_result(fl.l_type != F_UNLCK,
+			 "F_OFD_GETLK with F_UNLCK returned lock info\n");
+	if (fl.l_type == F_UNLCK)
+		ksft_exit_fail();
+	ksft_print_msg("F_UNLCK test returns: locked, type %i pid %i len %zi\n",
+		       fl.l_type, fl.l_pid, fl.l_len);
+
 	/* Try the same but by locking everything by len==0. */
 	fl2.l_type = F_UNLCK;
 	fl2.l_start = 0;
 	fl2.l_len = 0;
 	rc = lock_get(fd, &fl2);
-	if (rc != 0) {
-		ksft_print_msg
-		    ("[FAIL] F_OFD_GETLK with F_UNLCK not supported\n");
-		return -1;
-	}
+	if (rc != 0)
+		ksft_exit_fail_msg
+		    ("F_OFD_GETLK with F_UNLCK not supported\n");
+	ksft_test_result(memcmp(&fl, &fl2, sizeof(fl)) == 0,
+			 "F_UNLCK with len==0 returned the same\n");
 	if (memcmp(&fl, &fl2, sizeof(fl))) {
-		ksft_print_msg
-		    ("[FAIL] F_UNLCK test returns: locked, type %i pid %i len %zi\n",
+		ksft_exit_fail_msg
+		    ("F_UNLCK test returns: locked, type %i pid %i len %zi\n",
 		     fl.l_type, fl.l_pid, fl.l_len);
-		return -1;
 	}
-	ksft_print_msg("[SUCCESS] F_UNLCK with len==0 returned the same\n");
+
 	/* Get info about the lock on second fd - no locks on it. */
 	fl.l_type = F_UNLCK;
 	fl.l_start = 0;
 	fl.l_len = 0;
 	lock_get(fd2, &fl);
-	if (fl.l_type != F_UNLCK) {
-		ksft_print_msg
-		    ("[FAIL] F_OFD_GETLK with F_UNLCK return lock info from another fd\n");
-		return -1;
-	}
-	return 0;
+	ksft_test_result(fl.l_type == F_UNLCK,
+			 "F_OFD_GETLK with F_UNLCK return lock info from another fd\n");
+
+	ksft_finished();
 }

-- 
2.39.5


