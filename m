Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E4C773348
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 01:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjHGXCN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 19:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjHGXCH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 19:02:07 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1837419B4
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Aug 2023 16:01:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c8f360a07a2so4022743276.2
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Aug 2023 16:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691449304; x=1692054104;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4dErXtZJPA2B8bwHAUFICQ3V58GoU0WO1AR+4rLGR9U=;
        b=ZxlSKTI+laVNBuO8UTZ+ZCGmUs6BNo5I74TnUdV85ACjNmtDKARsLhiKqNMkPh3Mk/
         9RaigGGI96R+oAax6t0XcVzh8hAtDE96WW6YBkgzVqUaGgZ4WbSfnL1Mxr1I+7KubkRZ
         aaRhDkQDreqT1nDjrN2f4k06gs9+NCb45aivwY5/OAY6/QXCQhJngzrRQGNBLIUz8Cyt
         hlP0O+Y8+CM3VuMtiAJtfNe0nW6FbV1OSPxS/FzhNkedO0KnlSQqZ9O7eheS8Rab6j0x
         7Wn5l0azCIiJBUoh4czhdZ8N3ivr5kK4ri1VgZ0oq/SFtrBJ5mIx+xdOg+mJb52yDZkP
         lTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449304; x=1692054104;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4dErXtZJPA2B8bwHAUFICQ3V58GoU0WO1AR+4rLGR9U=;
        b=hTLgdtZnzE3Z5n5nVlgipZZTBxD33R5ksJifwNTC3n3rEnDgmUybjgsKXhzSyjFOOv
         n1Yf69iBwu2jsDBfkRAvsF/q2kHX5uSFbOnVCQKUyBqZor9O7oZa2m1ILtAcyw2fVneC
         rU54m4OFpKAH8jXwn2sMhBKuQ3CP6SnpskbKGoRbppT07aAz+61PxkYDyzOYooTLL2iO
         8K7bN6Q17I6vROzn7d8Ax/L5FZTW25P+Ro7/ZyZF7a63pEFb8UoMLCfNyvr6unGcZ0tl
         9TlcLOCjhBuU2lJsMnLaCYzLypgMNzBw2MkI24oki3mbgsGbpAtoskPsYj3yDtK5ZP/f
         PRPw==
X-Gm-Message-State: AOJu0Yx7hOXEy7sFhpwVCJBAKfJRASUn2Tb/LgBSGUxHJEoAWncAj6b+
        OG7KNh+B+tspDcyHIohJyr2Ezpbii0uWRUIbkQ==
X-Google-Smtp-Source: AGHT+IE/svlKmPQhPLWKkKQHO7AopT/Do6XvEGP3HPyG7nJ9U7NBc6RK+4KEP45bkZMm6GjdRHt0UIxCEE1tcBGE2g==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a05:6902:1588:b0:d3b:12d3:564e with
 SMTP id k8-20020a056902158800b00d3b12d3564emr65596ybu.2.1691449304218; Mon,
 07 Aug 2023 16:01:44 -0700 (PDT)
Date:   Mon,  7 Aug 2023 23:01:11 +0000
In-Reply-To: <cover.1691446946.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1691446946.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <196a2130f155cbc0201cce06579f122352c8b236.1691446946.git.ackerleytng@google.com>
Subject: [RFC PATCH 08/11] KVM: x86: Let moving encryption context be configurable
From:   Ackerley Tng <ackerleytng@google.com>
To:     pbonzini@redhat.com, seanjc@google.com, tglx@linutronix.de,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shuah@kernel.org, andrew.jones@linux.dev,
        ricarkol@google.com, chao.p.peng@linux.intel.com, tabba@google.com,
        jarkko@kernel.org, yu.c.zhang@linux.intel.com,
        vannapurve@google.com, ackerleytng@google.com,
        erdemaktas@google.com, mail@maciej.szmigiero.name, vbabka@suse.cz,
        david@redhat.com, qperret@google.com, michael.roth@amd.com,
        wei.w.wang@intel.com, liam.merwick@oracle.com,
        isaku.yamahata@gmail.com, kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SEV-capable VMs may also use the KVM_X86_SW_PROTECTED_VM type, but
they will still need architecture-specific handling to move encryption
context. Hence, we let moving of encryption context be configurable
and store that configuration in a flag.

Co-developed-by: Vishal Annapurve <vannapurve@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 arch/x86/include/asm/kvm_host.h | 2 ++
 arch/x86/kvm/svm/sev.c          | 2 ++
 arch/x86/kvm/x86.c              | 9 ++++++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 71c1236e4f18..ab45a3d3c867 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1445,6 +1445,8 @@ struct kvm_arch {
 	 */
 #define SPLIT_DESC_CACHE_MIN_NR_OBJECTS (SPTE_ENT_PER_PAGE + 1)
 	struct kvm_mmu_memory_cache split_desc_cache;
+
+	bool vm_move_enc_ctxt_supported;
 };
 
 struct kvm_vm_stat {
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index e0e206aa3e62..b09e6477e309 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -256,6 +256,8 @@ static int sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp)
 		goto e_no_asid;
 	sev->asid = asid;
 
+	kvm->arch.vm_move_enc_ctxt_supported = true;
+
 	ret = sev_platform_init(&argp->error);
 	if (ret)
 		goto e_free;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 75d48379d94d..a1a28dd77b94 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6351,7 +6351,14 @@ static int kvm_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 	if (r)
 		goto out_mark_migration_done;
 
-	r = static_call(kvm_x86_vm_move_enc_context_from)(kvm, source_kvm);
+	/*
+	 * Different types of VMs will allow userspace to define if moving
+	 * encryption context should be supported.
+	 */
+	if (kvm->arch.vm_move_enc_ctxt_supported &&
+	    kvm_x86_ops.vm_move_enc_context_from) {
+		r = static_call(kvm_x86_vm_move_enc_context_from)(kvm, source_kvm);
+	}
 
 	kvm_unlock_two_vms(kvm, source_kvm);
 out_mark_migration_done:
-- 
2.41.0.640.ga95def55d0-goog

