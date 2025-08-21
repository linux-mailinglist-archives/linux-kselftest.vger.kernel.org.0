Return-Path: <linux-kselftest+bounces-39452-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D81B2ECFC
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 06:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9C2FA24446
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 04:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773EB2EBDD7;
	Thu, 21 Aug 2025 04:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="loPsoVTU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54FC2EB87D
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 04:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755750593; cv=none; b=H5OH3hVl4RSsIcCgUdgZSngkNm5bZJnJKENuRx6+bJBmCeDu+H0zB5cuu3BMVgehtLHxgyIpZlDn+yjMm/+Ycj1czMio6bY3Qoyb1faIBKlXPnecUy2mKD6bQmQ+Lwl5+xiL3cf3n8x8Z1ndB6elxkbarAE0A9AlaJx8c64rM9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755750593; c=relaxed/simple;
	bh=9+eQprqBsQ6gxSE3z+RPqS3r7N8HYybLZbylKvd7iWA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=owNOyrtBLXKdL9282K1I7atsngSzAvCNc9KuOuKL/xTOyreJVgjMe881Xc6iA4WZ65hdQn3JPpomvkvqMZbDl9KzPmtY6w4HrVnxt/tTZcXSeKGideUDRZHi/3Lu5L4OwGS9XCfZRGz93/7xO57D5ZdVGz3/XC8tqq1Y2yYQT/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=loPsoVTU; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-323267915ebso1451346a91.1
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Aug 2025 21:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755750591; x=1756355391; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C+Vn2dydaOWO4V7Wr4fQ6A3nnlLiDSULKiE6J6INVZA=;
        b=loPsoVTU0O3ATp7otV70VbPJxJuQk/2j0ZPoKXZ7mXN/l8hLXHisNus9Blll0W/gAg
         KHLKOseGeE5pktXeHWprdojDfjfdRRwUQNVSfzrvfFwn0SCC8MoY2bPDC6G9y/wrMVQu
         aocGGX8Up9RJGxaXGuuQoVzpE7rLvLUTxMY44QT4Gbmj70I6uhYvknsBVR6hybkzq6OR
         6Av+rmdPtPtENUv2HaMa1EA5brrq4ESDMxNaHxgJCAWoExiZlLQycnLuv/VSYwBlLmLU
         +4YBRiheOJ+sQ/aFAoPwyAmTqvrWl3vkLp+8fGTRkc7qVsVQia8wSHL5/WfSzZt2xPFy
         nBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755750591; x=1756355391;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+Vn2dydaOWO4V7Wr4fQ6A3nnlLiDSULKiE6J6INVZA=;
        b=nA7voyK1uzT6+m1WyNJG71CiEvDRNmjsFq9OsOnzmyKFBuaSJ0sr0ltN4UfR5gubp/
         2kThBTMU4plG36Zy0q/+a0a3AddGoCbhXEpwHucU0Sh60vXxAl6SIK7vArdggklkY/c2
         85AeXolIdj1NRkG7GmsoCGcoxeQqwfcdfqNxovMXMQAEpfpZFNs+oK8lBH9+iAuzUN2Z
         tD1gLeFQ/MBDnB6SJgnhRbC1hrNtF/q1NFhezNcwSiqFjp1Rj6X6PrOSAzBJnEuhn5tD
         va8NhiPJjtxOb8itwP9Wp8KIGJU0HmdiesbRZqkehbUZJtY88uV39hUh5eRtvpTm+Kub
         MQZA==
X-Gm-Message-State: AOJu0YxrvFAA1kJLvc08b7Yygvggt3XvM7nqSDNUMRmukqJkZZ67mC0K
	7xzWNbezTZI36kXxcpsgt3U2hd3omANa0wMnvF1qzdjxQytkNwa6tbphRkV9+aWRCVCO1EA409+
	OOY2YjZUne1HuwMAeKTJ7srv4THfX82u3hw8GAytzm3xVS5/THg1DXAt8Mf6b0WwFrpLYEF5DPK
	CKJ7I8oj/xvxELgwAcyCZ1UDCBshP/c3czuZuJz7M5qO4=
X-Google-Smtp-Source: AGHT+IHnoZkxggDv6fXD1tHDt5+rOVqRbveDiJ7W0a/Y7B0nOodBtUYvH6G1D7HFbnYFBe8qgKggtU4fUA==
X-Received: from pjbnb18.prod.google.com ([2002:a17:90b:35d2:b0:321:c36d:1b8a])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2e0e:b0:31e:d929:5ca5
 with SMTP id 98e67ed59e1d1-324ed06131bmr1483288a91.1.1755750591038; Wed, 20
 Aug 2025 21:29:51 -0700 (PDT)
Date: Wed, 20 Aug 2025 21:29:11 -0700
In-Reply-To: <20250821042915.3712925-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821042915.3712925-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821042915.3712925-19-sagis@google.com>
Subject: [PATCH v9 18/19] KVM: selftests: Add ucall support for TDX
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ackerley Tng <ackerleytng@google.com>

ucalls for non-Coco VMs work by having the guest write to the rdi
register, then perform an io instruction to exit to the host. The host
then reads rdi using kvm_get_regs().

CPU registers can't be read using kvm_get_regs() for TDX, so TDX
guests use MMIO to pass the struct ucall's hva to the host. MMIO was
chosen because it is one of the simplest (hence unlikely to fail)
mechanisms that support passing 8 bytes from guest to host.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../testing/selftests/kvm/include/x86/ucall.h |  4 +-
 tools/testing/selftests/kvm/lib/x86/ucall.c   | 45 ++++++++++++++++---
 2 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/ucall.h b/tools/testing/selftests/kvm/include/x86/ucall.h
index d3825dcc3cd9..0494a4a21557 100644
--- a/tools/testing/selftests/kvm/include/x86/ucall.h
+++ b/tools/testing/selftests/kvm/include/x86/ucall.h
@@ -6,8 +6,6 @@
 
 #define UCALL_EXIT_REASON       KVM_EXIT_IO
 
-static inline void ucall_arch_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa)
-{
-}
+void ucall_arch_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa);
 
 #endif
diff --git a/tools/testing/selftests/kvm/lib/x86/ucall.c b/tools/testing/selftests/kvm/lib/x86/ucall.c
index 1265cecc7dd1..0ad24baaa3c4 100644
--- a/tools/testing/selftests/kvm/lib/x86/ucall.c
+++ b/tools/testing/selftests/kvm/lib/x86/ucall.c
@@ -5,11 +5,34 @@
  * Copyright (C) 2018, Red Hat, Inc.
  */
 #include "kvm_util.h"
+#include "tdx/tdx.h"
 
 #define UCALL_PIO_PORT ((uint16_t)0x1000)
 
+static uint8_t vm_type;
+static vm_paddr_t host_ucall_mmio_gpa;
+static vm_paddr_t ucall_mmio_gpa;
+
+void ucall_arch_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa)
+{
+	vm_type = vm->type;
+	sync_global_to_guest(vm, vm_type);
+
+	host_ucall_mmio_gpa = ucall_mmio_gpa = mmio_gpa;
+
+	if (vm_type == KVM_X86_TDX_VM)
+		ucall_mmio_gpa |= vm->arch.s_bit;
+
+	sync_global_to_guest(vm, ucall_mmio_gpa);
+}
+
 void ucall_arch_do_ucall(vm_vaddr_t uc)
 {
+	if (vm_type == KVM_X86_TDX_VM) {
+		tdg_vp_vmcall_ve_request_mmio_write(ucall_mmio_gpa, 8, uc);
+		return;
+	}
+
 	/*
 	 * FIXME: Revert this hack (the entire commit that added it) once nVMX
 	 * preserves L2 GPRs across a nested VM-Exit.  If a ucall from L2, e.g.
@@ -46,11 +69,23 @@ void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
 
-	if (run->exit_reason == KVM_EXIT_IO && run->io.port == UCALL_PIO_PORT) {
-		struct kvm_regs regs;
+	switch (vm_type) {
+	case KVM_X86_TDX_VM:
+		if (vcpu->run->exit_reason == KVM_EXIT_MMIO &&
+		    vcpu->run->mmio.phys_addr == host_ucall_mmio_gpa &&
+		    vcpu->run->mmio.len == 8 && vcpu->run->mmio.is_write) {
+			uint64_t data = *(uint64_t *)vcpu->run->mmio.data;
+
+			return (void *)data;
+		}
+		return NULL;
+	default:
+		if (run->exit_reason == KVM_EXIT_IO && run->io.port == UCALL_PIO_PORT) {
+			struct kvm_regs regs;
 
-		vcpu_regs_get(vcpu, &regs);
-		return (void *)regs.rdi;
+			vcpu_regs_get(vcpu, &regs);
+			return (void *)regs.rdi;
+		}
+		return NULL;
 	}
-	return NULL;
 }
-- 
2.51.0.rc1.193.gad69d77794-goog


