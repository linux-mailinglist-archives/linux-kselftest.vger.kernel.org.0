Return-Path: <linux-kselftest+bounces-8488-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 204B18AB79C
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 01:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC452281DDE
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 23:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE59D1428F7;
	Fri, 19 Apr 2024 23:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="PyDjOqTV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B051422D5
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 23:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713570473; cv=none; b=E1QiQvekVQN5wsk8i9HCdh8hxQMOJRaI0i5NYB1beD/Y/W5b/ltJzW/sQlG+7tPcth2LUBEj+xj1ol+rH9M6SZvuafa/ORCpkToTVQvoYk9oaKWpYf3OhBVL6ntrMEt78B/9rUEkZVLSf8QWRKR9e19gOslAWaVXDVSekf/gE/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713570473; c=relaxed/simple;
	bh=J8TrFuN//G6PmUvmCaqpAzaTIpoKbVOHs/yKTawHfLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AfLT3Kvavr66qNibjrLkoF7AUR7qYYJ5CggXuNmasEivGMxF2pTLUi7Li9n9H9kTYK9k+LuajnpVdBwKB4UlCEv0J0YCeNww6xlJTYgOppGqf4PbuVGXaYDIXZRTA3PbIEyvnApwAia7W11PQd9MJLYTd9Na3LYdEWT+WygNRS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=PyDjOqTV; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e5aa82d1f6so23015235ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 16:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713570472; x=1714175272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITt+KwUVR5JlR3QMHjofp/8j27l4zwoSN907Yn7Ybbg=;
        b=PyDjOqTVhmhhgtfZsWc0jioetZfve3T8G6D4shs3Xr7XwwaCmoNCW6iEqo/eAiKTWw
         kaKofaCHYCVNcJhaf08cLUn25CN0DZ8EsxfIHNAy4I5YxGYxnHPpGTQ5jT66l3nXquMy
         JcTlgUJL3whjYef1jLsraCva+0FFBTpMNBEnrMActuSFpHfq0RWHxweijortWpGlzFfE
         GndvUXRZwvnNlUECWq/hlUg+CnSwePDvxlq5NJeA9YzIuy8UgyQJ7fHvVOh0rhA5AzCk
         tAYN3v/127oI8rEKHPBqiBO0JQf+CRrS3WXsIfAj+IQlZpIAMVKRUZfjggpnIlrEkoF7
         s6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713570472; x=1714175272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITt+KwUVR5JlR3QMHjofp/8j27l4zwoSN907Yn7Ybbg=;
        b=tPx6NF89TetwMA762tV5y+Bjc0HAX7cBrQ24Ra6AwyUi48BsuUq9FZlzLETXIIY9AB
         jIGud/80zUMjf6KbB5baPECBLc+EfQcl47Mhnypuwo04jRd8h3rrmtbTZ5yb9854GLpw
         UWgajBgunfTbEtNDXzVuoHrqaF17IRMosVEuxTwhto1S0AdZWt0TxHu4He/n55pBkEqR
         WOeTOtLUU/t+uM0t42gSRKIvtxiwqfbZfmsC2TmaPLVqoa4X3RcLsdtrpjBXI7pURYjB
         0SeWvFCVGFNSfdSDPL41iptRGVuFnO3iM8RQGs8ncKhtDBNHopynAx0fOGiBSsUklaGf
         KtOA==
X-Forwarded-Encrypted: i=1; AJvYcCWPG1VcpG9G1PMMYVEsLk2HOyrQR4g+p7pFGYGalsl75jV4dUrqI/zE0sovX1dmCszGkI0FocDPIg+AiAM6Z0370Lc/FUfCP7ItQBtCWyhq
X-Gm-Message-State: AOJu0YzRaqz5zWtiLV5dPrDaT9kdc64oHvxN/9BbQolVzC+DfT/z8fyC
	c/WTHg9qnBbxCIpIan9BBtzGGUdiVz6CYhEVN5GqRF7t3zQcZiT1ctyV2m9rSbE=
X-Google-Smtp-Source: AGHT+IH5QGSC9XYAm6rDKcSeLNzkHXWCmDzCWOnGmFWs22ruWfJPyGgW69pbeeyR0NhMBzdKPRq55w==
X-Received: by 2002:a17:902:e741:b0:1e5:5c69:fcda with SMTP id p1-20020a170902e74100b001e55c69fcdamr10097280plf.26.1713570471976;
        Fri, 19 Apr 2024 16:47:51 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902d11100b001e42f215f33sm3924017plw.85.2024.04.19.16.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 16:47:51 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	samuel.holland@sifive.com,
	Conor Dooley <conor.dooley@microchip.com>,
	Juergen Gross <jgross@suse.com>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Shuah Khan <shuah@kernel.org>,
	virtualization@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	x86@kernel.org
Subject: [PATCH v8 04/24] drivers/perf: riscv: Use BIT macro for shifting operations
Date: Sat, 20 Apr 2024 08:17:20 -0700
Message-Id: <20240420151741.962500-5-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240420151741.962500-1-atishp@rivosinc.com>
References: <20240420151741.962500-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is a good practice to use BIT() instead of (1 << x).
Replace the current usages with BIT().

Take this opportunity to replace few (1UL << x) with BIT() as well
for consistency.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 20 ++++++++++----------
 drivers/perf/riscv_pmu_sbi.c |  2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index ef8311dafb91..4afa2cd01bae 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -233,20 +233,20 @@ enum sbi_pmu_ctr_type {
 #define SBI_PMU_EVENT_IDX_INVALID 0xFFFFFFFF
 
 /* Flags defined for config matching function */
-#define SBI_PMU_CFG_FLAG_SKIP_MATCH	(1 << 0)
-#define SBI_PMU_CFG_FLAG_CLEAR_VALUE	(1 << 1)
-#define SBI_PMU_CFG_FLAG_AUTO_START	(1 << 2)
-#define SBI_PMU_CFG_FLAG_SET_VUINH	(1 << 3)
-#define SBI_PMU_CFG_FLAG_SET_VSINH	(1 << 4)
-#define SBI_PMU_CFG_FLAG_SET_UINH	(1 << 5)
-#define SBI_PMU_CFG_FLAG_SET_SINH	(1 << 6)
-#define SBI_PMU_CFG_FLAG_SET_MINH	(1 << 7)
+#define SBI_PMU_CFG_FLAG_SKIP_MATCH	BIT(0)
+#define SBI_PMU_CFG_FLAG_CLEAR_VALUE	BIT(1)
+#define SBI_PMU_CFG_FLAG_AUTO_START	BIT(2)
+#define SBI_PMU_CFG_FLAG_SET_VUINH	BIT(3)
+#define SBI_PMU_CFG_FLAG_SET_VSINH	BIT(4)
+#define SBI_PMU_CFG_FLAG_SET_UINH	BIT(5)
+#define SBI_PMU_CFG_FLAG_SET_SINH	BIT(6)
+#define SBI_PMU_CFG_FLAG_SET_MINH	BIT(7)
 
 /* Flags defined for counter start function */
-#define SBI_PMU_START_FLAG_SET_INIT_VALUE (1 << 0)
+#define SBI_PMU_START_FLAG_SET_INIT_VALUE BIT(0)
 
 /* Flags defined for counter stop function */
-#define SBI_PMU_STOP_FLAG_RESET (1 << 0)
+#define SBI_PMU_STOP_FLAG_RESET BIT(0)
 
 enum sbi_ext_dbcn_fid {
 	SBI_EXT_DBCN_CONSOLE_WRITE = 0,
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 1823ffb25d35..f23501898657 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -386,7 +386,7 @@ static int pmu_sbi_ctr_get_idx(struct perf_event *event)
 			cmask = 1;
 		} else if (event->attr.config == PERF_COUNT_HW_INSTRUCTIONS) {
 			cflags |= SBI_PMU_CFG_FLAG_SKIP_MATCH;
-			cmask = 1UL << (CSR_INSTRET - CSR_CYCLE);
+			cmask = BIT(CSR_INSTRET - CSR_CYCLE);
 		}
 	}
 
-- 
2.34.1


