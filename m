Return-Path: <linux-kselftest+bounces-27997-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04604A4B76D
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 06:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E312C188DD02
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 05:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E121E766F;
	Mon,  3 Mar 2025 05:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Sig38sj1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5474F1E501C
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Mar 2025 05:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740978578; cv=none; b=goOWHuLJUCPDun3yc/xyv1gd9GOve8F3qCLCZEY/0FQEF0Q0W8B9vft2uG1Rglb/3hYHULNu94t4vmE44GRNH8d+E5Lksby2IzXDBdNvf5VQPPAU1gIPCMpqDpouEFUpHz0s57a+nM0o/rEOnTaaAw+zDJIlyEPEbbpvWkq4XKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740978578; c=relaxed/simple;
	bh=3DY82vtRT01tGrSMnZkHPiBV5qVqgpL5OZWNC8igoDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AKoze4f8v9H90+jnSqpV1tV5P9iQx3gh8aLyn4x2UTS6RWTSgQZD2GLRisZK77h2Wzujny5dpXMp08lQkXk5iiiNaipI1+48qFQrhqCtdJJqDNNgNvU+l7yQJc8uEUDFFnjoUBKEZnVszp69yYjNzriQKfK0gsTe0nJziHIALq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Sig38sj1; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e4d18a2c51so387005a12.0
        for <linux-kselftest@vger.kernel.org>; Sun, 02 Mar 2025 21:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740978575; x=1741583375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NM3JxIxfGoSiAwP/bRvuWu/M48PsDVjGGpFsNsimuo=;
        b=Sig38sj1JgcII/AVERM4VHaLiLql0AJKfaUvV7PQOmH3kgTi/trRwk8Wql+/5PjobZ
         bbSClXA/bzNWgJb5tMgv4sWV5vNmPlDQzjYPMYHj7lzL29N3FFtmDqEPbbexUBaSUq8d
         gk/4DALJ2d7B1pYNO6NeUYm9/+dDPahGUuWLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740978575; x=1741583375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0NM3JxIxfGoSiAwP/bRvuWu/M48PsDVjGGpFsNsimuo=;
        b=gyIYnWMC5VGdGr8NKE0LYa2Dng7tA3DT5TrB3c0orNJ9aIxfBzqkFcOVdngQHrwe81
         pQLuuzPQaF7YnShqArKJVqYN/f45G6z315y+vjdrsTSgbyxJFwz8Gr8swgcECN+31Pdi
         Rl+o7TVpKQfJTdRWMGklohIea9zrJpYzhCTWZeEr3v3DeYXOR8cax+JHRC/oCcZspXSb
         H2D4icL4xtMq1QIb3MKrbINSRmrclCPn8L2QKZ/hX8k8ls0qNEcnNlDytXQZLi9fTWsM
         iBrGRfr3MoOo0w5GKHo2lkG1FnWMH4+VeF/I3q9MP/Rix3CNugrdX2jccjtjO6n6Qqv1
         8nxw==
X-Forwarded-Encrypted: i=1; AJvYcCWNR6wg5AvxryfBhUcSdOXgyaN8tnsiRQ4KTxxiBV8KrHirhL4pMPmpbF3ErizaYhF1zWRVnJqA5PfgnTazIs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQhbjCUCiFw3GH/pad06+/sSTT+XXp/rPbxfp2y1GVWQwcn3Z1
	u8l/yHb3gzsJ0oG5+xXJNJbx0BqZsrpF6EzBOB/DO+WeXZKZYF4MTBMxCqLBrg==
X-Gm-Gg: ASbGncskfBecKv11g2S3rgPrfRwVTD68FRz+DY4tB61PRBbbghQslNi6g0v1znvf/d5
	VuIGlrqwXoVO3fL6xKEfz1T/7WH1DTRlaLmZTd4ZCImSXCOBSlQHHA7n/iakVgX3kNc96/MkE4u
	0Z8nhyY7KsQVlEKuKqyhk25IHAPnj65Xnz8dTSdRg3WZR5A7TZ4R4dbbzOvIeOlSEOlZ7bY0Rkg
	2mj7pBGwf+9Y1g+N2COSU858rOdE1+4/LSDTPPJzxqpRTrZtMHYcE3wr+T4ngUuBZJVT3j7ernC
	2W1kO8JDpeWGOLjuHxAZW7y2pY0LoMrJdx9BJZVUeSygEmTTZESYDSIemziPqVkd7TqZ3hq/hUo
	B
X-Google-Smtp-Source: AGHT+IEIzK5DVcy7xN31p85/klW2sNO6ixXa92Wud+ZOTOl0uHG/MytYEvsvME3kstnNOTe7tQRsOQ==
X-Received: by 2002:a05:6402:4406:b0:5e0:e845:c825 with SMTP id 4fb4d7f45d1cf-5e4d6b98391mr4616303a12.10.1740978574644;
        Sun, 02 Mar 2025 21:09:34 -0800 (PST)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb6067sm6248635a12.50.2025.03.02.21.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 21:09:33 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	torvalds@linux-foundation.org,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@Oracle.com,
	adhemerval.zanella@linaro.org,
	oleg@redhat.com,
	avagin@gmail.com,
	benjamin@sipsolutions.net
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	jorgelo@chromium.org,
	sroettger@google.com,
	hch@lst.de,
	ojeda@kernel.org,
	thomas.weissschuh@linutronix.de,
	adobriyan@gmail.com,
	johannes@sipsolutions.net,
	pedro.falcato@gmail.com,
	hca@linux.ibm.com,
	willy@infradead.org,
	anna-maria@linutronix.de,
	mark.rutland@arm.com,
	linus.walleij@linaro.org,
	Jason@zx2c4.com,
	deller@gmx.de,
	rdunlap@infradead.org,
	davem@davemloft.net,
	peterx@redhat.com,
	f.fainelli@gmail.com,
	gerg@kernel.org,
	dave.hansen@linux.intel.com,
	mingo@kernel.org,
	ardb@kernel.org,
	mhocko@suse.com,
	42.hyeyoo@gmail.com,
	peterz@infradead.org,
	ardb@google.com,
	enh@google.com,
	rientjes@google.com,
	groeck@chromium.org,
	mpe@ellerman.id.au,
	aleksandr.mikhalitsyn@canonical.com,
	mike.rapoport@gmail.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v8 3/7] mseal sysmap: enable x86-64
Date: Mon,  3 Mar 2025 05:09:17 +0000
Message-ID: <20250303050921.3033083-4-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250303050921.3033083-1-jeffxu@google.com>
References: <20250303050921.3033083-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on x86-64,
covering the vdso, vvar, vvar_vclock.

Production release testing passes on Android and Chrome OS.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 arch/x86/Kconfig          | 1 +
 arch/x86/entry/vdso/vma.c | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index be2c311f5118..c6f9ebcbe009 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -26,6 +26,7 @@ config X86_64
 	depends on 64BIT
 	# Options that are inherently 64-bit kernel only:
 	select ARCH_HAS_GIGANTIC_PAGE
+	select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
 	select ARCH_SUPPORTS_PER_VMA_LOCK
 	select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 39e6efc1a9ca..a4f312495de1 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -268,7 +268,8 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
 				       text_start,
 				       image->size,
 				       VM_READ|VM_EXEC|
-				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
+				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC|
+				       VM_SEALED_SYSMAP,
 				       &vdso_mapping);
 
 	if (IS_ERR(vma)) {
@@ -280,7 +281,7 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
 				       addr,
 				       (__VVAR_PAGES - VDSO_NR_VCLOCK_PAGES) * PAGE_SIZE,
 				       VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|
-				       VM_PFNMAP,
+				       VM_PFNMAP|VM_SEALED_SYSMAP,
 				       &vvar_mapping);
 
 	if (IS_ERR(vma)) {
@@ -293,7 +294,7 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
 				       addr + (__VVAR_PAGES - VDSO_NR_VCLOCK_PAGES) * PAGE_SIZE,
 				       VDSO_NR_VCLOCK_PAGES * PAGE_SIZE,
 				       VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|
-				       VM_PFNMAP,
+				       VM_PFNMAP|VM_SEALED_SYSMAP,
 				       &vvar_vclock_mapping);
 
 	if (IS_ERR(vma)) {
-- 
2.48.1.711.g2feabab25a-goog


