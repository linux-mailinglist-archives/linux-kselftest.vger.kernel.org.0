Return-Path: <linux-kselftest+bounces-26330-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1468A302FC
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 06:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 875FF188B599
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 05:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9A91E5B66;
	Tue, 11 Feb 2025 05:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="eUqqY8zC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346851E571B
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 05:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739252632; cv=none; b=uq91ZHmrzNGYWwW+cmm8PwUgghxIWUz78niNCMmUPNRCOI1rYFjgbWyjbR64W4Tk5IhPCT+AV36+IH4LsBD4rUiOGzmC+hzTGoQzbi0XE3B/qH4dIvp47bJGcUDw0dkKkzUOFizacwlLHKqq2fGnWTs2ZJJxSFkzh0Ri677EUFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739252632; c=relaxed/simple;
	bh=5PbCqh3umgNU/gZ+tDrHMMIbr/nnUqN53Rb2ul6bOEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MF6xHkGiJAVMHGuQRHsW1k45VCCVIJZbywfNrZ8FgzpXHrxt8e8HelzUd6TQKkYvmqSydX1O7yuAcdDAGRvjC2tUMqlGvTr0IcFo7wwDsgLMatNu2QbZ2X7yTXVE8hKGLBuJV3aYo8DNyvdnq727LZANHexg7pma1oKkvPoCgBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=eUqqY8zC; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f62cc4088so54963505ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 21:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739252629; x=1739857429; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bQsQ+/o421QYPh8BJOWROcjn2xBlqUe9Xq6Aw4uiVNM=;
        b=eUqqY8zCHDgKkQpCjdL4Xw1+uS1OpdpHq8SzUSvAlaUbFr2jSKbnGWYNxJIKVqZMI4
         hCuvX1/Q7D6ZjejLPgQwWi5FCDlWFXH/DFV5CHHTe7D1WbNxYHmpvmfcM2Dskb4pUIzB
         /nBnIAk9Z/ZztJrqkPT01w0BpMyl3hn0PaJvkW+aC/S8oD7CEjuEFlGhSlxr5UMq14K6
         O/zKQliYyVTojn3er7+NQKc+JzCQVXB0BNFjQaZxXXeBPRE7G3WswTgkib2lQlxCyNeD
         urjaZKplDHufxqzA8abubq+DzmgONMeyy/unZp9cLb3Xj2nFf9IUkhGenfgh3Nms36rq
         CEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739252629; x=1739857429;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bQsQ+/o421QYPh8BJOWROcjn2xBlqUe9Xq6Aw4uiVNM=;
        b=amYNxDpqGmaMo2bYpIHP5FHDFIzTF09zzchArPJzWb/asg32Fz8zqXYbUWo/7v4sr3
         MyNS4e/0f7yikPYvEn7ZNu9XLHqBUZn+IfwfiYrpPj9fKy9cV2FunYWaMvzFHF5OQ/th
         QCcP6pNZErf3TO/FLJx5SS/fucshXHO3PiRMlR5SvaUo4hmudH8BUMJEanNRz/8dWaLp
         QX6ZRlshQVnCNyFtDdYdIgDr9cu5xUX/Rl492Mr7ZRUYf5eNMn9D3Nz3fROEr5ymAxpn
         ichlkFKHKQb5n22SiSNNEuJWe8Ldc3a3+gPecG+axndIijAjxfz5Z+TZXnV8/JIIgTgN
         HESQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg7lAHZJY1iKWsFFFaWVs4pz270zNB4J4b+lWuueiRFpu8KOQQXTabPiFWlZOhe0egMhTqUKIMzTgnFqfp4Tg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+xxSaO7f2f6VpSXhvZQ2lXq5Qx6KogiL46DCO6cF2JfIe55Vh
	YyW5ZYRZvh+u/aNo1KYAue/1RK7uHq89FTH8DZ1q9tcEf5+xV2GNozAPi06FJrA=
X-Gm-Gg: ASbGnctfT27DX/Zt+vJgfyASTZOD/0uPupyNewZJZ07gdXMdYyCll8bz5My3CgygXHn
	G0m7wrloDIfxakp6SkX8NbnPo6A+VCFClTGQQIrfNmVomLloJSLJ5GelKo5Izk4VwU1k9g9WMfX
	8itSLfh4/QBYpnPudAeX6t2/ZJq5ctjq5IbmohZOQCVPbQ/o0Xlb1BLK350+9DdwsO+MLxgKI5M
	6wcdE6Utdvkmf0KxegOydNBK4tqupWFLAHQmWx7IOBvWKZrglY3RLV6+g0QBf7nPRICMjcj1Aqs
	oqkUhZ2FtqMT8mqvjnk2A4GtmQ==
X-Google-Smtp-Source: AGHT+IEPKtHYtx0smpDpQgrDnTYBegghA1v5GIvgD0h4cr824ONo5mx4lRTjSLhr137zD0mY6UDmiw==
X-Received: by 2002:a05:6a20:9f4a:b0:1e8:bd15:6819 with SMTP id adf61e73a8af0-1ee03a5f141mr31000422637.22.1739252629301;
        Mon, 10 Feb 2025 21:43:49 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7308b102789sm3396914b3a.149.2025.02.10.21.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 21:43:48 -0800 (PST)
Date: Mon, 10 Feb 2025 21:43:46 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v2 14/15] RISC-V: KVM: add support for FWFT SBI extension
Message-ID: <Z6rjkk5JlMlqbl2j@debug.ba.rivosinc.com>
References: <20250210213549.1867704-1-cleger@rivosinc.com>
 <20250210213549.1867704-15-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250210213549.1867704-15-cleger@rivosinc.com>

On Mon, Feb 10, 2025 at 10:35:47PM +0100, Clément Léger wrote:
>Add basic infrastructure to support the FWFT extension in KVM.
>
>Signed-off-by: Clément Léger <cleger@rivosinc.com>
>---
> arch/riscv/include/asm/kvm_host.h          |   4 +
> arch/riscv/include/asm/kvm_vcpu_sbi.h      |   1 +
> arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h |  37 ++++
> arch/riscv/include/uapi/asm/kvm.h          |   1 +
> arch/riscv/kvm/Makefile                    |   1 +
> arch/riscv/kvm/vcpu_sbi.c                  |   4 +
> arch/riscv/kvm/vcpu_sbi_fwft.c             | 187 +++++++++++++++++++++
> 7 files changed, 235 insertions(+)
> create mode 100644 arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h
> create mode 100644 arch/riscv/kvm/vcpu_sbi_fwft.c
>
>diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
>index bb93d2995ea2..c0db61ba691a 100644
>--- a/arch/riscv/include/asm/kvm_host.h
>+++ b/arch/riscv/include/asm/kvm_host.h
>@@ -19,6 +19,7 @@
> #include <asm/kvm_vcpu_fp.h>
> #include <asm/kvm_vcpu_insn.h>
> #include <asm/kvm_vcpu_sbi.h>
>+#include <asm/kvm_vcpu_sbi_fwft.h>
> #include <asm/kvm_vcpu_timer.h>
> #include <asm/kvm_vcpu_pmu.h>
>
>@@ -281,6 +282,9 @@ struct kvm_vcpu_arch {
> 	/* Performance monitoring context */
> 	struct kvm_pmu pmu_context;
>
>+	/* Firmware feature SBI extension context */
>+	struct kvm_sbi_fwft fwft_context;
>+
> 	/* 'static' configurations which are set only once */
> 	struct kvm_vcpu_config cfg;
>
>diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/asm/kvm_vcpu_sbi.h
>index cb68b3a57c8f..ffd03fed0c06 100644
>--- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
>+++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
>@@ -98,6 +98,7 @@ extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_hsm;
> extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_dbcn;
> extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_susp;
> extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_sta;
>+extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_fwft;
> extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_experimental;
> extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_vendor;
>
>diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h b/arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h
>new file mode 100644
>index 000000000000..5782517f6e08
>--- /dev/null
>+++ b/arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h
>@@ -0,0 +1,37 @@
>+/* SPDX-License-Identifier: GPL-2.0-only */
>+/*
>+ * Copyright (c) 2025 Rivos Inc.
>+ *
>+ * Authors:
>+ *     Clément Léger <cleger@rivosinc.com>
>+ */
>+
>+#ifndef __KVM_VCPU_RISCV_FWFT_H
>+#define __KVM_VCPU_RISCV_FWFT_H
>+
>+#include <asm/sbi.h>
>+
>+struct kvm_sbi_fwft_config;
>+struct kvm_vcpu;
>+
>+struct kvm_sbi_fwft_feature {
>+	enum sbi_fwft_feature_t id;
>+	bool (*supported)(struct kvm_vcpu *vcpu);
>+	int (*set)(struct kvm_vcpu *vcpu, struct kvm_sbi_fwft_config *conf, unsigned long value);
>+	int (*get)(struct kvm_vcpu *vcpu, struct kvm_sbi_fwft_config *conf, unsigned long *value);
>+};
>+
>+struct kvm_sbi_fwft_config {
>+	const struct kvm_sbi_fwft_feature *feature;
>+	bool supported;
>+	unsigned long flags;
>+};
>+
>+/* FWFT data structure per vcpu */
>+struct kvm_sbi_fwft {
>+	struct kvm_sbi_fwft_config *configs;
>+};
>+
>+#define vcpu_to_fwft(vcpu) (&(vcpu)->arch.fwft_context)
>+
>+#endif /* !__KVM_VCPU_RISCV_FWFT_H */
>diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
>index f06bc5efcd79..fa6eee1caf41 100644
>--- a/arch/riscv/include/uapi/asm/kvm.h
>+++ b/arch/riscv/include/uapi/asm/kvm.h
>@@ -202,6 +202,7 @@ enum KVM_RISCV_SBI_EXT_ID {
> 	KVM_RISCV_SBI_EXT_DBCN,
> 	KVM_RISCV_SBI_EXT_STA,
> 	KVM_RISCV_SBI_EXT_SUSP,
>+	KVM_RISCV_SBI_EXT_FWFT,
> 	KVM_RISCV_SBI_EXT_MAX,
> };
>
>diff --git a/arch/riscv/kvm/Makefile b/arch/riscv/kvm/Makefile
>index 4e0bba91d284..06e2d52a9b88 100644
>--- a/arch/riscv/kvm/Makefile
>+++ b/arch/riscv/kvm/Makefile
>@@ -26,6 +26,7 @@ kvm-y += vcpu_onereg.o
> kvm-$(CONFIG_RISCV_PMU_SBI) += vcpu_pmu.o
> kvm-y += vcpu_sbi.o
> kvm-y += vcpu_sbi_base.o
>+kvm-y += vcpu_sbi_fwft.o
> kvm-y += vcpu_sbi_hsm.o
> kvm-$(CONFIG_RISCV_PMU_SBI) += vcpu_sbi_pmu.o
> kvm-y += vcpu_sbi_replace.o
>diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
>index f81f06f82650..3b37deaed4e7 100644
>--- a/arch/riscv/kvm/vcpu_sbi.c
>+++ b/arch/riscv/kvm/vcpu_sbi.c
>@@ -78,6 +78,10 @@ static const struct kvm_riscv_sbi_extension_entry sbi_ext[] = {
> 		.ext_idx = KVM_RISCV_SBI_EXT_STA,
> 		.ext_ptr = &vcpu_sbi_ext_sta,
> 	},
>+	{
>+		.ext_idx = KVM_RISCV_SBI_EXT_FWFT,
>+		.ext_ptr = &vcpu_sbi_ext_fwft,
>+	},
> 	{
> 		.ext_idx = KVM_RISCV_SBI_EXT_EXPERIMENTAL,
> 		.ext_ptr = &vcpu_sbi_ext_experimental,
>diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwft.c
>new file mode 100644
>index 000000000000..fe608bf16558
>--- /dev/null
>+++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
>@@ -0,0 +1,187 @@
>+// SPDX-License-Identifier: GPL-2.0
>+/*
>+ * Copyright (c) 2025 Rivos Inc.
>+ *
>+ * Authors:
>+ *     Clément Léger <cleger@rivosinc.com>
>+ */
>+
>+#include <linux/errno.h>
>+#include <linux/err.h>
>+#include <linux/kvm_host.h>
>+#include <asm/cpufeature.h>
>+#include <asm/sbi.h>
>+#include <asm/kvm_vcpu_sbi.h>
>+#include <asm/kvm_vcpu_sbi_fwft.h>
>+
>+static const enum sbi_fwft_feature_t kvm_fwft_defined_features[] = {
>+	SBI_FWFT_MISALIGNED_EXC_DELEG,
>+	SBI_FWFT_LANDING_PAD,
>+	SBI_FWFT_SHADOW_STACK,
>+	SBI_FWFT_DOUBLE_TRAP,
>+	SBI_FWFT_PTE_AD_HW_UPDATING,
>+	SBI_FWFT_POINTER_MASKING_PMLEN,
>+};
>+
>+static bool kvm_fwft_is_defined_feature(enum sbi_fwft_feature_t feature)
>+{
>+	int i;
>+
>+	for (i = 0; i < ARRAY_SIZE(kvm_fwft_defined_features); i++) {
>+		if (kvm_fwft_defined_features[i] == feature)
>+			return true;
>+	}
>+
>+	return false;
>+}
>+
>+static const struct kvm_sbi_fwft_feature features[] = {
>+};
>+
>+static struct kvm_sbi_fwft_config *
>+kvm_sbi_fwft_get_config(struct kvm_vcpu *vcpu, enum sbi_fwft_feature_t feature)
>+{
>+	int i = 0;
>+	struct kvm_sbi_fwft *fwft = vcpu_to_fwft(vcpu);
>+
>+	for (i = 0; i < ARRAY_SIZE(features); i++) {
>+		if (fwft->configs[i].feature->id == feature)
>+			return &fwft->configs[i];
>+	}
>+
>+	return NULL;
>+}
>+
>+static int kvm_fwft_get_feature(struct kvm_vcpu *vcpu, unsigned long feature,
>+				struct kvm_sbi_fwft_config **conf)
>+{
>+	struct kvm_sbi_fwft_config *tconf;
>+
>+	/* Feature are defined as 32 bits identifiers */
>+	if (feature & ~(BIT_ULL(32) - 1))
>+		return SBI_ERR_INVALID_PARAM;
>+
>+	tconf = kvm_sbi_fwft_get_config(vcpu, feature);
>+	if (!tconf) {
>+		if (kvm_fwft_is_defined_feature(feature))
>+			return SBI_ERR_NOT_SUPPORTED;
>+
>+		return SBI_ERR_DENIED;
>+	}
>+
>+	if (!tconf->supported)
>+		return SBI_ERR_NOT_SUPPORTED;
>+
>+	*conf = tconf;
>+
>+	return SBI_SUCCESS;
>+}
>+
>+static int kvm_sbi_fwft_set(struct kvm_vcpu *vcpu, unsigned long feature,
>+			    unsigned long value, unsigned long flags)
>+{
>+	int ret;
>+	struct kvm_sbi_fwft_config *conf;
>+
>+	ret = kvm_fwft_get_feature(vcpu, feature, &conf);
>+	if (ret)
>+		return ret;
>+
>+	if ((flags & ~SBI_FWFT_SET_FLAG_LOCK) != 0)
>+		return SBI_ERR_INVALID_PARAM;
>+
>+	if (conf->flags & SBI_FWFT_SET_FLAG_LOCK)
>+		return SBI_ERR_DENIED_LOCKED;
>+
>+	conf->flags = flags;
>+
>+	return conf->feature->set(vcpu, conf, value);
>+}
>+
>+static int kvm_sbi_fwft_get(struct kvm_vcpu *vcpu, unsigned long feature,
>+			    unsigned long *value)
>+{
>+	int ret;
>+	struct kvm_sbi_fwft_config *conf;
>+
>+	ret = kvm_fwft_get_feature(vcpu, feature, &conf);
>+	if (ret)
>+		return ret;
>+
>+	return conf->feature->get(vcpu, conf, value);
>+}
>+
>+static int kvm_sbi_ext_fwft_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
>+				    struct kvm_vcpu_sbi_return *retdata)
>+{
>+	int ret = 0;
>+	struct kvm_cpu_context *cp = &vcpu->arch.guest_context;
>+	unsigned long funcid = cp->a6;
>+
>+	switch (funcid) {
>+	case SBI_EXT_FWFT_SET:
>+		ret = kvm_sbi_fwft_set(vcpu, cp->a0, cp->a1, cp->a2);
>+		break;
>+	case SBI_EXT_FWFT_GET:
>+		ret = kvm_sbi_fwft_get(vcpu, cp->a0, &retdata->out_val);
>+		break;
>+	default:
>+		ret = SBI_ERR_NOT_SUPPORTED;
>+		break;
>+	}
>+
>+	retdata->err_val = ret;
>+
>+	return 0;
>+}
>+
>+static int kvm_sbi_ext_fwft_init(struct kvm_vcpu *vcpu)
>+{
>+	struct kvm_sbi_fwft *fwft = vcpu_to_fwft(vcpu);
>+	const struct kvm_sbi_fwft_feature *feature;
>+	struct kvm_sbi_fwft_config *conf;
>+	int i;
>+
>+	fwft->configs = kcalloc(ARRAY_SIZE(features), sizeof(struct kvm_sbi_fwft_config),
>+				GFP_KERNEL);
nit:

I understand that in next patch you grow the static array`features`. But in this patch
`ARRAY_SIZE(features)` evaluates to 0, thus kcalloc will be returning a pointer
to some slab block (IIRC, kcalloc will not return NULL if size eventually evals to 0)

This probably won't result in some bad stuff. But still there is a pointer in
fwft->configs which is pointing to some random stuff if `features` turns out to be
empty.

Let me know if I got that right or missing something.

>+	if (!fwft->configs)
>+		return -ENOMEM;
>+
>+	for (i = 0; i < ARRAY_SIZE(features); i++) {
>+		feature = &features[i];
>+		conf = &fwft->configs[i];
>+		if (feature->supported)
>+			conf->supported = feature->supported(vcpu);
>+		else
>+			conf->supported = true;
>+
>+		conf->feature = feature;
>+	}
>+
>+	return 0;
>+}
>+
>+static void kvm_sbi_ext_fwft_deinit(struct kvm_vcpu *vcpu)
>+{
>+	struct kvm_sbi_fwft *fwft = vcpu_to_fwft(vcpu);
>+
>+	kfree(fwft->configs);
>+}
>+
>+static void kvm_sbi_ext_fwft_reset(struct kvm_vcpu *vcpu)
>+{
>+	int i = 0;
>+	struct kvm_sbi_fwft *fwft = vcpu_to_fwft(vcpu);
>+
>+	for (i = 0; i < ARRAY_SIZE(features); i++)
>+		fwft->configs[i].flags = 0;
>+}
>+
>+const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_fwft = {
>+	.extid_start = SBI_EXT_FWFT,
>+	.extid_end = SBI_EXT_FWFT,
>+	.handler = kvm_sbi_ext_fwft_handler,
>+	.init = kvm_sbi_ext_fwft_init,
>+	.deinit = kvm_sbi_ext_fwft_deinit,
>+	.reset = kvm_sbi_ext_fwft_reset,
>+};
>-- 
>2.47.2
>
>

