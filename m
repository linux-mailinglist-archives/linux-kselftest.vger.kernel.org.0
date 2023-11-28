Return-Path: <linux-kselftest+bounces-717-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6107FBD68
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 15:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2076FB21FDE
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 14:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DB65C095;
	Tue, 28 Nov 2023 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="LRdjJD1A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD3C212A
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Nov 2023 06:55:01 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cfc34b6890so20621205ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Nov 2023 06:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1701183300; x=1701788100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5JCc1y7hChZCMhp/0UYXh4hGb5WFeFKUHk/se+Qy3o=;
        b=LRdjJD1Ap5Jq2lae5f5/XxeSz3kLdt4pslDFekE2C0WptfSmQI//f5159W8OLWCdkA
         BYnHOMosHX+qekqXaruqY37QiTQKpyqZgj83XrYQPqIZ9++USpNFyvbQpww80uOMSv4T
         w2pDsj86dOhCN7OxVhzkUoifZw43xXr4gINdtW5UHPwUuHXmB7z3D8nsWZ/eicCTopUR
         NsQeuC9+U1ag91S0+rrt4wvcSN6QtMNCiofAMZcDf6FBeeI0zUETVWCC8MvCCvDODPNW
         2TMAkc9NO4cKCKqYHul4qR7vUf8PfBYyLBrkHo6CJQdH0opSvfzgv9OofABBCl04mfaY
         UTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701183300; x=1701788100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5JCc1y7hChZCMhp/0UYXh4hGb5WFeFKUHk/se+Qy3o=;
        b=f7swFL7gtpSX23OWxngRlf/KfxJAhb8kGZ4rGivUQNq+pITOJOUotrJ1gpjnrSOchE
         1JP/K3JBPPVDVQe6rbPxaAAd60q9cg9hw75SfhxG90Rg/B5PwZfIY2oLEdnc38kFJCRY
         P8fNL6OgfNj2Wu+mnHWffCHrxT+LyYGd48K8KDhgNbuDEKdtDlLkf3/mPdiqHgt/i59m
         7EAu4Uj2wjdUAFM7Q3PTEepit9uVyB0XicZD6IhQaEJwjXJSG0gCoiONuMoKvGtRxAn3
         x+1n+lpoS/r/fElfeIAovscf6Te5FqrX9VrJu4vlivDAwRJ92Xg7Wc+topqZkPf0hcO9
         T6LQ==
X-Gm-Message-State: AOJu0Yz2TXEZipioOBTYsP7mLLtZoF79UTmjd/CoUINzMg+g3kymjZjC
	xExIyIHAfeOwdXfMFJBa0iEuvA==
X-Google-Smtp-Source: AGHT+IFHvz2KJ2Ptp4VuMdWWkjIvpDtHxQBvBlRtVm0cv6eOX2vsedmq5SV8bJu7+77gjoAbna9mJQ==
X-Received: by 2002:a17:903:24c:b0:1cf:7e39:feb with SMTP id j12-20020a170903024c00b001cf7e390febmr26796386plh.23.1701183300534;
        Tue, 28 Nov 2023 06:55:00 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e80b00b001bf11cf2e21sm10281552plg.210.2023.11.28.06.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 06:55:00 -0800 (PST)
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
Subject: [PATCH 10/15] RISC-V: KVM: Allow Zihintntl extension for Guest/VM
Date: Tue, 28 Nov 2023 20:23:52 +0530
Message-Id: <20231128145357.413321-11-apatel@ventanamicro.com>
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
user space to detect and enable Zihintntl extension for Guest/VM.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/uapi/asm/kvm.h | 1 +
 arch/riscv/kvm/vcpu_onereg.c      | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index fa1a8e01b803..0ed5b0f8a230 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -162,6 +162,7 @@ enum KVM_RISCV_ISA_EXT_ID {
 	KVM_RISCV_ISA_EXT_ZVKT,
 	KVM_RISCV_ISA_EXT_ZFH,
 	KVM_RISCV_ISA_EXT_ZFHMIN,
+	KVM_RISCV_ISA_EXT_ZIHINTNTL,
 	KVM_RISCV_ISA_EXT_MAX,
 };
 
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index ba418ac47e81..ba0a44b6b757 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -55,6 +55,7 @@ static const unsigned long kvm_isa_ext_arr[] = {
 	KVM_ISA_EXT_ARR(ZICOND),
 	KVM_ISA_EXT_ARR(ZICSR),
 	KVM_ISA_EXT_ARR(ZIFENCEI),
+	KVM_ISA_EXT_ARR(ZIHINTNTL),
 	KVM_ISA_EXT_ARR(ZIHINTPAUSE),
 	KVM_ISA_EXT_ARR(ZIHPM),
 	KVM_ISA_EXT_ARR(ZKND),
@@ -126,6 +127,7 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
 	case KVM_RISCV_ISA_EXT_ZICOND:
 	case KVM_RISCV_ISA_EXT_ZICSR:
 	case KVM_RISCV_ISA_EXT_ZIFENCEI:
+	case KVM_RISCV_ISA_EXT_ZIHINTNTL:
 	case KVM_RISCV_ISA_EXT_ZIHINTPAUSE:
 	case KVM_RISCV_ISA_EXT_ZIHPM:
 	case KVM_RISCV_ISA_EXT_ZKND:
-- 
2.34.1


