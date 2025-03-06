Return-Path: <linux-kselftest+bounces-28436-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBD4A5591E
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 22:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E91CA189A0F2
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 21:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F7B27602E;
	Thu,  6 Mar 2025 21:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="cqPuKS7e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F691DDA8;
	Thu,  6 Mar 2025 21:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741297968; cv=none; b=Jw5aO4Q6OIwK+cr68PgGECINWyTyh6JRme9IQQMtyZtQjjCKeE9+5PV3U4Ikoj5CKiYp2kPyQivohaW6+4uZFumD3gZMMDsxmg9Pekf9TU0VyQEitupOr0H41ZyRuRSz7CA6wXFDHEEkUEZs2tPMucwzqGDeOU2h797El/w2fzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741297968; c=relaxed/simple;
	bh=7wVgWBRDUJlUttB3BlVjaM6DlUTq6z2IS8dEsfDLF2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gTQBJT0SfX1XXk4ma7soE0Cda6VhCIOpkbIWH33GuH8fxQhMe+7NmCBub2NlsY4zyqTYNma7518318Wz5jEZwg8TUVQKYXDXO1t9kalYuDg1s902DwXZmrC0QWq+wSXy3VMFY28ypTDjyC+uvGsHMfhUYr9BkU0O+ukUBjp4JeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=cqPuKS7e; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1741297964;
	bh=7wVgWBRDUJlUttB3BlVjaM6DlUTq6z2IS8dEsfDLF2I=;
	h=From:Date:Subject:To:Cc:From;
	b=cqPuKS7eTlfKXMuOKCpLJtP7ezS/Otr/OCAYwBpeln4i/Ps31DBQatUNDNgIr1SB3
	 CZNezFaiw0rb2/mzhIfbT9WFP+SG2rpGNIC6dC93XL2812BH4zY0gq9RlQWXHo6KwH
	 mfrOYFbL9R6/jtLhdozJCgGrJtMWiHf5kStj9odM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 06 Mar 2025 22:52:39 +0100
Subject: [PATCH] selftests/nolibc: stop testing constructor order
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250306-nolibc-constructor-order-v1-1-68fd161cc5ec@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIACYZymcC/x3MTQqDQAxA4atI1gbmB6XTq4gLG6MNlIlkVAri3
 Tt0+S3eu6CwCRd4NhcYn1JEc4VvG6D3lFdGmashuNC56HrM+pEXIWkuux20q6HazIZ9Cp4flGK
 XPNR8M17k+18P433/AFqUq3hqAAAA
X-Change-ID: 20250306-nolibc-constructor-order-6921e8c93591
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741297963; l=3381;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=7wVgWBRDUJlUttB3BlVjaM6DlUTq6z2IS8dEsfDLF2I=;
 b=Rf0hF1u9hBd0iD1ZPJNzlPZGDMkGp+3UnBGCw1RMCrrUrxoU8fiaj/JsmDShe66duT3DxdsVD
 4niKnSQpwhoCqdUYW/XvOpvQVtcxOo0Fm0yfTWZZmbnCJLYEOHD4CS1
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The execution order of constructors in undefined and depends on the
toolchain.  While recent toolchains seems to have a stable order, it
doesn't work for older ones and may also change at any time.

Stop validating the order and instead only validate that all
constructors are executed.

Reported-by: Willy Tarreau <w@1wt.eu>
Closes: https://lore.kernel.org/lkml/20250301110735.GA18621@1wt.eu/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test-linkage.c | 6 +++---
 tools/testing/selftests/nolibc/nolibc-test.c         | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test-linkage.c b/tools/testing/selftests/nolibc/nolibc-test-linkage.c
index 5ff4c8a1db2a46cf3f8cb55bdabaa5e8819b344c..a7ca8325863face9cd4134a717fe4c7761bdeb7f 100644
--- a/tools/testing/selftests/nolibc/nolibc-test-linkage.c
+++ b/tools/testing/selftests/nolibc/nolibc-test-linkage.c
@@ -11,16 +11,16 @@ void *linkage_test_errno_addr(void)
 	return &errno;
 }
 
-int linkage_test_constructor_test_value;
+int linkage_test_constructor_test_value = 0;
 
 __attribute__((constructor))
 static void constructor1(void)
 {
-	linkage_test_constructor_test_value = 2;
+	linkage_test_constructor_test_value |= 1 << 0;
 }
 
 __attribute__((constructor))
 static void constructor2(void)
 {
-	linkage_test_constructor_test_value *= 3;
+	linkage_test_constructor_test_value |= 1 << 1;
 }
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index a5abf16dbfe0f2aed286964fdfc391bc6201ef3b..5884a891c491544050fc35b07322c73a1a9dbaf3 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -692,14 +692,14 @@ int expect_strtox(int llen, void *func, const char *input, int base, intmax_t ex
 __attribute__((constructor))
 static void constructor1(void)
 {
-	constructor_test_value = 1;
+	constructor_test_value |= 1 << 0;
 }
 
 __attribute__((constructor))
 static void constructor2(int argc, char **argv, char **envp)
 {
 	if (argc && argv && envp)
-		constructor_test_value *= 2;
+		constructor_test_value |= 1 << 1;
 }
 
 int run_startup(int min, int max)
@@ -738,9 +738,9 @@ int run_startup(int min, int max)
 		CASE_TEST(environ_HOME);     EXPECT_PTRNZ(1, getenv("HOME")); break;
 		CASE_TEST(auxv_addr);        EXPECT_PTRGT(test_auxv != (void *)-1, test_auxv, brk); break;
 		CASE_TEST(auxv_AT_UID);      EXPECT_EQ(1, getauxval(AT_UID), getuid()); break;
-		CASE_TEST(constructor);      EXPECT_EQ(is_nolibc, constructor_test_value, 2); break;
+		CASE_TEST(constructor);      EXPECT_EQ(is_nolibc, constructor_test_value, 0x3); break;
 		CASE_TEST(linkage_errno);    EXPECT_PTREQ(1, linkage_test_errno_addr(), &errno); break;
-		CASE_TEST(linkage_constr);   EXPECT_EQ(is_nolibc, linkage_test_constructor_test_value, 6); break;
+		CASE_TEST(linkage_constr);   EXPECT_EQ(1, linkage_test_constructor_test_value, 0x3); break;
 		case __LINE__:
 			return ret; /* must be last */
 		/* note: do not set any defaults so as to permit holes above */

---
base-commit: 6e406202a44a1a37176da0333cec10d5320c4b33
change-id: 20250306-nolibc-constructor-order-6921e8c93591

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


