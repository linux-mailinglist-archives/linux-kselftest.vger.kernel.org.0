Return-Path: <linux-kselftest+bounces-29083-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F5CA61EA7
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 22:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD97A462F05
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 21:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A7D209667;
	Fri, 14 Mar 2025 21:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="RsT08IJc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55D8207A02
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 21:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988390; cv=none; b=eon2k60P/Lb9B/NtyZXzoHgr1dhlbFHrKyMuJLHRLi4PthD+QoxBLMoWgzi/CWYhH3NjfycJL9Zqw3huKIIqTlFlVJuwCvpVxSBszS8It3JTej8Efpn4J5EQb7lST4QKGeI7jh6tCSMpv8SLZR2JKVAv46YLCuMKUYh9vZvE3zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988390; c=relaxed/simple;
	bh=dYnSKVcgjKev+cLvQTSAbxVuiWC0M6hnA+QiRC/dEsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hU0xc+qQz3PdYwbsJ8BzB7A69zGJ+emS3aS7mYEO4/DYHSeu1TqeQ5JNtLN2vMfI0CVpBrYfzneZ2K4PAL/J93rTFsR1WPtgCda3h0DwoMYmNHwseGGqMkHKpUwJsSRp7ipypQNflg56wdzK8oGEIs1hHkQ1uUfzbnodNnDTfHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=RsT08IJc; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22423adf751so41790905ad.2
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 14:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741988388; x=1742593188; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kAIAgpv3AXe4grYgMLwnUee/eXYDz+xNUbGxtfEmLwk=;
        b=RsT08IJcdUpywvAJLLaveXrFeW3P5MtT3iKVoPjiCvbSVVlEdi/L3vdCvT1FO+17GY
         yL0VpMa/fPraoCZGy07XjWjKQjhnSw4hhSFgT1GAktqZCQpGKh07uNQyaH3jy9hp5AKK
         WBRTYpo1S4hA++/7N5sQAJli+Qf0TNr6KOf8SdSbzgj9x3ExVwyZbzuCMB0cfcEXqGVI
         6TfbJZXAUfRaFvVfMSvyAfJ2FufOVwOlJjDPIk7Pueg/xYcIUNgK6u/fzeVzpmfTVjG4
         qMwVQc6B1nrk5rwO2Q7rnAf+tLtm36qHnvN2CH2TJ2o80Nwoa/nm196QpY210fIAA3Vn
         qpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741988388; x=1742593188;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kAIAgpv3AXe4grYgMLwnUee/eXYDz+xNUbGxtfEmLwk=;
        b=XMTYlJlUfWW3kdXsh5hEeppAMFG+dn44SDGvkS3DGzljpapSs4I2qN+b/CQOKO/x9X
         TFdmR5JBGsLftBdO3x6Fj1lvS1bqrSmBUnggdfaBqKWKuBj+Wi7UxoLBhV0/NatJd6WT
         6SchgP7l3mp9DuNpqO81RR8jrtAaj/xPPgTY2DjNISKUMoo9fRVMyLWYJxiZol8Lxv0h
         uxjBLMUH5zotXfCeGZT4Ajf63maxYjj3r3BleeHKrafuEPbkBMhigAfcVltZvc0iCNSb
         nNKDt6ZaEwofr8ryIU45jKtZD/QQqFvOgVafpjNa9jZaWdrF6iqg+BnSungXgp8HlX10
         /e/A==
X-Forwarded-Encrypted: i=1; AJvYcCU09s0OHZ3Cuq5ZEnT9P6/338Gxi4wg+4lGendZgiJ2tKvKHghi/YVfPj5VpwCTybeu0zw/4vZ6cMSQav7+37Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb6z6nnw1RDdrJR1UMNTBtv/mOFbY0fcI8HId6kkYvd4YoBwdG
	YOGHQbHuBwdtlwG/kijhbT3I056kSkdTJQQNv/91G+DFgiLNqk1GUIkCJhTEf/o=
X-Gm-Gg: ASbGncs4rTZNSSCdZvvNNN+iHby6Bqb9LTi1c1YUkIqtbYzk0iLjZd6qzSa6JsVJrSv
	ApDmevihTKE6rZVE4vZNu1xkjgeFZdjkhSDf6PRKvEjwMw7tA4GeVLVwKutGFxvp+6RMhvd2KhC
	6W/nq92o+tnHq4A52TsX3poyA2M5syAu6DZti2UHSjyaBSeYHE2bGXBtnx+zWqlqvfXBm1QRmpE
	OPkK/pwLf3nfJuRD8KL1VlwbLQ/s0aCO5tTylEPi2lfYrUKMbwSY9t7L1z0gNttNeOV9ZaG0NIo
	+FydkU5fO8d2Qnj324LVQLhBlzJe3hb43GuQLUqFI2gMcZsTcX2KSFM=
X-Google-Smtp-Source: AGHT+IHx7WQpWru2fKimtMpSmVFwsTrooQDFYBOULcY3q47kcw+TEVwpgQle1i3yqVDeVf/+DpJMig==
X-Received: by 2002:a17:902:d2ca:b0:224:fa0:36d2 with SMTP id d9443c01a7336-225e0a82dcamr59199255ad.26.1741988388068;
        Fri, 14 Mar 2025 14:39:48 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a6e09sm33368855ad.55.2025.03.14.14.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 14:39:47 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 14 Mar 2025 14:39:27 -0700
Subject: [PATCH v12 08/28] riscv mmu: teach pte_mkwrite to manufacture
 shadow stack PTEs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-v5_user_cfi_series-v12-8-e51202b53138@rivosinc.com>
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
In-Reply-To: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, Zong Li <zong.li@sifive.com>, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

pte_mkwrite creates PTEs with WRITE encodings for underlying arch.
Underlying arch can have two types of writeable mappings. One that can be
written using regular store instructions. Another one that can only be
written using specialized store instructions (like shadow stack stores).
pte_mkwrite can select write PTE encoding based on VMA range (i.e.
VM_SHADOW_STACK)

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h |  7 +++++++
 arch/riscv/mm/pgtable.c          | 17 +++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index ede43185ffdf..ccd2fa34afb8 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -416,6 +416,10 @@ static inline pte_t pte_wrprotect(pte_t pte)
 
 /* static inline pte_t pte_mkread(pte_t pte) */
 
+struct vm_area_struct;
+pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma);
+#define pte_mkwrite pte_mkwrite
+
 static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	return __pte(pte_val(pte) | _PAGE_WRITE);
@@ -749,6 +753,9 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
 	return pte_pmd(pte_mkyoung(pmd_pte(pmd)));
 }
 
+pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma);
+#define pmd_mkwrite pmd_mkwrite
+
 static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 {
 	return pte_pmd(pte_mkwrite_novma(pmd_pte(pmd)));
diff --git a/arch/riscv/mm/pgtable.c b/arch/riscv/mm/pgtable.c
index 4ae67324f992..be5d38546bb3 100644
--- a/arch/riscv/mm/pgtable.c
+++ b/arch/riscv/mm/pgtable.c
@@ -155,3 +155,20 @@ pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
 	return pmd;
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
+pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
+{
+	if (vma->vm_flags & VM_SHADOW_STACK)
+		return pte_mkwrite_shstk(pte);
+
+	return pte_mkwrite_novma(pte);
+}
+
+pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
+{
+	if (vma->vm_flags & VM_SHADOW_STACK)
+		return pmd_mkwrite_shstk(pmd);
+
+	return pmd_mkwrite_novma(pmd);
+}
+

-- 
2.34.1


