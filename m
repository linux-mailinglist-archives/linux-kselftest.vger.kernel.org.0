Return-Path: <linux-kselftest+bounces-39389-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FDFB2E4F8
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 20:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CBD31CC24E9
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 18:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401C027E1A1;
	Wed, 20 Aug 2025 18:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhBmXqQL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D6427B332;
	Wed, 20 Aug 2025 18:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755714574; cv=none; b=jrz/7sbnYUe6fhjL0Th7xTg3AFfdil9cT3hE2O9Iwru51pppFj+L9wr3aS7xaePslQUDaAt2wgLFknnZuqgA0NhsjNBu+iHxSs5YCEZbPf7TL2x1jzrfPs6sz0PIwuBpmNF+4NP2E7FKblxYcM1kSMNXEG+/3OGuSEnYRdP1QW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755714574; c=relaxed/simple;
	bh=OMuQjCF+LEZgzxsBMcsJNa9yV1ZyVyIxF/02RSfwA9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rIz1uknG7VTdLG6UHniV3JcSCyYHrmoPhtKFg8wDpM7uFhtj4Xpk//gd524PBF31coIPuMYa/ijYJJhvQKyo1OHEg8NXZZwqp6KUdHCX1qvAookv16asyZWFPJo1eraHk5XkllHmY3bdu5xn81DdwDXf7J/9uAg5yySB8FCkiiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhBmXqQL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B4AC113CF;
	Wed, 20 Aug 2025 18:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755714573;
	bh=OMuQjCF+LEZgzxsBMcsJNa9yV1ZyVyIxF/02RSfwA9w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OhBmXqQL69XWfsGVFWp2pL/cMtfurNw6+7j363cugbyi8aJf+ZqZm+iHOy1eKLZn2
	 8QRQu7MxHqvJDgmu7QoxZ0WsPicOVAch51AjpUW/ZecIYUfeS+LcciVcglsrT04m64
	 gClvL9u+u1cr/1wtBQboezre3jeoVqzMJPrOz9d/9ZRQgbdUo63s+4YiawIzgaMME4
	 0zUEV1WfvWVYeQuXuvbNLTRBc53PxTE93gL8QTYDV46U14N2JeCnGA+9LMqRTx9u9L
	 bDmMU8EqTuZ19PGO4lMvPCTgi/O4H3rymQppPdZfvW/BatIyg14RonP8G7NJf6QCT4
	 ls007xoMEHJOw==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 20 Aug 2025 19:29:04 +0100
Subject: [PATCH 2/5] kselftest/arm64: Check that unsupported regsets fail
 in sve-ptrace
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-arm64-sme-ptrace-sme-only-v1-2-f7c22b2871f8@kernel.org>
References: <20250820-arm64-sme-ptrace-sme-only-v1-0-f7c22b2871f8@kernel.org>
In-Reply-To: <20250820-arm64-sme-ptrace-sme-only-v1-0-f7c22b2871f8@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 David Spickett <david.spickett@arm.com>, 
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>, 
 Luis Machado <luis.machado.foss@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=2392; i=broonie@kernel.org;
 h=from:subject:message-id; bh=OMuQjCF+LEZgzxsBMcsJNa9yV1ZyVyIxF/02RSfwA9w=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBophQBEDrSy5gbCqYmjEOVsYPzA4r4WdGUBR02Q
 RVoZ08qRU+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaKYUAQAKCRAk1otyXVSH
 0LFHB/oC7r5NmS8rvezdaqGX2+jaZs1ybK8ILWXxbmD+IDd6cmq1X8uUwnciGXVu22tSN9cG/Wq
 3KWsSiqlDjt1kXrsRDAzETo67WqYE7X7J0+Dk+trnLio0RCAhEaKImXWuOJ4x8aZLHSer9ighDu
 ehY4ZcFL1aRkV/BGAgDvHGxf4HBSJp4jzcyGx4PH1Z4ImeCyNvTgAVSr8ou9CbuRzLvWj8os9B6
 iQrDaF3OxR+AaeZ4MbstnNh0o8ZMCODMfiek2GRRBhgYfNyP/TmPzOdygh1JvY976Bp2sM74AT0
 9onIDfm5+mSUwp7qBm7f4QbxWhEtVqO8dtOseV4qykTrTeua
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Add a test which verifies that NT_ARM_SVE and NT_ARM_SSVE reads and writes
are rejected as expected when the relevant architecture feature is not
supported.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 46 +++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index a9b2377c46b8..5f39ca0b4194 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -158,6 +158,38 @@ static int set_sve(pid_t pid, const struct vec_type *type,
 	return ptrace(PTRACE_SETREGSET, pid, type->regset, &iov);
 }
 
+/* A read operation fails */
+static void read_fails(pid_t child, const struct vec_type *type)
+{
+	struct user_sve_header *new_sve = NULL;
+	size_t new_sve_size = 0;
+	void *ret;
+
+	ret = get_sve(child, type, (void **)&new_sve, &new_sve_size);
+
+	ksft_test_result(ret == NULL, "%s unsupported read fails\n",
+			 type->name);
+
+	free(new_sve);
+}
+
+/* A write operation fails */
+static void write_fails(pid_t child, const struct vec_type *type)
+{
+	struct user_sve_header sve;
+	int ret;
+
+	/* Just the header, no data */
+	memset(&sve, 0, sizeof(sve));
+	sve.size = sizeof(sve);
+	sve.flags = SVE_PT_REGS_SVE;
+	sve.vl = SVE_VL_MIN;
+	ret = set_sve(child, type, &sve);
+
+	ksft_test_result(ret != 0, "%s unsupported write fails\n",
+			 type->name);
+}
+
 /* Validate setting and getting the inherit flag */
 static void ptrace_set_get_inherit(pid_t child, const struct vec_type *type)
 {
@@ -702,6 +734,20 @@ static int do_parent(pid_t child)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(vec_types); i++) {
+		/*
+		 * If the vector type isn't supported reads and writes
+		 * should fail.
+		 */
+		if (!(getauxval(vec_types[i].hwcap_type) & vec_types[i].hwcap)) {
+			read_fails(child, &vec_types[i]);
+			write_fails(child, &vec_types[i]);
+		} else {
+			ksft_test_result_skip("%s unsupported read fails\n",
+					      vec_types[i].name);
+			ksft_test_result_skip("%s unsupported write fails\n",
+					      vec_types[i].name);
+		}
+
 		/* FPSIMD via SVE regset */
 		if (getauxval(vec_types[i].hwcap_type) & vec_types[i].hwcap) {
 			ptrace_sve_fpsimd(child, &vec_types[i]);

-- 
2.39.5


