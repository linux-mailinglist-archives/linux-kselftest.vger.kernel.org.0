Return-Path: <linux-kselftest+bounces-6833-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEEE8912A2
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 05:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC19E1F21DA3
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 04:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDB13BB2A;
	Fri, 29 Mar 2024 04:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="o5XW9U/J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259F940C04
	for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 04:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711687581; cv=none; b=Z4syURg9gMwn73FqXL7nM46Y3NnttZ8q6SUu0Lzy4s8dxOGUCh6tE+D93xfWH8dGt4Kaeco9FYttgv1XEHgVWWfCbQ4lTUeDIkKVIJzhoyV7/wKAUen+yn49K+n4nyTShKUzrz1hz5hNiZ8zQYKDyuIR8THeUbLNxOSfJKJl6jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711687581; c=relaxed/simple;
	bh=CNl3hprkQqVLkBFECp9sssqM0vv7IwZGZ7tM7RPw44k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t/K20IddAOmmRMlEME8+BsX0qbF01E09iFAxMByXsB3h3Juqx75UlgWWVtZ4FJW4juSYOrn2tEBdiQ19/LMd9ASS+Gi8Noza8sm3pbWgWK92vwj6/Ih7jlBeasWvWGQ4oOYArCuknl4Ppa97IaNcHiAiBu1JJ8B9rqvuMODupmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=o5XW9U/J; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c3ae8fa863so1134109b6e.2
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Mar 2024 21:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1711687579; x=1712292379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1ajd+NFF25bzcoUpj6TOVq3gYUXEAPUF2iej3ctG8E=;
        b=o5XW9U/JqDcaia3OfwV5wrptK104pX7I+qFj4VPK+EhVFBXgIdDgSq9fTtdZ4x0AbA
         iPyUegwdYLZocjaR3edLSpRogZgod0VIEQw01f36724oye1+xdw0xCwcuuZHupCc67Fe
         Lg8Y+JxL9BnQMOhrk2HTUqIywUvkYWZllKwsQ2tgQY1R96v6ael8T/SFRMPqumi7rgoq
         M0EN4vC0ilSab0D2nHOl/kDSBtUD2fdozwwpqcZHNkX/FmuUaDH/VZpGZqmtlyFl8qVy
         RuVgp0TPiV9bnZNTb8i7ozkHHkwszz6Qk1hjum/+6CBWuxRAB/OxEkuvlH5nPIMWPigk
         9cww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711687579; x=1712292379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w1ajd+NFF25bzcoUpj6TOVq3gYUXEAPUF2iej3ctG8E=;
        b=qrF88Qv+l11KI4Q/87Q5UfGRLYE9oFEhyI0tkL7E2CjCPuA54jI6wJyncFq60OZJ/Z
         8J3kaU9Z5OvqZy2y+u/UxNXGCZc0J1W74+mdE3CY7cjOZMusm9l5UGqe3MXjBZ1FHXpe
         c2Qonc6B+FFZjmBxoH88sQpeGD8bmDnr+RNDlOwGA0xVkinuZNBjtUfVGG4kVo+r2JW0
         VizJKA7gp4Ud8JY8Yxgo/oVVe8+rCNG+azIFr0mEnH8acf2XtKJt5wrg2Z9Hyp62N5NV
         HYM6mANjdmprYrdU35guUpJD1FWQrVwVtYXfpCzyUuzOXl+e+l8vBV9hnxitIOONLKRH
         Y6tw==
X-Forwarded-Encrypted: i=1; AJvYcCW9mp/uQThGLAZch0u5zM8axmlELHq9rSWO9BOp78luvuATLjqDqP6gfCRurwVzwzl4mzYk8x2nV1bJWRdQXP1qSeUgUSO/+bTrZ+egnQsQ
X-Gm-Message-State: AOJu0YxmiZtcBMJBG06HeW8jeCAeaN28fgufCcl85nJrm21yIqnv6bMW
	pGTc2M3/9xL1oFxJCSpFWy6uMiKE9EgZ96cjdo2epeotx8D5ckrdZ5hkkX7UMlw=
X-Google-Smtp-Source: AGHT+IH3K7i4PAKAFUMOdgNrbbbhpm+48RguclKkN/rSLzo7SW0Yi7+dWUtv4WvqoPHa2AHkl7gVfA==
X-Received: by 2002:a05:6808:2126:b0:3c3:ed9f:7e65 with SMTP id r38-20020a056808212600b003c3ed9f7e65mr1522250oiw.21.1711687579203;
        Thu, 28 Mar 2024 21:46:19 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id i18-20020aa78b52000000b006ea7e972947sm2217120pfd.130.2024.03.28.21.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 21:46:18 -0700 (PDT)
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
	palmer@sifive.com,
	conor@kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: corbet@lwn.net,
	tech-j-ext@lists.risc-v.org,
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
Subject: [PATCH v2 10/27] riscv mm: manufacture shadow stack pte
Date: Thu, 28 Mar 2024 21:44:42 -0700
Message-Id: <20240329044459.3990638-11-debug@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329044459.3990638-1-debug@rivosinc.com>
References: <20240329044459.3990638-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch implements creating shadow stack pte (on riscv). Creating
shadow stack PTE on riscv means that clearing RWX and then setting W=1.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 4d5983bc6766..6362407f1e83 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -408,6 +408,12 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_WRITE);
 }
 
+static inline pte_t pte_mkwrite_shstk(pte_t pte)
+{
+	/* shadow stack on risc-v is XWR = 010. Clear everything and only set _PAGE_WRITE */
+	return __pte((pte_val(pte) & ~(_PAGE_LEAF)) | _PAGE_WRITE);
+}
+
 /* static inline pte_t pte_mkexec(pte_t pte) */
 
 static inline pte_t pte_mkdirty(pte_t pte)
@@ -693,6 +699,12 @@ static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 	return pte_pmd(pte_mkwrite_novma(pmd_pte(pmd)));
 }
 
+static inline pmd_t pmd_mkwrite_shstk(pmd_t pte)
+{
+	/* shadow stack on risc-v is XWR = 010. Clear everything and only set _PAGE_WRITE */
+	return __pmd((pmd_val(pte) & ~(_PAGE_LEAF)) | _PAGE_WRITE);
+}
+
 static inline pmd_t pmd_wrprotect(pmd_t pmd)
 {
 	return pte_pmd(pte_wrprotect(pmd_pte(pmd)));
-- 
2.43.2


