Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9BB76258C
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 00:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjGYWDk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 18:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjGYWDH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 18:03:07 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189EC359C
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:40 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-583c49018c6so47539587b3.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690322547; x=1690927347;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9K41uZJPRAaLfZAxcyXvJMZOSv31CqLM2GpGiII81Fk=;
        b=OpmW4JnvYy/bza5rQugibt2avnwuFDDH/0mTQeuMfHsvMTg2kNgRrvLedRztTwzM/U
         zUcpFp6CKHOFQ/TmJgAadxVlvmRRehmvPAeWraf/kwLBsFkwmneFYGV3JXDEmDdQlLrG
         tptkdQ5VQA31vflO2KL8xHrRy1gx5hEOZo0XuwU5rW2YfjDOQHZj6s4c5TGzpM8vTN2s
         5jUNoUXFL6M6M5L3QqI1PioyTi3wHxLcLwtwRZT+bs+4DuWUVi0abyT+P2ruALragPhW
         oKIKZODlOVQ4YbsufHF69WUAp1BYpOA6S49VqpDEZNKP1TmojovgcXxuiTCm7XZXcShJ
         ccug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690322547; x=1690927347;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9K41uZJPRAaLfZAxcyXvJMZOSv31CqLM2GpGiII81Fk=;
        b=dV5ZDV62OSTeu1TQzFRDIBmI0Ip2ehCzj9fNfudYldXNf88VO+Gm8YwQtiw59mYh9H
         yEZRjA21tcTUFZZC/eG+EU6GVXDJhEIPDngLK6tEnE06NN8AL0k2pKzoyhO7AgYk8I/u
         DgbYStCfhOzsOdVh0okI4MCJVm9ns02N5uMRcBqlOFqsw4gvxblqLF24B/hPk+ZztyWn
         8FoxpHzBiRjllzP5BFFAsgTaCZbL1TKQGm0GuYEvqqARn3EudWJf1VRs/WiQxB6ArMeZ
         k0dPCkVwLNKNaRZ1JCDySGxx7YBWfbJwvlncuGqDzuzEY0ayxa8tdr0TSLqi0wnNgz9W
         9xPw==
X-Gm-Message-State: ABy/qLarOyJt9VlRvg1MU25/wi/izP2C4PBNRRSSJlaMRsSpOnm8DG9Z
        TpT8tinfFdacEd3P/5drC+z029WyZldH5pq7IFOwggE0K1Hc0t4U1hv7cYyHhjM73P3humNS3xR
        K9H2BFIhHVVkJtTZ0AF8RWk6nnsYQeZO2BkTJRDs1sp0FgfAa9mfyWIG6DOO4t6+mZ6JbAXtw2S
        Z2
X-Google-Smtp-Source: APBJJlGVTJ4SPpeiFYtnkUVrNdX14OyOltzfLMR/yqKN/X/VvbxhuLCRXTt2ThJXdftiamLwbSZngrvqdMkm
X-Received: from afranji.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:47f1])
 (user=afranji job=sendgmr) by 2002:a05:6902:56a:b0:d0b:ca14:33fd with SMTP id
 a10-20020a056902056a00b00d0bca1433fdmr1962ybt.8.1690322546274; Tue, 25 Jul
 2023 15:02:26 -0700 (PDT)
Date:   Tue, 25 Jul 2023 22:01:13 +0000
In-Reply-To: <20230725220132.2310657-1-afranji@google.com>
Mime-Version: 1.0
References: <20230725220132.2310657-1-afranji@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725220132.2310657-21-afranji@google.com>
Subject: [PATCH v4 20/28] KVM: selftests: TDX: Verify the behavior when host
 consumes a TD private memory
From:   Ryan Afranji <afranji@google.com>
To:     linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, seanjc@google.com, isaku.yamahata@intel.com,
        sagis@google.com, erdemaktas@google.com, afranji@google.com,
        runanwang@google.com, shuah@kernel.org, drjones@redhat.com,
        maz@kernel.org, bgardon@google.com, jmattson@google.com,
        dmatlack@google.com, peterx@redhat.com, oupton@google.com,
        ricarkol@google.com, yang.zhong@intel.com, wei.w.wang@intel.com,
        xiaoyao.li@intel.com, pgonda@google.com, eesposit@redhat.com,
        borntraeger@de.ibm.com, eric.auger@redhat.com,
        wangyanan55@huawei.com, aaronlewis@google.com, vkuznets@redhat.com,
        pshier@google.com, axelrasmussen@google.com,
        zhenzhong.duan@intel.com, maciej.szmigiero@oracle.com,
        like.xu@linux.intel.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, ackerleytng@google.com
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

The test checks that host can only read fixed values when trying to
access the guest's private memory.

Signed-off-by: Ryan Afranji <afranji@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Change-Id: Ib30f58764c54122bf554639f0b8adf24b0438b5c
---
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
index a6da9fda1c6b..36cc735fad30 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -1062,6 +1062,90 @@ void verify_td_cpuid_tdcall(void)
 	printf("\t ... PASSED\n");
 }
 
+/*
+ * Shared variables between guest and host for host reading private mem test
+ */
+static uint64_t tdx_test_host_read_private_mem_addr;
+#define TDX_HOST_READ_PRIVATE_MEM_PORT_TEST 0x53
+
+void guest_host_read_priv_mem(void)
+{
+	uint64_t ret;
+	uint64_t placeholder = 0;
+
+	/* Set value */
+	*((uint32_t *) tdx_test_host_read_private_mem_addr) = 0xABCD;
+
+	/* Exit so host can read value */
+	ret = tdg_vp_vmcall_instruction_io(
+		TDX_HOST_READ_PRIVATE_MEM_PORT_TEST, 4,
+		TDG_VP_VMCALL_INSTRUCTION_IO_WRITE, &placeholder);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	/* Update guest_var's value and have host reread it. */
+	*((uint32_t *) tdx_test_host_read_private_mem_addr) = 0xFEDC;
+
+	tdx_test_success();
+}
+
+void verify_host_reading_private_mem(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+
+	vm_vaddr_t test_page;
+	uint64_t *host_virt;
+	uint64_t first_host_read;
+	uint64_t second_host_read;
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+	vcpu = td_vcpu_add(vm, 0, guest_host_read_priv_mem);
+
+	test_page = vm_vaddr_alloc_page(vm);
+	TEST_ASSERT(test_page < BIT_ULL(32),
+		"Test address should fit in 32 bits so it can be sent to the guest");
+
+	host_virt = addr_gva2hva(vm, test_page);
+	TEST_ASSERT(host_virt != NULL,
+		"Guest address not found in guest memory regions\n");
+
+	tdx_test_host_read_private_mem_addr = test_page;
+	sync_global_to_guest(vm, tdx_test_host_read_private_mem_addr);
+
+	td_finalize(vm);
+
+	printf("Verifying host's behavior when reading TD private memory:\n");
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_HOST_READ_PRIVATE_MEM_PORT_TEST,
+		4, TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
+	printf("\t ... Guest's variable contains 0xABCD\n");
+
+	/* Host reads guest's variable. */
+	first_host_read = *host_virt;
+	printf("\t ... Host's read attempt value: %lu\n", first_host_read);
+
+	/* Guest updates variable and host rereads it. */
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	printf("\t ... Guest's variable updated to 0xFEDC\n");
+
+	second_host_read = *host_virt;
+	printf("\t ... Host's second read attempt value: %lu\n",
+		second_host_read);
+
+	TEST_ASSERT(first_host_read == second_host_read,
+		"Host did not read a fixed pattern\n");
+
+	printf("\t ... Fixed pattern was returned to the host\n");
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
 int main(int argc, char **argv)
 {
 	setbuf(stdout, NULL);
@@ -1084,6 +1168,7 @@ int main(int argc, char **argv)
 	run_in_new_process(&verify_mmio_reads);
 	run_in_new_process(&verify_mmio_writes);
 	run_in_new_process(&verify_td_cpuid_tdcall);
+	run_in_new_process(&verify_host_reading_private_mem);
 
 	return 0;
 }
-- 
2.41.0.487.g6d72f3e995-goog

