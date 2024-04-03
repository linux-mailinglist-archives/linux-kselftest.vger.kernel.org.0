Return-Path: <linux-kselftest+bounces-7051-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6BD89678B
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 10:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B55AEB24935
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 08:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C67F6FE2A;
	Wed,  3 Apr 2024 08:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="uK75Skh/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D3D6F06A
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Apr 2024 08:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131520; cv=none; b=AoraK5LpEUr8nqzHqnGr0l6T/OxC4KQSPxrxLuTBLemfmezBoftM1qrqD3uFb+crOKn+mPIB3xAkOFfDyRWPqhs7fpqqDV40AWVYI/DK49xGa3mxngvzJiUIB1OZwvyssCknjf4qcw6yof4aHnikytQQhXPOvBNuPQjwBLsK+fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131520; c=relaxed/simple;
	bh=5SixT0kcz+8IGtYwvZGhA9Q1KZ5SaAWo/BakwlxdqZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=novrVhfWVuhhwMWssdAOfQgUxzXZcixgEtDrxIB9YnxJ74BZm2ugK5qIGa0vCKoDtF2VZsXME9bjRiJE71BAzW5EWr/cskX6gFxBs6u2TOv+ZK6fIkgdivgFV+5C0waz5VP168sx8LQ4neno3aNQtOaEK4jGWcxjYJmBhdGkK5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=uK75Skh/; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e0bec01232so48717395ad.3
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Apr 2024 01:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712131518; x=1712736318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ukUdwvkRaeQmBPwRJpu6uMxNPU93zNWp+RJiBVsFw4=;
        b=uK75Skh/kr8v4RnArctSD7ENSLfakR6lkmYZzFmP10Hlu2kXP5spk6IQXSbS309AaS
         9nbmQ4aRhTKH0iRWuaqGf6zCfxadSs2xbbF1T8ORRzclYNTfaQOwuOGETxdNIWfmEm8U
         p+CqL2TIKw4I3+/L6Q5T3lQl4JiL3qaYPBcj/PlhwrhVE8iEJOY/iM27X3hlAS+ZN2tv
         Gpml8cz1wynHkSUN1G2U14IRmkD/g3YTv5c2wNNneC94/mcK5Lmt1jBQ9OHoeFn+zgRu
         oGQennlWMs0RxBAo6lHuE8p69IWXe5O9cqfHqvgriT9PzQqbyvumCyJWNX9P8TMdmxzP
         8SBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131518; x=1712736318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ukUdwvkRaeQmBPwRJpu6uMxNPU93zNWp+RJiBVsFw4=;
        b=OMHoMBsJdiwjn28UIEqx2ssIjPe8QTfAlV6kaqhtO9eNBLJoE66sIBQk9xrH+WhGuI
         O3NIs8EV8qXswkr9l5tGspoIR02p65p4q3jQe7wYGq2+KtinVNRHl0rqm9maRhtWnHut
         R1bSgpq/QxP44DJNTWm21wT37vR3+DZfFJmjOSg6cN43x9LU53meo7dl9holA8uSeCj2
         chYr45OoUGLvsk02RTW4q+RvXwqbG8v8IQadEqOWNTGof596thqKVL79oPoo7L32Wu3L
         VRrL0r6Vbq72mNENvgE4qFw6SpZ8KGB4woo2+Aqwo/OUMUa71X6jJdB5rOspxQOb2lys
         pyCw==
X-Forwarded-Encrypted: i=1; AJvYcCU+B5D+YlZDYBfBMD+V2o8ggVnjO0UK7OyvWn+8+ovPmGzfReVZA2SPIA37SHUhOMV/06fET38pibLRCQF9pyrajzRuQKmsLymtJmQ1f3bI
X-Gm-Message-State: AOJu0YyV5UXFPLl+uCbKW4mZnpdHA0FGooNY7oWZFkE4VpPFZSt1Cs0g
	2ArX30gXEP6Jrg0zqIcFrnPFk8+8rst1OkOgZaeQeShQwMd2eRYadWfBfv5Qqws=
X-Google-Smtp-Source: AGHT+IGzCaqR/FZVf4jG8/W5aRGI+FZChKgtdmsu22b2KjgU9hzL33Vhb0robWHwzAUPtLmResHVWQ==
X-Received: by 2002:a17:902:e741:b0:1dc:a605:5435 with SMTP id p1-20020a170902e74100b001dca6055435mr16071106plf.31.1712131518213;
        Wed, 03 Apr 2024 01:05:18 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902d48c00b001e0b5d49fc7sm12557229plg.161.2024.04.03.01.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:05:17 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Anup Patel <anup@brainfault.org>,
	Ajay Kaher <akaher@vmware.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <amakhalov@vmware.com>,
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
Subject: [PATCH v5 03/22] drivers/perf: riscv: Read upper bits of a firmware counter
Date: Wed,  3 Apr 2024 01:04:32 -0700
Message-Id: <20240403080452.1007601-4-atishp@rivosinc.com>
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
index 3e44d2fb8bf8..babf1b9a4dbe 100644
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
+				WARN_ONCE(1, "Unable to read upper 32 bits of firmware counter error: %d\n",
+					  sbi_err_map_linux_errno(ret.error));
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


