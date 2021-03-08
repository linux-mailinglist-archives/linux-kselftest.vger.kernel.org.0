Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2CE133184F
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Mar 2021 21:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhCHUSf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Mar 2021 15:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhCHUSc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Mar 2021 15:18:32 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA326C06174A;
        Mon,  8 Mar 2021 12:18:31 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id h10so16664363edl.6;
        Mon, 08 Mar 2021 12:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xEus+DE8Y+6Hz6uQIfLVbNTiNLnC290XtZObCVJPizs=;
        b=EUVXoExh+Sb7GQH0WJBF5KGZnJitXfHwiaDIy6OqIYHVHSMsE6NID/Dk7v9elZrL6n
         zdORUiumYCV3BCuMKSntef+syeMrVg9KsSwm3StkbqdR7HZE/Pad+HWOWrBkOfg8L5+8
         i82xbDS+amkMh/WqZG1p70eWrMvppel8joPTAj7xLH56LXvjv0j8n5j78N8K02pI2Jw8
         OyK5PQVFDWKWJouNCkY8vat1MWuDI/Z+Zqbk295UzLnV9GB0JJeqpM0hQ0xxVvZ6nPG3
         xhTCmGExBmO2TN9GT/YUXdQZ13BADFWkSOGKe0QAwqGJ+luzfvs5UnkxxWLYzlWrzCQ2
         5UGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xEus+DE8Y+6Hz6uQIfLVbNTiNLnC290XtZObCVJPizs=;
        b=kpKa4bXenBLoVTkcCHCeLZkD1aLOXyZttmUFGFZvhdjYOyTm2ihksvOLkb61srK4MQ
         g3lLhrTqBMLVz2f82i8LssYwqRolmTiFDfLDxxybhlHfGty4Q9KGIrm+cHCLdfMFG20U
         NEPEzyrW1KmnyVNC2oQr9ElUgHeGts1SLuaL8dSAOTQJriW77MhDyk84SjRQ6bI+fU4g
         zaNrOy3OSwiEBhFgJbnmEGiL6YlXx2dZ37Pvonbb1XNnToFDG68AX3Z8UZqh0f/tGGiy
         wvCgDqVzyK6B8oqHcQSs9Ypy6sMzflZh9/3veiL70sNnHpCdwoYjH30ZnQSPwz+ZBfiS
         xx0g==
X-Gm-Message-State: AOAM532OHGPsS4EjBktbnq4O9/zRy7oxyOC+oGKCLRIP/01BR6rUkrnG
        53yn+XjpoPPj+sBVKajX70yR5+wWNgUC/gQ1xbo=
X-Google-Smtp-Source: ABdhPJw5NWT9CCgMIQc0lxRIDTONwFmO58W+E2Y3C5NdaO4UczGWnwZti6R+vaARQCjY4NUrZjX7RTqffmarYubxta4=
X-Received: by 2002:aa7:c403:: with SMTP id j3mr321346edq.137.1615234710445;
 Mon, 08 Mar 2021 12:18:30 -0800 (PST)
MIME-Version: 1.0
References: <20210308152221.28555-1-zi.yan@sent.com> <79458c46-b4b9-332b-77f7-44371502cbeb@redhat.com>
 <AD0AFA61-8DCF-467D-B961-ACFA1D33828C@nvidia.com> <8039e1d7-3442-f133-f4f6-fe934f02122e@redhat.com>
 <9A4EF5F7-1BFF-4F8D-80B8-B559C05635BE@nvidia.com> <CAHbLzkofsc4_wEGmMFKwkUrc1pg4Y7iZZ9QKAXggiyg8RuOMqA@mail.gmail.com>
 <c530e051-9292-1b2c-3036-70fc1eac3bfa@redhat.com>
In-Reply-To: <c530e051-9292-1b2c-3036-70fc1eac3bfa@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 8 Mar 2021 12:18:18 -0800
Message-ID: <CAHbLzkqjeLZ2ZK=m3+nBqcM366gtq=Ug-=ALiSmnpi+FyZfjZQ@mail.gmail.com>
Subject: Re: [PATCH] mm: huge_memory: a new debugfs interface for splitting
 THP tests.
To:     David Hildenbrand <david@redhat.com>
Cc:     Zi Yan <ziy@nvidia.com>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 8, 2021 at 11:30 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 08.03.21 20:11, Yang Shi wrote:
> > On Mon, Mar 8, 2021 at 11:01 AM Zi Yan <ziy@nvidia.com> wrote:
> >>
> >> On 8 Mar 2021, at 13:11, David Hildenbrand wrote:
> >>
> >>> On 08.03.21 18:49, Zi Yan wrote:
> >>>> On 8 Mar 2021, at 11:17, David Hildenbrand wrote:
> >>>>
> >>>>> On 08.03.21 16:22, Zi Yan wrote:
> >>>>>> From: Zi Yan <ziy@nvidia.com>
> >>>>>>
> >>>>>> By writing "<pid>,<vaddr_start>,<vaddr_end>" to
> >>>>>> <debugfs>/split_huge_pages_in_range_pid, THPs in the process with =
the
> >>>>>> given pid and virtual address range are split. It is used to test
> >>>>>> split_huge_page function. In addition, a selftest program is added=
 to
> >>>>>> tools/testing/selftests/vm to utilize the interface by splitting
> >>>>>> PMD THPs and PTE-mapped THPs.
> >>>>>
> >>>>> Won't something like
> >>>>>
> >>>>> 1. MADV_HUGEPAGE
> >>>>>
> >>>>> 2. Access memory
> >>>>>
> >>>>> 3. MADV_NOHUGEPAGE
> >>>>>
> >>>>> Have a similar effect? What's the benefit of this?
> >>>>
> >>>> Thanks for checking the patch.
> >>>>
> >>>> No, MADV_NOHUGEPAGE just replaces VM_HUGEPAGE with VM_NOHUGEPAGE,
> >>>> nothing else will be done.
> >>>
> >>> Ah, okay - maybe my memory was tricking me. There is some s390x KVM c=
ode that forces MADV_NOHUGEPAGE and force-splits everything.
> >>>
> >>> I do wonder, though, if this functionality would be worth a proper us=
er interface (e.g., madvise), though. There might be actual benefit in havi=
ng this as a !debug interface.
> >>>
> >>> I think you aware of the discussion in https://lkml.kernel.org/r/d098=
c392-273a-36a4-1a29-59731cdf5d3d@google.com
> >>
> >> Yes. Thanks for bringing this up.
> >>
> >>>
> >>> If there will be an interface to collapse a THP -- "this memory area =
is worth extra performance now by collapsing a THP if possible" -- it might=
 also be helpful to have the opposite functionality -- "this memory area is=
 not worth a THP, rather use that somehwere else".
> >>>
> >>> MADV_HUGE_COLLAPSE vs. MADV_HUGE_SPLIT
> >>
> >> I agree that MADV_HUGE_SPLIT would be useful as the opposite of COLLAP=
SE when user might just want PAGESIZE mappings.
> >> Right now, HUGE_SPLIT is implicit from mapping changes like mprotect o=
r MADV_DONTNEED.
> >
> > IMHO, it sounds not very useful. MADV_DONTNEED would split PMD for any
> > partial THP. If the range covers the whole THP, the whole THP is going
> > to be freed anyway. All other places in kernel which need split THP
> > have been covered. So I didn't realize any usecase from userspace for
> > just splitting PMD to PTEs.
>
> THP are a limited resource. So indicating which virtual memory regions
> are not performance sensitive right now (e.g., cold pages in a databse)
> and not worth a THP might be quite valuable, no?

Such functionality could be achieved by MADV_COLD or MADV_PAGEOUT,
right? Then a subsequent call to MADV_NOHUGEPAGE would prevent from
collapsing or allocating THP for that area.

>
> --
> Thanks,
>
> David / dhildenb
>
