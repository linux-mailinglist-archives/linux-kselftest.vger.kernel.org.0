Return-Path: <linux-kselftest+bounces-7053-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAE2896792
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 10:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4CC21F24ED8
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 08:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF77745D9;
	Wed,  3 Apr 2024 08:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="APZqJJ8W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE34A73527
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Apr 2024 08:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131526; cv=none; b=Dz4SX6Ur2cT62mFQuHJSK4dK07VtNeVX3KBxVWfM5eB5P4EO0JyIQ1PBOx4hqIct+0uUW6X8AzE1iM/p6Wf4mGFG2tzx6sfMl8VIKQPYQVRrDoi/XzzIlqgrMbS5cs0U2gHUeplbgjjqaoEMAXm7uWRwXxbfZjQnZoM2vN64bVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131526; c=relaxed/simple;
	bh=hD4T8CbQGFqb30M4m5Qq8QzxJC1eOzrHV+Z0kwBj2NI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b7hAt/ORdmFzVlEbKAZysk51yjnrEvYF+4dWbkzoWbOTAi9UUwYYlim2a9hb1INZfPCXNICNELzlyss2U9lL6ZDyv+olAgQv9X7/mGd1azuJOZgOQrzrPI1rU0KeCrHLeFH05gLBgt6b5kkoG9nMFKozBW/tj750DA+xgaABqbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=APZqJJ8W; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e2987e9d67so1069805ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Apr 2024 01:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712131524; x=1712736324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cY+c1Et8e4Cu0t4snI2MWrn2141KaT0UNrXkfFbuJA=;
        b=APZqJJ8WSPdO9PXMkbYaajjlgHZk/+LXQVLPNEm7KKgpstdaAxBsJKFvSjRkKyalxj
         GhI6XbI1lR2S/RAoiqbaITQOrNGnqQuC5ctwCaPrBX9x+3tE535d2qZkghN1qNAUhopi
         +o07EKoPDnvJeorLpjmDCLJ6H2vdcMe1uF484REY+UtuPnxiHkMkQjKjErWMbfL1KzU3
         +24QXhFSpTdSJwSZUm8jd8nkQbrhDXOJ6UibLUnsTI60blqSeH8prptkviOh10sYvhFa
         lYiJNgfBMUV5QZqMSUf1TZsT/sSwa1+GWWo9JaVcg1qJO62fOd4bnlfpVvuxPfcP7Ckh
         INUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131524; x=1712736324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cY+c1Et8e4Cu0t4snI2MWrn2141KaT0UNrXkfFbuJA=;
        b=T38ACE1H4iKVv5jQBNqUlYYZAVMbjbnr9siNnBKd6AGvVgB1YajLI5NDr6k0WJdK0T
         5PH2tSeMXIg6YIlkaM9MGyKNnYC6AVfhOHmjBM0RxQE484BHRfIOdzFN4sh1BQlIhbqg
         4lj7EcTQg6U6cFmKSbCJIq9w9uHLJmT4cSzazNJomgyUhWvAFpiZzEDK/Wb1Ato2ouVy
         /34EUhqblvtWUXRnafqFmJuvvBMRbtKaQ2nMv5xL0XNesyGQrBlKAE7mnZ5H7ynquSWH
         PCBPsBAreoL1j9hJYU5aelAis+eqTQwESoewQ+0vU6bjKZLFxrxGt4uLI8LCtc4bGY88
         0GRw==
X-Forwarded-Encrypted: i=1; AJvYcCWhutSOa5SBczoLZUajBOb0sR4g1KKJjNTSFhPiWWJbsJWPd2iku2ArKiNNa7MpXrRhQoE2RL1DwOc7HANFobsqmxsvmO+SroAfVt3NyP6t
X-Gm-Message-State: AOJu0YxWhEVbObeCxoAUIsalgjdWv8/3m3nlBERmx/DoR4AIRmlEJaaj
	dlripfmtpJGf9EWhE2/pO3mNJJsUgWOuyuZ4NmVVAA8/WucBqbXXhiO33HZ8NZo=
X-Google-Smtp-Source: AGHT+IFKoJgtWxPYCEvG4otnYA6GehE6Ju467AMTWra/Y4iLfyYQ+vCfm0Zt2yPKMvFR+PhSvC1EhQ==
X-Received: by 2002:a17:902:c412:b0:1de:fdf2:b483 with SMTP id k18-20020a170902c41200b001defdf2b483mr2836035plk.8.1712131524245;
        Wed, 03 Apr 2024 01:05:24 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902d48c00b001e0b5d49fc7sm12557229plg.161.2024.04.03.01.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:05:22 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Ajay Kaher <akaher@vmware.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <amakhalov@vmware.com>,
	Andrew Jones <ajones@ventanamicro.com>,
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
Subject: [PATCH v5 05/22] RISC-V: Add SBI PMU snapshot definitions
Date: Wed,  3 Apr 2024 01:04:34 -0700
Message-Id: <20240403080452.1007601-6-atishp@rivosinc.com>
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

SBI PMU Snapshot function optimizes the number of traps to
higher privilege mode by leveraging a shared memory between the S/VS-mode
and the M/HS mode. Add the definitions for that extension and new error
codes.

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


