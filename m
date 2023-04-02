Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A934F6D3806
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Apr 2023 15:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjDBNC4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 2 Apr 2023 09:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjDBNCy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 2 Apr 2023 09:02:54 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A0311155;
        Sun,  2 Apr 2023 06:02:52 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1680440571;
        bh=XslKaVqkZRJWWcajYBGB4tWOiC4UW2nlnB382eAXHxc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=msmqM2dQ3kAiWKucBkxXplxVGB2jMEBPZRLYrjyv8WZlD+E276wbrK555iilnCOEq
         SiHlXDopE9sV+wPUM80DE+OhR91m2YTGxTQxQaokv+a9q5NOuZVyPTEm1qX4UTLUIW
         ofjtLoeq4QVTm14KGiCJxWC3bYmUswI73Q+m8g50=
Date:   Sun, 02 Apr 2023 13:02:47 +0000
Subject: [PATCH v2 3/3] tools/nolibc: add testcases for vfprintf
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230328-nolibc-printf-test-v2-3-f72bdf210190@weissschuh.net>
References: <20230328-nolibc-printf-test-v2-0-f72bdf210190@weissschuh.net>
In-Reply-To: <20230328-nolibc-printf-test-v2-0-f72bdf210190@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680440570; l=3312;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=XslKaVqkZRJWWcajYBGB4tWOiC4UW2nlnB382eAXHxc=;
 b=vzNuipwmsMWMEEg1jyjZTdKduVLj7U5A3uQYanHsSo+Z5QTnoxqCOKuIxfYn0MV2uEmx8h9+5
 Zt1lBrDVzy1BD3gKaJLtZT4K23noI7BkiGunGkkWqO4nr8+Pots53Ma
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

vfprintf() is complex and so far did not have proper tests.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 78 ++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 47013b78972e..25a64bda2722 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -20,6 +20,7 @@
 #include <linux/reboot.h>
 #include <sys/io.h>
 #include <sys/ioctl.h>
+#include <sys/mman.h>
 #include <sys/mount.h>
 #include <sys/reboot.h>
 #include <sys/stat.h>
@@ -667,6 +668,82 @@ int run_stdlib(int min, int max)
 	return ret;
 }
 
+#define EXPECT_VFPRINTF(c, expected, fmt, ...)				\
+	ret += expect_vfprintf(llen, c, expected, fmt, ##__VA_ARGS__)
+
+static int expect_vfprintf(int llen, size_t c, const char *expected, const char *fmt, ...)
+{
+	int ret, fd, w, r;
+	char buf[100];
+	va_list args;
+
+	fd = memfd_create("vfprintf", 0);
+	if (fd == -1) {
+		pad_spc(llen, 64, "[FAIL]\n");
+		return 1;
+	}
+
+	va_start(args, fmt);
+	w = vfprintf(fdopen(fd, "w+"), fmt, args);
+	va_end(args);
+
+	if (w != c) {
+		llen += printf(" written(%d) != %d", w, (int) c);
+		pad_spc(llen, 64, "[FAIL]\n");
+		return 1;
+	}
+
+	lseek(fd, 0, SEEK_SET);
+
+	r = read(fd, buf, sizeof(buf) - 1);
+	buf[r] = '\0';
+
+	close(fd);
+
+	if (r != w) {
+		llen += printf(" written(%d) != read(%d)", w, r);
+		pad_spc(llen, 64, "[FAIL]\n");
+		return 1;
+	}
+
+	llen += printf(" \"%s\" = \"%s\"", expected, buf);
+	ret = strncmp(expected, buf, c);
+
+	pad_spc(llen, 64, ret ? "[FAIL]\n" : " [OK]\n");
+	return ret;
+}
+
+static int run_vfprintf(int min, int max)
+{
+	int test;
+	int tmp;
+	int ret = 0;
+	void *p1, *p2;
+
+	for (test = min; test >= 0 && test <= max; test++) {
+		int llen = 0; // line length
+
+		/* avoid leaving empty lines below, this will insert holes into
+		 * test numbers.
+		 */
+		switch (test + __LINE__ + 1) {
+		CASE_TEST(empty);        EXPECT_VFPRINTF(0, "", ""); break;
+		CASE_TEST(simple);       EXPECT_VFPRINTF(3, "foo", "foo"); break;
+		CASE_TEST(string);       EXPECT_VFPRINTF(3, "foo", "%s", "foo"); break;
+		CASE_TEST(number);       EXPECT_VFPRINTF(4, "1234", "%d", 1234); break;
+		CASE_TEST(negnumber);    EXPECT_VFPRINTF(5, "-1234", "%d", -1234); break;
+		CASE_TEST(unsigned);     EXPECT_VFPRINTF(5, "12345", "%u", 12345); break;
+		CASE_TEST(char);         EXPECT_VFPRINTF(1, "c", "%c", 'c'); break;
+		CASE_TEST(hex);          EXPECT_VFPRINTF(1, "f", "%x", 0xf); break;
+		CASE_TEST(pointer);      EXPECT_VFPRINTF(3, "0x0", "%p", NULL); break;
+		case __LINE__:
+			return ret; /* must be last */
+		/* note: do not set any defaults so as to permit holes above */
+		}
+	}
+	return ret;
+}
+
 static int smash_stack(void)
 {
 	char buf[100];
@@ -774,6 +851,7 @@ static const struct test test_names[] = {
 	/* add new tests here */
 	{ .name = "syscall",    .func = run_syscall    },
 	{ .name = "stdlib",     .func = run_stdlib     },
+	{ .name = "vfprintf",   .func = run_vfprintf   },
 	{ .name = "protection", .func = run_protection },
 	{ 0 }
 };

-- 
2.40.0

