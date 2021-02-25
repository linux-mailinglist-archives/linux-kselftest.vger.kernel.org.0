Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8738D325A66
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Feb 2021 00:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbhBYXrl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 Feb 2021 18:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbhBYXqW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 Feb 2021 18:46:22 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8522AC06178B
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Feb 2021 15:45:26 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id d5so6539130iln.6
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Feb 2021 15:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vrszq5gHGap3Ga7KBY8i2VMSG41dYORDbuUui0l8S80=;
        b=MdbI32UIQbnzFUn/KLKTOeTY888IaQWsiBYInWsaKps44u3O/v6rz/hZTJMdAU5TrR
         FH0V9U4o/erRKAfFYkjO31p7hUsh4+IwnFTAs2fOMup9rJ49tXry+KYO5Hu8lD2YiIqR
         fhVlrBm/6rXyPWbH6qNmdmDX3+HQ6vyXYiURL11uPPLYL7B6E0Q/KOggYehiF2C8EIII
         9J9YzeBdIov9GgPuAvSjNownfUAVTHfduzvTJzo0jzll3ARJedlG6t6Da2qQ0CTH7oud
         HRzbeiZ8ybL7xtDaYJsZEDgDAzpN6fjpn+wIuM+qTuk+8m8laq8YdgZfsonhutWNV/pm
         39rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vrszq5gHGap3Ga7KBY8i2VMSG41dYORDbuUui0l8S80=;
        b=nLXIN4KTCBGgeV1BCJMK9tkcRuKI7GYeAj9tY5gzj/E2KwBMLKbcF3oKlkVVHj9D1E
         YBqn46A0rClWHgITl2ejTgI9sszYAguqb47qaPcw9ErGPLqxAtJipZ0UUef/1sinJM7f
         xG4fJjemF2oT0AdQ1StAwfBeYvuDWPu8ur+ZHOnRW2m7LC9nQnLp/zoCMuZ+HdVztxbn
         paL8bWs6TadYgoEPgvFRmgyCBgpBTY8iffz/4TZDjXCRnejSTgZS6nnW4jaJYrzembC9
         BXIjUPo3H/MucxJP1IbueelG4YkoHzrWeuBYi+iqEOY2e/EOJcgNMNo6NGC9RtqiFajZ
         djeQ==
X-Gm-Message-State: AOAM530MZcpCo6y69DJLiTOmyQkhLYdqgsCVlc9csx0duY+5NSv4i6Ai
        rZv/bUM7gdmthM/nswuXHp2sZSVvnyzckXK6Vunhxgknbiw=
X-Google-Smtp-Source: ABdhPJxHNvKHDpF9JxpytLO8SkPIAYchHYa1lAMgnpA8IyvVVy8KmCOnh3YK8XJpaUxWUYkciTXAsLIf0jg1FErdb00=
X-Received: by 2002:a92:6408:: with SMTP id y8mr128098ilb.203.1614296725854;
 Thu, 25 Feb 2021 15:45:25 -0800 (PST)
MIME-Version: 1.0
References: <20210225055940.18748-1-wangyanan55@huawei.com>
In-Reply-To: <20210225055940.18748-1-wangyanan55@huawei.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Thu, 25 Feb 2021 15:45:14 -0800
Message-ID: <CANgfPd-q=WNmJj95OJhWSERvwihtgkhxXZ_BoUSkhXwW8E3A1w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/7] Some improvement and a new test for kvm page table
To:     Yanan Wang <wangyanan55@huawei.com>
Cc:     kvm <kvm@vger.kernel.org>, linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Peter Xu <peterx@redhat.com>, Marc Zyngier <maz@kernel.org>,
        wanghaibin.wang@huawei.com, yuzenghui@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 24, 2021 at 9:59 PM Yanan Wang <wangyanan55@huawei.com> wrote:
>
> Hi,
> This v2 series can mainly include two parts.
> Based on kvm queue branch: https://git.kernel.org/pub/scm/virt/kvm/kvm.git/log/?h=queue
> Links of v1: https://lore.kernel.org/lkml/20210208090841.333724-1-wangyanan55@huawei.com/
>
> In the first part, all the known hugetlb backing src types specified
> with different hugepage sizes are listed, so that we can specify use
> of hugetlb source of the exact granularity that we want, instead of
> the system default ones. And as all the known hugetlb page sizes are
> listed, it's appropriate for all architectures. Besides, a helper that
> can get granularity of different backing src types(anonumous/thp/hugetlb)
> is added, so that we can use the accurate backing src granularity for
> kinds of alignment or guest memory accessing of vcpus.
>
> In the second part, a new test is added:
> This test is added to serve as a performance tester and a bug reproducer
> for kvm page table code (GPA->HPA mappings), it gives guidance for the
> people trying to make some improvement for kvm. And the following explains
> what we can exactly do through this test.
>
> The function guest_code() can cover the conditions where a single vcpu or
> multiple vcpus access guest pages within the same memory region, in three
> VM stages(before dirty logging, during dirty logging, after dirty logging).
> Besides, the backing src memory type(ANONYMOUS/THP/HUGETLB) of the tested
> memory region can be specified by users, which means normal page mappings
> or block mappings can be chosen by users to be created in the test.
>
> If ANONYMOUS memory is specified, kvm will create normal page mappings
> for the tested memory region before dirty logging, and update attributes
> of the page mappings from RO to RW during dirty logging. If THP/HUGETLB
> memory is specified, kvm will create block mappings for the tested memory
> region before dirty logging, and split the blcok mappings into normal page
> mappings during dirty logging, and coalesce the page mappings back into
> block mappings after dirty logging is stopped.
>
> So in summary, as a performance tester, this test can present the
> performance of kvm creating/updating normal page mappings, or the
> performance of kvm creating/splitting/recovering block mappings,
> through execution time.
>
> When we need to coalesce the page mappings back to block mappings after
> dirty logging is stopped, we have to firstly invalidate *all* the TLB
> entries for the page mappings right before installation of the block entry,
> because a TLB conflict abort error could occur if we can't invalidate the
> TLB entries fully. We have hit this TLB conflict twice on aarch64 software
> implementation and fixed it. As this test can imulate process from dirty
> logging enabled to dirty logging stopped of a VM with block mappings,
> so it can also reproduce this TLB conflict abort due to inadequate TLB
> invalidation when coalescing tables.
>
> Links about the TLB conflict abort:
> https://lore.kernel.org/lkml/20201201201034.116760-3-wangyanan55@huawei.com/

Besides a few style / readability comments, this series looks good to
me. Thanks for generalizing the way these selftests handle different
hugeTLB sizes!


>
> Yanan Wang (7):
>   tools include: sync head files of mmap flag encodings about hugetlb
>   KVM: selftests: Use flag CLOCK_MONOTONIC_RAW for timing
>   KVM: selftests: Make a generic helper to get vm guest mode strings
>   KVM: selftests: Add a helper to get system configured THP page size
>   KVM: selftests: List all hugetlb src types specified with page sizes
>   KVM: selftests: Adapt vm_userspace_mem_region_add to new helpers
>   KVM: selftests: Add a test for kvm page table code
>
>  tools/include/asm-generic/hugetlb_encode.h    |   3 +
>  tools/testing/selftests/kvm/Makefile          |   3 +
>  .../selftests/kvm/demand_paging_test.c        |   8 +-
>  .../selftests/kvm/dirty_log_perf_test.c       |  14 +-
>  .../testing/selftests/kvm/include/kvm_util.h  |   4 +-
>  .../testing/selftests/kvm/include/test_util.h |  21 +-
>  .../selftests/kvm/kvm_page_table_test.c       | 476 ++++++++++++++++++
>  tools/testing/selftests/kvm/lib/kvm_util.c    |  58 +--
>  tools/testing/selftests/kvm/lib/test_util.c   |  92 +++-
>  tools/testing/selftests/kvm/steal_time.c      |   4 +-
>  10 files changed, 623 insertions(+), 60 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/kvm_page_table_test.c
>
> --
> 2.19.1
>
