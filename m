Return-Path: <linux-kselftest+bounces-34560-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18121AD3775
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 14:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DF323A345E
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 12:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D512D0282;
	Tue, 10 Jun 2025 12:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glBwew/x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331E22BD596;
	Tue, 10 Jun 2025 12:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749559357; cv=none; b=DxCHlbThzNS6zaHtpTvWsnAsRyhiZYVYgoBE9WagfgpEhhEivx+AEvCKjaGvGB+n35Ep6S5/PmU5UwuUBGiCquk997CQklmRu844tZcuY5ba7f8ZWtkdDgHY7bX54yVSOIbqp8J3CrcghbWT/3fHVgAuPZYnnJEn8YMPW5mHNTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749559357; c=relaxed/simple;
	bh=MPMWLRYngQawDoNsJTy1uY6kJqIuvjy1h24Z2RiXIbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cZ1AhZi4E76tGMfG1Dt4F9HWgHP3M6jBL7PMFPxjZWnY6rP1XeCUEKNAJlca2yP0/2WysVYoQzqXuCp3nRetkUR4C/yRG3MYM163uHMNrU3/UD+3ai0DZmOqaUViMej/VGPG73P1FnxVIsaGpw6CZViMDu29HIBswXG5xYiSedQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glBwew/x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A36C4CEF1;
	Tue, 10 Jun 2025 12:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749559356;
	bh=MPMWLRYngQawDoNsJTy1uY6kJqIuvjy1h24Z2RiXIbc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=glBwew/xFmsZblnYcnNsAy1jYkxzM4R88S3WM282+ssBywad88KAcynoLh4nQ3jWW
	 sjFOzZ05tqVqeFn8u6wcWhzO75akYaC5rCA8skeJtwkpCUDEDJLDjVvujYHly8BhNN
	 JYlp6/sXfqObip4YtoTd/QX5sKb/iibdGgwxxJm3IbN344byyjdTDQ4diY6OD6R2Fx
	 03+RphiaJD2bJ6NxKIyUuKeTTSNmnHjysgOvsnI9gIeaTu7T+gAhjxdOXx0QdvZ/Fj
	 FFoAlFN8xy/hbtb0NlasKEkB2Xqb+65Albdyk97TCPtgHzbS9Pu/phLjGvwhmlmXVr
	 +naFK3qzQjxcw==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 10 Jun 2025 13:29:46 +0100
Subject: [PATCH v2 3/4] kselftest/arm64: Add a test for vfork() with GCS
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-arm64-gcs-vfork-exit-v2-3-929443dfcf82@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2389; i=broonie@kernel.org;
 h=from:subject:message-id; bh=MPMWLRYngQawDoNsJTy1uY6kJqIuvjy1h24Z2RiXIbc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoSCgwon8lvvXCpJn3/Mg5a+oD+zXp/XHAV9+svyua
 26OqNAmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaEgoMAAKCRAk1otyXVSH0HZfB/
 45rn40YaQ0Kbg0ebFttFNnd4Er7dRx9zeFK/ZIcExaR3lUaClGkfta2V5Ols4VL47KPVN6YDU2emP6
 IPoSEUafk4vAFOmeWh4So43TxcJfML7IQ7avt5LHWdMRogKtZsW+6E43qFehbP1byBaQQvRdZwhi43
 s9gBHgi7AVqVpIk8UiFI71ONqtS57iVqTJzL7kEEjfvUR7Z6EpUgj6f1Wpu3nrn4fp6rwRF7Ja87d1
 3xwnFBFUXbA0WMTg96jZ6qUJ0bNDSf3FtkrpG9fl4HCXGIDcqEHeiWLPcJKWHlibyXw43YPACsInRY
 pUE7H+a3NHL9W//mX98HZ3a7H1KsXe
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Ensure that we've got at least some coverage of the special cases around
vfork() by adding a test case in basic-gcs doing the same thing as the
plain fork() one - vfork(), do a few checks and then return to the parent.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/gcs/basic-gcs.c | 63 +++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/tools/testing/selftests/arm64/gcs/basic-gcs.c b/tools/testing/selftests/arm64/gcs/basic-gcs.c
index 3fb9742342a3..96ea51cf7163 100644
--- a/tools/testing/selftests/arm64/gcs/basic-gcs.c
+++ b/tools/testing/selftests/arm64/gcs/basic-gcs.c
@@ -298,6 +298,68 @@ static bool test_fork(void)
 	return pass;
 }
 
+/* A vfork()ed process can run and exit */
+static bool test_vfork(void)
+{
+	unsigned long child_mode;
+	int ret, status;
+	pid_t pid;
+	bool pass = true;
+
+	pid = vfork();
+	if (pid == -1) {
+		ksft_print_msg("vfork() failed: %d\n", errno);
+		pass = false;
+		goto out;
+	}
+	if (pid == 0) {
+		/* In child, make sure we can call a function, read
+		 * the GCS pointer and status and then exit */
+		valid_gcs_function();
+		get_gcspr();
+
+		ret = my_syscall5(__NR_prctl, PR_GET_SHADOW_STACK_STATUS,
+				  &child_mode, 0, 0, 0);
+		if (ret == 0 && !(child_mode & PR_SHADOW_STACK_ENABLE)) {
+			ksft_print_msg("GCS not enabled in child\n");
+			ret = -EINVAL;
+		}
+
+		exit(ret);
+	}
+
+	/*
+	 * In parent, check we can still do function calls then block
+	 * for the child.
+	 */
+	valid_gcs_function();
+
+	ksft_print_msg("Waiting for child %d\n", pid);
+
+	ret = waitpid(pid, &status, 0);
+	if (ret == -1) {
+		ksft_print_msg("Failed to wait for child: %d\n",
+			       errno);
+		return false;
+	}
+
+	if (!WIFEXITED(status)) {
+		ksft_print_msg("Child exited due to signal %d\n",
+			       WTERMSIG(status));
+		pass = false;
+	} else {
+		if (WEXITSTATUS(status)) {
+			ksft_print_msg("Child exited with status %d\n",
+				       WEXITSTATUS(status));
+			pass = false;
+		}
+	}
+
+out:
+
+	return pass;
+}
+
 typedef bool (*gcs_test)(void);
 
 static struct {
@@ -314,6 +376,7 @@ static struct {
 	{ "enable_invalid", enable_invalid, true },
 	{ "map_guarded_stack", map_guarded_stack },
 	{ "fork", test_fork },
+	{ "vfork", test_vfork },
 };
 
 int main(void)

-- 
2.39.5


