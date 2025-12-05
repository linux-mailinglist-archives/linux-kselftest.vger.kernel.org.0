Return-Path: <linux-kselftest+bounces-47152-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B39CA953E
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 21:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 255CC303875B
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 20:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE87F34CFDA;
	Fri,  5 Dec 2025 18:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="djPoaVlp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558DD34C14C
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Dec 2025 18:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764959831; cv=none; b=P+zs7Uwm4r9H1+0gKFbKMd4nizGSQdTcSt46yNzVUtg1yKzxNUMWVaWkkNsz3+1RmVs668E4ZJb5keV0ygL3djT9rZQ7JUNHksQ//f3BaZ8fCPjBT1oUbHiVyhhXTk/+f6vkRoimD+Z+lVtTJmb8drJoU/tS7EmTHuGNAr60TEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764959831; c=relaxed/simple;
	bh=c+59GLf/oXo60d4AM3tT5Dly1CdoHCtus6ztRRar0mY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PEKvAnh1NuFf/iXPg7/VrRRHnmIdDNT8FLjLihzf0lvDsFRD920JA7kk61HxVFKaAmNzmSNSOsWIEYGGzG/byT1h0mB7C+kMAhLUEU4GRGZ7ovnQJmipLwO5lzQ/yepl+XOk4/3ARn/Dnx4lM+VnZAbzs4gRA6KuyJSeTKuNxZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=djPoaVlp; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso1964344a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Dec 2025 10:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1764959826; x=1765564626; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qazkzNjoTGNZQrm2wNpnFtC3xWbAXmOxYceHXxLC8bk=;
        b=djPoaVlptQ8/YjlYcJ2+pDn4pFakFy8ehY9V+LI6UwEy2cW4HrIIPLuayBiHNZeMM9
         txZSX/6CsiFtuWENJcDgoXLwfzOitlsXy3OIOEOP1/byZSLmq4a47yDhX+xtruvBUG3c
         jFVd+KTRp5AWCIc83Jua/aNS1PqWGruME+/+iVJV96z7oUQps1e6ut4JmAobBLQTPSJt
         V9e8lemZ0UHJMh2vx1s/pquFK6jqdjZwth/U9WR0LdbA7XdoYvOmw0p30I45G1qGtiOY
         6jyi9QlyZA3I4s4uqRAUa0BJMukT1xYd2HuRSpjPs3kk0dL4ffOZ6RP7D8LecTvk+byO
         e78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764959826; x=1765564626;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qazkzNjoTGNZQrm2wNpnFtC3xWbAXmOxYceHXxLC8bk=;
        b=WZfhmNL+OYpbkCR9lmSA4EDYzqY+ygmsYBfFs1J/MsfHNgV5xmcLHmPIlYCfgO5spk
         8V6hdWdqH4lZE3s/A7uxE+DF7yJx8tGJx6USc0AZW9LsSEWiuZwhyFgbFTqTisfcra6c
         sI9+yq2hAVA1jXv2ifp9ngUY1IKsaAo6QyMKvFuHhq9qu47WAfI5OGLQZOyipHLQmxXo
         fe0PV2Xly95b0nh27Lp4SH4Fo4fI1+JnsQxy5pYoYvUumvlwSHRNI8S5borH4gOE7YVS
         f2iyQgvOOL5JyVNSXpdthBiCQNbIZk/rqT8IJJhqCdI5UPS5OK/o2UuzzdwQijAIzjX8
         j0nQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZTWs1b9omo8Wt3n3DhYEXKDgLBIWaoPAhWl/39lGsorDUSrsrvWJnc7Dl5AAulM7/aOreLifSaj7Q/eroiHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0QLS/at67FomCa5rOKuDMRRnbS5XijVKLZJ0S4s9H0GkEkg11
	OGRp0lJW8drNTqm0GoD2W1NYpmxaPVFGGP8m9XvBSjNxm8SAxvVbqkjtPZ1kQlVSuf0=
X-Gm-Gg: ASbGncu4G+nv2J2Ug6rm6XA1TeZCgApp2FbKibWFcV9GjA9P36K1sPztGHJ11hFsnNf
	GHjuNmohxXFNg9YuwIKfSSNF2/CJurcBxSSSb851/LYouTedagfPla4pMJ76Cnc9g1snwM9E5gP
	ToxyJEmcAmZoTMyxYGm9l5ctLOHZDzED1H5WmzcRTG59BGeAIvduoZ1Qo25FZGMXrLTIZD56kmT
	caDG2ZRglDbli419hU8eZ2AK4/GRytWAQi0eKUpmktNPvlgTVIDreZihim3mQN6CGVZtd6RFNnQ
	9wCAlKMJ6sAA8a48+wiCsQzTBLb3lMcIyCyx/yoLrrBH7oWoa/FoomxcS7Lwkh/Sc58oyFLTVXY
	sAMcLoLHceJG2iKSxTI0d9ibmxDZ0vBBXLx2zN2XDdlyAaYFz6AOcUejgLWuUiOl52I2XscRIgJ
	cTEQlsKgra6WJ5Woo1wxKT
X-Google-Smtp-Source: AGHT+IGWPgA52pVKY392RWVs73+ODbHTzrwBl35/Ip/bb+MqX23pPUpCLekpfaEmLltfbDW+jGlEKw==
X-Received: by 2002:a05:7301:4b0d:b0:2a4:3593:645b with SMTP id 5a478bee46e88-2abc713f251mr100407eec.11.1764959826450;
        Fri, 05 Dec 2025 10:37:06 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2aba8395d99sm23933342eec.1.2025.12.05.10.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 10:37:05 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 05 Dec 2025 10:36:54 -0800
Subject: [PATCH v25 08/28] riscv/mm: teach pte_mkwrite to manufacture
 shadow stack PTEs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251205-v5_user_cfi_series-v25-8-8a3570c3e145@rivosinc.com>
References: <20251205-v5_user_cfi_series-v25-0-8a3570c3e145@rivosinc.com>
In-Reply-To: <20251205-v5_user_cfi_series-v25-0-8a3570c3e145@rivosinc.com>
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
 Zong Li <zong.li@sifive.com>, 
 Andreas Korb <andreas.korb@aisec.fraunhofer.de>, 
 Valentin Haudiquet <valentin.haudiquet@canonical.com>, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764959808; l=2371;
 i=debug@rivosinc.com; s=20251023; h=from:subject:message-id;
 bh=c+59GLf/oXo60d4AM3tT5Dly1CdoHCtus6ztRRar0mY=;
 b=KhD+UIU/8v7BJ40QxMa3DFJbPyhICkmZOWVU8sWEQ0K0JX2XjnwtAs3NAXwpAsMgnytUbLEY0
 tCh0LHo2nu5BZL8LeCtCwXo00kOQ5pMdYs9gGJ55ybs4tzUu22/zeTK
X-Developer-Key: i=debug@rivosinc.com; a=ed25519;
 pk=O37GQv1thBhZToXyQKdecPDhtWVbEDRQ0RIndijvpjk=

pte_mkwrite creates PTEs with WRITE encodings for underlying arch.
Underlying arch can have two types of writeable mappings. One that can be
written using regular store instructions. Another one that can only be
written using specialized store instructions (like shadow stack stores).
pte_mkwrite can select write PTE encoding based on VMA range (i.e.
VM_SHADOW_STACK)

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de>
Tested-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
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


