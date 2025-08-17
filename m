Return-Path: <linux-kselftest+bounces-39178-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB87B2930C
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Aug 2025 14:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80699488271
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Aug 2025 12:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC9A288528;
	Sun, 17 Aug 2025 12:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="YcP4sFlZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC05824635E
	for <linux-kselftest@vger.kernel.org>; Sun, 17 Aug 2025 12:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755434053; cv=none; b=GGwOljSfr3q+QB3C/i2YhYeabx5VrQNSUTkzmmgCHrQWnaR1W5dpGxnYGRlo35UHjEYpLEAFQl93XFXb/ClJTgC5LNLa67HIA8pGqSBRWbmdPWtVQkofcQW9kH+w3mkS6DNpSU5ffR1OZc4v1Qf3iONXGmukfG98efItMGlqq7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755434053; c=relaxed/simple;
	bh=G9gBXgS5ZP2+2D3CVqP+3wrJpRXlPa7RbLzeqdLAE8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngSmR9sNENhu4HmS18prNghnNX4RfnvBmGEsRusI3fegFaEa0MXOG3vAwJ8cj59uihlVJQCk3sTTqT694vYNUiZP8oTXbpZoy8y1DZqzcsD9RXGSD3wnbD/zntmkpZ2unpgROekT6yvInF6wMi0U+gFx7GQ5mHPdG5Sq/F339P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=YcP4sFlZ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24457f43981so21031355ad.0
        for <linux-kselftest@vger.kernel.org>; Sun, 17 Aug 2025 05:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755434051; x=1756038851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSJAzpJrB/+0Vhq3Jx8mxwwAXiXUMS9lCBbypwhOCgE=;
        b=YcP4sFlZi9GSGqOrCwGxnXaDXwGbexmon0fKayMD3g5lLhGpDYkc3P4k/cueSILXFB
         qzdNHfnofYE20eMNFfsMxJ/PkVKrmyf9yUBvqoEC2t7gkeO7I0b98AC/nghv04rHc2Mk
         Riu5dd7SD9DPgliWVTFonogpXxsDv4M4Xr2MbWjtq2f4IN0imfgWb8PNwSTkZ+tfYb2Q
         geGlNJdCDREV8krXtJX64/M2XRcs8ZUWjx1QjIR11vJdBanWtJvV9+Agi3FgSIQL/s4f
         zmkaClJz6aNEquDSMeD4bJXViEyiFopLcwC3sDLOv4pE2/0OSLGZLU015oYba/shn0Od
         GQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755434051; x=1756038851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cSJAzpJrB/+0Vhq3Jx8mxwwAXiXUMS9lCBbypwhOCgE=;
        b=FUNGKtRRTun7OFpZI+aku3d3qTfZeffstf9nGS6eLTZj/K0oKK5LTcHbHDVS9gh6Nj
         CfMSnl55KvXwu86gaVwEpLXbeboNaW5LcnpsFaL2x9H9WnYBfwh69sn894Y0x0fYUytG
         umHktBV8bEKzN07C1vhKDmwER7jB1cc8QJUm8/j823YJCm7AP985RrqFlulKw3rJAXiA
         /fqlUXRaRfLU+bMWvomReH1GfFdl0QC7Oy7v6/7Y3A5wnfDEdh+Mo/dbZTHCsVe7UEMJ
         WS03Iv0D7rymtS4o6scsG1aFgnAmEkW0lJMzTG6BP6/hbUgcXydyTEPbcbgOBLDqgyGb
         ukjg==
X-Forwarded-Encrypted: i=1; AJvYcCWXzSMsznnwNZNQT8bx7het/dq+WRX5RTofNp3OKg0gnxylV6Hw95c5+vx/WkfbZCI3JBg5VT9hzQnm1cNai54=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTg7qH1tnj4cBTr59CRQkQMxBJ0OOeuVLe7e9V3OqLI7StzONI
	LBK4G8DvTL5u8zD1PdBAtC/KX/98esteVEpCGW0cpwGJd2D/AIBJVDiKHlJNBRHSLhpYEFWsS68
	s7gC4
X-Gm-Gg: ASbGncszewGv/WHwORqyKHp+/pTcTdHSxmM4BJtNLuJKgAi0PJ4bQ5f98puj9utScrW
	BIugbbsJaJt6jhN1WzVMgO3gCuOCDYmCgS5xyRif9SDYvcpkEekx/BYr8TsBkfwkH9Nhe/KILOY
	TUBav1URAmVVd3NPlpkEIP9W3LVi4MVBSed2jJaH110AzBl13cV9UTSHMmM/hoNq9wbq1SDIkrG
	TMBf4goQtDvgomf97ZcFDP4ghdZKFhfUD5qni3cCi2qyRP0CEvxvecaY5AfKcKBt2EGHVfDd5T7
	zbkrX6heFV3nlWv6J/J3Qk6KSKOc4Yp+jBcNEgh2Ugkq5n6SIcjdPb3MqotHU8QiclADXCAeseZ
	uCEAB01mqQDRF1tX9nYeCTHWVz1s6VZXQcO42fDxPXC6w4vHvpsHr37M=
X-Google-Smtp-Source: AGHT+IG9bQcRpasLdouxJiE//TtQ5x9wN3dfUlCeMpGjavP8R5CIApkBHxCO4i/AmFiEfyzFXEp67A==
X-Received: by 2002:a17:902:d50c:b0:240:763d:e999 with SMTP id d9443c01a7336-24478f7183fmr87414495ad.29.1755434050978;
        Sun, 17 Aug 2025 05:34:10 -0700 (PDT)
Received: from localhost.localdomain ([122.171.23.202])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3232b291449sm4480912a91.0.2025.08.17.05.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 05:34:10 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Atish Patra <atish.patra@linux.dev>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v2 6/6] KVM: riscv: selftests: Add SBI FWFT to get-reg-list test
Date: Sun, 17 Aug 2025 18:03:24 +0530
Message-ID: <20250817123324.239423-7-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250817123324.239423-1-apatel@ventanamicro.com>
References: <20250817123324.239423-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM RISC-V now supports SBI FWFT, so add it to the get-reg-list test.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 .../selftests/kvm/riscv/get-reg-list.c        | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index a0b7dabb5040..1bc84f09b4ee 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -128,6 +128,7 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_DBCN:
 	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_SUSP:
 	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_STA:
+	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_FWFT:
 	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_EXPERIMENTAL:
 	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_VENDOR:
 		return true;
@@ -627,6 +628,7 @@ static const char *sbi_ext_single_id_to_str(__u64 reg_off)
 		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_DBCN),
 		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_SUSP),
 		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_STA),
+		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_FWFT),
 		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_EXPERIMENTAL),
 		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_VENDOR),
 	};
@@ -683,6 +685,17 @@ static const char *sbi_sta_id_to_str(__u64 reg_off)
 	return strdup_printf("KVM_REG_RISCV_SBI_STA | %lld /* UNKNOWN */", reg_off);
 }
 
+static const char *sbi_fwft_id_to_str(__u64 reg_off)
+{
+	switch (reg_off) {
+	case 0: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(misaligned_deleg.flags)";
+	case 1: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(misaligned_deleg.value)";
+	case 2: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pointer_masking.flags)";
+	case 3: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pointer_masking.value)";
+	}
+	return strdup_printf("KVM_REG_RISCV_SBI_STA | %lld /* UNKNOWN */", reg_off);
+}
+
 static const char *sbi_id_to_str(const char *prefix, __u64 id)
 {
 	__u64 reg_off = id & ~(REG_MASK | KVM_REG_RISCV_SBI_STATE);
@@ -695,6 +708,8 @@ static const char *sbi_id_to_str(const char *prefix, __u64 id)
 	switch (reg_subtype) {
 	case KVM_REG_RISCV_SBI_STA:
 		return sbi_sta_id_to_str(reg_off);
+	case KVM_REG_RISCV_SBI_FWFT:
+		return sbi_fwft_id_to_str(reg_off);
 	}
 
 	return strdup_printf("%lld | %lld /* UNKNOWN */", reg_subtype, reg_off);
@@ -859,6 +874,14 @@ static __u64 sbi_sta_regs[] = {
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_STA | KVM_REG_RISCV_SBI_STA_REG(shmem_hi),
 };
 
+static __u64 sbi_fwft_regs[] = {
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_FWFT,
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(misaligned_deleg.flags),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(misaligned_deleg.value),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pointer_masking.flags),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pointer_masking.value),
+};
+
 static __u64 zicbom_regs[] = {
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CONFIG | KVM_REG_RISCV_CONFIG_REG(zicbom_block_size),
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZICBOM,
@@ -1010,6 +1033,9 @@ static __u64 vector_regs[] = {
 #define SUBLIST_SBI_STA \
 	{"sbi-sta", .feature_type = VCPU_FEATURE_SBI_EXT, .feature = KVM_RISCV_SBI_EXT_STA, \
 	 .regs = sbi_sta_regs, .regs_n = ARRAY_SIZE(sbi_sta_regs),}
+#define SUBLIST_SBI_FWFT \
+	{"sbi-fwft", .feature_type = VCPU_FEATURE_SBI_EXT, .feature = KVM_RISCV_SBI_EXT_FWFT, \
+	 .regs = sbi_fwft_regs, .regs_n = ARRAY_SIZE(sbi_fwft_regs),}
 #define SUBLIST_ZICBOM \
 	{"zicbom", .feature = KVM_RISCV_ISA_EXT_ZICBOM, .regs = zicbom_regs, .regs_n = ARRAY_SIZE(zicbom_regs),}
 #define SUBLIST_ZICBOZ \
@@ -1092,6 +1118,7 @@ KVM_SBI_EXT_SUBLIST_CONFIG(sta, STA);
 KVM_SBI_EXT_SIMPLE_CONFIG(pmu, PMU);
 KVM_SBI_EXT_SIMPLE_CONFIG(dbcn, DBCN);
 KVM_SBI_EXT_SIMPLE_CONFIG(susp, SUSP);
+KVM_SBI_EXT_SUBLIST_CONFIG(fwft, FWFT);
 
 KVM_ISA_EXT_SUBLIST_CONFIG(aia, AIA);
 KVM_ISA_EXT_SUBLIST_CONFIG(fp_f, FP_F);
@@ -1167,6 +1194,7 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&config_sbi_pmu,
 	&config_sbi_dbcn,
 	&config_sbi_susp,
+	&config_sbi_fwft,
 	&config_aia,
 	&config_fp_f,
 	&config_fp_d,
-- 
2.43.0


