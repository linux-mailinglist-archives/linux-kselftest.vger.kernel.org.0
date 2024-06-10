Return-Path: <linux-kselftest+bounces-11541-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B3B901A4D
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 07:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D57AA281AD4
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 05:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91471BF37;
	Mon, 10 Jun 2024 05:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LpY6lnli"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51141865B;
	Mon, 10 Jun 2024 05:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998065; cv=none; b=laHeT6zxIwyKYLUWLp6JhdPpAoodnoScQA4K84K0REsIocSlxKC/oSUlh/8xI2ch0mV/Q4xrs8+jSOMXX6z0fdI3tZwvK68GrCbjnGvxhcU0PTAGsjFfkqAoKG63YQuMZChkk7+7WIalJiLGSDgO13yWZJS4qJtgMDKPY27Tcoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998065; c=relaxed/simple;
	bh=BDc4NM9WwjjXQJ0PTvdEt7g6tkleuvV0tTM1gFIYrc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TU5o6PIBzq9O6nlkFHlO99WN75RjnmuMiX7j/EmeaQSd2ARxXRqI7Fl2aHYOPpvXUrvEUpHQyXlT558/hIWZKHnjE+84VtPidn8dy61e/PHJiC7kfX5LTIxXFFtu/iR+cy57zcN4C5hkfCZ8UmqggNJfFsyXS+fudB9+UAcLM5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LpY6lnli; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717998062;
	bh=BDc4NM9WwjjXQJ0PTvdEt7g6tkleuvV0tTM1gFIYrc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LpY6lnliBoAh8hxpZtpGhJP52VPeIo+8RJxR8qMFdLMCgMi9E4vebg7J4u2mopjS+
	 qw0tCy3T1D0sjjmJkgeQh4QgJB7xGm7LsGdG13sjqRFQrLhbzVOT/NwAFPjVTY/cNl
	 LAmdF3a2TBl1VkxF5fheWIvyFfxiItGtf2b3ij9OrLs9N4GETYhbuAsr7nKJGqpjQX
	 RDHB/GRU0gTEagupsOYWoxJJfyquUrQJ1j2jZX0q7O+wQwfuA5B8bXJHg9wVE4zcrA
	 V1M6NoMrgG/25dbRjD0prttjs1nVsj2D9hoYNeIrunnGHJ3eRAleVTYHRReUX/5Ntw
	 VBXWsSNocOXPw==
Received: from deb.www.tendawifi.com (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 090723782172;
	Mon, 10 Jun 2024 05:40:59 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel@collabora.com
Subject: [PATCH v2 2/4] kselftests: vdso: vdso_test_correctness: conform test to TAP output
Date: Mon, 10 Jun 2024 10:41:27 +0500
Message-Id: <20240610054129.1527389-3-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610054129.1527389-1-usama.anjum@collabora.com>
References: <20240610054129.1527389-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Conform the layout, informational and status messages to TAP. No
functional change is intended other than the layout of output messages.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 .../selftests/vDSO/vdso_test_correctness.c    | 146 +++++++++---------
 1 file changed, 74 insertions(+), 72 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_correctness.c b/tools/testing/selftests/vDSO/vdso_test_correctness.c
index e691a3cf14911..688f83abb28eb 100644
--- a/tools/testing/selftests/vDSO/vdso_test_correctness.c
+++ b/tools/testing/selftests/vDSO/vdso_test_correctness.c
@@ -46,8 +46,6 @@ struct __kernel_timespec {
 /* max length of lines in /proc/self/maps - anything longer is skipped here */
 #define MAPS_LINE_LEN 128
 
-int nerrs = 0;
-
 typedef int (*vgettime_t)(clockid_t, struct timespec *);
 
 vgettime_t vdso_clock_gettime;
@@ -97,7 +95,7 @@ static void *vsyscall_getcpu(void)
 	fclose(maps);
 
 	if (!found) {
-		printf("Warning: failed to find vsyscall getcpu\n");
+		ksft_print_msg("Warning: failed to find vsyscall getcpu\n");
 		return NULL;
 	}
 	return (void *) (0xffffffffff600800);
@@ -115,30 +113,29 @@ static void fill_function_pointers()
 		vdso = dlopen("linux-gate.so.1",
 			      RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
 	if (!vdso) {
-		printf("[WARN]\tfailed to find vDSO\n");
-		return;
+		ksft_print_msg("failed to find vDSO\n");
+		ksft_finished();
 	}
 
 	vdso_getcpu = (getcpu_t)dlsym(vdso, name[4]);
 	if (!vdso_getcpu)
-		printf("Warning: failed to find getcpu in vDSO\n");
+		ksft_print_msg("Warning: failed to find getcpu in vDSO\n");
 
 	vgetcpu = (getcpu_t) vsyscall_getcpu();
 
 	vdso_clock_gettime = (vgettime_t)dlsym(vdso, name[1]);
 	if (!vdso_clock_gettime)
-		printf("Warning: failed to find clock_gettime in vDSO\n");
+		ksft_print_msg("Warning: failed to find clock_gettime in vDSO\n");
 
 #if defined(VDSO_32BIT)
 	vdso_clock_gettime64 = (vgettime64_t)dlsym(vdso, name[5]);
 	if (!vdso_clock_gettime64)
-		printf("Warning: failed to find clock_gettime64 in vDSO\n");
+		ksft_print_msg("Warning: failed to find clock_gettime64 in vDSO\n");
 #endif
 
 	vdso_gettimeofday = (vgtod_t)dlsym(vdso, name[0]);
 	if (!vdso_gettimeofday)
-		printf("Warning: failed to find gettimeofday in vDSO\n");
-
+		ksft_print_msg("Warning: failed to find gettimeofday in vDSO\n");
 }
 
 static long sys_getcpu(unsigned * cpu, unsigned * node,
@@ -164,7 +161,7 @@ static inline int sys_gettimeofday(struct timeval *tv, struct timezone *tz)
 
 static void test_getcpu(void)
 {
-	printf("[RUN]\tTesting getcpu...\n");
+	ksft_print_msg("Testing getcpu...\n");
 
 	for (int cpu = 0; ; cpu++) {
 		cpu_set_t cpuset;
@@ -199,18 +196,16 @@ static void test_getcpu(void)
 		if (!ret_vsys && (cpu_vsys != cpu || node_vsys != node))
 			ok = false;
 
-		printf("[%s]\tCPU %u:", ok ? "OK" : "FAIL", cpu);
+		ksft_print_msg("CPU %u:", ok ? "OK" : "FAIL", cpu);
 		if (!ret_sys)
-			printf(" syscall: cpu %u, node %u", cpu_sys, node_sys);
+			ksft_print_msg(" syscall: cpu %u, node %u", cpu_sys, node_sys);
 		if (!ret_vdso)
-			printf(" vdso: cpu %u, node %u", cpu_vdso, node_vdso);
+			ksft_print_msg(" vdso: cpu %u, node %u", cpu_vdso, node_vdso);
 		if (!ret_vsys)
-			printf(" vsyscall: cpu %u, node %u", cpu_vsys,
-			       node_vsys);
-		printf("\n");
+			ksft_print_msg(" vsyscall: cpu %u, node %u", cpu_vsys, node_vsys);
+		ksft_print_msg("\n");
 
-		if (!ok)
-			nerrs++;
+		ksft_test_result(ok, "Succeeded\n");
 	}
 }
 
@@ -259,19 +254,20 @@ static void test_one_clock_gettime(int clock, const char *name)
 	struct timespec start, vdso, end;
 	int vdso_ret, end_ret;
 
-	printf("[RUN]\tTesting clock_gettime for clock %s (%d)...\n", name, clock);
+	ksft_print_msg("Testing clock_gettime for clock %s (%d)...\n", name, clock);
 
 	if (sys_clock_gettime(clock, &start) < 0) {
 		if (errno == EINVAL) {
 			vdso_ret = vdso_clock_gettime(clock, &vdso);
 			if (vdso_ret == -EINVAL) {
-				printf("[OK]\tNo such clock.\n");
+				ksft_test_result_skip("No such clock.\n");
 			} else {
-				printf("[FAIL]\tNo such clock, but __vdso_clock_gettime returned %d\n", vdso_ret);
-				nerrs++;
+				ksft_test_result_fail("No such clock, but __vdso_clock_gettime returned %d\n",
+						      vdso_ret);
 			}
 		} else {
-			printf("[WARN]\t clock_gettime(%d) syscall returned error %d\n", clock, errno);
+			ksft_test_result_skip("clock_gettime(%d) syscall returned error %d\n",
+					      clock, errno);
 		}
 		return;
 	}
@@ -280,30 +276,32 @@ static void test_one_clock_gettime(int clock, const char *name)
 	end_ret = sys_clock_gettime(clock, &end);
 
 	if (vdso_ret != 0 || end_ret != 0) {
-		printf("[FAIL]\tvDSO returned %d, syscall errno=%d\n",
-		       vdso_ret, errno);
-		nerrs++;
+		ksft_test_result_fail("vDSO returned %d, syscall errno=%d\n", vdso_ret, errno);
 		return;
 	}
 
-	printf("\t%llu.%09ld %llu.%09ld %llu.%09ld\n",
-	       (unsigned long long)start.tv_sec, start.tv_nsec,
-	       (unsigned long long)vdso.tv_sec, vdso.tv_nsec,
-	       (unsigned long long)end.tv_sec, end.tv_nsec);
+	ksft_print_msg("\t%llu.%09ld %llu.%09ld %llu.%09ld\n",
+		       (unsigned long long)start.tv_sec, start.tv_nsec,
+		       (unsigned long long)vdso.tv_sec, vdso.tv_nsec,
+		       (unsigned long long)end.tv_sec, end.tv_nsec);
 
 	if (!ts_leq(&start, &vdso) || !ts_leq(&vdso, &end)) {
-		printf("[FAIL]\tTimes are out of sequence\n");
-		nerrs++;
+		ksft_test_result_fail("Times are out of sequence\n");
 		return;
 	}
 
-	printf("[OK]\tTest Passed.\n");
+	ksft_test_result_pass("Test Passed.\n");
 }
 
 static void test_clock_gettime(void)
 {
 	if (!vdso_clock_gettime) {
-		printf("[SKIP]\tNo vDSO, so skipping clock_gettime() tests\n");
+		for (int clock = 0; clock < ARRAY_SIZE(clocknames); clock++)
+			ksft_test_result_skip("No vDSO, so skipping %s\n", clocknames[clock]);
+
+		ksft_test_result_skip("No vDSO, so skipping clock_gettime() tests -1\n");
+		ksft_test_result_skip("No vDSO, so skipping clock_gettime() tests min\n");
+		ksft_test_result_skip("No vDSO, so skipping clock_gettime() tests max\n");
 		return;
 	}
 
@@ -321,19 +319,20 @@ static void test_one_clock_gettime64(int clock, const char *name)
 	struct __kernel_timespec start, vdso, end;
 	int vdso_ret, end_ret;
 
-	printf("[RUN]\tTesting clock_gettime64 for clock %s (%d)...\n", name, clock);
+	ksft_print_msg("Testing clock_gettime64 for clock %s (%d)...\n", name, clock);
 
 	if (sys_clock_gettime64(clock, &start) < 0) {
 		if (errno == EINVAL) {
 			vdso_ret = vdso_clock_gettime64(clock, &vdso);
 			if (vdso_ret == -EINVAL) {
-				printf("[OK]\tNo such clock.\n");
+				ksft_test_result_skip("No such clock.\n");
 			} else {
-				printf("[FAIL]\tNo such clock, but __vdso_clock_gettime64 returned %d\n", vdso_ret);
-				nerrs++;
+				ksft_test_result_fail("No such clock, but __vdso_clock_gettime64 returned %d\n",
+						      vdso_ret);
 			}
 		} else {
-			printf("[WARN]\t clock_gettime64(%d) syscall returned error %d\n", clock, errno);
+			ksft_test_result_skip("clock_gettime64(%d) syscall returned error %d\n",
+					      clock, errno);
 		}
 		return;
 	}
@@ -342,30 +341,32 @@ static void test_one_clock_gettime64(int clock, const char *name)
 	end_ret = sys_clock_gettime64(clock, &end);
 
 	if (vdso_ret != 0 || end_ret != 0) {
-		printf("[FAIL]\tvDSO returned %d, syscall errno=%d\n",
-		       vdso_ret, errno);
-		nerrs++;
+		ksft_test_result_fail("vDSO returned %d, syscall errno=%d\n", vdso_ret, errno);
 		return;
 	}
 
-	printf("\t%llu.%09lld %llu.%09lld %llu.%09lld\n",
-	       (unsigned long long)start.tv_sec, start.tv_nsec,
-	       (unsigned long long)vdso.tv_sec, vdso.tv_nsec,
-	       (unsigned long long)end.tv_sec, end.tv_nsec);
+	ksft_print_msg("\t%llu.%09lld %llu.%09lld %llu.%09lld\n",
+		       (unsigned long long)start.tv_sec, start.tv_nsec,
+		       (unsigned long long)vdso.tv_sec, vdso.tv_nsec,
+		       (unsigned long long)end.tv_sec, end.tv_nsec);
 
 	if (!ts64_leq(&start, &vdso) || !ts64_leq(&vdso, &end)) {
-		printf("[FAIL]\tTimes are out of sequence\n");
-		nerrs++;
+		ksft_test_result_fail("Times are out of sequence\n");
 		return;
 	}
 
-	printf("[OK]\tTest Passed.\n");
+	ksft_test_result_pass("Test Passed.\n");
 }
 
 static void test_clock_gettime64(void)
 {
 	if (!vdso_clock_gettime64) {
-		printf("[SKIP]\tNo vDSO, so skipping clock_gettime64() tests\n");
+		for (int clock = 0; clock < ARRAY_SIZE(clocknames); clock++)
+			ksft_test_result_skip("No vDSO, so skipping %s\n", clocknames[clock]);
+
+		ksft_test_result_skip("No vDSO, so skipping clock_gettime() tests -1\n");
+		ksft_test_result_skip("No vDSO, so skipping clock_gettime() tests min\n");
+		ksft_test_result_skip("No vDSO, so skipping clock_gettime() tests max\n");
 		return;
 	}
 
@@ -384,14 +385,18 @@ static void test_gettimeofday(void)
 	struct timezone sys_tz, vdso_tz;
 	int vdso_ret, end_ret;
 
-	if (!vdso_gettimeofday)
+	if (!vdso_gettimeofday) {
+		ksft_test_result_skip("No vDSO, so skipping clock_gettime64() tests\n");
 		return;
+	}
 
-	printf("[RUN]\tTesting gettimeofday...\n");
+	ksft_print_msg("Testing gettimeofday...\n");
+
+	/* Make sure that passing NULL for tz doesn't crash. */
+	vdso_gettimeofday(&vdso, NULL);
 
 	if (sys_gettimeofday(&start, &sys_tz) < 0) {
-		printf("[FAIL]\tsys_gettimeofday failed (%d)\n", errno);
-		nerrs++;
+		ksft_test_result_fail("sys_gettimeofday failed (%d)\n", errno);
 		return;
 	}
 
@@ -399,39 +404,36 @@ static void test_gettimeofday(void)
 	end_ret = sys_gettimeofday(&end, NULL);
 
 	if (vdso_ret != 0 || end_ret != 0) {
-		printf("[FAIL]\tvDSO returned %d, syscall errno=%d\n",
-		       vdso_ret, errno);
-		nerrs++;
+		ksft_test_result_fail("vDSO returned %d, syscall errno=%d\n", vdso_ret, errno);
 		return;
 	}
 
-	printf("\t%llu.%06ld %llu.%06ld %llu.%06ld\n",
-	       (unsigned long long)start.tv_sec, start.tv_usec,
-	       (unsigned long long)vdso.tv_sec, vdso.tv_usec,
-	       (unsigned long long)end.tv_sec, end.tv_usec);
+	ksft_print_msg("\t%llu.%06ld %llu.%06ld %llu.%06ld\n",
+		       (unsigned long long)start.tv_sec, start.tv_usec,
+		       (unsigned long long)vdso.tv_sec, vdso.tv_usec,
+		       (unsigned long long)end.tv_sec, end.tv_usec);
 
 	if (!tv_leq(&start, &vdso) || !tv_leq(&vdso, &end)) {
-		printf("[FAIL]\tTimes are out of sequence\n");
-		nerrs++;
+		ksft_test_result_fail("Times are out of sequence\n");
+		return;
 	}
 
 	if (sys_tz.tz_minuteswest == vdso_tz.tz_minuteswest &&
 	    sys_tz.tz_dsttime == vdso_tz.tz_dsttime) {
-		printf("[OK]\ttimezones match: minuteswest=%d, dsttime=%d\n",
-		       sys_tz.tz_minuteswest, sys_tz.tz_dsttime);
+		ksft_test_result_pass("timezones match: minuteswest=%d, dsttime=%d\n",
+				      sys_tz.tz_minuteswest, sys_tz.tz_dsttime);
 	} else {
-		printf("[FAIL]\ttimezones do not match\n");
-		nerrs++;
+		ksft_test_result_fail("timezones do not match\n");
 	}
-
-	/* And make sure that passing NULL for tz doesn't crash. */
-	vdso_gettimeofday(&vdso, NULL);
 }
 
 int main(int argc, char **argv)
 {
 	name = (const char **)&names[VDSO_NAMES];
 
+	ksft_print_header();
+	ksft_set_plan(7 + ARRAY_SIZE(clocknames) * 2 + sysconf(_SC_NPROCESSORS_ONLN));
+
 	fill_function_pointers();
 
 	test_clock_gettime();
@@ -444,5 +446,5 @@ int main(int argc, char **argv)
 	 */
 	test_getcpu();
 
-	return nerrs ? 1 : 0;
+	ksft_finished();
 }
-- 
2.39.2


