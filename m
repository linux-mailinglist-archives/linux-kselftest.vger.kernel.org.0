Return-Path: <linux-kselftest+bounces-27491-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D0FA4477D
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 18:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6668B172315
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 17:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CCC198E65;
	Tue, 25 Feb 2025 17:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="AujNCIr5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757F3192D9A;
	Tue, 25 Feb 2025 17:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503350; cv=none; b=rMZ+qldkJSMcU0xWr0hTq0IQZy9MMKvTmehIXT7AnSPLgfsF3aoLuoqh6+HHjL4RluMQeZqGe68NH44KXMMO6a7g5T664Y+IhPhXtj7NnC9fbzgKhDZO5X9cdeug5yTSCPjz4a7V2czXaNVHCkOi7r027/WPwDAExuvHIIcd/xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503350; c=relaxed/simple;
	bh=5OYrKNTDrnzrdbAbWnukqr+FlUr2PbT0NF4dYqju2dE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MkKVxf0OwKpw0ClJa6GihnwC/ZPI4aZsfMZfIZm23s3UMZPLhqk0A07vHG+PEmzjaXcme33jWWaLzGLcPX3xlVYgz6MfE6g5K0uPdUtDQhanYy8N70GJcBqr9IxqiSaID3evvz1uFkBZW5vS0ivPfYide3AGFofbJphQuUbpc6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=AujNCIr5; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1740503338;
	bh=5OYrKNTDrnzrdbAbWnukqr+FlUr2PbT0NF4dYqju2dE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AujNCIr5laqn8G0lMCb4OQRU3f2O20aXwMAMZJzQpmqTVn5zM9bmzf8tJfWn+uXD9
	 3/RUJaZvFLisDX8zjTswmxvllCNr/29lDe+xOcrkLIoMLNPh3K0K+Qz/hcBWX6g/c+
	 ZPCfWgRiit6jtV5k/jiUUQnWyd/vmkEjghy5ZKlE=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 25 Feb 2025 18:02:37 +0100
Subject: [PATCH v2 3/4] tools/nolibc: MIPS: drop noreorder option
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250225-nolibc-mips-n32-v2-3-664b47d87fa0@weissschuh.net>
References: <20250225-nolibc-mips-n32-v2-0-664b47d87fa0@weissschuh.net>
In-Reply-To: <20250225-nolibc-mips-n32-v2-0-664b47d87fa0@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-mips@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740503008; l=1473;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=5OYrKNTDrnzrdbAbWnukqr+FlUr2PbT0NF4dYqju2dE=;
 b=xBx3KYZ+NRwonj8XeBX1Z4kI9rvA8Vsv+sAhWEQS0kNh3xTUjVREZheGygUySRGGvatEalAqH
 bqRY8W0HCSUDaSZ7/RaS4oQNjpg3OrSyQNolmIyLjipvPhWQuaixsNQ
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
2.48.1


