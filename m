Return-Path: <linux-kselftest+bounces-28622-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CE0A598CB
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 16:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E4E618912C7
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 14:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C6923BCF6;
	Mon, 10 Mar 2025 14:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="zUHRTAMn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84E223A588
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741618406; cv=none; b=GZVl3oyCl9Fjf4Yxrq0o26gSWe1EWFUB2hDy2xC4icAG7sYpl5RVQutkblpXLsj9EgMdyw+B6RwSLNBAH6JcCozdrcjpBGlA6TL4bkl9y6MHDV/xNMcDrAIhT/7OCKluKzlowOOyb/he1FurMCp06sCGl6hhTEy5SNeQUXdybFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741618406; c=relaxed/simple;
	bh=eLCcCnwX3oMrnR0hoKevVmuVrExvCA/E4+w0/d6DmO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jxVjpqC2OAq7X7sO2Plzz97FZKGerUPVKqAXUgaa0DmqMMx4rz5yeUvMetUohGyHZaq5YX3z69ckmmUJCZUhffRlsFU8i5wuwNchlZTVp5b49Z4Fd4YBocHCQ06Olp8q8jsVRkcpE18sqkxM1KSaNC4fzXQPqPjeLZ9yak4zwDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=zUHRTAMn; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2240b4de12bso71044225ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 07:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741618404; x=1742223204; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YHkNmM6XuphgUqeYDdwRc1f9MaOV9mSfy6OUDBv2dEo=;
        b=zUHRTAMnMSaHlOldgj+y5jDjAYlmU7B0XUvZ6KgxMKKNrluU6quTfpD/Duk5wM0s2J
         UfTIYhxGa5RhQK6VYs5rn78ang84tKTfKdmruN71mjbatvIArCfof4qVUOgEvKKYZDOk
         sgIsgIItjsfP5m/lEdxKFxEmr2lmRac66WGRLhUFcZkm+MlvNwTDTmPVAKfhLdVnWwwm
         8MYZ8VbRMGciDWwLP5joLbMMNmaJRsAcJqdvtzQbvF59J7Qg3xfWKSPUzkrvLCaBtrzd
         dTdyYNOphbJTwNWRVHPpu3kx1sFnWNno9IN21VxZTeCjPv6AnDfG2RUu4TXA8n+N4wKQ
         QPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741618404; x=1742223204;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YHkNmM6XuphgUqeYDdwRc1f9MaOV9mSfy6OUDBv2dEo=;
        b=joGPT9inWNVwEaLJ/LafckKBpU7yc4/H2lgMtZzaPwJWNhsVTXmbYxbbp8aoQA2qIS
         LNxS8qPGQkDqsIcMxaySpzbZN9yZDAYpzzEl1pIRnkZ0tGbtORqMg7JjyGLdM6uyHBgM
         B6nPUfu8h+pWuncLWKWowP7DbrxPmMpQ0Nrisaw68WqU/tF8EHKjM7mqVGBXxhHFNh4w
         AwWiqZ4mGw4YbUqLaoFBHqdV6lAN5jCueE8sANmd7O3Ylg5o6S7dkm7nDB86t3BJRutb
         NQ0DX49viqg/wcd/5v6TD8Romr59Ga2ndAg/p7Lw88FGNo3Aj5rosxM2/w3Gabg1hYLd
         SOQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlzmrbe/annOfDNlALW+1wJdq/6fu+T1KAl91h3n+JMoWksBdkp+jk0Z5el9yYxznJw6VOcL9LkFTrgc94+Vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX9Up9bdBCwbh7ayGeLdb9OGtJqijL6XRnI0Nm4uWT6v5SD6zt
	fFrMAOcp+pP0lUG/TEqvX1GchxFSHwGi4S6iYSnirVsndGi3Y3a39+JKYESwSkU=
X-Gm-Gg: ASbGncumykIMJ1V+Vff8YAmbGzUYvKPXt9+P5EYoAc2/xTeJS5tavmWlDPNm+kuGBaT
	HuSyGIy32Qkr+QQHWkOMZet/7X6lAO5e17VYe5XpY4N9bd03S3trv1PhZmdRmFKOlk9Z2P0jvCh
	9iuiuUNzyk/DcBAYmA478gUUIvuPosn+nCw9Q28fDJlU1+5KHYFkDAaDkVuHfHLGB47hEl1icLN
	sWsNZRT90rOU19lmPnmF9ZQHPxiS9FKqUX/TjhDMBgZ9wwUhGqaRmqF7osN5/2NIum0Cx5V38An
	LUfGKqZCpV5OklBeHf7fV6UJpTezilMOoi/w2tb8csDozXtg5Ue0Zcw=
X-Google-Smtp-Source: AGHT+IEufhMFpKiNcPYaN1q7fnoyb0yGUoGedR4PcX/LQ5rFfhM8NE7LJbQGAfjZIn8NhFa9HTR7qA==
X-Received: by 2002:a05:6a21:b92:b0:1f3:3f0b:8abe with SMTP id adf61e73a8af0-1f544acd261mr21823779637.9.1741618404090;
        Mon, 10 Mar 2025 07:53:24 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736d11d4600sm2890275b3a.116.2025.03.10.07.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:53:23 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 10 Mar 2025 07:52:43 -0700
Subject: [PATCH v11 21/27] riscv: enable kernel access to shadow stack
 memory via FWFT sbi call
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-v5_user_cfi_series-v11-21-86b36cbfb910@rivosinc.com>
References: <20250310-v5_user_cfi_series-v11-0-86b36cbfb910@rivosinc.com>
In-Reply-To: <20250310-v5_user_cfi_series-v11-0-86b36cbfb910@rivosinc.com>
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
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>
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

Kernel will have to perform shadow stack operations on user shadow stack.
Like during signal delivery and sigreturn, shadow stack token must be
created and validated respectively. Thus shadow stack access for kernel
must be enabled.

In future when kernel shadow stacks are enabled for linux kernel, it must
be enabled as early as possible for better coverage and prevent imbalance
between regular stack and shadow stack. After `relocate_enable_mmu` has
been done, this is as early as possible it can enabled.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/kernel/asm-offsets.c |  4 ++++
 arch/riscv/kernel/head.S        | 12 ++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index 0c188aaf3925..21f99d5757b6 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -515,4 +515,8 @@ void asm_offsets(void)
 	DEFINE(FREGS_A6,	    offsetof(struct __arch_ftrace_regs, a6));
 	DEFINE(FREGS_A7,	    offsetof(struct __arch_ftrace_regs, a7));
 #endif
+	DEFINE(SBI_EXT_FWFT, SBI_EXT_FWFT);
+	DEFINE(SBI_EXT_FWFT_SET, SBI_EXT_FWFT_SET);
+	DEFINE(SBI_FWFT_SHADOW_STACK, SBI_FWFT_SHADOW_STACK);
+	DEFINE(SBI_FWFT_SET_FLAG_LOCK, SBI_FWFT_SET_FLAG_LOCK);
 }
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 356d5397b2a2..6244408ca917 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -164,6 +164,12 @@ secondary_start_sbi:
 	call relocate_enable_mmu
 #endif
 	call .Lsetup_trap_vector
+	li a7, SBI_EXT_FWFT
+	li a6, SBI_EXT_FWFT_SET
+	li a0, SBI_FWFT_SHADOW_STACK
+	li a1, 1 /* enable supervisor to access shadow stack access */
+	li a2, SBI_FWFT_SET_FLAG_LOCK
+	ecall
 	scs_load_current
 	call smp_callin
 #endif /* CONFIG_SMP */
@@ -320,6 +326,12 @@ SYM_CODE_START(_start_kernel)
 	la tp, init_task
 	la sp, init_thread_union + THREAD_SIZE
 	addi sp, sp, -PT_SIZE_ON_STACK
+	li a7, SBI_EXT_FWFT
+	li a6, SBI_EXT_FWFT_SET
+	li a0, SBI_FWFT_SHADOW_STACK
+	li a1, 1 /* enable supervisor to access shadow stack access */
+	li a2, SBI_FWFT_SET_FLAG_LOCK
+	ecall
 	scs_load_current
 
 #ifdef CONFIG_KASAN

-- 
2.34.1


