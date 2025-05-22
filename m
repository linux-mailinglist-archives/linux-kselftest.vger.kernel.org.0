Return-Path: <linux-kselftest+bounces-33514-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50590AC1243
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 19:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E552417E102
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 17:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF46719F11F;
	Thu, 22 May 2025 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzvtsMUI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8775817C21B;
	Thu, 22 May 2025 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747935559; cv=none; b=bIlazzd+GSOK+gIaSeEzDelMgUnZ/dPTeqIUBHQ03HsApuqCX70xWOXvMxntiCeFR0i1/+rpKXtwkXEyxIMlz6CraUzaHBj33BO8H3u9YsZQ8KSwEUOZVPnAxiVrbccTiRjN1nrshqADKVrnTZKSgAx3pG8hiMX8edkF8LdTfYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747935559; c=relaxed/simple;
	bh=a4C7vo5a8gu9Tr4FRKWkna3ydJ9IfFuiXanLHBA+sJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CZERVfEY4ie0UQgJGII2xqwxKdVMYrY6LrA+lqEunwawaWdGW7E4kjk5UvF8AQNNVloeynEMsl6QjhoPFLxwhoGLUDuQTqaLSjXnapUIXSYWdjBA4xr1NxlTysbhhs3xZVtEgse9Lo24n4/q7hbl/AE+RpzWRDP+8jwVQ0Bm8uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzvtsMUI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5798AC4CEEA;
	Thu, 22 May 2025 17:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747935559;
	bh=a4C7vo5a8gu9Tr4FRKWkna3ydJ9IfFuiXanLHBA+sJQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PzvtsMUIX6KihaWf+v0D8lbfplKlxh+lMnBy7iFQY4UO/kpNZOIWmXYSNNI6F1mO1
	 c8zVRfiVCrAyktL9tcwd5SBkn005PgEFzqLpcGXwmjhwRe8x20RaPVCNfWCgyTVWC3
	 a3D1hI1tFAgmdIBsqgU9XbSjqzEX9j3JinAluBtu6IaidROWAjiV1iyxJN9pVDaM4J
	 O2kWESznbO/CXnZlP74na6CiBe7jploFSCwYCN4W+JFY+HH8iYgiRV7p82ibp8iAQb
	 T7vnc1fX3XOms50MeQlpfmjymfXCatnk8vXbURQFVgKj3Of/PGepPuiQ8O+UDJ+LIV
	 yuBDbrPH0luHA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 22 May 2025 18:38:52 +0100
Subject: [PATCH 3/4] selftests/mm: Report unique test names for each cow
 test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-selftests-mm-cow-dedupe-v1-3-713cee2fdd6d@kernel.org>
References: <20250522-selftests-mm-cow-dedupe-v1-0-713cee2fdd6d@kernel.org>
In-Reply-To: <20250522-selftests-mm-cow-dedupe-v1-0-713cee2fdd6d@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=32876; i=broonie@kernel.org;
 h=from:subject:message-id; bh=a4C7vo5a8gu9Tr4FRKWkna3ydJ9IfFuiXanLHBA+sJQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoL2E8bQI0SrOgleTojDQl9loG25ciShrnczqlLbvr
 D9lidvyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaC9hPAAKCRAk1otyXVSH0JVQB/
 0Ue6h7fsQUXETXjxBaVWCR2gz4De7hXxLQpL3SLtY9FKQFkzl4MfzDy+FQJ6zV8nmx9SkgPGI9TsOx
 pW1py6O8jifGTvBxC7t17kNR42qrVrAnPi6CKGD1EmvLw5WK1lObmutcn11eKBN3un0KPFXbA6T4Mx
 d4YVEx+DlmSWnccmOXsZclBvZ7ySk70X3yVPkll6/U4hHpLOGRnLon+MYiAQA12VxJ51SBv/Lrpef6
 JtP1Wqd96TwMphkfZ204Uicp0UiG72AzP59XYmZdTa31QioJ2plyVy7fBVrBU3J74qlnDoh4qccihN
 3jH2HxVmaeVRrJj4ufb8b2DFWZG33+
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The kselftest framework uses the string logged when a test result is
reported as the unique identifier for a test, using it to track test
results between runs. The cow test completely fails to follow this pattern,
it runs test functions repeatedly with various parameters with each result
report from those functions being a string logging an error message which
is fixed between runs.

Since the code already logs each test uniquely before it starts refactor
to also print this to a buffer, then use that name as the test result.
This isn't especially pretty but is relatively straightforward and is a
great help to tooling.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/mm/cow.c | 333 +++++++++++++++++++++++++--------------
 1 file changed, 217 insertions(+), 116 deletions(-)

diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index e70cd3d900cc..a97f5ef79f17 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -112,9 +112,12 @@ struct comm_pipes {
 
 static int setup_comm_pipes(struct comm_pipes *comm_pipes)
 {
-	if (pipe(comm_pipes->child_ready) < 0)
+	if (pipe(comm_pipes->child_ready) < 0) {
+		ksft_perror("pipe()");
 		return -errno;
+	}
 	if (pipe(comm_pipes->parent_ready) < 0) {
+		ksft_perror("pipe()");
 		close(comm_pipes->child_ready[0]);
 		close(comm_pipes->child_ready[1]);
 		return -errno;
@@ -207,13 +210,14 @@ static void do_test_cow_in_parent(char *mem, size_t size, bool do_mprotect,
 
 	ret = setup_comm_pipes(&comm_pipes);
 	if (ret) {
-		ksft_test_result_fail("pipe() failed\n");
+		log_test_result(KSFT_FAIL);
 		return;
 	}
 
 	ret = fork();
 	if (ret < 0) {
-		ksft_test_result_fail("fork() failed\n");
+		ksft_perror("fork() failed");
+		log_test_result(KSFT_FAIL);
 		goto close_comm_pipes;
 	} else if (!ret) {
 		exit(fn(mem, size, &comm_pipes));
@@ -228,9 +232,18 @@ static void do_test_cow_in_parent(char *mem, size_t size, bool do_mprotect,
 		 * write-faults by directly mapping pages writable.
 		 */
 		ret = mprotect(mem, size, PROT_READ);
-		ret |= mprotect(mem, size, PROT_READ|PROT_WRITE);
 		if (ret) {
-			ksft_test_result_fail("mprotect() failed\n");
+			ksft_perror("mprotect() failed");
+			log_test_result(KSFT_FAIL);
+			write(comm_pipes.parent_ready[1], "0", 1);
+			wait(&ret);
+			goto close_comm_pipes;
+		}
+
+		ret = mprotect(mem, size, PROT_READ|PROT_WRITE);
+		if (ret) {
+			ksft_perror("mprotect() failed");
+			log_test_result(KSFT_FAIL);
 			write(comm_pipes.parent_ready[1], "0", 1);
 			wait(&ret);
 			goto close_comm_pipes;
@@ -248,16 +261,16 @@ static void do_test_cow_in_parent(char *mem, size_t size, bool do_mprotect,
 		ret = -EINVAL;
 
 	if (!ret) {
-		ksft_test_result_pass("No leak from parent into child\n");
+		log_test_result(KSFT_PASS);
 	} else if (xfail) {
 		/*
 		 * With hugetlb, some vmsplice() tests are currently expected to
 		 * fail because (a) harder to fix and (b) nobody really cares.
 		 * Flag them as expected failure for now.
 		 */
-		ksft_test_result_xfail("Leak from parent into child\n");
+		log_test_result(KSFT_XFAIL);
 	} else {
-		ksft_test_result_fail("Leak from parent into child\n");
+		log_test_result(KSFT_FAIL);
 	}
 close_comm_pipes:
 	close_comm_pipes(&comm_pipes);
@@ -306,26 +319,29 @@ static void do_test_vmsplice_in_parent(char *mem, size_t size,
 
 	ret = setup_comm_pipes(&comm_pipes);
 	if (ret) {
-		ksft_test_result_fail("pipe() failed\n");
+		log_test_result(KSFT_FAIL);
 		goto free;
 	}
 
 	if (pipe(fds) < 0) {
-		ksft_test_result_fail("pipe() failed\n");
+		ksft_perror("pipe() failed");
+		log_test_result(KSFT_FAIL);
 		goto close_comm_pipes;
 	}
 
 	if (before_fork) {
 		transferred = vmsplice(fds[1], &iov, 1, 0);
 		if (transferred <= 0) {
-			ksft_test_result_fail("vmsplice() failed\n");
+			ksft_print_msg("vmsplice() failed\n");
+			log_test_result(KSFT_FAIL);
 			goto close_pipe;
 		}
 	}
 
 	ret = fork();
 	if (ret < 0) {
-		ksft_test_result_fail("fork() failed\n");
+		ksft_perror("fork() failed\n");
+		log_test_result(KSFT_FAIL);
 		goto close_pipe;
 	} else if (!ret) {
 		write(comm_pipes.child_ready[1], "0", 1);
@@ -339,7 +355,8 @@ static void do_test_vmsplice_in_parent(char *mem, size_t size,
 	if (!before_fork) {
 		transferred = vmsplice(fds[1], &iov, 1, 0);
 		if (transferred <= 0) {
-			ksft_test_result_fail("vmsplice() failed\n");
+			ksft_perror("vmsplice() failed");
+			log_test_result(KSFT_FAIL);
 			wait(&ret);
 			goto close_pipe;
 		}
@@ -348,7 +365,8 @@ static void do_test_vmsplice_in_parent(char *mem, size_t size,
 	while (read(comm_pipes.child_ready[0], &buf, 1) != 1)
 		;
 	if (munmap(mem, size) < 0) {
-		ksft_test_result_fail("munmap() failed\n");
+		ksft_perror("munmap() failed");
+		log_test_result(KSFT_FAIL);
 		goto close_pipe;
 	}
 	write(comm_pipes.parent_ready[1], "0", 1);
@@ -356,7 +374,8 @@ static void do_test_vmsplice_in_parent(char *mem, size_t size,
 	/* Wait until the child is done writing. */
 	wait(&ret);
 	if (!WIFEXITED(ret)) {
-		ksft_test_result_fail("wait() failed\n");
+		ksft_perror("wait() failed");
+		log_test_result(KSFT_FAIL);
 		goto close_pipe;
 	}
 
@@ -364,22 +383,23 @@ static void do_test_vmsplice_in_parent(char *mem, size_t size,
 	for (total = 0; total < transferred; total += cur) {
 		cur = read(fds[0], new + total, transferred - total);
 		if (cur < 0) {
-			ksft_test_result_fail("read() failed\n");
+			ksft_perror("read() failed");
+			log_test_result(KSFT_FAIL);
 			goto close_pipe;
 		}
 	}
 
 	if (!memcmp(old, new, transferred)) {
-		ksft_test_result_pass("No leak from child into parent\n");
+		log_test_result(KSFT_PASS);
 	} else if (xfail) {
 		/*
 		 * With hugetlb, some vmsplice() tests are currently expected to
 		 * fail because (a) harder to fix and (b) nobody really cares.
 		 * Flag them as expected failure for now.
 		 */
-		ksft_test_result_xfail("Leak from child into parent\n");
+		log_test_result(KSFT_XFAIL);
 	} else {
-		ksft_test_result_fail("Leak from child into parent\n");
+		log_test_result(KSFT_FAIL);
 	}
 close_pipe:
 	close(fds[0]);
@@ -416,13 +436,14 @@ static void do_test_iouring(char *mem, size_t size, bool use_fork)
 
 	ret = setup_comm_pipes(&comm_pipes);
 	if (ret) {
-		ksft_test_result_fail("pipe() failed\n");
+		log_test_result(KAFT_FAIL);
 		return;
 	}
 
 	file = tmpfile();
 	if (!file) {
-		ksft_test_result_fail("tmpfile() failed\n");
+		ksft_perror("tmpfile() failed");
+		log_test_result(KSFT_FAIL);
 		goto close_comm_pipes;
 	}
 	fd = fileno(file);
@@ -430,14 +451,16 @@ static void do_test_iouring(char *mem, size_t size, bool use_fork)
 
 	tmp = malloc(size);
 	if (!tmp) {
-		ksft_test_result_fail("malloc() failed\n");
+		ksft_pring_msg("malloc() failed\n");
+		log_test_result(KSFT_FAIL);
 		goto close_file;
 	}
 
 	/* Skip on errors, as we might just lack kernel support. */
 	ret = io_uring_queue_init(1, &ring, 0);
 	if (ret < 0) {
-		ksft_test_result_skip("io_uring_queue_init() failed\n");
+		ksft_print_msg("io_uring_queue_init() failed\n");
+		log_test_result(KSFT_SKIP);
 		goto free_tmp;
 	}
 
@@ -452,7 +475,8 @@ static void do_test_iouring(char *mem, size_t size, bool use_fork)
 	iov.iov_len = size;
 	ret = io_uring_register_buffers(&ring, &iov, 1);
 	if (ret) {
-		ksft_test_result_skip("io_uring_register_buffers() failed\n");
+		ksft_print_msg("io_uring_register_buffers() failed\n");
+		log_test_result(KSFT_SKIP);
 		goto queue_exit;
 	}
 
@@ -463,7 +487,8 @@ static void do_test_iouring(char *mem, size_t size, bool use_fork)
 		 */
 		ret = fork();
 		if (ret < 0) {
-			ksft_test_result_fail("fork() failed\n");
+			ksft_perror("fork() failed");
+			log_test_result(KSFT_FAIL);
 			goto unregister_buffers;
 		} else if (!ret) {
 			write(comm_pipes.child_ready[1], "0", 1);
@@ -483,10 +508,17 @@ static void do_test_iouring(char *mem, size_t size, bool use_fork)
 		 * if the page is mapped R/O vs. R/W).
 		 */
 		ret = mprotect(mem, size, PROT_READ);
+		if (ret) {
+			ksft_perror("mprotect() failed");
+			log_test_result(KSFT_FAIL);
+			goto unregister_buffers;
+		}
+
 		clear_softdirty();
-		ret |= mprotect(mem, size, PROT_READ | PROT_WRITE);
+		ret = mprotect(mem, size, PROT_READ | PROT_WRITE);
 		if (ret) {
-			ksft_test_result_fail("mprotect() failed\n");
+			ksft_perror("mprotect() failed");
+			log_test_result(KSFT_FAIL);
 			goto unregister_buffers;
 		}
 	}
@@ -498,25 +530,29 @@ static void do_test_iouring(char *mem, size_t size, bool use_fork)
 	memset(mem, 0xff, size);
 	sqe = io_uring_get_sqe(&ring);
 	if (!sqe) {
-		ksft_test_result_fail("io_uring_get_sqe() failed\n");
+		ksft_print_msg("io_uring_get_sqe() failed\n");
+		log_test_result(KSFT_FAIL);
 		goto quit_child;
 	}
 	io_uring_prep_write_fixed(sqe, fd, mem, size, 0, 0);
 
 	ret = io_uring_submit(&ring);
 	if (ret < 0) {
-		ksft_test_result_fail("io_uring_submit() failed\n");
+		ksft_print_msg("io_uring_submit() failed\n");
+		log_test_result(KSFT_FAIL);
 		goto quit_child;
 	}
 
 	ret = io_uring_wait_cqe(&ring, &cqe);
 	if (ret < 0) {
-		ksft_test_result_fail("io_uring_wait_cqe() failed\n");
+		ksft_print_msg("io_uring_wait_cqe() failed\n");
+		log_test_result(KSFT_FAIL);
 		goto quit_child;
 	}
 
 	if (cqe->res != size) {
-		ksft_test_result_fail("write_fixed failed\n");
+		ksft_print_msg("write_fixed failed\n");
+		log_test_result(KSFT_FAIL);
 		goto quit_child;
 	}
 	io_uring_cqe_seen(&ring, cqe);
@@ -526,15 +562,18 @@ static void do_test_iouring(char *mem, size_t size, bool use_fork)
 	while (total < size) {
 		cur = pread(fd, tmp + total, size - total, total);
 		if (cur < 0) {
-			ksft_test_result_fail("pread() failed\n");
+			ksft_print_msg("pread() failed\n");
+			log_test_result(KSFT_FAIL);
 			goto quit_child;
 		}
 		total += cur;
 	}
 
 	/* Finally, check if we read what we expected. */
-	ksft_test_result(!memcmp(mem, tmp, size),
-			 "Longterm R/W pin is reliable\n");
+	if (!memcmp(mem, tmp, size))
+		log_test_result(KSFT_PASS);
+	else
+		log_test_result(KSFT_FAIL);
 
 quit_child:
 	if (use_fork) {
@@ -582,19 +621,21 @@ static void do_test_ro_pin(char *mem, size_t size, enum ro_pin_test test,
 	int ret;
 
 	if (gup_fd < 0) {
-		ksft_test_result_skip("gup_test not available\n");
+		ksft_print_msg("gup_test not available\n");
+		log_test_result(KSFT_SKIP);
 		return;
 	}
 
 	tmp = malloc(size);
 	if (!tmp) {
-		ksft_test_result_fail("malloc() failed\n");
+		ksft_print_msg("malloc() failed\n");
+		log_test_result(KSFT_FAIL);
 		return;
 	}
 
 	ret = setup_comm_pipes(&comm_pipes);
 	if (ret) {
-		ksft_test_result_fail("pipe() failed\n");
+		log_test_result(KSFT_FAIL);
 		goto free_tmp;
 	}
 
@@ -609,7 +650,8 @@ static void do_test_ro_pin(char *mem, size_t size, enum ro_pin_test test,
 		 */
 		ret = fork();
 		if (ret < 0) {
-			ksft_test_result_fail("fork() failed\n");
+			ksft_perror("fork() failed");
+			log_test_result(KSFT_FAIL);
 			goto close_comm_pipes;
 		} else if (!ret) {
 			write(comm_pipes.child_ready[1], "0", 1);
@@ -646,7 +688,8 @@ static void do_test_ro_pin(char *mem, size_t size, enum ro_pin_test test,
 		clear_softdirty();
 		ret |= mprotect(mem, size, PROT_READ | PROT_WRITE);
 		if (ret) {
-			ksft_test_result_fail("mprotect() failed\n");
+			ksft_perror("mprotect() failed");
+			log_test_result(KSFT_FAIL);
 			goto close_comm_pipes;
 		}
 		break;
@@ -661,9 +704,11 @@ static void do_test_ro_pin(char *mem, size_t size, enum ro_pin_test test,
 	ret = ioctl(gup_fd, PIN_LONGTERM_TEST_START, &args);
 	if (ret) {
 		if (errno == EINVAL)
-			ksft_test_result_skip("PIN_LONGTERM_TEST_START failed\n");
+			ret = KSFT_SKIP;
 		else
-			ksft_test_result_fail("PIN_LONGTERM_TEST_START failed\n");
+			ret = KSFT_FAIL;
+		ksft_perror("PIN_LONGTERM_TEST_START failed");
+		log_test_result(ret);
 		goto wait;
 	}
 
@@ -676,22 +721,26 @@ static void do_test_ro_pin(char *mem, size_t size, enum ro_pin_test test,
 	 */
 	tmp_val = (__u64)(uintptr_t)tmp;
 	ret = ioctl(gup_fd, PIN_LONGTERM_TEST_READ, &tmp_val);
-	if (ret)
-		ksft_test_result_fail("PIN_LONGTERM_TEST_READ failed\n");
-	else
-		ksft_test_result(!memcmp(mem, tmp, size),
-				 "Longterm R/O pin is reliable\n");
+	if (ret) {
+		ksft_perror("PIN_LONGTERM_TEST_READ failed");
+		log_test_result(KSFT_FAIL);
+	} else {
+		if (!memcmp(mem, tmp, size))
+			log_test_result(KSFT_PASS);
+		else
+			log_test_result(KSFT_FAIL);
+	}
 
 	ret = ioctl(gup_fd, PIN_LONGTERM_TEST_STOP);
 	if (ret)
-		ksft_print_msg("[INFO] PIN_LONGTERM_TEST_STOP failed\n");
+		ksft_perror("PIN_LONGTERM_TEST_STOP failed");
 wait:
 	switch (test) {
 	case RO_PIN_TEST_SHARED:
 		write(comm_pipes.parent_ready[1], "0", 1);
 		wait(&ret);
 		if (!WIFEXITED(ret))
-			ksft_print_msg("[INFO] wait() failed\n");
+			ksft_perror("wait() failed");
 		break;
 	default:
 		break;
@@ -746,14 +795,16 @@ static void do_run_with_base_page(test_fn fn, bool swapout)
 	mem = mmap(NULL, pagesize, PROT_READ | PROT_WRITE,
 		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 	if (mem == MAP_FAILED) {
-		ksft_test_result_fail("mmap() failed\n");
+		ksft_perror("mmap() failed");
+		log_test_result(KSFT_FAIL);
 		return;
 	}
 
 	ret = madvise(mem, pagesize, MADV_NOHUGEPAGE);
 	/* Ignore if not around on a kernel. */
 	if (ret && errno != EINVAL) {
-		ksft_test_result_fail("MADV_NOHUGEPAGE failed\n");
+		ksft_perror("MADV_NOHUGEPAGE failed");
+		log_test_result(KSFT_FAIL);
 		goto munmap;
 	}
 
@@ -763,7 +814,8 @@ static void do_run_with_base_page(test_fn fn, bool swapout)
 	if (swapout) {
 		madvise(mem, pagesize, MADV_PAGEOUT);
 		if (!pagemap_is_swapped(pagemap_fd, mem)) {
-			ksft_test_result_skip("MADV_PAGEOUT did not work, is swap enabled?\n");
+			ksft_print_msg("MADV_PAGEOUT did not work, is swap enabled?\n");
+			log_test_result(KSFT_SKIP);
 			goto munmap;
 		}
 	}
@@ -775,13 +827,13 @@ static void do_run_with_base_page(test_fn fn, bool swapout)
 
 static void run_with_base_page(test_fn fn, const char *desc)
 {
-	ksft_print_msg("[RUN] %s ... with base page\n", desc);
+	log_test_start("%s ... with base page", desc);
 	do_run_with_base_page(fn, false);
 }
 
 static void run_with_base_page_swap(test_fn fn, const char *desc)
 {
-	ksft_print_msg("[RUN] %s ... with swapped out base page\n", desc);
+	log_test_start("%s ... with swapped out base page", desc);
 	do_run_with_base_page(fn, true);
 }
 
@@ -807,7 +859,8 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run, size_t thpsize)
 	mmap_mem = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
 			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 	if (mmap_mem == MAP_FAILED) {
-		ksft_test_result_fail("mmap() failed\n");
+		ksft_perror("mmap() failed");
+		log_test_result(KSFT_FAIL);
 		return;
 	}
 
@@ -816,7 +869,8 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run, size_t thpsize)
 
 	ret = madvise(mem, thpsize, MADV_HUGEPAGE);
 	if (ret) {
-		ksft_test_result_fail("MADV_HUGEPAGE failed\n");
+		ksft_perror("MADV_HUGEPAGE failed");
+		log_test_result(KSFT_FAIL);
 		goto munmap;
 	}
 
@@ -826,7 +880,8 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run, size_t thpsize)
 	 */
 	mem[0] = 1;
 	if (!pagemap_is_populated(pagemap_fd, mem + thpsize - pagesize)) {
-		ksft_test_result_skip("Did not get a THP populated\n");
+		ksft_print_msg("Did not get a THP populated\n");
+		log_test_result(KSFT_SKIP);
 		goto munmap;
 	}
 	memset(mem, 1, thpsize);
@@ -846,12 +901,14 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run, size_t thpsize)
 		 */
 		ret = mprotect(mem + pagesize, pagesize, PROT_READ);
 		if (ret) {
-			ksft_test_result_fail("mprotect() failed\n");
+			ksft_perror("mprotect() failed");
+			log_test_result(KSFT_FAIL);
 			goto munmap;
 		}
 		ret = mprotect(mem + pagesize, pagesize, PROT_READ | PROT_WRITE);
 		if (ret) {
-			ksft_test_result_fail("mprotect() failed\n");
+			ksft_perror("mprotect() failed");
+			log_test_result(KSFT_FAIL);
 			goto munmap;
 		}
 		break;
@@ -863,7 +920,8 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run, size_t thpsize)
 		 */
 		ret = madvise(mem + pagesize, thpsize - pagesize, MADV_DONTNEED);
 		if (ret) {
-			ksft_test_result_fail("MADV_DONTNEED failed\n");
+			ksft_perror("MADV_DONTNEED failed");
+			log_test_result(KSFT_FAIL);
 			goto munmap;
 		}
 		size = pagesize;
@@ -877,13 +935,15 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run, size_t thpsize)
 		mremap_mem = mmap(NULL, mremap_size, PROT_NONE,
 				  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 		if (mremap_mem == MAP_FAILED) {
-			ksft_test_result_fail("mmap() failed\n");
+			ksft_perror("mmap() failed");
+			log_test_result(KSFT_FAIL);
 			goto munmap;
 		}
 		tmp = mremap(mem + mremap_size, mremap_size, mremap_size,
 			     MREMAP_MAYMOVE | MREMAP_FIXED, mremap_mem);
 		if (tmp != mremap_mem) {
-			ksft_test_result_fail("mremap() failed\n");
+			ksft_perror("mremap() failed");
+			log_test_result(KSFT_FAIL);
 			goto munmap;
 		}
 		size = mremap_size;
@@ -896,12 +956,14 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run, size_t thpsize)
 		 */
 		ret = madvise(mem + pagesize, thpsize - pagesize, MADV_DONTFORK);
 		if (ret) {
-			ksft_test_result_fail("MADV_DONTFORK failed\n");
+			ksft_perror("MADV_DONTFORK failed");
+			log_test_result(KSFT_FAIL);
 			goto munmap;
 		}
 		ret = fork();
 		if (ret < 0) {
-			ksft_test_result_fail("fork() failed\n");
+			ksft_perror("fork() failed");
+			log_test_result(KSFT_FAIL);
 			goto munmap;
 		} else if (!ret) {
 			exit(0);
@@ -910,7 +972,8 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run, size_t thpsize)
 		/* Allow for sharing all pages again. */
 		ret = madvise(mem + pagesize, thpsize - pagesize, MADV_DOFORK);
 		if (ret) {
-			ksft_test_result_fail("MADV_DOFORK failed\n");
+			ksft_perror("MADV_DOFORK failed");
+			log_test_result(KSFT_FAIL);
 			goto munmap;
 		}
 		break;
@@ -924,7 +987,8 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run, size_t thpsize)
 	case THP_RUN_SINGLE_PTE_SWAPOUT:
 		madvise(mem, size, MADV_PAGEOUT);
 		if (!range_is_swapped(mem, size)) {
-			ksft_test_result_skip("MADV_PAGEOUT did not work, is swap enabled?\n");
+			ksft_print_msg("MADV_PAGEOUT did not work, is swap enabled?\n");
+			log_test_result(KSFT_SKIP);
 			goto munmap;
 		}
 		break;
@@ -941,56 +1005,56 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run, size_t thpsize)
 
 static void run_with_thp(test_fn fn, const char *desc, size_t size)
 {
-	ksft_print_msg("[RUN] %s ... with THP (%zu kB)\n",
+	log_test_start("%s ... with THP (%zu kB)",
 		desc, size / 1024);
 	do_run_with_thp(fn, THP_RUN_PMD, size);
 }
 
 static void run_with_thp_swap(test_fn fn, const char *desc, size_t size)
 {
-	ksft_print_msg("[RUN] %s ... with swapped-out THP (%zu kB)\n",
+	log_test_start("%s ... with swapped-out THP (%zu kB)",
 		desc, size / 1024);
 	do_run_with_thp(fn, THP_RUN_PMD_SWAPOUT, size);
 }
 
 static void run_with_pte_mapped_thp(test_fn fn, const char *desc, size_t size)
 {
-	ksft_print_msg("[RUN] %s ... with PTE-mapped THP (%zu kB)\n",
+	log_test_start("%s ... with PTE-mapped THP (%zu kB)",
 		desc, size / 1024);
 	do_run_with_thp(fn, THP_RUN_PTE, size);
 }
 
 static void run_with_pte_mapped_thp_swap(test_fn fn, const char *desc, size_t size)
 {
-	ksft_print_msg("[RUN] %s ... with swapped-out, PTE-mapped THP (%zu kB)\n",
+	log_test_start("%s ... with swapped-out, PTE-mapped THP (%zu kB)",
 		desc, size / 1024);
 	do_run_with_thp(fn, THP_RUN_PTE_SWAPOUT, size);
 }
 
 static void run_with_single_pte_of_thp(test_fn fn, const char *desc, size_t size)
 {
-	ksft_print_msg("[RUN] %s ... with single PTE of THP (%zu kB)\n",
+	log_test_start("%s ... with single PTE of THP (%zu kB)",
 		desc, size / 1024);
 	do_run_with_thp(fn, THP_RUN_SINGLE_PTE, size);
 }
 
 static void run_with_single_pte_of_thp_swap(test_fn fn, const char *desc, size_t size)
 {
-	ksft_print_msg("[RUN] %s ... with single PTE of swapped-out THP (%zu kB)\n",
+	log_test_start("%s ... with single PTE of swapped-out THP (%zu kB)",
 		desc, size / 1024);
 	do_run_with_thp(fn, THP_RUN_SINGLE_PTE_SWAPOUT, size);
 }
 
 static void run_with_partial_mremap_thp(test_fn fn, const char *desc, size_t size)
 {
-	ksft_print_msg("[RUN] %s ... with partially mremap()'ed THP (%zu kB)\n",
+	log_test_start("%s ... with partially mremap()'ed THP (%zu kB)",
 		desc, size / 1024);
 	do_run_with_thp(fn, THP_RUN_PARTIAL_MREMAP, size);
 }
 
 static void run_with_partial_shared_thp(test_fn fn, const char *desc, size_t size)
 {
-	ksft_print_msg("[RUN] %s ... with partially shared THP (%zu kB)\n",
+	log_test_start("%s ... with partially shared THP (%zu kB)",
 		desc, size / 1024);
 	do_run_with_thp(fn, THP_RUN_PARTIAL_SHARED, size);
 }
@@ -1000,14 +1064,15 @@ static void run_with_hugetlb(test_fn fn, const char *desc, size_t hugetlbsize)
 	int flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB;
 	char *mem, *dummy;
 
-	ksft_print_msg("[RUN] %s ... with hugetlb (%zu kB)\n", desc,
+	log_test_start("%s ... with hugetlb (%zu kB)", desc,
 		       hugetlbsize / 1024);
 
 	flags |= __builtin_ctzll(hugetlbsize) << MAP_HUGE_SHIFT;
 
 	mem = mmap(NULL, hugetlbsize, PROT_READ | PROT_WRITE, flags, -1, 0);
 	if (mem == MAP_FAILED) {
-		ksft_test_result_skip("need more free huge pages\n");
+		ksft_perror("need more free huge pages");
+		log_test_result(KSFT_SKIP);
 		return;
 	}
 
@@ -1020,7 +1085,8 @@ static void run_with_hugetlb(test_fn fn, const char *desc, size_t hugetlbsize)
 	 */
 	dummy = mmap(NULL, hugetlbsize, PROT_READ | PROT_WRITE, flags, -1, 0);
 	if (dummy == MAP_FAILED) {
-		ksft_test_result_skip("need more free huge pages\n");
+		ksft_perror("need more free huge pages");
+		log_test_result(KSFT_SKIP);
 		goto munmap;
 	}
 	munmap(dummy, hugetlbsize);
@@ -1226,7 +1292,7 @@ static void do_test_anon_thp_collapse(char *mem, size_t size,
 
 	ret = setup_comm_pipes(&comm_pipes);
 	if (ret) {
-		ksft_test_result_fail("pipe() failed\n");
+		log_test_result(KSFT_FAIL);
 		return;
 	}
 
@@ -1236,12 +1302,14 @@ static void do_test_anon_thp_collapse(char *mem, size_t size,
 	 */
 	ret = mprotect(mem + pagesize, pagesize, PROT_READ);
 	if (ret) {
-		ksft_test_result_fail("mprotect() failed\n");
+		ksft_perror("mprotect() failed");
+		log_test_result(KSFT_FAIL);
 		goto close_comm_pipes;
 	}
 	ret = mprotect(mem + pagesize, pagesize, PROT_READ | PROT_WRITE);
 	if (ret) {
-		ksft_test_result_fail("mprotect() failed\n");
+		ksft_perror("mprotect() failed");
+		log_test_result(KSFT_FAIL);
 		goto close_comm_pipes;
 	}
 
@@ -1250,8 +1318,8 @@ static void do_test_anon_thp_collapse(char *mem, size_t size,
 		/* Collapse before actually COW-sharing the page. */
 		ret = madvise(mem, size, MADV_COLLAPSE);
 		if (ret) {
-			ksft_test_result_skip("MADV_COLLAPSE failed: %s\n",
-					      strerror(errno));
+			ksft_perror("MADV_COLLAPSE failed");
+			log_test_result(KSFT_SKIP);
 			goto close_comm_pipes;
 		}
 		break;
@@ -1262,7 +1330,8 @@ static void do_test_anon_thp_collapse(char *mem, size_t size,
 		/* Don't COW-share the upper part of the THP. */
 		ret = madvise(mem + size / 2, size / 2, MADV_DONTFORK);
 		if (ret) {
-			ksft_test_result_fail("MADV_DONTFORK failed\n");
+			ksft_perror("MADV_DONTFORK failed");
+			log_test_result(KSFT_FAIL);
 			goto close_comm_pipes;
 		}
 		break;
@@ -1270,7 +1339,8 @@ static void do_test_anon_thp_collapse(char *mem, size_t size,
 		/* Don't COW-share the lower part of the THP. */
 		ret = madvise(mem, size / 2, MADV_DONTFORK);
 		if (ret) {
-			ksft_test_result_fail("MADV_DONTFORK failed\n");
+			ksft_perror("MADV_DONTFORK failed");
+			log_test_result(KSFT_FAIL);
 			goto close_comm_pipes;
 		}
 		break;
@@ -1280,7 +1350,8 @@ static void do_test_anon_thp_collapse(char *mem, size_t size,
 
 	ret = fork();
 	if (ret < 0) {
-		ksft_test_result_fail("fork() failed\n");
+		ksft_perror("fork() failed");
+		log_test_result(KSFT_FAIL);
 		goto close_comm_pipes;
 	} else if (!ret) {
 		switch (test) {
@@ -1314,7 +1385,8 @@ static void do_test_anon_thp_collapse(char *mem, size_t size,
 		 */
 		ret = madvise(mem, size, MADV_DOFORK);
 		if (ret) {
-			ksft_test_result_fail("MADV_DOFORK failed\n");
+			ksft_perror("MADV_DOFORK failed");
+			log_test_result(KSFT_FAIL);
 			write(comm_pipes.parent_ready[1], "0", 1);
 			wait(&ret);
 			goto close_comm_pipes;
@@ -1324,8 +1396,8 @@ static void do_test_anon_thp_collapse(char *mem, size_t size,
 		/* Collapse before anyone modified the COW-shared page. */
 		ret = madvise(mem, size, MADV_COLLAPSE);
 		if (ret) {
-			ksft_test_result_skip("MADV_COLLAPSE failed: %s\n",
-					      strerror(errno));
+			ksft_perror("MADV_COLLAPSE failed");
+			log_test_result(KSFT_SKIP);
 			write(comm_pipes.parent_ready[1], "0", 1);
 			wait(&ret);
 			goto close_comm_pipes;
@@ -1345,7 +1417,10 @@ static void do_test_anon_thp_collapse(char *mem, size_t size,
 	else
 		ret = -EINVAL;
 
-	ksft_test_result(!ret, "No leak from parent into child\n");
+	if (!ret)
+		log_test_result(KSFT_PASS);
+	else
+		log_test_result(KSFT_FAIL);
 close_comm_pipes:
 	close_comm_pipes(&comm_pipes);
 }
@@ -1430,7 +1505,7 @@ static void run_anon_thp_test_cases(void)
 	for (i = 0; i < ARRAY_SIZE(anon_thp_test_cases); i++) {
 		struct test_case const *test_case = &anon_thp_test_cases[i];
 
-		ksft_print_msg("[RUN] %s\n", test_case->desc);
+		log_test_start("%s", test_case->desc);
 		do_run_with_thp(test_case->fn, THP_RUN_PMD, pmdsize);
 	}
 }
@@ -1453,8 +1528,10 @@ static void test_cow(char *mem, const char *smem, size_t size)
 	memset(mem, 0xff, size);
 
 	/* See if we still read the old values via the other mapping. */
-	ksft_test_result(!memcmp(smem, old, size),
-			 "Other mapping not modified\n");
+	if (!memcmp(smem, old, size))
+		log_test_result(KSFT_PASS);
+	else
+		log_test_result(KSFT_FAIL);
 	free(old);
 }
 
@@ -1472,18 +1549,20 @@ static void run_with_zeropage(non_anon_test_fn fn, const char *desc)
 {
 	char *mem, *smem, tmp;
 
-	ksft_print_msg("[RUN] %s ... with shared zeropage\n", desc);
+	log_test_start("%s ... with shared zeropage", desc);
 
 	mem = mmap(NULL, pagesize, PROT_READ | PROT_WRITE,
 		   MAP_PRIVATE | MAP_ANON, -1, 0);
 	if (mem == MAP_FAILED) {
-		ksft_test_result_fail("mmap() failed\n");
+		ksft_perror("mmap() failed");
+		log_test_result(KSFT_FAIL);
 		return;
 	}
 
 	smem = mmap(NULL, pagesize, PROT_READ, MAP_PRIVATE | MAP_ANON, -1, 0);
 	if (smem == MAP_FAILED) {
-		ksft_test_result_fail("mmap() failed\n");
+		ksft_perror("mmap() failed");
+		log_test_result(KSFT_FAIL);
 		goto munmap;
 	}
 
@@ -1504,10 +1583,11 @@ static void run_with_huge_zeropage(non_anon_test_fn fn, const char *desc)
 	size_t mmap_size;
 	int ret;
 
-	ksft_print_msg("[RUN] %s ... with huge zeropage\n", desc);
+	log_test_start("%s ... with huge zeropage", desc);
 
 	if (!has_huge_zeropage) {
-		ksft_test_result_skip("Huge zeropage not enabled\n");
+		ksft_print_msg("Huge zeropage not enabled\n");
+		log_test_result(KSFT_SKIP);
 		return;
 	}
 
@@ -1516,13 +1596,15 @@ static void run_with_huge_zeropage(non_anon_test_fn fn, const char *desc)
 	mmap_mem = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
 			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 	if (mmap_mem == MAP_FAILED) {
-		ksft_test_result_fail("mmap() failed\n");
+		ksft_perror("mmap() failed");
+		log_test_result(KSFT_FAIL);
 		return;
 	}
 	mmap_smem = mmap(NULL, mmap_size, PROT_READ,
 			 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 	if (mmap_smem == MAP_FAILED) {
-		ksft_test_result_fail("mmap() failed\n");
+		ksft_perror("mmap() failed");
+		log_test_result(KSFT_FAIL);
 		goto munmap;
 	}
 
@@ -1531,9 +1613,15 @@ static void run_with_huge_zeropage(non_anon_test_fn fn, const char *desc)
 	smem = (char *)(((uintptr_t)mmap_smem + pmdsize) & ~(pmdsize - 1));
 
 	ret = madvise(mem, pmdsize, MADV_HUGEPAGE);
+	if (ret != 0) {
+		ksft_perror("madvise()");
+		log_test_result(KSFT_FAIL);
+		goto munmap;
+	}
 	ret |= madvise(smem, pmdsize, MADV_HUGEPAGE);
-	if (ret) {
-		ksft_test_result_fail("MADV_HUGEPAGE failed\n");
+	if (ret != 0) {
+		ksft_perror("madvise()");
+		log_test_result(KSFT_FAIL);
 		goto munmap;
 	}
 
@@ -1562,29 +1650,33 @@ static void run_with_memfd(non_anon_test_fn fn, const char *desc)
 	char *mem, *smem, tmp;
 	int fd;
 
-	ksft_print_msg("[RUN] %s ... with memfd\n", desc);
+	log_test_start("%s ... with memfd", desc);
 
 	fd = memfd_create("test", 0);
 	if (fd < 0) {
-		ksft_test_result_fail("memfd_create() failed\n");
+		ksft_perror("memfd_create() failed");
+		log_test_result(KSFT_FAIL);
 		return;
 	}
 
 	/* File consists of a single page filled with zeroes. */
 	if (fallocate(fd, 0, 0, pagesize)) {
-		ksft_test_result_fail("fallocate() failed\n");
+		ksft_perror("fallocate() failed");
+		log_test_result(KSFT_FAIL);
 		goto close;
 	}
 
 	/* Create a private mapping of the memfd. */
 	mem = mmap(NULL, pagesize, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
 	if (mem == MAP_FAILED) {
-		ksft_test_result_fail("mmap() failed\n");
+		ksft_perror("mmap() failed");
+		log_test_result(KSFT_FAIL);
 		goto close;
 	}
 	smem = mmap(NULL, pagesize, PROT_READ, MAP_SHARED, fd, 0);
 	if (smem == MAP_FAILED) {
-		ksft_test_result_fail("mmap() failed\n");
+		ksft_perror("mmap() failed");
+		log_test_result(KSFT_FAIL);
 		goto munmap;
 	}
 
@@ -1607,35 +1699,40 @@ static void run_with_tmpfile(non_anon_test_fn fn, const char *desc)
 	FILE *file;
 	int fd;
 
-	ksft_print_msg("[RUN] %s ... with tmpfile\n", desc);
+	log_test_start("%s ... with tmpfile", desc);
 
 	file = tmpfile();
 	if (!file) {
-		ksft_test_result_fail("tmpfile() failed\n");
+		ksft_perror("tmpfile() failed");
+		log_test_result(KSFT_FAIL);
 		return;
 	}
 
 	fd = fileno(file);
 	if (fd < 0) {
-		ksft_test_result_skip("fileno() failed\n");
+		ksft_perror("fileno() failed");
+		log_test_result(KSFT_SKIP);
 		return;
 	}
 
 	/* File consists of a single page filled with zeroes. */
 	if (fallocate(fd, 0, 0, pagesize)) {
-		ksft_test_result_fail("fallocate() failed\n");
+		ksft_perror("fallocate() failed");
+		log_test_result(KSFT_FAIL);
 		goto close;
 	}
 
 	/* Create a private mapping of the memfd. */
 	mem = mmap(NULL, pagesize, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
 	if (mem == MAP_FAILED) {
-		ksft_test_result_fail("mmap() failed\n");
+		ksft_perror("mmap() failed");
+		log_test_result(KSFT_FAIL);
 		goto close;
 	}
 	smem = mmap(NULL, pagesize, PROT_READ, MAP_SHARED, fd, 0);
 	if (smem == MAP_FAILED) {
-		ksft_test_result_fail("mmap() failed\n");
+		ksft_perror("mmap() failed");
+		log_test_result(KSFT_FAIL);
 		goto munmap;
 	}
 
@@ -1659,20 +1756,22 @@ static void run_with_memfd_hugetlb(non_anon_test_fn fn, const char *desc,
 	char *mem, *smem, tmp;
 	int fd;
 
-	ksft_print_msg("[RUN] %s ... with memfd hugetlb (%zu kB)\n", desc,
+	log_test_start("%s ... with memfd hugetlb (%zu kB)", desc,
 		       hugetlbsize / 1024);
 
 	flags |= __builtin_ctzll(hugetlbsize) << MFD_HUGE_SHIFT;
 
 	fd = memfd_create("test", flags);
 	if (fd < 0) {
-		ksft_test_result_skip("memfd_create() failed\n");
+		ksft_perror("memfd_create() failed");
+		log_test_result(KSFT_SKIP);
 		return;
 	}
 
 	/* File consists of a single page filled with zeroes. */
 	if (fallocate(fd, 0, 0, hugetlbsize)) {
-		ksft_test_result_skip("need more free huge pages\n");
+		ksft_perror("need more free huge pages");
+		log_test_result(KSFT_SKIP);
 		goto close;
 	}
 
@@ -1680,12 +1779,14 @@ static void run_with_memfd_hugetlb(non_anon_test_fn fn, const char *desc,
 	mem = mmap(NULL, hugetlbsize, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd,
 		   0);
 	if (mem == MAP_FAILED) {
-		ksft_test_result_skip("need more free huge pages\n");
+		ksft_perror("need more free huge pages");
+		log_test_result(KSFT_SKIP);
 		goto close;
 	}
 	smem = mmap(NULL, hugetlbsize, PROT_READ, MAP_SHARED, fd, 0);
 	if (smem == MAP_FAILED) {
-		ksft_test_result_fail("mmap() failed\n");
+		ksft_perror("mmap() failed");
+		log_test_result(KSFT_FAIL);
 		goto munmap;
 	}
 

-- 
2.39.5


