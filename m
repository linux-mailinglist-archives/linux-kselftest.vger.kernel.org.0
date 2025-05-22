Return-Path: <linux-kselftest+bounces-33515-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F22BAC1245
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 19:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E04617D106
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 17:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0FA1A0BCD;
	Thu, 22 May 2025 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPMm+v0C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E43E198E75;
	Thu, 22 May 2025 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747935563; cv=none; b=Nm5WZtUkFPR1Yd2rKssWYVzb2f3i9M4MP818C1rZqdQpE/V/1CUK8i62Qogs8pOQy8nVvKh6u5VqQbRWq3qmIOfaBNLRUoN5ENXW1OmyKBSAWYGMy6L3rYga7GP3VyMeK1JbtllLdZkAMD6SDZxPZMWyEwR1myLV6Oo3br0na58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747935563; c=relaxed/simple;
	bh=cHjqIjTqNNckbvYuzAVxs6zjA2YNzuxtFHwb8hivo1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lYIqPqazgZz9xuQta+Qh1XtYs9+N3JN8mf7BxiRMWY8090L5/WHtiZGgbucZTV0xEwGzRkIlsjMTiON18H8MUHcAgN2v5VZaPjxcU0qmtYB+TgweKS1gdx/xLt2PwgQULBhat4n0GnQWEBg8ASAtPOawHAyXzHL6VKP4Dfdo49M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPMm+v0C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F50C4CEF5;
	Thu, 22 May 2025 17:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747935561;
	bh=cHjqIjTqNNckbvYuzAVxs6zjA2YNzuxtFHwb8hivo1k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OPMm+v0Cnq0C5+AAGfHtutPNGqMIJn+4/l/UdX/Q2R9bl1e45NmHuqeF6fHMXyzN8
	 4e7pZRBsHnxPafCEenbO6z2uwnDjOcJLAXUwo1vKCE1Am9O99ThZB+0mXsJn2UzQIR
	 03Ss1Ic7s+QV+lcBt6VWtat59crRNvNSqV5mSBOaa/pq3dS0Kd7OXe2b0FKOXp0kB6
	 AHnaAO34cV/PJ0d9peSoSZdqRINPP1gcrSTdvrE8kc2PL4MUz4x2bhTQJu9PfAPWL+
	 y6yXSQS+HsFo+0ZQkN9Yn/eGxE1hU/OeyKUFP+oPePWcGYMznHk7vcF3w3ioA44xKb
	 zpNnubg0KoRAw==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 22 May 2025 18:38:53 +0100
Subject: [PATCH 4/4] selftests/mm: Fix test result reporting in
 gup_longterm
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-selftests-mm-cow-dedupe-v1-4-713cee2fdd6d@kernel.org>
References: <20250522-selftests-mm-cow-dedupe-v1-0-713cee2fdd6d@kernel.org>
In-Reply-To: <20250522-selftests-mm-cow-dedupe-v1-0-713cee2fdd6d@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=9917; i=broonie@kernel.org;
 h=from:subject:message-id; bh=cHjqIjTqNNckbvYuzAVxs6zjA2YNzuxtFHwb8hivo1k=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoL2E9Z3GLvXX9j/Zj6pEPY2WH14S5p6WXILcc5xZG
 LZTnACWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaC9hPQAKCRAk1otyXVSH0E1wB/
 9H9L+ofO7mB7KQHgFVq4IYJkW1aqTTPwMDZjTc/HvZmislDF7jBRyHsv5YD0/HagCbRTp6Y8lIB0G/
 lBY4iVg1uhtjIzdMepIYj6/PsyK193og0OAe7h60Au4Tznz5a/IUYLHShC4+HW4e6lXD9knCmVlGDP
 EQIGTj4fqVxKwqdU7cwGKnhjz1VGT8dbqxY3VzBLQnhwo3zP/VBtU5QQrxsxSs1t8sc7eYQDdhI8kY
 b97E0V/1Y+i9cHfkwFVBLer41yWIKysF2Ejgi+Ue45KPImIDAC1MB7LX3+a4b1WhjEbvwbXwTukvoU
 6OxbzxrOfUDfMb9pAsLD0x7nc256x1
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The kselftest framework uses the string logged when a test result is
reported as the unique identifier for a test, using it to track test
results between runs. The gup_longterm test fails to follow this
pattern, it runs a single test function repeatedly with various
parameters but each result report is a string logging an error message
which is fixed between runs.

Since the code already logs each test uniquely before it starts refactor
to also print this to a buffer, then use that name as the test result.
This isn't especially pretty but is relatively straightforward and is a
great help to tooling.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/mm/gup_longterm.c | 150 +++++++++++++++++++-----------
 1 file changed, 94 insertions(+), 56 deletions(-)

diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
index e60e62809186..f84ea97c2543 100644
--- a/tools/testing/selftests/mm/gup_longterm.c
+++ b/tools/testing/selftests/mm/gup_longterm.c
@@ -93,33 +93,48 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
 	__fsword_t fs_type = get_fs_type(fd);
 	bool should_work;
 	char *mem;
+	int result = KSFT_PASS;
 	int ret;
 
+	if (fd < 0) {
+		result = KSFT_FAIL;
+		goto report;
+	}
+
 	if (ftruncate(fd, size)) {
 		if (errno == ENOENT) {
 			skip_test_dodgy_fs("ftruncate()");
 		} else {
-			ksft_test_result_fail("ftruncate() failed (%s)\n", strerror(errno));
+			ksft_print_msg("ftruncate() failed (%s)\n",
+				       strerror(errno));
+			result = KSFT_FAIL;
+			goto report;
 		}
 		return;
 	}
 
 	if (fallocate(fd, 0, 0, size)) {
-		if (size == pagesize)
-			ksft_test_result_fail("fallocate() failed (%s)\n", strerror(errno));
-		else
-			ksft_test_result_skip("need more free huge pages\n");
-		return;
+		if (size == pagesize) {
+			ksft_print_msg("fallocate() failed (%s)\n", strerror(errno));
+			result = KSFT_FAIL;
+		} else {
+			ksft_print_msg("need more free huge pages\n");
+			result = KSFT_SKIP;
+		}
+		goto report;
 	}
 
 	mem = mmap(NULL, size, PROT_READ | PROT_WRITE,
 		   shared ? MAP_SHARED : MAP_PRIVATE, fd, 0);
 	if (mem == MAP_FAILED) {
-		if (size == pagesize || shared)
-			ksft_test_result_fail("mmap() failed (%s)\n", strerror(errno));
-		else
-			ksft_test_result_skip("need more free huge pages\n");
-		return;
+		if (size == pagesize || shared) {
+			ksft_print_msg("mmap() failed (%s)\n", strerror(errno));
+			result = KSFT_FAIL;
+		} else {
+			ksft_print_msg("need more free huge pages\n");
+			result = KSFT_SKIP;
+		}
+		goto report;
 	}
 
 	/* Fault in the page such that GUP-fast can pin it directly. */
@@ -134,7 +149,8 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
 		 */
 		ret = mprotect(mem, size, PROT_READ);
 		if (ret) {
-			ksft_test_result_fail("mprotect() failed (%s)\n", strerror(errno));
+			ksft_print_msg("mprotect() failed (%s)\n", strerror(errno));
+			result = KSFT_FAIL;
 			goto munmap;
 		}
 		/* FALLTHROUGH */
@@ -147,12 +163,14 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
 				type == TEST_TYPE_RW_FAST;
 
 		if (gup_fd < 0) {
-			ksft_test_result_skip("gup_test not available\n");
+			ksft_print_msg("gup_test not available\n");
+			result = KSFT_SKIP;
 			break;
 		}
 
 		if (rw && shared && fs_is_unknown(fs_type)) {
-			ksft_test_result_skip("Unknown filesystem\n");
+			ksft_print_msg("Unknown filesystem\n");
+			result = KSFT_SKIP;
 			return;
 		}
 		/*
@@ -169,14 +187,19 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
 		args.flags |= rw ? PIN_LONGTERM_TEST_FLAG_USE_WRITE : 0;
 		ret = ioctl(gup_fd, PIN_LONGTERM_TEST_START, &args);
 		if (ret && errno == EINVAL) {
-			ksft_test_result_skip("PIN_LONGTERM_TEST_START failed (EINVAL)n");
+			ksft_print_msg("PIN_LONGTERM_TEST_START failed (EINVAL)n");
+			result = KSFT_SKIP;
 			break;
 		} else if (ret && errno == EFAULT) {
-			ksft_test_result(!should_work, "Should have failed\n");
+			if (should_work)
+				result = KSFT_FAIL;
+			else
+				result = KSFT_PASS;
 			break;
 		} else if (ret) {
-			ksft_test_result_fail("PIN_LONGTERM_TEST_START failed (%s)\n",
-					      strerror(errno));
+			ksft_print_msg("PIN_LONGTERM_TEST_START failed (%s)\n",
+				       strerror(errno));
+			result = KSFT_FAIL;
 			break;
 		}
 
@@ -189,7 +212,10 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
 		 * some previously unsupported filesystems, we might want to
 		 * perform some additional tests for possible data corruptions.
 		 */
-		ksft_test_result(should_work, "Should have worked\n");
+		if (should_work)
+			result = KSFT_PASS;
+		else
+			result = KSFT_FAIL;
 		break;
 	}
 #ifdef LOCAL_CONFIG_HAVE_LIBURING
@@ -199,8 +225,9 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
 
 		/* io_uring always pins pages writable. */
 		if (shared && fs_is_unknown(fs_type)) {
-			ksft_test_result_skip("Unknown filesystem\n");
-			return;
+			ksft_print_msg("Unknown filesystem\n");
+			result = KSFT_SKIP;
+			goto report;
 		}
 		should_work = !shared ||
 			      fs_supports_writable_longterm_pinning(fs_type);
@@ -208,8 +235,9 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
 		/* Skip on errors, as we might just lack kernel support. */
 		ret = io_uring_queue_init(1, &ring, 0);
 		if (ret < 0) {
-			ksft_test_result_skip("io_uring_queue_init() failed (%s)\n",
-					      strerror(-ret));
+			ksft_print_msg("io_uring_queue_init() failed (%s)\n",
+				       strerror(-ret));
+			result = KSFT_SKIP;
 			break;
 		}
 		/*
@@ -222,17 +250,28 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
 		/* Only new kernels return EFAULT. */
 		if (ret && (errno == ENOSPC || errno == EOPNOTSUPP ||
 			    errno == EFAULT)) {
-			ksft_test_result(!should_work, "Should have failed (%s)\n",
-					 strerror(errno));
+			if (should_work) {
+				ksft_print_msg("Should have failed (%s)\n",
+					       strerror(errno));
+				result = KSFT_FAIL;
+			} else {
+				result = KSFT_PASS;
+			}
 		} else if (ret) {
 			/*
 			 * We might just lack support or have insufficient
 			 * MEMLOCK limits.
 			 */
-			ksft_test_result_skip("io_uring_register_buffers() failed (%s)\n",
-					      strerror(-ret));
+			ksft_print_msg("io_uring_register_buffers() failed (%s)\n",
+				       strerror(-ret));
+			result = KSFT_SKIP;
 		} else {
-			ksft_test_result(should_work, "Should have worked\n");
+			if (should_work) {
+				result = KSFT_PASS;
+			} else {
+				ksft_print_msg("Should have worked\n");
+				result = KSFT_FAIL;
+			}
 			io_uring_unregister_buffers(&ring);
 		}
 
@@ -246,6 +285,8 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
 
 munmap:
 	munmap(mem, size);
+report:
+	log_test_result(result);
 }
 
 typedef void (*test_fn)(int fd, size_t size);
@@ -254,13 +295,11 @@ static void run_with_memfd(test_fn fn, const char *desc)
 {
 	int fd;
 
-	ksft_print_msg("[RUN] %s ... with memfd\n", desc);
+	log_test_start("%s ... with memfd", desc);
 
 	fd = memfd_create("test", 0);
-	if (fd < 0) {
-		ksft_test_result_fail("memfd_create() failed (%s)\n", strerror(errno));
-		return;
-	}
+	if (fd < 0)
+		ksft_print_msg("memfd_create() failed (%s)\n", strerror(errno));
 
 	fn(fd, pagesize);
 	close(fd);
@@ -271,23 +310,23 @@ static void run_with_tmpfile(test_fn fn, const char *desc)
 	FILE *file;
 	int fd;
 
-	ksft_print_msg("[RUN] %s ... with tmpfile\n", desc);
+	log_test_start("%s ... with tmpfile", desc);
 
 	file = tmpfile();
 	if (!file) {
-		ksft_test_result_fail("tmpfile() failed (%s)\n", strerror(errno));
-		return;
-	}
-
-	fd = fileno(file);
-	if (fd < 0) {
-		ksft_test_result_fail("fileno() failed (%s)\n", strerror(errno));
-		goto close;
+		ksft_print_msg("tmpfile() failed (%s)\n", strerror(errno));
+		fd = -1;
+	} else {
+		fd = fileno(file);
+		if (fd < 0) {
+			ksft_print_msg("fileno() failed (%s)\n", strerror(errno));
+		}
 	}
 
 	fn(fd, pagesize);
-close:
-	fclose(file);
+
+	if (file)
+		fclose(file);
 }
 
 static void run_with_local_tmpfile(test_fn fn, const char *desc)
@@ -295,22 +334,22 @@ static void run_with_local_tmpfile(test_fn fn, const char *desc)
 	char filename[] = __FILE__"_tmpfile_XXXXXX";
 	int fd;
 
-	ksft_print_msg("[RUN] %s ... with local tmpfile\n", desc);
+	log_test_start("%s ... with local tmpfile", desc);
 
 	fd = mkstemp(filename);
-	if (fd < 0) {
-		ksft_test_result_fail("mkstemp() failed (%s)\n", strerror(errno));
-		return;
-	}
+	if (fd < 0)
+		ksft_print_msg("mkstemp() failed (%s)\n", strerror(errno));
 
 	if (unlink(filename)) {
-		ksft_test_result_fail("unlink() failed (%s)\n", strerror(errno));
-		goto close;
+		ksft_print_msg("unlink() failed (%s)\n", strerror(errno));
+		close(fd);
+		fd = -1;
 	}
 
 	fn(fd, pagesize);
-close:
-	close(fd);
+
+	if (fd >= 0)
+		close(fd);
 }
 
 static void run_with_memfd_hugetlb(test_fn fn, const char *desc,
@@ -319,15 +358,14 @@ static void run_with_memfd_hugetlb(test_fn fn, const char *desc,
 	int flags = MFD_HUGETLB;
 	int fd;
 
-	ksft_print_msg("[RUN] %s ... with memfd hugetlb (%zu kB)\n", desc,
+	log_test_start("%s ... with memfd hugetlb (%zu kB)", desc,
 		       hugetlbsize / 1024);
 
 	flags |= __builtin_ctzll(hugetlbsize) << MFD_HUGE_SHIFT;
 
 	fd = memfd_create("test", flags);
 	if (fd < 0) {
-		ksft_test_result_skip("memfd_create() failed (%s)\n", strerror(errno));
-		return;
+		ksft_print_msg("memfd_create() failed (%s)\n", strerror(errno));
 	}
 
 	fn(fd, hugetlbsize);

-- 
2.39.5


