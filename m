Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635445B916A
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Sep 2022 02:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiIOAFG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Sep 2022 20:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiIOAFB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Sep 2022 20:05:01 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2094910FEC
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Sep 2022 17:04:59 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id a16-20020a170902ecd000b001782ec09870so7399483plh.12
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Sep 2022 17:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=M8kjUtGppue3sjuZ1ccxnaotzaKgHdRhRoDLnPEs3wQ=;
        b=QYYv9pYmzjZ/GZ3xfR1ckqaEiTUNUkkDbO5nicDoIofbwRX6en04HfwXpqyQTrendu
         UFRuKwNh9pZTFaQ9FdJQnxKwa/ciSv27IWRy+I20b/qulZ9ESDP6+38Z4GA3ulqiOitj
         +Vn6QVqxEnGGf58xvRPpvEp9bp5hJA5uEaL1Jvw/w0hFGShyI+YpVKP4EGEmpNOCAC5+
         XeMgGo3aC3gGy/SZp2yl5KAQfUWgMHbKXmXWv/xS4hNC9rFLrJvfkmocTj6E+L/wKFvn
         LN70iu2ioUthiueAD6BNs8/oPDM066Rk9klz3yaVKSJP5jO+6ewEMmrmr8ym6eYDOmKm
         8Knw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=M8kjUtGppue3sjuZ1ccxnaotzaKgHdRhRoDLnPEs3wQ=;
        b=ZNRdwXnl0oxxT7fbREVGTdxTy0mn1N8X6FC/lA0itqOqA5XvrzrRKPNFu8iJh+tJo1
         MBUYAH4Kkd8te9uWtn50LLdkhk3byZRPN5ptL8fNOXiS83w1JLmvY66QwxSkJiBSumiD
         f92ANd4r/UxQlaU1f1mtEqZTamFWeV19106MV3pS5+tPEU3gEm3kcvw6L0VqupvtHRFw
         o0FRHrpYm68Y5wGN5ozfvGHInQVb61WPGOcmyKbVGht1jsUqajh9LiUHohcVBEaStBKE
         FksNs3vJIlegsMuULQS7SFMnuc87tNGzl/H/IC+fDKwWBULs8AtLArizyYcJnKjKzkxX
         BUpQ==
X-Gm-Message-State: ACrzQf2vZqFK7f4OdUpPWsUynzIBsTJj9XIvdOJypeQGNNWF97lJ0EfN
        Wtz7uaR+LV1JdBIWl9cqX277dR8gzxmhVzJ6
X-Google-Smtp-Source: AMsMyM7kpC1GcEfVUy7HRZqDlom1iprzgk4MNlOV/yHhpR0p7r9yl2PDuDr3EXP93iobRxxYxtQu2BGb86gCVUBN
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:90a:64c8:b0:202:6d4a:90f8 with SMTP
 id i8-20020a17090a64c800b002026d4a90f8mr7698135pjm.11.1663200298705; Wed, 14
 Sep 2022 17:04:58 -0700 (PDT)
Date:   Thu, 15 Sep 2022 00:04:43 +0000
In-Reply-To: <20220915000448.1674802-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20220915000448.1674802-1-vannapurve@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220915000448.1674802-4-vannapurve@google.com>
Subject: [V2 PATCH 3/8] KVM: selftests: Add arch specific post vm load setup
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

Add arch specific API kvm_selftest_post_vm_elf_load to possibly communicate
information to VM that is already known to selftest VMM logic.

This API will be used in followup commit to convey cpu vendor type to the
guest vm.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util_base.h | 4 ++++
 tools/testing/selftests/kvm/lib/aarch64/processor.c | 4 ++++
 tools/testing/selftests/kvm/lib/elf.c               | 2 ++
 tools/testing/selftests/kvm/lib/riscv/processor.c   | 4 ++++
 tools/testing/selftests/kvm/lib/s390x/processor.c   | 4 ++++
 tools/testing/selftests/kvm/lib/x86_64/processor.c  | 4 ++++
 6 files changed, 22 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 98edbbda9f97..73cfee3ebd76 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -839,4 +839,8 @@ static inline int __vm_disable_nx_huge_pages(struct kvm_vm *vm)
  */
 void kvm_selftest_arch_init(void);
 
+/*
+ * API to execute architecture specific setup after loading the vm elf.
+ */
+void kvm_arch_post_vm_elf_load(struct kvm_vm *vm);
 #endif /* SELFTEST_KVM_UTIL_BASE_H */
diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
index 2281d6c5d02f..12627c560f66 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
@@ -528,3 +528,7 @@ void kvm_selftest_arch_init(void)
 {
 	guest_modes_append_default();
 }
+
+void kvm_arch_post_vm_elf_load(struct kvm_vm *vm)
+{
+}
diff --git a/tools/testing/selftests/kvm/lib/elf.c b/tools/testing/selftests/kvm/lib/elf.c
index 9f54c098d9d0..b8963a7146ce 100644
--- a/tools/testing/selftests/kvm/lib/elf.c
+++ b/tools/testing/selftests/kvm/lib/elf.c
@@ -189,4 +189,6 @@ void kvm_vm_elf_load(struct kvm_vm *vm, const char *filename)
 				phdr.p_filesz);
 		}
 	}
+
+	kvm_arch_post_vm_elf_load(vm);
 }
diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
index 26660dd2ba78..4491c0d4be45 100644
--- a/tools/testing/selftests/kvm/lib/riscv/processor.c
+++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
@@ -366,3 +366,7 @@ void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
 void kvm_selftest_arch_init(void)
 {
 }
+
+void kvm_arch_post_vm_elf_load(struct kvm_vm *vm)
+{
+}
diff --git a/tools/testing/selftests/kvm/lib/s390x/processor.c b/tools/testing/selftests/kvm/lib/s390x/processor.c
index 8654ec74009a..332501b3693f 100644
--- a/tools/testing/selftests/kvm/lib/s390x/processor.c
+++ b/tools/testing/selftests/kvm/lib/s390x/processor.c
@@ -222,3 +222,7 @@ void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
 void kvm_selftest_arch_init(void)
 {
 }
+
+void kvm_arch_post_vm_elf_load(struct kvm_vm *vm)
+{
+}
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 20bf125f9363..25ae972f5c71 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -1315,3 +1315,7 @@ bool vm_is_unrestricted_guest(struct kvm_vm *vm)
 void kvm_selftest_arch_init(void)
 {
 }
+
+void kvm_arch_post_vm_elf_load(struct kvm_vm *vm)
+{
+}
-- 
2.37.2.789.g6183377224-goog

