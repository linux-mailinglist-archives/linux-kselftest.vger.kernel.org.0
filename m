Return-Path: <linux-kselftest+bounces-31498-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 946D9A9A368
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 09:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 289723B57E8
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 07:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C81213E6A;
	Thu, 24 Apr 2025 07:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="YGVDRZVQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1631E210F5A
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 07:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745479253; cv=none; b=oVVsRtgo/GcKA1JbAOO0LODj4owJsvDcAKj3qjqwE17ojEvlkjxpT2SGIhtkb++TepHtdYNm0PCopbJAE3kOiiOTgDnYWOT3iNWzsrk1VL/V5nhIImnA8qO2FvkipIAdaqfKdza7GNZcnKBcEIxCrR5+sg0wwMzJvMtx/xBGJNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745479253; c=relaxed/simple;
	bh=FW8GeCdpKjhiQGoUH1Vsi3yr9tKTmZ40wUaaIGh3HzM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FShdVOIZEUSvQH4ZSordhTNiVm4fmqjak5NWUAIKKBHIzZJa7kCGikj/XQgF9IMNQcYtLvgc1xkB8Lnpnwpyynm+oQuUsUT0XQRTdh9eHiI4IHwQl2XPdUJKyQyrK++2zYIZ69vXcy8E6uCwqG1lZvMIx2aO0IYAbDMoPkFTnbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=YGVDRZVQ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-303a66af07eso521927a91.2
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 00:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745479251; x=1746084051; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cqVNpqVNQNTLFKUUNkD9dMF3R05rxCs4UwxRmqJQ/M0=;
        b=YGVDRZVQhxmOay7dapVSzPbGrFyssQh0ZcBDL09zD8YfQnbxDKUdMCA32IQL87VbTX
         okDLJ0rRtvPR8Htgg19xvcA/vJ1vvD07laXvo7Jk4E9gI/ueYx5H9E0TDBy+oe5Sir+i
         9mbjeNdhzkkWjfMZ9y/gOVE627qqHOR53d0SssHSfDohuxIdzUPBB/t/9t+DL1z79FEp
         6AsyoYzPg0dyXrvutoF4WLxvaXo1d01nWkCcLX4CRssWfB3j75OTQhJRyPzHg2opsWtG
         TNhcw1sdl2X/n7YxgCY25WV6mphF+PTCaHTJg3ruLGS0o55BpbDN2JIUVVkZHhm4B1K6
         jI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745479251; x=1746084051;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqVNpqVNQNTLFKUUNkD9dMF3R05rxCs4UwxRmqJQ/M0=;
        b=mq55TLfgb9ggqaaI+vilD6UVhd/LCgluaT7uvK5SBMjDe89vA9jm4zSWGetkxb7E1z
         1oMZAQeN6QUTsxBxa/dfeeBBuTo7qB9YsYO2sWtI4dMgx6VBiCYDrGtLZZWSXwVWwe2v
         n5lY00FmEznD4lX7XSI3GQ4vB0IOVo/uf72vAv6G39auzW+AEu6VEB9SWYmOy1S6J5Zj
         L6af0a1FAhQskc6efMOugOeO3X2u/wInYZmSioyAET+wyq2icrIb8r2vMMWcwzOpn9Bg
         Moe4yfjPSgrjTH0S2xNzsgJ/wt/tC+BG1a4IzSch3CFMtSZbE3FNto/Q6yFE3IJR8no6
         F07w==
X-Forwarded-Encrypted: i=1; AJvYcCW2J/fHnxu3jXgco0/CnbMHDN05yhivwFqSsxXZBAcuMHv4wX6H/2aTRTU+qVenYzF8PZk/RXSRHpYjmtjuJt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIt2UEvRWd8JArn/CJ4MjRmlqAM5tv3YxTHAiEf7ySo5a5+iuU
	hsQ+QQdrALvQKhgIJBiqFiRkJc52P7Q8c0d12dUv8kxzDRqkceF05F83AVKbLTc=
X-Gm-Gg: ASbGncsunzfx5WTMoo381WNcHCbQs+Km8lNMW9W0Na6tX5IwVr5Zg2HSSdGRCwpc881
	Qk5YKhPJxEnKbG6AQT6yS5NPzejpiboQ/KythDOy4XRKzzjcyRvzUg9YGGFr14TYRZFq5QXkdm5
	OxBI5pt+4nG4TeHRhzR4vKsCxel6qkz2kmChLOQPUPJi/U0cMrUFtCCr1F0Tc5O4DJkJ3AkW0XK
	08IDoaCR2sBgUEwbaKGJuCZUtxM12DVKTfLvjt9Wepq5l7wlxwG2U4lEHpbiNoO6ny0Gt0B8q2R
	4HEuAJI9gXnNdUMdcJV2kXKNK22R/6Gvp3sNBzysUF2LOhqSbT8=
X-Google-Smtp-Source: AGHT+IGm94vNuDChfGpZY3JHg1iPxVQedsgs4wr0HwINk6/v6WQ8Ed+8gNEGNYrHrhw2GdIZutJrJA==
X-Received: by 2002:a17:90b:2b87:b0:2ee:b4bf:2d06 with SMTP id 98e67ed59e1d1-309ed2a3f00mr2155371a91.19.1745479251179;
        Thu, 24 Apr 2025 00:20:51 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db52163d6sm6240765ad.214.2025.04.24.00.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 00:20:50 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 24 Apr 2025 00:20:24 -0700
Subject: [PATCH v13 09/28] riscv mmu: write protect and shadow stack
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-v5_user_cfi_series-v13-9-971437de586a@rivosinc.com>
References: <20250424-v5_user_cfi_series-v13-0-971437de586a@rivosinc.com>
In-Reply-To: <20250424-v5_user_cfi_series-v13-0-971437de586a@rivosinc.com>
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
index ccd2fa34afb8..54707686f042 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -411,7 +411,7 @@ static inline int pte_devmap(pte_t pte)
 
 static inline pte_t pte_wrprotect(pte_t pte)
 {
-	return __pte(pte_val(pte) & ~(_PAGE_WRITE));
+	return __pte((pte_val(pte) & ~(_PAGE_WRITE)) | (_PAGE_READ));
 }
 
 /* static inline pte_t pte_mkread(pte_t pte) */
@@ -612,7 +612,15 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
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


