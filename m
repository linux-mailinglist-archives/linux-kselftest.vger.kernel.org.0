Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560436CCBC7
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Mar 2023 23:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjC1VBn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Mar 2023 17:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjC1VBi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Mar 2023 17:01:38 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F151989;
        Tue, 28 Mar 2023 14:01:36 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1680037294;
        bh=gTyXb86YCdpSyD5ksJfQiCofzh+RXt/YaEbOdrzwMus=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=AVeSNlXApxdNHbGdAjrWP0AtUxQM11T9+3tWwkk3fASmPMd4yyHncAGNk3etiqkCB
         p7MnOQoGPfbDXIslyAqPJKB/KA9FRuCsfobNCRFfjYpJev95pJysVh0cEUqph3nksb
         i1Yp8B8jjP0M6RsDOsnOmmotOJSwBXJAwJrmpcm8=
Date:   Tue, 28 Mar 2023 21:01:30 +0000
Subject: [PATCH 2/3] tools/nolibc: let FILE streams contain an fd
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230328-nolibc-printf-test-v1-2-d7290ec893dd@weissschuh.net>
References: <20230328-nolibc-printf-test-v1-0-d7290ec893dd@weissschuh.net>
In-Reply-To: <20230328-nolibc-printf-test-v1-0-d7290ec893dd@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680037292; l=2316;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=gTyXb86YCdpSyD5ksJfQiCofzh+RXt/YaEbOdrzwMus=;
 b=Q2O9+eUZgks7p8V+sdQe74LF15Bx0aOaZwaUz56aK619ovw3OXm/kFcEM3/1t7IECAMaoCvsn
 kuC0GQaLxfODzavdooRKXyrEwvbfVuO2UtvFJUjVBkOeszZ3R6o3JdS
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
Users can also use nolibc-specific code to do the same.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/stdio.h | 36 +++++++-----------------------------
 1 file changed, 7 insertions(+), 29 deletions(-)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index 96ac8afc5aee..cb58912b98e5 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -21,17 +21,13 @@
 #define EOF (-1)
 #endif
 
-/* just define FILE as a non-empty type */
 typedef struct FILE {
-	char dummy[1];
+	int fd;
 } FILE;
 
-/* We define the 3 common stdio files as constant invalid pointers that
- * are easily recognized.
- */
-static __attribute__((unused)) FILE* const stdin  = (FILE*)-3;
-static __attribute__((unused)) FILE* const stdout = (FILE*)-2;
-static __attribute__((unused)) FILE* const stderr = (FILE*)-1;
+static __attribute__((unused)) FILE* const stdin  = &(FILE){ STDIN_FILENO  };
+static __attribute__((unused)) FILE* const stdout = &(FILE){ STDOUT_FILENO };
+static __attribute__((unused)) FILE* const stderr = &(FILE){ STDERR_FILENO };
 
 /* getc(), fgetc(), getchar() */
 
@@ -41,14 +37,8 @@ static __attribute__((unused))
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
+	if (read(stream->fd, &ch, 1) <= 0)
 		return EOF;
 	return ch;
 }
@@ -68,14 +58,8 @@ static __attribute__((unused))
 int fputc(int c, FILE* stream)
 {
 	unsigned char ch = c;
-	int fd;
 
-	if (stream < stdin || stream > stderr)
-		return EOF;
-
-	fd = 3 + (long)stream;
-
-	if (write(fd, &ch, 1) <= 0)
+	if (write(stream->fd, &ch, 1) <= 0)
 		return EOF;
 	return ch;
 }
@@ -96,15 +80,9 @@ static __attribute__((unused))
 int _fwrite(const void *buf, size_t size, FILE *stream)
 {
 	ssize_t ret;
-	int fd;
-
-	if (stream < stdin || stream > stderr)
-		return EOF;
-
-	fd = 3 + (long)stream;
 
 	while (size) {
-		ret = write(fd, buf, size);
+		ret = write(stream->fd, buf, size);
 		if (ret <= 0)
 			return EOF;
 		size -= ret;

-- 
2.40.0

