Return-Path: <linux-kselftest+bounces-28644-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3926A59994
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 16:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37F511884078
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 15:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571F2232787;
	Mon, 10 Mar 2025 15:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Ind7pQE/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F7A22DFA7
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 15:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619688; cv=none; b=KKZne+FbYuG9RRl24b1Zxzt+fzKpy/qktcqtzwQ4AIWsrrrLBgNFKxMGKTpXjGv97DZzyFp369VVtzKsk5f4Ed/Z+pUi9gOvtiqHmE2dNmHAPHnF8IB/3B5KJi9MJVdpnRvecVCY7Bt45OFORMh1wfiFChUCe5/tHp7IfYu1rbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619688; c=relaxed/simple;
	bh=RjDzKYoAvlKNtUWvQ+NXMggJmy91OtoJ6HGr5PDli6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pCGRhpZH3zMCtXYDv8g8yNYzbviQQv41Wa3FKi26IHA1XEMlmTt49en5vU8lHlehvOWR3M8hU9Fpq+tS9AIGUt+0artfER1XNtAzRJf5Sgcvdj8ArZw4X0L+iGVyv6968qTErTRmB0Vd9ON7HztbZhpk1Sxrgv/6JhDQJVWZox8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Ind7pQE/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22403cbb47fso82392805ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 08:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741619685; x=1742224485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YO198dOv/JV7u6RiN4qQUqM3nesMDxD5mvDVMd+k3NU=;
        b=Ind7pQE/WbUNlyQ8d9R9VZr5ciqGoOFgMuRXw1GIkh7lHxrddDKVHsEjvDNnYeiV3j
         1WFPUCs2Zyi+QMdenoulBDEZxrfSTrRyFkVkvOlTEBBVXfCU9GHtxNK/Ulq0WhrvBxZi
         pfmNnsFpdZvIJ1BXV28hSP+SVqLghqLnxCLGWj1bj9JR8mSNIzIEctxTNqaAQAz2r/n0
         7r4GOD8dYLeqnz9DyqI8d9lifUCaT3/tEAOksVUv+IxdRNPmwsOuBaw40egXSkVGRSol
         Kifq3xa+7jRHCIdsxsgZ83YWltTAby5EmBWonSrugE1o6AHpnb3uRIhBAccvlVK/wBX6
         iHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741619685; x=1742224485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YO198dOv/JV7u6RiN4qQUqM3nesMDxD5mvDVMd+k3NU=;
        b=ewP0leajTSv4TV7f3T7Et/8d2TaWd5z4KVuXYi+NS06VZI1Ja63bM1DvMDP+Jh6sgN
         SUU6ceh5uBVYa0MqXkfAmKxKo9TF8020DoPZArf6D0wviz7D0Ax2Z4d9WRPfwazhlWvy
         TSe8VriNY/G4wfqDlAAP5Ce7CVm3XbW8v/O7zuzA86b6kyL7IJG27R6Yn4mQoymU7y0p
         uRZMlRFX/Dxh8tybgcWNFYEzH5I2rSMIMJyPzvi3WaMATUJ8uU+fyk8SgzLsoo2mdKUf
         23Bbxlz34ub3baXdGOTvNVxxu5CzVZedEoISFOcqy2/i7GGF0H2A+Jtd+N/Dk8zwuevX
         tIrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXog+9gaZf8rdeonk5MWHe+7WOU94X/eWbV7ZqL6iO4nHFDZbcvqieWXYy9HY/GenyRAVSh6T7GwlRirYMkZZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4wbLhuUN9XMhZv5/sSkN4y5rXwQMOKp81vclVidAVmWP78Lbe
	hueqVXTGpdbcWysTESuLi6dMlpTs4tmPWrqklHfdpR8sKqMIUDgzF0BEDbNxmws=
X-Gm-Gg: ASbGncvn8W63eQIs2p+V7VgdokKSN+bHNCysFlQbHdt2kmT3J+2NmZ0ZFzEgdg5eV2p
	tDrsELdB9v00uFZVdrD+FgJ4GUEG+732AkN97thBvly9Bpp+lK9eK0u3kI/GnACQ5Szo0nmvKyd
	KlkD84+ZGbt9E+I1C8m8BDwhgax2xxbzMstywZTvHQaWcAFw+MgZbojg49OSKOg9cyjzkDmDssi
	zTDumA9JuCR1P54Xx9ghrbLcYBXv+0Ht4jYB/hXUp3/ILJNvg6A9QlCEhbScl7iwNNT9+WjbdVf
	VcHxB0Rx2E6CQBb/4L9YdXQfFcT3k802zkkvfkqmuRdIQw==
X-Google-Smtp-Source: AGHT+IGIS2XxIf4TQa/glKSShb2DPMKV2nM+32P/jFh4qY9T5snUhs8ena+pzkKO/eEMPCMRH58+YA==
X-Received: by 2002:a17:902:eb81:b0:223:5ca1:3b0b with SMTP id d9443c01a7336-22428bd592amr282084395ad.40.1741619685003;
        Mon, 10 Mar 2025 08:14:45 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e99dfsm79230515ad.91.2025.03.10.08.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 08:14:44 -0700 (PDT)
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
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v3 14/17] RISC-V: KVM: add SBI extension init()/deinit() functions
Date: Mon, 10 Mar 2025 16:12:21 +0100
Message-ID: <20250310151229.2365992-15-cleger@rivosinc.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250310151229.2365992-1-cleger@rivosinc.com>
References: <20250310151229.2365992-1-cleger@rivosinc.com>
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
---
 arch/riscv/include/asm/kvm_vcpu_sbi.h |  9 +++++++++
 arch/riscv/kvm/vcpu.c                 |  2 ++
 arch/riscv/kvm/vcpu_sbi.c             | 29 +++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)

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
index d1c83a77735e..858ddefd7e7f 100644
--- a/arch/riscv/kvm/vcpu_sbi.c
+++ b/arch/riscv/kvm/vcpu_sbi.c
@@ -505,8 +505,37 @@ void kvm_riscv_vcpu_sbi_init(struct kvm_vcpu *vcpu)
 			continue;
 		}
 
+		if (!ext->default_disabled && ext->init &&
+		    ext->init(vcpu) != 0) {
+			scontext->ext_status[idx] = KVM_RISCV_SBI_EXT_STATUS_UNAVAILABLE;
+			continue;
+		}
+
 		scontext->ext_status[idx] = ext->default_disabled ?
 					KVM_RISCV_SBI_EXT_STATUS_DISABLED :
 					KVM_RISCV_SBI_EXT_STATUS_ENABLED;
 	}
 }
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
+	}
+}
-- 
2.47.2


