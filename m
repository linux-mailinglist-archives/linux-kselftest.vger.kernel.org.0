Return-Path: <linux-kselftest+bounces-44317-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDC7C1BF9B
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 17:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBA5719C1374
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 16:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA6F3546E3;
	Wed, 29 Oct 2025 16:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="nENLd4ND"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3DB33F8BE;
	Wed, 29 Oct 2025 16:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753896; cv=none; b=dkcRrSIv2lt6L4YTDHbTJFSBMAb/jabIdQ9QJFH/w108LqAESQaitp7852QCT+FvNua/gHqEjU/J8Aos2fjP4gu8+IxYx1jlZmmqICmKzYxBMqKLC42lUevxihhhvfj333W2QSqN8kT3ycH0IZKAYyMTe1kifuJeRYgb9Cu3oIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753896; c=relaxed/simple;
	bh=FBBimS5ndn4H9cVjHfRa0/w3nWQHf6b6qw4nWJc1plI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g++1qxvKvzMwcndfuwS8YEhQQCFX+80/wL6kzK+2WuJv9q8Woskso7V2aPgviMW4QhNxE5gb56pqZLEUFwy6PSYp640AmkhnjIl8+1W8twMEIDZTc8VXYl8kUM48+fsGkBT4+l9f6T/FmgV8D7uCsojcz9EIZENptUXOB1rENLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=nENLd4ND; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1761753883;
	bh=FBBimS5ndn4H9cVjHfRa0/w3nWQHf6b6qw4nWJc1plI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nENLd4NDu0Y12IGEu1H4QABzckiCO9uAL5tvcNidxFIZ6dvqzLkQXS2as0UvpTyLk
	 qVJy6GvpAVeP0JHNu22tmw/CZZPfdK82eOVVsHMUvmkLz1dpjHuFs6d243G/QOMEFW
	 en1LmNWp2tG76J32Mnuh8np4TdH66ZlQ+vgK7zQ4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 29 Oct 2025 17:03:00 +0100
Subject: [PATCH 10/12] tools/nolibc: always use 64-bit time types
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251029-nolibc-uapi-types-v1-10-e79de3b215d8@weissschuh.net>
References: <20251029-nolibc-uapi-types-v1-0-e79de3b215d8@weissschuh.net>
In-Reply-To: <20251029-nolibc-uapi-types-v1-0-e79de3b215d8@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761753881; l=1220;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=FBBimS5ndn4H9cVjHfRa0/w3nWQHf6b6qw4nWJc1plI=;
 b=1YKTaEqVChLSKVXey+vB2/QdCCbCiCgHRJLQ2h7WOykDiw2cSkRLMLCttjOpskh2W3R6HozcZ
 DA/zNXY2tBvCKm0zzPnupRMspDU9scSBe2PPQcPrZ1BakX9aa0spvku
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

32-bit time types will stop working in 2038.

Switch to 64-bit time types everywhere.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/lkml/cec27d94-c99d-4c57-9a12-275ea663dda8@app.fastmail.com/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/std.h   | 2 +-
 tools/include/nolibc/types.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/std.h b/tools/include/nolibc/std.h
index 392f4dd94158..b9a116123902 100644
--- a/tools/include/nolibc/std.h
+++ b/tools/include/nolibc/std.h
@@ -29,6 +29,6 @@ typedef unsigned long       nlink_t;
 typedef  int64_t              off_t;
 typedef   signed long     blksize_t;
 typedef   signed long      blkcnt_t;
-typedef __kernel_time_t      time_t;
+typedef __kernel_time64_t    time_t;
 
 #endif /* _NOLIBC_STD_H */
diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index 4f5a25567e5c..3b086f68b2be 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -17,7 +17,7 @@
 
 struct timespec {
 	time_t	tv_sec;
-	long	tv_nsec;
+	int64_t	tv_nsec;
 };
 #define _STRUCT_TIMESPEC
 

-- 
2.51.1.dirty


