Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833226549A9
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Dec 2022 01:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbiLWAOW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Dec 2022 19:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235527AbiLWAOJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Dec 2022 19:14:09 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607CC28735
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Dec 2022 16:14:07 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id o11-20020a17090a9f8b00b00225b041ba39so2242953pjp.7
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Dec 2022 16:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EZopER/s4tiFrvreBNvA+OQLVRUFqUiISvcp+c+5UHk=;
        b=HUHXH4BEFdjasI8KjN0DUcFgQ332DM1EZL/VY94UC6Bde5YG+dsLST21wPEJeWfbWE
         wY4rri7V8MWRDYmpHskMTKvqqoxLZBtWuJC7SsHzFUIHkRoL0PTqLj7lSni34hAjQObJ
         xlXyImG913s4gNZ8WDm9+nM7U9HGJqblab9uMnFqkO+wPGJc1j5U63dgGp+POZhikZLP
         j/rXDR7gmy5jND0wk+OXc9YgUJodEbji4Jn4yijCKodYA82gSADK6f7xteIR75w0gdzX
         tsixo1K5xYhwzfwRZhv6jAu4TVv612TEO75bFQbxpJ3LOTl3mCEK6W07rf9eGXcjdcjY
         DPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EZopER/s4tiFrvreBNvA+OQLVRUFqUiISvcp+c+5UHk=;
        b=30CsvWKi3GWp0rkhakMTHqtNUp2eYrX/IFSHgtrns53vx0T4UPTk4XskJT69cmgf4C
         rwinuTEIRG+KGh6K6RzZ4t/+7ilo2YfLjXeO30aCR4Q9t2lN7KxpBLW/uhIoQ42SD1Xw
         LDbn5vqcEVKFGrV0aYzT3uBWfD3brVXcBvba3AmqzyLD9Gt7Y5Zch+hYkPMkpUS4igib
         vyhER2pm10oW4QmFzeKU3+nHMVL98b05GebC+wOViVyxRuvRppCA1OheNgwZ4MKmq0wT
         wcmJL0DpwTkBs/ZRvB8gdXheTbNnqIxxVD9pt00N3eZMUSz9oEHLM22RqKVoTbQmz7n2
         9wMg==
X-Gm-Message-State: AFqh2krL2y8r0OPG1izULmQKBGgpsYwKLYoN7U+jH3YeVuqamRLPPtZ2
        j58S3qNypGVbmM2rR3+8+0MXHCyv7pk5VVAT
X-Google-Smtp-Source: AMrXdXtsCOLxwkxPeGE9Ol/zssDLd6SOwLmrDr2Pr3mBLzctCLIMEiKmUCf6u6bVUNGHfgsoNz3vV5wWK10EBiv+
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a62:3042:0:b0:576:f200:210 with SMTP id
 w63-20020a623042000000b00576f2000210mr505612pfw.67.1671754446844; Thu, 22 Dec
 2022 16:14:06 -0800 (PST)
Date:   Fri, 23 Dec 2022 00:13:49 +0000
In-Reply-To: <20221223001352.3873203-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20221223001352.3873203-1-vannapurve@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221223001352.3873203-6-vannapurve@google.com>
Subject: [V3 PATCH 5/8] KVM: selftests: Enable pagetable mapping for SEV VMs
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

Enable pagetable tracking and mapping for SEV VMs to allow guest code to
execute guest_map_region_shared/private APIs.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 tools/testing/selftests/kvm/lib/x86_64/sev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/sev.c b/tools/testing/selftests/kvm/lib/x86_64/sev.c
index 96d3dbc2ba74..0dfffdc224d6 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/sev.c
@@ -215,6 +215,8 @@ static void sev_vm_measure(struct kvm_vm *vm)
 	pr_debug("\n");
 }
 
+#define GUEST_PGT_MIN_VADDR     0x10000
+
 struct kvm_vm *sev_vm_init_with_one_vcpu(uint32_t policy, void *guest_code,
 					   struct kvm_vcpu **cpu)
 {
@@ -224,6 +226,7 @@ struct kvm_vm *sev_vm_init_with_one_vcpu(uint32_t policy, void *guest_code,
 
 	vm = ____vm_create(mode, nr_pages);
 
+	vm_set_pgt_alloc_tracking(vm);
 	kvm_sev_ioctl(vm, KVM_SEV_INIT, NULL);
 
 	configure_sev_pte_masks(vm);
@@ -238,6 +241,8 @@ struct kvm_vm *sev_vm_init_with_one_vcpu(uint32_t policy, void *guest_code,
 
 void sev_vm_finalize(struct kvm_vm *vm, uint32_t policy)
 {
+	vm_map_page_table(vm, GUEST_PGT_MIN_VADDR);
+
 	sev_vm_launch(vm, policy);
 
 	sev_vm_measure(vm);
-- 
2.39.0.314.g84b9a713c41-goog

