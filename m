Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D4B6549A3
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Dec 2022 01:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbiLWAOG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Dec 2022 19:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235201AbiLWAOD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Dec 2022 19:14:03 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A5E26AA5
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Dec 2022 16:14:02 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id c9-20020a63da09000000b0047954824506so1844757pgh.5
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Dec 2022 16:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cLuChDmHZy9fZJAsWYadyMA42cALgM97d3TAhY29bd4=;
        b=qesxOioXaSBJL1ruAcCimnE/4E3MkzM5ZdGrQ40tnDmX4p1zgoouiyYp1MUFj51vYO
         nNfOwW6LG4WVVZlUPnlDY4+m1g5Ot+S+a+sxVijlNBf3A1ztamoTbu1JNeB6zcat62bv
         4sZKS+O6SR4BDGU2SdZQmbQddafokLgtJEAamTcU9EXpGLpzv5QpwfcuaDT1U1ByTR8t
         Yn9Pel1JcW6C3LxBscnyfw+zgkMrzXFOvu0/lfQMKNp1hjPCg42eLccXB6PKdZ97pd5/
         03ryjbSSeYTi7TOD9AP2l+5tIQA4MenYW7GXMmsAvoZ+uhGJvLzF654L0FA35u/haI3Y
         1Q2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cLuChDmHZy9fZJAsWYadyMA42cALgM97d3TAhY29bd4=;
        b=dcvHMZf3WQVpx2b9OnFHNt+cVFLIQ+onnwsA2mjQBNh/3PuQ00802pRd4hbL42iw04
         i0UNpg/yaGO16idbYufSIl7uGZ1/2g2x6pJSN6R/sj6KLt146AbhQ2TAwSgUzyCESHrl
         5DFkOKOyFnqlpRyBm6FI8BbFxUTKAfJK6prwFGP64Xjbyj4u9OVQ9+sv/itp6/eP9n80
         gk5dKtodncpjwMk3dPlw2iDsF4IAdbSgQC1jE7laXDtuCGCcVWVITpwszNZOVLHVvuMo
         pE8Du6iN77+Gng8YK2RNw2dOwTeP/O9XIU2AoqYq6hXEJFvpmBm2fHBk8vff9qa6g38p
         y9pQ==
X-Gm-Message-State: AFqh2kplqCNW3kF4tCktLSTfGb+GgOLxAuReOy1ZIDSxbXYBMa2IF/08
        0IOdinGE0ilDt9nHZtUD6CBB0oZA1Ti1auHe
X-Google-Smtp-Source: AMrXdXvCa2RPlxHRHVP2d/nxmRmmfc6ud8BYwgOQ+ATjacORH6WxAk8C9L+XSPvx7xJyS+iVx1Es8D2izekn2BrB
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:aa7:870f:0:b0:576:a1d3:a157 with SMTP
 id b15-20020aa7870f000000b00576a1d3a157mr451723pfo.32.1671754442064; Thu, 22
 Dec 2022 16:14:02 -0800 (PST)
Date:   Fri, 23 Dec 2022 00:13:47 +0000
In-Reply-To: <20221223001352.3873203-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20221223001352.3873203-1-vannapurve@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221223001352.3873203-4-vannapurve@google.com>
Subject: [V3 PATCH 3/8] KVM: selftests: x86: Support changing gpa encryption masks
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add support for guest side functionality to modify encryption/shared
masks for entries in page table to allow accessing GPA ranges as private
or shared.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 .../selftests/kvm/include/x86_64/processor.h  |  4 ++
 .../selftests/kvm/lib/x86_64/processor.c      | 39 +++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 3617f83bb2e5..c8c55f54c14f 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -945,6 +945,10 @@ void vcpu_init_descriptor_tables(struct kvm_vcpu *vcpu);
 void vm_install_exception_handler(struct kvm_vm *vm, int vector,
 			void (*handler)(struct ex_regs *));
 
+void guest_set_region_shared(void *vaddr, uint64_t size);
+
+void guest_set_region_private(void *vaddr, uint64_t size);
+
 /* If a toddler were to say "abracadabra". */
 #define KVM_EXCEPTION_MAGIC 0xabacadabaULL
 
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index ab7d4cc4b848..42d1e4074f32 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -276,6 +276,45 @@ static uint64_t *guest_code_get_pte(uint64_t vaddr)
 	return (uint64_t *)&pte[index[0]];
 }
 
+static void guest_code_change_region_prot(void *vaddr_start, uint64_t mem_size,
+	bool private)
+{
+	uint64_t vaddr = (uint64_t)vaddr_start;
+	uint32_t num_pages;
+
+	GUEST_ASSERT(gpgt_info != NULL);
+	uint32_t guest_page_size = gpgt_info->page_size;
+
+	GUEST_ASSERT(!(mem_size % guest_page_size) && !(vaddr % guest_page_size));
+	GUEST_ASSERT(gpgt_info->enc_mask | gpgt_info->shared_mask);
+
+	num_pages = mem_size / guest_page_size;
+	for (uint32_t i = 0; i < num_pages; i++) {
+		uint64_t *pte = guest_code_get_pte(vaddr);
+
+		GUEST_ASSERT(pte);
+		if (private) {
+			*pte &= ~(gpgt_info->shared_mask);
+			*pte |= gpgt_info->enc_mask;
+		} else {
+			*pte &= ~(gpgt_info->enc_mask);
+			*pte |= gpgt_info->shared_mask;
+		}
+		asm volatile("invlpg (%0)" :: "r"(vaddr) : "memory");
+		vaddr += guest_page_size;
+	}
+}
+
+void guest_set_region_shared(void *vaddr, uint64_t size)
+{
+	guest_code_change_region_prot(vaddr, size, /* shared */ false);
+}
+
+void guest_set_region_private(void *vaddr, uint64_t size)
+{
+	guest_code_change_region_prot(vaddr, size, /* private */ true);
+}
+
 void sync_vm_gpgt_info(struct kvm_vm *vm, vm_vaddr_t pgt_info)
 {
 	gpgt_info = (struct guest_pgt_info *)pgt_info;
-- 
2.39.0.314.g84b9a713c41-goog

