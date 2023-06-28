Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DFC741805
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 20:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjF1Saz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 14:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjF1Saz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 14:30:55 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFF61BE9
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Jun 2023 11:30:54 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-262dc0bab18so2329900a91.2
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Jun 2023 11:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687977053; x=1690569053;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ueHpMMvGqjRgBfgpfgl/iGq7B0H1Tdq44HndljUB2L8=;
        b=BizrC7/BsGstGZtcIJS0Qsu1R//5wSSkMFEFg3Pc23Qg2XQ1moE1TsenQrJrhhRV1E
         kECs0e9AyAoSwsTreqocvfNbnNEe780163mpmBChGwodJJu2aRauIkr0lDzH2MFXstvi
         h7foAENkBjj1CfEAmC2iU0bFn+IFPfjJIhEGKmEL1Naw+OYJvRpir/iVSiqNpWZ564H5
         v440XCeaCsqmJNBf6JzQBsKhZU6FLyerNqdeA1aO0JCQK1kosTjS0cr5vk8SZgL05oK/
         ssrOvxiASmUfk0JVd15EK8Uzu0iTxsFp65EZCqD6lxG2nMeUDqUTOBnpud/iq3j+E01W
         Y23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687977053; x=1690569053;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ueHpMMvGqjRgBfgpfgl/iGq7B0H1Tdq44HndljUB2L8=;
        b=HXJgBmaW7ghMXAehinlPD5PiF1julKTbolZw+DNel3ortQjVra00uWrLd79CpTEe6k
         z8g1g1dlI7McajJ3LD4cQINKi70KBTAaee3B/o8tfYYcbSONIow7CE4qk84sTFYZycpT
         ujIXkUPH6MQAwNR46m16eSjMZXSoXz21ADOeMIsdXqTkDvdmDk1ObYOvsY4yO9bJUmx5
         wkBOFGq1gM+B6NVzIR2uNJQYgo8dtmpBfMpwrn00SWPKp5h8u+POyd0wvmhEvHPYZsPb
         y+05ToOf212RtvA8VglxBdOLCxGOHVHg2SkS6QWg+1QuchwhfM9Dz2WhLvgmQEb0pSWf
         FSmw==
X-Gm-Message-State: AC+VfDzVqD0SKV5ZTFS77h3WKkyQDR3n9/shj6//kCHJeYYMASRIxpuR
        IJyj68MgniTFHE6vLegwsuUA/TTsb7c=
X-Google-Smtp-Source: ACHHUZ48vEGEz5ddHZxRDJM+Uc+tbhPZS9Q73x0oofnefC5lc94LCPVeQ6Cp49UOl6BTUpUDaW+mjQWMgpw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1488:b0:262:e394:f054 with SMTP id
 js8-20020a17090b148800b00262e394f054mr1809737pjb.2.1687977053514; Wed, 28 Jun
 2023 11:30:53 -0700 (PDT)
Date:   Wed, 28 Jun 2023 11:30:52 -0700
In-Reply-To: <20230408040020.868929-2-npiggin@gmail.com>
Mime-Version: 1.0
References: <20230408040020.868929-1-npiggin@gmail.com> <20230408040020.868929-2-npiggin@gmail.com>
Message-ID: <ZJx8XCJwfSif1Ahc@google.com>
Subject: Re: [PATCH v2 1/4] KVM: selftests: Move pgd_created check into virt_pgd_alloc
From:   Sean Christopherson <seanjc@google.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Apr 08, 2023, Nicholas Piggin wrote:
> virt_arch_pgd_alloc all do the same test and set of pgd_created. Move
> this into common code.

Can you give virt_arch_dump() and addr_gva2gpa() the same treatment?  E.g. either
in one patch or in separate patches:

---
 tools/testing/selftests/kvm/include/kvm_util_base.h | 4 +++-
 tools/testing/selftests/kvm/lib/aarch64/processor.c | 6 ------
 tools/testing/selftests/kvm/lib/powerpc/processor.c | 3 ---
 tools/testing/selftests/kvm/lib/riscv/processor.c   | 6 ------
 tools/testing/selftests/kvm/lib/s390x/processor.c   | 3 ---
 tools/testing/selftests/kvm/lib/x86_64/processor.c  | 3 ---
 6 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index e52405c9fa8b..2545d65483f3 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -908,6 +908,7 @@ vm_paddr_t addr_arch_gva2gpa(struct kvm_vm *vm, vm_vaddr_t gva);
 
 static inline vm_paddr_t addr_gva2gpa(struct kvm_vm *vm, vm_vaddr_t gva)
 {
+	TEST_ASSERT(vm->pgd_created, "No guest mappings have been estalished");
 	return addr_arch_gva2gpa(vm, gva);
 }
 
@@ -930,7 +931,8 @@ void virt_arch_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent);
 
 static inline void virt_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
 {
-	virt_arch_dump(stream, vm, indent);
+	if (vm->pgd_created)
+		virt_arch_dump(stream, vm, indent);
 }
 
 
diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
index 3da3ec7c5b23..932fa9d350af 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
@@ -157,9 +157,6 @@ uint64_t *virt_get_pte_hva(struct kvm_vm *vm, vm_vaddr_t gva)
 {
 	uint64_t *ptep;
 
-	if (!vm->pgd_created)
-		goto unmapped_gva;
-
 	ptep = addr_gpa2hva(vm, vm->pgd) + pgd_index(vm, gva) * 8;
 	if (!ptep)
 		goto unmapped_gva;
@@ -222,9 +219,6 @@ void virt_arch_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
 	int level = 4 - (vm->pgtable_levels - 1);
 	uint64_t pgd, *ptep;
 
-	if (!vm->pgd_created)
-		return;
-
 	for (pgd = vm->pgd; pgd < vm->pgd + ptrs_per_pgd(vm) * 8; pgd += 8) {
 		ptep = addr_gpa2hva(vm, pgd);
 		if (!*ptep)
diff --git a/tools/testing/selftests/kvm/lib/powerpc/processor.c b/tools/testing/selftests/kvm/lib/powerpc/processor.c
index 57d64d281467..589c5eb15abf 100644
--- a/tools/testing/selftests/kvm/lib/powerpc/processor.c
+++ b/tools/testing/selftests/kvm/lib/powerpc/processor.c
@@ -246,9 +246,6 @@ void virt_arch_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
 {
 	vm_paddr_t pt = vm->pgd;
 
-	if (!vm->pgd_created)
-		return;
-
 	virt_dump_pt(stream, vm, pt, 0, 1, indent);
 }
 
diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
index 7695ba2cd369..251581364643 100644
--- a/tools/testing/selftests/kvm/lib/riscv/processor.c
+++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
@@ -111,9 +111,6 @@ vm_paddr_t addr_arch_gva2gpa(struct kvm_vm *vm, vm_vaddr_t gva)
 	uint64_t *ptep;
 	int level = vm->pgtable_levels - 1;
 
-	if (!vm->pgd_created)
-		goto unmapped_gva;
-
 	ptep = addr_gpa2hva(vm, vm->pgd) + pte_index(vm, gva, level) * 8;
 	if (!ptep)
 		goto unmapped_gva;
@@ -162,9 +159,6 @@ void virt_arch_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
 	int level = vm->pgtable_levels - 1;
 	uint64_t pgd, *ptep;
 
-	if (!vm->pgd_created)
-		return;
-
 	for (pgd = vm->pgd; pgd < vm->pgd + ptrs_per_pte(vm) * 8; pgd += 8) {
 		ptep = addr_gpa2hva(vm, pgd);
 		if (!*ptep)
diff --git a/tools/testing/selftests/kvm/lib/s390x/processor.c b/tools/testing/selftests/kvm/lib/s390x/processor.c
index 358e03f09c7a..39f4b87b9b15 100644
--- a/tools/testing/selftests/kvm/lib/s390x/processor.c
+++ b/tools/testing/selftests/kvm/lib/s390x/processor.c
@@ -145,9 +145,6 @@ static void virt_dump_region(FILE *stream, struct kvm_vm *vm, uint8_t indent,
 
 void virt_arch_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
 {
-	if (!vm->pgd_created)
-		return;
-
 	virt_dump_region(stream, vm, indent, vm->pgd);
 }
 
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index d4deb2718e86..32ed0eba3fbd 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -307,9 +307,6 @@ void virt_arch_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
 	uint64_t *pde, *pde_start;
 	uint64_t *pte, *pte_start;
 
-	if (!vm->pgd_created)
-		return;
-
 	fprintf(stream, "%*s                                          "
 		"                no\n", indent, "");
 	fprintf(stream, "%*s      index hvaddr         gpaddr         "

base-commit: 84e95f5585f25b5199e23c8547867616337103bd
-- 
