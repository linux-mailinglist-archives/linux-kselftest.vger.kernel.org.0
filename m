Return-Path: <linux-kselftest+bounces-19548-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B1C99A674
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 16:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 133511C2155D
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 14:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639AB78C76;
	Fri, 11 Oct 2024 14:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCAMeVr0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CED745F4;
	Fri, 11 Oct 2024 14:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728657408; cv=none; b=Sqri0dqtuPTFSIsCaN2yABmKcV/oGgDdC9Atvb2NmJWvibBVkVHZCNqmACA3Fj0JgPMtwx1WHylH48l6efXrx10TRGj6QWV41gLqrMvejK+t1McCr0Hit6rc7NMs8eolqdp3SZX+skKpX2VjYAzf6eQTckVkdIaCbmwO2MiapEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728657408; c=relaxed/simple;
	bh=1ea53qrez4o6hsa0y87C5X/KVCdb6cASptIkacZH8m0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bOX3i4LX/uOYtU8OBeaQTOLlavlzrnLT2S65XHfh98N3DpMlj31vF6KYHj9fMjRgVxIZ2KGSo/Ghr/CpASgQmNb7OmDyoiZXnk0OYalz9IqkjKBNsLFyUZVbFnKB4dyE7BpArCMEWrgFi6Ov0PzQe/WDHNoRux3rAGM8/zUxqH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCAMeVr0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822EDC4CEC3;
	Fri, 11 Oct 2024 14:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728657408;
	bh=1ea53qrez4o6hsa0y87C5X/KVCdb6cASptIkacZH8m0=;
	h=From:Date:Subject:To:Cc:From;
	b=XCAMeVr0Tbz5GecDr6+K2LhRuVVAfZIiblGVVc9KXFC9OxCWBHZZP+9k3wIzxMekA
	 5xFwZxDdUapCLjieW6Y0TtGNrjdURu5QKXRLJ8Y2N4phF2zvV4fWclDuNDaXN9OUE/
	 4pVHnVRSaRhuODKkgMoZkw380G8PyAjk0t/jYSYLAdDk2856GhcPMZ9/m7UIQRGTNH
	 i6cuVpkIw+YBDOV8Rys/BtUodnY2qB6a4DYy4jZhog+u/rUZktumA+H3MKx++4965V
	 SXViH2EJ/01zrXdat+Mp4mBnCe+zRT+cOMXMP1apMnLtfOPuVkf3DTiaoIKf09xT6Z
	 hk+R1LwmmAuOA==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 11 Oct 2024 15:36:25 +0100
Subject: [PATCH] kselftest/arm64: Ensure stable names for GCS stress test
 results
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-arm64-gcs-stress-stable-name-v1-1-4950f226218e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOg3CWcC/x3MQQrCQAxG4auUrA1Mho5UryIuxvq3DdhRklIKp
 Xd3dPX4Nm8nhymcrs1OhlVd36VCTg31Uy4jWJ/VFENsJYhwtvnc8tg7+2LwX/LjBS55BncphSS
 XAZIi1cXHMOj239/ux/EFj731xW4AAAA=
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=1617; i=broonie@kernel.org;
 h=from:subject:message-id; bh=1ea53qrez4o6hsa0y87C5X/KVCdb6cASptIkacZH8m0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnCTf9xKXHIf3VCZybYDBM5exrPgRIKfvh8ASb+
 uO9a8tZhfqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZwk3/QAKCRAk1otyXVSH
 0ObYB/9jOh8/jfo6HTYkE3K1TuGikVIeQBcVGtfmoSKn2BF5bjyyYwBejF5GwRv49vFtvkV6Nhc
 2Ce+699mHrGBQdPaJH/hHMMMBPykaxkKcXvqnUVF42HGmGzsXMMD1DksmbnzSJII9Tjm+FqxQ7f
 UvadFRd59rahPn7GGj+UmaN7bGB/99cFbnXKz50Qylevjbi4ZlIfL/ajPniPfiZyL6NYjnJMoSD
 8fea38JZCr+rNNF2KrbIleOZnB8H84YHrNrMjHppBMHOI83nwu3pXIqLLM6YwbKXwGVNNWgGxFy
 sOlhTs1+RiiRYrs+o7LzW6et60XxudRC0W0NrT+LPm0sRLh2
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The GCS stress test program currently uses the PID of the threads it
creates in the test names it reports, resulting in unstable test names
between runs. Fix this by using a thread number instead.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/gcs/gcs-stress.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/arm64/gcs/gcs-stress.c b/tools/testing/selftests/arm64/gcs/gcs-stress.c
index bdec7ee8cfd5..03222c36c436 100644
--- a/tools/testing/selftests/arm64/gcs/gcs-stress.c
+++ b/tools/testing/selftests/arm64/gcs/gcs-stress.c
@@ -56,7 +56,7 @@ static int num_processors(void)
 	return nproc;
 }
 
-static void start_thread(struct child_data *child)
+static void start_thread(struct child_data *child, int id)
 {
 	int ret, pipefd[2], i;
 	struct epoll_event ev;
@@ -132,7 +132,7 @@ static void start_thread(struct child_data *child)
 		ev.events = EPOLLIN | EPOLLHUP;
 		ev.data.ptr = child;
 
-		ret = asprintf(&child->name, "Thread-%d", child->pid);
+		ret = asprintf(&child->name, "Thread-%d", id);
 		if (ret == -1)
 			ksft_exit_fail_msg("asprintf() failed\n");
 
@@ -437,7 +437,7 @@ int main(int argc, char **argv)
 				   tests);
 
 	for (i = 0; i < gcs_threads; i++)
-		start_thread(&children[i]);
+		start_thread(&children[i], i);
 
 	/*
 	 * All children started, close the startup pipe and let them

---
base-commit: bb9ae1a66c85eeb626864efd812c62026e126ec0
change-id: 20241011-arm64-gcs-stress-stable-name-8550519fe152

Best regards,
-- 
Mark Brown <broonie@kernel.org>


