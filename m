Return-Path: <linux-kselftest+bounces-715-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A447FBD63
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 15:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B0FAB21C0A
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 14:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3585C8EE;
	Tue, 28 Nov 2023 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="fx0BCuYC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1527A2113
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Nov 2023 06:54:50 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cf89df1eecso38545685ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Nov 2023 06:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1701183290; x=1701788090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zm/Iyo3ZjfxV3AvcIfkWbfx2G5Qea1Dpvj7in6gJJEo=;
        b=fx0BCuYCbpHvzIZtgoFN0tiyMPMKqs06LYHAhTQV8ephbGpBLNBYRPli9kEEPXkJkz
         x8AbOoGEHWcbdaw47DvO0TfTd8QZU85n4FBBLR83CdqK6Cc2pohIJ4grMtGRVoSRZ+95
         H9QT7kLwuFCuuv/2u8bXy/pQKUvNNeGIzsmbSYoe2GIKXv7F6wWSaamplV/9OOtGvcsr
         kKmlANlqzLL5fqPec/C/ulkH70yFtNS585v5Qi3GBQPyd1QycDTxKQaSipvOm7mhWHds
         tIKlKKesxPTJM477U15ON1FRW+OAaZkqV3lGj++FqRl4lTlO7pqdCverQ2+BHCQDE53q
         1SVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701183290; x=1701788090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zm/Iyo3ZjfxV3AvcIfkWbfx2G5Qea1Dpvj7in6gJJEo=;
        b=vxja8Jfm7Q+J6MMWufCEdiQ7mK46HKCjjplfQQCDvxMDpdK+AMzhZtoXGbN56s6cxD
         f5FLYZVPZPpt+5j6rELMEvesAaAbnHVUV/7hh86H2nhqt8VMh0gBrnvHz9ybK9unFuBT
         Mvn9kTBEYLnyt5zuyLKVwAsmnLpCtcNC1RPKRA7py+0huFfCDaUgTBFxsy5nXynSqKiP
         NMSLpXcP+08rT9MSrkPoG5/Z+P/8nYPKdkvhHBdFNiyoKaYs8TdO0dYs24EAdFMhDWgj
         uI9UzpB9X3bNlsGfMDaNIDDAOT+gptrBlT4+9zrc+zbOjcEqQvhSggUtVS/2Qivdv3vp
         j0Sg==
X-Gm-Message-State: AOJu0Yys/QShH0qC396MoIdPL98VBpc1tqX5App6MzV+HwmuCoaFByyC
	7Je5JxLQcSeAOALeKyHzrsMEZg==
X-Google-Smtp-Source: AGHT+IGNa0gmUO/XYyy1AQclzWoEopJjPk2a6P+hxdcxMn26I35PIIr0XIYsIPFAX9+qx2+hdanbsA==
X-Received: by 2002:a17:902:cec8:b0:1cf:c018:b4e9 with SMTP id d8-20020a170902cec800b001cfc018b4e9mr10533194plg.43.1701183290185;
        Tue, 28 Nov 2023 06:54:50 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e80b00b001bf11cf2e21sm10281552plg.210.2023.11.28.06.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 06:54:49 -0800 (PST)
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
Subject: [PATCH 08/15] RISC-V: KVM: Allow Zfh[min] extensions for Guest/VM
Date: Tue, 28 Nov 2023 20:23:50 +0530
Message-Id: <20231128145357.413321-9-apatel@ventanamicro.com>
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
user space to detect and enable Zfh[min] extensions for Guest/VM.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/uapi/asm/kvm.h | 2 ++
 arch/riscv/kvm/vcpu_onereg.c      | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index 241632f91f73..fa1a8e01b803 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -160,6 +160,8 @@ enum KVM_RISCV_ISA_EXT_ID {
 	KVM_RISCV_ISA_EXT_ZVKSED,
 	KVM_RISCV_ISA_EXT_ZVKSH,
 	KVM_RISCV_ISA_EXT_ZVKT,
+	KVM_RISCV_ISA_EXT_ZFH,
+	KVM_RISCV_ISA_EXT_ZFHMIN,
 	KVM_RISCV_ISA_EXT_MAX,
 };
 
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index 4cd075f4cf9f..ba418ac47e81 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -47,6 +47,8 @@ static const unsigned long kvm_isa_ext_arr[] = {
 	KVM_ISA_EXT_ARR(ZBKC),
 	KVM_ISA_EXT_ARR(ZBKX),
 	KVM_ISA_EXT_ARR(ZBS),
+	KVM_ISA_EXT_ARR(ZFH),
+	KVM_ISA_EXT_ARR(ZFHMIN),
 	KVM_ISA_EXT_ARR(ZICBOM),
 	KVM_ISA_EXT_ARR(ZICBOZ),
 	KVM_ISA_EXT_ARR(ZICNTR),
@@ -118,6 +120,8 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
 	case KVM_RISCV_ISA_EXT_ZBKC:
 	case KVM_RISCV_ISA_EXT_ZBKX:
 	case KVM_RISCV_ISA_EXT_ZBS:
+	case KVM_RISCV_ISA_EXT_ZFH:
+	case KVM_RISCV_ISA_EXT_ZFHMIN:
 	case KVM_RISCV_ISA_EXT_ZICNTR:
 	case KVM_RISCV_ISA_EXT_ZICOND:
 	case KVM_RISCV_ISA_EXT_ZICSR:
-- 
2.34.1


