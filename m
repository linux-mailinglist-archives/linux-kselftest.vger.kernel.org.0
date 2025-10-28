Return-Path: <linux-kselftest+bounces-44228-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37111C16F61
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 22:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E885420B7E
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 21:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC12F3590A4;
	Tue, 28 Oct 2025 21:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pDez+d29"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959723587C5
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 21:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686474; cv=none; b=TVbaNk5VkDkC3ZB9A4Cd3g9S0C90s9O+XCaQHPuhB44qMaAyVbRcI2WViaPM5pHdvfUJheoV5J1gVDwzP4N5W3bVhq5ojP/SJxwr4fymt9w2ZsetXV/l0IczGjhx/GJ6qXrEtoWFr6AaeiLx5qWUVO3h6fCaGZDkDasM5ogCx8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686474; c=relaxed/simple;
	bh=FNuIYYaTDnExBaJlJLyltrsAwMmyaJqObjpLAPe8cjE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GDHgL+42zKhsMYweMCk6o/3q8nzsW2BaJjXzXkALTD6jCWxRTiohi9AU8O+EXsJPKNoM8o1aHzegILwTh2GEst4gEtwY7S7ikKLtUxQfMXdXgUaQZB8uiD9mxkQw7Aax8oNP9KWQ6MvH5N4XCaaUj8GeDs7YcQbspltZ+6yavjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pDez+d29; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-925332ba890so1806676739f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 14:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761686472; x=1762291272; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wtNpCTnCzrMlYFhLw7qwZUR1YJujCF7DVHm7Qw4COQg=;
        b=pDez+d29ZUBLyQ2z+W4MxL17R9bxZzpkYFI+0uoSoAcHHhNmx3F6IL/QOVdQx+5jB6
         kwoFy1qMOQCOa+aZ1wuuooglZq+dy8ayyD9BXBiKD+PWiJCLQHD3ZCoSwhrFT6lM4iPR
         c4gWuiil9aBtofSQfHw4Lx7+OSSHoIctke40GBKXgdYHXAIxD+8lBHr4vLCxCTx8rJDk
         EfmzVBuDWqS04QdwdIAaBosmAV6V0xO4CLGwyVt/rJ2RFLB6ITfjCjLK96VftOMLpaj0
         a5YQcL8RChK4nlnxJJeaL1Qd4AT/29d7iU/4Dlwcmy1EK0rlCd1zI+tFq1MyQWU7RXCw
         gT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686472; x=1762291272;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wtNpCTnCzrMlYFhLw7qwZUR1YJujCF7DVHm7Qw4COQg=;
        b=RSsW1QkUALEGkerhS41E8/Ghw8cX1h9nU/g4NZFa8HcaRGJpcX9a3hKepFZPDkWE7o
         yPWUs6ONUC31h5+E/tatxJHcAumVX5XGfQBVqz1z0/hhbDnFn+z60eSfobKPgRxktAY0
         a6S9+5IXbuYEnMcDUWipjPQgtabt85MkyP2F+nUKJFb31DYlyeVwrbQAiNgjzuQ7X1Bk
         kq0eRTEMrouJ3e4y7xNkjoVHUwjjn02WEGBhwWiA9qFMBOTg8Z8CAv4N1YmoQ9CUuMTk
         u6qr25lD7HbgPu3wA38rjw0Ohq81IHJAD+6Tkqj3TjwLoaNp0GzKCJMde70TYA55Ionl
         aC4Q==
X-Gm-Message-State: AOJu0YwWQbEj0yOnQuvJIfcIlZEH6fnCO4lSJMFLgkcuM4m4EfXKy3d7
	G6vD/uii/EzZ6/iQ7GrXj3BGie1VWky9NuNammzdxDyWAVGkVl8VzhUk7PtsCAagheZL/dv1Eqg
	k+fWx848v/334WisFEoH78VXEYMrSBMRBPKCTHXUwjvBDRebNtTXCAKeebu2mp2KQwKsEgj8Ppo
	hacPD0Bo9eAChBCLxkPuR7HMYKWcxFsrHKsZnT+fH/goU=
X-Google-Smtp-Source: AGHT+IE4wigd+sbcojUz5qHvrr7kF5OQrUZWBBxs3tohiwBFRj7c0ff5ucgIVmL3YMeSBqq9v4qFKvnm5A==
X-Received: from iobhd10.prod.google.com ([2002:a05:6602:680a:b0:945:af6f:682e])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6602:2d83:b0:945:abea:9f6a
 with SMTP id ca18e2360f4ac-945c9889dc5mr154675739f.19.1761686471591; Tue, 28
 Oct 2025 14:21:11 -0700 (PDT)
Date: Tue, 28 Oct 2025 21:20:43 +0000
In-Reply-To: <20251028212052.200523-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028212052.200523-1-sagis@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028212052.200523-18-sagis@google.com>
Subject: [PATCH v12 17/23] KVM: selftests: Call KVM_TDX_INIT_VCPU when
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
index 990f2769c5d8..036875fe140f 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -722,6 +722,19 @@ vm_vaddr_t kvm_allocate_vcpu_stack(struct kvm_vm *vm)
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
@@ -729,15 +742,21 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
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
2.51.1.851.g4ebd6896fd-goog


