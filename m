Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B035A7102
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 00:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbiH3Wn5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 18:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbiH3Wno (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 18:43:44 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9D380B76
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:43:31 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id z14-20020a170903018e00b00174fff57d17so2918128plg.14
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=EVXb2yKFUQIy1Xc2nGSh/Bz10UhUMA0E75xzrEY47PY=;
        b=q+XH7fUvfPeID0YJ7U49n0ESnUIAi9/wL4R5kzkpECScWmPDnLOQ/WFkvPK9NZIkMN
         U0SEt6cWlTUnHi/iUEFTFIZKLTMLr/g66walLDBWob5x7/No9VET34rSMUeEutZVfjSw
         1X4jn74tCUPffUvNTJaoBJdXk+wLiycEDfOfX8+Bnj3GX6VZozfHxOkjKprKfKh/Dsxk
         Scj5SGIzJZcaNJPtTIH5WLZ56op9vjZngNgpFaD143XaT/6NLYCtjH9NEXb5im9+S6Mj
         wPygBXNh4ZUo4Qdctl45gYcfalT/KzL68lPiECZGR5YXE1+9cnHJa/LMw9/wM9MEqof4
         JmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=EVXb2yKFUQIy1Xc2nGSh/Bz10UhUMA0E75xzrEY47PY=;
        b=5wJYIAK5Ud+WCSakoajzQb0knbHoisgCXLoiSBVJjs/Du9ul/YUSaH7y1qEu1AagSh
         fgN9XcZMHJB2EZI0tGXpcSBnumMvaZDRA8hLuzTVZXtyB7wpCMjKLF66vcjY9x2+GCaA
         jng5HMqKe0TcuYhVUH4uy9iDk11rfKCXaZjGzXComBtDjm3cJP1MW82JqqxDZmyEHLyX
         IQNewA55Xf+8IMfJJJZ2HGbQ9Q8Kvg8klBJlz81ikNhhib735mQwURHYABphhLIfid4l
         Z/qCWJ8Z3L3XntYZmIdkg75fl8EvULwkN/fV6twKU0W0XpdBqWzKJ8FljxTz1MpDgXni
         Azxg==
X-Gm-Message-State: ACgBeo21A0tROQHcrUbyBKpFaPBlmTzC4hm5PjOAbMaAuQwMCdasZsGR
        yH+/5o9MvzBZHodizYokJrASSTNkICsevopg
X-Google-Smtp-Source: AA6agR68oFvGPoyeb4Zbkf7izlnNfsd6sBNLwkNFBgmYKu6sYs9AXZrWGe6F9IAzmiul6hm4bS858itrP23BXUnL
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:90a:e558:b0:1fb:c4b7:1a24 with SMTP
 id ei24-20020a17090ae55800b001fbc4b71a24mr5289pjb.1.1661899410287; Tue, 30
 Aug 2022 15:43:30 -0700 (PDT)
Date:   Tue, 30 Aug 2022 22:42:57 +0000
In-Reply-To: <20220830224259.412342-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20220830224259.412342-1-vannapurve@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220830224259.412342-7-vannapurve@google.com>
Subject: [RFC V2 PATCH 6/8] selftests: kvm: Support executing SEV VMs with
 private memory
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shuah@kernel.org, yang.zhong@intel.com,
        drjones@redhat.com, ricarkol@google.com, aaronlewis@google.com,
        wei.w.wang@intel.com, kirill.shutemov@linux.intel.com,
        corbet@lwn.net, hughd@google.com, jlayton@kernel.org,
        bfields@fieldses.org, akpm@linux-foundation.org,
        chao.p.peng@linux.intel.com, yu.c.zhang@linux.intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com,
        michael.roth@amd.com, qperret@google.com, steven.price@arm.com,
        ak@linux.intel.com, david@redhat.com, luto@kernel.org,
        vbabka@suse.cz, marcorr@google.com, erdemaktas@google.com,
        pgonda@google.com, nikunj@amd.com, seanjc@google.com,
        diviness@google.com, maz@kernel.org, dmatlack@google.com,
        axelrasmussen@google.com, maciej.szmigiero@oracle.com,
        mizhang@google.com, bgardon@google.com,
        Vishal Annapurve <vannapurve@google.com>
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

Add support of executing SEV VMs for testing private memory conversion
scenarios.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 .../kvm/include/x86_64/private_mem.h          |  1 +
 .../selftests/kvm/lib/x86_64/private_mem.c    | 86 +++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/private_mem.h b/tools/testing/selftests/kvm/include/x86_64/private_mem.h
index 183b53b8c486..d3ef88da837c 100644
--- a/tools/testing/selftests/kvm/include/x86_64/private_mem.h
+++ b/tools/testing/selftests/kvm/include/x86_64/private_mem.h
@@ -49,5 +49,6 @@ struct vm_setup_info {
 };
 
 void execute_vm_with_private_mem(struct vm_setup_info *info);
+void execute_sev_vm_with_private_mem(struct vm_setup_info *info);
 
 #endif /* SELFTEST_KVM_PRIVATE_MEM_H */
diff --git a/tools/testing/selftests/kvm/lib/x86_64/private_mem.c b/tools/testing/selftests/kvm/lib/x86_64/private_mem.c
index 28d93754e1f2..0eb8f92d19e8 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/private_mem.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/private_mem.c
@@ -348,3 +348,89 @@ void execute_vm_with_private_mem(struct vm_setup_info *info)
 	ucall_uninit(vm);
 	kvm_vm_free(vm);
 }
+
+/*
+ * Execute Sev vm with private memory memslots.
+ *
+ * Input Args:
+ *   info - pointer to a structure containing information about setting up a SEV
+ *   VM with private memslots
+ *
+ * Output Args: None
+ *
+ * Return: None
+ *
+ * Function called by host userspace logic in selftests to execute SEV vm
+ * logic. It will install two memslots:
+ * 1) memslot 0 : containing all the boot code/stack pages
+ * 2) test_mem_slot : containing the region of memory that would be used to test
+ *   private/shared memory accesses to a memory backed by private memslots
+ */
+void execute_sev_vm_with_private_mem(struct vm_setup_info *info)
+{
+	uint8_t measurement[512];
+	struct sev_vm *sev;
+	struct kvm_vm *vm;
+	struct kvm_enable_cap cap;
+	struct kvm_vcpu *vcpu;
+	uint32_t memslot0_pages = info->memslot0_pages;
+	uint64_t test_area_gpa, test_area_size;
+	struct test_setup_info *test_info = &info->test_info;
+
+	sev = sev_vm_create_with_flags(info->policy, memslot0_pages, KVM_MEM_PRIVATE);
+	TEST_ASSERT(sev, "Sev VM creation failed");
+	vm = sev_get_vm(sev);
+	vm->use_ucall_pool = true;
+	vm_set_pgt_alloc_tracking(vm);
+	vm_create_irqchip(vm);
+
+	TEST_ASSERT(info->guest_fn, "guest_fn not present");
+	vcpu = vm_vcpu_add(vm, 0, info->guest_fn);
+	kvm_vm_elf_load(vm, program_invocation_name);
+
+	vm_check_cap(vm, KVM_CAP_EXIT_HYPERCALL);
+	cap.cap = KVM_CAP_EXIT_HYPERCALL;
+	cap.flags = 0;
+	cap.args[0] = (1 << KVM_HC_MAP_GPA_RANGE);
+	vm_ioctl(vm, KVM_ENABLE_CAP, &cap);
+
+	TEST_ASSERT(test_info->test_area_size, "Test mem size not present");
+
+	test_area_size = test_info->test_area_size;
+	test_area_gpa = test_info->test_area_gpa;
+	vm_userspace_mem_region_add(vm, test_info->test_area_mem_src, test_area_gpa,
+		test_info->test_area_slot, test_area_size / vm->page_size,
+		KVM_MEM_PRIVATE);
+	vm_update_private_mem(vm, test_area_gpa, test_area_size, ALLOCATE_MEM);
+
+	virt_map(vm, test_area_gpa, test_area_gpa, test_area_size/vm->page_size);
+
+	vm_map_page_table(vm, GUEST_PGT_MIN_VADDR);
+	sev_gpgt_info = (struct guest_pgt_info *)vm_setup_pgt_info_buf(vm,
+			GUEST_PGT_MIN_VADDR);
+	sev_enc_bit = sev_get_enc_bit(sev);
+	is_sev_vm = true;
+	sync_global_to_guest(vm, sev_enc_bit);
+	sync_global_to_guest(vm, sev_gpgt_info);
+	sync_global_to_guest(vm, is_sev_vm);
+
+	vm_update_private_mem_internal(vm, 0, (memslot0_pages << MIN_PAGE_SHIFT),
+		ALLOCATE_MEM, false);
+
+	/* Allocations/setup done. Encrypt initial guest payload. */
+	sev_vm_launch(sev);
+
+	/* Dump the initial measurement. A test to actually verify it would be nice. */
+	sev_vm_launch_measure(sev, measurement);
+	pr_info("guest measurement: ");
+	for (uint32_t i = 0; i < 32; ++i)
+		pr_info("%02x", measurement[i]);
+	pr_info("\n");
+
+	sev_vm_launch_finish(sev);
+
+	vcpu_work(vm, vcpu, info);
+
+	sev_vm_free(sev);
+	is_sev_vm = false;
+}
-- 
2.37.2.672.g94769d06f0-goog

