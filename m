Return-Path: <linux-kselftest+bounces-9081-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA0D8B6457
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 23:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD9831F210EC
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 21:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9463B17966D;
	Mon, 29 Apr 2024 21:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hjhobwCN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310191791F4
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 21:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714424846; cv=none; b=Pnf1ub5ki1iSa7W0A2Xgxmazgna4seL37dbN4ACAnCtUmFHjZl565pHO7h9yO2AtxqGEZRod5O1J1a1F4DIRZ54NB8uh/VP/JLfKrRiRCsMunCqghtDSOH1fVBqstU9vhMuuN3rNtuRirZ3SfgYYYa72Abv1HAcW0+6eBKPmzDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714424846; c=relaxed/simple;
	bh=bNW6HU81cGIeHe9Ew2GlDP3sf80i3dmA2+w1AJ4g7lk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DzZDNgsaZhiMNk7/BQd376PaOP0f7G7Pore4xm1uo43bPS3+hn0PjFIMSgi9R69R1wKIxny+VNH5SPtgFDIiAKiGMpeBsmLLUnhTNz2tqCPBBuE2h5a03TyDYkr98g5wDUjVUEIkT3LCctYGjC4bHQXHRJ9Z19LFEs9DM7GXEw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hjhobwCN; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1e851c0204aso56852395ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 14:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714424844; x=1715029644; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZPemufr3xn60MlET/JappNLxVr0lGO242Dr5arYhPmM=;
        b=hjhobwCNrRJSkhf5bH+cBUw5BgLiVhEwsep+Fd0oAms1aHSPZSfSZr/Tk1bLdGvxc7
         6QQog6N5tnCZBIni+oal4/kPfUyTfpSh3ZMCE4S4pG677Ulp75OnhNjmUguFdlWA1HbK
         exAvQ7jOD3i9ey2WOSiMMe3BWxKsdxxyqM81fGmaFagg1kz81PwyYP9T7Re5v/V4gBhZ
         4t5yAN45u1gpiQw7v062L6U+IGrfmzNjIlT0zVORBIZim02CkGQOZjyY+ruG95eoJdi5
         XYMifmdgGpcO9J7MHgqRN+9ry8jH6C1f+9Jl3ehuro7JyN5a6W5gS0UIuSwwQvuOAjEp
         oGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714424844; x=1715029644;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZPemufr3xn60MlET/JappNLxVr0lGO242Dr5arYhPmM=;
        b=g2hTlwwk+xuXRwZnh/b8O5yEJYZ1GKqfSLz6kJHvB4E+PznaYiEoL7RNJ/DzwHQZAc
         8DRBu3BTcWR/CImyR1ziWXe1fjyaoRJUJ/5u+I/Zoei9yVKsb7h6N2bYBfC++rg6uVF8
         XRYO1nz+4rfLm4HynaApVnFOP3IByn00MhdNiHLWNvcPnmsb+lv4IIntODG1CQez7Zkq
         gbXIytcdNfDCoENEviviZbG8WCOetWgzLyQF/nPv63hVdZblLZ2DL9AIzyFa7NM3YpR+
         dvfSwXHV6V9z8D/llh1vp/LT8rVeUvFU6on8U5M6kayzaGUrj1l4g4oHSqV4bSzuc8li
         DEHg==
X-Gm-Message-State: AOJu0YxIYqXiF5uNgwSbMP0gqiSduBJ01SU4EnndPNYfOw91xXFqj7Qp
	0BR92f28vdyNnltTrQ+DXlhfk4Dm3YeVZ2aB0NngWPCd9D+5zJUum9VypBnBZCNZLixeEac8BLU
	OBQ==
X-Google-Smtp-Source: AGHT+IFBGD7QB6vVNyyUyCjXOcacflWPyo+Z5Ud65lcVUKG1pidH8vesc6pbfjFPwGiC0U3xDqjPEOYjXtU=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:e88b:b0:1e3:e092:53b9 with SMTP id
 w11-20020a170902e88b00b001e3e09253b9mr33232plg.4.1714424844307; Mon, 29 Apr
 2024 14:07:24 -0700 (PDT)
Date: Mon, 29 Apr 2024 21:07:20 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240429210722.154156-1-edliaw@google.com>
Subject: [PATCH v2] selftests/vDSO: Explicit unsigned char conversion for elf_hash
From: Edward Liaw <edliaw@google.com>
To: linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Andy Lutomirski <luto@mit.edu>, "H. Peter Anvin" <hpa@linux.intel.com>
Cc: linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Fixes clang compilation warnings by adding explicit unsigned conversion:

parse_vdso.c:206:22: warning: passing 'const char *' to parameter of type 'const unsigned char *' converts between pointers to integer types where one is of the unique plain 'char' type and the other is not [-Wpointer-sign]
        ver_hash = elf_hash(version);
                            ^~~~~~~
parse_vdso.c:59:52: note: passing argument to parameter 'name' here
static unsigned long elf_hash(const unsigned char *name)
                                                   ^
parse_vdso.c:207:46: warning: passing 'const char *' to parameter of type 'const unsigned char *' converts between pointers to integer types where one is of the unique plain 'char' type and the other is not [-Wpointer-sign]
        ELF(Word) chain = vdso_info.bucket[elf_hash(name) % vdso_info.nbucket];
                                                    ^~~~
parse_vdso.c:59:52: note: passing argument to parameter 'name' here
static unsigned long elf_hash(const unsigned char *name)

Fixes: 98eedc3a9dbf ("Document the vDSO and add a reference parser")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
v2: update commit message with correct compiler warning
---
 tools/testing/selftests/vDSO/parse_vdso.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
index 413f75620a35..7e2ea9bea394 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -203,8 +203,8 @@ void *vdso_sym(const char *version, const char *name)
 	if (!vdso_info.valid)
 		return 0;

-	ver_hash = elf_hash(version);
-	ELF(Word) chain = vdso_info.bucket[elf_hash(name) % vdso_info.nbucket];
+	ver_hash = elf_hash((const unsigned char *)version);
+	ELF(Word) chain = vdso_info.bucket[elf_hash((const unsigned char *)name) % vdso_info.nbucket];

 	for (; chain != STN_UNDEF; chain = vdso_info.chain[chain]) {
 		ELF(Sym) *sym = &vdso_info.symtab[chain];
--
2.44.0.769.g3c40516874-goog


