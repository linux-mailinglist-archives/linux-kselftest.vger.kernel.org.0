Return-Path: <linux-kselftest+bounces-8194-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F0D8A7378
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 20:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 443E028454E
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 18:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C08F139D09;
	Tue, 16 Apr 2024 18:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1Ll2VWzI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBAB137C29
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 18:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293090; cv=none; b=MFQuiR/0K9NdNT1eeqlvfTskhcOtRgut1BMo2uT+le2hevMxjaykRM8leyUMKE6/nh7Qf4eHyjcTFYKOOG70xGVTgl16RIBFIgcCt195F0MpxZ+HMtABxoSyh/Xua0CZ1f1AC8N90LLyOYQgkhoW53FHPRv6AMQko95BfjNyqyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293090; c=relaxed/simple;
	bh=Gs/9X2hzactn0W0hn5UFwracoeJp45KmCczLf6NHuME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oKK5erHxjYP/hKlm9BjqIVxv2KAk4TAe1I99FvxDw6PhnwAxefg6fZLC+92/Itgg4ltc0zgECAM4XRzcsxPSJRXUkSNcQIZa+6SLlbf20Ug2/2E0bFX0Hdw09AJ2g0ZFrbta95bLm/Waizt4fSQZkwnk4MDqY804ifXxNmTlvA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1Ll2VWzI; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2a55a3d0b8eso40001a91.1
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 11:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713293088; x=1713897888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0lXa0RA4+kQWkomLRJk1QW7kf666EFgaJ2j58l79bA=;
        b=1Ll2VWzI8W1YGIG7FRLM/yINoz+qdRHCJvrBveY2tk+XPBhORoKAra57rHdvwo0sXx
         adokXKRUBWSm+ochnEqNK+gjuVnWAo/0pKLfnzrtKQWG9CrsdOJeUqaY/DSXLPFF5W84
         r6gTDxi9CDAPCFg5c/DPFdV177A1Cp8E0X+f+mBgZCLph6z6D2kJ0prxOwY+Ty5W1fCA
         d6wIoJ5fW/QZjdHVPcSKMuvMNhEfIlapKGvdpFmLBGh2/VgZH9nFgvQJgSnbP27oqcjv
         rCnBTXWTYHBSPJLYQcLpgupcbzSC/ErVJbkKZZnXhcsrhfGkzrkHoUVHVfIRXYf7ivtR
         YkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713293088; x=1713897888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0lXa0RA4+kQWkomLRJk1QW7kf666EFgaJ2j58l79bA=;
        b=oghqA31MD2cs4ZfI+cXjBvER+8mmjLyknFsyzfq9Zd+13LtUXI8XT8FMRcI7nfGO6s
         YI5TW9umj9CWdx6BmF56qlEt48RAUoZNEixp0p0WdoKXHvIMbn8JOP4NSMIMtoom9ZET
         47EBDiRGD/2qMxbLJlH927I7e//THQO4oeMtmxp92hY5umzcMYI+2eU3dVFK4KFmL0pK
         TscWhpu7BFuXbmjiRhb+/bQUc33d1Kothr0MQSgx+Z89BWD9mUTBxepdaILoy+4fPhiQ
         fChtd4LB0DcA9tHcdaKZEiNKJmsambLwP6zQ5rrXRtEaO3geRziHaaDg949qf1H/woCo
         YZmA==
X-Forwarded-Encrypted: i=1; AJvYcCWtdmesSyARgDeoYdFDMIAPRoNUiH9MmXPqOmlLLugRtOm5h2/GSMVPjIF7GwRyJullsA03znhPlNB6iuLUEnLN4DYPVXKjSCj9ObX0JgA6
X-Gm-Message-State: AOJu0Yxp1ZHqaPVgQiqaCFuEVuYzyIkgeygplLLFZbjE7tsR61s6PUlj
	qzPUgo9oPSmVDMh/ksRRGzDgyz6sw8qt12QtFEyAkiaettKepMU64r34hsC4PsY=
X-Google-Smtp-Source: AGHT+IEy4ZrQc6VpWHcofWnBnFX841IYpr0DACATgSN6h23DP3YRcVds0NngKjdBNkuEvrMjPFCw+A==
X-Received: by 2002:a17:90b:4c8e:b0:2aa:b56b:5bdb with SMTP id my14-20020a17090b4c8e00b002aab56b5bdbmr3174156pjb.9.1713293088546;
        Tue, 16 Apr 2024 11:44:48 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090aac1300b002a269828bb8sm8883645pjq.40.2024.04.16.11.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 11:44:48 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
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
Subject: [PATCH v7 05/24] RISC-V: Add SBI PMU snapshot definitions
Date: Tue, 16 Apr 2024 11:44:02 -0700
Message-Id: <20240416184421.3693802-6-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416184421.3693802-1-atishp@rivosinc.com>
References: <20240416184421.3693802-1-atishp@rivosinc.com>
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


