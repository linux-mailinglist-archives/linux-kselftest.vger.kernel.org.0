Return-Path: <linux-kselftest+bounces-47072-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 82970CA5411
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 21:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D56BD300B339
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 20:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEA4350D43;
	Thu,  4 Dec 2025 20:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="LL9lhDPE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8476A34EF0F
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Dec 2025 20:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764878681; cv=none; b=I9aFEOYxmWl0JSIZKILgCVmX0u9TNaEoD8guKG5COchQv8QbG0cfJYCduYbuq35+zQ2CAOro5ydaAlUyb1P3bXmR19XJG8gwjXuGDzwT8n1cktGCust5iiwn5+Do8qLXO+nv+FwXGTLhO0QbuNO9stKK5EbLad4tH1c/6nqPyVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764878681; c=relaxed/simple;
	bh=5pCsCIMJf4iBOvf300q6+KPihTaIQ8ZBfY4WmoGUnLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W0XWFokjlKUSr6KX2zXcY5AHSj7rZG1OoZiSWFZXBC/jKEzSkZsNuLZhu3i8uFqhbhE4P+JfkwcjQ/RfC8U2JjDXA9piTxNiLDi0p0tb/hvhFgqqN8DLPYsDkrLk58FBTP4ssPgQHBj5luKkFHaXcplQa2Mc3Rkw8I7VVUMOuDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=LL9lhDPE; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7b9a98b751eso1140793b3a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Dec 2025 12:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1764878675; x=1765483475; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y7cVA4V+tsTGYh8faQvOG85ZxC8pPRVoW62aZwUk0L0=;
        b=LL9lhDPE7KKQfMlEY58K7DFk2zBKGmI4yZ3vx/tQDy0Ccf/7WRooebvulhaOejlTII
         A/+UJKzebAuGn7yUGaOtQ8h0s0WaW7SutSopAqOlr7KDOs3J1iLtxoCfjyIjndjGurag
         DAtH967EWHHWcdewaZuUB/VWYBlU6Aerf2UbYIcgXS9EYNR7ckCTZnQTJGKOVRbEn+AT
         mfuL7pweJHQK1xvS0e76PDb6IJvr1fanzYgY1nZo4GnLrGvTsdzM/jN3gW+KWY7CbcBH
         PcrC25B+ygg+hWvmAK/Pos9bDGd6HTt6QasEuhzeUKmHn6s6qI72tzI7IIayk+V2PGmy
         JJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764878675; x=1765483475;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y7cVA4V+tsTGYh8faQvOG85ZxC8pPRVoW62aZwUk0L0=;
        b=C75JlikZAF9IAbAXPmidNmIsGOIUS0yHXvTxsSnW1maHxMUqinBTlQBzmf0pRbkFqH
         DVLbMiZVPFXu0tbukWeNdDvhpNFsaIyicM2jkRcwCwxZ754cQcqmU0S4tke4YoY2SGr7
         zYtfYWTPG1qP/M3UTWoU78bSO0q6Lj017+NMelK07sCqY7ECXwMvy+zhVOWgj6U93XVA
         NHgN/0+jxQ1Y4zQ5RNHxSSb1Ho6bKfyfIzgXVGw7G3kpJus6oHPh2Mdn/ggI7nfJC+E9
         crrKOCbKN43CsXPLPBH+TaWyM4B2eeThGeXrhMNbt79J4NJVgh/zrqYTqtkrZ+C+FPq3
         Za1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU2A8hVW877M2SUs4dZE9ytkQ6n6OzF1oyO/FjY4+u0PHAL9LlHJS5f9bzOFwu0hTH5hG5MuOJ0Cmj+kmhcybw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze9Muxw4poel31Sa7QKKu7SMq+1Nyrza6OAPN6JciShTNHNTvB
	k7XBnCSYNkrpUviiSWxoDECfM9e3meSG1cogqjoDrjDmw/Mwc/k/BRHsQNxwpKJpgAo=
X-Gm-Gg: ASbGncsVMqflF5B88klc2j7NLMCMxRzPUPhjtxRFlRcwC7rYOJZSJJu94HaypZycZvo
	NyHNirq8qmakf4Uwt/76mIoidEOgBPReM9C4ZjuCJeiGWeT913AkcgG3FnNPrRx2sLHSfS/7tLF
	BuitFjP0rQTEVYNZCM99clK7X/+ilIedNEj+a2UVU8n857UEN1+/+QnV7NkBfO0NyfF9ktNKZJG
	r70xx9JtCR5edyRUfm5JGnA+r7MA8cCyjRAI0FyDaI2Ex0Zzc9XQ0Gwxq0RfjNKbZ8WXbH2x5PH
	dwAnnQBd35kEEGqz/biTDQoYBr0OAW66pFK3WzSC7u++NUDGJKnTTXyOzmWPP28BgDSW7p52OSg
	A26NGNrXbxqsxJ2eMDGaojM16AhPMId1seZPRMucp2VwB0T6MzwhG4gUFMZTS3efXQeVWr+zcW2
	QXu9BnoBheqpM90lr4CDoGuHmc0KRYshs=
X-Google-Smtp-Source: AGHT+IH3DRNGCvULusk0MSN0c34XACnhHDWSefcdBCkji/UkCW9Cgr1V8Io5HqSxhaCaIYKCC+gGlw==
X-Received: by 2002:a05:7022:5e0e:b0:11b:9386:a38d with SMTP id a92af1059eb24-11df64a5fe7mr2337882c88.48.1764878674645;
        Thu, 04 Dec 2025 12:04:34 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76e2eefsm10417454c88.6.2025.12.04.12.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 12:04:34 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 04 Dec 2025 12:04:07 -0800
Subject: [PATCH v24 18/28] riscv/kernel: update __show_regs to print shadow
 stack register
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-v5_user_cfi_series-v24-18-ada7a3ba14dc@rivosinc.com>
References: <20251204-v5_user_cfi_series-v24-0-ada7a3ba14dc@rivosinc.com>
In-Reply-To: <20251204-v5_user_cfi_series-v24-0-ada7a3ba14dc@rivosinc.com>
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
 Andreas Korb <andreas.korb@aisec.fraunhofer.de>, 
 Valentin Haudiquet <valentin.haudiquet@canonical.com>, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764878636; l=1182;
 i=debug@rivosinc.com; s=20251023; h=from:subject:message-id;
 bh=5pCsCIMJf4iBOvf300q6+KPihTaIQ8ZBfY4WmoGUnLE=;
 b=gAgt0qiA01P7drDBMqFQXuoLVXR1r0qiMVxyXn0hwdIA1M7y9CqEeq19oXDcQmb0Z/54Aoug8
 68he+4K0zLTDttF3EANbQpNqxF1OUC/aAhnwKbqrODAAIjZ7IEJnRR9
X-Developer-Key: i=debug@rivosinc.com; a=ed25519;
 pk=O37GQv1thBhZToXyQKdecPDhtWVbEDRQ0RIndijvpjk=

Updating __show_regs to print captured shadow stack pointer as well.
On tasks where shadow stack is disabled, it'll simply print 0.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de>
Tested-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/kernel/process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 49f527e3acfd..aacb23978f93 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -93,8 +93,8 @@ void __show_regs(struct pt_regs *regs)
 		regs->s8, regs->s9, regs->s10);
 	pr_cont(" s11: " REG_FMT " t3 : " REG_FMT " t4 : " REG_FMT "\n",
 		regs->s11, regs->t3, regs->t4);
-	pr_cont(" t5 : " REG_FMT " t6 : " REG_FMT "\n",
-		regs->t5, regs->t6);
+	pr_cont(" t5 : " REG_FMT " t6 : " REG_FMT " ssp : " REG_FMT "\n",
+		regs->t5, regs->t6, get_active_shstk(current));
 
 	pr_cont("status: " REG_FMT " badaddr: " REG_FMT " cause: " REG_FMT "\n",
 		regs->status, regs->badaddr, regs->cause);

-- 
2.45.0


