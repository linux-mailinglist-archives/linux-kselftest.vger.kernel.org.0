Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05376D39B3
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Apr 2023 20:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjDBSEs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 2 Apr 2023 14:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjDBSEr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 2 Apr 2023 14:04:47 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5DA5255;
        Sun,  2 Apr 2023 11:04:45 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1680458683;
        bh=lRlYUuDp5glflddJvEoeapRiiCbk9usZQ1sjBHNJHWA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=hAqtsk1tMBTOcLmQdfShfuClxGMOfQ87C1yjw1nXaohBeAmIZ/e/XxuFfsdy7yO+p
         OXqzOIh903ka6x+00ab+Iz2eJSzlOzTipUjoo/vQ0DSbbJ3BJgIGarqD0mQTag+73p
         CKaeLPdhaEvB9qxGbfTqKeI8hzmdfQSmNYAYoOU0=
Date:   Sun, 02 Apr 2023 18:04:37 +0000
Subject: [PATCH v3 4/4] tools/nolibc: add testcases for vfprintf
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230328-nolibc-printf-test-v3-4-ddc79f92efd5@weissschuh.net>
References: <20230328-nolibc-printf-test-v3-0-ddc79f92efd5@weissschuh.net>
In-Reply-To: <20230328-nolibc-printf-test-v3-0-ddc79f92efd5@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680458682; l=3462;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=lRlYUuDp5glflddJvEoeapRiiCbk9usZQ1sjBHNJHWA=;
 b=r1gaqwcr5bI+JYJYF6F/e7zU/ZbkMtq+8Nx9jeWHBtiCSsdad9o8hV1RBLVCxN8lFZ0Rv2ta+
 gv3a94JEvWNBu2sE9onoc7uR2GvxejWHKmk4N4eDNT6RtNdjesRUa4P
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
 tools/testing/selftests/nolibc/nolibc-test.c | 86 ++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 47013b78972e..de943e028933 100644
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
@@ -667,6 +668,90 @@ int run_stdlib(int min, int max)
 	return ret;
 }
 
+#define EXPECT_VFPRINTF(c, expected, fmt, ...)				\
+	ret += expect_vfprintf(llen, c, expected, fmt, ##__VA_ARGS__)
+
+static int expect_vfprintf(int llen, size_t c, const char *expected, const char *fmt, ...)
+{
+	int ret, fd, w, r;
+	char buf[100];
+	FILE *memfile;
+	va_list args;
+
+	fd = memfd_create("vfprintf", 0);
+	if (fd == -1) {
+		pad_spc(llen, 64, "[FAIL]\n");
+		return 1;
+	}
+
+	memfile = fdopen(fd, "w+");
+	if (!memfile) {
+		pad_spc(llen, 64, "[FAIL]\n");
+		return 1;
+	}
+
+	va_start(args, fmt);
+	w = vfprintf(memfile, fmt, args);
+	va_end(args);
+
+	if (w != c) {
+		llen += printf(" written(%d) != %d", w, (int) c);
+		pad_spc(llen, 64, "[FAIL]\n");
+		return 1;
+	}
+
+	fflush(memfile);
+	lseek(fd, 0, SEEK_SET);
+
+	r = read(fd, buf, sizeof(buf) - 1);
+	buf[r] = '\0';
+
+	fclose(memfile);
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
+		CASE_TEST(pointer);      EXPECT_VFPRINTF(3, "0x1", "%p", (void *) 0x1); break;
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
@@ -774,6 +859,7 @@ static const struct test test_names[] = {
 	/* add new tests here */
 	{ .name = "syscall",    .func = run_syscall    },
 	{ .name = "stdlib",     .func = run_stdlib     },
+	{ .name = "vfprintf",   .func = run_vfprintf   },
 	{ .name = "protection", .func = run_protection },
 	{ 0 }
 };

-- 
2.40.0

