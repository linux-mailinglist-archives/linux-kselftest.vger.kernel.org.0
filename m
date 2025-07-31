Return-Path: <linux-kselftest+bounces-38147-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 651E1B1798D
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 01:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8EAC7BA078
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 23:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACC8285406;
	Thu, 31 Jul 2025 23:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="3VJh4WLB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40061285078
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Jul 2025 23:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754003984; cv=none; b=jswvz6/UzEou92vY5Su5ukheXXIwE6ugeplrnY7qjaXzFAJLMOYwJynuuXm5BJxG1DTYp1hSxUzo0NDzEh60eD60mM0cUeVNuMN9PnZ9kl9UMFSrQm1g4rQfKQVU8cgE9ywNU/G5wKweHvz2jT3QUQSLcEzSW8zLM2aKaow9RZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754003984; c=relaxed/simple;
	bh=81XzqmtIK3R70Ndhoy+hkyCDJLiPRMLBjcUZcF1lYxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M0tUMLCVqkoRECOS7rG34JS/Wg1spg95FRqryrYl2FUrOREAfaBggY5mL/ttgcqbJhyxFEPA38Dr9nF/mHxdr+iYQAbGBH4Kjy5L7kUAofMDLiu1MyhBaYZs0PgSaf6hiUiQfp9M0U49t7f4r28B0X06Bs98CRWxcwPo0CkVTts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=3VJh4WLB; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-31f53b3b284so2774155a91.1
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Jul 2025 16:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1754003982; x=1754608782; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k6HnUvt7E9ZR93PM/Gyja5rS+Mx2C6I8XGI70UUGCh4=;
        b=3VJh4WLBWk9sBV9lFBG/wnF8MJ2jJbwPaeW1zgZONcdZM6LRFqdz3f/lxkLSCqkkJW
         vO1g1d5XjFriJED7M/iBidoUcTOBR/gckMa0ra2xwpcVSAUNaSlSTeLZ+7rqdCcZ69uV
         +VIIGFtV9PMPgJR+i2Lge2AbAFVLRfzf5fLuaAcHYPti8vdUyZT7S5U0sDPKbMkVeiHL
         ShGzMnqfq1B60nSwQAl7EzMVJ4Hds1hmzIrFhJ6wa3weBhMFg3ws03NkpO7CgF2kXP1B
         D8rrNB7Z/wcDQWLqFf7ZFgjfbOVaKJJ1uoZh9Q7gm8AUbMTOtNHFo9glOvnxN4iYSUmP
         16xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754003982; x=1754608782;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k6HnUvt7E9ZR93PM/Gyja5rS+Mx2C6I8XGI70UUGCh4=;
        b=jB+PgaqZ3nz1fCJs27e1NR9FS5+MlTjDDFGFHgX/sIbuSMbngzOe2wQ+t1wv85QvUJ
         wa5RJ/eeflXPc3t/ThaFUhz7hyWiqV8lUzrUWvP+DoNnywvQnmJDN53XucZ0RMsaVbET
         IbSRQVUMRUGR5luqXtt+C8Lh1MPrItQLrGXMV826k4d8eMGebH/XXVus7usTuHdlVGoB
         WgcX30UpGrZHQ6aAEP73Pd1g358AsipEdhNfRS2FpK8+mKM6uRVoh6ahtS+as9F91mfs
         iyMg2BFOx7iCVmVJdCcrcihprUIEK45sGwJlFR7qnbQFIWqFdjr2tDdXNZi2m7+5Ghax
         2aPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfHCuErkdb98xXFtrG7ggQSHauCzM1O6Lr7wZBy8JhmfVB5vojyWSmUy4BbNnL3BK/whYJ+Wb2bNJNnoX1t+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEPjfGzaS7CC7H8fF20ZEf08SdC/LvAg4XjteCxFXNlZiiFz/O
	jJBu8K8I4sKASvV9S+Hrhnjwk6uxzaKUebAYN1IWjjE1mVo2AAL0tYdfs/zzZ+ZmtbU=
X-Gm-Gg: ASbGncty+Y8oHbjNYqCV7vZ0OOXPvI5dhPVnGuPlAYUOB6Ex0BWUeXK2v1g3FssKRLP
	Q0PFH7xman5cv4rerV/vkXBEk93qcnj+x6sYqcDajRxlyz239DbXY8TU0bDjkvMt8tMEMGS0hGq
	9svO6lr5iXoVSHJmO/EuS7jVWbbOmp3RTzU4njkAU8oMlVNRlxqbjENXqqTbYHpJBWoSCy/3Vgk
	ezlwoAfmYgfQV/UVniTs5aayhnl02pV8j3unvPxml+qrjbsfLH3S0geYKBazCjdXekgJJG8izsl
	bOXZZhH/4J0wOD9zVi958kl9u0am4PcnVHZkRr5RtHGBy9nc5zKzroWizkP1dSTMfKm/jtWBHWq
	m9HlT4Ec4bI+0mIx7LjS6rDNw3X//iTIb
X-Google-Smtp-Source: AGHT+IFK5NdFXAB7IoKpdbqOrLQWep91KhtVBkahQPqZIs3AVxChdKclTwDK0V60c+zsRWOqPN/wCA==
X-Received: by 2002:a17:90b:17c1:b0:31e:a3e9:fda5 with SMTP id 98e67ed59e1d1-320da626cf1mr5388757a91.17.1754003982599;
        Thu, 31 Jul 2025 16:19:42 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63da8fcfsm5773085a91.7.2025.07.31.16.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 16:19:42 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 31 Jul 2025 16:19:18 -0700
Subject: [PATCH v19 08/27] riscv/mm: teach pte_mkwrite to manufacture
 shadow stack PTEs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-v5_user_cfi_series-v19-8-09b468d7beab@rivosinc.com>
References: <20250731-v5_user_cfi_series-v19-0-09b468d7beab@rivosinc.com>
In-Reply-To: <20250731-v5_user_cfi_series-v19-0-09b468d7beab@rivosinc.com>
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
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org, 
 Zong Li <zong.li@sifive.com>, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

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
 arch/riscv/mm/pgtable.c          | 16 ++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 792cb9792e8f..2b14c4c08607 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -426,6 +426,10 @@ static inline pte_t pte_wrprotect(pte_t pte)
 
 /* static inline pte_t pte_mkread(pte_t pte) */
 
+struct vm_area_struct;
+pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma);
+#define pte_mkwrite pte_mkwrite
+
 static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	return __pte(pte_val(pte) | _PAGE_WRITE);
@@ -776,6 +780,9 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
 	return pte_pmd(pte_mkyoung(pmd_pte(pmd)));
 }
 
+pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma);
+#define pmd_mkwrite pmd_mkwrite
+
 static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 {
 	return pte_pmd(pte_mkwrite_novma(pmd_pte(pmd)));
diff --git a/arch/riscv/mm/pgtable.c b/arch/riscv/mm/pgtable.c
index 8b6c0a112a8d..17a4bd05a02f 100644
--- a/arch/riscv/mm/pgtable.c
+++ b/arch/riscv/mm/pgtable.c
@@ -165,3 +165,19 @@ pud_t pudp_invalidate(struct vm_area_struct *vma, unsigned long address,
 	return old;
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

-- 
2.43.0


