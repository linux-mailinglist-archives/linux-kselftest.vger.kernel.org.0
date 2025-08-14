Return-Path: <linux-kselftest+bounces-38989-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F75B26BBB
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 18:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1CED1CC68F6
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 15:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00116241661;
	Thu, 14 Aug 2025 15:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ZJS6xMAC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F3823C4F4
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Aug 2025 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186979; cv=none; b=ZrHqJfmhEJXgzzYb3OJxEiYRl02ER3S5+Nnl+UZP8f9HZp9U4NpFeZ55+hNPkoDYurXC+ZXnLHGROkLAOgFqlCgvPOzu1/GQ8pv+9dWSPVWQ09vxcB1QF5DWKc1+sy0Ggd52fGzZZdA2JbWD2ctCygiKjK7vaGLLg0cFBekFaz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186979; c=relaxed/simple;
	bh=Zv6FgrHew/Ek+2uF8NLnj+TFtkte+TJ5pINKwvlDgys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MbGMEI+4BIz/3lvx8WwegfXbgognb305pAqrLf1veMipbnjVpjPRBD5afIz1gPKALuhzQas3foKhzEoYxoWQ6lzn0CVbTIlCPQtjUYEQI51nZZgtUFSK1hM+bUcxJ0hHrW5zkMpEqeR7pvR3lp1u0E9EOwSLgBdbkddryNa6lpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ZJS6xMAC; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32326e5a623so1076617a91.3
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Aug 2025 08:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755186977; x=1755791777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=voblbOo+QfvOAACcm5KZQLQjl5caMotAdJEG/UANWVA=;
        b=ZJS6xMAC/2nar6F8MHT2+vFFslQdIqDsHgrii7levobu/uEmd2u+hDN+ppKvT0wP5J
         o5n9K1tAHuLHTO4qMH7fC/pqjILMAd/4P1x/iMuTVlsh8iu+P+B38He1TCwuCoGbt7Mp
         8TwZgxXK2d/bm86gJtH/zpEYfsCkZYu9KXF+Uq0KMssnAF/0ptlg8ajBdXXXcW1BUDtV
         FD3eec4zP1tKmcbSyDZo6JYIzvAYOjTGUa8r37eKrVPmYyVGRMoeMYzscbozh4HcGbFa
         dibJsN9dJcfgFDVtIxBkCs+Hfc63CTkscn2JGkkdA/WsckxtE3XSBpILllGvAI3NtSqz
         Rypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755186977; x=1755791777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=voblbOo+QfvOAACcm5KZQLQjl5caMotAdJEG/UANWVA=;
        b=XvdajMLykuTALCkq2Lx2adVPpHRQAgRnGx+zVmJFqqNIKKQR/0qidUS8aXS/41MLXz
         NE13FsZo4qrLxEM0xmU6W7Sldy7bUnjQNAwTviV/JOvP05aPeMO9u3bRpfo9h+8Lg9Aw
         fClY+yxrE4Wfx85fEvuXeerlud5UYjtsSOwGfXqJrkFl2weYhtag7gJ1FbbtqUV7dZOd
         Hneb6K59TOBzXAm5DX+BlQxUTTgf7opxv6ldzHTyIdAe7CWXYaKTuIXK0QNnJwFxce9T
         Ox15zrSCz4Fh2Sc0qTvTZl/ejM4Bka7YBGyhWvxyXeEVn6xruse9zyNascnk+Cs/2Lif
         uisg==
X-Forwarded-Encrypted: i=1; AJvYcCU05WQiLj08Q+6DC8spoQcavp6JrNmQ4hICHCsXYzkb2NspTzAIb5l5Hlw5Q6IB1FGxtH+lEIjI6yBpqHpzWGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztv+hjlcQhSnMyzgmZbBNV/IzFd9h0dbcAxqsI3sChbiu4aCzB
	cb3VfnqsXpstBuOIrX5iJY3/4qnAHKQ17ZOHhfcL1qx+xpdmlyhFz4R81ooKfuyqRPo=
X-Gm-Gg: ASbGncvsk41CZFNCmRSp9oQ1pmB5pEdVb+jByJ3SZ2kk+wsutSJNtP00w6LuFj/dLG0
	F90WJPxt6NkKlUjsE6lapcjX/QeEJ603NgieZKWIewyhdJsBt41SogyQxW4x4ZZtNbgeEIv2XZ/
	Ba8txJTXoASw5qeXwTPdOKRSoFbsvPm2bpgcHl9b+mfG1C8YXvzPlE/duQ7S0POfAULNqAdt8oI
	TnK0JzvBprGQcRNiX3kW73hq/rRkkbhefQDiv+/Ecw91r7/fZ/Em6wayiEvZYL1RAQKeeY8CM4j
	4ayDbtwsjhdPX/xAhxveaW6ZrVShXDfmk9W1jzFUhCJt9900pofp5GStTjKD8mtOZ+S6sszvuBS
	+HYmcvR9DcGph/B+nrpLGzPJ1pYR7HMuaA8+Sc6Hqkzd6WrTIFeznd/cD8bqFlQ==
X-Google-Smtp-Source: AGHT+IEWlbE9RkFR5n0JYrCg/svcoKE1yY0HvyVS2YpuZCp4xKVZZIkxAHVif5GhfUz0bUo0i/cEoQ==
X-Received: by 2002:a17:90b:2790:b0:318:f0cb:5a50 with SMTP id 98e67ed59e1d1-32327b4916emr5400286a91.26.1755186977266;
        Thu, 14 Aug 2025 08:56:17 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3233108e1d9sm2225500a91.29.2025.08.14.08.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 08:56:16 -0700 (PDT)
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
Subject: [PATCH 3/6] RISC-V: KVM: Introduce optional ONE_REG callbacks for SBI extensions
Date: Thu, 14 Aug 2025 21:25:45 +0530
Message-ID: <20250814155548.457172-4-apatel@ventanamicro.com>
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

SBI extensions can have per-VCPU state which needs to be saved/restored
through ONE_REG interface for Guest/VM migration. Introduce optional
ONE_REG callbacks for SBI extensions so that ONE_REG implementation
for an SBI extenion is part of the extension sources.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/kvm_vcpu_sbi.h |  21 ++--
 arch/riscv/kvm/vcpu_onereg.c          |  31 +-----
 arch/riscv/kvm/vcpu_sbi.c             | 145 ++++++++++++++++++++++----
 arch/riscv/kvm/vcpu_sbi_sta.c         |  64 ++++++++----
 4 files changed, 178 insertions(+), 83 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/asm/kvm_vcpu_sbi.h
index 766031e80960..144c3f6d5eb9 100644
--- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
+++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
@@ -59,6 +59,15 @@ struct kvm_vcpu_sbi_extension {
 	void (*deinit)(struct kvm_vcpu *vcpu);
 
 	void (*reset)(struct kvm_vcpu *vcpu);
+
+	bool have_state;
+	unsigned long state_reg_subtype;
+	unsigned long (*get_state_reg_count)(struct kvm_vcpu *vcpu);
+	int (*get_state_reg_id)(struct kvm_vcpu *vcpu, int index, u64 *reg_id);
+	int (*get_state_reg)(struct kvm_vcpu *vcpu, unsigned long reg_num,
+			     unsigned long reg_size, void *reg_val);
+	int (*set_state_reg)(struct kvm_vcpu *vcpu, unsigned long reg_num,
+			     unsigned long reg_size, const void *reg_val);
 };
 
 void kvm_riscv_vcpu_sbi_forward(struct kvm_vcpu *vcpu, struct kvm_run *run);
@@ -73,10 +82,9 @@ int kvm_riscv_vcpu_set_reg_sbi_ext(struct kvm_vcpu *vcpu,
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
@@ -85,11 +93,6 @@ void kvm_riscv_vcpu_sbi_init(struct kvm_vcpu *vcpu);
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
index b77748a56a59..5843b0519224 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -1090,36 +1090,9 @@ static unsigned long num_sbi_ext_regs(struct kvm_vcpu *vcpu)
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
@@ -1247,7 +1220,7 @@ int kvm_riscv_vcpu_copy_reg_indices(struct kvm_vcpu *vcpu,
 		return ret;
 	uindices += ret;
 
-	ret = copy_sbi_reg_indices(vcpu, uindices);
+	ret = kvm_riscv_vcpu_reg_indices_sbi(vcpu, uindices);
 	if (ret < 0)
 		return ret;
 	uindices += ret;
diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
index 01a93f4fdb16..8b3c393e0c83 100644
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
+		if (!ext->have_state ||
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
+		if (ext->have_state &&
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
+	};
 
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
+	};
 
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
index cc6cb7c8f0e4..d14cf6255d83 100644
--- a/arch/riscv/kvm/vcpu_sbi_sta.c
+++ b/arch/riscv/kvm/vcpu_sbi_sta.c
@@ -151,63 +151,83 @@ static unsigned long kvm_sbi_ext_sta_probe(struct kvm_vcpu *vcpu)
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
+	.have_state = true,
+	.state_reg_subtype = KVM_REG_RISCV_SBI_STA,
+	.get_state_reg_count = kvm_sbi_ext_sta_get_state_reg_count,
+	.get_state_reg = kvm_sbi_ext_sta_get_reg,
+	.set_state_reg = kvm_sbi_ext_sta_set_reg,
+};
-- 
2.43.0


