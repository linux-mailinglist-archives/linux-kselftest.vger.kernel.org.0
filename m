Return-Path: <linux-kselftest+bounces-5573-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8357E86BDC8
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 02:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 118C52850DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 01:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8240F3C49A;
	Thu, 29 Feb 2024 00:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cR1xXo+Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6DC3AC1E;
	Thu, 29 Feb 2024 00:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709168372; cv=none; b=M9rgnGIEq8o/K5nFYyfC3+Y6/57IgEpxK7rGX5g1CLYZ6vpe7cQZGE/T13fulnqXKkuzwqKkbYRCJ8k7mfT/G7WQ35QSXfc82xX2imdmNtHvpN1sGLeNeaUChedsT2k69UMclo36KUc42F2+7r9lCvaDTafVxwM7fz897mboPEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709168372; c=relaxed/simple;
	bh=kUXNicxEFPS6Tw9TLyUiMTsBYRZKhgDBnAsNtFKri38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dSOuBLqt8BFOrCArQy4haTBdW8RGU1+oo+mzdwRYMzM5g39o3dSEq0WnZqVG8ZqTnPuQMbf2zWiNc/wvu76G0MwC5Ef6mOi//pLJM4AVuzK/zv6NCmjdLceTxTZcki0yplrXw3XIh2h9KOHdkHw88LnuQFwndP8IUE8BhZDihYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cR1xXo+Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877FDC43390;
	Thu, 29 Feb 2024 00:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709168371;
	bh=kUXNicxEFPS6Tw9TLyUiMTsBYRZKhgDBnAsNtFKri38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cR1xXo+YAKlwYOKBuI6WmDZOK4s4h5daoh/Pgj+ToXvARbbPkuY7GjM2wGMiDv88w
	 ap3z/GH7Le7eF2JnlJzxmnfKYQZA+tZc0JjJfNx2vFY2ja8nCqLekfxsVZ7iB5Vo3b
	 r3d7p9oryxbX/fKdqwIfEHWacwlnfO+kbdM/REySPTUJAexYcARgI+RyL2cScS2wbE
	 nhMtlUWzyg5rx6KzA7VFwRcerj4BZnsVxe7uprYeu5oOogvi3Ymiz03Pc66TA2lTYf
	 BDpNSX+Zuf31LjrUEkiqHibSQc4Fl9LpZ7A0x2821000BNQhmO55mfgmQCvk+x8/mA
	 QGiDunw8CjoXQ==
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
Subject: [PATCH v4 08/12] selftests: kselftest_harness: print test name for SKIP
Date: Wed, 28 Feb 2024 16:59:15 -0800
Message-ID: <20240229005920.2407409-9-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240229005920.2407409-1-kuba@kernel.org>
References: <20240229005920.2407409-1-kuba@kernel.org>
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
Reviewed-by: Kees Cook <keescook@chromium.org>
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
index 4fb30fcc7774..82377051aa54 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -1147,7 +1147,8 @@ void __run_test(struct __fixture_metadata *f,
 		diagnostic = "unknown";
 
 	if (t->exit_code == KSFT_SKIP)
-		ksft_test_result_code(t->exit_code, "%s\n", diagnostic);
+		ksft_test_result_code(t->exit_code, test_name,
+				      "%s\n", diagnostic);
 	else
 		ksft_test_result(__test_passed(t), "%s\n", test_name);
 }
-- 
2.43.2


