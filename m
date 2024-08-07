Return-Path: <linux-kselftest+bounces-14983-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE74994B261
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 23:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81303B2197E
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 21:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A45156665;
	Wed,  7 Aug 2024 21:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="fa+dV+c0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25BA15535A;
	Wed,  7 Aug 2024 21:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723067524; cv=none; b=qXbp+o4crhINrU1+rUTSgbHc8Cj1V+i6Z4JtYaTr6kPg/s6FoWUWMkR1f3rlwGUEvToG3t98aJoAsFXXW8wYfdmCh/cyamSIK7mVzJ6jRKtGcNsymHC5N9taLdUfvBA94K1Oeq7L8QQV6IYH3NcrdHZkFKeeDFqBEOoWeN14o5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723067524; c=relaxed/simple;
	bh=obIjHsolXNXcLTedUP4pqEyIcSocTNAfNvlGUro4FYo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A7bKDRBffSpZQq7AxMCDvrW9lIiXOqzjHPrEkyEy8fJlKeegniWD7LInACKFWjoW1lOaBvY1VMFMLsvFqeg7FGMrYqQAVfhOsCWAFF8VDuYvkDpuMRehG6dQiLTXahYUmNB+oGpZu6RbfbaipqEHmY3Q0fHTF8cumhQGG7x9nKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=fa+dV+c0; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723067511;
	bh=obIjHsolXNXcLTedUP4pqEyIcSocTNAfNvlGUro4FYo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fa+dV+c0Tky2ez/aJ5ChRq8pNxGCmZb0wVpBYUwlMtIbW5oJ/X2SytykQY+v6TBXf
	 gs7iDXV4MuA3Is3ZZNDwlMKh4B2md4D0E+1Ml436co3hvM6YUvttpeVN911ujxx0X3
	 3hP84CzKzL46sDdAbqeeDy3gnB7+QoJds41MvHqA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 07 Aug 2024 23:51:44 +0200
Subject: [PATCH v2 08/15] selftests/nolibc: avoid passing NULL to
 printf("%s")
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240807-nolibc-llvm-v2-8-c20f2f5fc7c2@weissschuh.net>
References: <20240807-nolibc-llvm-v2-0-c20f2f5fc7c2@weissschuh.net>
In-Reply-To: <20240807-nolibc-llvm-v2-0-c20f2f5fc7c2@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723067509; l=1257;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=obIjHsolXNXcLTedUP4pqEyIcSocTNAfNvlGUro4FYo=;
 b=z9Y10TL611sG1brS8Kg1Uktqf7SPz0K9do0wzKH+GkueCbd/6HYsFORmh8DOpKipNc93nyP/C
 ErqGrlIneIcAtWXhpBhaWG7xljH1wYzkIDtjKCQBCwxD9RT0nvEXenG
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Clang on higher optimization levels detects that NULL is passed to
printf("%s") and warns about it.
While printf() from nolibc gracefully handles that NULL,
it is undefined behavior as per POSIX, so the warning is reasonable.
Avoid the warning by transforming NULL into a non-NULL placeholder.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 093d0512f4c5..8cbb51dca0cd 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -542,7 +542,7 @@ int expect_strzr(const char *expr, int llen)
 {
 	int ret = 0;
 
-	llen += printf(" = <%s> ", expr);
+	llen += printf(" = <%s> ", expr ? expr : "(null)");
 	if (expr) {
 		ret = 1;
 		result(llen, FAIL);
@@ -561,7 +561,7 @@ int expect_strnz(const char *expr, int llen)
 {
 	int ret = 0;
 
-	llen += printf(" = <%s> ", expr);
+	llen += printf(" = <%s> ", expr ? expr : "(null)");
 	if (!expr) {
 		ret = 1;
 		result(llen, FAIL);

-- 
2.46.0


