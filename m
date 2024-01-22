Return-Path: <linux-kselftest+bounces-3368-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C388374E6
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 22:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81194B2893B
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 21:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54766481C2;
	Mon, 22 Jan 2024 21:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iI9l0jmc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA6B481B9;
	Mon, 22 Jan 2024 21:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705957709; cv=none; b=HqaLGfM+CT4AOf0vhEOJ1vjEHWSHaLHDNhwQoMUUvZoT0/vkzYLP9ZLFiHZ1Fuk5M4EN/+Klns3i/0GjU8GdrfF5fmp1QhaR5M59fRK9Yi5YoGDFv1eXxHt7sAX9LaL6WpxwEWEy65H5NdzMCsb/oxZHvRxcDZWJdtSu5P25BQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705957709; c=relaxed/simple;
	bh=t77pXwBHIZmQkm4dwW7usuOT7jYVGRdtPqOlVm0lDgU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NB6ZZ7dDZDs2w+LW9txQc4XVsSA3KJ+antTNr1sva5Zx/cM6hcnCgLgBmgfMbDDajQ2q4nukeyq8DYBOvduxn/9COvqDoTGDTfKm1tLdFNPJrd5G8pp85G8U0qyJf3hNa6v6WwehirNSEZZ/ckBjnpwP2JyoGP15QqpzVvKaZPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iI9l0jmc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB85C43390;
	Mon, 22 Jan 2024 21:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705957709;
	bh=t77pXwBHIZmQkm4dwW7usuOT7jYVGRdtPqOlVm0lDgU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iI9l0jmcs/lZb2/NR+5Vq+pbajscZAI9AcX657ziy1imFpM3W5twu9tlpJfCLQ8TB
	 bf3GMNTYUfKC7utqmRyI0O/pPCOXptIjRgPU6FE1Fb/tutojA04fBmTpKKbc/XzVfY
	 XLcPZw7RlOYIOjgeHYJFqQYDp5E2fEpBC2fqZ7RvxX/QjFwy7anCWEHVd/2J9g+W5y
	 amIGaeh6DZGRPo2h4oauGONvNb4Y7o7MzxxWv/Q9YRKdTbCw/J9TwLykONGIqrjOYX
	 u3IGO1XdQ0Ub1rh5YLu0OMDGs5H34zruy+7EhJmL5HSt9Zjsxdu+7vnORymlqXbzMo
	 NTh2ImNk5HvMA==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 22 Jan 2024 21:08:18 +0000
Subject: [PATCH v3 2/2] kselftest/seccomp: Report each expectation we
 assert as a KTAP test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240122-b4-kselftest-seccomp-benchmark-ktap-v3-2-785bff4c04fd@kernel.org>
References: <20240122-b4-kselftest-seccomp-benchmark-ktap-v3-0-785bff4c04fd@kernel.org>
In-Reply-To: <20240122-b4-kselftest-seccomp-benchmark-ktap-v3-0-785bff4c04fd@kernel.org>
To: Kees Cook <keescook@chromium.org>, 
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, Anders Roxell <anders.roxell@linaro.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=5070; i=broonie@kernel.org;
 h=from:subject:message-id; bh=t77pXwBHIZmQkm4dwW7usuOT7jYVGRdtPqOlVm0lDgU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlrtlFUrdtPX47N2EhiewOPyZMX/jgPvNrIWZQNk9T
 tPXfBqyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZa7ZRQAKCRAk1otyXVSH0GR7B/
 0b+BDFYOSEMaG+g3jlTRnQyDa9HuB5LRNk61Sp5OE6Nxj5yvyeVLa43NswujPBcfL1a9z2ilykKPEi
 2kzvxv1PHzMi1kRg3IVfSlwgTi638fAHVTghjsKxHqW1RvlAe5MvrdXGYa5wvUvtiGITyPy5ryMcfv
 kmRM6A3bPeKYgydizA66ez48fW1OweUFS+O55fVuhEgqqRyiRIlflOn3w7k2r0teC7uNeeFqh106BC
 d0s1pGkkxhvIzCY0CAOwD1aAluQvktdVysDCsgIURZHNQvDIPtjGr59a+RrLtyoJwYKQPvOD7jyZHv
 JOK0LR2RvGsm5FB7p++NUKuGty8OrG
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The seccomp benchmark test makes a number of checks on the performance it
measures and logs them to the output but does so in a custom format which
none of the automated test runners understand meaning that the chances that
anyone is paying attention are slim. Let's additionally log each result in
KTAP format so that automated systems parsing the test output will see each
comparison as a test case. The original logs are left in place since they
provide the actual numbers for analysis.

As part of this rework the flow for the main program so that when we skip
tests we still log all the tests we skip, this is because the standard KTAP
headers and footers include counts of the number of expected and run tests.

Tested-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../testing/selftests/seccomp/seccomp_benchmark.c  | 62 +++++++++++++++-------
 1 file changed, 42 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_benchmark.c b/tools/testing/selftests/seccomp/seccomp_benchmark.c
index 93168dd2c1e3..436a527b8235 100644
--- a/tools/testing/selftests/seccomp/seccomp_benchmark.c
+++ b/tools/testing/selftests/seccomp/seccomp_benchmark.c
@@ -98,24 +98,36 @@ bool le(int i_one, int i_two)
 }
 
 long compare(const char *name_one, const char *name_eval, const char *name_two,
-	     unsigned long long one, bool (*eval)(int, int), unsigned long long two)
+	     unsigned long long one, bool (*eval)(int, int), unsigned long long two,
+	     bool skip)
 {
 	bool good;
 
+	if (skip) {
+		ksft_test_result_skip("%s %s %s\n", name_one, name_eval,
+				      name_two);
+		return 0;
+	}
+
 	ksft_print_msg("\t%s %s %s (%lld %s %lld): ", name_one, name_eval, name_two,
 		       (long long)one, name_eval, (long long)two);
 	if (one > INT_MAX) {
 		ksft_print_msg("Miscalculation! Measurement went negative: %lld\n", (long long)one);
-		return 1;
+		good = false;
+		goto out;
 	}
 	if (two > INT_MAX) {
 		ksft_print_msg("Miscalculation! Measurement went negative: %lld\n", (long long)two);
-		return 1;
+		good = false;
+		goto out;
 	}
 
 	good = eval(one, two);
 	printf("%s\n", good ? "✔️" : "❌");
 
+out:
+	ksft_test_result(good, "%s %s %s\n", name_one, name_eval, name_two);
+
 	return good ? 0 : 1;
 }
 
@@ -142,9 +154,13 @@ int main(int argc, char *argv[])
 	unsigned long long samples, calc;
 	unsigned long long native, filter1, filter2, bitmap1, bitmap2;
 	unsigned long long entry, per_filter1, per_filter2;
+	bool skip = false;
 
 	setbuf(stdout, NULL);
 
+	ksft_print_header();
+	ksft_set_plan(7);
+
 	ksft_print_msg("Running on:\n");
 	ksft_print_msg("");
 	system("uname -a");
@@ -202,8 +218,10 @@ int main(int argc, char *argv[])
 #define ESTIMATE(fmt, var, what)	do {			\
 		var = (what);					\
 		ksft_print_msg("Estimated " fmt ": %llu ns\n", var);	\
-		if (var > INT_MAX)				\
-			goto more_samples;			\
+		if (var > INT_MAX) {				\
+			skip = true;				\
+			ret |= 1;				\
+		}						\
 	} while (0)
 
 	ESTIMATE("total seccomp overhead for 1 bitmapped filter", calc,
@@ -222,30 +240,34 @@ int main(int argc, char *argv[])
 		 (filter2 - native - entry) / 4);
 
 	ksft_print_msg("Expectations:\n");
-	ret |= compare("native", "≤", "1 bitmap", native, le, bitmap1);
-	bits = compare("native", "≤", "1 filter", native, le, filter1);
+	ret |= compare("native", "≤", "1 bitmap", native, le, bitmap1,
+		       skip);
+	bits = compare("native", "≤", "1 filter", native, le, filter1,
+		       skip);
 	if (bits)
-		goto more_samples;
+		skip = true;
 
 	ret |= compare("per-filter (last 2 diff)", "≈", "per-filter (filters / 4)",
-			per_filter1, approx, per_filter2);
+		       per_filter1, approx, per_filter2, skip);
 
 	bits = compare("1 bitmapped", "≈", "2 bitmapped",
-			bitmap1 - native, approx, bitmap2 - native);
+		       bitmap1 - native, approx, bitmap2 - native, skip);
 	if (bits) {
 		ksft_print_msg("Skipping constant action bitmap expectations: they appear unsupported.\n");
-		goto out;
+		skip = true;
 	}
 
-	ret |= compare("entry", "≈", "1 bitmapped", entry, approx, bitmap1 - native);
-	ret |= compare("entry", "≈", "2 bitmapped", entry, approx, bitmap2 - native);
+	ret |= compare("entry", "≈", "1 bitmapped", entry, approx,
+		       bitmap1 - native, skip);
+	ret |= compare("entry", "≈", "2 bitmapped", entry, approx,
+		       bitmap2 - native, skip);
 	ret |= compare("native + entry + (per filter * 4)", "≈", "4 filters total",
-			entry + (per_filter1 * 4) + native, approx, filter2);
-	if (ret == 0)
-		goto out;
+		       entry + (per_filter1 * 4) + native, approx, filter2,
+		       skip);
 
-more_samples:
-	ksft_print_msg("Saw unexpected benchmark result. Try running again with more samples?\n");
-out:
-	return 0;
+	if (ret) {
+		ksft_print_msg("Saw unexpected benchmark result. Try running again with more samples?\n");
+	}
+
+	ksft_finished();
 }

-- 
2.30.2


