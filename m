Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FC65A70A9
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 00:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbiH3WVq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 18:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiH3WVO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 18:21:14 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002A67172F
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:20:28 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id k16-20020a635a50000000b0042986056df6so6063322pgm.2
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=XGisEg3sosGxno0TvjO4HvwWJUc+batMd9qgnL8cNT4=;
        b=NgGqwZ0Dhnd8/j3B3dmrOklRqoBSjTYgA7gn7uLdXSt7kjVtMudI2I2ruWAaUEzK5v
         zCx59Yw9f0nxh4YXMD0mqG7F6iscqIrcKkv8NAHP7Kbwy137aLKwp9QDEgTpgQBpyL4i
         siB79DFI3sqHIu3oY7Bj2EcGo1cZ9ZHPoupvdnF7n+vZug3yoTAV53b4UlO+hFpCWXoR
         uDMJxLSJg8XTjV/ggBxC2baL8GCIkJkQDssYuLNSQCwrcpW9L4bTtoYbEAlYxj8b6DS3
         Mm8Tavwzglvn4ef64onkfu1qvM0gvv5DP7SMTP1CrwufJeuJQSlO7caypcXhWeBu/NXT
         kSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=XGisEg3sosGxno0TvjO4HvwWJUc+batMd9qgnL8cNT4=;
        b=knJ6GYQ39UkMJol5z+PMBVtmoZ5216DgNFVSzh+TfCuZtZCSJ9GLxCzyGIjfWPHhEr
         fID+VUJO8Fk9+f9gEpoU+D7nk3yVaXM7BJXWSvAEFoNktok64p+VxHO8wXIjijvW6VFF
         sRgIh0+wWgTmAcBlTSyatQjUDfyxpFiA8YT0RrMxvr98SM1r+0zunAADWQuDhTN4FlMp
         6w5L/GOyD6y8hhQbSlzB1ZkzYASZTWgEmn626dsM/6TFxze6DkorVoxkGJGCcqOJaihs
         C4lsx5HXTAzB9qqobCBXOWwc2baoGKyXVM7siF3wOLg4oLf5DsVVSbK/RZ6HxTpGU9w0
         fRjg==
X-Gm-Message-State: ACgBeo1Ewxwyu8YVySMsUDOu3NuWJOFM+ZjedfOmiSfn7zSqjG9Hiku/
        OUq3+Hd7qVaffFWHVIWXNSSc8baw509DaEtn79pVzLQJKf3zTh/0nh/567KwdejKSbEvVZ3JaXe
        Q7vuwkkld+HTUbop81Kftm9u8HoO3ONKiwBzvrfJqLfbDMBaCSkQOsjNUoROkU6P0Jg+gNGU=
X-Google-Smtp-Source: AA6agR58PpzfkJaOKL5P3VkvrvMgUaV+8am7rwtsdMFdVRE98wNWCH+lEhFt7dOUm8PMABuN3S3LxXL6AQ==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a05:6a00:16c4:b0:535:890:d52 with SMTP id
 l4-20020a056a0016c400b0053508900d52mr23444002pfc.9.1661898028220; Tue, 30 Aug
 2022 15:20:28 -0700 (PDT)
Date:   Tue, 30 Aug 2022 22:19:56 +0000
In-Reply-To: <20220830222000.709028-1-sagis@google.com>
Mime-Version: 1.0
References: <20220830222000.709028-1-sagis@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220830222000.709028-14-sagis@google.com>
Subject: [RFC PATCH v2 13/17] KVM: selftest: TDX: Add TDX MMIO writes test
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

The test verifies MMIO writes of various sizes from the guest to the host.

Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/lib/x86_64/tdx.h  | 18 ++++
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 92 +++++++++++++++++++
 2 files changed, 110 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx.h b/tools/testing/selftests/kvm/lib/x86_64/tdx.h
index 7045d617dd78..17e3649e5729 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx.h
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx.h
@@ -329,6 +329,24 @@ static inline uint64_t tdvmcall_mmio_read(uint64_t address, uint64_t size, uint6
 	return regs.r10;
 }
 
+/*
+ * Execute MMIO request instruction for write.
+ */
+static inline uint64_t tdvmcall_mmio_write(uint64_t address, uint64_t size, uint64_t data_in)
+{
+	struct kvm_regs regs;
+
+	memset(&regs, 0, sizeof(regs));
+	regs.r11 = TDX_INSTRUCTION_VE_REQUEST_MMIO;
+	regs.r12 = size;
+	regs.r13 = TDX_MMIO_WRITE;
+	regs.r14 = address;
+	regs.r15 = data_in;
+	regs.rcx = 0xFC00;
+	tdcall(&regs);
+	return regs.r10;
+}
+
 /*
  * Reports a 32 bit value from the guest to user space using a TDVM IO call.
  * Data is reported on port TDX_DATA_REPORT_PORT.
diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
index 963e4feae31a..382119bd444b 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -1082,6 +1082,97 @@ void verify_mmio_reads(void)
 	printf("\t ... PASSED\n");
 }
 
+TDX_GUEST_FUNCTION(guest_mmio_writes)
+{
+	uint64_t ret;
+
+	ret = tdvmcall_mmio_write(MMIO_VALID_ADDRESS, 1, 0x12);
+	if (ret)
+		tdvmcall_fatal(ret);
+
+	ret = tdvmcall_mmio_write(MMIO_VALID_ADDRESS, 2, 0x1234);
+	if (ret)
+		tdvmcall_fatal(ret);
+
+	ret = tdvmcall_mmio_write(MMIO_VALID_ADDRESS, 4, 0x12345678);
+	if (ret)
+		tdvmcall_fatal(ret);
+
+	ret = tdvmcall_mmio_write(MMIO_VALID_ADDRESS, 8, 0x1234567890ABCDEF);
+	if (ret)
+		tdvmcall_fatal(ret);
+
+	// Write across page boundary.
+	ret = tdvmcall_mmio_write(PAGE_SIZE - 1, 8, 0);
+	if (ret)
+		tdvmcall_fatal(ret);
+
+	tdvmcall_success();
+}
+
+/*
+ * Varifies guest MMIO writes.
+ */
+void verify_mmio_writes(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	uint8_t byte_1;
+	uint16_t byte_2;
+	uint32_t byte_4;
+	uint64_t byte_8;
+
+	printf("Verifying TD MMIO writes:\n");
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
+	prepare_source_image(vm, guest_mmio_writes,
+			     TDX_FUNCTION_SIZE(guest_mmio_writes), 0);
+	finalize_td_memory(vm);
+
+	vcpu_run(vcpu);
+	CHECK_GUEST_FAILURE(vcpu);
+	CHECK_MMIO(vcpu, MMIO_VALID_ADDRESS, 1, TDX_MMIO_WRITE);
+	byte_1 = *(uint8_t *)(vcpu->run->mmio.data);
+
+	vcpu_run(vcpu);
+	CHECK_GUEST_FAILURE(vcpu);
+	CHECK_MMIO(vcpu, MMIO_VALID_ADDRESS, 2, TDX_MMIO_WRITE);
+	byte_2 = *(uint16_t *)(vcpu->run->mmio.data);
+
+	vcpu_run(vcpu);
+	CHECK_GUEST_FAILURE(vcpu);
+	CHECK_MMIO(vcpu, MMIO_VALID_ADDRESS, 4, TDX_MMIO_WRITE);
+	byte_4 = *(uint32_t *)(vcpu->run->mmio.data);
+
+	vcpu_run(vcpu);
+	CHECK_GUEST_FAILURE(vcpu);
+	CHECK_MMIO(vcpu, MMIO_VALID_ADDRESS, 8, TDX_MMIO_WRITE);
+	byte_8 = *(uint64_t *)(vcpu->run->mmio.data);
+
+	ASSERT_EQ(byte_1, 0x12);
+	ASSERT_EQ(byte_2, 0x1234);
+	ASSERT_EQ(byte_4, 0x12345678);
+	ASSERT_EQ(byte_8, 0x1234567890ABCDEF);
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
@@ -1100,6 +1191,7 @@ int main(int argc, char **argv)
 	run_in_new_process(&verify_guest_msr_writes);
 	run_in_new_process(&verify_guest_hlt);
 	run_in_new_process(&verify_mmio_reads);
+	run_in_new_process(&verify_mmio_writes);
 
 	return 0;
 }
-- 
2.37.2.789.g6183377224-goog

