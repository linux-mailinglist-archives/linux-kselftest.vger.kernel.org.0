Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9399F77334F
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 01:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjHGXCb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 19:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjHGXCL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 19:02:11 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76AA1FEB
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Aug 2023 16:01:51 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-584126c65d1so59491717b3.3
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Aug 2023 16:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691449310; x=1692054110;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/9gOMf8CCEdwWA0iNCqRkk5ADeV+gCZbuh7Q87rmQao=;
        b=rVjslmt7PSMAvIXx1/0lnOTs1uidu2pd6MwAtjXg1BJCgGiswAFxbp+++vbV00nz1C
         mP5FjKvxw3fVLnrTV9OEgaDRwI1UhHdFG7sOpwC2Z1Quk+yHZLS5jsXGTh1LxOTFcsl1
         +ZbYET4l4TyZbPdW3Kzr+L2Uqg1/oB9OZfxr3g5sjZEdoxesh/XIQg4+s7XBqtfjO4r1
         JhtWPyqglk0oIjBk3RcMgWyniTAKu+Ln1v/qPXePbFdqPwSuMShil7b6DcdfXZYAL/KU
         6YtHnfdC1+brh7t3JX4jhFM3n7enc6fRK02z5AJ4UKsvLX6ABMqW/j5nw73bgssBZv5v
         refg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449310; x=1692054110;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/9gOMf8CCEdwWA0iNCqRkk5ADeV+gCZbuh7Q87rmQao=;
        b=IFOba6A/Os+939fr8XbbdNtX9q3XN/5abKAuwBHPh1/Ko4dpeFQJjLNOvlIDtGNuA3
         OidisiKKoSWqcklGKUkAHZwbsLsNLtr+NmWEQwmudtH/YKQt8Gke1ufLwjo+fBBuQnfi
         HkMyniv4HBE+vY/pPI4WnCDKg4sDgvvWe6qWX8pcrkPmNNjG6hYUmGVEgqdSwe0l5P17
         zeuo92yaBDu8Wn6WuvXCMO4GvLwmE64G1rc5GTXCq6dQJSqsIW6kEpC9AzEEj+L4G2N0
         LRN5ltHFOWBdGww5/Fd5fa5yfyktVc2N3ltOj/zKHAf8bjzuepi2nWRQBOULUO1LYixi
         UAiw==
X-Gm-Message-State: AOJu0YyVTS42PKT7AjW69rDsOeUnPBjD4mFRo2pA/rmE7jjbPqs1aY8X
        Rrx8KXbbltdiHBp1jJ79qv2dXm2zu4T3Up8iaA==
X-Google-Smtp-Source: AGHT+IHCH2KbwO0St5/n0W3d3/SksT/droDwB5ND4gm7g2AP+5TLTNE/45MztZE+3byyt5hBlNFPdhUO0d6xVnsMNQ==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a81:ae1b:0:b0:579:f832:74b with SMTP
 id m27-20020a81ae1b000000b00579f832074bmr107515ywh.10.1691449310023; Mon, 07
 Aug 2023 16:01:50 -0700 (PDT)
Date:   Mon,  7 Aug 2023 23:01:14 +0000
In-Reply-To: <cover.1691446946.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1691446946.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <49b8587dab22fe1c0e31444a27e47246d2615a58.1691446946.git.ackerleytng@google.com>
Subject: [RFC PATCH 11/11] KVM: selftests: Add tests for migration of private mem
From:   Ackerley Tng <ackerleytng@google.com>
To:     pbonzini@redhat.com, seanjc@google.com, tglx@linutronix.de,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shuah@kernel.org, andrew.jones@linux.dev,
        ricarkol@google.com, chao.p.peng@linux.intel.com, tabba@google.com,
        jarkko@kernel.org, yu.c.zhang@linux.intel.com,
        vannapurve@google.com, ackerleytng@google.com,
        erdemaktas@google.com, mail@maciej.szmigiero.name, vbabka@suse.cz,
        david@redhat.com, qperret@google.com, michael.roth@amd.com,
        wei.w.wang@intel.com, liam.merwick@oracle.com,
        isaku.yamahata@gmail.com, kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Tests that private mem (in guest_mem files) can be migrated. Also
demonstrates the migration flow.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../kvm/x86_64/private_mem_migrate_tests.c    | 54 ++++++++++---------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/private_mem_migrate_tests.c b/tools/testing/selftests/kvm/x86_64/private_mem_migrate_tests.c
index 4226de3ebd41..2691497cf207 100644
--- a/tools/testing/selftests/kvm/x86_64/private_mem_migrate_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/private_mem_migrate_tests.c
@@ -5,28 +5,28 @@
 #include <linux/kvm.h>
 #include <linux/sizes.h>
 
-#define TRANSFER_PRIVATE_MEM_TEST_SLOT 10
-#define TRANSFER_PRIVATE_MEM_GPA ((uint64_t)(1ull << 32))
-#define TRANSFER_PRIVATE_MEM_GVA TRANSFER_PRIVATE_MEM_GPA
-#define TRANSFER_PRIVATE_MEM_VALUE 0xdeadbeef
+#define MIGRATE_PRIVATE_MEM_TEST_SLOT 10
+#define MIGRATE_PRIVATE_MEM_GPA ((uint64_t)(1ull << 32))
+#define MIGRATE_PRIVATE_MEM_GVA MIGRATE_PRIVATE_MEM_GPA
+#define MIGRATE_PRIVATE_MEM_VALUE 0xdeadbeef
 
-static void transfer_private_mem_guest_code_src(void)
+static void migrate_private_mem_data_guest_code_src(void)
 {
-	uint64_t volatile *const ptr = (uint64_t *)TRANSFER_PRIVATE_MEM_GVA;
+	uint64_t volatile *const ptr = (uint64_t *)MIGRATE_PRIVATE_MEM_GVA;
 
-	*ptr = TRANSFER_PRIVATE_MEM_VALUE;
+	*ptr = MIGRATE_PRIVATE_MEM_VALUE;
 
 	GUEST_SYNC1(*ptr);
 }
 
-static void transfer_private_mem_guest_code_dst(void)
+static void migrate_private_mem_guest_code_dst(void)
 {
-	uint64_t volatile *const ptr = (uint64_t *)TRANSFER_PRIVATE_MEM_GVA;
+	uint64_t volatile *const ptr = (uint64_t *)MIGRATE_PRIVATE_MEM_GVA;
 
 	GUEST_SYNC1(*ptr);
 }
 
-static void test_transfer_private_mem(void)
+static void test_migrate_private_mem_data(bool migrate)
 {
 	struct kvm_vm *src_vm, *dst_vm;
 	struct kvm_vcpu *src_vcpu, *dst_vcpu;
@@ -40,40 +40,43 @@ static void test_transfer_private_mem(void)
 
 	/* Build the source VM, use it to write to private memory */
 	src_vm = __vm_create_shape_with_one_vcpu(
-		shape, &src_vcpu, 0, transfer_private_mem_guest_code_src);
+		shape, &src_vcpu, 0, migrate_private_mem_data_guest_code_src);
 	src_memfd = vm_create_guest_memfd(src_vm, SZ_4K, 0);
 
-	vm_mem_add(src_vm, DEFAULT_VM_MEM_SRC, TRANSFER_PRIVATE_MEM_GPA,
-		   TRANSFER_PRIVATE_MEM_TEST_SLOT, 1, KVM_MEM_PRIVATE,
+	vm_mem_add(src_vm, DEFAULT_VM_MEM_SRC, MIGRATE_PRIVATE_MEM_GPA,
+		   MIGRATE_PRIVATE_MEM_TEST_SLOT, 1, KVM_MEM_PRIVATE,
 		   src_memfd, 0);
 
-	virt_map(src_vm, TRANSFER_PRIVATE_MEM_GVA, TRANSFER_PRIVATE_MEM_GPA, 1);
-	vm_set_memory_attributes(src_vm, TRANSFER_PRIVATE_MEM_GPA, SZ_4K,
+	virt_map(src_vm, MIGRATE_PRIVATE_MEM_GVA, MIGRATE_PRIVATE_MEM_GPA, 1);
+	vm_set_memory_attributes(src_vm, MIGRATE_PRIVATE_MEM_GPA, SZ_4K,
 				 KVM_MEMORY_ATTRIBUTE_PRIVATE);
 
 	vcpu_run(src_vcpu);
 	TEST_ASSERT_KVM_EXIT_REASON(src_vcpu, KVM_EXIT_IO);
 	get_ucall(src_vcpu, &uc);
-	TEST_ASSERT(uc.args[0] == TRANSFER_PRIVATE_MEM_VALUE,
+	TEST_ASSERT(uc.args[0] == MIGRATE_PRIVATE_MEM_VALUE,
 		    "Source VM should be able to write to private memory");
 
 	/* Build the destination VM with linked fd */
 	dst_vm = __vm_create_shape_with_one_vcpu(
-		shape, &dst_vcpu, 0, transfer_private_mem_guest_code_dst);
+		shape, &dst_vcpu, 0, migrate_private_mem_guest_code_dst);
 	dst_memfd = vm_link_guest_memfd(dst_vm, src_memfd, 0);
 
-	vm_mem_add(dst_vm, DEFAULT_VM_MEM_SRC, TRANSFER_PRIVATE_MEM_GPA,
-		   TRANSFER_PRIVATE_MEM_TEST_SLOT, 1, KVM_MEM_PRIVATE,
+	vm_mem_add(dst_vm, DEFAULT_VM_MEM_SRC, MIGRATE_PRIVATE_MEM_GPA,
+		   MIGRATE_PRIVATE_MEM_TEST_SLOT, 1, KVM_MEM_PRIVATE,
 		   dst_memfd, 0);
 
-	virt_map(dst_vm, TRANSFER_PRIVATE_MEM_GVA, TRANSFER_PRIVATE_MEM_GPA, 1);
-	vm_set_memory_attributes(dst_vm, TRANSFER_PRIVATE_MEM_GPA, SZ_4K,
-				 KVM_MEMORY_ATTRIBUTE_PRIVATE);
+	virt_map(dst_vm, MIGRATE_PRIVATE_MEM_GVA, MIGRATE_PRIVATE_MEM_GPA, 1);
+	if (migrate)
+		vm_migrate_from(dst_vm, src_vm);
+	else
+		vm_set_memory_attributes(dst_vm, MIGRATE_PRIVATE_MEM_GPA, SZ_4K,
+					 KVM_MEMORY_ATTRIBUTE_PRIVATE);
 
 	vcpu_run(dst_vcpu);
 	TEST_ASSERT_KVM_EXIT_REASON(dst_vcpu, KVM_EXIT_IO);
 	get_ucall(dst_vcpu, &uc);
-	TEST_ASSERT(uc.args[0] == TRANSFER_PRIVATE_MEM_VALUE,
+	TEST_ASSERT(uc.args[0] == MIGRATE_PRIVATE_MEM_VALUE,
 		    "Destination VM should be able to read value transferred");
 }
 
@@ -81,7 +84,10 @@ int main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));
 
-	test_transfer_private_mem();
+	test_migrate_private_mem_data(false);
+
+	if (kvm_check_cap(KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM))
+		test_migrate_private_mem_data(true);
 
 	return 0;
 }
-- 
2.41.0.640.ga95def55d0-goog

