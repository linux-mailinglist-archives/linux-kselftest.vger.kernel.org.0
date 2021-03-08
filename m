Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B1C331A20
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Mar 2021 23:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhCHWVM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Mar 2021 17:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhCHWVB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Mar 2021 17:21:01 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A0EC06174A;
        Mon,  8 Mar 2021 14:21:01 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id r17so23491049ejy.13;
        Mon, 08 Mar 2021 14:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gsZzT4mPQ2TrEl8JaekhZDeJKwM0//H/V4uDHJyM4jU=;
        b=jobkbkY1+hGaU1h3ss3KoQd0mPXDP7fELUfF5gKkYfGvtDum0YFEmEr2kRh/oos0mR
         cfC3tHLbzNMszj2eR5cRr+wi5sQILiFJ5Kc2aEp0TbUd3rt5iCkm0blOn9PgsG04bvJe
         C/9vNrVM3RVodn3bC49ivz0vGx1ICY7LahtgOcHeNO8yBzyjk01M0xsAoCBU6GXbkGo8
         iEU6DsoUb+uArUSgVGKuPZSD+ibEnL2ZTA+zFl+8DyZF/2Dx32jKk8RS2nIZQU47F+dO
         aMdPtIB9BUToY6PVypfNW7Vaeg+Iyu5VybtmK2ZHo6On/aMZxUC+A0bjZQrs0wAP4BKI
         lTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gsZzT4mPQ2TrEl8JaekhZDeJKwM0//H/V4uDHJyM4jU=;
        b=kRlKYvJED7Ja9h2BwNv6wL0SFvMHuX3spHiOrk2MYLh4v+wM5mC9QtpULPFEJ50jZk
         a2oAzcPd+XCT/v44k6ryVyVhmQ3DZ36hCS9PNq3cYM6U0N2Ngu76WIhQ7KK9YqQmkAVp
         VOOXEBKk21cJQTILyeUEol8vD1Zo29X1RiqxQi4KJXj8PttdczqJ9yepQVCdAjJrvM57
         AKa87HJFn07QXJwxD48JzxVkOwJIr1iFwRMwHXwBcbO8b3q0Ic0PcryIKqCMCfsTkyeg
         zF2/iaeFeL3CcM5s0EN3v5W/33I0lmCGpFGfX6KeQLxYdsG0KW6BoNl9aHYTxBF20vsr
         lk+Q==
X-Gm-Message-State: AOAM532qU2FbTocpW8uO96n3HYHt7l0+wV4VohsAmGEm8E/lr0cuKo0w
        QEAqRnhXccnABrBaHNeHpioOEHFiWsAeN3FHfO04+axHOJg=
X-Google-Smtp-Source: ABdhPJzohyWTyGkQHlvjWQEknpHziDr5CYi07PjtOGhHUF3dvjvO6XtpY5JlXQKxHQr3fPm+Yg1UckP7j9y4xPsoCn0=
X-Received: by 2002:a17:906:789:: with SMTP id l9mr16788881ejc.161.1615242060200;
 Mon, 08 Mar 2021 14:21:00 -0800 (PST)
MIME-Version: 1.0
References: <CAHbLzkpfR=xbnepbriu1b8n5ii8Kp0EgEa3D7+mU2xcS9iGpGg@mail.gmail.com>
 <B7E9E82B-70B1-491E-99B9-B6B30AE0DE68@redhat.com>
In-Reply-To: <B7E9E82B-70B1-491E-99B9-B6B30AE0DE68@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 8 Mar 2021 14:20:48 -0800
Message-ID: <CAHbLzkrdH4-CG5kVhDJdet0PSivE0fFmRCQyx0_z5MTEmTz9JA@mail.gmail.com>
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

On Mon, Mar 8, 2021 at 1:59 PM David Hildenbrand <david@redhat.com> wrote:
>
>
> > Am 08.03.2021 um 22:25 schrieb Yang Shi <shy828301@gmail.com>:
> >
> > =EF=BB=BFOn Mon, Mar 8, 2021 at 12:36 PM David Hildenbrand <david@redha=
t.com> wrote:
> >>
> >>
> >>>> Am 08.03.2021 um 21:18 schrieb Yang Shi <shy828301@gmail.com>:
> >>>
> >>> =EF=BB=BFOn Mon, Mar 8, 2021 at 11:30 AM David Hildenbrand <david@red=
hat.com> wrote:
> >>>>
> >>>>> On 08.03.21 20:11, Yang Shi wrote:
> >>>>> On Mon, Mar 8, 2021 at 11:01 AM Zi Yan <ziy@nvidia.com> wrote:
> >>>>>>
> >>>>>> On 8 Mar 2021, at 13:11, David Hildenbrand wrote:
> >>>>>>
> >>>>>>> On 08.03.21 18:49, Zi Yan wrote:
> >>>>>>>> On 8 Mar 2021, at 11:17, David Hildenbrand wrote:
> >>>>>>>>
> >>>>>>>>> On 08.03.21 16:22, Zi Yan wrote:
> >>>>>>>>>> From: Zi Yan <ziy@nvidia.com>
> >>>>>>>>>>
> >>>>>>>>>> By writing "<pid>,<vaddr_start>,<vaddr_end>" to
> >>>>>>>>>> <debugfs>/split_huge_pages_in_range_pid, THPs in the process w=
ith the
> >>>>>>>>>> given pid and virtual address range are split. It is used to t=
est
> >>>>>>>>>> split_huge_page function. In addition, a selftest program is a=
dded to
> >>>>>>>>>> tools/testing/selftests/vm to utilize the interface by splitti=
ng
> >>>>>>>>>> PMD THPs and PTE-mapped THPs.
> >>>>>>>>>
> >>>>>>>>> Won't something like
> >>>>>>>>>
> >>>>>>>>> 1. MADV_HUGEPAGE
> >>>>>>>>>
> >>>>>>>>> 2. Access memory
> >>>>>>>>>
> >>>>>>>>> 3. MADV_NOHUGEPAGE
> >>>>>>>>>
> >>>>>>>>> Have a similar effect? What's the benefit of this?
> >>>>>>>>
> >>>>>>>> Thanks for checking the patch.
> >>>>>>>>
> >>>>>>>> No, MADV_NOHUGEPAGE just replaces VM_HUGEPAGE with VM_NOHUGEPAGE=
,
> >>>>>>>> nothing else will be done.
> >>>>>>>
> >>>>>>> Ah, okay - maybe my memory was tricking me. There is some s390x K=
VM code that forces MADV_NOHUGEPAGE and force-splits everything.
> >>>>>>>
> >>>>>>> I do wonder, though, if this functionality would be worth a prope=
r user interface (e.g., madvise), though. There might be actual benefit in =
having this as a !debug interface.
> >>>>>>>
> >>>>>>> I think you aware of the discussion in https://lkml.kernel.org/r/=
d098c392-273a-36a4-1a29-59731cdf5d3d@google.com
> >>>>>>
> >>>>>> Yes. Thanks for bringing this up.
> >>>>>>
> >>>>>>>
> >>>>>>> If there will be an interface to collapse a THP -- "this memory a=
rea is worth extra performance now by collapsing a THP if possible" -- it m=
ight also be helpful to have the opposite functionality -- "this memory are=
a is not worth a THP, rather use that somehwere else".
> >>>>>>>
> >>>>>>> MADV_HUGE_COLLAPSE vs. MADV_HUGE_SPLIT
> >>>>>>
> >>>>>> I agree that MADV_HUGE_SPLIT would be useful as the opposite of CO=
LLAPSE when user might just want PAGESIZE mappings.
> >>>>>> Right now, HUGE_SPLIT is implicit from mapping changes like mprote=
ct or MADV_DONTNEED.
> >>>>>
> >>>>> IMHO, it sounds not very useful. MADV_DONTNEED would split PMD for =
any
> >>>>> partial THP. If the range covers the whole THP, the whole THP is go=
ing
> >>>>> to be freed anyway. All other places in kernel which need split THP
> >>>>> have been covered. So I didn't realize any usecase from userspace f=
or
> >>>>> just splitting PMD to PTEs.
> >>>>
> >>>> THP are a limited resource. So indicating which virtual memory regio=
ns
> >>>> are not performance sensitive right now (e.g., cold pages in a datab=
se)
> >>>> and not worth a THP might be quite valuable, no?
> >>>
> >>> Such functionality could be achieved by MADV_COLD or MADV_PAGEOUT,
> >>> right? Then a subsequent call to MADV_NOHUGEPAGE would prevent from
> >>> collapsing or allocating THP for that area.
> >>>
> >>
> >> I remember these deal with optimizing swapping. Not sure how they inte=
ract with THP, especially on systems without swap - I would guess they don=
=E2=80=98t as of now.
> >
> > Yes, MADV_PAGEOUT would just swap the THP or sub pages out. I think I
> > just forgot to mention MADV_FREE which would be more suitable for this
> > usecase.
> >
> >>
>
> Can you elaborate? MADV_FREE is destructive, just like a delayed MADV_DON=
TNEED. How would that help here?

Split THP and reclaim the memory. Then not allocate or collapse THP
for this area anymore (need subsequent MADV_NOHUGEPAGE call). I'm
supposed this is the main purpose of splitting a THP. And we don't
have to introduce a new advise flag.

Just splitting PMD to PTEs sounds less useful to me IMHO except for
vma changes (i.e. mprotect, mlock, etc).

>
> >>>>
> >>>> --
> >>>> Thanks,
> >>>>
> >>>> David / dhildenb
> >>>>
> >>>
> >>
> >
>
