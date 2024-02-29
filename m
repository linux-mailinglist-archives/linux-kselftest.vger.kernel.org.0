Return-Path: <linux-kselftest+bounces-5581-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0EE86BDE1
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 02:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51CBD285EE2
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 01:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440B039AF2;
	Thu, 29 Feb 2024 01:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="TXZg5mP1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06FB446BD
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Feb 2024 01:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709168510; cv=none; b=AcdFLo+zERTRAXs5jTrn6vH2iprzNj+6K6bbBAOSZZvq2ixBEHTVUPxODSS08chF+Wg/gmAS7S8z6G1M69E5XP0oXl1L2kkNaz0sXIrjGrUxEmZCRmV9taXK6a/V4UdYhH6b2MaP1eJ//d1+hqjvmb13ApHbfY2RVbMtbAJbB/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709168510; c=relaxed/simple;
	bh=ULMcUPZgsZy5s7AHs7JS+lYRRb/s3cg5atfyscwS9oY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l3EsEM6NJ+ELeAmUDepc94uX6DSsFtmSkKtruTkDB7HeF7dtCz60QMDh3of4n5cnlWzhw5oVgOKSkSAQYfu3Xd9f07i+ZhAYwn1WkS7GwcMqBfCGuYrDhNC8D09JY/TnCFN3indH0s6kGPnQc63iBMpGvo7l77pJlvwy1xtahhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=TXZg5mP1; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dc09556599so3809405ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 17:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709168507; x=1709773307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/Smp2oLhuu6GIJFXbIgbmjKI2p4Ava6d/2TN1s81h4=;
        b=TXZg5mP1FfuLO7QKPhZqp+oSPbiF/LglTSMIASd5Brt3EVGf2DhuG4XPx9mGPhfANy
         jJoCmxF6lzwmDtnsMd1hZhuRjaFLixCGCbE2+tytWbLBFi5SRw/DlKoWZOcqZ7ypDVmY
         at09iGenFM4nRhKY1Ey/KioH9Tb0ytPG6WuVnk2dulOZe+LhSktQD2tyq8f4H6EFpArh
         YS9HlVH+eGVOSdFXi7YqemkUEcxLyfiXLVsOgOFfxQGAbjX1SUJUe0lP73VON5iUnFpk
         QMIPLjOXOJotodqFJ6RIcFfG788+5EndhVEXo+dDrWjCuWtrBkjysDu00rBWuN88jsTd
         Ayuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709168507; x=1709773307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/Smp2oLhuu6GIJFXbIgbmjKI2p4Ava6d/2TN1s81h4=;
        b=bK7SU0QG0qNZjBrlu4cU0MvfCo5S5LsMvLPGaqwmP8c6zWBoAG3ljlPLYaXKxXvh2b
         QVGKYe/xYU0l19FZG3Wr8/x2BazoTe+7ohwCH3bqMGeqCQmyiYQ0o5Uw9Zu8LEFTYbON
         EQ/dxiaeOA+ppa1/MOqrCvwUkyh6cZ45ULZARYJFqKFtO9Zp+ybFXG6/DZBLaR8/K4AF
         KN1p+1Gel1um7PtzfWLBGXSuX/ftPeTBAFErsf8OThSBQm7IGIZMNXSCUFI9ZAOMO43Y
         HiyvxRXfKTM8DWkgfK6SH53c4BIi94h9IiPfwbRkCRymJg4abdQJjAzE5TtxZ8p51yQ0
         G0tg==
X-Forwarded-Encrypted: i=1; AJvYcCW2xa7RX31cn9+doc2HSQJSUZaCnlPo3LCMLoyTmyOVFfMRAVOw4dlTvVKDqTlrXj5S/0HiQS87GPlJUFA3GcSd/JdbLxTLQZc1zQk31LKa
X-Gm-Message-State: AOJu0Yz3lF5QgM4PNpz4qPxQOpRLAI2pMVunCWF4r0+PIpjKIyIEmJNy
	qeTKqL3uVrEbJ5oifPWcq7kr3j/hQ5t39oWDsNomt+6ZPO35N0XCGZohrkcExzA=
X-Google-Smtp-Source: AGHT+IEZMqLInCQx07S+Rn3WGEj/67sJxXqMLsPFvU4OeQFWJPIk5NjjGR/a40uVdCrM5KTE7F+2QQ==
X-Received: by 2002:a17:902:ecc9:b0:1dc:a60f:4bef with SMTP id a9-20020a170902ecc900b001dca60f4befmr636692plh.63.1709168506981;
        Wed, 28 Feb 2024 17:01:46 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id j14-20020a170902da8e00b001dc8d6a9d40sm78043plx.144.2024.02.28.17.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 17:01:46 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Anup Patel <anup@brainfault.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Patra <atishp@atishpatra.org>,
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
Subject: [PATCH v4 03/15] drivers/perf: riscv: Read upper bits of a firmware counter
Date: Wed, 28 Feb 2024 17:01:18 -0800
Message-Id: <20240229010130.1380926-4-atishp@rivosinc.com>
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

SBI v2.0 introduced a explicit function to read the upper 32 bits
for any firmwar counter width that is longer than 32bits.
This is only applicable for RV32 where firmware counter can be
64 bit.

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/perf/riscv_pmu_sbi.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 16acd4dcdb96..ea0fdb589f0d 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -35,6 +35,8 @@
 PMU_FORMAT_ATTR(event, "config:0-47");
 PMU_FORMAT_ATTR(firmware, "config:63");
 
+static bool sbi_v2_available;
+
 static struct attribute *riscv_arch_formats_attr[] = {
 	&format_attr_event.attr,
 	&format_attr_firmware.attr,
@@ -488,16 +490,23 @@ static u64 pmu_sbi_ctr_read(struct perf_event *event)
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
+		}
 	} else {
-		info = pmu_ctr_list[idx];
 		val = riscv_pmu_ctr_read_csr(info.csr);
 		if (IS_ENABLED(CONFIG_32BIT))
 			val = ((u64)riscv_pmu_ctr_read_csr(info.csr + 0x80)) << 31 | val;
@@ -1108,6 +1117,9 @@ static int __init pmu_sbi_devinit(void)
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


