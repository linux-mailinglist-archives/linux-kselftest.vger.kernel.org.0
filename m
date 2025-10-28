Return-Path: <linux-kselftest+bounces-44215-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D8743C16ED4
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 22:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF36F5018C2
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 21:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A89B35502C;
	Tue, 28 Oct 2025 21:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZgAxBpzV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EED6351FCE
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 21:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686462; cv=none; b=RlUdZ2l4hq/mpxc3CqULc2JTlt7fA38UkJhy6mbErpCNxz/7e7/Giqh8Z6NJ7wLSOmB9l6G/djXfDFsWBL0bHz5Q+UW/SlD0TbxACftxrFwUkQT68hUeUoqA5Y4YzuhsJuNddAGkLnIm+/zziyRPV7hF0fawRXRSaoWep5VZL64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686462; c=relaxed/simple;
	bh=VNH8CVMDxJFBcdGyaCU6T3UG3e69/KCqyLabtu2cxdc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XY4jsIHF1U1zNjxaCbKukmEAZDFEh0PDhsH+o8LfauwCwCPdnrFCGKNXm2vGxCnt58vpAluWMoyzv0AuarpcUslKnywgPolerSUsPBmG/8e+RAz8CpX9JfMG5EZ1cUNHPJZfmUAdNWHEuXwfB3lx8kR0VNUYMfSvCkSnrLIRrYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZgAxBpzV; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-927b19c5023so589770639f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 14:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761686459; x=1762291259; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MRyTmAGtbiYLKRxGX8ofD+iepUQ9YVHFIToGKiZ3XDM=;
        b=ZgAxBpzVX8AMJA9Fs6m532VsE/E7TSXyDmj7h9FkZUf4PIosuaY7ObF2ov5y0MGt2Y
         TCcz6VKB8nCxiDJfbzP1CA6bSApwDJpRsmlRU8+5SwXwiaeVrQjll9mIV9YbOYwO1IxK
         dMX4RwbGTVOan5IsNp/zf6MvLIUjOwxPx4O5kSwyPO99FeRmbKeEZkc0uO4SnO/k5NIf
         BhOtN88jxNk9/d1dOTb75V04w2nK6GxRbRV2yllSqM5L4HWPolHhytdx5NbXA0DH0tKQ
         CUGezb+/UIMSJykNmK81nTh7ou3V/fDnDhvS1GgKDUT9nA59APMOfRrjHT0sTczhGF+h
         z25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686459; x=1762291259;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MRyTmAGtbiYLKRxGX8ofD+iepUQ9YVHFIToGKiZ3XDM=;
        b=XcrADFfZwfcKLJNSQw15qP/PculpyZamwzvRw6IHmQBAXNy35IpapTF5geQXPcTK2Z
         oXfXSfS8sp6etvSFXOAIoA58miuqqnNm4wudO25n5ky11l5wCDaKBtmHcMw5LH0t+I2Y
         IrXbQvBePZ50JumfDhlcMyW2mUIH1HyaMB7glcV/tHLOigArI5a3m9VUnFdV+19CQ59N
         M8Q5eviADLevzArJBjjKYY9xFhMmbmqkmhcfKUPgztk0rDsDocQezvDTagyc2AyJPjAp
         BEbrvP5PBhi3dwU+qK6/6JuNTtQCCgn+brUweClQJniN9fhBnDZYCl8e2N0K8wNdvQ6F
         QX3w==
X-Gm-Message-State: AOJu0YyGsBR3Nfudvj2ccRZ3by3m1mzS45hG3qsEB/KXTANPSXQUu16i
	LY+0AMmX5nJ7gPFrQjdaz6gDqpbESZNiy8N0lpmM7Gvj1oDWKppuEkGTYlp8Sdwc6mrkqWandPD
	oweUyfFrgbaXWPVwgzA4LUZSX54TapntVFee2qGS5SBKQyjo6vKGQz2jVVFmbWLY3KfGThe/Laj
	txMcHl/n8JeJe9FFyg6ie0X3paytmrOAnY67JrlsBpUnM=
X-Google-Smtp-Source: AGHT+IEX2M8sMJYKjNjzv/RmBBD8GS/LYH1pfDM4GVeERde8ju9RTg31W/Ttu3uV9D7jJVP3Fiol92LL7A==
X-Received: from iobjh17.prod.google.com ([2002:a05:6602:7191:b0:945:a321:1fc4])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6602:6d88:b0:887:56f5:26a2
 with SMTP id ca18e2360f4ac-945c981ed55mr148376039f.14.1761686459397; Tue, 28
 Oct 2025 14:20:59 -0700 (PDT)
Date: Tue, 28 Oct 2025 21:20:30 +0000
In-Reply-To: <20251028212052.200523-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028212052.200523-1-sagis@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028212052.200523-5-sagis@google.com>
Subject: [PATCH v12 04/23] KVM: selftests: Expose function to allocate guest
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

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/include/x86/processor.h        |  2 ++
 tools/testing/selftests/kvm/lib/x86/processor.c  | 16 +++++++++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 9caeb3de7df6..dba2b3d558d1 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -1120,6 +1120,8 @@ static inline void vcpu_clear_cpuid_feature(struct kvm_vcpu *vcpu,
 	vcpu_set_or_clear_cpuid_feature(vcpu, feature, false);
 }
 
+vm_vaddr_t kvm_allocate_vcpu_stack(struct kvm_vm *vm);
+
 uint64_t vcpu_get_msr(struct kvm_vcpu *vcpu, uint64_t msr_index);
 int _vcpu_set_msr(struct kvm_vcpu *vcpu, uint64_t msr_index, uint64_t msr_value);
 
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 2d1544e8af6c..2898fe4f6de4 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -693,12 +693,9 @@ void vcpu_arch_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
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
@@ -719,6 +716,15 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
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
@@ -727,7 +733,7 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
 	/* Setup guest general purpose registers */
 	vcpu_regs_get(vcpu, &regs);
 	regs.rflags = regs.rflags | 0x2;
-	regs.rsp = stack_vaddr;
+	regs.rsp = kvm_allocate_vcpu_stack(vm);
 	vcpu_regs_set(vcpu, &regs);
 
 	/* Setup the MP state */
-- 
2.51.1.851.g4ebd6896fd-goog


