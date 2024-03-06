Return-Path: <linux-kselftest+bounces-6009-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 855F6874050
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 20:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7B591C240CA
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 19:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F319140397;
	Wed,  6 Mar 2024 19:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txi89XZo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210AD13E7CE;
	Wed,  6 Mar 2024 19:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709752900; cv=none; b=cBEAGeuP2k5b5w5CbH9K1CtH/J0rhIfkr0VUTbmSbi6FfrIFj0vkO/oZSGkqTT5wG5qpaPr9GJ/mFw/QMx4RGkhzub80oVonUtltaCuwEJS3QBHMi/+tW3mDNKGS1+FIFFo2y4V7GYC1bXhjfW9H73JN0uQqSg8x5gRCLhjm5X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709752900; c=relaxed/simple;
	bh=xL1xjg+8MEPz55HWswyeT1lYlU+bIX5B5bi0yf4AeHk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NYzJE5L3DYBJb5ZPtK1KGTVz3E59l9Okw5jKv8T+uglgpux0i6xqGYum4tddylHvfdWPc5adLjdj0wXPKl1s2xVXJVVfd+5jqeiqLKoafaMnXncor0Ceee5K8EXWaSglRNsjliy87MZ9QfHIguJUvoohMgabuQJASlmNnt85jqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txi89XZo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F118C43399;
	Wed,  6 Mar 2024 19:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709752899;
	bh=xL1xjg+8MEPz55HWswyeT1lYlU+bIX5B5bi0yf4AeHk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=txi89XZoa9oeWHO4VtIVwgJfOBk47detNEn8+YOSq91Ko7cTFuYKNvo64uYZG2/hv
	 dwhik06iQ+D/ZsMCPD6TkXkCNtxgkC/FPcT/01jVQS8LcH1YeODIawnihKW3oHzZRS
	 Mz7D/fxP3mlhRV3TaXfIXmdU14TM89jALdoCyxwpZwnAoIREaaytWIdwzJB+ak64J6
	 thCedDycDuwaFipYwlu7V2K5TwzWb6KAILNZmDfuinj9314mL5tsT/Lr+b1w1ZfJFc
	 g/9a1O60DxYSPYZd5DRlQca/G9KIfS6PbYyiXx0L9DHtezMcBwQ+SH10Lv6pSmtzYL
	 Ra2xvWeILm5dQ==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 06 Mar 2024 19:21:25 +0000
Subject: [PATCH 1/2] kselftest: Add mechanism for reporting a KSFT_ result
 code
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-kselftest-tty-tname-v1-1-33505b31629e@kernel.org>
References: <20240306-kselftest-tty-tname-v1-0-33505b31629e@kernel.org>
In-Reply-To: <20240306-kselftest-tty-tname-v1-0-33505b31629e@kernel.org>
To: Shuah Khan <shuah@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Michal Sekletar <msekleta@redhat.com>, linux-serial@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2019; i=broonie@kernel.org;
 h=from:subject:message-id; bh=xL1xjg+8MEPz55HWswyeT1lYlU+bIX5B5bi0yf4AeHk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBl6MI8vS9GOsN+KDt8q42xO9wBTJmy5E7Qy5wvEt1U
 Kf1hg6KJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZejCPAAKCRAk1otyXVSH0MMrB/
 9iy9164MfH74pl4LQO0WvyXLRut+raf/mTKsW0lab0Pwr8XsmLNyGuE5/7HA3ht5NH6Vwo+oOJo4v3
 v3XtAWGh0aTJvztnINY/L5eGUnyuWKbfd3OhJbtoqj29ibNpFLq7zuB/abEFEBtNnrzP2XrZVVsJIi
 zDJ5qoEvSIkVQOlTOKEjwW0kGACxnBSZXwz5MkmoqHXbA+5+sjHEJRNGVWDvdRzD5WHimvtztcilaI
 6bWzi/wGe5HzZnAAqwflljdv9t0I/IsMW/9Vwzf/fgJDYIibDY8pn59Kb0FnyQVf4JEVLNB5c9WUdH
 Ak7eqXeNojvwZQqlVllleSP2jf0Yye
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently there's no helper which a test can use to report it's result as
a KSFT_ result code, we can report a boolean pass/fail but not a skip. This
is sometimes a useful idiom so let's add a helper ksft_test_result_report()
which translates into the relevant report types.

Due to the use of va_args in the result reporting functions this is done as
a macro rather than an inline function as one might expect, none of the
alternatives looked particularly great.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kselftest.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index a781e6311810..9bc130c269d7 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -20,6 +20,7 @@
  * and finally report the pass/fail/skip/xfail state of the test with one of:
  *
  *     ksft_test_result(condition, fmt, ...);
+ *     ksft_test_result_report(result, fmt, ...);
  *     ksft_test_result_pass(fmt, ...);
  *     ksft_test_result_fail(fmt, ...);
  *     ksft_test_result_skip(fmt, ...);
@@ -254,6 +255,27 @@ static inline __printf(1, 2) void ksft_test_result_error(const char *msg, ...)
 	va_end(args);
 }
 
+/**
+ * ksft_test_result() - Report test success based on truth of condition
+ *
+ * @condition: if true, report test success, otherwise failure.
+ */
+#define ksft_test_result_report(result, fmt, ...) do {		\
+	switch (result) {					\
+	case KSFT_PASS:						\
+		ksft_test_result_pass(fmt, ##__VA_ARGS__);	\
+		break;						\
+	case KSFT_FAIL:						\
+		ksft_test_result_fail(fmt, ##__VA_ARGS__);	\
+		break;						\
+	case KSFT_XFAIL:					\
+		ksft_test_result_xfail(fmt, ##__VA_ARGS__);	\
+		break;						\
+	case KSFT_SKIP:						\
+		ksft_test_result_skip(fmt, ##__VA_ARGS__);	\
+		break;						\
+	} } while (0)
+
 static inline int ksft_exit_pass(void)
 {
 	ksft_print_cnts();

-- 
2.30.2


