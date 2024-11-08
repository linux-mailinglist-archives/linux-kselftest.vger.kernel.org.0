Return-Path: <linux-kselftest+bounces-21674-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B239B9C1E6C
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 14:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEFCA1C21A1F
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 13:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95821EF0AE;
	Fri,  8 Nov 2024 13:49:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3E01E0B66
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Nov 2024 13:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073765; cv=none; b=TPy/uGsvd/d2s3kpqtwPo1SUf/mMLSQ9N+hYG4r0vYvrcn6iC/TydrO00dnWCkl9fn4Hx2LjVSLiaJKYQvf9CrU7rlD0pJ7LsV37PY86mQh1QJ6mUYRPJ0ojP6jyIffgIKC4GEXltW3EyRx4wppKYrPRCSbnSfOdOKkWZspHaac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073765; c=relaxed/simple;
	bh=tJ4CagG0kCLicdZr6lrfKCXoz9QRktQ/nPKITTd51BA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lhAW2cQGgxCVcxTkUINkqOFKjKLuxPZmoHpiIrXfJjyGYRLzW0ve7t3XcyAR+iPPUzm6XeaUrq5uvGo7Uqh/Lx2Dw6PdHrj2N5gAirVRYa2ooDcLKN+teRjJS4oDQtGnr+qOIzMSVfsX/E+fe7Z51uf3fsrliyhv0+AIUN061u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CBAEC4CED4;
	Fri,  8 Nov 2024 13:49:24 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	Will Deacon <will@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 1/4] kselftest/arm64: Fix printf() compiler warnings in the arm64 fp tests
Date: Fri,  8 Nov 2024 13:49:17 +0000
Message-Id: <20241108134920.1233992-2-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241108134920.1233992-1-catalin.marinas@arm.com>
References: <20241108134920.1233992-1-catalin.marinas@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lots of incorrect length modifiers, missing arguments or conversion
specifiers. Fix them.

Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 16 +++++++++-------
 tools/testing/selftests/arm64/fp/za-ptrace.c  |  8 +++++---
 tools/testing/selftests/arm64/fp/zt-ptrace.c  |  8 +++++---
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index 6d61992fe8a0..577b6e05e860 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -82,10 +82,12 @@ static void fill_buf(char *buf, size_t size)
 static int do_child(void)
 {
 	if (ptrace(PTRACE_TRACEME, -1, NULL, NULL))
-		ksft_exit_fail_msg("PTRACE_TRACEME", strerror(errno));
+		ksft_exit_fail_msg("ptrace(PTRACE_TRACEME) failed: %s (%d)\n",
+				   strerror(errno), errno);
 
 	if (raise(SIGSTOP))
-		ksft_exit_fail_msg("raise(SIGSTOP)", strerror(errno));
+		ksft_exit_fail_msg("raise(SIGSTOP) failed: %s (%d)\n",
+				   strerror(errno), errno);
 
 	return EXIT_SUCCESS;
 }
@@ -340,7 +342,7 @@ static void ptrace_set_sve_get_sve_data(pid_t child,
 	data_size = SVE_PT_SVE_OFFSET + SVE_PT_SVE_SIZE(vq, SVE_PT_REGS_SVE);
 	write_buf = malloc(data_size);
 	if (!write_buf) {
-		ksft_test_result_fail("Error allocating %d byte buffer for %s VL %u\n",
+		ksft_test_result_fail("Error allocating %ld byte buffer for %s VL %u\n",
 				      data_size, type->name, vl);
 		return;
 	}
@@ -441,7 +443,7 @@ static void ptrace_set_sve_get_fpsimd_data(pid_t child,
 	data_size = SVE_PT_SVE_OFFSET + SVE_PT_SVE_SIZE(vq, SVE_PT_REGS_SVE);
 	write_buf = malloc(data_size);
 	if (!write_buf) {
-		ksft_test_result_fail("Error allocating %d byte buffer for %s VL %u\n",
+		ksft_test_result_fail("Error allocating %ld byte buffer for %s VL %u\n",
 				      data_size, type->name, vl);
 		return;
 	}
@@ -545,7 +547,7 @@ static void ptrace_set_fpsimd_get_sve_data(pid_t child,
 	read_sve = read_buf;
 
 	if (read_sve->vl != vl) {
-		ksft_test_result_fail("Child VL != expected VL %d\n",
+		ksft_test_result_fail("Child VL != expected VL: %u != %u\n",
 				      read_sve->vl, vl);
 		goto out;
 	}
@@ -555,7 +557,7 @@ static void ptrace_set_fpsimd_get_sve_data(pid_t child,
 	case SVE_PT_REGS_FPSIMD:
 		expected_size = SVE_PT_FPSIMD_SIZE(vq, SVE_PT_REGS_FPSIMD);
 		if (read_sve_size < expected_size) {
-			ksft_test_result_fail("Read %d bytes, expected %d\n",
+			ksft_test_result_fail("Read %ld bytes, expected %ld\n",
 					      read_sve_size, expected_size);
 			goto out;
 		}
@@ -571,7 +573,7 @@ static void ptrace_set_fpsimd_get_sve_data(pid_t child,
 	case SVE_PT_REGS_SVE:
 		expected_size = SVE_PT_SVE_SIZE(vq, SVE_PT_REGS_SVE);
 		if (read_sve_size < expected_size) {
-			ksft_test_result_fail("Read %d bytes, expected %d\n",
+			ksft_test_result_fail("Read %ld bytes, expected %ld\n",
 					      read_sve_size, expected_size);
 			goto out;
 		}
diff --git a/tools/testing/selftests/arm64/fp/za-ptrace.c b/tools/testing/selftests/arm64/fp/za-ptrace.c
index ac27d87396fc..08c777f87ea2 100644
--- a/tools/testing/selftests/arm64/fp/za-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/za-ptrace.c
@@ -48,10 +48,12 @@ static void fill_buf(char *buf, size_t size)
 static int do_child(void)
 {
 	if (ptrace(PTRACE_TRACEME, -1, NULL, NULL))
-		ksft_exit_fail_msg("PTRACE_TRACEME", strerror(errno));
+		ksft_exit_fail_msg("ptrace(PTRACE_TRACEME) failed: %s (%d)",
+				   strerror(errno), errno);
 
 	if (raise(SIGSTOP))
-		ksft_exit_fail_msg("raise(SIGSTOP)", strerror(errno));
+		ksft_exit_fail_msg("raise(SIGSTOP) failed: %s (%d)\n",
+				   strerror(errno), errno);
 
 	return EXIT_SUCCESS;
 }
@@ -201,7 +203,7 @@ static void ptrace_set_get_data(pid_t child, unsigned int vl)
 	data_size = ZA_PT_SIZE(vq);
 	write_buf = malloc(data_size);
 	if (!write_buf) {
-		ksft_test_result_fail("Error allocating %d byte buffer for VL %u\n",
+		ksft_test_result_fail("Error allocating %ld byte buffer for VL %u\n",
 				      data_size, vl);
 		return;
 	}
diff --git a/tools/testing/selftests/arm64/fp/zt-ptrace.c b/tools/testing/selftests/arm64/fp/zt-ptrace.c
index 996d9614a131..584b8d59b7ea 100644
--- a/tools/testing/selftests/arm64/fp/zt-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/zt-ptrace.c
@@ -43,10 +43,12 @@ static void fill_buf(char *buf, size_t size)
 static int do_child(void)
 {
 	if (ptrace(PTRACE_TRACEME, -1, NULL, NULL))
-		ksft_exit_fail_msg("PTRACE_TRACEME", strerror(errno));
+		ksft_exit_fail_msg("ptrace(PTRACE_TRACEME) failed: %s (%d)\n",
+				   strerror(errno), errno);
 
 	if (raise(SIGSTOP))
-		ksft_exit_fail_msg("raise(SIGSTOP)", strerror(errno));
+		ksft_exit_fail_msg("raise(SIGSTOP) failed: %s (%d)\n",
+				   strerror(errno), errno);
 
 	return EXIT_SUCCESS;
 }
@@ -231,7 +233,7 @@ static void ptrace_enable_za_via_zt(pid_t child)
 		/* Should have register data */
 		if (za_out->size < ZA_PT_SIZE(vq)) {
 			ksft_print_msg("ZA data less than expected: %u < %u\n",
-				       za_out->size, ZA_PT_SIZE(vq));
+				       za_out->size, (unsigned int)ZA_PT_SIZE(vq));
 			fail = true;
 			vq = 0;
 		}

