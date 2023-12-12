Return-Path: <linux-kselftest+bounces-1727-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F65C80F81C
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 21:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70D191C20D96
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 20:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A57E7762D;
	Tue, 12 Dec 2023 20:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V05TFJWO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48C8CA
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 12:47:05 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d1b2153ba1so53428757b3.2
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 12:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702414025; x=1703018825; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x1lodvb6OtWfxjhf5SoaUUtA7ex1XZFNPc9w8OKKvUg=;
        b=V05TFJWOpwlhLd3k3oEhlQ0LTZ8oXfSmFksigdfx8HAUfSFJdOmSQHvqPGxZt5PrbS
         ZJrzdXRUlDa19nPAB9Im4bwuejasfYoRwtTbYtibufvUVZzePX35jBD7Q8hsicivC8ZO
         2UV+Yt65WPJ1LDBH1HParEl96fCwNr5/TbeHKw4j8Qr43mnhb0e4Z+YeTRSwd3TdKALe
         i/0Ez1XLfcJ2DF1hg3xGLq92PEhd+b0gVsS5IS7wPzgBAVdCklX7LtKQNxdeyJqRGIez
         f3QNnVtCDji5mHOO7O3hOegyQXQIlrNTd/YX1j9j018MR9/v9J9pcdOO90iJYvSdS4TW
         QyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702414025; x=1703018825;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x1lodvb6OtWfxjhf5SoaUUtA7ex1XZFNPc9w8OKKvUg=;
        b=PFZf46vId1g/7UtXisp/ZdBhLVx2yFRY2/HG31G4UBPp+3/6aUz1Pm17ZqU9cZeJgy
         I73OSOEGZLvFQd3XIgh3QuczAUw3owNACdWfZWhU5vfPUb/9fe43zpFJGVKDsLx1mwUv
         f/MwQMJrUhUlkovaeDKoXuBpsD3O0M6ckPqw4SbH0xXQjSwFew0fGUiN/Zi+PH/hZZDK
         GplcF45d3dkrCA9+w/9l5/W9PTlgDtzwmuKfL4PRSV53JQlVpljhlN5YMOSw3qfZcDYa
         26zJpuA9YZL4VatJXpkWjOjOst2wdUhToSdr+vmgUtoIDQ0lnUPt8ITAfj23xVhD6QHV
         sXbA==
X-Gm-Message-State: AOJu0Yz4TB0NvJ6gh7t2PMRNIIYTsgRWSQU7JjqFqoN0yxMdMsEUa3h3
	6LeUyXwasWRvH29/r8Ja9HOz7YyYo+yRIfgEzf1JO0e2Dg2OtKAwlgXM9eCSGe6SVbpt0xn+wZU
	iaydZwXWvA9OrPS1t7VMs0TJ83fWUfCG9mjEBvmH7uRnx9TdNG4mqUY4IKpLSIEmnb93nlGE=
X-Google-Smtp-Source: AGHT+IFA0fKoM26J8ai3StFQnJI6WfpZDk7m02MxQ8rkZS/AQ4lQ2xMjuz7+KEcD4kLjVBP5Xztzh7FZew==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a25:ab26:0:b0:da0:3117:f35 with SMTP id
 u35-20020a25ab26000000b00da031170f35mr56027ybi.3.1702414024705; Tue, 12 Dec
 2023 12:47:04 -0800 (PST)
Date: Tue, 12 Dec 2023 12:46:19 -0800
In-Reply-To: <20231212204647.2170650-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231212204647.2170650-1-sagis@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231212204647.2170650-5-sagis@google.com>
Subject: [RFC PATCH v5 04/29] KVM: selftests: Refactor steps in vCPU
 descriptor table initialization
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>, 
	Ryan Afranji <afranji@google.com>, Erdem Aktas <erdemaktas@google.com>, 
	Sagi Shahar <sagis@google.com>, Isaku Yamahata <isaku.yamahata@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Peter Gonda <pgonda@google.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Roger Wang <runanwang@google.com>, Vipin Sharma <vipinsh@google.com>, jmattson@google.com, 
	dmatlack@google.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

From: Ackerley Tng <ackerleytng@google.com>

Split the vCPU descriptor table initialization process into a few
steps and expose them:

+ Setting up the IDT
+ Syncing exception handlers into the guest

In kvm_setup_idt(), we conditionally allocate guest memory for vm->idt
to avoid double allocation when kvm_setup_idt() is used after
vm_init_descriptor_tables().

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/include/x86_64/processor.h  |  2 ++
 .../selftests/kvm/lib/x86_64/processor.c      | 19 ++++++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 0b8855d68744..5c4e9a27d9e2 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -1089,6 +1089,8 @@ struct idt_entry {
 	uint32_t offset2; uint32_t reserved;
 };
 
+void kvm_setup_idt(struct kvm_vm *vm, struct kvm_dtable *dt);
+void sync_exception_handlers_to_guest(struct kvm_vm *vm);
 void vm_init_descriptor_tables(struct kvm_vm *vm);
 void vcpu_init_descriptor_tables(struct kvm_vcpu *vcpu);
 void vm_install_exception_handler(struct kvm_vm *vm, int vector,
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index b6b9438e0a33..566d82829da4 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -1155,19 +1155,32 @@ void vm_init_descriptor_tables(struct kvm_vm *vm)
 			DEFAULT_CODE_SELECTOR);
 }
 
+void kvm_setup_idt(struct kvm_vm *vm, struct kvm_dtable *dt)
+{
+	if (!vm->idt)
+		vm->idt = vm_vaddr_alloc_page(vm);
+
+	dt->base = vm->idt;
+	dt->limit = NUM_INTERRUPTS * sizeof(struct idt_entry) - 1;
+}
+
+void sync_exception_handlers_to_guest(struct kvm_vm *vm)
+{
+	*(vm_vaddr_t *)addr_gva2hva(vm, (vm_vaddr_t)(&exception_handlers)) = vm->handlers;
+}
+
 void vcpu_init_descriptor_tables(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vm *vm = vcpu->vm;
 	struct kvm_sregs sregs;
 
 	vcpu_sregs_get(vcpu, &sregs);
-	sregs.idt.base = vm->idt;
-	sregs.idt.limit = NUM_INTERRUPTS * sizeof(struct idt_entry) - 1;
+	kvm_setup_idt(vcpu->vm, &sregs.idt);
 	sregs.gdt.base = vm->gdt;
 	sregs.gdt.limit = getpagesize() - 1;
 	kvm_seg_set_kernel_data_64bit(NULL, DEFAULT_DATA_SELECTOR, &sregs.gs);
 	vcpu_sregs_set(vcpu, &sregs);
-	*(vm_vaddr_t *)addr_gva2hva(vm, (vm_vaddr_t)(&exception_handlers)) = vm->handlers;
+	sync_exception_handlers_to_guest(vm);
 }
 
 void vm_install_exception_handler(struct kvm_vm *vm, int vector,
-- 
2.43.0.472.g3155946c3a-goog


