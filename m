Return-Path: <linux-kselftest+bounces-5585-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8266C86BDEC
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 02:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4B47B27374
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 01:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27601482CD;
	Thu, 29 Feb 2024 01:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="escQEYB1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EA54B5DA
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Feb 2024 01:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709168516; cv=none; b=cuRzTarKJwr89kkLBvhAgzJz9zzeRoBlV8db0lKgPzot2E/hbTTlU348lJCBmaaN5U4WLfkgAD1pkAysjJvU5BXeIPblptjh45fnQkpxFEr4reQh2qK4g4ydG1xnWvVJWOhdQl39aFN9MGMhfZWCGqmGDJ4gewH91axT8wRzoJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709168516; c=relaxed/simple;
	bh=1V+hd27rw6/WCAn1DleSGvGCcsHuYA/SEtOYZLS88jw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=af6jaIqIAFvgB964CssfSWd5FvzhC/BmD56k3xJHnrV2FezAWl1+E625FHq1tyZ+f5KS84WPX3126INyClG55SojX0uk5Y8cTg70xavnGsLn498F6gHjBUxvRr0WoaC1LI3g0O2dA7qXfYsgbyiWIlGXbNqEDzgX13eljoFcnQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=escQEYB1; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dc418fa351so11420925ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 17:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709168514; x=1709773314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8UQElc6A/TnygdjzPZGFQnFIW5Dl3R45uxNNmzEmHk=;
        b=escQEYB1Bt2ZRhOrHnHHGHTMTtiK2PT9goLugDyI1ImLJ6839ez8vfF79zcBaDAuuy
         My+9HvtTnsWQk0gpxxXSFDtSc5bOBjKvsBRJRnJd4VX8btBvfrc+wb1i5tzWvYaOZd/H
         0j6xCFXVBt0K8iwclxQxrcqben9wzVEJ4+M59sqXTgW8OAclqB5YHrOXPL1t37Qd0WOr
         FQvm0inngPh/iJ3bpkHGUF/KN4NeQjq0TTY/d1RSGR3jdfkWdIoF/kwvKXmOotIYbrhb
         pimor46BVZ3KcfM4Fe/nXHOsop7MFpyQkELX3y+ySVPKmcLEi3SuYxgQnV64R7iYqPg/
         pE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709168514; x=1709773314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8UQElc6A/TnygdjzPZGFQnFIW5Dl3R45uxNNmzEmHk=;
        b=aDEOcL2j2LsZmQe+V/J+Cwq2yHUp2/shXGVsv7nXVY88bXlVoO/yeRobgaEaWpyGSl
         5VIu73Ki/vsrnScE4V31iKgVSvtTcVTwQB0YeIAZo0ZoBzPrHzAdD2crFQW/yqbOjP8O
         q0FgK8R/2uijKJL9KJydIY13K/LBltjuY6x1GHhchWp+mjWlzj/9T4yT6LM1cgd843BK
         Oeac4RGm82ExZuricbFi8o12tlvO3yvTMY6+jqAqQd7/dSZjZbPQ3a29ca4v/5uEWkBa
         tpNKlyMgoA4EuFs6xZJ+MPoKJrbTc7XfkoCc10iX1ORFxG3xnr1msYGnyvL3vscDA3LN
         HnKQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8WOcSqyiNFnuQhMgoYKx/0RFPbeGFrMJWTabzBq3NbC9hq3peYr5KPealzQ9AAy36BDsvXucr4TK1yGNE3J007t6iV5k4UMcI7gy3mbpn
X-Gm-Message-State: AOJu0YywzTKbZHwY8Wf2WRYpBdLQW165dXCZczkQlNN3Q9jUOf5YYOfk
	71Jng/uZ/5SG+nwgdghtVptd+HAsPfgeMFH3S8s6fpf+RdTp0nKRZ8Pv3G7tWsk=
X-Google-Smtp-Source: AGHT+IHDNjWn5dZ/wuSSoiVWheF3o9JRVG+GhFK7oDtYZumCcoNTXkWvgig/10iUgNoPi/vwvXOq9g==
X-Received: by 2002:a17:903:32cd:b0:1db:edb8:35f6 with SMTP id i13-20020a17090332cd00b001dbedb835f6mr622961plr.5.1709168513907;
        Wed, 28 Feb 2024 17:01:53 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id j14-20020a170902da8e00b001dc8d6a9d40sm78043plx.144.2024.02.28.17.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 17:01:53 -0800 (PST)
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
Subject: [PATCH v4 07/15] RISC-V: KVM: No need to exit to the user space if perf event failed
Date: Wed, 28 Feb 2024 17:01:22 -0800
Message-Id: <20240229010130.1380926-8-atishp@rivosinc.com>
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

Currently, we return a linux error code if creating a perf event failed
in kvm. That shouldn't be necessary as guest can continue to operate
without perf profiling or profiling with firmware counters.

Return appropriate SBI error code to indicate that PMU configuration
failed. An error message in kvm already describes the reason for failure.

Fixes: 0cb74b65d2e5 ("RISC-V: KVM: Implement perf support without sampling")
Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/vcpu_pmu.c     | 14 +++++++++-----
 arch/riscv/kvm/vcpu_sbi_pmu.c |  6 +++---
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index b1574c043f77..29bf4ca798cb 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -229,8 +229,9 @@ static int kvm_pmu_validate_counter_mask(struct kvm_pmu *kvpmu, unsigned long ct
 	return 0;
 }
 
-static int kvm_pmu_create_perf_event(struct kvm_pmc *pmc, struct perf_event_attr *attr,
-				     unsigned long flags, unsigned long eidx, unsigned long evtdata)
+static long kvm_pmu_create_perf_event(struct kvm_pmc *pmc, struct perf_event_attr *attr,
+				      unsigned long flags, unsigned long eidx,
+				      unsigned long evtdata)
 {
 	struct perf_event *event;
 
@@ -454,7 +455,8 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned long ctr_ba
 				     unsigned long eidx, u64 evtdata,
 				     struct kvm_vcpu_sbi_return *retdata)
 {
-	int ctr_idx, ret, sbiret = 0;
+	int ctr_idx, sbiret = 0;
+	long ret;
 	bool is_fevent;
 	unsigned long event_code;
 	u32 etype = kvm_pmu_get_perf_event_type(eidx);
@@ -513,8 +515,10 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned long ctr_ba
 			kvpmu->fw_event[event_code].started = true;
 	} else {
 		ret = kvm_pmu_create_perf_event(pmc, &attr, flags, eidx, evtdata);
-		if (ret)
-			return ret;
+		if (ret) {
+			sbiret = SBI_ERR_NOT_SUPPORTED;
+			goto out;
+		}
 	}
 
 	set_bit(ctr_idx, kvpmu->pmc_in_use);
diff --git a/arch/riscv/kvm/vcpu_sbi_pmu.c b/arch/riscv/kvm/vcpu_sbi_pmu.c
index 7eca72df2cbd..b70179e9e875 100644
--- a/arch/riscv/kvm/vcpu_sbi_pmu.c
+++ b/arch/riscv/kvm/vcpu_sbi_pmu.c
@@ -42,9 +42,9 @@ static int kvm_sbi_ext_pmu_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 #endif
 		/*
 		 * This can fail if perf core framework fails to create an event.
-		 * Forward the error to userspace because it's an error which
-		 * happened within the host kernel. The other option would be
-		 * to convert to an SBI error and forward to the guest.
+		 * No need to forward the error to userspace and exit the guest
+		 * operation can continue without profiling. Forward the
+		 * appropriate SBI error to the guest.
 		 */
 		ret = kvm_riscv_vcpu_pmu_ctr_cfg_match(vcpu, cp->a0, cp->a1,
 						       cp->a2, cp->a3, temp, retdata);
-- 
2.34.1


