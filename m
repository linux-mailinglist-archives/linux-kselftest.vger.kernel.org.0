Return-Path: <linux-kselftest+bounces-3330-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E20A836CB6
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 18:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7B0B1F270E8
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 17:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A36633F7;
	Mon, 22 Jan 2024 16:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehWpv7mM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9D0633F1;
	Mon, 22 Jan 2024 16:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705939469; cv=none; b=p9gYb/dxiS1WYoX6MUq5/XONHF1H5wiLd9ZblPF/97aZSq+AevorXio2NYjyPsFdM6BZDo/2w0myOS2h/OdlZwQQSW9efxl1AjLIzRxi+aDIpmtvjsZa3u+1KA9AE+4FNNA0n1hu0t3eO7lxy7I2KrAEegrjJLLWZXRpLaaFMu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705939469; c=relaxed/simple;
	bh=xnODDqrpQCt2Usa5KTDk01X54nQ4U4UJ8wKdaF12AcA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t/jDOFBg/V8Ls8Qq9mnAyi+YnQM+yaHIWO9hzEmVabUvT2PtqosnvblEF1ciZqrB6AIwuwbOlSYRVy4DHG/qKxzQDuwWDm081oRhAAhIieLd7p0XGfLnSYExlsa3H8N9fE4zeAXW4ff29AdIP02RC0qkpd7nXtuZemsVrk3POQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehWpv7mM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C46C433C7;
	Mon, 22 Jan 2024 16:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705939469;
	bh=xnODDqrpQCt2Usa5KTDk01X54nQ4U4UJ8wKdaF12AcA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ehWpv7mMx0kZH5qh0AnEMa69gi129WJubBJSPnoohE853y67ZBo1QLR7YwZPGI3Tt
	 bZHQ0YtBJfhJMJTu5Qc8WvguEw0uF5NhxIVDRQQ3t+1CGJRAs6ol1Ym5W2Oe/y0nAT
	 Qy6YobUKuJsn6G5EW1eogKOZnD5rhG0i45kePMYc3wJAw8PyiIawXQ2BOxYkLmROsP
	 S7qpe7JiFt76QPvXK12bV+ESEW1WuoVc2AHK2kODUIbNVqvAJ0+Yb8FyJyitToYsie
	 cVmNpN0YvrOrqJA9jAbyRQlUtuOvVOG0VBlWSBAxxJXIa220STUCLkPDZf54wkPbBG
	 68ZnAS4JjmSZg==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 22 Jan 2024 16:04:15 +0000
Subject: [PATCH v2 1/2] kselftest/seccomp: Use kselftest output functions
 for benchmark
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240122-b4-kselftest-seccomp-benchmark-ktap-v2-1-aed137eaea41@kernel.org>
References: <20240122-b4-kselftest-seccomp-benchmark-ktap-v2-0-aed137eaea41@kernel.org>
In-Reply-To: <20240122-b4-kselftest-seccomp-benchmark-ktap-v2-0-aed137eaea41@kernel.org>
To: Kees Cook <keescook@chromium.org>, 
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, Anders Roxell <anders.roxell@linaro.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=6351; i=broonie@kernel.org;
 h=from:subject:message-id; bh=xnODDqrpQCt2Usa5KTDk01X54nQ4U4UJ8wKdaF12AcA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlrpIHCO0I/3oSK3L4ZWNNjejV0PoGiyAEk/GBoq9h
 fofPpEqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZa6SBwAKCRAk1otyXVSH0OQ3B/
 4kGNKoJPJv3Jzds/m0NjzAyBQgxuP3qP8qXWPfh3gxIBmtozc2mZB8cBt7nWTmkmrQmmo1zejlqHj+
 7yjagcKOynaW73z/hqJ8I6LqFXIkoyuOHgRR16LL0c01kXX32vfxv7G06ua3pOmbWwr232kCq5j/yv
 Ix5ogbgYkOiLAqFm7wfP1rdbzDm0Y1fzAo26EuCiLgg82AvyVRkQ05P7Zsc5idMrUN5vZD6tEZkjDo
 GESu5BRK7/leO/2hw4lrKVrogBr7Vsxvv1iuxeuRSeR/SZL6LhBEgN15mq9kZ4nAthgoqw637K+n/M
 7R6/UOUkGsUo5ln66KudMMLyEEHDN1
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

In preparation for trying to output the test results themselves in TAP
format rework all the prints in the benchmark to use the kselftest output
functions. The uses of system() all produce single line output so we can
avoid having to deal with fully managing the child process and continue to
use system() by simply printing an empty message before we invoke system().
We also leave one printf() used to complete a line of output in place.

Tested-by: Anders Roxell <anders.roxell@linaro.org>
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


