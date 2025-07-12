Return-Path: <linux-kselftest+bounces-37186-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508ACB02A36
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Jul 2025 11:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1A4566E9A
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Jul 2025 09:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BF0273D9D;
	Sat, 12 Jul 2025 09:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="tqGnIweP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEAE2222A1;
	Sat, 12 Jul 2025 09:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752310871; cv=none; b=rwjjCggGKz5lbfl0D2vlxf2rgCHY8fSekFHDaSSS75KcI87kPvylAUxKhrnlYgYsUutiTlIVOepj/dilIbA+E75waV0cBACzYVd4JwZLFc3uPzOFqz0DEEjTdUqadLrRMZV0/zNrTnAGKXNKs1Yyi9SHLBXbCnvHdaKzAapHcXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752310871; c=relaxed/simple;
	bh=I0Za4MEKM7buIuLwCwH7lBjcRz9CuM5dT8TU7XLat0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=De4dts15bRTZR6gkSbpOs4g7ar9JvFx90jdnTxx1Ry9Eye+6lgeLxtt+83BPGhyTK2+3Hadj1PzRSeY/4c69OfBdfGaMeown+909rTMDM6IdFkIoltRlGHy43twhxA8PeeoFebu38m6eTdp+oG8zAMVxOTGozoONTaxwDvKlpgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=tqGnIweP; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1752310860;
	bh=I0Za4MEKM7buIuLwCwH7lBjcRz9CuM5dT8TU7XLat0I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tqGnIwePXLbsa0mw3yWZR7Xaepn2mEEzHVK1daQ41ehH9tsVhteHORrrxQrUD2HDX
	 Xr0TrGkR9tvoLyMn7fT0mvbHNFhanfmnfZJCQQH7AQgHM2XdYwrdi+2wFOgFRVieiL
	 6eJMPyM70M2O/4fYC/sFRqyZZf8rkHtw8eGL+cvY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 12 Jul 2025 11:00:55 +0200
Subject: [PATCH 1/2] tools/nolibc: define time_t in terms of
 __kernel_old_time_t
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250712-nolibc-x32-v1-1-6d81cb798710@weissschuh.net>
References: <20250712-nolibc-x32-v1-0-6d81cb798710@weissschuh.net>
In-Reply-To: <20250712-nolibc-x32-v1-0-6d81cb798710@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752310859; l=1408;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=I0Za4MEKM7buIuLwCwH7lBjcRz9CuM5dT8TU7XLat0I=;
 b=UZN9QsKRiZ8w3QI2KQzkkXzaU+kAUvayrhE5jq+vw5OP8yYGgnpmuoQiF89gi0tzUK0bfqNhL
 oUmsGDrKwijAnzE87BhhDdqzikLGYMFSozz5AcTH/WDdbqbQ3Q1fYjM
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Nolibc assumes that the kernel ABI is using a time values that are as
large as a long integer. For most ABIs this holds true.
But for x32 this is not correct, as it uses 32bit longs but 64bit times.

Also the 'struct stat' implementation of nolibc relies on timespec::tv_sec
and time_t being the same type. While timespec::tv_sec comes from the
kernel and is of type __kernel_old_time_t, time_t is defined within nolibc.

Switch to the __kernel_old_time_t to always get the correct type.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/std.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/std.h b/tools/include/nolibc/std.h
index adda7333d12e7d2c336938ede1aaf215b4b93165..ba950f0e7338438823b4ee8c68a067391c719823 100644
--- a/tools/include/nolibc/std.h
+++ b/tools/include/nolibc/std.h
@@ -16,6 +16,8 @@
 #include "stdint.h"
 #include "stddef.h"
 
+#include <linux/types.h>
+
 /* those are commonly provided by sys/types.h */
 typedef unsigned int          dev_t;
 typedef unsigned long         ino_t;
@@ -27,6 +29,6 @@ typedef unsigned long       nlink_t;
 typedef   signed long         off_t;
 typedef   signed long     blksize_t;
 typedef   signed long      blkcnt_t;
-typedef   signed long        time_t;
+typedef __kernel_old_time_t  time_t;
 
 #endif /* _NOLIBC_STD_H */

-- 
2.50.1


