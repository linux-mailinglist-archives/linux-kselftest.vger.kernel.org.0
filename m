Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B30D1302639
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Jan 2021 15:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbhAYOUG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Jan 2021 09:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729364AbhAYOTA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Jan 2021 09:19:00 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16FDC061786
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Jan 2021 06:18:18 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id 6so18271482ejz.5
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Jan 2021 06:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W8jVFguuT6m3F5w/xn5YSJGes8cxtxtvar1ZUvu/eoM=;
        b=Jqrr5sIJHZI42XyeQSNtEGhk/iXqs8XvtEUmwFOySC5uU/nWPWlXqZXMheutWEKUq9
         ztBO3zMX5+8VcQwOkMtEqp71gmApj74c3avAiqu8MNY8EH4L0FEiAmJGymk16irl0VmL
         BoU6mFDqvtOwQ6PLtHfnGX461kpXxwvCrpsyMKh2tGv3D7aXI6qat6lwoSY2f/W3Zr9d
         gXOGQ1HqM+BaQ9Fhn4h8+xPBkvX8SQxajAGgp7dvz9VZBZZ6wgEyhYVyo5fApBjrtBy2
         uWHiCjI2V9i8m87Sq7SVmEVmCQ/8M5/m2gwpBELHJhXMS7kj8EMj3oLPh+s1p4EcRrYV
         e9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W8jVFguuT6m3F5w/xn5YSJGes8cxtxtvar1ZUvu/eoM=;
        b=hcUuAs9bESIo/4BuVA6Y3oM/S9H9mOuHEyv46spUllnDLGt0XRo8SdaA4usfIxMcpZ
         wl+MCKOw+Wy1rwWHzRACouciqL3FChmuCBJD1s+x/yc1mX73a7EwhJU4WOmB0jqelIKJ
         we9dSfqaovrNotgrDqpf0KbK960DeryFwIVkEZr/o+m4FtZn0p4LvHssTwtlKErgMrAr
         bF74NfT8Wt1X0D7sf2zDYgmpzyn8irsdqZ0vpVEVTFPd6bdM3yYt0DI9H+rwNJndKBK9
         RgirW3OkPSfuuiFuf6jqDhXa4dmUUTbHIJ89jAIhTj2o2lUG+Y5/kkn4XeA1kJxEjRZN
         k5sw==
X-Gm-Message-State: AOAM532yekgCxmq25CaEI1PSV+cVzsgrTljTeOLHq/WshMvolfeeRONz
        IpOf7ah1FEhkiH+8eaEWtOQLBRo2Jaz6Xncwv6lHMg==
X-Google-Smtp-Source: ABdhPJyFmVdvGQkBZJR1hzTzd01twOSBNqzI53I0lyChAkFmuaJJodTCQQkhpiXU1ebsMXmR6Bkn/iPV24G4dOgKnq0=
X-Received: by 2002:a17:906:cedd:: with SMTP id si29mr539677ejb.426.1611584297565;
 Mon, 25 Jan 2021 06:18:17 -0800 (PST)
MIME-Version: 1.0
References: <20210122033748.924330-1-pasha.tatashin@soleen.com>
 <20210122033748.924330-15-pasha.tatashin@soleen.com> <532b1927-1b5d-83e8-f1f9-50cd5e72435f@nvidia.com>
In-Reply-To: <532b1927-1b5d-83e8-f1f9-50cd5e72435f@nvidia.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 25 Jan 2021 09:17:41 -0500
Message-ID: <CA+CK2bDsGby9yAZpm_seh2c4WHDSuxwBOL6oS9W0ttNpSjT7Tw@mail.gmail.com>
Subject: Re: [PATCH v7 14/14] selftests/vm: test faulting in kernel, and
 verify pinnable pages
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jan 24, 2021 at 6:18 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 1/21/21 7:37 PM, Pavel Tatashin wrote:
> > When pages are pinned they can be faulted in userland and migrated, and
> > they can be faulted right in kernel without migration.
> >
> > In either case, the pinned pages must end-up being pinnable (not movable).
> >
> > Add a new test to gup_test, to help verify that the gup/pup
> > (get_user_pages() / pin_user_pages()) behavior with respect to pinnable
> > and movable pages is reasonable and correct. Specifically, provide a
> > way to:
> >
> > 1) Verify that only "pinnable" pages are pinned. This is checked
> > automatically for you.
> >
> > 2) Verify that gup/pup performance is reasonable. This requires
> > comparing benchmarks between doing gup/pup on pages that have been
> > pre-faulted in from user space, vs. doing gup/pup on pages that are not
> > faulted in until gup/pup time (via FOLL_TOUCH). This decision is
> > controlled with the new -z command line option.
> >
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > ---
> >   mm/gup_test.c                         |  6 ++++++
> >   tools/testing/selftests/vm/gup_test.c | 23 +++++++++++++++++++----
> >   2 files changed, 25 insertions(+), 4 deletions(-)
> >
>
> This also looks good. I do see the WARN_ON_ONCE firing in
> internal_get_user_pages_fast(), when running with *only* the new -z
> option.
>
> I'll poke around the rest of the patchset and see if that is expected
> and normal, but either way the test code itself looks correct and seems
> to be passing my set of "run a bunch of different gup_test options" here,
> so feel free to add:
>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>

Thank you!

Pasha

>
> thanks,
> --
> John Hubbard
> NVIDIA
>
> > diff --git a/mm/gup_test.c b/mm/gup_test.c
> > index a6ed1c877679..d974dec19e1c 100644
> > --- a/mm/gup_test.c
> > +++ b/mm/gup_test.c
> > @@ -52,6 +52,12 @@ static void verify_dma_pinned(unsigned int cmd, struct page **pages,
> >
> >                               dump_page(page, "gup_test failure");
> >                               break;
> > +                     } else if (cmd == PIN_LONGTERM_BENCHMARK &&
> > +                             WARN(!is_pinnable_page(page),
> > +                                  "pages[%lu] is NOT pinnable but pinned\n",
> > +                                  i)) {
> > +                             dump_page(page, "gup_test failure");
> > +                             break;
> >                       }
> >               }
> >               break;
> > diff --git a/tools/testing/selftests/vm/gup_test.c b/tools/testing/selftests/vm/gup_test.c
> > index 943cc2608dc2..1e662d59c502 100644
> > --- a/tools/testing/selftests/vm/gup_test.c
> > +++ b/tools/testing/selftests/vm/gup_test.c
> > @@ -13,6 +13,7 @@
> >
> >   /* Just the flags we need, copied from mm.h: */
> >   #define FOLL_WRITE  0x01    /* check pte is writable */
> > +#define FOLL_TOUCH   0x02    /* mark page accessed */
> >
> >   static char *cmd_to_str(unsigned long cmd)
> >   {
> > @@ -39,11 +40,11 @@ int main(int argc, char **argv)
> >       unsigned long size = 128 * MB;
> >       int i, fd, filed, opt, nr_pages = 1, thp = -1, repeats = 1, write = 1;
> >       unsigned long cmd = GUP_FAST_BENCHMARK;
> > -     int flags = MAP_PRIVATE;
> > +     int flags = MAP_PRIVATE, touch = 0;
> >       char *file = "/dev/zero";
> >       char *p;
> >
> > -     while ((opt = getopt(argc, argv, "m:r:n:F:f:abctTLUuwWSHp")) != -1) {
> > +     while ((opt = getopt(argc, argv, "m:r:n:F:f:abctTLUuwWSHpz")) != -1) {
> >               switch (opt) {
> >               case 'a':
> >                       cmd = PIN_FAST_BENCHMARK;
> > @@ -110,6 +111,10 @@ int main(int argc, char **argv)
> >               case 'H':
> >                       flags |= (MAP_HUGETLB | MAP_ANONYMOUS);
> >                       break;
> > +             case 'z':
> > +                     /* fault pages in gup, do not fault in userland */
> > +                     touch = 1;
> > +                     break;
> >               default:
> >                       return -1;
> >               }
> > @@ -167,8 +172,18 @@ int main(int argc, char **argv)
> >       else if (thp == 0)
> >               madvise(p, size, MADV_NOHUGEPAGE);
> >
> > -     for (; (unsigned long)p < gup.addr + size; p += PAGE_SIZE)
> > -             p[0] = 0;
> > +     /*
> > +      * FOLL_TOUCH, in gup_test, is used as an either/or case: either
> > +      * fault pages in from the kernel via FOLL_TOUCH, or fault them
> > +      * in here, from user space. This allows comparison of performance
> > +      * between those two cases.
> > +      */
> > +     if (touch) {
> > +             gup.gup_flags |= FOLL_TOUCH;
> > +     } else {
> > +             for (; (unsigned long)p < gup.addr + size; p += PAGE_SIZE)
> > +                     p[0] = 0;
> > +     }
> >
> >       /* Only report timing information on the *_BENCHMARK commands: */
> >       if ((cmd == PIN_FAST_BENCHMARK) || (cmd == GUP_FAST_BENCHMARK) ||
> >
>
