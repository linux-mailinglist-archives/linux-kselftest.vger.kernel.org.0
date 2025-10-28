Return-Path: <linux-kselftest+bounces-44233-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F3AC16F5B
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 22:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 080FB356BF5
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 21:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F302435A128;
	Tue, 28 Oct 2025 21:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tZUifiMO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4E8359705
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 21:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686478; cv=none; b=lZ/N++XoeIKz9eN0ArH1LLjBIU+FqjouGZrjtNKtF8QOoISRnh4oh9B3FN6GZFaUAGKcjf0lSb+5Ck6QA9XKSf9yuswax2ZfChLm0BR/Qnr/Yuycz7yC1weQGt2B2j5txdCBLfbXqoSDcY3VpUBN6qC8/pWxgbtyVcKnXZ4lmwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686478; c=relaxed/simple;
	bh=UZLe6fcs4+2cK8KL7h1/WUe9mKZLLiYYT3kkeeT5kbE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e3W9mDGkYiUG4oweMeV6UpTqbRHA4t+MfiUVzjPMcvqoaQU8wKupd4B/vzRTVf3btYzP3OP4ds9ZmylMuDTAMgEiQtuYKWeHzUDEaML4+LY3VLPljvKaZ9MFxh8dKbFfLx1baq+pzYIF4l0uGBly5daNmOHX1OxsRTCqekc042g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tZUifiMO; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-93bc56ebb0aso2084709139f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 14:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761686476; x=1762291276; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=98xagRJ9cnultVeG0sA1nEIFICNJxv1IqATLZK1iFck=;
        b=tZUifiMOxHiwTL+UkOfrimFrhD+go5LJrcEYSIGB7f5p2u3yWRv2f9Wk23HDHGy70h
         4KOB3OC48OjvDyTl4aX6cYHZU+Dw4DqTtMhH7Qz9GV2Mn+liLdGnba2wlRTTBJ1ny59k
         ep4aAsuf/t7UQgvWtHbvDMr2KdF258TAdrIFE4ur7byguwKyt636EJDwPon9i0XbfeEU
         7Bl4wkJkDM8hMhRgG0w5B/pIoflua0I1ut/UjA145+EFQn6RdB5aimjWQNhSwjRuyHBp
         14LNG/wSM/CYlSbDAWnrpFHywTd7wJYBS/IMhJ/P57J0qyAbwpINojjykA+vYb0Le/qJ
         ro7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686476; x=1762291276;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=98xagRJ9cnultVeG0sA1nEIFICNJxv1IqATLZK1iFck=;
        b=neqql+K0Uu4h/iP2QB1q4xCKuyRXKVznkrMH4hRHATMV8TVOkos7pp0Q0634rwWbqW
         zCvuu6NeqtGEofBiAjxOfvXEX03dJh+F9R0BJiqMTI6xMhglVt+BwqTrVlwclSLb0snH
         T7yAFeWR8l9WM5MmfkJnr+AFdS+dH+CIOJO1/IFc8fiN3wWtyaQSbL2Ei5H8Ve2Jfm9v
         dpSvD+NYpvGh9zXT1KKfeCZ47CIKYG4x/yDac5bXkM6khNpJFeGjbjF736A55QtrMDJH
         riw+AT9vl9MNo0tbJlM7YbtdTp4xQpV5lXpLDghhHS2T50gKadvR+4vCzzUHAin060/d
         CO2g==
X-Gm-Message-State: AOJu0YyQT1L9efgq2CJrPtrASQ+h4+lwlJXfXKJ+iKl1JK5xPTnBo2tb
	a7k2wszpr6GiL2G/PVuezk6+PgJA3HiFvk+XjH7BtiS5bLVyShcradjX1FLFaQKk2vYxGIsH24w
	0W3ldjdl234XkoKe0CVZ+fBVkxO3kfBO60d+sW/zxQHTBYoWsW09PnZWigVRr7uYerqwfDigj0f
	NYsPGMom2f4pkXkeBcmpk+qsjfuwHZTbmSeaMXUK9Egts=
X-Google-Smtp-Source: AGHT+IGW9GSavDqWW1ubHmG0FcBgXUDwNg9Hu9nj4+LRBDxNjquSuhnf9Qh5SVD7+iQOAqNbxQDTayP9Wg==
X-Received: from iobeh12.prod.google.com ([2002:a05:6602:4a0c:b0:945:a1a1:3681])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6602:2c8b:b0:892:f398:591
 with SMTP id ca18e2360f4ac-945c96e725amr155242039f.2.1761686475888; Tue, 28
 Oct 2025 14:21:15 -0700 (PDT)
Date: Tue, 28 Oct 2025 21:20:48 +0000
In-Reply-To: <20251028212052.200523-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028212052.200523-1-sagis@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028212052.200523-23-sagis@google.com>
Subject: [PATCH v12 22/23] KVM: selftests: Add ucall support for TDX
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

----------------------------------------------

Changes from v10:
 * Removed ucall_arch_init() decleration from ucall.h.
 * Replace vm_type type check with is_tdx_vm().
 * Move mmio info initialization under is_tdx_vm() case.
---
 .../selftests/kvm/include/ucall_common.h      |  1 +
 .../testing/selftests/kvm/include/x86/ucall.h |  6 ---
 tools/testing/selftests/kvm/lib/x86/ucall.c   | 46 +++++++++++++++++--
 3 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/ucall_common.h b/tools/testing/selftests/kvm/include/ucall_common.h
index d9d6581b8d4f..f5eebf690033 100644
--- a/tools/testing/selftests/kvm/include/ucall_common.h
+++ b/tools/testing/selftests/kvm/include/ucall_common.h
@@ -4,6 +4,7 @@
  */
 #ifndef SELFTEST_KVM_UCALL_COMMON_H
 #define SELFTEST_KVM_UCALL_COMMON_H
+#include "kvm_util.h"
 #include "test_util.h"
 #include "ucall.h"
 
diff --git a/tools/testing/selftests/kvm/include/x86/ucall.h b/tools/testing/selftests/kvm/include/x86/ucall.h
index d3825dcc3cd9..7e54ec2c1a45 100644
--- a/tools/testing/selftests/kvm/include/x86/ucall.h
+++ b/tools/testing/selftests/kvm/include/x86/ucall.h
@@ -2,12 +2,6 @@
 #ifndef SELFTEST_KVM_UCALL_H
 #define SELFTEST_KVM_UCALL_H
 
-#include "kvm_util.h"
-
 #define UCALL_EXIT_REASON       KVM_EXIT_IO
 
-static inline void ucall_arch_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa)
-{
-}
-
 #endif
diff --git a/tools/testing/selftests/kvm/lib/x86/ucall.c b/tools/testing/selftests/kvm/lib/x86/ucall.c
index 1265cecc7dd1..fae6f37b0bcd 100644
--- a/tools/testing/selftests/kvm/lib/x86/ucall.c
+++ b/tools/testing/selftests/kvm/lib/x86/ucall.c
@@ -5,11 +5,35 @@
  * Copyright (C) 2018, Red Hat, Inc.
  */
 #include "kvm_util.h"
+#include "tdx/tdx.h"
+#include "tdx/tdx_util.h"
 
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
+	if (is_tdx_vm(vm)) {
+		host_ucall_mmio_gpa = ucall_mmio_gpa = mmio_gpa;
+		ucall_mmio_gpa |= vm->arch.s_bit;
+	}
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
@@ -46,11 +70,23 @@ void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
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
2.51.1.851.g4ebd6896fd-goog


