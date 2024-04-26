Return-Path: <linux-kselftest+bounces-8914-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 798C48B364F
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 13:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACA441C21EAD
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 11:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC4D144D3E;
	Fri, 26 Apr 2024 11:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="WUOSdkjH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC91414037C;
	Fri, 26 Apr 2024 11:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714129765; cv=none; b=hS8BcLFVC5oPc8D78FCBHMXaAWJymcv37pmNSZGFI8DDOfuXihVF/LnrjWChC4bjNsAP4i8w+l4dSwl4Um0BmfXykM7Q1Cc2xE/pYEOpztr7dNxPo8frk46UBuWbQG5b2foI4vrf4iIhGDmkow0ROpiNmE2ldW9hlkkQahOIA3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714129765; c=relaxed/simple;
	bh=POPoBWA0zb+CZxTZKQlvH0jHEDfJwJeLYQ/q42Q4tds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WEbDIRwkr5rP0HWZ0piRGFG7TEABSSxa55ssuWj+45EVlfn32slVfWq7NvL2rj1LFf2RG82/kij2EjeDwL0lQJGFSKLC3hSac1Fp2W/DTi7r3+G2XrVHccBI9Bt66/NEZDurBx8w7nzmkxXkDwvA8r6t5Gp0hLOGhDxKsKKenIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=WUOSdkjH; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1714129754;
	bh=POPoBWA0zb+CZxTZKQlvH0jHEDfJwJeLYQ/q42Q4tds=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WUOSdkjHWxDPd0U/iFslTgTmwnqkN7oHeNmu3TUfmmD2kXPvfdpXSBJxbnG0gUhO5
	 4Iy959TvW/Ut+XzIsvyj9xn4C0jNCTNcXVkDLA/9xHmYAnbbAST+VLxuIKfyYEGzlU
	 zyQkCmbE3vy1cTKMa+IRIzPYbPDasA2Q18AN+Y8w=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 26 Apr 2024 13:08:56 +0200
Subject: [PATCH 1/3] selftests/nolibc: introduce condition to run tests
 only on nolibc
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240426-nolibc-strerror-v1-1-76a4c9c5271d@weissschuh.net>
References: <20240426-nolibc-strerror-v1-0-76a4c9c5271d@weissschuh.net>
In-Reply-To: <20240426-nolibc-strerror-v1-0-76a4c9c5271d@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714129753; l=3870;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=POPoBWA0zb+CZxTZKQlvH0jHEDfJwJeLYQ/q42Q4tds=;
 b=HuIlN6rPjhA6VH5rmE3ZlIQZCJFQgnuMWRUt+OWRMPAohYcsyfBBDb6hKa5IVXqkaXqRkW+Wz
 vsK3AM1Q48vCWVLkDrINm3uQTA7rjI5jkheKN/tqvgEKhiWxoHlDZ6C
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Some tests only make sense on nolibc. To avoid gaps in the test numbers
do to inline "#ifdef NOLIBC", add a condition to formally skip these
tests.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 32 +++++++++++++++++-----------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 6161bd57a0c9..dadc9b8f2727 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -64,6 +64,14 @@ static const char *argv0;
 /* will be used by constructor tests */
 static int constructor_test_value;
 
+static const int is_nolibc =
+#ifdef NOLIBC
+	1
+#else
+	0
+#endif
+;
+
 /* definition of a series of tests */
 struct test {
 	const char *name;              /* test name */
@@ -1125,19 +1133,17 @@ int run_stdlib(int min, int max)
 		CASE_TEST(strchr_foobar_z);    EXPECT_STRZR(1, strchr("foobar", 'z')); break;
 		CASE_TEST(strrchr_foobar_o);   EXPECT_STREQ(1, strrchr("foobar", 'o'), "obar"); break;
 		CASE_TEST(strrchr_foobar_z);   EXPECT_STRZR(1, strrchr("foobar", 'z')); break;
-#ifdef NOLIBC
-		CASE_TEST(strlcat_0);          EXPECT_STRBUFEQ(1, strlcat(buf, "bar", 0), buf, 3, "test"); break;
-		CASE_TEST(strlcat_1);          EXPECT_STRBUFEQ(1, strlcat(buf, "bar", 1), buf, 4, "test"); break;
-		CASE_TEST(strlcat_5);          EXPECT_STRBUFEQ(1, strlcat(buf, "bar", 5), buf, 7, "test"); break;
-		CASE_TEST(strlcat_6);          EXPECT_STRBUFEQ(1, strlcat(buf, "bar", 6), buf, 7, "testb"); break;
-		CASE_TEST(strlcat_7);          EXPECT_STRBUFEQ(1, strlcat(buf, "bar", 7), buf, 7, "testba"); break;
-		CASE_TEST(strlcat_8);          EXPECT_STRBUFEQ(1, strlcat(buf, "bar", 8), buf, 7, "testbar"); break;
-		CASE_TEST(strlcpy_0);          EXPECT_STRBUFEQ(1, strlcpy(buf, "bar", 0), buf, 3, "test"); break;
-		CASE_TEST(strlcpy_1);          EXPECT_STRBUFEQ(1, strlcpy(buf, "bar", 1), buf, 3, ""); break;
-		CASE_TEST(strlcpy_2);          EXPECT_STRBUFEQ(1, strlcpy(buf, "bar", 2), buf, 3, "b"); break;
-		CASE_TEST(strlcpy_3);          EXPECT_STRBUFEQ(1, strlcpy(buf, "bar", 3), buf, 3, "ba"); break;
-		CASE_TEST(strlcpy_4);          EXPECT_STRBUFEQ(1, strlcpy(buf, "bar", 4), buf, 3, "bar"); break;
-#endif
+		CASE_TEST(strlcat_0);          EXPECT_STRBUFEQ(is_nolibc, strlcat(buf, "bar", 0), buf, 3, "test"); break;
+		CASE_TEST(strlcat_1);          EXPECT_STRBUFEQ(is_nolibc, strlcat(buf, "bar", 1), buf, 4, "test"); break;
+		CASE_TEST(strlcat_5);          EXPECT_STRBUFEQ(is_nolibc, strlcat(buf, "bar", 5), buf, 7, "test"); break;
+		CASE_TEST(strlcat_6);          EXPECT_STRBUFEQ(is_nolibc, strlcat(buf, "bar", 6), buf, 7, "testb"); break;
+		CASE_TEST(strlcat_7);          EXPECT_STRBUFEQ(is_nolibc, strlcat(buf, "bar", 7), buf, 7, "testba"); break;
+		CASE_TEST(strlcat_8);          EXPECT_STRBUFEQ(is_nolibc, strlcat(buf, "bar", 8), buf, 7, "testbar"); break;
+		CASE_TEST(strlcpy_0);          EXPECT_STRBUFEQ(is_nolibc, strlcpy(buf, "bar", 0), buf, 3, "test"); break;
+		CASE_TEST(strlcpy_1);          EXPECT_STRBUFEQ(is_nolibc, strlcpy(buf, "bar", 1), buf, 3, ""); break;
+		CASE_TEST(strlcpy_2);          EXPECT_STRBUFEQ(is_nolibc, strlcpy(buf, "bar", 2), buf, 3, "b"); break;
+		CASE_TEST(strlcpy_3);          EXPECT_STRBUFEQ(is_nolibc, strlcpy(buf, "bar", 3), buf, 3, "ba"); break;
+		CASE_TEST(strlcpy_4);          EXPECT_STRBUFEQ(is_nolibc, strlcpy(buf, "bar", 4), buf, 3, "bar"); break;
 		CASE_TEST(memcmp_20_20);       EXPECT_EQ(1, memcmp("aaa\x20", "aaa\x20", 4), 0); break;
 		CASE_TEST(memcmp_20_60);       EXPECT_LT(1, memcmp("aaa\x20", "aaa\x60", 4), 0); break;
 		CASE_TEST(memcmp_60_20);       EXPECT_GT(1, memcmp("aaa\x60", "aaa\x20", 4), 0); break;

-- 
2.44.0


