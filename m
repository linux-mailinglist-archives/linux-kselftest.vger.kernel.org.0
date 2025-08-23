Return-Path: <linux-kselftest+bounces-39792-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4A4B32A3D
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 18:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6683683292
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 16:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224B11DE2B5;
	Sat, 23 Aug 2025 16:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="f6i206te"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9A03BBC9
	for <linux-kselftest@vger.kernel.org>; Sat, 23 Aug 2025 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964815; cv=none; b=YehUdKr3DKctyXiDzzn8KEUx4JW06SplywrbLg//fj7e8TqcgyJ7evfFw7CnIOOxmra8/gh/TXZkrkPY9Co6WHMrY6u7VDGBggQeqhPJWDISJi4ongwpMR9Wu7yfQ8CKlc/IzCiNZhUAK1qwAeb+dLC4S7oGfC12jipGpZ73cv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964815; c=relaxed/simple;
	bh=5HKxK+Boc/7ZdYflehjWFkppD0SyD2LOi7Sgi2n9lB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JS+HOnjPws/rz3qouCrrqqGDeKwyqkNl3N2gmWf51VOONDK1bJp3Sit3Hn2PjnHu0iwD1rCcS5s9gkvwRyL4COUG0JL4p1Iw71L6ykYStkya3GznHrJW7dtBTVmhpxOX1tPkFpey2aDEq6mwp2drUbqXos+1zhWgVk10sauVQzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=f6i206te; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e2eb09041so2750020b3a.3
        for <linux-kselftest@vger.kernel.org>; Sat, 23 Aug 2025 09:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755964813; x=1756569613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Chrrw+dyIJSlBaNuFfzfLJBXunJM56lFjN13/1zM0cU=;
        b=f6i206teC4KTkOm51PMokSfnLmkQVaOtnQeRnmhRvNi2tM3P0G35BzRxPjpX9FixJ1
         e4DkC4OSXlCh4YdOEJ/LgTOwEYrMXOKR6l4ShYgiLbz463OABkcUq9vYl3scvwQNBhaO
         lj8LhNs/q89aKtQ0kuBQ+k+DoaEn1Rwl1OQnb2VKAzfmvZbyjnuk3FAEpa0wrUWpt5yV
         xUvgKcpobKIGA+VFaf/pzkKcZc1ZntErnwLGYSSTrg7VpjreE1laXopxB84t4VQiJl46
         oOPF02Gv2fBuC05ygpUoZ81+Ljrfsxjf2hv6YI5DOr73kbIjACE8RCmVjdZqNLgzaEuK
         /OKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755964813; x=1756569613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Chrrw+dyIJSlBaNuFfzfLJBXunJM56lFjN13/1zM0cU=;
        b=nvlIsiqwUfRHJ1QiDnZPXR2C9Bqdpj/cPQpE1g8pChNb2lPiad67EQ4XLjk4qAcnO9
         vFLg4EePt1jxC0Kx+Puxf9ehLOap6hBU6WVAD9z2Xylu1dhL/1/LMgqTzYOLFCeWsKyG
         q9Cg44pNT1q0yHlc3AUc6aaUhbZvZHcJrJcK+WnK/7auS6D+G3HuoijqxfOKJdBvL988
         ozbIFjjQq0tNGjlYg3WjyTBiYT6wDzPg+xDHR/kWxx6O8P7YVoG5EqUC2doktWjlqRBd
         PMOnwo2Ajf5vIuoeK5SzJM+Jc4SWhasczhe5Yrod7Riazx2EKA3w5345V/y66gJPDfkr
         ENEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdDuJ5V4ygb8WxQUVRLcgAvW85FdEPTInmhKKz96hn01oqqsCe7o6RFhtFaixDpqNTCT6c1M6QKWSjsUjPfCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJtKLdOZeUeuqDXLYvM3zZBUOC3LCXEWY6EbB1UulWhnPRPClY
	JZan1wgbSoy8Wv71mk8AapM4zUK3HCF0eJSpEbW1b6a5jO1E2qQAQYPRpNma/6V3R0k=
X-Gm-Gg: ASbGnct7XlYuMqfb27ig45GhfRz77kSr3Wd10vRjO9x/6ZJ+kJ9pUR+Gtcn8SGI08k5
	0Cld+fYDmK3FKMUS7x0QIHCtQO+OkXuvFdobIG42kePL8L4K1leuqlB9dJnWkjCaGcVOqkZ6Dn2
	Uld1KQzFxxf7W5SlFMxGJViTs6LW/ZabF1sUoWqzwtHDqEbur/IYRqUmDQeEBeJuK+Six65i0Zd
	grwJYhP560D85K80pdcaZVOKkPHHnu2FXYh5nNwRWyh+7RjpJYkocRh7vcYLSAfmff4KXoN+Yzj
	Zlm1UkQxp+ogWG0Ye92MXmvEQU1TJgSFYvvtZkOhVHxX/135EuvzyG+qDdmlF/wodGhiflZDDuG
	3T0qNhnpir7cRVqj+wwueZyeG1OnoQ+CdInVkgiuF/bTPs4ODzNgZ5gPqfiWhuA==
X-Google-Smtp-Source: AGHT+IESNcTGvVN4k0EYaaXCdIDdf4qv1awjmTqd/O8lynLE/hwFMmWAV0QVQZM1K89/KGK7Pb4KXg==
X-Received: by 2002:a05:6a00:2e96:b0:76e:885a:c33c with SMTP id d2e1a72fcca58-7702fad486emr8086610b3a.26.1755964812754;
        Sat, 23 Aug 2025 09:00:12 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77040214b81sm2804464b3a.93.2025.08.23.09.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 09:00:12 -0700 (PDT)
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
Subject: [PATCH v3 2/6] RISC-V: KVM: Introduce feature specific reset for SBI FWFT
Date: Sat, 23 Aug 2025 21:29:43 +0530
Message-ID: <20250823155947.1354229-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250823155947.1354229-1-apatel@ventanamicro.com>
References: <20250823155947.1354229-1-apatel@ventanamicro.com>
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
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
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


