Return-Path: <linux-kselftest+bounces-32246-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E891AA7CE8
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 May 2025 01:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DDF917B825
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 23:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F1F26138F;
	Fri,  2 May 2025 23:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Zphha/uM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C29025C834
	for <linux-kselftest@vger.kernel.org>; Fri,  2 May 2025 23:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746228670; cv=none; b=CjWxJzjtTBnAmiTAcpJ7lwD9LvHPtF8vgmUL/FxRylSAsqgZGU8h2cEkp+hqQfUw8W6+pBYNzt0LygWJ315iQdop8bSbe1MP+JfHTbbUNJUU5dQ8c16EJA6n6FHbTNHYKqTo9FgVu8XFhwk0wfd4GW+oqCbjjn69T3LSz0c7OSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746228670; c=relaxed/simple;
	bh=6epe1IklbdE30nYdZrV0ZHwki5ITawyBnbVBknH019E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e7UhXT/h/G3d3d4pNF8lmZMziESHIuRmg5NowJl9N/xcuL992+8jN6PSHBeLpoEVHvZE3dxJ6lzveM/Z8VT4SB7jwIsbZeBZiam3//YTp37G6zdfEvGBhiIFnG02xgWEqW5g/31X5IeqX/4N1HJtyWBtrnylv/so0U9fbJwfaSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Zphha/uM; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22e09f57ed4so23269595ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 02 May 2025 16:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1746228668; x=1746833468; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DsODLDfRcPuDSErfbs+tzfaJx/MFrIF5cCrvvQql1Yk=;
        b=Zphha/uMIRhQPRQ4ql3LiGwbU/uvDQ7z/ngghob5oZkCM2PtHdK9ImkrIwfqf6rsh2
         ZftyhpBfqr2WoIfJx66zUaiGlWfYJoZesDdZjejoO9f/B5LvHvdIZJpb05fpvPboSe8o
         5ypO3bziq1jQoPX4jix8TdbnJB1W4tbFDcej33PXt4bud0sERXNU72HfSeboiVJW8xGx
         zTpyqXS0hwFOhmp43dgeKBIjZmdbdKm+4y791k1TmXX3xQFhPK8vuR1EM9xyJSC9hSuj
         CbMrpsJ1AnHFwOhaeVv2PZrrkLUXKiZjTV3JMMP6N22zXTyJNKHH6U2ZqAzeBikF9wII
         T7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746228668; x=1746833468;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DsODLDfRcPuDSErfbs+tzfaJx/MFrIF5cCrvvQql1Yk=;
        b=R+b0CmFXHmMUrR38p7zVvuTrIfWHapd/9WE55mZNzJ7UzZQkpAfH6XmNjMJRNc2Ftr
         27XFR4AjdfuTISeXRe+vEehk0LQXcCzRsUhDYDgMN64AicLnXvZgDhYJkilZmnmRcxpC
         PIgAm/1Xb4TkNBLbj47vwlE686s1B2SiWNkpSZUVTQf1WNEClP+G3Q5Hw8O2Qsnely4V
         WS4zFZ/ZzyBvPGZlXVQunsdaufLm6tu0X4eAaAHM9hVtOVLoqWVi+xXz6i8b9RWWS8pk
         V58aB2ikbNVqocB7I9PqhdRV2xzKbuEZz3kgCy5FVHmZhhjd6ijZR7wVadzNwNDck7kq
         uXNA==
X-Forwarded-Encrypted: i=1; AJvYcCV3Qn7Zb04Q7U/TanpJ2rtYAmf0BcmVHLb702OHQRN4QUIVZdLunsgfP0U6a3govR0kojVti0tcpIIozn9rwUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxETHwkYIA5QNSFhwqBQwUK5ZFgbw4cxKOjFfWbTCdXoZCyAcYT
	+9lU6rMrAQDJiPCg3MqX2SXH/t784/yRox8UyD2Xnl7ksqhC3/ikzxah2A2d+nQ=
X-Gm-Gg: ASbGncvJvPEqEkWXpMp/nfLT6qNrZk2pcfTnxK72tt0Ih+9supvKzZYLpEhCy+zig+L
	dOuAslEQmUonx3CFAa9rtsrFGwgpdntnnU2CzwoL0YikwBYgblMiihXktx46mJ7vMH+F2nHt/SZ
	0C3VDgO3D4SzfXb6kAOhRr1HqZvAMIURxN7avXeQwV72pHZDqhOfEC21shpsY1q3Qbo+MRbg6YL
	uUfKPnKzu7IoSwaE/bKvIu2AGaOUWcRltgo4EX0FFS/3kvnM3552v5chJ+5AjZheuK5/GiWg+4s
	giIMzGbvXsUhnQvKparWvKEpWexDx6usd2cwuCmNQ096IL4/LBk=
X-Google-Smtp-Source: AGHT+IF1GBwtW4mRwkmgaeI/J2+u75DGUEWmcD8FxSbvnX/COnhKE4n3pTPfc6kL7c+4j6jd/EH9dQ==
X-Received: by 2002:a17:902:d4c3:b0:224:3994:8a8c with SMTP id d9443c01a7336-22e0842956cmr121545845ad.8.1746228667912;
        Fri, 02 May 2025 16:31:07 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15228ff2sm13367055ad.180.2025.05.02.16.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 16:31:07 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 02 May 2025 16:30:40 -0700
Subject: [PATCH v15 09/27] riscv mmu: write protect and shadow stack
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-v5_user_cfi_series-v15-9-914966471885@rivosinc.com>
References: <20250502-v5_user_cfi_series-v15-0-914966471885@rivosinc.com>
In-Reply-To: <20250502-v5_user_cfi_series-v15-0-914966471885@rivosinc.com>
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
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
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
index 60d4821627d2..4e3431ccf634 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -423,7 +423,7 @@ static inline int pte_devmap(pte_t pte)
 
 static inline pte_t pte_wrprotect(pte_t pte)
 {
-	return __pte(pte_val(pte) & ~(_PAGE_WRITE));
+	return __pte((pte_val(pte) & ~(_PAGE_WRITE)) | (_PAGE_READ));
 }
 
 /* static inline pte_t pte_mkread(pte_t pte) */
@@ -624,7 +624,15 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
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


