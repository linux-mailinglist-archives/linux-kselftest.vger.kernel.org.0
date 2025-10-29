Return-Path: <linux-kselftest+bounces-44311-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B67C1C522
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 18:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD81096272C
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 16:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961EF350298;
	Wed, 29 Oct 2025 16:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="EmcQPV+e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F99A34C99D;
	Wed, 29 Oct 2025 16:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753894; cv=none; b=jhL8UMO3yVT9SZnHWv2IgnrRNuX/4dBg7536l8CwbPN55XjVqyG+4sf62EpOU/t84ba1qS3UVcQyGT/n7d2f3nGdX9nJTuiWwHDhlF+f1+DbfuPNzYTQU8nLIqDw2DS2W+MfZ2QXehAbmNxmeWmUWaPkoCc/UhmvkFity8hvOxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753894; c=relaxed/simple;
	bh=c0ffcg/Cy/iLaabPjYtIOeiQB2bz7Rfn8U/JmWPANak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r6WMyUPjO4rfXaZ0QL72Bu5WbbbI6aZovEvCorWYF60T33SCOkeuZh9aJojlqFY4ygHbLCo+T7OaV2A9UIUPauJ7e+AGFvvl0cp7dXfQeA7rl0ymeoYb1EY3AJmvgfsOQwKsOiLsyoNLwCbhPqxtNE4qRsxR/3V6hFiIvRJELWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=EmcQPV+e; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1761753883;
	bh=c0ffcg/Cy/iLaabPjYtIOeiQB2bz7Rfn8U/JmWPANak=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EmcQPV+eeFxIkFt/h+sh9JKBVN5wSQfvNs04PolfXg8wh6Nd8b4WjfYLFB6cWhtVg
	 SBHC/yZV/7BRm/f+r+RyN31vETZzqJgdHnhhg/qOsjCkSb5H46ncB2PmrXNjycrrAX
	 pi61BS1BHRPipDi1694n4NHWpAYn2qkhNhymcstY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 29 Oct 2025 17:02:55 +0100
Subject: [PATCH 05/12] tools/nolibc: remove now superfluous overflow check
 in llseek
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251029-nolibc-uapi-types-v1-5-e79de3b215d8@weissschuh.net>
References: <20251029-nolibc-uapi-types-v1-0-e79de3b215d8@weissschuh.net>
In-Reply-To: <20251029-nolibc-uapi-types-v1-0-e79de3b215d8@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761753881; l=707;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=c0ffcg/Cy/iLaabPjYtIOeiQB2bz7Rfn8U/JmWPANak=;
 b=MfyGuJFfsfRsdh+SnrGFzpaOjSFpGmTd22bSsUUYLm8gQy/6llbi8XBlHcekXGmroEzq4nfqh
 UgkNXDQyLSfBGFQH+1jKraRotAWQP7Y+pffsOmquYqFJZhAsHmFeccJ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

As off_t is now always 64-bit wide this overflow can not happen anymore,
remove the check.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/sys.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 58cd2bb0f6ce..e91b7d947161 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -600,8 +600,6 @@ off_t sys_lseek(int fd, off_t offset, int whence)
 	ret = my_syscall5(__NR_llseek, fd, offset >> 32, (uint32_t)offset, &loff, whence);
 	if (ret < 0)
 		result = ret;
-	else if (loff != (off_t)loff)
-		result = -EOVERFLOW;
 	else
 		result = loff;
 

-- 
2.51.1.dirty


