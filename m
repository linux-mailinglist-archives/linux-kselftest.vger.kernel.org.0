Return-Path: <linux-kselftest+bounces-27492-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 528F2A4477F
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 18:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039CC189F7EC
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 17:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4BB19DF66;
	Tue, 25 Feb 2025 17:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="b+d6typJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208CF19A2A3;
	Tue, 25 Feb 2025 17:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503352; cv=none; b=fzT/N55lt5tomhuu4CMFoJ7P5NQg46BIqbyMdLDmpfe6o/DW/X7/1jtnpzvCn9IAegVnH4xYdVaXuvWmERnhqM8t+5siehHinImjzjBo3/5bShAuLpo7+VacpEdpQVH6hY896rSuaWblDZy595M+bFq/agAkHkit2awb3248mb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503352; c=relaxed/simple;
	bh=ltB/XAdB3jNItQt5mTbOe6zKx+95H3PtXZrFAkjq5q4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UCJvgErPLcCfDBz4BvhrernmLaoROb9YG7eFc2oZd3jr95JBp8k3vqKANxTsL6dhVczkszSCK6GtMXSjN27TN+f7UKJlqlsXooYIgCzrCWQaSjxAHH8Pzg6Sej5eVrMqSmxDswdBb0wfftfk0vewknrfsgwVq9El4P03XT0TurQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=b+d6typJ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1740503338;
	bh=ltB/XAdB3jNItQt5mTbOe6zKx+95H3PtXZrFAkjq5q4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=b+d6typJdFe8/svdfTXHRZW0ElqZ3yebqmi7ALC4LLapeBJyC2VWm9Sp8IQ1gr4JT
	 hqwzOYDvhy8VMoGnoQo+P4cX/calWogBEhcsjgk3be+QLhSoFDKzYo+VLwgQnuxu8c
	 Gty4njrDv0f/ijoivZb4yj2r/18PiSacHUWRE15g=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 25 Feb 2025 18:02:35 +0100
Subject: [PATCH v2 1/4] tools/nolibc: MIPS: drop $gp setup
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250225-nolibc-mips-n32-v2-1-664b47d87fa0@weissschuh.net>
References: <20250225-nolibc-mips-n32-v2-0-664b47d87fa0@weissschuh.net>
In-Reply-To: <20250225-nolibc-mips-n32-v2-0-664b47d87fa0@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-mips@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740503008; l=1594;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=ltB/XAdB3jNItQt5mTbOe6zKx+95H3PtXZrFAkjq5q4=;
 b=n4CAPihLJlfQdjMT/TJkL54ct9w67ERTMeEPBT8NHXhHZQNhy7vCN5E3m0d5oJ2Adly0+FrCC
 iNc/qtRBWRyAAJAt9LtrO+R+GcQovJD3/mzBS1+Ag1v8XVOGsYyWnJc
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The setup of the global pointer "$gp" register was necessary when the C
entrypoint was called through "jal <symbol>".
However since commit 0daf8c86a451 ("tools/nolibc: mips: load current function to $t9")
"jalr" is used instead which does not require "$gp".

Remove the unnecessary $gp setup, simplifying the code and opening the
road for some other cleanups.

Suggested-by: Maciej W. Rozycki <macro@orcam.me.uk>
Link: https://lore.kernel.org/lkml/alpine.DEB.2.21.2502172208570.65342@angie.orcam.me.uk/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/arch-mips.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index 753a8ed2cf695f0b5eac4b5e4d317fdb383ebf93..6d023d9f120301b2d6837c923c142ab2cf87ae5a 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -185,13 +185,7 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector __
 	__asm__ volatile (
 		".set push\n"
 		".set noreorder\n"
-		"bal 1f\n"               /* prime $ra for .cpload                            */
-		"nop\n"
-		"1:\n"
-		".cpload $ra\n"
 		"move  $a0, $sp\n"       /* save stack pointer to $a0, as arg1 of _start_c */
-		"addiu $sp, $sp, -4\n"   /* space for .cprestore to store $gp              */
-		".cprestore 0\n"
 		"li    $t0, -8\n"
 		"and   $sp, $sp, $t0\n"  /* $sp must be 8-byte aligned                     */
 		"addiu $sp, $sp, -16\n"  /* the callee expects to save a0..a3 there        */

-- 
2.48.1


