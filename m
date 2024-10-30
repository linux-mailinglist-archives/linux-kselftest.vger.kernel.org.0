Return-Path: <linux-kselftest+bounces-21054-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99AD9B57E9
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 00:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED5BE1C2091C
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 23:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857B921644C;
	Tue, 29 Oct 2024 23:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="sx2iVCdQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEC321620A
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 23:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730245535; cv=none; b=pmc/2J5rSC+/eLedFRQJ5WezAZiVtRl92HY0bAQZkY3ZTOfLeS+fJz9wyKoLPojlc2A8YiA3HrvJtoBDbC4o0eBgcxXFYrxXmqg7qVSPWUMeoc/NSVj0OzJj/ReaGNyKAXMUypddzdTs7ymRdg9anSUHU6Y6z4r4ub58rfKh7m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730245535; c=relaxed/simple;
	bh=pW7KHdVbXPe76p0NEMJniDVxHM9JQepVc01b7ARGXZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h8Hu8j3qVosUZln6kXaMn7Za8yJbuwHkITVXNUSVulsbm7bWftX3CmDLoTMtQTBeZVviTn9mBWgm+rJTjLkH1j/k9piqfqi85DdW4WdigrrHS2YNQYmk80fJsATwBs1XFCHghk2NZahcZE5xSXVhtPAoUchwK+jForym34KgaFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=sx2iVCdQ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e7086c231so4671872b3a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 16:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730245532; x=1730850332; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ev1Mbj3LeOLd13TT7hxU6pIG2vcpaYTYXYx00sbXeTw=;
        b=sx2iVCdQwTBLQYCAExxXEYO+xPqT/s/xzcegXT+30JZ105xzQKX+B5rO+DkxNZHCl2
         IDOFasUOvIDORB3onUFIGzvr393eeKbljl3+J7EQ8nSWK7sCgx9Xkd0UBbZCtON41Y0E
         j9hrrkhW1ygCN3JupFQDKCXfbMloQYS5eiR/8Y41uxP/t9dvUa09rkA9jTwlCb9txryB
         n0X3JOs/RVs+XPp5Q7HBzn2ZHD2iVvrKJi11Je6JTmF2vTxeMMjE34i+F85RyxnBBo4Z
         KvJ2ieG4C4DK95J5cMOi2HkSWZp1gveA2Ym4o/7tkMJTnXQEV/bUMCUlCYf8MGIyhCfA
         36kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730245532; x=1730850332;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ev1Mbj3LeOLd13TT7hxU6pIG2vcpaYTYXYx00sbXeTw=;
        b=jHBYd0iaCiAo/+pSU/RhHuOtGVNEdH01z7MnJJv2WV/94imgKceEVQwTrmf19qT75w
         ie0OncDYEQC/F9p2SQ/hM4uIm1h5hZVOvAc9nZFcbxICy/zfBFEQzbL1yqgFrvSXyq86
         2B/BHQ20D9SooBgs0j0h8z2zmxrdZMdrfi32nc4ITRt4HGD3G998xN8KTBIvXnWPuv/L
         Cjx7eDU3rSHUXvnQ4emMBN9PrJgmq8TiRRJUhdjNsxH2eslKdX7btFQn6BdVACs8gScB
         XAmbGDx0+2O1SyTuvDGqXQkGdJIUp4/E70k4RNYh4e8kfy1h1jxmybhAjLZuBQE+7Dlb
         jlXA==
X-Forwarded-Encrypted: i=1; AJvYcCXPBODwIkLrJSIPVLqSQyXNFqp6KVkSgFGCL+b3NNUlFj39I0pusLY+CGFCkuESv3FGmMZnXElCA8OiP6fnmiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNX3aGjhqAVKd/fAN71BPDmqHuazQyijziOJVeg33dw5BUiLfQ
	tN4qNJOm3ERvWlK4a+eGWR9cw351sTvVUg8afhW6f8owTSHsQalQwZM0BAeju8MvkxTx6DA+0DN
	t
X-Google-Smtp-Source: AGHT+IEfSyF62ivzJTKgFpp0kGdt3sdSzoahMwleruIgutJftkJDtf+kKS4NEl+lwlKC7xKag1P7PQ==
X-Received: by 2002:a05:6a00:18a3:b0:71e:6c65:e7c8 with SMTP id d2e1a72fcca58-72063093579mr19109726b3a.23.1730245532485;
        Tue, 29 Oct 2024 16:45:32 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057921863sm8157643b3a.33.2024.10.29.16.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 16:45:32 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 29 Oct 2024 16:44:29 -0700
Subject: [PATCH v7 29/32] riscv: create a config for shadow stack and
 landing pad instr support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-v5_user_cfi_series-v7-29-2727ce9936cb@rivosinc.com>
References: <20241029-v5_user_cfi_series-v7-0-2727ce9936cb@rivosinc.com>
In-Reply-To: <20241029-v5_user_cfi_series-v7-0-2727ce9936cb@rivosinc.com>
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

This patch creates a config for shadow stack support and landing pad instr
support. Shadow stack support and landing instr support can be enabled by
selecting `CONFIG_RISCV_USER_CFI`. Selecting `CONFIG_RISCV_USER_CFI` wires
up path to enumerate CPU support and if cpu support exists, kernel will
support cpu assisted user mode cfi.

If CONFIG_RISCV_USER_CFI is selected, select `ARCH_USES_HIGH_VMA_FLAGS`,
`ARCH_HAS_USER_SHADOW_STACK` and DYNAMIC_SIGFRAME for riscv.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/Kconfig | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 22dc5ea4196c..53f367609c70 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -244,6 +244,26 @@ config ARCH_HAS_BROKEN_DWARF5
 	# https://github.com/llvm/llvm-project/commit/7ffabb61a5569444b5ac9322e22e5471cc5e4a77
 	depends on LD_IS_LLD && LLD_VERSION < 180000
 
+config RISCV_USER_CFI
+	def_bool y
+	bool "riscv userspace control flow integrity"
+	depends on 64BIT && $(cc-option,-mabi=lp64 -march=rv64ima_zicfiss)
+	depends on RISCV_ALTERNATIVE
+	select ARCH_HAS_USER_SHADOW_STACK
+	select ARCH_USES_HIGH_VMA_FLAGS
+	select DYNAMIC_SIGFRAME
+	help
+	  Provides CPU assisted control flow integrity to userspace tasks.
+	  Control flow integrity is provided by implementing shadow stack for
+	  backward edge and indirect branch tracking for forward edge in program.
+	  Shadow stack protection is a hardware feature that detects function
+	  return address corruption. This helps mitigate ROP attacks.
+	  Indirect branch tracking enforces that all indirect branches must land
+	  on a landing pad instruction else CPU will fault. This mitigates against
+	  JOP / COP attacks. Applications must be enabled to use it, and old user-
+	  space does not get protection "for free".
+	  default y
+
 config ARCH_MMAP_RND_BITS_MIN
 	default 18 if 64BIT
 	default 8

-- 
2.34.1


