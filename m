Return-Path: <linux-kselftest+bounces-47062-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E10CA53ED
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 21:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DEC030CFA10
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 20:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471C034D383;
	Thu,  4 Dec 2025 20:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="VJPX2zxa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEB934C9B5
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Dec 2025 20:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764878659; cv=none; b=CY0S4mCquYU7WfXzxG4XhSAF93BvVURq6EUEIxKeWj6/WcuRD0eyqII4eKB9IarWfvToZwKWX25sTP1dBBZZm+tDDKHy//AGiaSfnPsI8oYkhfpgKJitACpoKMgGiYC5y5yfQ8jodQf/e72e33iqqQ7W5lDB18+B+V3qgOgCPfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764878659; c=relaxed/simple;
	bh=c+59GLf/oXo60d4AM3tT5Dly1CdoHCtus6ztRRar0mY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PLtNP/uw2dulYkgO8VcRewJ0TnEfKNcOD4EbArQt+uF7sQmK33+IzpC0LMFtUHhw5sv5XyM0HLakzt2/NCEpOaGWCcihEnhhVOuWX9bktIyrZJ43dBjHop1FThNcnHUaAhsJBuMAyhBVA3qoVQrnZEzQwCyvDmRyr5yVsvwfNKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=VJPX2zxa; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-bc17d39ccd2so736387a12.3
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Dec 2025 12:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1764878655; x=1765483455; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qazkzNjoTGNZQrm2wNpnFtC3xWbAXmOxYceHXxLC8bk=;
        b=VJPX2zxal/4iKr8/cGTDh7w/Xab5oHv5ZB2OaZ3sVAS/iQTpAW5UApXsDkjElKHeKx
         J1f7p97vgEQcVU96W5tmyjqMv8C3hX5gDqV973H6fNVKIDOZF3VJ8xh0YtinZwGQVuGM
         t9cGw7SK6d6ZxZvp+Vy6+GEa6t5I5wlxVZRIeg/PxuwlkG4kFu/UlY+GqUfyyKU0XhBA
         dtEC1fbnt54gWO2wlZA6SBa5ac3x4iH2L/TOqHmpUZpSg0UJHcxTdsWg0QRj21BbHZ3B
         HdkFofaQndfOFsjCpCDstftGxoPGb5eKRHJ3hWzNJrRSMdj2De2EAJvROjz+bGbSqesV
         czkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764878655; x=1765483455;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qazkzNjoTGNZQrm2wNpnFtC3xWbAXmOxYceHXxLC8bk=;
        b=SAkf4FbgwC9trUN95VtBc/jGysMNkDA8yru3bsZhf2WhQnrSqL1Ti4gnbzsDeuZnbY
         A8vvavTCQ/3hzJwnv9x4jRbZYoEaHzxCy137pgnTeQaUce5rq79eJRfA6qj4FQ/mM2rq
         +WsqhGj8ypll5Drrk6SkhWZlzKDPSsSI68R6KF1LKl6ZWzlrWb/iiAAE2N9BU3xxo8eP
         c++bgaTMuhmpbt+kMhKcIRxkg+U2MQ6wxHu2/i0FW090Esy43l2WhkjOjqmsxB0gWRL4
         5iiMbvWvx9d3nmssRyoo4D6QBm1lvbSENJgQ0v4xGlsfbicfL/T9EV2N/aACfvqZ12T9
         ofcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTrUymPiyOkhkPiEEBIUj9iga4m87x65YMLYyiPZm3EG0BkQjbrWQ9SW86CHS+S3NV7CwXrxw8I2lpNNl/9m4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4HSMy6LzDxJhuuv3vxWtc1BOmahZFXZEgsOZ1U1NS2gho2/lB
	gUQuBIw9ulnkaVAT88KlZ561toaA1xoDyeyOeuiPhQZC7PS8b2dmKIDEF+r0iljT/dA=
X-Gm-Gg: ASbGncu3qny94oJFlBfwmIIDPcVIcLX4dMqJx7Op15HsJdrnlQq1k4xlbEVsYUznhQO
	32WHiqoO/0FH0VL6tIzrU+yq9kvrioMgheWF2F8EXd9iHWUb90ekMp7dLGqHze30zuSCubf23Yy
	ZCiCSaONDjGad1OsBim6jqermdQXixWEny94QtUp5BltGYKBENgTqAcXihJk6fYLYRlVX+2z0+c
	X/+69/t7ByUBID1zo+y7VqBuAFnPPM5lJoWdJFrT8wWp2zopHtOa7EblDO9Oq17uhX3ibHWnGaq
	0DuaHCPKAhySaw6OB60N1yLJIxHompr8LWk+X9lxBgbypLV9GU9sIiB3Hn84ch1T01nfnnVugI1
	BBxYQbky04dN24gZEKtExTOYaPtq/cFMH74i7O9GtkbEa23JnSQdXJWObztmyob6k3gxdbNymZx
	wU54Tq7Qh6zT9vcz8PziUt
X-Google-Smtp-Source: AGHT+IFp98bHY82tmn1SWytYtV7IsOH4MNT5CrcOIzKcMZAK7rnYCRSLOXMz8X4skJhf2qDKjmrSCw==
X-Received: by 2002:a05:7022:249e:b0:119:e55a:9be6 with SMTP id a92af1059eb24-11df643c373mr2741142c88.2.1764878654709;
        Thu, 04 Dec 2025 12:04:14 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76e2eefsm10417454c88.6.2025.12.04.12.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 12:04:14 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 04 Dec 2025 12:03:57 -0800
Subject: [PATCH v24 08/28] riscv/mm: teach pte_mkwrite to manufacture
 shadow stack PTEs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-v5_user_cfi_series-v24-8-ada7a3ba14dc@rivosinc.com>
References: <20251204-v5_user_cfi_series-v24-0-ada7a3ba14dc@rivosinc.com>
In-Reply-To: <20251204-v5_user_cfi_series-v24-0-ada7a3ba14dc@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764878635; l=2371;
 i=debug@rivosinc.com; s=20251023; h=from:subject:message-id;
 bh=c+59GLf/oXo60d4AM3tT5Dly1CdoHCtus6ztRRar0mY=;
 b=DBHza92aj+k0BS2czHCo1xp8g9Cp+zSzm46DfBTV4xMmhPpMOTYeBlej3lCSUVel0u+uvkiuX
 hMVROXA+6ouD+BJWbNswx6PxOLIYpQkgCDWYd1oT2RkSzTAuLozzwnl
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


