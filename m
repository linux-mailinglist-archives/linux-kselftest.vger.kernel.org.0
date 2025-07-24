Return-Path: <linux-kselftest+bounces-37922-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F767B1009F
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 08:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C455F9635C3
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 06:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AD4244675;
	Thu, 24 Jul 2025 06:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FT+5hTrE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7Ok2gYf8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C55F238C36;
	Thu, 24 Jul 2025 06:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753338444; cv=none; b=bMtL3A2vrjOs5FfSD13PgPrL5BwUeVzIqV8lvqMinWcW6avSeqBiPgqD6lA2PfwqNO9uBqx1VbYOc98ClVG5/J1sXewazhh2vCT93HIcndHJyoY85OrsQr4YZI9aHOqn9HnT54r3q+oB71TIRI76Bgn2O0LukjNMlIpe6i6DQ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753338444; c=relaxed/simple;
	bh=AINOaxBuP5Ch3/2w2tbR7UDCA6saGXXKtrrH821ccA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OJAZpCvF3hjZKKhimA82gw7oVBche9CxO1ti0Q0x0v+gmVDZPpRNRBeEBGB8SHA6XStBro/NNeKDaV/8HD4ZcCLuo/O2quW46sWmqs0OO4y00vAG6uVzHKXpnB1Y5xqq44flv88sjiVwscEEYtW1G/OAAsOWMEw7D4y7SDypeZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FT+5hTrE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7Ok2gYf8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753338440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p3StxZg3wmTP4B25eUsgepw4UWcf1hLlH7xU6a+2F/k=;
	b=FT+5hTrEuyac1k+/ukPv20KvfXyavgxgvBURXpbXMduIzdzoSUl0W4ra0JSxTEStRlc3HW
	tNNfF19JKj9rK0nkFzUYwE0u9x0+lEWcpNec30IT9flm1mG5JPDopo5pzSPtTNUS0H+NDY
	GkNY5rK/+PYU40ZlDAIvLUB/NWj8LfUcV39p7t61IIDRd5TRja0ELtz26I0dCtiiKbttCb
	i2osjf4AHUubUirta2ERduSUCvguVSAfTwgVUgMdQSp/O6ZFnSWW7CCySem20uN7qH4qI1
	Q9Hg9khnOO2ICmdwK91Atu0Pmv9tDVkitLfTZ/hhlz4ogfcnw71UZpDGwpC7uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753338440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p3StxZg3wmTP4B25eUsgepw4UWcf1hLlH7xU6a+2F/k=;
	b=7Ok2gYf8TOWEOdO60Hh4UQwx0pkLemVuEoUDjLYIXgqJWlVrRnhBurjX59sRt8WmWoj5ik
	CDOc/pEmce0IlPCA==
Date: Thu, 24 Jul 2025 08:27:02 +0200
Subject: [PATCH RFC 12/14] sparc64: vdso2c: Remove symbol handling
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250724-vdso-sparc64-generic-2-v1-12-e376a3bd24d1@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753338429; l=3432;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=AINOaxBuP5Ch3/2w2tbR7UDCA6saGXXKtrrH821ccA0=;
 b=CNxVpGH61iMCULjj4FxsQOx3FEIH/0tFYSzN4JPzrlLoYiRERTp9pXBX3mt9Wb3g4eHIK3urP
 l4FbMwelrY1B4FSZ6naFpgxtB6ab7ad3qM4gqlrEzzSgANtelS+Rydb
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

There are no handled symbols left.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/sparc/vdso/vdso2c.c | 10 ----------
 arch/sparc/vdso/vdso2c.h | 41 +----------------------------------------
 2 files changed, 1 insertion(+), 50 deletions(-)

diff --git a/arch/sparc/vdso/vdso2c.c b/arch/sparc/vdso/vdso2c.c
index 70b14a436fe2297ab446f778ab0d43155c272421..e5c61214a0e285547ac57c9997542546464bde23 100644
--- a/arch/sparc/vdso/vdso2c.c
+++ b/arch/sparc/vdso/vdso2c.c
@@ -58,14 +58,6 @@
 
 const char *outfilename;
 
-struct vdso_sym {
-	const char *name;
-	int export;
-};
-
-struct vdso_sym required_syms[] = {
-};
-
 __attribute__((format(printf, 1, 2))) __attribute__((noreturn))
 static void fail(const char *format, ...)
 {
@@ -105,8 +97,6 @@ static void fail(const char *format, ...)
 #define PUT_BE(x, val)					\
 	PBE(x, val, 64, PBE(x, val, 32, PBE(x, val, 16, LAST_PBE(x, val))))
 
-#define NSYMS ARRAY_SIZE(required_syms)
-
 #define BITSFUNC3(name, bits, suffix) name##bits##suffix
 #define BITSFUNC2(name, bits, suffix) BITSFUNC3(name, bits, suffix)
 #define BITSFUNC(name) BITSFUNC2(name, ELF_BITS, )
diff --git a/arch/sparc/vdso/vdso2c.h b/arch/sparc/vdso/vdso2c.h
index ba0794659eb5af53b8c86b24f3221a5d0b3f74ab..bad6a0593f4ca293feca201a6343833268ad1cb8 100644
--- a/arch/sparc/vdso/vdso2c.h
+++ b/arch/sparc/vdso/vdso2c.h
@@ -17,11 +17,9 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 	unsigned long mapping_size;
 	int i;
 	unsigned long j;
-	ELF(Shdr) *symtab_hdr = NULL, *strtab_hdr;
+	ELF(Shdr) *symtab_hdr = NULL;
 	ELF(Ehdr) *hdr = (ELF(Ehdr) *)raw_addr;
 	ELF(Dyn) *dyn = 0, *dyn_end = 0;
-	INT_BITS syms[NSYMS] = {};
-
 	ELF(Phdr) *pt = (ELF(Phdr) *)(raw_addr + GET_BE(&hdr->e_phoff));
 
 	/* Walk the segment table. */
@@ -72,38 +70,6 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 	if (!symtab_hdr)
 		fail("no symbol table\n");
 
-	strtab_hdr = raw_addr + GET_BE(&hdr->e_shoff) +
-		GET_BE(&hdr->e_shentsize) * GET_BE(&symtab_hdr->sh_link);
-
-	/* Walk the symbol table */
-	for (i = 0;
-	     i < GET_BE(&symtab_hdr->sh_size) / GET_BE(&symtab_hdr->sh_entsize);
-	     i++) {
-		int k;
-
-		ELF(Sym) *sym = raw_addr + GET_BE(&symtab_hdr->sh_offset) +
-			GET_BE(&symtab_hdr->sh_entsize) * i;
-		const char *name = raw_addr + GET_BE(&strtab_hdr->sh_offset) +
-			GET_BE(&sym->st_name);
-
-		for (k = 0; k < NSYMS; k++) {
-			if (!strcmp(name, required_syms[k].name)) {
-				if (syms[k]) {
-					fail("duplicate symbol %s\n",
-					     required_syms[k].name);
-				}
-
-				/*
-				 * Careful: we use negative addresses, but
-				 * st_value is unsigned, so we rely
-				 * on syms[k] being a signed type of the
-				 * correct width.
-				 */
-				syms[k] = GET_BE(&sym->st_value);
-			}
-		}
-	}
-
 	if (!name) {
 		fwrite(stripped_addr, stripped_len, 1, outfile);
 		return;
@@ -129,10 +95,5 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 	fprintf(outfile, "const struct vdso_image %s_builtin = {\n", name);
 	fprintf(outfile, "\t.data = raw_data,\n");
 	fprintf(outfile, "\t.size = %lu,\n", mapping_size);
-	for (i = 0; i < NSYMS; i++) {
-		if (required_syms[i].export && syms[i])
-			fprintf(outfile, "\t.sym_%s = %" PRIi64 ",\n",
-				required_syms[i].name, (int64_t)syms[i]);
-	}
 	fprintf(outfile, "};\n");
 }

-- 
2.50.1


