Return-Path: <linux-kselftest+bounces-26237-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8C3A2FA90
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 21:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B22F61883390
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 20:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76883262145;
	Mon, 10 Feb 2025 20:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="k0WpeWPa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE76426138B
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 20:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739219259; cv=none; b=m0CSss2Lme/kFCwbIwfvve7YP8JeH8t5tkw0IiYNj/73y0ut1GSIeu0e89wKsmnHXC6VTbIBIoObZbswkgZoOWCO687bz21C8kjINBmwwSisdvw0xgGuVQ4P8NUup428W21LrS5hb2pzr4ModqGIdoblgIrhQtCCHNds3LujfUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739219259; c=relaxed/simple;
	bh=zWvCMjEUr0fm2YGOtkO5JQMRJ3MfHFejTQpY2YYRpeI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uRX/4ltmcj+1G4orjawe0sc9k+4nK2T2fYPhp1w+JkHyIc/CcylIHrtgNfhK+bZyLOLlJORKMgEMIbkC8ZLXa6oLtdlQ7Q3kl5kwGoGQSqsKRetu+qpqjqKBMmleH4PNHCMy6JfUeHaLIYFL7JG+OyjUJavQRQn3DhbCIvZQ4dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=k0WpeWPa; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f573ff39bso66572355ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 12:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739219257; x=1739824057; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=opxHamP1ejpgUrZttGLg4zwDHWHLF3xPs1/Qb/08WRM=;
        b=k0WpeWPaq8hgRQ9Ha2rVV/0mN9SFOGihKHVgQuw5DyqHjJ/dZ6ylpIjBcQLLONeKBJ
         yh9V0PiBX5YOLho1qfXolkqnX1SG/JZLulhHuU7UDizs/hd0kJ9L/pbfBcAYYo4ohVbx
         QCuE/yKnPqu5eUFUQXVajbu+zhfqDWMsQ2vsAv05p/BsnRuVwlWKN/SunCVcVRF5Zfbl
         X1oO2F24x0ZMOFnTgP5FbskCaTsBWWEYKZtQKFCu8cRmF15g02/9JWcdTEMj7pWjQM6p
         3FzhE6p/CwqAlGxvAySnQZX8EzycDtPfGIQhwEYrMdKLcvGN1tdAT3TE7hBTusK10Vdx
         +uZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739219257; x=1739824057;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=opxHamP1ejpgUrZttGLg4zwDHWHLF3xPs1/Qb/08WRM=;
        b=jRNc/7JOXGkreli3ZdrAcS4wOSNWEQj0GziixdXhVg7oakqP/6IX7LMlivjyzWfINn
         ywmXHfLncSCgJ/PbqCAZQWMeakkcDw2A4sA71D/phW6i2MKX70hSu9iDKbTka0n4Nc7L
         5H/3WBk7vsGfrr7mDOZzvH0DfmkXQfuwiy2hCVTH4zDQ8ZUarwZ4ovPl9O+Yw1FIxJ1k
         H31BYsz+HiW1j7WPY5VvEEzQCivKp0DTXtfQcfQF2+VpfvE9n+4+OELqpFs7FhN8Aj4e
         L/Xm0Sb65ise2R5Jv/oVrq2bclOXHVg9FBHDLsi0jEQVcek5G5mRgiFl4myhMaEOdx/v
         mrYw==
X-Forwarded-Encrypted: i=1; AJvYcCWmUM4l/OFC8m/vcS+8NWSwn1v6DXHngvDrlTQLNJRBR/rE0aL32185jNPFG3hOFKjd313VigqwzeyejmlA98k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1DVu7FaxPkxoVAgVYpvGQqwOJ1qLx1L5NmlULzG772X8c6fPs
	pSJMCAKmwPmqHxsBA10aAsxeEK20QO6ckRs534CV0zZ9ZbI+tiYFpYmNR8GWVDE=
X-Gm-Gg: ASbGncvdfOZ8kkga0tNaFEPmdw4azttKqE4G4I4lpBsMxFnKh5TPlV+mauysB96p4ds
	itbAuvuwLy+wy96xGsq43iNhNOYSSdYT0u0ApVvLiiCNe0b0PAkVfBQV7AznZanIWFfX2e5icCE
	1o81jLmEOZAdBkRiph8BfdYwqT3NiaFwGO1FiFuTw0r7huAgmP50fJLPrnorxjZ3NNyMrx3r6mU
	guVIjRvnX5A7dVNeG6ZiATH8dlpTQxo7KIl8gNLrjmmzJKamIgfTbKjtdQY44UXRmfa3iY3V56H
	2ed08HMoS4zLOwtJrafQz62Y1A==
X-Google-Smtp-Source: AGHT+IF/dAuKVSsF4xfi2H6sG4wlPlN+BXXOHG9nKEFkchqxVssSaBrEBlASEgV9299c+TKy14VoKQ==
X-Received: by 2002:a17:902:c94c:b0:216:1543:195e with SMTP id d9443c01a7336-21f4e1c8978mr260581855ad.5.1739219256955;
        Mon, 10 Feb 2025 12:27:36 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687c187sm83711555ad.168.2025.02.10.12.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 12:27:36 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 10 Feb 2025 12:26:55 -0800
Subject: [PATCH v10 22/27] riscv: kernel command line option to opt out of
 user cfi
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-v5_user_cfi_series-v10-22-163dcfa31c60@rivosinc.com>
References: <20250210-v5_user_cfi_series-v10-0-163dcfa31c60@rivosinc.com>
In-Reply-To: <20250210-v5_user_cfi_series-v10-0-163dcfa31c60@rivosinc.com>
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

This commit adds a kernel command line option using which user cfi can be
disabled.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/kernel/usercfi.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
index 6e561256bfaf..be08e5bb6e62 100644
--- a/arch/riscv/kernel/usercfi.c
+++ b/arch/riscv/kernel/usercfi.c
@@ -17,6 +17,8 @@
 #include <asm/csr.h>
 #include <asm/usercfi.h>
 
+bool disable_riscv_usercfi;
+
 #define SHSTK_ENTRY_SIZE sizeof(void *)
 
 bool is_shstk_enabled(struct task_struct *task)
@@ -390,6 +392,9 @@ int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status)
 	unsigned long size = 0, addr = 0;
 	bool enable_shstk = false;
 
+	if (disable_riscv_usercfi)
+		return 0;
+
 	if (!cpu_supports_shadow_stack())
 		return -EINVAL;
 
@@ -469,6 +474,9 @@ int arch_set_indir_br_lp_status(struct task_struct *t, unsigned long status)
 {
 	bool enable_indir_lp = false;
 
+	if (disable_riscv_usercfi)
+		return 0;
+
 	if (!cpu_supports_indirect_br_lp_instr())
 		return -EINVAL;
 
@@ -501,3 +509,16 @@ int arch_lock_indir_br_lp_status(struct task_struct *task,
 
 	return 0;
 }
+
+static int __init setup_global_riscv_enable(char *str)
+{
+	if (strcmp(str, "true") == 0)
+		disable_riscv_usercfi = true;
+
+	pr_info("Setting riscv usercfi to be %s\n",
+		(disable_riscv_usercfi ? "disabled" : "enabled"));
+
+	return 1;
+}
+
+__setup("disable_riscv_usercfi=", setup_global_riscv_enable);

-- 
2.34.1


