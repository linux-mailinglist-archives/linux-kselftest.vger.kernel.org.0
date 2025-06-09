Return-Path: <linux-kselftest+bounces-34480-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D390CAD21E3
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 17:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBD117A3177
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 15:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2980F1FECB1;
	Mon,  9 Jun 2025 15:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ft5tJkvP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D2F1E0B91;
	Mon,  9 Jun 2025 15:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749481761; cv=none; b=eI5qNJS2Tm5Ogyq0NWDoCv8pU3TMlApvJpshXpdN6iVeF4H/bcR/Y2yskBy9VdQBVbLAIec1C1deM8O8EDNvwAV6sJ60t7Sr7H/MGD6zj2NGefbUXfa7xad2bnG0yoEXvYJMA3mac1zx0xgJBkNCzo6DSXrJwxXwBAjOacBKHzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749481761; c=relaxed/simple;
	bh=MPMWLRYngQawDoNsJTy1uY6kJqIuvjy1h24Z2RiXIbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lBRtwOV7OAXSMg51O9/KO6xbVTTb3BmVYRHQ1vcc9xfjdhZPE8dqkiH9trBJ+33mrAv9BFcFqUOyK3o1Xe3BOEAXnuUWYYlVaiCRj0YfHb/Yw7R//vru9t9F1B+EKNI/oD3BB1W1iPxsFDVI0YIpZ+VLYGxj4vLGLlUhOt4yIMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ft5tJkvP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C9CC4CEF4;
	Mon,  9 Jun 2025 15:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749481760;
	bh=MPMWLRYngQawDoNsJTy1uY6kJqIuvjy1h24Z2RiXIbc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ft5tJkvPS7ukE+Wcfnc0F38KrMNjffgd5Qm9gI3sgzkDVHCxFh6DCz7Ga54EHQwoz
	 Jq5c04j0aL2AOiosx9J/WHiXRefixsZEMOHluFHF0D4g4/X8jXjOeF/3MT9duf68tC
	 m40fBHYcqBbEmEHYvkIZQaNOMeQgm9qssjPvDRSjGQNXOZsxgDrkrCxV+LmG3v5YCA
	 HwQOqrzKEt2KZ/ovnbEhk1hyscJtpP/X6Dtw31IFJJWjjaMdXxDTiScP+SNMd+ZvyS
	 YDTx4dY+pSaVo8HuG+V2aIVAgljdKPrAana6pmHrPGofyaYPe/eCch+bSCMiKmqMA7
	 oIaKNeCVTv7pA==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 09 Jun 2025 16:08:57 +0100
Subject: [PATCH 2/2] kselftest/arm64: Add a test for vfork() with GCS
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-arm64-gcs-vfork-exit-v1-2-baad0f085747@kernel.org>
References: <20250609-arm64-gcs-vfork-exit-v1-0-baad0f085747@kernel.org>
In-Reply-To: <20250609-arm64-gcs-vfork-exit-v1-0-baad0f085747@kernel.org>
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
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoRvkXzSIfbjfkDSimtO0hgNVcbiQZs4A9etnx1xMt
 NTS6qGiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaEb5FwAKCRAk1otyXVSH0LlSB/
 9TE6cSOmAwL1AOXdwzxS8NcDtUYZG3sWrHWfZUUR0N7N0Iwt0O3aeoKcd+aUr418H5bKCK4uZnr2mT
 he5r6p2UYir94VIL9Ojp5Rru/opwSRI14o2teiDcwQdeNSr3hvdJb9Exy1S792ZZFSndmWE9mGqYfp
 8Y9wL1Tf7jZaTd+HPT0+1lcgFlCI+mZCF0VuG/tyzaet5htmkYwsEXKivnZDMEqHV6e0c8dwwY2vv3
 A/q4ZIaFz1oPoUZW58eDri97UwlVMjTpHXuWLHLTT0des1JtvyEYthytRbhf8ZX7+CIu9phGaewAek
 zV60WycSnUAXA2avQoTXfAtaqOjjW0
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


