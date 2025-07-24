Return-Path: <linux-kselftest+bounces-37916-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12955B1008D
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 08:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4883A5827D6
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 06:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51790230BD9;
	Thu, 24 Jul 2025 06:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3qeOlGYx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gEtwxibg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEED22257E;
	Thu, 24 Jul 2025 06:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753338441; cv=none; b=CioW2NLV/9OaC5RLVZBOv3yWdEsEoLlsGYuWQZI9bNmIafWqoD/PfVkJy9JMdhMjneQsL3vEgY7jg9iaUpIbcgqSCEhaMy7VungQZJFnNDUXXUqWvzvlFZzQ+0UWwpko39xwv/YGVcltijtnjg0iE34H1kHhlqmoySDH4tmNXug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753338441; c=relaxed/simple;
	bh=/d7Kjsadf0MQRlQ8rFqan/QHEDoMwt3EGw/m83TdkFo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gT8/JVsho8hmEJxE+U1iDKJepSjyKDNlw/RJkH0uyzv+6n9v0M96fvgwxCxIYnGw2m7Szl2EKkVUJ24VX7swZYJqH7Gvm7K+ye75fScvAi0joem+9yYDm0/wXdko7Hi/JwbyDwHZYUEJazFs5ogVy5W+1dXD/6Vx8vgzFtSd8Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3qeOlGYx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gEtwxibg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753338436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qnPjxZaxoUQoAn4OPvNzydHs4g6dzmGoN+Wts/M/WYo=;
	b=3qeOlGYxH01gD3LGaNeCUPCa4f084EZfqzvIreiyxUe3B4m7QcmpfI9rIO2VA5txiXfEzH
	JzRiaX+GJJ+naQ2niRQocgjoth62deT9eSLoBj2dtMaZZjxYj00Qtfn73rKlKaHwQvdaoh
	hUb7fuqlSXwf9DzdcZzzSbO3QGnE5+E6C2aBRG6U68GhhpBl4Qi8aTw7stNS7E4/+NWYEm
	c96+gEXv6ow4+RHYs8OlSAun5PSYEQPR2teZZ1txMDY82Hsifnes2PecHPbCFfkuqXrONF
	YeMupxFxCAlSi1roAaT8xQosKCaYN8hNv3eRFxMHxXN4TkU26Y+bapXTxh+2nQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753338436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qnPjxZaxoUQoAn4OPvNzydHs4g6dzmGoN+Wts/M/WYo=;
	b=gEtwxibgHE9oKBSiANKZQmaaZwidwb5LeW3MFTE5H+x3QPEeS3MlvALGpAr460bc9RAcw2
	qvMKWZMNn1s+AqAw==
Date: Thu, 24 Jul 2025 08:26:55 +0200
Subject: [PATCH RFC 05/14] sparc64: vdso: Remove obsolete "fake section
 table" reservation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250724-vdso-sparc64-generic-2-v1-5-e376a3bd24d1@linutronix.de>
References: <20250724-vdso-sparc64-generic-2-v1-0-e376a3bd24d1@linutronix.de>
In-Reply-To: <20250724-vdso-sparc64-generic-2-v1-0-e376a3bd24d1@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>, 
 Shannon Nelson <shannon.nelson@amd.com>, 
 Nick Alcock <nick.alcock@oracle.com>, John Stultz <jstultz@google.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 sparclinux@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753338429; l=2564;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=/d7Kjsadf0MQRlQ8rFqan/QHEDoMwt3EGw/m83TdkFo=;
 b=1bxswy2EUvZBfEj28hof6i7LepniZLsXdxfY5zXKFbSN/FbVBhMzKC1fHd4NooKMuW9baL0vS
 EIMiKFNUntkCuMb8+De5qEfB9lo6ZX/Rk2ROtFhTLrA6sdBfcmdysH5
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
2.50.1


