Return-Path: <linux-kselftest+bounces-49236-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F96D38E6B
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 13:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A897330194DF
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 12:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0AE30DEBA;
	Sat, 17 Jan 2026 12:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="AC8x14DE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422F62FDC3C;
	Sat, 17 Jan 2026 12:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768651859; cv=none; b=crQxMDsLBnGNz4AGfR0YPx1YZqa/N8TBXEz9wVpc36AKbj2dZjpMoG1VrnOienxuc+leougD0D2vQtg9u/PzQY0+7arcuTOkLWDTkMCoLaVX0WTazBVsB89E4T60hoGhLEKz2371sWbVuqfAPqweEUengeC8H9N+QQbMg20r1lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768651859; c=relaxed/simple;
	bh=xV++OX5BruJPiGUB+6BtsUIpwLf98Tp7WflSyeVyANw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jghvEhXaeNtDiQ77VChZR7wZfTyYO1BlXhj4/3UIuOrWRIBIzTAy1NCSEQyNPq/BvGFGDkYOMC0GI8eext3iFPuKJl63+nr0tVERGIRhkLZGqlKEMLfyhBwixXJRKZ5Bq1/gYUYfyQs7bDo8XXsB9Mc2vNY5AcMFqquRU+u3hFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=AC8x14DE; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1768651856;
	bh=xV++OX5BruJPiGUB+6BtsUIpwLf98Tp7WflSyeVyANw=;
	h=From:Date:Subject:To:Cc:From;
	b=AC8x14DEnUIOTHuVlIaPow5UJBc7qm85ukk3aR536MgBtgFdb18tS7k/KwW+4jjIs
	 NuMM1uPIxz8O52L44JEC1Fl7wofWQsfblw2WUu5jIMdEfhLdoDYN3daRxdJvuUJzp4
	 4+MTSPzoRu3D3aDRTdduejnG5+Pvlw0hw6fFfehk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 17 Jan 2026 13:10:51 +0100
Subject: [PATCH] kselftest/arm64: Use syscall() macro over nolibc
 my_syscall()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260117-nolibc-mysyscall-arm64-v1-1-f70266a3db15@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQrDIBBA0auEWWcgWlHoVUoXE520A8YUB0KC5
 O6VLN/i/wbKVVjhOTSovIvKVjrMOED8UvkwSuoGO1k/GROwbFnmiOupp0bKGamu3qFjitY90hw
 SQY9/lRc57vHrfV1/RnlZI2gAAAA=
X-Change-ID: 20260117-nolibc-mysyscall-arm64-4eac243db7da
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768651855; l=5998;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=xV++OX5BruJPiGUB+6BtsUIpwLf98Tp7WflSyeVyANw=;
 b=92OTViQiCo/kZDfONPWVG9BjDJR6sqNznXHJze+SrWLwBb76kdsRzaRZc1xd4FxCvACQ8BtTE
 zPOxwnTPOcCD03KruZdxU5rBlura12YKcni+DCKnZIrqQVnztqQIbGb
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The my_syscall*() macros are internal implementation details of nolibc.
Nolibc also provides the regular syscall(2), which is also a macro
and directly expands to the correct my_syscall().

Use syscall() instead.

As a side-effect this fixes some return value checks, as my_syscall()
returns the raw value as set by the kernel and does not set errno.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Compile-tested only.
For the arm64 tree.

I want to rename those macros at some point.
---
 tools/testing/selftests/arm64/abi/tpidr2.c    |  3 +-
 tools/testing/selftests/arm64/gcs/basic-gcs.c | 40 +++++++++++----------------
 2 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/arm64/abi/tpidr2.c b/tools/testing/selftests/arm64/abi/tpidr2.c
index 1703543fb7c7..ce4550fb7224 100644
--- a/tools/testing/selftests/arm64/abi/tpidr2.c
+++ b/tools/testing/selftests/arm64/abi/tpidr2.c
@@ -128,8 +128,7 @@ static int sys_clone(unsigned long clone_flags, unsigned long newsp,
 		     int *parent_tidptr, unsigned long tls,
 		     int *child_tidptr)
 {
-	return my_syscall5(__NR_clone, clone_flags, newsp, parent_tidptr, tls,
-			   child_tidptr);
+	return syscall(__NR_clone, clone_flags, newsp, parent_tidptr, tls, child_tidptr);
 }
 
 #define __STACK_SIZE (8 * 1024 * 1024)
diff --git a/tools/testing/selftests/arm64/gcs/basic-gcs.c b/tools/testing/selftests/arm64/gcs/basic-gcs.c
index 250977abc398..ae4cce6afe2b 100644
--- a/tools/testing/selftests/arm64/gcs/basic-gcs.c
+++ b/tools/testing/selftests/arm64/gcs/basic-gcs.c
@@ -22,7 +22,7 @@ static size_t page_size = 65536;
 static  __attribute__((noinline)) void valid_gcs_function(void)
 {
 	/* Do something the compiler can't optimise out */
-	my_syscall1(__NR_prctl, PR_SVE_GET_VL);
+	syscall(__NR_prctl, PR_SVE_GET_VL);
 }
 
 static inline int gcs_set_status(unsigned long mode)
@@ -36,12 +36,10 @@ static inline int gcs_set_status(unsigned long mode)
 	 * other 3 values passed in registers to the syscall are zero
 	 * since the kernel validates them.
 	 */
-	ret = my_syscall5(__NR_prctl, PR_SET_SHADOW_STACK_STATUS, mode,
-			  0, 0, 0);
+	ret = syscall(__NR_prctl, PR_SET_SHADOW_STACK_STATUS, mode, 0, 0, 0);
 
 	if (ret == 0) {
-		ret = my_syscall5(__NR_prctl, PR_GET_SHADOW_STACK_STATUS,
-				  &new_mode, 0, 0, 0);
+		ret = syscall(__NR_prctl, PR_GET_SHADOW_STACK_STATUS, &new_mode, 0, 0, 0);
 		if (ret == 0) {
 			if (new_mode != mode) {
 				ksft_print_msg("Mode set to %lx not %lx\n",
@@ -49,7 +47,7 @@ static inline int gcs_set_status(unsigned long mode)
 				ret = -EINVAL;
 			}
 		} else {
-			ksft_print_msg("Failed to validate mode: %d\n", ret);
+			ksft_print_msg("Failed to validate mode: %d\n", errno);
 		}
 
 		if (enabling != chkfeat_gcs()) {
@@ -69,10 +67,9 @@ static bool read_status(void)
 	unsigned long state;
 	int ret;
 
-	ret = my_syscall5(__NR_prctl, PR_GET_SHADOW_STACK_STATUS,
-			  &state, 0, 0, 0);
+	ret = syscall(__NR_prctl, PR_GET_SHADOW_STACK_STATUS, &state, 0, 0, 0);
 	if (ret != 0) {
-		ksft_print_msg("Failed to read state: %d\n", ret);
+		ksft_print_msg("Failed to read state: %d\n", errno);
 		return false;
 	}
 
@@ -188,9 +185,8 @@ static bool map_guarded_stack(void)
 	int elem;
 	bool pass = true;
 
-	buf = (void *)my_syscall3(__NR_map_shadow_stack, 0, page_size,
-				  SHADOW_STACK_SET_MARKER |
-				  SHADOW_STACK_SET_TOKEN);
+	buf = (void *)syscall(__NR_map_shadow_stack, 0, page_size,
+			      SHADOW_STACK_SET_MARKER | SHADOW_STACK_SET_TOKEN);
 	if (buf == MAP_FAILED) {
 		ksft_print_msg("Failed to map %lu byte GCS: %d\n",
 			       page_size, errno);
@@ -257,8 +253,7 @@ static bool test_fork(void)
 		valid_gcs_function();
 		get_gcspr();
 
-		ret = my_syscall5(__NR_prctl, PR_GET_SHADOW_STACK_STATUS,
-				  &child_mode, 0, 0, 0);
+		ret = syscall(__NR_prctl, PR_GET_SHADOW_STACK_STATUS, &child_mode, 0, 0, 0);
 		if (ret == 0 && !(child_mode & PR_SHADOW_STACK_ENABLE)) {
 			ksft_print_msg("GCS not enabled in child\n");
 			ret = -EINVAL;
@@ -321,8 +316,7 @@ static bool test_vfork(void)
 		valid_gcs_function();
 		get_gcspr();
 
-		ret = my_syscall5(__NR_prctl, PR_GET_SHADOW_STACK_STATUS,
-				  &child_mode, 0, 0, 0);
+		ret = syscall(__NR_prctl, PR_GET_SHADOW_STACK_STATUS, &child_mode, 0, 0, 0);
 		if (ret == 0 && !(child_mode & PR_SHADOW_STACK_ENABLE)) {
 			ksft_print_msg("GCS not enabled in child\n");
 			ret = EXIT_FAILURE;
@@ -390,17 +384,15 @@ int main(void)
 	if (!(getauxval(AT_HWCAP) & HWCAP_GCS))
 		ksft_exit_skip("SKIP GCS not supported\n");
 
-	ret = my_syscall5(__NR_prctl, PR_GET_SHADOW_STACK_STATUS,
-			  &gcs_mode, 0, 0, 0);
+	ret = syscall(__NR_prctl, PR_GET_SHADOW_STACK_STATUS, &gcs_mode, 0, 0, 0);
 	if (ret != 0)
-		ksft_exit_fail_msg("Failed to read GCS state: %d\n", ret);
+		ksft_exit_fail_msg("Failed to read GCS state: %d\n", errno);
 
 	if (!(gcs_mode & PR_SHADOW_STACK_ENABLE)) {
 		gcs_mode = PR_SHADOW_STACK_ENABLE;
-		ret = my_syscall5(__NR_prctl, PR_SET_SHADOW_STACK_STATUS,
-				  gcs_mode, 0, 0, 0);
+		ret = syscall(__NR_prctl, PR_SET_SHADOW_STACK_STATUS, gcs_mode, 0, 0, 0);
 		if (ret != 0)
-			ksft_exit_fail_msg("Failed to enable GCS: %d\n", ret);
+			ksft_exit_fail_msg("Failed to enable GCS: %d\n", errno);
 	}
 
 	ksft_set_plan(ARRAY_SIZE(tests));
@@ -410,9 +402,9 @@ int main(void)
 	}
 
 	/* One last test: disable GCS, we can do this one time */
-	ret = my_syscall5(__NR_prctl, PR_SET_SHADOW_STACK_STATUS, 0, 0, 0, 0);
+	ret = syscall(__NR_prctl, PR_SET_SHADOW_STACK_STATUS, 0, 0, 0, 0);
 	if (ret != 0)
-		ksft_print_msg("Failed to disable GCS: %d\n", ret);
+		ksft_print_msg("Failed to disable GCS: %d\n", errno);
 
 	ksft_finished();
 

---
base-commit: db81cecbeb215e764413dfc25489c30220f7241c
change-id: 20260117-nolibc-mysyscall-arm64-4eac243db7da

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


