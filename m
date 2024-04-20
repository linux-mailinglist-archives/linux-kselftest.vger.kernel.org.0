Return-Path: <linux-kselftest+bounces-8492-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5128AB7AE
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 01:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375161F21BC0
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 23:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52526144D0F;
	Fri, 19 Apr 2024 23:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="CGz90VpD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89BC143C7D
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 23:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713570482; cv=none; b=rJmiMCJvySjdz0RVxUJEr9N4l+k9VfFu4rWnCHu+trIR2usr1gXY2lXATsJohKSGCy+xwJW5YyaeXsEpRiF3rr4cP/uhGCtLvU1YzWgLYtTqbtxU8q2xbyBxAEkUEQIZCpUHT+Duh0uGbqz8oNAwRj2uUwPG5o8kIe5KvOKlls4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713570482; c=relaxed/simple;
	bh=MfjfJpm3VBkwjMm72HsMOvO9UI9tfbob2HC7hMKYzy4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B6PFh22zuiFuykY0jVrZWwH3PU4U31i3/ZRHlkNiTGWtS0vtvcwxmPIIlBGnLdIka3VaptVEgBtPgwXwhKnwCi5S5BfVKOMtpREijx8TNhU+sRZktSQPpcLSYjG9Ot41UbxCtUGIg4idoqqRZ2j712vyv+LSZWmMCmTtb7SxiVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=CGz90VpD; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e3f17c6491so23430215ad.2
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 16:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713570479; x=1714175279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkOPph+llp8Otwcwt9B3eiemeK+kGnMbysCIlXdxbFk=;
        b=CGz90VpDvdqVi8eQyfqgWWuqNbnhGVSLxPjW0WSmFN9Kfpf80dwLnSigUcUN0Y2lFk
         mFW4C5zV3ZccfO7U/M+Gj1bMZscD3oL3mA1yfsrMcq7jPW3KGrLjGM4SbVFs4f5gmuPI
         GQn1Ckh2VhaAuLowB3wg+g3WMU1W8JdlQL5Dp/c/tjd9ggV1JwsiltNKXh4RKe3oA8if
         JYjWrzSdhuahMKkjWsqWHqHI+8/jnqgvJp60eU5aK3eFRsB3kWan9ePnJHDI8aFKFhDq
         GD/cqBVe8xv/h+2Aogjz3cMhJCrJHrHZyqqSSxZn8JoLNVOLN/LEADmAXHlEYYLtdZV8
         CgdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713570479; x=1714175279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wkOPph+llp8Otwcwt9B3eiemeK+kGnMbysCIlXdxbFk=;
        b=VYtEgnmMjD3xQ1NSitAmVPhgfSUWQw1aftknY8q9TdC2/HNCENE0hOsYKLXohDUniR
         VAUyZeG6GPDwC/FTbJkUlev/9pr4Zf0/K+ICgSO8os+fTMpeUb9QOCPZXKJs2Rfc2145
         GYcEhAWCQPvWjSKrf0UM/w7AkfUawFR7gff/WF/HEUkyRnhFQ5fBM6HwDmpR6b9S1hxk
         1fnY9ah9ggc51xEMG1V2x5yxlsLbRwTaJhYREqrvpRmzxl8ODJy8jdNmJ6BwXMSdgJeq
         8NxxThKhrmVIW1nozt2w/jqzlouOduWMK6V5TpNwNDD3M8PdC9c42zF8avMLaMzJ8JUf
         LnCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTuWo3sV507hrfgit5qjMcOTs9fHy9t6olJPyv45SD7iTSEHPriaMfYLbTPw38EFtJ7x095/IbPwX4vA+jpTvfQawY4SJZlWrVq0AKMaqH
X-Gm-Message-State: AOJu0YwckdDhfG+3M1dMHyLCzlIlK5R9mcKEf0G2KvGKPeyIUjhB3e/j
	zl7CWECONkNn2UpYsynObXbhR058HpVr8YCEeiq5uIgLoGZPehdFnjCcup0Tgqs=
X-Google-Smtp-Source: AGHT+IH1qz0aQ7clqAJJ4fHpFjaj37g2CZsxbNmpL8sCd2e71ca+suKQb30C+gPwakigrEbB4x5ueg==
X-Received: by 2002:a17:902:784f:b0:1e4:a120:14f3 with SMTP id e15-20020a170902784f00b001e4a12014f3mr3799131pln.51.1713570479336;
        Fri, 19 Apr 2024 16:47:59 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902d11100b001e42f215f33sm3924017plw.85.2024.04.19.16.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 16:47:58 -0700 (PDT)
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
Subject: [PATCH v8 08/24] drivers/perf: riscv: Fix counter mask iteration for RV32
Date: Sat, 20 Apr 2024 08:17:24 -0700
Message-Id: <20240420151741.962500-9-atishp@rivosinc.com>
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

For RV32, used_hw_ctrs can have more than 1 word if the firmware chooses
to interleave firmware/hardware counters indicies. Even though it's a
unlikely scenario, handle that case by iterating over all the words
instead of just using the first word.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/perf/riscv_pmu_sbi.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index f23501898657..4eacd89141a9 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -652,10 +652,12 @@ static inline void pmu_sbi_stop_all(struct riscv_pmu *pmu)
 static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
 {
 	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
+	int i;
 
-	/* No need to check the error here as we can't do anything about the error */
-	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, 0,
-		  cpu_hw_evt->used_hw_ctrs[0], 0, 0, 0, 0);
+	for (i = 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++)
+		/* No need to check the error here as we can't do anything about the error */
+		sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, i * BITS_PER_LONG,
+			  cpu_hw_evt->used_hw_ctrs[i], 0, 0, 0, 0);
 }
 
 /*
@@ -667,7 +669,7 @@ static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
 static inline void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
 					       unsigned long ctr_ovf_mask)
 {
-	int idx = 0;
+	int idx = 0, i;
 	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
 	struct perf_event *event;
 	unsigned long flag = SBI_PMU_START_FLAG_SET_INIT_VALUE;
@@ -676,11 +678,12 @@ static inline void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
 	struct hw_perf_event *hwc;
 	u64 init_val = 0;
 
-	ctr_start_mask = cpu_hw_evt->used_hw_ctrs[0] & ~ctr_ovf_mask;
-
-	/* Start all the counters that did not overflow in a single shot */
-	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, 0, ctr_start_mask,
-		  0, 0, 0, 0);
+	for (i = 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++) {
+		ctr_start_mask = cpu_hw_evt->used_hw_ctrs[i] & ~ctr_ovf_mask;
+		/* Start all the counters that did not overflow in a single shot */
+		sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, i * BITS_PER_LONG, ctr_start_mask,
+			0, 0, 0, 0);
+	}
 
 	/* Reinitialize and start all the counter that overflowed */
 	while (ctr_ovf_mask) {
-- 
2.34.1


