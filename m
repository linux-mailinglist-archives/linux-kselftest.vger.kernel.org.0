Return-Path: <linux-kselftest+bounces-3528-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D45D683B9D7
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 07:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74AE61F22E1E
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 06:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3C9125D9;
	Thu, 25 Jan 2024 06:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="aVj46D5R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41E51B59A
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Jan 2024 06:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706164191; cv=none; b=S+NOLsaMfs1LTU/FPvW20NfVqSgQAg2cFtQNuoX/WoIn2czC2zydBtEOf8rLCM60eGiZ0c/G0NUrm8hydg5tc4haZXv9uhEr84/Y7WGsDU+oh+yhpB8nOP6itRspq37uoT92mDyS1ACnMohkIvqWyUyMoG5vtrOTIXLGgjDHqDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706164191; c=relaxed/simple;
	bh=FfixUI8MC2ZdNJqvCMVXTVMx4oe56WGSabRF6Z+s82s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nOCaP6XL/UFkTp1reAU4ns6w9rY/ZRTL96JrfexuA3hDVt/1yOM/JCzkCbclhOKCU8ScsK8rDxL0zc8hWgb8++H16GioTBTcn1jfdq0p+q5PunOLJEs87w0NpEI8bCT2/JKAMUtWiTQeamwFUAp6nQMFGzkYS17NyzsXxQAv+pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=aVj46D5R; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e0d86d4659so4527650a34.1
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 22:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706164186; x=1706768986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJDL1aQMYsZ6x2hXclmWD0oGcQ0Z9qLhCUiJhXHD6LQ=;
        b=aVj46D5RxVrVjR6RkdwcyF93dUnlFCCCM4bjHRulvxeGq/b62JJUWS7rXMfZmePhXi
         v6ezGtjr5ABIOkgFSgcrkjlU/FxTWXBJSd74Rln4S/mjsr2ihtF0rT/Qfl/zGl467zLu
         wkSzzFvbtd/ifxDYZ2/yxiz6V2NFkhqGcfAOwijHhFcy/iR1TGka4E+7WKhTzhYW9TzM
         y8W4Sv07726xWApwoCjRsxTVFFssMRecn9dNNsAM8dt/Nn2VRzu1IQW8z1RLS8tM1EVz
         rc2ZGL/xVQm9UoLmcE+v8Bo3worpzy1TKj9pHsmVMLb6DOSsL7Rv6/v9My9ai0dWpGZO
         kIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706164186; x=1706768986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJDL1aQMYsZ6x2hXclmWD0oGcQ0Z9qLhCUiJhXHD6LQ=;
        b=uRmwkK4CgD2NMO53/5uqk1vUO3idF98yVw+sQdXNqreI+VhRMM+9oh1/zmAWq/1eNE
         io87jCMNlIrYjkqHNDmMRt4e2z6GU+rQk6kF1AGQRXtiwCSSKa8dVx9N5kT5Te2H41kw
         oiXUtiBoPHDzFx+vvHdUDKlMAlEG1s9P1dQTvPZa8giiOHbG/+ADdjNz1aZvoo3BjAWW
         2msx0/iWkUFFvJ3LUAemDjuE/xtTnsSnkK7YreZoE+0Z+e0x0i/JuOPyJSRPS/eSpk0M
         zoolqqGuQ+SZfhLtu25bi9dcx0eeq3Ax8jRmgWi6/HN3NPSPF5MfnvEXCuavzG+Q1tMz
         h46A==
X-Gm-Message-State: AOJu0Yy5uV9sAzNll/UYHaeX27TKh9k1ivfphvT0BEFkQWWT5YhRDrGi
	9EkDC4VCHNDDB6nkJ0WG9iOf+ZQ0v9fBkCIHUVfc6vktWcGgzL/kEBVAD/zbtso=
X-Google-Smtp-Source: AGHT+IESxe3nC4p6ceWk0Q/8i6vycGlmQHt1EYp+hk+MoL237ObbhpMDmBWtgjNemeeNm1tg7bXXoQ==
X-Received: by 2002:a05:6358:6f17:b0:173:33e:ec22 with SMTP id r23-20020a0563586f1700b00173033eec22mr487238rwn.22.1706164185725;
        Wed, 24 Jan 2024 22:29:45 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id t19-20020a056a00139300b006dd870b51b8sm3201139pfg.126.2024.01.24.22.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 22:29:45 -0800 (PST)
From: debug@rivosinc.com
To: rick.p.edgecombe@intel.com,
	broonie@kernel.org,
	Szabolcs.Nagy@arm.com,
	kito.cheng@sifive.com,
	keescook@chromium.org,
	ajones@ventanamicro.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	conor.dooley@microchip.com,
	cleger@rivosinc.com,
	atishp@atishpatra.org,
	alex@ghiti.fr,
	bjorn@rivosinc.com,
	alexghiti@rivosinc.com
Cc: corbet@lwn.net,
	aou@eecs.berkeley.edu,
	oleg@redhat.com,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	ebiederm@xmission.com,
	shuah@kernel.org,
	brauner@kernel.org,
	debug@rivosinc.com,
	guoren@kernel.org,
	samitolvanen@google.com,
	evan@rivosinc.com,
	xiao.w.wang@intel.com,
	apatel@ventanamicro.com,
	mchitale@ventanamicro.com,
	waylingii@gmail.com,
	greentime.hu@sifive.com,
	heiko@sntech.de,
	jszhang@kernel.org,
	shikemeng@huaweicloud.com,
	david@redhat.com,
	charlie@rivosinc.com,
	panqinglin2020@iscas.ac.cn,
	willy@infradead.org,
	vincent.chen@sifive.com,
	andy.chiu@sifive.com,
	gerg@kernel.org,
	jeeheng.sia@starfivetech.com,
	mason.huo@starfivetech.com,
	ancientmodern4@gmail.com,
	mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com,
	bhe@redhat.com,
	chenjiahao16@huawei.com,
	ruscur@russell.cc,
	bgray@linux.ibm.com,
	alx@kernel.org,
	baruch@tkos.co.il,
	zhangqing@loongson.cn,
	catalin.marinas@arm.com,
	revest@chromium.org,
	josh@joshtriplett.org,
	joey.gouly@arm.com,
	shr@devkernel.io,
	omosnace@redhat.com,
	ojeda@kernel.org,
	jhubbard@nvidia.com,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH v1 13/28] riscv mmu: teach pte_mkwrite to manufacture shadow stack PTEs
Date: Wed, 24 Jan 2024 22:21:38 -0800
Message-ID: <20240125062739.1339782-14-debug@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125062739.1339782-1-debug@rivosinc.com>
References: <20240125062739.1339782-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Deepak Gupta <debug@rivosinc.com>

pte_mkwrite creates PTEs with WRITE encodings for underlying arch. Underlying
arch can have two types of writeable mappings. One that can be written using
regular store instructions. Another one that can only be written using specialized
store instructions (like shadow stack stores). pte_mkwrite can select write PTE
encoding based on VMA range.

On riscv, presence of only VM_WRITE in vma->vm_flags means it's a shadow stack.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>

rebase with a30f0ca0fa31cdb2ac3d24b7b5be9e3ae75f4175

Implementation of pte_mkwrite and pmd_mkwrite on riscv

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h |  7 +++++++
 arch/riscv/mm/pgtable.c          | 21 +++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 7ed00b4cc73d..9477108e727d 100644
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
@@ -706,6 +710,9 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
 	return pte_pmd(pte_mkyoung(pmd_pte(pmd)));
 }
 
+pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma);
+#define pmd_mkwrite pmd_mkwrite
+
 static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 {
 	return pte_pmd(pte_mkwrite_novma(pmd_pte(pmd)));
diff --git a/arch/riscv/mm/pgtable.c b/arch/riscv/mm/pgtable.c
index fef4e7328e49..9b1845f93ea1 100644
--- a/arch/riscv/mm/pgtable.c
+++ b/arch/riscv/mm/pgtable.c
@@ -101,3 +101,24 @@ pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
 	return pmd;
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
+pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
+{
+	if (arch_is_shadow_stack(vma->vm_flags))
+		return pte_mkwrite_shstk(pte);
+
+	pte = pte_mkwrite_novma(pte);
+
+	return pte;
+}
+
+pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
+{
+	if (arch_is_shadow_stack(vma->vm_flags))
+		return pmd_mkwrite_shstk(pmd);
+
+	pmd = pmd_mkwrite_novma(pmd);
+
+	return pmd;
+}
+
-- 
2.43.0


