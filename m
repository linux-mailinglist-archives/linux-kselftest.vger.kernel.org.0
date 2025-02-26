Return-Path: <linux-kselftest+bounces-27600-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3969A45D82
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 12:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5C6F1720D5
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 11:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565F321D3F3;
	Wed, 26 Feb 2025 11:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pkZldx7g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3nuVc8yk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF876216E01;
	Wed, 26 Feb 2025 11:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570320; cv=none; b=nVSKoheFYgLaA0StoABx/rpY+z8+7R+4bq0YJDXzE3Zgs0uInExVV2s7hBzVPo6P4xnCvV/K1n8rB0sA7zo4O/vPLt3pne/Er5DOrKJVvgRha74rRiI3nCvZcy3Jow0BCo9DqQ3hcJpuS9UREH9F5zIzg7/7kG3h0+3Pvf8GM68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570320; c=relaxed/simple;
	bh=fJM1dVn7zNhQ0eUj0mWU+BrWz8rCvgfwxzZIAbjOWds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QskLq/Dc8Nknu9yHGP/k2ra+YDrKxRCyxYNJQIqKquZCCMbJvLzp8k4ompK+mfGAhvz4QuC5/iORjXvQWLvQRO3Ax51SxsCDPGBvB6re/AyXgi67ETD+I6wvLoaZDki91ZrUmgiBjNFciiGk4tv4aB5xGj/IDLPQBHrnIr/K8rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pkZldx7g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3nuVc8yk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740570316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tIWdgZoCmwWBnzk969udACPDuwBISkKWyW+kvFZi0zY=;
	b=pkZldx7gjJAIiP6Nyp/tpg4NYTfib6x4vgodgj73oB+tPwbKvV8NdIF+2BJJvtycke8FpL
	h9NqNmmpoAbu7pXRZMFVs2F+7ukszsBgdWA2HO+A97PHCQ4i0tcmmqTkuEMyeDVVb9VE6y
	iIiLUM6KYyakr3Wm6aZzfULArGCHGPOjkVaX2FwHppny4NsBoYEJ9wMCcDBO4VOMVOeImj
	dIPOwKZ4GOIqcnGEIpsUM5rutMjfaNbwiI0TfDsPCNbFb0dFeOhL3DuVz/tIjtTQJIR87a
	X7OO8cPAxnZmy4vyy9NhMTejn2RHhv8oNi/fLToBjWGlLvEuiral2C2tbhbCXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740570316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tIWdgZoCmwWBnzk969udACPDuwBISkKWyW+kvFZi0zY=;
	b=3nuVc8yk0FkiZuhMCvs0za0GLuZOJLXEmd1sfgMJQzXyaNSBugPsC+D9KDC575YiFhtpXW
	ZBuMfSYPJKNTl8Bg==
Date: Wed, 26 Feb 2025 12:44:52 +0100
Subject: [PATCH v2 13/16] selftests: vDSO: parse_vdso: Test __SIZEOF_LONG__
 instead of ULONG_MAX
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250226-parse_vdso-nolibc-v2-13-28e14e031ed8@linutronix.de>
References: <20250226-parse_vdso-nolibc-v2-0-28e14e031ed8@linutronix.de>
In-Reply-To: <20250226-parse_vdso-nolibc-v2-0-28e14e031ed8@linutronix.de>
To: Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 llvm@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740570307; l=1086;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=fJM1dVn7zNhQ0eUj0mWU+BrWz8rCvgfwxzZIAbjOWds=;
 b=6T6VWDZMcel2G6Zqb6mCesiA8PGT6B0sNETzWQ66Mp/5lSowPPuzzGpKaqlAcHkLRbfII0Z0s
 Syn1yJLgRIeDf3EJEi1iCsi/So3t2zJFCJRojcc15ZDIoqi2lQC5yju
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

According to limits.h(2) ULONG_MAX is only guaranteed to expand to an
expression, not a symbolic constant which can be evaluated by the
preprocessor.
Specifically the definition of ULONG_MAX from nolibc can no be evaluated
by the preprocessor. To provide compatibility with nolibc, check with
__SIZEOF_LONG__ instead, with is provided directly by the preprocessor
and therefore always a symbolic constant.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/parse_vdso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
index 200c534cc70e2c2381fce3be5c0ebe4cb5675e84..902b8f9984a1f70049d46bcd4f199df24f507dcb 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -26,7 +26,7 @@
 
 /* And here's the code. */
 #ifndef ELF_BITS
-# if ULONG_MAX > 0xffffffffUL
+# if __SIZEOF_LONG__ >= 8
 #  define ELF_BITS 64
 # else
 #  define ELF_BITS 32

-- 
2.48.1


