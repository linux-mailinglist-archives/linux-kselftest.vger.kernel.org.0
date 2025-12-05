Return-Path: <linux-kselftest+bounces-47162-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6D2CA8F13
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 19:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A0FC320039B
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 18:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC8C352FA4;
	Fri,  5 Dec 2025 18:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="Hg1w6IbF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D9234F481
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Dec 2025 18:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764959856; cv=none; b=WXSP7An4lBMVtj2MNXEoXpsO7kStrZFPq8Q0T792RN1CLYujpz7lTpheTFLorToftG7L5HHDyPuzYyIXp8GuX8oQMYRrvvqHghdsjVbHh6Gxduw8jAYBaku6K10v+7pvIbirNtDXTlC+4LCzUQ9SrZfKIq4PuBveItl7NXCSqL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764959856; c=relaxed/simple;
	bh=5pCsCIMJf4iBOvf300q6+KPihTaIQ8ZBfY4WmoGUnLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gfZl7QclTxt0GplLDQcOFlvMWba946Jl8OobOG6VfJh511ydR7IC5I9DSZtflMieHd15xYgNM4quvT89lyia96I00UwlwDb2fQChvEjEoi+OtcMmJi2wc67jF3/TQUNcKEZXmtnflnu2GonIgSlLpLcCivaOEFVSUVtSJDQDwcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=Hg1w6IbF; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2a484a0b7cfso4133983eec.1
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Dec 2025 10:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1764959845; x=1765564645; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y7cVA4V+tsTGYh8faQvOG85ZxC8pPRVoW62aZwUk0L0=;
        b=Hg1w6IbFq7J3oJTjZQMV2a3n1TVZ5ezwfniSFN8ubnhi6A7ZVt/IB0dnZcHekEqntY
         CcmCDuWuAwUOM/ehPvqvfAEqGj/UXsNDLwj7evTRL/v0vVaTe4l7QbdCs7By2HIGRj/e
         XAd6H8dbPS89TkTUPh9QZuSf7dvtBjFvpQ5XTzCIulapezJ/aDEcbA+UAzomUslmcQbx
         CTNE2PYDuGBDc+AFVZUoxNvB5/5GPwhNsvrbZDRqvPG5ESUpKU2LZCAe+FnCvptMQUjx
         4hNe5rhc1lK5JNyO4OcO7qEIv46GF/6UhIFSw2lj1Enhdc/WOtwJ5GVs0HtNm5EjQYmg
         C1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764959845; x=1765564645;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y7cVA4V+tsTGYh8faQvOG85ZxC8pPRVoW62aZwUk0L0=;
        b=OEjAWafV3kXOWPJ5VFQpQVpWxblCNzpk3v+Ling2HfVcEQZQAPxZlcdb0qlMY+NaPt
         MbIZ5yPUu6UM9GG+6BLLqpv2pgLoCG4PpiWpp3jLfahqcRMfyTgs6K9Q+A/QJCWuyIHJ
         Sry0Gc66HlXzVLHkqfSCIi6VCEk/s2spZG2T+iq7sPt7Sv2Jxc3HnY6jhWBz7a2icUHe
         jG55w40C8lsBy1uWRLMszFEpTGezpnJb/J6+2hRvxxuEdM6dQSze1JUx2CEboXWQhIaT
         Ok/4kl/m7rcFhO5vhz2dV4YfDXcPPgBg9HrQHKWOzBipEB85f6ZurYqDrfzFfbISrteJ
         o1dA==
X-Forwarded-Encrypted: i=1; AJvYcCUI10txjzr3Z2cWd5vHx5syhF7Vc0yOPEtpHtDoMJqLBsW6VXv7KDTbbutujML95mTWQ5P91qpke6f+ZiBoXi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZPqRnqml+eVsXqX0rTWn+dpNeQ1a/aGicPH1W0aQvsFbWAudq
	hpjENcatDQZHj1roBaP9PoDQgKHYH9b0FMTj4hum3gwo1h8F62/UfZkPowNrlcie4xM=
X-Gm-Gg: ASbGnctbk6TkspymA+BUOqgz9FLW7S1Y92L8oufx45kusFURIiyZrzX7FzxidHA1E0D
	pkOcqFM/lrBcsxDEN0NXhQKZ6m/HyjixY4ZMYISQetOJIGeYfnHl+hQH/6Si4wYf7M2r3MAOA3V
	NOhLS1MEWsaZSEfwhlgylEb7dLID7T1xpwacpzeBu1+ujSMjID8p6dknVswf+7iPpqjx5f83Fej
	FomJNC/cp87zxDZpgRpEXym1bv27Gy5LUgQU8S7OoA2K3cS9fRUCil2WbhzuKmayowKpsX1M8Ee
	YwSC8JDcbKbgnJueEvqXel9Q50izmrVZ3XQ2eGxezZoGe48WWHUD1nV5FdiboaqNHL9jUaTaG39
	uvBxlxfSEex/aArT8lN5OVqZcMbltuwWhg3lDR//kWXs5nLvOzrP+aFOtvye34RzmazWu5bzP0p
	9/SyfdhCUoAVVX3qKN10wk
X-Google-Smtp-Source: AGHT+IHpgKa7H8AahzL7MXJDXATVAt8op9HJLZz6q1O1yZv7iAcmKoVC4X9a7AcjVimql64o0x0uoQ==
X-Received: by 2002:a05:7301:1e82:b0:2a4:5c33:ff7e with SMTP id 5a478bee46e88-2aba34e598cmr5659789eec.19.1764959844877;
        Fri, 05 Dec 2025 10:37:24 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2aba8395d99sm23933342eec.1.2025.12.05.10.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 10:37:24 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 05 Dec 2025 10:37:04 -0800
Subject: [PATCH v25 18/28] riscv/kernel: update __show_regs to print shadow
 stack register
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251205-v5_user_cfi_series-v25-18-8a3570c3e145@rivosinc.com>
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
 Andreas Korb <andreas.korb@aisec.fraunhofer.de>, 
 Valentin Haudiquet <valentin.haudiquet@canonical.com>, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764959808; l=1182;
 i=debug@rivosinc.com; s=20251023; h=from:subject:message-id;
 bh=5pCsCIMJf4iBOvf300q6+KPihTaIQ8ZBfY4WmoGUnLE=;
 b=YUOAVPCuxUM5Gbaa6opv1masEPHIuQa83DUGc+CGXyeJ5A4kfQSjMwPJRS+2ZDYG/CTYlt+hh
 XoV55OqqjBBArKRtE/ICcgJfxzIDFQra1KnJGP2v9aOA7JvRD/LcfRN
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


