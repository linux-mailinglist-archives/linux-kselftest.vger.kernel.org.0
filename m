Return-Path: <linux-kselftest+bounces-33602-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EAAAC1C78
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 07:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFFD11897020
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 05:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967E428C864;
	Fri, 23 May 2025 05:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="jPhNKuJu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BB428C5C2
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 05:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747978355; cv=none; b=tz15Rkm1Hi5oeTLKZIW8GByQY6gpvcgwtlowR1cWigaloItZjPdL/RIe/bkqn/Db173Ck8gm0cSYPnCXe5D/5fzKfvJuJ+zDzpnnDunr6pp+NVR5pOvNBaKC9sqv93pAvPBjxgaPUN7A1VpzABoLeqkg+D/KV/XaUo0Uzum2miQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747978355; c=relaxed/simple;
	bh=YhfdOBzKEEebS8YngpHiUP828c0FLw+RSd9OBhsOuOM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=esKYPWtpI3k3D7746c8j58IQExpNJEh12WP7bB2OJX+5smP85/eT3msLOO21aoBmhcWbPGOzmCQKkxTyp9k4zU3h34V/6BcpK/rER+MDtwpezLIe355Jo7nynAVfcSOwuikcBqKFPL3bxR30GE8ACqE8btLV27wddRWoUuSAoUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=jPhNKuJu; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso7471279b3a.2
        for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 22:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747978353; x=1748583153; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zd01FxT3OlMOzWqIaODnmoUPnuHtuVmONb+HNJjd/YM=;
        b=jPhNKuJuL+lYKVrdr/Tgw8pPSntQwTdvQONX2YxYtAEEFIA1eO9jJmicZ/c/pApj84
         QAdPRZJ/LLRH7VW0P6I6hrDK0GyrUQ71+A5LBdtvgl5XLCPrM4xesOoKrao0oo/+wgQ6
         OSW+2ikBNXJdL/7IYC1/GSnjYXRV34AJt4M/C20YBsHysbZEIwBYXwEvFfgC/Io0AFIO
         a6Wt2wDbh4YkMpYVbN6pL1zwZvu1AaHUtDNKcrzap2dk7Cb0VNP+1ziNqK8b84iyh0lV
         D/bk8bGj+oy2+Inpy4/Z899mu7Bn7HjI/5OkGoQc2g5wzrXre/l9SL8mjwHGjozaWuym
         OQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747978353; x=1748583153;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zd01FxT3OlMOzWqIaODnmoUPnuHtuVmONb+HNJjd/YM=;
        b=tsS4iSQn4pDl3zw5F2vAaY3ncxHIvSWFnNLBbbxzEHoSY9prCcQQA5soI8INneyHMf
         MzGQ3IwjFl9eHM4jjar3zCWKsNqkSAsIz/Opgvw4gYc4Gld7ZEsjn1OqxlDoGhpJyyzP
         Z2uKfajmZjxNVGesUUf+wAeOEPzgRGLQyJJ0jZ1dnoYadTY3p6kQ+mNA6TauCz1ia0NU
         53hibcHUDtxPPJtXzzjNq43fW2Av8fvmRnpODGTMi7utydrOmfHYZ3Bd/U4CUx+cAlYY
         2aAc0/NJzN4PZT+rKKZbaHUh+ocuCPjMF3ecxYy42eXdCsTmGsSxbyEyBdVjGzr9HwnX
         7i9w==
X-Forwarded-Encrypted: i=1; AJvYcCVVNoceJpfGGalcUBApprZDjX9kI0eqT7oIZ3+QRH42GNzVcVA6+u5g5QmyZ619TVVphww2URYbQPpIe2oTl0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW7i6E6+bjPjEKJla8TFW9XjOCZwe5bzkrZ3WuIYQiR5mKhYBK
	q9xFHkTqnv2mwf2BwX0s/rOrMEcgxuoDeHK16slYuGC5YJd+feXajVlMFjTDDTjGk4Y=
X-Gm-Gg: ASbGncu2UFaL/8/IL/JVFtH7x7z1LKPdExBOVaiWoaDBnFuNtM91xZMQ45P4yHAKg/x
	iYDtI+EUuT2qnXibOnKuWKvXF+y8Hl7o7CXj7eznDBC7SCHZdclqL/HW7fDJF3XhN0U2tZvxl7b
	crABeaZCj3Y6Rf+mlAy+cGcPHecG7tbTn8cfGAUj+FwTfZX2urmYuslJ42ObhVO+TQa+0Apyd3D
	VfrSNYtWWoHWzp5rUQIXZ8G4nPRCf/VrKJBjSYT13QFOenoAmEFbbqaB/oh+ifXIIxSaoJVM5/Z
	iu1cdCBqZlww2DJbOnhWjbBWInOZj9FzWBq9sR/FPPAHpiVqjOjfdA4Diky7YgcrMr881O27
X-Google-Smtp-Source: AGHT+IHiypBZn8GTV0A/2+Gj0eQCyN8j7h3oyPr5Idne7mafOFuM42ePJJ91A987vgZKpCGw+DfvwA==
X-Received: by 2002:a05:6a00:2790:b0:737:9b:582a with SMTP id d2e1a72fcca58-742a98de014mr39044316b3a.24.1747978352881;
        Thu, 22 May 2025 22:32:32 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a982a0a4sm12474336b3a.101.2025.05.22.22.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 22:32:32 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 22 May 2025 22:31:27 -0700
Subject: [PATCH v16 24/27] riscv: create a config for shadow stack and
 landing pad instr support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-v5_user_cfi_series-v16-24-64f61a35eee7@rivosinc.com>
References: <20250522-v5_user_cfi_series-v16-0-64f61a35eee7@rivosinc.com>
In-Reply-To: <20250522-v5_user_cfi_series-v16-0-64f61a35eee7@rivosinc.com>
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


