Return-Path: <linux-kselftest+bounces-40745-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78260B4331B
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 08:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00BC3684C45
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 06:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29A829D291;
	Thu,  4 Sep 2025 06:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v/UKW17+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C8029C35A
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Sep 2025 06:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756968930; cv=none; b=Em8q3B94BFmaKA8d8brd9JsO75HOo3rRFtIeficYeSw7FZZoPcYO1IOr0rf+Nzk7hTUDf083/M9Ongs+G2dGjkSnXwsMir/SKEBMFhxu+78l6rxWTxtlcB6rqDGUwhhECv5FfaVQqnX1eYlxpBB8GVPQssU4Z0aojoyPGGAXRwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756968930; c=relaxed/simple;
	bh=A3rvNv5tLE6sXzjWetLlKSM8k2q2gEXk49EouZJdocs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mwonVaY3DDBdh0TY7JOrr+CF9iotpRLrHINK5jEAgcT3NqFOtC311S8l1z8ATCZkJ+YbFFVOqR/0tg84cjz/OHrAcO+hZXLyqUqXIYKHXiWRlQiVhmVHNOPqVYk6MChGiz4CMNuXtdciJbtf7P29w1DcYG1fnMahIEzyXbQJPpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v/UKW17+; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-248eec89618so9990615ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Sep 2025 23:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756968928; x=1757573728; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7jyzFRHHiSGpkjG2s+KNnXbL/OeDAvT2CWWv4I+ohEc=;
        b=v/UKW17+yXm+POY8T+V38W1I0sjblkHsI+MFHch4DhumNF4VSPrywAguzrCRGPlglh
         LgnfG1OYHk9WSDsZ9Uh2dZJQv7PHZJbA8o9C7N9yojS7z+LMfpVdeZNw58ZUbZ8u4ku/
         syNYliZQe1ov94Q+sZSLYwHqB1/5ZdnjPqEL0tfxCrCI1CAgPbIiGrP01WCqxA6DJCzy
         a+7re2latKmqMNmLfJujocCq5fdHUnDXJ1L4KEO32OY2vXA/vg5uWL5NEy02tAUSmXwh
         n4hDYILU9OhZAFWbFyZGDZJXIBNcyQdZDIdEXzETD+GQa0/JQd6WFV/9WB9iGlHhX8KL
         Z30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756968928; x=1757573728;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7jyzFRHHiSGpkjG2s+KNnXbL/OeDAvT2CWWv4I+ohEc=;
        b=vYWbtaRvrpNNZArGUzPHrkV/QlUUBq3r/cuGnqWlJv4HHDkxyLz7xL/VsdHFjWZsCz
         qeySGuSvym89CdtmRxUP0mbTSlvICljyM7IAB9/40J89oc14n0gZUt1YEyE1ejj9+jAx
         lCDSqukhfeGSLOZIMDOhIn//oPaBOYrn8KJaWlAuJ3jzcJ5a6cfy0QYquucrFk9U9MZA
         ChRyIX8bfuBm3OvVSn7NVsh4NsUouvPX15/1+dHjXKVnfGABlGX0H4L5BrdhAUrXrIV+
         A6WcG7nFuN6Snm2uvC7qQKnEJgiBBT9x3wMEuHXLoVDf+6t7MsZnYT3q9K0d7ozFmC3t
         tXuw==
X-Gm-Message-State: AOJu0YyL44z2oE7rvoxQaZdMZnkZ4N2PhRwXok1Rw7jgpqPIr8NCFP+x
	C+4ldz7pFXe2zLNyfd+j8crn1pJtm5wVI955WcDVdH8grSTN4Oxp+6ODqD9UmFKZji1dADxGyBj
	GxHj9ydgLXw0wVnjn8s4PkMuAmToJ39nPHTjPdOkG9fz0F0Suy9YouYeS+IFOoYFXoQZ6RjB4Gi
	UE+5/0PlpZqYtrpkZxSSev7xO4BNFpeOtIri6xPTNaLMQ=
X-Google-Smtp-Source: AGHT+IFvmfVW+KjlSTZrEQuN275lpqi6Zns8OFz+/5+P3JxjVk+2+fXszGsfdn7feAXTaG2YLUI81w0/kA==
X-Received: from plao20.prod.google.com ([2002:a17:903:3014:b0:248:df48:c4e])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce03:b0:248:cd0b:3454
 with SMTP id d9443c01a7336-24944873445mr201783715ad.9.1756968927646; Wed, 03
 Sep 2025 23:55:27 -0700 (PDT)
Date: Wed,  3 Sep 2025 23:54:46 -0700
In-Reply-To: <20250904065453.639610-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904065453.639610-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904065453.639610-17-sagis@google.com>
Subject: [PATCH v10 16/21] KVM: selftests: Call KVM_TDX_INIT_VCPU when
 creating a new TDX vcpu
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

TDX VMs need to issue the KVM_TDX_INIT_VCPU ioctl for each vcpu after
vcpu creation.

Since the cpuids for TD are managed by the TDX module, read the values
virtualized for the TD using KVM_TDX_GET_CPUID and set them in kvm using
KVM_SET_CPUID2 so that kvm has an accurate view of the VM cpuid values.

Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../testing/selftests/kvm/lib/x86/processor.c | 35 ++++++++++++++-----
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index c255fe1951be..b1e5f4137629 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -685,6 +685,19 @@ vm_vaddr_t kvm_allocate_vcpu_stack(struct kvm_vm *vm)
 	return stack_vaddr;
 }
 
+static void vm_tdx_vcpu_add(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
+{
+	struct kvm_cpuid2 *cpuid;
+
+	cpuid = allocate_kvm_cpuid2(MAX_NR_CPUID_ENTRIES);
+	vm_tdx_vcpu_ioctl(vcpu, KVM_TDX_GET_CPUID, 0, cpuid);
+	vcpu_init_cpuid(vcpu, cpuid);
+	free(cpuid);
+	vm_tdx_vcpu_ioctl(vcpu, KVM_TDX_INIT_VCPU, 0, NULL);
+
+	vm_tdx_load_vcpu_boot_parameters(vm, vcpu);
+}
+
 struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
 {
 	struct kvm_mp_state mp_state;
@@ -692,15 +705,21 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
 	struct kvm_vcpu *vcpu;
 
 	vcpu = __vm_vcpu_add(vm, vcpu_id);
-	vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
-	vcpu_init_sregs(vm, vcpu);
-	vcpu_init_xcrs(vm, vcpu);
 
-	/* Setup guest general purpose registers */
-	vcpu_regs_get(vcpu, &regs);
-	regs.rflags = regs.rflags | 0x2;
-	regs.rsp = kvm_allocate_vcpu_stack(vm);
-	vcpu_regs_set(vcpu, &regs);
+	if (is_tdx_vm(vm)) {
+		vm_tdx_vcpu_add(vm, vcpu);
+	} else {
+		vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
+
+		vcpu_init_sregs(vm, vcpu);
+		vcpu_init_xcrs(vm, vcpu);
+
+		/* Setup guest general purpose registers */
+		vcpu_regs_get(vcpu, &regs);
+		regs.rflags = regs.rflags | 0x2;
+		regs.rsp = kvm_allocate_vcpu_stack(vm);
+		vcpu_regs_set(vcpu, &regs);
+	}
 
 	/* Setup the MP state */
 	mp_state.mp_state = 0;
-- 
2.51.0.338.gd7d06c2dae-goog


