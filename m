Return-Path: <linux-kselftest+bounces-5066-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC43585C4AB
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 20:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 624021F251E9
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 19:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040CB14E2DB;
	Tue, 20 Feb 2024 19:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzhjzG7l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC11E14E2C3;
	Tue, 20 Feb 2024 19:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456970; cv=none; b=a5otnL88jEKQdLYIRGNXcWo2xCel333irgmrKlgcqJHPg2/RjVzBjb2/H2XC2h2PeBX/A5u0pZg86BV4BHLm3UaVItdke/F6k/zYXKBAl04/WYhMS4p5YVQzn1EA8qDsNKV5Y3LXIRNOJz63e3JaRLvo0Mv3ogt1fC/AJSe9yfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456970; c=relaxed/simple;
	bh=dOHmxdg3EP760oxxQuwhluOWp5ADJEFGi+z4Te1Ix98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fcmJQuW7TPfHduMWrPtt+55YIUAptn9uc0m4PQtIa3BKjoXE9grPSqZRzzpp0Fa6GSD5N8asSSkzIQgwoJR091xsRwDLEW5iGlBtr6uXvqvd1nxReBWSfIvXbaxYWwbbr8tOlz34bEkgYBgG/YKOtZAkgOZVvI737TpsIctzCEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzhjzG7l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02831C433F1;
	Tue, 20 Feb 2024 19:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708456970;
	bh=dOHmxdg3EP760oxxQuwhluOWp5ADJEFGi+z4Te1Ix98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EzhjzG7lxvTipRQSfDA59QNrA/VebCwHM591nOKvV+80vxub9BgqGaWauDmDFayow
	 7SPiWjoxu5wcLupYoezmoL+Dj2bX3AmW2afJEVc4MV1zZC1LRdBP5HLnBm9SR5ve0q
	 b8wnGd6SKVWLaY6dLpiVRvBrEhWBHsFF6DBhmQkZ73Ix9BuyQP05Cs0MNn1byVv/rt
	 HSf1ZxDib0fNy7+Av4lQhUaU31e1kKWMDMdW5x2TGCFG46uxyVULJmzRsSlZGb6237
	 I/QygWWXJfVRQzvn8+y3YWKK5PuvyLGvlmtRgElcVNekk0F/iC9fULWX+Xf+HB4gRc
	 LojDXgWvSG9wQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	mic@digikod.net,
	linux-security-module@vger.kernel.org,
	keescook@chromium.org,
	jakub@cloudflare.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 07/11] selftests: kselftest_harness: print test name for SKIP
Date: Tue, 20 Feb 2024 11:22:31 -0800
Message-ID: <20240220192235.2953484-8-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220192235.2953484-1-kuba@kernel.org>
References: <20240220192235.2953484-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jakub points out that for parsers it's rather useful to always
have the test name on the result line. Currently if we SKIP
(or soon XFAIL or XPASS), we will print:

ok 17 # SKIP SCTP doesn't support IP_BIND_ADDRESS_NO_PORT

     ^
     no test name

Always print the test name.
KTAP format seems to allow or even call for it, per:
https://docs.kernel.org/dev-tools/ktap.html

Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Link: https://lore.kernel.org/all/87jzn6lnou.fsf@cloudflare.com/
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/kselftest.h         | 7 ++++---
 tools/testing/selftests/kselftest_harness.h | 3 ++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 12ad7f8dfe3a..25e29626566e 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -255,8 +255,9 @@ static inline __printf(1, 2) void ksft_test_result_error(const char *msg, ...)
 	va_end(args);
 }
 
-static inline __printf(2, 3)
-void ksft_test_result_code(int exit_code, const char *msg, ...)
+static inline __printf(3, 4)
+void ksft_test_result_code(int exit_code, const char *test_name,
+			   const char *msg, ...)
 {
 	const char *tap_code = "ok";
 	const char *directive = "";
@@ -287,7 +288,7 @@ void ksft_test_result_code(int exit_code, const char *msg, ...)
 	}
 
 	va_start(args, msg);
-	printf("%s %u%s", tap_code, ksft_test_num(), directive);
+	printf("%s %u %s%s", tap_code, ksft_test_num(), test_name, directive);
 	errno = saved_errno;
 	vprintf(msg, args);
 	va_end(args);
diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 684c5676dfcb..a1a794e4b8f6 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -1151,7 +1151,8 @@ void __run_test(struct __fixture_metadata *f,
 		diagnostic = "unknown";
 
 	if (t->exit_code == KSFT_SKIP)
-		ksft_test_result_code(t->exit_code, "%s\n", diagnostic);
+		ksft_test_result_code(t->exit_code, test_name,
+				      "%s\n", diagnostic);
 	else
 		ksft_test_result(__test_passed(t), "%s\n", test_name);
 }
-- 
2.43.0


