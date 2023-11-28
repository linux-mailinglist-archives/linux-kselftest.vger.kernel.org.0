Return-Path: <linux-kselftest+bounces-709-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A037FBD4D
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 15:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C50E61C20EC7
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 14:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5075C092;
	Tue, 28 Nov 2023 14:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="SR+B9bwQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774B510D4
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Nov 2023 06:54:18 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5bddf66ed63so3921829a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Nov 2023 06:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1701183258; x=1701788058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWjJzXo4ydUM1qBdZFj/A/LBdPnzjXBTEeDQn9bxklc=;
        b=SR+B9bwQXi1BDIf/KEeufLybH3ombV18cVXRQqpJImYLpG8SpO+cdSbaVDIqnQ2z84
         JLxtK+Wynfvo7HT3RPHaPeNVq1IGraDhjzk9PYH5I+QPmIjjeBz76mM0BLj3ZJEWGKMZ
         5emkb6wQAPk1p0MEFurduanGw9AI6Pt8s+mBDGdd4PuJrkRLJj0LZEIGn1KBXftxHaB2
         v0ZM5QIt/I8JhGLB5o/BGhfMGFBFzzyFJLRQotvpMz6FpTHlYUpE4P3k2Y8L9MtxOfu4
         SzJzILJYi2fMEC4+nbRwzoKTHpLHu75c/QblP+axsASgrroErSlhMupJTxipK3jTpdpR
         dyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701183258; x=1701788058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zWjJzXo4ydUM1qBdZFj/A/LBdPnzjXBTEeDQn9bxklc=;
        b=LUU9hO+v8IFW0tBtHcA9O90nnOlMCVBsbxO2k5Ilm9WSzMEWbPH2nrwVhDWqQnoDKX
         7U085VbUC+M22adI6H/e92hhK4+mQjilkGKAb6YE6lWSCiLhsPLhlPV1kPLjvweeemb0
         s+BIFYoZuafkWdJMt5Q5ounWv/gUgPSAtkgXQbtkLXVrtuBuUarH4K4jOe0VN+klFq0v
         POQhf3tPqe+7OnX76lJ3q3Jmyg8h3C88MIf1do7FWov0M0uirYBjvDVaFRVQEwaTOowG
         wdNd8FNWpMxYQBSlI1QTdxr3IG0v71s4riaDfjs1h4RpTMoU5lVQd0aprh0/UMIEQ2GT
         F4MQ==
X-Gm-Message-State: AOJu0YzC+Z81k2vhCa44SbcRhrlNrrQCsQ9SxJDoG+zwdClwd9gtf/3g
	Y7NSmJoU8a8FhAOBSslWVqoK6w==
X-Google-Smtp-Source: AGHT+IGxW136Vwz0iG0z8Bd+73y8peGGLL8YdmZ8vllqxs8AnDN8I+cKti2HazA7AW6wj4+a/QmmRQ==
X-Received: by 2002:a17:90b:4b0e:b0:285:b687:b831 with SMTP id lx14-20020a17090b4b0e00b00285b687b831mr14391825pjb.10.1701183257699;
        Tue, 28 Nov 2023 06:54:17 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e80b00b001bf11cf2e21sm10281552plg.210.2023.11.28.06.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 06:54:17 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Anup Patel <anup@brainfault.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	devicetree@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 02/15] RISC-V: KVM: Allow Zbc extension for Guest/VM
Date: Tue, 28 Nov 2023 20:23:44 +0530
Message-Id: <20231128145357.413321-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128145357.413321-1-apatel@ventanamicro.com>
References: <20231128145357.413321-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We extend the KVM ISA extension ONE_REG interface to allow KVM
user space to detect and enable Zbc extension for Guest/VM.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/uapi/asm/kvm.h | 1 +
 arch/riscv/kvm/vcpu_onereg.c      | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index 60d3b21dead7..518b368b41e5 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -139,6 +139,7 @@ enum KVM_RISCV_ISA_EXT_ID {
 	KVM_RISCV_ISA_EXT_ZIHPM,
 	KVM_RISCV_ISA_EXT_SMSTATEEN,
 	KVM_RISCV_ISA_EXT_ZICOND,
+	KVM_RISCV_ISA_EXT_ZBC,
 	KVM_RISCV_ISA_EXT_MAX,
 };
 
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index f8c9fa0c03c5..f789517c9fae 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -42,6 +42,7 @@ static const unsigned long kvm_isa_ext_arr[] = {
 	KVM_ISA_EXT_ARR(SVPBMT),
 	KVM_ISA_EXT_ARR(ZBA),
 	KVM_ISA_EXT_ARR(ZBB),
+	KVM_ISA_EXT_ARR(ZBC),
 	KVM_ISA_EXT_ARR(ZBS),
 	KVM_ISA_EXT_ARR(ZICBOM),
 	KVM_ISA_EXT_ARR(ZICBOZ),
@@ -92,6 +93,7 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
 	case KVM_RISCV_ISA_EXT_SVNAPOT:
 	case KVM_RISCV_ISA_EXT_ZBA:
 	case KVM_RISCV_ISA_EXT_ZBB:
+	case KVM_RISCV_ISA_EXT_ZBC:
 	case KVM_RISCV_ISA_EXT_ZBS:
 	case KVM_RISCV_ISA_EXT_ZICNTR:
 	case KVM_RISCV_ISA_EXT_ZICOND:
-- 
2.34.1


