Return-Path: <linux-kselftest+bounces-3450-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC1D83AA96
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 14:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 333A1B2DC3E
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 13:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D9D7CF00;
	Wed, 24 Jan 2024 13:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDIKaeqW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBE97C0BD;
	Wed, 24 Jan 2024 13:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706101248; cv=none; b=POke17UySNcdY0IKjnmJow0Bw7sysRJ27J4on1p5HUHz7YkIDhETVssc3tpz6X9wspABfBem6SYOeeIkTSG6MPF2GuPyzYTAh658UWhF2MZvIEymik3mxwpa+iiHyFtGO75NCF+EFt3TLwtJ1MApE3bJImhegbonBvF0WKKhJnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706101248; c=relaxed/simple;
	bh=X1GX0ByCnXN+q4cLRykG/1QyOWnsNOpR6oiWLUfDTno=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KVx/dNXsz4YugseC4SW3cBVuCZz7OSUXC+uHloNL4PUNxm8nuutyQaRLdBCBaduLHc/zX3o2RtEKAV5SBLvP5nyuds7EqFm9+H5rO+nyuMJkWmYbuiajEVum6USZBjWPLdCjGZW0kFmlx1tQ5WtAeZ2cto0Cq5V3b3tM2uJuYvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDIKaeqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A37C433B1;
	Wed, 24 Jan 2024 13:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706101248;
	bh=X1GX0ByCnXN+q4cLRykG/1QyOWnsNOpR6oiWLUfDTno=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FDIKaeqW33O8OwynqwvSImtN9obGZOJ75h5y4zwyq5I+90UbBcGrQc9akxfYPyCAh
	 W6s/DIcw0Capd1k1mTIoLdlsrzkaMUOn+Cj/03DitpVKHdhk0Z3RDjxjduu4wJwjU5
	 VrzX45W9f6ygz/Aon83hyNVHpGgJeC8W3NPqn5CEH3QUYjUz5NFXZcCOdiRxQlPD5B
	 kAuH4XpXHrP/ipMOl8B35i4Ohv3FZYgvw4/w4BUcxCzDG/RN+8kX1EEP4vv6hWXCBi
	 A7fEPYJDON7Jtr1mng6+Au89llWkoRJX7u5Yec4dhaJm0IC6SMw7fpgKnxHXAyKJ4a
	 mFXXzlLwWu7DQ==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 24 Jan 2024 13:00:19 +0000
Subject: [PATCH v4 2/2] kselftest/seccomp: Report each expectation we
 assert as a KTAP test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240124-b4-kselftest-seccomp-benchmark-ktap-v4-2-cfd2bd2a31cf@kernel.org>
References: <20240124-b4-kselftest-seccomp-benchmark-ktap-v4-0-cfd2bd2a31cf@kernel.org>
In-Reply-To: <20240124-b4-kselftest-seccomp-benchmark-ktap-v4-0-cfd2bd2a31cf@kernel.org>
To: Kees Cook <keescook@chromium.org>, 
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, Anders Roxell <anders.roxell@linaro.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=5108; i=broonie@kernel.org;
 h=from:subject:message-id; bh=X1GX0ByCnXN+q4cLRykG/1QyOWnsNOpR6oiWLUfDTno=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlsQn5N93xH8lGYJR9CI+DPLMhROPr1XgTTQV5xqOg
 HhPSx7yJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZbEJ+QAKCRAk1otyXVSH0G8xB/
 9hWsgU+vB1MPfxtfy0eLiKu4r+niuaCgEm9zo8o+CVHYQgatiPKiHr2u99nYQ8ywvq1iy9WAWGiWq1
 CrihEehbnAcfiAtd9fjxppadatXzAw2Nba5kQ2z52xtrfKsk1UC+kuk8e+QANRsVj9uA/ASX+sqVmY
 TKSYWQWrp18kNha4YQM8H6ww/o9uvDHhdH39C1DfyScFwzXOn599HkwVJbNzW5koYl+NRW47sAonxT
 Hrat3w8MZstRYfTiQzBoe6WdOUSLH+er3NUfeR09tKL8sPPeXoEtPxkyqFE7OCWvIFATJFUrFpk/KO
 NGX+lJMPrvNwNJ8UXQecK+eUlAuwME
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
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../testing/selftests/seccomp/seccomp_benchmark.c  | 61 +++++++++++++++-------
 1 file changed, 41 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_benchmark.c b/tools/testing/selftests/seccomp/seccomp_benchmark.c
index 93168dd2c1e3..97b86980b768 100644
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
@@ -222,30 +240,33 @@ int main(int argc, char *argv[])
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
+	if (ret)
+		ksft_print_msg("Saw unexpected benchmark result. Try running again with more samples?\n");
+
+	ksft_finished();
 }

-- 
2.30.2


