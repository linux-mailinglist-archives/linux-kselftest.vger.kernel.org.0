Return-Path: <linux-kselftest+bounces-43584-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEF7BF369D
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 22:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32E8A18C0719
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 20:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BD333506E;
	Mon, 20 Oct 2025 20:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="BvW4T9j6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434BA3346A7
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 20:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760991779; cv=none; b=WiFXG5L3NJ73MHmQGDzjg9Ute8tMFMaP2MKMlZ0RV7qu8mDQYVITmzGNY2YaCOmrF7dYDbxQ4mBiMo/D4F4RJvzbPJXCJQo+S+td7vpFn/bKGH2UGwd9Jrh8b0qbiFESoMqbWyt8b3wZF22KNWuX+ziR4ec4I09/7xDplsKmlns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760991779; c=relaxed/simple;
	bh=OpJOxzQ6J1PHp/VY/sLG7GChBfKjV0VxMWfzEAtIg50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q7SoxgF3qIZbZexpP3V7uyvuOEGERz6pSOiTmYP9UcJzQskE4NiDIbN2TRCtzzpQbZRw47dRgqNlqGzk4K65UNzhridQlEGrJFdTOPV9Lpb9jdfuH2VlTh9TNfvkHFTHmDrvf9uXAJKBdmBFpoGMDmLk7gIfWNk3Td2rOpuUpIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=BvW4T9j6; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-33255011eafso4478366a91.1
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 13:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760991775; x=1761596575; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ouwtbe8R0Oh+n2FlVTKPPjmDEW3Po0ayDuW4LCokLZU=;
        b=BvW4T9j6mFPx0UOMLLveOM/r26WivEwfFSKgdzFc0l/Zudg54vSvB5rxgyPYLU634/
         Fmdwv7a5WZqC3ASRURcR+XGYJFhemyY0QYMR9QcvI8p7SLHW5bcBSincy+ZkhkZkr0WN
         3hEIc9Zt6KxbCFjSkGvAeUUN+5QPvsuM+O/j123+ysrYU8dbhraDmFSXrUqRITRdyWRJ
         xrTAtK6LuxX7TQyEHfNd7k1MxMsQDNNWmd6HHh/uGkvqOWRqxWXWwQNgsy3UTDzPmJTv
         U1Y3m7ZXwtOD7udmW8CrO32SsaFEAEmsi5OWLFq5XdvRa0eYvcNiO0q7fL90jTI4/1o6
         aQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760991775; x=1761596575;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ouwtbe8R0Oh+n2FlVTKPPjmDEW3Po0ayDuW4LCokLZU=;
        b=Zl2HoqArQH0SuwxjvZSpI/B7JWNwfxUSmcbu4AaoMjzEddu66tMrEaIAVMtCX4+nct
         t0lKK1JPI7+u9wPh11N4+wreciFJ86JxJMEllo6EJ0qvG7Ri00FksnPZmP68LVB7GqzU
         wo6kOMbfP2N1CXw+KiruqtfZlAXNPLxJAI+uTZUtV9hMRQFn2B95zjlU2/A4bbHxlww+
         nvfEvBENAs0IV4ePoABRDrdm1wiNEcoku3bpK8JTkUp4ofoIIAfz78hSCIzZRGZyh4mO
         kgrymgAPRwZQzYUlxHAda0E59nm27qQT/DsQtUsRa5XBdPWyilBK6yCsj2BBbW+MAe41
         2FhQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3xkSiMx8TpNZAa9SMSUV5Q+L4RB6rddrxWSdWwy2Zf/h3HcbfbLdz43daCwRhqqUKAtb/g5Vzou4TKrovLtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvpnmuPwKfR496W8PqrEbPavvzneG+/kBadrlnhPQvWTURNOrF
	kga9j3sB1ZkpBtdt0AIa1qeER7yp82d0p6rxZ+ZR9rJumn3jMGjnZgTSRoKaaZtukqM=
X-Gm-Gg: ASbGncuZF3DNihGZ/8SwaRHuP1eaQqrVEbo6/F5FG4iDLJgfuZkWcloZ+jTvTVLMAQs
	5OM/bSf04wungy+UAJBQGs77nUYQ01we26qHiMNjd2PG2EKUQDhJlDNjvKb9Xe+EABz+VnT26ID
	8Zr/PDDJAZ1+VcRgzMRheXMk+9w0KcxvGJkjXL8dE78bWDQzdZT8cBTRqFRuNAG4KJ5PdVn3s5H
	4K+ObSef6gcop7FA74WU9Pq+WgXipAIqqJ/+JbxntAOvLpzaB0wVT9jVBlKZjmmFwd+Ahu7qyv8
	0doNM+Y6G2TsymDY5uG5LgZZAJa7TTGlw85nI0yB9zBr7tdirEo3Ax7lZikyOwq08ebzvIYqCx7
	gxV8oWQYmMSem3KjlZi0/ETxECfkGOeKCF4oCw7MnRsdDMNF29LIuJz/2dK6OUiZMGG8w/rVQOO
	Zt6I6eHinajUicZ4Pzea2L
X-Google-Smtp-Source: AGHT+IGVYGp6RpoHZtMEnuKRtaA6P+e7vcil/yBZ6a/LspeozTywnKWSGgV4o1nOqkaRYdNcLLQYGw==
X-Received: by 2002:a17:90b:2686:b0:32e:e18a:3691 with SMTP id 98e67ed59e1d1-33bcf919f1fmr21052145a91.35.1760991775439;
        Mon, 20 Oct 2025 13:22:55 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a766745dasm8443240a12.14.2025.10.20.13.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 13:22:55 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 20 Oct 2025 13:22:37 -0700
Subject: [PATCH v22 08/28] riscv/mm: teach pte_mkwrite to manufacture
 shadow stack PTEs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-v5_user_cfi_series-v22-8-66732256ad8f@rivosinc.com>
References: <20251020-v5_user_cfi_series-v22-0-66732256ad8f@rivosinc.com>
In-Reply-To: <20251020-v5_user_cfi_series-v22-0-66732256ad8f@rivosinc.com>
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
index e4eb4657e1b6..b03e8f85221f 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -420,6 +420,10 @@ static inline pte_t pte_wrprotect(pte_t pte)
 
 /* static inline pte_t pte_mkread(pte_t pte) */
 
+struct vm_area_struct;
+pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma);
+#define pte_mkwrite pte_mkwrite
+
 static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	return __pte(pte_val(pte) | _PAGE_WRITE);
@@ -765,6 +769,9 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
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
2.45.0


