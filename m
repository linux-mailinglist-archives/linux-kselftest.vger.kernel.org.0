Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2475A70A1
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 00:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbiH3WVa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 18:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbiH3WVK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 18:21:10 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD8B5E556
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:20:27 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id oo12-20020a17090b1c8c00b001faa0b549caso11850655pjb.0
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=3Hb55PPYqJ9GhLXNrzEjW9U1TfsgkxT16tA5j1wTvr0=;
        b=lOtIGU26iz1lGzz8PGxwebfYTciclQR/ZgZqMjT1sDm6xcmOSU7kFFnxdKTt4q5Ssc
         Jl92P1U0pIKvRArwiPIAhoifOejXR1RAKNMMgUIrEsd0mt601ry3OkyJ69SbdGSjCoK9
         gB5WDN+KstIssgYegKHaGoEkGdGJaJ6kd/x/wLSSWZRamedKb3Zs71O96pmeT1lKxxj2
         BYFZbVoLweZlWz32QxV5gtF4JpzPcpNt2Ub/bZ8qWrmQU27ra+MaAAmiaWTcvefsUOc8
         27XAGYSi2VBY0E990Jv7NmNmhYC1xqe6hjceMiWojJ9F3KhctMFnapBA6pRKP4kyp76X
         joTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=3Hb55PPYqJ9GhLXNrzEjW9U1TfsgkxT16tA5j1wTvr0=;
        b=gwUHb72Ah+mpq8prtiP0p/+Z1cPc//pgKYuscQRw0Bo+Zz/0C5vv8uXc+qTkwbcusv
         lOXlyBELVIkpy5WXpLhoFYxdC33wkqjqFhyUfYAGYyQ3GLi9qJ64e0se+dvLfmEfI8dH
         mBrc4zOIoV5wwiGGgtUXcTFQb1rewzVa2uPbQrc2mwtDv1I+Ml5dEuR7tOICeNtsWGnY
         yslpn1/QQJzVa/mhXrA3CO30vWiUuI6NptIdcrIbCf4D+pH9zreB2B2NphEZWTMyyiM6
         1m/LzAkRZRQ74gVbJ0j+gXIWaU5mLfzgm75CZXKXWg6urUnKldpQradUnS9b2OHZK14t
         HraQ==
X-Gm-Message-State: ACgBeo2V1aSr+w3Izc+ZZ3dA1beib1RaNpd2Wkj/i9XASnsp0F9CvyhM
        phj9mhHtM6tNLbbAhUWaQnRhU0lt0JnT6WbiG4GcCFNTnPTtcjBsAURh3N2IRYidAC6PT1kHklM
        eIZ8VGvPYzExCTvK0lBIRw+sGdjXUE+klzbw1DcJM5P0gWgB/x2/URtoqA5Pt9si4hpLgfjg=
X-Google-Smtp-Source: AA6agR5r9ukQ4wlLG+/DfKVl60d5YWDQENm8K4M7KnBQl9loaE6nhV9tNxkZsIffR8utMom8bm2g3UZNjg==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a05:6a00:174b:b0:52f:c4d1:d130 with SMTP id
 j11-20020a056a00174b00b0052fc4d1d130mr22924078pfc.23.1661898026592; Tue, 30
 Aug 2022 15:20:26 -0700 (PDT)
Date:   Tue, 30 Aug 2022 22:19:55 +0000
In-Reply-To: <20220830222000.709028-1-sagis@google.com>
Mime-Version: 1.0
References: <20220830222000.709028-1-sagis@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220830222000.709028-13-sagis@google.com>
Subject: [RFC PATCH v2 12/17] KVM: selftest: TDX: Add TDX MMIO reads test
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The test verifies MMIO reads of various sizes from the host to the guest.

Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/lib/x86_64/tdx.h  |  21 ++++
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 113 ++++++++++++++++++
 2 files changed, 134 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx.h b/tools/testing/selftests/kvm/lib/x86_64/tdx.h
index b11200028546..7045d617dd78 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx.h
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx.h
@@ -60,12 +60,15 @@
 #define TDX_INSTRUCTION_IO 30
 #define TDX_INSTRUCTION_RDMSR 31
 #define TDX_INSTRUCTION_WRMSR 32
+#define TDX_INSTRUCTION_VE_REQUEST_MMIO 48
 
 #define TDX_SUCCESS_PORT 0x30
 #define TDX_TEST_PORT 0x31
 #define TDX_DATA_REPORT_PORT 0x32
 #define TDX_IO_READ 0
 #define TDX_IO_WRITE 1
+#define TDX_MMIO_READ 0
+#define TDX_MMIO_WRITE 1
 
 #define GDT_ENTRY(flags, base, limit)				\
 		((((base)  & 0xff000000ULL) << (56-24)) |	\
@@ -308,6 +311,24 @@ static inline uint64_t tdvmcall_hlt(uint64_t interrupt_blocked_flag)
 	return regs.r10;
 }
 
+/*
+ * Execute MMIO request instruction for read.
+ */
+static inline uint64_t tdvmcall_mmio_read(uint64_t address, uint64_t size, uint64_t *data_out)
+{
+	struct kvm_regs regs;
+
+	memset(&regs, 0, sizeof(regs));
+	regs.r11 = TDX_INSTRUCTION_VE_REQUEST_MMIO;
+	regs.r12 = size;
+	regs.r13 = TDX_MMIO_READ;
+	regs.r14 = address;
+	regs.rcx = 0x7C00;
+	tdcall(&regs);
+	*data_out = regs.r11;
+	return regs.r10;
+}
+
 /*
  * Reports a 32 bit value from the guest to user space using a TDVM IO call.
  * Data is reported on port TDX_DATA_REPORT_PORT.
diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
index 39604aac54bd..963e4feae31a 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include "asm/kvm.h"
+#include "linux/kernel.h"
 #include <bits/stdint-uintn.h>
 #include <fcntl.h>
 #include <limits.h>
@@ -47,6 +48,24 @@
 			    (VCPU)->run->io.direction);					\
 	} while (0)
 
+#define CHECK_MMIO(VCPU, ADDR, SIZE, DIR)						\
+	do {										\
+		TEST_ASSERT((VCPU)->run->exit_reason == KVM_EXIT_MMIO,			\
+			    "Got exit_reason other than KVM_EXIT_MMIO: %u (%s)\n",	\
+			    (VCPU)->run->exit_reason,					\
+			    exit_reason_str((VCPU)->run->exit_reason));			\
+											\
+		TEST_ASSERT(((VCPU)->run->exit_reason == KVM_EXIT_MMIO) &&		\
+			    ((VCPU)->run->mmio.phys_addr == (ADDR)) &&			\
+			    ((VCPU)->run->mmio.len == (SIZE)) &&			\
+			    ((VCPU)->run->mmio.is_write == (DIR)),			\
+			    "Got an unexpected MMIO exit values: %u (%s) %llu %d %d\n",	\
+			    (VCPU)->run->exit_reason,					\
+			    exit_reason_str((VCPU)->run->exit_reason),			\
+			    (VCPU)->run->mmio.phys_addr, (VCPU)->run->mmio.len,		\
+			    (VCPU)->run->mmio.is_write);				\
+	} while (0)
+
 #define CHECK_GUEST_FAILURE(VCPU)							\
 	do {										\
 		if ((VCPU)->run->exit_reason == KVM_EXIT_SYSTEM_EVENT)			\
@@ -89,6 +108,8 @@ struct kvm_msr_filter test_filter = {
 	},
 };
 
+#define MMIO_VALID_ADDRESS (TDX_GUEST_MAX_NR_PAGES * PAGE_SIZE + 1)
+
 static uint64_t read_64bit_from_guest(struct kvm_vcpu *vcpu, uint64_t port)
 {
 	uint32_t lo, hi;
@@ -970,6 +991,97 @@ void verify_guest_hlt(void)
 	_verify_guest_hlt(0);
 }
 
+TDX_GUEST_FUNCTION(guest_mmio_reads)
+{
+	uint64_t data;
+	uint64_t ret;
+
+	ret = tdvmcall_mmio_read(MMIO_VALID_ADDRESS, 1, &data);
+	if (ret)
+		tdvmcall_fatal(ret);
+	if (data != 0x12)
+		tdvmcall_fatal(1);
+
+	ret = tdvmcall_mmio_read(MMIO_VALID_ADDRESS, 2, &data);
+	if (ret)
+		tdvmcall_fatal(ret);
+	if (data != 0x1234)
+		tdvmcall_fatal(2);
+
+	ret = tdvmcall_mmio_read(MMIO_VALID_ADDRESS, 4, &data);
+	if (ret)
+		tdvmcall_fatal(ret);
+	if (data != 0x12345678)
+		tdvmcall_fatal(4);
+
+	ret = tdvmcall_mmio_read(MMIO_VALID_ADDRESS, 8, &data);
+	if (ret)
+		tdvmcall_fatal(ret);
+	if (data != 0x1234567890ABCDEF)
+		tdvmcall_fatal(8);
+
+	// Read an invalid number of bytes.
+	ret = tdvmcall_mmio_read(MMIO_VALID_ADDRESS, 10, &data);
+	if (ret)
+		tdvmcall_fatal(ret);
+
+	tdvmcall_success();
+}
+
+/*
+ * Varifies guest MMIO reads.
+ */
+void verify_mmio_reads(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	printf("Verifying TD MMIO reads:\n");
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
+	prepare_source_image(vm, guest_mmio_reads,
+			     TDX_FUNCTION_SIZE(guest_mmio_reads), 0);
+	finalize_td_memory(vm);
+
+	vcpu_run(vcpu);
+	CHECK_GUEST_FAILURE(vcpu);
+	CHECK_MMIO(vcpu, MMIO_VALID_ADDRESS, 1, TDX_MMIO_READ);
+	*(uint8_t *)vcpu->run->mmio.data = 0x12;
+
+	vcpu_run(vcpu);
+	CHECK_GUEST_FAILURE(vcpu);
+	CHECK_MMIO(vcpu, MMIO_VALID_ADDRESS, 2, TDX_MMIO_READ);
+	*(uint16_t *)vcpu->run->mmio.data = 0x1234;
+
+	vcpu_run(vcpu);
+	CHECK_GUEST_FAILURE(vcpu);
+	CHECK_MMIO(vcpu, MMIO_VALID_ADDRESS, 4, TDX_MMIO_READ);
+	*(uint32_t *)vcpu->run->mmio.data = 0x12345678;
+
+	vcpu_run(vcpu);
+	CHECK_GUEST_FAILURE(vcpu);
+	CHECK_MMIO(vcpu, MMIO_VALID_ADDRESS, 8, TDX_MMIO_READ);
+	*(uint64_t *)vcpu->run->mmio.data = 0x1234567890ABCDEF;
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
@@ -987,6 +1099,7 @@ int main(int argc, char **argv)
 	run_in_new_process(&verify_guest_msr_reads);
 	run_in_new_process(&verify_guest_msr_writes);
 	run_in_new_process(&verify_guest_hlt);
+	run_in_new_process(&verify_mmio_reads);
 
 	return 0;
 }
-- 
2.37.2.789.g6183377224-goog

