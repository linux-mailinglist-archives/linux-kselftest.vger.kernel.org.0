Return-Path: <linux-kselftest+bounces-25538-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0B8A25548
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 10:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3E333A42A3
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 09:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AA11FC7FD;
	Mon,  3 Feb 2025 09:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3DWraR5V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LyOYwDg0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0365137932;
	Mon,  3 Feb 2025 09:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738573522; cv=none; b=FysnNOO8bhyEACT4s4LyESv3zGPBL1XVf78W8ly6ng9SPuMv//XryM0ilTg9XiXuGbe+Wf6qGXfCxxZv+xsB+TFQEHzNrpYHRgbgrCNGzRMTbHNGuLs5tG3benVn2ys72fu41qfYB1qaqaNedzMHpz0VGKBcL2KHOXZwlpflXcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738573522; c=relaxed/simple;
	bh=FEaofIv+JUjjywiT6rS3O3D+OYARr4o4oDpoALKMPN0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tgt7bHpKOJNE939MJbY/sC6u6AwH3bWa5oLqNlQ7YIT7/Xqu4wCyZfTBpa+AAIWWwdiJFAYnpq7AHIUkEmmQ6wR/qtjUOd+cf4PaN75I9CkLZjs4Bw90V3PVS9S5WtRVuOrGqJY9iZkiPDytu8m10ZmRiJp9HoCM7sSYvbRBsPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3DWraR5V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LyOYwDg0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738573519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AqxvCmKG6a1x16hCjSThnsvuCnWxl1ds6KfWld3LsEI=;
	b=3DWraR5VL+9WHCcpWsJXy2P1Q24o82I0qjNBzIt9UikDP9RupiPDfU3dDc5C56/15JbM02
	0/ODqp9vKX/deI0nUddGy0kI8ppPkcBsTHXoWM+FA+NV9IHhLlJk8zxDxNKFoUePmzTjvs
	ADvkS6GYonpLMgc4AsiMy4JlGfV+980qTyDm7KH3Ostxuml9JvWdeJ7NPDQEsJ5zv26nNp
	AD/uAb5Ca240xw6nfI0HsaTL8gm+3q1zTQbGx6lvqokEdEWdotjw9X8PY+WyQzNkpjLiDL
	Vc9e+dGqpNpM8EGWqWBHDGknzxVBbkx/D19go5Aml3dNibCagRXBb5lieeHecA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738573519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AqxvCmKG6a1x16hCjSThnsvuCnWxl1ds6KfWld3LsEI=;
	b=LyOYwDg0LcHjS4/3ejV510LsGVoFmPJ6cGGkE89Y6+lkjACch3UTwqaZdXpj2OuuMKnMLP
	kWzGO4vlbw6Q+jAg==
Date: Mon, 03 Feb 2025 10:05:03 +0100
Subject: [PATCH 02/16] elf, uapi: Add definition for STN_UNDEF
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250203-parse_vdso-nolibc-v1-2-9cb6268d77be@linutronix.de>
References: <20250203-parse_vdso-nolibc-v1-0-9cb6268d77be@linutronix.de>
In-Reply-To: <20250203-parse_vdso-nolibc-v1-0-9cb6268d77be@linutronix.de>
To: Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738573516; l=843;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=FEaofIv+JUjjywiT6rS3O3D+OYARr4o4oDpoALKMPN0=;
 b=6ap2E9pgBsF576nuzERSuthuwPkpinZdzn7NrB2VMb8kF8mXyyC+nPYOF8sHjgDC2J9KoaRAf
 yZYknsg9hz/Ay2rTTwdv3RYKMqDBf0baUssvsDbVjtBgdT9ts+wWDNr
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The definition is used by tools/testing/selftests/vDSO/parse_vdso.c.
To be able to build the vDSO selftests without a libc dependency,
add the definition to the kernels own UAPI headers.

Link: https://refspecs.linuxfoundation.org/elf/gabi4+/ch4.symtab.html
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/uapi/linux/elf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index b44069d29cecc0f9de90ee66bfffd2137f4275a8..448695c7364042b10682acc8223eb6053ad039dd 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -125,6 +125,8 @@ typedef __s64	Elf64_Sxword;
 #define STB_GLOBAL 1
 #define STB_WEAK   2
 
+#define STN_UNDEF 0
+
 #define STT_NOTYPE  0
 #define STT_OBJECT  1
 #define STT_FUNC    2

-- 
2.48.1


