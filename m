Return-Path: <linux-kselftest+bounces-38781-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A86B22B1A
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 16:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3C0D3B60AA
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 14:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FFE2ED166;
	Tue, 12 Aug 2025 14:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jz6GdDjD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123492D0C99;
	Tue, 12 Aug 2025 14:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755009760; cv=none; b=Q8O9ZUWBsLXin0p1HaEhsc+hRLinVGzyYun+N3gthUHDoqhbo+v5e4zbL6A3OnWa89KPqiqwIlKbUXs2V+V6g64RrbRJnoAWCscHCEzoikNaEPeC3NhUNDTChNDnM8hSDo+zwfDxBfqxW9x2n7R4szy20ASYQCdCRIzqrvNmBik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755009760; c=relaxed/simple;
	bh=ETLjRp9vig5Efxzz4KkC1MHH3nZ8dtIu3vn/zI9XXgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SdFSxPs25cOmDunblcMcpu29ik/wynKpG0ZAXdopAAudDeOKvvhacIuhkqfs0xWh7tF02W9iWjpAF0jTnB3K9lJUNnCL/nHjBqdOyDuWBDEJPnH6S3Wap+JAy9J5Oja2zMJJZ20bFP1/ZhNoj2m9D1UNB9yROe5+czII6zruPA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jz6GdDjD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31FE7C4CEF0;
	Tue, 12 Aug 2025 14:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755009756;
	bh=ETLjRp9vig5Efxzz4KkC1MHH3nZ8dtIu3vn/zI9XXgM=;
	h=From:Date:Subject:To:Cc:From;
	b=jz6GdDjDIlbP1PK8+LRHxmZfpY/1xLYqiQao3PRoxLTVrAuv/4Fi4T3rY3dwwwC3e
	 bu7gCPbM1PAmFnDy43whWI2TLaAZQuewqNJ8s5ukLsP8zE05korj/QLDzNHyLmT7cA
	 Fm6yeivWzYL2NPHhXYH+hRA1mOknv1ravCjbnbh0MXChcCrTpuDHDrD3ciH/wiC1Ql
	 VgV0lygTnnklTdFS/5n0NdgPqM29QL7OUti4jo9ZuHc0TH80zBTbrrVAhKj+FwI8WW
	 NCvrdvKmQErzHCPny6zjICs5EdDtHn9x6lLd4/3Mjg76stO4bPCKs4+GxmqssC1rVg
	 2U2Mv+467B3Gw==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 12 Aug 2025 15:37:00 +0100
Subject: [PATCH] kselftest/arm64: Log error codes in sve-ptrace
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-arm64-fp-ptrace-perror-v1-1-7ce62d33709d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAItRm2gC/x3MPQqAMAxA4atIZgO1/nsVcag11QxqSUUE6d0tj
 t/w3guBhCnAkL0gdHPg80go8gzsZo6VkJdk0ErXqlMdGtmbCp1Hf4mxhJ5ETkFdqHluXV/a1kK
 KvZDj5x+PU4wf3GhpF2gAAAA=
X-Change-ID: 20250808-arm64-fp-ptrace-perror-210bb7f93c7c
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=2712; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ETLjRp9vig5Efxzz4KkC1MHH3nZ8dtIu3vn/zI9XXgM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBom1LaJ2upA/Uof7Z6d84nh9kx7p1YYlXKHscrv
 iC4NrTG1FeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaJtS2gAKCRAk1otyXVSH
 0APcB/wIoS/byN8bBx9jFgGH5oBOuTnhPMPMHSeiHSWXMPQQcczrKVeakRJrDvPo3wqLFzaxvOn
 XQOWArDyXhF4vwGp17dxTpTnMIao1freeft1YX2LDL8zMbeAglOKoS9m3yVzzXVPyKfOzXiWkyI
 QPBVBezeoA8aKggBXa++YTxbGLHJOzEI97NhMBcLI92sNf22w4z1kYcZNPXqNXc4VrdlBXJXmet
 yU5BvhSbzY05tJC5f4fNfzcJPEt+OAQjZT3V60dZe98Vjg7mkSypYaGBmpIbEJG7TtsnyzdnVPM
 acLN9g1xsRaV0X1t33dq68eu/hM4oG90ptxIKIsM8hBGvbu7
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Use ksft_perror() to report error codes from failing ptrace operations to
make it easier to interpret logs when things go wrong.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index b22303778fb0..4cba3bcff660 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -95,19 +95,27 @@ static int do_child(void)
 static int get_fpsimd(pid_t pid, struct user_fpsimd_state *fpsimd)
 {
 	struct iovec iov;
+	int ret;
 
 	iov.iov_base = fpsimd;
 	iov.iov_len = sizeof(*fpsimd);
-	return ptrace(PTRACE_GETREGSET, pid, NT_PRFPREG, &iov);
+	ret = ptrace(PTRACE_GETREGSET, pid, NT_PRFPREG, &iov);
+	if (ret == -1)
+		ksft_perror("ptrace(PTRACE_GETREGSET)");
+	return ret;
 }
 
 static int set_fpsimd(pid_t pid, struct user_fpsimd_state *fpsimd)
 {
 	struct iovec iov;
+	int ret;
 
 	iov.iov_base = fpsimd;
 	iov.iov_len = sizeof(*fpsimd);
-	return ptrace(PTRACE_SETREGSET, pid, NT_PRFPREG, &iov);
+	ret = ptrace(PTRACE_SETREGSET, pid, NT_PRFPREG, &iov);
+	if (ret == -1)
+		ksft_perror("ptrace(PTRACE_SETREGSET)");
+	return ret;
 }
 
 static struct user_sve_header *get_sve(pid_t pid, const struct vec_type *type,
@@ -117,6 +125,7 @@ static struct user_sve_header *get_sve(pid_t pid, const struct vec_type *type,
 	void *p;
 	size_t sz = sizeof *sve;
 	struct iovec iov;
+	int ret;
 
 	while (1) {
 		if (*size < sz) {
@@ -132,8 +141,11 @@ static struct user_sve_header *get_sve(pid_t pid, const struct vec_type *type,
 
 		iov.iov_base = *buf;
 		iov.iov_len = sz;
-		if (ptrace(PTRACE_GETREGSET, pid, type->regset, &iov))
+		ret = ptrace(PTRACE_GETREGSET, pid, type->regset, &iov);
+		if (ret) {
+			ksft_perror("ptrace(PTRACE_GETREGSET)");
 			goto error;
+		}
 
 		sve = *buf;
 		if (sve->size <= sz)
@@ -152,10 +164,14 @@ static int set_sve(pid_t pid, const struct vec_type *type,
 		   const struct user_sve_header *sve)
 {
 	struct iovec iov;
+	int ret;
 
 	iov.iov_base = (void *)sve;
 	iov.iov_len = sve->size;
-	return ptrace(PTRACE_SETREGSET, pid, type->regset, &iov);
+	ret = ptrace(PTRACE_SETREGSET, pid, type->regset, &iov);
+	if (ret == -1)
+		ksft_perror("ptrace(PTRACE_SETREGSET)");
+	return ret;
 }
 
 /* Validate setting and getting the inherit flag */

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250808-arm64-fp-ptrace-perror-210bb7f93c7c

Best regards,
--  
Mark Brown <broonie@kernel.org>


