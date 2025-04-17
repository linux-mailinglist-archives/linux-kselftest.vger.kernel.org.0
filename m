Return-Path: <linux-kselftest+bounces-31058-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA56A91C09
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 14:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C88C3B5035
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 12:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3303124E012;
	Thu, 17 Apr 2025 12:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="XpBQMCuX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0A9247DF0
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Apr 2025 12:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744892738; cv=none; b=sLL4ScoCeGaGBDNOjIrqvYuiWHDqU+PPdAaCLTBpmiSJJ554dx2ubrp6Yp/q59PYwhtzht16gZryLr6icW5A+mg6dZ8RIP+IeF2lcgLLgxlUfbo0ohQNINV47LfurBCr8xUlpYQWHqZL0Dz15kWjiGGH5YFeZSpiudHfROCZeNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744892738; c=relaxed/simple;
	bh=H5I3SSDmXjwRUib3TL18xTg/rVQsrKqfiODBF/E5v6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G6oR3zGv5v7RaofrR1HDY4GYp1P3ghUosIxtvEARLOW/7scX57qvgHkY7N0gRBOm0sHDrIjYMum4nqEFZeWuZwVW9P+pNHU6BJf72gSTwKDVW11fB/lysS4n7HQR0cBe1zsbTqx8Oe+0E5ux++KS9s1116p1fHGLlyMubV9YAA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=XpBQMCuX; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-223fd89d036so8230075ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Apr 2025 05:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1744892736; x=1745497536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIWI5J13lSlmUc75M0Yyv1OmkFoJoZE6o7hXZ4HO9lg=;
        b=XpBQMCuXAyDB11UWoArkfLcN7EhswpqfbfknbC1ohQpeyaijdj8NnI7eNKYdG9SdJ9
         L5ieRIgVw3cebhF07DqstpRT60jXzn/bstssdCO5AwAI548ClCWIapyPKjIDNtn6424E
         jhByHaFEWxUltJn/l8wiawskYcErI32YJgpXwGwu/RC5a0qiWRHMrZ6hblXHkQHSxipe
         2g1XpCBRtGxG0U6q8xeou9KN5H2OhqyNt8mXzn/qvQyqrhYkZei5yR+vJeQQXucf2ghL
         RaM2O2D7rVqCB3I7kXt3OBeZviQVJS//NPTdcvv0ipFcdrDHHYY1iwtG83FS0F4OixOL
         c7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744892736; x=1745497536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RIWI5J13lSlmUc75M0Yyv1OmkFoJoZE6o7hXZ4HO9lg=;
        b=hjVBrxKkdSks5vAVYerEOv1MpW2VNLyX0k3MPobOty/mLpsjrANJlVI51LIVmedd26
         VADNZh/HjLLkQ8AZzNJwTZB/ToDmL0geS1/r6jzYMLLZssSYIZEl4B7l1YcdPemLJ90P
         Uo0sdXLZHr/fnzPuHqt94FoWtRq5hsiEheYGp6giOzFuY+CzQNK2VMwHs9ngAe/b8kZ0
         PTVbhCniUqO01ivDC9Vm+RNDwqdiDzDRCaCuyayNMN5wlKIbtB3UML2wg/aIc3NLpIy6
         snhq7nGH80zmHr5KCGF088oFLV/gMjXd9EU4+ot1uiOlv9Sstf6bosg4nP0A2/1pvBsa
         0vmw==
X-Forwarded-Encrypted: i=1; AJvYcCXbAX6CHdrKawZct2Nq7i4ix99u0TbzFrycosZkZrsCN5FuCh82y05a0DpE56wIlsJ4QJBguLX8DPq+ZUlRNbg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk7TiGa8sv4rEP7xsmyqSjiuNKwejyhb/56HFRm67hlLydAkAF
	d/KkJ7NVhJt8UWV3ShxR3gbILk68ME1Gwpjnd6JA0dAA9dwHl13ItZO4mwFOvsE=
X-Gm-Gg: ASbGncuvSTqy6NW4yT5pvf7KdogEu21UWQufnAkYUW6qxyBrsuxg4AQ4fwbbZ/6HEhQ
	v+pVS5ZG/BQ9jojaJ0Q7j5EgXsqDn3FeemX3+lilu4Y4tTniHX2KgMo/D8ecwXtTepUHGcVjNOk
	Rsyo962H1EiT9yZw2fwQ7/0QALmwT2/8cmST9drLJCMWSjEujYSNLdLeSded5E+Ezuydjku1xK/
	S/19q0YOBaw+12lWwLuO79BkkuHyduACIv73H4CbSk8VLcy63+dGPpBjin3tBi9AxDlDF93N/aF
	iDeXcedwdn+0I0L8ORrutwllqOF3Mf5NqEQ48TJ0Ng==
X-Google-Smtp-Source: AGHT+IH/XOfIZJN1QIMfxSpPHyEBOL2TQ9imzdZAMvoYmfc/2OhjJtEou81N2JqUbXrpk40zrfv2Kw==
X-Received: by 2002:a17:903:1905:b0:224:10b9:357a with SMTP id d9443c01a7336-22c359743ffmr95085905ad.32.1744892735913;
        Thu, 17 Apr 2025 05:25:35 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c3ee1a78dsm18489415ad.253.2025.04.17.05.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 05:25:35 -0700 (PDT)
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
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v5 11/13] RISC-V: KVM: add SBI extension reset callback
Date: Thu, 17 Apr 2025 14:19:58 +0200
Message-ID: <20250417122337.547969-12-cleger@rivosinc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417122337.547969-1-cleger@rivosinc.com>
References: <20250417122337.547969-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, only the STA extension needed a reset function but that's
going to be the case for FWFT as well. Add a reset callback that can be
implemented by SBI extensions.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/kvm_host.h     |  1 -
 arch/riscv/include/asm/kvm_vcpu_sbi.h |  2 ++
 arch/riscv/kvm/vcpu.c                 |  2 +-
 arch/riscv/kvm/vcpu_sbi.c             | 24 ++++++++++++++++++++++++
 arch/riscv/kvm/vcpu_sbi_sta.c         |  3 ++-
 5 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index 0e9c2fab6378..4fa02e082142 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -407,7 +407,6 @@ void __kvm_riscv_vcpu_power_on(struct kvm_vcpu *vcpu);
 void kvm_riscv_vcpu_power_on(struct kvm_vcpu *vcpu);
 bool kvm_riscv_vcpu_stopped(struct kvm_vcpu *vcpu);
 
-void kvm_riscv_vcpu_sbi_sta_reset(struct kvm_vcpu *vcpu);
 void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu);
 
 #endif /* __RISCV_KVM_HOST_H__ */
diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/asm/kvm_vcpu_sbi.h
index bcb90757b149..cb68b3a57c8f 100644
--- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
+++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
@@ -57,6 +57,7 @@ struct kvm_vcpu_sbi_extension {
 	 */
 	int (*init)(struct kvm_vcpu *vcpu);
 	void (*deinit)(struct kvm_vcpu *vcpu);
+	void (*reset)(struct kvm_vcpu *vcpu);
 };
 
 void kvm_riscv_vcpu_sbi_forward(struct kvm_vcpu *vcpu, struct kvm_run *run);
@@ -78,6 +79,7 @@ bool riscv_vcpu_supports_sbi_ext(struct kvm_vcpu *vcpu, int idx);
 int kvm_riscv_vcpu_sbi_ecall(struct kvm_vcpu *vcpu, struct kvm_run *run);
 void kvm_riscv_vcpu_sbi_init(struct kvm_vcpu *vcpu);
 void kvm_riscv_vcpu_sbi_deinit(struct kvm_vcpu *vcpu);
+void kvm_riscv_vcpu_sbi_reset(struct kvm_vcpu *vcpu);
 
 int kvm_riscv_vcpu_get_reg_sbi_sta(struct kvm_vcpu *vcpu, unsigned long reg_num,
 				   unsigned long *reg_val);
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 877bcc85c067..542747e2c7f5 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -94,7 +94,7 @@ static void kvm_riscv_reset_vcpu(struct kvm_vcpu *vcpu)
 	vcpu->arch.hfence_tail = 0;
 	memset(vcpu->arch.hfence_queue, 0, sizeof(vcpu->arch.hfence_queue));
 
-	kvm_riscv_vcpu_sbi_sta_reset(vcpu);
+	kvm_riscv_vcpu_sbi_reset(vcpu);
 
 	/* Reset the guest CSRs for hotplug usecase */
 	if (loaded)
diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
index 3139f171c20f..50be079b5528 100644
--- a/arch/riscv/kvm/vcpu_sbi.c
+++ b/arch/riscv/kvm/vcpu_sbi.c
@@ -536,3 +536,27 @@ void kvm_riscv_vcpu_sbi_deinit(struct kvm_vcpu *vcpu)
 		ext->deinit(vcpu);
 	}
 }
+
+void kvm_riscv_vcpu_sbi_reset(struct kvm_vcpu *vcpu)
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
+		if (scontext->ext_status[idx] != KVM_RISCV_SBI_EXT_STATUS_ENABLED ||
+		    !ext->reset)
+			continue;
+
+		ext->reset(vcpu);
+	}
+}
+
diff --git a/arch/riscv/kvm/vcpu_sbi_sta.c b/arch/riscv/kvm/vcpu_sbi_sta.c
index 5f35427114c1..cc6cb7c8f0e4 100644
--- a/arch/riscv/kvm/vcpu_sbi_sta.c
+++ b/arch/riscv/kvm/vcpu_sbi_sta.c
@@ -16,7 +16,7 @@
 #include <asm/sbi.h>
 #include <asm/uaccess.h>
 
-void kvm_riscv_vcpu_sbi_sta_reset(struct kvm_vcpu *vcpu)
+static void kvm_riscv_vcpu_sbi_sta_reset(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.sta.shmem = INVALID_GPA;
 	vcpu->arch.sta.last_steal = 0;
@@ -156,6 +156,7 @@ const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_sta = {
 	.extid_end = SBI_EXT_STA,
 	.handler = kvm_sbi_ext_sta_handler,
 	.probe = kvm_sbi_ext_sta_probe,
+	.reset = kvm_riscv_vcpu_sbi_sta_reset,
 };
 
 int kvm_riscv_vcpu_get_reg_sbi_sta(struct kvm_vcpu *vcpu,
-- 
2.49.0


