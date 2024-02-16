Return-Path: <linux-kselftest+bounces-4832-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C60D08572B2
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 01:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD3EE1C238DE
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 00:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8583610B;
	Fri, 16 Feb 2024 00:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMw2+K92"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F51D2F0;
	Fri, 16 Feb 2024 00:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708044091; cv=none; b=mAolvvlQVmgVSTKkZqf6lfcYm/CxD2lbDyNt2FnQXFgRKY8oe7cQToe9XTxERP46cGOMtR/8SI8YAH3KfGL1MNl1uUSwjGVTMV5bdWrh5h6zY04HE7qWHkG3o5haTpYH5ivRYPa9lUJ/GZokmJvYSb6VHWlf0HkEZX1OZStXL/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708044091; c=relaxed/simple;
	bh=PUYSnoEiqdY/3A4RqbDDuJYK260acc9oXybD55EpoQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OIU6qEMYLQHvJlUGQ9zJ6dQZLHW0Xi0/gbplM6APHr4cT1OAAMx7Aw4Eaw8Su6W6SGcpoU71+iu4QtQ48RSw0V32hTeBd9AE3wQpwjQLyslSD0zfOp3oyX4Z4sxOpiRv3k0yDecGcwidFWC9O5BynOZEHKjybtq+63FxRC5iXT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMw2+K92; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA07C433C7;
	Fri, 16 Feb 2024 00:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708044091;
	bh=PUYSnoEiqdY/3A4RqbDDuJYK260acc9oXybD55EpoQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CMw2+K92CX49nkW1XEBPNbb5daXNgI3ZHSnFnA+kB/ZKQbhG4uCcHFTxqt6xpVt0v
	 +VN4tIvo2AO2dU5OYJp2k2moXXhIQWVho2uMuMha/OtUbSzH26Xstx3BXW1plU2HSM
	 VvM2c+xfFaCy3cpv6FtjIKFkhUoH7CE9rciRxMxOwfaccIUyZAqtxfMUumPLjBDZza
	 w0cqTxEepBN2+mvizn5kqeNTo6ezcm41Y/BsEsFZul3e0K5JbwCI40iWntRNN2rysS
	 g5+MRkreHKmYSxTcqXWRaI+hz6CMuIu+pf0iFJgoyZdNRxjiAv6KRGrNhHnCW/V19P
	 eBXQ4V7ou6C0Q==
From: Jakub Kicinski <kuba@kernel.org>
To: jakub@cloudflare.com
Cc: shuah@kernel.org,
	keescook@chromium.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC 5/7] selftests: kselftest_harness: print test name for SKIP and XFAIL
Date: Thu, 15 Feb 2024 16:41:20 -0800
Message-ID: <20240216004122.2004689-6-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216004122.2004689-1-kuba@kernel.org>
References: <20240216004122.2004689-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jakub points out that for parsers it's rather useful to always
have the test name on the result line. Currently if we SKIP
or XFAIL, we will print:

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
index 79a3fec0cefa..beae50fd5ac3 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -1178,7 +1178,8 @@ void __run_test(struct __fixture_metadata *f,
 		diagnostic = "unknown";
 
 	if (t->exit_code == KSFT_SKIP || t->exit_code == KSFT_XFAIL)
-		ksft_test_result_code(t->exit_code, "%s\n", diagnostic);
+		ksft_test_result_code(t->exit_code, test_name,
+				      "%s\n", diagnostic);
 	else
 		ksft_test_result(__test_passed(t), "%s\n", test_name);
 }
-- 
2.43.0


