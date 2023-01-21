Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED98676227
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jan 2023 01:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjAUAS3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Jan 2023 19:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjAUASP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Jan 2023 19:18:15 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1860E0504
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:17:45 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-4fb212e68b7so59024497b3.0
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rfsY1LSMZWbkB3lzXo82d1IvFhV8JL2sADgvMPah8iE=;
        b=iOjwDOWBLA+75vHNu041s40M+FhZkzA3407S5hBkV79p5NSRaF7IU9DIGyOAlBbJoX
         z/14b1ayPGaPg6JBGlwHj9sU9hxIGQ5kxlc8GbUMUbicrfUe/hvPJKB80Pq/idC7RquH
         5x3R+qd2Rp70khxwTrGlKox2h1VNHn/9ZHD4qMYkcO9fKLZjaJ/DI03P9QduZwtLZrrY
         2IN4ubI9WsgtkW1fh3/5ettAd38ZWBW7uHzTWYy2ZKScSKvP+oDd4kjVEXs2DBvnbj9L
         8wuLw+gIyWbQXjZ+vfluxPl9PiK6W29xbaU7Wwah+4v02L/mEcwftEmwq6puQdXuJI1p
         lHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rfsY1LSMZWbkB3lzXo82d1IvFhV8JL2sADgvMPah8iE=;
        b=TY3FNHKS8YNx/QiyzH1zDVnmizVWsYjjCdD9wTTMAcDHbxqF2EI15y7cKCe71QXGMj
         DDskIbmuWq0VjQve8IRBWr+Aeuhelk2kNwMSYsTFJsqEX1XBkI2irfsIJjz2sKKhuq7D
         JCMNb3wI1moAMoZXnMwFHQqBT8JZFUU4u5+0Xk29Qw/rxP/GjOTA/HcVOK5Q0D4380JU
         dvfqjU7w+x7/LQoL9MePMt6a6gP9CdBC4AxllDIEhR5HS+eb1v2UYJyFxIukaDzyC6mo
         2niQFjl6bxYb7xkQZvOxPH/4ff9RzGQA4xCKe8V+s190GvTJE6pEUttjlBi/y4ueOR/C
         ShLw==
X-Gm-Message-State: AFqh2koR74iHOL/q+lS5Oxec1cfFrSSgHU2Rka2ChzW4zEPmNCG8T18Z
        wfhdAqvPNEZ7SYnZLM1G0BtIJlGRBCR6HfUv1EeZ+7gMEb9hkMdmsg0cuu07FngwojlTx1uLqSV
        ZKU82heuXRFg38djGo3iVXc8z60ecRmrF2dstxTGbf5uC8SoIyNEziaeAlhqYmwZcGCV0eEvZyb
        EiPSXYeeZdsh8=
X-Google-Smtp-Source: AMrXdXuGQ/uTHxxtm+W+laNGWc0n8lUwlm0ZAYDNMJSsXsmvJ1Xc5HBhOnuhLPLPAamVVKNduZp2XSu1xPjt2GsL5A==
X-Received: from ackerleytng-cloudtop-sg.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:b30])
 (user=ackerleytng job=sendgmr) by 2002:a5b:58a:0:b0:7bb:3b2d:718f with SMTP
 id l10-20020a5b058a000000b007bb3b2d718fmr1765369ybp.302.1674260241431; Fri,
 20 Jan 2023 16:17:21 -0800 (PST)
Date:   Sat, 21 Jan 2023 00:15:27 +0000
In-Reply-To: <20230121001542.2472357-1-ackerleytng@google.com>
Mime-Version: 1.0
References: <20230121001542.2472357-1-ackerleytng@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230121001542.2472357-17-ackerleytng@google.com>
Subject: [RFC PATCH v3 16/31] KVM: selftests: TDX: Add TDX MSR read/write tests
From:   Ackerley Tng <ackerleytng@google.com>
To:     linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, seanjc@google.com, isaku.yamahata@intel.com,
        sagis@google.com, erdemaktas@google.com, afranji@google.com,
        runanwang@google.com, shuah@kernel.org, drjones@redhat.com,
        maz@kernel.org, bgardon@google.com, jmattson@google.com,
        dmatlack@google.com, peterx@redhat.com, oupton@google.com,
        ricarkol@google.com, yang.zhong@intel.com, wei.w.wang@intel.com,
        xiaoyao.li@intel.com, pgonda@google.com, marcorr@google.com,
        eesposit@redhat.com, borntraeger@de.ibm.com, eric.auger@redhat.com,
        wangyanan55@huawei.com, aaronlewis@google.com, vkuznets@redhat.com,
        pshier@google.com, axelrasmussen@google.com,
        zhenzhong.duan@intel.com, maciej.szmigiero@oracle.com,
        like.xu@linux.intel.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Sagi Shahar <sagis@google.com>

The test verifies reads and writes for MSR registers with different access
level.

Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
Changes RFCv2 -> RFCv3
+ Fixed typo in MTTR->MTRR
---
 .../selftests/kvm/include/x86_64/tdx/tdx.h    |   4 +
 .../selftests/kvm/lib/x86_64/tdx/tdx.c        |  27 +++
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 217 ++++++++++++++++++
 3 files changed, 248 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
index 37ad16943e299..fbac1951cfe35 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
@@ -8,11 +8,15 @@
 #define TDG_VP_VMCALL_REPORT_FATAL_ERROR 0x10003

 #define TDG_VP_VMCALL_INSTRUCTION_IO 30
+#define TDG_VP_VMCALL_INSTRUCTION_RDMSR 31
+#define TDG_VP_VMCALL_INSTRUCTION_WRMSR 32

 uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
 				      uint64_t write, uint64_t *data);
 void tdg_vp_vmcall_report_fatal_error(uint64_t error_code, uint64_t data_gpa);
 uint64_t tdg_vp_vmcall_get_td_vmcall_info(uint64_t *r11, uint64_t *r12,
 					uint64_t *r13, uint64_t *r14);
+uint64_t tdg_vp_vmcall_instruction_rdmsr(uint64_t index, uint64_t *ret_value);
+uint64_t tdg_vp_vmcall_instruction_wrmsr(uint64_t index, uint64_t value);

 #endif // SELFTEST_TDX_TDX_H
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
index 7254d61515db2..43088d6f40b50 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
@@ -66,3 +66,30 @@ uint64_t tdg_vp_vmcall_get_td_vmcall_info(uint64_t *r11, uint64_t *r12,

 	return ret;
 }
+
+uint64_t tdg_vp_vmcall_instruction_rdmsr(uint64_t index, uint64_t *ret_value)
+{
+	uint64_t ret;
+	struct tdx_hypercall_args args = {
+		.r11 = TDG_VP_VMCALL_INSTRUCTION_RDMSR,
+		.r12 = index,
+	};
+
+	ret = __tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT);
+
+	if (ret_value)
+		*ret_value = args.r11;
+
+	return ret;
+}
+
+uint64_t tdg_vp_vmcall_instruction_wrmsr(uint64_t index, uint64_t value)
+{
+	struct tdx_hypercall_args args = {
+		.r11 = TDG_VP_VMCALL_INSTRUCTION_WRMSR,
+		.r12 = index,
+		.r13 = value,
+	};
+
+	return __tdx_hypercall(&args, 0);
+}
diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
index 71aa4e5907a05..65ca1ec2a6e82 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -514,6 +514,221 @@ void verify_guest_reads(void)
 	printf("\t ... PASSED\n");
 }

+/*
+ * Define a filter which denies all MSR access except the following:
+ * MTTR_BASE_0: Allow read/write access
+ * MTTR_BASE_1: Allow read access
+ * MTTR_BASE_2: Allow write access
+ */
+static u64 tdx_msr_test_allow_bits = 0xFFFFFFFFFFFFFFFF;
+#define MTTR_BASE_0 (0x200)
+#define MTTR_BASE_1 (0x202)
+#define MTTR_BASE_2 (0x204)
+struct kvm_msr_filter tdx_msr_test_filter = {
+	.flags = KVM_MSR_FILTER_DEFAULT_DENY,
+	.ranges = {
+		{
+			.flags = KVM_MSR_FILTER_READ |
+				 KVM_MSR_FILTER_WRITE,
+			.nmsrs = 1,
+			.base = MTTR_BASE_0,
+			.bitmap = (uint8_t *)&tdx_msr_test_allow_bits,
+		}, {
+			.flags = KVM_MSR_FILTER_READ,
+			.nmsrs = 1,
+			.base = MTTR_BASE_1,
+			.bitmap = (uint8_t *)&tdx_msr_test_allow_bits,
+		}, {
+			.flags = KVM_MSR_FILTER_WRITE,
+			.nmsrs = 1,
+			.base = MTTR_BASE_2,
+			.bitmap = (uint8_t *)&tdx_msr_test_allow_bits,
+		},
+	},
+};
+
+/*
+ * Verifies MSR read functionality.
+ */
+void guest_msr_read(void)
+{
+	uint64_t data;
+	uint64_t ret;
+
+	ret = tdg_vp_vmcall_instruction_rdmsr(MTTR_BASE_0, &data);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	ret = tdx_test_report_64bit_to_user_space(data);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	ret = tdg_vp_vmcall_instruction_rdmsr(MTTR_BASE_1, &data);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	ret = tdx_test_report_64bit_to_user_space(data);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	/* We expect this call to fail since MTTR_BASE_2 is write only */
+	ret = tdg_vp_vmcall_instruction_rdmsr(MTTR_BASE_2, &data);
+	if (ret) {
+		ret = tdx_test_report_64bit_to_user_space(ret);
+		if (ret)
+			tdx_test_fatal(ret);
+	} else {
+		tdx_test_fatal(-99);
+	}
+
+	tdx_test_success();
+}
+
+void verify_guest_msr_reads(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+
+	uint64_t data;
+	int ret;
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+
+	/*
+	 * Set explicit MSR filter map to control access to the MSR registers
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
+	ret = ioctl(vm->fd, KVM_X86_SET_MSR_FILTER, &tdx_msr_test_filter);
+	TEST_ASSERT(ret == 0,
+		    "KVM_X86_SET_MSR_FILTER failed, ret: %i errno: %i (%s)",
+		    ret, errno, strerror(errno));
+
+	vcpu = td_vcpu_add(vm, 0, guest_msr_read);
+	td_finalize(vm);
+
+	printf("Verifying guest msr reads:\n");
+
+	printf("\t ... Setting test MTTR values\n");
+	/* valid values for mtrr type are 0, 1, 4, 5, 6 */
+	vcpu_set_msr(vcpu, MTTR_BASE_0, 4);
+	vcpu_set_msr(vcpu, MTTR_BASE_1, 5);
+	vcpu_set_msr(vcpu, MTTR_BASE_2, 6);
+
+	printf("\t ... Running guest\n");
+	vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	data = tdx_test_read_64bit_report_from_guest(vcpu);
+	ASSERT_EQ(data, 4);
+
+	vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	data = tdx_test_read_64bit_report_from_guest(vcpu);
+	ASSERT_EQ(data, 5);
+
+	vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	data = tdx_test_read_64bit_report_from_guest(vcpu);
+	ASSERT_EQ(data, TDG_VP_VMCALL_INVALID_OPERAND);
+
+	vcpu_run(vcpu);
+	TDX_TEST_ASSERT_SUCCESS(vcpu);
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
+/*
+ * Verifies MSR write functionality.
+ */
+void guest_msr_write(void)
+{
+	uint64_t ret;
+
+	ret = tdg_vp_vmcall_instruction_wrmsr(MTTR_BASE_0, 4);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	/* We expect this call to fail since MTTR_BASE_1 is read only */
+	ret = tdg_vp_vmcall_instruction_wrmsr(MTTR_BASE_1, 5);
+	if (ret) {
+		ret = tdx_test_report_64bit_to_user_space(ret);
+		if (ret)
+			tdx_test_fatal(ret);
+	} else {
+		tdx_test_fatal(-99);
+	}
+
+
+	ret = tdg_vp_vmcall_instruction_wrmsr(MTTR_BASE_2, 6);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	tdx_test_success();
+}
+
+void verify_guest_msr_writes(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	uint64_t data;
+	int ret;
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+
+	/*
+	 * Set explicit MSR filter map to control access to the MSR registers
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
+	ret = ioctl(vm->fd, KVM_X86_SET_MSR_FILTER, &tdx_msr_test_filter);
+	TEST_ASSERT(ret == 0,
+		    "KVM_X86_SET_MSR_FILTER failed, ret: %i errno: %i (%s)",
+		    ret, errno, strerror(errno));
+
+	vcpu = td_vcpu_add(vm, 0, guest_msr_write);
+	td_finalize(vm);
+
+	printf("Verifying guest msr writes:\n");
+
+	printf("\t ... Running guest\n");
+	/* Only the write to MTTR_BASE_1 should trigger an exit */
+	vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	data = tdx_test_read_64bit_report_from_guest(vcpu);
+	ASSERT_EQ(data, TDG_VP_VMCALL_INVALID_OPERAND);
+
+	vcpu_run(vcpu);
+	TDX_TEST_ASSERT_SUCCESS(vcpu);
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
+
 int main(int argc, char **argv)
 {
 	setbuf(stdout, NULL);
@@ -530,6 +745,8 @@ int main(int argc, char **argv)
 	run_in_new_process(&verify_get_td_vmcall_info);
 	run_in_new_process(&verify_guest_writes);
 	run_in_new_process(&verify_guest_reads);
+	run_in_new_process(&verify_guest_msr_writes);
+	run_in_new_process(&verify_guest_msr_reads);

 	return 0;
 }
--
2.39.0.246.g2a6d74b583-goog
