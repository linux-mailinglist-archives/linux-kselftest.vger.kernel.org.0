Return-Path: <linux-kselftest+bounces-31579-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF61A9B54B
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 19:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E1411B6792A
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 17:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C23928EA77;
	Thu, 24 Apr 2025 17:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="HYxIFLWD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2327928EA50
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 17:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745516055; cv=none; b=Br6TVTTRUdX/NT1pKi/lGKjJB3UbqCFtFgA/+EZbdjGk24YbBskcfvuBYJmazbtOdubb+sS6560lB0xsUDtljH++pG8i6LlStYPdxJPOO/G/JGgl1kHYk3ChO9TdWqWFTHIxLlCLxuS3ZuCbLYSq4qhKc8wQPOv2Ewg5PhH0sek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745516055; c=relaxed/simple;
	bh=4KKxaT4YbiMX7RMDjwNA7B7kFRjG+KUrG1SV+mETLMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lp1K9dia80ZWcfW6Z0NBfEveDIIm+9gQKqJl5MzOV1tWFm1MPt2GPuHGXDzNq+gHT9zrsGn5dNtw4MoHu4/3Y3RjrbXVzMeegAefshW+szEKuhbDWOImPCs32ydvH7wJOelCfL0fpoAcf6KlZx5LLVZWXRyMpE+24yGP+2zPZYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=HYxIFLWD; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-223fd89d036so17369895ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 10:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745516052; x=1746120852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvBBsjj+z7fvXIiV8XNjx2EbWr7FpMlve2V3rRwX9go=;
        b=HYxIFLWDGWb1b5A5HS0G2BdVtNK/UIDYiMrtfAXgk7oErx/DFK7LO28/3faj3VqCld
         ZTkq20eJQiLbQwG0TdUryAdwSaG6WJHcqz2nVCldu26RFhRuwPLaBaFY8h8onkYrf+1v
         motQw/Vk5iZE8xZFXI9Fyzm6wDWY3reH4Y2DMoOQLbrpkXzMw/fnw7lAOiexNeWO5Cly
         URcADGRYIcBe0r3m0QRoPB2IeuVx/wQtPb3QKINEGqpgFwgnWRSHW5QntJ56IMBpI4cJ
         oq0nV4QI9niQcALRBb6fKTc4o98Tzi+Gh8plGLttAmAjxFW2DYKwWBR7+3d/Al5Lc+Hd
         n3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745516052; x=1746120852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DvBBsjj+z7fvXIiV8XNjx2EbWr7FpMlve2V3rRwX9go=;
        b=sQe9wfIXaE7klPoqGoTLMo8hszKH7Zvu3OlbE2OoDntCbbKtJXcnBIvnnKxsAMWhmk
         jwRQFUfN9x27tB+/qzS2GR6qfwZdFtbjb072Kevi009DYgHMrlzs87Ga7TF+dipJL9Bc
         imP+m38vRsTTGGhdvi+tcwFd7Vdz7CFKnyXWfZsLxTACrV51JKyxbzrsz6DbVTwVi36X
         CFux2kFqb/WdUSK9AQR4nTcyc/fmxcZSCnbpNJkCUaVYvWWj+Ij/x3hDHC1oPWUhPR4i
         rzFjfJurOMoFvH92wx+hluYxtUaoFrYIoSWNm1d9WnHnCHHYlwCjjtZktHQrI42T6yQK
         ddFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWh0Nvy2PXTKpCY1Wx1vyeEl40eWQHgm+RPSx6xOVp6T4o/d9coF9tcfSWgMg9rHLSN6QyaR+qvSNf2LHN19dw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4gYbSO4uxT0cY3AtUNbXO8raSCbGoR0tUu8ZhB6aFQAwR7KQZ
	QXTsH+SAfZ/uXC6Z4qydHJRrjwa/qMWiAChaT/LPFCsfNlziCEtLbOlr0PT1Au4=
X-Gm-Gg: ASbGncu/NtFRrqAblt7IoiH0tGM2QoL8OKBjXXvrd5ppg6fuNmOpNpHAANPW/1/ynY3
	zRgtaJKKr29/iJqI1kxWETEH9BPJ+9flqJbQE28eKRIISdFW0Amg2SsLna+sxoUhCbhpT4jYxav
	WugdaHtZr/0I4jnLWxHAEWq6n7hIIrfGQZ9ut7H8HdExF80b7oEKi0o7tRV1d5y3Q0+gJyHXjba
	3XsjCkOlvSc5TNfmq1UmTJMITNeffGdijlihV5wUxuLGegRMvo15oC8KaQTdgypum12WPFf1PZV
	wqS1MDq5mywzeZEgsp8QtdyJ7el6MScI3p8rsE2PYg==
X-Google-Smtp-Source: AGHT+IGUt7NQqfqeO0namSyIMn7maNYN8P7cnVATP91mLdDbfQJ5Gas+mViREoMG88x9kDoZBx7Z4g==
X-Received: by 2002:a17:903:3c46:b0:21c:fb6:7c3c with SMTP id d9443c01a7336-22dbd412142mr4560165ad.17.1745516052316;
        Thu, 24 Apr 2025 10:34:12 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5100c4esm16270255ad.173.2025.04.24.10.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 10:34:11 -0700 (PDT)
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
	Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v6 04/14] riscv: sbi: add FWFT extension interface
Date: Thu, 24 Apr 2025 19:31:51 +0200
Message-ID: <20250424173204.1948385-5-cleger@rivosinc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424173204.1948385-1-cleger@rivosinc.com>
References: <20250424173204.1948385-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This SBI extensions enables supervisor mode to control feature that are
under M-mode control (For instance, Svadu menvcfg ADUE bit, Ssdbltrp
DTE, etc). Add an interface to set local features for a specific cpu
mask as well as for the online cpu mask.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/sbi.h | 17 +++++++++++
 arch/riscv/kernel/sbi.c      | 57 ++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 7ec249fea880..3bbef56bcefc 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -503,6 +503,23 @@ int sbi_remote_hfence_vvma_asid(const struct cpumask *cpu_mask,
 				unsigned long asid);
 long sbi_probe_extension(int ext);
 
+int sbi_fwft_set(u32 feature, unsigned long value, unsigned long flags);
+int sbi_fwft_set_cpumask(const cpumask_t *mask, u32 feature,
+			 unsigned long value, unsigned long flags);
+/**
+ * sbi_fwft_set_online_cpus() - Set a feature on all online cpus
+ * @feature: The feature to be set
+ * @value: The feature value to be set
+ * @flags: FWFT feature set flags
+ *
+ * Return: 0 on success, appropriate linux error code otherwise.
+ */
+static inline int sbi_fwft_set_online_cpus(u32 feature, unsigned long value,
+					   unsigned long flags)
+{
+	return sbi_fwft_set_cpumask(cpu_online_mask, feature, value, flags);
+}
+
 /* Check if current SBI specification version is 0.1 or not */
 static inline int sbi_spec_is_0_1(void)
 {
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 1d44c35305a9..d57e4dae7dac 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -299,6 +299,63 @@ static int __sbi_rfence_v02(int fid, const struct cpumask *cpu_mask,
 	return 0;
 }
 
+/**
+ * sbi_fwft_set() - Set a feature on the local hart
+ * @feature: The feature ID to be set
+ * @value: The feature value to be set
+ * @flags: FWFT feature set flags
+ *
+ * Return: 0 on success, appropriate linux error code otherwise.
+ */
+int sbi_fwft_set(u32 feature, unsigned long value, unsigned long flags)
+{
+	return -EOPNOTSUPP;
+}
+
+struct fwft_set_req {
+	u32 feature;
+	unsigned long value;
+	unsigned long flags;
+	atomic_t error;
+};
+
+static void cpu_sbi_fwft_set(void *arg)
+{
+	struct fwft_set_req *req = arg;
+	int ret;
+
+	ret = sbi_fwft_set(req->feature, req->value, req->flags);
+	if (ret)
+		atomic_set(&req->error, ret);
+}
+
+/**
+ * sbi_fwft_set_cpumask() - Set a feature for the specified cpumask
+ * @mask: CPU mask of cpus that need the feature to be set
+ * @feature: The feature ID to be set
+ * @value: The feature value to be set
+ * @flags: FWFT feature set flags
+ *
+ * Return: 0 on success, appropriate linux error code otherwise.
+ */
+int sbi_fwft_set_cpumask(const cpumask_t *mask, u32 feature,
+			       unsigned long value, unsigned long flags)
+{
+	struct fwft_set_req req = {
+		.feature = feature,
+		.value = value,
+		.flags = flags,
+		.error = ATOMIC_INIT(0),
+	};
+
+	if (feature & SBI_FWFT_GLOBAL_FEATURE_BIT)
+		return -EINVAL;
+
+	on_each_cpu_mask(mask, cpu_sbi_fwft_set, &req, 1);
+
+	return atomic_read(&req.error);
+}
+
 /**
  * sbi_set_timer() - Program the timer for next timer event.
  * @stime_value: The value after which next timer event should fire.
-- 
2.49.0


