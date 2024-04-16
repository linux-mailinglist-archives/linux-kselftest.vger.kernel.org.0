Return-Path: <linux-kselftest+bounces-8204-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 209918A73A7
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 20:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BAD61F21924
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 18:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725DB13CABB;
	Tue, 16 Apr 2024 18:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Hh90rara"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3BE13C8F1
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 18:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293105; cv=none; b=hfxgKD/KTFrnZL/hbLwwGQcMcSljiT9cTMAjGPFI6/6sMKkM1AuX7E3vEMLSgdaxcPboZgjdSrhDblH6ZjFtbGafOHY76MBzoA9EXyjZ2nEnBEgr9nrwOO6oMoC38en0Rk0gtX72froFS0OTZZzZQUyZ+kCKAd/YxVtigaWZXHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293105; c=relaxed/simple;
	bh=kMQT5NtU/3H2nu/pPUysYDHLMBWHMS5imSpFNSr8k7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UPm4bgZEPmbSs93oQHZJxCyC9gcUTwOEJ+TV9WbuwMG9Jx6IO9Sd6VcuEinNV9RMufXnh9oLEcG1xW21V2+sDHN2mSqmXf/WPmIlbdm1mjWUKzUAMl4sfyoPunrarYsC3S5sYEZbR6BB129QNaESRVQHxgkVJaZeu9zbFRJgM7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Hh90rara; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e411e339b8so37431875ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 11:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713293103; x=1713897903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/zHwGjJUr6D05KIztpGDsyJZSWroCpzob1LwbCt9c8=;
        b=Hh90rarak4bXNazgHP9M/I+P/HDCwQG9snUUWhvWMyo96S/MlDQCOeoZ1YW8reHElx
         fih0vBX715whnEkSJe2R1YwXJHB+oiliK5WVkLMKEzc4yoe1dEyODgGGbZZq4OiQpY+C
         qfYumXI2pszLETJs1pVCMJ5v/8cG1GIa+wCXHwSenI7I1hk5VlpRWsp+BojGBzIhqftX
         KToD/r1LXZZzPbcCFCJfm1JvkSr9VFm3blKaJAY91ZyIUfkNJlMJtgsyZd6WPkbXZWDQ
         GwYvoy0/ayDpOmlecswZOCgedcNq7tJq0vahgmhQxMSFxxjSU4LEe73VMg3TuxZl6w0M
         f2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713293103; x=1713897903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/zHwGjJUr6D05KIztpGDsyJZSWroCpzob1LwbCt9c8=;
        b=WKNV0oG1dadTT7Xk9/tJftGetbrAdUAGzApgTcvWsR3WSWu2wTitUFtDn0lUCWbHXr
         hVRR4ONeJniA9Ckc2zWqEvY9BGoqb4MftU+gG04rA9n1Cf2lG+NeLz2oqS20Hs9gI0Oy
         G9MRC/oznqU9k2SmZ9JTsQ/pCGDFGWu/OXsEQ3taNBXZ0YPoO3LJQLtv0m5pNpFnLHs6
         hOQw1fxP6o8/LiDfowb7VDNY0VCa4ssPg7HpOt2tEyRf5UeATKM+Ihyl9qAdtI5TeaKV
         3fkyySZsGC71Tqfu2h8VvvX9e7ceNM4B2RJIODH8GY+Ncn0RBORiv7hpI5jbydVF7LMh
         7BCA==
X-Forwarded-Encrypted: i=1; AJvYcCUfg9MflcoM/7rDkynhLtsb3K7KazP8bH0+X8NA82QMv2Vk01biGKK/yh2YtmCQJs2v2wlMG9TmjGIlaDhjNUE0gfdttSENtsUJ8h1m6aPw
X-Gm-Message-State: AOJu0Yxu6Mp6SRFDLBqBl7+mEuaD2TgjkQZQeHs/bRZIa4FXDelvVbgf
	ZzY+swZAviAMccRXY99JaO/0SuTcNum6W5kPyT5MAyodkf+okNWTy0z1GVizXx8=
X-Google-Smtp-Source: AGHT+IGkSLP+G9OfSvAm6OeBIjVKORUjBByK8gTejadMruSiporaGb7bfMqDPAMUlAQl6HsFlPwaYQ==
X-Received: by 2002:a17:90a:fd8f:b0:2a2:bbb9:c937 with SMTP id cx15-20020a17090afd8f00b002a2bbb9c937mr12054639pjb.49.1713293102765;
        Tue, 16 Apr 2024 11:45:02 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090aac1300b002a269828bb8sm8883645pjq.40.2024.04.16.11.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 11:45:02 -0700 (PDT)
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
Subject: [PATCH v7 15/24] RISC-V: KVM: Support 64 bit firmware counters on RV32
Date: Tue, 16 Apr 2024 11:44:12 -0700
Message-Id: <20240416184421.3693802-16-atishp@rivosinc.com>
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

The SBI v2.0 introduced a fw_read_hi function to read 64 bit firmware
counters for RV32 based systems.

Add infrastructure to support that.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/kvm_vcpu_pmu.h |  4 ++-
 arch/riscv/kvm/vcpu_pmu.c             | 44 ++++++++++++++++++++++++++-
 arch/riscv/kvm/vcpu_sbi_pmu.c         |  6 ++++
 3 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_vcpu_pmu.h b/arch/riscv/include/asm/kvm_vcpu_pmu.h
index 257f17641e00..55861b5d3382 100644
--- a/arch/riscv/include/asm/kvm_vcpu_pmu.h
+++ b/arch/riscv/include/asm/kvm_vcpu_pmu.h
@@ -20,7 +20,7 @@ static_assert(RISCV_KVM_MAX_COUNTERS <= 64);
 
 struct kvm_fw_event {
 	/* Current value of the event */
-	unsigned long value;
+	u64 value;
 
 	/* Event monitoring status */
 	bool started;
@@ -91,6 +91,8 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned long ctr_ba
 				     struct kvm_vcpu_sbi_return *retdata);
 int kvm_riscv_vcpu_pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
 				struct kvm_vcpu_sbi_return *retdata);
+int kvm_riscv_vcpu_pmu_fw_ctr_read_hi(struct kvm_vcpu *vcpu, unsigned long cidx,
+				      struct kvm_vcpu_sbi_return *retdata);
 void kvm_riscv_vcpu_pmu_init(struct kvm_vcpu *vcpu);
 int kvm_riscv_vcpu_pmu_snapshot_set_shmem(struct kvm_vcpu *vcpu, unsigned long saddr_low,
 				      unsigned long saddr_high, unsigned long flags,
diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index a801ed52dc9b..e1409ec9afc0 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -197,6 +197,36 @@ static int pmu_get_pmc_index(struct kvm_pmu *pmu, unsigned long eidx,
 	return kvm_pmu_get_programmable_pmc_index(pmu, eidx, cbase, cmask);
 }
 
+static int pmu_fw_ctr_read_hi(struct kvm_vcpu *vcpu, unsigned long cidx,
+			      unsigned long *out_val)
+{
+	struct kvm_pmu *kvpmu = vcpu_to_pmu(vcpu);
+	struct kvm_pmc *pmc;
+	int fevent_code;
+
+	if (!IS_ENABLED(CONFIG_32BIT)) {
+		pr_warn("%s: should be invoked for only RV32\n", __func__);
+		return -EINVAL;
+	}
+
+	if (cidx >= kvm_pmu_num_counters(kvpmu) || cidx == 1) {
+		pr_warn("Invalid counter id [%ld]during read\n", cidx);
+		return -EINVAL;
+	}
+
+	pmc = &kvpmu->pmc[cidx];
+
+	if (pmc->cinfo.type != SBI_PMU_CTR_TYPE_FW)
+		return -EINVAL;
+
+	fevent_code = get_event_code(pmc->event_idx);
+	pmc->counter_val = kvpmu->fw_event[fevent_code].value;
+
+	*out_val = pmc->counter_val >> 32;
+
+	return 0;
+}
+
 static int pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
 			unsigned long *out_val)
 {
@@ -705,6 +735,18 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned long ctr_ba
 	return 0;
 }
 
+int kvm_riscv_vcpu_pmu_fw_ctr_read_hi(struct kvm_vcpu *vcpu, unsigned long cidx,
+				      struct kvm_vcpu_sbi_return *retdata)
+{
+	int ret;
+
+	ret = pmu_fw_ctr_read_hi(vcpu, cidx, &retdata->out_val);
+	if (ret == -EINVAL)
+		retdata->err_val = SBI_ERR_INVALID_PARAM;
+
+	return 0;
+}
+
 int kvm_riscv_vcpu_pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
 				struct kvm_vcpu_sbi_return *retdata)
 {
@@ -778,7 +820,7 @@ void kvm_riscv_vcpu_pmu_init(struct kvm_vcpu *vcpu)
 			pmc->cinfo.csr = CSR_CYCLE + i;
 		} else {
 			pmc->cinfo.type = SBI_PMU_CTR_TYPE_FW;
-			pmc->cinfo.width = BITS_PER_LONG - 1;
+			pmc->cinfo.width = 63;
 		}
 	}
 
diff --git a/arch/riscv/kvm/vcpu_sbi_pmu.c b/arch/riscv/kvm/vcpu_sbi_pmu.c
index d3e7625fb2d2..cf111de51bdb 100644
--- a/arch/riscv/kvm/vcpu_sbi_pmu.c
+++ b/arch/riscv/kvm/vcpu_sbi_pmu.c
@@ -64,6 +64,12 @@ static int kvm_sbi_ext_pmu_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	case SBI_EXT_PMU_COUNTER_FW_READ:
 		ret = kvm_riscv_vcpu_pmu_ctr_read(vcpu, cp->a0, retdata);
 		break;
+	case SBI_EXT_PMU_COUNTER_FW_READ_HI:
+		if (IS_ENABLED(CONFIG_32BIT))
+			ret = kvm_riscv_vcpu_pmu_fw_ctr_read_hi(vcpu, cp->a0, retdata);
+		else
+			retdata->out_val = 0;
+		break;
 	case SBI_EXT_PMU_SNAPSHOT_SET_SHMEM:
 		ret = kvm_riscv_vcpu_pmu_snapshot_set_shmem(vcpu, cp->a0, cp->a1, cp->a2, retdata);
 		break;
-- 
2.34.1


