Return-Path: <linux-kselftest+bounces-28102-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1557CA4CECA
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 23:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04BB516E829
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 22:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B9823F267;
	Mon,  3 Mar 2025 22:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="WdJuMiIk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE26239594
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Mar 2025 22:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741042395; cv=none; b=oLzuUlXnG3bQt1zEjTgyk9nRgKDDPD4dq793rd6Ph0KLbpzZEUnskn4eucqkslzQUj91GX7LjhrUZQPAMr4g4DZ2c0Q50urjR3dQ76un1A1Ii+3tXe2ufiTGEZXQSo3nCq0h/mmrOknVZd3PDSsWg7vIBzsWdPs88x9mQdNQIsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741042395; c=relaxed/simple;
	bh=DxQuXHMlgc7H5Iz7LRmGc2M8YCqPk4tOjdxPmN2FNfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ry0dQW4qkVxNDgAleRy3TcG11T+WgaNvl8up5Qauc5zTbvzYb1A19JKG6OikfHm5lE+NFEQ5yZpRMAs4NyhZFSlf93J4q/6FPasLag5mIJniXDf7cbDGMljI1HCQQdZxRcaTVMQv9BklX2/O6xgdDBUCXhuh0+9qPgF1qTMgq/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=WdJuMiIk; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2234e4b079cso90571265ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Mar 2025 14:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741042393; x=1741647193; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mugBhowmjHeOZ8voD78niLPk8kFDSWBL6lZCl8cn1Qg=;
        b=WdJuMiIkIs3pUQXpxz7Z9HmUtPvCC79mJk/occ7KYGG/aZdiOmBHRmCNJhdTOf3/ef
         ovpBWaFkZU/v2DMGUw9V6pXveZmqaYiGBC56j7XIAZad2ocyzUG4D6T6+hEk5gaP94Fw
         VsXkGx+7uzLOu6QNKgxQZDi4HxBscik0se8xvAPweYri0I7hRmHEPx0d0wqW2CcqCN/h
         N4o+RyBR5xgif1GKI770sWlsnhnzzyufnWMaoEritGhZ29py8V5tvja0pu0oehAjlZy+
         7I/spmdEj4WD2ny8Xc1m55EZRBYIwT6a33H+8dc1T906V1Jmn7Qk8d7bPbSMbFd/dkTJ
         xihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741042393; x=1741647193;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mugBhowmjHeOZ8voD78niLPk8kFDSWBL6lZCl8cn1Qg=;
        b=rhFZ4FX8693d7Ns5Aywdt4peBuDl10Km/hf9sAjJlbts9424prqTofG0d2xQLTnT62
         qJ350zsN/aNd4XWjHsUNWgLIgKHu6Xkm2dO9FRcNK0cGi4zpgan8QIMMrnln5+gVlJX7
         FUjEtTf88LIJsT06HKvX/Xz0aS9BWvQXvQWUe68Bdu8M2mtOGcYXk2eoyRD1qBbCsGGB
         iPKozbTbIH8E0mlIN+7S1lc7rkmgq3OI60lz0nEADv4VePVWrw1/SEBBXL9y2gXXD0Rs
         r4HPurZKtkteqdqxtab+mluH/41n3nKvC/4TzjqBo9KC7mQQqoKGX2BU6HAhvlZkhszF
         yS2w==
X-Forwarded-Encrypted: i=1; AJvYcCU0jlK8yMu8s0DDt9ikmnzqVRGuHDcOAmEKQ1GKT9cA1lSRwqFMpWVE+IePfSRiR1lA+7oB7ySV6bALQs1zXiI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz02TObtsYO8SUxVx+c65MXyKxZ5+QW3mOckNvDdtepMna9134U
	Oc/eBwXu0j7ZcL5Ot9wkOKyGSbPNHNDiip1x7xmqZSIFc8NlynPJPn3lml91sX4=
X-Gm-Gg: ASbGncsTIRSEZt7uAwh/hpXVevkY9WCLwcdQg9NAkS+7mVeYMDW2ypbooAfNeLFc8H1
	PxddqRx16IDnjZfCGdPordPUTu7KuVB8xCfeYk9ZwQBVNpUsWUtbKeaqmtQuJKNSzv72vplG4jy
	q+SQ8LqLlCzh2K3AYVUZ1NrUx0TEAOkn+lo+xB3Rf1VkdivOHlTJTtxD0sF3kicASit851NXBsr
	YjO169MBuBdJ+HRCFaLGZ+/u60Xb2pQfqaNchC2pUxzRs+qwq2FXF8We4ZUsPMn4effX7PnlqxR
	eoHQocdd8yZ+RJCTNi5zOwiFIKx63Tcg4YmGIsftO7bxS83t0pIDDVsOuw==
X-Google-Smtp-Source: AGHT+IGcN7KmSzWUc3x2Q9hIKcCxmrhzor1ESo6ey42ZNpnLuX0uKU0+qCp3SXFy7hHj8nlBIEN6rA==
X-Received: by 2002:a05:6a00:240c:b0:732:2170:b68b with SMTP id d2e1a72fcca58-734abee4a68mr22681643b3a.0.1741042393072;
        Mon, 03 Mar 2025 14:53:13 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a003eb4fsm9440601b3a.129.2025.03.03.14.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 14:53:12 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Mon, 03 Mar 2025 14:53:06 -0800
Subject: [PATCH v2 1/4] RISC-V: KVM: Disable the kernel perf counter during
 configure
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-kvm_pmu_improve-v2-1-41d177e45929@rivosinc.com>
References: <20250303-kvm_pmu_improve-v2-0-41d177e45929@rivosinc.com>
In-Reply-To: <20250303-kvm_pmu_improve-v2-0-41d177e45929@rivosinc.com>
To: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Andrew Jones <ajones@ventanamicro.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-42535

The perf event should be marked disabled during the creation as
it is not ready to be scheduled until there is SBI PMU start call
or config matching is called with auto start. Otherwise, event add/start
gets called during perf_event_create_kernel_counter function.
It will be enabled and scheduled to run via perf_event_enable during
either the above mentioned scenario.

Fixes: 0cb74b65d2e5 ("RISC-V: KVM: Implement perf support without sampling")

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/vcpu_pmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index 2707a51b082c..78ac3216a54d 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -666,6 +666,7 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned long ctr_ba
 		.type = etype,
 		.size = sizeof(struct perf_event_attr),
 		.pinned = true,
+		.disabled = true,
 		/*
 		 * It should never reach here if the platform doesn't support the sscofpmf
 		 * extension as mode filtering won't work without it.

-- 
2.43.0


