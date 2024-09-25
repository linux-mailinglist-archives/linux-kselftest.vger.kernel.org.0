Return-Path: <linux-kselftest+bounces-18348-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD359985D39
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 15:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 786A51F25F71
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 13:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176571DC1A9;
	Wed, 25 Sep 2024 12:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEVeLzB1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6091DC1A1;
	Wed, 25 Sep 2024 12:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265770; cv=none; b=LQ0BR7MKPY9RrE6/LZG+SrMPvgNCuc+bJ0nDjvaz7bsMhrX+jDWpPIhXvm6fFb+CKet3E9dumyPrDwu3hcmI8nLu7CNJWHGcMBvYYkbl0hHK2U+1/7fCi6B9+I5TQ3d9dwGmiu5qH/O/KrnyPVwR6h6+Y3i4HSG7SIA7B6RsObg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265770; c=relaxed/simple;
	bh=SkvK9gsJPxzQqJt2W8U0dTzsNBx6WaPygmvnODs2c/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gXiVHixssA8C3dr+2y+vFTrhRnZW8spWwC0t7Y7s+pEIgY7Qj2ccxiGDZzyJt63SSuZ47FwfCswNjc1U8nC6xaBrWJBWC53OlSjNrqGie+0j85JK2CgfEx2QmDkpxqd7SVaq4TPlisaTw3/g41lgp8SUfp/yZ/kSpxvOGEYWeD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEVeLzB1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78747C4CEC3;
	Wed, 25 Sep 2024 12:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265769;
	bh=SkvK9gsJPxzQqJt2W8U0dTzsNBx6WaPygmvnODs2c/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IEVeLzB1mHa31HWf1FwgBhubUYbbOueJOtZHPkNjH5/CV14OjHtg5MqgUxW5qb2QM
	 iD/VIR3AITTovd4AYCssnDVTHSFGYur06xsdVrqHy7gduQZJ+WJfnmTVMIBsfNHqJr
	 xV013mM8I5N05pU5WyTGAPD3Pb1H7rjaOHyHaU2e8rmB+f9GdJq4PK4C4fCfYRmGDa
	 d/YaE0l/QoQAyeMyTiHbbmGhw+7aI8kr/B2Tfhhxt0XOAa2uLr47kb8ypLFxJuWzTI
	 O0RTVwtI8IQ/jaDMzFXQKeQ5rD3UyLiRfMXFVPc8GqO+303PsQw9TJ9U80unep1e4c
	 nYBLzPeE9qeCg==
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
Subject: [PATCH AUTOSEL 6.10 092/197] selftests/nolibc: avoid passing NULL to printf("%s")
Date: Wed, 25 Sep 2024 07:51:51 -0400
Message-ID: <20240925115823.1303019-92-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
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
index 994477ee87bef..4bd8360d54225 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -534,7 +534,7 @@ int expect_strzr(const char *expr, int llen)
 {
 	int ret = 0;
 
-	llen += printf(" = <%s> ", expr);
+	llen += printf(" = <%s> ", expr ? expr : "(null)");
 	if (expr) {
 		ret = 1;
 		result(llen, FAIL);
@@ -553,7 +553,7 @@ int expect_strnz(const char *expr, int llen)
 {
 	int ret = 0;
 
-	llen += printf(" = <%s> ", expr);
+	llen += printf(" = <%s> ", expr ? expr : "(null)");
 	if (!expr) {
 		ret = 1;
 		result(llen, FAIL);
-- 
2.43.0


