Return-Path: <linux-kselftest+bounces-43182-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FB1BDE7A3
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 14:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07CD33E01ED
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 12:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25759258EC8;
	Wed, 15 Oct 2025 12:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBOka7Yy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A981F1306;
	Wed, 15 Oct 2025 12:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760531481; cv=none; b=nz0XlJsqtuQg+z/y68VV6quN8VPAYz5/H7sIbiMh/hqewXwH8XfgwZmIgzgegOviTBKQiruLoAP1VgnfOHlL0sblaxRldUuY0A19NkZfAutgEI7dam8dVps2JP4bwou2p3SiO6fzqDgo5p7N4Y0eA9ZeBQgiREgiWvxBt3CmuSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760531481; c=relaxed/simple;
	bh=+F6BhFqK/qwRD7sdwtYpVfrwMh2HqCXX3EocI8gnIkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hnOVa/mu6jclU6YYl9jCVap5YIh4wSNQOkkB7qR+JYxIuv7Wj3mh/AFrk4ukd9BlSD7n66aONXlf6UI/9lOGuh3Zdn/lpeaTcRBBm4dHys1vBqr2dxG9lQzYCKG9Lpp9LO7E/Fjuf0biNcxdwEsaDDWLh9SYNSyUKMXf9q243RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qBOka7Yy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436E7C116D0;
	Wed, 15 Oct 2025 12:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760531480;
	bh=+F6BhFqK/qwRD7sdwtYpVfrwMh2HqCXX3EocI8gnIkI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qBOka7YyqckOlVlzDw1nIBD+hFkQXqnjM977Yx3Hs3h+4p3FBtkHYdaoKk9TjtUhE
	 lARztiLTQdF559HKv2sTwdzHQzxL2Nm2Usgicqt8Se+rpCTGwPYLSa3anmsj0hp/lh
	 cKvtLOGNRsCGauB3vHZ/xx3aA47ZJJ2NPFQs8GU17WzVj6MUYKASQ6K5pQI0P0FM7/
	 +SzKBbbr2IEL1z/o/xW9wxLGeC3DbYGuZH19FHtEmbzrVD2m8NTngLQ25cSITOestJ
	 SE9E1pWzwgN4QOnydj/Ykwh0bcRKKayOQlHx3oj94GKuexaJEydkKsKdKfHxrVG7Oq
	 +64pMeuUxUyvA==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 15 Oct 2025 13:30:51 +0100
Subject: [PATCH v2 2/3] kselftest/filelock: Report each test in oftlocks
 separately
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-selftest-filelock-ktap-v2-2-f5fd21b75c3a@kernel.org>
References: <20251015-selftest-filelock-ktap-v2-0-f5fd21b75c3a@kernel.org>
In-Reply-To: <20251015-selftest-filelock-ktap-v2-0-f5fd21b75c3a@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=4646; i=broonie@kernel.org;
 h=from:subject:message-id; bh=+F6BhFqK/qwRD7sdwtYpVfrwMh2HqCXX3EocI8gnIkI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBo75QOzsXaC0RktD6B20dC7OnNR5A1Cvpa0jY00
 r5XZ6q0JymJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaO+UDgAKCRAk1otyXVSH
 0PNnB/9orq3Os2KiWP0V1/lPhwr1OKFdmydobc4zu2WgT0Nb3YlU8F/Gn5U7dVQIDP766T17b18
 jYcMB7HM38yGye4QZcEtDdpkSJLykwo4R8ZlWfJDTuDfKzjcUe6qclON3OLhX45nlAh5kyqiQdG
 FLFb1rKakmNTVwqo0QkuaE5p/scfjTjrpNYo/629CaYIq6d74lz2JXZS1Mhesaa9EZFHHc5e4JW
 5p+OjbRuTO3Nqb9Ory5XizNTZM77zIfSfEsrTuLyxiGI3YamopY6ArC18oAIqZxC7nqkLXMwY0D
 kKVLNjKnK5b6AR0W8wlBQvZJi2lafQQtHBzlrOSrgt451yuj
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
2.47.2


