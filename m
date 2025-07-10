Return-Path: <linux-kselftest+bounces-36948-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC33BAFFF79
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 12:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C95171C847BB
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 10:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007422D9787;
	Thu, 10 Jul 2025 10:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="M0mmErND"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA731FBEA2
	for <linux-kselftest@vger.kernel.org>; Thu, 10 Jul 2025 10:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752144211; cv=none; b=MP61ItlEwHPb1jNFNXsbMeNMSjlPHCImlkXb7XCxaOacbVoUha7Tj2vqbqYfA/lI4b1ECjhVGLBciGtt8Bm8L+173TVvktNgReX9v16uBiW+0foUEPFAluFWv1JPuPSFd6cGGnQzxD0dKOzJ2VVTX3eqgmLOK3e0V/2mlpw7v3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752144211; c=relaxed/simple;
	bh=d3sxZXjRC82xGNolWwhyJmdLgIPOD3WJS5LohzNkaZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xnd1/fkqsb4TJxk+RCjNcSDPR2seV+cDGR+B2DwqkR4bBOVIvzminjgW+qK0bb9h4IuZQT2qnOkcL1QaS/0upwXxOD+xskrMq1EzY4ZDHqq342+vqjTYhj5C/1OqVjAAIFsdC8ECNYS4z/MMD9zEtAO7sLXdnjbkSBFdEw8F2Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=M0mmErND; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ZoUHxs4e+VTXuo3zHAuSxfrKp6MVarGo+9atE96CX/4=;
	t=1752144210; x=1753353810; b=M0mmErNDq0Hi32lTouH0xukEuQmWkUglEtfoVsOR/lHLLOM
	lJ0Lbz826lL68LWlDEKDHllG+rb6o8BOHSmMSGIpvdn0ObjDqBzgqGuJ3FMZW+GYmOXBdhlMWipTH
	odP1w2iWIoB7cq70/9wMkyni8fUxgD880KV8mgq+x7H9805ze/UorzpHgav+imPWrdvnuoPeY7bOz
	QVW6AbBOe/DkguvuCnT4ySduA0XSh5a6B5ifbjI/zrNpmgB0GGX9GDBtgfbx15U3I3G0ciGric/AY
	UQ8XW45kDPG8dyKyS/s9hREkxhZADS3dCiVVWdj57mmuLhAoooW/9In0jA8RbT8Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uZokM-0000000Eg4e-3Vgz;
	Thu, 10 Jul 2025 12:43:23 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 2/4] selftests/nolibc: validate order of constructor calls
Date: Thu, 10 Jul 2025 12:39:48 +0200
Message-ID: <20250710103950.1272379-3-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250710103950.1272379-1-benjamin@sipsolutions.net>
References: <20250710103950.1272379-1-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

Add new helpers to track multiple steps as bits in an integer. Store
each step in a bit and use the lowest bit to store whether all steps
occurred in the correct order and only once.

Use this for the constructor tests.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

---

v2:
- Newly added patch
---
 .../selftests/nolibc/nolibc-test-linkage.c    | 17 ++++++++--
 tools/testing/selftests/nolibc/nolibc-test.c  | 31 ++++++++++++++++---
 2 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test-linkage.c b/tools/testing/selftests/nolibc/nolibc-test-linkage.c
index 0636d1b6e808..4435f389570b 100644
--- a/tools/testing/selftests/nolibc/nolibc-test-linkage.c
+++ b/tools/testing/selftests/nolibc/nolibc-test-linkage.c
@@ -4,6 +4,19 @@
 
 #include <errno.h>
 
+/*
+ * Set BIT(step + 1), BIT(0) shows whether all steps ran once and in order
+ *
+ * Copied from nolibc-test.c.
+ */
+#define MARK_STEP_DONE(val, step) do {					\
+	if ((val) == 0 && (step) == 0)					\
+		(val) |= 0x1;						\
+	else if (!(val & (1 << (step))) || (val) & (1 << ((step) + 1)))	\
+		(val) &= ~0x1;						\
+	(val) |= 1 << ((step) + 1);					\
+	} while (0)
+
 void *linkage_test_errno_addr(void)
 {
 	return &errno;
@@ -14,11 +27,11 @@ int linkage_test_constructor_test_value = 0;
 __attribute__((constructor))
 static void constructor1(void)
 {
-	linkage_test_constructor_test_value |= 1 << 0;
+	MARK_STEP_DONE(linkage_test_constructor_test_value, 0);
 }
 
 __attribute__((constructor))
 static void constructor2(void)
 {
-	linkage_test_constructor_test_value |= 1 << 1;
+	MARK_STEP_DONE(linkage_test_constructor_test_value, 1);
 }
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 97efc98b6a3d..d612150d2ea3 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -72,6 +72,15 @@ static const int is_nolibc =
 #endif
 ;
 
+/* Set BIT(step + 1), BIT(0) shows whether all steps ran once and in order */
+#define MARK_STEP_DONE(val, step) do {					\
+	if ((val) == 0 && (step) == 0)					\
+		(val) |= 0x1;						\
+	else if ((val) & (1 << ((step) + 1)) || !(val & (1 << (step))))	\
+		(val) &= ~0x1;						\
+	(val) |= 1 << ((step) + 1);					\
+	} while (0)
+
 /* definition of a series of tests */
 struct test {
 	const char *name;              /* test name */
@@ -389,6 +398,20 @@ int expect_syserr2(int expr, int expret, int experr1, int experr2, int llen)
 }
 
 
+#define EXPECT_STEPS(cond, expr, num_steps)			\
+	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_steps(expr, llen, num_steps); } while (0)
+
+static __attribute__((unused))
+int expect_steps(uint64_t expr, int llen, int num_steps)
+{
+	int ret = !(expr == ((uint64_t)1 << (num_steps + 1)) - 1);
+
+	llen += printf(" = %llx ", (long long)expr);
+	result(llen, ret ? FAIL : OK);
+	return ret;
+}
+
+
 #define EXPECT_PTRZR(cond, expr)				\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptrzr(expr, llen); } while (0)
 
@@ -690,14 +713,14 @@ int expect_strtox(int llen, void *func, const char *input, int base, intmax_t ex
 __attribute__((constructor))
 static void constructor1(void)
 {
-	constructor_test_value |= 1 << 0;
+	MARK_STEP_DONE(constructor_test_value, 0);
 }
 
 __attribute__((constructor))
 static void constructor2(int argc, char **argv, char **envp)
 {
 	if (argc && argv && envp)
-		constructor_test_value |= 1 << 1;
+		MARK_STEP_DONE(constructor_test_value, 1);
 }
 
 int run_startup(int min, int max)
@@ -736,9 +759,9 @@ int run_startup(int min, int max)
 		CASE_TEST(environ_HOME);     EXPECT_PTRNZ(1, getenv("HOME")); break;
 		CASE_TEST(auxv_addr);        EXPECT_PTRGT(test_auxv != (void *)-1, test_auxv, brk); break;
 		CASE_TEST(auxv_AT_UID);      EXPECT_EQ(1, getauxval(AT_UID), getuid()); break;
-		CASE_TEST(constructor);      EXPECT_EQ(is_nolibc, constructor_test_value, 0x3); break;
+		CASE_TEST(constructor);      EXPECT_STEPS(is_nolibc, constructor_test_value, 2); break;
 		CASE_TEST(linkage_errno);    EXPECT_PTREQ(1, linkage_test_errno_addr(), &errno); break;
-		CASE_TEST(linkage_constr);   EXPECT_EQ(1, linkage_test_constructor_test_value, 0x3); break;
+		CASE_TEST(linkage_constr);   EXPECT_STEPS(1, linkage_test_constructor_test_value, 2); break;
 		case __LINE__:
 			return ret; /* must be last */
 		/* note: do not set any defaults so as to permit holes above */
-- 
2.50.0


