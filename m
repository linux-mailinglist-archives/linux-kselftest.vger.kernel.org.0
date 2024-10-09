Return-Path: <linux-kselftest+bounces-19275-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50780995A5E
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 00:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C8012848EE
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 22:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5754B21BAF5;
	Tue,  8 Oct 2024 22:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="VQtbSfnZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB94A21B45E
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Oct 2024 22:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728427092; cv=none; b=blzQsARu0W0PpDr+ceqDYkUQI5aV674wuNjrJP5GFUjfBA/S+s5BqwUUjMiLWizRgfKzu6xrZCjD6BF5/xwqr0cQqrr5SHcQusJD5/SjwLHQwViurrxxfhYsYE4H3DJHet7pM2fHK5kzpNRW0OGcUk3nw8OgGpye1qt/1P9++1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728427092; c=relaxed/simple;
	bh=5wvgfV3/LATz8X0I96JuzGDO0PbGn97k4UaoFuqOub0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gq0Lo/ouvIWAJrLZx++TsGoRNQEMgytPVkzuByJ950amYXW160FJKgTzAHHrkzohhBAGgQCwoTUOAFIfuMyxJalKuK2YUo2szcQEn61xi5r8LgTP80G05RqET/8xNTRxmNGZT74kOoGL4rc2EmaBf/d6LxG4+r0XxkxPhE2lI+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=VQtbSfnZ; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-656d8b346d2so4005699a12.2
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Oct 2024 15:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728427090; x=1729031890; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1PgKK5psJ4uqI8azQmoLe2esobQYgrwfNA+bFUurkQQ=;
        b=VQtbSfnZeykqjNM3vvZs3e3lOe4CAYtM4HIXxDz10txttyY6nk6TUXsQ9yHNpzkW+8
         4RCVvW+jfxtVQ+sA9uP7m73xR2qy4Tn/MEFjvXMY11Vt3V4jTtx6ZJ7iEKV5vPjduH2Q
         BzN6QyvtnaAPHBPVko9+AoUfS/vL6o4sSLpVrnEt3jfc5UX05PhWcaqvNOA9FcE54K2B
         oQVrqkNG6ypvMHPS2pQkZF9LyTfAxnwdk9COivbyLS78VXCsjGLxUejZJbcEEybQavzg
         YVPY2eezbjtaNAIyfuZTBJQEQ+qrQThsL5tp3zS5M9n01VyFhGnky+Zbe17JAh/8XrjI
         HXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728427090; x=1729031890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1PgKK5psJ4uqI8azQmoLe2esobQYgrwfNA+bFUurkQQ=;
        b=bscQyrcS1s1rA+RLFVYbFqtDKWkVQNjJVM0DKTr2VjNcSN1jDaVmbY7RZzpxpg6s/Z
         7e4Nz8jv6+N4AQQBpkVe2aIbMlbGW12NP4UxWj9dmVuI/xrv5fXd3pgj2ULaeQPAsuN4
         9ZyFYT55YVTiFbNCih7U3VxQS8zPsOxLoCJcvLABSS9IGvs5e10hlDEncS9r0yBqZlMq
         9sLZsuT0ZZ/rNP7E/0s0MlqUfJpzLjgO2cAe8qK5fMgE257G1oW37KBAfQpYii0gle/5
         UyHhod2aKbj6W3j2GDclQ6yW2J8MHY1Plr+7s1xsrgoFMLKb91dmPjZIBG1qJaE3qpfi
         t+xg==
X-Forwarded-Encrypted: i=1; AJvYcCULoa/Nr+/FTK6Ik+8dwNjUk52qrSIIGts7TX1RxyEJK5VwsYXuZh2zbO3vTIPqGQv2n77lVnBttr3sLmtryIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtJ6GoaGt24ssD7rHav2ePCpejXvVT1IZbAbg7wsBYfQBMn9Bj
	xkOrwLaDW2xMskeEZndnTsOD9G7clMKXG70Gh3CUY8t1cfaJfvFpNt2uVj9TcHU=
X-Google-Smtp-Source: AGHT+IFY7chdq/RlO1VqqZI5iRB44TlQ/FpJUC1y/VZKQga2d2VHN1qSiIxLmjb9SvMQ9TpE0KT+Pw==
X-Received: by 2002:a05:6a20:9f9b:b0:1d7:f7d:5cf3 with SMTP id adf61e73a8af0-1d8a3c1d7c4mr777890637.25.1728427089845;
        Tue, 08 Oct 2024 15:38:09 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0ccc4b2sm6591270b3a.45.2024.10.08.15.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 15:38:09 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 08 Oct 2024 15:36:50 -0700
Subject: [PATCH v6 08/33] riscv: zicfiss / zicfilp enumeration
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-v5_user_cfi_series-v6-8-60d9fe073f37@rivosinc.com>
References: <20241008-v5_user_cfi_series-v6-0-60d9fe073f37@rivosinc.com>
In-Reply-To: <20241008-v5_user_cfi_series-v6-0-60d9fe073f37@rivosinc.com>
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
index ce9a995730c1..344b8e8cd3e8 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -8,6 +8,7 @@
 
 #include <linux/bitmap.h>
 #include <linux/jump_label.h>
+#include <linux/smp.h>
 #include <asm/hwcap.h>
 #include <asm/alternative-macros.h>
 #include <asm/errno.h>
@@ -180,4 +181,16 @@ static __always_inline bool riscv_cpu_has_extension_unlikely(int cpu, const unsi
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
index 46d9de54179e..10d315a6ef0e 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -93,6 +93,8 @@
 #define RISCV_ISA_EXT_ZCMOP		84
 #define RISCV_ISA_EXT_ZAWRS		85
 #define RISCV_ISA_EXT_SVVPTC		86
+#define RISCV_ISA_EXT_ZICFILP		87
+#define RISCV_ISA_EXT_ZICFISS		88
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index c1a492508835..aec3466a389c 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -13,6 +13,7 @@
 #include <vdso/processor.h>
 
 #include <asm/ptrace.h>
+#include <asm/hwcap.h>
 
 #define arch_get_mmap_end(addr, len, flags)			\
 ({								\
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index b3a057c36996..70803aa66332 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -317,6 +317,8 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 					  riscv_ext_zicbom_validate),
 	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicboz, RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvcfg_exts,
 					  riscv_ext_zicboz_validate),
+	__RISCV_ISA_EXT_SUPERSET(zicfilp, RISCV_ISA_EXT_ZICFILP, riscv_xlinuxenvcfg_exts),
+	__RISCV_ISA_EXT_SUPERSET(zicfiss, RISCV_ISA_EXT_ZICFISS, riscv_xlinuxenvcfg_exts),
 	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
 	__RISCV_ISA_EXT_DATA(zicond, RISCV_ISA_EXT_ZICOND),
 	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),

-- 
2.45.0


