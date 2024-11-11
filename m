Return-Path: <linux-kselftest+bounces-21802-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F16119C4743
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 21:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 818731F21321
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 20:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DF31C1F2A;
	Mon, 11 Nov 2024 20:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="temjL06W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A491BE23C
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Nov 2024 20:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731358448; cv=none; b=jPp3IInfh3ikTaLzOYQZj4NVIqZxyclbBr42AYCbPg1zFwcqt1UJ8mQUsbsDh3PpT1GdMTkCrFEVi2dyl2xeweO9pN46F7gy1kN1zDNiD9QBoxI1oLyGB9ZPWKcMgreq00mIBLXvyT2O4o8er/fH/xfU5qHCoNBd/IIsAkTI+UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731358448; c=relaxed/simple;
	bh=K/NMbZl7U/jSNoq5PHO4rj+dcshoY2ftgT6QfOev46c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SOC3QxkXVlUaN7ic1tu8znD10SSfrA2uwoX1VkgQagmareq/Qn9Xcd5beEcojd9Xb0CuTnA+zQ1acfOZZ2KTP8wnvqeqLKmKW4gpE1+jHZgGmcRBPXCXopC6/GBdHUwQFKB3IYHRyLBG3aGH/DL/M2VatOyGFsd12g1wFqGGepc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=temjL06W; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7e6d04f74faso3427908a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Nov 2024 12:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731358445; x=1731963245; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kCloQ3kpRaUIw71nS1Yef0RT6Cd+Bh0EPCOA/9JkyG8=;
        b=temjL06WxnXhl+yU4sTg7NmdaJgUaOnKm8QjDrfHJ4d3adoe5U3aJO0ip5clG9m+TE
         1H3muGKC6aKs/WYEfHcK3+8UuhDv3bWtLLlXBCkT3vqhUcRbamOp/Lg5s31II7i7Wqel
         LUNAmDpneenNea7GuoqmHp/Z3AL2ZrFzT4gwOnDJUbUjH4lpXQCoOfOolD3hQLfeo9JS
         Vij0AM1ppGi0G7DX+0MZ0TWzlcJBhy7t9ks+bNl71UJama+EVQ3bTxALxlxIxWhk/z60
         Wib2h98OdV5ELyNtC/7dsqkQMw6P7lW5k0xpb7Aud0b7CFmEv+4fHbzu3C22tCnlqL5a
         twhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731358445; x=1731963245;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kCloQ3kpRaUIw71nS1Yef0RT6Cd+Bh0EPCOA/9JkyG8=;
        b=BniTk4yZoCn7BY47FaE+wV7G8Y/lChGd1+PbakOq5SUNmE8RAq4HIhSo4dpD3AaE1h
         y4DCvcznysE4IIN1yKKNGl9H6JPUuyRqn/rLL2vYvWJI4cotPPNcO8DHL2OgO4POVeD8
         8zTNLjD6L4wjSUPpKpEsRDw9yBZ2retB6LFgyfNtcfsIOYjLgt+lst8C7zhJfNuFjQyC
         yCZb1opnxcn3hAnd/uqiCj0nglt+T+Upy+/QFXsDcMW+prvaTsHAOMUa+M5Cm+F2NiUh
         yOBcTfbaeoV+eG8Z4TaS6AT6RGGZxxMNoCs5ZsSsTStN77wQ+o0LtTX4zrvD2zo3J6Td
         4l5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUidrYhHAIgHp3hVn40KpjOUihcodrlHu0Chmb7f7R6hgjNJQiNUIZDPHiK9y+2TIA+T96GjqNcHsUt2nk8KdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWIY1zKRCj4J/pl/NqMmI4T7O6C6AcAozK3CQz3Q48WJmcTclc
	vwguvsyaqI+Vx25cgQRnf9dIIgKhUBTTXO3O6ZytLH00cwfP9jVniIRcHb3xvl4=
X-Google-Smtp-Source: AGHT+IEzLgiBrXYk8UpI73d5WjrE2IsuXIp2E2P6Y/oemnmdip5WKObNchwxhppbPh61kx0lDDr4mA==
X-Received: by 2002:a17:90b:1bc3:b0:2e0:7b03:1908 with SMTP id 98e67ed59e1d1-2e9b0a57d33mr21146939a91.10.1731358445109;
        Mon, 11 Nov 2024 12:54:05 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5fd1534sm9059974a91.42.2024.11.11.12.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 12:54:04 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 11 Nov 2024 12:53:49 -0800
Subject: [PATCH v8 04/29] riscv: zicfiss / zicfilp enumeration
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-v5_user_cfi_series-v8-4-dce14aa30207@rivosinc.com>
References: <20241111-v5_user_cfi_series-v8-0-dce14aa30207@rivosinc.com>
In-Reply-To: <20241111-v5_user_cfi_series-v8-0-dce14aa30207@rivosinc.com>
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

This patch adds support for detecting zicfiss and zicfilp. zicfiss and
zicfilp stands for unprivleged integer spec extension for shadow stack
and branch tracking on indirect branches, respectively.

This patch looks for zicfiss and zicfilp in device tree and accordinlgy
lights up bit in cpu feature bitmap. Furthermore this patch adds detection
utility functions to return whether shadow stack or landing pads are
supported by cpu.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/cpufeature.h | 13 +++++++++++++
 arch/riscv/include/asm/hwcap.h      |  2 ++
 arch/riscv/include/asm/processor.h  |  1 +
 arch/riscv/kernel/cpufeature.c      |  2 ++
 4 files changed, 18 insertions(+)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 4bd054c54c21..8d12dc6c7d44 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -12,6 +12,7 @@
 #include <linux/kconfig.h>
 #include <linux/percpu-defs.h>
 #include <linux/threads.h>
+#include <linux/smp.h>
 #include <asm/hwcap.h>
 #include <asm/cpufeature-macros.h>
 
@@ -135,4 +136,16 @@ static __always_inline bool riscv_cpu_has_extension_unlikely(int cpu, const unsi
 	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
 }
 
+static inline bool cpu_supports_shadow_stack(void)
+{
+	return (IS_ENABLED(CONFIG_RISCV_USER_CFI) &&
+		    riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_ZICFISS));
+}
+
+static inline bool cpu_supports_indirect_br_lp_instr(void)
+{
+	return (IS_ENABLED(CONFIG_RISCV_USER_CFI) &&
+		    riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_ZICFILP));
+}
+
 #endif
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 08d2a5697466..f81f62b32f72 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -98,6 +98,8 @@
 #define RISCV_ISA_EXT_SSNPM		89
 #define RISCV_ISA_EXT_ZABHA		90
 #define RISCV_ISA_EXT_ZICCRSE		91
+#define RISCV_ISA_EXT_ZICFILP		92
+#define RISCV_ISA_EXT_ZICFISS		93
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 5f56eb9d114a..e3aba3336e63 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -13,6 +13,7 @@
 #include <vdso/processor.h>
 
 #include <asm/ptrace.h>
+#include <asm/hwcap.h>
 
 #define arch_get_mmap_end(addr, len, flags)			\
 ({								\
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index eb904ca64ad0..0f2c466a51ee 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -318,6 +318,8 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicboz, RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvcfg_exts,
 					  riscv_ext_zicboz_validate),
 	__RISCV_ISA_EXT_DATA(ziccrse, RISCV_ISA_EXT_ZICCRSE),
+	__RISCV_ISA_EXT_SUPERSET(zicfilp, RISCV_ISA_EXT_ZICFILP, riscv_xlinuxenvcfg_exts),
+	__RISCV_ISA_EXT_SUPERSET(zicfiss, RISCV_ISA_EXT_ZICFISS, riscv_xlinuxenvcfg_exts),
 	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
 	__RISCV_ISA_EXT_DATA(zicond, RISCV_ISA_EXT_ZICOND),
 	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),

-- 
2.45.0


