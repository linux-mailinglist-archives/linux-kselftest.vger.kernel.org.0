Return-Path: <linux-kselftest+bounces-42021-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BF0B8DBBE
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 15:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4756189BE7B
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 13:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA002D836D;
	Sun, 21 Sep 2025 13:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yc89g9/F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B6B246348;
	Sun, 21 Sep 2025 13:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758461120; cv=none; b=p4Grz61fnwvE/9zI1reD3dAg4rRnvD8D9jZW0Uu2kEMF4CtCslGy1hsRQ3zeP5Uf3z/HJYZZzbqQ1YHlBNlI8703q9OH+lCdirgx5Cl8svGQ73KOG/k7yzBGlvV8iKq8/otbvb7kikY2OfDS6E9SJgLZkByj/s43wS4kSHS97vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758461120; c=relaxed/simple;
	bh=FE4Staxl9+mwSZcKwcO0fto6nTUyhBcjpM/AKe7NNY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L91Qcey6AhW5Svop5LrIHE4lQAOG3rsBJVBpZ1lk7r7gwLdwVD9j3NGqq3y78Q69EGYM9SYXgfUNtVP8PGvlFVHKqNngDoKrsOaDQhMxYJbQWkKVLWAjYoutRGps2fepoigZYknJ5Ei2+y4odGPJLYqDmjk4Ny1y0N5co4Dg8Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yc89g9/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029B7C4CEF0;
	Sun, 21 Sep 2025 13:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758461119;
	bh=FE4Staxl9+mwSZcKwcO0fto6nTUyhBcjpM/AKe7NNY8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Yc89g9/F/laADXDu6ZyJb9kVjEtwNioPYXSRgxQXgZdPXrB4bbnYsLysHu5P/TAnp
	 Kf1WdAGYFzTWs0JoLAxWrOL3griTN3JXT5sk/SK8n8Diuuwwkp/YTiogBod9aAwlDQ
	 sjZ0NLixO9nACX4MxgOLjbNxFSYOvT44EE8ZfHoS08+T3BYCnHvX2dD1qqR1hqQ826
	 7cqHkPMvmeJfMfgmT1gcUmWixe85nSmgHE043GkTbJkbTVJk2i1x2rAN8RBUfmc2cq
	 KWj1yheucpElKXGmqcA6i1NDumLxYwZXXYC7wPD/PHUL6dAYd2ESPV4dgMVCa2YZ1y
	 0eALsiHzHkV5Q==
From: Mark Brown <broonie@kernel.org>
Date: Sun, 21 Sep 2025 14:21:36 +0100
Subject: [PATCH RFC 2/3] kselftest/arm64: Validate
 PR_SHADOW_STACK_EXIT_TOKEN in basic-gcs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-arm64-gcs-exit-token-v1-2-45cf64e648d5@kernel.org>
References: <20250921-arm64-gcs-exit-token-v1-0-45cf64e648d5@kernel.org>
In-Reply-To: <20250921-arm64-gcs-exit-token-v1-0-45cf64e648d5@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Christian Brauner <brauner@kernel.org>, 
 Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Wilco Dijkstra <wilco.dijkstra@arm.com>, 
 Carlos O'Donell <codonell@redhat.com>, Florian Weimer <fweimer@redhat.com>, 
 Szabolcs Nagy <nsz@port70.net>, Rich Felker <dalias@libc.org>, 
 libc-alpha@sourceware.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=openpgp-sha256; l=4482; i=broonie@kernel.org;
 h=from:subject:message-id; bh=FE4Staxl9+mwSZcKwcO0fto6nTUyhBcjpM/AKe7NNY8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoz/y0qv/Jyaej/JiKd4zy1N2rJ1bK2njRN45w9
 EPbCK0jLlWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaM/8tAAKCRAk1otyXVSH
 0KuRB/0bDm/ebdy8GZSxWh/fi1nPlICB1XII9YWAt+iA7wyVCD0CLW5vjcJPBAlk/BPRamycpdx
 1/QlWc2HK7SLE/sM87DFGj3EEJneinoMRX3J3IdlgyopEbv1JBrkDyhm1P3Rwo9vk7ZGcwG3+sb
 OMVM7iTx1aNXZe4/ODOfo4LJb4fV73L4LAblIqhiO/3BljLKG67blpfF1SzkSfLqGz1ZlG0r1f7
 CImcAMlZMzIXqCs1ADT/DegqlmLkWNGspPxK8hfy+F7rOJ3HCf5fl2ae97V/pxX7nmXkvTadfWO
 oyJ01dPgAhj2tIKe3nFNVx8Lrr71bNo3wDIqKekFGTMPEOZc
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Add a simple test which validates that exit tokens can be written to the
GCS of exiting threads, in basic-gcs since this functionality is expected
to be used by libcs.

We should add further tests which validate the option being absent.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/gcs/basic-gcs.c | 121 ++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/tools/testing/selftests/arm64/gcs/basic-gcs.c b/tools/testing/selftests/arm64/gcs/basic-gcs.c
index 54f9c888249d..5515a5425186 100644
--- a/tools/testing/selftests/arm64/gcs/basic-gcs.c
+++ b/tools/testing/selftests/arm64/gcs/basic-gcs.c
@@ -360,6 +360,126 @@ static bool test_vfork(void)
 	return pass;
 }
 
+/* We can reuse a shadow stack with an exit token */
+static bool test_exit_token(void)
+{
+	struct clone_args clone_args;
+	int ret, status;
+	static bool pass = true; /* These will be used in the thread */
+	static uint64_t expected_cap;
+	static int elem;
+	static uint64_t *buf;
+
+	/* Ensure we've got exit tokens enabled here */
+	ret = my_syscall5(__NR_prctl, PR_SET_SHADOW_STACK_STATUS,
+			  PR_SHADOW_STACK_ENABLE | PR_SHADOW_STACK_EXIT_TOKEN,
+			  0, 0, 0);
+	if (ret != 0)
+		ksft_exit_fail_msg("Failed to enable exit token: %d\n", ret);
+
+	buf = (void *)my_syscall3(__NR_map_shadow_stack, 0, page_size,
+				  SHADOW_STACK_SET_TOKEN);
+	if (buf == MAP_FAILED) {
+		ksft_print_msg("Failed to map %lu byte GCS: %d\n",
+			       page_size, errno);
+		return false;
+	}
+	ksft_print_msg("Mapped GCS at %p-%p\n", buf,
+		       (void *)((uint64_t)buf + page_size));
+
+	/* We should have a cap token */
+	elem = (page_size / sizeof(uint64_t)) - 1;
+	expected_cap = ((uint64_t)buf + page_size - 8);
+	expected_cap &= GCS_CAP_ADDR_MASK;
+	expected_cap |= GCS_CAP_VALID_TOKEN;
+	if (buf[elem] != expected_cap) {
+		ksft_print_msg("Cap entry is 0x%llx not 0x%llx\n",
+			       buf[elem], expected_cap);
+		pass = false;
+	}
+	ksft_print_msg("cap token is 0x%llx\n", buf[elem]);
+
+	memset(&clone_args, 0, sizeof(clone_args));
+	clone_args.exit_signal = SIGCHLD;
+	clone_args.flags = CLONE_VM;
+	clone_args.shstk_token = (uint64_t)&(buf[elem]);
+	clone_args.stack = (uint64_t)malloc(page_size);
+	clone_args.stack_size = page_size;
+
+	if (!clone_args.stack) {
+		ksft_print_msg("Failed to allocate stack\n");
+		pass = false;
+	}
+
+	/* Don't try to clone if we're failing, we might hang */
+	if (!pass)
+		goto out;
+
+	/* There is no wrapper for clone3() in nolibc (or glibc) */
+	ret = my_syscall2(__NR_clone3, &clone_args, sizeof(clone_args));
+	if (ret == -1) {
+		ksft_print_msg("clone3() failed: %d\n", errno);
+		pass = false;
+		goto out;
+	}
+
+	if (ret == 0) {
+		/* In the child, make sure the token is gone */
+		if (buf[elem]) {
+			ksft_print_msg("GCS token was not consumed: %llx\n",
+				       buf[elem]);
+			pass = false;
+		}
+
+		/* Make sure we're using the right stack */
+		if ((uint64_t)get_gcspr() != (uint64_t)&buf[elem + 1]) {
+			ksft_print_msg("Child GCSPR_EL0 is %llx not %llx\n",
+				       (uint64_t)get_gcspr(),
+				       (uint64_t)&buf[elem + 1]);
+			pass = false;
+		}
+
+		/* We want to exit with *exactly* the same GCS pointer */
+		my_syscall1(__NR_exit, 0);
+	}
+
+	ksft_print_msg("Waiting for child %d\n", ret);
+
+	ret = waitpid(ret, &status, 0);
+	if (ret == -1) {
+		ksft_print_msg("Failed to wait for child: %d\n",
+			       errno);
+		pass = false;
+		goto out;
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
+	/* The token should have been restored */
+	if (buf[elem] == expected_cap) {
+		ksft_print_msg("Cap entry restored\n");
+	} else {
+		ksft_print_msg("Cap entry is 0x%llx not 0x%llx\n",
+			       buf[elem], expected_cap);
+		pass = false;
+	}
+
+out:
+	free((void*)clone_args.stack);
+	munmap(buf, page_size);
+	return pass;
+}
+
 typedef bool (*gcs_test)(void);
 
 static struct {
@@ -377,6 +497,7 @@ static struct {
 	{ "map_guarded_stack", map_guarded_stack },
 	{ "fork", test_fork },
 	{ "vfork", test_vfork },
+	{ "exit_token", test_exit_token },
 };
 
 int main(void)

-- 
2.47.2


