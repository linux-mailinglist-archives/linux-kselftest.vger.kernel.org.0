Return-Path: <linux-kselftest+bounces-7623-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B15D8A0461
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 02:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C842D1F2463C
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 00:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8643A8BEE;
	Thu, 11 Apr 2024 00:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Zo6tCDoP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04295D517
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 00:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712794097; cv=none; b=sq3MGFhzP469bUKDTLGKHYzqRF3+lxbCSdcdc0fE8bpYHp39qnzOSZNi82nAzr2S20fFnbzrW5XJLSrTi2x+JFtcFKS1pFXmsJkpKzYwPRi7+wl/ecDlB9Li8NVRNp0hyfGlZ8kGe+sBmDBYqGV2Nw2WCdlYTiKWL3Ho8+iJMco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712794097; c=relaxed/simple;
	bh=PCH+9nz39V3BSztS1z+ZZiAV+qP9h7YwF5oYKnRz76Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SEDLe90a+M0MJ5IBapGXHmEjSWrw8W7sRT1qtHVME/QR8f841OipOPMs3CByKC8Zws/c+Zbdu5C1BrQpIK6AVchzIpnIpddPbG3Fc10SNYp6vyv3w94/+rTGnKK9OX6NfkyyYTvue2ENf3AeE5RHfXAlNx/JjtJ+61je8Gs1lo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Zo6tCDoP; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e3e56c9d2cso38854245ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 17:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712794095; x=1713398895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUdjqPblbE6Q25Ekp/l365V3YEPrpPkLHh57fhpvEHQ=;
        b=Zo6tCDoPQ8FgQ4krFL9MjaWkDjlOGFnTnb5e8hN6PAOUMclPRRjTWuC/lF/Cwh/SgF
         /FkLFivzHVermsT6l6UWK2n6k9TJg4be6M7t2k4EVVuOzVRnhr7M+5FYLGmWA1Qk8FtK
         YbMADxHdfcCcLDaYyylqlKyZvj3L9lElrcc5+xs2ctFpYelXCZn0B1FSSBBB9UDsyJg7
         wxOB2a+9g0McJVz/f9zsQS2YtdLNI/VIb/71OOnKiNQx+rvszaWWMNuHJ9VjDZUjt5c2
         sl/zwnFrR2VVMDZrQ6si5XeU0yDE7ruH5sSyI80lSZmySM5OvjXzV/wIb42T3NLET4Jd
         Hfxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712794095; x=1713398895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUdjqPblbE6Q25Ekp/l365V3YEPrpPkLHh57fhpvEHQ=;
        b=H9ZkzzM4zWq33D71DO4qwK2/kC7Gim0o97X/8VuAKidDC7mDkaEgyIp+Ai2FaEOaWR
         1o5cajuTOw4mB4R8gcQJNEz9jNxyl9575BKzznVjslIUKF0Gmv1w3R3WR3BJm4kVfkuj
         vFdRQAEJ1f5NKNtw5grewS6iB+k3iNvRf+ICY8bY4hiBdbHQbepBueIRGm8EAoF3SbMT
         vIRQH8rVL1eZPuQs9LJ8AOKzbQHReMHeCFpt8hLBrsog0DtDrlIzhsVi8WuU9kRObca6
         y/q7jjMIKxKqK45ctHEIxWX8qDePkRiw8h2vHskqRBGlaI+DcVJRDZM8xvLo8it9pC2h
         2m2g==
X-Forwarded-Encrypted: i=1; AJvYcCUyMq3u5VxRRcN69OjNOefBdCT4CWTVGWtvrgpY28OlVbEYZW/2MSpaQ1bgtDeud4QK8/9YbYaICWykYAEHBY9wVwIoIpbnTwlt4md0rQO1
X-Gm-Message-State: AOJu0Yzyzi6cylhv2YOjMjNIkG4QuK3z8vadMTHXgue5Ms3w2UbXBSUN
	80q/80HP0cYQN5Fgc8fgVRH+jFX8lBR9mlKGsmf6eJH5LpHO2iTGNGSf9/hmT/c=
X-Google-Smtp-Source: AGHT+IFIBD1SOaWsgt2948dyeKGyG07Tn/ktfC4uoEXfuxeDgccQR9pNsvZjwG3GwFp5aB5INBJAQw==
X-Received: by 2002:a17:902:7618:b0:1e4:fd4:48db with SMTP id k24-20020a170902761800b001e40fd448dbmr4188157pll.43.1712794095332;
        Wed, 10 Apr 2024 17:08:15 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b001e3d8a70780sm130351pln.171.2024.04.10.17.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 17:08:14 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Anup Patel <anup@brainfault.org>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Atish Patra <atishp@atishpatra.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
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
Subject: [PATCH v6 03/24] drivers/perf: riscv: Read upper bits of a firmware counter
Date: Wed, 10 Apr 2024 17:07:31 -0700
Message-Id: <20240411000752.955910-4-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411000752.955910-1-atishp@rivosinc.com>
References: <20240411000752.955910-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SBI v2.0 introduced a explicit function to read the upper 32 bits
for any firmware counter width that is longer than 32bits.
This is only applicable for RV32 where firmware counter can be
64 bit.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/perf/riscv_pmu_sbi.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 3e44d2fb8bf8..1823ffb25d35 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -57,6 +57,8 @@ asm volatile(ALTERNATIVE(						\
 PMU_FORMAT_ATTR(event, "config:0-47");
 PMU_FORMAT_ATTR(firmware, "config:63");
 
+static bool sbi_v2_available;
+
 static struct attribute *riscv_arch_formats_attr[] = {
 	&format_attr_event.attr,
 	&format_attr_firmware.attr,
@@ -511,19 +513,29 @@ static u64 pmu_sbi_ctr_read(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
 	struct sbiret ret;
-	union sbi_pmu_ctr_info info;
 	u64 val = 0;
+	union sbi_pmu_ctr_info info = pmu_ctr_list[idx];
 
 	if (pmu_sbi_is_fw_event(event)) {
 		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_FW_READ,
 				hwc->idx, 0, 0, 0, 0, 0);
-		if (!ret.error)
-			val = ret.value;
+		if (ret.error)
+			return 0;
+
+		val = ret.value;
+		if (IS_ENABLED(CONFIG_32BIT) && sbi_v2_available && info.width >= 32) {
+			ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_FW_READ_HI,
+					hwc->idx, 0, 0, 0, 0, 0);
+			if (!ret.error)
+				val |= ((u64)ret.value << 32);
+			else
+				WARN_ONCE(1, "Unable to read upper 32 bits of firmware counter error: %ld\n",
+					  ret.error);
+		}
 	} else {
-		info = pmu_ctr_list[idx];
 		val = riscv_pmu_ctr_read_csr(info.csr);
 		if (IS_ENABLED(CONFIG_32BIT))
-			val = ((u64)riscv_pmu_ctr_read_csr(info.csr + 0x80)) << 31 | val;
+			val |= ((u64)riscv_pmu_ctr_read_csr(info.csr + 0x80)) << 32;
 	}
 
 	return val;
@@ -1135,6 +1147,9 @@ static int __init pmu_sbi_devinit(void)
 		return 0;
 	}
 
+	if (sbi_spec_version >= sbi_mk_version(2, 0))
+		sbi_v2_available = true;
+
 	ret = cpuhp_setup_state_multi(CPUHP_AP_PERF_RISCV_STARTING,
 				      "perf/riscv/pmu:starting",
 				      pmu_sbi_starting_cpu, pmu_sbi_dying_cpu);
-- 
2.34.1


