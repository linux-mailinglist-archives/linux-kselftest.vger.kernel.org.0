Return-Path: <linux-kselftest+bounces-7135-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98978897C53
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 01:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3FDBB28F2A
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 23:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB70158A11;
	Wed,  3 Apr 2024 23:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="HiiVifJV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF4B158A01
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Apr 2024 23:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712187724; cv=none; b=Tf3fJfD6/rqu9BVU7AFPH1VJ5WKVGYQxbgSKVYKqMdVtFujEqbiH6LbePkc/U45t9vNVmp33x0MYvQUYG62DT2Ky6f7HYD27yBO/AwT4Yza7TgtiDPpcFsmJIRBdngm0T0l/uVqmh/FrEMmjdnR+c/AtyzilOis6jph4FUvEwwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712187724; c=relaxed/simple;
	bh=7m+lwx5hnBcCswvc1cbYpS6vclXxJd4dhK55npT2Syw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VbrLv6mxJNdv9vUVfa5wtcmXuhMe2GL1n1ZPioOPP9CSH2QgirAHro+UQwDxxf1RvsLN3E5dd7hv+WhMl/U/78sLAipjkxYz+Dyc2Ce2S8BHWPZ/s3YNh55BD99VjhZDXXMVRqxDomrqRBNJXlDzy0yO3pQ1qgqszRKxFe63cdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=HiiVifJV; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e0d82c529fso3642325ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Apr 2024 16:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712187722; x=1712792522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ir+lgmmL0ZmHswiBuJpYbgwfILZ/3vCYSTqJIvKZkPQ=;
        b=HiiVifJVjGBaeiNzxhd0SDxfk6KrDmGRvM0Y9Gag3Wb1rsjAgkpV1YUe2lhbFDiACI
         Z9QXgIzFt54wr68jBtKsVTaZQgEDJAeP45LiAt0KF3BQbRFC0h5a7Gijb0jXtmgvKurb
         tsQbN+JDMtAXQBuFKQrnCnlI3NV65Gc18HLfhti8eP5YgTts8xglxAelfwAVCGc9Jdjj
         Gnan69QU6t8XquuMvpfMYLZCYQkpGw4v2pHudiB2TEuoe0Giw8t7+qArJo3niM15Xkot
         6Ep9IWkmp21/nTiEnuPZCiZCH0bnYDW4DKanVK3v/zsUkt2IG+RT4uE9kVtWfDevhtwM
         wxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712187722; x=1712792522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ir+lgmmL0ZmHswiBuJpYbgwfILZ/3vCYSTqJIvKZkPQ=;
        b=Ya8a+VUZVCm+LFEH6X11YOANbR+Z/Ge+BmsU6mn7Ps2iUTPC7vGteVzdKMRLLaw2Uf
         XH+AOr1LPACyiCAGFP1akVBVuC61k4Nb2PaqqDisabWV3GELYrYYyVkki12VeLWrC5qT
         f3a3dXgTp+njwbQCzu3IORx8ORekkIvKPx5aDlRCOIOrxh7siJawn5SlKFwq49i/cCZ4
         OdwiW+zUMM027FYOLAXqXkpFuOIKpf+X5h3fpXAfhdsJBDO/pS3s4NPWUDx/X8qy3TFU
         r5N85detFAhYHVYyJ9qMOLenWzt3B80BAz1RJp28J4TlEmKF1MqraFi7ZrZ2QEjQrbf1
         JIJA==
X-Forwarded-Encrypted: i=1; AJvYcCVMptFDe08YILnbHNuqqEz6nhCOz72LAi78KSQuEnng/j/yjrnICYwdhxK0Iug4M1FI1SBHUjj1hI6vheWmnWR3H7hgcXbjSR2GlqcmdmnT
X-Gm-Message-State: AOJu0Yw2mJubE3/iNZlo69/cj9JFbyKCSnfNef6xhRUOPia5aOB4VfSm
	DL6P+sgB1VB4Uf0DYSedjndcyspfmm+Lhba1+bk/lCQL+UD04EKpRTVgGX7QeVA=
X-Google-Smtp-Source: AGHT+IE44MbJu6BIDOc3JQGIbnw05ABlT/b1420//7Gxn6oIy2GZnOOaOXzQhU0JUqBs5V+YKteclQ==
X-Received: by 2002:a17:903:22ca:b0:1e2:3851:6b6a with SMTP id y10-20020a17090322ca00b001e238516b6amr860088plg.65.1712187721821;
        Wed, 03 Apr 2024 16:42:01 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id b18-20020a170902d51200b001deeac592absm13899117plg.180.2024.04.03.16.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 16:42:01 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: paul.walmsley@sifive.com,
	rick.p.edgecombe@intel.com,
	broonie@kernel.org,
	Szabolcs.Nagy@arm.com,
	kito.cheng@sifive.com,
	keescook@chromium.org,
	ajones@ventanamicro.com,
	conor.dooley@microchip.com,
	cleger@rivosinc.com,
	atishp@atishpatra.org,
	alex@ghiti.fr,
	bjorn@rivosinc.com,
	alexghiti@rivosinc.com,
	samuel.holland@sifive.com,
	conor@kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	corbet@lwn.net,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	oleg@redhat.com,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	ebiederm@xmission.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	lstoakes@gmail.com,
	shuah@kernel.org,
	brauner@kernel.org,
	debug@rivosinc.com,
	andy.chiu@sifive.com,
	jerry.shih@sifive.com,
	hankuan.chen@sifive.com,
	greentime.hu@sifive.com,
	evan@rivosinc.com,
	xiao.w.wang@intel.com,
	charlie@rivosinc.com,
	apatel@ventanamicro.com,
	mchitale@ventanamicro.com,
	dbarboza@ventanamicro.com,
	sameo@rivosinc.com,
	shikemeng@huaweicloud.com,
	willy@infradead.org,
	vincent.chen@sifive.com,
	guoren@kernel.org,
	samitolvanen@google.com,
	songshuaishuai@tinylab.org,
	gerg@kernel.org,
	heiko@sntech.de,
	bhe@redhat.com,
	jeeheng.sia@starfivetech.com,
	cyy@cyyself.name,
	maskray@google.com,
	ancientmodern4@gmail.com,
	mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com,
	bgray@linux.ibm.com,
	mpe@ellerman.id.au,
	baruch@tkos.co.il,
	alx@kernel.org,
	david@redhat.com,
	catalin.marinas@arm.com,
	revest@chromium.org,
	josh@joshtriplett.org,
	shr@devkernel.io,
	deller@gmx.de,
	omosnace@redhat.com,
	ojeda@kernel.org,
	jhubbard@nvidia.com
Subject: [PATCH v3 12/29] riscv mmu: teach pte_mkwrite to manufacture shadow stack PTEs
Date: Wed,  3 Apr 2024 16:35:00 -0700
Message-ID: <20240403234054.2020347-13-debug@rivosinc.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240403234054.2020347-1-debug@rivosinc.com>
References: <20240403234054.2020347-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pte_mkwrite creates PTEs with WRITE encodings for underlying arch.
Underlying arch can have two types of writeable mappings. One that can be
written using regular store instructions. Another one that can only be
written using specialized store instructions (like shadow stack stores).
pte_mkwrite can select write PTE encoding based on VMA range (i.e.
VM_SHADOW_STACK)

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h |  7 +++++++
 arch/riscv/mm/pgtable.c          | 21 +++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 6362407f1e83..9b837239d3e8 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -403,6 +403,10 @@ static inline pte_t pte_wrprotect(pte_t pte)
 
 /* static inline pte_t pte_mkread(pte_t pte) */
 
+struct vm_area_struct;
+pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma);
+#define pte_mkwrite pte_mkwrite
+
 static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	return __pte(pte_val(pte) | _PAGE_WRITE);
@@ -694,6 +698,9 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
 	return pte_pmd(pte_mkyoung(pmd_pte(pmd)));
 }
 
+pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma);
+#define pmd_mkwrite pmd_mkwrite
+
 static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 {
 	return pte_pmd(pte_mkwrite_novma(pmd_pte(pmd)));
diff --git a/arch/riscv/mm/pgtable.c b/arch/riscv/mm/pgtable.c
index ef887efcb679..c84ae2e0424d 100644
--- a/arch/riscv/mm/pgtable.c
+++ b/arch/riscv/mm/pgtable.c
@@ -142,3 +142,24 @@ pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
 	return pmd;
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
+pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
+{
+	if (vma_is_shadow_stack(vma->vm_flags))
+		return pte_mkwrite_shstk(pte);
+
+	pte = pte_mkwrite_novma(pte);
+
+	return pte;
+}
+
+pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
+{
+	if (vma_is_shadow_stack(vma->vm_flags))
+		return pmd_mkwrite_shstk(pmd);
+
+	pmd = pmd_mkwrite_novma(pmd);
+
+	return pmd;
+}
+
-- 
2.43.2


