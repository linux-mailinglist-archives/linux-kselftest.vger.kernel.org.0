Return-Path: <linux-kselftest+bounces-40749-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4259BB43327
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 09:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0353A41C3
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 07:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6082F2BE655;
	Thu,  4 Sep 2025 06:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MHtgfCZR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A292874FC
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Sep 2025 06:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756968936; cv=none; b=IGkJg0ieFQDipw8sDE3aQ1cIG7DP0lgIy8jKvkorKipA2HEPzz+JZZ0ACScW0hWAIQVPjbs4ZU8TH0d6bXq8hC5RZsnsB6mANJWVxEzksrPGQNIqCgugHEF/zD/dN+xBiGesm4TIrtyNMUAX4bjcZezKOM4Ca/gdC1p9ojQe3oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756968936; c=relaxed/simple;
	bh=82imUpUGSrASE3Ews8yZjglaw3mYQKnEEacvVHA3ZMU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VupNnaESsmA+t0rP/oAexTUxYMnZ13JarcqspCLoQeCGv3Jqsl0okOup1ErPBVqIhG6m3mTYl/mNsBHWjx2WEyVGNlPwQM2P0TJYVG3yjCwDTTPIMaeep6YLOsq/Ds3sXE5D/coAJb54cVb/41ga6Gl+UWdWefas6xu/5b3ymqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MHtgfCZR; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-329ee69e7deso666713a91.3
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Sep 2025 23:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756968934; x=1757573734; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gEbqVx1XUrmfHL/bfo75/bOQleA+IfiyOTZneZaFJoQ=;
        b=MHtgfCZRlzzy+B1FnCuKz64C5x++VmiPA7BvlutupPDVQBi+P9SgS6K+HLsBkwrNJX
         IL0G9dSoSofxv3OI+ebB/A2xcLUj8nbROUmoM7+g6fPxJr9BKniBy4/62oDFhDnOz0EY
         iRlg9tG//Q+V1+zcLb2qmY2Je44Tse7ojTRfUqKVZZZrUwXTW1Bt6xNWcDo6LeR6Oevu
         Y9+DixkzAJCvtur0DjGjXq4xqTmGP1BCCcQ5MCYjQ4ogW4RXO0WZ7FX0AkIB9JePFqW9
         uqtvP8bBzF5nwvGd0MjDQ8F/tuaoRUDsjydrimq8rhcE7nZ7TErQ6d/NF2TFuJTmiTSx
         JtNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756968934; x=1757573734;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gEbqVx1XUrmfHL/bfo75/bOQleA+IfiyOTZneZaFJoQ=;
        b=pKJE30bZnIyKpHAWdmN2dogna9Mo2NXGI6tbC5BcV8luH/1epnuR5MztIZofjgcIMN
         XVQsTTSEusnvZrf0bSbfaCOzGCMLJKQwaSos1RBgyep4Nhhv75sxb/EVkBhQocLRfJVM
         ZETbWUtfRz0Ka4Z2qD2amNYTglcsYD07ZprvXDNUUTNkhDmvlwVSptLNynwSpn06TZhH
         zgqlTBbvMi2nHxzaQP3r4VMrY98T0RIMwGCPGg7pMLlInHH0D0O9cZgbGobcOrTZN1zs
         yOFvc3ZlbkTmbsYnQ77GV/Gc2rkBFPvV5yOlRfB1WUDtNwEVZ4vJQfmUVu8nWIDSfoxN
         yiJQ==
X-Gm-Message-State: AOJu0YwyW5Q6V+KxiG1dZ5VGVY63p9R7942MZksLrFV1QcjP5s345oNk
	jNU2T9PzV58Uerg+ccPaK7k6uqymrxyuDfvRAvNVqOYgS/awAVg5R3h+/8RuHxBdDl0HP0wDdF+
	RmKntyyN8vm+ZX0LG+5INF9RRvbey3/okZ5MXCMpapkjuDvw9JzQGacdUz8YVpYbNsWwgfQ8d13
	iYDwkXUYHYo71m5W5xoTB3nd1R6X4u86e4AtIvMSBMRvg=
X-Google-Smtp-Source: AGHT+IHxg5XX+QGRvB3eVe6BPmD4a7wWjsiBO7i2k5ga/0nig7c6kMIoh8dnmBhJcA/htRSJV7twgBolAg==
X-Received: from pjn16.prod.google.com ([2002:a17:90b:5710:b0:32b:58d1:a610])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:384c:b0:329:e708:c88e
 with SMTP id 98e67ed59e1d1-329e708c9fdmr12000946a91.20.1756968933985; Wed, 03
 Sep 2025 23:55:33 -0700 (PDT)
Date: Wed,  3 Sep 2025 23:54:50 -0700
In-Reply-To: <20250904065453.639610-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904065453.639610-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904065453.639610-21-sagis@google.com>
Subject: [PATCH v10 20/21] KVM: selftests: Add ucall support for TDX
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
2.51.0.338.gd7d06c2dae-goog


