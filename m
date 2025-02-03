Return-Path: <linux-kselftest+bounces-25540-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 074B3A2554D
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 10:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B12B165D2D
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 09:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38301FF1D1;
	Mon,  3 Feb 2025 09:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yGkuMvym";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sjm68L9e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EFD1F3FC6;
	Mon,  3 Feb 2025 09:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738573523; cv=none; b=N1XN5Bdog6xQXz/djSsz9DvKlqCBOFD9pj0ujeBGDmF/dgh/0AXiquU/imhxMarxWeWlSoXn1eFJzKxLbbONlVzKB7VoOsghfgNzHF3Hff/rpNMAigOI0Z4s6iL3xq4loYgiA7PpnjVNVpWYKENj+l1ZiDonMY9C9AvnKetmRgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738573523; c=relaxed/simple;
	bh=qvBznUpLU05pMIiidsZrHxM0XCMJ36Udyt/zDIm3nn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UmypWf5UrSbm0965Mfw+PG2EOpa477ZPZpSdtfs+qMdGMYKLsfLoGO/3JletVXH2gwT3Yat8HuWdBMQljpPybVpvFsBKXwsv1fQLH/9tc6BBhEa64NjDn7vkxu1brkklu9y1L5llu8Pw8TWY1GYoI4EX9eHIXLv90MIsJL7krwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yGkuMvym; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sjm68L9e; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738573520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=28tf5lio+l75NgUgMkp1DazjisfzJIKMC2UwGQGfUyM=;
	b=yGkuMvymA01j+y2mo89y77NSpuStn+bRcHQ3bkpoWSL3HgdXmyi0t0YxEOwXVx8zMaFFqb
	QuT7HvSRxNAc9xwxtiOrKuqLoysP8WvW/V9DkFmO3V6rdGahxcx1rfc2Hx4xV6JPazmQJS
	EmbhDBDNWHE75uzzOJGGMtxDS2lCMhb63Em926JFnUgAXJSYkueTfJZ1U3VE3MgmxzGDEV
	zPkuP3A8bM8Ctux1JdIfvTkJNzTnsljZ9tspamGh3aAqqGoJ8mSLbXrG1wWzJLUjnsBDk+
	NtxpQVjBWW+LloYH4IUQuSaVWT0Bod4eQQolUfkEhK5QzQjObymN6CmMAv6gsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738573520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=28tf5lio+l75NgUgMkp1DazjisfzJIKMC2UwGQGfUyM=;
	b=Sjm68L9eF/hUNa0nEAY0tzxfUbxDZYE1MUiD5Fk9SLOck/3PWCN3jpbY/bUS8SI5YVUbGF
	hCRi9fuEHqdq35BQ==
Date: Mon, 03 Feb 2025 10:05:05 +0100
Subject: [PATCH 04/16] elf, uapi: Add definitions for VER_FLG_BASE and
 VER_FLG_WEAK
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250203-parse_vdso-nolibc-v1-4-9cb6268d77be@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738573516; l=934;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=qvBznUpLU05pMIiidsZrHxM0XCMJ36Udyt/zDIm3nn4=;
 b=N8EPe4SWUVakAB+4BPyrhp+oOoSFOcjUMNsXcY5d4XdoEUO4bPdfxTJ6W5cfbOZaySJ6omt62
 ytTq7NtvGNkCW12u5RjsjBz7GO8xJJU+SKCKOKILAq4iUyh2Aw1gKGd
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The definitions are used by tools/testing/selftests/vDSO/parse_vdso.c.
To be able to build the vDSO selftests without a libc dependency,
add the definitions to the kernels own UAPI headers.

Link: https://docs.oracle.com/cd/E19683-01/816-1386/chapter6-80869/index.html
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/uapi/linux/elf.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index c5383cc7bb13c931fea083de5243c4006f795006..d040f12ff1c0ae3dde5c371c81d6089118fbe8ed 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -136,6 +136,9 @@ typedef __s64	Elf64_Sxword;
 #define STT_COMMON  5
 #define STT_TLS     6
 
+#define VER_FLG_BASE 0x1
+#define VER_FLG_WEAK 0x2
+
 #define ELF_ST_BIND(x)		((x) >> 4)
 #define ELF_ST_TYPE(x)		((x) & 0xf)
 #define ELF32_ST_BIND(x)	ELF_ST_BIND(x)

-- 
2.48.1


