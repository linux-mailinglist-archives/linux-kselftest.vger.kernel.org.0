Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388606D39B4
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Apr 2023 20:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjDBSEt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 2 Apr 2023 14:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjDBSEr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 2 Apr 2023 14:04:47 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B4F558B;
        Sun,  2 Apr 2023 11:04:46 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1680458683;
        bh=QOC+hmegC2L3PEWdvDZRUgvKeYyvc+Fv0GYoxoLbGqY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=BqjyAbQUgBkgB0MfvVpqVXi1JPSgVjwmYANa2w1mt1+sK3UtNE99tQwAmgjzzFW7y
         4z0B0t35r3l8rn/xSeVNgXHuqatgP5wD2RiJbGCr558If0cSae5SdJnmsMQQALMvZl
         SeXUtBVTKEaFXebItrqyw2vFcIDS7WP+XOuNHBQs=
Date:   Sun, 02 Apr 2023 18:04:36 +0000
Subject: [PATCH v3 3/4] tools/nolibc: implement fd-based FILE streams
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230328-nolibc-printf-test-v3-3-ddc79f92efd5@weissschuh.net>
References: <20230328-nolibc-printf-test-v3-0-ddc79f92efd5@weissschuh.net>
In-Reply-To: <20230328-nolibc-printf-test-v3-0-ddc79f92efd5@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680458682; l=3629;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=QOC+hmegC2L3PEWdvDZRUgvKeYyvc+Fv0GYoxoLbGqY=;
 b=bt4M+CbIQgzuqN/9lDOZZI80k6Y2pAvGjw7lYMVjY+oBBgyiloL4qOkj+WgQhgWtQCReeLkwf
 ApJfsxnx0s6D1uMow0XaLiADTMP13R30namU7owoRCYotJJUay7RdAW
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
 tools/include/nolibc/stdio.h | 95 +++++++++++++++++++++++++++++++-------------
 1 file changed, 68 insertions(+), 27 deletions(-)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index 96ac8afc5aee..4add736c07aa 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -21,17 +21,75 @@
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
+	if (fd < 0) {
+		SET_ERRNO(EBADF);
+		return NULL;
+	}
+	return (FILE*)(intptr_t)~fd;
+}
+
+/* provides the fd of stream. */
+static __attribute__((unused))
+int fileno(FILE *stream)
+{
+	intptr_t i = (intptr_t)stream;
+
+	if (i >= 0) {
+		SET_ERRNO(EBADF);
+		return -1;
+	}
+	return ~i;
+}
+
+/* flush a stream. */
+static __attribute__((unused))
+int fflush(FILE *stream)
+{
+	intptr_t i = (intptr_t)stream;
+
+	/* NULL is valid here. */
+	if (i > 0) {
+		SET_ERRNO(EBADF);
+		return -1;
+	}
+
+	/* Don't do anything, nolibc does not support buffering. */
+	return 0;
+}
+
+/* flush a stream. */
+static __attribute__((unused))
+int fclose(FILE *stream)
+{
+	intptr_t i = (intptr_t)stream;
+
+	if (i >= 0) {
+		SET_ERRNO(EBADF);
+		return -1;
+	}
+
+	if (close(~i))
+		return EOF;
+
+	return 0;
+}
 
 /* getc(), fgetc(), getchar() */
 
@@ -41,14 +99,8 @@ static __attribute__((unused))
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
@@ -68,14 +120,8 @@ static __attribute__((unused))
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
@@ -96,12 +142,7 @@ static __attribute__((unused))
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

