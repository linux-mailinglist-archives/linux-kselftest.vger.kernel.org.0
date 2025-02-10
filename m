Return-Path: <linux-kselftest+bounces-26261-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C591A2FC6A
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 22:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D224316753D
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 21:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850CD25D529;
	Mon, 10 Feb 2025 21:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="KIJxLqrM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D7225A328
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 21:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739223388; cv=none; b=MJkqQswWqoHpY5nuetB6Ll4vig7bD+qWJW6j6Ly16Z/G1ZrpNUkjW+6wzJ5MxHl+oABJekdlwnXDy1+TMcIQf2d86XaRFAsisarzKrg4H+IGFYLTzeTpim0NxgnAo8VhC2xOJpKzBpIOPI5ywX8wkrto2w+w2afLm2zKJytA1Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739223388; c=relaxed/simple;
	bh=nJOyXdzbrLGYaga0Be2fMzo02Kjc7RMA0U06eJZe1ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f7QKGcDfATYdqFRUN5AqCF/smBPVAk6WNzOE5P0ozsHaTdPl1y0LVleb9YSNHQ9tmpep4/4VKciKmfoFv3MudtXXrcb1PPEyIwHhOdvy5Xob37nrw/dLKKj73PPYusZ5fqOzZwoHcOQiCYoG78OdjhZ0TL7cnkK3DL98H2IshFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=KIJxLqrM; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38dcc6bfbccso1956253f8f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 13:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739223383; x=1739828183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLemH8ynfgSfPvc/FNbZdwEa9OOsaEqx6lRijihbbR8=;
        b=KIJxLqrMBAv+1YPlGqnLgt9JUYyCRZ83WTXGcGkamWz4BTBTo9jm6zacyxC8L2EOGb
         DWst1w4FFQNY3HWlsVJe6aosuorUdosWblK1wujx9QcpA9A02hJzBUVTIvNRa54irLmy
         W0hmtfHqY2uS5uCtJ3mhCq/zLtGnwpLrpovU269AEY+bAyP/xLdVSr0uXGOhQalpwEY6
         P7u34R3vFyRidCZqr/rlnPGiE6ibaIyFKXSX/jwDKdr8SBdbu2cMYBQErYLZgw23nE1k
         gYbr6HSkqEEku1SJSsIY3V53VMnIm6ZFyFVn0ylZw44AMn2ZU8sVbbR+yb9dRZecWGo2
         Tgtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739223383; x=1739828183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YLemH8ynfgSfPvc/FNbZdwEa9OOsaEqx6lRijihbbR8=;
        b=CgNamOhFvzYCPvz63qPBm0GN/KfD1DlbwvRd2mTwCmTm34nlJf9SzV/O9UY+LGWUB7
         6S7O56/QJVhlqdBPpNpHbsKVZDcmYQM54RlQv9zfuLekqIYZl0VZL+yMRUXh4FPW+Ske
         pScsiuKXH+sC/1RQzrYwUeMraktVzFJLkSmW0bR4IqHS7arDbW/ZNm5ByqizZKBwUFnh
         kroNLSsAhesPfZlvlL0FnOjkRChIxDI5LMTCt5gjFt+lZ7D66JQf/a8l0PKMvpbQx1+v
         QHsfoz9BPa6B9I3k3nCGmAhyNlt8RJGHmNKJvY5LwCN04syix/BiKQZlqr/NIpKIvzhu
         tm8w==
X-Forwarded-Encrypted: i=1; AJvYcCUlbEiaN0TZctZ6h4CFvOfJggu+uUzycz/2wmoOvWGXt8tDfZzWkpWroPVHyaFZgf57xGUzRmMC5QhyOSFXra4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcjPx9HAoLIQHr3qMVjzzq6pzs50KyDjCZDRNWeSjYtvleDCKF
	7atPEHv2CO/Lt5GzHa/ciZZTBQM+26MOG+5U2QfE2hsRZ4fYEqQY0Rz2WuJZkQQ=
X-Gm-Gg: ASbGncvgF2Anso1CxWy/OrGWiKgBq1/LYW47vlAZdFQ/lFNESEHpg0R0oIuzTRAD+Pa
	iM+z2IVWV1hxvRqJbhyJkJ5AM8mjHwOKGAN2NKtOu8CejckuWRHd6dJRSLJ1bilP1tUgifgC1nF
	Bbq26UxfloUWYanm9chPgTtBV9FmblXscO+cop0GQ2huU6yBaxlDpt/a4Dfse4quuqfsI3cxqj1
	lkSV/R4eiAZ5J2zaCYo+u1uWZQKwHLs0qHaaDuyU4l0aJ6vOv0oN4yZRdSot8q5l0unG2oTBLWr
	oCSKgxJJQFAV9NLb
X-Google-Smtp-Source: AGHT+IH2dlYi1O5kUCZJxtYlgHXa+ws9BLhvD6mC+8NX+JeSXuC2kr9vlNuO+zXUNjOhcWWHcNo08w==
X-Received: by 2002:adf:efc4:0:b0:38a:4b8b:c57a with SMTP id ffacd0b85a97d-38dc93509damr12435434f8f.44.1739223383507;
        Mon, 10 Feb 2025 13:36:23 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394376118esm47541515e9.40.2025.02.10.13.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 13:36:22 -0800 (PST)
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
Subject: [PATCH v2 15/15] RISC-V: KVM: add support for SBI_FWFT_MISALIGNED_DELEG
Date: Mon, 10 Feb 2025 22:35:48 +0100
Message-ID: <20250210213549.1867704-16-cleger@rivosinc.com>
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

SBI_FWFT_MISALIGNED_DELEG needs hedeleg to be modified to delegate
misaligned load/store exceptions. Save and restore it during CPU
load/put.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/kvm/vcpu.c          |  3 +++
 arch/riscv/kvm/vcpu_sbi_fwft.c | 39 ++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 542747e2c7f5..d98e379945c3 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -646,6 +646,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 {
 	void *nsh;
 	struct kvm_vcpu_csr *csr = &vcpu->arch.guest_csr;
+	struct kvm_vcpu_config *cfg = &vcpu->arch.cfg;
 
 	vcpu->cpu = -1;
 
@@ -671,6 +672,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 		csr->vstval = nacl_csr_read(nsh, CSR_VSTVAL);
 		csr->hvip = nacl_csr_read(nsh, CSR_HVIP);
 		csr->vsatp = nacl_csr_read(nsh, CSR_VSATP);
+		cfg->hedeleg = nacl_csr_read(nsh, CSR_HEDELEG);
 	} else {
 		csr->vsstatus = csr_read(CSR_VSSTATUS);
 		csr->vsie = csr_read(CSR_VSIE);
@@ -681,6 +683,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 		csr->vstval = csr_read(CSR_VSTVAL);
 		csr->hvip = csr_read(CSR_HVIP);
 		csr->vsatp = csr_read(CSR_VSATP);
+		cfg->hedeleg = csr_read(CSR_HEDELEG);
 	}
 }
 
diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwft.c
index fe608bf16558..235a46d553d4 100644
--- a/arch/riscv/kvm/vcpu_sbi_fwft.c
+++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
@@ -14,6 +14,8 @@
 #include <asm/kvm_vcpu_sbi.h>
 #include <asm/kvm_vcpu_sbi_fwft.h>
 
+#define MIS_DELEG (1UL << EXC_LOAD_MISALIGNED | 1UL << EXC_STORE_MISALIGNED)
+
 static const enum sbi_fwft_feature_t kvm_fwft_defined_features[] = {
 	SBI_FWFT_MISALIGNED_EXC_DELEG,
 	SBI_FWFT_LANDING_PAD,
@@ -35,7 +37,44 @@ static bool kvm_fwft_is_defined_feature(enum sbi_fwft_feature_t feature)
 	return false;
 }
 
+static bool kvm_sbi_fwft_misaligned_delegation_supported(struct kvm_vcpu *vcpu)
+{
+	if (!misaligned_traps_can_delegate())
+		return false;
+
+	return true;
+}
+
+static int kvm_sbi_fwft_set_misaligned_delegation(struct kvm_vcpu *vcpu,
+					struct kvm_sbi_fwft_config *conf,
+					unsigned long value)
+{
+	if (value == 1)
+		csr_set(CSR_HEDELEG, MIS_DELEG);
+	else if (value == 0)
+		csr_clear(CSR_HEDELEG, MIS_DELEG);
+	else
+		return SBI_ERR_INVALID_PARAM;
+
+	return SBI_SUCCESS;
+}
+
+static int kvm_sbi_fwft_get_misaligned_delegation(struct kvm_vcpu *vcpu,
+					struct kvm_sbi_fwft_config *conf,
+					unsigned long *value)
+{
+	*value = (csr_read(CSR_HEDELEG) & MIS_DELEG) != 0;
+
+	return SBI_SUCCESS;
+}
+
 static const struct kvm_sbi_fwft_feature features[] = {
+	{
+		.id = SBI_FWFT_MISALIGNED_EXC_DELEG,
+		.supported = kvm_sbi_fwft_misaligned_delegation_supported,
+		.set = kvm_sbi_fwft_set_misaligned_delegation,
+		.get = kvm_sbi_fwft_get_misaligned_delegation,
+	},
 };
 
 static struct kvm_sbi_fwft_config *
-- 
2.47.2


