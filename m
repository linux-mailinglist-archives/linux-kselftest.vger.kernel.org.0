Return-Path: <linux-kselftest+bounces-41712-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FC3B7FD76
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 16:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E132B1C82D24
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275BB2EBB9A;
	Wed, 17 Sep 2025 14:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z30Hwa++";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uny7uvHO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735C82EACF9;
	Wed, 17 Sep 2025 14:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117737; cv=none; b=gBV8ZUVcoCMwJU0qv4eC7XkQtfbECDfO5UsMzVTu+i4oXB4/6QshU9/5bUglCBbhJEcyZr0mHdALCtm6Rm5k9lQ/c3RMo0rKHVHKM/WXMAZwmKFr2gFr25sQqTR3HUbiNwALxTOIUEZfDPxb+tlmy25A8dBTHW38OvBHGe+1VBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117737; c=relaxed/simple;
	bh=8w72gLGme3rV9N/8xInoEUzLlu1u1Hn8GjckW/Fu+5Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S7FhK2sfjg62gVuG1u8x8/kNg9yzIH/Tv/aZX5G96aFsN/Ep8HEFmGTez0WCYTnucFCg8czrKYqOu2et+gCuY6FJLokaMv0vfdP3sLCDrY5F1Zo6zMmj+9BoI9gJIpqoQ9UgaBu+d/dyuLG2EuFphKg/m7esQ65oPk28DtIp8YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z30Hwa++; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uny7uvHO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758117729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mRNw6GkZZ0SOwENot0cflaJo5WOKKLsTLyEwUK24zow=;
	b=Z30Hwa++YpmdECroIgGLGo2qdagWua1+42J45XnVC49cul3KcaHrxdUhuIBDt3V6HVyw9C
	x88vdcmNUH+OJGU/N36wEOa0fbSZhPDuG1A9ophk5d2oEXjvV+ErtH03aur3YOEmSJq05H
	yrUWa94v4xD6JlJlYveDMSAGZz2bYTDERdBAVq5FJdApxjq9Eo4P5wTRB6cJccOQ71YjVQ
	otSwetGTNZAeftVt5GIw0Gd/RSIhYYG9VmMDIp2lEWNuVjA+ZrAC3C96zv+KIXdcuxaOGe
	tWprgkciuzV2udYjb1dIADelwFE05b/S6ia4nm2ZwKn6+icRQgRTcbN290SKCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758117729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mRNw6GkZZ0SOwENot0cflaJo5WOKKLsTLyEwUK24zow=;
	b=uny7uvHOBpJaQmiyNWgZDoVcJ/W4s4C4UJydeIXx+29V6CWnPmW/6D9xgUBg+G1HuhVrw6
	/GPNUaUtapK0CQDQ==
Date: Wed, 17 Sep 2025 16:00:28 +0200
Subject: [PATCH v3 26/36] sparc64: vdso: Remove obsolete "fake section
 table" reservation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250917-vdso-sparc64-generic-2-v3-26-3679b1bc8ee8@linutronix.de>
References: <20250917-vdso-sparc64-generic-2-v3-0-3679b1bc8ee8@linutronix.de>
In-Reply-To: <20250917-vdso-sparc64-generic-2-v3-0-3679b1bc8ee8@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Nick Alcock <nick.alcock@oracle.com>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Shuah Khan <shuah@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>, 
 Shannon Nelson <sln@onemain.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
 linux-mips@vger.kernel.org, linux-s390@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758117712; l=2564;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=8w72gLGme3rV9N/8xInoEUzLlu1u1Hn8GjckW/Fu+5Y=;
 b=QgCYHWUCSKPu9lf4c4OeQFeEjv9jGji9gCgDezyDsZYodT0c3UE1Qh/8caZxZEy4/G9jAr3o+
 +gt1ht2t+QnC4eIxVKBSv2ORSay29H8EfuooOZ1hluInrsoTIoX56qW
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

When the vDSO logic was copied from x86 to SPARC some unused remnants of
the fake section handling were copied, too. In x86 the original fake
section handling had already been removed incompletely in commit
da861e18eccc ("x86, vdso: Get rid of the fake section mechanism").
On x86 the reservation was only cleaned up in commit 24b7c77bbb24
("x86/vdso: Remove obsolete "fake section table" reservation").

Remove the reservation for SPARC, too.

Fixes: 9a08862a5d2e ("vDSO for sparc")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/sparc/vdso/vdso-layout.lds.S | 21 ---------------------
 arch/sparc/vdso/vdso2c.c          |  8 --------
 2 files changed, 29 deletions(-)

diff --git a/arch/sparc/vdso/vdso-layout.lds.S b/arch/sparc/vdso/vdso-layout.lds.S
index d31e57e8a3bbffd3afb187cd631e2491fde64148..9e0804789d11696948f11be367480b530a1f18d9 100644
--- a/arch/sparc/vdso/vdso-layout.lds.S
+++ b/arch/sparc/vdso/vdso-layout.lds.S
@@ -4,16 +4,6 @@
  * This script controls its layout.
  */
 
-#if defined(BUILD_VDSO64)
-# define SHDR_SIZE 64
-#elif defined(BUILD_VDSO32)
-# define SHDR_SIZE 40
-#else
-# error unknown VDSO target
-#endif
-
-#define NUM_FAKE_SHDRS 7
-
 SECTIONS
 {
 	/*
@@ -47,19 +37,8 @@ SECTIONS
 		*(.bss*)
 		*(.dynbss*)
 		*(.gnu.linkonce.b.*)
-
-		/*
-		 * Ideally this would live in a C file: kept in here for
-		 * compatibility with x86-64.
-		 */
-		VDSO_FAKE_SECTION_TABLE_START = .;
-		. = . + NUM_FAKE_SHDRS * SHDR_SIZE;
-		VDSO_FAKE_SECTION_TABLE_END = .;
 	}						:text
 
-	.fake_shstrtab	: { *(.fake_shstrtab) }		:text
-
-
 	.note		: { *(.note.*) }		:text	:note
 
 	.eh_frame_hdr	: { *(.eh_frame_hdr) }		:text	:eh_frame_hdr
diff --git a/arch/sparc/vdso/vdso2c.c b/arch/sparc/vdso/vdso2c.c
index dc81240aab6fd31a72b8a751cc2a4a821a3c4e4e..b97af5ec9f35c01f2a976b6213b1768b677ad231 100644
--- a/arch/sparc/vdso/vdso2c.c
+++ b/arch/sparc/vdso/vdso2c.c
@@ -61,8 +61,6 @@ const char *outfilename;
 /* Symbols that we need in vdso2c. */
 enum {
 	sym_vvar_start,
-	sym_VDSO_FAKE_SECTION_TABLE_START,
-	sym_VDSO_FAKE_SECTION_TABLE_END,
 };
 
 struct vdso_sym {
@@ -72,12 +70,6 @@ struct vdso_sym {
 
 struct vdso_sym required_syms[] = {
 	[sym_vvar_start] = {"vvar_start", 1},
-	[sym_VDSO_FAKE_SECTION_TABLE_START] = {
-		"VDSO_FAKE_SECTION_TABLE_START", 0
-	},
-	[sym_VDSO_FAKE_SECTION_TABLE_END] = {
-		"VDSO_FAKE_SECTION_TABLE_END", 0
-	},
 };
 
 __attribute__((format(printf, 1, 2))) __attribute__((noreturn))

-- 
2.51.0


