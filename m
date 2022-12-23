Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9A26549A5
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Dec 2022 01:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbiLWAOL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Dec 2022 19:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235442AbiLWAOF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Dec 2022 19:14:05 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2238827932
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Dec 2022 16:14:05 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id h88-20020a17090a29e100b00223f501b046so1771131pjd.0
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Dec 2022 16:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xlm4N5CTIk+gx1iR2xF2yQo3rvmps98CLQF90zWQYoY=;
        b=jq9yJkP+aFqI9u8i8zl7BZbwNgH9lWiHnMROFDPqV7emq/6CZ1BBaf50MTKk4axAHc
         P9sABC18Xnp2N7bHZ4fpyynjIqDrHu6Gm9tsTlRRzSwwn3W0i3ulLy0Xl61kd3MxS1Sb
         2NHztbMkbWmYzJGnjb2t3WQGs6TpLSrUBIBYBU8VNN912lCHyUFwtnC5bk9HsB8Ggfis
         +y7p+8FCdWi7jdfSSDQNlmCl+FJTT2KJdcPfFDlhmohQqs3qvR9KClcOBwCwtol5jTBA
         0rS1T8RuAY6ZCMdhuzRsWhPMXMYwBH531gG+eFKkv7DZNMnSsCUeFcAWqVBQ6TTT5aix
         XKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xlm4N5CTIk+gx1iR2xF2yQo3rvmps98CLQF90zWQYoY=;
        b=KXfLR1FoVoQnwI9gVR4rjdEEmW+fiGZiMA5BVOpysOeYdGMH7YUt02E7+kLMr0Mtm+
         XRZ47WPQQ+lkG5W52J4GovQTLg05SD1jPL8Cos0b7q/Hmw85uWfLXMwgrQMxPM+fbsNO
         N0Ww8dSnhEwwT3Hn1cz4vfC+fZTBB+MKCdIPPOTut2C+XpnU4OWN6OMBoR28a9syENSA
         6KVngsxrXx4uPLftnoOTWXi1zryJE8tvYNDulsuQmJT7ascWhPiLTqadiV9SVa5qii/X
         VA0S+eIAlvFPcS8/36AHx5Kcta+STmoO/0g4GWI926OQxspcF2wjFTiym0RGBNudsl2o
         tPfA==
X-Gm-Message-State: AFqh2koL3RtVTTY4AZSL79zzeKgKY/1znhUhbeOprgVvgQG2vFCpo3RU
        Vxgbcdd5TsaGYI4FYR6XIj/CnMJ1DqSvaes3
X-Google-Smtp-Source: AMrXdXsWc72htDtUWZS0yotugRgHtIHt8ahcLWxwxO5Sze+CNKRIKcpoRG+ZfMoKpk9Dv/2eij/H1pcN0LxZ3IDY
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:903:32c3:b0:191:3e01:39b3 with SMTP
 id i3-20020a17090332c300b001913e0139b3mr400196plr.5.1671754444373; Thu, 22
 Dec 2022 16:14:04 -0800 (PST)
Date:   Fri, 23 Dec 2022 00:13:48 +0000
In-Reply-To: <20221223001352.3873203-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20221223001352.3873203-1-vannapurve@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221223001352.3873203-5-vannapurve@google.com>
Subject: [V3 PATCH 4/8] KVM: selftests: Split SEV VM creation logic
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shuah@kernel.org, yang.zhong@intel.com,
        drjones@redhat.com, ricarkol@google.com, aaronlewis@google.com,
        wei.w.wang@intel.com, kirill.shutemov@linux.intel.com,
        corbet@lwn.net, hughd@google.com, jlayton@kernel.org,
        bfields@fieldses.org, akpm@linux-foundation.org,
        chao.p.peng@linux.intel.com, yu.c.zhang@linux.intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com,
        michael.roth@amd.com, qperret@google.com, steven.price@arm.com,
        ak@linux.intel.com, david@redhat.com, luto@kernel.org,
        vbabka@suse.cz, marcorr@google.com, erdemaktas@google.com,
        pgonda@google.com, nikunj@amd.com, seanjc@google.com,
        diviness@google.com, maz@kernel.org, dmatlack@google.com,
        axelrasmussen@google.com, maciej.szmigiero@oracle.com,
        mizhang@google.com, bgardon@google.com, ackerleytng@google.com,
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

Split SEV VM creation logic to allow additional modifications
to SEV VM configuration e.g. adding memslots.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 .../selftests/kvm/include/x86_64/sev.h        |  4 ++++
 tools/testing/selftests/kvm/lib/x86_64/sev.c  | 20 ++++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/sev.h b/tools/testing/selftests/kvm/include/x86_64/sev.h
index 1148db928d0b..6bf2015fff7a 100644
--- a/tools/testing/selftests/kvm/include/x86_64/sev.h
+++ b/tools/testing/selftests/kvm/include/x86_64/sev.h
@@ -19,4 +19,8 @@ bool is_kvm_sev_supported(void);
 struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t policy, void *guest_code,
 					   struct kvm_vcpu **cpu);
 
+struct kvm_vm *sev_vm_init_with_one_vcpu(uint32_t policy, void *guest_code,
+					   struct kvm_vcpu **cpu);
+
+void sev_vm_finalize(struct kvm_vm *vm, uint32_t policy);
 #endif /* SELFTEST_KVM_SEV_H */
diff --git a/tools/testing/selftests/kvm/lib/x86_64/sev.c b/tools/testing/selftests/kvm/lib/x86_64/sev.c
index 49c62f25363e..96d3dbc2ba74 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/sev.c
@@ -215,7 +215,7 @@ static void sev_vm_measure(struct kvm_vm *vm)
 	pr_debug("\n");
 }
 
-struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t policy, void *guest_code,
+struct kvm_vm *sev_vm_init_with_one_vcpu(uint32_t policy, void *guest_code,
 					   struct kvm_vcpu **cpu)
 {
 	enum vm_guest_mode mode = VM_MODE_PXXV48_4K;
@@ -231,14 +231,28 @@ struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t policy, void *guest_code,
 	*cpu = vm_vcpu_add(vm, 0, guest_code);
 	kvm_vm_elf_load(vm, program_invocation_name);
 
+	pr_info("SEV guest created, policy: 0x%x, size: %lu KB\n", policy,
+		nr_pages * vm->page_size / 1024);
+	return vm;
+}
+
+void sev_vm_finalize(struct kvm_vm *vm, uint32_t policy)
+{
 	sev_vm_launch(vm, policy);
 
 	sev_vm_measure(vm);
 
 	sev_vm_launch_finish(vm);
+}
 
-	pr_info("SEV guest created, policy: 0x%x, size: %lu KB\n", policy,
-		nr_pages * vm->page_size / 1024);
+struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t policy, void *guest_code,
+					   struct kvm_vcpu **cpu)
+{
+	struct kvm_vm *vm;
+
+	vm = sev_vm_init_with_one_vcpu(policy, guest_code, cpu);
+
+	sev_vm_finalize(vm, policy);
 
 	return vm;
 }
-- 
2.39.0.314.g84b9a713c41-goog

