Return-Path: <linux-kselftest+bounces-31056-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD6DA91C00
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 14:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A01C445121
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 12:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1404924CEEE;
	Thu, 17 Apr 2025 12:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="YxAnZnFd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F212472BC
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Apr 2025 12:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744892722; cv=none; b=K8VWN7Z7aqYbvR7yeNc+Et/UbhitmShX8d+/Qt4SEjtcyJeSiUb56xIsJ2XTSBwOF3Q9xdmnEz7PddCSKFGO+Kjcu5ORXCuIYPwlhLRToswwmmzq0Sk2ancxSYlozmGEZ5Fio7dUtdTYvsgL4nX6KAqDJ9s5pw8WcGTK+BLSVn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744892722; c=relaxed/simple;
	bh=EovtyHw9idZFNwtsYlCnzb9BpVvdfog+V7fNy74G0ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MBBYXpb2DUP0EY3eZGXGfDgtUEIRcFnYXlG5YSq+17jBoN326hsX2e9O5nMOPRY23tsh+8N7zrkOosdbfcN5raRu1vXjr2DiIlK+HolN3AGNthn7see0A4Dx4syzYJ7mGkcznY2DIy7tC3SfL+X+paFKpOEAZR0vK6HyNH4z/Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=YxAnZnFd; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22c33ac23edso7575385ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Apr 2025 05:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1744892718; x=1745497518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZnuSlMP6ZuwANzL9lETdaARYZp01YtNV9fLw8GSKUw=;
        b=YxAnZnFdjVu5gHkkao1RamPbDun2+eJGZ96H+jcRzfY99EYkmBRdovrb/zuWmBuLGF
         /vm3UtI+rDHCd6jVWTThMHRmppDhiG2Uw73HbKc3uJnD0OEN7mJ/hfboLSwuBj/M1nvi
         0VTcokaXVSoRcweOfmOhXdyS01tRWi+PHt8I1h6eJPLOajaTV/egiXaZzEOSzPmapj25
         kg6yWyU27GGfh36Vl7z+YR3rMvYb+zbF/f/UJcEuRvXuhrZdRDN99ti7EAliF2m6egh6
         48BhqxVEQEupVYxsHAaMU/x+xGxMG1uGpQilEj72yYRLMQJz3POhj+LljvNa3NnJoMTw
         SHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744892718; x=1745497518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZnuSlMP6ZuwANzL9lETdaARYZp01YtNV9fLw8GSKUw=;
        b=Au2Bqe16xdaG6WQOc8lXiT/xgp/VPWLynIn66cDe9N7sU53AlK4tK/8+JAJ3w9qxGi
         ma3tcmAXkqXmHAFaT7xRJo0xaMv0gVbbocIdGekCRQP4tWkgutoIkRSmuTlmylcgvftZ
         WqC2qGGn/E4IQjtQuv9Z4agYxR/Pa8aHRrxbq9mvmUMNANsJiw1bel8oRwSCkvfFw1ze
         oIIeOMGdtQ6m7xo2dizJ3+2K7vce8KZPyLlZAJootBysN7z1oLsIDIuJwRM/yKrmbPkv
         2zp71ggtY7FG6/AUl3fdHTL/yxGpGOz6spo7oukc+/C2CLfKltqE3aBmW/VGtpj8rgIs
         g9jg==
X-Forwarded-Encrypted: i=1; AJvYcCV87Ec/p6GK+6Dzt73u0UnFk3r6dkynYwn4aEWJ+YtuqokKL3cBR7ODayqh99NQYm33IPdHJ8C13l/JQYHWH+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhHTdVgEotuc5ua/jBElCupPmUbYnU8QdX20CeK5j2dhF+FpJ4
	PIdJIl9oHRukoSf4U6LsR39L3OEkXtKxIf4gHqQOPv6FL20lb/JJrxZL9eGafL8=
X-Gm-Gg: ASbGncuUk4Lt7KRbUuNl6XdSHF5VrhclRwz5LDup7PCnKd+ejcigOMMDaQEJPw+ZKMG
	cKjfQdOjM5m3qF5rRj8F/q0ano/IiA6w74gdSCVi3jdgh2tp9j4U5/1htEYKvnM6nWsKkUKrvpk
	127gfcOtvtzMuziSnqrEESjHOwRCSmgnI2sQE9LcVuWVJ5NZUCml0Jsx1WZcw281DA5K0JU24v3
	hlW+vUbqdSjo4D6oHRvmGrQaFXutoY9a+owTH3c0lT3cyTkj/B/y2tcNU3mpP2NaCipOT84uVQ1
	nFtj/a71mYDPSgobKNrPYOMT/BKU7SQ8FkOO1iVwniadxbe3b5Rz
X-Google-Smtp-Source: AGHT+IFn+UkDwIOY/e3sKBsC4N9k8AEuCmWtLw7UPdTMPKcDNDFZ5/adGOe7oxZT/yFghuiQ5DQrlA==
X-Received: by 2002:a17:902:e808:b0:216:2bd7:1c2f with SMTP id d9443c01a7336-22c358db9abmr72649025ad.18.1744892718633;
        Thu, 17 Apr 2025 05:25:18 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c3ee1a78dsm18489415ad.253.2025.04.17.05.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 05:25:18 -0700 (PDT)
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
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v5 09/13] riscv: misaligned: add a function to check misalign trap delegability
Date: Thu, 17 Apr 2025 14:19:56 +0200
Message-ID: <20250417122337.547969-10-cleger@rivosinc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417122337.547969-1-cleger@rivosinc.com>
References: <20250417122337.547969-1-cleger@rivosinc.com>
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
 arch/riscv/include/asm/cpufeature.h  |  5 +++++
 arch/riscv/kernel/traps_misaligned.c | 17 +++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index dbe5970d4fe6..3a87f612035c 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -72,12 +72,17 @@ int cpu_online_unaligned_access_init(unsigned int cpu);
 #if defined(CONFIG_RISCV_SCALAR_MISALIGNED)
 void unaligned_emulation_finish(void);
 bool unaligned_ctl_available(void);
+bool misaligned_traps_can_delegate(void);
 DECLARE_PER_CPU(long, misaligned_access_speed);
 #else
 static inline bool unaligned_ctl_available(void)
 {
 	return false;
 }
+static inline bool misaligned_traps_can_delegate(void)
+{
+	return false;
+}
 #endif
 
 bool __init check_vector_unaligned_access_emulated_all_cpus(void);
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index a0007552e7a5..7ff1e21f619e 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -709,10 +709,10 @@ static int cpu_online_check_unaligned_access_emulated(unsigned int cpu)
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
@@ -748,6 +748,7 @@ static int cpu_online_sbi_unaligned_setup(unsigned int cpu __always_unused)
 {
 	return 0;
 }
+
 #endif
 
 int cpu_online_unaligned_access_init(unsigned int cpu)
@@ -760,3 +761,15 @@ int cpu_online_unaligned_access_init(unsigned int cpu)
 
 	return cpu_online_check_unaligned_access_emulated(cpu);
 }
+
+bool misaligned_traps_can_delegate(void)
+{
+	/*
+	 * Either we successfully requested misaligned traps delegation for all
+	 * CPUS or the SBI does not implemented FWFT extension but delegated the
+	 * exception by default.
+	 */
+	return misaligned_traps_delegated ||
+	       all_cpus_unaligned_scalar_access_emulated();
+}
+EXPORT_SYMBOL_GPL(misaligned_traps_can_delegate);
-- 
2.49.0


