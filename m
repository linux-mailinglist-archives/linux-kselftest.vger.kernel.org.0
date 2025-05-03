Return-Path: <linux-kselftest+bounces-32245-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB586AA7CE3
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 May 2025 01:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D5421C03ED3
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 23:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8193325CC6F;
	Fri,  2 May 2025 23:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="pMP6Az6/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12EF25C825
	for <linux-kselftest@vger.kernel.org>; Fri,  2 May 2025 23:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746228667; cv=none; b=qfVSjMRWXcXF8Z9Pi1p5qSHwHfu37UxH44bHO8/PgCEREkKr6sDtnjJJVKT/r6h6HvjwzFLOf/w+8Mcj6qV/kEp2XashnblvsCj9z3deqiczVopXNQ5we9w9ywG8nZtC+7qc827Gqjq+ILCCkPk0v8C1nalKpKJlPTqZU2gFs0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746228667; c=relaxed/simple;
	bh=botWNQij/L5jZa9ComPdhZ+E/aGmcXy6ciNlZPypsCM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K6Fw4b+n0PeDw3Dv8OZZ20UiyVj+9EaDqfjsHiMWdZ8HqoXBiwbv/4z9OF93FPdCPAQtLIyHPE/khYPC4oZBjYh0SXK7VXvwuosXi+TEhJ5kyZP8ccOnTbKLFbdngo5hnJOsojMvTIhPjp/x33jFOQlXyiE/dT+AFlDib0ibG2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=pMP6Az6/; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22d95f0dda4so39570485ad.2
        for <linux-kselftest@vger.kernel.org>; Fri, 02 May 2025 16:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1746228665; x=1746833465; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RIAdpVF04Dq2IgOKnxPyubvKXBbe4mWx866NZtbwafw=;
        b=pMP6Az6/4MFf2cA8Qax5dsyOf9D6zgYcZfvlzqOIv9ZCpURCDcNqssAL2SqF5eM0EE
         bZVosLpYogX1+8LqefpRbWUEbrq43FvcrT9zAkW009SXDVBbczYKTgtJJjbuCBaFVKqM
         EED2VxkCwCznJOIzKj3zfovy3n/+CF2k5GSJ7Zl/DRkqo8y7FIM4+cLVfjzven8LmivI
         Ymh+CMZAw8YYR3BAB+pqTeWQ/F/rIQ6/E0Vm9fjgMSohMWL27S4SE7BGlXTHzSOLfJQm
         RrBC3QC9Moc7mZZ+bWjOXwLz5r1zeYeL6JOsG0tBjFgtyNC0qnVsR5LyH3jSgBXqdLjU
         3bhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746228665; x=1746833465;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RIAdpVF04Dq2IgOKnxPyubvKXBbe4mWx866NZtbwafw=;
        b=Ig7aiEiVcCEzIpvMxjBYwv0BHbSj/6B33YSqTkpEsLJ/te2DfU5Q5qBfwkTXFc6nlw
         5RU+IzIlx5PmjnzTl/J/Li9k1bTjlceb2uKqtSaeL7iO+ChRFjK6GiA2IWkk8PZyID0E
         EeHVtTAMoTzfc2zc1P4HHxgUNbbwUyN9pM7gAy4J1s0wYbm8+dPV2cZi5PNHKfNTrDSp
         5M+0eDlGCYfwMOfyFMHjH7lcHZACYhTRvWgGD5hnp3x6qU4DEYni4uXBf3hnCbwSAW7X
         vkLzGkQUMUp6glreKkXDZ/bzUS+QkIqecbS3YHfvo3jjCJeF71O5NlmcbdZ4xv+f4X8D
         XUuA==
X-Forwarded-Encrypted: i=1; AJvYcCVRqhh0fjYIYLYYhVO+gYkWmyiSDDaPfylpsnscbVZs22XT5Yi+6T30Ft2a/FNx6DNbebzvbIjuWhN3KZMuOkg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9prdJRL6qyrYxu6pGwG3Nnp0ssJMHqzufxAGL7KAOs9A3t7Qp
	w8KwQCi6YqJjxqfiZHK3Twjqwf9yOyLEn9yHannaUI5yppWbgDAq2AvvvfhbcTM=
X-Gm-Gg: ASbGnctneo/grfRE0HAPaausnR8FvI7GR9NhGwqaaUi0XdLCcND5fVEemgD7EA6C4CB
	wtJrKGhH6+zRYslLjJkbeNwP69Awd8DrO1jLr7jSMdlU1vqwmv5yE55NPaOwT0hmXEBLa3tPOnf
	rCxnVu2UxPUkop/L8JObFQCkYOGuz+0n4d59BQ9Y6omaEEN13PirhEaeU86ZfKHAijt+k0ehQO8
	hqUHl9N1k91sgVnNh37j+GTyvTQf6R9QIdLXefENNKZqHRtZoqfynzYpQgDD1VNANgckj0Hl5Ng
	lg/REXUI6l13USG/df6pUKLVVhxXYDVgb/oEfDcgWtC6DEggEv0=
X-Google-Smtp-Source: AGHT+IGp2tIgqPIeVL1fUnVRzrlkiAjbLccoy07WU8cAzc9KMNqyou0HJrBg+LEQJwmT2E1+TS4a5w==
X-Received: by 2002:a17:903:41cf:b0:223:501c:7581 with SMTP id d9443c01a7336-22e18b99d5fmr14703165ad.16.1746228664986;
        Fri, 02 May 2025 16:31:04 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15228ff2sm13367055ad.180.2025.05.02.16.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 16:31:04 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 02 May 2025 16:30:39 -0700
Subject: [PATCH v15 08/27] riscv mmu: teach pte_mkwrite to manufacture
 shadow stack PTEs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-v5_user_cfi_series-v15-8-914966471885@rivosinc.com>
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
 arch/riscv/mm/pgtable.c          | 17 +++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index f21c888f59eb..60d4821627d2 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -428,6 +428,10 @@ static inline pte_t pte_wrprotect(pte_t pte)
 
 /* static inline pte_t pte_mkread(pte_t pte) */
 
+struct vm_area_struct;
+pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma);
+#define pte_mkwrite pte_mkwrite
+
 static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	return __pte(pte_val(pte) | _PAGE_WRITE);
@@ -778,6 +782,9 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
 	return pte_pmd(pte_mkyoung(pmd_pte(pmd)));
 }
 
+pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma);
+#define pmd_mkwrite pmd_mkwrite
+
 static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 {
 	return pte_pmd(pte_mkwrite_novma(pmd_pte(pmd)));
diff --git a/arch/riscv/mm/pgtable.c b/arch/riscv/mm/pgtable.c
index 4ae67324f992..be5d38546bb3 100644
--- a/arch/riscv/mm/pgtable.c
+++ b/arch/riscv/mm/pgtable.c
@@ -155,3 +155,20 @@ pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
 	return pmd;
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
+

-- 
2.43.0


