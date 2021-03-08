Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEA3331957
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Mar 2021 22:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhCHVZV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Mar 2021 16:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhCHVZV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Mar 2021 16:25:21 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC238C06174A;
        Mon,  8 Mar 2021 13:25:20 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id l12so16923088edt.3;
        Mon, 08 Mar 2021 13:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qOsKysHmPp2aVhNaoAMyp4YZeDW1D1UH7Hy8PXT8Ies=;
        b=fSsrlhxOBFqSDG74RFsuvBiXnKrnpyYRjWU02QXSEfajja6RCbjkh6fjcG6etzsLQi
         CXEqoxFgQxDpDDCcjHogfn70fUoImQDbt6iPH0Fe+UzU2zLbEiabLPDjpv5ROlrw82im
         xYSd14uc/CDxMcsgPSbZm2xMHr7/gtAXEUAkEDWIRsJjfzVzL1p+BJfnL8pOu/EMvvRs
         Pz+maOFPsGl5fQa0iqVUqMHZYs7CYnWMYQV9PNzrjg+8TPZf2F1C1m68Hyp0MGQnixAU
         El6YCIOCEZ3DSuqe4CJ2eqKDz9nvlxftGJZAyp3fBKr31BfZ8eozcbv7Z0HoHsBlsydR
         gPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qOsKysHmPp2aVhNaoAMyp4YZeDW1D1UH7Hy8PXT8Ies=;
        b=FnIOz1drk4OIep1X7t/TF75SG8200pbkzQNVLbi29uN0vser7nQsfi+X+YZ9XBRYO1
         EpmO+ZYD1SM7JLTRneSBYeNxJGjYKwFeCtbgEyKSV8XUYatyve1cphgPwg+CyPP02UHt
         z4Usaf7xafPJcLkk3fSuHzTBe4fQL372kGSAdD0DE6W51vUIMAM83hw44PmfczmjZhpV
         dQopqTnqCQf1KvTVGCJIKhtYv8xApHhP2xe7sn5w25fgiNzXGTHPil/08t2uimpNRdq2
         tmAYKVlW5Iu2qxpqbx2X2pVuR6QqwooiIa5kZK/s8rni74TmnaSsiz5u/T1srDpOejUi
         KFSw==
X-Gm-Message-State: AOAM533Y+wsYZx3WHFuc7p66Sm3zU8ppggw3SoO56dTNQV/xcNfDq2xb
        Op/Vrixu3oVuRs0z09iA5FwVqBdrVKoTVz7eVgY=
X-Google-Smtp-Source: ABdhPJx+DFxPfCnz1O6SvyS+/Yv0XPrageQjGF2NmAEnoS43AmbcOqMWK9I3KRuHFUOb0DZMOmDBfJtxe73a87OC5gU=
X-Received: by 2002:aa7:de82:: with SMTP id j2mr534611edv.313.1615238719519;
 Mon, 08 Mar 2021 13:25:19 -0800 (PST)
MIME-Version: 1.0
References: <CAHbLzkqjeLZ2ZK=m3+nBqcM366gtq=Ug-=ALiSmnpi+FyZfjZQ@mail.gmail.com>
 <44C62A78-4B37-445D-A9F7-25D1A412A802@redhat.com>
In-Reply-To: <44C62A78-4B37-445D-A9F7-25D1A412A802@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 8 Mar 2021 13:25:07 -0800
Message-ID: <CAHbLzkpfR=xbnepbriu1b8n5ii8Kp0EgEa3D7+mU2xcS9iGpGg@mail.gmail.com>
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

On Mon, Mar 8, 2021 at 12:36 PM David Hildenbrand <david@redhat.com> wrote:
>
>
> > Am 08.03.2021 um 21:18 schrieb Yang Shi <shy828301@gmail.com>:
> >
> > =EF=BB=BFOn Mon, Mar 8, 2021 at 11:30 AM David Hildenbrand <david@redha=
t.com> wrote:
> >>
> >>> On 08.03.21 20:11, Yang Shi wrote:
> >>> On Mon, Mar 8, 2021 at 11:01 AM Zi Yan <ziy@nvidia.com> wrote:
> >>>>
> >>>> On 8 Mar 2021, at 13:11, David Hildenbrand wrote:
> >>>>
> >>>>> On 08.03.21 18:49, Zi Yan wrote:
> >>>>>> On 8 Mar 2021, at 11:17, David Hildenbrand wrote:
> >>>>>>
> >>>>>>> On 08.03.21 16:22, Zi Yan wrote:
> >>>>>>>> From: Zi Yan <ziy@nvidia.com>
> >>>>>>>>
> >>>>>>>> By writing "<pid>,<vaddr_start>,<vaddr_end>" to
> >>>>>>>> <debugfs>/split_huge_pages_in_range_pid, THPs in the process wit=
h the
> >>>>>>>> given pid and virtual address range are split. It is used to tes=
t
> >>>>>>>> split_huge_page function. In addition, a selftest program is add=
ed to
> >>>>>>>> tools/testing/selftests/vm to utilize the interface by splitting
> >>>>>>>> PMD THPs and PTE-mapped THPs.
> >>>>>>>
> >>>>>>> Won't something like
> >>>>>>>
> >>>>>>> 1. MADV_HUGEPAGE
> >>>>>>>
> >>>>>>> 2. Access memory
> >>>>>>>
> >>>>>>> 3. MADV_NOHUGEPAGE
> >>>>>>>
> >>>>>>> Have a similar effect? What's the benefit of this?
> >>>>>>
> >>>>>> Thanks for checking the patch.
> >>>>>>
> >>>>>> No, MADV_NOHUGEPAGE just replaces VM_HUGEPAGE with VM_NOHUGEPAGE,
> >>>>>> nothing else will be done.
> >>>>>
> >>>>> Ah, okay - maybe my memory was tricking me. There is some s390x KVM=
 code that forces MADV_NOHUGEPAGE and force-splits everything.
> >>>>>
> >>>>> I do wonder, though, if this functionality would be worth a proper =
user interface (e.g., madvise), though. There might be actual benefit in ha=
ving this as a !debug interface.
> >>>>>
> >>>>> I think you aware of the discussion in https://lkml.kernel.org/r/d0=
98c392-273a-36a4-1a29-59731cdf5d3d@google.com
> >>>>
> >>>> Yes. Thanks for bringing this up.
> >>>>
> >>>>>
> >>>>> If there will be an interface to collapse a THP -- "this memory are=
a is worth extra performance now by collapsing a THP if possible" -- it mig=
ht also be helpful to have the opposite functionality -- "this memory area =
is not worth a THP, rather use that somehwere else".
> >>>>>
> >>>>> MADV_HUGE_COLLAPSE vs. MADV_HUGE_SPLIT
> >>>>
> >>>> I agree that MADV_HUGE_SPLIT would be useful as the opposite of COLL=
APSE when user might just want PAGESIZE mappings.
> >>>> Right now, HUGE_SPLIT is implicit from mapping changes like mprotect=
 or MADV_DONTNEED.
> >>>
> >>> IMHO, it sounds not very useful. MADV_DONTNEED would split PMD for an=
y
> >>> partial THP. If the range covers the whole THP, the whole THP is goin=
g
> >>> to be freed anyway. All other places in kernel which need split THP
> >>> have been covered. So I didn't realize any usecase from userspace for
> >>> just splitting PMD to PTEs.
> >>
> >> THP are a limited resource. So indicating which virtual memory regions
> >> are not performance sensitive right now (e.g., cold pages in a databse=
)
> >> and not worth a THP might be quite valuable, no?
> >
> > Such functionality could be achieved by MADV_COLD or MADV_PAGEOUT,
> > right? Then a subsequent call to MADV_NOHUGEPAGE would prevent from
> > collapsing or allocating THP for that area.
> >
>
> I remember these deal with optimizing swapping. Not sure how they interac=
t with THP, especially on systems without swap - I would guess they don=E2=
=80=98t as of now.

Yes, MADV_PAGEOUT would just swap the THP or sub pages out. I think I
just forgot to mention MADV_FREE which would be more suitable for this
usecase.

>
> >>
> >> --
> >> Thanks,
> >>
> >> David / dhildenb
> >>
> >
>
