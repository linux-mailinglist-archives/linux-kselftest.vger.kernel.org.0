Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571665A70AE
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 00:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbiH3WWQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 18:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbiH3WVc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 18:21:32 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A8281B08
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:20:51 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id j3-20020a634a43000000b00429f2cb4a43so6089958pgl.0
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=vMcvJ9jQS2E+g0S4PWnxHHd/lgPl91w8YK5lh2IoNIY=;
        b=jV6AN7Z+y5CcrU1zuFjC1bs4zOXiI/KNzt8q7rrE/DlpGjqcYKxo1MSZMuDsUKCGPz
         Xg+wdvoP7BaiKdNcuzzlXsAegakE9fl8EFQEPaImhbwAV6NZcesUVtHLUvkoCAJzwgXD
         k0QJGr+vksiv0kqz728ku2dXh2yxrk23a2vsm7EHM1hm+d86J/R4uXiMyK2+mV6RXDTu
         c4WFpu3+KVakDdVZcoJ/HLobUfjQbZd8MixJ3oq6ATLTSsBddVMOqa/ILyw7rF+Jq6pL
         sNWns12rd1DjHMgQVTHb7HE6U5Gysi2FWA3+kszDCPHaZTdZhPPW+beb8hBSK8uXBbha
         TX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=vMcvJ9jQS2E+g0S4PWnxHHd/lgPl91w8YK5lh2IoNIY=;
        b=dMYuTzwVtewh279efTw2xX4J0gQS+poLYz26eKigiXmgq1jZ4AQ/aKIyp5LbdhRcWc
         7l3JO5+2ndxVL7c11v6J7qZWqKXN43G8wTBuh3bwu7TxXUSBHHdGz9VlIOgtWaFQTbDY
         edxeqUa5jiztSXAoxLuyIfPByAIC0T1ttNgaNcqtLPKzeWJ62VRLzu4S2DxHoe2wftTp
         DrhkTGlSSjxPD5Zajf044gVwZEQS82cVpkas1l7rtX2ZL9JUkWiSht76om8CGxRdqBzD
         KydLLhRiYde/lQmlFfnl7Qn/ttEc4WiGSZC/5v3e9K7+GM4XiCjGYvZ87UMzrthOoy+z
         yTYQ==
X-Gm-Message-State: ACgBeo1MprbBXQVxEhJlmSmXp0PT2If/uNzY2Omz8U7In14JQynj2SN8
        Wsmmn9219ZJalrTR3hBdbE64MmXwXjOCU+UXXBd4Xi5ng0tnSITu6wA0D4yzngK0ETNSdWwhhbZ
        +9lVHNqvctl8tEa7Q+QeJVlpdlaWlEEg1NpfTf3caSYOEBPJVL+8Icr9mw+wEzMMprzEbe2c=
X-Google-Smtp-Source: AA6agR7llbVa2geVxu4+4rCNPnonZfb8yeHEc/Ey8ehBBGcxWv7pm5z0heEP8eSlDFUnGJBumhRsFeUnmw==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a17:902:7048:b0:172:bc91:56b9 with SMTP id
 h8-20020a170902704800b00172bc9156b9mr23401051plt.125.1661898029897; Tue, 30
 Aug 2022 15:20:29 -0700 (PDT)
Date:   Tue, 30 Aug 2022 22:19:57 +0000
In-Reply-To: <20220830222000.709028-1-sagis@google.com>
Mime-Version: 1.0
References: <20220830222000.709028-1-sagis@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220830222000.709028-15-sagis@google.com>
Subject: [RFC PATCH v2 14/17] KVM: selftest: TDX: Add TDX CPUID TDVMCALL test
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

This test issues a CPUID TDVMCALL from inside the guest to get the CPUID
values as seen by KVM.

Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/lib/x86_64/tdx.h  |  23 ++++
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 102 ++++++++++++++++++
 2 files changed, 125 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx.h b/tools/testing/selftests/kvm/lib/x86_64/tdx.h
index 17e3649e5729..3729543a05a3 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx.h
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx.h
@@ -56,6 +56,7 @@
 
 #define TDX_GET_TD_VM_CALL_INFO 0x10000
 #define TDX_REPORT_FATAL_ERROR 0x10003
+#define TDX_INSTRUCTION_CPUID 10
 #define TDX_INSTRUCTION_HLT 12
 #define TDX_INSTRUCTION_IO 30
 #define TDX_INSTRUCTION_RDMSR 31
@@ -347,6 +348,28 @@ static inline uint64_t tdvmcall_mmio_write(uint64_t address, uint64_t size, uint
 	return regs.r10;
 }
 
+/*
+ * Execute CPUID instruction.
+ */
+static inline uint64_t tdvmcall_cpuid(uint32_t eax, uint32_t ecx,
+				      uint32_t *ret_eax, uint32_t *ret_ebx,
+				      uint32_t *ret_ecx, uint32_t *ret_edx)
+{
+	struct kvm_regs regs;
+
+	memset(&regs, 0, sizeof(regs));
+	regs.r11 = TDX_INSTRUCTION_CPUID;
+	regs.r12 = eax;
+	regs.r13 = ecx;
+	regs.rcx = 0xFC00;
+	tdcall(&regs);
+	*ret_eax = regs.r12;
+	*ret_ebx = regs.r13;
+	*ret_ecx = regs.r14;
+	*ret_edx = regs.r15;
+	return regs.r10;
+}
+
 /*
  * Reports a 32 bit value from the guest to user space using a TDVM IO call.
  * Data is reported on port TDX_DATA_REPORT_PORT.
diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
index 382119bd444b..934f2f7a5df9 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -459,6 +459,107 @@ void verify_td_cpuid(void)
 	printf("\t ... PASSED\n");
 }
 
+/*
+ * Verifies CPUID TDVMCALL functionality.
+ * The guest will then send the values to userspace using an IO write to be
+ * checked against the expected values.
+ */
+TDX_GUEST_FUNCTION(guest_code_cpuid_tdcall)
+{
+	uint64_t err;
+	uint32_t eax, ebx, ecx, edx;
+
+	// Read CPUID leaf 0x1 from host.
+	err = tdvmcall_cpuid(/*eax=*/1, /*ecx=*/0, &eax, &ebx, &ecx, &edx);
+	if (err)
+		tdvmcall_fatal(err);
+
+	err = tdvm_report_to_user_space(eax);
+	if (err)
+		tdvmcall_fatal(err);
+
+	err = tdvm_report_to_user_space(ebx);
+	if (err)
+		tdvmcall_fatal(err);
+
+	err = tdvm_report_to_user_space(ecx);
+	if (err)
+		tdvmcall_fatal(err);
+
+	err = tdvm_report_to_user_space(edx);
+	if (err)
+		tdvmcall_fatal(err);
+
+	tdvmcall_success();
+}
+
+void verify_td_cpuid_tdcall(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	uint32_t eax, ebx, ecx, edx;
+	struct kvm_cpuid_entry2 *cpuid_entry;
+	struct tdx_cpuid_data cpuid_data;
+	int ret;
+
+	printf("Verifying TD CPUID TDVMCALL:\n");
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
+	prepare_source_image(vm, guest_code_cpuid_tdcall,
+			     TDX_FUNCTION_SIZE(guest_code_cpuid_tdcall), 0);
+	finalize_td_memory(vm);
+
+	/* Wait for guest to report CPUID values */
+	vcpu_run(vcpu);
+	CHECK_GUEST_FAILURE(vcpu);
+	CHECK_IO(vcpu, TDX_DATA_REPORT_PORT, 4, TDX_IO_WRITE);
+	eax = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	vcpu_run(vcpu);
+	CHECK_GUEST_FAILURE(vcpu);
+	CHECK_IO(vcpu, TDX_DATA_REPORT_PORT, 4, TDX_IO_WRITE);
+	ebx = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	vcpu_run(vcpu);
+	CHECK_GUEST_FAILURE(vcpu);
+	CHECK_IO(vcpu, TDX_DATA_REPORT_PORT, 4, TDX_IO_WRITE);
+	ecx = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	vcpu_run(vcpu);
+	CHECK_GUEST_FAILURE(vcpu);
+	CHECK_IO(vcpu, TDX_DATA_REPORT_PORT, 4, TDX_IO_WRITE);
+	edx = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	vcpu_run(vcpu);
+	CHECK_GUEST_FAILURE(vcpu);
+	CHECK_GUEST_COMPLETION(vcpu);
+
+	/* Get KVM CPUIDs for reference */
+	memset(&cpuid_data, 0, sizeof(cpuid_data));
+	cpuid_data.cpuid.nent = KVM_MAX_CPUID_ENTRIES;
+	ret = ioctl(vm->kvm_fd, KVM_GET_SUPPORTED_CPUID, &cpuid_data);
+	TEST_ASSERT(!ret, "KVM_GET_SUPPORTED_CPUID failed\n");
+	cpuid_entry = find_cpuid_entry(cpuid_data, 1, 0);
+	TEST_ASSERT(cpuid_entry, "CPUID entry missing\n");
+
+	ASSERT_EQ(cpuid_entry->eax, eax);
+	// Mask lapic ID when comparing ebx.
+	ASSERT_EQ(cpuid_entry->ebx & ~0xFF000000, ebx & ~0xFF000000);
+	ASSERT_EQ(cpuid_entry->ecx, ecx);
+	ASSERT_EQ(cpuid_entry->edx, edx);
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
 /*
  * Verifies get_td_vmcall_info functionality.
  */
@@ -1184,6 +1285,7 @@ int main(int argc, char **argv)
 	run_in_new_process(&verify_report_fatal_error);
 	run_in_new_process(&verify_td_ioexit);
 	run_in_new_process(&verify_td_cpuid);
+	run_in_new_process(&verify_td_cpuid_tdcall);
 	run_in_new_process(&verify_get_td_vmcall_info);
 	run_in_new_process(&verify_guest_writes);
 	run_in_new_process(&verify_guest_reads);
-- 
2.37.2.789.g6183377224-goog

