Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88AC7670E0B
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jan 2023 00:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjAQXtx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Jan 2023 18:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjAQXte (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Jan 2023 18:49:34 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A004F376
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jan 2023 14:59:03 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id v13so13166645eda.11
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jan 2023 14:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bna1Go+FLPWZPO+Q65HkXvlvtGtXMjbIMGmdWudjb8E=;
        b=SXEXN4zAt0S8uxdQAAbuzPEfDs+2gUgOVxUyZIqwyoFvU5gUH+sBt+cuITwbAuo055
         QQXw8bCXGg5lptXHjpWKN1NbFkKZxdfHss6hgNw10E9w9ALQHIuqPrnbBPrss6VjtRkb
         GP9ZiBSPUIBeenGZA5q++JngkMUWHGQyuwshey8h6xai6MQY7GeX84ai4MSaQ9GOHIYZ
         oP9J3yPcVpozQ9e0Fq6nAp3BrADANgplgrm2onZv9pDxFUPtVbO5xEniRfTdgQbC62dp
         acw8zhCv4aCs4G1sm0B/kziyBjM2RTVFiwoTONP9pY5D0QLq3sCJrziKfkiaea2ZBgYU
         Zu1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bna1Go+FLPWZPO+Q65HkXvlvtGtXMjbIMGmdWudjb8E=;
        b=0WuPfPXlsEtmY4SD7cKit+FWiB8c62DOITXW1Lhpgrv+I4NAbisicX7XPJBNYqjHbe
         3uB9MGq+j9KzQmDOLDpoovuesTiNiChlQJvQS7rm8vgIRZSXswNlovgUT0FvGrcDtviz
         z9acr4bzfVH3XeGlbJET8qFXh096SfmNwfRtn51HJQwOBnF9PspGtPzLTGLN11fvnaLV
         8RwKu2NoHkNXUZPlbIocfxA5FoWye8KD6AtAO1bpGba0TgN6dL0Q8w2VWfm2CV3CQ2WP
         dMXW/8SQ9X77DddTo9appVjeGDxpdNWus0JGqT3DararDcLGonQW0smbTGVDSK7j5A1G
         bxDA==
X-Gm-Message-State: AFqh2kpvdKd8P9duy+wBJnrBGubituKo8NG/cFNdfUfXgCYbP+MgkPDz
        3/YofjdwLFKJYHglNYeDwZlfrKoBe7QesXG3e30BlA==
X-Google-Smtp-Source: AMrXdXtj/BOtB5PM/YeFNzbYlnJMctr7Ss11djAm3clEWb1KMmuzi1BrQwFCaY24rxwj7vdIeBQZOopIAXVc0CEtDdo=
X-Received: by 2002:aa7:da51:0:b0:49e:4936:bbd8 with SMTP id
 w17-20020aa7da51000000b0049e4936bbd8mr31755eds.410.1673996341742; Tue, 17 Jan
 2023 14:59:01 -0800 (PST)
MIME-Version: 1.0
References: <20221205232341.4131240-1-vannapurve@google.com>
 <20221205232341.4131240-2-vannapurve@google.com> <Y8cVhFIM1EoLHO/V@google.com>
In-Reply-To: <Y8cVhFIM1EoLHO/V@google.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Tue, 17 Jan 2023 14:58:48 -0800
Message-ID: <CAGtprH-Z9=pKM1XxYYQTvwA161BCdgeRbRFQjV=HaV+4Qfo3=w@mail.gmail.com>
Subject: Re: [V2 PATCH 1/6] KVM: x86: Add support for testing private memory
To:     Sean Christopherson <seanjc@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        shuah@kernel.org, yang.zhong@intel.com, ricarkol@google.com,
        aaronlewis@google.com, wei.w.wang@intel.com,
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
        mizhang@google.com, bgardon@google.com, ackerleytng@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 17, 2023 at 1:39 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Mon, Dec 05, 2022, Vishal Annapurve wrote:
> > Introduce HAVE_KVM_PRIVATE_MEM_TESTING config to be able to test fd based
> > @@ -272,13 +274,15 @@ static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
> >               .rsvd = err & PFERR_RSVD_MASK,
> >               .user = err & PFERR_USER_MASK,
> >               .prefetch = prefetch,
> > -             .is_tdp = likely(vcpu->arch.mmu->page_fault == kvm_tdp_page_fault),
> > +             .is_tdp = is_tdp,
> >               .nx_huge_page_workaround_enabled =
> >                       is_nx_huge_page_enabled(vcpu->kvm),
> >
> >               .max_level = KVM_MAX_HUGEPAGE_LEVEL,
> >               .req_level = PG_LEVEL_4K,
> >               .goal_level = PG_LEVEL_4K,
> > +             .is_private = IS_ENABLED(CONFIG_HAVE_KVM_PRIVATE_MEM_TESTING) && is_tdp &&
> > +                             kvm_mem_is_private(vcpu->kvm, cr2_or_gpa >> PAGE_SHIFT),
>
> After looking at the SNP+UPM series, I think we should forego a dedicated Kconfig
> for testing and instead add a new VM type for UPM-capable guests.  The new type,
> e.g. KVM_X86_PROTECTED_VM, can then be used to leverage UPM for "legacy" SEV and
> SEV-ES guests, as well as for UPM-capable guests that don't utilize per-VM
> memory encryption, e.g. KVM selftests.
>
> Carrying test-only behavior is obviously never ideal, and it would pretty much have
> to be mutually exclusive with "real" usage of UPM, otherwise the KVM logics gets
> unnecessarily complex.

Ack, the newly added VM type fits better here with SEV/SEV-ES and
non-confidential selftests being able to share this framework.
