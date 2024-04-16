Return-Path: <linux-kselftest+bounces-8209-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF6E8A73BB
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 20:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 921F91C21DAB
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 18:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D953A1411F2;
	Tue, 16 Apr 2024 18:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="0/Ej4FOW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE7B13EFEE
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 18:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293111; cv=none; b=GQCPdLQ1pCVscXBDR4NiMxYhHoWVvz1t70StwT0ValRCG5vET7amwFSZXR6Mp4kjxIZnrW5DczkU3Xapvs7tFriWRwjs/jbTtCkAb1v7QECew/8MLt4v7GDi5+oGWaMXDAX0fQPW8y0Rkyb9bqiC840J277HYPRMmWONu4XwchU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293111; c=relaxed/simple;
	bh=XaYtSkDqV2Gk6SkR/vZ7T7PA/8MDDP7ooY8/f+ym4MI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uEWhT/QOrJJxbjsOHXHJikqsRqikj7607zi1lLVS6G9dRwKyRFo6uPCKtX3XFyN4su9VifbK4u2VC1Z3JRmns2LzOVsEDd/bTX5eHWI0E1R06lgnc4NDPVYYJ6epQZbIR2hOVSNTVm4HuSFyxd4DZT5s48OcGTPbcP6tjdfd3aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=0/Ej4FOW; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2a6fa7773d3so3315237a91.3
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 11:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713293110; x=1713897910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9soA5cn4wIINjbEEbaSFa4z0U18KoF+cjavdbqPH+4=;
        b=0/Ej4FOWhyarDlN60tU97y4o0Wf/7Mtnm5qIVr+X4bGkvAqrtqrEdjexaSYrhMPVST
         NNtqK3voiXQZhsNsxX1Ej8U8is93drZzCJObsSXm7ljDEq6r5rIDwsxSeRRLU5UlMBS3
         JF+ZHlADp3La4UVFzsLgvYqFSLDHDLy/+DKE6n9TP5KT2/N/e+0Au8NSoJKBHH65WkeS
         3ke9hDI5WXKsUUHZ4I3CWO9vhoh+OiMj7LUEFgrApNFuliI6pykR6A3UeVZBHP2ndkYc
         fMqQXzBToIQij3HFebkbP/p8ufcKi/nIomB6i0JFEs984Fh7QuvVpl8RJlUiCwz9Dd+A
         IdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713293110; x=1713897910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H9soA5cn4wIINjbEEbaSFa4z0U18KoF+cjavdbqPH+4=;
        b=Rs7ndQJxcqpvEG1/t3gyDeKz2s0NVbeKriq9SVt34s10oBa3nWTI9C2WmXWd654k9f
         9nhWz9NLN+D4OXoF+i9KcDBltw9etcN0uHQE/UbXaqv2w6CY6r7VtBlv0D+5qQlhkGgC
         qDI6s6OGi5KLSgLIV6WxHU8I4q4xFr6xHWL+PBDG8JQCFla0s6DUxvGSUYNghoQF2CWB
         D2px07KrNKwZPVaWBqTgOrfU7Rab176QfHnqjESTJjwwjy6vu35SsrxJMT8bhLyT+vEA
         ZjwEMDl6e4nmYp2W70MkiU7OtA779FOtIuvgHZdFt52NW8MeYwfuZLBw3IXdWPCu6PfC
         AE6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8H3NqH6OythfxEP9NV/5VMK6jpevI76e9bngjHgI66iNkvsfeXVr3ehrJ0rSkDz8+lXutXlCXIJ3TBRIifE9wdYkVatNDcbsUMGLSHtHS
X-Gm-Message-State: AOJu0Yyi8Cior6A9WRyxjI2kNP4Al6whB7mceJEljA/utqtf/lyqFcWn
	sm/fxhHyRGsFNZ1N2qOr1gCMI5eJbEPipjJpHMVJAqDYoxttt3ZLbUUPBIRMheo=
X-Google-Smtp-Source: AGHT+IHDTeNVga9tFzBdGXfnm4TEDY0Ha5j2XCWgAdGdaU558CfadIkSKiQQwMLkSusHLb3PPhohFg==
X-Received: by 2002:a17:90b:180a:b0:2a2:55de:93eb with SMTP id lw10-20020a17090b180a00b002a255de93ebmr11036026pjb.33.1713293109672;
        Tue, 16 Apr 2024 11:45:09 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090aac1300b002a269828bb8sm8883645pjq.40.2024.04.16.11.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 11:45:09 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
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
Subject: [PATCH v7 20/24] KVM: riscv: selftests: Add SBI PMU extension definitions
Date: Tue, 16 Apr 2024 11:44:17 -0700
Message-Id: <20240416184421.3693802-21-atishp@rivosinc.com>
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

The SBI PMU extension definition is required for upcoming SBI PMU
selftests.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 .../testing/selftests/kvm/include/riscv/sbi.h | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/riscv/sbi.h b/tools/testing/selftests/kvm/include/riscv/sbi.h
index ba04f2dec7b5..6675ca673c77 100644
--- a/tools/testing/selftests/kvm/include/riscv/sbi.h
+++ b/tools/testing/selftests/kvm/include/riscv/sbi.h
@@ -29,17 +29,83 @@
 enum sbi_ext_id {
 	SBI_EXT_BASE = 0x10,
 	SBI_EXT_STA = 0x535441,
+	SBI_EXT_PMU = 0x504D55,
 };
 
 enum sbi_ext_base_fid {
 	SBI_EXT_BASE_PROBE_EXT = 3,
 };
+enum sbi_ext_pmu_fid {
+	SBI_EXT_PMU_NUM_COUNTERS = 0,
+	SBI_EXT_PMU_COUNTER_GET_INFO,
+	SBI_EXT_PMU_COUNTER_CFG_MATCH,
+	SBI_EXT_PMU_COUNTER_START,
+	SBI_EXT_PMU_COUNTER_STOP,
+	SBI_EXT_PMU_COUNTER_FW_READ,
+	SBI_EXT_PMU_COUNTER_FW_READ_HI,
+	SBI_EXT_PMU_SNAPSHOT_SET_SHMEM,
+};
+
+union sbi_pmu_ctr_info {
+	unsigned long value;
+	struct {
+		unsigned long csr:12;
+		unsigned long width:6;
+#if __riscv_xlen == 32
+		unsigned long reserved:13;
+#else
+		unsigned long reserved:45;
+#endif
+		unsigned long type:1;
+	};
+};
 
 struct sbiret {
 	long error;
 	long value;
 };
 
+/** General pmu event codes specified in SBI PMU extension */
+enum sbi_pmu_hw_generic_events_t {
+	SBI_PMU_HW_NO_EVENT			= 0,
+	SBI_PMU_HW_CPU_CYCLES			= 1,
+	SBI_PMU_HW_INSTRUCTIONS			= 2,
+	SBI_PMU_HW_CACHE_REFERENCES		= 3,
+	SBI_PMU_HW_CACHE_MISSES			= 4,
+	SBI_PMU_HW_BRANCH_INSTRUCTIONS		= 5,
+	SBI_PMU_HW_BRANCH_MISSES		= 6,
+	SBI_PMU_HW_BUS_CYCLES			= 7,
+	SBI_PMU_HW_STALLED_CYCLES_FRONTEND	= 8,
+	SBI_PMU_HW_STALLED_CYCLES_BACKEND	= 9,
+	SBI_PMU_HW_REF_CPU_CYCLES		= 10,
+
+	SBI_PMU_HW_GENERAL_MAX,
+};
+
+/* SBI PMU counter types */
+enum sbi_pmu_ctr_type {
+	SBI_PMU_CTR_TYPE_HW = 0x0,
+	SBI_PMU_CTR_TYPE_FW,
+};
+
+/* Flags defined for config matching function */
+#define SBI_PMU_CFG_FLAG_SKIP_MATCH	BIT(0)
+#define SBI_PMU_CFG_FLAG_CLEAR_VALUE	BIT(1)
+#define SBI_PMU_CFG_FLAG_AUTO_START	BIT(2)
+#define SBI_PMU_CFG_FLAG_SET_VUINH	BIT(3)
+#define SBI_PMU_CFG_FLAG_SET_VSINH	BIT(4)
+#define SBI_PMU_CFG_FLAG_SET_UINH	BIT(5)
+#define SBI_PMU_CFG_FLAG_SET_SINH	BIT(6)
+#define SBI_PMU_CFG_FLAG_SET_MINH	BIT(7)
+
+/* Flags defined for counter start function */
+#define SBI_PMU_START_FLAG_SET_INIT_VALUE BIT(0)
+#define SBI_PMU_START_FLAG_INIT_SNAPSHOT BIT(1)
+
+/* Flags defined for counter stop function */
+#define SBI_PMU_STOP_FLAG_RESET BIT(0)
+#define SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT BIT(1)
+
 struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
 			unsigned long arg1, unsigned long arg2,
 			unsigned long arg3, unsigned long arg4,
-- 
2.34.1


