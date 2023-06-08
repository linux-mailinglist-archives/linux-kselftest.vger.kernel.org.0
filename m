Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3445727EDB
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jun 2023 13:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235994AbjFHLek (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 07:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235973AbjFHLej (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 07:34:39 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E166C1721;
        Thu,  8 Jun 2023 04:34:37 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id e9e14a558f8ab-33b1e83e1daso1422625ab.0;
        Thu, 08 Jun 2023 04:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686224077; x=1688816077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37yFKoZm2e70geEHgnXSIVZd3bC8hUwwUl4q2cKbqZE=;
        b=QVis7OW0T0e24fmwfS4XCMlnUK+mfYgDce0w6O1w+k/npw5AJO11o9tqZitLvMohSJ
         +gS/svL3y7K2B7X+BOz63yTh55Du1EvTjC1iI/CHtTfWic4U8ljHGoDvxgPUzLUK8ZNY
         s9XedMV3Ilql/dpzJx1GF1rp9xmb5aD3yqtX4tBlyuE3QWz5fEcBU9AdNfCVAUFHcWu7
         7lWOZ83tyLm0fXFuoK8K/b65keJynlpKY6xvDfva7VTrq4mCTNko1rHjZrnxrNnQJaCl
         jexeDLovDqNVqPOmIGFF3H6XHllD5dvxJmWRe35pOYnuZlWxC4UiYeD7i8Lsst3fm6NA
         H0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686224077; x=1688816077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=37yFKoZm2e70geEHgnXSIVZd3bC8hUwwUl4q2cKbqZE=;
        b=Q32/waLMhHs+0cBmbBMuGZaixvmaO9R9d7intoIoeUXQ9K5AOqunquB45FYmLoXLlH
         efurBzxc2+X+nhkn0O2T3cJqf+pCP17A6C4b/V13yVZQVFazz/R83FIJZ+LnrijcxbbH
         NSmL2+mYe5ILqlUcywwNlgFOxjSttlIFXn6JSa5HZRKhvGc2acewP+CtiineGkOIm6xW
         Mr+Ao+62cmscK+X/IBRcJbCmwi0wDBhZ6VYGGVMCxY3FveBvgmJ2M1vVi4XmNBMJ4Dfe
         6dnXKrdEiZDcWLh05QtQskUABOKpVf9s2JAdSfb4u4gFCCXTzOcCpue52faVhYDf11kK
         OZSg==
X-Gm-Message-State: AC+VfDzmhRPkfKspWeWkVbCOxjNR3BYSYC4DZ5RPLPMi6aTT+7E64GrK
        Zj+2YgqmTZcN0siiO/uhKjs=
X-Google-Smtp-Source: ACHHUZ42OlDGTlLHy3K04uVhmeFJYpa9thyzdyXyN02sfyyUd/e4VmxIqqJum6Bbut+ibtrr9AAg7g==
X-Received: by 2002:a92:da8c:0:b0:339:f9d:9f6b with SMTP id u12-20020a92da8c000000b003390f9d9f6bmr8088428iln.1.1686224076937;
        Thu, 08 Jun 2023 04:34:36 -0700 (PDT)
Received: from CLOUDLIANG-MB2.tencent.com ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id qa2-20020a17090b4fc200b002310ed024adsm2900456pjb.12.2023.06.08.04.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 04:34:36 -0700 (PDT)
From:   Jinrong Liang <ljr.kernel@gmail.com>
X-Google-Original-From: Jinrong Liang <cloudliang@tencent.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] KVM: selftests: Test consistency of setting MSR_IA32_DS_AREA
Date:   Thu,  8 Jun 2023 19:34:19 +0800
Message-Id: <20230608113420.14695-2-cloudliang@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230608113420.14695-1-cloudliang@tencent.com>
References: <20230608113420.14695-1-cloudliang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jinrong Liang <cloudliang@tencent.com>

Tests have been added to this commit to check if setting
MSR_IA32_DS_AREA with a non-classical address causes a fault. By
verifying that KVM is correctly faulting non-classical addresses
in MSR_IA32_DS_AREA, it helps ensure the accuracy and stability
of the KVM subsystem.

Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
---
 .../selftests/kvm/x86_64/vmx_pmu_caps_test.c  | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
index 4c90f76930f9..02903084598f 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
@@ -19,6 +19,9 @@
 #include "kvm_util.h"
 #include "vmx.h"
 
+#define MAX_LINEAR_ADDR_MASK		GENMASK_ULL(15, 8)
+#define ADDR_OFS_BIT			8
+
 union perf_capabilities {
 	struct {
 		u64	lbr_format:6;
@@ -232,6 +235,102 @@ static void test_lbr_perf_capabilities(union perf_capabilities host_cap)
 	kvm_vm_free(vm);
 }
 
+/*
+ * Generate a non-canonical address for a given number of address bits.
+ * @addr_bits: The number of address bits used in the system.
+ *
+ * This function calculates a non-canonical address by setting the most
+ * significant bit to 1 and adding an offset equal to the maximum value
+ * that can be represented by the remaining bits. This ensures that the
+ * generated address is outside the valid address range and is consistent.
+ */
+static inline uint64_t non_canonical_address(unsigned int addr_bits)
+{
+	return (1ULL << (addr_bits - 1)) + ((1ULL << (addr_bits - 1)) - 1);
+}
+
+static uint64_t get_addr_bits(struct kvm_vcpu *vcpu)
+{
+	const struct kvm_cpuid_entry2 *kvm_entry;
+	unsigned int addr_bits;
+	struct kvm_sregs sregs;
+
+	kvm_entry = get_cpuid_entry(kvm_get_supported_cpuid(), 0x80000008, 0);
+	addr_bits = (kvm_entry->eax & MAX_LINEAR_ADDR_MASK) >> ADDR_OFS_BIT;
+	/*
+	 * Get the size of the virtual address space by checking the LA57 bit
+	 * in the CR4 control register. If the LA57 bit is set, then the virtual
+	 * address space is 57 bits. Otherwise, it's 48 bits.
+	 */
+	if (addr_bits != 32) {
+		vcpu_sregs_get(vcpu, &sregs);
+		addr_bits = (sregs.cr4 & X86_CR4_LA57) ? 57 : 48;
+	}
+
+	return addr_bits;
+}
+
+static void test_ds_guest_code(uint64_t bad_addr)
+{
+	uint8_t vector = 0;
+
+	vector = wrmsr_safe(MSR_IA32_DS_AREA, bad_addr);
+	GUEST_SYNC(vector);
+}
+
+/* Check if setting MSR_IA32_DS_AREA in guest and kvm userspace will fail. */
+static void test_ds_area_noncanonical_address(union perf_capabilities host_cap)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	unsigned int r, addr_bits;
+	uint64_t bad_addr, without_pebs_fmt_caps;
+	struct ucall uc;
+
+	vm = vm_create_with_one_vcpu(&vcpu, test_ds_guest_code);
+	vm_init_descriptor_tables(vm);
+	vcpu_init_descriptor_tables(vcpu);
+
+	/* Check that Setting MSR_IA32_DS_AREA with 0 should succeed. */
+	r = _vcpu_set_msr(vcpu, MSR_IA32_DS_AREA, 0);
+	TEST_ASSERT(r, "Setting MSR_IA32_DS_AREA with 0 should succeed.");
+
+	/*
+	 * Check that if PEBS_FMT is not set setting MSR_IA32_DS_AREA will
+	 * succeed.
+	 */
+	without_pebs_fmt_caps = host_cap.capabilities & ~PERF_CAP_PEBS_FORMAT;
+	vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, without_pebs_fmt_caps);
+	r = _vcpu_set_msr(vcpu, MSR_IA32_DS_AREA, 1);
+	TEST_ASSERT(r, "Setting MSR_IA32_DS_AREA with bad addr should fail.");
+
+	/*
+	 * Check that setting MSR_IA32_DS_AREA in kvm userspace to use a
+	 * non-canonical address should fail.
+	 */
+	vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, host_cap.capabilities);
+	addr_bits = get_addr_bits(vcpu);
+	bad_addr = non_canonical_address(addr_bits);
+	r = _vcpu_set_msr(vcpu, MSR_IA32_DS_AREA, bad_addr);
+	TEST_ASSERT(!r, "Setting MSR_IA32_DS_AREA with bad addr should fail.");
+
+	/*
+	 * Check that setting MSR_IA32_DS_AREA in guest to use a non-canonical
+	 * address should cause the #GP.
+	 */
+	vcpu_args_set(vcpu, 1, bad_addr);
+	vcpu_run(vcpu);
+
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+	get_ucall(vcpu, &uc);
+	TEST_ASSERT(uc.cmd == UCALL_SYNC,
+		    "Received ucall other than UCALL_SYNC: %lu", uc.cmd);
+	TEST_ASSERT(uc.args[1] == GP_VECTOR,
+		    "Setting MSR_IA32_DS_AREA with bad addr should fail.");
+
+	kvm_vm_free(vm);
+}
+
 int main(int argc, char *argv[])
 {
 	union perf_capabilities host_cap;
@@ -252,4 +351,5 @@ int main(int argc, char *argv[])
 	test_immutable_perf_capabilities(host_cap);
 	test_guest_wrmsr_perf_capabilities(host_cap);
 	test_lbr_perf_capabilities(host_cap);
+	test_ds_area_noncanonical_address(host_cap);
 }
-- 
2.31.1

