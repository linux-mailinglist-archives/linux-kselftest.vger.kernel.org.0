Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8DD5A709A
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 00:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbiH3WVI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 18:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbiH3WUi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 18:20:38 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E352C58B58
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:20:21 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id y9-20020a17090322c900b00174c881abaeso4436657plg.6
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=ZKZyychf2ckUAiVIKhV5N5UZMfwgcYI+ar1kxk3E/L4=;
        b=EApviBTvewlHWbvbESqFcFdkFYfHnAVWK/NKIk8LewMSDM8v9kNk/x3ajoUqcjYrIi
         flTf9vFfA3VRfld7AapqlhyC6ac7BhSmpLyRq5FRDcH07mjcgdM5tFQy6e+nmXHbknDX
         97ykUwvGQ6BDAtBFkJX3cgf87ZBhPYHXYV1cIeEH6gQWDkvbfq37IvDTgNX3bNgG1vFa
         myR9YHb1sOhKoPNyNSkvToAFa1ijO+sTHKeIEluMZI0XR6UgJEG72KpAwUwBd/FPJPPQ
         HEmwn51NHQPeWtEHTXH+M+HVZEcxdnywlVv/L1lBhetPph+3AWUopPOTUULyIDolyFNn
         ILCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=ZKZyychf2ckUAiVIKhV5N5UZMfwgcYI+ar1kxk3E/L4=;
        b=RhjZ9yE2tQXY3ut1lqMBCSfA1JH2TCHSfEZdxL6KmuK9O7tDXtLTuLM1mVrLUpZ+kz
         daDBxdSC87oLnDjmsEnlGMSb4bj/8doJwjI3F8gw6YtflfnEao1M5zTMoVsW2p/VdjB1
         HPnUlk5BAYldO4dqINVs35SePnb8J0TcxEHt44d8pk9igCSNy9h2eEmX8safIr13xyjx
         2C/jsufXWmL2fRxGMwDiXHMOUw3QPDSOEqyKhDjOh6NNj68uVj4OfSsA/ut2XME2tUhX
         7kTig/I6RQoumvl1+Kf94+Fvn0J8nqdaaHhsrgQVCe2FPbMX41C3D6jcAJpVwaD9s7iE
         +Bnw==
X-Gm-Message-State: ACgBeo0LKGEi3GqQYvhyCRhU2H7o7rOboBR2o4sirxNGtRP3J1HTwRT8
        /kBV53raTVFA+abjfUpkH3VYyIMcEy5XXiVy5+ogXdIlCbb6KWJLEEEj4IrZ9o23IWfyskU3fcz
        cck9eNLolSVbMJvX7hfF06pkir/RqDcXyLOrpNo7/62eO4iXkZwPDG5QCawFi4SQPKfizPvI=
X-Google-Smtp-Source: AA6agR6/HMwaZBuWZDYIYWsY99pC+WePM1T6/CYJuVaTJ/QGT5UGOgcVVjOBVq5tri8Ty1s0OI+J3PSXhw==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a17:90a:e558:b0:1fb:c4b7:1a24 with SMTP id
 ei24-20020a17090ae55800b001fbc4b71a24mr995pjb.1.1661898018970; Tue, 30 Aug
 2022 15:20:18 -0700 (PDT)
Date:   Tue, 30 Aug 2022 22:19:51 +0000
In-Reply-To: <20220830222000.709028-1-sagis@google.com>
Mime-Version: 1.0
References: <20220830222000.709028-1-sagis@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220830222000.709028-9-sagis@google.com>
Subject: [RFC PATCH v2 08/17] KVM: selftest: TDX: Add TDX IO writes test
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

The test verifies IO writes of various sizes from the guest to the host.

Google-Bug-Id: 235407183

Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/lib/x86_64/tdx.h  |  3 +
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 85 +++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx.h b/tools/testing/selftests/kvm/lib/x86_64/tdx.h
index 39b000118e26..f1f44c2ad40e 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx.h
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx.h
@@ -51,6 +51,9 @@
 #define _PAGE_RW            (1UL<<1)       /* writeable */
 #define _PAGE_PS            (1UL<<7)       /* page size bit*/
 
+#define TDX_VMCALL_SUCCESS 0x0000000000000000
+#define TDX_VMCALL_INVALID_OPERAND 0x8000000000000000
+
 #define TDX_GET_TD_VM_CALL_INFO 0x10000
 #define TDX_REPORT_FATAL_ERROR 0x10003
 #define TDX_INSTRUCTION_IO 30
diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
index cf8260db1f5b..ee60f77fe38e 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -489,6 +489,90 @@ void verify_get_td_vmcall_info(void)
 	printf("\t ... PASSED\n");
 }
 
+/*
+ * Verifies IO functionality by writing values of different sizes
+ * to the host.
+ */
+TDX_GUEST_FUNCTION(guest_io_writes)
+{
+	uint64_t byte_1 = 0xAB;
+	uint64_t byte_2 = 0xABCD;
+	uint64_t byte_4 = 0xFFABCDEF;
+	uint64_t ret;
+
+	ret = tdvmcall_io(TDX_TEST_PORT, 1, TDX_IO_WRITE, &byte_1);
+	if (ret)
+		tdvmcall_fatal(ret);
+
+	ret = tdvmcall_io(TDX_TEST_PORT, 2, TDX_IO_WRITE, &byte_2);
+	if (ret)
+		tdvmcall_fatal(ret);
+
+	ret = tdvmcall_io(TDX_TEST_PORT, 4, TDX_IO_WRITE, &byte_4);
+	if (ret)
+		tdvmcall_fatal(ret);
+
+	// Write an invalid number of bytes.
+	ret = tdvmcall_io(TDX_TEST_PORT, 5, TDX_IO_WRITE, &byte_4);
+	if (ret)
+		tdvmcall_fatal(ret);
+
+	tdvmcall_success();
+}
+
+void verify_guest_writes(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	uint8_t byte_1;
+	uint16_t byte_2;
+	uint32_t byte_4;
+
+	printf("Verifying guest writes:\n");
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
+	prepare_source_image(vm, guest_io_writes,
+			     TDX_FUNCTION_SIZE(guest_io_writes), 0);
+	finalize_td_memory(vm);
+
+	vcpu_run(vcpu);
+	CHECK_GUEST_FAILURE(vcpu);
+	CHECK_IO(vcpu, TDX_TEST_PORT, 1, TDX_IO_WRITE);
+	byte_1 = *(uint8_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	vcpu_run(vcpu);
+	CHECK_GUEST_FAILURE(vcpu);
+	CHECK_IO(vcpu, TDX_TEST_PORT, 2, TDX_IO_WRITE);
+	byte_2 = *(uint16_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	vcpu_run(vcpu);
+	CHECK_GUEST_FAILURE(vcpu);
+	CHECK_IO(vcpu, TDX_TEST_PORT, 4, TDX_IO_WRITE);
+	byte_4 = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	ASSERT_EQ(byte_1, 0xAB);
+	ASSERT_EQ(byte_2, 0xABCD);
+	ASSERT_EQ(byte_4, 0xFFABCDEF);
+
+	vcpu_run(vcpu);
+	ASSERT_EQ(vcpu->run->exit_reason, KVM_EXIT_SYSTEM_EVENT);
+	ASSERT_EQ(vcpu->run->system_event.data[1], TDX_VMCALL_INVALID_OPERAND);
+
+	vcpu_run(vcpu);
+	CHECK_GUEST_COMPLETION(vcpu);
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
 int main(int argc, char **argv)
 {
 	if (!is_tdx_enabled()) {
@@ -501,6 +585,7 @@ int main(int argc, char **argv)
 	run_in_new_process(&verify_td_ioexit);
 	run_in_new_process(&verify_td_cpuid);
 	run_in_new_process(&verify_get_td_vmcall_info);
+	run_in_new_process(&verify_guest_writes);
 
 	return 0;
 }
-- 
2.37.2.789.g6183377224-goog

