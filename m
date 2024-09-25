Return-Path: <linux-kselftest+bounces-18345-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC5B985A2C
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 14:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADC5E1C23782
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 12:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764DE1B3B2B;
	Wed, 25 Sep 2024 11:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6Xjns4q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3841B3B24;
	Wed, 25 Sep 2024 11:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264510; cv=none; b=WZyuyJGHFaTZlSAUKIkIdPD6YKQSB3BoLNz7neU3LaAzmDOr9bBUGnVm2S8VFfeaV1nj1tirvp2UZ4B60+JrUYda2cxok8Z0QFdQsIsqU4tMZMXkc4Mk4QbQ816+S32/h5j7qWvw8UlTvFuBERnVGhOedWEvu2g9VQ+f2IgMcUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264510; c=relaxed/simple;
	bh=q9wo/9okz0UpGNlrpCb9pnkdE9045EF8wkvfj6rt54Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iI6V9MjmgrKV1kUi88WuMrSBKuaxi7GsFhwcxDR9mqokSIV5XAy3VCKGfXU5HwJZD3ICqgBYBjYvAGw3JVuU3Yl5QmBITbBTVxdpDLQsrpzq8CCOMLX3wyMYuDpvmzNCuubhOO1rGTyFWih4U3B2rLEa3KhYr+Yeqru0C2fyx9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6Xjns4q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3D7C4CECF;
	Wed, 25 Sep 2024 11:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264509;
	bh=q9wo/9okz0UpGNlrpCb9pnkdE9045EF8wkvfj6rt54Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E6Xjns4qhzPM4vj3+ywlTpNk5lKSeYljVFIp1+PADinKK5jgqkYZoj6iVf6QvrFN7
	 6YGOdaDW+DnckYm37NNRI+mWtL6jotSqOKjWYjOrZ5J8rUM4cTUWV2yXiyVWpYWWYp
	 nO135TNeAOA0g/I/6YSUWVtHQ6MZzmVL6B9Esbgfyd5AOnhl4oEn5omRFmkBPTuMTU
	 YDL6AjI49yTlMGLos1FizfvlcKVb4LvCBxMqINTZYns+PpXwPgjCd0uNVed5GJFpJJ
	 BN1dPsxKR1HW8kEzwep6AjVYcmYRJfjHigHU0iafS/VPu9jmFa3QwCc6pIdfKV/+PR
	 NkVaXt4ZThaeA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Willy Tarreau <w@1wt.eu>,
	Sasha Levin <sashal@kernel.org>,
	shuah@kernel.org,
	nathan@kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.11 108/244] selftests/nolibc: avoid passing NULL to printf("%s")
Date: Wed, 25 Sep 2024 07:25:29 -0400
Message-ID: <20240925113641.1297102-108-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Thomas Weißschuh <linux@weissschuh.net>

[ Upstream commit f1a58f61d88642ae1e6e97e9d72d73bc70a93cb8 ]

Clang on higher optimization levels detects that NULL is passed to
printf("%s") and warns about it.
While printf() from nolibc gracefully handles that NULL,
it is undefined behavior as per POSIX, so the warning is reasonable.
Avoid the warning by transforming NULL into a non-NULL placeholder.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Acked-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/r/20240807-nolibc-llvm-v2-8-c20f2f5fc7c2@weissschuh.net
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 093d0512f4c57..8cbb51dca0cd6 100644
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
2.43.0


