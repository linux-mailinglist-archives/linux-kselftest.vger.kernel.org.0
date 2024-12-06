Return-Path: <linux-kselftest+bounces-22913-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 467A59E6EFD
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 14:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C568163F46
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 13:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687CC1FF7D9;
	Fri,  6 Dec 2024 13:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="E7JWWcnG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E7C1C1F19;
	Fri,  6 Dec 2024 13:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733490484; cv=none; b=l5MWu9URYgBMUhdYUm8Ts8xYGFEWZu34DcZd850yLXyEcV9WIeU8yTygR9x3IDMUYoNU7keGJjf8Zbe+FyHye8BK8W7pvyLg5HFh3uTmX66nI2YUZ8+O2tjN+l0x8ohiP6HAc8zhXJ0fvNx0/aEZFz/H92iBkIJt85VYvuMzfNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733490484; c=relaxed/simple;
	bh=1ixYuV9vn+tvWWMjI9qcrLzeMtCAsGWYRbir1E1avq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+eHmZG0oyRzO9E6fyf2PjZSp0hStPyh1eYjXpoe6AkQqCvilAMzElZv4R405NX4OmiH/p17nelMD+kS75XjStoc3SGHm14S7+Pxsn74qxNDH87VAc2baLRNqqgsroadzNeorq4tlZJZe7memahRX81bSjV6wYUDH8dV+NguPRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=E7JWWcnG; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1733490481;
	bh=XnKm59ylPYPwoM2DkN4Cx3zBQck18EMZi4AXKvhtbWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E7JWWcnG1+tJLydCqLAwS1NH5On7Gx6kfN9sRI2Ava1ePlhNZ1oVGZUUMpr2Mfb3x
	 T+PMUlh7kW9ltKamp7Ssg+cSNOukT1ZHR04gyTjbj+BIeRycG2ti5+on178Di/xb7n
	 7DnQSmJU5jRYDj9mk4pGWk0QPUy60JrD/h+AoKDU=
Received: from stargazer.. (unknown [113.200.174.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 14E6C6748E;
	Fri,  6 Dec 2024 08:07:59 -0500 (EST)
From: Xi Ruoyao <xry111@xry111.site>
To: Shuah Khan <shuah@kernel.org>,
	Fangrui Song <i@maskray.me>,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH v3] selftests/vDSO: support DT_GNU_HASH
Date: Fri,  6 Dec 2024 21:07:25 +0800
Message-ID: <20241206130724.7944-2-xry111@xry111.site>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <297cfe11-0418-4633-8c15-4ffc7d290a3d@linuxfoundation.org>
References: <297cfe11-0418-4633-8c15-4ffc7d290a3d@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fangrui Song <i@maskray.me>

glibc added support for DT_GNU_HASH in 2006 and DT_HASH has been
obsoleted for more than one decade in many Linux distributions.

Many vDSOs support DT_GNU_HASH. This patch adds selftests support.

Signed-off-by: Fangrui Song <i@maskray.me>
Tested-by: Xi Ruoyao <xry111@xry111.site>
Signed-off-by: Xi Ruoyao <xry111@xry111.site> # rebase
---
 tools/testing/selftests/vDSO/parse_vdso.c | 110 ++++++++++++++++------
 1 file changed, 82 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
index 28f35620c499..2fe5e983cb22 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -53,6 +53,7 @@ static struct vdso_info
 	/* Symbol table */
 	ELF(Sym) *symtab;
 	const char *symstrings;
+	ELF(Word) *gnu_hash;
 	ELF_HASH_ENTRY *bucket, *chain;
 	ELF_HASH_ENTRY nbucket, nchain;
 
@@ -81,6 +82,16 @@ static unsigned long elf_hash(const char *name)
 	return h;
 }
 
+static uint32_t gnu_hash(const char *name)
+{
+	const unsigned char *s = (void *)name;
+	uint32_t h = 5381;
+
+	for (; *s; s++)
+		h += h * 32 + *s;
+	return h;
+}
+
 void vdso_init_from_sysinfo_ehdr(uintptr_t base)
 {
 	size_t i;
@@ -123,6 +134,7 @@ void vdso_init_from_sysinfo_ehdr(uintptr_t base)
 	 */
 	ELF_HASH_ENTRY *hash = 0;
 	vdso_info.symstrings = 0;
+	vdso_info.gnu_hash = 0;
 	vdso_info.symtab = 0;
 	vdso_info.versym = 0;
 	vdso_info.verdef = 0;
@@ -143,6 +155,11 @@ void vdso_init_from_sysinfo_ehdr(uintptr_t base)
 				((uintptr_t)dyn[i].d_un.d_ptr
 				 + vdso_info.load_offset);
 			break;
+		case DT_GNU_HASH:
+			vdso_info.gnu_hash =
+				(ELF(Word) *)((uintptr_t)dyn[i].d_un.d_ptr +
+					      vdso_info.load_offset);
+			break;
 		case DT_VERSYM:
 			vdso_info.versym = (ELF(Versym) *)
 				((uintptr_t)dyn[i].d_un.d_ptr
@@ -155,17 +172,27 @@ void vdso_init_from_sysinfo_ehdr(uintptr_t base)
 			break;
 		}
 	}
-	if (!vdso_info.symstrings || !vdso_info.symtab || !hash)
+	if (!vdso_info.symstrings || !vdso_info.symtab ||
+	    (!hash && !vdso_info.gnu_hash))
 		return;  /* Failed */
 
 	if (!vdso_info.verdef)
 		vdso_info.versym = 0;
 
 	/* Parse the hash table header. */
-	vdso_info.nbucket = hash[0];
-	vdso_info.nchain = hash[1];
-	vdso_info.bucket = &hash[2];
-	vdso_info.chain = &hash[vdso_info.nbucket + 2];
+	if (vdso_info.gnu_hash) {
+		vdso_info.nbucket = vdso_info.gnu_hash[0];
+		/* The bucket array is located after the header (4 uint32) and the bloom
+		 * filter (size_t array of gnu_hash[2] elements).
+		 */
+		vdso_info.bucket = vdso_info.gnu_hash + 4 +
+				   sizeof(size_t) / 4 * vdso_info.gnu_hash[2];
+	} else {
+		vdso_info.nbucket = hash[0];
+		vdso_info.nchain = hash[1];
+		vdso_info.bucket = &hash[2];
+		vdso_info.chain = &hash[vdso_info.nbucket + 2];
+	}
 
 	/* That's all we need. */
 	vdso_info.valid = true;
@@ -209,6 +236,26 @@ static bool vdso_match_version(ELF(Versym) ver,
 		&& !strcmp(name, vdso_info.symstrings + aux->vda_name);
 }
 
+static bool check_sym(ELF(Sym) *sym, ELF(Word) i, const char *name,
+		      const char *version, unsigned long ver_hash)
+{
+	/* Check for a defined global or weak function w/ right name. */
+	if (ELF64_ST_TYPE(sym->st_info) != STT_FUNC)
+		return false;
+	if (ELF64_ST_BIND(sym->st_info) != STB_GLOBAL &&
+	    ELF64_ST_BIND(sym->st_info) != STB_WEAK)
+		return false;
+	if (strcmp(name, vdso_info.symstrings + sym->st_name))
+		return false;
+
+	/* Check symbol version. */
+	if (vdso_info.versym &&
+	    !vdso_match_version(vdso_info.versym[i], version, ver_hash))
+		return false;
+
+	return true;
+}
+
 void *vdso_sym(const char *version, const char *name)
 {
 	unsigned long ver_hash;
@@ -216,29 +263,36 @@ void *vdso_sym(const char *version, const char *name)
 		return 0;
 
 	ver_hash = elf_hash(version);
-	ELF(Word) chain = vdso_info.bucket[elf_hash(name) % vdso_info.nbucket];
-
-	for (; chain != STN_UNDEF; chain = vdso_info.chain[chain]) {
-		ELF(Sym) *sym = &vdso_info.symtab[chain];
-
-		/* Check for a defined global or weak function w/ right name. */
-		if (ELF64_ST_TYPE(sym->st_info) != STT_FUNC)
-			continue;
-		if (ELF64_ST_BIND(sym->st_info) != STB_GLOBAL &&
-		    ELF64_ST_BIND(sym->st_info) != STB_WEAK)
-			continue;
-		if (sym->st_shndx == SHN_UNDEF)
-			continue;
-		if (strcmp(name, vdso_info.symstrings + sym->st_name))
-			continue;
-
-		/* Check symbol version. */
-		if (vdso_info.versym
-		    && !vdso_match_version(vdso_info.versym[chain],
-					   version, ver_hash))
-			continue;
-
-		return (void *)(vdso_info.load_offset + sym->st_value);
+	ELF(Word) i;
+
+	if (vdso_info.gnu_hash) {
+		uint32_t h1 = gnu_hash(name), h2, *hashval;
+
+		i = vdso_info.bucket[h1 % vdso_info.nbucket];
+		if (i == 0)
+			return 0;
+		h1 |= 1;
+		hashval = vdso_info.bucket + vdso_info.nbucket +
+			  (i - vdso_info.gnu_hash[1]);
+		for (;; i++) {
+			ELF(Sym) *sym = &vdso_info.symtab[i];
+			h2 = *hashval++;
+			if (h1 == (h2 | 1) &&
+			    check_sym(sym, i, name, version, ver_hash))
+				return (void *)(vdso_info.load_offset +
+						sym->st_value);
+			if (h2 & 1)
+				break;
+		}
+	} else {
+		i = vdso_info.bucket[elf_hash(name) % vdso_info.nbucket];
+		for (; i; i = vdso_info.chain[i]) {
+			ELF(Sym) *sym = &vdso_info.symtab[i];
+			if (sym->st_shndx != SHN_UNDEF &&
+			    check_sym(sym, i, name, version, ver_hash))
+				return (void *)(vdso_info.load_offset +
+						sym->st_value);
+		}
 	}
 
 	return 0;

base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
-- 
2.47.1


