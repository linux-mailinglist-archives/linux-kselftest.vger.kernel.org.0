Return-Path: <linux-kselftest+bounces-43813-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 47166BFE8E9
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 01:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C186735602B
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 23:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E673126B3;
	Wed, 22 Oct 2025 23:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="F96YopPf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D0330EF85
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 23:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761175800; cv=none; b=D0VID9ug2gV/x+ZHCV3z7BDfgm5HVMVQb9qni8DkyrASusAlal7wcdO3YEltcyJknB4SZigtZo3s0xy8Xw/bpHE2PByb9W6RCKqnZgomN4hn4oaZWGOpPve2G4RAIVd1Kks6aFx9ME31WgNA7VW57OwMZmNF1GS+6zxZs+DSKkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761175800; c=relaxed/simple;
	bh=hYnrlxG2aSy5XgBcW07Fd+5qY0pd1xI872KUOKzj6JI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XFoPZTL/6vtLRBE570dAaujz86M/YjdnQHbHJ5dOvkghyCblk2N2hDmt1Th8ObXkxgdkLNTLmcAWVfNH3L3lYlrRdUmfPP/J1Sg3tKJM20c2pZc1sf7m5Ls6xZlLO18eTsl4PJEQmmCt8GPhN3wNRIKq/dp0+guxibKPVDSE/Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=F96YopPf; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77f67ba775aso227973b3a.3
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 16:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1761175795; x=1761780595; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aU5JHaPOPUGgukhD3bad891ElerIE5ocm+VeTPJz1C8=;
        b=F96YopPfnyI5qIm5U5k4h/r+ABsuT5800lgjUUtKEFDH6w2uM2t8T/8Iv+Sp+PIXPI
         GPM12XlrqM15lOihlDnXNL+WIxe+uga9oKGNtmwPx/jkucsN7StbbJdbUCfI1lPlQoRT
         ckeWhbK3WaqwbdB+Rx8I9Y11bbMv8DYIz2n4M15Vu639U0lCadht9kNIaoRtuHYQbOiS
         Cu+6xdVdEhc4VAYNM5ngDS5lHXfewdWG/sf0jW85YSJa1sPEWs2WB/FsJqOmNWutt44j
         YyPaPN0NoDHOAKO+gx2AdJbZuZqe4WX1ddkgobIjIQxDMBORj9NbbHtzAtmNKU9uuTqi
         Uirg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761175795; x=1761780595;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aU5JHaPOPUGgukhD3bad891ElerIE5ocm+VeTPJz1C8=;
        b=J2X14I9kryeeZ2hknYxC/5GZVRUqQ9PGuXP7ZMDVhiD1br6/SeuzGMMwy4fVaj7IKw
         cfKIeSDVNqlmRpRPcutVreB14nEWdh1vCEQw3Oen2aDu0ob09iDgwNXbADBeHx4hTdTl
         gCvR3zOBf9Fq7bI9yH0u3ziaZMuH3sXXeYJnG+T275H8sW9Y7uC8xjV8UeRloy39XDVz
         aNCflkhDxD8tlMV3pD/4Vyc7knUU1rX5uz6wHX0RYTHIQXw6X90WyPjcDpSPFpxaHXCw
         B6vkHvW+g8XJsvpHHgSYK0yPl6ADPHCoaKdu4s1SHw3lF8PYkgCMKqwMNx+VBRsTBOt6
         cTKg==
X-Forwarded-Encrypted: i=1; AJvYcCUL0EFOYCx0hwUmJYTUURwybXhE/aNYlU1lCSh7ldYxqkDhZtLWQbKn8GugRqSHQFIal116P5UHsmpc7ccISpc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz26eeIYVxXbf3+FGfhGAe+qVqqiFbNd70puQGyemlupNNE80/4
	bMnMn39BwEfrqNjw4mP+mlM495OvI+voKRtiX45MSpyAUrmISzG9TNrt+o77kW8uwOk=
X-Gm-Gg: ASbGncuwqMymjJ2yHHBOaxRAkrjsDvsFn7HsGdqxt1zJmlsRPYUQwfTHXBjMESRpTgo
	ekS1PlQDNeoTQmmbVQoAOJLBJBzMV6oQR7nsFOC1rm0gvIesCcuzEWnXYjz4MEmcVoNE7C/I9K9
	d/ExwqeyYcFE/N10uAt4vEJi/JiOVljZPctfxCLiXYYqGhzSDEYynaDIJBE7BtpkHWB2WbYJLSX
	ECkOt9v1hn/Q9CZQ6gzDZh9qDcyCItNvUP/v8uNKNiSkqKTo4hKQZVpj3Qj+GAJLZtUHjqOXQjf
	KId+4gPYgEAHPYK3HkWsT+noqFoTgbIDmpdxil6paS3JnYv/1ZeCmU+HkGmiXs34Rs9EYJceBCz
	8WqVuPQIbRSxxRhfUnUkHgkKOwqQfg6/yuvcrRBF9FrK6IEe3o6aAox49TLXYzO3HV8NdiXNSTo
	6xChP/IGmf5A==
X-Google-Smtp-Source: AGHT+IFYp0ny70CA4NAOgoFbnGMlXPyOpppEdL0vT/v/zgXSwVQA4g/6+fINYUYu1VCsjkOYj2gtog==
X-Received: by 2002:a05:6a21:8881:b0:33a:86cd:1553 with SMTP id adf61e73a8af0-33a86dc7f16mr6439638637.12.1761175795311;
        Wed, 22 Oct 2025 16:29:55 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274dc12b2sm392646b3a.67.2025.10.22.16.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 16:29:54 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 22 Oct 2025 16:29:34 -0700
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
Message-Id: <20251022-v5_user_cfi_series-v22-8-fdaa7e4022aa@rivosinc.com>
References: <20251022-v5_user_cfi_series-v22-0-fdaa7e4022aa@rivosinc.com>
In-Reply-To: <20251022-v5_user_cfi_series-v22-0-fdaa7e4022aa@rivosinc.com>
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
2.43.0


