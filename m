Return-Path: <linux-kselftest+bounces-19270-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0A1995A3C
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 00:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A55BF2865B1
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 22:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D03C218D6C;
	Tue,  8 Oct 2024 22:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="AGQ46eIn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D042185A3
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Oct 2024 22:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728427078; cv=none; b=Yiwryma6n5pTkOcDqVPFXbuxyGLJ+uyu+fvHb94KSKHHLXQcR+XdVs6tdRplGCtBNA1jsR4C48JTsP2xmmtcNFRrglXE8fV4mRJnzJ57KgxZSOYit7d6Lv/4LlBA7oYLapKa6mnZ0rHWx/BfbxUQcwSq1p/d7eojZCUbaqPLHzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728427078; c=relaxed/simple;
	bh=RTYbtz2cge2Cz64b5zkB/emGlgKn9LjHJOHc4M2L1Rk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j2+h2PkhHCsOR5loLsLU1gFpfeCuHZ9HJyhnXVRavRVzubrEjjj3CaHX1Fc58lIzGP1lJIMhWt+tWQAJ6/TR63ZDkfEoVgZ6mPVkCrcs9PdZzzfzkL0oBxb/92+JVHUDO+cNkwMJkg/vgpi+43SEWJLYyDpEjs4mwXoSGgw65L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=AGQ46eIn; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71dff3b3c66so1962926b3a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Oct 2024 15:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728427075; x=1729031875; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TN/jwUyrk7nWeXz+2PkcX9PcP6JH0CIrLV6B3SOl4g0=;
        b=AGQ46eInfupokNz7qTkiVsA15Fkud2xN4W+SOZ0XzLMvl9ki6479LW4tkhbotoVyj7
         tPnWnxiSKqOFOzG/7AyTQHsH/13Rgb02tO/+vruJU14bjVt5vmCAAkVCaRGIfaYaDyUz
         gg6ZfeBZzNaJCRlQblIwHRw1QkfeQ7IeSsyCF34kaK+vUaNg75A0xrXj93t8QVLyr9ON
         kKVhYIXUMVIXOq/iWxQaOW2kbHGJXcTjM7ByEvm3Ceci5i89yThgxeGWvMUoESJViIG1
         hEMVD+P3C/dpB2v4m3CkWOGVuQBYYJjyvogcrRGJhAnqI6wwbemP1Xs6ga12wiwGG9ZV
         i1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728427075; x=1729031875;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TN/jwUyrk7nWeXz+2PkcX9PcP6JH0CIrLV6B3SOl4g0=;
        b=XmlpSff+lY32C/Ea/E2rY+0oP5Hm2jbAlL2kAI3Ix4CQAJKnx5QzEr7h3UgpJxQtk1
         gTuRf8cNtkhdXI09EE5gPuJN7+NBCrsoJN/oW3SSoI1fsoW2By4OqfRg61VEEcOERPbe
         +bwufyWl00LWrIJsGnonA8gfyGkU5eyaATpJY4UR31dvfbjwRkuC5nbkXSEEuVSUUf3Q
         Qf3ypHLI2SHvgPb6v/mMPVmKfdmYQzVfHMDVPpBgqREOMp+LZagBsnvaMJzt4ZWT2ahj
         JIXIfGgcAVubjhbbLb5RRzATTK+fTWYoLL1Bu1htWxmHk49qgD5HyLt1RXnibguA8YZp
         oyAw==
X-Forwarded-Encrypted: i=1; AJvYcCW7106bHDhcCzHfHX1Fx0aa2B/ja5VH4SoTt9Yn+4cwEDlRTpK1i8OKqi5T35jrGyEYg5FhBiDGN/p8ws7CEyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB7bbGSrPZ9gOsJ/+ZJgD9C4H3mr/Lq5Izss2VZ6UmpLvhc8lq
	IviVPCKGlazkrzlQw0Shl/tKKoCYjyVohloZGHI6e8T/DFkXdCF3VkbXu5p9nGQ=
X-Google-Smtp-Source: AGHT+IHjrWqEH6M+PTKFju9GDA7ag0b13dl3Gb4hkRJRFQ30q32KWOk48b2V/zigaYM7P+HHrQ7gww==
X-Received: by 2002:a05:6a00:1310:b0:71e:620:8e0a with SMTP id d2e1a72fcca58-71e1db65b25mr707008b3a.5.1728427075480;
        Tue, 08 Oct 2024 15:37:55 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0ccc4b2sm6591270b3a.45.2024.10.08.15.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 15:37:55 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 08 Oct 2024 15:36:45 -0700
Subject: [PATCH v6 03/33] riscv: Enable cbo.zero only when all harts
 support Zicboz
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-v5_user_cfi_series-v6-3-60d9fe073f37@rivosinc.com>
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
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Andrew Jones <ajones@ventanamicro.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.0

From: Samuel Holland <samuel.holland@sifive.com>

Currently, we enable cbo.zero for usermode on each hart that supports
the Zicboz extension. This means that the [ms]envcfg CSR value may
differ between harts. Other features, such as pointer masking and CFI,
require setting [ms]envcfg bits on a per-thread basis. The combination
of these two adds quite some complexity and overhead to context
switching, as we would need to maintain two separate masks for the
per-hart and per-thread bits. Andrew Jones, who originally added Zicboz
support, writes[1][2]:

  I've approached Zicboz the same way I would approach all
  extensions, which is to be per-hart. I'm not currently aware of
  a platform that is / will be composed of harts where some have
  Zicboz and others don't, but there's nothing stopping a platform
  like that from being built.

  So, how about we add code that confirms Zicboz is on all harts.
  If any hart does not have it, then we complain loudly and disable
  it on all the other harts. If it was just a hardware description
  bug, then it'll get fixed. If there's actually a platform which
  doesn't have Zicboz on all harts, then, when the issue is reported,
  we can decide to not support it, support it with defconfig, or
  support it under a Kconfig guard which must be enabled by the user.

Let's follow his suggested solution and require the extension to be
available on all harts, so the envcfg CSR value does not need to change
when a thread migrates between harts. Since we are doing this for all
extensions with fields in envcfg, the CSR itself only needs to be saved/
restored when it is present on all harts.

This should not be a regression as no known hardware has asymmetric
Zicboz support, but if anyone reports seeing the warning, we will
re-evaluate our solution.

Link: https://lore.kernel.org/linux-riscv/20240322-168f191eeb8479b2ea169a5e@orel/ [1]
Link: https://lore.kernel.org/linux-riscv/20240323-28943722feb57a41fb0ff488@orel/ [2]
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Deepak Gupta <debug@rivosinc.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---
 arch/riscv/kernel/cpufeature.c | 7 ++++++-
 arch/riscv/kernel/suspend.c    | 4 ++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 3a8eeaa9310c..e560a253e99b 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -28,6 +28,8 @@
 
 #define NUM_ALPHA_EXTS ('z' - 'a' + 1)
 
+static bool any_cpu_has_zicboz;
+
 unsigned long elf_hwcap __read_mostly;
 
 /* Host ISA bitmap */
@@ -98,6 +100,7 @@ static int riscv_ext_zicboz_validate(const struct riscv_isa_ext_data *data,
 		pr_err("Zicboz disabled as cboz-block-size present, but is not a power-of-2\n");
 		return -EINVAL;
 	}
+	any_cpu_has_zicboz = true;
 	return 0;
 }
 
@@ -919,8 +922,10 @@ unsigned long riscv_get_elf_hwcap(void)
 
 void riscv_user_isa_enable(void)
 {
-	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_ZICBOZ))
+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICBOZ))
 		csr_set(CSR_ENVCFG, ENVCFG_CBZE);
+	else if (any_cpu_has_zicboz)
+		pr_warn_once("Zicboz disabled as it is unavailable on some harts\n");
 }
 
 #ifdef CONFIG_RISCV_ALTERNATIVE
diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
index c8cec0cc5833..9a8a0dc035b2 100644
--- a/arch/riscv/kernel/suspend.c
+++ b/arch/riscv/kernel/suspend.c
@@ -14,7 +14,7 @@
 
 void suspend_save_csrs(struct suspend_context *context)
 {
-	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_XLINUXENVCFG))
+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_XLINUXENVCFG))
 		context->envcfg = csr_read(CSR_ENVCFG);
 	context->tvec = csr_read(CSR_TVEC);
 	context->ie = csr_read(CSR_IE);
@@ -37,7 +37,7 @@ void suspend_save_csrs(struct suspend_context *context)
 void suspend_restore_csrs(struct suspend_context *context)
 {
 	csr_write(CSR_SCRATCH, 0);
-	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_XLINUXENVCFG))
+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_XLINUXENVCFG))
 		csr_write(CSR_ENVCFG, context->envcfg);
 	csr_write(CSR_TVEC, context->tvec);
 	csr_write(CSR_IE, context->ie);

-- 
2.45.0


