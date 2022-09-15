Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1DE5B9167
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Sep 2022 02:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiIOAE7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Sep 2022 20:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiIOAE6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Sep 2022 20:04:58 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8295AFD02
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Sep 2022 17:04:56 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id x25-20020aa79199000000b005358eeebf49so10011512pfa.17
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Sep 2022 17:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=k7YNCe9q93GJKQLNbQn4DCcTE32W+gnc21Gk4wtYZRU=;
        b=Dcke97I3Xf1R9wOrr0D7KOe97Lixb1Dngj32GCMPg6ofYp2vRngBYLjYH5f6Gax+5H
         7z7JCGkCxwAZPCQy0VhUomyvulmWIzB964FDPzC2FPXvMo09SbDgwn6aW7KAgl2XZl7H
         IvRJ8Os9yQEc58xg1jUFFtXZoZfFs3xA+OvWphHXtKlY2k/T2JfQYpJw7DwJai1tRzEy
         Cnyc+dIpp9VUCtf1AqR2Em49BDLkyGeuh5AfNkHFN27dS5FsPXtSDvp+SIZMVCWpSpYR
         Y0vBDqVgOBEFMn10Au98lYjJtjNuGeNtSYILkPALZ9+6ZAV+CVh+5D+G7CRW50mgBYb0
         84Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=k7YNCe9q93GJKQLNbQn4DCcTE32W+gnc21Gk4wtYZRU=;
        b=1vkiXEzxE7mi+6w1dqfQDdvfmqMVCerQIPEEBqi5z9dEfuyJKw9xG86anGECncATJY
         7sNXRwnG0Ibuo4AhKTTUe+AN6ajIW1340voWQ40ld9XzoLGtac/6jHDjdvqYbXyQMpqu
         tZOK0wxQsny8BRsjxVRfpBGIeEsK04JdvVw1oMnLZw8y6BvIOdfmfqcMqn8CN+1Ea/Dc
         SddBhqQRFyjlrA9X7teGMl7bqKgsvhEyVB+Twkvnj/RJpEG1Ykt4hZk0ya19h8nmfzIh
         IM5PlXicwkYWVNwb8COcYWiqc65HZ1DDpeHCjzv9CY0nwLIsQihf2ZZ3fketTCqY4tja
         VlIw==
X-Gm-Message-State: ACrzQf2l2fQ3tH2yj5CZvXzryfN07Vcjm5Igt5UkgMN2bfhc0pKKQt15
        4IM/JPXnKVg9xJlKV8eWwkYiBxbkzs2SXLqb
X-Google-Smtp-Source: AMsMyM5mFgtlY/T/tC3v8QhzTx5cd0v4PZoci7DL5mnWVsX73MBOIpR8vrJk1gQoMU+JJ0vlGWwS5KG3c53yqe52
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:90a:a09:b0:202:ab93:2afb with SMTP
 id o9-20020a17090a0a0900b00202ab932afbmr7459241pjo.60.1663200295926; Wed, 14
 Sep 2022 17:04:55 -0700 (PDT)
Date:   Thu, 15 Sep 2022 00:04:42 +0000
In-Reply-To: <20220915000448.1674802-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20220915000448.1674802-1-vannapurve@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220915000448.1674802-3-vannapurve@google.com>
Subject: [V2 PATCH 2/8] KVM: selftests: Add arch specific initialization
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, shuah@kernel.org, bgardon@google.com,
        seanjc@google.com, oupton@google.com, peterx@redhat.com,
        vkuznets@redhat.com, dmatlack@google.com,
        Vishal Annapurve <vannapurve@google.com>
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

Introduce arch specific API: kvm_selftest_arch_init to allow each arch to
handle initialization before running any selftest logic.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h      |  5 +++++
 .../selftests/kvm/lib/aarch64/processor.c      | 18 +++++++++---------
 tools/testing/selftests/kvm/lib/kvm_util.c     |  2 ++
 .../selftests/kvm/lib/riscv/processor.c        |  4 ++++
 .../selftests/kvm/lib/s390x/processor.c        |  4 ++++
 .../selftests/kvm/lib/x86_64/processor.c       |  4 ++++
 6 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 24fde97f6121..98edbbda9f97 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -834,4 +834,9 @@ static inline int __vm_disable_nx_huge_pages(struct kvm_vm *vm)
 	return __vm_enable_cap(vm, KVM_CAP_VM_DISABLE_NX_HUGE_PAGES, 0);
 }
 
+/*
+ * API to execute architecture specific setup before executing selftest logic.
+ */
+void kvm_selftest_arch_init(void);
+
 #endif /* SELFTEST_KVM_UTIL_BASE_H */
diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
index 6f5551368944..2281d6c5d02f 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
@@ -495,15 +495,6 @@ void aarch64_get_supported_page_sizes(uint32_t ipa,
 	close(kvm_fd);
 }
 
-/*
- * arm64 doesn't have a true default mode, so start by computing the
- * available IPA space and page sizes early.
- */
-void __attribute__((constructor)) init_guest_modes(void)
-{
-       guest_modes_append_default();
-}
-
 void smccc_hvc(uint32_t function_id, uint64_t arg0, uint64_t arg1,
 	       uint64_t arg2, uint64_t arg3, uint64_t arg4, uint64_t arg5,
 	       uint64_t arg6, struct arm_smccc_res *res)
@@ -528,3 +519,12 @@ void smccc_hvc(uint32_t function_id, uint64_t arg0, uint64_t arg1,
 		       [arg4] "r"(arg4), [arg5] "r"(arg5), [arg6] "r"(arg6)
 		     : "x0", "x1", "x2", "x3", "x4", "x5", "x6", "x7");
 }
+
+/*
+ * arm64 doesn't have a true default mode, so start by computing the
+ * available IPA space and page sizes early.
+ */
+void kvm_selftest_arch_init(void)
+{
+	guest_modes_append_default();
+}
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 3c83838999f5..dafe4471a6c7 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1984,4 +1984,6 @@ void __attribute((constructor)) kvm_selftest_init(void)
 {
 	/* Tell stdout not to buffer its content. */
 	setbuf(stdout, NULL);
+
+	kvm_selftest_arch_init();
 }
diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
index 604478151212..26660dd2ba78 100644
--- a/tools/testing/selftests/kvm/lib/riscv/processor.c
+++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
@@ -362,3 +362,7 @@ void vcpu_args_set(struct kvm_vcpu *vcpu, unsigned int num, ...)
 void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
 {
 }
+
+void kvm_selftest_arch_init(void)
+{
+}
diff --git a/tools/testing/selftests/kvm/lib/s390x/processor.c b/tools/testing/selftests/kvm/lib/s390x/processor.c
index 89d7340d9cbd..8654ec74009a 100644
--- a/tools/testing/selftests/kvm/lib/s390x/processor.c
+++ b/tools/testing/selftests/kvm/lib/s390x/processor.c
@@ -218,3 +218,7 @@ void vcpu_arch_dump(FILE *stream, struct kvm_vcpu *vcpu, uint8_t indent)
 void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
 {
 }
+
+void kvm_selftest_arch_init(void)
+{
+}
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 2e6e61bbe81b..20bf125f9363 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -1311,3 +1311,7 @@ bool vm_is_unrestricted_guest(struct kvm_vm *vm)
 
 	return val == 'Y';
 }
+
+void kvm_selftest_arch_init(void)
+{
+}
-- 
2.37.2.789.g6183377224-goog

