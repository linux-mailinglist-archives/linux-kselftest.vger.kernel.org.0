Return-Path: <linux-kselftest+bounces-17112-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFD396BAD8
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 13:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0B751C24686
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 11:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D541D0158;
	Wed,  4 Sep 2024 11:35:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAF818890D;
	Wed,  4 Sep 2024 11:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725449729; cv=none; b=K/i/4LUFcSeNyULAM5IA5BBPQf8BFHNf8O+X2fiHrHZkUxW8qSa9WPhMFkLRUZguSuZzerDHnAai+SxBRKVZ4+F/L9avhcDc6rZFMzaBdyvvQNPn0JofzpduIsKdHSvhu5kUhqHR7J+klNb/GDjBx03NgH6P0Oq3nElEpS8puZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725449729; c=relaxed/simple;
	bh=IiQGCh2SGIAwmnkIbp7AAPKn9N9e7F3p+VQMdskkzYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RmVGZ+4K3dtA9ewNlY3rNNIg3jkSTyePqpxyJVBWXSUxP5DQHaY2zNSROuTwL7dWPBTUhe+BQoD1EF1ojXsehryzs5U0G0hzbZulR9u8/Oy0Kw1Bc1ScASU8mU+pFv65lQ3PQf69+/euNmdmoyRVDgO5vHf4BUVDALdPz0yzjc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WzL5T3tHlz9sS7;
	Wed,  4 Sep 2024 13:35:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NX8yQkEqz96I; Wed,  4 Sep 2024 13:35:25 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WzL5T2y6pz9sRr;
	Wed,  4 Sep 2024 13:35:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 543788B77A;
	Wed,  4 Sep 2024 13:35:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id uCm-DvTqex84; Wed,  4 Sep 2024 13:35:25 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.234.246])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id ED2C78B778;
	Wed,  4 Sep 2024 13:35:24 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Shuah Khan <shuah@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests: vDSO: enable partial vdso_test_getrandom bench
Date: Wed,  4 Sep 2024 13:35:14 +0200
Message-ID: <0f08535586cc74111613ddf728633ae306502e66.1725449605.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725449714; l=6714; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=IiQGCh2SGIAwmnkIbp7AAPKn9N9e7F3p+VQMdskkzYs=; b=bYlM2fmWgI7w1g4RgzDeOfTKtmGIy4TTO5k6sa/6hnDcdzSe2DnFTYQo8yyxLr0g2ZuL6UPLB kwU9gKO50x0C78ZeSycgpdiTfpapwwsT032yo8tG4Z4O8T0gubc38OS
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

In order to use vdso_test_getrandom with analysis tools like 'perf' it
can be useful to perform only one kind of test, for instead only vdso.

Add an optional argument that allows telling which of the three API
you want to benchmark.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 .../selftests/vDSO/vdso_test_getrandom.c      | 122 +++++++++++-------
 1 file changed, 73 insertions(+), 49 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_getrandom.c b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
index 8866b65a4605..c38210ac8dc5 100644
--- a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
+++ b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
@@ -46,6 +46,10 @@ static struct {
 	.lock = PTHREAD_MUTEX_INITIALIZER
 };
 
+#define VDSO_TEST_VDSO		0x1
+#define VDSO_TEST_LIBC		0x2
+#define VDSO_TEST_SYSCALL	0x4
+
 static void *vgetrandom_get_state(void)
 {
 	void *state = NULL;
@@ -173,60 +177,72 @@ static void *test_syscall_getrandom(void *ctx)
 	return NULL;
 }
 
-static void bench_single(void)
+static void bench_single(int tests)
 {
 	struct timespec start, end, diff;
 
-	clock_gettime(CLOCK_MONOTONIC, &start);
-	test_vdso_getrandom(NULL);
-	clock_gettime(CLOCK_MONOTONIC, &end);
-	timespecsub(&end, &start, &diff);
-	printf("   vdso: %u times in %lu.%09lu seconds\n", TRIALS, diff.tv_sec, diff.tv_nsec);
-
-	clock_gettime(CLOCK_MONOTONIC, &start);
-	test_libc_getrandom(NULL);
-	clock_gettime(CLOCK_MONOTONIC, &end);
-	timespecsub(&end, &start, &diff);
-	printf("   libc: %u times in %lu.%09lu seconds\n", TRIALS, diff.tv_sec, diff.tv_nsec);
-
-	clock_gettime(CLOCK_MONOTONIC, &start);
-	test_syscall_getrandom(NULL);
-	clock_gettime(CLOCK_MONOTONIC, &end);
-	timespecsub(&end, &start, &diff);
-	printf("syscall: %u times in %lu.%09lu seconds\n", TRIALS, diff.tv_sec, diff.tv_nsec);
+	if (tests & VDSO_TEST_VDSO) {
+		clock_gettime(CLOCK_MONOTONIC, &start);
+		test_vdso_getrandom(NULL);
+		clock_gettime(CLOCK_MONOTONIC, &end);
+		timespecsub(&end, &start, &diff);
+		printf("   vdso: %u times in %lu.%09lu seconds\n", TRIALS, diff.tv_sec, diff.tv_nsec);
+	}
+
+	if (tests & VDSO_TEST_LIBC) {
+		clock_gettime(CLOCK_MONOTONIC, &start);
+		test_libc_getrandom(NULL);
+		clock_gettime(CLOCK_MONOTONIC, &end);
+		timespecsub(&end, &start, &diff);
+		printf("   libc: %u times in %lu.%09lu seconds\n", TRIALS, diff.tv_sec, diff.tv_nsec);
+	}
+
+	if (tests & VDSO_TEST_SYSCALL) {
+		clock_gettime(CLOCK_MONOTONIC, &start);
+		test_syscall_getrandom(NULL);
+		clock_gettime(CLOCK_MONOTONIC, &end);
+		timespecsub(&end, &start, &diff);
+		printf("syscall: %u times in %lu.%09lu seconds\n", TRIALS, diff.tv_sec, diff.tv_nsec);
+	}
 }
 
-static void bench_multi(void)
+static void bench_multi(int tests)
 {
 	struct timespec start, end, diff;
 	pthread_t threads[THREADS];
 
-	clock_gettime(CLOCK_MONOTONIC, &start);
-	for (size_t i = 0; i < THREADS; ++i)
-		assert(pthread_create(&threads[i], NULL, test_vdso_getrandom, NULL) == 0);
-	for (size_t i = 0; i < THREADS; ++i)
-		pthread_join(threads[i], NULL);
-	clock_gettime(CLOCK_MONOTONIC, &end);
-	timespecsub(&end, &start, &diff);
-	printf("   vdso: %u x %u times in %lu.%09lu seconds\n", TRIALS, THREADS, diff.tv_sec, diff.tv_nsec);
-
-	clock_gettime(CLOCK_MONOTONIC, &start);
-	for (size_t i = 0; i < THREADS; ++i)
-		assert(pthread_create(&threads[i], NULL, test_libc_getrandom, NULL) == 0);
-	for (size_t i = 0; i < THREADS; ++i)
-		pthread_join(threads[i], NULL);
-	clock_gettime(CLOCK_MONOTONIC, &end);
-	timespecsub(&end, &start, &diff);
-	printf("   libc: %u x %u times in %lu.%09lu seconds\n", TRIALS, THREADS, diff.tv_sec, diff.tv_nsec);
-
-	clock_gettime(CLOCK_MONOTONIC, &start);
-	for (size_t i = 0; i < THREADS; ++i)
-		assert(pthread_create(&threads[i], NULL, test_syscall_getrandom, NULL) == 0);
-	for (size_t i = 0; i < THREADS; ++i)
-		pthread_join(threads[i], NULL);
-	clock_gettime(CLOCK_MONOTONIC, &end);
-	timespecsub(&end, &start, &diff);
-	printf("   syscall: %u x %u times in %lu.%09lu seconds\n", TRIALS, THREADS, diff.tv_sec, diff.tv_nsec);
+	if (tests & VDSO_TEST_VDSO) {
+		clock_gettime(CLOCK_MONOTONIC, &start);
+		for (size_t i = 0; i < THREADS; ++i)
+			assert(pthread_create(&threads[i], NULL, test_vdso_getrandom, NULL) == 0);
+		for (size_t i = 0; i < THREADS; ++i)
+			pthread_join(threads[i], NULL);
+		clock_gettime(CLOCK_MONOTONIC, &end);
+		timespecsub(&end, &start, &diff);
+		printf("   vdso: %u x %u times in %lu.%09lu seconds\n", TRIALS, THREADS, diff.tv_sec, diff.tv_nsec);
+	}
+
+	if (tests & VDSO_TEST_LIBC) {
+		clock_gettime(CLOCK_MONOTONIC, &start);
+		for (size_t i = 0; i < THREADS; ++i)
+			assert(pthread_create(&threads[i], NULL, test_libc_getrandom, NULL) == 0);
+		for (size_t i = 0; i < THREADS; ++i)
+			pthread_join(threads[i], NULL);
+		clock_gettime(CLOCK_MONOTONIC, &end);
+		timespecsub(&end, &start, &diff);
+		printf("   libc: %u x %u times in %lu.%09lu seconds\n", TRIALS, THREADS, diff.tv_sec, diff.tv_nsec);
+	}
+
+	if (tests & VDSO_TEST_SYSCALL) {
+		clock_gettime(CLOCK_MONOTONIC, &start);
+		for (size_t i = 0; i < THREADS; ++i)
+			assert(pthread_create(&threads[i], NULL, test_syscall_getrandom, NULL) == 0);
+		for (size_t i = 0; i < THREADS; ++i)
+			pthread_join(threads[i], NULL);
+		clock_gettime(CLOCK_MONOTONIC, &end);
+		timespecsub(&end, &start, &diff);
+		printf("   syscall: %u x %u times in %lu.%09lu seconds\n", TRIALS, THREADS, diff.tv_sec, diff.tv_nsec);
+	}
 }
 
 static void fill(void)
@@ -255,11 +271,13 @@ static void kselftest(void)
 
 static void usage(const char *argv0)
 {
-	fprintf(stderr, "Usage: %s [bench-single|bench-multi|fill]\n", argv0);
+	fprintf(stderr, "Usage: %s [bench-single|bench-multi|fill [vdso|libc|syscall]]\n", argv0);
 }
 
 int main(int argc, char *argv[])
 {
+	int tests = VDSO_TEST_VDSO | VDSO_TEST_LIBC | VDSO_TEST_SYSCALL;
+
 	vgetrandom_init();
 
 	if (argc == 1) {
@@ -267,14 +285,20 @@ int main(int argc, char *argv[])
 		return 0;
 	}
 
-	if (argc != 2) {
+	if (argc == 3 && !strcmp(argv[2], "vdso")) {
+		tests = VDSO_TEST_VDSO;
+	} else if (argc == 3 && !strcmp(argv[2], "libc")) {
+		tests = VDSO_TEST_LIBC;
+	} else if (argc == 3 && !strcmp(argv[2], "syscall")) {
+		tests = VDSO_TEST_SYSCALL;
+	} else if (argc != 2) {
 		usage(argv[0]);
 		return 1;
 	}
 	if (!strcmp(argv[1], "bench-single"))
-		bench_single();
+		bench_single(tests);
 	else if (!strcmp(argv[1], "bench-multi"))
-		bench_multi();
+		bench_multi(tests);
 	else if (!strcmp(argv[1], "fill"))
 		fill();
 	else {
-- 
2.44.0


