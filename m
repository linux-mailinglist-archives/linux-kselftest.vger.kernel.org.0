Return-Path: <linux-kselftest+bounces-18004-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8CB9794DF
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Sep 2024 08:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEBF41F2256E
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Sep 2024 06:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D771BDCF;
	Sun, 15 Sep 2024 06:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nKBNXj5V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72316748D
	for <linux-kselftest@vger.kernel.org>; Sun, 15 Sep 2024 06:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726383009; cv=none; b=l75ngFK/k8XexBts9DHpkUnBWXFh3Ggoq4f+7F6v+Nor9YNMe3ItejaGI+8I4XixCwRkqS+gPxjE4b1NBJszU00lKNbFrnVSAoltWX+wZaClR7bUT1thrA6Es1cR+9XWg1sL91I9YQgihVCtxZbdSHC9N4PwM0NyO5HN6YueRkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726383009; c=relaxed/simple;
	bh=vGwBqpQMeRzVz91v5wOwtZwL/8l7EfilXwAoFxOp7rY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KaJsFZuqZkACXOcEbF6xVGGnq7nkLkNcXncp09scRKOuaDMBiojtUvAexgj/TKNEavcTo2r03rLfMu5q6h+PNJpFs0JAvFD39TpA0fMz3zLARpSLjifYmdubHnHR02G62tO41qWzaOfFyUBmXCJLbSYgoJBSTUA65dCciyJUJ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maskray.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nKBNXj5V; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maskray.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1ab008280aso7643850276.0
        for <linux-kselftest@vger.kernel.org>; Sat, 14 Sep 2024 23:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726383005; x=1726987805; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RZPfXwekQwda6LwC500fM8ZDrlyOnYAVczBGHGxiFOA=;
        b=nKBNXj5VtnQwLAnGdPehG15insdWcib96WBk05cFT7bi80QculG+wA6o9+vni3Ap2T
         ohlyJ36yq9SXyC0iQcXBUnaN41stCuIz/fF8BzuHv5jskCj1rvYSPZkwzXf1lxED7MOJ
         upEG6KPkPxc/pIH9dyYX9PIalv+yKFH5TFZp+vwSYh74w/5s96Oaor0Tccl6wPQV0SU4
         cU3/trBD/TY7uSw6rCX1AenmtW71bCiqo3TJ4cQ5zdn6B2p/pxt1zYsb9FsRqm+Gd9sZ
         7MJ7yxbnKXzwuTAMuK4R02qtj2wQsIChYLV+I5wUXoWVCkGBK/wUn/OAzoy8QcOJsAMt
         T7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726383005; x=1726987805;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RZPfXwekQwda6LwC500fM8ZDrlyOnYAVczBGHGxiFOA=;
        b=f/nG909kHZPAAGXBXfJl86ECXCOBZurb568sYySnHmNk7ubTXLB1wj20VuBj/z/JeK
         rwsfvdNl18hpa7suanU5z+8UwDxMPaZSUARhvheMJQ9t7B6CSr3T1Dc6wkN8tIuDBgqN
         QhryWSg736jRngMxKxq9v5l4jZWI50Cxl1VVDWZeib9h6/zloOHfs+qaEXvxg6yQZzy9
         /XN7e0Q/fbXdT1kx9xbwkFfyevuJCPiVm0DM+fFuS+8D4XIVIAO7sW5YDdEj1ohZ++eI
         VjojuSkwJfrKOb1sER4VlKCmodlvdGQlDzdDfbOvdcXbyEzYDV/jPh3FZiFLA9D00w0v
         uVMw==
X-Forwarded-Encrypted: i=1; AJvYcCWK1vhS86+hOASv6i+LL5te/1YLn06IWDOLJkTDxA0i7rk8WuVuST4vM8GlsCZrTcCNx+WGSex+r1IpsZ+m9Hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUVi4FjMtInhaAtj+WiKQfDyadnY/TdcqeQSjHfQsU+A2ZB7CH
	tJnZA50TsMTHPlbvxICw7Fs7CfC7dPU6L4lcv8W9KuvxdGT96ZmyHuAD8dTuoCrvtOQjKap+0+V
	rgigFvQ==
X-Google-Smtp-Source: AGHT+IFy5saDk0q8GAnbGModaSuNEzwhm+wgHSr3ejmbNiEzEhzJDCLMP5dJytwyQ+fF3+cw2S/Ey80NwCSX
X-Received: from maskray.svl.corp.google.com ([2620:15c:2d3:205:824b:94ca:e715:74ff])
 (user=maskray job=sendgmr) by 2002:a5b:18c:0:b0:e16:50d2:3d39 with SMTP id
 3f1490d57ef6-e1d9dc530a4mr18080276.9.1726383005309; Sat, 14 Sep 2024 23:50:05
 -0700 (PDT)
Date: Sat, 14 Sep 2024 23:49:44 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <20240915064944.2044066-1-maskray@google.com>
Subject: [PATCH v2] selftests/vDSO: support DT_GNU_HASH
From: Fangrui Song <maskray@google.com>
To: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Xi Ruoyao <xry111@xry111.site>, 
	Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"

glibc added support for DT_GNU_HASH in 2006 and DT_HASH has been
obsoleted for more than one decade in many Linux distributions.

Many vDSOs support DT_GNU_HASH. This patch adds selftests support.

Signed-off-by: Fangrui Song <maskray@google.com>
Tested-by: Xi Ruoyao <xry111@xry111.site>
--
Changes from v1:
* fix style of a multi-line comment. ignore false positive suggestions from checkpath.pl: `ELF(Word) *`
---
 tools/testing/selftests/vDSO/parse_vdso.c | 105 ++++++++++++++++------
 1 file changed, 79 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
index 4ae417372e9e..dbc946dee4b1 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -47,6 +47,7 @@ static struct vdso_info
 	/* Symbol table */
 	ELF(Sym) *symtab;
 	const char *symstrings;
+	ELF(Word) *gnu_hash;
 	ELF(Word) *bucket, *chain;
 	ELF(Word) nbucket, nchain;
 
@@ -75,6 +76,16 @@ static unsigned long elf_hash(const char *name)
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
@@ -117,6 +128,7 @@ void vdso_init_from_sysinfo_ehdr(uintptr_t base)
 	 */
 	ELF(Word) *hash = 0;
 	vdso_info.symstrings = 0;
+	vdso_info.gnu_hash = 0;
 	vdso_info.symtab = 0;
 	vdso_info.versym = 0;
 	vdso_info.verdef = 0;
@@ -137,6 +149,11 @@ void vdso_init_from_sysinfo_ehdr(uintptr_t base)
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
@@ -149,17 +166,26 @@ void vdso_init_from_sysinfo_ehdr(uintptr_t base)
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
+		 * filter (size_t array of gnu_hash[2] elements). */
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
@@ -203,6 +229,26 @@ static bool vdso_match_version(ELF(Versym) ver,
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
@@ -210,29 +256,36 @@ void *vdso_sym(const char *version, const char *name)
 		return 0;
 
 	ver_hash = elf_hash(version);
-	ELF(Word) chain = vdso_info.bucket[elf_hash(name) % vdso_info.nbucket];
+	ELF(Word) i;
 
-	for (; chain != STN_UNDEF; chain = vdso_info.chain[chain]) {
-		ELF(Sym) *sym = &vdso_info.symtab[chain];
+	if (vdso_info.gnu_hash) {
+		uint32_t h1 = gnu_hash(name), h2, *hashval;
 
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
-- 
2.46.0.662.g92d0881bb0-goog


