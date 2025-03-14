Return-Path: <linux-kselftest+bounces-29078-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EA4A61E86
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 22:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C31BD884FAC
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 21:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71B2205ADC;
	Fri, 14 Mar 2025 21:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qMt/wtYd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C93205E16
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 21:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988377; cv=none; b=HLVpdOiN7M8Ku2rXGJfyr5/7Rqz5njuduw8DnPl69KikJ1do4/eoLOlHxgZMD6gVDi/H6IuO+qtKoHlGqNwrxNXRIG5mppf6rbnQ79MfEAfyFqJoG90YpgnJNYzq7JP+Uq3oVATSJlLoe39IgJQTpAIsSfjkjhgwUh+SIYFFb9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988377; c=relaxed/simple;
	bh=P/oe+SRurodsNA/QyDfdYClTVdValzkaQJuC5iIj12k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mzP3yb4byppjcDJuF5PiTEU+wFyONeY1lP4uNLqTWttx8x1Y1Ar4uZqWxCeehcB/6XAUXH9ZfrGlUDJsq3scPjaXP1XWgX5Uu1q3MGWH9nJgVWQFzjA4DuHoiV7ZsLQMPkPaKVHviwMxpGKomul2rWPu3WaM8vQr0qH6jZCB0sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=qMt/wtYd; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22398e09e39so55797445ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 14:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741988375; x=1742593175; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2gHC+OQH/HyLVaEB8d5yyptpM2IOJ5Z6rZqVaRKPZQE=;
        b=qMt/wtYdUZLKSeDUXPlXSe/ddLg1JmGRGRuFN9PZ8FDAom4aNHi7cMSSJmsY2W1FjL
         4+9ApJQk+eOrtJdbwJ+YDwW7EkDLlq4md700djyE6HzfbVOLH/+xSGtDRMfBkV9LzpN0
         UHpYHu+0g/RHnB3onfGVZW3/bVHC93iEce4Iyxyoe6LvXKKQayxHV9Nb3hzR6fYlnAhL
         g1aG9ELnq3NsgL4njb6usoK93zgSr9HTtBtzPvGyJvLkrP6t1yofwXRbbEdwZxIR70qg
         PN1NyQen1tLZh+qdq6PZ2xU6uhh9+9+KH4aawaiAlcLD2ToCwq/jZnahRjH9A25zu6z8
         JFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741988375; x=1742593175;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2gHC+OQH/HyLVaEB8d5yyptpM2IOJ5Z6rZqVaRKPZQE=;
        b=C+v3qWlo0dwNxkBC9Kagsfo2Z+YRQdRA9FjQVVPEfjMcTDkbyRxduwVT76cWWfeh/8
         HXRiTr2SK3A6i2bgPwZqZeLCEs947OBYtkXLtR83Dj3cYcJHHy7IkOn6gQxpgLha35p4
         T1gj+uR7S5/xYTqZl5JtHLU/Ws2ajxgn48Jas0Ks+ABOy/HZGELGsFOJ8KNKzuVZigRg
         W4gqRVoVZruYodrAYUM4RbB9/bwq4U+47M7Ht8v6tjc8c9qaLPNbMi5V3ZuMcdgQAHrv
         lcQV5U8trQ86KGWXko9HRQdEgTlpg+c5pGTzyfMyxRSpMyrGiG9T0GnH4FlGkWDTLYm0
         Rr8A==
X-Forwarded-Encrypted: i=1; AJvYcCXtEIvZPWxM9Ux5E6DMvld8STqZKGYGShYDZjgWq3roivslL2Y3Rk0K209UVdSRHv4y4sXfd5oH99aFr6BKCuk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5hyXewOP5IypbVEmaws+S/7TBbYVNhJ2qD5DZXMCfXWpKDsie
	O7B9SMD1Onk5xfRSk4ILtQ2Q2FWW0ks9FfVfH7uXmeeMIv/T1zYhA/uLQDNst60=
X-Gm-Gg: ASbGncvWR74kT/2NTEXLryHb7o1TfgV8oTBcHFhdYIhQoi0QpfPjjPUo6TyC0JZ+m2/
	x/yi0HKjIzdT11Zdkkg8sO1TcFvabMM4dW6D9WJASuOmUwtcXqqu4+x+M9S5xVgZ4G9U+wD2EPA
	nJW4t4EP52mzC5l11zyk1iu+00ix9GeNCr9pduftT9kzYE77DdS+cWvTYaoOOwmhIj2859nd+qg
	Y+otLBrx+39gMyi6V9jfuvR1ehWMw4xwTXqnJJW+s7LoFBqtzhKoLMpzRRjeZBD2GOsOkggJwQ3
	HN85h0PTu5cmrDLLYW884cmW4VZ1Inv9qrnawezawBHE/xORUkTzFAo=
X-Google-Smtp-Source: AGHT+IHvHW2W/QvmAtTQpnpsWWRaM1HH0j3AoAcqaAS/SF4n712ckDXuPjUXwXP+UZCTKkiG9rvh0w==
X-Received: by 2002:a17:902:f54c:b0:224:1935:fb7e with SMTP id d9443c01a7336-225e0a75439mr57801355ad.24.1741988374981;
        Fri, 14 Mar 2025 14:39:34 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a6e09sm33368855ad.55.2025.03.14.14.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 14:39:34 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 14 Mar 2025 14:39:22 -0700
Subject: [PATCH v12 03/28] riscv: zicfiss / zicfilp enumeration
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-v5_user_cfi_series-v12-3-e51202b53138@rivosinc.com>
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
In-Reply-To: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
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
 rick.p.edgecombe@intel.com, Zong Li <zong.li@sifive.com>, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

This patch adds support for detecting zicfiss and zicfilp. zicfiss and
zicfilp stands for unprivleged integer spec extension for shadow stack
and branch tracking on indirect branches, respectively.

This patch looks for zicfiss and zicfilp in device tree and accordinlgy
lights up bit in cpu feature bitmap. Furthermore this patch adds detection
utility functions to return whether shadow stack or landing pads are
supported by cpu.

Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/cpufeature.h | 13 +++++++++++++
 arch/riscv/include/asm/hwcap.h      |  2 ++
 arch/riscv/include/asm/processor.h  |  1 +
 arch/riscv/kernel/cpufeature.c      | 13 +++++++++++++
 4 files changed, 29 insertions(+)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 569140d6e639..69007b8100ca 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -12,6 +12,7 @@
 #include <linux/kconfig.h>
 #include <linux/percpu-defs.h>
 #include <linux/threads.h>
+#include <linux/smp.h>
 #include <asm/hwcap.h>
 #include <asm/cpufeature-macros.h>
 
@@ -137,4 +138,16 @@ static __always_inline bool riscv_cpu_has_extension_unlikely(int cpu, const unsi
 	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
 }
 
+static inline bool cpu_supports_shadow_stack(void)
+{
+	return (IS_ENABLED(CONFIG_RISCV_USER_CFI) &&
+		riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_ZICFISS));
+}
+
+static inline bool cpu_supports_indirect_br_lp_instr(void)
+{
+	return (IS_ENABLED(CONFIG_RISCV_USER_CFI) &&
+		riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_ZICFILP));
+}
+
 #endif
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 869da082252a..2dc4232bdb3e 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -100,6 +100,8 @@
 #define RISCV_ISA_EXT_ZICCRSE		91
 #define RISCV_ISA_EXT_SVADE		92
 #define RISCV_ISA_EXT_SVADU		93
+#define RISCV_ISA_EXT_ZICFILP		94
+#define RISCV_ISA_EXT_ZICFISS		95
 
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
index c6ba750536c3..82065cc55822 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -150,6 +150,15 @@ static int riscv_ext_svadu_validate(const struct riscv_isa_ext_data *data,
 	return 0;
 }
 
+static int riscv_cfi_validate(const struct riscv_isa_ext_data *data,
+			      const unsigned long *isa_bitmap)
+{
+	if (!IS_ENABLED(CONFIG_RISCV_USER_CFI))
+		return -EINVAL;
+
+	return 0;
+}
+
 static const unsigned int riscv_zk_bundled_exts[] = {
 	RISCV_ISA_EXT_ZBKB,
 	RISCV_ISA_EXT_ZBKC,
@@ -333,6 +342,10 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicboz, RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvcfg_exts,
 					  riscv_ext_zicboz_validate),
 	__RISCV_ISA_EXT_DATA(ziccrse, RISCV_ISA_EXT_ZICCRSE),
+	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicfilp, RISCV_ISA_EXT_ZICFILP, riscv_xlinuxenvcfg_exts,
+					  riscv_cfi_validate),
+	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicfiss, RISCV_ISA_EXT_ZICFISS, riscv_xlinuxenvcfg_exts,
+					  riscv_cfi_validate),
 	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
 	__RISCV_ISA_EXT_DATA(zicond, RISCV_ISA_EXT_ZICOND),
 	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),

-- 
2.34.1


