Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6DE441F7F
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Nov 2021 18:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhKARqf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Nov 2021 13:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbhKARqe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Nov 2021 13:46:34 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75643C061766
        for <linux-kselftest@vger.kernel.org>; Mon,  1 Nov 2021 10:44:01 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id v138so40983181ybb.8
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Nov 2021 10:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Fmyu5Mn4i82cp8HMsdl33MAzo8mJP0Q39h/qUlCf0Q=;
        b=ZGLIjb6VJaU8wer4pug6zS3Pp/Ya9KByddsZSsXhikN90vlK5Kns3+32lBZMa+bhOG
         fqvbiUWC8nnj8k0LR7K7IEiuEpg1lLlGflHTVR7UGt+xZ1+lmdzZhgPDHgJojsBrR8/B
         F0+KKHEXD7BtVvxGO5lH7Pvexp9z8qPpqE9MGQaQ/AE3oQw4+XlQi6vKHVO3CP8rJlGK
         77mY/JwzORTKv+1glzTayTuswnAKEEjYhQRZl0VfmDq+sbuCfy66ohqVdsUspHBiAR/l
         mIBEGCaP0g628RohfMcrErdtaO4fvTLObe+0N1Wjg4i3SyTylaOEt9Q+q1K/CZcEErO+
         tJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Fmyu5Mn4i82cp8HMsdl33MAzo8mJP0Q39h/qUlCf0Q=;
        b=aKROJiRRFfsvlK9xnYZLGd4pK7CtA+E5mjw8mi4xLvlp1GhXbggx7yv6/mKrM1+9vR
         UP1xCu6BSCsmXrsLorc9SHrGk95O2NKlgQ58E1bfy1/JnewZYko1jnbsrwPNJa578wKs
         7inwJMtEQioTP7+NVuWQpWQ/XJkUYqLvFA2p9JqcqV3+f/SX5Jz6f1QkOA6Sg5CZ4Ni3
         Ho9f0upkcdSmIXMaPAcZD3A+Y2Ry5JtpOggqGtvRznKfgpU1OwIaKmu2onIMh4YfSLd5
         zV92Ppk6HI5xlGu8hzY/W+qTAS+ddx5wRpqZbgwPGqnwW5pmTLzFIf+keIhQDLGhEiaJ
         3m7Q==
X-Gm-Message-State: AOAM530AqFKbBk/B/19S4qR6NYk1EQOOEwxLXeZD+CuxQDT2FgFnOFPO
        Ep/n9jU31sFJZwjv05G93wpNHwthio3kw7Ptb/B/aw==
X-Google-Smtp-Source: ABdhPJy8yTlLWG4HgdFtxqaTwCWYlCCin5bPaCJr6rTK2yhMkgh4cmx6q7WO1dC/nFaHckuJT6sw6Twf/PBBdFf/KfE=
X-Received: by 2002:a25:3142:: with SMTP id x63mr31367323ybx.99.1635788639054;
 Mon, 01 Nov 2021 10:43:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211005234459.430873-1-michael.roth@amd.com> <20211005234459.430873-2-michael.roth@amd.com>
 <CAL715WK2toExGW7GGWGQyzhqBijMEhQfhamyb9_eZkrU=+LKnQ@mail.gmail.com>
 <20211021034529.gwv3hz5xhomtvnu7@amd.com> <CAL715W+PE1hGmxZfMc4oOm6dyNzCBmStnJzp-OyW6DdhNAmwjQ@mail.gmail.com>
In-Reply-To: <CAL715W+PE1hGmxZfMc4oOm6dyNzCBmStnJzp-OyW6DdhNAmwjQ@mail.gmail.com>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Mon, 1 Nov 2021 10:43:48 -0700
Message-ID: <CAL715W+q1NuV6vWGoK=ef==zLv26mTqbft6F5r=wFF81E+72tA@mail.gmail.com>
Subject: Re: [RFC 01/16] KVM: selftests: move vm_phy_pages_alloc() earlier in file
To:     Michael Roth <Michael.Roth@amd.com>
Cc:     linux-kselftest@vger.kernel.org, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Nathan Tempelman <natet@google.com>,
        Marc Orr <marcorr@google.com>,
        Steve Rutherford <srutherford@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Ricardo Koller <ricarkol@google.com>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 26, 2021 at 8:52 AM Mingwei Zhang <mizhang@google.com> wrote:
>
> On Wed, Oct 20, 2021 at 8:47 PM Michael Roth <michael.roth@amd.com> wrote:
> >
> > On Mon, Oct 18, 2021 at 08:00:00AM -0700, Mingwei Zhang wrote:
> > > On Tue, Oct 5, 2021 at 4:46 PM Michael Roth <michael.roth@amd.com> wrote:
> > > >
> > > > Subsequent patches will break some of this code out into file-local
> > > > helper functions, which will be used by functions like vm_vaddr_alloc(),
> > > > which currently are defined earlier in the file, so a forward
> > > > declaration would be needed.
> > > >
> > > > Instead, move it earlier in the file, just above vm_vaddr_alloc() and
> > > > and friends, which are the main users.
> > > >
> > > > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > > > ---
> > > >  tools/testing/selftests/kvm/lib/kvm_util.c | 146 ++++++++++-----------
> > > >  1 file changed, 73 insertions(+), 73 deletions(-)
> > > >
> > > > diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> > > > index 10a8ed691c66..92f59adddebe 100644
> > > > --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> > > > +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> > > > @@ -1145,6 +1145,79 @@ void vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid)
> > > >         list_add(&vcpu->list, &vm->vcpus);
> > > >  }
> > > >
> > > > +/*
> > > > + * Physical Contiguous Page Allocator
> > > > + *
> > > > + * Input Args:
> > > > + *   vm - Virtual Machine
> > > > + *   num - number of pages
> > > > + *   paddr_min - Physical address minimum
> > > > + *   memslot - Memory region to allocate page from
> > > > + *
> > > > + * Output Args: None
> > > > + *
> > > > + * Return:
> > > > + *   Starting physical address
> > > > + *
> > > > + * Within the VM specified by vm, locates a range of available physical
> > > > + * pages at or above paddr_min. If found, the pages are marked as in use
> > > > + * and their base address is returned. A TEST_ASSERT failure occurs if
> > > > + * not enough pages are available at or above paddr_min.
> > > > + */
> > > > +vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
> > > > +                             vm_paddr_t paddr_min, uint32_t memslot)
> > > > +{
> > > > +       struct userspace_mem_region *region;
> > > > +       sparsebit_idx_t pg, base;
> > > > +
> > > > +       TEST_ASSERT(num > 0, "Must allocate at least one page");
> > > > +
> > > > +       TEST_ASSERT((paddr_min % vm->page_size) == 0, "Min physical address "
> > > > +               "not divisible by page size.\n"
> > > > +               "  paddr_min: 0x%lx page_size: 0x%x",
> > > > +               paddr_min, vm->page_size);
> > > > +
> > > > +       region = memslot2region(vm, memslot);
> > > > +       base = pg = paddr_min >> vm->page_shift;
> > > > +
> > > > +       do {
> > > > +               for (; pg < base + num; ++pg) {
> > > > +                       if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
> > > > +                               base = pg = sparsebit_next_set(region->unused_phy_pages, pg);
> > > > +                               break;
> > > > +                       }
> > > > +               }
> > > > +       } while (pg && pg != base + num);
> > > > +
> > > > +       if (pg == 0) {
> > > > +               fprintf(stderr, "No guest physical page available, "
> > > > +                       "paddr_min: 0x%lx page_size: 0x%x memslot: %u\n",
> > > > +                       paddr_min, vm->page_size, memslot);
> > > > +               fputs("---- vm dump ----\n", stderr);
> > > > +               vm_dump(stderr, vm, 2);
> > > > +               abort();
> > > > +       }
> > > > +
> > > > +       for (pg = base; pg < base + num; ++pg)
> > > > +               sparsebit_clear(region->unused_phy_pages, pg);
> > > > +
> > > > +       return base * vm->page_size;
> > > > +}
> > > > +
> > > > +vm_paddr_t vm_phy_page_alloc(struct kvm_vm *vm, vm_paddr_t paddr_min,
> > > > +                            uint32_t memslot)
> > > > +{
> > > > +       return vm_phy_pages_alloc(vm, 1, paddr_min, memslot);
> > > > +}
> > > > +
> > > > +/* Arbitrary minimum physical address used for virtual translation tables. */
> > > > +#define KVM_GUEST_PAGE_TABLE_MIN_PADDR 0x180000
> > > > +
> > > > +vm_paddr_t vm_alloc_page_table(struct kvm_vm *vm)
> > > > +{
> > > > +       return vm_phy_page_alloc(vm, KVM_GUEST_PAGE_TABLE_MIN_PADDR, 0);
> > > > +}
> > > > +
> > > >  /*
> > > >   * VM Virtual Address Unused Gap
> > > >   *
> > > > @@ -2149,79 +2222,6 @@ const char *exit_reason_str(unsigned int exit_reason)
> > > >         return "Unknown";
> > > >  }
> > > >
> > > > -/*
> > > > - * Physical Contiguous Page Allocator
> > > > - *
> > > > - * Input Args:
> > > > - *   vm - Virtual Machine
> > > > - *   num - number of pages
> > > > - *   paddr_min - Physical address minimum
> > > > - *   memslot - Memory region to allocate page from
> > > > - *
> > > > - * Output Args: None
> > > > - *
> > > > - * Return:
> > > > - *   Starting physical address
> > > > - *
> > > > - * Within the VM specified by vm, locates a range of available physical
> > > > - * pages at or above paddr_min. If found, the pages are marked as in use
> > > > - * and their base address is returned. A TEST_ASSERT failure occurs if
> > > > - * not enough pages are available at or above paddr_min.
> > > > - */
> > > > -vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
> > > > -                             vm_paddr_t paddr_min, uint32_t memslot)
> > > > -{
> > > > -       struct userspace_mem_region *region;
> > > > -       sparsebit_idx_t pg, base;
> > > > -
> > > > -       TEST_ASSERT(num > 0, "Must allocate at least one page");
> > > > -
> > > > -       TEST_ASSERT((paddr_min % vm->page_size) == 0, "Min physical address "
> > > > -               "not divisible by page size.\n"
> > > > -               "  paddr_min: 0x%lx page_size: 0x%x",
> > > > -               paddr_min, vm->page_size);
> > > > -
> > > > -       region = memslot2region(vm, memslot);
> > > > -       base = pg = paddr_min >> vm->page_shift;
> > > > -
> > > > -       do {
> > > > -               for (; pg < base + num; ++pg) {
> > > > -                       if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
> > > > -                               base = pg = sparsebit_next_set(region->unused_phy_pages, pg);
> > > > -                               break;
> > > > -                       }
> > > > -               }
> > > > -       } while (pg && pg != base + num);
> > > > -
> > > > -       if (pg == 0) {
> > > > -               fprintf(stderr, "No guest physical page available, "
> > > > -                       "paddr_min: 0x%lx page_size: 0x%x memslot: %u\n",
> > > > -                       paddr_min, vm->page_size, memslot);
> > > > -               fputs("---- vm dump ----\n", stderr);
> > > > -               vm_dump(stderr, vm, 2);
> > > > -               abort();
> > > > -       }
> > > > -
> > > > -       for (pg = base; pg < base + num; ++pg)
> > > > -               sparsebit_clear(region->unused_phy_pages, pg);
> > > > -
> > > > -       return base * vm->page_size;
> > > > -}
> > > > -
> > > > -vm_paddr_t vm_phy_page_alloc(struct kvm_vm *vm, vm_paddr_t paddr_min,
> > > > -                            uint32_t memslot)
> > > > -{
> > > > -       return vm_phy_pages_alloc(vm, 1, paddr_min, memslot);
> > > > -}
> > > > -
> > > > -/* Arbitrary minimum physical address used for virtual translation tables. */
> > > > -#define KVM_GUEST_PAGE_TABLE_MIN_PADDR 0x180000
> > > > -
> > > > -vm_paddr_t vm_alloc_page_table(struct kvm_vm *vm)
> > > > -{
> > > > -       return vm_phy_page_alloc(vm, KVM_GUEST_PAGE_TABLE_MIN_PADDR, 0);
> > > > -}
> > > > -
> > > >  /*
> > > >   * Address Guest Virtual to Host Virtual
> > > >   *
> > > > --
> > > > 2.25.1
> > > >
> > >
> > > Why move the function implementation? Maybe just adding a declaration
> > > at the top of kvm_util.c should suffice.
> >
> > At least from working on other projects I'd gotten the impression that
> > forward function declarations should be avoided if they can be solved by
> > moving the function above the caller. Certainly don't mind taking your
> > suggestion and dropping this patch if that's not the case here though.
>
> Understood. Yes, I think it would be better to follow your experience
> then. I was thinking that if you move the code and then potentially
> git blame on that function might point to you :)
>
> Thanks.
> -Mingwei


Reviewed-by: Mingwei Zhang <mizhang@google.com>

Thanks.
-Mingwei
