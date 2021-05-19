Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0929B389943
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 May 2021 00:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhESW0p (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 May 2021 18:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhESW0n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 May 2021 18:26:43 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424A6C061574
        for <linux-kselftest@vger.kernel.org>; Wed, 19 May 2021 15:25:22 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id k16so14604604ios.10
        for <linux-kselftest@vger.kernel.org>; Wed, 19 May 2021 15:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lFxp5Wo5o8KVeHp1UFWe95+41R0OvdliXrOKe6C2icQ=;
        b=mLnewFJkeeJSpCJWt4VqJyF90CI/PtHxpmF3KzTsZUR3TvUmWFbS7Elq/2JHtCfcxe
         HRODcbL/3wgoESreTVUidJGGaTCTNHC9LeZuLMzUaAijHXAOQ/0qO5CBngdwCLm+PRNu
         3jDYarfXCWVEJ19r2SWg8pMT1e0m3mFvMkTKnEILP6XWgI0psLvSVDxmZXGyYsyGcm06
         ob/rp2UobM9Ez19oqjnMuiniGVOPQHGqWMb2/Bg+S9OH3oVOPHDHB3fYla8oKRhXXTpo
         kKMiHKkaWWLxv0wBJSPFXew5aQ2wutS7uA2IuNnhgvjRGmbpdnUrH0d8009X80wOfYdm
         MJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lFxp5Wo5o8KVeHp1UFWe95+41R0OvdliXrOKe6C2icQ=;
        b=UXBoKtC7M/QhHYsQTAOKiPjfMCnXNNzrwb7AIyCLE376l8BJ5YOuYYHoGteyH+SCBv
         NjUBfXLtSx/Y27I8p/jxda/GU9BJvsXCa+YGIbHMxzDjtC9UdXJONbf+QoNKOaXS7MyE
         r/UCb4GqGGuU+l0VIkH0HYwL7gNCLmlsOwoJD9tfi9icihJw5sP3JnRKu/INjq/Bb0E+
         XxZryd0PM+RQ0bqKPOdo08pbi7Gs3gae0gIfUUmSuqto3iWtcj1FeeJD5wDN+Z1K3lUZ
         Utgy9ewwXwBfMDbVcWZcY8YJ6f3qLWyNWigDva6alEfox7YXB1bA/G3tEseL678pe0LH
         eUug==
X-Gm-Message-State: AOAM532y0Fza6AVnw6uyQXs/7QeN/RB4pn9rwIW5hTeG1W8/l/T5wvCi
        E1rj2cgI8pT5BtTB5Eh0+/gaOIgps/HRDAHJdbTr/Q==
X-Google-Smtp-Source: ABdhPJzfpozcvCfE5cxMXYtwUSKnQSzRGz6Wf64p8UV1W/+Wg3OT2t0l6IjI+DEPjyWJvD+On9NH7zP+W1hfV8Fju+Q=
X-Received: by 2002:a05:6638:3395:: with SMTP id h21mr1798024jav.44.1621463121394;
 Wed, 19 May 2021 15:25:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210519200339.829146-1-axelrasmussen@google.com>
 <20210519200339.829146-7-axelrasmussen@google.com> <CANgfPd-RuScC1BONf2wBSSJ=GQE5yW=BK4g18L3R2Ebn__+PAg@mail.gmail.com>
 <CAJHvVchMMse=CcSUnHGDXLKd0YSa3wTvyyyPjT8MU3RmmwAXtQ@mail.gmail.com>
In-Reply-To: <CAJHvVchMMse=CcSUnHGDXLKd0YSa3wTvyyyPjT8MU3RmmwAXtQ@mail.gmail.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Wed, 19 May 2021 15:25:10 -0700
Message-ID: <CANgfPd-_LgX5bf=GG=_CGHS9gNpeiiuW+_UseoirPuBasWU4tQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] KVM: selftests: refactor vm_mem_backing_src_type flags
To:     Axel Rasmussen <axelrasmussen@google.com>
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

On Wed, May 19, 2021 at 3:17 PM Axel Rasmussen <axelrasmussen@google.com> wrote:
>
> On Wed, May 19, 2021 at 3:02 PM Ben Gardon <bgardon@google.com> wrote:
> >
> > On Wed, May 19, 2021 at 1:04 PM Axel Rasmussen <axelrasmussen@google.com> wrote:
> > >
> > > Each struct vm_mem_backing_src_alias has a flags field, which denotes
> > > the flags used to mmap() an area of that type. Previously, this field
> > > never included MAP_PRIVATE | MAP_ANONYMOUS, because
> > > vm_userspace_mem_region_add assumed that *all* types would always use
> > > those flags, and so it hardcoded them.
> > >
> > > In a follow-up commit, we'll add a new type: shmem. Areas of this type
> > > must not have MAP_PRIVATE | MAP_ANONYMOUS, and instead they must have
> > > MAP_SHARED.
> > >
> > > So, refactor things. Make it so that the flags field of
> > > struct vm_mem_backing_src_alias really is a complete set of flags, and
> > > don't add in any extras in vm_userspace_mem_region_add. This will let us
> > > easily tack on shmem.
> > >
> > > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > > ---
> > >  tools/testing/selftests/kvm/lib/kvm_util.c  |  5 ++-
> > >  tools/testing/selftests/kvm/lib/test_util.c | 35 +++++++++++----------
> > >  2 files changed, 21 insertions(+), 19 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> > > index 0d6ddee429b9..bc405785ac8b 100644
> > > --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> > > +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> > > @@ -759,9 +759,8 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
> > >
> > >         region->mmap_start = mmap(NULL, region->mmap_size,
> > >                                   PROT_READ | PROT_WRITE,
> > > -                                 MAP_PRIVATE | MAP_ANONYMOUS
> > > -                                 | vm_mem_backing_src_alias(src_type)->flag,
> > > -                                 -1, 0);
> > > +                                 vm_mem_backing_src_alias(src_type)->flag,
> > > +                                 region->fd, 0);
> >
> > I don't see the region->fd change mentioned in the patch description
> > or elsewhere in this patch. Is something setting region->fd to -1 or
> > should this be part of another patch in the series?
>
> Ah, apologies, this is a mistake from splitting up the commits. When
> they were all squashed together, we set region->fd = -1 explicitly
> just above here, but with them separated we can't depend on that. I'll
> fix this in a v3.

Thanks for fixing that and thanks for splitting up the patches in this
series. It made them super easy to review.

>
> >
> > >         TEST_ASSERT(region->mmap_start != MAP_FAILED,
> > >                     "test_malloc failed, mmap_start: %p errno: %i",
> > >                     region->mmap_start, errno);
> > > diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
> > > index 63d2bc7d757b..06ddde068736 100644
> > > --- a/tools/testing/selftests/kvm/lib/test_util.c
> > > +++ b/tools/testing/selftests/kvm/lib/test_util.c
> > > @@ -168,70 +168,73 @@ size_t get_def_hugetlb_pagesz(void)
> > >
> > >  const struct vm_mem_backing_src_alias *vm_mem_backing_src_alias(uint32_t i)
> > >  {
> > > +       static const int anon_flags = MAP_PRIVATE | MAP_ANONYMOUS;
> > > +       static const int anon_huge_flags = anon_flags | MAP_HUGETLB;
> > > +
> > >         static const struct vm_mem_backing_src_alias aliases[] = {
> > >                 [VM_MEM_SRC_ANONYMOUS] = {
> > >                         .name = "anonymous",
> > > -                       .flag = 0,
> > > +                       .flag = anon_flags,
> > >                 },
> > >                 [VM_MEM_SRC_ANONYMOUS_THP] = {
> > >                         .name = "anonymous_thp",
> > > -                       .flag = 0,
> > > +                       .flag = anon_flags,
> > >                 },
> > >                 [VM_MEM_SRC_ANONYMOUS_HUGETLB] = {
> > >                         .name = "anonymous_hugetlb",
> > > -                       .flag = MAP_HUGETLB,
> > > +                       .flag = anon_huge_flags,
> > >                 },
> > >                 [VM_MEM_SRC_ANONYMOUS_HUGETLB_16KB] = {
> > >                         .name = "anonymous_hugetlb_16kb",
> > > -                       .flag = MAP_HUGETLB | MAP_HUGE_16KB,
> > > +                       .flag = anon_huge_flags | MAP_HUGE_16KB,
> > >                 },
> > >                 [VM_MEM_SRC_ANONYMOUS_HUGETLB_64KB] = {
> > >                         .name = "anonymous_hugetlb_64kb",
> > > -                       .flag = MAP_HUGETLB | MAP_HUGE_64KB,
> > > +                       .flag = anon_huge_flags | MAP_HUGE_64KB,
> > >                 },
> > >                 [VM_MEM_SRC_ANONYMOUS_HUGETLB_512KB] = {
> > >                         .name = "anonymous_hugetlb_512kb",
> > > -                       .flag = MAP_HUGETLB | MAP_HUGE_512KB,
> > > +                       .flag = anon_huge_flags | MAP_HUGE_512KB,
> > >                 },
> > >                 [VM_MEM_SRC_ANONYMOUS_HUGETLB_1MB] = {
> > >                         .name = "anonymous_hugetlb_1mb",
> > > -                       .flag = MAP_HUGETLB | MAP_HUGE_1MB,
> > > +                       .flag = anon_huge_flags | MAP_HUGE_1MB,
> > >                 },
> > >                 [VM_MEM_SRC_ANONYMOUS_HUGETLB_2MB] = {
> > >                         .name = "anonymous_hugetlb_2mb",
> > > -                       .flag = MAP_HUGETLB | MAP_HUGE_2MB,
> > > +                       .flag = anon_huge_flags | MAP_HUGE_2MB,
> > >                 },
> > >                 [VM_MEM_SRC_ANONYMOUS_HUGETLB_8MB] = {
> > >                         .name = "anonymous_hugetlb_8mb",
> > > -                       .flag = MAP_HUGETLB | MAP_HUGE_8MB,
> > > +                       .flag = anon_huge_flags | MAP_HUGE_8MB,
> > >                 },
> > >                 [VM_MEM_SRC_ANONYMOUS_HUGETLB_16MB] = {
> > >                         .name = "anonymous_hugetlb_16mb",
> > > -                       .flag = MAP_HUGETLB | MAP_HUGE_16MB,
> > > +                       .flag = anon_huge_flags | MAP_HUGE_16MB,
> > >                 },
> > >                 [VM_MEM_SRC_ANONYMOUS_HUGETLB_32MB] = {
> > >                         .name = "anonymous_hugetlb_32mb",
> > > -                       .flag = MAP_HUGETLB | MAP_HUGE_32MB,
> > > +                       .flag = anon_huge_flags | MAP_HUGE_32MB,
> > >                 },
> > >                 [VM_MEM_SRC_ANONYMOUS_HUGETLB_256MB] = {
> > >                         .name = "anonymous_hugetlb_256mb",
> > > -                       .flag = MAP_HUGETLB | MAP_HUGE_256MB,
> > > +                       .flag = anon_huge_flags | MAP_HUGE_256MB,
> > >                 },
> > >                 [VM_MEM_SRC_ANONYMOUS_HUGETLB_512MB] = {
> > >                         .name = "anonymous_hugetlb_512mb",
> > > -                       .flag = MAP_HUGETLB | MAP_HUGE_512MB,
> > > +                       .flag = anon_huge_flags | MAP_HUGE_512MB,
> > >                 },
> > >                 [VM_MEM_SRC_ANONYMOUS_HUGETLB_1GB] = {
> > >                         .name = "anonymous_hugetlb_1gb",
> > > -                       .flag = MAP_HUGETLB | MAP_HUGE_1GB,
> > > +                       .flag = anon_huge_flags | MAP_HUGE_1GB,
> > >                 },
> > >                 [VM_MEM_SRC_ANONYMOUS_HUGETLB_2GB] = {
> > >                         .name = "anonymous_hugetlb_2gb",
> > > -                       .flag = MAP_HUGETLB | MAP_HUGE_2GB,
> > > +                       .flag = anon_huge_flags | MAP_HUGE_2GB,
> > >                 },
> > >                 [VM_MEM_SRC_ANONYMOUS_HUGETLB_16GB] = {
> > >                         .name = "anonymous_hugetlb_16gb",
> > > -                       .flag = MAP_HUGETLB | MAP_HUGE_16GB,
> > > +                       .flag = anon_huge_flags | MAP_HUGE_16GB,
> > >                 },
> > >         };
> > >         _Static_assert(ARRAY_SIZE(aliases) == NUM_SRC_TYPES,
> > > --
> > > 2.31.1.751.gd2f1c929bd-goog
> > >
