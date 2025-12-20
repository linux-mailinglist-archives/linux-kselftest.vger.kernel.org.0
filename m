Return-Path: <linux-kselftest+bounces-47763-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5E2CD300A
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 14:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EADC0300AB09
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 13:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5342F0C68;
	Sat, 20 Dec 2025 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ksd+M9ly"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACEE2D877B;
	Sat, 20 Dec 2025 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766238967; cv=none; b=rNoY4MOpn4/4t70158XZ3QcvY8VNQkAl1P6o8bQW3dBav9WkaBsHEZSUrX73A+xuzwHMmhg5jn5VGynwSSlo4ts43T7rr6o//9wTQdVsGfK3RpNPO3Ft6iVzETjnUkGsC8XUl2Eyl3FgYx/aoJD1qjwVB1QkauUzdStqHZBI+gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766238967; c=relaxed/simple;
	bh=gVq3x4tBxiNm+mJ5OxMCxytcQfvKNj8AIsptA23SvRM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K+51MFkSZtcYeIQVPlsLw3WK5zWp0BllX6wZC1mhdtwwEi6XW9rSVn9erWH0o+BmyzgE8HGmZ+KAtFfdjoZMXC+9k89oG6j28sDBKBAvlLGA9oadg58KEUJd4R9L3qEnIVo+xbZH5QZa5o2fIdaXKM2Fo9S9NyrbhYMSQnRPX6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ksd+M9ly; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1766238957;
	bh=gVq3x4tBxiNm+mJ5OxMCxytcQfvKNj8AIsptA23SvRM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ksd+M9lyYMexCZvyIdY550I0FdyFYEcM+CRf51+tHy+R75ZvNPeeocY9RXeKG3ahS
	 8X7W6sEyfhawsFkrytnOLeAjd7CrIGzR1KtmOpSgMZwAw6/uxfib3xrUQfWTYBczOV
	 d+qrLXk5yhnx3CcscKKZaDOHsoq7ytXHRUVEJKt8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 20 Dec 2025 14:55:48 +0100
Subject: [PATCH v3 04/14] tools/nolibc/time: drop invocation of
 gettimeofday system call
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251220-nolibc-uapi-types-v3-4-c662992f75d7@weissschuh.net>
References: <20251220-nolibc-uapi-types-v3-0-c662992f75d7@weissschuh.net>
In-Reply-To: <20251220-nolibc-uapi-types-v3-0-c662992f75d7@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766238956; l=1161;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=gVq3x4tBxiNm+mJ5OxMCxytcQfvKNj8AIsptA23SvRM=;
 b=5Jft3oUvHE7l/o2Bt3xbgz1TiDTbli5bb2V4nLSzsa/i783iC+9aEYu2tzUco3SYcsUwJyv9k
 W6Ml1Qz76BIAMRFffwoFPnZyoVy3U9HTP/4G2l49QAV9N4OFqqF51Sz
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

This invocation uses libc types with a system call. While this works
now, upcoming changes to 'struct timeval' would require type
conversions. If types are converted anyways, the clock_gettime() based
fallback can be used everywhere, simplifying the code.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/sys/time.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/include/nolibc/sys/time.h b/tools/include/nolibc/sys/time.h
index 33782a19aae9..171187836e6d 100644
--- a/tools/include/nolibc/sys/time.h
+++ b/tools/include/nolibc/sys/time.h
@@ -22,9 +22,6 @@ static int sys_clock_gettime(clockid_t clockid, struct timespec *tp);
 static __attribute__((unused))
 int sys_gettimeofday(struct timeval *tv, struct timezone *tz)
 {
-#ifdef __NR_gettimeofday
-	return my_syscall2(__NR_gettimeofday, tv, tz);
-#else
 	(void) tz; /* Non-NULL tz is undefined behaviour */
 
 	struct timespec tp;
@@ -37,7 +34,6 @@ int sys_gettimeofday(struct timeval *tv, struct timezone *tz)
 	}
 
 	return ret;
-#endif
 }
 
 static __attribute__((unused))

-- 
2.52.0


