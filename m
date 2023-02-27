Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79986A4933
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Feb 2023 19:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjB0SGq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Feb 2023 13:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjB0SGp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Feb 2023 13:06:45 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738CB2107
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Feb 2023 10:06:17 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536cb268ab8so156149647b3.17
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Feb 2023 10:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CCs6UT8o6jWjsVnlpOlGQvwvfh2gZBztGVt5ejScdkA=;
        b=n1Hm70B2pVQ4JlAhGiUDyj4CEH8k0YYYiRK+CxFnN6Ks5AuOrDlHiK9oH4W9oR6D/Z
         IyAD9aW7E6kJPybduNEV2dOGlxSucL/cGgipuHi8rs8KB6gj2Mb7+ZMgxgc6HiW7t74w
         r6TtEub/Ib2L65WI0R/PZrqIF3GvfS5n64uVujKPFkeCh0/CDcBxibe+cUGdL4Gs4FSr
         rck6QYtvVtC6jUs3hMWknorvuedx97yfjeQ4/38KVfggUKU7rSIg1Xy33rKgKSCFTeU6
         IDlFX/b8umtqUw/L8+NF64Erf7JpxHtUoWok77B/UBFxLIQPpMXOowJlWJIlZD2NtbcP
         nbNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CCs6UT8o6jWjsVnlpOlGQvwvfh2gZBztGVt5ejScdkA=;
        b=cBz5a+VArfxRsE4pTgcRsIIqVC9N/tNHM4CMYmlFqB7jwPu4gw5w9yMuLhAH/GYH8P
         xwZ9bGNzjjRKJhogQNBXvL09DKX6o4rByLX8qTBrUqN36UupENGVRnRFSH0i7nymvLyX
         jMrm8v5DuWLC/dJMwJWJ2bXLpO6E4y/V4OA+SEhQOVSfDF6qKdjFSnpP9xLhkuVzmprs
         3wpN054rXYbdxf/E7Hvp2wA9c7g8vPIsE/hKS1Idv1NwfDWIqf7fbUyCrjmkwgoqfZIO
         uYGJNRKEHhvubCJTFkkxK5q0IXXUzm/DNZJ7Tl2kKC8ryGEEsjjGLmcijWIXw4PNBmZk
         6CYw==
X-Gm-Message-State: AO0yUKW0JZdVQHeaC/VH0H5jZW7ilZkwACsW1k8amcDscn/r3B6hGfth
        bLkAa59TOUsRJkwHf7Hbccj043at0N3uTtndmw==
X-Google-Smtp-Source: AK7set/qINqQKKt6kZE0c8d6Ua2qChgsBAHGHkegT5aaQvUm1/8fbeJe6dPKfUwIaRlyeMAyPAhNbh4GJO50EFxRGQ==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a05:6902:118c:b0:a06:538f:265f with
 SMTP id m12-20020a056902118c00b00a06538f265fmr8185254ybu.4.1677521173110;
 Mon, 27 Feb 2023 10:06:13 -0800 (PST)
Date:   Mon, 27 Feb 2023 18:06:01 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230227180601.104318-1-ackerleytng@google.com>
Subject: [PATCH v2 1/1] KVM: selftests: Adjust VM's initial stack address to
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

Align the guest stack to match calling sequence requirements in
section "The Stack Frame" of the System V ABI AMD64 Architecture
Processor Supplement, which requires the value (%rsp + 8), NOT %rsp,
to be a multiple of 16 when control is transferred to the function
entry point. I.e. in a normal function call, %rsp needs to be 16-byte
aligned _before_ CALL, not after.

This fixes unexpected #GPs in guest code when the compiler uses SSE
instructions, e.g. to initialize memory, as many SSE instructions
require memory operands (including those on the stack) to be
16-byte-aligned.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---

This patch is a follow-up from discussions at
https://lore.kernel.org/lkml/20230121001542.2472357-9-ackerleytng@google.com/

v1 -> v2: Cleaned the patch up after getting comments from Sean in

v1: https://lore.kernel.org/lkml/Y%2FfHLdvKHlK6D%2F1v@google.com/

Please also see
https://lore.kernel.org/lkml/20230227174654.94641-1-ackerleytng@google.com/
regarding providing alignment macros for selftests.

---
 .../selftests/kvm/lib/x86_64/processor.c       | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index ae1e573d94ce..a0669d31bb85 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2018, Google LLC.
  */

+#include "linux/bitmap.h"
 #include "test_util.h"
 #include "kvm_util.h"
 #include "processor.h"
@@ -573,6 +574,21 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
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
+		    "__vm_vaddr_alloc() did not provide a page-aligned address");
+	stack_vaddr -= 8;
+
 	vcpu = __vm_vcpu_add(vm, vcpu_id);
 	vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
 	vcpu_setup(vm, vcpu);
@@ -580,7 +596,7 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
 	/* Setup guest general purpose registers */
 	vcpu_regs_get(vcpu, &regs);
 	regs.rflags = regs.rflags | 0x2;
-	regs.rsp = stack_vaddr + (DEFAULT_STACK_PGS * getpagesize());
+	regs.rsp = stack_vaddr;
 	regs.rip = (unsigned long) guest_code;
 	vcpu_regs_set(vcpu, &regs);

--
2.39.2.722.g9855ee24e9-goog
