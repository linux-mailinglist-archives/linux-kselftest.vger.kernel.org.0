Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC9269B2B2
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Feb 2023 19:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjBQSzJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Feb 2023 13:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjBQSzG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Feb 2023 13:55:06 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E385FC7A
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Feb 2023 10:54:23 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id l7-20020a17090b078700b0020a71040b4cso777559pjz.6
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Feb 2023 10:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8XXhCOstGxwm90421DAyoKAej/4Z8mcoi6Wlc8kCjdk=;
        b=IZ3Z+JoTISDUXkmeFG7QKBn0PDd2RpeSIuii7wzSU5FWqFqD3YKNG+p6S1JpwaSlDh
         ew0RNKAwlChjbJqhc/GPqNf1onzwQRLDT2pQHAmZ9z13N1rsH4zlD4C/iBORwtcy/7Vs
         4LWY2bmqvD+7WPRfYO9LYJkUalQmHeupmZPVU/uJPEn2jjlzI2fHZUFBGgx89uIFNeR8
         GQMoxJZ7eN704Skwx87dhfoA1hN1zix01/rqgIEYeAej1Xo5VgUaA7c3+8n9lORAovk5
         e/+NnegHzJPw0GpOp+WnX4Iu6JmfT99u3ZWkFj74cIzcI7JpajVc87uUCNr9hx7bRq9F
         xGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8XXhCOstGxwm90421DAyoKAej/4Z8mcoi6Wlc8kCjdk=;
        b=yMrSrgBG6/AdRrkNT3agO2+8yb7TmhoMmVuyLHLY88sAhcdn9/Om2bqn3iNqww0kxu
         kFkZQD9u+UXBJYvDcu75pt8PIRkwx7OEwJE/6a+Z7ESdulUO9jfj+T2/VqzssoDbuOdR
         xadoucS/5J0jCeau/hVyf85qFlcGspYa746txXhk7J+8CORUdIhzKX77blN2LucMfayB
         6gHNBGs/GCB1waPNo7u+ATvLyPZpnRa5Q9dh7VEbY9WsFrXnK3DIi9kl8i3KQiEpE8r8
         vwgHT6H2qjYcDqI6zFu9hapnQkhJrNtj7WsIVBwJOd83t193nM8SRYYjfWbgiO4VK+si
         XZKQ==
X-Gm-Message-State: AO0yUKV9ffb5QbCzo53U44yASm7uKm0TCTA7/MZJ690t2Qx97XTVhZW4
        lOU0DXOW2YajhERBHcpedmfzNiMZ1ZW6n2zXMw==
X-Google-Smtp-Source: AK7set+1XTTWB/DeE9M0hPnAQqoc9pw6PJXf/6VSbMIu1YTy+8tDk8uVwsQF3gP8eC2DNG7keUDHRWLwMUFcysx2TA==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a62:1d41:0:b0:5a8:dc92:109f with SMTP
 id d62-20020a621d41000000b005a8dc92109fmr303430pfd.3.1676660059492; Fri, 17
 Feb 2023 10:54:19 -0800 (PST)
Date:   Fri, 17 Feb 2023 18:54:05 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <32866e5d00174697730d6231d2fb81f6b8d98c8a.1676659352.git.ackerleytng@google.com>
Subject: [PATCH 1/1] KVM: selftests: Adjust VM's initial stack address to
 align with SysV ABI spec
From:   Ackerley Tng <ackerleytng@google.com>
To:     pbonzini@redhat.com, shuah@kernel.org, seanjc@google.com,
        dmatlack@google.com, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     erdemaktas@google.com, vannapurve@google.com, sagis@google.com,
        mail@maciej.szmigiero.name, Ackerley Tng <ackerleytng@google.com>
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

Align stack to match calling sequence requirements in section "The
Stack Frame" of the System V ABI AMD64 Architecture Processor
Supplement, which requires the value (%rsp + 8) to be a multiple of 16
when control is transferred to the function entry point.

This is required because GCC is already aligned with the SysV ABI
spec, and compiles code resulting in (%rsp + 8) being a multiple of 16
when control is transferred to the function entry point.

This fixes guest crashes when compiled guest code contains certain SSE
instructions, because thes SSE instructions expect memory
references (including those on the stack) to be 16-byte-aligned.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---

This patch is a follow-up from discussions at
https://lore.kernel.org/lkml/20230121001542.2472357-9-ackerleytng@google.com/

---
 .../selftests/kvm/include/linux/align.h        | 15 +++++++++++++++
 .../selftests/kvm/lib/x86_64/processor.c       | 18 +++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kvm/include/linux/align.h

diff --git a/tools/testing/selftests/kvm/include/linux/align.h b/tools/testing/selftests/kvm/include/linux/align.h
new file mode 100644
index 000000000000..2b4acec7b95a
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/linux/align.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_ALIGN_H
+#define _LINUX_ALIGN_H
+
+#include <linux/const.h>
+
+/* @a is a power of 2 value */
+#define ALIGN(x, a)		__ALIGN_KERNEL((x), (a))
+#define ALIGN_DOWN(x, a)	__ALIGN_KERNEL((x) - ((a) - 1), (a))
+#define __ALIGN_MASK(x, mask)	__ALIGN_KERNEL_MASK((x), (mask))
+#define PTR_ALIGN(p, a)		((typeof(p))ALIGN((unsigned long)(p), (a)))
+#define PTR_ALIGN_DOWN(p, a)	((typeof(p))ALIGN_DOWN((unsigned long)(p), (a)))
+#define IS_ALIGNED(x, a)		(((x) & ((typeof(x))(a) - 1)) == 0)
+
+#endif	/* _LINUX_ALIGN_H */
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index acfa1d01e7df..09b48ae96fdd 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2018, Google LLC.
  */

+#include "linux/align.h"
 #include "test_util.h"
 #include "kvm_util.h"
 #include "processor.h"
@@ -569,6 +570,21 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
 				       DEFAULT_GUEST_STACK_VADDR_MIN,
 				       MEM_REGION_DATA);

+	stack_vaddr += DEFAULT_STACK_PGS * getpagesize();
+
+	/*
+	 * Align stack to match calling sequence requirements in section "The
+	 * Stack Frame" of the System V ABI AMD64 Architecture Processor
+	 * Supplement, which requires the value (%rsp + 8) to be a multiple of
+	 * 16 when control is transferred to the function entry point.
+	 *
+	 * If this code is ever used to launch a vCPU with 32-bit entry point it
+	 * may need to subtract 4 bytes instead of 8 bytes.
+	 */
+	TEST_ASSERT(IS_ALIGNED(stack_vaddr, PAGE_SIZE),
+		"stack_vaddr must be page aligned for stack adjustment of -8 to work");
+	stack_vaddr -= 8;
+
 	vcpu = __vm_vcpu_add(vm, vcpu_id);
 	vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
 	vcpu_setup(vm, vcpu);
@@ -576,7 +592,7 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
 	/* Setup guest general purpose registers */
 	vcpu_regs_get(vcpu, &regs);
 	regs.rflags = regs.rflags | 0x2;
-	regs.rsp = stack_vaddr + (DEFAULT_STACK_PGS * getpagesize());
+	regs.rsp = stack_vaddr;
 	regs.rip = (unsigned long) guest_code;
 	vcpu_regs_set(vcpu, &regs);

--
2.39.2.637.g21b0678d19-goog
