Return-Path: <linux-kselftest+bounces-43243-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B58BE023D
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 20:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC1953A9099
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 18:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2924369985;
	Wed, 15 Oct 2025 18:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="JqIG/3XF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD503570DD
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 18:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760552082; cv=none; b=VbEZ4BkxXgPAaLEPcOKw9PcO14h5BYpFg8Xj+WBmts5Quj2srY2nd6iBxhIytIkLR7+EK2jKRF/KhKIVNtGp4CyCX3Dq4p9kg5QuEz+Tqw7HgG1N5DlHTC2aXJkCbnrnT3ubOuOdd9YqWgXcYIjfgfnBllgMFXpe02LSJ8EHsLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760552082; c=relaxed/simple;
	bh=zp1GtZ2xtYk4tzcgCMIiTQFkQH3SwEi1+kZi/xCoKAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N7eiKO3xtDSW/LYGjGqX+a9jl4t8YreNANFiUhT1FZKuZZNLb5o+jlILNqI3FULrW+mfOYK21CIXaePlUamLRD+Nwo1b1FSwyHo6NI3r8hZRpFuVnCDC6CN2xPnIZRbC1xzpRdgTCWHz7mCrnZWZXlW8vRWS8PxBHWwJR99IU5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=JqIG/3XF; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b62e7221351so5671983a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 11:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760552080; x=1761156880; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dbof0LYINd4D+dAMCbCh8LGflH6StFg2c2dYAuc2+YY=;
        b=JqIG/3XFXRZ2mzFU5uXGN758RTkfJ0QiC0qCd1562YsaFP3evnevukX69sq6ZVOktt
         3wx4c1h7Pnm8fMxWEojQtSh3N6jmNw/+BQNtMKoZj6/vAfW/41n4lxg1gh/ew1WMn1LZ
         zvaChlDH7M6Rck6O7EWLVzzqaSaEUGoTFgWF6T9P7JhX1EXqpo9zqI8NqaPLJ5nAHy/O
         z+5dr3dS2JJX6uKqGm+d/L6H60KFS8wCGfNuLMyRIgYUC5Ad/GTJD7lZmwxgCPNJl0Wk
         3UTvu7/yazxTPHX4ms3lWg8mCz7I0jSqsIMdka1CvrsEPFQfDOg89Odsf7MTCLvZZJyQ
         viQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760552080; x=1761156880;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dbof0LYINd4D+dAMCbCh8LGflH6StFg2c2dYAuc2+YY=;
        b=B1hGK+oFki7xY7js3j6fdgL4hy2EHY+g8mx8w0asW5mkCipknuYmmgQ8ZKYwBSSmrJ
         i3ecB+OBWzVDnBq0YMgKTDfWqNgkrXPOiHP1DtORwB1jcu0k2NSQAqJPkw0hnphFUDsN
         t97csTS/7STpTs2FFhV72CcCRByBdE1Hk/PcK4RFGDfcBnmYISjjpdgTR8PrrKtl5KPZ
         Iu3sSAjJ/OYheVQpV2LUJ6oRnfflIrn6MHp+XJxyGh1Liggd2f+yQtqQEQX6+CbNotEJ
         vpvyIsntp/sRoZOz/5MnVApZxTQxFGmoToEFPMccpLL2abH6E80ifyY1Wrk+L1IbCpwn
         BFYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1+HovC3bKvu83Nq+Z8Xwlo8Hdg6y8GiBHST4GxP+fA726FRH/vdmCVFeBX3yxJRMVNX1SlBd/S4NdxrWr7gc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFLbthn0GzTVGRpwUsrlhL+r7aSlkPIFWliqT95Vdc33jvuUc1
	vP3VAtqL1AFzK2LzbSBA1jlPvxSGRTDAD4YEIgTXv3WMTJuYpSHUiY2ZT3EnuGPZ4n8=
X-Gm-Gg: ASbGnct/nilWgGDhLdufw7VEF6lB8N8QSn86OY8U1WrweGUqYQojO632g5+g2IfybhT
	7Srdml4rFOfsBxxfVXEIxtXl+fYiFYCQ7WhzVjxHGpZQ/g61l7ANMxONFlBgTjaQKeyvbm+0Ksb
	T/AWFDFrzr+0XiPZ81Gl8zda6rn/7lSFhoKVcQABYo8YpCR2N4k1UNFwXANHZeOxXLGtrpct95e
	OGpRcOnnxZDDlp0FNIMi7h3THX8ouZaD7Wlq/0wVgoY3SvbdHWZvIosU52Ahq72f9h/bedMT/a6
	XyEk0O3gChWKELibcNOmcEGvHVvLtmlAF1Qf5yrg6t7sc4uEsVGfyekNDunEYIdlWLt3hzQD8HE
	hgZ2V4A8+tI9bm7TPW2ZmIsArIntIUk1EUSdMOagkhE1U3bx5r9sE4PzceaWlklNcrH+2akyB
X-Google-Smtp-Source: AGHT+IGAsBeXLYnUBeSk4VeBAeMiRCSfs4dgrhVgQ7j/hrfP/0NXVnhFuxrL4cfJn2DM39e7oP4gDw==
X-Received: by 2002:a17:903:1aef:b0:250:1c22:e7b with SMTP id d9443c01a7336-290272e3a78mr384355745ad.43.1760552080319;
        Wed, 15 Oct 2025 11:14:40 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909930a72esm3126625ad.21.2025.10.15.11.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 11:14:39 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 15 Oct 2025 11:13:57 -0700
Subject: [PATCH v21 25/28] riscv: create a config for shadow stack and
 landing pad instr support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-v5_user_cfi_series-v21-25-6a07856e90e7@rivosinc.com>
References: <20251015-v5_user_cfi_series-v21-0-6a07856e90e7@rivosinc.com>
In-Reply-To: <20251015-v5_user_cfi_series-v21-0-6a07856e90e7@rivosinc.com>
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
 arch/riscv/Kconfig                  | 21 +++++++++++++++++++++
 arch/riscv/configs/hardening.config |  4 ++++
 2 files changed, 25 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0c6038dc5dfd..aed033e2b526 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -1146,6 +1146,27 @@ config RANDOMIZE_BASE
 
           If unsure, say N.
 
+config RISCV_USER_CFI
+	def_bool y
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
+	  default n.
+
 endmenu # "Kernel features"
 
 menu "Boot options"
diff --git a/arch/riscv/configs/hardening.config b/arch/riscv/configs/hardening.config
new file mode 100644
index 000000000000..089f4cee82f4
--- /dev/null
+++ b/arch/riscv/configs/hardening.config
@@ -0,0 +1,4 @@
+# RISCV specific kernel hardening options
+
+# Enable control flow integrity support for usermode.
+CONFIG_RISCV_USER_CFI=y

-- 
2.43.0


