Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5988762564
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 00:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjGYWCv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 18:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjGYWCa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 18:02:30 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B4B26B3
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:01 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5637a108d02so2333961a12.2
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690322513; x=1690927313;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2LFI4LFbO9Za9GYdKLk7QvU7CpMUS45By27lNDC3GjA=;
        b=XPZYYN80whNtKmg72IIp/UHHoBnf0D4TOLXPAkgNa859gsOKEWP70FvNNQH3EqSmLb
         /7xYxvbjdyPtqDhR6S+T/OpRbS4h0yD7l7Qyg5zacI8yFm6GAh2Foj3zFORHPP9Lih6k
         dGSFTYH/lXXbywkCKF7WDkY3h7uEV8iNazvovq6bZzWbLiJPIGKx183ygDz6PjtSArqx
         /uIWQxnizEM19sLjT+UP8ulLt4R4VXM/mh95WkN3v7DwtoTbRs0VJE66caFgzMp2pmxX
         9khE9+ginvAEM+3DM55q12biTmLtqaxgPfZ1bkRgbc4G/rckAg3+V7Sb4WHEjCAbGrE8
         RTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690322513; x=1690927313;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2LFI4LFbO9Za9GYdKLk7QvU7CpMUS45By27lNDC3GjA=;
        b=hPH0CiAdbRiDSMpg5YfjOjIzpfu9EsqHrrIrIzu4cwC+NeAgoxB690ZnSFMykArcMt
         OpMMPagNP/nW6aFHBkMmUZxRNqOmofm2+aG491UTGGtjrGnfiI2Go82z7EG7F4rMaiJ1
         jNIAgdgY1ekyTn+hF8O78sjlyhrVGnwlRDnctGN93udpamKcYN7RaI99+uAZMchj6J0Q
         ZmxhgaaW+WM2g8tpLRQeYHOyje+zvW6D+y0qhWFJ5X/8moh4pSO0GePQoXih9k0JaVNP
         4Cesiv9kMCYY3A3qDEipXuBZSXGFYKUXIHHgAYTfNPj3bTMdNQ993bNvW9msSda0FIja
         TuxA==
X-Gm-Message-State: ABy/qLYJveDucPw7CcK1y66MsjYlCgdW84N/5wyQpLWck7Q+erfn1SEO
        Qf1KDxjPKfIWQbm/r/ESxrMdIhV8MsgVR7dAUPRgES0gdpGrn6i3ApaY6zdOTDChf3ncYgvkDXi
        CgAOuujF06bkw06nmIw0ilFUChgHhM5QnMe06bi8zx056XRdTpfF61QfrInsEfdoH+VaY5LCacT
        5F
X-Google-Smtp-Source: APBJJlEPI23MF32jHIZQ2ZRj8w4W6GxwOZ6bYhBqAkYrdYYyI9q1X89KcpwA0MZlRaLNL9IvTnS+4zGIWWHr
X-Received: from afranji.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:47f1])
 (user=afranji job=sendgmr) by 2002:a63:3e82:0:b0:563:9e04:52b with SMTP id
 l124-20020a633e82000000b005639e04052bmr2658pga.6.1690322512106; Tue, 25 Jul
 2023 15:01:52 -0700 (PDT)
Date:   Tue, 25 Jul 2023 22:00:56 +0000
In-Reply-To: <20230725220132.2310657-1-afranji@google.com>
Mime-Version: 1.0
References: <20230725220132.2310657-1-afranji@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725220132.2310657-4-afranji@google.com>
Subject: [PATCH v4 03/28] KVM: selftests: Store initial stack address in
 struct kvm_vcpu
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ackerley Tng <ackerleytng@google.com>

TDX guests' registers cannot be initialized directly using
vcpu_regs_set(), hence the stack pointer needs to be initialized by
the guest itself, running boot code beginning at the reset vector.

We store the stack address as part of struct kvm_vcpu so that it can
be accessible later to be passed to the boot code for rsp
initialization.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Change-Id: I54e7bde72c5c21e7d8944415ac5818d9443e2b70
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util_base.h | 1 +
 tools/testing/selftests/kvm/lib/x86_64/processor.c  | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index a07ce5f5244a..12524d94a4eb 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -67,6 +67,7 @@ struct kvm_vcpu {
 	int fd;
 	struct kvm_vm *vm;
 	struct kvm_run *run;
+	vm_vaddr_t initial_stack_addr;
 #ifdef __x86_64__
 	struct kvm_cpuid2 *cpuid;
 #endif
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index e3a9366d4f80..78dd918b9a92 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -607,10 +607,12 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
 	vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
 	vcpu_setup(vm, vcpu);
 
+	vcpu->initial_stack_addr = stack_vaddr;
+
 	/* Setup guest general purpose registers */
 	vcpu_regs_get(vcpu, &regs);
 	regs.rflags = regs.rflags | 0x2;
-	regs.rsp = stack_vaddr;
+	regs.rsp = vcpu->initial_stack_addr;
 	regs.rip = (unsigned long) guest_code;
 	vcpu_regs_set(vcpu, &regs);
 
-- 
2.41.0.487.g6d72f3e995-goog

