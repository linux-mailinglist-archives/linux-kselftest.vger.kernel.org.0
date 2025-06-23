Return-Path: <linux-kselftest+bounces-35649-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 646F0AE508A
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 23:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A69FA189B979
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 21:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B6A2222C2;
	Mon, 23 Jun 2025 21:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="I1TjsbgX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DB721B9C9;
	Mon, 23 Jun 2025 21:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750713946; cv=none; b=NaNuBIv4TZ/xziOyiOuQAXxQakbb/3z/U2Et74JriOzx8betGZXccEdCC9nEL/sLXo0E7irb5FvBMrwIc5A3cxzmWXlgHywSqHJBiNplKDQNqXGGvlBbPl8Ww1Ro2pfdQLOMFwagrZ23iUyLyYLBiFuK0fVHrWVm0MxoD8VX/WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750713946; c=relaxed/simple;
	bh=98CrYfiF4BtrJsy4mcJlUCMY0HAKCKJDc4QFtC0CKUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TzabqLZx1JfR/OGe6mWeFPrrQKT3c+NCaMC7CcVhxc3mlRoA34VlFLbpHQAB7bGQPhvg+YNQkvRpYqeXogu4nC5IolX90MxooC5fNbQJ5qeXYFjPNPA5g6iYKovI8yutkBzPkLFc5cUy+qDS/jN0REBYuiEiol8LPfgV5yLD41s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=I1TjsbgX; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1750713942;
	bh=98CrYfiF4BtrJsy4mcJlUCMY0HAKCKJDc4QFtC0CKUs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=I1TjsbgXXK9fHk4KfpiRfGOnRNwphCmIif/IIkTvOi0Unj2PsnjzKLzmekjHo2RFJ
	 XXKpuKFTNVtM7rnK8aQh/uUK6BjwDqOlaXq6RngkA+P5T5hto/Me3HNK+NwJzsLyqc
	 8S4frozUVkRza2GKCo9y64doo7NQMkShtPg/NA3I=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 23 Jun 2025 23:25:36 +0200
Subject: [PATCH v3 1/4] tools/nolibc: MIPS: drop $gp setup
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250623-nolibc-mips-n32-v3-1-6ae2d89f4259@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750713941; l=1658;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=98CrYfiF4BtrJsy4mcJlUCMY0HAKCKJDc4QFtC0CKUs=;
 b=DK0FRPqX+11S7qlrhNy8SVQa/50ciVSsZU6ZHmlvqk4wFbgs9FFjgmrYGgQeaAkQZhWRb1W7F
 XFFiin8uqUyD6oPsbVcUOyCHUvpx6I/Wa6q5uaEfXCK32qHUEOeQAiI
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
Tested-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
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
2.50.0


