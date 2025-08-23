Return-Path: <linux-kselftest+bounces-39794-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB18B32A2F
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 18:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC400188B8F0
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 16:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D082EAB88;
	Sat, 23 Aug 2025 16:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="A6WkRlKw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7601885AB
	for <linux-kselftest@vger.kernel.org>; Sat, 23 Aug 2025 16:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964828; cv=none; b=nsLK8Jf5CxB4TOFtHTy8GBUdpZIpZgc65T6gUXdtJ19FKHMSKrLjUPXdqmnAfblVKVcz0fJlGd/lblTBLe1y/8iucB//s1o97irPHmnert2VlwroPg8guyIyMLSmpHXlyZVDqMu56DiD8A8rovaeLOA2GuHfNedqW95zn1P+jf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964828; c=relaxed/simple;
	bh=KVSzn4jAFjRZOnjj54GPJabMi5/vyN4OVJVrz5LsUW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hICgizG200FE4tBsAmUJLWjJUN4+2bN3n9JvPTm+inSKLB4cUixBRz+vwoFAXXNJuF3zBbrDJcgDApuCxW5LWKQ0ETGU+deA6WFQrTqfJAzVYXuogd3NeLn06Vid1zw7Kofh0QF3qOOx20B/s1e7tFZC080TJE0mwouy1o5G7AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=A6WkRlKw; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so2765322b3a.0
        for <linux-kselftest@vger.kernel.org>; Sat, 23 Aug 2025 09:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755964826; x=1756569626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QNTGSl8W9jUKwX1Y5hiHFssIh4zzMlPaIQnsQ0pfko=;
        b=A6WkRlKwBgCMqncNCEJCWsNwGzcnkkWlBwHglbOchMyj4jH9ops8KgkRZFUa67ZF14
         5cIe7k+wimeRnrrW59ZofqjCBpXfmzbsTivhn4ywVerfxlkQasWXCDbBHsDttfPgJrCv
         6LeRUFrlQ7EKPXBIP6BFNOineqk2LvigJT5XteZbYYzVeErErNLY/W/HDmx+P1hVRoR6
         XsNN0v1MdNoYf292JtsK1VUACxc3gMTliHXqK45PHH66Id5RvapW2+4Y7ELx2sJ4IFnA
         A4U4OoDgvihwtR1RIgagN3I/7n4c0pCAKkN+H/6nJvTLOmh0gjoE3NQOc28lVIvSk+Yw
         WJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755964826; x=1756569626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+QNTGSl8W9jUKwX1Y5hiHFssIh4zzMlPaIQnsQ0pfko=;
        b=jm5o82/ADVeivkGDikD3WeSX3lQzr8BZZRvSXnMNL6AnuGcp2ZnYmf7kSKxFSPN+G4
         rmpIsUCm777Y1rcK1GJK4oPHJ0qFIl3r1bEcaVHUNq5O2P/zRhTrtQMPxxuyu/XhfPGm
         LbX32m72wdLDSmCloXAJkWPtrUZqWzrOgQqW7yqfMJDGWgwYe4IPb3uY9YTQdVt4/7Zt
         OeNQKwi784RyVFz5Bw4wkJwfqN2vgidz0UHmI4rPW8W4rLUXftgN8QDzSw2moEY9SXpP
         XVEvPk+cbyDPg1HSUCAgWjaC1fvKX9I1YWoArNor4lKvfwHmSuCuf5ZXa+mxiJb/nFXN
         /tWg==
X-Forwarded-Encrypted: i=1; AJvYcCWK7PJInzFltyvhML7F9YIRvvTZnO77CZk+UBawXMKStjzw4GgHYFAEcruSwMFSJc7vivxEZQPxNuBJslSBoTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE5rLSfkkmvkc3X2zkc+qoWbwd4AvFYpDnYcndT78J5IfD7+SL
	y9KsvWWtUlB6s/dxPTCku/8lT7ziMu/qoqza1M00mU11gcVtXA/s/vDmskNM5arMcmE=
X-Gm-Gg: ASbGncuL8NKS0mBAiFdjkkgy+jWI5zhplPezGALqssiTTORwx4pKoXR7Miec1u9ouX/
	Gv9++Z174joTxNRDSE3Vxubk0QSsthfa52EUBKEAoyfkaRrziaWXZgeNL0uyLNrzhhpmsJU8fAR
	7Pm/ioDKVXg+1UqEOBxMBH1cfqntnma+MZO+Km7KBCAEJuqwuywFCvLjliESxxPbSsW7R1IbFWk
	agthhEHdfNkEGggzUIrAu5VbCZ9XJ8HvSHbk/5/XL6vI/6u+U3xO7noBNfVjOdS1ZFyxIUj+wGz
	FWXRCuToi31Ikzhan38ul4WvFxgvyza5T2yc2hlBg5bTVYIAYIGti/pagV6Zlu5R9xL/no3f1yi
	h+UsNGTvyHv0XMkX5hwyG7Ahdnrjeo7VBycdIJQfztWUFc4jAkdlCV302QFDGV0qwO9hEZjwJ
X-Google-Smtp-Source: AGHT+IEo9oLIFiXAIQrZJ7Jw/lL5+vEVJj3YiBwiqokGLrQldRoOB9aEEhSOfywm+FIR5r1fQzfjXg==
X-Received: by 2002:a05:6a00:9288:b0:76b:d67b:2ee0 with SMTP id d2e1a72fcca58-7702f9d7f70mr10308982b3a.6.1755964825622;
        Sat, 23 Aug 2025 09:00:25 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77040214b81sm2804464b3a.93.2025.08.23.09.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 09:00:25 -0700 (PDT)
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
Subject: [PATCH v3 4/6] RISC-V: KVM: Move copy_sbi_ext_reg_indices() to SBI implementation
Date: Sat, 23 Aug 2025 21:29:45 +0530
Message-ID: <20250823155947.1354229-5-apatel@ventanamicro.com>
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

The ONE_REG handling of SBI extension enable/disable registers and
SBI extension state registers is already under SBI implementation.
On similar lines, let's move copy_sbi_ext_reg_indices() under SBI
implementation.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/kvm_vcpu_sbi.h |  2 +-
 arch/riscv/kvm/vcpu_onereg.c          | 29 ++-------------------------
 arch/riscv/kvm/vcpu_sbi.c             | 27 ++++++++++++++++++++++++-
 3 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/asm/kvm_vcpu_sbi.h
index 8970cc7530c4..d75ca45c0152 100644
--- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
+++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
@@ -77,6 +77,7 @@ void kvm_riscv_vcpu_sbi_request_reset(struct kvm_vcpu *vcpu,
 				      unsigned long pc, unsigned long a1);
 void kvm_riscv_vcpu_sbi_load_reset_state(struct kvm_vcpu *vcpu);
 int kvm_riscv_vcpu_sbi_return(struct kvm_vcpu *vcpu, struct kvm_run *run);
+int kvm_riscv_vcpu_reg_indices_sbi_ext(struct kvm_vcpu *vcpu, u64 __user *uindices);
 int kvm_riscv_vcpu_set_reg_sbi_ext(struct kvm_vcpu *vcpu,
 				   const struct kvm_one_reg *reg);
 int kvm_riscv_vcpu_get_reg_sbi_ext(struct kvm_vcpu *vcpu,
@@ -86,7 +87,6 @@ int kvm_riscv_vcpu_set_reg_sbi(struct kvm_vcpu *vcpu, const struct kvm_one_reg *
 int kvm_riscv_vcpu_get_reg_sbi(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
 const struct kvm_vcpu_sbi_extension *kvm_vcpu_sbi_find_ext(
 				struct kvm_vcpu *vcpu, unsigned long extid);
-bool riscv_vcpu_supports_sbi_ext(struct kvm_vcpu *vcpu, int idx);
 int kvm_riscv_vcpu_sbi_ecall(struct kvm_vcpu *vcpu, struct kvm_run *run);
 void kvm_riscv_vcpu_sbi_init(struct kvm_vcpu *vcpu);
 void kvm_riscv_vcpu_sbi_deinit(struct kvm_vcpu *vcpu);
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index 0f4e444e5e10..865dae903aa0 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -1082,34 +1082,9 @@ static inline unsigned long num_isa_ext_regs(const struct kvm_vcpu *vcpu)
 	return copy_isa_ext_reg_indices(vcpu, NULL);
 }
 
-static int copy_sbi_ext_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
-{
-	unsigned int n = 0;
-
-	for (int i = 0; i < KVM_RISCV_SBI_EXT_MAX; i++) {
-		u64 size = IS_ENABLED(CONFIG_32BIT) ?
-			   KVM_REG_SIZE_U32 : KVM_REG_SIZE_U64;
-		u64 reg = KVM_REG_RISCV | size | KVM_REG_RISCV_SBI_EXT |
-			  KVM_REG_RISCV_SBI_SINGLE | i;
-
-		if (!riscv_vcpu_supports_sbi_ext(vcpu, i))
-			continue;
-
-		if (uindices) {
-			if (put_user(reg, uindices))
-				return -EFAULT;
-			uindices++;
-		}
-
-		n++;
-	}
-
-	return n;
-}
-
 static unsigned long num_sbi_ext_regs(struct kvm_vcpu *vcpu)
 {
-	return copy_sbi_ext_reg_indices(vcpu, NULL);
+	return kvm_riscv_vcpu_reg_indices_sbi_ext(vcpu, NULL);
 }
 
 static inline unsigned long num_sbi_regs(struct kvm_vcpu *vcpu)
@@ -1237,7 +1212,7 @@ int kvm_riscv_vcpu_copy_reg_indices(struct kvm_vcpu *vcpu,
 		return ret;
 	uindices += ret;
 
-	ret = copy_sbi_ext_reg_indices(vcpu, uindices);
+	ret = kvm_riscv_vcpu_reg_indices_sbi_ext(vcpu, uindices);
 	if (ret < 0)
 		return ret;
 	uindices += ret;
diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
index 04903e5012d6..1b13623380e1 100644
--- a/arch/riscv/kvm/vcpu_sbi.c
+++ b/arch/riscv/kvm/vcpu_sbi.c
@@ -110,7 +110,7 @@ riscv_vcpu_get_sbi_ext(struct kvm_vcpu *vcpu, unsigned long idx)
 	return sext;
 }
 
-bool riscv_vcpu_supports_sbi_ext(struct kvm_vcpu *vcpu, int idx)
+static bool riscv_vcpu_supports_sbi_ext(struct kvm_vcpu *vcpu, int idx)
 {
 	struct kvm_vcpu_sbi_context *scontext = &vcpu->arch.sbi_context;
 	const struct kvm_riscv_sbi_extension_entry *sext;
@@ -288,6 +288,31 @@ static int riscv_vcpu_get_sbi_ext_multi(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+int kvm_riscv_vcpu_reg_indices_sbi_ext(struct kvm_vcpu *vcpu, u64 __user *uindices)
+{
+	unsigned int n = 0;
+
+	for (int i = 0; i < KVM_RISCV_SBI_EXT_MAX; i++) {
+		u64 size = IS_ENABLED(CONFIG_32BIT) ?
+			   KVM_REG_SIZE_U32 : KVM_REG_SIZE_U64;
+		u64 reg = KVM_REG_RISCV | size | KVM_REG_RISCV_SBI_EXT |
+			  KVM_REG_RISCV_SBI_SINGLE | i;
+
+		if (!riscv_vcpu_supports_sbi_ext(vcpu, i))
+			continue;
+
+		if (uindices) {
+			if (put_user(reg, uindices))
+				return -EFAULT;
+			uindices++;
+		}
+
+		n++;
+	}
+
+	return n;
+}
+
 int kvm_riscv_vcpu_set_reg_sbi_ext(struct kvm_vcpu *vcpu,
 				   const struct kvm_one_reg *reg)
 {
-- 
2.43.0


