Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AB55A7093
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 00:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiH3WUk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 18:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbiH3WUe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 18:20:34 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1AB4E62A
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:20:19 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 92-20020a17090a09e500b001d917022847so5214633pjo.1
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=sMSKVgYi+NQVBY9S65ltrEDvFSNwWuSwBWyaYR7CUj4=;
        b=OJS0Nn/GPz/gpL1O+Y6+R1pzOQuvLM9Zfw1WHuhf1AmdkfMk9ofK2yVxApO6yyyCmm
         9PUADX4nZ9qN6FCMXondDy/69esGmzAqfLt1PIfqSOLlQ8frQ1rDlqVZTAiKJsaI7Z4C
         Bg1ek3U/Nwupy+YXNHJ4Y6sejApfs94fxiU6b104D8s8GuC/iO9Taa0iQaUVumtoqf6j
         Jyqa5QteTfvPIE0VQDpoidenyc72nKGaP4+wbnDRZTz0t49pI7GZFvfzDbD5SWyr08Qb
         oKRRHzZMm55T0d69G1REstnG0jd4lwpfacsIIjTVjuDa7SyCRV08BQVd7l8eWQ88LFKg
         8j3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=sMSKVgYi+NQVBY9S65ltrEDvFSNwWuSwBWyaYR7CUj4=;
        b=waWv5y5MuZJf4tmxzK7Q2VPfkj8Vxo7tzeHMJSSRMfG42TcXtgozjIPmoOYbmmRKyM
         yyLo8iIljpvO3iBXLfi/ADcbzVsVzDLoWs0kQ2nWfwNsWLUP+rFI0JPSaYteoTKN6KCi
         PjyAn3iJb9w4KMXLs22k+nMlUqPJHvpzSdZ0UvanHfRbpExMA1cZWA29swq6BjtZQxSS
         evJv02MJk7FdXzVrbXPqGFEXQzGfPfSfnCTPWyQJJGNK9IHT6fhZ24TpRl00t/05HapO
         nq8YgJghLzBIZq5XXISRlh19Bz60pSJOqRtJUQWo/Qar7h6dvGyzjgsP1gV0JJgMsGpP
         /HKQ==
X-Gm-Message-State: ACgBeo1eb7UnrynFXpvDYP0/bvOU1XDx+TfwBSDhgW2Kxj5pw7Wz/w7I
        bccx5q+kda7/aaHx49DTcIFFt1ExaiiS/vDWuHc9awZXtSLm0LrGIMQ6SURvBgoUt2LNyu/wKxz
        KL2KoI08S1yNn0X7F+7PzE+d4FKVrR6S4sfSpEBl1wYE5/uf3zJeNo//0/DN2LQ0ch90UoRI=
X-Google-Smtp-Source: AA6agR67quWcW4kBcXZag7XBF+W0FktEv/vP+E2ojRFsmYh9WrvWOPXiyQxu5VZVsCvqrZ5OVKvXx7OH4w==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a17:90a:249:b0:1e0:a8a3:3c6c with SMTP id
 t9-20020a17090a024900b001e0a8a33c6cmr1010pje.0.1661898015842; Tue, 30 Aug
 2022 15:20:15 -0700 (PDT)
Date:   Tue, 30 Aug 2022 22:19:49 +0000
In-Reply-To: <20220830222000.709028-1-sagis@google.com>
Mime-Version: 1.0
References: <20220830222000.709028-1-sagis@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220830222000.709028-7-sagis@google.com>
Subject: [RFC PATCH v2 06/17] KVM: selftest: TDX: Add basic TDX CPUID test
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

The test reads CPUID values from inside a TD VM and compare them
to expected values.

The test targets CPUID values which are virtualized as "As Configured",
"As Configured (if Native)", "Calculated", "Fixed" and "Native"
according to the TDX spec.

Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/lib/x86_64/tdx.h  |  13 ++
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 132 ++++++++++++++++++
 2 files changed, 145 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx.h b/tools/testing/selftests/kvm/lib/x86_64/tdx.h
index c78dba1af14f..a28d15417d3e 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx.h
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx.h
@@ -56,6 +56,7 @@
 
 #define TDX_SUCCESS_PORT 0x30
 #define TDX_TEST_PORT 0x31
+#define TDX_DATA_REPORT_PORT 0x32
 #define TDX_IO_READ 0
 #define TDX_IO_WRITE 1
 
@@ -231,6 +232,18 @@ static inline void tdvmcall_fatal(uint64_t error_code)
 	tdcall(&regs);
 }
 
+/*
+ * Reports a 32 bit value from the guest to user space using a TDVM IO call.
+ * Data is reported on port TDX_DATA_REPORT_PORT.
+ */
+static inline uint64_t tdvm_report_to_user_space(uint32_t data)
+{
+	// Need to upcast data to match tdvmcall_io signature.
+	uint64_t data_64 = data;
+
+	return tdvmcall_io(TDX_DATA_REPORT_PORT, /*size=*/4, TDX_IO_WRITE, &data_64);
+}
+
 #define TDX_FUNCTION_SIZE(name) ((uint64_t)&__stop_sec_ ## name -\
 			   (uint64_t)&__start_sec_ ## name) \
 
diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
index a93629cfd13f..3f51f936ea5a 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -77,6 +77,27 @@ bool is_tdx_enabled(void)
 	return !!(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_TDX_VM));
 }
 
+/*
+ * Find a specific CPUID entry.
+ */
+static struct kvm_cpuid_entry2 *
+find_cpuid_entry(struct tdx_cpuid_data cpuid_data, uint32_t function,
+		 uint32_t index)
+{
+	struct kvm_cpuid_entry2 *e;
+	int i;
+
+	for (i = 0; i < cpuid_data.cpuid.nent; i++) {
+		e = &cpuid_data.entries[i];
+
+		if (e->function == function &&
+		    (e->index == index ||
+		     !(e->flags & KVM_CPUID_FLAG_SIGNIFCANT_INDEX)))
+			return e;
+	}
+	return NULL;
+}
+
 /*
  * Do a dummy io exit to verify that the TD has been initialized correctly and
  * guest can run some code inside.
@@ -251,6 +272,116 @@ void verify_td_ioexit(void)
 	printf("\t ... PASSED\n");
 }
 
+/*
+ * Verifies CPUID functionality by reading CPUID values in guest. The guest
+ * will then send the values to userspace using an IO write to be checked
+ * against the expected values.
+ */
+TDX_GUEST_FUNCTION(guest_code_cpuid)
+{
+	uint64_t err;
+	uint32_t eax, ebx, edx, ecx;
+
+	// Read CPUID leaf 0x1.
+	cpuid(1, &eax, &ebx, &ecx, &edx);
+
+	err = tdvm_report_to_user_space(ebx);
+	if (err)
+		tdvmcall_fatal(err);
+
+	err = tdvm_report_to_user_space(ecx);
+	if (err)
+		tdvmcall_fatal(err);
+
+	tdvmcall_success();
+}
+
+void verify_td_cpuid(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	uint32_t ebx, ecx;
+	struct kvm_cpuid_entry2 *cpuid_entry;
+	struct tdx_cpuid_data cpuid_data;
+	uint32_t guest_clflush_line_size;
+	uint32_t guest_max_addressable_ids, host_max_addressable_ids;
+	uint32_t guest_sse3_enabled;
+	uint32_t guest_fma_enabled;
+	uint32_t guest_initial_apic_id;
+	int ret;
+
+	printf("Verifying TD CPUID:\n");
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
+	prepare_source_image(vm, guest_code_cpuid,
+			     TDX_FUNCTION_SIZE(guest_code_cpuid), 0);
+	finalize_td_memory(vm);
+
+	/* Wait for guest to report ebx value */
+	vcpu_run(vcpu);
+	CHECK_GUEST_FAILURE(vcpu);
+	CHECK_IO(vcpu, TDX_DATA_REPORT_PORT, 4, TDX_IO_WRITE);
+	ebx = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	/* Wait for guest to report either ecx value or error */
+	vcpu_run(vcpu);
+	CHECK_GUEST_FAILURE(vcpu);
+	CHECK_IO(vcpu, TDX_DATA_REPORT_PORT, 4, TDX_IO_WRITE);
+	ecx = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	/* Wait for guest to complete execution */
+	vcpu_run(vcpu);
+	CHECK_GUEST_FAILURE(vcpu);
+	CHECK_GUEST_COMPLETION(vcpu);
+
+	/* Verify the CPUID values we got from the guest. */
+	printf("\t ... Verifying CPUID values from guest\n");
+
+	/* Get KVM CPUIDs for reference */
+	memset(&cpuid_data, 0, sizeof(cpuid_data));
+	cpuid_data.cpuid.nent = KVM_MAX_CPUID_ENTRIES;
+	ret = ioctl(vm->kvm_fd, KVM_GET_SUPPORTED_CPUID, &cpuid_data);
+	TEST_ASSERT(!ret, "KVM_GET_SUPPORTED_CPUID failed\n");
+	cpuid_entry = find_cpuid_entry(cpuid_data, 1, 0);
+	TEST_ASSERT(cpuid_entry, "CPUID entry missing\n");
+
+	host_max_addressable_ids = (cpuid_entry->ebx >> 16) & 0xFF;
+
+	guest_sse3_enabled = ecx & 0x1;  // Native
+	guest_clflush_line_size = (ebx >> 8) & 0xFF;  // Fixed
+	guest_max_addressable_ids = (ebx >> 16) & 0xFF;  // As Configured
+	guest_fma_enabled = (ecx >> 12) & 0x1;  // As Configured (if Native)
+	guest_initial_apic_id = (ebx >> 24) & 0xFF;  // Calculated
+
+	ASSERT_EQ(guest_sse3_enabled, 1);
+	ASSERT_EQ(guest_clflush_line_size, 8);
+	ASSERT_EQ(guest_max_addressable_ids, host_max_addressable_ids);
+
+	/* TODO: This only tests the native value. To properly test
+	 * "As Configured (if Native)" we need to override this value
+	 * in the TD params
+	 */
+	ASSERT_EQ(guest_fma_enabled, 1);
+
+	/* TODO: guest_initial_apic_id is calculated based on the number of
+	 * VCPUs in the TD. From the spec: "Virtual CPU index, starting from 0
+	 * and allocated sequentially on each successful TDH.VP.INIT"
+	 * To test non-trivial values we either need a TD with multiple VCPUs
+	 * or to pick a different calculated value.
+	 */
+	ASSERT_EQ(guest_initial_apic_id, 0);
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
 
 int main(int argc, char **argv)
 {
@@ -262,6 +393,7 @@ int main(int argc, char **argv)
 	run_in_new_process(&verify_td_lifecycle);
 	run_in_new_process(&verify_report_fatal_error);
 	run_in_new_process(&verify_td_ioexit);
+	run_in_new_process(&verify_td_cpuid);
 
 	return 0;
 }
-- 
2.37.2.789.g6183377224-goog

