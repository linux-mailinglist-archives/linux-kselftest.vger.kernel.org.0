Return-Path: <linux-kselftest+bounces-12300-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EFF90FDA7
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 09:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4EDB286234
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 07:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B77C44366;
	Thu, 20 Jun 2024 07:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHfLwKb4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD15940858;
	Thu, 20 Jun 2024 07:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718868356; cv=none; b=YF1jETfT7p/eIRvjZv12NdoQFJaTANDOGAj1S1DVMFZL2OJuwZzaTKiSrd3g55KYOvpQWDJcBVcnqZUtPCQpl+Yqs1lp0tb5J328qT7zlQAkVNlMKXLMCJV8Fe1FLh+f07U6r70lpGc5FUVZe7WgUtPxWxeejdgkizpl6NyzhH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718868356; c=relaxed/simple;
	bh=ze55I3bXHSs997gxJnaF+U1nEZpiMDBKOiqIUAcrH/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wr1sTjfzNSSFh0E3GCG8zkLBu0u6FZNfl7uSpN/m5Rd+ZBRQyBpjIZj/xMqo2YzdnwA4TrU7yyYg/NE9mmA+HfHuK2ZqwZeJNhcIp8JDNjgfNixFJgnnjagreJWELdGHZiSMKQ+rgC45Xjvd1rnIQNmjGa5OuST8voPOXtqb4TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHfLwKb4; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4ecf11df664so156760e0c.2;
        Thu, 20 Jun 2024 00:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718868353; x=1719473153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLXZUXgh5TLk41BARNCX6OxSVAe0KiHJAXDwIUYsvfM=;
        b=mHfLwKb48nPkWzYbSC+xBs/t7p2ilBBLhmIZuUSDLhhzjEKxdzJCHnFF+rPAP9MMor
         RDNRtt8PXZg624CHF74wbXwSgV82v94/TlePf50v2mFF2l9q8wqI6QBc1jFQ7rL8OOkQ
         ZILG0A6Lo7JFPc10BjnhtnpmhofNoObG+2Ta4iKSxCfO6bfU/UmkEDRSM1IxzAAjFgUB
         WfXlpc7MxW8M6m40jLhH2/0Y1N9bnEAukxfxWMaNzHeaO9smwCCbMOIzMJRMxtQXdBF1
         jlJ4C7Nvt7t6/TihaAMNIscoJmZOMlt1lKlFrr99KRoZy9do24oKSUyziCdx3LBP6YFL
         HrQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718868353; x=1719473153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLXZUXgh5TLk41BARNCX6OxSVAe0KiHJAXDwIUYsvfM=;
        b=r6FZFocQhyApsiQfZRkJwTiDQUQqgXf40w1phA0cwv/Oas4FZ2wn4WeD7b5TeU7AYC
         UXPCAMsVITVIdCa9NChoMIX3Fwku7vaYR6rI4uG/YASKGJjkBA2syHjhI4aOqYGNyZuM
         20yBOFzhx6h4Wu135NS9QRhY8vq1AVI+bfiqbj0ZAF+VSy2c2i5LAuMmrF9jeeRQe4lK
         mJFG8P6WgCYzbgznCN8kTr5P4bj+gk8CCxZyhWkqIX3n1NZLQoa5GOBmwdqGIBLqK0vI
         H677AA4MrKjM9+HXBhMK6+vnEeDVVNv1njHuIl5Wuh4wlE/c7gO7wEnueuVei2T/URDJ
         1Drw==
X-Forwarded-Encrypted: i=1; AJvYcCXqaK6Z+wkms0H/Re7yh8MtWm5GKozznHqSFbvVQlZ8amMgEvNc5u+6SUo5RxsNmYdFU1juNOiVQUw96v2qjoZpSeLkb8UYMfUizFA3THxPh2FbNzUz6rpqcgZqhjdPMBM1fKp6jfO85k0aXAcU
X-Gm-Message-State: AOJu0Yw47m3HxLrSd8eymPVpXWrD+9THmN3Ty3GHxTyiv6e6PvRBocoC
	GehNIogNIOcLQUxqCMHDbmVo3O4FzVsj1SHNtp5TIU/7nJTcYYYl10ynnfd/KvnRFwcZC95qHP6
	8EJ7bVpPAXk86koxFow1wUas52u8=
X-Google-Smtp-Source: AGHT+IHN2NVouyF6JqeqBCeqrXcMyZNL0yaQV7MG+sGA6JKJYMOFXjvPfEm9qp3C2rdb0jOmQdg8s3+6cAe/BJfxWEY=
X-Received: by 2002:a05:6122:3c88:b0:4eb:12da:14c7 with SMTP id
 71dfb90a1353d-4ef276f96b7mr5354704e0c.6.1718868353350; Thu, 20 Jun 2024
 00:25:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620002648.75204-1-21cnbao@gmail.com> <87zfrg2xce.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAGsJ_4wS1PbGpfi5oWw4qRgs49kcdyTb42PA+35vBC1oA8Jsbg@mail.gmail.com>
 <87o77w2nrw.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4zz7FdEubG4DhcCvEfyC2Z-yp8QReh9OYopvhudrZF+6A@mail.gmail.com>
 <87jzik2kcq.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87jzik2kcq.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 20 Jun 2024 19:25:42 +1200
Message-ID: <CAGsJ_4ynitJ098KyMQ2rDo3XCFKLCs=xZXfSqdcJ_kFNC02t7g@mail.gmail.com>
Subject: Re: [PATCH] selftests/mm: Introduce a test program to assess swap
 entry allocation for thp_swapout
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, shuah@kernel.org, linux-mm@kvack.org, 
	ryan.roberts@arm.com, chrisl@kernel.org, david@redhat.com, hughd@google.com, 
	kaleshsingh@google.com, kasong@tencent.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 6:36=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > On Thu, Jun 20, 2024 at 5:22=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> Barry Song <21cnbao@gmail.com> writes:
> >>
> >> > On Thu, Jun 20, 2024 at 1:55=E2=80=AFPM Huang, Ying <ying.huang@inte=
l.com> wrote:
> >> >>
> >> >> Barry Song <21cnbao@gmail.com> writes:
> >> >>
> >> >> > From: Barry Song <v-songbaohua@oppo.com>
> >> >> >
> >> >> > Both Ryan and Chris have been utilizing the small test program to=
 aid
> >> >> > in debugging and identifying issues with swap entry allocation. W=
hile
> >> >> > a real or intricate workload might be more suitable for assessing=
 the
> >> >> > correctness and effectiveness of the swap allocation policy, a sm=
all
> >> >> > test program presents a simpler means of understanding the proble=
m and
> >> >> > initially verifying the improvements being made.
> >> >> >
> >> >> > Let's endeavor to integrate it into the self-test suite. Although=
 it
> >> >> > presently only accommodates 64KB and 4KB, I'm optimistic that we =
can
> >> >> > expand its capabilities to support multiple sizes and simulate mo=
re
> >> >> > complex systems in the future as required.
> >> >>
> >> >> IIUC, this is a performance test program instead of functionality t=
est
> >> >> program.  Does it match the purpose of the kernel selftest?
> >> >
> >> > I have a differing perspective. I maintain that the functionality is
> >> > not functioning
> >> > as expected. Despite having all the necessary resources for allocati=
on, failure
> >> > persists, indicating a lack of functionality.
> >>
> >> Is there any user visual functionality issue?
> >
> > Definitely not. If a plane can't take off, taking a train and pretendin=
g
> > there's no functionality issue isn't a solution.
>
> I always think that performance optimization is great work.  However, it
> is not functionality work.
>
> > I have never assigned blame for any mistakes here. On the contrary,
> > I have 100% appreciation for Ryan's work in at least initiating mTHP
> > swapout w/o being split.
> >
> > It took countless experiments for humans to make airplanes commercially
> > viable, but the person who created the first flying airplane remains th=
e
> > greatest. Similarly, Ryan's efforts, combined with your review of his p=
atch,
> > have enabled us to achieve a better goal here. Without your work, we ca=
n't
> > get here at all.
>
> Thanks!
>
> > However, this is never a reason to refuse to acknowledge that this feat=
ure
> > is not actually working.
>
> It just works for some workloads, not for some others.
>
> >>
> >> >>
> >> >> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >> >> > ---
> >> >> >  tools/testing/selftests/mm/Makefile           |   1 +
> >> >> >  .../selftests/mm/thp_swap_allocator_test.c    | 192 ++++++++++++=
++++++
> >> >> >  2 files changed, 193 insertions(+)
> >> >> >  create mode 100644 tools/testing/selftests/mm/thp_swap_allocator=
_test.c
> >> >> >
> >> >> > diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/=
selftests/mm/Makefile
> >> >> > index e1aa09ddaa3d..64164ad66835 100644
> >> >> > --- a/tools/testing/selftests/mm/Makefile
> >> >> > +++ b/tools/testing/selftests/mm/Makefile
> >> >> > @@ -65,6 +65,7 @@ TEST_GEN_FILES +=3D mseal_test
> >> >> >  TEST_GEN_FILES +=3D seal_elf
> >> >> >  TEST_GEN_FILES +=3D on-fault-limit
> >> >> >  TEST_GEN_FILES +=3D pagemap_ioctl
> >> >> > +TEST_GEN_FILES +=3D thp_swap_allocator_test
> >> >> >  TEST_GEN_FILES +=3D thuge-gen
> >> >> >  TEST_GEN_FILES +=3D transhuge-stress
> >> >> >  TEST_GEN_FILES +=3D uffd-stress
> >> >> > diff --git a/tools/testing/selftests/mm/thp_swap_allocator_test.c=
 b/tools/testing/selftests/mm/thp_swap_allocator_test.c
> >> >> > new file mode 100644
> >> >> > index 000000000000..4443a906d0f8
> >> >> > --- /dev/null
> >> >> > +++ b/tools/testing/selftests/mm/thp_swap_allocator_test.c
> >> >> > @@ -0,0 +1,192 @@
> >> >> > +// SPDX-License-Identifier: GPL-2.0-or-later
> >> >> > +/*
> >> >> > + * thp_swap_allocator_test
> >> >> > + *
> >> >> > + * The purpose of this test program is helping check if THP swpo=
ut
> >> >> > + * can correctly get swap slots to swap out as a whole instead o=
f
> >> >> > + * being split. It randomly releases swap entries through madvis=
e
> >> >> > + * DONTNEED and do swapout on two memory areas: a memory area fo=
r
> >> >> > + * 64KB THP and the other area for small folios. The second memo=
ry
> >> >> > + * can be enabled by "-s".
> >> >> > + * Before running the program, we need to setup a zRAM or simila=
r
> >> >> > + * swap device by:
> >> >> > + *  echo lzo > /sys/block/zram0/comp_algorithm
> >> >> > + *  echo 64M > /sys/block/zram0/disksize
> >> >> > + *  echo never > /sys/kernel/mm/transparent_hugepage/hugepages-2=
048kB/enabled
> >> >> > + *  echo always > /sys/kernel/mm/transparent_hugepage/hugepages-=
64kB/enabled
> >> >> > + *  mkswap /dev/zram0
> >> >> > + *  swapon /dev/zram0
> >> >> > + * The expected result should be 0% anon swpout fallback ratio w=
/ or
> >> >> > + * w/o "-s".
> >> >> > + *
> >> >> > + * Author(s): Barry Song <v-songbaohua@oppo.com>
> >> >> > + */
> >> >> > +
> >> >> > +#define _GNU_SOURCE
> >> >> > +#include <stdio.h>
> >> >> > +#include <stdlib.h>
> >> >> > +#include <unistd.h>
> >> >> > +#include <string.h>
> >> >> > +#include <sys/mman.h>
> >> >> > +#include <errno.h>
> >> >> > +#include <time.h>
> >> >> > +
> >> >> > +#define MEMSIZE_MTHP (60 * 1024 * 1024)
> >> >> > +#define MEMSIZE_SMALLFOLIO (1 * 1024 * 1024)
> >> >> > +#define ALIGNMENT_MTHP (64 * 1024)
> >> >> > +#define ALIGNMENT_SMALLFOLIO (4 * 1024)
> >> >> > +#define TOTAL_DONTNEED_MTHP (16 * 1024 * 1024)
> >> >> > +#define TOTAL_DONTNEED_SMALLFOLIO (768 * 1024)
> >> >> > +#define MTHP_FOLIO_SIZE (64 * 1024)
> >> >> > +
> >> >> > +#define SWPOUT_PATH \
> >> >> > +     "/sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/s=
wpout"
> >> >> > +#define SWPOUT_FALLBACK_PATH \
> >> >> > +     "/sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/s=
wpout_fallback"
> >> >> > +
> >> >> > +static void *aligned_alloc_mem(size_t size, size_t alignment)
> >> >> > +{
> >> >> > +     void *mem =3D NULL;
> >> >> > +
> >> >> > +     if (posix_memalign(&mem, alignment, size) !=3D 0) {
> >> >> > +             perror("posix_memalign");
> >> >> > +             return NULL;
> >> >> > +     }
> >> >> > +     return mem;
> >> >> > +}
> >> >> > +
> >> >> > +static void random_madvise_dontneed(void *mem, size_t mem_size,
> >> >> > +             size_t align_size, size_t total_dontneed_size)
> >> >> > +{
> >> >> > +     size_t num_pages =3D total_dontneed_size / align_size;
> >> >> > +     size_t i;
> >> >> > +     size_t offset;
> >> >> > +     void *addr;
> >> >> > +
> >> >> > +     for (i =3D 0; i < num_pages; ++i) {
> >> >> > +             offset =3D (rand() % (mem_size / align_size)) * ali=
gn_size;
> >> >> > +             addr =3D (char *)mem + offset;
> >> >> > +             if (madvise(addr, align_size, MADV_DONTNEED) !=3D 0=
)
> >> >> > +                     perror("madvise dontneed");
> >> >>
> >> >> IIUC, this simulates align_size (generally 64KB) swap-in.  That is,=
 it
> >> >> simulate the effect of large size swap-in when it's not available i=
n
> >> >> kernel.  If we have large size swap-in in kernel in the future, thi=
s
> >> >> becomes unnecessary.
> >> >>
> >> >> Additionally, we have not reached the consensus that we should alwa=
ys
> >> >> swap-in with swapped-out size.  So, I suspect that this test may no=
t
> >> >> reflect real situation in the future.  Although it doesn't reflect
> >> >> current situation too.
> >> >
> >> > Disagree again. releasing the whole mTHP swaps is the best case. Eve=
n in
> >> > the best-case scenario, if we fail, it raises concerns for handling =
potentially
> >> > more challenging situations.
> >>
> >> Repeating sequential anonymous pages writing is the best case.
> >
> > I define the best case as the scenario with the least chance of creatin=
g
> > fragments within swapfiles for mTHP to swap out. There is no real
> > difference whether this is done through swapin or madv_dontneed.
>
> IMO, swapin is much more important than madv_dontneed.  Because most
> users use swapin automatically, but few use madv_dontneed by hand.  So,
> I think swapin/swapout test is much more important than madv_dontneed.
> I don't like this test case because madv_dontneed isn't typical or
> basic.

Disliking DONTNEED isn't a sufficient reason to reject this test program be=
cause
no single small program can report swapout counters, swapout fallback count=
ers,
and fallback ratios within several minutes for 100 iterations. That's
precisely why
we need it, at least initially. We can enhance it further if it lacks
certain functionalities
that people desire.

The entire purpose of MADV_DONTNEED is to simulate a scenario where all
slots are released as a whole, preventing the creation of fragments, which =
is
most favorable for swap allocation. I believe there is no difference betwee=
n
using MADV_DONTNEED or swapin for this purpose. But I am perfectly fine
with switching to swapin to replace MADV_DONTNEED in v2.

I will simply replace DONTNEED by swapping in all 16 subpages every time as
the initial commit, as I anticipate that this approach will yield the
best test results.

I anticipate that the optimization process will comprise three steps in tot=
al.

1. If our swapin process doesn't generate fragments(always swapin all subpa=
ges),
we achieve a 0% fallback ratio with Chris's and Ryan's current optimization=
s.

2. With the current optimizations from Chris and Ryan, we achieve a
fallback ratio
of less than 50% when generating fragments during swapping in by randomly
swapping in a portion of subpages.

The positive outcome is that we tested Ryan's V1 on an actual phone that sw=
aps
in by small folios at 50% percentage (because we have 50% chance to fallbac=
k
while allocating mTHP within do_swap_page()). Despite this, we still achiev=
ed
a 0% fallback ratio when using two zRAMs: one for small folios and the othe=
r for
large folios. My assumption is that anonymous memory still maintains
good spatial
locality, allowing all subpages to eventually be accessed even though they =
are
swapped in one by one. So finally fragments are removed sooner or later.

3. We still maintain a 0% fallback ratio with Chris's long-term plan to opt=
imize
   swapout, even using non-discontiguous slots. I actually don't find
it difficult
   if we can save a swap offset in subpage's field. But obviously
people don't like
   this because the trend is to remove subpage's stuff as much as possible =
:-)

>
> >>
> >> > I don't find it hard to incorporate additional features into this te=
st
> >> > program to simulate more intricate scenarios.
> >>
> >> IMHO, we don't really need this special purpose test.  We can have som=
e
> >> more general basic tests, for example, sequential anonymous pages
> >> writing/reading, random anonymous pages writing/reading, and combinati=
on
> >> of them.
> >
> > I understand that not all things will be loved by all people. However, =
before
> > I sent this patch, Chris mentioned that it has been very helpful for hi=
m and
> > strongly suggested that I contribute it to the self-test suite.
> >
> > By the way, adding sequential and random anonymous pages for
> > read/write operations is definitely in my plan. The absence of this fea=
ture
> > isn't a convincing reason to disregard it.
> >
>
> [snip]
>
> --
> Best Regards,
> Huang, Ying

Thanks
Barry

