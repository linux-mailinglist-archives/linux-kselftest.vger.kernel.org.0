Return-Path: <linux-kselftest+bounces-27587-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B26A45D6D
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 12:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CBDA188E961
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 11:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A4D2165E9;
	Wed, 26 Feb 2025 11:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HG2/OSTT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nld6xex1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7433218DB2D;
	Wed, 26 Feb 2025 11:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570313; cv=none; b=GHpdydMnU9Zyu9foXse9C9l6fahgLR75m0f7Z8O4XEVMCqkZLJEBVFLQNYdOaB1FT/6BnmPll7MfTajHsYBjyU/QgCXF6/T4qOhaV+1z1onpsXfIr40RIvuk6CK88BOY/rDcl0Aa/rYwH1UJHWxtG+gMDPDI3ylgl8ZTsB2LBeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570313; c=relaxed/simple;
	bh=s3dkTBDXdzo+I16hjaEXfC4T5xD6NlAF4J47urRaCBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qr3wP7om28tBtRuLaf37T6OiU9Q3Uxi0q0jcc5qo83iYRcabPnN9/EI+K2wmpAsn/NNjViahOcmrjZLVEQZM3rWdlZyYYP8/Sg6eBw6ZQswYRSjZd/JjrqQrV6eTF37mPRIyUBCt32BQGng7OVJ5Spp8/7ak6iuhrW3LbcVVjZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HG2/OSTT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nld6xex1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740570309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mc60C8g9Fb1tmdPaCWjP2wsKb3/BHTAaOKy7dD4Q/9Y=;
	b=HG2/OSTTB6A6DxnV9fJlxcbHxinFNkvCoc5Av0QoN/O5O+YI/YJJ/bruh7X8hN/Pw9tgph
	IvazjtlrEHvE70F096sE5glzpOsk/2seGBEE6mnWqKyR7quNplEuJULu48Ip6K1P9ALaSc
	CcIEO0Wx17XWQkF/v0cKIMDE2HGNkckrrXzPp8dEFRrg3wND1aSJFNIdawyf9uLxaTABRo
	ZaLQlEl5Ls8TI0NZ/sV4xP68+0hmYhn07h0uUoBEBcFcOZKdXrp6IW2fE9PtWJkDyHEUD0
	oQtSjyeQ/Xpg2WNBMg2fGnBibELpAJAVp21s+DjKJ5dw3tCPwi51eWcUjp5leg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740570309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mc60C8g9Fb1tmdPaCWjP2wsKb3/BHTAaOKy7dD4Q/9Y=;
	b=nld6xex166KgiTl4cwebgevCV8SivocBIvcZsJEvFPKYFQRriCZczK7R2BtRLLOQ4JjzCQ
	SUUrhpc+PqFJSfDQ==
Date: Wed, 26 Feb 2025 12:44:40 +0100
Subject: [PATCH v2 01/16] MAINTAINERS: Add vDSO selftests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250226-parse_vdso-nolibc-v2-1-28e14e031ed8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740570307; l=675;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=s3dkTBDXdzo+I16hjaEXfC4T5xD6NlAF4J47urRaCBo=;
 b=RmTkrNBpC+8rUj4SUZbDrfqW5Rz+2JesNkGa22nnnObwaeaPhHsLR2eLjesHwiz9iee7NIV4Q
 XJaNIHxUageD+jmnkXoAdx2diftbLQQUokA/XWcB8tDXaA54QQQwuSI
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

These currently have no maintainer besides the default kselftest ones.
Add the general vDSO maintainers, too.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 896a307fa06545e2861abe46ea7029f9b4d3628e..959c8a86844eb1e5c6218e8fdbde6c3ebf68e25d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9777,6 +9777,7 @@ F:	include/asm-generic/vdso/vsyscall.h
 F:	include/vdso/
 F:	kernel/time/vsyscall.c
 F:	lib/vdso/
+F:	tools/testing/selftests/vDSO/
 
 GENWQE (IBM Generic Workqueue Card)
 M:	Frank Haverkamp <haver@linux.ibm.com>

-- 
2.48.1


