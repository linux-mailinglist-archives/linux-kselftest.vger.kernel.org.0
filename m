Return-Path: <linux-kselftest+bounces-13288-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C56929628
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jul 2024 02:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B489728409F
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jul 2024 00:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0417F4690;
	Sun,  7 Jul 2024 00:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LQnor/7r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33DA12B95;
	Sun,  7 Jul 2024 00:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720312047; cv=none; b=T+JYNAe2XQxBRnUhK8NUjMPBFelM0+DGlOnUfH4Q8bwc6acyi148+0aQ7yDWkdb24qx6BmfNEOh1Zv/NpY4sRaQX81ghQDjzQx7oYuXV2lcOQOR7upyUE5YAjKmyDfUI+u3XZFEiIWnm7CBUaEWUlc9MF4yWXwBSQPWhDptCnBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720312047; c=relaxed/simple;
	bh=eb76rZ1Tg9DNQHzIxI2FU+u9Yp06iC6M811D+lVbpGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p7sQhe9W2IHIyA2BGTrOkKhFGKcDXyYxSuBSirgeGQnoA2ZDP+Adk4uFgg35g1c5hvemmwBmeWS1IBiXIuhchQ1VyxUUbghm9S3qfWNIP923tpqwQmSVuWG6OI7z36UPPCG61jqwK+rgHZyb4fGEPuYD/hG0JKGspLWbdiZhnd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=LQnor/7r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C44BBC32786;
	Sun,  7 Jul 2024 00:27:24 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LQnor/7r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720312043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxiAM5M3/r5avrLgTNbVfZIpNPfXzHvpvzDSuwiv7+8=;
	b=LQnor/7r+nWjrNGtnVUbjapxX7YQN0sADpsMFRVg3APjrWw2fF1Lwmql1NDdW26xjr4bcd
	dyVxFfkg+Bdko7Yanm3SENM8jZATvfr6HAUKiZUyjhxUw9eafFGiJnepA2FxbffDDofURN
	8jAU0Pm64Gv6r3n68poD/XhDhCiaQ6g=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1c6a62cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 7 Jul 2024 00:27:23 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	tglx@linutronix.de
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	linux-crypto@vger.kernel.org,
	linux-api@vger.kernel.org,
	x86@kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Carlos O'Donell <carlos@redhat.com>,
	Florian Weimer <fweimer@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <dhildenb@redhat.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v21 4/4] selftests/vDSO: add tests for vgetrandom
Date: Sun,  7 Jul 2024 02:26:54 +0200
Message-ID: <20240707002658.1917440-5-Jason@zx2c4.com>
In-Reply-To: <20240707002658.1917440-1-Jason@zx2c4.com>
References: <20240707002658.1917440-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds two tests for vgetrandom. The first one, vdso_test_chacha,
simply checks that the assembly implementation of chacha20 matches that
of libsodium, a basic sanity check that should catch most errors. The
second, vdso_test_getrandom, is a full "libc-like" implementation of the
userspace side of vgetrandom() support. It's meant to be used also as
example code for libcs that might be integrating this.

Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 tools/include/asm/rwonce.h                    |   0
 tools/testing/selftests/vDSO/.gitignore       |   2 +
 tools/testing/selftests/vDSO/Makefile         |  15 +
 .../testing/selftests/vDSO/vdso_test_chacha.c |  43 +++
 .../selftests/vDSO/vdso_test_getrandom.c      | 288 ++++++++++++++++++
 5 files changed, 348 insertions(+)
 create mode 100644 tools/include/asm/rwonce.h
 create mode 100644 tools/testing/selftests/vDSO/vdso_test_chacha.c
 create mode 100644 tools/testing/selftests/vDSO/vdso_test_getrandom.c

diff --git a/tools/include/asm/rwonce.h b/tools/include/asm/rwonce.h
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tools/testing/selftests/vDSO/.gitignore b/tools/testing/selftests/vDSO/.gitignore
index a8dc51af5a9c..30d5c8f0e5c7 100644
--- a/tools/testing/selftests/vDSO/.gitignore
+++ b/tools/testing/selftests/vDSO/.gitignore
@@ -6,3 +6,5 @@ vdso_test_correctness
 vdso_test_gettimeofday
 vdso_test_getcpu
 vdso_standalone_test_x86
+vdso_test_getrandom
+vdso_test_chacha
diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index d53a4d8008f9..12fdae3b3201 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -3,6 +3,7 @@ include ../lib.mk
 
 uname_M := $(shell uname -m 2>/dev/null || echo not)
 ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
+SODIUM := $(shell pkg-config --libs libsodium 2>/dev/null)
 
 TEST_GEN_PROGS := $(OUTPUT)/vdso_test_gettimeofday $(OUTPUT)/vdso_test_getcpu
 TEST_GEN_PROGS += $(OUTPUT)/vdso_test_abi
@@ -11,9 +12,19 @@ ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
 TEST_GEN_PROGS += $(OUTPUT)/vdso_standalone_test_x86
 endif
 TEST_GEN_PROGS += $(OUTPUT)/vdso_test_correctness
+ifeq ($(uname_M),x86_64)
+TEST_GEN_PROGS += $(OUTPUT)/vdso_test_getrandom
+ifneq ($(SODIUM),)
+TEST_GEN_PROGS += $(OUTPUT)/vdso_test_chacha
+endif
+endif
 
 CFLAGS := -std=gnu99
 CFLAGS_vdso_standalone_test_x86 := -nostdlib -fno-asynchronous-unwind-tables -fno-stack-protector
+CFLAGS_vdso_test_getrandom := -isystem $(top_srcdir)/tools/include -isystem $(top_srcdir)/include/uapi
+CFLAGS_vdso_test_chacha := $(SODIUM) -idirafter $(top_srcdir)/tools/include -isystem $(top_srcdir)/include \
+			   -isystem $(top_srcdir)/arch/$(ARCH)/include \
+			   -D__ASSEMBLY__ -DBULID_VDSO -DCONFIG_FUNCTION_ALIGNMENT=0 -Wa,--noexecstack
 LDFLAGS_vdso_test_correctness := -ldl
 ifeq ($(CONFIG_X86_32),y)
 LDLIBS += -lgcc_s
@@ -33,3 +44,7 @@ $(OUTPUT)/vdso_test_correctness: vdso_test_correctness.c
 		vdso_test_correctness.c \
 		-o $@ \
 		$(LDFLAGS_vdso_test_correctness)
+$(OUTPUT)/vdso_test_getrandom: CFLAGS += $(CFLAGS_vdso_test_getrandom)
+$(OUTPUT)/vdso_test_getrandom: parse_vdso.c
+$(OUTPUT)/vdso_test_chacha: CFLAGS += $(CFLAGS_vdso_test_chacha)
+$(OUTPUT)/vdso_test_chacha: $(top_srcdir)/arch/$(ARCH)/entry/vdso/vgetrandom-chacha.S
diff --git a/tools/testing/selftests/vDSO/vdso_test_chacha.c b/tools/testing/selftests/vDSO/vdso_test_chacha.c
new file mode 100644
index 000000000000..e38f44e5f803
--- /dev/null
+++ b/tools/testing/selftests/vDSO/vdso_test_chacha.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022-2024 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#include <sodium/crypto_stream_chacha20.h>
+#include <sys/random.h>
+#include <string.h>
+#include <stdint.h>
+#include "../kselftest.h"
+
+extern void __arch_chacha20_blocks_nostack(uint8_t *dst_bytes, const uint8_t *key, uint32_t *counter, size_t nblocks);
+
+int main(int argc, char *argv[])
+{
+	enum { TRIALS = 1000, BLOCKS = 128, BLOCK_SIZE = 64 };
+	static const uint8_t nonce[8] = { 0 };
+	uint32_t counter[2];
+	uint8_t key[32];
+	uint8_t output1[BLOCK_SIZE * BLOCKS], output2[BLOCK_SIZE * BLOCKS];
+
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	for (unsigned int trial = 0; trial < TRIALS; ++trial) {
+		if (getrandom(key, sizeof(key), 0) != sizeof(key)) {
+			printf("getrandom() failed!\n");
+			return KSFT_SKIP;
+		}
+		crypto_stream_chacha20(output1, sizeof(output1), nonce, key);
+		for (unsigned int split = 0; split < BLOCKS; ++split) {
+			memset(output2, 'X', sizeof(output2));
+			memset(counter, 0, sizeof(counter));
+			if (split)
+				__arch_chacha20_blocks_nostack(output2, key, counter, split);
+			__arch_chacha20_blocks_nostack(output2 + split * BLOCK_SIZE, key, counter, BLOCKS - split);
+			if (memcmp(output1, output2, sizeof(output1)))
+				return KSFT_FAIL;
+		}
+	}
+	ksft_test_result_pass("chacha: PASS\n");
+	return KSFT_PASS;
+}
diff --git a/tools/testing/selftests/vDSO/vdso_test_getrandom.c b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
new file mode 100644
index 000000000000..69f5833590d2
--- /dev/null
+++ b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
@@ -0,0 +1,288 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022-2024 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#include <assert.h>
+#include <pthread.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+#include <unistd.h>
+#include <signal.h>
+#include <sys/auxv.h>
+#include <sys/mman.h>
+#include <sys/random.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <linux/random.h>
+
+#include "../kselftest.h"
+#include "parse_vdso.h"
+
+#ifndef timespecsub
+#define	timespecsub(tsp, usp, vsp)					\
+	do {								\
+		(vsp)->tv_sec = (tsp)->tv_sec - (usp)->tv_sec;		\
+		(vsp)->tv_nsec = (tsp)->tv_nsec - (usp)->tv_nsec;	\
+		if ((vsp)->tv_nsec < 0) {				\
+			(vsp)->tv_sec--;				\
+			(vsp)->tv_nsec += 1000000000L;			\
+		}							\
+	} while (0)
+#endif
+
+static struct {
+	pthread_mutex_t lock;
+	void **states;
+	size_t len, cap;
+} grnd_allocator = {
+	.lock = PTHREAD_MUTEX_INITIALIZER
+};
+
+static struct {
+	ssize_t(*fn)(void *, size_t, unsigned long, void *, size_t);
+	pthread_key_t key;
+	pthread_once_t initialized;
+	struct vgetrandom_opaque_params params;
+} grnd_ctx = {
+	.initialized = PTHREAD_ONCE_INIT
+};
+
+static void *vgetrandom_get_state(void)
+{
+	void *state = NULL;
+
+	pthread_mutex_lock(&grnd_allocator.lock);
+	if (!grnd_allocator.len) {
+		size_t page_size = getpagesize();
+		size_t new_cap;
+		size_t alloc_size, num = sysconf(_SC_NPROCESSORS_ONLN); /* Just a decent heuristic. */
+		void *new_block, *new_states;
+
+		alloc_size = (num * grnd_ctx.params.size_of_opaque_state + page_size - 1) & (~(page_size - 1));
+		num = (page_size / grnd_ctx.params.size_of_opaque_state) * (alloc_size / page_size);
+		new_block = mmap(0, alloc_size, grnd_ctx.params.mmap_prot, grnd_ctx.params.mmap_flags, -1, 0);
+		if (new_block == MAP_FAILED)
+			return NULL;
+
+		new_cap = grnd_allocator.cap + num;
+		new_states = reallocarray(grnd_allocator.states, new_cap, sizeof(*grnd_allocator.states));
+		if (!new_states)
+			goto unmap;
+		grnd_allocator.cap = new_cap;
+		grnd_allocator.states = new_states;
+
+		for (size_t i = 0; i < num; ++i) {
+			if (((uintptr_t)new_block & (page_size - 1)) + grnd_ctx.params.size_of_opaque_state > page_size)
+				new_block = (void *)(((uintptr_t)new_block + page_size - 1) & (~(page_size - 1)));
+			grnd_allocator.states[i] = new_block;
+			new_block += grnd_ctx.params.size_of_opaque_state;
+		}
+		grnd_allocator.len = num;
+		goto success;
+
+	unmap:
+		munmap(new_block, alloc_size);
+		goto out;
+	}
+success:
+	state = grnd_allocator.states[--grnd_allocator.len];
+
+out:
+	pthread_mutex_unlock(&grnd_allocator.lock);
+	return state;
+}
+
+static void vgetrandom_put_state(void *state)
+{
+	if (!state)
+		return;
+	pthread_mutex_lock(&grnd_allocator.lock);
+	grnd_allocator.states[grnd_allocator.len++] = state;
+	pthread_mutex_unlock(&grnd_allocator.lock);
+}
+
+static void vgetrandom_init(void)
+{
+	if (pthread_key_create(&grnd_ctx.key, vgetrandom_put_state) != 0)
+		return;
+	unsigned long sysinfo_ehdr = getauxval(AT_SYSINFO_EHDR);
+	if (!sysinfo_ehdr) {
+		printf("AT_SYSINFO_EHDR is not present!\n");
+		exit(KSFT_SKIP);
+	}
+	vdso_init_from_sysinfo_ehdr(sysinfo_ehdr);
+	grnd_ctx.fn = (__typeof__(grnd_ctx.fn))vdso_sym("LINUX_2.6", "__vdso_getrandom");
+	if (!grnd_ctx.fn) {
+		printf("__vdso_getrandom is missing!\n");
+		exit(KSFT_FAIL);
+	}
+	if (grnd_ctx.fn(NULL, 0, 0, &grnd_ctx.params, ~0UL) != 0) {
+		printf("failed to fetch vgetrandom params!\n");
+		exit(KSFT_FAIL);
+	}
+}
+
+static ssize_t vgetrandom(void *buf, size_t len, unsigned long flags)
+{
+	void *state;
+
+	pthread_once(&grnd_ctx.initialized, vgetrandom_init);
+	state = pthread_getspecific(grnd_ctx.key);
+	if (!state) {
+		state = vgetrandom_get_state();
+		if (pthread_setspecific(grnd_ctx.key, state) != 0) {
+			vgetrandom_put_state(state);
+			state = NULL;
+		}
+		if (!state) {
+			printf("vgetrandom_get_state failed!\n");
+			exit(KSFT_FAIL);
+		}
+	}
+	return grnd_ctx.fn(buf, len, flags, state, grnd_ctx.params.size_of_opaque_state);
+}
+
+enum { TRIALS = 25000000, THREADS = 256 };
+
+static void *test_vdso_getrandom(void *)
+{
+	for (size_t i = 0; i < TRIALS; ++i) {
+		unsigned int val;
+		ssize_t ret = vgetrandom(&val, sizeof(val), 0);
+		assert(ret == sizeof(val));
+	}
+	return NULL;
+}
+
+static void *test_libc_getrandom(void *)
+{
+	for (size_t i = 0; i < TRIALS; ++i) {
+		unsigned int val;
+		ssize_t ret = getrandom(&val, sizeof(val), 0);
+		assert(ret == sizeof(val));
+	}
+	return NULL;
+}
+
+static void *test_syscall_getrandom(void *)
+{
+	for (size_t i = 0; i < TRIALS; ++i) {
+		unsigned int val;
+		ssize_t ret = syscall(__NR_getrandom, &val, sizeof(val), 0);
+		assert(ret == sizeof(val));
+	}
+	return NULL;
+}
+
+static void bench_single(void)
+{
+	struct timespec start, end, diff;
+
+	clock_gettime(CLOCK_MONOTONIC, &start);
+	test_vdso_getrandom(NULL);
+	clock_gettime(CLOCK_MONOTONIC, &end);
+	timespecsub(&end, &start, &diff);
+	printf("   vdso: %u times in %lu.%09lu seconds\n", TRIALS, diff.tv_sec, diff.tv_nsec);
+
+	clock_gettime(CLOCK_MONOTONIC, &start);
+	test_libc_getrandom(NULL);
+	clock_gettime(CLOCK_MONOTONIC, &end);
+	timespecsub(&end, &start, &diff);
+	printf("   libc: %u times in %lu.%09lu seconds\n", TRIALS, diff.tv_sec, diff.tv_nsec);
+
+	clock_gettime(CLOCK_MONOTONIC, &start);
+	test_syscall_getrandom(NULL);
+	clock_gettime(CLOCK_MONOTONIC, &end);
+	timespecsub(&end, &start, &diff);
+	printf("syscall: %u times in %lu.%09lu seconds\n", TRIALS, diff.tv_sec, diff.tv_nsec);
+}
+
+static void bench_multi(void)
+{
+	struct timespec start, end, diff;
+	pthread_t threads[THREADS];
+
+	clock_gettime(CLOCK_MONOTONIC, &start);
+	for (size_t i = 0; i < THREADS; ++i)
+		assert(pthread_create(&threads[i], NULL, test_vdso_getrandom, NULL) == 0);
+	for (size_t i = 0; i < THREADS; ++i)
+		pthread_join(threads[i], NULL);
+	clock_gettime(CLOCK_MONOTONIC, &end);
+	timespecsub(&end, &start, &diff);
+	printf("   vdso: %u x %u times in %lu.%09lu seconds\n", TRIALS, THREADS, diff.tv_sec, diff.tv_nsec);
+
+	clock_gettime(CLOCK_MONOTONIC, &start);
+	for (size_t i = 0; i < THREADS; ++i)
+		assert(pthread_create(&threads[i], NULL, test_libc_getrandom, NULL) == 0);
+	for (size_t i = 0; i < THREADS; ++i)
+		pthread_join(threads[i], NULL);
+	clock_gettime(CLOCK_MONOTONIC, &end);
+	timespecsub(&end, &start, &diff);
+	printf("   libc: %u x %u times in %lu.%09lu seconds\n", TRIALS, THREADS, diff.tv_sec, diff.tv_nsec);
+
+	clock_gettime(CLOCK_MONOTONIC, &start);
+	for (size_t i = 0; i < THREADS; ++i)
+		assert(pthread_create(&threads[i], NULL, test_syscall_getrandom, NULL) == 0);
+	for (size_t i = 0; i < THREADS; ++i)
+		pthread_join(threads[i], NULL);
+	clock_gettime(CLOCK_MONOTONIC, &end);
+	timespecsub(&end, &start, &diff);
+	printf("   syscall: %u x %u times in %lu.%09lu seconds\n", TRIALS, THREADS, diff.tv_sec, diff.tv_nsec);
+}
+
+static void fill(void)
+{
+	uint8_t weird_size[323929];
+	for (;;)
+		vgetrandom(weird_size, sizeof(weird_size), 0);
+}
+
+static void kselftest(void)
+{
+	uint8_t weird_size[1263];
+
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	for (size_t i = 0; i < 1000; ++i) {
+		ssize_t ret = vgetrandom(weird_size, sizeof(weird_size), 0);
+		if (ret != sizeof(weird_size))
+			exit(KSFT_FAIL);
+	}
+
+	ksft_test_result_pass("getrandom: PASS\n");
+	exit(KSFT_PASS);
+}
+
+static void usage(const char *argv0)
+{
+	fprintf(stderr, "Usage: %s [bench-single|bench-multi|fill]\n", argv0);
+}
+
+int main(int argc, char *argv[])
+{
+	if (argc == 1) {
+		kselftest();
+		return 0;
+	}
+
+	if (argc != 2) {
+		usage(argv[0]);
+		return 1;
+	}
+	if (!strcmp(argv[1], "bench-single"))
+		bench_single();
+	else if (!strcmp(argv[1], "bench-multi"))
+		bench_multi();
+	else if (!strcmp(argv[1], "fill"))
+		fill();
+	else {
+		usage(argv[0]);
+		return 1;
+	}
+	return 0;
+}
-- 
2.45.2


