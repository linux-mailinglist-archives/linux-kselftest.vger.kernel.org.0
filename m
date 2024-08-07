Return-Path: <linux-kselftest+bounces-14989-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCAA94B26B
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 23:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E8E61C210CA
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 21:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480E115A4B5;
	Wed,  7 Aug 2024 21:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="YzTqhX+E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FE8155C8E;
	Wed,  7 Aug 2024 21:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723067526; cv=none; b=MrnDajg532Fu9Ma+zw7zydlBGcXFaj01L6QCT4Pdb9qI6X7DPRfXwAeRYvf0Pj3Sx8XTFxJSd3JSOMvwohlpDooKjo7bWCQGsXV6vEtqe1EypKpZGR91b9BL71n5OXBKsw6CV8MKtVgDzv+FF0yUS8CbsYTJS69e4SWm5iRVpOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723067526; c=relaxed/simple;
	bh=uPw5miHYcaSsLeE2v10jPbSAr4/8J4GkU5tRfOmmqv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gb/rx4nOWV+hnDTru8VMr6D/M9MINhycR8cR1Y38dplBcPIPO8+tGv81l6nnaeU4EsRdmRphFvVryQdgM+ZjLn5Btrv9hlm7zBswVWvvp6eKi+eMGkagrQVJgH2QXW6/9HDeODpx+XImerAYMiGdqcgyjtiZZA+8EC7ajkZR9iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=YzTqhX+E; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723067510;
	bh=uPw5miHYcaSsLeE2v10jPbSAr4/8J4GkU5tRfOmmqv8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YzTqhX+EyHLy20A8WG0U25pkwIOoklpR19R1pOzupouvl9KE0AUdT0vhGYNdyqdfL
	 0zVDoj0FdVcTahQgnDCqby9k8zatM5SfgcTcLP4Lz2iuKo/nPWWAKrrLmztvculOM7
	 Er02FlMAjCAPhLHQb6jveA4E3xrORTtOFPCTycg4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 07 Aug 2024 23:51:42 +0200
Subject: [PATCH v2 06/15] tools/nolibc: compiler: use attribute((naked)) if
 available
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240807-nolibc-llvm-v2-6-c20f2f5fc7c2@weissschuh.net>
References: <20240807-nolibc-llvm-v2-0-c20f2f5fc7c2@weissschuh.net>
In-Reply-To: <20240807-nolibc-llvm-v2-0-c20f2f5fc7c2@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723067509; l=1484;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=uPw5miHYcaSsLeE2v10jPbSAr4/8J4GkU5tRfOmmqv8=;
 b=DKVzOhzwb0h0a9ucmjRw4LStFhFxlBu0FuQ4HwA3b23zXfM/JVxQu6/H5wHkop/4hVO7L0t9y
 bwkXGNDesQDCBNaar2i9MLSjrWYy047uVn1of7sqWP16bmWKQyF3w4G
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The current entrypoint attributes optimize("Os", "omit-frame-pointer")
are intended to avoid all compiler generated code, like function
porologue and epilogue.
This is the exact usecase implemented by the attribute "naked".

Unfortunately this is not implemented by GCC for all targets,
so only use it where available.
This also provides compatibility with clang, which recognizes the
"naked" attribute but not the previously used attribute "optimized".

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/compiler.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/compiler.h b/tools/include/nolibc/compiler.h
index 14a854929910..e4cb5cf772ee 100644
--- a/tools/include/nolibc/compiler.h
+++ b/tools/include/nolibc/compiler.h
@@ -12,8 +12,13 @@
 #  define __nolibc_has_attribute(attr) 0
 #endif
 
-#define __nolibc_naked __attribute__((optimize("Os", "omit-frame-pointer")))
-#define __nolibc_naked_epilogue() __builtin_unreachable()
+#if __nolibc_has_attribute(naked)
+#  define __nolibc_naked __attribute__((naked))
+#  define __nolibc_naked_epilogue()
+#else
+#  define __nolibc_naked __attribute__((optimize("Os", "omit-frame-pointer")))
+#  define __nolibc_naked_epilogue() __builtin_unreachable()
+#endif /* __nolibc_has_attribute(naked) */
 
 #if defined(__SSP__) || defined(__SSP_STRONG__) || defined(__SSP_ALL__) || defined(__SSP_EXPLICIT__)
 

-- 
2.46.0


