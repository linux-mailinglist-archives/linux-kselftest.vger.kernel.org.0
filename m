Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB65D617F2C
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 15:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiKCOQF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 10:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbiKCOPb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 10:15:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AD0120B2
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Nov 2022 07:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667484865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yBY6+Wpx8c1HV9QootYh8PbPrW04DR2GqIrNFdSxlfY=;
        b=gbqICAoxvo2P4c9GwWyz2a2WGjm9Yk1SP1MxiIzmI3eYZvTMOCwPl6GnW/X3oj3yEdHrm8
        4CDMQCm6s0H2OmR9y/wvvPo1UCPwQOSPYAAeLaF7DqlA+6HhvmQlNHytT+Y4NAe0xTGOnR
        JM0oYbokq9+Co3PDlMlMjk6fKcJE2I8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-362-8o0VhxxEOfG_-aHeLN-64g-1; Thu, 03 Nov 2022 10:14:22 -0400
X-MC-Unique: 8o0VhxxEOfG_-aHeLN-64g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E38E101A54E;
        Thu,  3 Nov 2022 14:14:20 +0000 (UTC)
Received: from amdlaptop.tlv.redhat.com (dhcp-4-238.tlv.redhat.com [10.35.4.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0973640C6DC7;
        Thu,  3 Nov 2022 14:14:16 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Chenyi Qiang <chenyi.qiang@intel.com>,
        Yang Zhong <yang.zhong@intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Colton Lewis <coltonlewis@google.com>,
        Borislav Petkov <bp@alien8.de>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kselftest@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Wei Wang <wei.w.wang@intel.com>,
        David Matlack <dmatlack@google.com>
Subject: [PATCH v2 6/9] kvm: selftests: add svm nested shutdown test
Date:   Thu,  3 Nov 2022 16:13:48 +0200
Message-Id: <20221103141351.50662-7-mlevitsk@redhat.com>
In-Reply-To: <20221103141351.50662-1-mlevitsk@redhat.com>
References: <20221103141351.50662-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add test that tests that on SVM if L1 doesn't intercept SHUTDOWN,
then L2 crashes L1 and doesn't crash L2

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 tools/testing/selftests/kvm/.gitignore        |  1 +
 tools/testing/selftests/kvm/Makefile          |  1 +
 .../kvm/x86_64/svm_nested_shutdown_test.c     | 67 +++++++++++++++++++
 3 files changed, 69 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/svm_nested_shutdown_test.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 2f0d705db9dba5..05d980fb083d17 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -41,6 +41,7 @@
 /x86_64/svm_vmcall_test
 /x86_64/svm_int_ctl_test
 /x86_64/svm_nested_soft_inject_test
+/x86_64/svm_nested_shutdown_test
 /x86_64/sync_regs_test
 /x86_64/tsc_msrs_test
 /x86_64/tsc_scaling_sync
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 0172eb6cb6eee2..4a2caef2c9396f 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -101,6 +101,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/state_test
 TEST_GEN_PROGS_x86_64 += x86_64/vmx_preemption_timer_test
 TEST_GEN_PROGS_x86_64 += x86_64/svm_vmcall_test
 TEST_GEN_PROGS_x86_64 += x86_64/svm_int_ctl_test
+TEST_GEN_PROGS_x86_64 += x86_64/svm_nested_shutdown_test
 TEST_GEN_PROGS_x86_64 += x86_64/svm_nested_soft_inject_test
 TEST_GEN_PROGS_x86_64 += x86_64/tsc_scaling_sync
 TEST_GEN_PROGS_x86_64 += x86_64/sync_regs_test
diff --git a/tools/testing/selftests/kvm/x86_64/svm_nested_shutdown_test.c b/tools/testing/selftests/kvm/x86_64/svm_nested_shutdown_test.c
new file mode 100644
index 00000000000000..e73fcdef47bbe9
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/svm_nested_shutdown_test.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * svm_nested_shutdown_test
+ *
+ * Copyright (C) 2022, Red Hat, Inc.
+ *
+ * Nested SVM testing: test that unintercepted shutdown in L2 doesn't crash the host
+ */
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "svm_util.h"
+
+static void l2_guest_code(struct svm_test_data *svm)
+{
+	__asm__ __volatile__("ud2");
+}
+
+static void l1_guest_code(struct svm_test_data *svm, struct idt_entry *idt)
+{
+	#define L2_GUEST_STACK_SIZE 64
+	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
+	struct vmcb *vmcb = svm->vmcb;
+
+	generic_svm_setup(svm, l2_guest_code,
+			  &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+
+	vmcb->control.intercept &= ~(BIT(INTERCEPT_SHUTDOWN));
+
+	idt[6].p   = 0; // #UD is intercepted but its injection will cause #NP
+	idt[11].p  = 0; // #NP is not intercepted and will cause another
+			// #NP that will be converted to #DF
+	idt[8].p   = 0; // #DF will cause #NP which will cause SHUTDOWN
+
+	run_guest(vmcb, svm->vmcb_gpa);
+
+	/* should not reach here */
+	GUEST_ASSERT(0);
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_run *run;
+	vm_vaddr_t svm_gva;
+	struct kvm_vm *vm;
+
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
+
+	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
+	vm_init_descriptor_tables(vm);
+	vcpu_init_descriptor_tables(vcpu);
+
+	vcpu_alloc_svm(vm, &svm_gva);
+
+	vcpu_args_set(vcpu, 2, svm_gva, vm->idt);
+	run = vcpu->run;
+
+	vcpu_run(vcpu);
+	TEST_ASSERT(run->exit_reason == KVM_EXIT_SHUTDOWN,
+		    "Got exit_reason other than KVM_EXIT_SHUTDOWN: %u (%s)\n",
+		    run->exit_reason,
+		    exit_reason_str(run->exit_reason));
+
+	kvm_vm_free(vm);
+}
-- 
2.34.3

