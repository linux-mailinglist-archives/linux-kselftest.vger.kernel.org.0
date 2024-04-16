Return-Path: <linux-kselftest+bounces-8205-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6A48A73AA
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 20:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3160B244AC
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 18:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D30013CFB1;
	Tue, 16 Apr 2024 18:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="h+XacNlf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B539213C9B0
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 18:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293106; cv=none; b=FDlXMHSInXPIkJYuVz6iX8Ca5pOMFS/9e+ay62YrIyMbTzJdvBVlr/0rZcVyDq9qbnFXovLoc9CGoXpzeMC+EmzYjwl1O5kAgZP6SR1+MKMJ/JrwtaYIwZBe/HWhPmwGOrUl9fQbq5oyf9YGXAfaLls1cEqjyaVXY6TcDtYIjfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293106; c=relaxed/simple;
	bh=iSleVGmYPORH0YJ6M9GKkX0luLVW1L/lHmqsDNV+cHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ogv3IdsJVPYuxIWvfIObe8NIuPZJfTs7j+oiSbnMj2k2Rql0CrnK8tcyXi1zL/WsCF3pbjiELnAR+Sbu19zvFSSGaELr3+S2mJO5u1gcXKS1R+OHAwAopadjBechXjxNxhXLwbOjB837kWJbbhkul6e3v78rFXdbMyjJSovvK3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=h+XacNlf; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-53fa455cd94so3783156a12.2
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 11:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713293104; x=1713897904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvJukw934GuSrXeFuup9ak7dnmqxN0Lb+FQnvb7sFPo=;
        b=h+XacNlfbK5JGXFKKTe77kKNvOlW2y/Vpbuwxe78qoMbYEiZrwxCcqFe1Oykjpnz3p
         KwNhWTzg6FgSok/WC3RR+gRF0FI+wsIMqPC4YhcJPoBXnWLetg+p0q7ls43caxj42JT+
         zGmIhalf1fXVkfmarpH6KiLR/BegJXEj7k0LSSPiS6eydRUOT4UXI2hzROiFuuwWHHq+
         mvaXyQHfUC4QlK69cxnk66guZdWhPf7KToKuY18rm1oz8cSXggkkb8s7RB8qWsGH71H5
         JC9FzUCK42tBv/1SE1aHpnABh1SLC26Cl1tYf2LxMOX4s+S/0AmViiais+lj6In7aNCT
         mctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713293104; x=1713897904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvJukw934GuSrXeFuup9ak7dnmqxN0Lb+FQnvb7sFPo=;
        b=qGTI2TiRbNmji/Cy060htyC586pG9+1Yany8nxVbZcowSOWrRCriEWtBppe1Vsri6W
         xyOdBcRTTCnb7247e1FEB8KbE2d+Jkv19WayL9JWbFSzJ7/0ymotNYIFgMRMHUZMu3ec
         KJDsWSfSq0jmLhU1pEDZsvRGqi57E/VfEr7B3uzfktO/aTsOjFu7MUg/syYXS91XoMMa
         Aa6aME2XWafCJ4tuK2sWF26jsIzX9CeyH2bnRPgPJgVSJQWHf1ki+S/7OAbHm1x3g+Vw
         tpzhImvWqkLnVLISK0ntmaGoV/9GlmZtotWeNTCQDSJMYL7yaPBCJD9nEDwrY55v1pet
         m9IQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp7+V+m4QfCjb5aQlq6x24m/mf+4qzJen4IrQKMiqUrKCuUgWTFMDYiK8GSu248NsMy2U7Gq7Pno77p18GruFduCoGRXPQBm4bemxSnvNZ
X-Gm-Message-State: AOJu0Yz8vPLyrY9B01zno+6Qynz/H94MvkERBjQmmxgcbjBX8qNnWJcn
	bPlJehG/H3Fji4JLCnJ54pyr6yZMiD/12o4mWCSFpiiT/dZZ0Oaw7viVIPIKMCE=
X-Google-Smtp-Source: AGHT+IEzkuVs13Wd8oWq41fr6Cm4Cf2ZRXqAps1equR8HRaWNn24PI2u5SFf2jAeIUGzEw8b8iUdrw==
X-Received: by 2002:a05:6a21:2d8e:b0:1a9:dd82:a42a with SMTP id ty14-20020a056a212d8e00b001a9dd82a42amr9766403pzb.31.1713293104126;
        Tue, 16 Apr 2024 11:45:04 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090aac1300b002a269828bb8sm8883645pjq.40.2024.04.16.11.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 11:45:03 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
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
	Will Deacon <will@kernel.org>,
	x86@kernel.org
Subject: [PATCH v7 16/24] RISC-V: KVM: Improve firmware counter read function
Date: Tue, 16 Apr 2024 11:44:13 -0700
Message-Id: <20240416184421.3693802-17-atishp@rivosinc.com>
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

Rename the function to indicate that it is meant for firmware
counter read. While at it, add a range sanity check for it as
well.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/kvm_vcpu_pmu.h | 2 +-
 arch/riscv/kvm/vcpu_pmu.c             | 7 ++++++-
 arch/riscv/kvm/vcpu_sbi_pmu.c         | 2 +-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_vcpu_pmu.h b/arch/riscv/include/asm/kvm_vcpu_pmu.h
index 55861b5d3382..fa0f535bbbf0 100644
--- a/arch/riscv/include/asm/kvm_vcpu_pmu.h
+++ b/arch/riscv/include/asm/kvm_vcpu_pmu.h
@@ -89,7 +89,7 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned long ctr_ba
 				     unsigned long ctr_mask, unsigned long flags,
 				     unsigned long eidx, u64 evtdata,
 				     struct kvm_vcpu_sbi_return *retdata);
-int kvm_riscv_vcpu_pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
+int kvm_riscv_vcpu_pmu_fw_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
 				struct kvm_vcpu_sbi_return *retdata);
 int kvm_riscv_vcpu_pmu_fw_ctr_read_hi(struct kvm_vcpu *vcpu, unsigned long cidx,
 				      struct kvm_vcpu_sbi_return *retdata);
diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index e1409ec9afc0..04db1f993c47 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -235,6 +235,11 @@ static int pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
 	u64 enabled, running;
 	int fevent_code;
 
+	if (cidx >= kvm_pmu_num_counters(kvpmu) || cidx == 1) {
+		pr_warn("Invalid counter id [%ld] during read\n", cidx);
+		return -EINVAL;
+	}
+
 	pmc = &kvpmu->pmc[cidx];
 
 	if (pmc->cinfo.type == SBI_PMU_CTR_TYPE_FW) {
@@ -747,7 +752,7 @@ int kvm_riscv_vcpu_pmu_fw_ctr_read_hi(struct kvm_vcpu *vcpu, unsigned long cidx,
 	return 0;
 }
 
-int kvm_riscv_vcpu_pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
+int kvm_riscv_vcpu_pmu_fw_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
 				struct kvm_vcpu_sbi_return *retdata)
 {
 	int ret;
diff --git a/arch/riscv/kvm/vcpu_sbi_pmu.c b/arch/riscv/kvm/vcpu_sbi_pmu.c
index cf111de51bdb..e4be34e03e83 100644
--- a/arch/riscv/kvm/vcpu_sbi_pmu.c
+++ b/arch/riscv/kvm/vcpu_sbi_pmu.c
@@ -62,7 +62,7 @@ static int kvm_sbi_ext_pmu_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		ret = kvm_riscv_vcpu_pmu_ctr_stop(vcpu, cp->a0, cp->a1, cp->a2, retdata);
 		break;
 	case SBI_EXT_PMU_COUNTER_FW_READ:
-		ret = kvm_riscv_vcpu_pmu_ctr_read(vcpu, cp->a0, retdata);
+		ret = kvm_riscv_vcpu_pmu_fw_ctr_read(vcpu, cp->a0, retdata);
 		break;
 	case SBI_EXT_PMU_COUNTER_FW_READ_HI:
 		if (IS_ENABLED(CONFIG_32BIT))
-- 
2.34.1


