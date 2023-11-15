Return-Path: <linux-kselftest+bounces-132-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5CF7EC652
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 15:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50A301F27716
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 14:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06752EAE1;
	Wed, 15 Nov 2023 14:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMMoAMhM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CE21863A
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 14:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F615C433C8;
	Wed, 15 Nov 2023 14:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700059908;
	bh=G3egpy2nf+//PHzb7uY6/R8g/C2NnsGvbBaPizHeq6E=;
	h=From:Date:Subject:To:Cc:From;
	b=ZMMoAMhMRpDjzyDC+lzjNGV+PwdjqmzbMG16wu3PXK2EMXfXo2BICwvB7rGWuLdrw
	 oEfNfUOe8ddHtUc30tLZSd8D8uB3SXmkFb3K/kHU7hEA8yPts8ua5jcvPHE5G7rkVB
	 sZVsln0EOHonnjrZPMU1szTGBaTeDZ+dJTg3lQB6ruxvVn4oIRpdZQk7oXZQmrlk5K
	 QY9hWnPcpBptj/D0BlDHX6lhTBxGdLmVC4lhvVt8zu38TapGO3JzEJ1oHs09SPtY6C
	 JN/1XOmzx2c8znh4jTX3KFhoft+xz/yPCr7nEpLwcj+uWf6mL/K/ZRvV+2IP+Eu7Ld
	 YZUaccjZUrICA==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 15 Nov 2023 14:43:02 +0000
Subject: [PATCH] kselftest/clone3: Make test names for set_tid test stable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231115-kselftest-clone3-set-tid-v1-1-c1932591c480@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPXYVGUC/x2MwQqDMBAFf0X23IWsqVD6K+KhxJd2UaJkgwjBf
 zf0ODAzlQxZYfTuKmUcarqlBvLoKPw+6QvWuTH1rvci8uTFsMYCKxzWLcGzoXDRmYMLfmhKlFe
 klu8ZUc//epyu6wZYdIxKagAAAA==
To: Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=10772; i=broonie@kernel.org;
 h=from:subject:message-id; bh=G3egpy2nf+//PHzb7uY6/R8g/C2NnsGvbBaPizHeq6E=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlVNsCwB6v+BvXhFinTCkt3AM89CRrhr0oVrTwmAsO
 eGJd6eSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZVTbAgAKCRAk1otyXVSH0E5gB/
 4mkK4IYc0YgH6wT48Om4vAR8SreBbwYZzaU3AweeHR5ESvDO+pi5Neg1jHVA9VJtlRnfymEB2ui49W
 72d3MfNovQfYH1wF420U4wlMz+SDvkJVpMwYnxUjy4vx+7Ra1kwkQsud0f/BbEF6qZZeMsbC2+i7np
 R6ps/sZx2TGVH13GanEZGTsitt+h2rRG0F1djXT/kKHVDOuUlKlzaGZC3+eJbP19Dp+kYj88rY+tQ6
 7ROTRy+v55e4//SoKiS2+tU+yknP6U4iV2dndiqkplQx2/9uO32MaNP4geDs2iXxALTZfs9RzMD3IK
 G8HK/6MgFKzMNKt82Izt7dxZ5+q2Wh
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The test results reported for the clone3_set_tid tests interact poorly with
automation for running kselftest since the reported test names include TIDs
dynamically allocated at runtime. A lot of automation for running kselftest
will compare runs by looking at the test name to identify if the same test
is being run so changing names make it look like the testsuite has been
updated to include new tests. This makes the results display less clearly
and breaks cases like bisection.

Address this by providing a brief description of the tests and logging that
along with the stable parameters for the test currently logged. The TIDs
are already logged separately in existing logging except for the final test
which has a new log message added. We also tweak the formatting of the
logging of expected/actual values for clarity.

There are still issues with the logging of skipped tests (many are simply
not logged at all when skipped and all are logged with different names) but
these are less disruptive since the skips are all based on not being run as
root, a condition likely to be stable for a given test system.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/clone3/clone3_set_tid.c | 117 ++++++++++++++----------
 1 file changed, 69 insertions(+), 48 deletions(-)

diff --git a/tools/testing/selftests/clone3/clone3_set_tid.c b/tools/testing/selftests/clone3/clone3_set_tid.c
index ed785afb6077..9ae38733cb6e 100644
--- a/tools/testing/selftests/clone3/clone3_set_tid.c
+++ b/tools/testing/selftests/clone3/clone3_set_tid.c
@@ -114,7 +114,8 @@ static int call_clone3_set_tid(pid_t *set_tid,
 	return WEXITSTATUS(status);
 }
 
-static void test_clone3_set_tid(pid_t *set_tid,
+static void test_clone3_set_tid(const char *desc,
+				pid_t *set_tid,
 				size_t set_tid_size,
 				int flags,
 				int expected,
@@ -129,17 +130,13 @@ static void test_clone3_set_tid(pid_t *set_tid,
 	ret = call_clone3_set_tid(set_tid, set_tid_size, flags, expected_pid,
 				  wait_for_it);
 	ksft_print_msg(
-		"[%d] clone3() with CLONE_SET_TID %d says :%d - expected %d\n",
+		"[%d] clone3() with CLONE_SET_TID %d says: %d - expected %d\n",
 		getpid(), set_tid[0], ret, expected);
-	if (ret != expected)
-		ksft_test_result_fail(
-			"[%d] Result (%d) is different than expected (%d)\n",
-			getpid(), ret, expected);
-	else
-		ksft_test_result_pass(
-			"[%d] Result (%d) matches expectation (%d)\n",
-			getpid(), ret, expected);
+
+	ksft_test_result(ret == expected, "%s with %d TIDs and flags 0x%x\n",
+			 desc, set_tid_size, flags);
 }
+
 int main(int argc, char *argv[])
 {
 	FILE *f;
@@ -172,73 +169,91 @@ int main(int argc, char *argv[])
 
 	/* Try invalid settings */
 	memset(&set_tid, 0, sizeof(set_tid));
-	test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL + 1, 0, -EINVAL, 0, 0);
+	test_clone3_set_tid("invalid size, 0 TID",
+			    set_tid, MAX_PID_NS_LEVEL + 1, 0, -EINVAL, 0, 0);
 
-	test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL * 2, 0, -EINVAL, 0, 0);
+	test_clone3_set_tid("invalid size, 0 TID",
+			    set_tid, MAX_PID_NS_LEVEL * 2, 0, -EINVAL, 0, 0);
 
-	test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL * 2 + 1, 0,
-			-EINVAL, 0, 0);
+	test_clone3_set_tid("invalid size, 0 TID",
+			    set_tid, MAX_PID_NS_LEVEL * 2 + 1, 0,
+			    -EINVAL, 0, 0);
 
-	test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL * 42, 0, -EINVAL, 0, 0);
+	test_clone3_set_tid("invalid size, 0 TID",
+			    set_tid, MAX_PID_NS_LEVEL * 42, 0, -EINVAL, 0, 0);
 
 	/*
 	 * This can actually work if this test running in a MAX_PID_NS_LEVEL - 1
 	 * nested PID namespace.
 	 */
-	test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL - 1, 0, -EINVAL, 0, 0);
+	test_clone3_set_tid("invalid size, 0 TID",
+			    set_tid, MAX_PID_NS_LEVEL - 1, 0, -EINVAL, 0, 0);
 
 	memset(&set_tid, 0xff, sizeof(set_tid));
-	test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL + 1, 0, -EINVAL, 0, 0);
+	test_clone3_set_tid("invalid size, TID all 1s",
+			    set_tid, MAX_PID_NS_LEVEL + 1, 0, -EINVAL, 0, 0);
 
-	test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL * 2, 0, -EINVAL, 0, 0);
+	test_clone3_set_tid("invalid size, TID all 1s",
+			    set_tid, MAX_PID_NS_LEVEL * 2, 0, -EINVAL, 0, 0);
 
-	test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL * 2 + 1, 0,
-			-EINVAL, 0, 0);
+	test_clone3_set_tid("invalid size, TID all 1s",
+			    set_tid, MAX_PID_NS_LEVEL * 2 + 1, 0,
+			    -EINVAL, 0, 0);
 
-	test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL * 42, 0, -EINVAL, 0, 0);
+	test_clone3_set_tid("invalid size, TID all 1s",
+			    set_tid, MAX_PID_NS_LEVEL * 42, 0, -EINVAL, 0, 0);
 
 	/*
 	 * This can actually work if this test running in a MAX_PID_NS_LEVEL - 1
 	 * nested PID namespace.
 	 */
-	test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL - 1, 0, -EINVAL, 0, 0);
+	test_clone3_set_tid("invalid size, TID all 1s",
+			    set_tid, MAX_PID_NS_LEVEL - 1, 0, -EINVAL, 0, 0);
 
 	memset(&set_tid, 0, sizeof(set_tid));
 	/* Try with an invalid PID */
 	set_tid[0] = 0;
-	test_clone3_set_tid(set_tid, 1, 0, -EINVAL, 0, 0);
+	test_clone3_set_tid("valid size, 0 TID",
+			    set_tid, 1, 0, -EINVAL, 0, 0);
 
 	set_tid[0] = -1;
-	test_clone3_set_tid(set_tid, 1, 0, -EINVAL, 0, 0);
+	test_clone3_set_tid("valid size, -1 TID",
+			    set_tid, 1, 0, -EINVAL, 0, 0);
 
 	/* Claim that the set_tid array actually contains 2 elements. */
-	test_clone3_set_tid(set_tid, 2, 0, -EINVAL, 0, 0);
+	test_clone3_set_tid("2 TIDs, -1 and 0",
+			    set_tid, 2, 0, -EINVAL, 0, 0);
 
 	/* Try it in a new PID namespace */
 	if (uid == 0)
-		test_clone3_set_tid(set_tid, 1, CLONE_NEWPID, -EINVAL, 0, 0);
+		test_clone3_set_tid("valid size, -1 TID",
+				    set_tid, 1, CLONE_NEWPID, -EINVAL, 0, 0);
 	else
 		ksft_test_result_skip("Clone3() with set_tid requires root\n");
 
 	/* Try with a valid PID (1) this should return -EEXIST. */
 	set_tid[0] = 1;
 	if (uid == 0)
-		test_clone3_set_tid(set_tid, 1, 0, -EEXIST, 0, 0);
+		test_clone3_set_tid("duplicate PID 1",
+				    set_tid, 1, 0, -EEXIST, 0, 0);
 	else
 		ksft_test_result_skip("Clone3() with set_tid requires root\n");
 
 	/* Try it in a new PID namespace */
 	if (uid == 0)
-		test_clone3_set_tid(set_tid, 1, CLONE_NEWPID, 0, 0, 0);
+		test_clone3_set_tid("duplicate PID 1",
+				    set_tid, 1, CLONE_NEWPID, 0, 0, 0);
 	else
 		ksft_test_result_skip("Clone3() with set_tid requires root\n");
 
 	/* pid_max should fail everywhere */
 	set_tid[0] = pid_max;
-	test_clone3_set_tid(set_tid, 1, 0, -EINVAL, 0, 0);
+	test_clone3_set_tid("set TID to maximum",
+			    set_tid, 1, 0, -EINVAL, 0, 0);
 
 	if (uid == 0)
-		test_clone3_set_tid(set_tid, 1, CLONE_NEWPID, -EINVAL, 0, 0);
+		test_clone3_set_tid("set TID to maximum",
+				    set_tid, 1, CLONE_NEWPID, -EINVAL, 0, 0);
 	else
 		ksft_test_result_skip("Clone3() with set_tid requires root\n");
 
@@ -262,10 +277,12 @@ int main(int argc, char *argv[])
 
 	/* After the child has finished, its PID should be free. */
 	set_tid[0] = pid;
-	test_clone3_set_tid(set_tid, 1, 0, 0, 0, 0);
+	test_clone3_set_tid("reallocate child TID",
+			    set_tid, 1, 0, 0, 0, 0);
 
 	/* This should fail as there is no PID 1 in that namespace */
-	test_clone3_set_tid(set_tid, 1, CLONE_NEWPID, -EINVAL, 0, 0);
+	test_clone3_set_tid("duplicate child TID",
+			    set_tid, 1, CLONE_NEWPID, -EINVAL, 0, 0);
 
 	/*
 	 * Creating a process with PID 1 in the newly created most nested
@@ -274,7 +291,8 @@ int main(int argc, char *argv[])
 	 */
 	set_tid[0] = 1;
 	set_tid[1] = pid;
-	test_clone3_set_tid(set_tid, 2, CLONE_NEWPID, 0, pid, 0);
+	test_clone3_set_tid("create PID 1 in new NS",
+			    set_tid, 2, CLONE_NEWPID, 0, pid, 0);
 
 	ksft_print_msg("unshare PID namespace\n");
 	if (unshare(CLONE_NEWPID) == -1)
@@ -284,7 +302,8 @@ int main(int argc, char *argv[])
 	set_tid[0] = pid;
 
 	/* This should fail as there is no PID 1 in that namespace */
-	test_clone3_set_tid(set_tid, 1, 0, -EINVAL, 0, 0);
+	test_clone3_set_tid("duplicate PID 1",
+			    set_tid, 1, 0, -EINVAL, 0, 0);
 
 	/* Let's create a PID 1 */
 	ns_pid = fork();
@@ -295,21 +314,25 @@ int main(int argc, char *argv[])
 		 */
 		set_tid[0] = 43;
 		set_tid[1] = -1;
-		test_clone3_set_tid(set_tid, 2, 0, -EINVAL, 0, 0);
+		test_clone3_set_tid("check leak on invalid TID -1",
+				    set_tid, 2, 0, -EINVAL, 0, 0);
 
 		set_tid[0] = 43;
 		set_tid[1] = pid;
-		test_clone3_set_tid(set_tid, 2, 0, 0, 43, 0);
+		test_clone3_set_tid("check leak on invalid specific TID",
+				    set_tid, 2, 0, 0, 43, 0);
 
 		ksft_print_msg("Child in PID namespace has PID %d\n", getpid());
 		set_tid[0] = 2;
-		test_clone3_set_tid(set_tid, 1, 0, 0, 2, 0);
+		test_clone3_set_tid("create PID 2 in child NS",
+				    set_tid, 1, 0, 0, 2, 0);
 
 		set_tid[0] = 1;
 		set_tid[1] = -1;
 		set_tid[2] = pid;
 		/* This should fail as there is invalid PID at level '1'. */
-		test_clone3_set_tid(set_tid, 3, CLONE_NEWPID, -EINVAL, 0, 0);
+		test_clone3_set_tid("fail due to invalid TID at level 1",
+				    set_tid, 3, CLONE_NEWPID, -EINVAL, 0, 0);
 
 		set_tid[0] = 1;
 		set_tid[1] = 42;
@@ -319,13 +342,15 @@ int main(int argc, char *argv[])
 		 * namespaces. Again assuming this is running in the host's
 		 * PID namespace. Not yet nested.
 		 */
-		test_clone3_set_tid(set_tid, 4, CLONE_NEWPID, -EINVAL, 0, 0);
+		test_clone3_set_tid("fail due to too few active PID NSs",
+				    set_tid, 4, CLONE_NEWPID, -EINVAL, 0, 0);
 
 		/*
 		 * This should work and from the parent we should see
 		 * something like 'NSpid:	pid	42	1'.
 		 */
-		test_clone3_set_tid(set_tid, 3, CLONE_NEWPID, 0, 42, true);
+		test_clone3_set_tid("verify that we have 3 PID NSs",
+				    set_tid, 3, CLONE_NEWPID, 0, 42, true);
 
 		child_exit(ksft_cnt.ksft_fail);
 	}
@@ -380,14 +405,10 @@ int main(int argc, char *argv[])
 	ksft_cnt.ksft_pass += 6 - (ksft_cnt.ksft_fail - WEXITSTATUS(status));
 	ksft_cnt.ksft_fail = WEXITSTATUS(status);
 
-	if (ns3 == pid && ns2 == 42 && ns1 == 1)
-		ksft_test_result_pass(
-			"PIDs in all namespaces as expected (%d,%d,%d)\n",
-			ns3, ns2, ns1);
-	else
-		ksft_test_result_fail(
-			"PIDs in all namespaces not as expected (%d,%d,%d)\n",
-			ns3, ns2, ns1);
+	ksft_print_msg("Expecting PIDs %d, 42, 1\n", pid);
+	ksft_print_msg("Have PIDs in namespaces: %d, %d, %d\n", ns3, ns2, ns1);
+	ksft_test_result(ns3 == pid && ns2 == 42 && ns1 == 1,
+			 "PIDs in all namespaces as expected\n");
 out:
 	ret = 0;
 

---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20231114-kselftest-clone3-set-tid-c0c35111f18f

Best regards,
-- 
Mark Brown <broonie@kernel.org>


