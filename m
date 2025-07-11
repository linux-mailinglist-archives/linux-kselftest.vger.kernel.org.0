Return-Path: <linux-kselftest+bounces-37152-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FC5B024FC
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 21:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C997A804B9
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 19:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AB32F5486;
	Fri, 11 Jul 2025 19:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ubSJ9l5D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327182F5476
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Jul 2025 19:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752263203; cv=none; b=OiiTQnufrkvulCLgSs1waB/5fiuiAWgw5ozDQzLiB+xhmcOn9y0lHLz813meNS2LVcfxJQXb3TA6cMk+qA7zG7JSFPnLFnGdi6x5+tprkKFgNKE+OJMQMswp9hu5qnygclXmuhdnSs3YsUeeqvh5ka59quKVyIFOCNkJYUqz/Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752263203; c=relaxed/simple;
	bh=WL15EkC9r/moKkRq13zdFyUaooKGHVsvH33BXrA8W6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CBQJXyPJCufFGNKZXlNmN3GEjDxDJSEJe3gTXHAX66rh1QUKu/YlYKJGZKYOm8ZCgOYvHMmgVFurwJH4DX+8XJuuE1woezpHthQX2g+l9VuCMcZmr5bTRHOEN5YCquRejuEIMv01q/kQda8ygIpnRKJx++ZRZAnTVo5Xxr0GAn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ubSJ9l5D; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so2409530b3a.0
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Jul 2025 12:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1752263202; x=1752868002; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YcQNf+l7CrEDLiT/8fKsbXFpHxmlSwLjUqKyq0Di2lQ=;
        b=ubSJ9l5DrLY6bS7wgMThOI0kFFQC2NAhNlPx5u0JkVNLh7GuCLv9DxXK1G0eUFaAJu
         A2hzdx+04XVm6qDC00xTFkpRVYX0d0N2g4l6Hf5XU021D/+2DVpoVMAGvwhVBmB0zzZA
         FjkEBVP2C8sNudRf1N91sQb311lt5wHpNPFq3LQ/VwJ7SwBhw/aiYF6fRN0ZbqPBjlHn
         6NlC6mkGRFEZlu3NydpnVQF67LDRufaa3iNKHaNNRtbuXdnH/waidI+c1myVPwvUot6g
         sgJULzCIgp8j42Le3DzMuw0f+KBLarDj0hZv6zw8fAZW9daD2DHJSjt0m7JQoutSkqCi
         MhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752263202; x=1752868002;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YcQNf+l7CrEDLiT/8fKsbXFpHxmlSwLjUqKyq0Di2lQ=;
        b=LdqN+0HQydp9akHmvHK3o+zLEzFSbv5ejqorY+fDjZ4hTOPCNkbVlYUx7AlRbAohuM
         tAmOR4Q26+YgDntYXqW4P7fu962rEct6JLictrEV9Kr+0Faa7EUTvIXkMQy8IduePahQ
         7T/BWWD2dkBM6pdoBwKpJpm1WMTIlJa9cxci7H2lw+obwTnygsPx12KFdKKrmzsIX+5j
         YH7G711mKpBNtZ89HGRPrA8iTUN+2Try8VLUYykIIHbS/4WNuWeS7vRTYvA1dAPqX0zK
         OZiNp+pApyWIQUrZ5BTRn9Eb/sVdXLwBPd5ACHp6PGJIe9x0OH5JUrL+vbvC4OmNYEj+
         49SQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOmtqHkD+pXpebh8SXftK+c9MBHQD5VALfhtfuuxDLl/0NHCrd/acpJC1uJHayWPug8FAvQOEj7aCqnHw5zRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPX8JMTserPS+M/JGhSb6PCDqmFwriT+654FNKWeuG+uWcO3mW
	DVxKWFFqNXFQrO5SSSE7ZWD12Bf4+7Vt56YkXLK/tp/ZmvU6r0bieI1ExKEsfFNOUjA=
X-Gm-Gg: ASbGncuNQCZwWaespKnW724O8HaDc8ieJtRj24cZ2L1Bs2soQCERnE2aQ69DRKld4Il
	ZWg8RKVyg4tVP57KExSU/ZVo2IHli84JpFY5+4GPkqSc1h9douOOfW2YBlA0RgLtkNbmdVdyFcq
	b+LSFXHPjVhsgNEdWDSYjaW7juTJZueVCX7OI8GL/OMNTxLl9WuO9IpfvLY67jSfzZ468gPhyjD
	q8YB/Fh17Xu/ydBS3ogywXlaZcb4gtpeNUGcfNeYeyA9ea2MgXDMbrR432v0eBC+DTL4ZVrpM+4
	V4Jf8mAqaMq9eZ4Yj2FP0I7JjbPyBbppXS+0pZk2Ph87k3ica7Ou9gP4Vqn30MPVRoP1uXozB8Z
	nQNx4kv1xAvrNZLAIvAJEFBEdqeAJzaF1tTFB0hZlD8U=
X-Google-Smtp-Source: AGHT+IHmAcSPrxefr82+UMf9/ikIX93mr+C5rgW4YF0B8S3scOQC4UOExmIhVVKYEXcNj15bTCN85Q==
X-Received: by 2002:a05:6a20:244a:b0:224:654a:4461 with SMTP id adf61e73a8af0-23120f1563fmr7370528637.41.1752263201611;
        Fri, 11 Jul 2025 12:46:41 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e06995sm5840977b3a.38.2025.07.11.12.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 12:46:41 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 11 Jul 2025 12:46:14 -0700
Subject: [PATCH v18 09/27] riscv/mm: write protect and shadow stack
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-v5_user_cfi_series-v18-9-a8ee62f9f38e@rivosinc.com>
References: <20250711-v5_user_cfi_series-v18-0-a8ee62f9f38e@rivosinc.com>
In-Reply-To: <20250711-v5_user_cfi_series-v18-0-a8ee62f9f38e@rivosinc.com>
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
index 2b14c4c08607..f04f3da881c9 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -421,7 +421,7 @@ static inline int pte_devmap(pte_t pte)
 
 static inline pte_t pte_wrprotect(pte_t pte)
 {
-	return __pte(pte_val(pte) & ~(_PAGE_WRITE));
+	return __pte((pte_val(pte) & ~(_PAGE_WRITE)) | (_PAGE_READ));
 }
 
 /* static inline pte_t pte_mkread(pte_t pte) */
@@ -622,7 +622,15 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
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


