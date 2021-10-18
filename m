Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6954743215B
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Oct 2021 17:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbhJRPDD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Oct 2021 11:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbhJRPC5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Oct 2021 11:02:57 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35168C06176E
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Oct 2021 08:00:46 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id s64so3427289yba.11
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Oct 2021 08:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MMmlS+/+SZBwSSXsxt9wumzVOo1h71EHizXwQ2Vozuo=;
        b=SmebFWraC7SAK1xLKjsSIT8mMTsCqEVoOtApUR9cVOSqesBlAzVr9ZRPd9Qr/Z9wAt
         v4ZMzZ6zaNPvNGVVRnUYcUKFARIQy+D26VCmtBh6h4IOMfzuta8J7PAfBpsOrGRyeQs/
         VgsW09h/Jieuphcvvs70S/rSgY8p15CZooeFXVTyWx30T3dyXUh11IJv+piRWfCmW/re
         FDJCDI3jrGPCwIRuJkYEsK88uEN0isKnoh1BWM7R+j7wHtv48ltH0tDFt+3IZsF46Djr
         G4XCz3N06BlUDSQEnpfBOptX4oEwODFhygDrCqsDJVtknk+JMXY1evtb4WBIiihITtjP
         Y8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MMmlS+/+SZBwSSXsxt9wumzVOo1h71EHizXwQ2Vozuo=;
        b=5hIUP1DsDc9fkYN08L4IV3sTuY8x2KW+qBtB4/+wwF21Asb931B5CgqVytlHg+DCLp
         V/A7+jKjEWPbNp3ZCgaH+SI/xruN9BVxmC0xhoT2Bfh9yyhbq5jho/ug7SyfFGoL6I9z
         jtLd+5hEpMWghqjH6V9N0iwBgflXUVOVtz8PfK34RZYqYpFXnrwAZny491akq+Z43NE5
         cHW9CdSO1erpdBj1kyBsk3ipu8QNsw2EybAIydM0pbm/eH3kuiM1XVpV2690UlcC46Dg
         YcmrmBK6uSVNoXOqQ7KS+fu8hlZIqcs5aMQBCwFLbczGliGd1llRG5n37PouhMvLgpzC
         qTGg==
X-Gm-Message-State: AOAM533020pAoHhp9W+nxS44URNDgTq4/PrYGiCgm9ho5KcHs4trBx4Q
        cgk9Jti7qrlk2bWnedsyzBp86OO4ephktkpqyl3q6wYdz3ST2A==
X-Google-Smtp-Source: ABdhPJzRoowO7+zNqfQT24KNvrBIPvwss7R36nX75ede2DLZ0sayOu/TPWO9clhq5tszbpbNPq1ltf6pQSCBuIpjfqc=
X-Received: by 2002:a25:6405:: with SMTP id y5mr3035764ybb.0.1634569245046;
 Mon, 18 Oct 2021 08:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211005234459.430873-1-michael.roth@amd.com> <20211005234459.430873-2-michael.roth@amd.com>
In-Reply-To: <20211005234459.430873-2-michael.roth@amd.com>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Mon, 18 Oct 2021 08:00:00 -0700
Message-ID: <CAL715WK2toExGW7GGWGQyzhqBijMEhQfhamyb9_eZkrU=+LKnQ@mail.gmail.com>
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

On Tue, Oct 5, 2021 at 4:46 PM Michael Roth <michael.roth@amd.com> wrote:
>
> Subsequent patches will break some of this code out into file-local
> helper functions, which will be used by functions like vm_vaddr_alloc(),
> which currently are defined earlier in the file, so a forward
> declaration would be needed.
>
> Instead, move it earlier in the file, just above vm_vaddr_alloc() and
> and friends, which are the main users.
>
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c | 146 ++++++++++-----------
>  1 file changed, 73 insertions(+), 73 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 10a8ed691c66..92f59adddebe 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1145,6 +1145,79 @@ void vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid)
>         list_add(&vcpu->list, &vm->vcpus);
>  }
>
> +/*
> + * Physical Contiguous Page Allocator
> + *
> + * Input Args:
> + *   vm - Virtual Machine
> + *   num - number of pages
> + *   paddr_min - Physical address minimum
> + *   memslot - Memory region to allocate page from
> + *
> + * Output Args: None
> + *
> + * Return:
> + *   Starting physical address
> + *
> + * Within the VM specified by vm, locates a range of available physical
> + * pages at or above paddr_min. If found, the pages are marked as in use
> + * and their base address is returned. A TEST_ASSERT failure occurs if
> + * not enough pages are available at or above paddr_min.
> + */
> +vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
> +                             vm_paddr_t paddr_min, uint32_t memslot)
> +{
> +       struct userspace_mem_region *region;
> +       sparsebit_idx_t pg, base;
> +
> +       TEST_ASSERT(num > 0, "Must allocate at least one page");
> +
> +       TEST_ASSERT((paddr_min % vm->page_size) == 0, "Min physical address "
> +               "not divisible by page size.\n"
> +               "  paddr_min: 0x%lx page_size: 0x%x",
> +               paddr_min, vm->page_size);
> +
> +       region = memslot2region(vm, memslot);
> +       base = pg = paddr_min >> vm->page_shift;
> +
> +       do {
> +               for (; pg < base + num; ++pg) {
> +                       if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
> +                               base = pg = sparsebit_next_set(region->unused_phy_pages, pg);
> +                               break;
> +                       }
> +               }
> +       } while (pg && pg != base + num);
> +
> +       if (pg == 0) {
> +               fprintf(stderr, "No guest physical page available, "
> +                       "paddr_min: 0x%lx page_size: 0x%x memslot: %u\n",
> +                       paddr_min, vm->page_size, memslot);
> +               fputs("---- vm dump ----\n", stderr);
> +               vm_dump(stderr, vm, 2);
> +               abort();
> +       }
> +
> +       for (pg = base; pg < base + num; ++pg)
> +               sparsebit_clear(region->unused_phy_pages, pg);
> +
> +       return base * vm->page_size;
> +}
> +
> +vm_paddr_t vm_phy_page_alloc(struct kvm_vm *vm, vm_paddr_t paddr_min,
> +                            uint32_t memslot)
> +{
> +       return vm_phy_pages_alloc(vm, 1, paddr_min, memslot);
> +}
> +
> +/* Arbitrary minimum physical address used for virtual translation tables. */
> +#define KVM_GUEST_PAGE_TABLE_MIN_PADDR 0x180000
> +
> +vm_paddr_t vm_alloc_page_table(struct kvm_vm *vm)
> +{
> +       return vm_phy_page_alloc(vm, KVM_GUEST_PAGE_TABLE_MIN_PADDR, 0);
> +}
> +
>  /*
>   * VM Virtual Address Unused Gap
>   *
> @@ -2149,79 +2222,6 @@ const char *exit_reason_str(unsigned int exit_reason)
>         return "Unknown";
>  }
>
> -/*
> - * Physical Contiguous Page Allocator
> - *
> - * Input Args:
> - *   vm - Virtual Machine
> - *   num - number of pages
> - *   paddr_min - Physical address minimum
> - *   memslot - Memory region to allocate page from
> - *
> - * Output Args: None
> - *
> - * Return:
> - *   Starting physical address
> - *
> - * Within the VM specified by vm, locates a range of available physical
> - * pages at or above paddr_min. If found, the pages are marked as in use
> - * and their base address is returned. A TEST_ASSERT failure occurs if
> - * not enough pages are available at or above paddr_min.
> - */
> -vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
> -                             vm_paddr_t paddr_min, uint32_t memslot)
> -{
> -       struct userspace_mem_region *region;
> -       sparsebit_idx_t pg, base;
> -
> -       TEST_ASSERT(num > 0, "Must allocate at least one page");
> -
> -       TEST_ASSERT((paddr_min % vm->page_size) == 0, "Min physical address "
> -               "not divisible by page size.\n"
> -               "  paddr_min: 0x%lx page_size: 0x%x",
> -               paddr_min, vm->page_size);
> -
> -       region = memslot2region(vm, memslot);
> -       base = pg = paddr_min >> vm->page_shift;
> -
> -       do {
> -               for (; pg < base + num; ++pg) {
> -                       if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
> -                               base = pg = sparsebit_next_set(region->unused_phy_pages, pg);
> -                               break;
> -                       }
> -               }
> -       } while (pg && pg != base + num);
> -
> -       if (pg == 0) {
> -               fprintf(stderr, "No guest physical page available, "
> -                       "paddr_min: 0x%lx page_size: 0x%x memslot: %u\n",
> -                       paddr_min, vm->page_size, memslot);
> -               fputs("---- vm dump ----\n", stderr);
> -               vm_dump(stderr, vm, 2);
> -               abort();
> -       }
> -
> -       for (pg = base; pg < base + num; ++pg)
> -               sparsebit_clear(region->unused_phy_pages, pg);
> -
> -       return base * vm->page_size;
> -}
> -
> -vm_paddr_t vm_phy_page_alloc(struct kvm_vm *vm, vm_paddr_t paddr_min,
> -                            uint32_t memslot)
> -{
> -       return vm_phy_pages_alloc(vm, 1, paddr_min, memslot);
> -}
> -
> -/* Arbitrary minimum physical address used for virtual translation tables. */
> -#define KVM_GUEST_PAGE_TABLE_MIN_PADDR 0x180000
> -
> -vm_paddr_t vm_alloc_page_table(struct kvm_vm *vm)
> -{
> -       return vm_phy_page_alloc(vm, KVM_GUEST_PAGE_TABLE_MIN_PADDR, 0);
> -}
> -
>  /*
>   * Address Guest Virtual to Host Virtual
>   *
> --
> 2.25.1
>

Why move the function implementation? Maybe just adding a declaration
at the top of kvm_util.c should suffice.
