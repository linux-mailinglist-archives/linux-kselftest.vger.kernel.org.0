Return-Path: <linux-kselftest+bounces-38988-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83446B26BDC
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 18:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C22F5AC138C
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 15:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA912494ED;
	Thu, 14 Aug 2025 15:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="pMktD8Mo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DB623C503
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Aug 2025 15:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186973; cv=none; b=kF2mzJHwKHGRQ1UL9A/iZH1/UcSzUXXSBgANEwd65S/qyMISbNDWb4TrNio4+ey399IwmcGS+m5VG1oufGsedNZLKon1Tm3Bb4T4kxNoiqKv5XZ1ruSb/d3Fm0oEuDTbNriTTbIPGcnoT438JxXk2MU70+nUxLu32rR/1/6zWho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186973; c=relaxed/simple;
	bh=OAG+rNqDoUjd+RELKmOJev7nbWr03ivllHVNaYObMaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rybwIbTLSF4zWFLHzCDh7+k8qIhw+/Cu3MdnxXVVhQbHX0PzzFVQGQntMHeMhwc/7RTBW7BdahIfK7ubbXpYZsoPFE4SVdMDO3Ja3nCZ+AD0o/+ejromrdfvlT+P2HmG0R4ZD9id3TNGvnhIBmqeJ9Hfvn+QmP5liA7w+a4cyZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=pMktD8Mo; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32326e66dbaso846130a91.3
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Aug 2025 08:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755186972; x=1755791772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQNPbIdIHYbwO34hliHe+Dii/8OaWGaAGknLYtaJxxA=;
        b=pMktD8MouJMxo1PUfAaF8LwL+zPcEnU6aEoOkbLnL6s/wlBJpCrRc06YCdT2wHw3kt
         ad7hIkubt4AX2LaAnQOCPIxuxaDxAM5xSVoYkHyUqC9cG05v8h/91QwGWuy+E3KGf8Sw
         KnLBkYUsGjx/o5WQCeBmBb7XD4vNMSFAHKwUHYXJo1Ula7XPC/uhRMBlpVs773rDx7NF
         aJTmc4rQe2Ktyaqa9qs6FD8Xcn0Liy7xob1RUPGeP+i8sXTQxj/9DUUOSorYb/yXWrO4
         9uiV2a3CIJZ5NAGv88OoQxY4HkHfaRDyHSE1cEOBx16S+Rw130XsvE7EI9kKS3WCNUzR
         kCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755186972; x=1755791772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQNPbIdIHYbwO34hliHe+Dii/8OaWGaAGknLYtaJxxA=;
        b=AbB1oJt0WYe/QMSQXO9z9Guv6CFU1M3h66d++XxdIJqC7xzMGP0jprMD0zvmWeU6LO
         IVi5MZgzdMapjynlXglPengpEw9oxiRRKmsWhVCmU+9jLyEUMlFOFi8/Wh037kWRT10w
         qJ/qA5tmiaNnDrfBwP/sK0De0afgLLE7Eb5qVqVj2wCb3+jnl3BQq1gJWdmVJNIC6zpC
         CSuiv/aEUp0c8JDhdb0OHbZyNRN+vVXZ2IfhcUQoJij7R60o01jJS3wDUNp6MMc2qSUt
         6xKqA5fE5Itjql3S99I625YD5WE4MCfU7k6YsdB+1YAX9CYiPymGuI4khzOGcoKoQKAz
         vYaA==
X-Forwarded-Encrypted: i=1; AJvYcCXYTFg3cBRM8rk6LyRRQeSHj+6rhVfB6p2tQOvFfsHgEVsAOeIRBSq+sz1+0LidXRiebS8Ul1xmZhWGZ5TIdm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlqJFayghFKrXR3sz4MSvk2RnaTPGAYgp40eNFneFNO+lByR3w
	qgjIFymmdQ2RiuUzQboEvKR+/1EbzIUjkafGsqjYWpawpw3VEB+rCA/I2BBOdBxdiFk=
X-Gm-Gg: ASbGncvldV/biSnQIdiBg1YX9NzUNqqPsmF6e7raz9Uvmoc8ktedQX3v8kWLRi/myrs
	4rATnwlFi9+ENs1pOSmN3NB8Z4M58wAQfZGYNqhkIEkPLqgZ/T/qiirXxpGFzu8zamQiVYQdwKi
	vC9yJjV3tUAMVXFPsH/fsFkiPJkPjAugESvAfOpnuodb7Q19fKZRrpNE+0sM6F2wXPax9R+QSxH
	AmKW6GC33336vvIRUKBxco9xUkE84Dw7jeiP00NErW4Hy0BYJlenteRjwL448pqjH9GGwY6Evs6
	dpJzns7SBJOJeEtIOrXfm0KGUQkI4vpuxSNhY6BxO9/9Ogp7r0MF3DPqjsGUXByk7r+k0eXImty
	tIvLm6/eKyCFgcS/o4zlaURDzWO3ZHIvtTZbHLfBQAKXnS1XMCFyXpMCUg9VyRA==
X-Google-Smtp-Source: AGHT+IEH2lHONmY7yOykbcxyMlWHAYogmXhk5h922kUnrQe0tO8VefaBP+3/9ekNxpfG4JCDWaX1hA==
X-Received: by 2002:a17:90b:5303:b0:312:1c83:58e9 with SMTP id 98e67ed59e1d1-3232795877emr5105743a91.5.1755186971369;
        Thu, 14 Aug 2025 08:56:11 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3233108e1d9sm2225500a91.29.2025.08.14.08.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 08:56:10 -0700 (PDT)
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
Subject: [PATCH 2/6] RISC-V: KVM: Introduce feature specific reset for SBI FWFT
Date: Thu, 14 Aug 2025 21:25:44 +0530
Message-ID: <20250814155548.457172-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814155548.457172-1-apatel@ventanamicro.com>
References: <20250814155548.457172-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SBI FWFT feature values must be reset upon VCPU reset so
introduce feature specific reset callback for this purpose.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/kvm/vcpu_sbi_fwft.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwft.c
index 164a01288b0a..5a3bad0f9330 100644
--- a/arch/riscv/kvm/vcpu_sbi_fwft.c
+++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
@@ -30,6 +30,13 @@ struct kvm_sbi_fwft_feature {
 	 */
 	bool (*supported)(struct kvm_vcpu *vcpu);
 
+	/**
+	 * @reset: Reset the feature value irrespective whether feature is supported or not
+	 *
+	 * This callback is mandatory
+	 */
+	void (*reset)(struct kvm_vcpu *vcpu);
+
 	/**
 	 * @set: Set the feature value
 	 *
@@ -75,6 +82,13 @@ static bool kvm_sbi_fwft_misaligned_delegation_supported(struct kvm_vcpu *vcpu)
 	return misaligned_traps_can_delegate();
 }
 
+static void kvm_sbi_fwft_reset_misaligned_delegation(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_config *cfg = &vcpu->arch.cfg;
+
+	cfg->hedeleg &= ~MIS_DELEG;
+}
+
 static long kvm_sbi_fwft_set_misaligned_delegation(struct kvm_vcpu *vcpu,
 					struct kvm_sbi_fwft_config *conf,
 					unsigned long value)
@@ -124,6 +138,11 @@ static bool kvm_sbi_fwft_pointer_masking_pmlen_supported(struct kvm_vcpu *vcpu)
 	return fwft->have_vs_pmlen_7 || fwft->have_vs_pmlen_16;
 }
 
+static void kvm_sbi_fwft_reset_pointer_masking_pmlen(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.cfg.henvcfg &= ~ENVCFG_PMM;
+}
+
 static long kvm_sbi_fwft_set_pointer_masking_pmlen(struct kvm_vcpu *vcpu,
 						   struct kvm_sbi_fwft_config *conf,
 						   unsigned long value)
@@ -180,6 +199,7 @@ static const struct kvm_sbi_fwft_feature features[] = {
 	{
 		.id = SBI_FWFT_MISALIGNED_EXC_DELEG,
 		.supported = kvm_sbi_fwft_misaligned_delegation_supported,
+		.reset = kvm_sbi_fwft_reset_misaligned_delegation,
 		.set = kvm_sbi_fwft_set_misaligned_delegation,
 		.get = kvm_sbi_fwft_get_misaligned_delegation,
 	},
@@ -187,6 +207,7 @@ static const struct kvm_sbi_fwft_feature features[] = {
 	{
 		.id = SBI_FWFT_POINTER_MASKING_PMLEN,
 		.supported = kvm_sbi_fwft_pointer_masking_pmlen_supported,
+		.reset = kvm_sbi_fwft_reset_pointer_masking_pmlen,
 		.set = kvm_sbi_fwft_set_pointer_masking_pmlen,
 		.get = kvm_sbi_fwft_get_pointer_masking_pmlen,
 	},
@@ -321,11 +342,16 @@ static void kvm_sbi_ext_fwft_deinit(struct kvm_vcpu *vcpu)
 
 static void kvm_sbi_ext_fwft_reset(struct kvm_vcpu *vcpu)
 {
-	int i;
 	struct kvm_sbi_fwft *fwft = vcpu_to_fwft(vcpu);
+	const struct kvm_sbi_fwft_feature *feature;
+	int i;
 
-	for (i = 0; i < ARRAY_SIZE(features); i++)
+	for (i = 0; i < ARRAY_SIZE(features); i++) {
 		fwft->configs[i].flags = 0;
+		feature = &features[i];
+		if (feature->reset)
+			feature->reset(vcpu);
+	}
 }
 
 const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_fwft = {
-- 
2.43.0


