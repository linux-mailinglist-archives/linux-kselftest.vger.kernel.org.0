Return-Path: <linux-kselftest+bounces-8487-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FD38AB798
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 01:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77B18B2160B
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 23:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CEC1422AA;
	Fri, 19 Apr 2024 23:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="QKHayzdb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C93140395
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 23:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713570472; cv=none; b=sGtd4xjrNr5k5aXp2kGQZeIKeKgCVnr38S7CowZe9uyXfKSqE8Z3T0x0AvPcMu2GDNF8maxGFMrux1Q2E52/VNbl4d7UUOcuXioubamzKAZbQxxjfBXx2wXA/EohBKvxshoHG4gkP+zBPWkfwWHuUxe7JhI5iGtjpO1h7NRiPxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713570472; c=relaxed/simple;
	bh=PCH+9nz39V3BSztS1z+ZZiAV+qP9h7YwF5oYKnRz76Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lf8D94a1gIyXJnVau5hHJKKwkdXX9zy7Q+KEASOj9cvaUdTx9YSiLa2kGg5uuPv/1H8S/Uh/z3/TJAoVER1MHiCaok3icoOROP/R7OahD6nl9my+WAPbsmvH4v09TGhEiOS9r0aWSQ5F00eU0s+Odwkpux4qvDUb5BjsZXYewhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=QKHayzdb; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e3ca546d40so22550275ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 16:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713570470; x=1714175270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUdjqPblbE6Q25Ekp/l365V3YEPrpPkLHh57fhpvEHQ=;
        b=QKHayzdb8u/fjXl8b9ryUcZ5e++n2TKLJIilA0DZ5XXh456Cjl707if5jq148PmDdG
         d1cRTRvFCj1ZKk1klwIven3gL0+lkYnPQnAFtulFqUy4KPwkDYxkySQAt84NfZLsk+Kr
         zfdheQl1vPn8/hWD60Wq5r2XxoCcSQLp5BTV16i2aB1zNTiO15wl+INkcCNSVlIhuIZm
         D4lC0PRQHM9OOMDBWg7g7hq5bStTbVuybOkgQV1nzGqlOhOYVmmiueUrg2sQzfk/qPqS
         CY0fFwx2cPDkz4cJ6oKQk8V17srAKptZW0qdhAxxFsWHmjvnq6TokxbeXmdKR6L/o6jX
         0WRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713570470; x=1714175270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUdjqPblbE6Q25Ekp/l365V3YEPrpPkLHh57fhpvEHQ=;
        b=K8/1JJbITy7jJaXPrAygyzsJ5R2apUZYtubmP2UYa6norY9g/Y/bHpKWSJE8fsPMpQ
         CccoHjceK7N5CXo0wgFuUoze9/SuF2T1EQdGykp5XSkeK6ndtKRyfU7z9s/GtR9Dss8e
         vZDgnhH9EvVR9sMNFYSLhn1IlqT4uvmH/jE6G6FYWxknM3rEwbljFmyhum6CFc8lCPbD
         6QnEv+NnqFv0NqZe0eEtK8VQAbxbKRTrdZYfBTkkbAJXHTzJjRFELjCJ/tMQWUcrNP1c
         UacaZHnseSc7fFcVdpcTeb9AFOK6iK1zSEDmhrj9V78wv9X0jdpCbbrOZPdcIp33xbY/
         y0vA==
X-Forwarded-Encrypted: i=1; AJvYcCXMfXA3sH/MOwyP7J5tvQgM06461BG8tRRL7JbagKP3f9e8uyOwqZPv9B10D0rG8pjyFAzzIfI+mysLhsGCSE9tlWuBnU9Lq7K0OpirG6YV
X-Gm-Message-State: AOJu0YweWSm3+yeu5YAUE7oDY8TMKB+6bqT8qSeXpsnCRWkrwzdHnbk+
	17nRLdJ1WrCR3ubhYMi5pORqUDiUwX7V2zJCbLZuV/7dQ09pO17qAO324Bn+0OA=
X-Google-Smtp-Source: AGHT+IHHwHHNr57vk6UY+3yPVXMTfYgGKJY/BylkfQbNFTOXtEPd/o7PF2mQkqkaeyzxGO6UPPizVg==
X-Received: by 2002:a17:902:ce85:b0:1e2:3e7f:3b08 with SMTP id f5-20020a170902ce8500b001e23e7f3b08mr4580616plg.38.1713570470144;
        Fri, 19 Apr 2024 16:47:50 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902d11100b001e42f215f33sm3924017plw.85.2024.04.19.16.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 16:47:49 -0700 (PDT)
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
Subject: [PATCH v8 03/24] drivers/perf: riscv: Read upper bits of a firmware counter
Date: Sat, 20 Apr 2024 08:17:19 -0700
Message-Id: <20240420151741.962500-4-atishp@rivosinc.com>
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


