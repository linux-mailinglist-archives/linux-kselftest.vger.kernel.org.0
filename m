Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC2F5A708D
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 00:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbiH3WUX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 18:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiH3WUW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 18:20:22 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD452ED7B
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:20:15 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id b9-20020a170902d50900b0016f0342a417so8810844plg.21
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=t1EJEc3ehuP8VgtxlwMAMy4e8zFNWLY0+qkN4qZlgjo=;
        b=OBDHMiVsduqJn82HBATnhpkGshEMFhpVZd04lCP+8vCRmGXewLCmigJbYMcHR2G1Wg
         +1Jp0anvPji+d03Qe1im6ULPefCWNZxTRGuYy1fmOcQDpL+aa60iN43yHrmxPsTe47Lz
         n0ZFXEzIqvp6UzBWc088o439BDnM4TCo/tLCOgVz8zadA67XwGMERiEPcIyK+BRZpsLi
         AxREiplpSLOHm7UHaBzpEo0sw0HIKQ3Gsv1eW/xGP6Tf9RDyUF55ezGrN/oO204ZnPif
         E2kdK9vpGN5AC9zHWegVB8elrEBJDwd6bK7V8/y9BJ0ywKUFP2pPlVZ3S8T9TdzVsk5M
         Ol8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=t1EJEc3ehuP8VgtxlwMAMy4e8zFNWLY0+qkN4qZlgjo=;
        b=E9uWGM4ledHLzrZH6XQatqob9/WarejXegHfUHsVk/mgqmocQLYnAWDDBFAocjJi6L
         x0WPf1ejfjA4LYR93Zhl6jckeUwMeKpdI4mK1HlGiIkzd1hFFPxwdoHuObzNt9Sepwxw
         +Nv3tFTjFmD4WkwtifNRqI1Q3zGFc2rUykvt4C3U9MWyW7ig7/yEhUvOirWEbjaMrimk
         OztSBdS+7HcJeVD9ru6MZcsQNszFdCgpmU+j9rKzV566HVbQtwqZGIpCm/ZefvsCmtKv
         0ZejuShzPt1UdH0uwmwBOon1oqxgU+T7BOCfY7FAh9E1JSKAHZ5Otm3DGbFCiLCbyOgi
         iIYA==
X-Gm-Message-State: ACgBeo1yQoWMprdHSqeQcDqTp696HiMp3+IXHnceAsr5vv9EMtX7ui4q
        MjP7gZD1VLaqxGKt2h86w5RPxzjHsa6oLbR2HtilqLDThJmGcnki89IsuyY0Mk7zhWy0j61v6Vk
        TO/ssSIaP290hOQFKlIjYYrVE1fOZHQ9Y9A+q2RLdXoiyCZJw+c5cGPX3bs2+1hhCMEYKwlk=
X-Google-Smtp-Source: AA6agR5cOKhbp+QG6nKAHLfE4O20IypU//wy/qm51Rv1hI/FjyPUOXD4nlx1Iu9RD3DCdgvkY7550GjkVg==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a05:6a00:1a89:b0:536:5dca:a673 with SMTP id
 e9-20020a056a001a8900b005365dcaa673mr23237123pfv.71.1661898014056; Tue, 30
 Aug 2022 15:20:14 -0700 (PDT)
Date:   Tue, 30 Aug 2022 22:19:48 +0000
In-Reply-To: <20220830222000.709028-1-sagis@google.com>
Mime-Version: 1.0
References: <20220830222000.709028-1-sagis@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220830222000.709028-6-sagis@google.com>
Subject: [RFC PATCH v2 05/17] KVM: selftest: Adding test case for TDX port IO
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

From: Erdem Aktas <erdemaktas@google.com>

Verifies TDVMCALL<INSTRUCTION.IO> READ and WRITE operations.

Signed-off-by: Erdem Aktas <erdemaktas@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/lib/x86_64/tdx.h  |   1 +
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 108 ++++++++++++++++++
 2 files changed, 109 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx.h b/tools/testing/selftests/kvm/lib/x86_64/tdx.h
index 351ece3e80e2..c78dba1af14f 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx.h
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx.h
@@ -55,6 +55,7 @@
 #define TDX_INSTRUCTION_IO 30
 
 #define TDX_SUCCESS_PORT 0x30
+#define TDX_TEST_PORT 0x31
 #define TDX_IO_READ 0
 #define TDX_IO_WRITE 1
 
diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
index 1db5400ca5ef..a93629cfd13f 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -27,6 +27,32 @@
 		(VCPU)->run->exit_reason, exit_reason_str((VCPU)->run->exit_reason),		\
 		(VCPU)->run->io.port, (VCPU)->run->io.size, (VCPU)->run->io.direction))
 
+#define CHECK_IO(VCPU, PORT, SIZE, DIR)							\
+	do {										\
+		TEST_ASSERT((VCPU)->run->exit_reason == KVM_EXIT_IO,			\
+			    "Got exit_reason other than KVM_EXIT_IO: %u (%s)\n",	\
+			    (VCPU)->run->exit_reason,					\
+			    exit_reason_str((VCPU)->run->exit_reason));			\
+											\
+		TEST_ASSERT(((VCPU)->run->exit_reason == KVM_EXIT_IO) &&		\
+			    ((VCPU)->run->io.port == (PORT)) &&				\
+			    ((VCPU)->run->io.size == (SIZE)) &&				\
+			    ((VCPU)->run->io.direction == (DIR)),			\
+			    "Got an unexpected IO exit values: %u (%s) %d %d %d\n",	\
+			    (VCPU)->run->exit_reason,					\
+			    exit_reason_str((VCPU)->run->exit_reason),			\
+			    (VCPU)->run->io.port, (VCPU)->run->io.size,			\
+			    (VCPU)->run->io.direction);					\
+	} while (0)
+
+#define CHECK_GUEST_FAILURE(VCPU)							\
+	do {										\
+		if ((VCPU)->run->exit_reason == KVM_EXIT_SYSTEM_EVENT)			\
+			TEST_FAIL("Guest reported error. error code: %lld (0x%llx)\n",	\
+				  (VCPU)->run->system_event.data[1],			\
+				  (VCPU)->run->system_event.data[1]);			\
+	} while (0)
+
 /*
  * There might be multiple tests we are running and if one test fails, it will
  * prevent the subsequent tests to run due to how tests are failing with
@@ -145,6 +171,87 @@ void verify_report_fatal_error(void)
 	printf("\t ... PASSED\n");
 }
 
+/*
+ * Verifies IO functionality by writing a |value| to a predefined port.
+ * Verifies that the read value is |value| + 1 from the same port.
+ * If all the tests are passed then write a value to port TDX_TEST_PORT
+ */
+TDX_GUEST_FUNCTION(guest_io_exit)
+{
+	uint64_t data_out, data_in, delta;
+	uint64_t ret;
+
+	data_out = 0xAB;
+
+	ret = tdvmcall_io(TDX_TEST_PORT, 1, TDX_IO_WRITE, &data_out);
+	if (ret)
+		tdvmcall_fatal(ret);
+
+	ret = tdvmcall_io(TDX_TEST_PORT, 1, TDX_IO_READ, &data_in);
+	if (ret)
+		tdvmcall_fatal(ret);
+
+	delta = data_in - data_out;
+	if (delta != 1)
+		tdvmcall_fatal(ret);
+
+	tdvmcall_success();
+}
+
+void verify_td_ioexit(void)
+{
+	struct kvm_vcpu *vcpu;
+	uint32_t port_data;
+	struct kvm_vm *vm;
+
+	printf("Verifying TD IO Exit:\n");
+	/* Create a TD VM with no memory.*/
+	vm = vm_create_tdx();
+
+	/* Allocate TD guest memory and initialize the TD.*/
+	initialize_td(vm);
+
+	/* Initialize the TD vcpu and copy the test code to the guest memory.*/
+	vcpu = vm_vcpu_add_tdx(vm, 0);
+
+	/* Setup and initialize VM memory */
+	prepare_source_image(vm, guest_io_exit,
+			     TDX_FUNCTION_SIZE(guest_io_exit), 0);
+	finalize_td_memory(vm);
+
+	/* Wait for guest to do a IO write */
+	vcpu_run(vcpu);
+	CHECK_GUEST_FAILURE(vcpu);
+	CHECK_IO(vcpu, TDX_TEST_PORT, 1, TDX_IO_WRITE);
+	port_data = *(uint8_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	printf("\t ... IO WRITE: OK\n");
+
+	/*
+	 * Wait for the guest to do a IO read. Provide the previos written data
+	 * + 1 back to the guest
+	 */
+	vcpu_run(vcpu);
+	CHECK_GUEST_FAILURE(vcpu);
+	CHECK_IO(vcpu, TDX_TEST_PORT, 1, TDX_IO_READ);
+	*(uint8_t *)((void *)vcpu->run + vcpu->run->io.data_offset) = port_data + 1;
+
+	printf("\t ... IO READ: OK\n");
+
+	/*
+	 * Wait for the guest to complete execution successfully. The read
+	 * value is checked within the guest.
+	 */
+	vcpu_run(vcpu);
+	CHECK_GUEST_FAILURE(vcpu);
+	CHECK_GUEST_COMPLETION(vcpu);
+
+	printf("\t ... IO verify read/write values: OK\n");
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
+
 int main(int argc, char **argv)
 {
 	if (!is_tdx_enabled()) {
@@ -154,6 +261,7 @@ int main(int argc, char **argv)
 
 	run_in_new_process(&verify_td_lifecycle);
 	run_in_new_process(&verify_report_fatal_error);
+	run_in_new_process(&verify_td_ioexit);
 
 	return 0;
 }
-- 
2.37.2.789.g6183377224-goog

