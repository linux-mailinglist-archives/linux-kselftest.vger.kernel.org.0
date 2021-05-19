Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07121389930
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 May 2021 00:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhESWSo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 May 2021 18:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhESWSn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 May 2021 18:18:43 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995C9C06175F
        for <linux-kselftest@vger.kernel.org>; Wed, 19 May 2021 15:17:23 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id h6so13539518ila.7
        for <linux-kselftest@vger.kernel.org>; Wed, 19 May 2021 15:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5wgl05064bo/wrhGEEMBj308K0kQaD0/2stg8PGthI0=;
        b=H6+SABy0HV4MGm3RGyJtz6pogFgzYS75atH5aoZhE6LIjuSASSLpiVi2cTcJqD1CZy
         XTQ34IZDiAjannkogmRFrctR7ETtoQ83cmiNdGMhQqnlVxOVzH1ZI+hmDuE8x0xvNuBS
         Jtsh9aeSiGvHKr8JVL7KalSSNMMxJeD5NUxqM8vVgN+x7OQBhj4wJGbep5q8F7IiEAek
         2XtUak8fA2EHe5UJw1RYfhXqOLpYGPQqr0RPNQg6f+soqQggdyv8Vtx6gsrD7pLJ087U
         BocGya1tu3TXC4kB/AAjBp3wA6XCMcU44DqdAdxk0sNhUje2WDByAFUQNii0t6NUvnbL
         9Jiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5wgl05064bo/wrhGEEMBj308K0kQaD0/2stg8PGthI0=;
        b=bkt1P6VMX2CsfHJPrRZTxgYYf7cSZ0u6p5P70lxRPjIda0jXK0AneVzvyIUm03Px64
         Rq46UplN4U+9r+6IwwvnYAzpD7QeUodR0wHlt2gGkWW0SJWxOzzlLj6nm5+DCGCYuw3N
         NTHUeUduDhNuVAu1T/JMJ6vq+7zyET6F2IymUAGTrGTwFCNhFJUds2zo5VUvMvEKSoqZ
         zklIJfwlXShHnsooVB8hrza8TBq/DqSDaPCzGdniCa8OGjNQaCCtomgb65bfYYzPa8uJ
         UBCm43gcQjSF91PxNO7Q0skgRH723kwPjrABznsGTqMClvDhGhCDOG/AMLfMXL1rCEq7
         +JAw==
X-Gm-Message-State: AOAM530oIar1GNlvSMMeFgXazI+w5X3q1u075Qgi7N1qGUwgQ2bgK2uK
        my5ECvSV1LMI4/X0yDe87BBdc5h8JB/0JUi2f3mXnA==
X-Google-Smtp-Source: ABdhPJzOuNXE276R25wv+szT69fRMzJgkvdYpulEGNtX8Xfx1YJ1vxarp3QWt6xXw5xq4KBBUjMWe8MTFYkiZvXOJ9Q=
X-Received: by 2002:a92:340a:: with SMTP id b10mr1424032ila.301.1621462642818;
 Wed, 19 May 2021 15:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210519200339.829146-1-axelrasmussen@google.com>
 <20210519200339.829146-7-axelrasmussen@google.com> <CANgfPd-RuScC1BONf2wBSSJ=GQE5yW=BK4g18L3R2Ebn__+PAg@mail.gmail.com>
In-Reply-To: <CANgfPd-RuScC1BONf2wBSSJ=GQE5yW=BK4g18L3R2Ebn__+PAg@mail.gmail.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 19 May 2021 15:16:46 -0700
Message-ID: <CAJHvVchMMse=CcSUnHGDXLKd0YSa3wTvyyyPjT8MU3RmmwAXtQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] KVM: selftests: refactor vm_mem_backing_src_type flags
To:     Ben Gardon <bgardon@google.com>
Cc:     Aaron Lewis <aaronlewis@google.com>,
        Alexander Graf <graf@amazon.com>,
        Andrew Jones <drjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Xu <jacobhxu@google.com>,
        Makarand Sonare <makarandsonare@google.com>,
        Oliver Upton <oupton@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Yanan Wang <wangyanan55@huawei.com>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 19, 2021 at 3:02 PM Ben Gardon <bgardon@google.com> wrote:
>
> On Wed, May 19, 2021 at 1:04 PM Axel Rasmussen <axelrasmussen@google.com> wrote:
> >
> > Each struct vm_mem_backing_src_alias has a flags field, which denotes
> > the flags used to mmap() an area of that type. Previously, this field
> > never included MAP_PRIVATE | MAP_ANONYMOUS, because
> > vm_userspace_mem_region_add assumed that *all* types would always use
> > those flags, and so it hardcoded them.
> >
> > In a follow-up commit, we'll add a new type: shmem. Areas of this type
> > must not have MAP_PRIVATE | MAP_ANONYMOUS, and instead they must have
> > MAP_SHARED.
> >
> > So, refactor things. Make it so that the flags field of
> > struct vm_mem_backing_src_alias really is a complete set of flags, and
> > don't add in any extras in vm_userspace_mem_region_add. This will let us
> > easily tack on shmem.
> >
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > ---
> >  tools/testing/selftests/kvm/lib/kvm_util.c  |  5 ++-
> >  tools/testing/selftests/kvm/lib/test_util.c | 35 +++++++++++----------
> >  2 files changed, 21 insertions(+), 19 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> > index 0d6ddee429b9..bc405785ac8b 100644
> > --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> > +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> > @@ -759,9 +759,8 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
> >
> >         region->mmap_start = mmap(NULL, region->mmap_size,
> >                                   PROT_READ | PROT_WRITE,
> > -                                 MAP_PRIVATE | MAP_ANONYMOUS
> > -                                 | vm_mem_backing_src_alias(src_type)->flag,
> > -                                 -1, 0);
> > +                                 vm_mem_backing_src_alias(src_type)->flag,
> > +                                 region->fd, 0);
>
> I don't see the region->fd change mentioned in the patch description
> or elsewhere in this patch. Is something setting region->fd to -1 or
> should this be part of another patch in the series?

Ah, apologies, this is a mistake from splitting up the commits. When
they were all squashed together, we set region->fd = -1 explicitly
just above here, but with them separated we can't depend on that. I'll
fix this in a v3.

>
> >         TEST_ASSERT(region->mmap_start != MAP_FAILED,
> >                     "test_malloc failed, mmap_start: %p errno: %i",
> >                     region->mmap_start, errno);
> > diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
> > index 63d2bc7d757b..06ddde068736 100644
> > --- a/tools/testing/selftests/kvm/lib/test_util.c
> > +++ b/tools/testing/selftests/kvm/lib/test_util.c
> > @@ -168,70 +168,73 @@ size_t get_def_hugetlb_pagesz(void)
> >
> >  const struct vm_mem_backing_src_alias *vm_mem_backing_src_alias(uint32_t i)
> >  {
> > +       static const int anon_flags = MAP_PRIVATE | MAP_ANONYMOUS;
> > +       static const int anon_huge_flags = anon_flags | MAP_HUGETLB;
> > +
> >         static const struct vm_mem_backing_src_alias aliases[] = {
> >                 [VM_MEM_SRC_ANONYMOUS] = {
> >                         .name = "anonymous",
> > -                       .flag = 0,
> > +                       .flag = anon_flags,
> >                 },
> >                 [VM_MEM_SRC_ANONYMOUS_THP] = {
> >                         .name = "anonymous_thp",
> > -                       .flag = 0,
> > +                       .flag = anon_flags,
> >                 },
> >                 [VM_MEM_SRC_ANONYMOUS_HUGETLB] = {
> >                         .name = "anonymous_hugetlb",
> > -                       .flag = MAP_HUGETLB,
> > +                       .flag = anon_huge_flags,
> >                 },
> >                 [VM_MEM_SRC_ANONYMOUS_HUGETLB_16KB] = {
> >                         .name = "anonymous_hugetlb_16kb",
> > -                       .flag = MAP_HUGETLB | MAP_HUGE_16KB,
> > +                       .flag = anon_huge_flags | MAP_HUGE_16KB,
> >                 },
> >                 [VM_MEM_SRC_ANONYMOUS_HUGETLB_64KB] = {
> >                         .name = "anonymous_hugetlb_64kb",
> > -                       .flag = MAP_HUGETLB | MAP_HUGE_64KB,
> > +                       .flag = anon_huge_flags | MAP_HUGE_64KB,
> >                 },
> >                 [VM_MEM_SRC_ANONYMOUS_HUGETLB_512KB] = {
> >                         .name = "anonymous_hugetlb_512kb",
> > -                       .flag = MAP_HUGETLB | MAP_HUGE_512KB,
> > +                       .flag = anon_huge_flags | MAP_HUGE_512KB,
> >                 },
> >                 [VM_MEM_SRC_ANONYMOUS_HUGETLB_1MB] = {
> >                         .name = "anonymous_hugetlb_1mb",
> > -                       .flag = MAP_HUGETLB | MAP_HUGE_1MB,
> > +                       .flag = anon_huge_flags | MAP_HUGE_1MB,
> >                 },
> >                 [VM_MEM_SRC_ANONYMOUS_HUGETLB_2MB] = {
> >                         .name = "anonymous_hugetlb_2mb",
> > -                       .flag = MAP_HUGETLB | MAP_HUGE_2MB,
> > +                       .flag = anon_huge_flags | MAP_HUGE_2MB,
> >                 },
> >                 [VM_MEM_SRC_ANONYMOUS_HUGETLB_8MB] = {
> >                         .name = "anonymous_hugetlb_8mb",
> > -                       .flag = MAP_HUGETLB | MAP_HUGE_8MB,
> > +                       .flag = anon_huge_flags | MAP_HUGE_8MB,
> >                 },
> >                 [VM_MEM_SRC_ANONYMOUS_HUGETLB_16MB] = {
> >                         .name = "anonymous_hugetlb_16mb",
> > -                       .flag = MAP_HUGETLB | MAP_HUGE_16MB,
> > +                       .flag = anon_huge_flags | MAP_HUGE_16MB,
> >                 },
> >                 [VM_MEM_SRC_ANONYMOUS_HUGETLB_32MB] = {
> >                         .name = "anonymous_hugetlb_32mb",
> > -                       .flag = MAP_HUGETLB | MAP_HUGE_32MB,
> > +                       .flag = anon_huge_flags | MAP_HUGE_32MB,
> >                 },
> >                 [VM_MEM_SRC_ANONYMOUS_HUGETLB_256MB] = {
> >                         .name = "anonymous_hugetlb_256mb",
> > -                       .flag = MAP_HUGETLB | MAP_HUGE_256MB,
> > +                       .flag = anon_huge_flags | MAP_HUGE_256MB,
> >                 },
> >                 [VM_MEM_SRC_ANONYMOUS_HUGETLB_512MB] = {
> >                         .name = "anonymous_hugetlb_512mb",
> > -                       .flag = MAP_HUGETLB | MAP_HUGE_512MB,
> > +                       .flag = anon_huge_flags | MAP_HUGE_512MB,
> >                 },
> >                 [VM_MEM_SRC_ANONYMOUS_HUGETLB_1GB] = {
> >                         .name = "anonymous_hugetlb_1gb",
> > -                       .flag = MAP_HUGETLB | MAP_HUGE_1GB,
> > +                       .flag = anon_huge_flags | MAP_HUGE_1GB,
> >                 },
> >                 [VM_MEM_SRC_ANONYMOUS_HUGETLB_2GB] = {
> >                         .name = "anonymous_hugetlb_2gb",
> > -                       .flag = MAP_HUGETLB | MAP_HUGE_2GB,
> > +                       .flag = anon_huge_flags | MAP_HUGE_2GB,
> >                 },
> >                 [VM_MEM_SRC_ANONYMOUS_HUGETLB_16GB] = {
> >                         .name = "anonymous_hugetlb_16gb",
> > -                       .flag = MAP_HUGETLB | MAP_HUGE_16GB,
> > +                       .flag = anon_huge_flags | MAP_HUGE_16GB,
> >                 },
> >         };
> >         _Static_assert(ARRAY_SIZE(aliases) == NUM_SRC_TYPES,
> > --
> > 2.31.1.751.gd2f1c929bd-goog
> >
