Return-Path: <linux-kselftest+bounces-27588-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2015FA45D6E
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 12:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D36DA188F173
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 11:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2EA21764B;
	Wed, 26 Feb 2025 11:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JPxjA3rj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NogC8iL5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99212153F0;
	Wed, 26 Feb 2025 11:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570313; cv=none; b=tLs43/6pR/Zf5AWiVk17O0AZ3MoZbu2pYiQSsWTFP+zQNti/p6rIvAK2lYaI+iiD+Wsno1ZdwqUnuYujqXJgvXiZwGpSduNawbJnaBy5GuXQR/Z9xOtyipxnlE0BEym2sbie0DXdKj50xuwsUD6D5YXAYD/Veas/XRreqtdQeac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570313; c=relaxed/simple;
	bh=jOcl4jChzaOfnuMhe6CWOzQik5bw/m/LULE4SM4Wwic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=slEANvLYB6GT+rp68VMrNuXkUtqT2tmFi97k1CQDy1DM2sX1Vn07QJ0Ei+sKWlqRpRyByYa53W7+gZaYv+lvr2owcoWsEmKidQ3z8b/xsR+hpYkF2IEk36mUnthbTdCkvYFqVX4LXV+I2R58purhVquUq1Q98e76v3YEX2fmzpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JPxjA3rj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NogC8iL5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740570310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lMDiGbYVSI2UFf1LCxWO6nyQEZB+Om9MsywMKZqQgCo=;
	b=JPxjA3rjz6xx4GTC7I8oaWdo6JKP5/SU+MZYtxrPCtbpIT6X3MBJTtspm+D3CEgeb/rGz0
	TIwScseTkmK+tv0QaLucWZcdi7zu5lWTZllLIPEth+U6QNA7ZDutG838PWSniAlvZ5ahWC
	0LU6v2uQDsmxRX5nsy9c/Cis8PC/Q1IHXZb+7MWEbaxt9tUHqJ7kKtA4EYETE4lsDIKZpa
	HJfXRZJvOSLXJNl442y+s1e545AMCTgZpPgaVWCujHEFBcobNhSRSsLqNr7p75EmCu1fCB
	3UPM8em6xc+wLNOxbvByppfB07n2A/LCz2/v9s/kEJqPMEna1tDWxq6xKKZ3vQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740570310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lMDiGbYVSI2UFf1LCxWO6nyQEZB+Om9MsywMKZqQgCo=;
	b=NogC8iL5YzrQpwMRQZ93LpyvPa5B8vMn/uJTGvcGCDvF9ORegZ4u77l7P0pYsd9hV5eT+D
	tm/sp4VhOqmVeBCg==
Date: Wed, 26 Feb 2025 12:44:41 +0100
Subject: [PATCH v2 02/16] elf, uapi: Add definition for STN_UNDEF
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250226-parse_vdso-nolibc-v2-2-28e14e031ed8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740570307; l=885;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=jOcl4jChzaOfnuMhe6CWOzQik5bw/m/LULE4SM4Wwic=;
 b=qt2UpwulQT6NmPqm+BCm/x9gmi8yb5q4QxLrpncjEM195FECfP4GUiMb0tEXnI6jNVxzs5MLk
 c8OLcJCsa1SBT8bdPVaKrK+Hc3gm7a3UVHR9oQ0/xyDKxXTMTcKdumk
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The definition is used by tools/testing/selftests/vDSO/parse_vdso.c.
To be able to build the vDSO selftests without a libc dependency,
add the definition to the kernels own UAPI headers.

Link: https://refspecs.linuxfoundation.org/elf/gabi4+/ch4.symtab.html
Reviewed-by: Kees Cook <kees@kernel.org>
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


