Return-Path: <linux-kselftest+bounces-7636-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3108A0496
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 02:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06EC81F247B3
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 00:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AAB10F4;
	Thu, 11 Apr 2024 00:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="IBUB3eac"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB70E3C46B
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 00:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712794133; cv=none; b=Nfhwcwy89L+qTeabM0Uj/zscjExtA7tfm6DESWv9PpUuBU1lEHQ9yjR/PkmazhpmIOIY860N1sLUoTD1wFhh3TH1hf5KMRnMDaWxCsIgLxyzm4alkOhPf1UwXIK/X3vKaGi0495X+zthnj6Ovkz9XrBcPIwocleKbXlcMxC378Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712794133; c=relaxed/simple;
	bh=iSleVGmYPORH0YJ6M9GKkX0luLVW1L/lHmqsDNV+cHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NmZRIkX2vddq1hjR8QHSGnUGByi6Z4Ue8QxrlY62N5tz5iY0b638LD1R1y0XVCfKkcTMVU8GD/7cr++JGxrNbupyY57zDj6JmOQ254zU/mEG4chdQvCwrkjoHZjYe3h6Sb5c6efTQQkmsROUXPpAr7iOusV7TTBPb04Ijyz9ESQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=IBUB3eac; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e4f341330fso9790945ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 17:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712794131; x=1713398931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvJukw934GuSrXeFuup9ak7dnmqxN0Lb+FQnvb7sFPo=;
        b=IBUB3eac0zfUacwAQqjGVBpCZMKM5KbhukFcpOTOjfCraPDQvCbDc8q5jSkY3/OGlK
         cl4yDrgUMKCGORWa/BeNu96KCb+p+u6LAon8Qzz+27SstjUDw+sfMv0enbmxj7VyJCDP
         XsWdTTG6wlk/4pLZOhNgfhLQuwMyBJOP7X+PtFS0czhcXrQ9Ouy7JIroedqctKihcRgY
         TG0AKxgNcPBIdQCSui3Hl9RRDOqbVRftWAf1xmW6nx59W38/2GayuUMPUhNMd7YZ/iDO
         tPi0Nq4bGyCfcIgZJyR7K8TECQRYDzTsB8SxcoE7nmol1CerrPJdRQfRfEgMdgDg3H4V
         niEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712794131; x=1713398931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvJukw934GuSrXeFuup9ak7dnmqxN0Lb+FQnvb7sFPo=;
        b=QxjuL40I2SPDbcmtiRpAG8r/7iqYwSBXox8pVn4J1ZBdtQxFUbtv/WA4Ae5ioEJxd3
         4EX5jeDwsGwojmmHNWMb2rCC4O8XcXRafJNt7D8XdRmon5Zga0HrIcvFnKT4Q/Z1zdO9
         pA2+wLdngakadtpTM5wacn/outyRsA62aqdnTRfW55KUrQnEIwbZddT1u03+6f+3vqMB
         w3aEdYs6MfCwQDu0p9cYFDZw2LpPTLXjJmnnlSGicAJDjG5X8rc46JsUMGevFBPh16Mx
         axlKrJTW/816Ca0a16KqO+ijrJVze63WQJuTSctPBLNDNn8OGWIB/Fef7jY+qmt6Bf/e
         8RPw==
X-Forwarded-Encrypted: i=1; AJvYcCX3fgG2WlMfmb25MiYjRuPAPGcug4it0Hzm2LPfN9efVMjEHgfPB2nLIZqYFmzvsHPpJ4x25Sw2QBFm9D6UWfGLBWWFIvHhAbPEX590Qn8U
X-Gm-Message-State: AOJu0YwZ81+ZhGntXQPJ6CkTNtf2aFr0VRB1Z6pDIvW6wPAzsyiG8LCI
	rAIq3CKgGoA8ZomuBev8TV82I3X8z1xAKSxgp3IUk6ojURHgkol3Nc5YF7C0Cq8=
X-Google-Smtp-Source: AGHT+IGQl1xQbgxg+nNMIsyytsihji4E3ebv+uAWttmmQwL/4Oe9eSB0Um2dnBeEnpUODnyh1XkRQw==
X-Received: by 2002:a17:902:db09:b0:1e3:dd66:58e1 with SMTP id m9-20020a170902db0900b001e3dd6658e1mr5752619plx.44.1712794131255;
        Wed, 10 Apr 2024 17:08:51 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b001e3d8a70780sm130351pln.171.2024.04.10.17.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 17:08:50 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
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
Subject: [PATCH v6 16/24] RISC-V: KVM: Improve firmware counter read function
Date: Wed, 10 Apr 2024 17:07:44 -0700
Message-Id: <20240411000752.955910-17-atishp@rivosinc.com>
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


