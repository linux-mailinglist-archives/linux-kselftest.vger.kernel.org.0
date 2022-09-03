Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0D75ABC0C
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Sep 2022 03:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiICB3U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Sep 2022 21:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiICB3T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Sep 2022 21:29:19 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4DFF0757
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Sep 2022 18:29:12 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id a17-20020a17090abe1100b001fda49516e2so3927798pjs.2
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Sep 2022 18:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=IaGyK4Cmoeqm5Ji0W1YNBahEYicrSC3f7mSHsYNJtKM=;
        b=FpKrvAobSwsF4v0aTq0S77F1NIiFYOnF38UePy6mvwRkyZmLSMutiLKgJGAKkcAy6e
         cEYuH7JVRMQpp68ZFFDTUqDWHfxsKN0LL/oijxe9JR9VMHCUMAgCkykJ+FFbExkjQZqs
         i1HzfT4x6w/M6+SwuiATa5QzIy2ENHXt0SRS9IkK9xBTxH3w3dfvK6KRppCh/tSkPuZx
         3X7Z8dKE4OCPsOiJo6SFXwx1e63dEao+QD1fa1ykBynAkZNg2xUHTZRUdAWseHxkyx0a
         MFqSlWiy3iVblH0UsSgMshbjMhhRPVr0X+szwkrfYI6cMvf3S3JzG4LkdAwhg3NZcJtP
         GUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=IaGyK4Cmoeqm5Ji0W1YNBahEYicrSC3f7mSHsYNJtKM=;
        b=RiYLEW3x29G/endzCpDCEn+7qFDD43Cio+4p0exS6yPIhN4FbvheYaC7LUnnhufxdo
         ilwEUpW7Czi4CfH4PqWglzAPEcCVmP5RX8N23g3DjPdsHjlY1m3ml0LIxCtd8wnDOToc
         QvijyGhnMVCuNuKsP8+e3kMtm/s5xyNgPN9nh5MnGvSKlbQYQ6GWV6UG/3HTZ7c4Ifwi
         rj+KhxkcyBPYdlvEurUn+wCzh7BWnOCNSuNiK3+tbYedK8rZ99Vb9d4YW5fO/pz2HWl+
         K+M3nedN+zO4UaDS8PTNJEBvGfmeOEzXqPLWdAU2qiEMyX4m5WKpiDDIkkRfRC++CSGQ
         5z/A==
X-Gm-Message-State: ACgBeo2GMpy5cGSrTarfJa+yOON/xifgbv1lQdm509gYuJCaGea7xD2B
        YrmaEAxXAinPUJlZvpIoQQA/4gtmFtncLHVZ
X-Google-Smtp-Source: AA6agR7nkWudbpvipKjy/b0H43cozN9u/M79LMGTTv4qY7Q7a28LiXCWjVh9B1W7+DNdqOZCp16JXhB5FN2Wba5k
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:90a:e558:b0:1fb:c4b7:1a24 with SMTP
 id ei24-20020a17090ae55800b001fbc4b71a24mr44453pjb.1.1662168551705; Fri, 02
 Sep 2022 18:29:11 -0700 (PDT)
Date:   Sat,  3 Sep 2022 01:28:46 +0000
In-Reply-To: <20220903012849.938069-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20220903012849.938069-1-vannapurve@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220903012849.938069-3-vannapurve@google.com>
Subject: [V1 PATCH 2/5] selftests: kvm: Introduce kvm_arch_main and helpers
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, shuah@kernel.org, bgardon@google.com,
        seanjc@google.com, oupton@google.com, peterx@redhat.com,
        vkuznets@redhat.com, drjones@redhat.com, dmatlack@google.com,
        Vishal Annapurve <vannapurve@google.com>
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

Introduce following APIs:
1) kvm_arch_main : to be called at the startup of each test.
2) kvm_arch_post_vm_load: called after guest elf image is loaded into
   memory to populate any global state in guest memory.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util_base.h | 10 ++++++++++
 tools/testing/selftests/kvm/lib/aarch64/processor.c |  8 ++++++++
 tools/testing/selftests/kvm/lib/elf.c               |  2 ++
 tools/testing/selftests/kvm/lib/kvm_util.c          |  2 ++
 tools/testing/selftests/kvm/lib/riscv/processor.c   |  8 ++++++++
 tools/testing/selftests/kvm/lib/s390x/processor.c   |  8 ++++++++
 tools/testing/selftests/kvm/lib/x86_64/processor.c  |  8 ++++++++
 7 files changed, 46 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 9e521d1c8afe..301bef6376a5 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -834,6 +834,16 @@ static inline int __vm_disable_nx_huge_pages(struct kvm_vm *vm)
 	return __vm_enable_cap(vm, KVM_CAP_VM_DISABLE_NX_HUGE_PAGES, 0);
 }
 
+/*
+ * API to execute architecture specific setup before executing selftest logic.
+ */
+void kvm_arch_main(void);
+
+/*
+ * API to execute architecture specific setup after loading VMs.
+ */
+void kvm_arch_post_vm_load(struct kvm_vm *vm);
+
 /*
  * API to be implemented by all the selftests.
  */
diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
index 6f5551368944..a7ca1947d574 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
@@ -528,3 +528,11 @@ void smccc_hvc(uint32_t function_id, uint64_t arg0, uint64_t arg1,
 		       [arg4] "r"(arg4), [arg5] "r"(arg5), [arg6] "r"(arg6)
 		     : "x0", "x1", "x2", "x3", "x4", "x5", "x6", "x7");
 }
+
+void kvm_arch_main(void)
+{
+}
+
+void kvm_arch_post_vm_load(struct kvm_vm *vm)
+{
+}
diff --git a/tools/testing/selftests/kvm/lib/elf.c b/tools/testing/selftests/kvm/lib/elf.c
index 9f54c098d9d0..f56f9279e703 100644
--- a/tools/testing/selftests/kvm/lib/elf.c
+++ b/tools/testing/selftests/kvm/lib/elf.c
@@ -189,4 +189,6 @@ void kvm_vm_elf_load(struct kvm_vm *vm, const char *filename)
 				phdr.p_filesz);
 		}
 	}
+
+	kvm_arch_post_vm_load(vm);
 }
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 2e611a021c6e..b778dc684e30 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1985,6 +1985,8 @@ int main(int argc, char *argv[])
 	/* Tell stdout not to buffer its content */
 	setbuf(stdout, NULL);
 
+	kvm_arch_main();
+
 	__main(argc, argv);
 
 	return 0;
diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
index 604478151212..d992ad5b5771 100644
--- a/tools/testing/selftests/kvm/lib/riscv/processor.c
+++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
@@ -362,3 +362,11 @@ void vcpu_args_set(struct kvm_vcpu *vcpu, unsigned int num, ...)
 void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
 {
 }
+
+void kvm_arch_main(void)
+{
+}
+
+void kvm_arch_post_vm_load(struct kvm_vm *vm)
+{
+}
diff --git a/tools/testing/selftests/kvm/lib/s390x/processor.c b/tools/testing/selftests/kvm/lib/s390x/processor.c
index 89d7340d9cbd..3a249783b3fe 100644
--- a/tools/testing/selftests/kvm/lib/s390x/processor.c
+++ b/tools/testing/selftests/kvm/lib/s390x/processor.c
@@ -218,3 +218,11 @@ void vcpu_arch_dump(FILE *stream, struct kvm_vcpu *vcpu, uint8_t indent)
 void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
 {
 }
+
+void kvm_arch_main(void)
+{
+}
+
+void kvm_arch_post_vm_load(struct kvm_vm *vm)
+{
+}
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 2e6e61bbe81b..e22cfc4bf284 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -1311,3 +1311,11 @@ bool vm_is_unrestricted_guest(struct kvm_vm *vm)
 
 	return val == 'Y';
 }
+
+void kvm_arch_main(void)
+{
+}
+
+void kvm_arch_post_vm_load(struct kvm_vm *vm)
+{
+}
-- 
2.37.2.789.g6183377224-goog

