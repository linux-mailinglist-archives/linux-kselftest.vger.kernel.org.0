Return-Path: <linux-kselftest+bounces-46330-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AE3C7D47C
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 18:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 02464354EC8
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 17:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7CB2FF147;
	Sat, 22 Nov 2025 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="IiG2Jvpe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA0128C84A;
	Sat, 22 Nov 2025 16:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763830799; cv=none; b=bTg6lLOlL5LuIjWCeZqKs1VkFuXm0/T71VUyQEgCtM1Ru/RVZsDlW5ALis8KRxMsaX45GnYASbRF/cSqBEZvBro1iERza/zUcXIHYKWYgU1gwMA6LnBzCM0jSHrLOSxZ0Nd6Pofp2fhbuQ8Q9uSv30Syw1U/C+2i8X8X2gYQLXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763830799; c=relaxed/simple;
	bh=rZNFs92ggHWt1n0B8ucHPV4F1K6FynP/LBgA0cQHUIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W8+FSr3aU+rXQpAxoLPvNBNOm2XKdggdsywVxiKi3ieddZQT3L66/wY0ekUOlpBf9kPNpPYp/di0RgcTfDGnAImoNxY0W3rZH9ELxi+K1sJt/tIdpKfcOPqvm46GTSDWBcg0ubC4WtX0J11rKE7p/GT5QTAhayOYboZexp8wexA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=IiG2Jvpe; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1763830791;
	bh=rZNFs92ggHWt1n0B8ucHPV4F1K6FynP/LBgA0cQHUIA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IiG2JvpeYxmW/VZZEgAS5L9G+scH6uOhzwDJN0vTZrsbxMddwo/xopfYJA6GLVbgu
	 mdcYrF/FSOGzM8YuQJJRxJXOI+gvi3PaRBdjw9LsWnZQQWKJmwYg4Jgd1ZYLr0mXUT
	 4z0FFKjGvE7jPGyq9tcVDahxpN+7l6QZQ7Tjld00=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 22 Nov 2025 17:59:12 +0100
Subject: [PATCH v2 06/13] tools/nolibc/gettimeofday: avoid libgcc 64-bit
 divisions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251122-nolibc-uapi-types-v2-6-b814a43654f5@weissschuh.net>
References: <20251122-nolibc-uapi-types-v2-0-b814a43654f5@weissschuh.net>
In-Reply-To: <20251122-nolibc-uapi-types-v2-0-b814a43654f5@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763830790; l=1067;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=rZNFs92ggHWt1n0B8ucHPV4F1K6FynP/LBgA0cQHUIA=;
 b=qsVpovwjhSpIkBq9r56QxWk+q25Zidosvnk0ZXOn1ozdluBRYSPuMOPDCGU9fUKzVZyYhkI8l
 UnDVi4ege+/CwvB7ytzqNtlSC3KsONMxa/ukevzUFvVW4ARL5MyF/jz
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


