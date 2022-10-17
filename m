Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BFA600BCD
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Oct 2022 12:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiJQKAT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Oct 2022 06:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiJQKAS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Oct 2022 06:00:18 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7242AE2C
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Oct 2022 03:00:14 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q1so9983795pgl.11
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Oct 2022 03:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ePppwLt74DC17JINfUdq6ewo+ZOCDgPxBEotdIjpxzA=;
        b=Pznod0+OlFAyAl5hAqI+jlkkU/ZBSOnS+JMGGJfh/SEvsibrXGTR9F5IZn01jbWw4Y
         ALzLuPu2RwziBUKwMKBr2UMMWB3xoN3qlgOpspRHsSLWWM4BLcyRi3WGM4qeTIlkn1gK
         T9H4qNR7rIZ03evY2tV+JtwI/1ECZxySJCTk/DwgkIm8hmTCk9QrpVbRHcR9hR86m7sw
         xUq2/zwwKb6fAiAnNZVr2mHoitgkZYXKeANksUY0y7coiHKSnBUIDmnsSmUEWPpcg5ip
         /9nOy19mqIX/KdcacIC/9aNk56b0Gvs9LwgedSS+siKOIZqUYWo/8eNNLMgE5ZWjqTby
         oRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ePppwLt74DC17JINfUdq6ewo+ZOCDgPxBEotdIjpxzA=;
        b=dp32Ij514uBKxxWA+e970ONoXstzCJuRVJuto02YF/GVztnC07V1vNGDiIc425eDqg
         i8YO/LPpRNv3LurWmjUTeYaqZIT9xDnFspolXhe/v1Ty9TVDO0WbYTSJTljtAvyWB0St
         G04XH4a5O14O6WAa7bEJd7O3T+FW1102k4pCO0+9d+Vqwothym97YJePng9Bo3E5qQlZ
         /Vql4V/HdbIH4UQzC47JqIdsoyX7Q6mkwm+IfmBdF3osoHjPknHkUmk9QtkgBykZ0jc2
         64kEWK7XL7pMgGtj72CsIHo7OQP39MEl54GACY9gndH3vlIJqO8dsGoR0SaVfSOcCFqs
         P6xQ==
X-Gm-Message-State: ACrzQf0ruVJ7uBv5tZUudr+cSU1dFCFbe5iZiVOkezYRwcH80RD3HiK/
        abGOmQo4CG0pTsrZFchKHYUsUWtfwrjiAMQmYKarEg==
X-Google-Smtp-Source: AMsMyM61at4bEZhvaPH428j8qUSJp4507BHO65b98Rw1OxZWJISyAn81PnFbbiQ5nxYYzPcOCG7jOmcfSrXYqkKvPEY=
X-Received: by 2002:a65:4c46:0:b0:460:f598:d038 with SMTP id
 l6-20020a654c46000000b00460f598d038mr10254368pgr.99.1666000813404; Mon, 17
 Oct 2022 03:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220819174659.2427983-1-vannapurve@google.com>
 <20220819174659.2427983-4-vannapurve@google.com> <Yz80XAg74KGdSqco@google.com>
 <CAGtprH_XSCXZDroGUnL3H1CwcsbH_A_NDn8B4P2xfpSYGqKmqw@mail.gmail.com> <Y0mu1FKugNQG5T8K@google.com>
In-Reply-To: <Y0mu1FKugNQG5T8K@google.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Mon, 17 Oct 2022 15:30:02 +0530
Message-ID: <CAGtprH9tm2ZPY6skZuqeYq9LzpPeoSzYEnqMja3heVf06qoFgQ@mail.gmail.com>
Subject: Re: [RFC V3 PATCH 3/6] selftests: kvm: ucall: Allow querying ucall
 pool gpa
To:     Sean Christopherson <seanjc@google.com>
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
Content-Type: text/plain; charset="UTF-8"
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

On Sat, Oct 15, 2022 at 12:17 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Fri, Oct 14, 2022, Vishal Annapurve wrote:
> > On Fri, Oct 7, 2022 at 1:32 AM Sean Christopherson <seanjc@google.com> wrote:
> > >
> > > On Fri, Aug 19, 2022, Vishal Annapurve wrote:
> > > > Add a helper to query guest physical address for ucall pool
> > > > so that guest can mark the page as accessed shared or private.
> > > >
> > > > Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> > > > ---
> > >
> > > This should be handled by the SEV series[*].  Can you provide feedback on that
> > > series if having a generic way to map the ucall address as shared won't work?
> > >
> > > [*] https://lore.kernel.org/all/20220829171021.701198-1-pgonda@google.com
> >
> > Based on the SEV series you referred to, selftests are capable of
> > accessing ucall pool memory by having encryption bit cleared (as set
> > by guest pagetables) as allowed by generic API vm_vaddr_alloc_shared.
> > This change is needed in the context of fd based private memory where
> > guest (specifically non-confidential/sev guests) code in the selftests
> > will have to explicitly indicate that ucall pool address range will be
> > accessed by guest as shared.
>
> Ah, right, the conversion needs an explicit hypercall, which gets downright
> annoying because auto-converting shared pages would effectivfely require injecting
> code into the start of every guest.
>
Ack.

> Ha!  I think we got too fancy.  This is purely for testing UPM, not any kind of
> trust model, i.e. there's no need for KVM to treat userspace as untrusted.  Rather
> than jump through hoops just to let the guest dictate private vs. shared, simply
> "trust" userspace when determining whether a page should be mapped private.  Then
> the selftests can invoke the repurposed KVM_MEMORY_ENCRYPT_(UN)REG_REGION ioctls
> as appropriate when allocating/remapping guest private memory.
>
> E.g. on top of UPM v8, I think the test hook boils down to:
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index d68944f07b4b..d42d0e6bdd8c 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4279,6 +4279,9 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
>
>         fault->gfn = fault->addr >> PAGE_SHIFT;
>         fault->slot = kvm_vcpu_gfn_to_memslot(vcpu, fault->gfn);
> +       fault->is_private = IS_ENABLED(CONFIG_KVM_PRIVATE_MEM_TESTING) &&
> +                           kvm_slot_can_be_private(fault->slot) &&
> +                           kvm_mem_is_private(vcpu->kvm, fault->gfn);
>
>         if (page_fault_handle_page_track(vcpu, fault))
>                 return RET_PF_EMULATE;
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 8ffd4607c7d8..0dc5d0bf647c 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1653,7 +1653,7 @@ static void kvm_replace_memslot(struct kvm *kvm,
>
>  bool __weak kvm_arch_has_private_mem(struct kvm *kvm)
>  {
> -       return false;
> +       return IS_ENABLED(CONFIG_KVM_PRIVATE_MEM_TESTING);
>  }
>
>  static int check_memory_region_flags(struct kvm *kvm,

This is much sleeker and will avoid hacking KVM for testing. Only
caveat here is that these tests will not be able to exercise implicit
conversion path if we go this route.
