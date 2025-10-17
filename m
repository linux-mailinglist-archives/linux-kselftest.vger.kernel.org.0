Return-Path: <linux-kselftest+bounces-43387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 563F5BEA70E
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 18:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5660119A227F
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 16:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A29336ECD;
	Fri, 17 Oct 2025 15:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="SHeU5cES"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D624336EC0
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 15:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716789; cv=none; b=p/MAlOV6DoF09O85jSEq4TtbSR3Pyr+w+60PcNB+sNXwKNWqeSt+fXM03X24PlaglDqt2rK8hsJGZCvz8kfaDVyUTl0N921jlbWSd1VbhxOwfiJfn2ZqpVnjhL/DhJBe6L+13V/7pOLipgrg/5Is4DLwqoy4qgza3fN9bMeefv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716789; c=relaxed/simple;
	bh=VauSt0uAycrcY3nlPmUv8mw69nRyhNX8TjKVsezUOqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZzXvNWnZKyIlV9E1BCgWq4wPIExHRCq9iY08ND8eBD2G+gPQvRZ2Q6xhr+EeTttWMXHKK4iVL2SBR/cebkcOn8+LeXHPt9yq17vGq+RGqXd6QJgN315FFyWvsBb73nkrhNUGbLAn527FHt4pUbSr5rAZKRzPZt8J5X+L9bUf9f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=SHeU5cES; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-782023ca359so2140906b3a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 08:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760716787; x=1761321587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YO6UzdALBp15BcoYG5LkyhqHChXHZ3HPbY8ifkU6tw=;
        b=SHeU5cESp/bYhZx31CNpfGT035STe6p9kMQbJ+o32xJna8Kf0r7JVHCynygGgm8LJA
         TMusansS/ctst5/OQD0Fntnsi1pnxm9iXYpxxwzJCR2V11XEULG3zEtr6gbhyC/VAISY
         /MMMO5M68MVRPJ+7/g55+LS28t4220ZP3ufvrM6XEHUG/Z0SWdcECMtl1ELETt8D7myK
         vjdSaTIhoIHtcZ8GYDQ9N0+ZYhDWMxjfLzFdJ2i8jm+UQbR1OKNxAYCqJ6kbHpTeyqY4
         jknSjvahBsRMQ+aZjGOpjFPBTCIPkZKhOovtcx6gtiFHZA9RsEUoogH30LgTUS6YFDEQ
         bP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760716787; x=1761321587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7YO6UzdALBp15BcoYG5LkyhqHChXHZ3HPbY8ifkU6tw=;
        b=PNZ59qhyARd43sKzf0eMcUtEXH8XrNa+V1cDSq6iB+o+BHlEn8ypYSzYzSf8Hye2hI
         sPHUvjtLR+S8P6geLul9RL87eaK6GaMOdsv5k9ocIGb7eGcQDXPsRyqyJgX7lk7zva/h
         NVCVHwKKI8manjOaZ+ple1h+wIStM13P7bWLjWY+EM20EspnBKCcEEPKQknPg8r9o/88
         Pt3fTIWI6lIB+N8G82vy0K77ZdaRLF4J3cQa0QaxasBolBkiO1Hdpt6rz3DjvGwZMlzq
         lnRTAYkTllYuBgOP+GtDqGsybQhX8Zv4DsHhXFUXKEtPPqAzVJS1UtlwjYmo5m839mZR
         eLvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUmiiWiFyQpE1N0+VMdoiii3rspmECaFK1kneGkCSP8uA92+0m52mf7mMAxgxOM/p74QGWc0tptD66L6h7b94=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoBInNGoQiGwapoc/BLUvZ5GDkvJi/7u89zZeTAZyx6/bKqW24
	vz3BnReWihii4dFOCSOrikeRPECj96M159JbUd8Sf5QMdCiUqG2TJ/T3N+8WC4UI2Uc=
X-Gm-Gg: ASbGnculjGc873foVqgt4ON6+YKt+iAcLdOETo7Yia7fQ4QQ7NxVOhukkdqxu7KBEQX
	0zbAk4GVtwrui/ql+ymtskb34DLR7Y7pFTNdCkDCXM+1o8FoE/8R+KvGCFUQoT1Ca2uRuzKFjRM
	SWn4Rp8TNf80ZFkYvgYbcprvLb+NqPHEBou7ZyiGWlKmswqi10eMfWmAZhZ8yIl3a6Wc/L8MDBu
	x795ogXRDO7C3qEekkizGda1KT3OL8z9HHY4SkTb8yTJKhZOdCj37U3GYoX+J9kBGBarYIanomk
	GTqXEpH06lFxsyFS81pFOnrWbR2SZxenUm5VbpgtfzzMp0HHURMu5tMwOTTBOkJlTQZfUR0VazB
	hxpxMET2hwWwxV6Wp2rz8JiGllJ/SVTdgEHWfETbP5Ir+w22qtpxU53rwBs544bslYw+vEymvOK
	KnTnOramWKDgLkMCY+VWjE/ib0kz6VFIUxvhDfSWQO6nvu5mROEF92fw==
X-Google-Smtp-Source: AGHT+IGyl9gTUlhqKvf7bWFyXToKYsATj7SdvLFGZ0eSD3zQLgSjQNxd1CMPXeNXJkwX2bLubLMF4Q==
X-Received: by 2002:a05:6a21:9997:b0:334:9e5e:c2c2 with SMTP id adf61e73a8af0-334a84c81famr5765358637.13.1760716785208;
        Fri, 17 Oct 2025 08:59:45 -0700 (PDT)
Received: from localhost.localdomain ([122.171.18.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a7669392csm151067a12.18.2025.10.17.08.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 08:59:44 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 2/4] RISC-V: KVM: Add separate source for forwarded SBI extensions
Date: Fri, 17 Oct 2025 21:29:23 +0530
Message-ID: <20251017155925.361560-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017155925.361560-1-apatel@ventanamicro.com>
References: <20251017155925.361560-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a separate source vcpu_sbi_forward.c for SBI extensions
which are entirely forwarded to KVM user-space.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/kvm/Makefile           |  1 +
 arch/riscv/kvm/vcpu_sbi_base.c    | 12 ------------
 arch/riscv/kvm/vcpu_sbi_forward.c | 27 +++++++++++++++++++++++++++
 arch/riscv/kvm/vcpu_sbi_replace.c |  7 -------
 4 files changed, 28 insertions(+), 19 deletions(-)
 create mode 100644 arch/riscv/kvm/vcpu_sbi_forward.c

diff --git a/arch/riscv/kvm/Makefile b/arch/riscv/kvm/Makefile
index 07197395750e..3b8afb038b35 100644
--- a/arch/riscv/kvm/Makefile
+++ b/arch/riscv/kvm/Makefile
@@ -27,6 +27,7 @@ kvm-y += vcpu_onereg.o
 kvm-$(CONFIG_RISCV_PMU_SBI) += vcpu_pmu.o
 kvm-y += vcpu_sbi.o
 kvm-y += vcpu_sbi_base.o
+kvm-y += vcpu_sbi_forward.o
 kvm-y += vcpu_sbi_fwft.o
 kvm-y += vcpu_sbi_hsm.o
 kvm-$(CONFIG_RISCV_PMU_SBI) += vcpu_sbi_pmu.o
diff --git a/arch/riscv/kvm/vcpu_sbi_base.c b/arch/riscv/kvm/vcpu_sbi_base.c
index ca489f2dfbdf..06fdd5f69364 100644
--- a/arch/riscv/kvm/vcpu_sbi_base.c
+++ b/arch/riscv/kvm/vcpu_sbi_base.c
@@ -70,15 +70,3 @@ const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_base = {
 	.extid_end = SBI_EXT_BASE,
 	.handler = kvm_sbi_ext_base_handler,
 };
-
-const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_experimental = {
-	.extid_start = SBI_EXT_EXPERIMENTAL_START,
-	.extid_end = SBI_EXT_EXPERIMENTAL_END,
-	.handler = kvm_riscv_vcpu_sbi_forward_handler,
-};
-
-const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_vendor = {
-	.extid_start = SBI_EXT_VENDOR_START,
-	.extid_end = SBI_EXT_VENDOR_END,
-	.handler = kvm_riscv_vcpu_sbi_forward_handler,
-};
diff --git a/arch/riscv/kvm/vcpu_sbi_forward.c b/arch/riscv/kvm/vcpu_sbi_forward.c
new file mode 100644
index 000000000000..dbfa70c2c775
--- /dev/null
+++ b/arch/riscv/kvm/vcpu_sbi_forward.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Ventana Micro Systems Inc.
+ */
+
+#include <linux/kvm_host.h>
+#include <asm/kvm_vcpu_sbi.h>
+#include <asm/sbi.h>
+
+const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_experimental = {
+	.extid_start = SBI_EXT_EXPERIMENTAL_START,
+	.extid_end = SBI_EXT_EXPERIMENTAL_END,
+	.handler = kvm_riscv_vcpu_sbi_forward_handler,
+};
+
+const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_vendor = {
+	.extid_start = SBI_EXT_VENDOR_START,
+	.extid_end = SBI_EXT_VENDOR_END,
+	.handler = kvm_riscv_vcpu_sbi_forward_handler,
+};
+
+const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_dbcn = {
+	.extid_start = SBI_EXT_DBCN,
+	.extid_end = SBI_EXT_DBCN,
+	.default_disabled = true,
+	.handler = kvm_riscv_vcpu_sbi_forward_handler,
+};
diff --git a/arch/riscv/kvm/vcpu_sbi_replace.c b/arch/riscv/kvm/vcpu_sbi_replace.c
index 2c456e26f6ca..506a510b6bff 100644
--- a/arch/riscv/kvm/vcpu_sbi_replace.c
+++ b/arch/riscv/kvm/vcpu_sbi_replace.c
@@ -185,10 +185,3 @@ const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_srst = {
 	.extid_end = SBI_EXT_SRST,
 	.handler = kvm_sbi_ext_srst_handler,
 };
-
-const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_dbcn = {
-	.extid_start = SBI_EXT_DBCN,
-	.extid_end = SBI_EXT_DBCN,
-	.default_disabled = true,
-	.handler = kvm_riscv_vcpu_sbi_forward_handler,
-};
-- 
2.43.0


