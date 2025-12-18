Return-Path: <linux-kselftest+bounces-47704-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E624CCB962
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 12:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2AEC30A1818
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 11:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A97131690A;
	Thu, 18 Dec 2025 11:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="peawLDvk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02431314D13;
	Thu, 18 Dec 2025 11:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766056695; cv=none; b=T0WcbKZKSSEr2APvhYkg+de+xJG8eqZ4oOQYNVhaIS5eCiFay5cZWJBE/WakP2Af5qGH2xqE+tP3wc+uR4Pf4jk1MBK1vMFDMTrIRKTet9/ycN+xDAwEDl6hy4dm3tLSiklz9w6E/YlWp1WCQ+ytfVHV02tt9zcr5RoqMzFkETM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766056695; c=relaxed/simple;
	bh=vmNY/um9G+bwBHysTJuVVWcHuR/Vq1L6YzINaZGyZbY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SloZgGMvah4LMpFTx1qnpzh0R70zuxuEsy1Fd7nreEmFbh+LwksVYrS3o2CX+tIJhyONI2ZNa9ngNMNiP4cUmLTfH6WTWZ+VSJvnr9UQlODJ6sNBIM+s+1lhkOxKTtojdnX6zLp3AN10qwtIeyxKH5XfOJtNcwnVWqePdcvCBjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=peawLDvk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CD4C4CEFB;
	Thu, 18 Dec 2025 11:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766056694;
	bh=vmNY/um9G+bwBHysTJuVVWcHuR/Vq1L6YzINaZGyZbY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=peawLDvkgG/nXxKwHk1Rv3iCuFax4CkgZJahdVCoy68EYsJNm2hC3CAu24tqYmVLl
	 FluB6dl0jPkPiviiGQJM2d5uEhaxpkrAidRb3rtO9NFlcgOGmLGc9utkYj6xtZmXHC
	 wo+eioROxwYCQhcx2HLwLOF8RYhX7gKOnV9SyYfcVa/rFIrc70QzwBWUpXsC7je/L4
	 IJmb5yaOLsrZ5TyXp48roPR9HHzqtzlf51nvQedZCKEJ4rf7Jw/Np3Yv1CmP9YTsuC
	 dWuiHsuAZ0qtYskLce/zetq7Lmz+A4syykLM0m80PcIcxIBUPL+ybTxfkiJm2LsQhN
	 bVKr5T/aPIQeg==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 18 Dec 2025 11:18:01 +0000
Subject: [PATCH v3 2/3] kselftest/filelock: Report each test in oftlocks
 separately
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-selftest-filelock-ktap-v3-2-62acfea940dd@kernel.org>
References: <20251218-selftest-filelock-ktap-v3-0-62acfea940dd@kernel.org>
In-Reply-To: <20251218-selftest-filelock-ktap-v3-0-62acfea940dd@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=4646; i=broonie@kernel.org;
 h=from:subject:message-id; bh=vmNY/um9G+bwBHysTJuVVWcHuR/Vq1L6YzINaZGyZbY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpQ+LwMaeJKDhHGV8SOqnxQdFa5nLW8ER2MTTSk
 Genwtwr3GKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaUPi8AAKCRAk1otyXVSH
 0DobB/9T7JDrG4WMay0Io5hQcJyZtwXtG/LPQpad8sqpuEIJ4ZBCE+f2U0GmL1ZHYD+yVsqD57E
 69hDEcQHfSRVlHbde50CFozqXtfUgs0yE8l0SLjL1UmU+DKiztpDxBxnfROcX9Man39Sk8VdipO
 JrgnzoI19vOe8DZkikaeAttiU1GJYUsp+SgHrdYlCixlbHTI2UALrOH57yo3m6vkZ7njdHtR4r/
 w71HDrzETerz7VF2Ah7hA/fY5GCCWSiXsh2dd9+ykpc2PrLArJKiI4LQGVlLU8yQhgUUN1+bg94
 /0qf1anyjCwQVgcrhXAd5sGHCc2l3mgL8I6D+ijJ0rjwBoSd
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
index 2d3b06ce5e5e..68bac28b234b 100644
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
2.47.3


