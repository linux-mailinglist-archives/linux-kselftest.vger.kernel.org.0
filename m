Return-Path: <linux-kselftest+bounces-46323-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E9DC7D452
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 18:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 327334E5B96
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 17:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DCA2C11F1;
	Sat, 22 Nov 2025 16:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="nW+9Pchq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1E8285CA9;
	Sat, 22 Nov 2025 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763830795; cv=none; b=cHvHQHK20LTAoM1Qs8KhFpoLWdk8cC07lWCIDNCOeIPchWYSXtIA91PneBWtO9qeG28HMi7C4do4vN0E3FjOtwsQaEtqbuNJfAaFpZNvpzy78bfD6879SPrhY+pRyDVXTZRUhjpA+XTczcHSc8vT3IYFKm+gF5JuM8ghaLV39Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763830795; c=relaxed/simple;
	bh=XjElBhpMXWH0kxV1GFxd879u/AH0m7wiE5TmbhqXv+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y9e8rdjAG6B2bKmd94fWKc+V7pcy3EfAfQWZIVm4jG2c7YAIb3IAYZHrFh8nyVmht9WJ9+xg6pVBlxD2YJHjA9NapJPp/4R1CM4RBIFUX/b9zHH0EHoh4WcDGYk5+uQbKgIr2ir2rXi5ogWFVE1Tr/Cjg4o9OXQlmk4GKKrCIPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=nW+9Pchq; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1763830791;
	bh=XjElBhpMXWH0kxV1GFxd879u/AH0m7wiE5TmbhqXv+E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nW+9Pchq9yJSvsSiiqCnVYBGlmcN7VSh8H+KVspR4G+JsHOLmQHz8st+InTq9bza4
	 MZcANpPjk/K2iGUPvFVpuyn7lYLvm5wSkw0ynEwA6BPCjPvsb+YYpi4D0CBqFOCPmE
	 Zm/c9iax7eXIRP1dp8gvk0jubTW8UJ3pllO1fzxc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 22 Nov 2025 17:59:13 +0100
Subject: [PATCH v2 07/13] tools/nolibc/select: avoid libgcc 64-bit
 multiplications
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251122-nolibc-uapi-types-v2-7-b814a43654f5@weissschuh.net>
References: <20251122-nolibc-uapi-types-v2-0-b814a43654f5@weissschuh.net>
In-Reply-To: <20251122-nolibc-uapi-types-v2-0-b814a43654f5@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763830790; l=1444;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=XjElBhpMXWH0kxV1GFxd879u/AH0m7wiE5TmbhqXv+E=;
 b=wnqI3Cd1pBq56uXjJRWyuMpMnLm2ZjeLcOqUvdodGpUpPtGtNf3Br2ARRWeiIQcrJg2zPQr7h
 upBLpKX8rCMAdnqt2t1GVPTbpuYjCT6rrgBJkn/ka4CWhlioMfcS4rY
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

timeval::tv_usec is going to be 64-bit wide even on 32-bit
architectures. As not all architectures support 64-bit multiplications
instructions, calls to libgcc (__multi3()) may be emitted by the
compiler which are not provided by nolibc.

As tv_usec and tv_nsec are guaranteed to always fit into an uint32_t,
perform a 32-bit multiplication instead.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/sys/select.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/sys/select.h b/tools/include/nolibc/sys/select.h
index f8870ad49687..80cb3755ba18 100644
--- a/tools/include/nolibc/sys/select.h
+++ b/tools/include/nolibc/sys/select.h
@@ -68,7 +68,7 @@ int sys_select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeva
 
 	if (timeout) {
 		t.tv_sec  = timeout->tv_sec;
-		t.tv_nsec = timeout->tv_usec * 1000;
+		t.tv_nsec = (uint32_t)timeout->tv_usec * 1000;
 	}
 	return my_syscall6(__NR_pselect6_time64, nfds, rfds, wfds, efds, timeout ? &t : NULL, NULL);
 #else
@@ -76,7 +76,7 @@ int sys_select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeva
 
 	if (timeout) {
 		t.tv_sec  = timeout->tv_sec;
-		t.tv_nsec = timeout->tv_usec * 1000;
+		t.tv_nsec = (uint32_t)timeout->tv_usec * 1000;
 	}
 	return my_syscall6(__NR_pselect6, nfds, rfds, wfds, efds, timeout ? &t : NULL, NULL);
 #endif

-- 
2.52.0


