Return-Path: <linux-kselftest+bounces-19185-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A94993985
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 23:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDAF51C21261
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 21:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9D2175D38;
	Mon,  7 Oct 2024 21:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="IivwmPSa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6962774C08
	for <linux-kselftest@vger.kernel.org>; Mon,  7 Oct 2024 21:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728337574; cv=none; b=LxVOxFz5+CR1iSorDNs1fqcMe4bKhKlpzI+S5L1hW3p1A9ixnsgAAlRP1qRtTVyikd8eq5OZN+jm/dLBjpcMXl2Z7oAS3o7KUHT4jmuXT009szhUKf9vcTmFAnIjHa6utzUhf+dFihc9MFyee3VeqlIxx2660AOuXvJAyolMTL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728337574; c=relaxed/simple;
	bh=Dy5PsWHF/hd0Qs1WR035jds0f1A0JqB40ld1GT1T6jM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JGUzELrljZNBOskfU4oWWJlhy56fk0pD6UvxNC/Ktx66xIoODmEJMJx26VnFwIlX4prRM7twNL2OcLAwaLyV/piQ2SHQkTxN/SZAPjq2j8FJ/IgX2ho0IzosL0Tdy+fREjNRQCuOzEXi4GZNar66cyiADALKNbCZLv+3h1TQ6j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=IivwmPSa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB87C4CEC6;
	Mon,  7 Oct 2024 21:46:13 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="IivwmPSa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1728337568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VFiFlqN0v+4ELpL9sZmgo6GRX/7LhppnKlv9q/ahwLs=;
	b=IivwmPSavWd3DcVTh8jbp7C5i5QWniDJOILAoVgBMGHkgs9GILS4erAdozZWXyBdpowsft
	Hk42CODOJl30yaSSBiD8qmsUUp3bUejMgKPF1ndKd6tph+waYOKYbR27wAI3mnaHeImXOE
	iG8n8GcXvODp/XPlN0Ao8CnnAIjt7M8=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a1939a3f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 21:46:08 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: linux-kselftest@vger.kernel.org,
	greg@kroah.com,
	skhan@linuxfoundation.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH kselftest v3 3/3] selftests: vDSO: improve getrandom and chacha error messages
Date: Mon,  7 Oct 2024 23:45:58 +0200
Message-ID: <20241007214558.2590492-3-Jason@zx2c4.com>
In-Reply-To: <20241007214558.2590492-1-Jason@zx2c4.com>
References: <6d8c0894-f3c4-42ff-9794-03d675142a7c@linuxfoundation.org>
 <20241007214558.2590492-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve the error and skip condition messages to let the developer know
precisely where a test has failed. Also make better use of the ksft api
for this.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 .../testing/selftests/vDSO/vdso_test_chacha.c | 27 ++++---
 .../selftests/vDSO/vdso_test_getrandom.c      | 75 ++++++++-----------
 2 files changed, 49 insertions(+), 53 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_chacha.c b/tools/testing/selftests/vDSO/vdso_test_chacha.c
index c66eb9df89bd..8757f738b0b1 100644
--- a/tools/testing/selftests/vDSO/vdso_test_chacha.c
+++ b/tools/testing/selftests/vDSO/vdso_test_chacha.c
@@ -91,10 +91,8 @@ int main(int argc, char *argv[])
 	ksft_set_plan(1);
 
 	for (unsigned int trial = 0; trial < TRIALS; ++trial) {
-		if (getrandom(key, sizeof(key), 0) != sizeof(key)) {
-			printf("getrandom() failed!\n");
-			return KSFT_SKIP;
-		}
+		if (getrandom(key, sizeof(key), 0) != sizeof(key))
+			ksft_exit_skip("getrandom() failed unexpectedly\n");
 		memset(counter1, 0, sizeof(counter1));
 		reference_chacha20_blocks(output1, key, counter1, BLOCKS);
 		for (unsigned int split = 0; split < BLOCKS; ++split) {
@@ -103,8 +101,10 @@ int main(int argc, char *argv[])
 			if (split)
 				__arch_chacha20_blocks_nostack(output2, key, counter2, split);
 			__arch_chacha20_blocks_nostack(output2 + split * BLOCK_SIZE, key, counter2, BLOCKS - split);
-			if (memcmp(output1, output2, sizeof(output1)) || memcmp(counter1, counter2, sizeof(counter1)))
-				return KSFT_FAIL;
+			if (memcmp(output1, output2, sizeof(output1)))
+				ksft_exit_fail_msg("Main loop outputs do not match on trial %u, split %u\n", trial, split);
+			if (memcmp(counter1, counter2, sizeof(counter1)))
+				ksft_exit_fail_msg("Main loop counters do not match on trial %u, split %u\n", trial, split);
 		}
 	}
 	memset(counter1, 0, sizeof(counter1));
@@ -114,14 +114,19 @@ int main(int argc, char *argv[])
 
 	reference_chacha20_blocks(output1, key, counter1, BLOCKS);
 	__arch_chacha20_blocks_nostack(output2, key, counter2, BLOCKS);
-	if (memcmp(output1, output2, sizeof(output1)) || memcmp(counter1, counter2, sizeof(counter1)))
-		return KSFT_FAIL;
+	if (memcmp(output1, output2, sizeof(output1)))
+		ksft_exit_fail_msg("Block limit outputs do not match after first round\n");
+	if (memcmp(counter1, counter2, sizeof(counter1)))
+		ksft_exit_fail_msg("Block limit counters do not match after first round\n");
 
 	reference_chacha20_blocks(output1, key, counter1, BLOCKS);
 	__arch_chacha20_blocks_nostack(output2, key, counter2, BLOCKS);
-	if (memcmp(output1, output2, sizeof(output1)) || memcmp(counter1, counter2, sizeof(counter1)))
-		return KSFT_FAIL;
+	if (memcmp(output1, output2, sizeof(output1)))
+		ksft_exit_fail_msg("Block limit outputs do not match after second round\n");
+	if (memcmp(counter1, counter2, sizeof(counter1)))
+		ksft_exit_fail_msg("Block limit counters do not match after second round\n");
 
 	ksft_test_result_pass("chacha: PASS\n");
-	return KSFT_PASS;
+	ksft_exit_pass();
+	return 0;
 }
diff --git a/tools/testing/selftests/vDSO/vdso_test_getrandom.c b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
index 5489a2f07434..50ec9ad4c7ec 100644
--- a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
+++ b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
@@ -40,6 +40,9 @@
 	} while (0)
 #endif
 
+#define ksft_assert(condition) \
+	do { if (!(condition)) ksft_exit_fail_msg("Assertion failed: %s\n", #condition); } while (0)
+
 static struct {
 	pthread_mutex_t lock;
 	void **states;
@@ -109,26 +112,19 @@ static void vgetrandom_init(void)
 	const char *version = versions[VDSO_VERSION];
 	const char *name = names[VDSO_NAMES][6];
 	unsigned long sysinfo_ehdr = getauxval(AT_SYSINFO_EHDR);
-	size_t ret;
+	ssize_t ret;
 
-	if (!sysinfo_ehdr) {
-		printf("AT_SYSINFO_EHDR is not present!\n");
-		exit(KSFT_SKIP);
-	}
+	if (!sysinfo_ehdr)
+		ksft_exit_skip("AT_SYSINFO_EHDR is not present\n");
 	vdso_init_from_sysinfo_ehdr(sysinfo_ehdr);
 	vgrnd.fn = (__typeof__(vgrnd.fn))vdso_sym(version, name);
-	if (!vgrnd.fn) {
-		printf("%s is missing!\n", name);
-		exit(KSFT_SKIP);
-	}
+	if (!vgrnd.fn)
+		ksft_exit_skip("%s@%s symbol is missing from vDSO\n", name, version);
 	ret = VDSO_CALL(vgrnd.fn, 5, NULL, 0, 0, &vgrnd.params, ~0UL);
-	if (ret == -ENOSYS) {
-		printf("unsupported architecture\n");
-		exit(KSFT_SKIP);
-	} else if (ret) {
-		printf("failed to fetch vgetrandom params!\n");
-		exit(KSFT_FAIL);
-	}
+	if (ret == -ENOSYS)
+		ksft_exit_skip("CPU does not have runtime support\n");
+	else if (ret)
+		ksft_exit_fail_msg("Failed to fetch vgetrandom params: %zd\n", ret);
 }
 
 static ssize_t vgetrandom(void *buf, size_t len, unsigned long flags)
@@ -137,10 +133,7 @@ static ssize_t vgetrandom(void *buf, size_t len, unsigned long flags)
 
 	if (!state) {
 		state = vgetrandom_get_state();
-		if (!state) {
-			printf("vgetrandom_get_state failed!\n");
-			exit(KSFT_FAIL);
-		}
+		ksft_assert(state);
 	}
 	return VDSO_CALL(vgrnd.fn, 5, buf, len, flags, state, vgrnd.params.size_of_opaque_state);
 }
@@ -152,7 +145,7 @@ static void *test_vdso_getrandom(void *ctx)
 	for (size_t i = 0; i < TRIALS; ++i) {
 		unsigned int val;
 		ssize_t ret = vgetrandom(&val, sizeof(val), 0);
-		assert(ret == sizeof(val));
+		ksft_assert(ret == sizeof(val));
 	}
 	return NULL;
 }
@@ -162,7 +155,7 @@ static void *test_libc_getrandom(void *ctx)
 	for (size_t i = 0; i < TRIALS; ++i) {
 		unsigned int val;
 		ssize_t ret = getrandom(&val, sizeof(val), 0);
-		assert(ret == sizeof(val));
+		ksft_assert(ret == sizeof(val));
 	}
 	return NULL;
 }
@@ -172,7 +165,7 @@ static void *test_syscall_getrandom(void *ctx)
 	for (size_t i = 0; i < TRIALS; ++i) {
 		unsigned int val;
 		ssize_t ret = syscall(__NR_getrandom, &val, sizeof(val), 0);
-		assert(ret == sizeof(val));
+		ksft_assert(ret == sizeof(val));
 	}
 	return NULL;
 }
@@ -207,7 +200,7 @@ static void bench_multi(void)
 
 	clock_gettime(CLOCK_MONOTONIC, &start);
 	for (size_t i = 0; i < THREADS; ++i)
-		assert(pthread_create(&threads[i], NULL, test_vdso_getrandom, NULL) == 0);
+		ksft_assert(pthread_create(&threads[i], NULL, test_vdso_getrandom, NULL) == 0);
 	for (size_t i = 0; i < THREADS; ++i)
 		pthread_join(threads[i], NULL);
 	clock_gettime(CLOCK_MONOTONIC, &end);
@@ -216,7 +209,7 @@ static void bench_multi(void)
 
 	clock_gettime(CLOCK_MONOTONIC, &start);
 	for (size_t i = 0; i < THREADS; ++i)
-		assert(pthread_create(&threads[i], NULL, test_libc_getrandom, NULL) == 0);
+		ksft_assert(pthread_create(&threads[i], NULL, test_libc_getrandom, NULL) == 0);
 	for (size_t i = 0; i < THREADS; ++i)
 		pthread_join(threads[i], NULL);
 	clock_gettime(CLOCK_MONOTONIC, &end);
@@ -225,7 +218,7 @@ static void bench_multi(void)
 
 	clock_gettime(CLOCK_MONOTONIC, &start);
 	for (size_t i = 0; i < THREADS; ++i)
-		assert(pthread_create(&threads[i], NULL, test_syscall_getrandom, NULL) == 0);
+		ksft_assert(pthread_create(&threads[i], NULL, test_syscall_getrandom, NULL) == 0);
 	for (size_t i = 0; i < THREADS; ++i)
 		pthread_join(threads[i], NULL);
 	clock_gettime(CLOCK_MONOTONIC, &end);
@@ -250,48 +243,46 @@ static void kselftest(void)
 
 	for (size_t i = 0; i < 1000; ++i) {
 		ssize_t ret = vgetrandom(weird_size, sizeof(weird_size), 0);
-		if (ret != sizeof(weird_size))
-			exit(KSFT_FAIL);
+		ksft_assert(ret == sizeof(weird_size));
 	}
 
 	ksft_test_result_pass("getrandom: PASS\n");
 
 	unshare(CLONE_NEWUSER);
-	assert(unshare(CLONE_NEWTIME) == 0);
+	ksft_assert(unshare(CLONE_NEWTIME) == 0);
 	child = fork();
-	assert(child >= 0);
+	ksft_assert(child >= 0);
 	if (!child) {
 		vgetrandom_init();
 		child = getpid();
-		assert(ptrace(PTRACE_TRACEME, 0, NULL, NULL) == 0);
-		assert(kill(child, SIGSTOP) == 0);
-		assert(vgetrandom(weird_size, sizeof(weird_size), 0) == sizeof(weird_size));
+		ksft_assert(ptrace(PTRACE_TRACEME, 0, NULL, NULL) == 0);
+		ksft_assert(kill(child, SIGSTOP) == 0);
+		ksft_assert(vgetrandom(weird_size, sizeof(weird_size), 0) == sizeof(weird_size));
 		_exit(0);
 	}
 	for (;;) {
 		struct ptrace_syscall_info info = { 0 };
 		int status, ret;
-		assert(waitpid(child, &status, 0) >= 0);
+		ksft_assert(waitpid(child, &status, 0) >= 0);
 		if (WIFEXITED(status)) {
-			if (WEXITSTATUS(status) != 0)
-				exit(KSFT_FAIL);
+			ksft_assert(WEXITSTATUS(status) == 0);
 			break;
 		}
-		assert(WIFSTOPPED(status));
+		ksft_assert(WIFSTOPPED(status));
 		if (WSTOPSIG(status) == SIGSTOP)
-			assert(ptrace(PTRACE_SETOPTIONS, child, 0, PTRACE_O_TRACESYSGOOD) == 0);
+			ksft_assert(ptrace(PTRACE_SETOPTIONS, child, 0, PTRACE_O_TRACESYSGOOD) == 0);
 		else if (WSTOPSIG(status) == (SIGTRAP | 0x80)) {
-			assert(ptrace(PTRACE_GET_SYSCALL_INFO, child, sizeof(info), &info) > 0);
+			ksft_assert(ptrace(PTRACE_GET_SYSCALL_INFO, child, sizeof(info), &info) > 0);
 			if (info.op == PTRACE_SYSCALL_INFO_ENTRY && info.entry.nr == __NR_getrandom &&
 			    info.entry.args[0] == (uintptr_t)weird_size && info.entry.args[1] == sizeof(weird_size))
-				exit(KSFT_FAIL);
+				ksft_exit_fail_msg("vgetrandom passed buffer to syscall getrandom unexpectedly\n");
 		}
-		assert(ptrace(PTRACE_SYSCALL, child, 0, 0) == 0);
+		ksft_assert(ptrace(PTRACE_SYSCALL, child, 0, 0) == 0);
 	}
 
 	ksft_test_result_pass("getrandom timens: PASS\n");
 
-	exit(KSFT_PASS);
+	ksft_exit_pass();
 }
 
 static void usage(const char *argv0)
-- 
2.46.0


