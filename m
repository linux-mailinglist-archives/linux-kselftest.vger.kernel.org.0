Return-Path: <linux-kselftest+bounces-26258-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE25A2FC5A
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 22:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 907317A1E11
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 21:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E6524E4BC;
	Mon, 10 Feb 2025 21:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ZbKzi5mK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84948257AF1
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 21:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739223383; cv=none; b=eDqzOWYOXvCVNzA4ujopDda0GWE3cstyxFrh/Co9yuVr7WVCTQFdnsWnHnA8+wZy4BYojV5UK8mX9u77HPIfSB5ND3jwgqO9V1kFg2wLxWBlEbA0yG7k1J74MP1jBWo7j2RyXZfCYUR0TGhxkG5EVoLih7vmd69EMCfyW3acJlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739223383; c=relaxed/simple;
	bh=tnKzbqMMp5HHjfXQnWoloF0osdhVoD6R7LW0XEkdLdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oblia/Rr1n4sesdT9a8IMMio+n6QE1fNEBLYmv9j8gbdUUq4QgQjvsrXm/+NUQmk5DyGzlqTn4i2G+he/Pw74vAErAUBJtNv6FmQmRpLVPd5D8qai5jyzd+Oyk9HEIvEpgY2cBnRGXFpsIf9DE+O2/DWZmoMiPNRI3daQ8Goymg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ZbKzi5mK; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38de17a5fc9so708548f8f.3
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 13:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739223379; x=1739828179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzMhLGWSVmu+B6UkQbjgF0/C3X18++BVbDb7RHWPhdM=;
        b=ZbKzi5mKr3OqmP2fjZJZs0xISpdic60V0Goq7gXYDzq7x1m1+j7C7+ygrqVb4TDhof
         EoK/pKg7ro07rRFPay68q+MGMgSPQDKjKoqpnjVwB2+c34nGoNmD9b00bdlkIEziQJuS
         Ku5poqJQAQEwHIWBjNppV7Vc58imjMTf8Lu7yGX8KoNVyA5jeHwSn1VJ+okk+O5Lma1U
         amJS9OMQBgWAfEj7PTjmetanUxMjAtWsBYUSzQRcNz4rLhe+hN9xOXvRca1Vmpigu5nd
         nn+QnSwpLNCuhUQ+rrlI5rp0dGHgxYMleHKJ30MmU3hWE0jE+bSUwu8vRKUscaDEEh4O
         Pw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739223379; x=1739828179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fzMhLGWSVmu+B6UkQbjgF0/C3X18++BVbDb7RHWPhdM=;
        b=lCI6np0F/ENeCBHaGKiM5Bl8n0xpWO6cNmmCNn+WYhZE6dvg+I9o2LbTswnEHBMt0q
         JIW6fRVXImM/ZWdb4iRfGfETFMjMzd2qNfyO2gJlar1BwotppI9heKXLo2ZiQ5iUwnHV
         YrA6ID+7+NOEVYSXCMXDvFcGxYJ6z3WhvWcFjaWx+LnjE7DEse7UM1km8xF8G3Uy7LGm
         yZkCsWFcy0xl3euX2Q/4jwa7x6eOKDmJjnOB5bDebs+NkZJuNXi13d6o7/+gpSG2byBv
         Zum9TZHy4yuQ4OYWtGbFzF6YTsEMWQySIbJpKX3fG9iHL6PtcKEKKch0UWwAXdvpfZem
         Pddw==
X-Forwarded-Encrypted: i=1; AJvYcCX2wHGzr9yJDI8DcagBOJFWrnAtpjuF07XPjSK8KvrrrwZaaG/TPKfLajxH9LjRueZuhWPvTsFs5K+pqlsO/s4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNAADnsILhvEv7t7qA32+z/ofkwkJO4RL9RnBB6sJboRa7d69d
	fM/32jy41Su8gXK9T2a6uX7jmqMcBDCs8wsqha37vGqsFjVouNL30RkRRhyCUoU=
X-Gm-Gg: ASbGnctYE71SYrlZ66xse8eriogxnwyurGCESmed7zwJrUKdpj1XDeCgnbaIs5bb646
	y1bZXSFr6PDZon6XThYTIFQV7IQtMDAJtq1G8XxnuVifVd43Hi4vuod+CCRfKfUZVXbrV/OrKiY
	GH++POiSPf19+1HTizcwpVKCuVFeHuMKhbInaDXHdvlHGNAJDRhCs3CFqm3DvvZSjkVDb1CpCj0
	/6IMyFMY3PTJ1ROwC7M3HAWdTXgPiN7d+6QFewojxqsM+4D4Ta+6xgf38hJRFVY1G9mLJNIMNjz
	twD+Fdx8DAwcu88b
X-Google-Smtp-Source: AGHT+IEdxZi1LVbl9euup4c2vHOS8bchWH6uTAT2rIkrBK2DWGVQXoH4pwkPsigJnMZZocj6TvzXjg==
X-Received: by 2002:a5d:6d0e:0:b0:38d:b34a:679 with SMTP id ffacd0b85a97d-38dc9373577mr10353065f8f.37.1739223379602;
        Mon, 10 Feb 2025 13:36:19 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394376118esm47541515e9.40.2025.02.10.13.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 13:36:18 -0800 (PST)
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
Subject: [PATCH v2 12/15] RISC-V: KVM: add SBI extension init()/deinit() functions
Date: Mon, 10 Feb 2025 22:35:45 +0100
Message-ID: <20250210213549.1867704-13-cleger@rivosinc.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250210213549.1867704-1-cleger@rivosinc.com>
References: <20250210213549.1867704-1-cleger@rivosinc.com>
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
 arch/riscv/include/asm/kvm_vcpu_sbi.h |  9 ++++++++
 arch/riscv/kvm/vcpu.c                 |  2 ++
 arch/riscv/kvm/vcpu_sbi.c             | 30 +++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

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
index d1c83a77735e..44f551143498 100644
--- a/arch/riscv/kvm/vcpu_sbi.c
+++ b/arch/riscv/kvm/vcpu_sbi.c
@@ -505,8 +505,38 @@ void kvm_riscv_vcpu_sbi_init(struct kvm_vcpu *vcpu)
 			continue;
 		}
 
+		if (!ext->default_disabled && ext->init &&
+		    ext->init(vcpu) != 0) {
+			    scontext->ext_status[idx] =
+				    KVM_RISCV_SBI_EXT_STATUS_UNAVAILABLE;
+			    continue;
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


