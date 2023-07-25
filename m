Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013C976257C
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 00:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbjGYWD0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 18:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjGYWDE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 18:03:04 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B0130EE
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d052f49702dso5436650276.3
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690322538; x=1690927338;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NtcWyuvzCv676hKj496tQHwOP6H0h/MN00b1AT520wM=;
        b=Sh6NfQAqvxkG5Are5kDLONdnFcJrwZpKh6nlYP7ihUcp0MyboQJIaMix7EZelt/tH5
         YEaF/QFx1wf75q6z7BValjIDs/5hz4oVqItxo03qkxBtrJy3nlqOJI25e+gIp0EqJu81
         4T/0eyD+p7zf0TF6k/I+gZQBJ1TA1vTJojtP/5Rh+R+1rAtiRJPI1xeaoQyfMtkafzZ2
         RGjIVHWw49K5p5Jiek47RDAX2/SJTmFlfyIUbzY5JX/PRv+bwDwcBXgwAncJ9s5op5wB
         i7zlP3ffiwTtqHx/t3wy3XB+TthDG9uQ/3P5nACNJhbIkGpbDBint+Stx5MnxG9fgvpF
         doIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690322538; x=1690927338;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NtcWyuvzCv676hKj496tQHwOP6H0h/MN00b1AT520wM=;
        b=bN4fTXNDAsT5cTYmG6JQtXhwqQBgQsdVdEnCxmtA2jXCpBf1m1pVz44lDPIlvyCnHJ
         zDs4DtW/kPJ9Hzx4DrreIIxSRlHBh+x81xIcAneubLeXUMHm5+GQgJQD8eni0cPyA49i
         T3LRqVJc3kcWXCkBH1ocBTB0MnuOCAk17LsRMG9E+ANCa0Xd7Ct+NB+HebnmK7+gbsyg
         k2ULlEZ0M19KLx4Di+jPEUMt3ZzjztViOxs38JyOWX4JUiCHh5U1jJ9cvizn0+m79JcV
         q3VnBiQesxegmFwjTiX/qgU11Z6SkUVnZTNidbG+I75zFZE4OKne83wCYdCWZK4Onxmg
         cyzA==
X-Gm-Message-State: ABy/qLYfzDx8IKUI8Mj0ZWNR5Y1gzj3gktdbcZOo/Vf5WaGjbGhlNnf+
        N8DMeHAb7SAk/ZbYJAxfTmB4DCN2pFM3BCzZrXqWp+jUYR9o3OvG/fblM1Q/H4Vi5wG9rLLg4XH
        CfC2E68pKDVyljE/zf4a50SQCI/jp/oms2Hxf7UtF9PDLvJRgrmBioTmiO8gMN0lI1socFLgxau
        D1
X-Google-Smtp-Source: APBJJlHMfS7V934fUvtR/ekKgyAOGNoMxqDk/+cDlfYlVunKRHf8h+HVH78rLLonfe92zuYlsHXVSY0JIxhZ
X-Received: from afranji.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:47f1])
 (user=afranji job=sendgmr) by 2002:a25:69c8:0:b0:d0c:e37:b749 with SMTP id
 e191-20020a2569c8000000b00d0c0e37b749mr1261ybc.10.1690322538496; Tue, 25 Jul
 2023 15:02:18 -0700 (PDT)
Date:   Tue, 25 Jul 2023 22:01:09 +0000
In-Reply-To: <20230725220132.2310657-1-afranji@google.com>
Mime-Version: 1.0
References: <20230725220132.2310657-1-afranji@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725220132.2310657-17-afranji@google.com>
Subject: [PATCH v4 16/28] KVM: selftests: TDX: Add TDX HLT exit test
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

From: Sagi Shahar <sagis@google.com>

The test verifies that the guest runs TDVMCALL<INSTRUCTION.HLT> and the
guest vCPU enters to the halted state.

Signed-off-by: Erdem Aktas <erdemaktas@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Change-Id: I253a2432bb29265bc3b3360f9254395761c5aadd
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 .../selftests/kvm/include/x86_64/tdx/tdx.h    |  2 +
 .../selftests/kvm/lib/x86_64/tdx/tdx.c        | 10 +++
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 78 +++++++++++++++++++
 3 files changed, 90 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
index 85ba6aab79a7..b18e39d20498 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
@@ -8,6 +8,7 @@
 #define TDG_VP_VMCALL_GET_TD_VM_CALL_INFO 0x10000
 #define TDG_VP_VMCALL_REPORT_FATAL_ERROR 0x10003
 
+#define TDG_VP_VMCALL_INSTRUCTION_HLT 12
 #define TDG_VP_VMCALL_INSTRUCTION_IO 30
 #define TDG_VP_VMCALL_INSTRUCTION_RDMSR 31
 #define TDG_VP_VMCALL_INSTRUCTION_WRMSR 32
@@ -20,5 +21,6 @@ uint64_t tdg_vp_vmcall_get_td_vmcall_info(uint64_t *r11, uint64_t *r12,
 					uint64_t *r13, uint64_t *r14);
 uint64_t tdg_vp_vmcall_instruction_rdmsr(uint64_t index, uint64_t *ret_value);
 uint64_t tdg_vp_vmcall_instruction_wrmsr(uint64_t index, uint64_t value);
+uint64_t tdg_vp_vmcall_instruction_hlt(uint64_t interrupt_blocked_flag);
 
 #endif // SELFTEST_TDX_TDX_H
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
index 88ea6f2a6469..9485bafedc38 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
@@ -114,3 +114,13 @@ uint64_t tdg_vp_vmcall_instruction_wrmsr(uint64_t index, uint64_t value)
 
 	return __tdx_hypercall(&args, 0);
 }
+
+uint64_t tdg_vp_vmcall_instruction_hlt(uint64_t interrupt_blocked_flag)
+{
+	struct tdx_hypercall_args args = {
+		.r11 = TDG_VP_VMCALL_INSTRUCTION_HLT,
+		.r12 = interrupt_blocked_flag,
+	};
+
+	return __tdx_hypercall(&args, 0);
+}
diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
index 41dad6cf249b..f77caf262f84 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -721,6 +721,83 @@ void verify_guest_msr_writes(void)
 	printf("\t ... PASSED\n");
 }
 
+/*
+ * Verifies HLT functionality.
+ */
+void guest_hlt(void)
+{
+	uint64_t ret;
+	uint64_t interrupt_blocked_flag;
+
+	interrupt_blocked_flag = 0;
+	ret = tdg_vp_vmcall_instruction_hlt(interrupt_blocked_flag);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	tdx_test_success();
+}
+
+void _verify_guest_hlt(int signum);
+
+void wake_me(int interval)
+{
+	struct sigaction action;
+
+	action.sa_handler = _verify_guest_hlt;
+	sigemptyset(&action.sa_mask);
+	action.sa_flags = 0;
+
+	TEST_ASSERT(sigaction(SIGALRM, &action, NULL) == 0,
+		    "Could not set the alarm handler!");
+
+	alarm(interval);
+}
+
+void _verify_guest_hlt(int signum)
+{
+	struct kvm_vm *vm;
+	static struct kvm_vcpu *vcpu;
+
+	/*
+	 * This function will also be called by SIGALRM handler to check the
+	 * vCPU MP State. If vm has been initialized, then we are in the signal
+	 * handler. Check the MP state and let the guest run again.
+	 */
+	if (vcpu != NULL) {
+		struct kvm_mp_state mp_state;
+
+		vcpu_mp_state_get(vcpu, &mp_state);
+		ASSERT_EQ(mp_state.mp_state, KVM_MP_STATE_HALTED);
+
+		/* Let the guest to run and finish the test.*/
+		mp_state.mp_state = KVM_MP_STATE_RUNNABLE;
+		vcpu_mp_state_set(vcpu, &mp_state);
+		return;
+	}
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+	vcpu = td_vcpu_add(vm, 0, guest_hlt);
+	td_finalize(vm);
+
+	printf("Verifying HLT:\n");
+
+	printf("\t ... Running guest\n");
+
+	/* Wait 1 second for guest to execute HLT */
+	wake_me(1);
+	td_vcpu_run(vcpu);
+
+	TDX_TEST_ASSERT_SUCCESS(vcpu);
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
+void verify_guest_hlt(void)
+{
+	_verify_guest_hlt(0);
+}
 
 int main(int argc, char **argv)
 {
@@ -740,6 +817,7 @@ int main(int argc, char **argv)
 	run_in_new_process(&verify_guest_reads);
 	run_in_new_process(&verify_guest_msr_writes);
 	run_in_new_process(&verify_guest_msr_reads);
+	run_in_new_process(&verify_guest_hlt);
 
 	return 0;
 }
-- 
2.41.0.487.g6d72f3e995-goog

