Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9DF676233
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jan 2023 01:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjAUATH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Jan 2023 19:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjAUASw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Jan 2023 19:18:52 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EAC40DA
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:18:23 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a14-20020a5b0ace000000b007bf99065fcbso7439871ybr.2
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aU8EEj4+t8QDE1+v+1nJSnMuiEYEWTVzh5HjN1v63xM=;
        b=CZyMH/wtFabSHYajD2rl/1mxAK8ImYuJhOe0qrxfZn1jd7qkK4ctPvfNnbYe4HpBgq
         +OR/+07KpRsHSpG+fM9YZr+zU8l76nuHBDYazfdCTQEfar0tsn3xWDHDds/NzG1ApMv8
         VrQJ4D6HkoKG0bhi65WUS1xwmhqBbfCDLqWCQ3nM4QYElN20xvR+TIfA1tq3arTQEp0y
         pT27fs8Jn0SRvuAzmqtwTr2dQUbZXfNwctiUkumuD6AG94N6hbKrp+BqFJ35N67zn5L9
         GEyF+ZK/QLVRN2IKVFSF2UC0fFvR+EhiH0lhTmf9VTk0LSkgWcCnE1144RjRk/eFJ15v
         RNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aU8EEj4+t8QDE1+v+1nJSnMuiEYEWTVzh5HjN1v63xM=;
        b=W0Pi54NFxr738OjIegKQEq0tnXXGEz/S1SOTJid7gITGKIiFli0huzpWXtK8TyH2We
         McvpZ3+DHv8bhrdJoVdMPFm0qVBYLrf0HffH9t5xRtDt1LInWmCDWT/CjUITsIgFYmME
         vlc/DzbqiSbS8ClEIegWdelFzkCHJGmlSTmz2KUSMHio8W4I4lePQ1SoqKEnrvGibEHl
         C56ngzWQ27f0C1NmNQUYnyrDxNrv9MVzWLyF0Cjj9LBJ6kyFkCtVUxN7Q0WhDAl079pp
         Cx3s3Bk4dyPyn/O1RTYlvwDsAlnq0E5sDEoW8ZaE9rOIIxyssoAaPetyIklxMFK0H8nh
         nQPw==
X-Gm-Message-State: AFqh2kqX8BwPA98DVTU8c6LPN/ZrpDE5JeAmR+YvtWfDbQ/Dq+UaVsJ7
        fLe9smO7MCcn8XlPSpDYU1DudMyeCXGimC4Iry6rayX6N3Vz9ps6Myu96zDVG6Fhn0KxKySN7Ey
        hFtS9ysXqtFZ20U0QxMEJHVsXMmczGPuLK4khOsGMoZwfzwNThvR+22ECN5F4dEMMgad8pQahoa
        6ydHaYrbCLvxU=
X-Google-Smtp-Source: AMrXdXtk2MSUQiuREtPrJbrkhCVDp53FqaOrQSLGcdLMLfPTeNPOYbS2c9PIzGKPwqn+QnqV+sL1ueCWG+nHRZkyrg==
X-Received: from ackerleytng-cloudtop-sg.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:b30])
 (user=ackerleytng job=sendgmr) by 2002:a25:2c9:0:b0:803:bfff:635f with SMTP
 id 192-20020a2502c9000000b00803bfff635fmr246350ybc.90.1674260264239; Fri, 20
 Jan 2023 16:17:44 -0800 (PST)
Date:   Sat, 21 Jan 2023 00:15:32 +0000
In-Reply-To: <20230121001542.2472357-1-ackerleytng@google.com>
Mime-Version: 1.0
References: <20230121001542.2472357-1-ackerleytng@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230121001542.2472357-22-ackerleytng@google.com>
Subject: [RFC PATCH v3 21/31] KVM: selftests: TDX: Verify the behavior when
 host consumes a TD private memory
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

From: Ryan Afranji <afranji@google.com>

The test checks that host can only read fixed values when trying to
access the guest's private memory.

Signed-off-by: Ryan Afranji <afranji@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
index b9d96b5f6521f..4c338206dbaf2 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -1069,6 +1069,90 @@ void verify_td_cpuid_tdcall(void)
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
+	vcpu_run(vcpu);
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
+	vcpu_run(vcpu);
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
@@ -1091,6 +1175,7 @@ int main(int argc, char **argv)
 	run_in_new_process(&verify_mmio_reads);
 	run_in_new_process(&verify_mmio_writes);
 	run_in_new_process(&verify_td_cpuid_tdcall);
+	run_in_new_process(&verify_host_reading_private_mem);
 
 	return 0;
 }
-- 
2.39.0.246.g2a6d74b583-goog

