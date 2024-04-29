Return-Path: <linux-kselftest+bounces-9076-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFA08B63C8
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 22:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A50F1F22656
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 20:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A2A178CF2;
	Mon, 29 Apr 2024 20:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k4NwZOxw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AED117799B
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 20:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714423426; cv=none; b=pt7nNDNvsRcY60Ti168I31zI9lBbmjzRk3OKm77Se/k41pVw7y3HrdFOwfAokkYZpVHM75yNUab4PvYhBnAvJ1XckytrClt6uvw+BZWA+YsqWD2QJi9DA0ts0eQUzk2hdmNj5r4of99zrZToVROVW6cwYb0te/kYYTlrt3H7rCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714423426; c=relaxed/simple;
	bh=Dqvvv5k/2rBndxGB8WRqT0FWAmJL3N2QMXq8c8tcCZ8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Kj4C+XXBcEWsmWr/OJNDOM12BsQsDUp5M845zsn2KrmBIiiQ4vylloz5CeZ643qJFOeygxSBFotjGsP9YvgT5trpJOmunWsIEibmuKHaRykBJRWqVxbu3uEOZYmKfmSJvLm85TLL903TnGGRypFFUNoRdjaz+0wy77nUFQqrsYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k4NwZOxw; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be8f7ed6eso946787b3.0
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 13:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714423422; x=1715028222; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kP5D9/l/449dTy3r209IVThrMxV6+RNO48E3tZy87Nw=;
        b=k4NwZOxw7/0sWfc6h5SRG+E66ZQGe+HXgBZ1cQ2zcoqCwxSgeQdf2ygu8MeNJK0EFB
         HxwbbHHC8/AJQ3Glem/QBH2S9ZGiyAp2/Kjd3KpEYllsdNVqLGPfov3oOOaww7ho1nPT
         BuTn3rp7prAaxlnvn7ans2Lq47tTHJsvq56reQ3F6Hrisqt1A3GGoS/iff4+wxeIP6JC
         PqVooAaKfwWpZhqd1iLxrR3QB2zqLYWQPuhlGffYfK3ncyky0gcPRwNeqj4+Ig+uQi1Q
         Dpe7j2ZSdrVC8jG8zGKz53rpar+7uh9aGbdphsrqyv4fRKFq3mdAubwTdRDk3Kz9hIB5
         9hKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714423422; x=1715028222;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kP5D9/l/449dTy3r209IVThrMxV6+RNO48E3tZy87Nw=;
        b=f1WBBEPTVQqdkGSsEzQ4i2AUPsxi4AmmoFIszUSNDTE2Me0EtfC+Bm5IETVvPonXVR
         J9bhWVKfm2B+9GHON1uNv8XFYYWYyZoHKhW8uX5HBdBv/a7qW5Qy67Y+YMvChWbmL6G7
         pNrhKtSUBkCVP2z5kX49J+N6I8wtvN6jTNlmMpkBOPjyK+VWEDy87Jxyj02VP1EH/wR3
         e0LEEsH6/A7Vvk3UEIUB+3QiqtA/B2X00kZ29PhTwRXyQKCKNzhBTwf2W8PaXrPBVKn5
         lI447gBux08cfWGN1lwsvBo7QyGB2aWGV1e5pDjy8r6lXzilG3StO5Y8NY7bmhGgJrwp
         HhmQ==
X-Gm-Message-State: AOJu0Yyp0eQiGwDQsbz5CAaUdGKFdEk+5XmxHyM2ma8odgtEP4wP65yw
	dPI82O1yeltluxgDmpI4isyDA0gUyM/f1bNjcqW+/YMfpp0ZTAfHxgy/P2MZs3OzKYW6muBDiEJ
	4PA==
X-Google-Smtp-Source: AGHT+IHcpzk6wYZrqzhB/+Lz7lRSuqPg6576nmgHC5Ed8jKuAp3HkexHCZB1xdt3BUA02fkvb59KkOzh1vc=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:690c:250f:b0:618:2ad1:a46f with SMTP id
 dt15-20020a05690c250f00b006182ad1a46fmr136239ywb.2.1714423422592; Mon, 29 Apr
 2024 13:43:42 -0700 (PDT)
Date: Mon, 29 Apr 2024 20:43:32 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240429204333.146063-1-edliaw@google.com>
Subject: [PATCH] selftests/vDSO: Explicit unsigned char conversion for elf_hash
From: Edward Liaw <edliaw@google.com>
To: linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	"H. Peter Anvin" <hpa@linux.intel.com>, Andy Lutomirski <luto@mit.edu>
Cc: linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Fixes clang compilation warnings by adding explicit unsigned conversion:

parse_vdso.c:206:22: warning: passing 'const char *' to parameter of type 'const unsigned char *' converts between pointers to integer types where one is of the unique plain 'char' type and the other is not [-Wpointer-sign]
        ver_hash = elf_hash((const char *)version);
                            ^~~~~~~~~~~~~~~~~~~~~
parse_vdso.c:59:52: note: passing argument to parameter 'name' here
static unsigned long elf_hash(const unsigned char *name)
                                                   ^
parse_vdso.c:207:46: warning: passing 'const char *' to parameter of type 'const unsigned char *' converts between pointers to integer types where one is of the unique plain 'char' type and the other is not [-Wpointer-sign]
        ELF(Word) chain = vdso_info.bucket[elf_hash((const char *)name) % vdso_info.nbucket];
                                                    ^~~~~~~~~~~~~~~~~~
parse_vdso.c:59:52: note: passing argument to parameter 'name' here
static unsigned long elf_hash(const unsigned char *name)

Fixes: 98eedc3a9dbf ("Document the vDSO and add a reference parser")
Signed-off-by: Edward Liaw <edliaw@google.com>
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


