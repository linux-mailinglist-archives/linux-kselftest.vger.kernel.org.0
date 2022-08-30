Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9655A70B1
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 00:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbiH3WWU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 18:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiH3WVx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 18:21:53 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62CE82D31
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:20:56 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id b25-20020aa78119000000b00536a929d8e4so5086960pfi.1
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=2AzASQeU88APEljBXBn0RNVGXW+shwwgUtawD6/ADN8=;
        b=XxqBa5YUPEuIofhtRPgfQP1Gp7yJBPrhB27iJVTj5hKg2qUgSwojvxOwPl1mqNddVk
         EvLfXqPC7nzUVlzuvW0kzXSJdPKfu576AOZ5UZcRRd44IzixhkQfNSVGLTbFEsotJ7lH
         w3kaELzdP+sFBMynBIe9kYmybdDrc3m8ps34xZ5UhYxfLTX0FN/ZbNvQOunYsj/1WVry
         PC8RvwlhuKpik45jWpSrhGU/4j/BmLkbdRUaMDB4p42YF9ICdlsSwc+afhYAIpKsHdVF
         dW2yEJqpRTTGVXnkT+Ps0wMPO1gfjvZxwFJXci6mZ2WCAg9f0kkjjIbF/j3X/dSTmaYl
         RgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=2AzASQeU88APEljBXBn0RNVGXW+shwwgUtawD6/ADN8=;
        b=lka4vmLFeKqD8WXl1NRDnbzF376NChRZ6kKvE5dkZgdY32gwi0RApKL/0iW+TvoJQq
         RwOqvEN7Y8n0YTF/MmyJAYdGmFUKE/kK9TTsuF3mouC6LV+bwI4F9IdhIclrZOsV3m9f
         T1vmYwr3rBBTLw9ODoUlbaBZDPa/zhVq9HhXw7bDxjQjuzfStDGogSFDQhAPHokkIBGz
         w+oZDmMtbrAHLqcAucZcrDlo44zRcB+H8xyVUjko1H5pvUYuEKvL4OhSZodkveoW2lcF
         pzmrhoG7GaG3KkPrpWtty+PYP9/gCkYAmLChFxWiyFh2DxzXpjlF3fXS7aHOrN6e/Ofo
         gE6A==
X-Gm-Message-State: ACgBeo0uGmq10p129vwMyHYYOwA1HvVYoBT8j5obuo4E930LvuSIDWd9
        y7/NdkjXp732Y7nOKfv7ML5hljdVJTi6PGv0POhlqTYZm5v6mAu3Ooc3zGHcINVQaL6iHqZoBkO
        ZpN0omj6lCL0Y7KuKYMBBEnOyrdRGJEEUVVKBDZw5X7gyD0rnQ+4DlKVFMjz4Pztn1e3DdI8=
X-Google-Smtp-Source: AA6agR7m/uiWOU0X1ALpMi8LPsl7IheXdMIzK8T+7BYvKoXpERL9W/YFwQ3v9zngVlKofPdPkx5efJAG2Q==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a05:6a00:acc:b0:530:e79e:fc27 with SMTP id
 c12-20020a056a000acc00b00530e79efc27mr23466087pfl.61.1661898031820; Tue, 30
 Aug 2022 15:20:31 -0700 (PDT)
Date:   Tue, 30 Aug 2022 22:19:58 +0000
In-Reply-To: <20220830222000.709028-1-sagis@google.com>
Mime-Version: 1.0
References: <20220830222000.709028-1-sagis@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220830222000.709028-16-sagis@google.com>
Subject: [RFC PATCH v2 15/17] KVM: selftest: TDX: Verify the behavior when
 host consumes a TD private memory
From:   Sagi Shahar <sagis@google.com>
To:     linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Sagi Shahar <sagis@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Ryan Afranji <afranji@google.com>,
        Roger Wang <runanwang@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Marc Zyngier <maz@kernel.org>, Ben Gardon <bgardon@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Matlack <dmatlack@google.com>,
        Peter Xu <peterx@redhat.com>, Oliver Upton <oupton@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Yang Zhong <yang.zhong@intel.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Peter Gonda <pgonda@google.com>, Marc Orr <marcorr@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Eric Auger <eric.auger@redhat.com>,
        Yanan Wang <wangyanan55@huawei.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Shier <pshier@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Zhenzhong Duan <zhenzhong.duan@intel.com>,
        "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
        Like Xu <like.xu@linux.intel.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
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

From: Ryan Afranji <afranji@google.com>

The test checks that host can only read fixed values when trying to
access the guest's private memory.

Signed-off-by: Ryan Afranji <afranji@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 93 +++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
index 934f2f7a5df9..1776b39b7d9e 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -1274,6 +1274,98 @@ void verify_mmio_writes(void)
 	printf("\t ... PASSED\n");
 }
 
+TDX_GUEST_FUNCTION(guest_host_read_priv_mem)
+{
+	uint64_t guest_var = 0xABCD;
+	uint64_t ret;
+
+	/* Sends address to host. */
+	ret = tdvm_report_64bit_to_user_space((uint64_t)&guest_var);
+	if (ret)
+		tdvmcall_fatal(ret);
+
+	/* Update guest_var's value and have host reread it. */
+	guest_var = 0xFEDC;
+
+	tdvmcall_success();
+}
+
+void verify_host_reading_private_mem(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct userspace_mem_region *region;
+	uint64_t guest_var_addr;
+	uint64_t host_virt;
+	uint64_t first_host_read;
+	uint64_t second_host_read;
+	int ctr;
+
+	printf("Verifying host's behavior when reading TD private memory:\n");
+	/* Create a TD VM with no memory. */
+	vm = vm_create_tdx();
+
+	/* Allocate TD guest memory and initialize the TD. */
+	initialize_td(vm);
+
+	/* Initialize the TD vcpu and copy the test code to the guest memory. */
+	vcpu = vm_vcpu_add_tdx(vm, 0);
+
+	/* Setup and initialize VM memory. */
+	prepare_source_image(vm, guest_host_read_priv_mem,
+			     TDX_FUNCTION_SIZE(guest_host_read_priv_mem), 0);
+	finalize_td_memory(vm);
+
+	/* Get the address of the guest's variable. */
+	vcpu_run(vcpu);
+	CHECK_GUEST_FAILURE(vcpu);
+	printf("\t ... Guest's variable contains 0xABCD\n");
+
+	/* Guest virtual and guest physical addresses have 1:1 mapping. */
+	guest_var_addr = read_64bit_from_guest(vcpu, TDX_DATA_REPORT_PORT);
+
+	/* Search for the guest's address in guest's memory regions. */
+	host_virt = 0;
+	hash_for_each(vm->regions.slot_hash, ctr, region, slot_node) {
+		uint64_t offset;
+		uint64_t host_virt_base;
+		uint64_t guest_base;
+
+		guest_base = (uint64_t)region->region.guest_phys_addr;
+		offset = guest_var_addr - guest_base;
+
+		if (guest_base <= guest_var_addr &&
+		    offset <= region->region.memory_size) {
+			host_virt_base = (uint64_t)region->host_mem;
+			host_virt = host_virt_base + offset;
+			break;
+		}
+	}
+	TEST_ASSERT(host_virt != 0,
+		    "Guest address not found in guest memory regions\n");
+
+	/* Host reads guest's variable. */
+	first_host_read = *(uint64_t *)host_virt;
+	printf("\t ... Host's read attempt value: %lu\n", first_host_read);
+
+	/* Guest updates variable and host rereads it. */
+	vcpu_run(vcpu);
+	CHECK_GUEST_FAILURE(vcpu);
+	printf("\t ... Guest's variable updated to 0xFEDC\n");
+
+	second_host_read = *(uint64_t *)host_virt;
+	printf("\t ... Host's second read attempt value: %lu\n",
+	       second_host_read);
+
+	TEST_ASSERT(first_host_read == second_host_read,
+		    "Host did not read a fixed pattern\n");
+
+	printf("\t ... Fixed pattern was returned to the host\n");
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
 int main(int argc, char **argv)
 {
 	if (!is_tdx_enabled()) {
@@ -1294,6 +1386,7 @@ int main(int argc, char **argv)
 	run_in_new_process(&verify_guest_hlt);
 	run_in_new_process(&verify_mmio_reads);
 	run_in_new_process(&verify_mmio_writes);
+	run_in_new_process(&verify_host_reading_private_mem);
 
 	return 0;
 }
-- 
2.37.2.789.g6183377224-goog

