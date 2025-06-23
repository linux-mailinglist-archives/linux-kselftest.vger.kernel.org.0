Return-Path: <linux-kselftest+bounces-35651-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C73AE508E
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 23:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2FD41B6247B
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 21:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008E52236EF;
	Mon, 23 Jun 2025 21:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Ii9HZmjt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD5721FF50;
	Mon, 23 Jun 2025 21:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750713946; cv=none; b=Bdpsl4wuygUHJqoLqA7jRDSSiyO1qiDr2IXXN93uTDX//FiLFckPqjPaP3b19h2nQzeCUhookFOMegExaz4LWNNWIpuAGSB9O514YA+JfOOCfTNUURj5duprkCqfiEcQmoolUcWptTivVadOkTpLlCDHGhjzYZEx+udQmQXrEKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750713946; c=relaxed/simple;
	bh=K4401D/s9X8trfbLrKrkvgktSNGSmeMc0zrERdDGY3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=myJQcSBmLdlWe9JpLFFnE5MMiYdOR90oNOPzrTyJwHpbZifxNm3VDZSlpVCVqRhlx4OZ6b+MrMiRulMsOI2B9uiwM6HZ7BxvRKKNsKUQ94N5PdXpBxtkQ8fXgAHJbxb8VCdqBixe9BvoyuDfcMPWQYRabmADwK+skAK1T++jDDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Ii9HZmjt; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1750713942;
	bh=K4401D/s9X8trfbLrKrkvgktSNGSmeMc0zrERdDGY3o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ii9HZmjtJ1vzUHdZiyIfbR4GqgwIynWJh4u6bWLGRCOar7vU6FaeF1iggMqHIxTxT
	 l7hytbqGtMPIhZBLN1oBoQX5Tmrs4d7Ywm2bCEbeqcVK6ik3QkGz3t4dnEr9sguz5h
	 fvdbrooGK5fG3wCFg6ukSbamNvrBkU3h754DPfJI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 23 Jun 2025 23:25:37 +0200
Subject: [PATCH v3 2/4] tools/nolibc: MIPS: drop manual stack pointer
 alignment
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250623-nolibc-mips-n32-v3-2-6ae2d89f4259@weissschuh.net>
References: <20250623-nolibc-mips-n32-v3-0-6ae2d89f4259@weissschuh.net>
In-Reply-To: <20250623-nolibc-mips-n32-v3-0-6ae2d89f4259@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-mips@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750713941; l=1367;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=K4401D/s9X8trfbLrKrkvgktSNGSmeMc0zrERdDGY3o=;
 b=e+vX5aMPOhXOax9UhDwDZCV86w/LuP0z/Zp8WYsdiiuEu6dGlDugQGpSBk3IcpEOZp3x1Nc4L
 nwEZF3ibA71A4VjAftT13g2pRyRTJRzq/UOmi178qv5CGX01acRv6S3
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The stack pointer is already aligned by the kernel to a multiple of 16.
All modifications of the register have been removed from the entrypoint,
so the manual realignment is unnecessary.

Drop the manual alignment.

Suggested-by: Maciej W. Rozycki <macro@orcam.me.uk>
Link: https://lore.kernel.org/lkml/alpine.DEB.2.21.2502161523290.65342@angie.orcam.me.uk/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Tested-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
 tools/include/nolibc/arch-mips.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index 6d023d9f120301b2d6837c923c142ab2cf87ae5a..0776de7574b451aeb34531bc4696c7bd9b694268 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -186,8 +186,6 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector __
 		".set push\n"
 		".set noreorder\n"
 		"move  $a0, $sp\n"       /* save stack pointer to $a0, as arg1 of _start_c */
-		"li    $t0, -8\n"
-		"and   $sp, $sp, $t0\n"  /* $sp must be 8-byte aligned                     */
 		"addiu $sp, $sp, -16\n"  /* the callee expects to save a0..a3 there        */
 		"lui $t9, %hi(_start_c)\n" /* ABI requires current function address in $t9 */
 		"ori $t9, %lo(_start_c)\n"

-- 
2.50.0


