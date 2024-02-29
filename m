Return-Path: <linux-kselftest+bounces-5586-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD2886BDEF
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 02:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDB8F1C223F4
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 01:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDA451033;
	Thu, 29 Feb 2024 01:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="VmJIYRLc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAEB4F215
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Feb 2024 01:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709168517; cv=none; b=pwxVqUdlL5vtCAEn8iVuP53k0nVgNiBrd44qVqfvem1vlQ6tllapS4I62VA2fIXiCxqZ8FXSJfy6SecVNeQwQGIVzspMK+CPI+4kF/8T6mv9JZfPUr9UyWenISvsFno9svwFT8b4QAq0ph5Yb6i/zZnOEb+uuFZcTeeW9oOJgz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709168517; c=relaxed/simple;
	bh=7l67F8XIduwEbqCwQadKxoUoyejLMO0EXfENrPowktE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bX8UyCJY1p6Ol1hlBqvtqTfOwTaYNZ6hjZ+/DzUWq3zOXhX40ZXhwpsNFFiJox17Eq3AM0zVJos/LTciDbJoDeFRAxj6cgF72XYoObenkyM99r2gVjzlzKUYq0CP5NBh+P9FhHDuW775VubjYFKrJaVTdZiIlL/nU1heiOiBZRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=VmJIYRLc; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dca3951ad9so3948665ad.3
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 17:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709168515; x=1709773315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFyzkxFTCB/H1W/EIIzp1/a6ouaBHPpkCS6jjNdCSQg=;
        b=VmJIYRLc9VCd0pMkffVzeJrSc6rXNyf/RQqwZh250Esg4FUz1qHmmdgRhY2hhCn3hY
         iTuP+wlFfjJKR4dYILztYcS0nkh1mF0p0ItIFhUCD/zAdSJHfisW/cZp6HUYvl698OHg
         MfK6FRL+27E+ZH8CjaA/9VGYcL8BGO7Duj3bbNP1GRfoEHtwrgFL6VrGPoqHHCZasOn2
         +V7V3VP9yZf7cXXS8cRzhCa9okKbg5heSVCBLJ2E9YOHHjYMjwcTkFODjYQwH1duUZij
         7/6ibAC+wYiCt4SIM912vc1SMjuJOn+adXF/ORqnnbxql0eQWcKDwtVbIR48vFP4M0Or
         bTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709168515; x=1709773315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFyzkxFTCB/H1W/EIIzp1/a6ouaBHPpkCS6jjNdCSQg=;
        b=vbbiD+ElL2NxV4GdRYLadMBbJj/GF6vmiEinFp0tQhaM55urNbGNYGe2lsHZoMlcuX
         lAWFBWD/54NOmPwyLVRuHxbo0qTQsMezyfWVoUk8/lDTGeLpOtof1M9GLOpxGsxLTaK0
         gBMtdVEwgA5SXX60qL1lW/NCKsEpDqnEigJVBE+Mi45k2vlspeswTs9tpFZ8lski5190
         QbWvk/R3qGmk7tJn0FYIrm0VOqbBuq12EizLq4vEYRwld0IGRQySstIYAm5ckO9OmqWb
         T9m/n11GcW0Yr+xkXA6f6RBjxjXdgolfKSAxGPsO9gZPCLeB5X2iN62+i/BqY0FqsQuU
         fg6A==
X-Forwarded-Encrypted: i=1; AJvYcCWZF7TdDF721/QzDfunjeP/bJoo6jTXSOdNoNe6Nuaw3nUrun1PXQ3NtJblx9caiA7hWrj2epbi07eMcMJQLFYQtxWeRb43i0LGBUtiJK4a
X-Gm-Message-State: AOJu0YwwVdaEMZrTVTv820yJi/IYHiX9FQwX0DpxR1ntdY+mHCGPDl61
	rr8ah/Q8qJAby5Jlq6WIr8jG35rDhcEONys0Fd6nuDF2yCIO4VSnE+s4ZORHTm0=
X-Google-Smtp-Source: AGHT+IFkP6LHQuWtEjxFUd1+wmaQJZSIilrD5agA6clYHhvqg47teFwKrMibf18aatRcQTAkEgri0g==
X-Received: by 2002:a17:903:44c:b0:1dc:854f:9a7e with SMTP id iw12-20020a170903044c00b001dc854f9a7emr573758plb.60.1709168515602;
        Wed, 28 Feb 2024 17:01:55 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id j14-20020a170902da8e00b001dc8d6a9d40sm78043plx.144.2024.02.28.17.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 17:01:55 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Patra <atishp@atishpatra.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Guo Ren <guoren@kernel.org>,
	Icenowy Zheng <uwu@icenowy.me>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Shuah Khan <shuah@kernel.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v4 08/15] RISC-V: KVM: Implement SBI PMU Snapshot feature
Date: Wed, 28 Feb 2024 17:01:23 -0800
Message-Id: <20240229010130.1380926-9-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229010130.1380926-1-atishp@rivosinc.com>
References: <20240229010130.1380926-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PMU Snapshot function allows to minimize the number of traps when the
guest access configures/access the hpmcounters. If the snapshot feature
is enabled, the hypervisor updates the shared memory with counter
data and state of overflown counters. The guest can just read the
shared memory instead of trap & emulate done by the hypervisor.

This patch doesn't implement the counter overflow yet.

Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/kvm_vcpu_pmu.h |   7 ++
 arch/riscv/kvm/vcpu_pmu.c             | 120 +++++++++++++++++++++++++-
 arch/riscv/kvm/vcpu_sbi_pmu.c         |   3 +
 drivers/perf/riscv_pmu_sbi.c          |   2 +-
 4 files changed, 129 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_vcpu_pmu.h b/arch/riscv/include/asm/kvm_vcpu_pmu.h
index 395518a1664e..586bab84be35 100644
--- a/arch/riscv/include/asm/kvm_vcpu_pmu.h
+++ b/arch/riscv/include/asm/kvm_vcpu_pmu.h
@@ -50,6 +50,10 @@ struct kvm_pmu {
 	bool init_done;
 	/* Bit map of all the virtual counter used */
 	DECLARE_BITMAP(pmc_in_use, RISCV_KVM_MAX_COUNTERS);
+	/* The address of the counter snapshot area (guest physical address) */
+	gpa_t snapshot_addr;
+	/* The actual data of the snapshot */
+	struct riscv_pmu_snapshot_data *sdata;
 };
 
 #define vcpu_to_pmu(vcpu) (&(vcpu)->arch.pmu_context)
@@ -85,6 +89,9 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned long ctr_ba
 int kvm_riscv_vcpu_pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
 				struct kvm_vcpu_sbi_return *retdata);
 void kvm_riscv_vcpu_pmu_init(struct kvm_vcpu *vcpu);
+int kvm_riscv_vcpu_pmu_setup_snapshot(struct kvm_vcpu *vcpu, unsigned long saddr_low,
+				      unsigned long saddr_high, unsigned long flags,
+				      struct kvm_vcpu_sbi_return *retdata);
 void kvm_riscv_vcpu_pmu_deinit(struct kvm_vcpu *vcpu);
 void kvm_riscv_vcpu_pmu_reset(struct kvm_vcpu *vcpu);
 
diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index 29bf4ca798cb..74865e6050a1 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -311,6 +311,81 @@ int kvm_riscv_vcpu_pmu_read_hpm(struct kvm_vcpu *vcpu, unsigned int csr_num,
 	return ret;
 }
 
+static void kvm_pmu_clear_snapshot_area(struct kvm_vcpu *vcpu)
+{
+	struct kvm_pmu *kvpmu = vcpu_to_pmu(vcpu);
+	int snapshot_area_size = sizeof(struct riscv_pmu_snapshot_data);
+
+	if (kvpmu->sdata) {
+		memset(kvpmu->sdata, 0, snapshot_area_size);
+		if (kvpmu->snapshot_addr != INVALID_GPA)
+			kvm_vcpu_write_guest(vcpu, kvpmu->snapshot_addr,
+					     kvpmu->sdata, snapshot_area_size);
+		kfree(kvpmu->sdata);
+		kvpmu->sdata = NULL;
+	}
+	kvpmu->snapshot_addr = INVALID_GPA;
+}
+
+int kvm_riscv_vcpu_pmu_setup_snapshot(struct kvm_vcpu *vcpu, unsigned long saddr_low,
+				      unsigned long saddr_high, unsigned long flags,
+				      struct kvm_vcpu_sbi_return *retdata)
+{
+	struct kvm_pmu *kvpmu = vcpu_to_pmu(vcpu);
+	int snapshot_area_size = sizeof(struct riscv_pmu_snapshot_data);
+	int sbiret = 0;
+	gpa_t saddr;
+	unsigned long hva;
+	bool writable;
+
+	if (!kvpmu) {
+		sbiret = SBI_ERR_INVALID_PARAM;
+		goto out;
+	}
+
+	if (saddr_low == -1 && saddr_high == -1) {
+		kvm_pmu_clear_snapshot_area(vcpu);
+		return 0;
+	}
+
+	saddr = saddr_low;
+
+	if (saddr_high != 0) {
+		if (IS_ENABLED(CONFIG_32BIT))
+			saddr |= ((gpa_t)saddr << 32);
+		else
+			sbiret = SBI_ERR_INVALID_ADDRESS;
+		goto out;
+	}
+
+	if (kvm_is_error_gpa(vcpu->kvm, saddr)) {
+		sbiret = SBI_ERR_INVALID_PARAM;
+		goto out;
+	}
+
+	hva = kvm_vcpu_gfn_to_hva_prot(vcpu, saddr >> PAGE_SHIFT, &writable);
+	if (kvm_is_error_hva(hva) || !writable) {
+		sbiret = SBI_ERR_INVALID_ADDRESS;
+		goto out;
+	}
+
+	kvpmu->snapshot_addr = saddr;
+	kvpmu->sdata = kzalloc(snapshot_area_size, GFP_ATOMIC);
+	if (!kvpmu->sdata)
+		return -ENOMEM;
+
+	if (kvm_vcpu_write_guest(vcpu, saddr, kvpmu->sdata, snapshot_area_size)) {
+		kfree(kvpmu->sdata);
+		kvpmu->snapshot_addr = INVALID_GPA;
+		sbiret = SBI_ERR_FAILURE;
+	}
+
+out:
+	retdata->err_val = sbiret;
+
+	return 0;
+}
+
 int kvm_riscv_vcpu_pmu_num_ctrs(struct kvm_vcpu *vcpu,
 				struct kvm_vcpu_sbi_return *retdata)
 {
@@ -344,20 +419,33 @@ int kvm_riscv_vcpu_pmu_ctr_start(struct kvm_vcpu *vcpu, unsigned long ctr_base,
 	int i, pmc_index, sbiret = 0;
 	struct kvm_pmc *pmc;
 	int fevent_code;
+	bool snap_flag_set = flags & SBI_PMU_START_FLAG_INIT_FROM_SNAPSHOT;
 
 	if (kvm_pmu_validate_counter_mask(kvpmu, ctr_base, ctr_mask) < 0) {
 		sbiret = SBI_ERR_INVALID_PARAM;
 		goto out;
 	}
 
+	if (snap_flag_set && kvpmu->snapshot_addr == INVALID_GPA) {
+		sbiret = SBI_ERR_NO_SHMEM;
+		goto out;
+	}
+
 	/* Start the counters that have been configured and requested by the guest */
 	for_each_set_bit(i, &ctr_mask, RISCV_MAX_COUNTERS) {
 		pmc_index = i + ctr_base;
 		if (!test_bit(pmc_index, kvpmu->pmc_in_use))
 			continue;
 		pmc = &kvpmu->pmc[pmc_index];
-		if (flags & SBI_PMU_START_FLAG_SET_INIT_VALUE)
+		if (flags & SBI_PMU_START_FLAG_SET_INIT_VALUE) {
 			pmc->counter_val = ival;
+		} else if (snap_flag_set) {
+			kvm_vcpu_read_guest(vcpu, kvpmu->snapshot_addr, kvpmu->sdata,
+					    sizeof(struct riscv_pmu_snapshot_data));
+			/* The counter index in the snapshot are relative to the counter base */
+			pmc->counter_val = kvpmu->sdata->ctr_values[i];
+		}
+
 		if (pmc->cinfo.type == SBI_PMU_CTR_TYPE_FW) {
 			fevent_code = get_event_code(pmc->event_idx);
 			if (fevent_code >= SBI_PMU_FW_MAX) {
@@ -398,14 +486,21 @@ int kvm_riscv_vcpu_pmu_ctr_stop(struct kvm_vcpu *vcpu, unsigned long ctr_base,
 {
 	struct kvm_pmu *kvpmu = vcpu_to_pmu(vcpu);
 	int i, pmc_index, sbiret = 0;
+	u64 enabled, running;
 	struct kvm_pmc *pmc;
 	int fevent_code;
+	bool snap_flag_set = flags & SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT;
 
-	if (kvm_pmu_validate_counter_mask(kvpmu, ctr_base, ctr_mask) < 0) {
+	if ((kvm_pmu_validate_counter_mask(kvpmu, ctr_base, ctr_mask) < 0)) {
 		sbiret = SBI_ERR_INVALID_PARAM;
 		goto out;
 	}
 
+	if (snap_flag_set && kvpmu->snapshot_addr == INVALID_GPA) {
+		sbiret = SBI_ERR_NO_SHMEM;
+		goto out;
+	}
+
 	/* Stop the counters that have been configured and requested by the guest */
 	for_each_set_bit(i, &ctr_mask, RISCV_MAX_COUNTERS) {
 		pmc_index = i + ctr_base;
@@ -438,9 +533,28 @@ int kvm_riscv_vcpu_pmu_ctr_stop(struct kvm_vcpu *vcpu, unsigned long ctr_base,
 		} else {
 			sbiret = SBI_ERR_INVALID_PARAM;
 		}
+
+		if (snap_flag_set && !sbiret) {
+			if (pmc->cinfo.type == SBI_PMU_CTR_TYPE_FW)
+				pmc->counter_val = kvpmu->fw_event[fevent_code].value;
+			else if (pmc->perf_event)
+				pmc->counter_val += perf_event_read_value(pmc->perf_event,
+									  &enabled, &running);
+			/* TODO: Add counter overflow support when sscofpmf support is added */
+			kvpmu->sdata->ctr_values[i] = pmc->counter_val;
+			kvm_vcpu_write_guest(vcpu, kvpmu->snapshot_addr, kvpmu->sdata,
+					     sizeof(struct riscv_pmu_snapshot_data));
+		}
+
 		if (flags & SBI_PMU_STOP_FLAG_RESET) {
 			pmc->event_idx = SBI_PMU_EVENT_IDX_INVALID;
 			clear_bit(pmc_index, kvpmu->pmc_in_use);
+			if (snap_flag_set) {
+				/* Clear the snapshot area for the upcoming deletion event */
+				kvpmu->sdata->ctr_values[i] = 0;
+				kvm_vcpu_write_guest(vcpu, kvpmu->snapshot_addr, kvpmu->sdata,
+						     sizeof(struct riscv_pmu_snapshot_data));
+			}
 		}
 	}
 
@@ -566,6 +680,7 @@ void kvm_riscv_vcpu_pmu_init(struct kvm_vcpu *vcpu)
 	kvpmu->num_hw_ctrs = num_hw_ctrs + 1;
 	kvpmu->num_fw_ctrs = SBI_PMU_FW_MAX;
 	memset(&kvpmu->fw_event, 0, SBI_PMU_FW_MAX * sizeof(struct kvm_fw_event));
+	kvpmu->snapshot_addr = INVALID_GPA;
 
 	if (kvpmu->num_hw_ctrs > RISCV_KVM_MAX_HW_CTRS) {
 		pr_warn_once("Limiting the hardware counters to 32 as specified by the ISA");
@@ -625,6 +740,7 @@ void kvm_riscv_vcpu_pmu_deinit(struct kvm_vcpu *vcpu)
 	}
 	bitmap_zero(kvpmu->pmc_in_use, RISCV_MAX_COUNTERS);
 	memset(&kvpmu->fw_event, 0, SBI_PMU_FW_MAX * sizeof(struct kvm_fw_event));
+	kvm_pmu_clear_snapshot_area(vcpu);
 }
 
 void kvm_riscv_vcpu_pmu_reset(struct kvm_vcpu *vcpu)
diff --git a/arch/riscv/kvm/vcpu_sbi_pmu.c b/arch/riscv/kvm/vcpu_sbi_pmu.c
index b70179e9e875..9f61136e4bb1 100644
--- a/arch/riscv/kvm/vcpu_sbi_pmu.c
+++ b/arch/riscv/kvm/vcpu_sbi_pmu.c
@@ -64,6 +64,9 @@ static int kvm_sbi_ext_pmu_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	case SBI_EXT_PMU_COUNTER_FW_READ:
 		ret = kvm_riscv_vcpu_pmu_ctr_read(vcpu, cp->a0, retdata);
 		break;
+	case SBI_EXT_PMU_SNAPSHOT_SET_SHMEM:
+		ret = kvm_riscv_vcpu_pmu_setup_snapshot(vcpu, cp->a0, cp->a1, cp->a2, retdata);
+		break;
 	default:
 		retdata->err_val = SBI_ERR_NOT_SUPPORTED;
 	}
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 8de5721e8019..1a22ce1ff8c8 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -802,7 +802,7 @@ static noinline void pmu_sbi_start_ovf_ctrs_snapshot(struct cpu_hw_events *cpu_h
 	struct riscv_pmu_snapshot_data *sdata = cpu_hw_evt->snapshot_addr;
 
 	for_each_set_bit(idx, cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTERS) {
-		if (ctr_ovf_mask & (1 << idx)) {
+		if (ctr_ovf_mask & (BIT(idx))) {
 			event = cpu_hw_evt->events[idx];
 			hwc = &event->hw;
 			max_period = riscv_pmu_ctr_get_width_mask(event);
-- 
2.34.1


