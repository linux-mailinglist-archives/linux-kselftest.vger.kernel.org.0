Return-Path: <linux-kselftest+bounces-8489-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E7D8AB79F
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 01:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E77671F21B5A
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 23:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5576142E6E;
	Fri, 19 Apr 2024 23:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Lds6TL6F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8521422A0
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 23:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713570475; cv=none; b=X2mvWWG23oWJF+SXI0AHQbac8sOzjlvtEpAW6BTucGMNs7AMVBeYBsxfLwAhqDxdDfjdgP6xOLr16Yq1ESGwiBndSH2+V1ZI2FCaEjfS4PQrVVkORHWIFdoZpfirU2cGG+EWGjCuTAlDD+4Qrfi7n6kc9Z2AorjjF3nPuDEkuuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713570475; c=relaxed/simple;
	bh=Gs/9X2hzactn0W0hn5UFwracoeJp45KmCczLf6NHuME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JRxqauiSPtZhWZ5jm/x8/kYdch6U+TCYdMET9tVSXQUlJma/Ff8PRcK5n88ehaepocKZ05EK0wkOrWegSx4BruJ/TJCbgkReKxpUcvXQflC/5oKc7vlkOOz8CSYgbfdtmdnxYxs+vaShOUeZSW3KPAzuiBrd/csbUNeYe2tBWgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Lds6TL6F; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e4266673bbso24363215ad.2
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 16:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713570474; x=1714175274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0lXa0RA4+kQWkomLRJk1QW7kf666EFgaJ2j58l79bA=;
        b=Lds6TL6F6woj3WW5X2RBpXs+GK9WBjb/aU3kju/2JJIzKP6TzhazcpojMUWAmyUFg+
         omP+Rp0WkyC4+09UO2OtpYt0TxrFaiO9mBHl/a/KL6CnTJubT2et6jfafqP+A5P0RS4x
         vWSObOQr6vnNiDBNKmu1VIClh137efILgFgSZPHzvvg2EslsYJly0LX9UUxdrCK4YQ1H
         Mn8kkx3JMSodtmssbb+hgD6hEjGxdlih27kNEAJj7Oq3GuqFWuieT2pXv6f7Rk/n1rdC
         rnC3O0QTwet/xxVFoHvjtV0MvxiFjjZMcLkt60cIJVRRGbmW6rmtj3G9cvLHvO7WHdDY
         wuAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713570474; x=1714175274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0lXa0RA4+kQWkomLRJk1QW7kf666EFgaJ2j58l79bA=;
        b=d40cdDnIQLmzLVPqVgFEL1OaRa88pUT6g5pnIGAaMmywb4ctkqf4DfAA0mZkRSr+zp
         nS49DKq1dDO38MjQVGVqikM5FA2AXhgz5h69oDHyCgxPjnafob/pngUgQ9oMd1Kvi06Y
         /Ctr3jEwuGSdH5LQjeL0ptCly7W9w4UBXHS/KplyEWwZWarLW8BbbSsDcX1/bKygQZf+
         kW6bWsaxPYWgYOIpQF+RaT3IXHX4SE0kRCxiaKmgx/AXoBksDizjuop8XeoSLCJIC8hJ
         Mf9Dd0s1++HVwI4bOb5F7FkqRvN3RrD5GFtBLlXKoGMgy+BDiYNsc0Y0UwCJvTcMovPV
         SCyA==
X-Forwarded-Encrypted: i=1; AJvYcCULBtOGzwUy+D3o5pyFEOqh7K176PUxS9Yq17uxghdf1IYCvEiL4A56cRhrXlH4NUdKvWurl14oKrDzZWm0A7lgRTC8Qt6nGkDjwnfBVmg5
X-Gm-Message-State: AOJu0YzugOlgP4YQzY6EPSWS3wnsTwo4BXu0QJk9ECiwMWxnXn+Pt4O2
	/z4o10u/4uYO8MWqsWbdcD1qNCjQUEJEwORSO1f2yLu+V3RJi4x2uY8MI3uLELY=
X-Google-Smtp-Source: AGHT+IFXaW6wZywudrszg7M9K7pzeD0F1Y92Mkq1wCwVh8jMOhVOOMocPyY8L0Q71C8UhuUv6rBj9Q==
X-Received: by 2002:a17:903:120a:b0:1e4:70d0:9337 with SMTP id l10-20020a170903120a00b001e470d09337mr4759283plh.45.1713570473875;
        Fri, 19 Apr 2024 16:47:53 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902d11100b001e42f215f33sm3924017plw.85.2024.04.19.16.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 16:47:53 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
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
Subject: [PATCH v8 05/24] RISC-V: Add SBI PMU snapshot definitions
Date: Sat, 20 Apr 2024 08:17:21 -0700
Message-Id: <20240420151741.962500-6-atishp@rivosinc.com>
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

SBI PMU Snapshot function optimizes the number of traps to
higher privilege mode by leveraging a shared memory between the S/VS-mode
and the M/HS mode. Add the definitions for that extension and new error
codes.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 4afa2cd01bae..9aada4b9f7b5 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -132,6 +132,7 @@ enum sbi_ext_pmu_fid {
 	SBI_EXT_PMU_COUNTER_STOP,
 	SBI_EXT_PMU_COUNTER_FW_READ,
 	SBI_EXT_PMU_COUNTER_FW_READ_HI,
+	SBI_EXT_PMU_SNAPSHOT_SET_SHMEM,
 };
 
 union sbi_pmu_ctr_info {
@@ -148,6 +149,13 @@ union sbi_pmu_ctr_info {
 	};
 };
 
+/* Data structure to contain the pmu snapshot data */
+struct riscv_pmu_snapshot_data {
+	u64 ctr_overflow_mask;
+	u64 ctr_values[64];
+	u64 reserved[447];
+};
+
 #define RISCV_PMU_RAW_EVENT_MASK GENMASK_ULL(47, 0)
 #define RISCV_PMU_RAW_EVENT_IDX 0x20000
 
@@ -244,9 +252,11 @@ enum sbi_pmu_ctr_type {
 
 /* Flags defined for counter start function */
 #define SBI_PMU_START_FLAG_SET_INIT_VALUE BIT(0)
+#define SBI_PMU_START_FLAG_INIT_SNAPSHOT BIT(1)
 
 /* Flags defined for counter stop function */
 #define SBI_PMU_STOP_FLAG_RESET BIT(0)
+#define SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT BIT(1)
 
 enum sbi_ext_dbcn_fid {
 	SBI_EXT_DBCN_CONSOLE_WRITE = 0,
@@ -285,6 +295,7 @@ struct sbi_sta_struct {
 #define SBI_ERR_ALREADY_AVAILABLE -6
 #define SBI_ERR_ALREADY_STARTED -7
 #define SBI_ERR_ALREADY_STOPPED -8
+#define SBI_ERR_NO_SHMEM	-9
 
 extern unsigned long sbi_spec_version;
 struct sbiret {
-- 
2.34.1


