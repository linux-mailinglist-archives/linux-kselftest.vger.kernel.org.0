Return-Path: <linux-kselftest+bounces-7052-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E2189678F
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 10:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07AD728AFDF
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 08:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD827317E;
	Wed,  3 Apr 2024 08:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="OdCJtUm/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DB16BFD5
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Apr 2024 08:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131523; cv=none; b=sKygaoimqVw47v3dcru1XRnAcUSSWj4GFsuPibupngUJtFerB0XB0NVcydZuvkqV+HXta+JurjL3CIuLMm06geduWEjW+tF27oN+lWk9MBGb/bY7HImQ6C23wi0qx81NRST7K3+zG+NheZXOSZ9QGefZXVsWYqj3BCsCFaBc9zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131523; c=relaxed/simple;
	bh=IeCUKxpOMKG0zL7LcLS/wH2lWaOxpIfM9zaAAyQj4Uk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bPmVSorNmFHxXeo9XP67lA3rRBXcQuWajYzHK5nzSyP/L629mtTcl08IXFcsALTTWHZIySKXniSu9Emjy+qjhZ9Ru33x++nuU0IvE/g8e8AlL4su9cH3oXy255Efuu5Hon3dh3ideZFSLPCNiWNav4waP/4kN7u1QsCQxoRC2FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=OdCJtUm/; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e0bfc42783so51159665ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Apr 2024 01:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712131520; x=1712736320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ixjc/2duOe8tMNsDFapztE6WZpMRR0IqMx2Riyo3ljE=;
        b=OdCJtUm/TnCsKRq0tOayzDsxkmSlAE4FjEpJQ8e4FvpENOjnl6jwWVCrlwrgStP4zL
         AKlz3P/CLAem4ptLrNY6j0UaCbQqAbfvKQ6u8qMnfN50cRknOPKxAa6FyBCn5zVQYG1W
         EcMpRnWm2kHkgkpEAHc5xIwmNgVAINAVvJ0g2zxWgw1sfPBOis1sYIQJNdIGQUSadp/F
         2WkDKPYY6YDOwvrioJDD36yGUs0aoegshj5HvZie4Uy3uXFovDk7heQZa4hOJfsWGW20
         e/cWfP2ScDyVwCxu7mAjRNoKhvFrQbfRApoN1NXz/sViPapNAeAhJCBIY9CxfCFtkLtC
         cFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131520; x=1712736320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ixjc/2duOe8tMNsDFapztE6WZpMRR0IqMx2Riyo3ljE=;
        b=XM6hkQUQNi67suerJWxzBdUT/PPf2AyHtFjaFQ0RtUWAD/2ouaXfTGRXK5Dav1uN27
         0FBYkWiPYVMk2dL8HiKzj9+IUcRbthbK45WGgrtbIn6+8zSBVT14TcXxoE9mrOp1sl+x
         JGcC+SkdhZahpGA+gjPweUfmbfAzcX12qjh59eM1Dc49f56GiiQNmz19DQ6hD9yTMSwm
         msnckB6Bww19SiLyJOl//pNt8YNhm4DwYA8jEVCNjG0weT8N2cMi4eD0VDB6l/VNH/63
         MrtLb7ScuTYZ8E2rtkkBpIgnXASZeESaZmrUL2hxRuA0b2C3bNQdGJSCCUyGWWSghG0s
         zkjg==
X-Forwarded-Encrypted: i=1; AJvYcCXlcERhCqguYogRQ9umvYJLPNSXwNQQOT5tkem70mGuus9hPVXCHmEnTc4h08zNoN3agsD4uCxP1AIdhxaTRjbqr0I7rh/ic+TAVTXK6Qmc
X-Gm-Message-State: AOJu0YyLTIr6WCVt7Pk81Qa+pFPCh2nWNVXbZVL8HEIMlDd5QjuMaTP1
	fzWaq24Bn31Rjk4wi4WYvdwf/fjWoHvDMczSPGqcyIXMucgh+ONTbrm2KkSFJtw=
X-Google-Smtp-Source: AGHT+IFNP2TORKh7//FzhNMEZN9MBNitQSqhLOnah919WVqeHY+e2MYv0jsRIRUc8mtVSGHiLEDhcg==
X-Received: by 2002:a17:902:b701:b0:1e0:a1c7:56fd with SMTP id d1-20020a170902b70100b001e0a1c756fdmr13300312pls.61.1712131520248;
        Wed, 03 Apr 2024 01:05:20 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902d48c00b001e0b5d49fc7sm12557229plg.161.2024.04.03.01.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:05:19 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Ajay Kaher <akaher@vmware.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <amakhalov@vmware.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
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
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Will Deacon <will@kernel.org>,
	x86@kernel.org
Subject: [PATCH v5 04/22] drivers/perf: riscv: Use BIT macro for shifting operations
Date: Wed,  3 Apr 2024 01:04:33 -0700
Message-Id: <20240403080452.1007601-5-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403080452.1007601-1-atishp@rivosinc.com>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is a good practice to use BIT() instead of (1UL << x).
Replace the current usages with BIT().

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
index babf1b9a4dbe..a83ae82301e3 100644
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


