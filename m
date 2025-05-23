Return-Path: <linux-kselftest+bounces-33634-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7990AC20F7
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 12:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D76AA41C72
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 10:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF67823C4F5;
	Fri, 23 May 2025 10:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="F4BLMmvU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2206A22D4D9
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 10:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747995746; cv=none; b=X/2cye5F02igZLgth94htoU69MPbn8GF080wwtihqkI6GiBh8Mhn2c1Hifuj8wrnn9ev7HsAZpp4AiFWR4LhC6sJBC5ejSQmlU/5fU3fUTuUwmy2uctM9PiSkPDhs0JBcD4XYTuRKyfMxtMHrg+36jKWtvb3EUQUH9Q+OU43cWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747995746; c=relaxed/simple;
	bh=ViCP/GXPR6c4TqOEA6RHPSeoT6XgmF7w9rLMCocIqJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KD9ljSSzQVVS+t/3bTD2gJctD2pakW/KVeXjrwrh3GvQelcgARseJ0t5KgtRhW/1HzB5gaGaey2HatCeu0UUKey7nPsk8MdQaBabPlrKJqKxKeJW/yTMxV3UduRWb0fPW4Smbmg2EOg6XsGgv7NUuvqDMaGrBbWWHSwNhRox/3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=F4BLMmvU; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-742c46611b6so7636413b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 03:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747995744; x=1748600544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJlHvKZgzBuDLrZteqciLWVF8ALRj3f5YDjK6RzEUVA=;
        b=F4BLMmvUragUW4s7HyKp0BYbTKVW3t5KE14GnKOGodHwi/oOQ9epFFGVDSTCc2EGCE
         unmJMniOabLV+9iCUQEtm36SHxTUHyF9g2kgDZzMfbcD0Zg312zo+BlS5wNhUZh8FePs
         1PqZfkN7IMu6extAbRIVX+t4fRXYmB9dxV4gQnmBJqsFJfaPEvGvWiHuaHCE7tb6KDfi
         iGVxa4AhX+H73k/AGzcJof9GS1RUMkdo6kanbzU6BNBaNPPNxgPEjEFB7UGybGaaJhOG
         CxDoBBO1hc/KeOAnOTbzJZ1S6Uy0S7kGYFclirqXqGhizlUCand9GvD1h2U9OVROTB5G
         X4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747995744; x=1748600544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJlHvKZgzBuDLrZteqciLWVF8ALRj3f5YDjK6RzEUVA=;
        b=T6FwAO3AoUe8J/QTxj3DJWmdct0w9XJmeaEMtNfz9hYy5kLi/g4Go/Te+OLZup35+/
         X18WXz2ibNmJw9C4wjWuMNJCySllfbj4dqjXY1uLm1A2cKEjW9KPh4HqOWzq1Kd3j1Nv
         hB1deRdaU/UuyAcpy7Wxdi3d4WdbUOe1QqWagoWrbSsVFliuCaFxHCq7uF+/i/8r424X
         lt1mlHpJlcyNpC8vDeengrYi90uhUSKFM4ppbYnTCZlXYk7zdIMS4Zd2abIJFYavuG6m
         Y5FTmUODFG/vkRiBdsh3CIzqgRC+pcslvSqIPdk1GnsKk+0DL2psLcYubsFZVqylq+OV
         +yEw==
X-Forwarded-Encrypted: i=1; AJvYcCVx1pnJMk6Yb9OZDa7hJhUyl8USgDB3j9Ojcpwo5eWBB40YSjEKb8MUWiGFjoNShT/XDgHzMOsGV3kkdu1onbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyndqXLoNVllh/HISwtQVY7Ngw6ICj4zXEj6EcFkfxO6CPJ05Ta
	eEmXxmkjIgfEBGQM6sjL5LXqiB87rfXxmM7VCOnMyQ9yWxm7IL8LxXRU6/iVrnOuhrs=
X-Gm-Gg: ASbGnctUEgHMcV/om0I1F+gIPlZk1ZXyaFJtjbcIgGgOh4xI1rYOuQRT+wTorIhLIXW
	zxR3LCGNqspiojpAmRkiteQ2WNG+cL6Stk8/yEk8ZQTqP0TTMoWfl+y5EANEBWsOJcv4+dKYvYJ
	t5SYPf2rvNDHPmTZHFnnptoOvS6E6gPP1cU3JVcm0BJRwPoLegzflnQN/qekj3Z+zt6oJxB2wfS
	cCMfLdv5HxnWfEM3h4ushF+MzsVu8V/slszBfk4j+K8GJ6O+ZQe4hFSOpQiSdZwSAKYjLNTLaC9
	vugWrOvPBRXOGVEE/zJa7+7BKUipRizv28fTncVRR+zDLMvkL1oy
X-Google-Smtp-Source: AGHT+IGKDj0Vt3rsaPKYZL2nBjHo4cZKOOLzPGlgQIfiludDyBY6vduzzuNU0u8N497C+aWPSTsTOQ==
X-Received: by 2002:a05:6a00:3e0b:b0:736:34a2:8a18 with SMTP id d2e1a72fcca58-742acd75e6amr44078224b3a.24.1747995744354;
        Fri, 23 May 2025 03:22:24 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829ce8sm12466688b3a.118.2025.05.23.03.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 03:22:23 -0700 (PDT)
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
Subject: [PATCH v8 10/14] riscv: misaligned: add a function to check misalign trap delegability
Date: Fri, 23 May 2025 12:19:27 +0200
Message-ID: <20250523101932.1594077-11-cleger@rivosinc.com>
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

Checking for the delegability of the misaligned access trap is needed
for the KVM FWFT extension implementation. Add a function to get the
delegability of the misaligned trap exception.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/cpufeature.h  |  6 ++++++
 arch/riscv/kernel/traps_misaligned.c | 17 +++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 2bfa4ef383ed..fbd0e4306c93 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -81,6 +81,12 @@ static inline bool unaligned_ctl_available(void)
 
 #if defined(CONFIG_RISCV_MISALIGNED)
 DECLARE_PER_CPU(long, misaligned_access_speed);
+bool misaligned_traps_can_delegate(void);
+#else
+static inline bool misaligned_traps_can_delegate(void)
+{
+	return false;
+}
 #endif
 
 bool __init check_vector_unaligned_access_emulated_all_cpus(void);
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 7ecaa8103fe7..93043924fe6c 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -724,10 +724,10 @@ static int cpu_online_check_unaligned_access_emulated(unsigned int cpu)
 }
 #endif
 
-#ifdef CONFIG_RISCV_SBI
-
 static bool misaligned_traps_delegated;
 
+#ifdef CONFIG_RISCV_SBI
+
 static int cpu_online_sbi_unaligned_setup(unsigned int cpu)
 {
 	if (sbi_fwft_set(SBI_FWFT_MISALIGNED_EXC_DELEG, 1, 0) &&
@@ -763,6 +763,7 @@ static int cpu_online_sbi_unaligned_setup(unsigned int cpu __always_unused)
 {
 	return 0;
 }
+
 #endif
 
 int cpu_online_unaligned_access_init(unsigned int cpu)
@@ -775,3 +776,15 @@ int cpu_online_unaligned_access_init(unsigned int cpu)
 
 	return cpu_online_check_unaligned_access_emulated(cpu);
 }
+
+bool misaligned_traps_can_delegate(void)
+{
+	/*
+	 * Either we successfully requested misaligned traps delegation for all
+	 * CPUs, or the SBI does not implement the FWFT extension but delegated
+	 * the exception by default.
+	 */
+	return misaligned_traps_delegated ||
+	       all_cpus_unaligned_scalar_access_emulated();
+}
+EXPORT_SYMBOL_GPL(misaligned_traps_can_delegate);
-- 
2.49.0


