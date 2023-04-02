Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE5B6D3909
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Apr 2023 18:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjDBQnc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 2 Apr 2023 12:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjDBQna (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 2 Apr 2023 12:43:30 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0CDA9E3B7;
        Sun,  2 Apr 2023 09:43:27 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 332GhLQV020330;
        Sun, 2 Apr 2023 18:43:21 +0200
Date:   Sun, 2 Apr 2023 18:43:21 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/3] tools/nolibc: add testcases for vfprintf
Message-ID: <ZCmwqcwxHIlODz2i@1wt.eu>
References: <20230328-nolibc-printf-test-v2-0-f72bdf210190@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230328-nolibc-printf-test-v2-0-f72bdf210190@weissschuh.net>
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Thomas,

On Sun, Apr 02, 2023 at 01:02:44PM +0000, Thomas Weißschuh wrote:
> vfprintf() is complex and so far did not have proper tests.
> 
> This series is based on the "dev" branch of the RCU tree.

I've just ran it with glibc to see:

  $ gcc nolibc-test.c  
  $ ./a.out vfprintf
  Running test 'vfprintf'
  0 empty "" = ""                                                  [OK]
  1 simple written(3) != read(0)                                  [FAIL]
  2 string written(3) != read(0)                                  [FAIL]
  3 number written(4) != read(0)                                  [FAIL]
  4 negnumber written(5) != read(0)                               [FAIL]
  5 unsigned written(5) != read(0)                                [FAIL]
  6 char written(1) != read(0)                                    [FAIL]
  7 hex written(1) != read(0)                                     [FAIL]
  8 pointer written(5) != 3                                       [FAIL]
  Errors during this test: 8

The main issue was that glibc uses buffered writes by default.

I could fix them with fflush() (which we don't have so it required an
ifndef), and this also made me realize that we were missing an fclose()
as well for compatibility with glibc. With this it got better:

  Running test 'vfprintf'
  0 empty "" = ""                                                  [OK]
  1 simple "foo" = "foo"                                           [OK]
  2 string "foo" = "foo"                                           [OK]
  3 number "1234" = "1234"                                         [OK]
  4 negnumber "-1234" = "-1234"                                    [OK]
  5 unsigned "12345" = "12345"                                     [OK]
  6 char "c" = "c"                                                 [OK]
  7 hex "f" = "f"                                                  [OK]
  8 pointer written(5) != 3                                       [FAIL]
  Errors during this test: 1

This is caused by glibc emitting "(nil)" while we emit "0x0" for a NULL
pointer since we use the same code as when dumping integers. I could fix
that one as well by printing (void*)1 instead, which shows "0x1" for both.

This gives me the patch below on top of yours, which I think would make
sense to integrate in this form or a simplified one if we manage to add
fflush() and fclose() earlier.

What do you think ?

Thanks,
Willy


diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 28a8d77078dc..2958dc3eca93 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -678,6 +678,7 @@ static int expect_vfprintf(int llen, size_t c, const char *expected, const char
 	int ret, fd, w, r;
 	char buf[100];
 	va_list args;
+	FILE *memfile;
 
 	fd = memfd_create("vfprintf", 0);
 	if (fd == -1) {
@@ -685,8 +686,14 @@ static int expect_vfprintf(int llen, size_t c, const char *expected, const char
 		return 1;
 	}
 
+	memfile = fdopen(fd, "w+");
+	if (!memfile) {
+		pad_spc(llen, 64, "[FAIL]\n");
+		return 1;
+	}
+
 	va_start(args, fmt);
-	w = vfprintf(fdopen(fd, "w+"), fmt, args);
+	w = vfprintf(memfile, fmt, args);
 	va_end(args);
 
 	if (w != c) {
@@ -695,12 +702,19 @@ static int expect_vfprintf(int llen, size_t c, const char *expected, const char
 		return 1;
 	}
 
+#ifndef _NOLIBC_STDIO_H
+	fflush(memfile);
+#endif
 	lseek(fd, 0, SEEK_SET);
 
 	r = read(fd, buf, sizeof(buf) - 1);
 	buf[r] = '\0';
 
+#ifndef _NOLIBC_STDIO_H
+	fclose(memfile);
+#else
 	close(fd);
+#endif
 
 	if (r != w) {
 		llen += printf(" written(%d) != read(%d)", w, r);
@@ -737,7 +751,7 @@ static int run_vfprintf(int min, int max)
 		CASE_TEST(unsigned);     EXPECT_VFPRINTF(5, "12345", "%u", 12345); break;
 		CASE_TEST(char);         EXPECT_VFPRINTF(1, "c", "%c", 'c'); break;
 		CASE_TEST(hex);          EXPECT_VFPRINTF(1, "f", "%x", 0xf); break;
-		CASE_TEST(pointer);      EXPECT_VFPRINTF(3, "0x0", "%p", NULL); break;
+		CASE_TEST(pointer);      EXPECT_VFPRINTF(3, "0x1", "%p", (void*)0x1); break;
 		case __LINE__:
 			return ret; /* must be last */
 		/* note: do not set any defaults so as to permit holes above */
