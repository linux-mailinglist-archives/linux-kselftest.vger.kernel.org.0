Return-Path: <linux-kselftest+bounces-23719-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAC69FA10B
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2024 15:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5561166F85
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2024 14:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C041FBC9C;
	Sat, 21 Dec 2024 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="m4YGyeh0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44EC1F37CC;
	Sat, 21 Dec 2024 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734792277; cv=none; b=EXME2rgjv8CPClNlNTTqdNSfJOMnPqKbPMGErNvlkRtNEOCdh54U/yJayylchOsHupRbspJ4AoDUtObz41Cfox7z6Spj+ScHnQn+P1TCjcd5S8wjA8xOr/sxWxaDFyVyOb4mbmcSnoRH74EVIVxXFwrGIT1PulyzX2Lypyuo6Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734792277; c=relaxed/simple;
	bh=frLR13FDv9wGOaLeaaK7JPvRthh2lmgaUpvebzfmFKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B4Vr75l+vS0YqGnUbZwerIqD2gHiYclZbX7N3PHcL069+wOutU+0FTklKMM3rTUO+WLl8jywG9YdyPH6qEBwZs4Zbedq+eWZyEN+68dVpZG82FEGfwK6U5rdKlXOJRB3Qo71FGCTcCYxfukbc3PcUn5Wx23dHEW5jr4/YfFJ0/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=m4YGyeh0; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734792272;
	bh=frLR13FDv9wGOaLeaaK7JPvRthh2lmgaUpvebzfmFKY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=m4YGyeh0O8c7q7qd3hllODqv1NEk/dSEeN2KiOzWopTqJT8c88iccwJ+z3pGXSR95
	 l0DAaGgpyQ/i6lja6MWKOd9M76sw8LGZRGHywfokjuY5fUxDPwmM4rQluWr/OBTbqt
	 4BjfvjY2u7lvXw+UICfki3qgYFG4OxkikAsViNjE=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 21 Dec 2024 15:44:30 +0100
Subject: [PATCH 3/6] selftests/nolibc: use a pipe to in vfprintf tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241221-nolibc-rv32-v1-3-d9ef6dab7c63@weissschuh.net>
References: <20241221-nolibc-rv32-v1-0-d9ef6dab7c63@weissschuh.net>
In-Reply-To: <20241221-nolibc-rv32-v1-0-d9ef6dab7c63@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Zhangjin Wu <falcon@tinylab.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734792271; l=1746;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=frLR13FDv9wGOaLeaaK7JPvRthh2lmgaUpvebzfmFKY=;
 b=gs7amVw+s5LZnTCX6MU6wJ0JxnVhWUnmJJklLIlAuqsF2BBtLDWPmuYdOZ7rs4I2iqnCfdCrk
 ngZv2FnmjTaDmNBrchU3eQTkK2kVmj4kdS8KwMiUq03Giv9QM2uxWum
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Not all architectures implement lseek(), for example riscv32 only
implements llseek() which is not equivalent to normal lseek().
Remove the need for lseek() by using a pipe instead.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 60c50968d3630e4909a5ecb2400770baaf7c2add..3685c13a9a6b8fd5110715b95ff323cdcb29481a 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1229,19 +1229,20 @@ int run_stdlib(int min, int max)
 
 static int expect_vfprintf(int llen, int c, const char *expected, const char *fmt, ...)
 {
-	int ret, fd;
+	int ret, pipefd[2];
 	ssize_t w, r;
 	char buf[100];
 	FILE *memfile;
 	va_list args;
 
-	fd = open("/tmp", O_TMPFILE | O_EXCL | O_RDWR, 0600);
-	if (fd == -1) {
-		result(llen, SKIPPED);
-		return 0;
+	ret = pipe(pipefd);
+	if (ret == -1) {
+		llen += printf(" pipe() != %s", strerror(errno));
+		result(llen, FAIL);
+		return 1;
 	}
 
-	memfile = fdopen(fd, "w+");
+	memfile = fdopen(pipefd[1], "w");
 	if (!memfile) {
 		result(llen, FAIL);
 		return 1;
@@ -1257,13 +1258,10 @@ static int expect_vfprintf(int llen, int c, const char *expected, const char *fm
 		return 1;
 	}
 
-	fflush(memfile);
-	lseek(fd, 0, SEEK_SET);
-
-	r = read(fd, buf, sizeof(buf) - 1);
-
 	fclose(memfile);
 
+	r = read(pipefd[0], buf, sizeof(buf) - 1);
+
 	if (r != w) {
 		llen += printf(" written(%d) != read(%d)", (int)w, (int)r);
 		result(llen, FAIL);

-- 
2.47.1


