Return-Path: <linux-kselftest+bounces-34309-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3598EACE307
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 19:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ACB23A89CC
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 17:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46267213E83;
	Wed,  4 Jun 2025 17:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="AFkwo8kR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07342101BD
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Jun 2025 17:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749057398; cv=none; b=uBId0j5G98heYn9KETVx1C+QwBpLzP8lrOOWl+sVulQSgoS01ZdUYLdeK6UzsX7+Otnvm9ZXptPplz/+2Ki2jde1WP0JnM/HmPrWFJko+3hjD6XGrC2AlpvHXZ4eC9JPLYUP6M8y5/gLFh4y7taERW5EpZoahRl/uoPbpcPvbFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749057398; c=relaxed/simple;
	bh=5l4eYXK/UGIl+TXQnZwANU66ClnBTNssKdiHYV/yMZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vwu9vA+a1Iilr+sroJuDtB/HawoFk89mYSDkfi8lovY5d5jVck+aFn5gHwU/ij6oeDrCGWXB4fD62YCMeJj661Ix0EyXVxyBKVp7gyP/WOv/95JOk8o7XUcOx95Xruv8PxRAPxtLybNEWFHy/xThtvEOfyIGuBl1j9otJd2ScWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=AFkwo8kR; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b1fd59851baso26239a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Jun 2025 10:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1749057395; x=1749662195; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2tvKQDIIBJb26wPDVIJoD2xzubcY8uay1NjKLxC4PFw=;
        b=AFkwo8kRJMjud/rwko8n6NMqRVUEg5eXTYwB2mg8Sz38y1yTr6IMjHYWq7SBPzafXw
         9L4Y16FkzdBoBjQBMj0hUBCii6H73b8EmumPhqYXqRmqumJNeHQbYRLGesVMoj/+/3pO
         nw29qRumIb4h265dL1GE7Br6Seh1mfp80kLWtYdSXCGtp55Z3wmkmwzuos3JIk1UKxmf
         9T4LubxFNgMUyPBdmEL5zxLpYCCPOfVbirRBFV8uo4BweAsfYynFa8GF2xu32NZw5jIh
         zl1hitW5Z7vyEoGZOpfdcw3z2dw6fMbUdBGJldbL9Hg263zyU7iLQWUqh2D4Nu+d6bWZ
         LfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749057395; x=1749662195;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tvKQDIIBJb26wPDVIJoD2xzubcY8uay1NjKLxC4PFw=;
        b=BjQmwieJW9VY4Z1k6OTCSaNLesNs1eAPGQnQjLNuMr/MeSxy6FtHv1xMd2C8l3wuqg
         3VBzGkmHKOIKj5KzrrfSa19sVjZkw2qPGOxzTtNPBcjFBjLFrwvG+EToLCii9DGXw1ms
         /u7E/0njrlu4JfVdCXVInZ182AwGA6ZZLiLh/I1qLEkimAN8nbzcQV329qbLAIqaEfn4
         3w/0mAz10pk7+Qs9ddwviiHcfT83wX6Wngl0bNdbZDRLIV7E/veaXhiJ1M7Pye79PJyU
         Dt+JqD9+lG3yn6o74Pq2OMcxzvoI58NIhHX8iONLWTHp0GOExkzJJ1AkICqIo6yWfQzr
         vlFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9J12U6eJWiGCgL58nxaWLiqhIUDObkkvo7laUjHQuscpTqCFGmF0k3HQpnJ8yO7mest7MqrXuEZRK3V86oZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAYQpCkYCQwii5LE7luuuz459tdd6I/Y0tZHN32+akCblbHx8i
	9hO9tzihrJ7CGN+KRbmm0litJokzZ5OibQDCVmobqqXjimpoh6PxfFgBYOxCQvAP0f0=
X-Gm-Gg: ASbGncuzD4gd6A/zPI84/IJwj3Q9anhxi/klspG1uP528pATH3DfSV0YnCA486BXD4h
	5qZeV/EnHnxBZ7xHihk0k0BN8wMMfgq+v1srgJMekrJj/koXOiQc6Y4VOwzQDZOJfQ652A/5Dds
	ZwY/QSgVsLrZFMJN1B+9si0tkBdqSeRcWpl5bPV/VvwP1/n7XlMCPx8Y05QGrTK4GEdGGBiG39y
	D+NDRDRuwZnapmIO4870IqsUAxPT6G4JeznO4mgemAeuf/Q2CQlKfLEBWSPoZBYKtIClL6esqMn
	8F9jlTieVlgNX7uzq5jF2djfszksDxMVh00olJ0weUqcI8T07SvsPU6fIU0h4d57OdKh/MgA
X-Google-Smtp-Source: AGHT+IG+Qv2DNy5GUYLSr8qaMd4z1JKIMYQvC0rcwVPQ/+dBpmSSBbz8jQQs3wb6D/V0cK/kK11nfA==
X-Received: by 2002:a17:90b:54cf:b0:311:c5d9:2c79 with SMTP id 98e67ed59e1d1-3130cd31ea9mr4868567a91.21.1749057395003;
        Wed, 04 Jun 2025 10:16:35 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e2e9c9fsm9178972a91.30.2025.06.04.10.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 10:16:34 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 04 Jun 2025 10:15:31 -0700
Subject: [PATCH v17 07/27] riscv/mm: manufacture shadow stack pte
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250604-v5_user_cfi_series-v17-7-4565c2cf869f@rivosinc.com>
References: <20250604-v5_user_cfi_series-v17-0-4565c2cf869f@rivosinc.com>
In-Reply-To: <20250604-v5_user_cfi_series-v17-0-4565c2cf869f@rivosinc.com>
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
index dba257cc4e2d..f21c888f59eb 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -433,6 +433,11 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_WRITE);
 }
 
+static inline pte_t pte_mkwrite_shstk(pte_t pte)
+{
+	return __pte((pte_val(pte) & ~(_PAGE_LEAF)) | _PAGE_WRITE);
+}
+
 /* static inline pte_t pte_mkexec(pte_t pte) */
 
 static inline pte_t pte_mkdirty(pte_t pte)
@@ -778,6 +783,11 @@ static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
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


