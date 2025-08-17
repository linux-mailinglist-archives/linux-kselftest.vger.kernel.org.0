Return-Path: <linux-kselftest+bounces-39176-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA6AB29305
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Aug 2025 14:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 753377A4575
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Aug 2025 12:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE862877E1;
	Sun, 17 Aug 2025 12:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="F9PlLszB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1143F286D74
	for <linux-kselftest@vger.kernel.org>; Sun, 17 Aug 2025 12:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755434043; cv=none; b=ZmUwUFADlVl4r5jfgunr1W7aYbwvMMn9gOGApYBmtKhcquFU/Yzqs639HjNXHtYOEHzS6xkm5qm0vp9gROFV0NqoEryzgfjnsa2VXxOD3S5EbZ2QlN06y3Pu9EFN1BtHG/3sPgbj41967oHufwwyrM9QOgOd+QuGMgg0oLNz5wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755434043; c=relaxed/simple;
	bh=rUEDsE7OMNbrZonr7DAVZfzNpB2WUNyLAZ5gRH05Jz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEvzcelAq1FXhJ3K9dCgcuYgBW6fn98+2KBkOSMUZXLQrXRs5s5V5TXyzukHq3XcuHudJOm3OgVpP0dVONAEDqgYJNBeanLrCvsNeVttifk7Z64ZGjErlr+tRJ15VaHmzJTL8EVqz8nTz9K0JtJXPqQt6rj7SnagVMutlhIdsaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=F9PlLszB; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-323266b6ff5so1903930a91.0
        for <linux-kselftest@vger.kernel.org>; Sun, 17 Aug 2025 05:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755434041; x=1756038841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNhy8e+wcu2xj9coMjyL72gmYgwxBYToiGY6Az0bjY8=;
        b=F9PlLszBVpLfE+AUk98ZZqc9KP9KINCRShKbclJj8/fSxVJV1yKs8vfkSCAeIlrbTu
         NT+uFUT03Kms7uqmjSDF7MXZ2W2li0R5XszZk1nHL3A1/YqMFshTFC1HAeICFr9gUKdY
         AX5cbnnFleZ+gV2Xz6x1Ll7NChTzHkL2DGovu3JVzsQdZUvX20ZgZUrs6H/wj2XNV7JU
         852NmCIH9gG/eL/ZbCfPg0P5gKm+JsyfbaNyqHuOjT5XmVTm1lWYb8i9uvmJ8JnuBseq
         8Jj/QUsmV7qdztpWgbdowEYCuV3I+t+jWV736UKVpv/5LloMcdjDEJhZmioMJH8h7t/P
         kyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755434041; x=1756038841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GNhy8e+wcu2xj9coMjyL72gmYgwxBYToiGY6Az0bjY8=;
        b=P0oDUuNj2jNbVYhYXixAZsXZnxr9L6ou4t408XEHiAkd1mc0hGZxUv0JhPdEbtFITf
         lRezzv7PZL2vfjVu/VCnhmev0QsN0LpF+fCd/tVYZHLEHOgTKP8iFeNA8uofm489pjyD
         UC0uLMn6OoimD0/i2hGyHK5iRdGO9WAx3UeyK9CMfsrkjVPWC1p7+dV+QOBThKf1y6Ib
         mLxF9khviNZtkWk9ebl7HaG3PscTmxGSxd0tjDp142K4jCd5meGTSuC/FwQ9CnQEfcuD
         GkH+2oXR22Irolj4irOJNMibRKjRpR6wFt4yh7iqLBOWv3pXdTpNcZJo9mc7Sv4Pi4sb
         rSCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBCR9co3Lwz+0VZ2J2UWRGDLYvnj919zvjQYgbCUQioom4I6j+cGgaMciVW37eIv896nzC+ODFs9SsrsegM/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyix+bn7iwcP6JMu/cDy0ZdWZCRxK7sr8f+atQhBkkPjG3JEW2c
	QFcdpZZiHif7EPDErZwPStv/U1KHtnoL47AyZF66VKXmuolwbmdnA5h7IdIeNNyeCEo=
X-Gm-Gg: ASbGncuxfGA9E59BEbAXxFuh2Spdj2Bkdf72KtH66uPAom4snKUyPBMa99giyM5cDSj
	K3g7v8SesiRU5DFsmrm8ZciGRSuP+O97kSA7w3599N1ugjC6Tj5LSSc8ZBpWNPb9lsuEUnmCF1G
	Ix5fDxyRbqPDgpugxteQDGMV+5E7wktikrYtxqbPmFwDdx5yHpeg6iMmCeaDoVQbwfQnuF/ZfEQ
	2lnRKhS5AbgnSZxYPLHYvD422Gqqv6jVWd7ld8gj120TQL8yFc7txNmBxFkdCFqedzo3tik1hT6
	7FQrQSrFT27p6MqVXVJfNZswWNc9kZfCy7z5kWAX1ZRFi6eeRodRu9nJHCfD+zmgXqSig+wO+4G
	Mg/Rx06nOyqNAhMSBj7R+DBTVExHUyOz/EmEzQbclWEZeD7DxyMorP4I=
X-Google-Smtp-Source: AGHT+IHh37iRS02dzFD7p73eZSbpQiOlqNZO1JoyVWCj6beSgZrt2b8qgavkosgeWIhzOEcfJ80ZCA==
X-Received: by 2002:a17:90b:3b4d:b0:321:1348:4438 with SMTP id 98e67ed59e1d1-323296d963bmr17136225a91.7.1755434041279;
        Sun, 17 Aug 2025 05:34:01 -0700 (PDT)
Received: from localhost.localdomain ([122.171.23.202])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3232b291449sm4480912a91.0.2025.08.17.05.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 05:34:00 -0700 (PDT)
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
Subject: [PATCH v2 4/6] RISC-V: KVM: Move copy_sbi_ext_reg_indices() to SBI implementation
Date: Sun, 17 Aug 2025 18:03:22 +0530
Message-ID: <20250817123324.239423-5-apatel@ventanamicro.com>
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
index 5843b0519224..0894ab517525 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -1060,34 +1060,9 @@ static inline unsigned long num_isa_ext_regs(const struct kvm_vcpu *vcpu)
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
@@ -1215,7 +1190,7 @@ int kvm_riscv_vcpu_copy_reg_indices(struct kvm_vcpu *vcpu,
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


