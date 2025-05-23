Return-Path: <linux-kselftest+bounces-33638-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDE0AC2108
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 12:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA1B13ABBFD
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 10:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0413923237B;
	Fri, 23 May 2025 10:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="CcEbbbNh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA73229B16
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 10:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747995787; cv=none; b=L2NXWIpblXqxZ0PfxCtU0Loq5n8IpIHQ/NEuJIxhOagCy2XO2livDtc3Sf0OAg6vbXyY1kTVfbrHnrzCOZkYzGA/2XqnXGABqlkywgataRYQKCDTTQMRIzTHfugrTFGhkp7XkAKJybfHJ9kPFOWLVkwBwF9md8edYZ8idlAc5ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747995787; c=relaxed/simple;
	bh=e9Zv6MyOruJNuSW+pX4lrxjbHhF9mFEMsBWjimF3ZhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OhQ8fL3mrOvD4vZ2PGOaoDoEXGNVq4QZ3td4Qpha6iQJ4MPeN2gCdMqciuPzUCXooIVdSun5YBxriZ8lyrJ98AqMWyORzYaO2+k4S7sgEoNHeziqNJ9nRWZy/w29Hi+8WKN96JFGPz95Lqbch2WPIO+Z2K38IARfVDi9EFIe7NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=CcEbbbNh; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso8607595b3a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 03:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747995785; x=1748600585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jL4iC9TbsUd0FaNofW/nJkV1WGoug0A9XRZElPbt0BQ=;
        b=CcEbbbNhQGus+iKvllfw3GK8En6ZEWuRu55e/YIyBKPXS24kKr3xODUWbPA8mziPUQ
         pCBM0Fq/B3ZY+OtvPZbPoZ89q9vd+32U3DkTpai0gT3XzaoY0UgCQswJgULjOokz4+t9
         01YWLDvldc9TaVkfp/7Mjp7Be7TCWjXW5a2AHRsWLt2SaPPOp4l72n1n/XDJfBk1eERt
         vX7byG29q1Skn2LFm0Zi1MfKezDnKYWEGrD6DaEYtFVpXWLAOk6uXo8VBhZmsdZHYBv3
         W3PVaPEpmTWaRRViJCRi+lO3cuJMgFXJpDAA8WIiDc6vdKn0VT95UZgiTKxSoTOTi/a9
         NDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747995785; x=1748600585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jL4iC9TbsUd0FaNofW/nJkV1WGoug0A9XRZElPbt0BQ=;
        b=ZOqKrw2QWjwbKd6SOgmbY0MC65FeOSZKmqQ2jnFBMmb+8USDCB7c/4jNNBZL4Xyt42
         +KpzRXuAQCKmi1yOeI8uD2sXG/KVXcDBt3sWJfIGKWvB3e8eOvaVQJEyxpcGETCFdowT
         H8g7xSIVtgStIcg095FWXi10TDOFJ/nHRjrONDV3/PwNYsb3Edex0FwObdoRsFnUcfVo
         brvOPREkWDMPaZsLFFTm6v/n0Ru0JxBlltfo3D81me2tlOWQhhXYmqbRTQ+sspgXMZXV
         lTmyAEyT7HFvYqExs1tH7VHW4TqkebcY807v2Hth4Eu8kO4O9NGka0wN/np4FPaeqC8E
         prYw==
X-Forwarded-Encrypted: i=1; AJvYcCV0oNJW6b4waa7giok3pWOcV9aNds8fXqx6mzpF2370riKK6gWWvY86VKszpZZoqEJjPowQElJlp1V4EsZ2uYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzus8LD9Us8TMupgjVJ4O4l7F2gf1QMNEZu/xZ8B1Uy0aF66rik
	4eWqU1E06siUXjO6UmmlBGstjvv2JxkXY2QOkQMQhoR+5LrunnkjoJg5TUIzqH0+mD1b4eLr/qi
	69AqLGXg=
X-Gm-Gg: ASbGncsVWqFfh0ATB0+JzIehROEyDXVGjtr591fjjjJM3uoXAIGIu9vwAnkYMkPkIfZ
	CahMDN17kXi7BPLmj5dvXTwPFabiYoUvXmM/NDfwZHOKL95SWTc50lzV/p1yIOTSczo+ATa4bQO
	sQ9b1gUimMH6xdPD+q1hdNjZsqxymWG2jrmznKdQxs7uN5SNyFJf/ke8YbwZ5hTdzVFhrgSi13i
	D+FIBVrDJKE/SA210Enp3g6i4Z0l9ZKrrto00lrXRN3IcC/CmKh4PWa8UorMCEhH9dvJ2rlvwgF
	89GnEnrQPQOzvNr7G/xoexTw48mld5cd7Ix7Qzh0/nwinhfqrKcn
X-Google-Smtp-Source: AGHT+IEbv4B8UCIzN6nDmsaNwoV85BuQ6Mp+F2TMaxmDctRPfjMepLlOopoKzZHjGeALummtngi9+Q==
X-Received: by 2002:a05:6a00:98d:b0:736:34a2:8a23 with SMTP id d2e1a72fcca58-745ed8f5d5bmr3385811b3a.15.1747995785079;
        Fri, 23 May 2025 03:23:05 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829ce8sm12466688b3a.118.2025.05.23.03.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 03:23:04 -0700 (PDT)
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
	Andrew Jones <ajones@ventanamicro.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v8 14/14] RISC-V: KVM: add support for SBI_FWFT_MISALIGNED_DELEG
Date: Fri, 23 May 2025 12:19:31 +0200
Message-ID: <20250523101932.1594077-15-cleger@rivosinc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250523101932.1594077-1-cleger@rivosinc.com>
References: <20250523101932.1594077-1-cleger@rivosinc.com>
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
Reviewed-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/vcpu_sbi_fwft.c | 41 ++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwft.c
index b0f66c7bf010..6770c043bbcb 100644
--- a/arch/riscv/kvm/vcpu_sbi_fwft.c
+++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
@@ -14,6 +14,8 @@
 #include <asm/kvm_vcpu_sbi.h>
 #include <asm/kvm_vcpu_sbi_fwft.h>
 
+#define MIS_DELEG (BIT_ULL(EXC_LOAD_MISALIGNED) | BIT_ULL(EXC_STORE_MISALIGNED))
+
 struct kvm_sbi_fwft_feature {
 	/**
 	 * @id: Feature ID
@@ -68,7 +70,46 @@ static bool kvm_fwft_is_defined_feature(enum sbi_fwft_feature_t feature)
 	return false;
 }
 
+static bool kvm_sbi_fwft_misaligned_delegation_supported(struct kvm_vcpu *vcpu)
+{
+	return misaligned_traps_can_delegate();
+}
+
+static long kvm_sbi_fwft_set_misaligned_delegation(struct kvm_vcpu *vcpu,
+					struct kvm_sbi_fwft_config *conf,
+					unsigned long value)
+{
+	struct kvm_vcpu_config *cfg = &vcpu->arch.cfg;
+
+	if (value == 1) {
+		cfg->hedeleg |= MIS_DELEG;
+		csr_set(CSR_HEDELEG, MIS_DELEG);
+	} else if (value == 0) {
+		cfg->hedeleg &= ~MIS_DELEG;
+		csr_clear(CSR_HEDELEG, MIS_DELEG);
+	} else {
+		return SBI_ERR_INVALID_PARAM;
+	}
+
+	return SBI_SUCCESS;
+}
+
+static long kvm_sbi_fwft_get_misaligned_delegation(struct kvm_vcpu *vcpu,
+					struct kvm_sbi_fwft_config *conf,
+					unsigned long *value)
+{
+	*value = (csr_read(CSR_HEDELEG) & MIS_DELEG) == MIS_DELEG;
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
2.49.0


