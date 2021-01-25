Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB10303229
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Jan 2021 03:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbhAYORl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Jan 2021 09:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729315AbhAYORd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Jan 2021 09:17:33 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F61C06174A
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Jan 2021 06:16:45 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id by1so18254782ejc.0
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Jan 2021 06:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S5Ui7E4iwyE2TQO65zSz/0Cgb3Ri9fqJGpA6Dk0NlEk=;
        b=D1g0OFclSwCFIpJvZSABcihNf3nxNGDnIpyNIku9AIMotbVylImHXj4utu3QP4XIaT
         5XhQvXsq5KVqQji0sVwiqjuzJIw2Wk2yMnHH8LEmExSzzZQ18YNGeE8aAErKVhjQD92K
         84Azqi4Q+e10R5sqIV1ojeUGdrwke3da1LuUHaMP2XbWH5J2HXw4xmkWYNTe0FBLx3X1
         RYjjIUkxBZ7ac0CUPbDukpQXFeEWDanfzb7uaaYo5H61/HmGDO5/iu+mP5IgO2oB6eBz
         trsbXNzYLEEi7yuMmHDLxfHcKZ4JUSezaZXgGSPQwPYeYq08ZhBF2Y++kVmGjsCJMs35
         3Feg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S5Ui7E4iwyE2TQO65zSz/0Cgb3Ri9fqJGpA6Dk0NlEk=;
        b=LBpmNLZgs/afn0nhpi0r2AenQEW0Y7MxawlamM/3NTqNkfAjwHiSh1ufTI6R6bwLjm
         5mAdQPswgAaFS7Up4m4qfV/mOBqCF10a+j0g+RMFsCXzHgc5sJiBj/012kFAR77P4U/B
         M/5hiMlHjoSZ6bd25diDFD5wuDBve4NAoG1CaAQVAdc8IlYGlaYP+kv0ljJXy6TK/0rO
         vA/MqiBAcMXvYh0Itjqmtz2uoJCPZ42pSra4q7lzmbXxNo9fW6Bny88stPTYBytIjzhF
         /sPFcZmnhyULxq+8aKSb09wE7BTot+EQtbl+JJp43NpnJQ2GyqRIIKjWW19bp7LgtK9B
         kSlA==
X-Gm-Message-State: AOAM533ZVagAUhZtg9t3qVDW0q7zbwJDP+dCI6oSkk1u1buFgtMwLTX+
        o1GeUupzr9sGiNFSX23SGJR0tZ5hpuNI5xYFTTRtRg==
X-Google-Smtp-Source: ABdhPJw9jlPcdIINmgZjtVDVelbU35ypsuGYyluiedNJjJ35WXaYdQ6v+d9X/v3YPJAzgdiRjoMvHPkjOi2S3pu/4wA=
X-Received: by 2002:a17:907:20aa:: with SMTP id pw10mr508044ejb.314.1611584202800;
 Mon, 25 Jan 2021 06:16:42 -0800 (PST)
MIME-Version: 1.0
References: <20210122033748.924330-1-pasha.tatashin@soleen.com>
 <20210122033748.924330-14-pasha.tatashin@soleen.com> <6fe738b0-af13-333d-8b22-2d3b62a1ded7@nvidia.com>
In-Reply-To: <6fe738b0-af13-333d-8b22-2d3b62a1ded7@nvidia.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 25 Jan 2021 09:16:07 -0500
Message-ID: <CA+CK2bDDXp18fx21XMB98s1UqxK7ySp_huPVLL0Na4DiJ912FQ@mail.gmail.com>
Subject: Re: [PATCH v7 13/14] selftests/vm: test flag is broken
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

On Sun, Jan 24, 2021 at 6:03 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 1/21/21 7:37 PM, Pavel Tatashin wrote:
> > In gup_test both gup_flags and test_flags use the same flags field.
> > This is broken.
> >
> > Farther, in the actual gup_test.c all the passed gup_flags are erased and
> > unconditionally replaced with FOLL_WRITE.
> >
> > Which means that test_flags are ignored, and code like this always
> > performs pin dump test:
> >
> > 155                   if (gup->flags & GUP_TEST_FLAG_DUMP_PAGES_USE_PIN)
> > 156                           nr = pin_user_pages(addr, nr, gup->flags,
> > 157                                               pages + i, NULL);
> > 158                   else
> > 159                           nr = get_user_pages(addr, nr, gup->flags,
> > 160                                               pages + i, NULL);
> > 161                   break;
> >
> > Add a new test_flags field, to allow raw gup_flags to work.
> > Add a new subcommand for DUMP_USER_PAGES_TEST to specify that pin test
> > should be performed.
> > Remove  unconditional overwriting of gup_flags via FOLL_WRITE. But,
> > preserve the previous behaviour where FOLL_WRITE was the default flag,
> > and add a new option "-W" to unset FOLL_WRITE.
> >
> > Rename flags with gup_flags.
>
> Hi Pavel,
>
> Thanks again for fixing this up! Looks good, with a tiny point about the
> subject line:
>
> 1) To follow convention, the subject line should say what you're doing,
> not what the previous condition was. Also, there are several tests in that
> directory, so we should say which one. So more like this:
>
> "selftests/vm: gup_test: fix test flag"
>
> That is just a minor documentation point, so either way, feel free to add:
>
>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>

Thank you for your review , I will change the subject line in the next update.

Pasha

>
>
> thanks,
> --
> John Hubbard
> NVIDIA
>
> >
> > With the fix, dump works like this:
> >
> > root@virtme:/# gup_test  -c
> > ---- page #0, starting from user virt addr: 0x7f8acb9e4000
> > page:00000000d3d2ee27 refcount:2 mapcount:1 mapping:0000000000000000
> > index:0x0 pfn:0x100bcf
> > anon flags: 0x300000000080016(referenced|uptodate|lru|swapbacked)
> > raw: 0300000000080016 ffffd0e204021608 ffffd0e208df2e88 ffff8ea04243ec61
> > raw: 0000000000000000 0000000000000000 0000000200000000 0000000000000000
> > page dumped because: gup_test: dump_pages() test
> > DUMP_USER_PAGES_TEST: done
> >
> > root@virtme:/# gup_test  -c -p
> > ---- page #0, starting from user virt addr: 0x7fd19701b000
> > page:00000000baed3c7d refcount:1025 mapcount:1 mapping:0000000000000000
> > index:0x0 pfn:0x108008
> > anon flags: 0x300000000080014(uptodate|lru|swapbacked)
> > raw: 0300000000080014 ffffd0e204200188 ffffd0e205e09088 ffff8ea04243ee71
> > raw: 0000000000000000 0000000000000000 0000040100000000 0000000000000000
> > page dumped because: gup_test: dump_pages() test
> > DUMP_USER_PAGES_TEST: done
> >
> > Refcount shows the difference between pin vs no-pin case.
> > Also change type of nr from int to long, as it counts number of pages.
> >
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > ---
> >   mm/gup_test.c                         | 23 ++++++++++-------------
> >   mm/gup_test.h                         |  3 ++-
> >   tools/testing/selftests/vm/gup_test.c | 15 +++++++++++----
> >   3 files changed, 23 insertions(+), 18 deletions(-)
> >
> > diff --git a/mm/gup_test.c b/mm/gup_test.c
> > index e3cf78e5873e..a6ed1c877679 100644
> > --- a/mm/gup_test.c
> > +++ b/mm/gup_test.c
> > @@ -94,7 +94,7 @@ static int __gup_test_ioctl(unsigned int cmd,
> >   {
> >       ktime_t start_time, end_time;
> >       unsigned long i, nr_pages, addr, next;
> > -     int nr;
> > +     long nr;
> >       struct page **pages;
> >       int ret = 0;
> >       bool needs_mmap_lock =
> > @@ -126,37 +126,34 @@ static int __gup_test_ioctl(unsigned int cmd,
> >                       nr = (next - addr) / PAGE_SIZE;
> >               }
> >
> > -             /* Filter out most gup flags: only allow a tiny subset here: */
> > -             gup->flags &= FOLL_WRITE;
> > -
> >               switch (cmd) {
> >               case GUP_FAST_BENCHMARK:
> > -                     nr = get_user_pages_fast(addr, nr, gup->flags,
> > +                     nr = get_user_pages_fast(addr, nr, gup->gup_flags,
> >                                                pages + i);
> >                       break;
> >               case GUP_BASIC_TEST:
> > -                     nr = get_user_pages(addr, nr, gup->flags, pages + i,
> > +                     nr = get_user_pages(addr, nr, gup->gup_flags, pages + i,
> >                                           NULL);
> >                       break;
> >               case PIN_FAST_BENCHMARK:
> > -                     nr = pin_user_pages_fast(addr, nr, gup->flags,
> > +                     nr = pin_user_pages_fast(addr, nr, gup->gup_flags,
> >                                                pages + i);
> >                       break;
> >               case PIN_BASIC_TEST:
> > -                     nr = pin_user_pages(addr, nr, gup->flags, pages + i,
> > +                     nr = pin_user_pages(addr, nr, gup->gup_flags, pages + i,
> >                                           NULL);
> >                       break;
> >               case PIN_LONGTERM_BENCHMARK:
> >                       nr = pin_user_pages(addr, nr,
> > -                                         gup->flags | FOLL_LONGTERM,
> > +                                         gup->gup_flags | FOLL_LONGTERM,
> >                                           pages + i, NULL);
> >                       break;
> >               case DUMP_USER_PAGES_TEST:
> > -                     if (gup->flags & GUP_TEST_FLAG_DUMP_PAGES_USE_PIN)
> > -                             nr = pin_user_pages(addr, nr, gup->flags,
> > +                     if (gup->test_flags & GUP_TEST_FLAG_DUMP_PAGES_USE_PIN)
> > +                             nr = pin_user_pages(addr, nr, gup->gup_flags,
> >                                                   pages + i, NULL);
> >                       else
> > -                             nr = get_user_pages(addr, nr, gup->flags,
> > +                             nr = get_user_pages(addr, nr, gup->gup_flags,
> >                                                   pages + i, NULL);
> >                       break;
> >               default:
> > @@ -187,7 +184,7 @@ static int __gup_test_ioctl(unsigned int cmd,
> >
> >       start_time = ktime_get();
> >
> > -     put_back_pages(cmd, pages, nr_pages, gup->flags);
> > +     put_back_pages(cmd, pages, nr_pages, gup->test_flags);
> >
> >       end_time = ktime_get();
> >       gup->put_delta_usec = ktime_us_delta(end_time, start_time);
> > diff --git a/mm/gup_test.h b/mm/gup_test.h
> > index 90a6713d50eb..887ac1d5f5bc 100644
> > --- a/mm/gup_test.h
> > +++ b/mm/gup_test.h
> > @@ -21,7 +21,8 @@ struct gup_test {
> >       __u64 addr;
> >       __u64 size;
> >       __u32 nr_pages_per_call;
> > -     __u32 flags;
> > +     __u32 gup_flags;
> > +     __u32 test_flags;
> >       /*
> >        * Each non-zero entry is the number of the page (1-based: first page is
> >        * page 1, so that zero entries mean "do nothing") from the .addr base.
> > diff --git a/tools/testing/selftests/vm/gup_test.c b/tools/testing/selftests/vm/gup_test.c
> > index 6c6336dd3b7f..943cc2608dc2 100644
> > --- a/tools/testing/selftests/vm/gup_test.c
> > +++ b/tools/testing/selftests/vm/gup_test.c
> > @@ -37,13 +37,13 @@ int main(int argc, char **argv)
> >   {
> >       struct gup_test gup = { 0 };
> >       unsigned long size = 128 * MB;
> > -     int i, fd, filed, opt, nr_pages = 1, thp = -1, repeats = 1, write = 0;
> > +     int i, fd, filed, opt, nr_pages = 1, thp = -1, repeats = 1, write = 1;
> >       unsigned long cmd = GUP_FAST_BENCHMARK;
> >       int flags = MAP_PRIVATE;
> >       char *file = "/dev/zero";
> >       char *p;
> >
> > -     while ((opt = getopt(argc, argv, "m:r:n:F:f:abctTLUuwSH")) != -1) {
> > +     while ((opt = getopt(argc, argv, "m:r:n:F:f:abctTLUuwWSHp")) != -1) {
> >               switch (opt) {
> >               case 'a':
> >                       cmd = PIN_FAST_BENCHMARK;
> > @@ -65,9 +65,13 @@ int main(int argc, char **argv)
> >                        */
> >                       gup.which_pages[0] = 1;
> >                       break;
> > +             case 'p':
> > +                     /* works only with DUMP_USER_PAGES_TEST */
> > +                     gup.test_flags |= GUP_TEST_FLAG_DUMP_PAGES_USE_PIN;
> > +                     break;
> >               case 'F':
> >                       /* strtol, so you can pass flags in hex form */
> > -                     gup.flags = strtol(optarg, 0, 0);
> > +                     gup.gup_flags = strtol(optarg, 0, 0);
> >                       break;
> >               case 'm':
> >                       size = atoi(optarg) * MB;
> > @@ -93,6 +97,9 @@ int main(int argc, char **argv)
> >               case 'w':
> >                       write = 1;
> >                       break;
> > +             case 'W':
> > +                     write = 0;
> > +                     break;
> >               case 'f':
> >                       file = optarg;
> >                       break;
> > @@ -140,7 +147,7 @@ int main(int argc, char **argv)
> >
> >       gup.nr_pages_per_call = nr_pages;
> >       if (write)
> > -             gup.flags |= FOLL_WRITE;
> > +             gup.gup_flags |= FOLL_WRITE;
> >
> >       fd = open("/sys/kernel/debug/gup_test", O_RDWR);
> >       if (fd == -1) {
> >
>
