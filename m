Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDC3762567
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 00:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjGYWCy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 18:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjGYWCb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 18:02:31 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5832683
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:02 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c0f35579901so6803954276.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690322515; x=1690927315;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l8eGH3ygkEuOZ47kPtRCFJ0Al+rLHkYn4Wu/qaGwYZM=;
        b=O17YNG6iB0Xuh4somHJCNJmASI+hOdC7ojhwp+u2xlNX1R/ARIPn1a0k7tjNGhauj2
         zcBPtQMLfj/2W8F4tuFrQR95cMghpvw/FK9lx5CX5ChaYCdshhd51esu2R2JWlpyMuSW
         QxP1xK0js/vQpIhJDEuhP/THWdKt4dLB0ayY0zuv+om2hRM6McyNf5NT4EdJKjHH3UXu
         OjPzpTVFLXhqL5GjLLIA/1yisaB1eZnuTi0jJMtn+/Zam3XSYRwDkAZaF/prH00agAYk
         mDqlZ1yaom1FLS5qGHOQLL4ySmzuuMR+AIDjAaeYhvaLfm41dkF0SqeZvvMXbut1rZrS
         w6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690322515; x=1690927315;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l8eGH3ygkEuOZ47kPtRCFJ0Al+rLHkYn4Wu/qaGwYZM=;
        b=F+IypqvQwuKrXB4bib/cFXzLg9MnJEJu2GM9638z7YNDUPlptVpIDMO6xQ5V0SPeef
         6zhThvtgxo3wQT8TC0KAv5drEQI8KnfX5tVufCdgOQLrKoInKrCFXvBcsbgZGA0gMdzx
         2WmqGt9IvhT8bfh6QCFr5MH1RAL3h8dbqW+5Ua2MEPGuCcUiEy0RhjGMw0Ow1wcQvoH0
         WD/cu0lzPDUGJuBysb+jTPZ7SbkGYIzuAezG3E52TP+l2+wexrjx7q5FMsn2JxIse3Dk
         rtIGsizb1hJRWYl4+IdKn8CeOq5QT6keWs61F1d0psnKTd2+UqPldi086ZI9ews7KmS7
         NZUA==
X-Gm-Message-State: ABy/qLZV9YtXGU1JIDQSnTsDdJKM2M6pJ78PXAZtP3xLoWBahYnSMRm9
        yayQTioLtbG8yQbBU3AOJdeLN6vJeKS/3UX94m7W/GM2gl/A7f6Y9ILKyvN00ZgOZL8dKvgtJCk
        ba5/qoa22fiGRTk1deFhXYcJ1xxGBhgkO3PweQSzBTpBmDzFcwbv5O2KJglVk+EHUyI6jdGz9xS
        ub
X-Google-Smtp-Source: APBJJlFegGohqWqOdSnA6IS8sXWJ8VHwoCGraN7Fw++Y6c88kB55gpqKOQlvPxRwGPoMkWW8QyxDbkskqqQz
X-Received: from afranji.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:47f1])
 (user=afranji job=sendgmr) by 2002:a25:abd2:0:b0:d05:e080:63c6 with SMTP id
 v76-20020a25abd2000000b00d05e08063c6mr2231ybi.9.1690322514251; Tue, 25 Jul
 2023 15:01:54 -0700 (PDT)
Date:   Tue, 25 Jul 2023 22:00:57 +0000
In-Reply-To: <20230725220132.2310657-1-afranji@google.com>
Mime-Version: 1.0
References: <20230725220132.2310657-1-afranji@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725220132.2310657-5-afranji@google.com>
Subject: [PATCH v4 04/28] KVM: selftests: Refactor steps in vCPU descriptor
 table initialization
From:   Ryan Afranji <afranji@google.com>
To:     linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, seanjc@google.com, isaku.yamahata@intel.com,
        sagis@google.com, erdemaktas@google.com, afranji@google.com,
        runanwang@google.com, shuah@kernel.org, drjones@redhat.com,
        maz@kernel.org, bgardon@google.com, jmattson@google.com,
        dmatlack@google.com, peterx@redhat.com, oupton@google.com,
        ricarkol@google.com, yang.zhong@intel.com, wei.w.wang@intel.com,
        xiaoyao.li@intel.com, pgonda@google.com, eesposit@redhat.com,
        borntraeger@de.ibm.com, eric.auger@redhat.com,
        wangyanan55@huawei.com, aaronlewis@google.com, vkuznets@redhat.com,
        pshier@google.com, axelrasmussen@google.com,
        zhenzhong.duan@intel.com, maciej.szmigiero@oracle.com,
        like.xu@linux.intel.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, ackerleytng@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ackerley Tng <ackerleytng@google.com>

Split the vCPU descriptor table initialization process into a few
steps and expose them:

+ Setting up the IDT
+ Syncing exception handlers into the guest

In kvm_setup_idt(), we conditionally allocate guest memory for vm->idt
to avoid double allocation when kvm_setup_idt() is used after
vm_init_descriptor_tables().

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Change-Id: I4a1229173a4e09d6a3770d4b67edc8cdfe83f868
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 .../selftests/kvm/include/x86_64/processor.h  |  2 ++
 .../selftests/kvm/lib/x86_64/processor.c      | 19 ++++++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index a4923f92460d..2a83a23801b0 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -1060,6 +1060,8 @@ struct idt_entry {
 	uint32_t offset2; uint32_t reserved;
 };
 
+void kvm_setup_idt(struct kvm_vm *vm, struct kvm_dtable *dt);
+void sync_exception_handlers_to_guest(struct kvm_vm *vm);
 void vm_init_descriptor_tables(struct kvm_vm *vm);
 void vcpu_init_descriptor_tables(struct kvm_vcpu *vcpu);
 void vm_install_exception_handler(struct kvm_vm *vm, int vector,
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 78dd918b9a92..4893a778fff5 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -1124,19 +1124,32 @@ void vm_init_descriptor_tables(struct kvm_vm *vm)
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
2.41.0.487.g6d72f3e995-goog

