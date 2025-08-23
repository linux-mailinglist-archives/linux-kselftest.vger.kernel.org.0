Return-Path: <linux-kselftest+bounces-39793-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3947AB32A3B
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 18:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 614D1164EF8
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 16:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678152E9743;
	Sat, 23 Aug 2025 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="jq9nVlpc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7F22EA741
	for <linux-kselftest@vger.kernel.org>; Sat, 23 Aug 2025 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964822; cv=none; b=K6HDHSemlOpZuGeuNkrcqYQRCOAIFfQxUOzSnJSEl71LQ/6NV4zEMPFe/doAu5u9zBJpMozvJRaRHcKKabnsE6jMGf4ZM03+BGawNqPA211BWS5ZFR7GLkqjjp05iKmq7gHdvMruQIGsQSWZoheNTKKXIswl3M+EPX9vJk7rwYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964822; c=relaxed/simple;
	bh=o+lw/BPht1P4REIUIPZhrZhnYd85zsmpnu1ym62NXik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tvsqaVU9Jm5fsOq6cUDFh1db48Wh4mA94oCvdd4kl9B2qzdGSlIodX5few1iqvQ+MF0smhuo0/UkfcmWZeYP152f+6zafs6cCulm7BdH/Gr3r26JIOIx3doePB08tYEdbRRM+GHNFNEp05giuFguEQkWSkCQrFyI3cR3AD/ZXzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=jq9nVlpc; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b471737b347so2009771a12.1
        for <linux-kselftest@vger.kernel.org>; Sat, 23 Aug 2025 09:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755964820; x=1756569620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PRrbFKlAPo0iY7cqmxQ4BlWrfq3AMnKEWra5f0Zz/M=;
        b=jq9nVlpcNak8JysE1lrHUUp729gx/U452hrMFXm9k4zpLxB9bb0LKOoPr+INmXRhRv
         3SK8NehV2wpzTiXNZ7ryjOz74vy0XEAOFUeYdDqHXvF8g0zpjgLokACWoY7LaOW0Dbeq
         Z4vfk3V9u/xhL7k3HKOvFZEfmZOSd5owXa3WaDsb+VDf7vnDNCbutT4S4MbcD7C+GOC4
         IqrayTpkSTCSPHf9AbHPPUHNWxPc9uqxe1fnkaDfOOVgKIrnxz1r2YKqxX+PJc7dsg0b
         S3lrfBwgpGvyKftkteDamajtfK+ZgqNuB4sKaMoSoMknf/8B7IhbZ2QC1aKVMmgWrZGa
         X6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755964820; x=1756569620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PRrbFKlAPo0iY7cqmxQ4BlWrfq3AMnKEWra5f0Zz/M=;
        b=l3vDq5kmwsBQXQxGvdtwq5xKcjlxglluin2ekjjV1w5iejUPKHNb9zZ+MEbGPtYpon
         nVXfd9/NnnYbQE6Ft4uOyl4jJhdvq2dsKX+P7LoppOtuElp2yqQVu/WrZBOwqf0T5neX
         bQ4068unnyKZFQiTo1RNNipSfBYynOaSMOAd4EKOo8jR65Du5/eMCHbDFZYq4cFzgeQy
         2lXuFFiSm0uJH+PtFQU4o2cISRKSm/aJEiORO/J3zBbgMC+rO6aY4YIp+ZlMzQkaWxaj
         SsQ3NamifOik/Bi9PEumoFQYZg82jURH2ksi6Qd21ee9v9QKu5R9G8gRm4ecmd6Z/22O
         HcVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN2IVFZTfcU+gPsJEfRdlhd+kwBTsGjq+qytdZhyJwIXf5CuzJ7W5crPt7MzKw8PqJiarWHHP/4+ixVPpZ+Ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwFxXSTroj1EZgldAHf2DphtnaCgoaqUyEWOcLGFLWAu8ARg9R
	gjmVMpjKe6mqUMKUGnNzk17Nq3s4JzGzIBhpWY7uhdPF2PNnREt52Movzl0PrDy206c=
X-Gm-Gg: ASbGncvsp+fD4O1UT7Zc9vEvF15OCUDsmI4TP0rnbmYrrQvjos62D/bXD9Vz9MD6N+l
	3KHwmT/DXX5JGGwUrF/RsrTdU9RTbxGuTtxD8w1kKLJ88Sw0o3m8y3lq+Eyfd4DjfEyH0j2+wgy
	Squso5+ABHOvlVASCTraE/PSpwYsG7t1Y8NfLGotY+ht8hsz6wBxGg9GhnEHek9IPcrKf76vZiL
	XH0vmMvHIJ/aM3szKS9STfoh5OjVdumFZVb2T3xJeomIKMarguNqi0m7gLnoKEdPENCscfVTjYK
	it6JkA7EduzSHOvAOT/1l7BbG6vcYmuBkL/I5NjzSmBauIk7m8u1newQiXjj2b6fM2Cgs/DSXDs
	cX4sznP0k1UDeIuok0q+jVlH1lOM4Dw168q1OAWf8mh9aw9Nr029/MCTEroWXOQ==
X-Google-Smtp-Source: AGHT+IEz4ib3v6xj9/9qK/OO/ow5kk9gKoERQ302DF3ti/lE2LTdNFMCaskrQTDrkadVI8PFAruV+Q==
X-Received: by 2002:a17:903:1107:b0:242:a1ee:6c3f with SMTP id d9443c01a7336-2462ee246bfmr92516195ad.4.1755964819449;
        Sat, 23 Aug 2025 09:00:19 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77040214b81sm2804464b3a.93.2025.08.23.09.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 09:00:18 -0700 (PDT)
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
Subject: [PATCH v3 3/6] RISC-V: KVM: Introduce optional ONE_REG callbacks for SBI extensions
Date: Sat, 23 Aug 2025 21:29:44 +0530
Message-ID: <20250823155947.1354229-4-apatel@ventanamicro.com>
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

SBI extensions can have per-VCPU state which needs to be saved/restored
through ONE_REG interface for Guest/VM migration. Introduce optional
ONE_REG callbacks for SBI extensions so that ONE_REG implementation
for an SBI extenion is part of the extension sources.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/kvm_vcpu_sbi.h |  20 ++--
 arch/riscv/kvm/vcpu_onereg.c          |  31 +-----
 arch/riscv/kvm/vcpu_sbi.c             | 145 ++++++++++++++++++++++----
 arch/riscv/kvm/vcpu_sbi_sta.c         |  63 +++++++----
 4 files changed, 176 insertions(+), 83 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/asm/kvm_vcpu_sbi.h
index 766031e80960..8970cc7530c4 100644
--- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
+++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
@@ -59,6 +59,14 @@ struct kvm_vcpu_sbi_extension {
 	void (*deinit)(struct kvm_vcpu *vcpu);
 
 	void (*reset)(struct kvm_vcpu *vcpu);
+
+	unsigned long state_reg_subtype;
+	unsigned long (*get_state_reg_count)(struct kvm_vcpu *vcpu);
+	int (*get_state_reg_id)(struct kvm_vcpu *vcpu, int index, u64 *reg_id);
+	int (*get_state_reg)(struct kvm_vcpu *vcpu, unsigned long reg_num,
+			     unsigned long reg_size, void *reg_val);
+	int (*set_state_reg)(struct kvm_vcpu *vcpu, unsigned long reg_num,
+			     unsigned long reg_size, const void *reg_val);
 };
 
 void kvm_riscv_vcpu_sbi_forward(struct kvm_vcpu *vcpu, struct kvm_run *run);
@@ -73,10 +81,9 @@ int kvm_riscv_vcpu_set_reg_sbi_ext(struct kvm_vcpu *vcpu,
 				   const struct kvm_one_reg *reg);
 int kvm_riscv_vcpu_get_reg_sbi_ext(struct kvm_vcpu *vcpu,
 				   const struct kvm_one_reg *reg);
-int kvm_riscv_vcpu_set_reg_sbi(struct kvm_vcpu *vcpu,
-			       const struct kvm_one_reg *reg);
-int kvm_riscv_vcpu_get_reg_sbi(struct kvm_vcpu *vcpu,
-			       const struct kvm_one_reg *reg);
+int kvm_riscv_vcpu_reg_indices_sbi(struct kvm_vcpu *vcpu, u64 __user *uindices);
+int kvm_riscv_vcpu_set_reg_sbi(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
+int kvm_riscv_vcpu_get_reg_sbi(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
 const struct kvm_vcpu_sbi_extension *kvm_vcpu_sbi_find_ext(
 				struct kvm_vcpu *vcpu, unsigned long extid);
 bool riscv_vcpu_supports_sbi_ext(struct kvm_vcpu *vcpu, int idx);
@@ -85,11 +92,6 @@ void kvm_riscv_vcpu_sbi_init(struct kvm_vcpu *vcpu);
 void kvm_riscv_vcpu_sbi_deinit(struct kvm_vcpu *vcpu);
 void kvm_riscv_vcpu_sbi_reset(struct kvm_vcpu *vcpu);
 
-int kvm_riscv_vcpu_get_reg_sbi_sta(struct kvm_vcpu *vcpu, unsigned long reg_num,
-				   unsigned long *reg_val);
-int kvm_riscv_vcpu_set_reg_sbi_sta(struct kvm_vcpu *vcpu, unsigned long reg_num,
-				   unsigned long reg_val);
-
 #ifdef CONFIG_RISCV_SBI_V01
 extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_v01;
 #endif
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index 9f8b196e7697..0f4e444e5e10 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -1112,36 +1112,9 @@ static unsigned long num_sbi_ext_regs(struct kvm_vcpu *vcpu)
 	return copy_sbi_ext_reg_indices(vcpu, NULL);
 }
 
-static int copy_sbi_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
-{
-	struct kvm_vcpu_sbi_context *scontext = &vcpu->arch.sbi_context;
-	int total = 0;
-
-	if (scontext->ext_status[KVM_RISCV_SBI_EXT_STA] == KVM_RISCV_SBI_EXT_STATUS_ENABLED) {
-		u64 size = IS_ENABLED(CONFIG_32BIT) ? KVM_REG_SIZE_U32 : KVM_REG_SIZE_U64;
-		int n = sizeof(struct kvm_riscv_sbi_sta) / sizeof(unsigned long);
-
-		for (int i = 0; i < n; i++) {
-			u64 reg = KVM_REG_RISCV | size |
-				  KVM_REG_RISCV_SBI_STATE |
-				  KVM_REG_RISCV_SBI_STA | i;
-
-			if (uindices) {
-				if (put_user(reg, uindices))
-					return -EFAULT;
-				uindices++;
-			}
-		}
-
-		total += n;
-	}
-
-	return total;
-}
-
 static inline unsigned long num_sbi_regs(struct kvm_vcpu *vcpu)
 {
-	return copy_sbi_reg_indices(vcpu, NULL);
+	return kvm_riscv_vcpu_reg_indices_sbi(vcpu, NULL);
 }
 
 static inline unsigned long num_vector_regs(const struct kvm_vcpu *vcpu)
@@ -1269,7 +1242,7 @@ int kvm_riscv_vcpu_copy_reg_indices(struct kvm_vcpu *vcpu,
 		return ret;
 	uindices += ret;
 
-	ret = copy_sbi_reg_indices(vcpu, uindices);
+	ret = kvm_riscv_vcpu_reg_indices_sbi(vcpu, uindices);
 	if (ret < 0)
 		return ret;
 	uindices += ret;
diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
index 01a93f4fdb16..04903e5012d6 100644
--- a/arch/riscv/kvm/vcpu_sbi.c
+++ b/arch/riscv/kvm/vcpu_sbi.c
@@ -364,64 +364,163 @@ int kvm_riscv_vcpu_get_reg_sbi_ext(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
-int kvm_riscv_vcpu_set_reg_sbi(struct kvm_vcpu *vcpu,
-			       const struct kvm_one_reg *reg)
+int kvm_riscv_vcpu_reg_indices_sbi(struct kvm_vcpu *vcpu, u64 __user *uindices)
+{
+	struct kvm_vcpu_sbi_context *scontext = &vcpu->arch.sbi_context;
+	const struct kvm_riscv_sbi_extension_entry *entry;
+	const struct kvm_vcpu_sbi_extension *ext;
+	unsigned long state_reg_count;
+	int i, j, rc, count = 0;
+	u64 reg;
+
+	for (i = 0; i < ARRAY_SIZE(sbi_ext); i++) {
+		entry = &sbi_ext[i];
+		ext = entry->ext_ptr;
+
+		if (!ext->get_state_reg_count ||
+		    scontext->ext_status[entry->ext_idx] != KVM_RISCV_SBI_EXT_STATUS_ENABLED)
+			continue;
+
+		state_reg_count = ext->get_state_reg_count(vcpu);
+		if (!uindices)
+			goto skip_put_user;
+
+		for (j = 0; j < state_reg_count; j++) {
+			if (ext->get_state_reg_id) {
+				rc = ext->get_state_reg_id(vcpu, j, &reg);
+				if (rc)
+					return rc;
+			} else {
+				reg = KVM_REG_RISCV |
+				      (IS_ENABLED(CONFIG_32BIT) ?
+				       KVM_REG_SIZE_U32 : KVM_REG_SIZE_U64) |
+				      KVM_REG_RISCV_SBI_STATE |
+				      ext->state_reg_subtype | j;
+			}
+
+			if (put_user(reg, uindices))
+				return -EFAULT;
+			uindices++;
+		}
+
+skip_put_user:
+		count += state_reg_count;
+	}
+
+	return count;
+}
+
+static const struct kvm_vcpu_sbi_extension *kvm_vcpu_sbi_find_ext_withstate(struct kvm_vcpu *vcpu,
+									    unsigned long subtype)
+{
+	struct kvm_vcpu_sbi_context *scontext = &vcpu->arch.sbi_context;
+	const struct kvm_riscv_sbi_extension_entry *entry;
+	const struct kvm_vcpu_sbi_extension *ext;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sbi_ext); i++) {
+		entry = &sbi_ext[i];
+		ext = entry->ext_ptr;
+
+		if (ext->get_state_reg_count &&
+		    ext->state_reg_subtype == subtype &&
+		    scontext->ext_status[entry->ext_idx] == KVM_RISCV_SBI_EXT_STATUS_ENABLED)
+			return ext;
+	}
+
+	return NULL;
+}
+
+int kvm_riscv_vcpu_set_reg_sbi(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 {
 	unsigned long __user *uaddr =
 			(unsigned long __user *)(unsigned long)reg->addr;
 	unsigned long reg_num = reg->id & ~(KVM_REG_ARCH_MASK |
 					    KVM_REG_SIZE_MASK |
 					    KVM_REG_RISCV_SBI_STATE);
-	unsigned long reg_subtype, reg_val;
-
-	if (KVM_REG_SIZE(reg->id) != sizeof(unsigned long))
+	const struct kvm_vcpu_sbi_extension *ext;
+	unsigned long reg_subtype;
+	void *reg_val;
+	u64 data64;
+	u32 data32;
+	u16 data16;
+	u8 data8;
+
+	switch (KVM_REG_SIZE(reg->id)) {
+	case 1:
+		reg_val = &data8;
+		break;
+	case 2:
+		reg_val = &data16;
+		break;
+	case 4:
+		reg_val = &data32;
+		break;
+	case 8:
+		reg_val = &data64;
+		break;
+	default:
 		return -EINVAL;
+	}
 
-	if (copy_from_user(&reg_val, uaddr, KVM_REG_SIZE(reg->id)))
+	if (copy_from_user(reg_val, uaddr, KVM_REG_SIZE(reg->id)))
 		return -EFAULT;
 
 	reg_subtype = reg_num & KVM_REG_RISCV_SUBTYPE_MASK;
 	reg_num &= ~KVM_REG_RISCV_SUBTYPE_MASK;
 
-	switch (reg_subtype) {
-	case KVM_REG_RISCV_SBI_STA:
-		return kvm_riscv_vcpu_set_reg_sbi_sta(vcpu, reg_num, reg_val);
-	default:
+	ext = kvm_vcpu_sbi_find_ext_withstate(vcpu, reg_subtype);
+	if (!ext || !ext->set_state_reg)
 		return -EINVAL;
-	}
 
-	return 0;
+	return ext->set_state_reg(vcpu, reg_num, KVM_REG_SIZE(reg->id), reg_val);
 }
 
-int kvm_riscv_vcpu_get_reg_sbi(struct kvm_vcpu *vcpu,
-			       const struct kvm_one_reg *reg)
+int kvm_riscv_vcpu_get_reg_sbi(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 {
 	unsigned long __user *uaddr =
 			(unsigned long __user *)(unsigned long)reg->addr;
 	unsigned long reg_num = reg->id & ~(KVM_REG_ARCH_MASK |
 					    KVM_REG_SIZE_MASK |
 					    KVM_REG_RISCV_SBI_STATE);
-	unsigned long reg_subtype, reg_val;
+	const struct kvm_vcpu_sbi_extension *ext;
+	unsigned long reg_subtype;
+	void *reg_val;
+	u64 data64;
+	u32 data32;
+	u16 data16;
+	u8 data8;
 	int ret;
 
-	if (KVM_REG_SIZE(reg->id) != sizeof(unsigned long))
+	switch (KVM_REG_SIZE(reg->id)) {
+	case 1:
+		reg_val = &data8;
+		break;
+	case 2:
+		reg_val = &data16;
+		break;
+	case 4:
+		reg_val = &data32;
+		break;
+	case 8:
+		reg_val = &data64;
+		break;
+	default:
 		return -EINVAL;
+	}
 
 	reg_subtype = reg_num & KVM_REG_RISCV_SUBTYPE_MASK;
 	reg_num &= ~KVM_REG_RISCV_SUBTYPE_MASK;
 
-	switch (reg_subtype) {
-	case KVM_REG_RISCV_SBI_STA:
-		ret = kvm_riscv_vcpu_get_reg_sbi_sta(vcpu, reg_num, &reg_val);
-		break;
-	default:
+	ext = kvm_vcpu_sbi_find_ext_withstate(vcpu, reg_subtype);
+	if (!ext || !ext->get_state_reg)
 		return -EINVAL;
-	}
 
+	ret = ext->get_state_reg(vcpu, reg_num, KVM_REG_SIZE(reg->id), reg_val);
 	if (ret)
 		return ret;
 
-	if (copy_to_user(uaddr, &reg_val, KVM_REG_SIZE(reg->id)))
+	if (copy_to_user(uaddr, reg_val, KVM_REG_SIZE(reg->id)))
 		return -EFAULT;
 
 	return 0;
diff --git a/arch/riscv/kvm/vcpu_sbi_sta.c b/arch/riscv/kvm/vcpu_sbi_sta.c
index cc6cb7c8f0e4..68486f90a61e 100644
--- a/arch/riscv/kvm/vcpu_sbi_sta.c
+++ b/arch/riscv/kvm/vcpu_sbi_sta.c
@@ -151,63 +151,82 @@ static unsigned long kvm_sbi_ext_sta_probe(struct kvm_vcpu *vcpu)
 	return !!sched_info_on();
 }
 
-const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_sta = {
-	.extid_start = SBI_EXT_STA,
-	.extid_end = SBI_EXT_STA,
-	.handler = kvm_sbi_ext_sta_handler,
-	.probe = kvm_sbi_ext_sta_probe,
-	.reset = kvm_riscv_vcpu_sbi_sta_reset,
-};
+static unsigned long kvm_sbi_ext_sta_get_state_reg_count(struct kvm_vcpu *vcpu)
+{
+	return sizeof(struct kvm_riscv_sbi_sta) / sizeof(unsigned long);
+}
 
-int kvm_riscv_vcpu_get_reg_sbi_sta(struct kvm_vcpu *vcpu,
-				   unsigned long reg_num,
-				   unsigned long *reg_val)
+static int kvm_sbi_ext_sta_get_reg(struct kvm_vcpu *vcpu, unsigned long reg_num,
+				   unsigned long reg_size, void *reg_val)
 {
+	unsigned long *value;
+
+	if (reg_size != sizeof(unsigned long))
+		return -EINVAL;
+	value = reg_val;
+
 	switch (reg_num) {
 	case KVM_REG_RISCV_SBI_STA_REG(shmem_lo):
-		*reg_val = (unsigned long)vcpu->arch.sta.shmem;
+		*value = (unsigned long)vcpu->arch.sta.shmem;
 		break;
 	case KVM_REG_RISCV_SBI_STA_REG(shmem_hi):
 		if (IS_ENABLED(CONFIG_32BIT))
-			*reg_val = upper_32_bits(vcpu->arch.sta.shmem);
+			*value = upper_32_bits(vcpu->arch.sta.shmem);
 		else
-			*reg_val = 0;
+			*value = 0;
 		break;
 	default:
-		return -EINVAL;
+		return -ENOENT;
 	}
 
 	return 0;
 }
 
-int kvm_riscv_vcpu_set_reg_sbi_sta(struct kvm_vcpu *vcpu,
-				   unsigned long reg_num,
-				   unsigned long reg_val)
+static int kvm_sbi_ext_sta_set_reg(struct kvm_vcpu *vcpu, unsigned long reg_num,
+				   unsigned long reg_size, const void *reg_val)
 {
+	unsigned long value;
+
+	if (reg_size != sizeof(unsigned long))
+		return -EINVAL;
+	value = *(const unsigned long *)reg_val;
+
 	switch (reg_num) {
 	case KVM_REG_RISCV_SBI_STA_REG(shmem_lo):
 		if (IS_ENABLED(CONFIG_32BIT)) {
 			gpa_t hi = upper_32_bits(vcpu->arch.sta.shmem);
 
-			vcpu->arch.sta.shmem = reg_val;
+			vcpu->arch.sta.shmem = value;
 			vcpu->arch.sta.shmem |= hi << 32;
 		} else {
-			vcpu->arch.sta.shmem = reg_val;
+			vcpu->arch.sta.shmem = value;
 		}
 		break;
 	case KVM_REG_RISCV_SBI_STA_REG(shmem_hi):
 		if (IS_ENABLED(CONFIG_32BIT)) {
 			gpa_t lo = lower_32_bits(vcpu->arch.sta.shmem);
 
-			vcpu->arch.sta.shmem = ((gpa_t)reg_val << 32);
+			vcpu->arch.sta.shmem = ((gpa_t)value << 32);
 			vcpu->arch.sta.shmem |= lo;
-		} else if (reg_val != 0) {
+		} else if (value != 0) {
 			return -EINVAL;
 		}
 		break;
 	default:
-		return -EINVAL;
+		return -ENOENT;
 	}
 
 	return 0;
 }
+
+const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_sta = {
+	.extid_start = SBI_EXT_STA,
+	.extid_end = SBI_EXT_STA,
+	.handler = kvm_sbi_ext_sta_handler,
+	.probe = kvm_sbi_ext_sta_probe,
+	.reset = kvm_riscv_vcpu_sbi_sta_reset,
+	.state_reg_subtype = KVM_REG_RISCV_SBI_STA,
+	.get_state_reg_count = kvm_sbi_ext_sta_get_state_reg_count,
+	.get_state_reg = kvm_sbi_ext_sta_get_reg,
+	.set_state_reg = kvm_sbi_ext_sta_set_reg,
+};
-- 
2.43.0


