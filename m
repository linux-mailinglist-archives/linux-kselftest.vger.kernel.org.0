Return-Path: <linux-kselftest+bounces-35650-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66530AE5087
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 23:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D62714402AA
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 21:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEE022258C;
	Mon, 23 Jun 2025 21:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="hHskGiBO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BAD1EEA3C;
	Mon, 23 Jun 2025 21:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750713946; cv=none; b=gltKdp9/lM13KgBdP6hoadzNSlRGTJnBo0EsXU+zL3qvH00pk95hS1itBmp0wKvnmKT68HJPwTY4erz0kdN9vYTzJ20YoRdAi8pjmPVFObY7KejVufu5/BWdsl54BqEiRdCGP1RO3jnps1MCYkBHMt3+hHtP1j3QRsxKXRm2Ls8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750713946; c=relaxed/simple;
	bh=SA23DUA65m1dGBqAcEo41euuXPrElMD5TLx7znnGhkA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RE8sBb9dlb6ppJP6ouyQ8OnbfuTvPZJl/nlsGJFVSrm3kEgH32AE2CCzEeGVSXz8ArFSnya33US2EqshWTl2LfScYml1NH9fhYSxMynkrW23lmAbw/XLi/lh6LvQ02PRvI7NxvQU8Jkm6vgtO5B2NQLmGXx58djFjyKlW6gmOSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=hHskGiBO; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1750713942;
	bh=SA23DUA65m1dGBqAcEo41euuXPrElMD5TLx7znnGhkA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hHskGiBOUaOxBluiH2gxS4QMRHYVgiDSqwhPe0rJZxuTz3Es+Ql5mYaDL96YeKKo2
	 0ETzstdJE8/zdngrmxiMy0dYDGl1kk5l7Aam91He4Aw87j/LBFzagppcttFJ3l0lZR
	 WSDOj4NCZaapCCCWRUayXjsz4Y4mHWnl2THlbNCc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 23 Jun 2025 23:25:38 +0200
Subject: [PATCH v3 3/4] tools/nolibc: MIPS: drop noreorder option
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250623-nolibc-mips-n32-v3-3-6ae2d89f4259@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750713941; l=1537;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=SA23DUA65m1dGBqAcEo41euuXPrElMD5TLx7znnGhkA=;
 b=IvUwZdvvp82+e6RX8ICmudXsXZwwkixB+udr4AyjcliugVTFobYX1hu+dX8aeoWsdJ5Eee4HN
 WdCYOMk4jl8DiuDUheUVadYFrJx/hWPNVRxR1kdSuW5mCol1yNTnfMf
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

There are no more statements in the assembly code which would require
the usage of ".set noreorder".

Remove the option.

This also allows removal of the manual "nop" instruction in the
delay slot.

Suggested-by: Maciej W. Rozycki <macro@orcam.me.uk>
Link: https://lore.kernel.org/lkml/alpine.DEB.2.21.2502172208570.65342@angie.orcam.me.uk/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Tested-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
 tools/include/nolibc/arch-mips.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index 0776de7574b451aeb34531bc4696c7bd9b694268..4f0b969f66af610d3c986f3ff0e1c3f3a0be16b5 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -183,15 +183,11 @@ void __start(void);
 void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector __start(void)
 {
 	__asm__ volatile (
-		".set push\n"
-		".set noreorder\n"
 		"move  $a0, $sp\n"       /* save stack pointer to $a0, as arg1 of _start_c */
 		"addiu $sp, $sp, -16\n"  /* the callee expects to save a0..a3 there        */
 		"lui $t9, %hi(_start_c)\n" /* ABI requires current function address in $t9 */
 		"ori $t9, %lo(_start_c)\n"
 		"jalr $t9\n"             /* transfer to c runtime                          */
-		" nop\n"                 /* delayed slot                                   */
-		".set pop\n"
 	);
 	__nolibc_entrypoint_epilogue();
 }

-- 
2.50.0


