Return-Path: <linux-kselftest+bounces-27998-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A93A4B771
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 06:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DDF716C835
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 05:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E361E9B05;
	Mon,  3 Mar 2025 05:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dV79NVOz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50901DF965
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Mar 2025 05:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740978582; cv=none; b=HsjGNX+uX2tBeT4zEFQ0cV+pws5eEqGv0EPZ2OaBIMtJx32tgWnGEo5Xa1jifMM9xBZff9GqnNlxDUl1rMx2jSWLxbulZJ1cRZ65S1tG0uRvWrfPSuGFYoWSKNcdoUz8MnQwVSWXB/jJrb+G03nuGKDOGSdbvFC7FwMzwmqIeeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740978582; c=relaxed/simple;
	bh=7zDlhtsN6IWTCHgfTa5SxUNOg/lpgS1kgV2r6nWpBoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=usZ7Tv3N/qK33XVUBP7TyCPKGJy7t7tImRyVijkssPVLaXEFI2ZLa9NLwW1nnF35GtMhGolcKN2FxiTJ9C0JV9P3krvB7ZVa91e6emvXr2PQJ0qdWwwyd4O7KiWaqsZZO80WhCvqF/ngYn4RKuhizEBl/DuBy4tFupGp+e8Ymt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dV79NVOz; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e5258a2bd9so247719a12.2
        for <linux-kselftest@vger.kernel.org>; Sun, 02 Mar 2025 21:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740978577; x=1741583377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAoQrXrn6YJEh9Pobcge+uaEegOFqqBxGl0PnC+cOhU=;
        b=dV79NVOzTKjE5tvz08UdV11IDOtFZLcWwi5/rkKV6JB8ZxXdklyWHyDyfMSls1XuhU
         Q88K8700NktNr2kU7aQCeVqu73Fa04I3WT8SM0J+p5MIHutkw1jqbA12Ry7EGNMaubmn
         01ATJs+zmJh4M5w+RizP0roKiW7IUKF0g9H7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740978577; x=1741583377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAoQrXrn6YJEh9Pobcge+uaEegOFqqBxGl0PnC+cOhU=;
        b=bCOEak1ABW6IvzkoiAIBgZbDFbS2jdlCEC8lT61Axgnn4ndUCVnQzOQvTLtZbovSJj
         590a1dMFtbCqJXAPfwJqDL3Eb8joLz5vjgiY1Z2kreoqf8LpHOUtCQTCai1WwJ+38tQR
         26uKwP6ZrYk+T3qRtyxb8YMHxcDOPA7RtrAHHDxAn0lsfhw1iSNDXKr9GQV/JP+1VNDs
         19kAEscyl5miCwFfWgMKTZwRTgJMeLMFttwkw8ZJZTYb0lwRmFT7IC/otYEOmSaaIy1i
         +S8agmq1QAhBpkT7IqerWbcIaMm5lQt4357avKHJxJF/WNpulwA6fEcDPVVGpIY3PCBs
         FD2A==
X-Forwarded-Encrypted: i=1; AJvYcCV7noL4os4+BcEehoPyeV3BpkmCWlYJxAZ44L8TARgHktDY1Ak9Z3Mz9v3NB8lysjYb/eCQPTjrPersTgDwV8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM3YnzpM3yElVMlt1oa6Xj/lqIhu5W8nGz4IQEAbjwwHhTUv6v
	9cbKiD6xuVxJkvxj3n2cZBAS/oFO8tSQnE9OWI/q3BSwdq+XEZJVgj0TAc+gXQ==
X-Gm-Gg: ASbGncv/pZixsJR0oXE3dKuKgnPMlGMDJ64Ee7/DsBKw3aZ6oqlQsKDJ0fEC2iSXjQl
	P5iXtmmZO6DqtzR2lJUlXlro66pGpJxHLnA3DbohScV0Z2rYiWZqZBcp8mPViONiethZ0muPSkl
	6NyLinAvfF8kj+S4tc+13LmQ/LTiGh9JIM+d+b3LpfbG2DVn8SLMIG4GvEL6MsTYRn53EgvPPOk
	GmcQvn55yrOMPnbhKInHjdQFvtynndn6wWGxM2UNH7Qf0StQd75/Nglv1Pt0b428lz+jiUm9rVa
	oYa6W22Z3DiZo7lmtlyNpcptk5F1Yh7MZ02ldflZVCrmZCs24/LY9rkDsvDMK1eIGkwda66vlIB
	b
X-Google-Smtp-Source: AGHT+IFFf+CduNG846GcfkCLdAht/QDxEug4xx+ZimxDfLRqsASOv0BOjbMGqDHYYZSfdkiJ8c/g8Q==
X-Received: by 2002:a05:6402:35d2:b0:5e0:7ffd:a6ef with SMTP id 4fb4d7f45d1cf-5e4d6b42c58mr5147613a12.5.1740978577006;
        Sun, 02 Mar 2025 21:09:37 -0800 (PST)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb6067sm6248635a12.50.2025.03.02.21.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 21:09:35 -0800 (PST)
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
Subject: [PATCH v8 4/7] mseal sysmap: enable arm64
Date: Mon,  3 Mar 2025 05:09:18 +0000
Message-ID: <20250303050921.3033083-5-jeffxu@google.com>
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

Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on arm64, covering
the vdso, vvar, and compat-mode vectors and sigpage mappings.

Production release testing passes on Android and Chrome OS.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 arch/arm64/Kconfig       |  1 +
 arch/arm64/kernel/vdso.c | 12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 940343beb3d4..282d6cb13cfb 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -38,6 +38,7 @@ config ARM64
 	select ARCH_HAS_KEEPINITRD
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_MEM_ENCRYPT
+	select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_NONLEAF_PMD_YOUNG if ARM64_HAFT
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index e8ed8e5b713b..69d2b5ceb092 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -198,7 +198,8 @@ static int __setup_additional_pages(enum vdso_abi abi,
 	}
 
 	ret = _install_special_mapping(mm, vdso_base, VVAR_NR_PAGES * PAGE_SIZE,
-				       VM_READ|VM_MAYREAD|VM_PFNMAP,
+				       VM_READ|VM_MAYREAD|VM_PFNMAP|
+				       VM_SEALED_SYSMAP,
 				       &vvar_map);
 	if (IS_ERR(ret))
 		goto up_fail;
@@ -210,7 +211,8 @@ static int __setup_additional_pages(enum vdso_abi abi,
 	mm->context.vdso = (void *)vdso_base;
 	ret = _install_special_mapping(mm, vdso_base, vdso_text_len,
 				       VM_READ|VM_EXEC|gp_flags|
-				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
+				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC|
+				       VM_SEALED_SYSMAP,
 				       vdso_info[abi].cm);
 	if (IS_ERR(ret))
 		goto up_fail;
@@ -336,7 +338,8 @@ static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
 	 */
 	ret = _install_special_mapping(mm, AARCH32_VECTORS_BASE, PAGE_SIZE,
 				       VM_READ | VM_EXEC |
-				       VM_MAYREAD | VM_MAYEXEC,
+				       VM_MAYREAD | VM_MAYEXEC |
+				       VM_SEALED_SYSMAP,
 				       &aarch32_vdso_maps[AA32_MAP_VECTORS]);
 
 	return PTR_ERR_OR_ZERO(ret);
@@ -359,7 +362,8 @@ static int aarch32_sigreturn_setup(struct mm_struct *mm)
 	 */
 	ret = _install_special_mapping(mm, addr, PAGE_SIZE,
 				       VM_READ | VM_EXEC | VM_MAYREAD |
-				       VM_MAYWRITE | VM_MAYEXEC,
+				       VM_MAYWRITE | VM_MAYEXEC |
+				       VM_SEALED_SYSMAP,
 				       &aarch32_vdso_maps[AA32_MAP_SIGPAGE]);
 	if (IS_ERR(ret))
 		goto out;
-- 
2.48.1.711.g2feabab25a-goog


