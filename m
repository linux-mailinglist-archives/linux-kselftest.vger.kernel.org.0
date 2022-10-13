Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAE55FD8FE
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Oct 2022 14:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiJMMOB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Oct 2022 08:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiJMMN6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Oct 2022 08:13:58 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B40FE906
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Oct 2022 05:13:51 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id gz13-20020a17090b0ecd00b0020d67a4e6e5so1004794pjb.3
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Oct 2022 05:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V0aWW8bYZcwHBD680JFtsAetqc8rikFJrjlci3PTsrQ=;
        b=mrImrw9iRdZRmVVn3GynmwX3YCsy4SMTIdW1kb3OWriCm4QyX3xxUKJ3xPaqFRfIDZ
         jD2YV7LE4SRRpOA/oDGRX2PdPM86tgj0I6I/Gd2KHSV6VyXKfb1VH1tfPDV/1ObiOxet
         TiQpjp4DdTrfFB1AtaoTh6RO8iz31izgANRCSt+NWPB3PIvTQ4S9IJ2DVmhQ45pSoD8b
         ZpkIASLfpDCIRPXdLiVljzCkFEHIAA9DInb4VjV9FdQY358XVAd0BFTva7kHYQ3Wl3Xu
         fYGsJ1Mk6A9zbbD3tkJvTRyB/RDRKC79C/TCecFPpDwNzKXfncJ0UHkbbbRa1j9hhsIj
         pjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V0aWW8bYZcwHBD680JFtsAetqc8rikFJrjlci3PTsrQ=;
        b=ScEh6lQlyUDaVAhitvFtgLnQqEFkF0z7xr9y7L8VBch5IKVeHToZtMbwlc7ZpLU7WJ
         F9LkP8z7G70IuMt6k6Wiw3Ls+52Hsh6BKh00B5g76kRMiy3LGO8mqlyzvcZQSr0KS8IE
         0ZBCsdtVn6TiW0++oAwUTlyE77okClPwstAMI7s8I1noRalaIt7x62B80I7LiKl0m43y
         +RmU/ccKKvBkphxkZaopGUR2gBppLICpapEgT8x6pDfm3Ord8q/WP6mk/wKtMxX3Rlqa
         Fpc20M6rq0Q8BMKMvbMi8qn6FcPNUN1UGwrWv9Am5vm4CHMIW6DLBZJvEcrcj0ihfR2d
         NBDQ==
X-Gm-Message-State: ACrzQf0k32pWz55MwgxIurim0h3H2NNBwAcDACWz0VL69p98gtGMvVmp
        ZlDnXXe0UKlESQiHpLY9yDqigoWIIKNp0W/C
X-Google-Smtp-Source: AMsMyM6S6FkRoIYnEPSy/CG4F3ryvwVLnb6dJUjttNHKuwroUYt7Ut4GOOdwDkpHgOznch9y8LBY8rLLkvRfqgv4
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:902:64c2:b0:17b:6546:54be with SMTP
 id y2-20020a17090264c200b0017b654654bemr35968508pli.60.1665663230813; Thu, 13
 Oct 2022 05:13:50 -0700 (PDT)
Date:   Thu, 13 Oct 2022 12:13:18 +0000
In-Reply-To: <20221013121319.994170-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20221013121319.994170-1-vannapurve@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221013121319.994170-4-vannapurve@google.com>
Subject: [V3 PATCH 3/4] KVM: selftests: Add arch specific post vm creation hook
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add arch specific API kvm_arch_vm_post_create to perform any required setup
after VM creation.

This API will be used in followup commit to convey cpu vendor type to the
guest vm.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util_base.h | 4 ++++
 tools/testing/selftests/kvm/lib/kvm_util.c          | 9 ++++++---
 tools/testing/selftests/kvm/lib/x86_64/processor.c  | 6 ++++++
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index eec0e4898efe..1e7d3eae8c91 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -843,4 +843,8 @@ static inline int __vm_disable_nx_huge_pages(struct kvm_vm *vm)
  */
 void kvm_selftest_arch_init(void);
 
+/*
+ * API to execute architecture specific setup after creating the VM.
+ */
+void kvm_arch_vm_post_create(struct kvm_vm *vm);
 #endif /* SELFTEST_KVM_UTIL_BASE_H */
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index deb4c731b9fa..3ed72980c996 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -340,9 +340,8 @@ struct kvm_vm *__vm_create(enum vm_guest_mode mode, uint32_t nr_runnable_vcpus,
 
 	kvm_vm_elf_load(vm, program_invocation_name);
 
-#ifdef __x86_64__
-	vm_create_irqchip(vm);
-#endif
+	kvm_arch_vm_post_create(vm);
+
 	return vm;
 }
 
@@ -2022,6 +2021,10 @@ void __vm_get_stat(struct kvm_vm *vm, const char *stat_name, uint64_t *data,
 	}
 }
 
+__weak void kvm_arch_vm_post_create(struct kvm_vm *vm)
+{
+}
+
 __weak void kvm_selftest_arch_init(void)
 {
 }
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 39c4409ef56a..fa65e8142c16 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -1327,3 +1327,9 @@ bool vm_is_unrestricted_guest(struct kvm_vm *vm)
 
 	return get_kvm_intel_param_bool("unrestricted_guest");
 }
+
+
+void kvm_arch_vm_post_create(struct kvm_vm *vm)
+{
+	vm_create_irqchip(vm);
+}
-- 
2.38.0.rc1.362.ged0d419d3c-goog

