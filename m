Return-Path: <linux-kselftest+bounces-19281-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F4A995A80
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 00:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCB1FB24A4D
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 22:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1AB21E948;
	Tue,  8 Oct 2024 22:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="V0r+u9vn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F86321D2DD
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Oct 2024 22:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728427108; cv=none; b=SOywZJXdoQ1jhIWyt/suZ1J6f/LsG6ktsrsMbGV+kNlZYbuqJuUsPd/UwSjm4BsSExixoFYL0P8BHkegJLcy3CNUpdajpuS4+y4JzOlvTjGvOrn9N8gd8ANITLzgE1CtK+5y/Rbdl8AGzVbPSW882EuirjDmg9lfYpSr8zjGh70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728427108; c=relaxed/simple;
	bh=vaFWjXy2DRrsSIuTbWduvBr7Hy/qYsbzVGbusd1hcYE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dDyrzYQ8wmZA4cLIcNVVQvKhEcjK9uvwp6TzksfwZKFylhVPzlH9PQ2fIktX9Wvy34bdC9fnT4sUE3Q2z0VQD+WnsWWXzuXo80eEOiRW34o0UcqOaOm2JwjTknoq2lOEYLANj2Qd0RyhPgtt9bMVtVZF8Lx00v0Gq7SGztfjbMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=V0r+u9vn; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e03be0d92so1982040b3a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Oct 2024 15:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728427107; x=1729031907; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AMPZIqdzSjfHq7xJb4YaIgEu2GPeUmiCYK4jkAGMc38=;
        b=V0r+u9vn+VXksb2s2Ka2C9Ut/1IbFmzhyjXJ59qLbFA+2RCoVvAbwMvLYuVS03nv1I
         /skG13y1a6+x9e3bzKLsQpzJgTEASyzB494Eyj5vDQJ3nkOEjpAgB5PXYR2byMVrHYaB
         0ffixZ+XG6wVwAKMQVvZpMXUo1z5bu8SnyyCkwGjtDSx/B4U+++iS/go4C2IAhG+//7T
         afztVwuGdmSBKn/4aT6dkBLMvSiooymQjMXzr3xqYA6gY1kwt8+rABwzfoXoJEN7kFjV
         ZQpWTi1X8wLzVW4nilktb4knNlhkERqLBJloyJLN0yRM/YprAztoIKISdy+kRhOpnY4o
         9NdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728427107; x=1729031907;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AMPZIqdzSjfHq7xJb4YaIgEu2GPeUmiCYK4jkAGMc38=;
        b=nn5FJFZ6hEBfs9oVG7mlZKU1YgWMzpNMfL8/NPxf1GZ6ws/LynGnNL5g0Z0/2jtZBZ
         B3FoDL5/P7jojXC2bdxomz2SpKdbTl9HjuW/cNm9Y8/RIL3atDuSPZ3gJ4/N2vUS2aQk
         9oeDa1CIqvwH8eqpnirygm/aWVmuIn7rc21g3Piure6uDRvnYBw2HrggFdIYuQtC3Jcc
         ggpNAYdqiGKmh9uP9u8VMdYwfRn0JZVYxyykMLchuO/lBCWwc+OcQzdrUm3gTJmtiRbS
         2mgzZJhD72xsbinLBoQD4u+QHO+EvvktSm7iNilKiUZDkeFnh71B2thjXhOfNPss3foL
         cRwA==
X-Forwarded-Encrypted: i=1; AJvYcCV3V0un35aunFuJq22HEkUH/YFBx2/dAAoWtu4QtN9aAVryeHkHeyawR9v5QjjN4SxRLAn4b6EjtalY4MOt3DI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8eR2zfOXQhmYUgDtCgiyBM+MVX53LBN7OjiG301mxzKwTceB5
	EWXjn0so+M1QFlSVSCE4xSiEJlSM8EelIn9R82Gexu6K2uiTPog0B8jUgpJbW0A=
X-Google-Smtp-Source: AGHT+IHWWiD7Qfl6QcTOp/Fh8ZvI7bj5RBVwxNM0ruqC/BqZklsNYndBJ5uZwxRV/4BsJaJcvUdg6w==
X-Received: by 2002:a05:6a21:3983:b0:1cf:23cb:b927 with SMTP id adf61e73a8af0-1d8a3c5656dmr945264637.34.1728427106662;
        Tue, 08 Oct 2024 15:38:26 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0ccc4b2sm6591270b3a.45.2024.10.08.15.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 15:38:26 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 08 Oct 2024 15:36:56 -0700
Subject: [PATCH v6 14/33] riscv mmu: write protect and shadow stack
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-v5_user_cfi_series-v6-14-60d9fe073f37@rivosinc.com>
References: <20241008-v5_user_cfi_series-v6-0-60d9fe073f37@rivosinc.com>
In-Reply-To: <20241008-v5_user_cfi_series-v6-0-60d9fe073f37@rivosinc.com>
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
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

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

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 7963ab11d924..fdab7d74437d 100644
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
2.45.0


