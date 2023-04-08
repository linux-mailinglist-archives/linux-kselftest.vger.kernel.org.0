Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F5C6DB8AF
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Apr 2023 06:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjDHEAl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 8 Apr 2023 00:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjDHEAj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 8 Apr 2023 00:00:39 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D94FD328;
        Fri,  7 Apr 2023 21:00:38 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id o2so437684plg.4;
        Fri, 07 Apr 2023 21:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680926438; x=1683518438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wabldjhu/02X2JJW8O7n2Z864dAbSSqTLFqNFx+My70=;
        b=JTmIzZ97Hwc1Xw27MfSLoRxRIsROvw+4QgNpPD9hZgcoE9hXjz05DOa5TaCHmLa1dJ
         3yV4k+y7djs+VTd2uNFiTevjsJ53lzMgPwUX0mTfICg0YDeogpPE0qN1i7gQ3/xvGJr8
         TjqXqqqrKykOFO1iMJ5qEOR5aLDnkw3immHcJJExz9MZQO/ymz5tDlS4pDfrhBb7MnUk
         Erd9Y28GG6e/bo3DTtiddMCzd/0yH06Yjz42g1mYCmOFlBa8Vjz0fUmxmWYZ+p+nPxFn
         f3NshmMgTWZFlnfJJYlmSoMnTnu2UJCXw9ljyQBqueYjleAHda/EKVJ3z+dp1t3pjxeX
         em7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680926438; x=1683518438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wabldjhu/02X2JJW8O7n2Z864dAbSSqTLFqNFx+My70=;
        b=Lgbau0wfJy0YfbhudyYqxG9iJp+SV2TZzeGPAhb4deN85t36KtIEW1hB6cwVHs4N14
         4m3dXfcFMMvaJro0ZABLudhO7PDpJs99vjO+jigVf5xIwn2fE9yC/eBgNDubwFkUhQ6O
         5gnMPnASuSdZOKIX8cDVIjEm4sKEK7IRJC8TAUgqR9dRDzZKDNAKVDr4Bpi/kGBenfk5
         p5fe/NlUerzDp2pHXwxWhtCYPdudTi9t6EnVvAI88AGtniKxPUvWp7Nkm26wfUiYGv3x
         q/KmeDrAZYBt1u/eK6Yd2qMroeaR1UHaVNpmy1wMQ9nlVQuFSwEymRT8RLNb72kDcc4R
         74+A==
X-Gm-Message-State: AAQBX9feeBGyDDVpWtnguebb21hrKngR2J2peFpgmwKP599d/0LMb+Ge
        SDu83juBPEOUB9roUC43G7k=
X-Google-Smtp-Source: AKy350YLQKQghQT0ucNp7Db4+0BINAIZLNFE5tfU3TnEkwDBAL2fpZ8rSiG1/1xn1tnDyt2EhBqkJQ==
X-Received: by 2002:a05:6a20:4a30:b0:d9:e45d:95cd with SMTP id fr48-20020a056a204a3000b000d9e45d95cdmr4380267pzb.17.1680926437804;
        Fri, 07 Apr 2023 21:00:37 -0700 (PDT)
Received: from wheely.local0.net ([203.59.189.25])
        by smtp.gmail.com with ESMTPSA id o12-20020a056a001bcc00b006328ee1e56csm263872pfw.2.2023.04.07.21.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 21:00:37 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>, Shuah Khan <shuah@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/4] KVM: selftests: Move pgd_created check into virt_pgd_alloc
Date:   Sat,  8 Apr 2023 14:00:17 +1000
Message-Id: <20230408040020.868929-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230408040020.868929-1-npiggin@gmail.com>
References: <20230408040020.868929-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

virt_arch_pgd_alloc all do the same test and set of pgd_created. Move
this into common code.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tools/testing/selftests/kvm/include/kvm_util_base.h | 5 +++++
 tools/testing/selftests/kvm/lib/aarch64/processor.c | 4 ----
 tools/testing/selftests/kvm/lib/riscv/processor.c   | 4 ----
 tools/testing/selftests/kvm/lib/s390x/processor.c   | 4 ----
 tools/testing/selftests/kvm/lib/x86_64/processor.c  | 7 ++-----
 5 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index fbc2a79369b8..16425da16861 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -821,7 +821,12 @@ void virt_arch_pgd_alloc(struct kvm_vm *vm);
 
 static inline void virt_pgd_alloc(struct kvm_vm *vm)
 {
+	if (vm->pgd_created)
+		return;
+
 	virt_arch_pgd_alloc(vm);
+
+	vm->pgd_created = true;
 }
 
 /*
diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
index 5972a23b2765..76edd988178b 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
@@ -79,13 +79,9 @@ void virt_arch_pgd_alloc(struct kvm_vm *vm)
 {
 	size_t nr_pages = page_align(vm, ptrs_per_pgd(vm) * 8) / vm->page_size;
 
-	if (vm->pgd_created)
-		return;
-
 	vm->pgd = vm_phy_pages_alloc(vm, nr_pages,
 				     KVM_GUEST_PAGE_TABLE_MIN_PADDR,
 				     vm->memslots[MEM_REGION_PT]);
-	vm->pgd_created = true;
 }
 
 static void _virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
index d146ca71e0c0..7695ba2cd369 100644
--- a/tools/testing/selftests/kvm/lib/riscv/processor.c
+++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
@@ -57,13 +57,9 @@ void virt_arch_pgd_alloc(struct kvm_vm *vm)
 {
 	size_t nr_pages = page_align(vm, ptrs_per_pte(vm) * 8) / vm->page_size;
 
-	if (vm->pgd_created)
-		return;
-
 	vm->pgd = vm_phy_pages_alloc(vm, nr_pages,
 				     KVM_GUEST_PAGE_TABLE_MIN_PADDR,
 				     vm->memslots[MEM_REGION_PT]);
-	vm->pgd_created = true;
 }
 
 void virt_arch_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr)
diff --git a/tools/testing/selftests/kvm/lib/s390x/processor.c b/tools/testing/selftests/kvm/lib/s390x/processor.c
index 15945121daf1..358e03f09c7a 100644
--- a/tools/testing/selftests/kvm/lib/s390x/processor.c
+++ b/tools/testing/selftests/kvm/lib/s390x/processor.c
@@ -17,16 +17,12 @@ void virt_arch_pgd_alloc(struct kvm_vm *vm)
 	TEST_ASSERT(vm->page_size == 4096, "Unsupported page size: 0x%x",
 		    vm->page_size);
 
-	if (vm->pgd_created)
-		return;
-
 	paddr = vm_phy_pages_alloc(vm, PAGES_PER_REGION,
 				   KVM_GUEST_PAGE_TABLE_MIN_PADDR,
 				   vm->memslots[MEM_REGION_PT]);
 	memset(addr_gpa2hva(vm, paddr), 0xff, PAGES_PER_REGION * vm->page_size);
 
 	vm->pgd = paddr;
-	vm->pgd_created = true;
 }
 
 /*
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index c39a4353ba19..d49068045bdf 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -126,11 +126,8 @@ void virt_arch_pgd_alloc(struct kvm_vm *vm)
 	TEST_ASSERT(vm->mode == VM_MODE_PXXV48_4K, "Attempt to use "
 		"unknown or unsupported guest mode, mode: 0x%x", vm->mode);
 
-	/* If needed, create page map l4 table. */
-	if (!vm->pgd_created) {
-		vm->pgd = vm_alloc_page_table(vm);
-		vm->pgd_created = true;
-	}
+	/* Create page map l4 table. */
+	vm->pgd = vm_alloc_page_table(vm);
 }
 
 static void *virt_get_pte(struct kvm_vm *vm, uint64_t *parent_pte,
-- 
2.40.0

