Return-Path: <linux-kselftest+bounces-31057-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4F4A91C05
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 14:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA85A445348
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 12:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B7724DFF8;
	Thu, 17 Apr 2025 12:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ebL7KfEo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0654524DFEC
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Apr 2025 12:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744892729; cv=none; b=XprqDIScS7KMdbM2n5nNu2H2Z6kQ0p3SsAAnEYMemmNeinsFdsK9mbwIBHWHPjzxOx9rKyLRqWRAqlLsFk9TkFTIoHg4sO4D4gtzCyvZTFvPR2zX174DadQLNOB2SjoU1Sk30eUH8llQEear4lMm9iiIW5OFHVjvXp1d243vsOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744892729; c=relaxed/simple;
	bh=NXa9HEO5RKY1D2k9IbxsxMtK9lSmU2PJg0VdH4XU874=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ihLakkmxx0mM7+TedKT5ea9S8Myh+PsldBRcaKHV60RY6GFgYUlSqffepa2SI34inbV0Gru+4WTzQrsOZ2fYHjOVifTm3Og9mRHw7qLS1L0cFEdCtnYR6AbMKrG6/C4KvLqMFhlgf8J6Ju3fs7M/TotrBcIbAm9apsJB1ODgcNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ebL7KfEo; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-223fb0f619dso7944065ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Apr 2025 05:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1744892727; x=1745497527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/KHThPTp9HBECdAqxs4JY6wN99GqOifsmOPr7rqjaok=;
        b=ebL7KfEoLNqPqmyiWZAsOd3YNnrAxLi5iPwk0vZzO1HAU3PqZEJryOBOFQUSEVCx5D
         6KkPS6/omiyR0cw0DrR0w6vrXo0ovV9xKUmPfHP5vjiMavkamcppOyMq7bswF6h8VZtg
         pxV/CglZ5tAXiNA16etMPHVOp4m3cL2smOraRDIxnAhAKz1ynOIm3uQ6RgE/FFFMxMIV
         zob7P1LzvABzUMIukDwahFh5UbXLPsZDjV9jmuE4UB6A3438EiK8S3aTsYIT+9tapbf+
         6gyLejP7c5HNtVFUvD+uBUmKS8FpY3//gbPpgZ2JOVDg8f/zsC1MkvFmxoz4vqjny5sn
         gR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744892727; x=1745497527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/KHThPTp9HBECdAqxs4JY6wN99GqOifsmOPr7rqjaok=;
        b=cfDsrwR9pVRVJdhUWwS7H1P1PtvK+urLJBC10fmrmLb+SLkNVUyku60jNEkGuOZWp+
         zKT+2pCyBo/3hrnBKAWY72ZJfHCBIs+ni3z2iNWcAWNB5WZGoNl4FaAs7n6QccoWutG6
         d2dgeHD0HDzZJ+TCGeN3FeHqP1eh7YY7gXC3ggFgyo4NRY8rIdtYYCryHTrGSooQ0Kuh
         fI/st7ffzvEBIltDeSUN5sxz/rwZnRNXg9/OZWC3FtkWGQh5PYxu/9cjm7lvuehz84l/
         KHvKEsMonCHAJgtb5u451rIqFb6VsJdIssshmfQIM/wHQ7U0/qSxCU3/ad2rB1LRaE2r
         X/5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCB7IlaGFFVInKjzuCAFt2S9RinsrmftyC90KRY3GGiAYvGZaHH+P229U3ZfiIpZU/udar6360/dyE4ZIDWnE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww+E0vpqUl/qXNFfO9mUAPcoG+wknwd1qQDqwKc6xDCc5M20Ty
	gHlPjc1yoo5axbXdUn3xFtfnH4xR58t3mznVmSBL7A7GnyG9v2vqsIPp+RxNOYU=
X-Gm-Gg: ASbGncskb8UpfBG45ip6+u4g9QMg6a2yciiaEVWk70e2ISuHAgRHM/BMXDH89VH/JTi
	xQa93NYxV9ix4O/7PUeKyhSePXHroca2gvCT1bEg+J7rq63hwr/TcJiRk3O0zXOtGEaR63Nj3O3
	FOp0Ya9XaSOBlOzrcFl3IPsD7tpFHwk2HEBl7O02BrszFyrSZv2L/33aZOOqgfhCBy0A6xUJJIT
	Cc1Q0a6dDBR9850TS/1wHgh556keUZiBeMEfcaDwFclToG1HgEy5ogZ1aP1YDEwkHdafPJ7W6wq
	HLcjqgKKABTYH32R/EUv4gf5B8zw9UsTx7QQo+se0w==
X-Google-Smtp-Source: AGHT+IEoqy/kqoORsS0UV+1ioB/JireEK12cMki3F6JIxzmrV6R0qu0Yn7V200b2nJAkaxmJUugsbg==
X-Received: by 2002:a17:903:1b26:b0:224:13a4:d62e with SMTP id d9443c01a7336-22c3597ec4bmr109539965ad.35.1744892727277;
        Thu, 17 Apr 2025 05:25:27 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c3ee1a78dsm18489415ad.253.2025.04.17.05.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 05:25:26 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v5 10/13] RISC-V: KVM: add SBI extension init()/deinit() functions
Date: Thu, 17 Apr 2025 14:19:57 +0200
Message-ID: <20250417122337.547969-11-cleger@rivosinc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417122337.547969-1-cleger@rivosinc.com>
References: <20250417122337.547969-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The FWFT SBI extension will need to dynamically allocate memory and do
init time specific initialization. Add an init/deinit callbacks that
allows to do so.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/kvm_vcpu_sbi.h |  9 +++++++++
 arch/riscv/kvm/vcpu.c                 |  2 ++
 arch/riscv/kvm/vcpu_sbi.c             | 26 ++++++++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/asm/kvm_vcpu_sbi.h
index 4ed6203cdd30..bcb90757b149 100644
--- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
+++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
@@ -49,6 +49,14 @@ struct kvm_vcpu_sbi_extension {
 
 	/* Extension specific probe function */
 	unsigned long (*probe)(struct kvm_vcpu *vcpu);
+
+	/*
+	 * Init/deinit function called once during VCPU init/destroy. These
+	 * might be use if the SBI extensions need to allocate or do specific
+	 * init time only configuration.
+	 */
+	int (*init)(struct kvm_vcpu *vcpu);
+	void (*deinit)(struct kvm_vcpu *vcpu);
 };
 
 void kvm_riscv_vcpu_sbi_forward(struct kvm_vcpu *vcpu, struct kvm_run *run);
@@ -69,6 +77,7 @@ const struct kvm_vcpu_sbi_extension *kvm_vcpu_sbi_find_ext(
 bool riscv_vcpu_supports_sbi_ext(struct kvm_vcpu *vcpu, int idx);
 int kvm_riscv_vcpu_sbi_ecall(struct kvm_vcpu *vcpu, struct kvm_run *run);
 void kvm_riscv_vcpu_sbi_init(struct kvm_vcpu *vcpu);
+void kvm_riscv_vcpu_sbi_deinit(struct kvm_vcpu *vcpu);
 
 int kvm_riscv_vcpu_get_reg_sbi_sta(struct kvm_vcpu *vcpu, unsigned long reg_num,
 				   unsigned long *reg_val);
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 60d684c76c58..877bcc85c067 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -185,6 +185,8 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 
 void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 {
+	kvm_riscv_vcpu_sbi_deinit(vcpu);
+
 	/* Cleanup VCPU AIA context */
 	kvm_riscv_vcpu_aia_deinit(vcpu);
 
diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
index d1c83a77735e..3139f171c20f 100644
--- a/arch/riscv/kvm/vcpu_sbi.c
+++ b/arch/riscv/kvm/vcpu_sbi.c
@@ -508,5 +508,31 @@ void kvm_riscv_vcpu_sbi_init(struct kvm_vcpu *vcpu)
 		scontext->ext_status[idx] = ext->default_disabled ?
 					KVM_RISCV_SBI_EXT_STATUS_DISABLED :
 					KVM_RISCV_SBI_EXT_STATUS_ENABLED;
+
+		if (ext->init && ext->init(vcpu) != 0)
+			scontext->ext_status[idx] = KVM_RISCV_SBI_EXT_STATUS_UNAVAILABLE;
+	}
+}
+
+void kvm_riscv_vcpu_sbi_deinit(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_sbi_context *scontext = &vcpu->arch.sbi_context;
+	const struct kvm_riscv_sbi_extension_entry *entry;
+	const struct kvm_vcpu_sbi_extension *ext;
+	int idx, i;
+
+	for (i = 0; i < ARRAY_SIZE(sbi_ext); i++) {
+		entry = &sbi_ext[i];
+		ext = entry->ext_ptr;
+		idx = entry->ext_idx;
+
+		if (idx < 0 || idx >= ARRAY_SIZE(scontext->ext_status))
+			continue;
+
+		if (scontext->ext_status[idx] == KVM_RISCV_SBI_EXT_STATUS_UNAVAILABLE ||
+		    !ext->deinit)
+			continue;
+
+		ext->deinit(vcpu);
 	}
 }
-- 
2.49.0


