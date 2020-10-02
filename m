Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B308281E0F
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Oct 2020 00:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725497AbgJBWLQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Oct 2020 18:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBWLQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Oct 2020 18:11:16 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E1EC0613E2
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Oct 2020 15:11:14 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q4so1855013pjh.5
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Oct 2020 15:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WqR15+53sxuwPJNhG7UG5UWNC8ykbQrWL0dbrlfLd84=;
        b=wBnJYdX3j0KvI3E9/Rv3G3+tTnUPNT62rSqh1h9uJYdXfWkoXgtnBi3r2c0RgQZBaj
         hXYD4KXVAkb3TtIecQSUfK8E+rOaJeIcpGnhbOHnRRkoROoDQ6QsKYfs820F/lJtrJu4
         wOW1c++5z3HL/lHdozDnipsC5a25lC1yIxwn0mq7w+rB9E8ph6gtmTgNvkTUErKL6dyM
         nF65kKXd92+bGYcJVHIwGkM8hD0ASRv0F2EtOvaDvWY277owNjtVgv+Xzoo/ML95+MrY
         lUYg2AeoJTWKjQ+xoVn8WWF0MLzKcqUJdkoK9hy3gUsPpTi9uyYxLX8qJEpkiGJb1Xjo
         W8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WqR15+53sxuwPJNhG7UG5UWNC8ykbQrWL0dbrlfLd84=;
        b=bB8MQJeg0TW/8ecRFHooM8eoKkH76aWK1byUf4GhRTQDxNLRSGSoVKbPFhqd0POclg
         aRkAYHUF7F2ra65EJ+AQXLHKoZq2TAzCwoxa4JnA+oZy1uNdzFgffCTAySKVv339gzSF
         pIuQUWV65ABYouEs9xGguJVdkfXpwiH5hAMMVxGyDcsaykuXMiHWlzJgVMEydiuAPLMd
         2Iyv+gvre//Tuk8jJCbQorRInDn6q1ARzc5Xrg7P/+RQHUIX4OoNfHv9GMMsTvafQC2s
         rHXoZzJqFERTWp0NFV2vh+fwOP2Ekf6Ps6PVuZjjoXuChwufOeTe3fcHSyrFzbUbJ7Hx
         CHzg==
X-Gm-Message-State: AOAM533Qz+lgR4OXQYbe2tJNz6x422cxLCFsYLeRp2lJlyixjpYgEcvU
        IT7Zz2LyBOBx1E7H6efsFMugGn8Mf5eoaAdH62KFsg==
X-Google-Smtp-Source: ABdhPJwgYFqygj8pPearJixSMqQnrivMy1i6q8vhwcRD1rwnPwoIp+QW6IC/yzGak0d5S1vN5XbAKzgnknx/iVB5i5M=
X-Received: by 2002:a17:90b:a53:: with SMTP id gw19mr4889507pjb.53.1601676673868;
 Fri, 02 Oct 2020 15:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20201002162101.665549-1-kaleshsingh@google.com>
 <20201002162101.665549-5-kaleshsingh@google.com> <20201002165202.qjthgret34qvh43d@black.fi.intel.com>
In-Reply-To: <20201002165202.qjthgret34qvh43d@black.fi.intel.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Fri, 2 Oct 2020 18:11:01 -0400
Message-ID: <CAC_TJvcd2NqhD9B3G8q9cEm1Sj=C-24MgQ5418ZEcR8+jNOOjQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] arm64: Add set_pud_at() function
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Mike Rapoport <rppt@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Steven Price <steven.price@arm.com>,
        Jia He <justin.he@arm.com>, Zhenyu Ye <yezhenyu2@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Mina Almasry <almasrymina@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Brian Geffon <bgeffon@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        SeongJae Park <sjpark@amazon.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 2, 2020 at 12:52 PM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Fri, Oct 02, 2020 at 04:20:49PM +0000, Kalesh Singh wrote:
> > set_pud_at() is used in move_normal_pud() for remapping
> > pages at the PUD level.
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >  arch/arm64/include/asm/pgtable.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> > index d5d3fbe73953..8848125e3024 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -415,6 +415,7 @@ static inline pmd_t pmd_mkdevmap(pmd_t pmd)
> >  #define pfn_pud(pfn,prot)    __pud(__phys_to_pud_val((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
> >
> >  #define set_pmd_at(mm, addr, pmdp, pmd)      set_pte_at(mm, addr, (pte_t *)pmdp, pmd_pte(pmd))
> > +#define set_pud_at(mm, addr, pudp, pud)      set_pte_at(mm, addr, (pte_t *)pudp, pud_pte(pud))
> >
> >  #define __p4d_to_phys(p4d)   __pte_to_phys(p4d_pte(p4d))
> >  #define __phys_to_p4d_val(phys)      __phys_to_pte_val(phys)
>
> Just fold it into the next patch.
Sounds good. I'll update in the next version. Thanks
>
> --
>  Kirill A. Shutemov
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
