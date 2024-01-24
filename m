Return-Path: <linux-kselftest+bounces-3449-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C11983AA87
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 14:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 756EA1C25E9D
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 13:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A490D7A702;
	Wed, 24 Jan 2024 13:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjsMtApZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D69277F3D;
	Wed, 24 Jan 2024 13:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706101246; cv=none; b=CLnOD9gaO7lbPKH8qQz3XD0hj6fcOdO8+k9loKDQP5dlLCcn6l2WqfsonMDRRg/wEU0BZX2dpYWs5dxOgS71rk1lGa+1sRIS6lZFPyRheIfaQMeEBEJfkz1ruyJIjU8/9JcpnyQ33dWxN7Id3HsDIACsRVjWwNIt4l52afgV5s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706101246; c=relaxed/simple;
	bh=9o+HDIgpROySfFcjDsYJORGTrxcfESNCkeqXVhB1kMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BMXvV/A+egqVEBt53XHo+BzabDAX9hSPKntVFQ4Sr4x8A8WC9y6pVJIlbUWZ2NwZGPYxgvSi15gRYz4EIHpl2Qhiv+cv4VxMBjwX/qfKuT4KRXs12VvLUl26Ja6YWQebqCPtWDFHQNdHWeIUf8tEMQ2STBDdm/nzfci6r5vz8Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjsMtApZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC3FC43399;
	Wed, 24 Jan 2024 13:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706101246;
	bh=9o+HDIgpROySfFcjDsYJORGTrxcfESNCkeqXVhB1kMs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JjsMtApZ/LfOVy3w3MvsI0ylp+32K7Z9s8Vkc0JJNWOkxc0OdVfJG+G1nMTCgcIU6
	 qH4NGdLvCcdAjcH7RNNCWObmclTDUqMABp1q1R9CYBO/zsuavpNM/Yo800ECkgySdf
	 dojdasyJtkpj45kunj9bPJ2e2A7raiaOHGNzNc2xBfePLG3m3CHmSU8zbUPVBJcR1J
	 N/ew4UHt9HaTt6HdzaWI2BLMd8WeADHJE37X+aEGDAuKQKgyyzn1QxcEQ21OdcQb+1
	 zhoiSUD71lD4ilAOhdkGaOPR+91+YCPmo7rN6tNNNcMD0/8TSJdINVIZrsmaDBaEsP
	 cvh+VWJpWGNwQ==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 24 Jan 2024 13:00:18 +0000
Subject: [PATCH v4 1/2] kselftest/seccomp: Use kselftest output functions
 for benchmark
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240124-b4-kselftest-seccomp-benchmark-ktap-v4-1-cfd2bd2a31cf@kernel.org>
References: <20240124-b4-kselftest-seccomp-benchmark-ktap-v4-0-cfd2bd2a31cf@kernel.org>
In-Reply-To: <20240124-b4-kselftest-seccomp-benchmark-ktap-v4-0-cfd2bd2a31cf@kernel.org>
To: Kees Cook <keescook@chromium.org>, 
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, Anders Roxell <anders.roxell@linaro.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=6396; i=broonie@kernel.org;
 h=from:subject:message-id; bh=9o+HDIgpROySfFcjDsYJORGTrxcfESNCkeqXVhB1kMs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlsQn49b2Zza7GkhVKcqYmrZhTblZq2V1s361lWZBk
 bJdChpeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZbEJ+AAKCRAk1otyXVSH0Bf/B/
 4mqoLI4E/yGtZzKbIF6y/mexAgLxBG2XDnuMvc+Z57gybUe3ckEzXd6U2gc0wA4hMnDPztZ5d1OCD5
 Z2iAjJJqHeiOG1pW5vrjwf7OeUsF/b3Ni+rFlSdMg3h/EeyQa4SdcRKzStj3HfcNie6qOQnyiduY2p
 DG8+jllccSAsBg9cxG5bSYcedIfQc363x/nOuiU/CWMs60XIoBQv0OXOFI8l711cnA84KZCN2enxu+
 B0jPLww0QhNKbgKfZ9+bnrdYokCseAp1JTLGkABdAasEG8xUhD/9cuPf8RiY5gsvnLEdItgFvjBpIl
 oiVS5f0pNk3MTz8BmStsyUsauHtBDz
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

In preparation for trying to output the test results themselves in TAP
format rework all the prints in the benchmark to use the kselftest output
functions. The uses of system() all produce single line output so we can
avoid having to deal with fully managing the child process and continue to
use system() by simply printing an empty message before we invoke system().
We also leave one printf() used to complete a line of output in place.

Tested-by: Anders Roxell <anders.roxell@linaro.org>
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../testing/selftests/seccomp/seccomp_benchmark.c  | 45 ++++++++++++----------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_benchmark.c b/tools/testing/selftests/seccomp/seccomp_benchmark.c
index 5b5c9d558dee..93168dd2c1e3 100644
--- a/tools/testing/selftests/seccomp/seccomp_benchmark.c
+++ b/tools/testing/selftests/seccomp/seccomp_benchmark.c
@@ -38,10 +38,10 @@ unsigned long long timing(clockid_t clk_id, unsigned long long samples)
 	i *= 1000000000ULL;
 	i += finish.tv_nsec - start.tv_nsec;
 
-	printf("%lu.%09lu - %lu.%09lu = %llu (%.1fs)\n",
-		finish.tv_sec, finish.tv_nsec,
-		start.tv_sec, start.tv_nsec,
-		i, (double)i / 1000000000.0);
+	ksft_print_msg("%lu.%09lu - %lu.%09lu = %llu (%.1fs)\n",
+		       finish.tv_sec, finish.tv_nsec,
+		       start.tv_sec, start.tv_nsec,
+		       i, (double)i / 1000000000.0);
 
 	return i;
 }
@@ -53,7 +53,7 @@ unsigned long long calibrate(void)
 	pid_t pid, ret;
 	int seconds = 15;
 
-	printf("Calibrating sample size for %d seconds worth of syscalls ...\n", seconds);
+	ksft_print_msg("Calibrating sample size for %d seconds worth of syscalls ...\n", seconds);
 
 	samples = 0;
 	pid = getpid();
@@ -102,14 +102,14 @@ long compare(const char *name_one, const char *name_eval, const char *name_two,
 {
 	bool good;
 
-	printf("\t%s %s %s (%lld %s %lld): ", name_one, name_eval, name_two,
-	       (long long)one, name_eval, (long long)two);
+	ksft_print_msg("\t%s %s %s (%lld %s %lld): ", name_one, name_eval, name_two,
+		       (long long)one, name_eval, (long long)two);
 	if (one > INT_MAX) {
-		printf("Miscalculation! Measurement went negative: %lld\n", (long long)one);
+		ksft_print_msg("Miscalculation! Measurement went negative: %lld\n", (long long)one);
 		return 1;
 	}
 	if (two > INT_MAX) {
-		printf("Miscalculation! Measurement went negative: %lld\n", (long long)two);
+		ksft_print_msg("Miscalculation! Measurement went negative: %lld\n", (long long)two);
 		return 1;
 	}
 
@@ -145,12 +145,15 @@ int main(int argc, char *argv[])
 
 	setbuf(stdout, NULL);
 
-	printf("Running on:\n");
+	ksft_print_msg("Running on:\n");
+	ksft_print_msg("");
 	system("uname -a");
 
-	printf("Current BPF sysctl settings:\n");
+	ksft_print_msg("Current BPF sysctl settings:\n");
 	/* Avoid using "sysctl" which may not be installed. */
+	ksft_print_msg("");
 	system("grep -H . /proc/sys/net/core/bpf_jit_enable");
+	ksft_print_msg("");
 	system("grep -H . /proc/sys/net/core/bpf_jit_harden");
 
 	if (argc > 1)
@@ -158,11 +161,11 @@ int main(int argc, char *argv[])
 	else
 		samples = calibrate();
 
-	printf("Benchmarking %llu syscalls...\n", samples);
+	ksft_print_msg("Benchmarking %llu syscalls...\n", samples);
 
 	/* Native call */
 	native = timing(CLOCK_PROCESS_CPUTIME_ID, samples) / samples;
-	printf("getpid native: %llu ns\n", native);
+	ksft_print_msg("getpid native: %llu ns\n", native);
 
 	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
 	assert(ret == 0);
@@ -172,33 +175,33 @@ int main(int argc, char *argv[])
 	assert(ret == 0);
 
 	bitmap1 = timing(CLOCK_PROCESS_CPUTIME_ID, samples) / samples;
-	printf("getpid RET_ALLOW 1 filter (bitmap): %llu ns\n", bitmap1);
+	ksft_print_msg("getpid RET_ALLOW 1 filter (bitmap): %llu ns\n", bitmap1);
 
 	/* Second filter resulting in a bitmap */
 	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &bitmap_prog);
 	assert(ret == 0);
 
 	bitmap2 = timing(CLOCK_PROCESS_CPUTIME_ID, samples) / samples;
-	printf("getpid RET_ALLOW 2 filters (bitmap): %llu ns\n", bitmap2);
+	ksft_print_msg("getpid RET_ALLOW 2 filters (bitmap): %llu ns\n", bitmap2);
 
 	/* Third filter, can no longer be converted to bitmap */
 	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &prog);
 	assert(ret == 0);
 
 	filter1 = timing(CLOCK_PROCESS_CPUTIME_ID, samples) / samples;
-	printf("getpid RET_ALLOW 3 filters (full): %llu ns\n", filter1);
+	ksft_print_msg("getpid RET_ALLOW 3 filters (full): %llu ns\n", filter1);
 
 	/* Fourth filter, can not be converted to bitmap because of filter 3 */
 	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &bitmap_prog);
 	assert(ret == 0);
 
 	filter2 = timing(CLOCK_PROCESS_CPUTIME_ID, samples) / samples;
-	printf("getpid RET_ALLOW 4 filters (full): %llu ns\n", filter2);
+	ksft_print_msg("getpid RET_ALLOW 4 filters (full): %llu ns\n", filter2);
 
 	/* Estimations */
 #define ESTIMATE(fmt, var, what)	do {			\
 		var = (what);					\
-		printf("Estimated " fmt ": %llu ns\n", var);	\
+		ksft_print_msg("Estimated " fmt ": %llu ns\n", var);	\
 		if (var > INT_MAX)				\
 			goto more_samples;			\
 	} while (0)
@@ -218,7 +221,7 @@ int main(int argc, char *argv[])
 	ESTIMATE("seccomp per-filter overhead (filters / 4)", per_filter2,
 		 (filter2 - native - entry) / 4);
 
-	printf("Expectations:\n");
+	ksft_print_msg("Expectations:\n");
 	ret |= compare("native", "≤", "1 bitmap", native, le, bitmap1);
 	bits = compare("native", "≤", "1 filter", native, le, filter1);
 	if (bits)
@@ -230,7 +233,7 @@ int main(int argc, char *argv[])
 	bits = compare("1 bitmapped", "≈", "2 bitmapped",
 			bitmap1 - native, approx, bitmap2 - native);
 	if (bits) {
-		printf("Skipping constant action bitmap expectations: they appear unsupported.\n");
+		ksft_print_msg("Skipping constant action bitmap expectations: they appear unsupported.\n");
 		goto out;
 	}
 
@@ -242,7 +245,7 @@ int main(int argc, char *argv[])
 		goto out;
 
 more_samples:
-	printf("Saw unexpected benchmark result. Try running again with more samples?\n");
+	ksft_print_msg("Saw unexpected benchmark result. Try running again with more samples?\n");
 out:
 	return 0;
 }

-- 
2.30.2


