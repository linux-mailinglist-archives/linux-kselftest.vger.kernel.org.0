Return-Path: <linux-kselftest+bounces-43107-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4FFBD7BFB
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 08:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0F75D34EC16
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 06:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA43312821;
	Tue, 14 Oct 2025 06:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R7Y2Epqc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yCvAqurT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC8A311964;
	Tue, 14 Oct 2025 06:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760424575; cv=none; b=nq/PL7B8nV6q2xu8AoD/c4g+nSXoQi2dQHtoINTlYAQuwZoWYpdSs8aYuGnUpHM+QOQmGWhXVgarsNIP1J9FY3kzKbV5O8w7ER4jlB9YJ0QKrvhIp1pPWezHSbD8Z60VQ/tv1f5TOGonZ/gD3O3/DDLLutaQe5TqKrNNMJ1gH0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760424575; c=relaxed/simple;
	bh=rscVeDO1P+cKaXX/Ha1fTrfGby5/x6sbnmbmn2plnQg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L578MU5CmLUQrx1YQBFCtwt1LcsfKPepB0cWECAjNnJ+HyomOkkwkvfJh2bwEU6V3PCmKhOCpwRC6p+60hSS//H4UKbEZQp9E4ABR/9eJykNKWIhiy/VOGE59X4d4k5xFN0F78gHmhHUxDyPZ7W4HUMf3deAKPKvyhCYbSgJhZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R7Y2Epqc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yCvAqurT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760424567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W2Ul6+VkoAGtk+fbsWo8FnOHy/g1Ec+KdWjD8933yrE=;
	b=R7Y2Epqcwh1XIGHsa4YhsLHE28rrG/0h8jCubj3C2UJzPNcamxn3KkemVTrIXQrY7hgc/u
	eY5MA91zrK3skLGtJwI8P+0JskOtmOTWnzW5d6vH/Os3wzrGB6kwBMrsu4KC/5VgrpbGAV
	bgm1XWMaPxoxDFvU2KmeFaGEOWEEXasLOlRL4mBstuGfRsckbCDNRmiy0djwH+4oeC35Kh
	CUGU7lxgEB3gEzklhaR5w+pIGwNTCfLfp5d34h0KZAFGdfREITfRPUYl0Q6cEsJh0d0AI3
	pZw8Anen8BR0Bx+kcxVo6GLS7bAPHgUJfM6AY6TuNESFRQhxE+Nwlx4n+JOKfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760424567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W2Ul6+VkoAGtk+fbsWo8FnOHy/g1Ec+KdWjD8933yrE=;
	b=yCvAqurTFkWATU5HMBrDFI5i0G4o0VQm6+fqujIoho/B89bXNotMVDIVWAXXcm0HNozTom
	aAnP0t+bvqkqkTDw==
Date: Tue, 14 Oct 2025 08:49:19 +0200
Subject: [PATCH v4 33/35] sparc64: vdso2c: Remove symbol handling
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251014-vdso-sparc64-generic-2-v4-33-e0607bf49dea@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-0-e0607bf49dea@linutronix.de>
In-Reply-To: <20251014-vdso-sparc64-generic-2-v4-0-e0607bf49dea@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760424546; l=3583;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=rscVeDO1P+cKaXX/Ha1fTrfGby5/x6sbnmbmn2plnQg=;
 b=MKQP0xW+gatRy36pcrODh3/t+7XqCnNDiuxCl4M8kN91U8oRPokjlz5Yoz/6IYPKFb3zhWWYF
 /cv3C/CpJ8nBaXfEJdWKHFaJmBFqdbTFOa5KX+Nq99Xj9d5h3ieKu1l
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

There are no handled symbols left.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Acked-by: Andreas Larsson <andreas@gaisler.com>
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
2.51.0


