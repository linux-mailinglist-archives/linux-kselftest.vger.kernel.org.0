Return-Path: <linux-kselftest+bounces-47767-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A950CD302E
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 14:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04DF53032A93
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 13:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41D230CDB0;
	Sat, 20 Dec 2025 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="cp2+kLMg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46A33093D8;
	Sat, 20 Dec 2025 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766238970; cv=none; b=SQxlm6at6bKqforPu8EV2F/EFd/43b5DoZZEKLZJ0zjMxAvXi0GPS7boYxzd5vlE67wHLGVvtDGUpPGBHT9WaSygcuMVRaBL+Lv0OJwjm32STeU+LAXnQ3GDdDL4Pm9Q85qQKA5LSQ/rTX3Z/1q6EPbZqJlY8f5WQNEUi97Y2AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766238970; c=relaxed/simple;
	bh=rZNFs92ggHWt1n0B8ucHPV4F1K6FynP/LBgA0cQHUIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BI/i9QWjbj++qabhnkp6omU0ic/OrafkrtqqVGS9bgoRZpq6jp5K5TZ1GoA6+scymunc7uhcIOnUTulO2mSh3H25IbqbCqrun5SX2ezR+jWgZu3sIzI/bpE7ODHuLUZBytkh9j41EfoK3ImJ8jbIHgB8gPTtytNsqu3J/462eqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=cp2+kLMg; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1766238957;
	bh=rZNFs92ggHWt1n0B8ucHPV4F1K6FynP/LBgA0cQHUIA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cp2+kLMgXYqmCL3V6JjS57FlKpj8s+nwNSSmYdAFXaPU/pJGgC/tQWyF1RaGWd8Ns
	 W6/Qg+cWYo5Aa4cmkUPnMzPxwTRN7O2sM+pdNXV3BRNfZtrRxbCMH/if7F7/ndJUVV
	 XUoyrFr7UP5KfRQlZMn7BqPsmF8GKYz5RR2CSd5s=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 20 Dec 2025 14:55:50 +0100
Subject: [PATCH v3 06/14] tools/nolibc/gettimeofday: avoid libgcc 64-bit
 divisions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251220-nolibc-uapi-types-v3-6-c662992f75d7@weissschuh.net>
References: <20251220-nolibc-uapi-types-v3-0-c662992f75d7@weissschuh.net>
In-Reply-To: <20251220-nolibc-uapi-types-v3-0-c662992f75d7@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766238956; l=1067;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=rZNFs92ggHWt1n0B8ucHPV4F1K6FynP/LBgA0cQHUIA=;
 b=8WRlm1Hxg8d28foZt91zz8Yj7ggXPufFisCBeVSmKM3wPqlpxUM5+fSuGNu/pXQYMoYu+A+UO
 JH9bzLJYH/VAAqnGo7I8/lPpO3rnWz43Qa+pS3DIeB98bztiGPgx80g
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

timespec::tv_nsec is going to be 64-bit wide even on 32-bit
architectures. As not all architectures support 64-bit division
instructions, calls to libgcc (__divdi3()) may be emitted by the
compiler which are not provided by nolibc.

As tv_nsec is guaranteed to always fit into an uint32_t, perform a
32-bit division instead.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/sys/time.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/sys/time.h b/tools/include/nolibc/sys/time.h
index 171187836e6d..afdb7e326df1 100644
--- a/tools/include/nolibc/sys/time.h
+++ b/tools/include/nolibc/sys/time.h
@@ -30,7 +30,7 @@ int sys_gettimeofday(struct timeval *tv, struct timezone *tz)
 	ret = sys_clock_gettime(CLOCK_REALTIME, &tp);
 	if (!ret && tv) {
 		tv->tv_sec = tp.tv_sec;
-		tv->tv_usec = tp.tv_nsec / 1000;
+		tv->tv_usec = (uint32_t)tp.tv_nsec / 1000;
 	}
 
 	return ret;

-- 
2.52.0


