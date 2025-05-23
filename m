Return-Path: <linux-kselftest+bounces-33632-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60ECBAC20F2
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 12:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC494501495
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 10:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ADA22B8D2;
	Fri, 23 May 2025 10:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hWsPuST9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8078227EB6
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 10:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747995727; cv=none; b=oZ62Z8h8GUogXVR518c3FHBHrOtR9IY5KaXHkDI7t4tlYH8swkT/E3AkIzPcrtWZR5TgcR7m4+mXiCBUdlT7z7yrd0Xy8Pir2UporT5IcWfuijh+McKjygW85GGcgzKSN94gcvSf8JB+EFbmy7Kc6rQdJRLJwRMvvx2t2CH9WMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747995727; c=relaxed/simple;
	bh=WrnyhIasMq6stNyEMZaWBeMPZeLi0WsnQ5RqREJagnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TNmKisjry8m7S2ETw2E8BTc78mxEYLKaLfJM0qHPHKwhgDTmO1PoF9eQR/SaRRIpUM4NFd7UCAlP6udhDoHsSG0qirXS4+3CdG3N/Qw4Lu01ZemWu4aUHltfo4bmr4S9opwwMbe8z9O6nJGDXYVIsBgFPWa2eF6KfFyH6hEVrjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hWsPuST9; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-742c96af71dso7250935b3a.0
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 03:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747995725; x=1748600525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+BbSDDHoenIJ3oteuCEH5EGHycpOZc3PIlMBGmoJPY=;
        b=hWsPuST9ePr0oAag0BP3gnLxUGbrjBRqKnYZUHvKUIc3gD7bwyc8nYFZcYtPYvc9Ua
         zv8S1bJYNEgqbe8weP00C9y5RTtih0lPfJGO/i52rI8lHo6F2qHsddvRSsnSTYFuvrxZ
         ijk63m7ydyinwqSlmSmWr4BAl2Ur5b8udyVUoTknY4EvtjAxnySB7XjsLglnqK3fUejT
         0lP0QWaVYKAFRwG6UlNihI8QnhBnKvk4mEfXkyCfVU9nKNNyHA7scQPypJTKdbvoHY/0
         OlZBCK20wCIJxP8loOIfbj4oJmSWj/fYmfXKaoZkvA6yE5vOrm04U74Q14yc6F5+1e7Z
         twyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747995725; x=1748600525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+BbSDDHoenIJ3oteuCEH5EGHycpOZc3PIlMBGmoJPY=;
        b=OZ04JJJTsTOQABZqwk+gp2X2KtKIi9orKVR8NaFC2ERPkKDkZLyyx/F/szKXUea9TD
         LZ841AQOMs11j2wHci0mNcNu+L1DUAJnI+ojvcD/hzbQOWN8/1dcy9mNKATMYpNlkpT4
         kgLNIGF+85T6bd2TbRr/Nlj7EEcF9WDfV09dhi9d9u1ttAIm9DJR0nY1ku2vWGqtvuMb
         XrntDzufisKZNKOwXESGgK48T6As0kFFaHWo83wy8PwMDueqGxcl+/vgHFsF3G0IZZpg
         0ArYnqM2/UgUpDDUeaiZ8KgHseX40z9z+2d1oSkOHTiTe/To18t8XFPLF47myPDOHYsl
         5iJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdBqw1PVccwqHPjOlAeWKvpBtN9qGwk6YyDPIStWfXylA1wEjlTNeVbs+Lq6+DIjBsnHFMVko9+D3NDuhOYI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE1SDmfZb8iAXLS1M2X2/RfpThg2rHzMN39rWSj5Ex3ecJTYPz
	8Z0ByEgaTY1RzeKNeTy/jK/DY6rKe30PFtSTmmigfQYHAjekxiVpT1ml1I+9E/BVTEg=
X-Gm-Gg: ASbGncsxyTDjr2IMqsmF3YdztICpoRAiEMGCDmCqsBsG00hYi4wZX9V3hrXyVxclyo+
	ys9URTgScdl5t69jgnc8fK+UaAigJNgFaW7ppV58+NbCfkQcJxAZMgyk3HBdB7lfSv0w0MRBo/i
	YsG+NTuSFPa+AQtfkyp3vVsyoGU6+zn/D/UZyU2dPKqLm7/Ae6wHKSDJMQa64DFdw9KlYl4VMDa
	qweB36O+3F+XQwNJ5KZ6ojw7zjQ5c2MS8fLv2nkDlcgk99ZVJTX4+ALmAP5v2S6aDv7kmsc42Sm
	VwLzaG/D6vQY3p/NMx9aZajWW525b9lPHpYVJjFk5YJU/rmTVWX8
X-Google-Smtp-Source: AGHT+IGKTvrfjxP+cm7Qm4VGpAeva7NGxp+n2OLS1ggJxzcYA6qQkaI/iWC4Vzlh5iYGSGWB+//FSA==
X-Received: by 2002:a05:6a00:4614:b0:736:5822:74b4 with SMTP id d2e1a72fcca58-742a98d4a75mr42390281b3a.21.1747995725139;
        Fri, 23 May 2025 03:22:05 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829ce8sm12466688b3a.118.2025.05.23.03.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 03:22:04 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v8 08/14] riscv: misaligned: declare misaligned_access_speed under CONFIG_RISCV_MISALIGNED
Date: Fri, 23 May 2025 12:19:25 +0200
Message-ID: <20250523101932.1594077-9-cleger@rivosinc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250523101932.1594077-1-cleger@rivosinc.com>
References: <20250523101932.1594077-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

While misaligned_access_speed was defined in a file compile with
CONFIG_RISCV_MISALIGNED, its definition was under
CONFIG_RISCV_SCALAR_MISALIGNED. This resulted in compilation problems
when using it in a file compiled with CONFIG_RISCV_MISALIGNED.

Move the declaration under CONFIG_RISCV_MISALIGNED so that it can be
used unconditionnally when compiled with that config and remove the check
for that variable in traps_misaligned.c.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/cpufeature.h  | 5 ++++-
 arch/riscv/kernel/traps_misaligned.c | 2 --
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index dbe5970d4fe6..2bfa4ef383ed 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -72,7 +72,6 @@ int cpu_online_unaligned_access_init(unsigned int cpu);
 #if defined(CONFIG_RISCV_SCALAR_MISALIGNED)
 void unaligned_emulation_finish(void);
 bool unaligned_ctl_available(void);
-DECLARE_PER_CPU(long, misaligned_access_speed);
 #else
 static inline bool unaligned_ctl_available(void)
 {
@@ -80,6 +79,10 @@ static inline bool unaligned_ctl_available(void)
 }
 #endif
 
+#if defined(CONFIG_RISCV_MISALIGNED)
+DECLARE_PER_CPU(long, misaligned_access_speed);
+#endif
+
 bool __init check_vector_unaligned_access_emulated_all_cpus(void);
 #if defined(CONFIG_RISCV_VECTOR_MISALIGNED)
 void check_vector_unaligned_access_emulated(struct work_struct *work __always_unused);
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 34b4a4e9dfca..f1b2af515592 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -369,9 +369,7 @@ static int handle_scalar_misaligned_load(struct pt_regs *regs)
 
 	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
 
-#ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
 	*this_cpu_ptr(&misaligned_access_speed) = RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED;
-#endif
 
 	if (!unaligned_enabled)
 		return -1;
-- 
2.49.0


