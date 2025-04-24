Return-Path: <linux-kselftest+bounces-31496-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCED3A9A359
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 09:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11B4A448818
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 07:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D9B207DFF;
	Thu, 24 Apr 2025 07:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hC0kaWUU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413BC206F2A
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 07:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745479246; cv=none; b=QgLy/qTvfoI7NWPcWec6I8t0qKPj9K4IkOj2KSIGfV4KdlVnWnz/mSi4HPPMaawrUxhuEuCBTdhSWhanI7OGJkHTDVcqXIu3E7RYPiui+NrVBWAZqRl5Q7CdeClzLSWodZmU3l4W/cLBCOyEfxcD8gaE5inhL8eF7pHEHRvR4MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745479246; c=relaxed/simple;
	bh=R7oEwbD3/y5k7o3aqwxIBGjnZGUlgVxW90n9VyI9wfs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t8YVa3WZA5g4MRNJgRtshd47oE/A840NRdhV3CZfpRgfRabN45CZ1dI+jqZyjBm5ng76XNWoDLtQh7Z3HS9kgtXP+B9x7DSNynsBLzb4+MGhU7FkeJcaJgAYIdERX1e+jbW8auE/SqrY44J0bw9TdnTvuYgXfH5Q6CGMNZNr6Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hC0kaWUU; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7fd581c2bf4so527193a12.3
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 00:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745479244; x=1746084044; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qwh9x6lD2MO9lJ//kvPDhOJNTq6ZrmIfW44uUh8vro0=;
        b=hC0kaWUUvw8UhWRSNIv3VogUZl5cUyWKZmn6QViXD2eyqwp4Ov5EEJHafUNWpcedgQ
         bOPoxvR07fIIgDTC7B+pi8+EuSx2ZeioOjg/6N7XZ4hX3qO5MgIA/5zZzONP1LzjxtBz
         zIKnwNx4kPgpDLM19/uy14ebsFN4Fu6h3BV68Zns6GSZwQP9Dboz3fuJ/EBwcO5SAsme
         5ijwjAzBdb5fjt7uVw4XqZd4RrQbiWs6FwHOn2w2eylm1WZXQPpahAQIFD/5JcZ6EEEy
         RP1DmzM5dRhopw2j6ZjPw+yhQJINjT9e3GG9nDHDrBAhLcxQ2Sp3ZLNk0glcB9qCX02X
         icGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745479244; x=1746084044;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwh9x6lD2MO9lJ//kvPDhOJNTq6ZrmIfW44uUh8vro0=;
        b=JyrxT3gLzx4scQIAJDFdcXsodNAOU80OiMUD8L5jt6CRdPzxLXh9SqE/6vrelXkRGK
         RU4jz7at9bKofk9tzCz+vSM1CUqVk2XYv9bTTrs4YM9GMbr3hpIj6quIe6jA8bliS1KS
         2teaJlf66jDEQTuyxZPgyL7OpkC5S/0UEi5WWOiQpvLXLiIdg26BwHD5jO4H5LQNZxrN
         m5XLxFvkhVZyz6FE7FSvfQ+w393eqzKR2T7xcr6/fSUz5EPl37VrIVXJFyBzLx8VMjBD
         kvluWDxiimw5wCQiZ6Jq9JNngKvdFis/PDq8nhFfACFeEp3rg5z2FiYU+cfYf/r4EmrB
         ukQw==
X-Forwarded-Encrypted: i=1; AJvYcCVdFgc3gX+opAgxH2a+rif5YADrbx+g+qnIlQ+EcjD/Ezk7eQhSducJt6y4610BldJokLbqfrGDaADpKCgOOWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdSx3LPDArGD/vDTl8m3uIZbB+baCHxNxCJbikUPc1Z8fCRGt+
	hZHOFSvhK5G7Q0P8lQCBnyIeBmJwWoVUj3LUcLMuuYgeBlLhyb/TdDijfDGhtvQ=
X-Gm-Gg: ASbGncvKAnf3jNtJ+cDjSULbRIpFqNN0/Hh5nnuU/zIlyasu9ryVh2kehcrmRRDD0Xd
	i2977CKrlS1gSWp5Qv0PGiKAmMl3iHIa0m7KqJLpcGOUxOyx5L10NIf5JkEmwzNio94fIwGRkvf
	FeV6AsCqiAJAO4Re67sKvu7AD0PEkzk2NN5YBA/y55E9YIQ7Hsix5nJ3fF+fSyUqMXLWkOfXN/U
	JSAYnKHhGkU/W/mu3GyvZfU3A9Nj4cJzSHpohRKf56qG2z7KavWOEukXiPbMFBcXq/kCEsDmtn1
	g8QUJ9ZNmY35zZvwLJQit1jZjhNfuZPg9Q29en9DMN0+6tINIx4=
X-Google-Smtp-Source: AGHT+IEC5A9t3KljY5+oPEDMiuLjjOrgYWWUXALnuXXsSvtsWmrcbar9Dh97NMWpjDuX0nmNsvCGcA==
X-Received: by 2002:a17:90b:6c3:b0:2f9:c144:9d13 with SMTP id 98e67ed59e1d1-309ed31aeeemr2671578a91.24.1745479244474;
        Thu, 24 Apr 2025 00:20:44 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db52163d6sm6240765ad.214.2025.04.24.00.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 00:20:44 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 24 Apr 2025 00:20:22 -0700
Subject: [PATCH v13 07/28] riscv mm: manufacture shadow stack pte
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-v5_user_cfi_series-v13-7-971437de586a@rivosinc.com>
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

This patch implements creating shadow stack pte (on riscv). Creating
shadow stack PTE on riscv means that clearing RWX and then setting W=1.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 8c528cd7347a..ede43185ffdf 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -421,6 +421,11 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_WRITE);
 }
 
+static inline pte_t pte_mkwrite_shstk(pte_t pte)
+{
+	return __pte((pte_val(pte) & ~(_PAGE_LEAF)) | _PAGE_WRITE);
+}
+
 /* static inline pte_t pte_mkexec(pte_t pte) */
 
 static inline pte_t pte_mkdirty(pte_t pte)
@@ -749,6 +754,11 @@ static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 	return pte_pmd(pte_mkwrite_novma(pmd_pte(pmd)));
 }
 
+static inline pmd_t pmd_mkwrite_shstk(pmd_t pte)
+{
+	return __pmd((pmd_val(pte) & ~(_PAGE_LEAF)) | _PAGE_WRITE);
+}
+
 static inline pmd_t pmd_wrprotect(pmd_t pmd)
 {
 	return pte_pmd(pte_wrprotect(pmd_pte(pmd)));

-- 
2.43.0


