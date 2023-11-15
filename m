Return-Path: <linux-kselftest+bounces-183-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 109577ED5A8
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 22:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A40EEB20CB7
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 21:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1165545BFE;
	Wed, 15 Nov 2023 21:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="QxQFiyVs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABBAB7;
	Wed, 15 Nov 2023 13:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1700082503;
	bh=l0DjQT50wWPCx8bAIk7vWf2LX6LEwzHNYtmJlA8L6J0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QxQFiyVsIc6a5YV70upXPlmTRX4ZkcpR0v8ekrkfswJGaLF2P/0k24GAnrzTFbT7c
	 j9IXsg6HyOtECGGmtWxa3NLU+qqTvrzdRKUlSSC+L4H2mgF4IMw5jxroh8vxY0Nbki
	 fHm/MF7imxuvdmmGYaYZgqY6sYsWhd1nBQsXIhxc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 15 Nov 2023 22:08:21 +0100
Subject: [PATCH RFC 3/3] selftests/nolibc: migrate vfprintf tests to new
 harness
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231115-nolibc-harness-v1-3-4d61382d9bf3@weissschuh.net>
References: <20231115-nolibc-harness-v1-0-4d61382d9bf3@weissschuh.net>
In-Reply-To: <20231115-nolibc-harness-v1-0-4d61382d9bf3@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700082502; l=4412;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=l0DjQT50wWPCx8bAIk7vWf2LX6LEwzHNYtmJlA8L6J0=;
 b=D5ubOmECihDPDmd+UIRvHxT53OEDtxVHsJ8JxG5/5/6M0grUKMZjRz3CZcM3KiTTNpKB0bKp7
 iBnTQFNFLhQCExPNZs6sZVF7T6HxzJEll+TB2zy9EwZStzdAmVmzyaB
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Migrate part of nolibc-test.c to the new test harness.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 74 +++++++++++-----------------
 1 file changed, 28 insertions(+), 46 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 6c1b42b58e3e..c0e7e090a05a 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1039,10 +1039,13 @@ int run_stdlib(int min, int max)
 	return ret;
 }
 
-#define EXPECT_VFPRINTF(c, expected, fmt, ...)				\
-	ret += expect_vfprintf(llen, c, expected, fmt, ##__VA_ARGS__)
+#define ASSERT_VFPRINTF(c, expected, fmt, ...)				\
+	enum RESULT res = assert_vfprintf(_metadata, c, expected, fmt, ##__VA_ARGS__); \
+	if (res == SKIPPED) SKIP(return); \
+	if (res == FAIL) FAIL(return);
 
-static int expect_vfprintf(int llen, int c, const char *expected, const char *fmt, ...)
+static enum RESULT assert_vfprintf(struct __test_metadata *_metadata, int c,
+				   const char *expected, const char *fmt, ...)
 {
 	int ret, fd;
 	ssize_t w, r;
@@ -1051,25 +1054,20 @@ static int expect_vfprintf(int llen, int c, const char *expected, const char *fm
 	va_list args;
 
 	fd = open("/tmp", O_TMPFILE | O_EXCL | O_RDWR, 0600);
-	if (fd == -1) {
-		result(llen, SKIPPED);
-		return 0;
-	}
+	if (fd == -1)
+		return SKIPPED;
 
 	memfile = fdopen(fd, "w+");
-	if (!memfile) {
-		result(llen, FAIL);
-		return 1;
-	}
+	if (!memfile)
+		return FAIL;
 
 	va_start(args, fmt);
 	w = vfprintf(memfile, fmt, args);
 	va_end(args);
 
 	if (w != c) {
-		llen += printf(" written(%d) != %d", (int)w, c);
-		result(llen, FAIL);
-		return 1;
+		_metadata->exe.llen += printf(" written(%d) != %d", (int)w, c);
+		return FAIL;
 	}
 
 	fflush(memfile);
@@ -1080,46 +1078,30 @@ static int expect_vfprintf(int llen, int c, const char *expected, const char *fm
 	fclose(memfile);
 
 	if (r != w) {
-		llen += printf(" written(%d) != read(%d)", (int)w, (int)r);
-		result(llen, FAIL);
-		return 1;
+		_metadata->exe.llen += printf(" written(%d) != read(%d)", (int)w, (int)r);
+		return FAIL;
 	}
 
 	buf[r] = '\0';
-	llen += printf(" \"%s\" = \"%s\"", expected, buf);
+	_metadata->exe.llen += printf(" \"%s\" = \"%s\"", expected, buf);
 	ret = strncmp(expected, buf, c);
 
-	result(llen, ret ? FAIL : OK);
-	return ret;
+	return ret ? FAIL : OK;
 }
 
-static int run_vfprintf(int min, int max)
+TEST(vfprintf, empty)     { ASSERT_VFPRINTF(0, "", ""); }
+TEST(vfprintf, simple)    { ASSERT_VFPRINTF(3, "foo", "foo"); }
+TEST(vfprintf, string)    { ASSERT_VFPRINTF(3, "foo", "%s", "foo"); }
+TEST(vfprintf, number)    { ASSERT_VFPRINTF(4, "1234", "%d", 1234); }
+TEST(vfprintf, negnumber) { ASSERT_VFPRINTF(5, "-1234", "%d", -1234); }
+TEST(vfprintf, unsigned)  { ASSERT_VFPRINTF(5, "12345", "%u", 12345); }
+TEST(vfprintf, char)      { ASSERT_VFPRINTF(1, "c", "%c", 'c'); }
+TEST(vfprintf, hex)       { ASSERT_VFPRINTF(1, "f", "%x", 0xf); }
+TEST(vfprintf, pointer)   { ASSERT_VFPRINTF(3, "0x1", "%p", (void *) 0x1); }
+
+int run_vfprintf(int min, int max)
 {
-	int test;
-	int ret = 0;
-
-	for (test = min; test >= 0 && test <= max; test++) {
-		int llen = 0; /* line length */
-
-		/* avoid leaving empty lines below, this will insert holes into
-		 * test numbers.
-		 */
-		switch (test + __LINE__ + 1) {
-		CASE_TEST(empty);        EXPECT_VFPRINTF(0, "", ""); break;
-		CASE_TEST(simple);       EXPECT_VFPRINTF(3, "foo", "foo"); break;
-		CASE_TEST(string);       EXPECT_VFPRINTF(3, "foo", "%s", "foo"); break;
-		CASE_TEST(number);       EXPECT_VFPRINTF(4, "1234", "%d", 1234); break;
-		CASE_TEST(negnumber);    EXPECT_VFPRINTF(5, "-1234", "%d", -1234); break;
-		CASE_TEST(unsigned);     EXPECT_VFPRINTF(5, "12345", "%u", 12345); break;
-		CASE_TEST(char);         EXPECT_VFPRINTF(1, "c", "%c", 'c'); break;
-		CASE_TEST(hex);          EXPECT_VFPRINTF(1, "f", "%x", 0xf); break;
-		CASE_TEST(pointer);      EXPECT_VFPRINTF(3, "0x1", "%p", (void *) 0x1); break;
-		case __LINE__:
-			return ret; /* must be last */
-		/* note: do not set any defaults so as to permit holes above */
-		}
-	}
-	return ret;
+	return run_test_suite("vfprintf", min, max);
 }
 
 static int smash_stack(void)

-- 
2.42.1


