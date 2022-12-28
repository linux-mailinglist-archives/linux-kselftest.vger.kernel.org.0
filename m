Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6FD658664
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Dec 2022 20:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbiL1TZA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Dec 2022 14:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbiL1TY5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Dec 2022 14:24:57 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFED18383
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Dec 2022 11:24:52 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id m13-20020a170902f64d00b001899a70c8f1so12611028plg.14
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Dec 2022 11:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eezWDwyqk949sEAV6VBZXvmE65PTPfqNCFhhSoX++44=;
        b=VQLWwAsnp8xEr114AAmlLuYwOEaQZ3kuhyeF6c365GeAlZ4EMzS8MiWB11jz/EMUgm
         khDN6r175XUEyW7m/oNk3OZkdkPyvwGwmsgCd4NMjRYpSLjTAYPrx72KQCfsNXcbQRLr
         0EkXan3XgXT5CLnAlpsw0Vmj/h7JMY+8peywoXVo1O9CJLLG6GhpKfyUTh1zNLRd6zLY
         FEq1Y+kNPCkX43rdGocrQGj5MgGl4RnJaqHBexdt3XuZeOQtdNgiFzgO99+DYRM3JFBZ
         20n74dHtErcViR3PW+5hpXz5jvnhsU/bhHiP4KqIRiiRfueHHRoeui8yVMj5sxFSEL5j
         47jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eezWDwyqk949sEAV6VBZXvmE65PTPfqNCFhhSoX++44=;
        b=1Dqr8UQ3d2gQJxt27yFvZAStmDJZMH3zY7V4vygMjCLjVtKd2SV0UyQQiwg+bIHmZb
         4qAIFzRa9nDqiuqf5yrhFxDgfKOMe8l+29rzgEltxatZA5c7iC7sTTUmuFJstKxNgXdi
         +ivIKCh+pN1GT6v99QBK7z2ad/FQjcy+wT8O7aNLD5986Zl3wMLZC4rx8m66fl/hTFCW
         UO7LqIdvdQxB9qCJ2OTOpT3SqvKHxfWWDFlzZaf4SgikGKigXIS0KQO+/1BmDpvcHgWg
         UOw2DcsntiQTfMau4/l0wQ3PMJ+5Pm0+RAU9punUXd8GmTwf1jZDEYNgwZcWSnCQUbwY
         TNIg==
X-Gm-Message-State: AFqh2kqKSiOBgHtSumz5YAVD5Xv2/CbulvFv+4DOwPG+l+L3nslGEdvF
        fkxWX1Hccxxy6jzXw7NSGWiicyJQxSaoMZow
X-Google-Smtp-Source: AMrXdXuFouVTMxaq7VekFjs4wz2DtSH9W9iNxpumCXLOPTj16YNvmf/eBWS8w7lu3B8BzCIKLgDjy4XmaacOkKAz
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:90a:5c86:b0:219:c1fb:5da8 with SMTP
 id r6-20020a17090a5c8600b00219c1fb5da8mr2330892pji.221.1672255492112; Wed, 28
 Dec 2022 11:24:52 -0800 (PST)
Date:   Wed, 28 Dec 2022 19:24:36 +0000
In-Reply-To: <20221228192438.2835203-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20221228192438.2835203-1-vannapurve@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221228192438.2835203-3-vannapurve@google.com>
Subject: [V4 PATCH 2/4] KVM: selftests: x86: Add variables to store cpu type
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add variables to hold the cpu vendor type that are initialized early
during the selftest setup and later synced to guest vm post VM creation.

These variables will be used in later patches to avoid querying CPU
type multiple times.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 tools/testing/selftests/kvm/lib/x86_64/processor.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index a799af572f3f..b3d2a9ab5ced 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -19,6 +19,8 @@
 #define MAX_NR_CPUID_ENTRIES 100
 
 vm_vaddr_t exception_handlers;
+static bool host_cpu_is_amd;
+static bool host_cpu_is_intel;
 
 static void regs_dump(FILE *stream, struct kvm_regs *regs, uint8_t indent)
 {
@@ -555,6 +557,8 @@ static void vcpu_setup(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
 void kvm_arch_vm_post_create(struct kvm_vm *vm)
 {
 	vm_create_irqchip(vm);
+	sync_global_to_guest(vm, host_cpu_is_intel);
+	sync_global_to_guest(vm, host_cpu_is_amd);
 }
 
 struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
@@ -1264,3 +1268,9 @@ bool vm_is_unrestricted_guest(struct kvm_vm *vm)
 
 	return get_kvm_intel_param_bool("unrestricted_guest");
 }
+
+void kvm_selftest_arch_init(void)
+{
+	host_cpu_is_intel = this_cpu_is_intel();
+	host_cpu_is_amd = this_cpu_is_amd();
+}
-- 
2.39.0.314.g84b9a713c41-goog

