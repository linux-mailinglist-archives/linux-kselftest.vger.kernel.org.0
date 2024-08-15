Return-Path: <linux-kselftest+bounces-15379-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BE1952840
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 05:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE811C20F63
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 03:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2605E2562E;
	Thu, 15 Aug 2024 03:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K8qJdV3h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9EF1D545
	for <linux-kselftest@vger.kernel.org>; Thu, 15 Aug 2024 03:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723692380; cv=none; b=IruPlJpR05v7gAKiqEQHICTteNzqzV+vRtlikIyAb3IdmpgWzGVvmfPdt2AKUHVvCDUnfrrW8PZ+GTyM2Yb/U4lZCe4ztsPPNSivtYqzV2LLU1U5ebpFaWclzIaTilTazAXUWsOhSjicLAAeolEQPh31jXEgq+M+hncAU9tpOlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723692380; c=relaxed/simple;
	bh=eCrF4L7L013Lbyx/EqsJVmDCQSkeFCRdOB/AqI4sYCY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AuquhxeQQJQuJKk9Xrpk2wkmaBtgwX0cOTr1qr2LEcFKiEqtgE7EF2hxfpeuOHz3UoVMIpqUEckvUIrQBDLdYxPyHN8ucf5KJNyPK/fx8M2jlcnJB/G36YMg8iX5u6shM1nv0Mbf0f3SOH/d+59EJx3fEShYCnsWqeRXx+zjRHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maskray.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K8qJdV3h; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maskray.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0353b731b8so939836276.2
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Aug 2024 20:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723692377; x=1724297177; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ftLnDEOB7+9TeneBrUPUBNMhzAdIHafAcv7/yjdA9pg=;
        b=K8qJdV3hBnDp2nW1nS4/cJQFtVb2qzBySjRyCvN+GEi1BHKs6c+tudn9ykFsYk6rqD
         vS5iFzxfZnSeWcmqWVqLKcfeSHswnvopXrxXGYwG7bkrzQtM/cFBzy3lJq4Jem67Yl66
         fse1ez0K39/sc2rIQaBXF4SAdrcvK7cXF9gCPFOUy0l9DHFk+0eUc1CAyZr8/kUiMVrS
         GOTpr0WXpvr7r2a0434I8DvJuj4xQjft2Kh9US02A/61o8w5X6gr6USfUttvtve41scW
         xQEuzghQDHySgIKl6NQvFt9axm/SGS16pUqhN6MVvCfb8DSHoXo26dkoK4Fontovj/mV
         GQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723692377; x=1724297177;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ftLnDEOB7+9TeneBrUPUBNMhzAdIHafAcv7/yjdA9pg=;
        b=whmJvooG3CK5RrOR+VE7hgX2F9B5MDnegT4zDw6+mz3ZBbLymZtaNSPL/ttx7kP1vN
         QfktcBrT45xHsm0RDBvj8/vaZ5wnE7kqlurgXPPdzTrTxq3UcFVmF0jjngk/r1JsqBWR
         WxmwgUxtxasEgl17SNvTO7NpbhJIbmojXKkjYdSbLQjcpk5p6QgNylWzMiWF9J/84/C0
         H9twBBqlum8VJ4ecY2WPmYqluCkTGfL1buK0FgKORvwBkLXv5JxbZ1nDS2kSXWVcTaSW
         DVMpnZZ56PaRGuwiuPKOmKPHjB/3C7HyyUvr/Z94B6/z6rOYmS5KphOXY7G4XAA9kZcz
         POyg==
X-Forwarded-Encrypted: i=1; AJvYcCW8VQfYMIg07pynnYwH0c1XCaTdKA/SJIyXdLtHS47Lz/bhJnyRJOmxqkAuJsdRl2dMqJu0os0wqyFNYhgr+PYFqzZJDX5XoV9f76CmfG1Y
X-Gm-Message-State: AOJu0YzTZSt6jPp99WhyOWuH+B0DQ4n4PrW5Y0BuPuDrlHl7ePf10eOF
	jmhejfAArb0rPqZ9+y5NyBnGFgjigBpMnBp2G8F2CZq5tnxYZCGNz2XFEW2f5NdUhV0UM89JXMm
	DSyYxdA==
X-Google-Smtp-Source: AGHT+IHZRLmGS4QgdBXQheYH//g9x8s5N18YyOTKFZTVnJpqcP2g6jmzSv5bzIuH2R4EdR2G4T4jEB6oTTcY
X-Received: from maskray.svl.corp.google.com ([2620:15c:2d3:205:aaf0:b9c8:2773:d92b])
 (user=maskray job=sendgmr) by 2002:a25:acc2:0:b0:e0b:cb4a:3602 with SMTP id
 3f1490d57ef6-e1155ab133cmr6193276.4.1723692377187; Wed, 14 Aug 2024 20:26:17
 -0700 (PDT)
Date: Wed, 14 Aug 2024 20:26:13 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <20240815032614.2747224-1-maskray@google.com>
Subject: [PATCH] selftests/vDSO: support DT_GNU_HASH
From: Fangrui Song <maskray@google.com>
To: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Xi Ruoyao <xry111@xry111.site>, 
	Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"

glibc added support for DT_GNU_HASH in 2006 and DT_HASH has been
obsoleted for more than one decade in many Linux distributions.

Many vDSOs support DT_GNU_HASH. This patch adds selftests support.

Signed-off-by: Fangrui Song <maskray@google.com>
---
 tools/testing/selftests/vDSO/parse_vdso.c | 105 ++++++++++++++++------
 1 file changed, 79 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
index 4ae417372e9e..35cb545da13e 100644
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
+		   filter (size_t array of gnu_hash[2] elements). */
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
2.46.0.76.ge559c4bf1a-goog


