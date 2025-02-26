Return-Path: <linux-kselftest+bounces-27592-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CF0A45D77
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 12:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AF9D16B658
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 11:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E46521ABDF;
	Wed, 26 Feb 2025 11:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dC7RWRst";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p2wJLYMt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCFD218AB7;
	Wed, 26 Feb 2025 11:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570316; cv=none; b=rKvt1WT955fMl3ZXRbTmzqWHTCTLlUDmIick66jvoY1xZNlau9VTkeJQFiNHWdP4Ym8UrzXSD8BEH5DIv3qmh4GK6x5mbDcGJFxizGXbho+utr3s4AnGdrfoLZ7Q8RlIcH0UDfDeyfiDw7ILxSB8zR36OJhkdSgCFp25c5H57R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570316; c=relaxed/simple;
	bh=uMbwFQSW2wbApezo9DQH/BnNIMdQZar0Ezqf7xcu58Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tOHnOyprnXNDpEfMVs64HjCHzqg44moomc+HhS+1qn4jLtEPsMU4Nmtt2uUBPp9JbRBhTjbWB/hlU/RlrsNgFuNuADDiPJF7wvnsyOPmL5ZkYPnkVIAXDRDWsFS36bssOhqKD9wSo3DietNlarPUiE2DUPbjqZSb/Yge8ajC00s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dC7RWRst; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p2wJLYMt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740570311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k9pJvPJRoot4AT1h69bhn9vc1GanKxm+mtfLKQnaoF4=;
	b=dC7RWRst00MR9iLmG1iI2b5cbgzkgiVwWBn0rDD4HVIfYUSuYojRsR/TmE4RQmWGHNvJ+2
	77jKMGmT7QUb9GGXEH6BgCtKx8H2mDwpZPu9v2GWMPYLr040SgXS/LOxwnpTo5AXAvjjZY
	0UU6ZLw7D5pTQxbFsvxUZ6RqphD15YS0/KLoZ6u6FY3NZ3pmHV5l9GfiT3txGa8oC1LpO9
	MhPkybzWhm7Gdxj4aYuI8CpcXmYHNdOhgqXHolufvud1+ZYWcvb9jwmZLUQgm+1HQxQxJU
	m2uujyAmHrqemW05yghgOO+PufC36Ypuvo1WUGAYMciRvy0yHbKhKp3QIVZGZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740570311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k9pJvPJRoot4AT1h69bhn9vc1GanKxm+mtfLKQnaoF4=;
	b=p2wJLYMtdpFHXL/9QycDKpVmsl95tT5ehlvebqkIkYEFtNGrVIsnpJyr+1WpYjd9T61LR7
	YjJ8/JUjJsaEohCQ==
Date: Wed, 26 Feb 2025 12:44:44 +0100
Subject: [PATCH v2 05/16] elf, uapi: Add type ElfXX_Versym
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250226-parse_vdso-nolibc-v2-5-28e14e031ed8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740570307; l=1126;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=uMbwFQSW2wbApezo9DQH/BnNIMdQZar0Ezqf7xcu58Y=;
 b=7CvId9mvKa9//HzXCxvhR1VmXOx23JW3X291jiX1R+XcNhWx5UgmMqTiFxZ+a3AXSWFC+nXzl
 /gMgqN7haSpDrF2zUs3SczycGbg7PP7Jvfv59hjA3ElJYqWD8Q0IvHT
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The types are used by tools/testing/selftests/vDSO/parse_vdso.c.
To be able to build the vDSO selftests without a libc dependency,
add the types to the kernels own UAPI headers.

As documented by elf(5).

Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/uapi/linux/elf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index d040f12ff1c0ae3dde5c371c81d6089118fbe8ed..8846fe03ca5b836c96aad1be6d8fb9daf3d4b1d9 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -11,6 +11,7 @@ typedef __u16	Elf32_Half;
 typedef __u32	Elf32_Off;
 typedef __s32	Elf32_Sword;
 typedef __u32	Elf32_Word;
+typedef __u16	Elf32_Versym;
 
 /* 64-bit ELF base types. */
 typedef __u64	Elf64_Addr;
@@ -21,6 +22,7 @@ typedef __s32	Elf64_Sword;
 typedef __u32	Elf64_Word;
 typedef __u64	Elf64_Xword;
 typedef __s64	Elf64_Sxword;
+typedef __u16	Elf64_Versym;
 
 /* These constants are for the segment types stored in the image headers */
 #define PT_NULL    0

-- 
2.48.1


