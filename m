Return-Path: <linux-kselftest+bounces-27490-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9532A4477B
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 18:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E93E316D5B5
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 17:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0FA1946A2;
	Tue, 25 Feb 2025 17:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Ifq03blO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137F921ABC6;
	Tue, 25 Feb 2025 17:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503349; cv=none; b=CKlebBhZ6e5wUTD/zOFRZUTBbHaxTVpAZvoFgZoXoujjriMxvK61WaRqU8Kpvwv2P6DmXLLDEzb+gcmfHaHUhWTn4s98eRPjGgjRTif7xqa7fsyZ+aUKbEtvnhFqoewm88aoUFfUFQae2n8WFLHBJnLxfpaK/bxJNDMwpk2sZFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503349; c=relaxed/simple;
	bh=1Mqb0FDWIw1ADmmUeRDK34CWIdfCeF5F2u6J+Uft7vs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G4vj1U7ccEIcmnz+FqGfjmEhzwo6FbnDMPpPRcUaDjBlDhmFToA9lTkdCcD4vBiYaphoocf1Ebi2JxyBa/e5Rt1ziUiKGeH9QqYw18SP+kh/5NT4olTk8Y879p5UfF+n9cYyvKo0MIzmZ+muT4MdmhTl2YbocbdVOtiaW4alRhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Ifq03blO; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1740503338;
	bh=1Mqb0FDWIw1ADmmUeRDK34CWIdfCeF5F2u6J+Uft7vs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ifq03blOaWLnzDWxALkh/5kIOFbDhQ5fW2KYxQtPNIjGQBuJW/GR9LsmqiRsec+zB
	 gpd4EZdqYX25iaehz8Sn6gA5HBSfLMZksoV3loVvcBxyJZ2t/LqrJnYqcN5XZ2LfII
	 ZgfelOIhheUNlIjAfsCdA9mnIYnmQFZq+AuvEkQk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 25 Feb 2025 18:02:36 +0100
Subject: [PATCH v2 2/4] tools/nolibc: MIPS: drop manual stack pointer
 alignment
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250225-nolibc-mips-n32-v2-2-664b47d87fa0@weissschuh.net>
References: <20250225-nolibc-mips-n32-v2-0-664b47d87fa0@weissschuh.net>
In-Reply-To: <20250225-nolibc-mips-n32-v2-0-664b47d87fa0@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-mips@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740503008; l=1303;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=1Mqb0FDWIw1ADmmUeRDK34CWIdfCeF5F2u6J+Uft7vs=;
 b=cRGFF4h2F2lkimI3M21Jz1TDb3cTBnoPWG2lSF0CX11jS0x62rfYD9Tqk+NiEhvOFgA+Ym7G7
 3mNDvoL3ZYpCdOpcFak4KLyO1Hq81BlFIVPMC5PR17ly9wblxeVucEP
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The stack pointer is already aligned by the kernel to a multiple of 16.
All modifications of the register have been removed from the entrypoint,
so the manual realignment is unnecessary.

Drop the manual alignment.

Suggested-by: Maciej W. Rozycki <macro@orcam.me.uk>
Link: https://lore.kernel.org/lkml/alpine.DEB.2.21.2502161523290.65342@angie.orcam.me.uk/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
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
2.48.1


