Return-Path: <linux-kselftest+bounces-42387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB23BBA0E54
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 19:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3BF74A1C2A
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 17:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7512332143D;
	Thu, 25 Sep 2025 17:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cyZW/fdB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160E8320380
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 17:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821374; cv=none; b=DjY+3pM7cjeEFKw9YHOInYy8LNozxBtrKbsqs+XgRdBjJIQz7T3t/C/P/TXY2fBpwvxysF0OqBYRjHSs2eYnqYKjnr3ayV/K8MwtXbk9dWhsn5Yv3MUHjX9lJTi/cssqOYXpgbPl0t14R2PEYZESb05LkWuk31UAjmRmS9jGgcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821374; c=relaxed/simple;
	bh=dQKO09oJCnocRjFNIJDtEll6Y8mthajh35gt3qwwu5Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oHlRFT1V2t4U9JfdR3zlgbjsxer1vSwsf7XzinIAvkSe+OZPU//5UOQ+9Df9EnI/Zm9VIvUH7K3doYLExJmXFIBQRER35IScFl5EvdSZEkRg4m52s6psIsiO4vz2TRLyjnLjan8u0YmHLsweQ+NUZ9X+Ayd4TtLi0NuQuF7hFnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cyZW/fdB; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3304def7909so1269255a91.3
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 10:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758821371; x=1759426171; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ThwYPhcmkCcqvioAtkivdQwxT8TbijxWH5xfKoaQ6zM=;
        b=cyZW/fdBOJExph9ZXQLzSsO3znwutoIZ6isNvl8JN9BHU9paLFBSxxsNdJyEprLARn
         5YQQTZ5+jfoaGt7rwll9s09kSDQzJBUD9YrlGs+UAE3MIrikGCJwwuchnOlIe6tMsQk5
         rLFwBa6umtZIrtT4FeWQl3dBSSAU0pLVI1vrGFAen3LCXCEJV8dhIL7CA4Mb668BOl8d
         Aji12W4TsDQb/i0bCjyAzmYKWwa/rPbjQQdJRkglDSzq30c9y2Zcn2mWjeoyyUna4P3l
         z3Pyc3O/deyiE51rVZl1gTTDVS6lrLoyNBmaU+aa9BR4l1IZ+qkrjgCOOdYbfLiDmubO
         nhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758821371; x=1759426171;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ThwYPhcmkCcqvioAtkivdQwxT8TbijxWH5xfKoaQ6zM=;
        b=K5b4lTVzGA/fuE9DFevVR4HFelXvV+xdf/DC/FCm1OJ10J0+Qom/9iQ1C1mxhuxujn
         trgrMUV8idK9yk4TgB62vPmRWT8RU14tPnhB0atDp/mSjo/7ukb2IWQQ0PDx+0gJY4Sd
         N5D55vvP2o+MBmAqKpBQCNkvJ8tx6cLPBibY5+CijGSvSC/H0yeTx2y2Py7z3BJqCOtq
         SzUV0dISYCmj4FYWYMMFQXpSlkvj8+ocFM0Gqk+rsqrjrXs3Vb+OucywbCeVabVUO448
         48Zdhc2M9rexa3VYdqJG4clexrABhY01lNmgJj2meseC+F+fVZ2ZlGRYnLXB4lX2yCWL
         /+lg==
X-Gm-Message-State: AOJu0YzasZGj5zrUdHLGUSVwVbkWHC1NBX+V3rVdDaIdCbju3REI07sU
	g6nfsJcpgqxk0wT2Dhx/+BcAP53IpChqjbDHud713u5iucE/uPGZLI+XWXeACSpMnfgFnhjHJ4/
	5TrnZq/Se1trXk/OcmV8p/QiN5++QhTgHgMqLxaVZ1mgIu1GvGB+iLUG4agYoWS2flQR01Kbrmi
	9IgOzFoiyVG1S5penKpH37oPUkbhrXaQSNoCNiQoakBqo=
X-Google-Smtp-Source: AGHT+IHM1CN9rSt/1jalfBqV4Qi3jOCHo0SnGbk6lWEtgzzPfwzmrVSoUXtYNBHsHrzpTPor0m+ksolOYw==
X-Received: from pjbmr16.prod.google.com ([2002:a17:90b:2390:b0:330:8b1f:c4e7])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b4f:b0:330:4a1d:223c
 with SMTP id 98e67ed59e1d1-3342a23af2fmr5505597a91.15.1758821371197; Thu, 25
 Sep 2025 10:29:31 -0700 (PDT)
Date: Thu, 25 Sep 2025 10:28:48 -0700
In-Reply-To: <20250925172851.606193-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250925172851.606193-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250925172851.606193-21-sagis@google.com>
Subject: [PATCH v11 20/21] KVM: selftests: Add ucall support for TDX
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
2.51.0.536.g15c5d4f767-goog


