Return-Path: <linux-kselftest+bounces-44313-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A94FDC1BF93
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 17:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D677519C29EE
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 16:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772E9350D62;
	Wed, 29 Oct 2025 16:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="qsXEFgPW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A7534DCE0;
	Wed, 29 Oct 2025 16:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753895; cv=none; b=TJRHuQXGhq84osw4yAgS2h+AM04nQw+GeKgVCiuzHzyD48rOMu/UE2/QuBctZofAj/qs+YFTZ7PxbzostaB6OE+i1ELtoIbwViSTsWA0yCycjdMKLTO8lNhmtRuMcB+ioEpCGhDuPm9wuOlAfEeotwIk6ozvE0tmVzDCERSR3gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753895; c=relaxed/simple;
	bh=+qwmC43SORwO1oCatMlbgPGu9VROVZZOikEDPBsvhCw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O1rdAD18MViWEm5N0Ikm6zUqSOSC3x4PTsf8SrTOlBxgNGLKhZ4HKwrpuM1JAL1dpursMa5SdiUHA//6o7oSP6EYXAhZC8V6bGp40Q4h0kuNsvg9/VhSftEDEqSsTB4SLP9AdCJ3kNFUL8K7I14PFV1t/Q4KBFqABO/qkI8c9nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=qsXEFgPW; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1761753884;
	bh=+qwmC43SORwO1oCatMlbgPGu9VROVZZOikEDPBsvhCw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qsXEFgPWmbzkPvG0bBu4uLyA3w4NxPVeJCKoBcWVtg9FstsXh2yM5pQYOcS5BqBgX
	 0K2vE951E2TI35Z5r64LxFAO+A58rW7lAl24M5AIN48m5QKEqXikvrdQGWzmoTN84u
	 r2pMZXq0K0QfLgYL/GdRAvwsdj7iAb3bvaf00p9E=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 29 Oct 2025 17:02:58 +0100
Subject: [PATCH 08/12] tools/nolibc: gettimeofday(): avoid libgcc 64-bit
 divisions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251029-nolibc-uapi-types-v1-8-e79de3b215d8@weissschuh.net>
References: <20251029-nolibc-uapi-types-v1-0-e79de3b215d8@weissschuh.net>
In-Reply-To: <20251029-nolibc-uapi-types-v1-0-e79de3b215d8@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761753881; l=993;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=+qwmC43SORwO1oCatMlbgPGu9VROVZZOikEDPBsvhCw=;
 b=WyBDzC+kNvpJKnBOyPI57pNu8KIRUEo+2qWq1qf2mP/AdZeWc3/eL+6rLTdw1C0/eKpo7A4Ep
 i7m+kyfAGaNDbbQ9FW414+WyJ4dH1LXOmcFokeyeXcSSi4JJVHK9u53
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

timespec::tv_nsec is going to be 64-bit wide even on 32-bit
architectures. As not all architectures support 64-bit division
instructions, calls to libgcc (__divdi3()) may be emitted by the
compiler which are not provided by nolibc.

As tv_nsec is guaranteed to always fit into an uint32_t, perform a
32-bit division instead.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/sys/time.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/sys/time.h b/tools/include/nolibc/sys/time.h
index 33782a19aae9..6dd3705c6c9d 100644
--- a/tools/include/nolibc/sys/time.h
+++ b/tools/include/nolibc/sys/time.h
@@ -33,7 +33,7 @@ int sys_gettimeofday(struct timeval *tv, struct timezone *tz)
 	ret = sys_clock_gettime(CLOCK_REALTIME, &tp);
 	if (!ret && tv) {
 		tv->tv_sec = tp.tv_sec;
-		tv->tv_usec = tp.tv_nsec / 1000;
+		tv->tv_usec = (uint32_t)tp.tv_nsec / 1000;
 	}
 
 	return ret;

-- 
2.51.1.dirty


