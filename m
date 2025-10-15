Return-Path: <linux-kselftest+bounces-43227-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC585BE00E0
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 20:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB1B61897C6B
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 18:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3963D341ACF;
	Wed, 15 Oct 2025 18:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="MHEVBTF9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E9B341AA8
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 18:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760552046; cv=none; b=JMI9hsz3rln59toWXNb8xBPWA3YHKedSOIy6VdTG6R0mNxFMYmOdkE5sL+8UtzT7s+VB5uc01fTEvRr+rEcj+w3XysFIQsce/+YhY92cLCucgCNUH/ESiTKfw9tAmRy7tscA1cnLWyEl2UheWbDX90JQrIFb1f5pvRUaAcbeeUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760552046; c=relaxed/simple;
	bh=zG1PvbsubgVB7UstpLjRtN915FxsRLFbcnYegAn0YwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fiQUSrMuCK61Qdwgt9sgvUFCEIfU+YsRCChhbcuJx2ze7B5G+vCi+VwrVmm91Kpf+5q+kJsGBpBUgl4Y+pQeVKBUvB/nP9X+jRkyQTr/51qldje8n5czhVBM3Wz4uHwfaO2GrIBxy8OQZuLjN3RBFb3emPaNvWlUKILRfOtRvPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=MHEVBTF9; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7a1603a098eso896337b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 11:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760552044; x=1761156844; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9H2LPWU9+l2k2EeL07qQml9rdpRAXigNCc3vd68LC0=;
        b=MHEVBTF9STO/GNVSxCK0nA02PIU01qRQ4JK8OvrVRABocMgICDMts2BJ0lRLWuQuNl
         6eSNbOkm1WsurkfusnlyzxCE/C3rHEDyIlGumuzD0arNW+VRkvjbz5XM+4/VdV6M2OA4
         RmhWyDugLOpEwn9nfYOXj4VpXHd8RrAgyeTDyJTOwdt8h0V7jvbeJFCg+ZxWwuMfYMFd
         fG/v13wfHa0wcDo4FFiuzlMA6d3sgxBbhcXVFqnZFMFi71skuti5hcY17pugbykEtcvb
         76mcMcGjuOSi75o+bX9TPKEQNx6gJWVCx0aQb+hy7CG2dQSWQPvfQVKpds0RRR2lIfoe
         9fRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760552044; x=1761156844;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9H2LPWU9+l2k2EeL07qQml9rdpRAXigNCc3vd68LC0=;
        b=MOubCfj7Yct9KrgAWlEjqTqEdyiq0PCnCGW9e63suKc7X48AIAEW7vkpnkx9mtywf4
         JnqzgMRO7zse4vwlWotvcBJTw+3HsldorUgEDeREb8LBlG/lOVu3L593SDdu7nE88szD
         Jxa9f9xSnjxKBWesqiy8qYLqhtrL+BgNUOS4XJXkIKt7owZEiykRwrUem/rWoYPtkZBG
         N9zdIUu6YcGNmhwuw3n/bItuw8QURrbURvPX9qOodvZ7KNJLYQL2elJGcTUwu8LVfVe5
         qkMEm2Kj54A6NdqG6oMvr5PKbqoQdxKQClhFKFpWJAB1g0VhRvQMz8Zm0HqgWiPXLcC6
         qnvg==
X-Forwarded-Encrypted: i=1; AJvYcCXN76gN41Z66lKnZJuY9wkffUKy1h1+ibxotiTkahDBtPVCgkwg3hvv6Wx08d803YPk/Wv2wj6XPu6iZMXbcLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvWFUzfRPn90Yri/W5sP116zA4g204Ijt5nRGN34RZTgyK3Zpg
	UrIEro7mtA7/hbVOAoW0yW7ZpawxwLziTTXuZWxYU0fLHBYYUjg3854dpR1T1XYtBK0=
X-Gm-Gg: ASbGncuzqZCuBCD8EgVt6v14f75wpnGgSr2w19BNGDRlRuQkv/dLQ122S+b3jV/yc7Q
	q39EUp0Ypmg/zCOyF9vESYI9svdrxqjajMta4Pjo4TjTqZoESKV8gerLet3Q2AfgqzBxwKR1FuP
	PjKHJiDc1XQCyeiDwIOHEP9Z/5Jymg1/go01r90K/gWht/41BJlWZm1ccXVTAl4ayHaTTIl6c27
	MNgTaEkh3vofffi9M3+x0J9Br9Amgqoel2YOQ3GzRUVQKG+QepeSqZ1w/b27qyuUvpi6JWcSiOn
	zZX6BBVHIvPKWW2X5ev77/xp16FTTVQ9unWQYjo5jjQkqOEsh9QuKFWgeq8TuKtX9rk7mgwnqes
	uEsTlEX2VTKNsLjqsEjndCXXG5yEjvazcgGqBPG5MSj/qR0SOtsQmyQKchCZSYw==
X-Google-Smtp-Source: AGHT+IHetZQQxpaUW6Ligrelt0t3SG9P3lR8csbC0fN5hsFXEFcboGQK7fC7f7E0BUqjK+kKMsFmwA==
X-Received: by 2002:a17:902:e806:b0:261:6d61:f28d with SMTP id d9443c01a7336-290273ffe94mr346464585ad.50.1760552043546;
        Wed, 15 Oct 2025 11:14:03 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909930a72esm3126625ad.21.2025.10.15.11.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 11:14:03 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 15 Oct 2025 11:13:41 -0700
Subject: [PATCH v21 09/28] riscv/mm: write protect and shadow stack
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-v5_user_cfi_series-v21-9-6a07856e90e7@rivosinc.com>
References: <20251015-v5_user_cfi_series-v21-0-6a07856e90e7@rivosinc.com>
In-Reply-To: <20251015-v5_user_cfi_series-v21-0-6a07856e90e7@rivosinc.com>
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

`fork` implements copy on write (COW) by making pages readonly in child
and parent both.

ptep_set_wrprotect and pte_wrprotect clears _PAGE_WRITE in PTE.
Assumption is that page is readable and on fault copy on write happens.

To implement COW on shadow stack pages, clearing up W bit makes them XWR =
000. This will result in wrong PTE setting which says no perms but V=1 and
PFN field pointing to final page. Instead desired behavior is to turn it
into a readable page, take an access (load/store) fault on sspush/sspop
(shadow stack) and then perform COW on such pages. This way regular reads
would still be allowed and not lead to COW maintaining current behavior
of COW on non-shadow stack but writeable memory.

On the other hand it doesn't interfere with existing COW for read-write
memory. Assumption is always that _PAGE_READ must have been set and thus
setting _PAGE_READ is harmless.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index b03e8f85221f..df4a04b64944 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -415,7 +415,7 @@ static inline int pte_special(pte_t pte)
 
 static inline pte_t pte_wrprotect(pte_t pte)
 {
-	return __pte(pte_val(pte) & ~(_PAGE_WRITE));
+	return __pte((pte_val(pte) & ~(_PAGE_WRITE)) | (_PAGE_READ));
 }
 
 /* static inline pte_t pte_mkread(pte_t pte) */
@@ -611,7 +611,15 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 static inline void ptep_set_wrprotect(struct mm_struct *mm,
 				      unsigned long address, pte_t *ptep)
 {
-	atomic_long_and(~(unsigned long)_PAGE_WRITE, (atomic_long_t *)ptep);
+	pte_t read_pte = READ_ONCE(*ptep);
+	/*
+	 * ptep_set_wrprotect can be called for shadow stack ranges too.
+	 * shadow stack memory is XWR = 010 and thus clearing _PAGE_WRITE will lead to
+	 * encoding 000b which is wrong encoding with V = 1. This should lead to page fault
+	 * but we dont want this wrong configuration to be set in page tables.
+	 */
+	atomic_long_set((atomic_long_t *)ptep,
+			((pte_val(read_pte) & ~(unsigned long)_PAGE_WRITE) | _PAGE_READ));
 }
 
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH

-- 
2.43.0


