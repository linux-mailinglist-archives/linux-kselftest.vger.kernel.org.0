Return-Path: <linux-kselftest+bounces-40732-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91349B432F0
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 08:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67F0A1C244D1
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 06:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1182882BD;
	Thu,  4 Sep 2025 06:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GxEoezQx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7146E2874F3
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Sep 2025 06:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756968910; cv=none; b=nIfeFR4L2LdrTvpg4z0lyAYLUNbMNG4tHnOZsjairLbuouu/NYpveeMdiX0Cj79AEs0afeB73ndHzkWEWY19ID12er42HeOn5se25xlQfuE8ow28YBio0pWYSFSbQd0Hozs5mbyH48K4uY2Z28oQxQJFI0hgKApfMiRkZ4C0nFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756968910; c=relaxed/simple;
	bh=EiTLc0aW13p3IiS4aBuoOV83AeEk06GWH67Cf3kqWJg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HI05r9CkTV2+OmUJ74lFMjQJDw4TxpkNNjQU6R34/1jOUPjiTSKRvuPklOG1BYnSFPOATVi/TbW60zZgP4p0s3PDAvUm6Ofre/gqEPpJI7LaLbVPRY3DW1yPVylCgKaZyetIj7XAwJzjmqeJvnKpQIn7EzxUq9IIEulG5usWicI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GxEoezQx; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-77260b29516so1374501b3a.3
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Sep 2025 23:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756968908; x=1757573708; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1UaVfX3zOkLGXHSP9oRgmeXGU19apvDwL7UQ/Q2BpRU=;
        b=GxEoezQxKnUka0cwSSbPiQF0IAWgGCxO8qGkrM4U24+hFafJy59xgwqmz58QjpgAvC
         QSxjETZkJ11dMoFk2XYcZpk7Fhaf6Zk11FVHOcqxF2O0Y3tCf/Bq4ASKqBkAIUrd/jT8
         U05MEwT74SGXRADN7FN89reVjG6yI/+Ms6zZ654fLServUyqNrcg702yWSF+zWoR0/IT
         8Pc/wL1Z7/8p+1FF0/nEYM1NcYjNH9Xb8KYH8imO//XV+6kFVakKz/x4Fpb923UHFN9A
         0zvtXgZfaFMq1aN2uwQfo7nn3yrOvXbcDOxlInkDWDm112Fez3PA7kPy1M8G6/ACLUSv
         W9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756968908; x=1757573708;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1UaVfX3zOkLGXHSP9oRgmeXGU19apvDwL7UQ/Q2BpRU=;
        b=ouSmMVgYJrFx/zRAPfCtlQvq4GKQnVV+spW3gN/p3hzze3yfuOXaLuzUCH/5I33727
         tyrbrGIBZU+7hJpy900472WJk+bKaUfFrE04KpGM+i/m5krmsdpTwRmVCaN7KJPWqyBS
         FtcI7AR4rQ7X5SscgBVcWyMoox4XLHmCE/sJ7t1aZekh481kOG7kSvpalyIFKsg9cwCL
         EI18fCFQ1L0VpqiFQzuoS06JYsvWnPAxYaid3QkntNnwBVz/N2hEy69s52cO5JAGVZvT
         wyX+Uztle9Zyvdp8g0HV3pnHwonXDab9/7CcMUI8gYt2gw8KQ+4O5rv2XY6R6qjHs7hL
         m9rg==
X-Gm-Message-State: AOJu0YwsZ3ndow7gpHtC21xZ3uLf6mEW+R0QfH8CbX+xjV7EDn1d391t
	qumygfb8AzQxqroWkQf6OatU6k3yRmULGhnXYHvg29exW8IPLlkc32wO+GAEyGbe3VCjmK1RjYI
	0uz+ZbjnA93BIZpWTmCRtXTOAfTQG2mYBNREVyUWhr1Jno4RDZPJJ0TZKx8+/iSTR+vuFeDIZaC
	QyQnSLUVRXP92VRMuxrcOM0cOh6+fcYBooxAhwmM9nD1Q=
X-Google-Smtp-Source: AGHT+IFXT+7TET6eQLNfnMbWm2CfkiHvtD2nLGJIyq17+osdVfH3IRuTMKDNhIPImZxMhUnt6NxzFYe7Cg==
X-Received: from pfch21.prod.google.com ([2002:a05:6a00:1715:b0:76e:396a:e2dd])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e0d:b0:772:88b7:5a
 with SMTP id d2e1a72fcca58-77288b70399mr3947136b3a.16.1756968907464; Wed, 03
 Sep 2025 23:55:07 -0700 (PDT)
Date: Wed,  3 Sep 2025 23:54:33 -0700
In-Reply-To: <20250904065453.639610-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904065453.639610-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904065453.639610-4-sagis@google.com>
Subject: [PATCH v10 03/21] KVM: selftests: Expose function to allocate guest
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
 .../selftests/kvm/include/x86/processor.h        |  2 ++
 tools/testing/selftests/kvm/lib/x86/processor.c  | 16 +++++++++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index f610c09cadf4..8e75df5e6bc9 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -1109,6 +1109,8 @@ static inline void vcpu_clear_cpuid_feature(struct kvm_vcpu *vcpu,
 	vcpu_set_or_clear_cpuid_feature(vcpu, feature, false);
 }
 
+vm_vaddr_t kvm_allocate_vcpu_stack(struct kvm_vm *vm);
+
 uint64_t vcpu_get_msr(struct kvm_vcpu *vcpu, uint64_t msr_index);
 int _vcpu_set_msr(struct kvm_vcpu *vcpu, uint64_t msr_index, uint64_t msr_value);
 
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 83efcf48faad..82369373e843 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -658,12 +658,9 @@ void vcpu_arch_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
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
@@ -684,6 +681,15 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
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
@@ -692,7 +698,7 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
 	/* Setup guest general purpose registers */
 	vcpu_regs_get(vcpu, &regs);
 	regs.rflags = regs.rflags | 0x2;
-	regs.rsp = stack_vaddr;
+	regs.rsp = kvm_allocate_vcpu_stack(vm);
 	vcpu_regs_set(vcpu, &regs);
 
 	/* Setup the MP state */
-- 
2.51.0.338.gd7d06c2dae-goog


