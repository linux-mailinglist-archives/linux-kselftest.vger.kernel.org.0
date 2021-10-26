Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADBAF43B621
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Oct 2021 17:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbhJZPze (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Oct 2021 11:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237139AbhJZPza (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Oct 2021 11:55:30 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B2AC061745
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Oct 2021 08:52:41 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id i65so35318739ybb.2
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Oct 2021 08:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/sasRfabbPuEjBen+tyWL4c0tyBTfXF/+shmskjClrw=;
        b=JwYkC6CWUO/oqH+2cIkcp0Z43KZbcu5vi0cjuGIWT/T7FJFLm1deKl7LB6dPXtLSvB
         uBCeXwxkIlK/DE26TcjF5NDD7cbDAGXCpVSWdxPxXd8O1ofj1CiBmUk37RGK83LEo9Ws
         P81FPMZrlHUDo23Ne5zY6nkyJRyjn48eTtoLf/fZP3HK1H+RLJZkJeoGSyR4Ggyz+fC8
         I38s5iInh8DfmRhHukanb4QaPRe3D8zlnDcLFhIEz0ScYiICxAX8BnstOyxVI1zjm7Qp
         Ziy1Kw5u5Jt2joDt2nGPcukBx48gO3T8WGxZmZ3gYsb12vEwDv5+UfnJFsPyHYt6BDS0
         W7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/sasRfabbPuEjBen+tyWL4c0tyBTfXF/+shmskjClrw=;
        b=kw/3WrWw8RIl2yF2WP9NzXQ/nuCwkCKCSc5CSqTrCEuODh34OZe97Xwt2WL6rttKTk
         qS1zTansBcUZBIBn15eysUaBgY/KDY4KOlqBxbM9XHR0L9uuoZ+DmHgOgal0uu8SLYuh
         pRHAvqT/37b0/3Er2q6M3Dx1S57XrIbOTgXvDv+Daf9sqz7XzvEKYCoIXatRaiHKzHpK
         Kmk7PiY6+Qf5HgZM+0wAKCXTFvt+W21TPjPpp4ELy8rT/Hc7dDPyjQ3R36lg0Lpxt9Ag
         XGctDVjTPgHg0p6sVLv/IcuePGfyoEu2woPzR6WIsgMJl+RX0XCgibsXAs8FuvByYjnC
         x8Ag==
X-Gm-Message-State: AOAM532UgPLVXicl0qgEJXsLdKB9qPeHBxBDUgvaiFYD8BFPAFXp7ztQ
        EoS+adM4KqZM0VEe73BHkJ9X5m/djvrBLabkOkRAgA==
X-Google-Smtp-Source: ABdhPJyBDuC69bwxJ5kEJFcWiDOSowL08nmwikSLFscBvcyZcDXqdIUQNZrTfmI8kCafXhhd26aAAdZaXiagnuUSIdc=
X-Received: by 2002:a25:3142:: with SMTP id x63mr23679155ybx.99.1635263560527;
 Tue, 26 Oct 2021 08:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <20211005234459.430873-1-michael.roth@amd.com> <20211005234459.430873-2-michael.roth@amd.com>
 <CAL715WK2toExGW7GGWGQyzhqBijMEhQfhamyb9_eZkrU=+LKnQ@mail.gmail.com> <20211021034529.gwv3hz5xhomtvnu7@amd.com>
In-Reply-To: <20211021034529.gwv3hz5xhomtvnu7@amd.com>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Tue, 26 Oct 2021 08:52:29 -0700
Message-ID: <CAL715W+PE1hGmxZfMc4oOm6dyNzCBmStnJzp-OyW6DdhNAmwjQ@mail.gmail.com>
Subject: Re: [RFC 01/16] KVM: selftests: move vm_phy_pages_alloc() earlier in file
To:     Michael Roth <michael.roth@amd.com>
Cc:     linux-kselftest@vger.kernel.org, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Nathan Tempelman <natet@google.com>,
        Marc Orr <marcorr@google.com>,
        Steve Rutherford <srutherford@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
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

On Wed, Oct 20, 2021 at 8:47 PM Michael Roth <michael.roth@amd.com> wrote:
>
> On Mon, Oct 18, 2021 at 08:00:00AM -0700, Mingwei Zhang wrote:
> > On Tue, Oct 5, 2021 at 4:46 PM Michael Roth <michael.roth@amd.com> wrote:
> > >
> > > Subsequent patches will break some of this code out into file-local
> > > helper functions, which will be used by functions like vm_vaddr_alloc(),
> > > which currently are defined earlier in the file, so a forward
> > > declaration would be needed.
> > >
> > > Instead, move it earlier in the file, just above vm_vaddr_alloc() and
> > > and friends, which are the main users.
> > >
> > > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > > ---
> > >  tools/testing/selftests/kvm/lib/kvm_util.c | 146 ++++++++++-----------
> > >  1 file changed, 73 insertions(+), 73 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> > > index 10a8ed691c66..92f59adddebe 100644
> > > --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> > > +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> > > @@ -1145,6 +1145,79 @@ void vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid)
> > >         list_add(&vcpu->list, &vm->vcpus);
> > >  }
> > >
> > > +/*
> > > + * Physical Contiguous Page Allocator
> > > + *
> > > + * Input Args:
> > > + *   vm - Virtual Machine
> > > + *   num - number of pages
> > > + *   paddr_min - Physical address minimum
> > > + *   memslot - Memory region to allocate page from
> > > + *
> > > + * Output Args: None
> > > + *
> > > + * Return:
> > > + *   Starting physical address
> > > + *
> > > + * Within the VM specified by vm, locates a range of available physical
> > > + * pages at or above paddr_min. If found, the pages are marked as in use
> > > + * and their base address is returned. A TEST_ASSERT failure occurs if
> > > + * not enough pages are available at or above paddr_min.
> > > + */
> > > +vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
> > > +                             vm_paddr_t paddr_min, uint32_t memslot)
> > > +{
> > > +       struct userspace_mem_region *region;
> > > +       sparsebit_idx_t pg, base;
> > > +
> > > +       TEST_ASSERT(num > 0, "Must allocate at least one page");
> > > +
> > > +       TEST_ASSERT((paddr_min % vm->page_size) == 0, "Min physical address "
> > > +               "not divisible by page size.\n"
> > > +               "  paddr_min: 0x%lx page_size: 0x%x",
> > > +               paddr_min, vm->page_size);
> > > +
> > > +       region = memslot2region(vm, memslot);
> > > +       base = pg = paddr_min >> vm->page_shift;
> > > +
> > > +       do {
> > > +               for (; pg < base + num; ++pg) {
> > > +                       if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
> > > +                               base = pg = sparsebit_next_set(region->unused_phy_pages, pg);
> > > +                               break;
> > > +                       }
> > > +               }
> > > +       } while (pg && pg != base + num);
> > > +
> > > +       if (pg == 0) {
> > > +               fprintf(stderr, "No guest physical page available, "
> > > +                       "paddr_min: 0x%lx page_size: 0x%x memslot: %u\n",
> > > +                       paddr_min, vm->page_size, memslot);
> > > +               fputs("---- vm dump ----\n", stderr);
> > > +               vm_dump(stderr, vm, 2);
> > > +               abort();
> > > +       }
> > > +
> > > +       for (pg = base; pg < base + num; ++pg)
> > > +               sparsebit_clear(region->unused_phy_pages, pg);
> > > +
> > > +       return base * vm->page_size;
> > > +}
> > > +
> > > +vm_paddr_t vm_phy_page_alloc(struct kvm_vm *vm, vm_paddr_t paddr_min,
> > > +                            uint32_t memslot)
> > > +{
> > > +       return vm_phy_pages_alloc(vm, 1, paddr_min, memslot);
> > > +}
> > > +
> > > +/* Arbitrary minimum physical address used for virtual translation tables. */
> > > +#define KVM_GUEST_PAGE_TABLE_MIN_PADDR 0x180000
> > > +
> > > +vm_paddr_t vm_alloc_page_table(struct kvm_vm *vm)
> > > +{
> > > +       return vm_phy_page_alloc(vm, KVM_GUEST_PAGE_TABLE_MIN_PADDR, 0);
> > > +}
> > > +
> > >  /*
> > >   * VM Virtual Address Unused Gap
> > >   *
> > > @@ -2149,79 +2222,6 @@ const char *exit_reason_str(unsigned int exit_reason)
> > >         return "Unknown";
> > >  }
> > >
> > > -/*
> > > - * Physical Contiguous Page Allocator
> > > - *
> > > - * Input Args:
> > > - *   vm - Virtual Machine
> > > - *   num - number of pages
> > > - *   paddr_min - Physical address minimum
> > > - *   memslot - Memory region to allocate page from
> > > - *
> > > - * Output Args: None
> > > - *
> > > - * Return:
> > > - *   Starting physical address
> > > - *
> > > - * Within the VM specified by vm, locates a range of available physical
> > > - * pages at or above paddr_min. If found, the pages are marked as in use
> > > - * and their base address is returned. A TEST_ASSERT failure occurs if
> > > - * not enough pages are available at or above paddr_min.
> > > - */
> > > -vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
> > > -                             vm_paddr_t paddr_min, uint32_t memslot)
> > > -{
> > > -       struct userspace_mem_region *region;
> > > -       sparsebit_idx_t pg, base;
> > > -
> > > -       TEST_ASSERT(num > 0, "Must allocate at least one page");
> > > -
> > > -       TEST_ASSERT((paddr_min % vm->page_size) == 0, "Min physical address "
> > > -               "not divisible by page size.\n"
> > > -               "  paddr_min: 0x%lx page_size: 0x%x",
> > > -               paddr_min, vm->page_size);
> > > -
> > > -       region = memslot2region(vm, memslot);
> > > -       base = pg = paddr_min >> vm->page_shift;
> > > -
> > > -       do {
> > > -               for (; pg < base + num; ++pg) {
> > > -                       if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
> > > -                               base = pg = sparsebit_next_set(region->unused_phy_pages, pg);
> > > -                               break;
> > > -                       }
> > > -               }
> > > -       } while (pg && pg != base + num);
> > > -
> > > -       if (pg == 0) {
> > > -               fprintf(stderr, "No guest physical page available, "
> > > -                       "paddr_min: 0x%lx page_size: 0x%x memslot: %u\n",
> > > -                       paddr_min, vm->page_size, memslot);
> > > -               fputs("---- vm dump ----\n", stderr);
> > > -               vm_dump(stderr, vm, 2);
> > > -               abort();
> > > -       }
> > > -
> > > -       for (pg = base; pg < base + num; ++pg)
> > > -               sparsebit_clear(region->unused_phy_pages, pg);
> > > -
> > > -       return base * vm->page_size;
> > > -}
> > > -
> > > -vm_paddr_t vm_phy_page_alloc(struct kvm_vm *vm, vm_paddr_t paddr_min,
> > > -                            uint32_t memslot)
> > > -{
> > > -       return vm_phy_pages_alloc(vm, 1, paddr_min, memslot);
> > > -}
> > > -
> > > -/* Arbitrary minimum physical address used for virtual translation tables. */
> > > -#define KVM_GUEST_PAGE_TABLE_MIN_PADDR 0x180000
> > > -
> > > -vm_paddr_t vm_alloc_page_table(struct kvm_vm *vm)
> > > -{
> > > -       return vm_phy_page_alloc(vm, KVM_GUEST_PAGE_TABLE_MIN_PADDR, 0);
> > > -}
> > > -
> > >  /*
> > >   * Address Guest Virtual to Host Virtual
> > >   *
> > > --
> > > 2.25.1
> > >
> >
> > Why move the function implementation? Maybe just adding a declaration
> > at the top of kvm_util.c should suffice.
>
> At least from working on other projects I'd gotten the impression that
> forward function declarations should be avoided if they can be solved by
> moving the function above the caller. Certainly don't mind taking your
> suggestion and dropping this patch if that's not the case here though.

Understood. Yes, I think it would be better to follow your experience
then. I was thinking that if you move the code and then potentially
git blame on that function might point to you :)

Thanks.
-Mingwei
