Return-Path: <linux-kselftest+bounces-28270-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85663A4F490
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 03:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7D723AB477
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 02:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEAE18A6D7;
	Wed,  5 Mar 2025 02:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X1TBFy6f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103A418950A
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Mar 2025 02:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741141050; cv=none; b=M8oFcRNaLgOpJZd3xCh3NydhjnQxf7cGtUysv6R8X+e8RngsvCppry9k7V2SJ2W8C6wzlueAqPI6/dZCJ/JyWv6M+0L+iEJeRlx/CigqCjUy0Fjy19m0k1mm3n0ABjRBBmFmBorcrx1Oo5HcDm6PwSI5H84eNSHe3VrLsIUD8ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741141050; c=relaxed/simple;
	bh=ZAnJcNAE0RBecudUUh8uu90jecNEuyMqoLyI4jqjchU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O410+haJcOHJQod9yE+eIMR0JqBiS/K5v30ZkhVo7JrUlbrEFIcvIA6QY1orycicsw++jahHfrvLsKA/jX4Cw/gN2r9iM1KvDh8p/pQcQfn0gR7rHZl1zD3Zecb0goKlQgeGqSuvdP8Mo+8nEVQtgnBAVSEQLJeuB/YT54fiST4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=X1TBFy6f; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5de8e26f69fso1478786a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Mar 2025 18:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741141046; x=1741745846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAD8cO652vqhuw2yI/B0NaFEiQTnRzt1qnI3Rgts5M4=;
        b=X1TBFy6fyOIykD4hhqQObvcmUdGxA77ViAdfT3UQK8Laiceh9ngOpbBE5xSJEzZ2Vj
         6ScPU9eime5XGq0LeuPbm5aE01MatSd0Gr8Qup3+BX/0HhE7GyVk1NFUjKPgFJ8d6TC5
         wdWxxQbEAQj3gLNFSnllWYprrFpjVN6dXRyeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741141046; x=1741745846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yAD8cO652vqhuw2yI/B0NaFEiQTnRzt1qnI3Rgts5M4=;
        b=YWQjnC6SHy5jvktbLmfx3CNONNDKYynkrG1UmHKP5+gynCswWr0LrvlHYK9js9LUmr
         nDKcierNt+0VGV3QFvm09bES3CB8mQTAVR13QdYVAXAfEjKIEfMK1PIgaZ99DjsSHykS
         EUPYg1dSep7A5X2EM3bZSdLoyw2m8Q6sBaYJ6JOaDdy0+Fu2hloyYcAH29v+AWta8sv8
         ezEq6m2D/vx+PiRcbgdx3cOqHlFi57CIw04T1ws/ZEWz0DC0+zwjexYncCPUuYYddxGV
         pnvxJyx6eqjqKsxt120st5NtYwLS12pH1yiKbfSl5ZvBJpCMavjSDSmuIpPKlrUUUk5x
         B+jg==
X-Forwarded-Encrypted: i=1; AJvYcCVYPz6Gndop2GMVrTD6rONaWgYXbFdVu7ywFWNAuDZA9RtQqHDqxinK4wG6oyiWBRY18AGJlPqGHnSoUq/dJjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyQX7pZSKpSdqwIBu0Iz16Ps84pYKdxqHZHP9yp/xbBpGUUB3X
	KawR+fEoeSH1NeJLC8kPZnsgTo0dSdQFTHKrT6F78uuQMkzApP+4XLwn8LHorA==
X-Gm-Gg: ASbGnctBLFwdyNSBaJLa2qyaU5ECctOpzITMQU9wUXYB2rC+V8/pU47lTLTfUztVCWL
	5ojAnUbvgNc1zfPqVSu9hPy5kpy5Dl+TSifaHfzKcm7H9+mMK4qniCsAHhd+r8mJAuVCZQZNbAP
	3TwvC3/KePNeN0Tkkx4W8BHcy4We5C3Ki59QNwBSn052/UEdV5XDmjUCBytsqzuP/bpesiHIw8a
	fvkVEW/gshHdzMdcxoLgCyh4lDKxO4w2p6ZPTM/WwA5lJYyaxfDi1WdvHxo02GgUky9iDBNTPIA
	g26RMLolzyWmA0pKLDmgvO67mfq5NF9uxm4vHG+AgFkRxk7R5PIkpuABPlc8q+32ywxEvMu3gsz
	1
X-Google-Smtp-Source: AGHT+IG5pY9ZWt/x42cTmKktAWQXU77r3g1NJ93PY1cEg+ZgzNoMnGCHYfwW1EvcG+ghtIB8aggB5g==
X-Received: by 2002:a05:6402:5214:b0:5e0:e335:2f08 with SMTP id 4fb4d7f45d1cf-5e59f38b512mr484401a12.2.1741141046235;
        Tue, 04 Mar 2025 18:17:26 -0800 (PST)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c43a55besm8891211a12.72.2025.03.04.18.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 18:17:25 -0800 (PST)
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
	Jeff Xu <jeffxu@chromium.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH v9 4/7] mseal sysmap: enable arm64
Date: Wed,  5 Mar 2025 02:17:08 +0000
Message-ID: <20250305021711.3867874-5-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250305021711.3867874-1-jeffxu@google.com>
References: <20250305021711.3867874-1-jeffxu@google.com>
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
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Kees Cook <kees@kernel.org>
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


