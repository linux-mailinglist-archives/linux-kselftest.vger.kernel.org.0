Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530CC5A70A4
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 00:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbiH3WVb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 18:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbiH3WVK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 18:21:10 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4149161D66
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:20:26 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id mq13-20020a17090b380d00b001fb60a596c8so1379633pjb.0
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=sOX1XOkMTNP89FeyjTl121MB6xyMNQdWf26YjlGxjkU=;
        b=EMWJFza8n/pVkMzyp5Egqw1c3Hvb52fwxBRvcKF6phUtBCDb4j8Uov1AabTS5+QokQ
         uPKX7+HHgyylIliyq7ilBJNtcK+iZWw5sjcllSmaoTwVDX2SAOPtDOjPJpFWUhG5aGzd
         d+4XlOM52rVG7KZUkm9F8AiZ/nAMrTpasazKOf9boQ/N6y5nFryZN0unfxkz8SpDPQsL
         yDKNwT7Ypu1kIjibRhTzEULxSan95DscgQ7bujqCUBbyVzRFzSYhOczKOFUtLV2I0yBy
         uNoRQeLk4I9tKSQY+F8sLzmmKE7r0+9C0SdbwG6K66X0aAdK9qMq9r366f8fJEcLoiZa
         d6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=sOX1XOkMTNP89FeyjTl121MB6xyMNQdWf26YjlGxjkU=;
        b=2FTSFAq+r0XzBJdYRsQIgy6IexWF0KbYrMkm3AE8Lm8FNFIQnzyVuISfU8u+1YfyHE
         9QA6/hFM7JNv8GfkcX1SO8xk2pZZ8c2EzIDF1ITDAm5mP3FPI82+XAtA2KI7qCMmVmHW
         7J1DnFrwPO3zKtJeREZSz2s+WQcAadzCwcQxKdC6HfazpN/toO14D+CzXL6jlciAC3/c
         j6PbhvVNB4sU9o+1LK8sBNdooCTo1jOjdOB24FXIFQpZgdmfA2OeADQPsl54xVvaij/a
         vfDeZdjwGUKaIWBWgW4tNnN6sQKkPllt5xdD6lmIC0FhzkvhZY7Zdahf4FRfs/GDj9rC
         VUXQ==
X-Gm-Message-State: ACgBeo2pE5wLp0umkdNUioJyRzbA1m+r7KgkYi01ZTdgfQN7di8S61wQ
        zKyVioKmmlP5HfCohrcLHwF1NEJA09+0lL/qWkFzpsrNHVqvRWLjjffwksY34SdSgnczWmVn4Pe
        Y1d7VK/rIi7fnx88tkthdZ6RVlJKu5MrlnujUyX56mBYa4ffMT1g4+L5+nU9RfJfC60JG/nE=
X-Google-Smtp-Source: AA6agR5JRKYfTjXtUS8ogxmfTte8ySUyffUi2ssKkLp2LZObbA/ZpbSm4YLluSvKI2/Pd1FY7BDRQLJNyg==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a17:90a:e558:b0:1fb:c4b7:1a24 with SMTP id
 ei24-20020a17090ae55800b001fbc4b71a24mr1011pjb.1.1661898022646; Tue, 30 Aug
 2022 15:20:22 -0700 (PDT)
Date:   Tue, 30 Aug 2022 22:19:53 +0000
In-Reply-To: <20220830222000.709028-1-sagis@google.com>
Mime-Version: 1.0
References: <20220830222000.709028-1-sagis@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220830222000.709028-11-sagis@google.com>
Subject: [RFC PATCH v2 10/17] KVM: selftest: TDX: Add TDX MSR read/write tests
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

The test verifies reads and writes for MSR registers with different access
level.

Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/lib/x86_64/tdx.h  |  34 +++
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 229 ++++++++++++++++++
 2 files changed, 263 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx.h b/tools/testing/selftests/kvm/lib/x86_64/tdx.h
index f1f44c2ad40e..263834979727 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx.h
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx.h
@@ -57,6 +57,8 @@
 #define TDX_GET_TD_VM_CALL_INFO 0x10000
 #define TDX_REPORT_FATAL_ERROR 0x10003
 #define TDX_INSTRUCTION_IO 30
+#define TDX_INSTRUCTION_RDMSR 31
+#define TDX_INSTRUCTION_WRMSR 32
 
 #define TDX_SUCCESS_PORT 0x30
 #define TDX_TEST_PORT 0x31
@@ -258,6 +260,38 @@ static inline uint64_t tdvmcall_get_td_vmcall_info(uint64_t *r11, uint64_t *r12,
 	return regs.r10;
 }
 
+/*
+ * Read MSR register.
+ */
+static inline uint64_t tdvmcall_rdmsr(uint64_t index, uint64_t *ret_value)
+{
+	struct kvm_regs regs;
+
+	memset(&regs, 0, sizeof(regs));
+	regs.r11 = TDX_INSTRUCTION_RDMSR;
+	regs.r12 = index;
+	regs.rcx = 0x1C00;
+	tdcall(&regs);
+	*ret_value = regs.r11;
+	return regs.r10;
+}
+
+/*
+ * Write MSR register.
+ */
+static inline uint64_t tdvmcall_wrmsr(uint64_t index, uint64_t value)
+{
+	struct kvm_regs regs;
+
+	memset(&regs, 0, sizeof(regs));
+	regs.r11 = TDX_INSTRUCTION_WRMSR;
+	regs.r12 = index;
+	regs.r13 = value;
+	regs.rcx = 0x3C00;
+	tdcall(&regs);
+	return regs.r10;
+}
+
 /*
  * Reports a 32 bit value from the guest to user space using a TDVM IO call.
  * Data is reported on port TDX_DATA_REPORT_PORT.
diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
index 85b5ab99424e..fb3b8de7e5cd 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -55,6 +55,40 @@
 				  (VCPU)->run->system_event.data[1]);			\
 	} while (0)
 
+
+/*
+ * Define a filter which denies all MSR access except the following:
+ * MTTR_BASE_0: Allow read/write access
+ * MTTR_BASE_1: Allow read access
+ * MTTR_BASE_2: Allow write access
+ */
+static u64 allow_bits = 0xFFFFFFFFFFFFFFFF;
+#define MTTR_BASE_0 (0x200)
+#define MTTR_BASE_1 (0x202)
+#define MTTR_BASE_2 (0x204)
+struct kvm_msr_filter test_filter = {
+	.flags = KVM_MSR_FILTER_DEFAULT_DENY,
+	.ranges = {
+		{
+			.flags = KVM_MSR_FILTER_READ |
+				 KVM_MSR_FILTER_WRITE,
+			.nmsrs = 1,
+			.base = MTTR_BASE_0,
+			.bitmap = (uint8_t *)&allow_bits,
+		}, {
+			.flags = KVM_MSR_FILTER_READ,
+			.nmsrs = 1,
+			.base = MTTR_BASE_1,
+			.bitmap = (uint8_t *)&allow_bits,
+		}, {
+			.flags = KVM_MSR_FILTER_WRITE,
+			.nmsrs = 1,
+			.base = MTTR_BASE_2,
+			.bitmap = (uint8_t *)&allow_bits,
+		},
+	},
+};
+
 static uint64_t read_64bit_from_guest(struct kvm_vcpu *vcpu, uint64_t port)
 {
 	uint32_t lo, hi;
@@ -656,6 +690,199 @@ void verify_guest_reads(void)
 	printf("\t ... PASSED\n");
 }
 
+/*
+ * Verifies MSR read functionality.
+ */
+TDX_GUEST_FUNCTION(guest_msr_read)
+{
+	uint64_t data;
+	uint64_t ret;
+
+	ret = tdvmcall_rdmsr(MTTR_BASE_0, &data);
+	if (ret)
+		tdvmcall_fatal(ret);
+
+	ret = tdvm_report_64bit_to_user_space(data);
+	if (ret)
+		tdvmcall_fatal(ret);
+
+	ret = tdvmcall_rdmsr(MTTR_BASE_1, &data);
+	if (ret)
+		tdvmcall_fatal(ret);
+
+	ret = tdvm_report_64bit_to_user_space(data);
+	if (ret)
+		tdvmcall_fatal(ret);
+
+	/* We expect this call to fail since MTTR_BASE_2 is write only */
+	ret = tdvmcall_rdmsr(MTTR_BASE_2, &data);
+	if (ret) {
+		ret = tdvm_report_64bit_to_user_space(ret);
+		if (ret)
+			tdvmcall_fatal(ret);
+	} else {
+		tdvmcall_fatal(-99);
+	}
+
+	tdvmcall_success();
+}
+
+void verify_guest_msr_reads(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	uint64_t data;
+	int ret;
+
+	printf("Verifying guest msr reads:\n");
+
+	/* Create a TD VM with no memory.*/
+	vm = vm_create_tdx();
+
+	/* Set explicit MSR filter map to control access to the MSR registers
+	 * used in the test.
+	 */
+	printf("\t ... Setting test MSR filter\n");
+	ret = kvm_check_cap(KVM_CAP_X86_USER_SPACE_MSR);
+	TEST_ASSERT(ret, "KVM_CAP_X86_USER_SPACE_MSR is unavailable");
+	vm_enable_cap(vm, KVM_CAP_X86_USER_SPACE_MSR, KVM_MSR_EXIT_REASON_FILTER);
+
+	ret = kvm_check_cap(KVM_CAP_X86_MSR_FILTER);
+	TEST_ASSERT(ret, "KVM_CAP_X86_MSR_FILTER is unavailable");
+
+	ret = ioctl(vm->fd, KVM_X86_SET_MSR_FILTER, &test_filter);
+	TEST_ASSERT(ret == 0,
+		    "KVM_X86_SET_MSR_FILTER failed, ret: %i errno: %i (%s)",
+		    ret, errno, strerror(errno));
+
+	/* Allocate TD guest memory and initialize the TD.*/
+	initialize_td(vm);
+
+	/* Initialize the TD vcpu and copy the test code to the guest memory.*/
+	vcpu = vm_vcpu_add_tdx(vm, 0);
+
+	/* Setup and initialize VM memory */
+	prepare_source_image(vm, guest_msr_read,
+			     TDX_FUNCTION_SIZE(guest_msr_read), 0);
+	finalize_td_memory(vm);
+
+	printf("\t ... Setting test MTTR values\n");
+	/* valid values for mttr type are 0, 1, 4, 5, 6 */
+	vcpu_set_msr(vcpu, MTTR_BASE_0, 4);
+	vcpu_set_msr(vcpu, MTTR_BASE_1, 5);
+	vcpu_set_msr(vcpu, MTTR_BASE_2, 6);
+
+	printf("\t ... Running guest\n");
+	vcpu_run(vcpu);
+	CHECK_GUEST_FAILURE(vcpu);
+	data = read_64bit_from_guest(vcpu, TDX_DATA_REPORT_PORT);
+	ASSERT_EQ(data, 4);
+
+	vcpu_run(vcpu);
+	CHECK_GUEST_FAILURE(vcpu);
+	data = read_64bit_from_guest(vcpu, TDX_DATA_REPORT_PORT);
+	ASSERT_EQ(data, 5);
+
+	vcpu_run(vcpu);
+	CHECK_GUEST_FAILURE(vcpu);
+	data = read_64bit_from_guest(vcpu, TDX_DATA_REPORT_PORT);
+	ASSERT_EQ(data, TDX_VMCALL_INVALID_OPERAND);
+
+	vcpu_run(vcpu);
+	CHECK_GUEST_COMPLETION(vcpu);
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
+/*
+ * Verifies MSR write functionality.
+ */
+TDX_GUEST_FUNCTION(guest_msr_write)
+{
+	uint64_t ret;
+
+	ret = tdvmcall_wrmsr(MTTR_BASE_0, 4);
+	if (ret)
+		tdvmcall_fatal(ret);
+
+	/* We expect this call to fail since MTTR_BASE_1 is read only */
+	ret = tdvmcall_wrmsr(MTTR_BASE_1, 5);
+	if (ret) {
+		ret = tdvm_report_64bit_to_user_space(ret);
+		if (ret)
+			tdvmcall_fatal(ret);
+	} else {
+		tdvmcall_fatal(-99);
+	}
+
+
+	ret = tdvmcall_wrmsr(MTTR_BASE_2, 6);
+	if (ret)
+		tdvmcall_fatal(ret);
+
+	tdvmcall_success();
+}
+
+void verify_guest_msr_writes(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	uint64_t data;
+	int ret;
+
+	printf("Verifying guest msr writes:\n");
+
+	/* Create a TD VM with no memory.*/
+	vm = vm_create_tdx();
+
+	/* Set explicit MSR filter map to control access to the MSR registers
+	 * used in the test.
+	 */
+	printf("\t ... Setting test MSR filter\n");
+	ret = kvm_check_cap(KVM_CAP_X86_USER_SPACE_MSR);
+	TEST_ASSERT(ret, "KVM_CAP_X86_USER_SPACE_MSR is unavailable");
+	vm_enable_cap(vm, KVM_CAP_X86_USER_SPACE_MSR, KVM_MSR_EXIT_REASON_FILTER);
+
+	ret = kvm_check_cap(KVM_CAP_X86_MSR_FILTER);
+	TEST_ASSERT(ret, "KVM_CAP_X86_MSR_FILTER is unavailable");
+
+	ret = ioctl(vm->fd, KVM_X86_SET_MSR_FILTER, &test_filter);
+	TEST_ASSERT(ret == 0,
+		    "KVM_X86_SET_MSR_FILTER failed, ret: %i errno: %i (%s)",
+		    ret, errno, strerror(errno));
+
+	/* Allocate TD guest memory and initialize the TD.*/
+	initialize_td(vm);
+
+	/* Initialize the TD vcpu and copy the test code to the guest memory.*/
+	vcpu = vm_vcpu_add_tdx(vm, 0);
+
+	/* Setup and initialize VM memory */
+	prepare_source_image(vm, guest_msr_write,
+			     TDX_FUNCTION_SIZE(guest_msr_write), 0);
+	finalize_td_memory(vm);
+
+	printf("\t ... Running guest\n");
+	/* Only the write to MTTR_BASE_1 should trigger an exit */
+	vcpu_run(vcpu);
+	CHECK_GUEST_FAILURE(vcpu);
+	data = read_64bit_from_guest(vcpu, TDX_DATA_REPORT_PORT);
+	ASSERT_EQ(data, TDX_VMCALL_INVALID_OPERAND);
+
+	vcpu_run(vcpu);
+	CHECK_GUEST_COMPLETION(vcpu);
+
+	printf("\t ... Verifying MTTR values writen by guest\n");
+
+	ASSERT_EQ(vcpu_get_msr(vcpu, MTTR_BASE_0), 4);
+	ASSERT_EQ(vcpu_get_msr(vcpu, MTTR_BASE_1), 0);
+	ASSERT_EQ(vcpu_get_msr(vcpu, MTTR_BASE_2), 6);
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
 int main(int argc, char **argv)
 {
 	if (!is_tdx_enabled()) {
@@ -670,6 +897,8 @@ int main(int argc, char **argv)
 	run_in_new_process(&verify_get_td_vmcall_info);
 	run_in_new_process(&verify_guest_writes);
 	run_in_new_process(&verify_guest_reads);
+	run_in_new_process(&verify_guest_msr_reads);
+	run_in_new_process(&verify_guest_msr_writes);
 
 	return 0;
 }
-- 
2.37.2.789.g6183377224-goog

