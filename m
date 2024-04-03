Return-Path: <linux-kselftest+bounces-7054-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B54896799
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 10:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F8961F23BF9
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 08:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423EA7EEF8;
	Wed,  3 Apr 2024 08:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="2iixUOkb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55230745F0
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Apr 2024 08:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131530; cv=none; b=lAXx0YSGwykD7yI7Qm7u6irmRPDZTrbKoql5zjxznlqg4RA7+HVxIqIiMzUjWNX6jzsdtYG2MEm/W53kD2tD1fPY7O/O0aZAVPclyvhcEB8vWnNU2qOUjeUUs2TVss3AiBjWgrUz0Qm2sBjw/P1HxhK62+8bG5ARZDqhH/DeYgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131530; c=relaxed/simple;
	bh=aDfanLTs21GL0maDPQpRseQyiyuKg+u1j0b2hveDXpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r6jZB0V6XrbAxf3D+2b4aACLD+qpzTTRaJV6cNZGYSi5tGiZ1WKOLGodW1imbF28pS6rHMaHXf56y81AVPJidrfcW2JNJd8+2lod08YTNafRKsZdTSoWuzT4Edl+EjM+D60iQax1vtKvwy1HA/9m5T00KkSLYXipwrUyi47JNJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=2iixUOkb; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso3976967a12.2
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Apr 2024 01:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712131527; x=1712736327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4rw21DNPDWpaXnd5Gs3cWE2qTmUGGOZ0JnLHhYLDMiI=;
        b=2iixUOkb5ZvcS909cd2IhppvnztzEejMRSDC99adKGajjgp1jtLAQJ5lGxpJnmnkXf
         FKM3oJrgfdEAKK3vfP76gfrAjghy5khVIwIYF7SFJunpu52SD0BTSTKxP/BD27F4utB9
         jTfRLGEBLDRrvUmjpBVJUVHf16VfmhhhsQNjQXFQIJI7KB2mpwfepVwdczJGhAMKYbCM
         aagO54xA8Bj2XqknrkufVfHoo/UOcQwcra9A1ZcLz/+Xyrfu8plWr+PwAwsahUkm10Mb
         XNUcukZutv8afK4JgJf4PdCY2I3mBfyn5ZjrbXcTJR2txMIppT3GM5JtHvvP+7RA/5/H
         Ii/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131527; x=1712736327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4rw21DNPDWpaXnd5Gs3cWE2qTmUGGOZ0JnLHhYLDMiI=;
        b=gk+cCyCcpS/N68Ru6xltRuCKiPjGskp7/s1c4dWzDQwtXe/k68t6OVjs+X1g2YX/SY
         6AQrSVNfHKe9H7ZZ3zYLEOvZ5U5IyjOlSKncgrSGeKOq2poPXy1HN8t6iaEw8q14G+qU
         hXwJ2Jy0e7U1T+jGxYktbdDlehCeP6PQdwfBa3GGdMRkZM7oDPzZzN2BBMxnFiH0X4Ya
         r/8ei1RStsn79Hp+54V4zYyhDYIooz1PRlkSQo3Rn5u+8PMxw88o9zazoc8sy+ZV0PDU
         xqXiJMEMwv81WP6p2Y4tF8YU9GVDeXJbyglAD1oOBGVwAQHal203KIUq1Rmi0fPfaCf7
         YSBA==
X-Forwarded-Encrypted: i=1; AJvYcCVou5RKxiX2tAe/Dkc6VvTlhVa7KFrT+qZanwo3mgEjqfE+PmguKPlYXvmaFg5HGiA4d9bXla0Je/5xAjUd1sNCHf/xAEKz39JJYEAzT0EN
X-Gm-Message-State: AOJu0YweHhyoQX7rV37D0/8HbQoFontdA1NCopnEdrl5H+IOLxUkTEnC
	E7bNTKA5lvoPwVPxim/OyaMfL3RPsbYBpwNxuXBBeH9rAPDIaqP7HSSkVYzrnb4=
X-Google-Smtp-Source: AGHT+IHZeguUWEErPiWxvNkeVU9lmGoRHX/48aTBnxr2DMrqRPKV9Qdy9c2zpt6UamZ4tC6ZYgwGwA==
X-Received: by 2002:a05:6a20:17a7:b0:1a3:34c4:b184 with SMTP id bl39-20020a056a2017a700b001a334c4b184mr13823636pzb.19.1712131527654;
        Wed, 03 Apr 2024 01:05:27 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902d48c00b001e0b5d49fc7sm12557229plg.161.2024.04.03.01.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:05:26 -0700 (PDT)
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
Subject: [PATCH v5 07/22] drivers/perf: riscv: Fix counter mask iteration for RV32
Date: Wed,  3 Apr 2024 01:04:36 -0700
Message-Id: <20240403080452.1007601-8-atishp@rivosinc.com>
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

For RV32, used_hw_ctrs can have more than 1 word if the firmware chooses
to interleave firmware/hardware counters indicies. Even though it's a
unlikely scenario, handle that case by iterating over all the words
instead of just using the first word.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/perf/riscv_pmu_sbi.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 8c3475d55433..82336fec82b8 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -771,13 +771,15 @@ static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
 {
 	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
 	unsigned long flag = 0;
+	int i;
 
 	if (sbi_pmu_snapshot_available())
 		flag = SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT;
 
-	/* No need to check the error here as we can't do anything about the error */
-	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, 0,
-		  cpu_hw_evt->used_hw_ctrs[0], flag, 0, 0, 0);
+	for (i = 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++)
+		/* No need to check the error here as we can't do anything about the error */
+		sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, i * BITS_PER_LONG,
+			  cpu_hw_evt->used_hw_ctrs[i], flag, 0, 0, 0);
 }
 
 /*
@@ -789,7 +791,7 @@ static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
 static noinline void pmu_sbi_start_ovf_ctrs_sbi(struct cpu_hw_events *cpu_hw_evt,
 						unsigned long ctr_ovf_mask)
 {
-	int idx = 0;
+	int idx = 0, i;
 	struct perf_event *event;
 	unsigned long flag = SBI_PMU_START_FLAG_SET_INIT_VALUE;
 	unsigned long ctr_start_mask = 0;
@@ -797,11 +799,12 @@ static noinline void pmu_sbi_start_ovf_ctrs_sbi(struct cpu_hw_events *cpu_hw_evt
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


