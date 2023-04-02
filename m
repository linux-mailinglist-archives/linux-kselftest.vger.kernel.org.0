Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B37E6D3804
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Apr 2023 15:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjDBNCz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 2 Apr 2023 09:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjDBNCy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 2 Apr 2023 09:02:54 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F1F11159;
        Sun,  2 Apr 2023 06:02:52 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1680440570;
        bh=T8RVOs4azHVELdWLvY+5zv0X2y22kGN/1wJMaJIVLtc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=IH8eEvhVyAcAtKynq+H8IW/Krqlmz4GRaD9yr3ys4uDrIJvRBYJo/zXE8FHlIQULA
         ilMRHtpqjFUrIUge4slsizPDekitgtUo45FoQ6Vn9NVXBQJHu7W3z3jbwUZbc/X2lF
         vp0qC4To3HcnJs7sttaBEUDhWnTlM1ByU7DuKaew=
Date:   Sun, 02 Apr 2023 13:02:46 +0000
Subject: [PATCH v2 2/3] tools/nolibc: implement fd-based FILE streams
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230328-nolibc-printf-test-v2-2-f72bdf210190@weissschuh.net>
References: <20230328-nolibc-printf-test-v2-0-f72bdf210190@weissschuh.net>
In-Reply-To: <20230328-nolibc-printf-test-v2-0-f72bdf210190@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680440570; l=3061;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=T8RVOs4azHVELdWLvY+5zv0X2y22kGN/1wJMaJIVLtc=;
 b=5iR9MA+v57ECoqD2l9JxLhY8lvr1vpmRApDWKYWF44Ra2kojXz7Zb+78WA3ZY0UoFxngpL6un
 BvpTdEDrFI9BdC182hzgWdJK01UvDSj38Poi7mvwaqsIU270Wrf3Bdt
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

This enables the usage of the stream APIs with arbitrary filedescriptors.

It will be used by a future testcase.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

---

Willy:

This uses intptr_t instead of uintptr_t as proposed because uintptr_t
can not be negative.
---
 tools/include/nolibc/stdio.h | 60 ++++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index 96ac8afc5aee..edf1009e9203 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -21,17 +21,40 @@
 #define EOF (-1)
 #endif
 
-/* just define FILE as a non-empty type */
+/* just define FILE as a non-empty type. The value of the pointer gives
+ * the FD: FILE=~fd for fd>=0 or NULL for fd<0. This way positive FILE
+ * are immediately identified as abnormal entries (i.e. possible copies
+ * of valid pointers to something else).
+ */
 typedef struct FILE {
 	char dummy[1];
 } FILE;
 
-/* We define the 3 common stdio files as constant invalid pointers that
- * are easily recognized.
- */
-static __attribute__((unused)) FILE* const stdin  = (FILE*)-3;
-static __attribute__((unused)) FILE* const stdout = (FILE*)-2;
-static __attribute__((unused)) FILE* const stderr = (FILE*)-1;
+static __attribute__((unused)) FILE* const stdin  = (FILE*)(intptr_t)~STDIN_FILENO;
+static __attribute__((unused)) FILE* const stdout = (FILE*)(intptr_t)~STDOUT_FILENO;
+static __attribute__((unused)) FILE* const stderr = (FILE*)(intptr_t)~STDERR_FILENO;
+
+/* provides a FILE* equivalent of fd. The mode is ignored. */
+static __attribute__((unused))
+FILE *fdopen(int fd, const char *mode __attribute__((unused)))
+{
+	if (fd < 0)
+		return NULL;
+	return (FILE*)(intptr_t)~fd;
+}
+
+/* provides the fd from of stream. */
+static __attribute__((unused))
+int fileno(FILE *stream)
+{
+	intptr_t i = (intptr_t)stream;
+
+	if (i > 0) {
+		SET_ERRNO(EBADF);
+		return -1;
+	}
+	return ~i;
+}
 
 /* getc(), fgetc(), getchar() */
 
@@ -41,14 +64,8 @@ static __attribute__((unused))
 int fgetc(FILE* stream)
 {
 	unsigned char ch;
-	int fd;
 
-	if (stream < stdin || stream > stderr)
-		return EOF;
-
-	fd = 3 + (long)stream;
-
-	if (read(fd, &ch, 1) <= 0)
+	if (read(fileno(stream), &ch, 1) <= 0)
 		return EOF;
 	return ch;
 }
@@ -68,14 +85,8 @@ static __attribute__((unused))
 int fputc(int c, FILE* stream)
 {
 	unsigned char ch = c;
-	int fd;
-
-	if (stream < stdin || stream > stderr)
-		return EOF;
-
-	fd = 3 + (long)stream;
 
-	if (write(fd, &ch, 1) <= 0)
+	if (write(fileno(stream), &ch, 1) <= 0)
 		return EOF;
 	return ch;
 }
@@ -96,12 +107,7 @@ static __attribute__((unused))
 int _fwrite(const void *buf, size_t size, FILE *stream)
 {
 	ssize_t ret;
-	int fd;
-
-	if (stream < stdin || stream > stderr)
-		return EOF;
-
-	fd = 3 + (long)stream;
+	int fd = fileno(stream);
 
 	while (size) {
 		ret = write(fd, buf, size);

-- 
2.40.0

