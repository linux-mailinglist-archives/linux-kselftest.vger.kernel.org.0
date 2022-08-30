Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E765A7091
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 00:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbiH3WUj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 18:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiH3WUY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 18:20:24 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC894A82E
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:20:18 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id e11-20020a17090a630b00b001f8b2deb88dso11834867pjj.1
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=xND6YprCPZaQfpHo5dST5YbROtuGVFjyk8gKa/6IPBk=;
        b=ihbMRkP6LsisdZGdDSPBzStuAZmKk3JB59/cYAJtuNTJ2cOdmKtcPsX+9Y9WE4rfpv
         vgYOKUHpBCwMSlmOerTzfPv4fmUL5At8WQduTf4NtNmYGZpLCyywSQT2Jp+kN6E8uNFV
         EepkBJ87b4P1IjxdGwbI8BmSnztidDFGgOjsb3LHMBcm9aLfFXt4aSLsE1EilcD7ap5L
         FTag25ZySHcLIEbgXeHAbmEH2+sO7GmRffsS1/3sNPa7ZllFLqwWJLu8R+ruByRZ4B/V
         sI3Iieu3p0jj3Y7Rzw4Shshnx2WugrYTDfqwQXnZ6EnaEFapcLFdgAqTEPg6sxK/DduH
         qkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=xND6YprCPZaQfpHo5dST5YbROtuGVFjyk8gKa/6IPBk=;
        b=GVJh1t8kJrPHFQDLOnjWhfgz3OK1jywZoCXN2vBuMr5mlWyUlLlwWn3455aSK28wJz
         shHxM+pstSXjN1TUUZyrLuXANeArbLv5s1+/JpEfCWEwwpyKCPPnjuSnQvwlxvF95sxg
         HgQnOGfwmx/vZfUC41weuUEfdkKFe3r7VKnF+KSTg6T3XYit1lxmx1PeKxpj/TkBybJ0
         zyZhq6tyLDTR9Ni8ecSwZn0vV+okGOtekxlJnQIKHY278T0wha81UC69hlW+U61KtLIX
         1LvGCg4aqInYrDbw+jOp5xtn+jL9QB0+rVQz2mtiCMnetufy9PogxOEJNtFfuIsFuEsz
         ogZg==
X-Gm-Message-State: ACgBeo11ULaXygWmc2IJ3J7Oct7Brv5BZmw1X3RRm5LaFubQAsIwdbdY
        VFbjbXg+a05a1csFGEOh0mU1hCgxJpIfncH/bi82fz/qVtVmq6jlOWJZPLB9NymaYHIBQWN+H/+
        rcdHhxGE8br0gVtGEfX1ce+9Cjhdcyff3GzWxWwwJsr/vovD0emhMuqw8iMiXQXVCtlqb9NU=
X-Google-Smtp-Source: AA6agR46bO17fnMxZM7TZ/5H7eKsa6pyH2qDyyeilP3PCFJj5Lb/9uX36JbQNKo/PIfxwnLmGVSszRTS6w==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a17:90a:bb96:b0:1fd:8068:cfd4 with SMTP id
 v22-20020a17090abb9600b001fd8068cfd4mr186096pjr.114.1661898017506; Tue, 30
 Aug 2022 15:20:17 -0700 (PDT)
Date:   Tue, 30 Aug 2022 22:19:50 +0000
In-Reply-To: <20220830222000.709028-1-sagis@google.com>
Mime-Version: 1.0
References: <20220830222000.709028-1-sagis@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220830222000.709028-8-sagis@google.com>
Subject: [RFC PATCH v2 07/17] KVM: selftest: TDX: Add basic get_td_vmcall_info test
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

The test calls get_td_vmcall_info from the guest and verifies the
expected returned values.

Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/lib/x86_64/tdx.h  |  43 +++++++
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 107 ++++++++++++++++++
 2 files changed, 150 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx.h b/tools/testing/selftests/kvm/lib/x86_64/tdx.h
index a28d15417d3e..39b000118e26 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx.h
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx.h
@@ -51,6 +51,7 @@
 #define _PAGE_RW            (1UL<<1)       /* writeable */
 #define _PAGE_PS            (1UL<<7)       /* page size bit*/
 
+#define TDX_GET_TD_VM_CALL_INFO 0x10000
 #define TDX_REPORT_FATAL_ERROR 0x10003
 #define TDX_INSTRUCTION_IO 30
 
@@ -232,6 +233,28 @@ static inline void tdvmcall_fatal(uint64_t error_code)
 	tdcall(&regs);
 }
 
+/*
+ * Get td vmcall info.
+ * Used to help request the host VMM enumerate which TDG.VP.VMCALLs are supported.
+ * Returns return in r10 code and leaf-specific output in r11-r14.
+ */
+static inline uint64_t tdvmcall_get_td_vmcall_info(uint64_t *r11, uint64_t *r12,
+						   uint64_t *r13, uint64_t *r14)
+{
+	struct kvm_regs regs;
+
+	memset(&regs, 0, sizeof(regs));
+	regs.r11 = TDX_GET_TD_VM_CALL_INFO;
+	regs.r12 = 0;
+	regs.rcx = 0x1C00;
+	tdcall(&regs);
+	*r11 = regs.r11;
+	*r12 = regs.r12;
+	*r13 = regs.r13;
+	*r14 = regs.r14;
+	return regs.r10;
+}
+
 /*
  * Reports a 32 bit value from the guest to user space using a TDVM IO call.
  * Data is reported on port TDX_DATA_REPORT_PORT.
@@ -244,6 +267,26 @@ static inline uint64_t tdvm_report_to_user_space(uint32_t data)
 	return tdvmcall_io(TDX_DATA_REPORT_PORT, /*size=*/4, TDX_IO_WRITE, &data_64);
 }
 
+/*
+ * Reports a 64 bit value from the guest to user space using a TDVM IO call.
+ * Data is reported on port TDX_DATA_REPORT_PORT.
+ * Data is sent to host in 2 calls. LSB is sent (and needs to be read) first.
+ */
+static inline uint64_t tdvm_report_64bit_to_user_space(uint64_t data)
+{
+	uint64_t err;
+	uint64_t data_lo = data & 0xFFFFFFFF;
+	uint64_t data_hi = (data >> 32) & 0xFFFFFFFF;
+
+	err = tdvmcall_io(TDX_DATA_REPORT_PORT, /*size=*/4, TDX_IO_WRITE,
+			  &data_lo);
+	if (err)
+		return err;
+
+	return tdvmcall_io(TDX_DATA_REPORT_PORT, /*size=*/4, TDX_IO_WRITE,
+			   &data_hi);
+}
+
 #define TDX_FUNCTION_SIZE(name) ((uint64_t)&__stop_sec_ ## name -\
 			   (uint64_t)&__start_sec_ ## name) \
 
diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
index 3f51f936ea5a..cf8260db1f5b 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -53,6 +53,25 @@
 				  (VCPU)->run->system_event.data[1]);			\
 	} while (0)
 
+static uint64_t read_64bit_from_guest(struct kvm_vcpu *vcpu, uint64_t port)
+{
+	uint32_t lo, hi;
+	uint64_t res;
+
+	CHECK_IO(vcpu, port, 4, TDX_IO_WRITE);
+	lo = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	vcpu_run(vcpu);
+
+	CHECK_IO(vcpu, port, 4, TDX_IO_WRITE);
+	hi = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	res = hi;
+	res = (res << 32) | lo;
+	return res;
+}
+
+
 /*
  * There might be multiple tests we are running and if one test fails, it will
  * prevent the subsequent tests to run due to how tests are failing with
@@ -383,6 +402,93 @@ void verify_td_cpuid(void)
 	printf("\t ... PASSED\n");
 }
 
+/*
+ * Verifies get_td_vmcall_info functionality.
+ */
+TDX_GUEST_FUNCTION(guest_code_get_td_vmcall_info)
+{
+	uint64_t err;
+	uint64_t r11, r12, r13, r14;
+
+	err = tdvmcall_get_td_vmcall_info(&r11, &r12, &r13, &r14);
+	if (err)
+		tdvmcall_fatal(err);
+
+	err = tdvm_report_64bit_to_user_space(r11);
+	if (err)
+		tdvmcall_fatal(err);
+
+	err = tdvm_report_64bit_to_user_space(r12);
+	if (err)
+		tdvmcall_fatal(err);
+
+	err = tdvm_report_64bit_to_user_space(r13);
+	if (err)
+		tdvmcall_fatal(err);
+
+	err = tdvm_report_64bit_to_user_space(r14);
+	if (err)
+		tdvmcall_fatal(err);
+
+	tdvmcall_success();
+}
+
+void verify_get_td_vmcall_info(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	uint64_t r11, r12, r13, r14;
+
+	printf("Verifying TD get vmcall info:\n");
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
+	prepare_source_image(vm, guest_code_get_td_vmcall_info,
+			     TDX_FUNCTION_SIZE(guest_code_get_td_vmcall_info),
+			     0);
+	finalize_td_memory(vm);
+
+	/* Wait for guest to report r11 value */
+	vcpu_run(vcpu);
+	CHECK_GUEST_FAILURE(vcpu);
+	r11 = read_64bit_from_guest(vcpu, TDX_DATA_REPORT_PORT);
+
+	/* Wait for guest to report r12 value */
+	vcpu_run(vcpu);
+	CHECK_GUEST_FAILURE(vcpu);
+	r12 = read_64bit_from_guest(vcpu, TDX_DATA_REPORT_PORT);
+
+	/* Wait for guest to report r13 value */
+	vcpu_run(vcpu);
+	CHECK_GUEST_FAILURE(vcpu);
+	r13 = read_64bit_from_guest(vcpu, TDX_DATA_REPORT_PORT);
+
+	/* Wait for guest to report r14 value */
+	vcpu_run(vcpu);
+	CHECK_GUEST_FAILURE(vcpu);
+	r14 = read_64bit_from_guest(vcpu, TDX_DATA_REPORT_PORT);
+
+	ASSERT_EQ(r11, 0);
+	ASSERT_EQ(r12, 0);
+	ASSERT_EQ(r13, 0);
+	ASSERT_EQ(r14, 0);
+
+	/* Wait for guest to complete execution */
+	vcpu_run(vcpu);
+	CHECK_GUEST_FAILURE(vcpu);
+	CHECK_GUEST_COMPLETION(vcpu);
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
 int main(int argc, char **argv)
 {
 	if (!is_tdx_enabled()) {
@@ -394,6 +500,7 @@ int main(int argc, char **argv)
 	run_in_new_process(&verify_report_fatal_error);
 	run_in_new_process(&verify_td_ioexit);
 	run_in_new_process(&verify_td_cpuid);
+	run_in_new_process(&verify_get_td_vmcall_info);
 
 	return 0;
 }
-- 
2.37.2.789.g6183377224-goog

