Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AAC5A7088
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 00:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiH3WUS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 18:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbiH3WUP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 18:20:15 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9E82CC8F
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:20:13 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id a21-20020a62bd15000000b005360da6b25aso5174356pff.23
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=4HErFRuZWnvNea+crcpmX3JHa78L1TL3m4q9Khg/Jh4=;
        b=cDKvhJ6cjRi3/088MY6el/echJAjDXJyz87g+GLLGuxePVe7haWbP1mmqlJRdw8xAB
         ulPMlNP0Q84T5Whq/9d+LuwLsemViGiwbEZFwfvEv7jcTxYt6r549vumV8rRze0ajjo6
         d66T4t3NqHaks1m7FwWmV+1aiUaKk+ZYCXeqXCBkDUzjO/DzHndVZKBaFBuDVEIbyKAT
         +pqk6gIdjXXXURpds3lOB/jPE9lqkusocO7BoFTelzCFxjeBoxSJSivWVYBTXlW3Xyqf
         eLc4OIWy3ajLwJAp+lyZdNq2em2r6Trqbg3vHRH1SsE4qlQRPmf522lj1lt+dPy3LkTG
         NL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=4HErFRuZWnvNea+crcpmX3JHa78L1TL3m4q9Khg/Jh4=;
        b=58l3pyx/XGciJYBvpd3kPT+9CQDHRXP5i9+2CsWtfk+lVoxjhLFp8lIw60Q6anaDeT
         FYpdUZeOW482N2QP2HQ1W9iFi5cJUTi/3VF6kCia9jFB//vC5mY4OlOYCBGg3vJwecVH
         3jLt8JDzMEqVNjBYBr6Th84c3XVMn068Hr7i9k0kFHXdOFtFe5XlioRKjbgCCeXxE4kX
         MwL8KManau8Y6G5A+oa+jPSSDBKzHYPpzU1W+e+73WBUZ1JFKt/X6IznMHNPzlPRT5s7
         E5JW6FCgsWqUaKJP2x3jiANG0HaVmG8A3YayCq9uV6KHowNQjPcvGMuHRj88nEwUG3Ww
         OMHw==
X-Gm-Message-State: ACgBeo2UhSJhUlHMY1d1zPDhLKmrItbOK1d40mY3HItjnBFPhvQkxA3g
        nSzWcbhfd1pFbsfAYGbzbCDagUkYaIIxvQMTqTfyZFZNlngLg0VGZoun7OlKlTnWXjCqjbiUTrF
        t6AdGA+dxIqTXiTHanSfaGjZKTF6VFMB5ePFL7lKzUAm1V+coil8ky/lTwL+pqA5vUlsDXak=
X-Google-Smtp-Source: AA6agR5PbnmN6dYRh+nCwvlvex+8uK7KW+7p/GMZAdg4ZLuyXW4YoUw+I5NpPIWIM/6fxg2v1OZsZWYjvA==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a05:6a00:b8b:b0:536:71f7:4ce3 with SMTP id
 g11-20020a056a000b8b00b0053671f74ce3mr23113027pfj.74.1661898012331; Tue, 30
 Aug 2022 15:20:12 -0700 (PDT)
Date:   Tue, 30 Aug 2022 22:19:47 +0000
In-Reply-To: <20220830222000.709028-1-sagis@google.com>
Mime-Version: 1.0
References: <20220830222000.709028-1-sagis@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220830222000.709028-5-sagis@google.com>
Subject: [RFC PATCH v2 04/17] KVM: selftest: TDX: Add report_fatal_error test
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

The test checks report_fatal_error functionality.

Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/lib/x86_64/tdx.h  | 17 ++++++
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 55 +++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx.h b/tools/testing/selftests/kvm/lib/x86_64/tdx.h
index d5de52657112..351ece3e80e2 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx.h
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx.h
@@ -51,6 +51,7 @@
 #define _PAGE_RW            (1UL<<1)       /* writeable */
 #define _PAGE_PS            (1UL<<7)       /* page size bit*/
 
+#define TDX_REPORT_FATAL_ERROR 0x10003
 #define TDX_INSTRUCTION_IO 30
 
 #define TDX_SUCCESS_PORT 0x30
@@ -212,6 +213,22 @@ static inline void tdvmcall_success(void)
 	tdvmcall_io(TDX_SUCCESS_PORT, /*size=*/4, TDX_IO_WRITE, &code);
 }
 
+/*
+ * Report an error to user space.
+ * data_gpa may point to an optional shared guest memory holding the error string.
+ * Return value from tdvmcall is ignored since execution is not expected to
+ * continue beyond this point.
+ */
+static inline void tdvmcall_fatal(uint64_t error_code)
+{
+	struct kvm_regs regs;
+
+	memset(&regs, 0, sizeof(regs));
+	regs.r11 = TDX_REPORT_FATAL_ERROR;
+	regs.r12 = error_code;
+	regs.rcx = 0x1C00;
+	tdcall(&regs);
+}
 
 #define TDX_FUNCTION_SIZE(name) ((uint64_t)&__stop_sec_ ## name -\
 			   (uint64_t)&__start_sec_ ## name) \
diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
index 590e45aa7570..1db5400ca5ef 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -91,6 +91,60 @@ void verify_td_lifecycle(void)
 	printf("\t ... PASSED\n");
 }
 
+/*
+ * Verifies TDX_REPORT_FATAL_ERROR functionality.
+ */
+TDX_GUEST_FUNCTION(guest_code_report_fatal_error)
+{
+	uint64_t err;
+	/* Note: err should follow the GHCI spec definition:
+	 * bits 31:0 should be set to 0.
+	 * bits 62:32 are used for TD-specific extended error code.
+	 * bit 63 is used to mark additional information in shared memory.
+	 */
+	err = 0x0BAAAAAD00000000;
+
+	if (err)
+		tdvmcall_fatal(err);
+
+	tdvmcall_success();
+}
+
+void verify_report_fatal_error(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	printf("Verifying report_fatal_error:\n");
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
+	prepare_source_image(vm, guest_code_report_fatal_error,
+			     TDX_FUNCTION_SIZE(guest_code_report_fatal_error),
+			     0);
+	finalize_td_memory(vm);
+
+	vcpu_run(vcpu);
+	ASSERT_EQ(vcpu->run->exit_reason, KVM_EXIT_SYSTEM_EVENT);
+	ASSERT_EQ(vcpu->run->system_event.ndata, 3);
+	ASSERT_EQ(vcpu->run->system_event.data[0], TDX_REPORT_FATAL_ERROR);
+	ASSERT_EQ(vcpu->run->system_event.data[1], 0x0BAAAAAD00000000);
+	ASSERT_EQ(vcpu->run->system_event.data[2], 0);
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
@@ -99,6 +153,7 @@ int main(int argc, char **argv)
 	}
 
 	run_in_new_process(&verify_td_lifecycle);
+	run_in_new_process(&verify_report_fatal_error);
 
 	return 0;
 }
-- 
2.37.2.789.g6183377224-goog

