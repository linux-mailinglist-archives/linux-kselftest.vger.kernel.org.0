Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB265FF3CD
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Oct 2022 20:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiJNSrz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Oct 2022 14:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiJNSry (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Oct 2022 14:47:54 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DC41D20D6
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Oct 2022 11:47:52 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id pq16so5733266pjb.2
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Oct 2022 11:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DVeKnsilAaALTYl5DcDFF3bTzhcPBCzGuXmS6zwN/1A=;
        b=iKtbbS0f/N724EyFcWivRHsLt8s7M/4b5tiw3FgpccfdnP4bQeuyJY25OSL25I5Edy
         MCKU/5Nbe6oz+aJyA877uItmo21eeThDaSBw3ZW2mftEEJURCmd35szX/oiMufzO8TBC
         hh79Cs1Tyja1vUWvKir8DEGiIVbAngjnwfL9RiJyCTP+x8PeSWKvnIKFu2lvvsxxhex2
         nljj5so2YcyL5/mHUIhqp2Qn69Bg9hs+U0xOQ2fKHKhBnSY/GoSzD9WCdSnXAjJJ8Wzz
         ORaQXu4xXEsaU2kGTpi6iD+ms5OZ1th+j2fsEnDnQr0eGt9btCVq/XA5t0IIB/2lZjOU
         XBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVeKnsilAaALTYl5DcDFF3bTzhcPBCzGuXmS6zwN/1A=;
        b=e/FHGj9R8zdTBwyaCkZw9Czl92HhIu9FO8RhtZQzdOro75AksGBqZ3Se8918MrPVaz
         IQMlB95HAMpwDw8nt5UUSkzsvH+pWZhndBKZrzq6TFF74Xgv3fe6BR+fQxdo6iqTtRAI
         FAPNQAhgnV5Sw/kJSDRQAXR/cflZvouFJfZOYnNcy2St6i9jF8+9EBe0sVKkSvPfIi+V
         W2W1WQN/tXcvFrTqmnX04eaioky37oXM3vR/MxVi/4FpWVtS3L/VyR+qrvOHIWUWmB9W
         EXf19QavfuGdu0Q6xgg1oFCdmOAdQZiSZaV/rwJH0Pm1vP7bR3q6V5spoN8iNZmuybqr
         BWKg==
X-Gm-Message-State: ACrzQf1c9kbQxNPEtUHEcbsJqSDEfxIY8slrGbg4IDw98qI7k+3c7usH
        g+3Pp2zj1wTOICMAi/HRRIC5fQ==
X-Google-Smtp-Source: AMsMyM5SnI+qEh7eeSum2zv2KhNeA0NSEtgLt0fvibS+GFep1cf4xtoQVdm9LhnVZpTZEYRfmICmyw==
X-Received: by 2002:a17:903:210d:b0:184:1881:bfe6 with SMTP id o13-20020a170903210d00b001841881bfe6mr6845905ple.80.1665773272183;
        Fri, 14 Oct 2022 11:47:52 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id f125-20020a625183000000b005627868e27esm2077409pfb.127.2022.10.14.11.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 11:47:51 -0700 (PDT)
Date:   Fri, 14 Oct 2022 18:47:48 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        shuah@kernel.org, yang.zhong@intel.com, drjones@redhat.com,
        ricarkol@google.com, aaronlewis@google.com, wei.w.wang@intel.com,
        kirill.shutemov@linux.intel.com, corbet@lwn.net, hughd@google.com,
        jlayton@kernel.org, bfields@fieldses.org,
        akpm@linux-foundation.org, chao.p.peng@linux.intel.com,
        yu.c.zhang@linux.intel.com, jun.nakajima@intel.com,
        dave.hansen@intel.com, michael.roth@amd.com, qperret@google.com,
        steven.price@arm.com, ak@linux.intel.com, david@redhat.com,
        luto@kernel.org, vbabka@suse.cz, marcorr@google.com,
        erdemaktas@google.com, pgonda@google.com, nikunj@amd.com,
        diviness@google.com, maz@kernel.org, dmatlack@google.com,
        axelrasmussen@google.com, maciej.szmigiero@oracle.com,
        mizhang@google.com, bgardon@google.com
Subject: Re: [RFC V3 PATCH 3/6] selftests: kvm: ucall: Allow querying ucall
 pool gpa
Message-ID: <Y0mu1FKugNQG5T8K@google.com>
References: <20220819174659.2427983-1-vannapurve@google.com>
 <20220819174659.2427983-4-vannapurve@google.com>
 <Yz80XAg74KGdSqco@google.com>
 <CAGtprH_XSCXZDroGUnL3H1CwcsbH_A_NDn8B4P2xfpSYGqKmqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGtprH_XSCXZDroGUnL3H1CwcsbH_A_NDn8B4P2xfpSYGqKmqw@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 14, 2022, Vishal Annapurve wrote:
> On Fri, Oct 7, 2022 at 1:32 AM Sean Christopherson <seanjc@google.com> wrote:
> >
> > On Fri, Aug 19, 2022, Vishal Annapurve wrote:
> > > Add a helper to query guest physical address for ucall pool
> > > so that guest can mark the page as accessed shared or private.
> > >
> > > Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> > > ---
> >
> > This should be handled by the SEV series[*].  Can you provide feedback on that
> > series if having a generic way to map the ucall address as shared won't work?
> >
> > [*] https://lore.kernel.org/all/20220829171021.701198-1-pgonda@google.com
> 
> Based on the SEV series you referred to, selftests are capable of
> accessing ucall pool memory by having encryption bit cleared (as set
> by guest pagetables) as allowed by generic API vm_vaddr_alloc_shared.
> This change is needed in the context of fd based private memory where
> guest (specifically non-confidential/sev guests) code in the selftests
> will have to explicitly indicate that ucall pool address range will be
> accessed by guest as shared.

Ah, right, the conversion needs an explicit hypercall, which gets downright
annoying because auto-converting shared pages would effectivfely require injecting
code into the start of every guest.

Ha!  I think we got too fancy.  This is purely for testing UPM, not any kind of
trust model, i.e. there's no need for KVM to treat userspace as untrusted.  Rather
than jump through hoops just to let the guest dictate private vs. shared, simply
"trust" userspace when determining whether a page should be mapped private.  Then
the selftests can invoke the repurposed KVM_MEMORY_ENCRYPT_(UN)REG_REGION ioctls
as appropriate when allocating/remapping guest private memory.

E.g. on top of UPM v8, I think the test hook boils down to:

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index d68944f07b4b..d42d0e6bdd8c 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4279,6 +4279,9 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 
        fault->gfn = fault->addr >> PAGE_SHIFT;
        fault->slot = kvm_vcpu_gfn_to_memslot(vcpu, fault->gfn);
+       fault->is_private = IS_ENABLED(CONFIG_KVM_PRIVATE_MEM_TESTING) &&
+                           kvm_slot_can_be_private(fault->slot) &&
+                           kvm_mem_is_private(vcpu->kvm, fault->gfn);
 
        if (page_fault_handle_page_track(vcpu, fault))
                return RET_PF_EMULATE;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 8ffd4607c7d8..0dc5d0bf647c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1653,7 +1653,7 @@ static void kvm_replace_memslot(struct kvm *kvm,
 
 bool __weak kvm_arch_has_private_mem(struct kvm *kvm)
 {
-       return false;
+       return IS_ENABLED(CONFIG_KVM_PRIVATE_MEM_TESTING);
 }
 
 static int check_memory_region_flags(struct kvm *kvm,
