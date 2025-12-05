Return-Path: <linux-kselftest+bounces-47151-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A210BCA8FDE
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 20:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D383311EBC3
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 19:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28B734CFAD;
	Fri,  5 Dec 2025 18:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="Uf39Gdby"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1F534B683
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Dec 2025 18:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764959830; cv=none; b=QRZ7pX2+oekvcAyBuhZlbe2p5cWoIL1pu4WJE33W3KDdMZUGM3SsI3W3Hbxv2m8lHRPXiJNhUsusv7U0kIikSQvVLU/yawHSNfkrMAcyIzglixKgLJRoNwQ2t7+EmDgCSCX205GzfSB8QikHN8v64zrpXVS7sKmWO73hpNDzIHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764959830; c=relaxed/simple;
	bh=nBM+gKOHTmPMkti0DTh5flAX5grcW8t0U+G6mikLn4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cfyzLP7LzqjFJkJMofn9JbnSeJMuAVuxKqIaVJFAz3F5T0POuBp0tVvtr9RgNkod7qRPjZPC2YQQxxuaLmXrDGJ+LgRpFG0T/3dUZFRUrftbrxHw7ZxoksKJ7PqMS6xhOn4+dbrbQVjAilZ63qTDDZX9Y9kij5Unyxu0ZRkB7Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=Uf39Gdby; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-bd1b0e2c1eeso1971978a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Dec 2025 10:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1764959824; x=1765564624; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FldpuJVG3boWADnTyrci9WEZv61t3vqu/iLtDVGsedQ=;
        b=Uf39GdbyDJpxG6/UIPdzRK2vLMyumU7XVJoDePuaiUicMSpX68gfPdMRjx5uPdZo5Y
         HgOTDXXp4XKs1ImwH3oVcpE2t/pKmD8e7CZJCpfWuIQkerq9E4RvoWqkF0QoqXG7Btp5
         r0De2bDypsgR4zVuKZPyPohw/kamU4682Ghoc1cHD//mrAbFjp1h80c08lrPlCYKPq0W
         njRTRicRFZCLrrMgEFGBfq7kwZ4qFF8KoRGUUS9PiPZmaVfyscciGxcKbiBtxpVl4aOD
         9hOSb0Raz7Tn3cG352TmSycNvtdiMR/OZ17CdYeBHLn6xNnDrnyl8GVdZqpYFHc33Azh
         kjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764959824; x=1765564624;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FldpuJVG3boWADnTyrci9WEZv61t3vqu/iLtDVGsedQ=;
        b=U4YsGvPC87ewQzI/2/CHR1MqQj98uGsRMyaVRq0NCWwUJjTz+Ehwunsh8tB+978K38
         DJdYKOk65zQC/LLJIAXRvD5ibiKceDD0wSy31JYHTLROXiCjB83YG4x7JQatBBsV8Fob
         JI1y+aKxt1Uor7OhxaQJg3AU8UZ/qFm09o7CN6wuTigGyt92V7oP4PvrID87NhFx7QJP
         PlObYxR+LqxH8dzPUFd1ZAAoaZA2kg1j631FcTqpoYo9xadlrRjArpS1CK+DqthTcXe3
         jAi/vD82SpIMFYdqb6Mes4Tf53haTh1YPA3i/DApUcZxRAbDCEMmhLGn2dV30Yqw7MKR
         iQ6A==
X-Forwarded-Encrypted: i=1; AJvYcCUMFiazbW7u0GFl/Krr0L5XfbvunYzXidH2AGtyPN8JJixM4tA0oUlXS6sjWumTEk3EEO9XCQzGQn4mc2TXObo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3noWcGl564tio6gwb/fj379Uimyn2MUAi5vQeR86ZuyB6KCnb
	69oyQoolFNaP49aqgu+VZp8OOTYb9niXhmtigtvgPMAGmShtWsi5BG9uoXEyXFcdY2w=
X-Gm-Gg: ASbGncsqUYwQfaGkNjWyD+5gkEKmg3zRyiIfW8VavUZNViCFZKoPe9MtWTR0ow3/smt
	67XztvPeSwRv6+ioix8neBbFLpKYTXr0qxptzDEMXw+9Liog56o1iDkKY4/dNX7zI4m0Xq8paZt
	d9CZA1ZzRfr9EuL2NgI16KEAfJR9ChySzxwNS0dUQb1a3kTxap8++FcekZr/PcAri+WzrRhoj5o
	crTmy1XQYFyK/w/ORzgTnPel32a/Ffi2jNE8to2pe7GQ2ZGFpxnXUGvB4F7Mby9ef+49Tx1zljD
	93LPQ1Y1xRl3/QLezaHU70DNI5B8QMTCxZfsGPhp/lml74dtPNbyVrYpFtsvQ/Ryh60nwAZwJPq
	/cS0enjoeErP/KspsZGd8C9w3kvuoS5AuAsQLRfNrZzVZ8c8dTREujqVKZy4own4F5SwebK0cBf
	LjjxQSxhAhSxZdzrJZ6TfQngDqM8AX/Ug=
X-Google-Smtp-Source: AGHT+IHWIa+CUlLJ0qe8tt+iE2caT6nKD2wfDSY1g0hDmU5iV9uKmwprZ5K8BpaoIbktQvNqImb1UA==
X-Received: by 2002:a05:7301:60c:b0:2a4:87e2:bcca with SMTP id 5a478bee46e88-2abc712e3acmr123339eec.13.1764959824396;
        Fri, 05 Dec 2025 10:37:04 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2aba8395d99sm23933342eec.1.2025.12.05.10.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 10:37:03 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 05 Dec 2025 10:36:53 -0800
Subject: [PATCH v25 07/28] riscv/mm: manufacture shadow stack pte
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251205-v5_user_cfi_series-v25-7-8a3570c3e145@rivosinc.com>
References: <20251205-v5_user_cfi_series-v25-0-8a3570c3e145@rivosinc.com>
In-Reply-To: <20251205-v5_user_cfi_series-v25-0-8a3570c3e145@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764959808; l=1430;
 i=debug@rivosinc.com; s=20251023; h=from:subject:message-id;
 bh=nBM+gKOHTmPMkti0DTh5flAX5grcW8t0U+G6mikLn4g=;
 b=oyiVB2mV2Xr0Lyb4BupLSuiXGMjHkUrkc1x6guHAqwdwHbYglV/kn8YYY3hQ4vZqsYqYf0IH/
 luTeFhKyqPYALE6hb1xL5HYvgU1E78HSbMsFrb/HbDOtyeGcM4VZWOy
X-Developer-Key: i=debug@rivosinc.com; a=ed25519;
 pk=O37GQv1thBhZToXyQKdecPDhtWVbEDRQ0RIndijvpjk=

This patch implements creating shadow stack pte (on riscv). Creating
shadow stack PTE on riscv means that clearing RWX and then setting W=1.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de>
Tested-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
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
2.45.0


