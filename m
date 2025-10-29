Return-Path: <linux-kselftest+bounces-44308-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B53A7C1C141
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 17:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 640AA5A1974
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 16:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081223469FF;
	Wed, 29 Oct 2025 16:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="GTTEROS3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAA333A03A;
	Wed, 29 Oct 2025 16:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753891; cv=none; b=iTRisic9/nNo+gP4fikYBDXcpPDTqHX0DlUIsYDfmqOdliqQZRQdr1PJLmst+GsIhfXg5M3h+v2rndLYoAoVlIIIyXygPKoJnskahGtSkMJ1Dl1+iAu+Co4T0GaFE0EIAxVLEL9LhfAd+1v2L8xiN3EFP3e7E2vZzQQgRLmRPDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753891; c=relaxed/simple;
	bh=qoHkysGDKD9OEHMs63XhS35a1MFgD32k3DYU2BDI5W0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KVJVTTxORX+1515OBRWgXBlEUN6P7QJdXyLgAjODYgDTwy+te0iGlXSRjskXFZ69KVx2kcyD2p6C0mTcrA32Rsy/N/JL0qNrhORuBRRNFGK4UJnJYrWzRBEnl1V796UccBhQmsDSbDNBmDXQYbivK085vz1UwRdrchxDhBLsTAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=GTTEROS3; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1761753882;
	bh=qoHkysGDKD9OEHMs63XhS35a1MFgD32k3DYU2BDI5W0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GTTEROS3AkaLH6Hr1fVXMTjEwJe73kokdKJ65auyDN6PfUStwttLkHmVmkIduIQ8N
	 8x3IEEkx6hW/gkTBYKZDWfFnl8seypat+ByfYxy+jNVLLT1XiduoWQ9naFfJBu8gTg
	 6ZJWN75yMgjB/T0HpCMdkK+Ls5nwv+FJ8GOjKGXM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 29 Oct 2025 17:02:51 +0100
Subject: [PATCH 01/12] tools/nolibc: use 64-bit ino_t
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251029-nolibc-uapi-types-v1-1-e79de3b215d8@weissschuh.net>
References: <20251029-nolibc-uapi-types-v1-0-e79de3b215d8@weissschuh.net>
In-Reply-To: <20251029-nolibc-uapi-types-v1-0-e79de3b215d8@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761753881; l=1065;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=qoHkysGDKD9OEHMs63XhS35a1MFgD32k3DYU2BDI5W0=;
 b=5mOLkkb6xRER4W+yPG9V2o5W3KgxjU8UFPI52SML1Ysw9pxLw7AxfTLvso/vv6sA+3T51Qr4b
 GNwsixToGWyC1LoPrJKTZ03cNBgF9wcK4KDomjH6JVHWXHGAymKJswk
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The kernel uses 64-bit values for inode numbers.
Currently these might be truncated to 32-bit when assigned to
nolibc's ino_t values.

Switch to 64-bit ino_t consistently.

As ino_t is never used directly in kernel ABIs, no systemcall wrappers
need to be adapted.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/lkml/cec27d94-c99d-4c57-9a12-275ea663dda8@app.fastmail.com/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/std.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/std.h b/tools/include/nolibc/std.h
index 2c1ad23b9b5c..eae457d60858 100644
--- a/tools/include/nolibc/std.h
+++ b/tools/include/nolibc/std.h
@@ -20,7 +20,7 @@
 
 /* those are commonly provided by sys/types.h */
 typedef unsigned int          dev_t;
-typedef unsigned long         ino_t;
+typedef uint64_t              ino_t;
 typedef unsigned int         mode_t;
 typedef   signed int          pid_t;
 typedef unsigned int          uid_t;

-- 
2.51.1.dirty


