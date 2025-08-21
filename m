Return-Path: <linux-kselftest+bounces-39438-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C46AB2ECD3
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 06:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBE18A23087
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 04:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F8A2E8B89;
	Thu, 21 Aug 2025 04:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2ispsQFY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7E22E8896
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 04:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755750572; cv=none; b=rXyARfQhI3mMf7y8hT8xrx5E8MFNiYNP1E7Cq2AWtIe/htPPMXvotIYpUDNbGRkHB3aIYhJDyp6DW3lp2ti8JvCM/lwEPAn8Rx/OG4HHEObEVV3qdyNnsXYFwtVuzFVYb1j2JfaqOMfEmYly5AIQ2avaCQRN90XXcYls72jCxxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755750572; c=relaxed/simple;
	bh=0Jrb3Ji8Kdw7g+EvrXjQHEn0QPEdvq7OtxqdSz4cQ/k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XVR1OO/YYKFrwTa7s5MPjO5f3Fo4e1I4t81sZjI0OrNEkh21mLYL8aMIYukoZQAoxNPRMku8KuylGA9JMzDBcmqQDX7PQNIUBaxCqTyJWbaIXLCJXw0iV1bBmeo+lcu18RYxMlh/VsazCY6QlOOYavrBHtVya6fZ2n+lxf43W6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2ispsQFY; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-323267c0292so647769a91.1
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Aug 2025 21:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755750570; x=1756355370; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7p1w/0nGP2+nuE3Sj/o2pc3RbjAseJgFmPLpSNz8fQ=;
        b=2ispsQFYbopr2DkXLfKyn5aWtHDMYvgnUWGAAJpU5CThp/+oCRajZYtUOMXyEcU6C2
         wQwr7m+Wygu7Y4x+IOE3DhBU4OSromTgPSYAd3PmQIdsZb26I6NWtOVtewS9wk3QszOA
         NvcM1WbJEHgDmCj2qWwz1KpVR1O/gNBMKxDBlhiSKVSjit5Y5f/lgK7t7ec17cMje4gf
         +hBmyLCuPdgwq6qKXiADZ7FKmYSyrI4qoZ/2FTlRbYLP683RuXyWA2pHSorAUPDLtvzJ
         Ixzr7XVSJIReYJq02c83kbH1IDAtEbgXFNAkdUzzzP1TinCwbrwtNIRkIYpQD2kfAV/O
         v3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755750570; x=1756355370;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7p1w/0nGP2+nuE3Sj/o2pc3RbjAseJgFmPLpSNz8fQ=;
        b=m/bKXc1xRf9PzPCg6jvPekouSee4Hm7Z299O9Y5uKWkTVdJTm3yxCz0z6aPKf3QBR3
         b+KqSaX34H5YmymeW3MNTUltQEXM1Eq8WhIEYVrlS+AZFaAw5AfBU0oJ1YJVEpztatoq
         AGdibV9/k+sFQ+Xar0+Uc7r63PFUl6EQS+B1Khp5h2zP1a4nerH2ia4F1ucoEzmsekIx
         SdpY9D+OwrkdoSRRCsvAhdzEYdgh1+z7q1xzbbC31v88mPnSsvu5DU0I7yHVlIvpjoTU
         9fENAR73us6QuH3Qvf5QeskgJ8WlAJpKi88DAkHDYopAkUTmNoG4Y8bvkijwnfWPmpxp
         d2jg==
X-Gm-Message-State: AOJu0Yw4ushwxp8JiIS5K0FdynQqtOdns3cOJzzdCpYrnZKewhvvMcjQ
	HglB1wWp7CWiakhhQB/+MBaPpmksn+Vf/yC4y4Vx5j5ICd6Zh4OR46Mc3yKL1P1+ia0xY0CPnjT
	45mTvw+uYPc9jePr8VJOxITsJp+q0E8AYsx0r7Wuf9ZbdXuLE1qX2ymLQKCoGlJgA9q6oLrO4DA
	2PCuF4dnaSesynjoE70pyF+4z7hZC/SbO5XnkaDtzgKXo=
X-Google-Smtp-Source: AGHT+IFYyHng4eo+BL8OQ8lBS0tjB4dYQ5kbVU0qukLxLoDrhgSCiNMa6RXzrgJnUdi0EatgPpu1Ry6ljA==
X-Received: from pjbsd14.prod.google.com ([2002:a17:90b:514e:b0:321:78e7:57fb])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d4d:b0:312:1c83:58e7
 with SMTP id 98e67ed59e1d1-324ed07eeb5mr1323651a91.1.1755750570205; Wed, 20
 Aug 2025 21:29:30 -0700 (PDT)
Date: Wed, 20 Aug 2025 21:28:57 -0700
In-Reply-To: <20250821042915.3712925-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821042915.3712925-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821042915.3712925-5-sagis@google.com>
Subject: [PATCH v9 04/19] KVM: selftests: Expose function to allocate guest
 vCPU stack
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

TDX guests' registers cannot be initialized directly using
vcpu_regs_set(), hence the stack pointer needs to be initialized by
the guest itself, running boot code beginning at the reset vector.

Expose the function to allocate the guest stack so that TDX
initialization code can allocate it itself and skip the allocation in
vm_arch_vcpu_add() in that case.

Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/include/x86/processor.h       |  2 ++
 tools/testing/selftests/kvm/lib/x86/processor.c | 17 ++++++++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 5c16507f9b2d..8fcc5118683e 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -1111,6 +1111,8 @@ static inline void vcpu_clear_cpuid_feature(struct kvm_vcpu *vcpu,
 	vcpu_set_or_clear_cpuid_feature(vcpu, feature, false);
 }
 
+vm_vaddr_t kvm_allocate_vcpu_stack(struct kvm_vm *vm);
+
 uint64_t vcpu_get_msr(struct kvm_vcpu *vcpu, uint64_t msr_index);
 int _vcpu_set_msr(struct kvm_vcpu *vcpu, uint64_t msr_index, uint64_t msr_value);
 
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index b2a4b11ac8c0..1eae92957456 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -687,12 +687,9 @@ void vcpu_arch_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
 	vcpu_regs_set(vcpu, &regs);
 }
 
-struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
+vm_vaddr_t kvm_allocate_vcpu_stack(struct kvm_vm *vm)
 {
-	struct kvm_mp_state mp_state;
-	struct kvm_regs regs;
 	vm_vaddr_t stack_vaddr;
-	struct kvm_vcpu *vcpu;
 
 	stack_vaddr = __vm_vaddr_alloc(vm, DEFAULT_STACK_PGS * getpagesize(),
 				       DEFAULT_GUEST_STACK_VADDR_MIN,
@@ -713,6 +710,15 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
 		    "__vm_vaddr_alloc() did not provide a page-aligned address");
 	stack_vaddr -= 8;
 
+	return stack_vaddr;
+}
+
+struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
+{
+	struct kvm_mp_state mp_state;
+	struct kvm_regs regs;
+	struct kvm_vcpu *vcpu;
+
 	vcpu = __vm_vcpu_add(vm, vcpu_id);
 	vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
 	vcpu_init_sregs(vm, vcpu);
@@ -721,7 +727,8 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
 	/* Setup guest general purpose registers */
 	vcpu_regs_get(vcpu, &regs);
 	regs.rflags = regs.rflags | 0x2;
-	regs.rsp = stack_vaddr;
+	if (vm->type != KVM_X86_TDX_VM)
+		regs.rsp = kvm_allocate_vcpu_stack(vm);
 	vcpu_regs_set(vcpu, &regs);
 
 	/* Setup the MP state */
-- 
2.51.0.rc1.193.gad69d77794-goog


