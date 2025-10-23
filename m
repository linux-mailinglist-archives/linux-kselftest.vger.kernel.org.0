Return-Path: <linux-kselftest+bounces-43812-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB45BFE8BE
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 01:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8DEA3A5395
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 23:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB57430F7E9;
	Wed, 22 Oct 2025 23:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="Prbll6mU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F1F3081AF
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 23:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761175798; cv=none; b=WI0Lxt/MsVxfu5qEPpIiq0BBhdut5xTGbz7TQEPxuUCvGqsGpelW5WpePnQf6T/K5I3mAZPJeH1pJVuF9UtpuYYIWVPjTA+UytsUXH6Wobt5Z8TK8mJBGbnW+lYIl+U9m0cJk1avHLDfiDPT/hedYYgjPlmQ58sEeS196OLvuw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761175798; c=relaxed/simple;
	bh=9AtWvDKQ9q5op9YLRgkrDiWaHEAhrRbEgloHu05lQww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l1opr9jaX70Q/vO0omOfVsIpc7ifBEmnqeYV06XM/emyVHj4jMV3kWLawjAgOIsJKThx/ksAiZByX37ghOXazbtK1YDLJbrA8nUbBQNzc4lKf7HaNvDC1aEIMeTp3HmNPv26tjy4nYwYJNu389nXQlhcyF9C7NVdGZm8ozZmsEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=Prbll6mU; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-782e93932ffso174627b3a.3
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 16:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1761175793; x=1761780593; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oeDKcuIcO6+2FhxyceVVS2WWiuktyVdq1WpyUni2wlA=;
        b=Prbll6mU1vI2MIpiqqmRiIMlDhiQcn+TUaFuVhmIhP9Km349sm77sL5AchQZcY5TAR
         xvHg/0tFiWpuZkcaFGtF2pN4qUVVyNc91wZNE6/8yTuVQVIE6aAHdYuMD3QYF9hDeMZY
         x7FnR3eUvoggqvZjevW7xrtHIJ8MIZ2P2yb08axLCQzV+8Lj0J0pyQtXRzhHb1QHdbIA
         ldxf/lzEE5AuLENUCZIrNQ3R3fptlDCGVGMoDNrcD0S1qv7yOoTFdKE+kXdxMb2BwwP/
         u5QayRieaRlGqiy5HcMDfXS8tM6OK6duQ5tAEMfP2Y5SgoXEqv5EE92YK4IiZaH3sKmI
         qKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761175793; x=1761780593;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oeDKcuIcO6+2FhxyceVVS2WWiuktyVdq1WpyUni2wlA=;
        b=Xv/7GDlGBkwZGwJ19FiT5C+bAyAqiwkO6ENhzKnwhOUtLvqRAR8puln0clpM2RdDhJ
         EzivNtdSivZXIeNx55k9h4Cy5OpWsDHJuNutDj4wzYdFSSvqF5OFz0RG8GqDTHQYsahR
         106b1qc14kY7UwPQGKu+Eqn8Zz1PCPAOC9EOCCfB33DC313Zz+nT+p6mZk2GCYqKap9+
         w9m9g+4n3qWLX9Jy3b4G/HQfmVYPz2i06EXet4xT8b6fuQiiS4wNj7ltzvErr5+zUuWA
         Gv/620kp/vNGaoSWxedRfFAiv2Wp1gLeUPbVtiSdPWsgRF5ANZp7WvABrTn7K/4hXtpf
         RI5A==
X-Forwarded-Encrypted: i=1; AJvYcCWsKLQKpJ6aLks5GOWYvNPhWX5+fiFdyRe1pVlDQuPQ5FJuy9Z4uDp07Lxw7esixJtuoHV7+PbDoAPzl0WMpb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgqIfyjwkAESkLpFguDMdWFTuQoTqL7pnPedyb3kuw59q1nRe4
	hJZmsXDnq0FiMaJY3D8sPUIdegd+gXKqWTTpqmyiLNNBpqgehtdXqFs+xKE8UtPA2g4=
X-Gm-Gg: ASbGncvgAbO0e1fDQleMPycVCmlW3lG9OGx8NLsmmnw74ROs+MOf1igE7ZgpHXae2C0
	KXpEX2czWEv5LxuSm/X2o1ftftxvEsWYdB1Z5KB/hb6fYAIg6+Zz022ph36f0a2XQM0NXFDdvAb
	unvzosYMyG6QjWvfAFF4haTc6zmbBlgZC/jhZxyguce+cT42I3ORNYfN8SxZ54oQGggx26R/pc3
	ZDIELVjN7/celrREzn0TRlfVE6ysRCUQw8bpsmRDOm9Y1iOKGu4QJJzmcScCf1+HLQ5mEV7W5Nr
	6E8oSaopI4+XavUEG17ig7HBm+qLz8sPw2SoC8UqeGknewcGgwQpgcRYeL3cMBXhqTUkaPyA3UB
	h3TG1YwyVhQPHUEzCQuHComDu85ZUgftHW8WhYbYir3ZuuikR/EMHhg0RDZpHpC5KDDX7ZeIqVM
	lQWb1Gm0PQUA==
X-Google-Smtp-Source: AGHT+IEyYaBVYRUloskvUCZ/yxzw7bPY2t7mEI/bU4QrTEjElNpmobT/VekcDiyMNALIqBN5WCBgDg==
X-Received: by 2002:a05:6a00:2e1b:b0:7a2:7157:6d95 with SMTP id d2e1a72fcca58-7a2715777f0mr2234795b3a.14.1761175792856;
        Wed, 22 Oct 2025 16:29:52 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274dc12b2sm392646b3a.67.2025.10.22.16.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 16:29:52 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 22 Oct 2025 16:29:33 -0700
Subject: [PATCH v22 07/28] riscv/mm: manufacture shadow stack pte
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-v5_user_cfi_series-v22-7-fdaa7e4022aa@rivosinc.com>
References: <20251022-v5_user_cfi_series-v22-0-fdaa7e4022aa@rivosinc.com>
In-Reply-To: <20251022-v5_user_cfi_series-v22-0-fdaa7e4022aa@rivosinc.com>
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

This patch implements creating shadow stack pte (on riscv). Creating
shadow stack PTE on riscv means that clearing RWX and then setting W=1.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 4c4057a2550e..e4eb4657e1b6 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -425,6 +425,11 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_WRITE);
 }
 
+static inline pte_t pte_mkwrite_shstk(pte_t pte)
+{
+	return __pte((pte_val(pte) & ~(_PAGE_LEAF)) | _PAGE_WRITE);
+}
+
 /* static inline pte_t pte_mkexec(pte_t pte) */
 
 static inline pte_t pte_mkdirty(pte_t pte)
@@ -765,6 +770,11 @@ static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
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


