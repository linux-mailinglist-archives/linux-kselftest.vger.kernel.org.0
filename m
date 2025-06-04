Return-Path: <linux-kselftest+bounces-34326-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A04ACE367
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 19:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0787916F8A7
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 17:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E9725D54A;
	Wed,  4 Jun 2025 17:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1t6DWDGX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDE225D212
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Jun 2025 17:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749057451; cv=none; b=TdwIE0KNvTV2gt0DDqfQgv9Azv4b4aRnUtZZbiH7yTyljNQuiP2B2Lvaa7R0DvzitM8ITVK+IGAU9qkAM4XDZegNMuREMpVJ0bydbidNP5gB67Jpkanbm7el66FyBAUGdtPnZDg2JsGR2icjCafOYVnXNUfC0trsUOruh0OYzbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749057451; c=relaxed/simple;
	bh=YhfdOBzKEEebS8YngpHiUP828c0FLw+RSd9OBhsOuOM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CYF9+Xc+2vBXDb40z9LNRbBvgVvXUrZjk3+9fG1y8/XWQyB74HduEWX3AyWWNd/VuqOhNnck7teQEMYGl8bXmf5CFVeX7DEux3LZUUFIjOwq0b9xd7VNr15llh6P35excEUd/uYs85Y/pBFdZRwkiZ7n1enNUefw5OiGJYrs74U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1t6DWDGX; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-312116d75a6so71583a91.3
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Jun 2025 10:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1749057448; x=1749662248; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zd01FxT3OlMOzWqIaODnmoUPnuHtuVmONb+HNJjd/YM=;
        b=1t6DWDGXL85bnyW6DwbcUA4nnIMzJ3z5/DMR1vtpsHCG+IV9kF4eduBG1tA9SvxLHS
         fpd08CRFsamOhZcZs0RiKju06O+dMwx9KpHEsK2KUmk1LQVud8Yxjf0cGSOGThunFbdf
         GxYLa0LNr9zkWKq/7TMoGjtfnFkH8xuxQEMPivrmzlw8LOwVXqviJAdAwxLh+R1eDHdA
         /uEwmNhcX0L6VB5bVc7Mq+K/LunZhYixShUCdvfxDPw2Fo++xPc36JC94nlOMiEDFOfu
         g9SY9mxf7vnQa32GBKkVKCTWh0UTMXgzEhMh73RrIjlK5awJCG+4efkE/jcMRX5lMo3s
         Ds/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749057448; x=1749662248;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zd01FxT3OlMOzWqIaODnmoUPnuHtuVmONb+HNJjd/YM=;
        b=xQ7cAkSah4wmRYsJ/7BC0ZZu6VfnRPAjUWjuUHYq1ApNt6e+MWOTcKo0HaTJ37B/tm
         BMSGOameGTr4AigPHTJfr/sh34jIugk7Rch/gIC9pX56S8OkDx78lInoI14givOcJpHw
         nR2vII7THTlNonzk/k6YPwCv15v6j7YeNJNqB4MifDmkb+7/GeMXliaBrPxD8eTvp58h
         xoUlkWyYbiahpcFiatMcPEKW4wjGPQbfeRP09QyZSCF+Fgga40VXADCuBPba5WmVlAES
         yAVyv8J01/NN1vD6OiYZ0zbE2EI48qBHQRjzRS2mq1skV+1orGS6263BOcYpb4AN1m5p
         c8aw==
X-Forwarded-Encrypted: i=1; AJvYcCUWMFaIc7UgELmcVh8gVDTfvM81S73ttHq5EEe935Fkl2PAuzmKfUsEQKl31Zk2EqxsxHnmywy0s2IbLYnwKmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeyWDQ4MmkkmMj7sRaFK+giBcdLfUXtJwLF5VTC9p7PljHXH9C
	cSYuu3v/2Ehk+Jwsx/F6DdGPaXC0B0GrsA3bRdREwUrJioYr+3+vJdDqMJIaZhbqFWw=
X-Gm-Gg: ASbGnctVIRpW5/TZpiuneH7LEP3xNFSPz7gGK3cCPRUGmHFMjN5+Jxj53d5Q+Lfz0WM
	uSsk2pzz7SdWyZ5kPG7DQLnEDLJht6ktboGWH7q+pA/7x3Si84sXcE60fPjMmFjxbpn9c+vE4UM
	pTaB9qo23k8NFQRBX71bmnY6/YEgoKetgga/viffoEPKLYg89VSgbXYWSMz+mbLUV4u1eqvHVvA
	pAuAqUnXQmQOVW7fSUkuG9cGcyRqQkJDVCIOoQMIHfkPWdPCP4CtAtWi8YR9I3Bhtk9EazOBArn
	z9NEjZVg+JRw74IVsDVdTef6mAXmivwafZUe6N+Enbav3pBpqcI9/Xxzg6kpSg==
X-Google-Smtp-Source: AGHT+IFWkJ78wFMwg3GliR7Galn0PbhhfnyCNBUVVp6rLtdMWNFL3ewFiC9H95Yfi/uZOn7VC4Cxkg==
X-Received: by 2002:a17:90b:3c4d:b0:312:f88d:25f9 with SMTP id 98e67ed59e1d1-31310fc4f72mr4513419a91.7.1749057447912;
        Wed, 04 Jun 2025 10:17:27 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e2e9c9fsm9178972a91.30.2025.06.04.10.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 10:17:27 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 04 Jun 2025 10:15:48 -0700
Subject: [PATCH v17 24/27] riscv: create a config for shadow stack and
 landing pad instr support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250604-v5_user_cfi_series-v17-24-4565c2cf869f@rivosinc.com>
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

This patch creates a config for shadow stack support and landing pad instr
support. Shadow stack support and landing instr support can be enabled by
selecting `CONFIG_RISCV_USER_CFI`. Selecting `CONFIG_RISCV_USER_CFI` wires
up path to enumerate CPU support and if cpu support exists, kernel will
support cpu assisted user mode cfi.

If CONFIG_RISCV_USER_CFI is selected, select `ARCH_USES_HIGH_VMA_FLAGS`,
`ARCH_HAS_USER_SHADOW_STACK` and DYNAMIC_SIGFRAME for riscv.

Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/Kconfig | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index bbec87b79309..147ae201823e 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -256,6 +256,27 @@ config ARCH_HAS_BROKEN_DWARF5
 	# https://github.com/llvm/llvm-project/commit/7ffabb61a5569444b5ac9322e22e5471cc5e4a77
 	depends on LD_IS_LLD && LLD_VERSION < 180000
 
+config RISCV_USER_CFI
+	def_bool n
+	bool "riscv userspace control flow integrity"
+	depends on 64BIT && $(cc-option,-mabi=lp64 -march=rv64ima_zicfiss)
+	depends on RISCV_ALTERNATIVE
+	select RISCV_SBI
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
2.43.0


