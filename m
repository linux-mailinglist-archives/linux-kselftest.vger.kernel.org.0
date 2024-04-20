Return-Path: <linux-kselftest+bounces-8493-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9248AB7B0
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 01:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F6A281F2F
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 23:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2199145340;
	Fri, 19 Apr 2024 23:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="DYnKaR6V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F188E1448FB
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 23:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713570483; cv=none; b=tQ8YD0UybpZZOoXgkTPOhSBDzbdQUlUgCOkNUjxDa20DO4ZXmcLFMLaydJ7bROIAcx3oh38Ir+e+brxdssM4HR9EGdO/RNPzrqexcvS6uVh3HA4nrRlibIXhSzRwMukdXN/M3qRVAdosOIJqM67bG4nNgCnCQkseXzSz/cEav8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713570483; c=relaxed/simple;
	bh=kM5CopkEsgTaQKXrbckXT/uwabNw3lYMOMjb+jknKHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EFpas5/8nfWR2VfuzUG+bInr05HF1y/AW+ufbls6AhbwseGY+a7YaMnI4gO+dqtCmFixgFWCXLKH2I2aiWlRgeIQrIO7tQJO86BFp6RwzaEESukXuyY8WYoszDJQOq54Kqgr0BhH5+Xyz1kIhhSqs1/AQQ9ZfDjXweKEDE18cUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=DYnKaR6V; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e834159f40so21092245ad.2
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 16:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713570481; x=1714175281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLlpOQ1Kh/EdqYXwWF/BBBScRjozwpPrFVxSyIvbVEs=;
        b=DYnKaR6VqWa6iTUX+Co2t6qJgyqjUrpGFn/mzoCFk9VEcjM0NRmyXxEvmP6FNKVuMZ
         tlKaGP/5YMLJWHRp8hqg7T2H0RiWepHza4q+LXVjLdAcAEajStTD1rXjuf+5QsXsk41w
         GJVx9TSfmppqXblfz4y8BW7FeE8kOvRJhO7ldlGASm8uGGxH/fqTUE2hCDiENsdFsBSp
         hWUB78aTqkQwlbNgDwDMxb7Lf1eFJM7VxPtfRsp4JD0tZPs93LHoFteGHOosNyXkU3vt
         k0Ilzw2+TNqcw8Vb20veS1yiG8Z2a0742/kULQCbuPmw0vhFxc/7E73rToGVcWxHS8nP
         rzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713570481; x=1714175281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLlpOQ1Kh/EdqYXwWF/BBBScRjozwpPrFVxSyIvbVEs=;
        b=AQHlxIiJEhbQ6/t/shmSvcHojAwiDmk0N9BPOMCLKCLFGK6BvfPv/NCjAqrbmnty+9
         EELcScytL3uKTE/Q8csayIebybY2TqmU0/VygX4DuB6Qhl89jYhYDJX9sIOqDeZOFPfs
         2sXeoG4ql4Jtfw39LGarrFRrBC/P0IcTvQjck6tT486XY98TZEWz4moRXWuMJ8/cRJCy
         YXQRd3QTgkmtlhbk7hyQov49RNLlCsYH2HUAPcPuW5u7USnIvqk1kBne7KdGIRyMyzmb
         fMytjMviEk4OD8jYkAJLmOSDL8aJ9lLoUHCFM3W4Fbpde5jLyC1kuFiEwp7uDoJp9qmd
         ibzA==
X-Forwarded-Encrypted: i=1; AJvYcCWWYvgOAUaFkCZQrCwpjfoPoMXUIzU6Mo8peD/vQwiJL1y9ZXiZvsVJLekVM+3gZ16vCox/N6wvSnloevdWFb3QPsfMusbRjSMoJ+jgrga6
X-Gm-Message-State: AOJu0YzOdnkLZczTQ3WbVcPsX5R+W1UfCilMZ7SdY/SJa//SLRW42wVA
	tGAUiRjNcyJi0CxPRrYUYQvX/l/sPBfy8b1+TVQY2HGffdxSoeAJehS5x6naE7o=
X-Google-Smtp-Source: AGHT+IGpd/k++uBpnHvwXFFhxjV+WzXncc9ClP9LAZ8a75FN+NFM0WCbYQDnO+mpaDVL72EDirUEvg==
X-Received: by 2002:a17:902:e807:b0:1e5:556:60e2 with SMTP id u7-20020a170902e80700b001e5055660e2mr4708386plg.5.1713570481235;
        Fri, 19 Apr 2024 16:48:01 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902d11100b001e42f215f33sm3924017plw.85.2024.04.19.16.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 16:48:00 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	samuel.holland@sifive.com,
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
Subject: [PATCH v8 09/24] drivers/perf: riscv: Implement SBI PMU snapshot function
Date: Sat, 20 Apr 2024 08:17:25 -0700
Message-Id: <20240420151741.962500-10-atishp@rivosinc.com>
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

SBI v2.0 SBI introduced PMU snapshot feature which adds the following
features.

1. Read counter values directly from the shared memory instead of
csr read.
2. Start multiple counters with initial values with one SBI call.

These functionalities optimizes the number of traps to the higher
privilege mode. If the kernel is in VS mode while the hypervisor
deploy trap & emulate method, this would minimize all the hpmcounter
CSR read traps. If the kernel is running in S-mode, the benefits
reduced to CSR latency vs DRAM/cache latency as there is no trap
involved while accessing the hpmcounter CSRs.

In both modes, it does saves the number of ecalls while starting
multiple counter together with an initial values. This is a likely
scenario if multiple counters overflow at the same time.

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/perf/riscv_pmu.c       |   1 +
 drivers/perf/riscv_pmu_sbi.c   | 265 ++++++++++++++++++++++++++++++---
 include/linux/perf/riscv_pmu.h |   6 +
 3 files changed, 255 insertions(+), 17 deletions(-)

diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
index b4efdddb2ad9..36d348753d05 100644
--- a/drivers/perf/riscv_pmu.c
+++ b/drivers/perf/riscv_pmu.c
@@ -408,6 +408,7 @@ struct riscv_pmu *riscv_pmu_alloc(void)
 		cpuc->n_events = 0;
 		for (i = 0; i < RISCV_MAX_COUNTERS; i++)
 			cpuc->events[i] = NULL;
+		cpuc->snapshot_addr = NULL;
 	}
 	pmu->pmu = (struct pmu) {
 		.event_init	= riscv_pmu_event_init,
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 4eacd89141a9..2694110f1cff 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -58,6 +58,9 @@ PMU_FORMAT_ATTR(event, "config:0-47");
 PMU_FORMAT_ATTR(firmware, "config:63");
 
 static bool sbi_v2_available;
+static DEFINE_STATIC_KEY_FALSE(sbi_pmu_snapshot_available);
+#define sbi_pmu_snapshot_available() \
+	static_branch_unlikely(&sbi_pmu_snapshot_available)
 
 static struct attribute *riscv_arch_formats_attr[] = {
 	&format_attr_event.attr,
@@ -508,14 +511,105 @@ static int pmu_sbi_event_map(struct perf_event *event, u64 *econfig)
 	return ret;
 }
 
+static void pmu_sbi_snapshot_free(struct riscv_pmu *pmu)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct cpu_hw_events *cpu_hw_evt = per_cpu_ptr(pmu->hw_events, cpu);
+
+		if (!cpu_hw_evt->snapshot_addr)
+			continue;
+
+		free_page((unsigned long)cpu_hw_evt->snapshot_addr);
+		cpu_hw_evt->snapshot_addr = NULL;
+		cpu_hw_evt->snapshot_addr_phys = 0;
+	}
+}
+
+static int pmu_sbi_snapshot_alloc(struct riscv_pmu *pmu)
+{
+	int cpu;
+	struct page *snapshot_page;
+
+	for_each_possible_cpu(cpu) {
+		struct cpu_hw_events *cpu_hw_evt = per_cpu_ptr(pmu->hw_events, cpu);
+
+		snapshot_page = alloc_page(GFP_ATOMIC | __GFP_ZERO);
+		if (!snapshot_page) {
+			pmu_sbi_snapshot_free(pmu);
+			return -ENOMEM;
+		}
+		cpu_hw_evt->snapshot_addr = page_to_virt(snapshot_page);
+		cpu_hw_evt->snapshot_addr_phys = page_to_phys(snapshot_page);
+	}
+
+	return 0;
+}
+
+static int pmu_sbi_snapshot_disable(void)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_SNAPSHOT_SET_SHMEM, SBI_SHMEM_DISABLE,
+			SBI_SHMEM_DISABLE, 0, 0, 0, 0);
+	if (ret.error) {
+		pr_warn("failed to disable snapshot shared memory\n");
+		return sbi_err_map_linux_errno(ret.error);
+	}
+
+	return 0;
+}
+
+static int pmu_sbi_snapshot_setup(struct riscv_pmu *pmu, int cpu)
+{
+	struct cpu_hw_events *cpu_hw_evt;
+	struct sbiret ret = {0};
+
+	cpu_hw_evt = per_cpu_ptr(pmu->hw_events, cpu);
+	if (!cpu_hw_evt->snapshot_addr_phys)
+		return -EINVAL;
+
+	if (cpu_hw_evt->snapshot_set_done)
+		return 0;
+
+	if (IS_ENABLED(CONFIG_32BIT))
+		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_SNAPSHOT_SET_SHMEM,
+				cpu_hw_evt->snapshot_addr_phys,
+				(u64)(cpu_hw_evt->snapshot_addr_phys) >> 32, 0, 0, 0, 0);
+	else
+		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_SNAPSHOT_SET_SHMEM,
+				cpu_hw_evt->snapshot_addr_phys, 0, 0, 0, 0, 0);
+
+	/* Free up the snapshot area memory and fall back to SBI PMU calls without snapshot */
+	if (ret.error) {
+		if (ret.error != SBI_ERR_NOT_SUPPORTED)
+			pr_warn("pmu snapshot setup failed with error %ld\n", ret.error);
+		return sbi_err_map_linux_errno(ret.error);
+	}
+
+	cpu_hw_evt->snapshot_set_done = true;
+
+	return 0;
+}
+
 static u64 pmu_sbi_ctr_read(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
 	struct sbiret ret;
 	u64 val = 0;
+	struct riscv_pmu *pmu = to_riscv_pmu(event->pmu);
+	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
+	struct riscv_pmu_snapshot_data *sdata = cpu_hw_evt->snapshot_addr;
 	union sbi_pmu_ctr_info info = pmu_ctr_list[idx];
 
+	/* Read the value from the shared memory directly only if counter is stopped */
+	if (sbi_pmu_snapshot_available() & (hwc->state & PERF_HES_STOPPED)) {
+		val = sdata->ctr_values[idx];
+		return val;
+	}
+
 	if (pmu_sbi_is_fw_event(event)) {
 		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_FW_READ,
 				hwc->idx, 0, 0, 0, 0, 0);
@@ -565,6 +659,7 @@ static void pmu_sbi_ctr_start(struct perf_event *event, u64 ival)
 	struct hw_perf_event *hwc = &event->hw;
 	unsigned long flag = SBI_PMU_START_FLAG_SET_INIT_VALUE;
 
+	/* There is no benefit setting SNAPSHOT FLAG for a single counter */
 #if defined(CONFIG_32BIT)
 	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, hwc->idx,
 			1, flag, ival, ival >> 32, 0);
@@ -585,16 +680,36 @@ static void pmu_sbi_ctr_stop(struct perf_event *event, unsigned long flag)
 {
 	struct sbiret ret;
 	struct hw_perf_event *hwc = &event->hw;
+	struct riscv_pmu *pmu = to_riscv_pmu(event->pmu);
+	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
+	struct riscv_pmu_snapshot_data *sdata = cpu_hw_evt->snapshot_addr;
 
 	if ((hwc->flags & PERF_EVENT_FLAG_USER_ACCESS) &&
 	    (hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT))
 		pmu_sbi_reset_scounteren((void *)event);
 
+	if (sbi_pmu_snapshot_available())
+		flag |= SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT;
+
 	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, hwc->idx, 1, flag, 0, 0, 0);
-	if (ret.error && (ret.error != SBI_ERR_ALREADY_STOPPED) &&
-		flag != SBI_PMU_STOP_FLAG_RESET)
+	if (!ret.error && sbi_pmu_snapshot_available()) {
+		/*
+		 * The counter snapshot is based on the index base specified by hwc->idx.
+		 * The actual counter value is updated in shared memory at index 0 when counter
+		 * mask is 0x01. To ensure accurate counter values, it's necessary to transfer
+		 * the counter value to shared memory. However, if hwc->idx is zero, the counter
+		 * value is already correctly updated in shared memory, requiring no further
+		 * adjustment.
+		 */
+		if (hwc->idx > 0) {
+			sdata->ctr_values[hwc->idx] = sdata->ctr_values[0];
+			sdata->ctr_values[0] = 0;
+		}
+	} else if (ret.error && (ret.error != SBI_ERR_ALREADY_STOPPED) &&
+		flag != SBI_PMU_STOP_FLAG_RESET) {
 		pr_err("Stopping counter idx %d failed with error %d\n",
 			hwc->idx, sbi_err_map_linux_errno(ret.error));
+	}
 }
 
 static int pmu_sbi_find_num_ctrs(void)
@@ -652,12 +767,39 @@ static inline void pmu_sbi_stop_all(struct riscv_pmu *pmu)
 static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
 {
 	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
+	struct riscv_pmu_snapshot_data *sdata = cpu_hw_evt->snapshot_addr;
+	unsigned long flag = 0;
 	int i;
+	struct sbiret ret;
+	unsigned long temp_ctr_values[64] = {0};
+	unsigned long ctr_val, temp_ctr_overflow_mask = 0;
 
-	for (i = 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++)
+	if (sbi_pmu_snapshot_available())
+		flag = SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT;
+
+	for (i = 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++) {
 		/* No need to check the error here as we can't do anything about the error */
-		sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, i * BITS_PER_LONG,
-			  cpu_hw_evt->used_hw_ctrs[i], 0, 0, 0, 0);
+		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, i * BITS_PER_LONG,
+				cpu_hw_evt->used_hw_ctrs[i], flag, 0, 0, 0);
+		if (!ret.error && sbi_pmu_snapshot_available()) {
+			/* Save the counter values to avoid clobbering */
+			temp_ctr_values[i * BITS_PER_LONG + i] = sdata->ctr_values[i];
+			/* Save the overflow mask to avoid clobbering */
+			if (BIT(i) & sdata->ctr_overflow_mask)
+				temp_ctr_overflow_mask |= BIT(i + i * BITS_PER_LONG);
+		}
+	}
+
+	/* Restore the counter values to the shared memory */
+	if (sbi_pmu_snapshot_available()) {
+		for (i = 0; i < 64; i++) {
+			ctr_val = temp_ctr_values[i];
+			if (ctr_val)
+				sdata->ctr_values[i] = ctr_val;
+			if (temp_ctr_overflow_mask)
+				sdata->ctr_overflow_mask = temp_ctr_overflow_mask;
+		}
+	}
 }
 
 /*
@@ -666,11 +808,10 @@ static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
  * while the overflowed counters need to be started with updated initialization
  * value.
  */
-static inline void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
-					       unsigned long ctr_ovf_mask)
+static inline void pmu_sbi_start_ovf_ctrs_sbi(struct cpu_hw_events *cpu_hw_evt,
+					      u64 ctr_ovf_mask)
 {
 	int idx = 0, i;
-	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
 	struct perf_event *event;
 	unsigned long flag = SBI_PMU_START_FLAG_SET_INIT_VALUE;
 	unsigned long ctr_start_mask = 0;
@@ -706,6 +847,48 @@ static inline void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
 	}
 }
 
+static inline void pmu_sbi_start_ovf_ctrs_snapshot(struct cpu_hw_events *cpu_hw_evt,
+						   u64 ctr_ovf_mask)
+{
+	int idx = 0;
+	struct perf_event *event;
+	unsigned long flag = SBI_PMU_START_FLAG_INIT_SNAPSHOT;
+	u64 max_period, init_val = 0;
+	struct hw_perf_event *hwc;
+	struct riscv_pmu_snapshot_data *sdata = cpu_hw_evt->snapshot_addr;
+
+	for_each_set_bit(idx, cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTERS) {
+		if (ctr_ovf_mask & BIT(idx)) {
+			event = cpu_hw_evt->events[idx];
+			hwc = &event->hw;
+			max_period = riscv_pmu_ctr_get_width_mask(event);
+			init_val = local64_read(&hwc->prev_count) & max_period;
+			sdata->ctr_values[idx] = init_val;
+		}
+		/*
+		 * We do not need to update the non-overflow counters the previous
+		 * value should have been there already.
+		 */
+	}
+
+	for (idx = 0; idx < BITS_TO_LONGS(RISCV_MAX_COUNTERS); idx++) {
+		/* Start all the counters in a single shot */
+		sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, idx * BITS_PER_LONG,
+			  cpu_hw_evt->used_hw_ctrs[idx], flag, 0, 0, 0);
+	}
+}
+
+static void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
+					u64 ctr_ovf_mask)
+{
+	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
+
+	if (sbi_pmu_snapshot_available())
+		pmu_sbi_start_ovf_ctrs_snapshot(cpu_hw_evt, ctr_ovf_mask);
+	else
+		pmu_sbi_start_ovf_ctrs_sbi(cpu_hw_evt, ctr_ovf_mask);
+}
+
 static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 {
 	struct perf_sample_data data;
@@ -716,9 +899,10 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 	struct riscv_pmu *pmu;
 	struct perf_event *event;
 	unsigned long overflow;
-	unsigned long overflowed_ctrs = 0;
+	u64 overflowed_ctrs = 0;
 	struct cpu_hw_events *cpu_hw_evt = dev;
 	u64 start_clock = sched_clock();
+	struct riscv_pmu_snapshot_data *sdata = cpu_hw_evt->snapshot_addr;
 
 	if (WARN_ON_ONCE(!cpu_hw_evt))
 		return IRQ_NONE;
@@ -740,7 +924,10 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 	pmu_sbi_stop_hw_ctrs(pmu);
 
 	/* Overflow status register should only be read after counter are stopped */
-	ALT_SBI_PMU_OVERFLOW(overflow);
+	if (sbi_pmu_snapshot_available())
+		overflow = sdata->ctr_overflow_mask;
+	else
+		ALT_SBI_PMU_OVERFLOW(overflow);
 
 	/*
 	 * Overflow interrupt pending bit should only be cleared after stopping
@@ -766,9 +953,14 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 		if (!info || info->type != SBI_PMU_CTR_TYPE_HW)
 			continue;
 
-		/* compute hardware counter index */
-		hidx = info->csr - CSR_CYCLE;
-		/* check if the corresponding bit is set in sscountovf */
+		if (sbi_pmu_snapshot_available())
+			/* SBI implementation already updated the logical indicies */
+			hidx = lidx;
+		else
+			/* compute hardware counter index */
+			hidx = info->csr - CSR_CYCLE;
+
+		/* check if the corresponding bit is set in sscountovf or overflow mask in shmem */
 		if (!(overflow & BIT(hidx)))
 			continue;
 
@@ -778,7 +970,10 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 		 */
 		overflowed_ctrs |= BIT(lidx);
 		hw_evt = &event->hw;
+		/* Update the event states here so that we know the state while reading */
+		hw_evt->state |= PERF_HES_STOPPED;
 		riscv_pmu_event_update(event);
+		hw_evt->state |= PERF_HES_UPTODATE;
 		perf_sample_data_init(&data, 0, hw_evt->last_period);
 		if (riscv_pmu_event_set_period(event)) {
 			/*
@@ -791,6 +986,8 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 			 */
 			perf_event_overflow(event, &data, regs);
 		}
+		/* Reset the state as we are going to start the counter after the loop */
+		hw_evt->state = 0;
 	}
 
 	pmu_sbi_start_overflow_mask(pmu, overflowed_ctrs);
@@ -822,6 +1019,9 @@ static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
 		enable_percpu_irq(riscv_pmu_irq, IRQ_TYPE_NONE);
 	}
 
+	if (sbi_pmu_snapshot_available())
+		return pmu_sbi_snapshot_setup(pmu, cpu);
+
 	return 0;
 }
 
@@ -834,6 +1034,9 @@ static int pmu_sbi_dying_cpu(unsigned int cpu, struct hlist_node *node)
 	/* Disable all counters access for user mode now */
 	csr_write(CSR_SCOUNTEREN, 0x0);
 
+	if (sbi_pmu_snapshot_available())
+		return pmu_sbi_snapshot_disable();
+
 	return 0;
 }
 
@@ -942,6 +1145,12 @@ static inline void riscv_pm_pmu_unregister(struct riscv_pmu *pmu) { }
 
 static void riscv_pmu_destroy(struct riscv_pmu *pmu)
 {
+	if (sbi_v2_available) {
+		if (sbi_pmu_snapshot_available()) {
+			pmu_sbi_snapshot_disable();
+			pmu_sbi_snapshot_free(pmu);
+		}
+	}
 	riscv_pm_pmu_unregister(pmu);
 	cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
 }
@@ -1109,10 +1318,6 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 	pmu->event_unmapped = pmu_sbi_event_unmapped;
 	pmu->csr_index = pmu_sbi_csr_index;
 
-	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
-	if (ret)
-		return ret;
-
 	ret = riscv_pm_pmu_register(pmu);
 	if (ret)
 		goto out_unregister;
@@ -1121,8 +1326,34 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_unregister;
 
+	/* SBI PMU Snapsphot is only available in SBI v2.0 */
+	if (sbi_v2_available) {
+		ret = pmu_sbi_snapshot_alloc(pmu);
+		if (ret)
+			goto out_unregister;
+
+		ret = pmu_sbi_snapshot_setup(pmu, smp_processor_id());
+		if (ret) {
+			/* Snapshot is an optional feature. Continue if not available */
+			pmu_sbi_snapshot_free(pmu);
+		} else {
+			pr_info("SBI PMU snapshot detected\n");
+			/*
+			 * We enable it once here for the boot cpu. If snapshot shmem setup
+			 * fails during cpu hotplug process, it will fail to start the cpu
+			 * as we can not handle hetergenous PMUs with different snapshot
+			 * capability.
+			 */
+			static_branch_enable(&sbi_pmu_snapshot_available);
+		}
+	}
+
 	register_sysctl("kernel", sbi_pmu_sysctl_table);
 
+	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
+	if (ret)
+		goto out_unregister;
+
 	return 0;
 
 out_unregister:
diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pmu.h
index 43282e22ebe1..c3fa90970042 100644
--- a/include/linux/perf/riscv_pmu.h
+++ b/include/linux/perf/riscv_pmu.h
@@ -39,6 +39,12 @@ struct cpu_hw_events {
 	DECLARE_BITMAP(used_hw_ctrs, RISCV_MAX_COUNTERS);
 	/* currently enabled firmware counters */
 	DECLARE_BITMAP(used_fw_ctrs, RISCV_MAX_COUNTERS);
+	/* The virtual address of the shared memory where counter snapshot will be taken */
+	void *snapshot_addr;
+	/* The physical address of the shared memory where counter snapshot will be taken */
+	phys_addr_t snapshot_addr_phys;
+	/* Boolean flag to indicate setup is already done */
+	bool snapshot_set_done;
 };
 
 struct riscv_pmu {
-- 
2.34.1


