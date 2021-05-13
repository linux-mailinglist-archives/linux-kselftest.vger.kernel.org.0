Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E32737FFE3
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 May 2021 23:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbhEMVrm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 May 2021 17:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbhEMVrm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 May 2021 17:47:42 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE20C061756
        for <linux-kselftest@vger.kernel.org>; Thu, 13 May 2021 14:46:31 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id z24so26354539ioj.7
        for <linux-kselftest@vger.kernel.org>; Thu, 13 May 2021 14:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PJaJODXKMxjVlXSx3cQ/3A1Pv1xFsKF6bksiX7iej1w=;
        b=J1DE9syfxUpi567p+3iZMa59SpwJFqHrKG4xgw70Iqd/MDnKI+O6GFSeSsyyYr2CZD
         S93zeGFmXMaKr/PGheaB1+3NsWiCFwWzQgcr64QvRJlyr1x5BZPO3UlIQko4/Rikt7Im
         BfU18WHoZH2Q+Il+1T0NCbEB1DtkvDzykoE4WvExCQOIMoONp2MA0WhPHE8LexDl0/Pp
         BCnZ3P8X+w6B2zHdnyVyHrCidJBQU75TIqXvLuuWQ8xPzf2UxqUuT0m/BRqFoDO1wI4W
         SSBhwMc9xcIlMAFU4fVo6wtUrsRvOuJg63gxvWjP6bhMpolytl7HEkUyzaARZCvJsPuz
         3JrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PJaJODXKMxjVlXSx3cQ/3A1Pv1xFsKF6bksiX7iej1w=;
        b=MBYE7Fb6md27SjQQG9bBY8frfL+fnbyGmJsiFDbOYDpQLhTmjBnlurWjkjv9cGlmRF
         CqfvALMtSOvaGBAWpjUf1Jkl0P8ah1MB+Zyq1gMn5G5SuqfMkG8xbgr7JkQID8hSRUkq
         AgWqV5pa2SccFxAjav/TjjYTcg10nZUr88vOCgslK4cycK77RsuAQ4FzKe1aTt0ZzQx0
         iiGPtEkXujQ4d7NwBf/hvHV0xbSuSTxz+c/gNyTM9inqwrTEc2waTInDG+hKcQVT0lui
         FSqEuiNA/6mdio12K3Tu1EEsUPcMNK934RPfKrJ62MjcGlEYnPG7aWgV/TXDIyeAZ77S
         IV0Q==
X-Gm-Message-State: AOAM532PJ9C39WLYca/KFcyWoQ7tBb4ZLoN2xsrKtiQiFQFwGgjwCHGY
        6svUReN8TGoqNqODWFuc8kydaKu0tJVXBAgv8Hh4Vw==
X-Google-Smtp-Source: ABdhPJwHA1X23SBWLtydFi8RhMZdCdRgnlBgyMvFBLLoxcobU7j8cKcQ4rtLggmO4DJgEyaXmrgj0a+5UVDJXYBK6d8=
X-Received: by 2002:a02:b057:: with SMTP id q23mr18067476jah.25.1620942391036;
 Thu, 13 May 2021 14:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210512214502.2047008-1-axelrasmussen@google.com> <20210512214502.2047008-3-axelrasmussen@google.com>
In-Reply-To: <20210512214502.2047008-3-axelrasmussen@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Thu, 13 May 2021 14:46:20 -0700
Message-ID: <CANgfPd_th954ugsyEDj-hHjpeeo0_ho+ALF4puiDh1RNpDHqyg@mail.gmail.com>
Subject: Re: [PATCH 2/5] KVM: selftests: add shmem backing source type
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

On Wed, May 12, 2021 at 2:45 PM Axel Rasmussen <axelrasmussen@google.com> wrote:
>
> This lets us run the demand paging test on top of a shmem-backed area.
> In follow-up commits, we'll 1) leverage this new capability to create an
> alias mapping, and then 2) use the alias mapping to exercise UFFD minor
> faults.
>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  .../testing/selftests/kvm/include/test_util.h |  1 +
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 24 ++++++++---
>  tools/testing/selftests/kvm/lib/test_util.c   | 40 +++++++++++--------
>  3 files changed, 44 insertions(+), 21 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
> index fade3130eb01..7377f00469ef 100644
> --- a/tools/testing/selftests/kvm/include/test_util.h
> +++ b/tools/testing/selftests/kvm/include/test_util.h
> @@ -84,6 +84,7 @@ enum vm_mem_backing_src_type {
>         VM_MEM_SRC_ANONYMOUS_HUGETLB_1GB,
>         VM_MEM_SRC_ANONYMOUS_HUGETLB_2GB,
>         VM_MEM_SRC_ANONYMOUS_HUGETLB_16GB,
> +       VM_MEM_SRC_SHMEM,
>         NUM_SRC_TYPES,
>  };
>
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index fc83f6c5902d..6fbe124e0e16 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -663,8 +663,8 @@ int kvm_memcmp_hva_gva(void *hva, struct kvm_vm *vm, vm_vaddr_t gva, size_t len)
>   *
>   * Input Args:
>   *   vm - Virtual Machine
> - *   backing_src - Storage source for this region.
> - *                 NULL to use anonymous memory.
> + *   src_type - Storage source for this region.
> + *              NULL to use anonymous memory.

It would probably make sense to separate this rename out into a separate commit.

>   *   guest_paddr - Starting guest physical address
>   *   slot - KVM region slot
>   *   npages - Number of physical pages
> @@ -755,11 +755,25 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
>         if (alignment > 1)
>                 region->mmap_size += alignment;
>
> +       region->fd = -1;
> +       if (src_type == VM_MEM_SRC_SHMEM) {
> +               region->fd = memfd_create("kvm_selftest", MFD_CLOEXEC);
> +               TEST_ASSERT(region->fd != -1,
> +                           "memfd_create failed, errno: %i", errno);
> +
> +               ret = ftruncate(region->fd, region->mmap_size);
> +               TEST_ASSERT(ret == 0, "ftruncate failed, errno: %i", errno);
> +
> +               ret = fallocate(region->fd,
> +                               FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0,
> +                               region->mmap_size);
> +               TEST_ASSERT(ret == 0, "fallocate failed, errno: %i", errno);
> +       }
> +
>         region->mmap_start = mmap(NULL, region->mmap_size,
>                                   PROT_READ | PROT_WRITE,
> -                                 MAP_PRIVATE | MAP_ANONYMOUS
> -                                 | vm_mem_backing_src_alias(src_type)->flag,
> -                                 -1, 0);
> +                                 vm_mem_backing_src_alias(src_type)->flag,
> +                                 region->fd, 0);
>         TEST_ASSERT(region->mmap_start != MAP_FAILED,
>                     "test_malloc failed, mmap_start: %p errno: %i",
>                     region->mmap_start, errno);
> diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
> index 63d2bc7d757b..c7a265da5090 100644
> --- a/tools/testing/selftests/kvm/lib/test_util.c
> +++ b/tools/testing/selftests/kvm/lib/test_util.c
> @@ -168,70 +168,77 @@ size_t get_def_hugetlb_pagesz(void)
>
>  const struct vm_mem_backing_src_alias *vm_mem_backing_src_alias(uint32_t i)
>  {
> +       static const int anon_flags = MAP_PRIVATE | MAP_ANONYMOUS;
> +       static const int anon_huge_flags = anon_flags | MAP_HUGETLB;
> +
>         static const struct vm_mem_backing_src_alias aliases[] = {
>                 [VM_MEM_SRC_ANONYMOUS] = {
>                         .name = "anonymous",
> -                       .flag = 0,
> +                       .flag = anon_flags,

You could also do this refactoring in a separate commit, which would
make the change to support shmem quite small.

>                 },
>                 [VM_MEM_SRC_ANONYMOUS_THP] = {
>                         .name = "anonymous_thp",
> -                       .flag = 0,
> +                       .flag = anon_flags,
>                 },
>                 [VM_MEM_SRC_ANONYMOUS_HUGETLB] = {
>                         .name = "anonymous_hugetlb",
> -                       .flag = MAP_HUGETLB,
> +                       .flag = anon_huge_flags,
>                 },
>                 [VM_MEM_SRC_ANONYMOUS_HUGETLB_16KB] = {
>                         .name = "anonymous_hugetlb_16kb",
> -                       .flag = MAP_HUGETLB | MAP_HUGE_16KB,
> +                       .flag = anon_huge_flags | MAP_HUGE_16KB,
>                 },
>                 [VM_MEM_SRC_ANONYMOUS_HUGETLB_64KB] = {
>                         .name = "anonymous_hugetlb_64kb",
> -                       .flag = MAP_HUGETLB | MAP_HUGE_64KB,
> +                       .flag = anon_huge_flags | MAP_HUGE_64KB,
>                 },
>                 [VM_MEM_SRC_ANONYMOUS_HUGETLB_512KB] = {
>                         .name = "anonymous_hugetlb_512kb",
> -                       .flag = MAP_HUGETLB | MAP_HUGE_512KB,
> +                       .flag = anon_huge_flags | MAP_HUGE_512KB,
>                 },
>                 [VM_MEM_SRC_ANONYMOUS_HUGETLB_1MB] = {
>                         .name = "anonymous_hugetlb_1mb",
> -                       .flag = MAP_HUGETLB | MAP_HUGE_1MB,
> +                       .flag = anon_huge_flags | MAP_HUGE_1MB,
>                 },
>                 [VM_MEM_SRC_ANONYMOUS_HUGETLB_2MB] = {
>                         .name = "anonymous_hugetlb_2mb",
> -                       .flag = MAP_HUGETLB | MAP_HUGE_2MB,
> +                       .flag = anon_huge_flags | MAP_HUGE_2MB,
>                 },
>                 [VM_MEM_SRC_ANONYMOUS_HUGETLB_8MB] = {
>                         .name = "anonymous_hugetlb_8mb",
> -                       .flag = MAP_HUGETLB | MAP_HUGE_8MB,
> +                       .flag = anon_huge_flags | MAP_HUGE_8MB,
>                 },
>                 [VM_MEM_SRC_ANONYMOUS_HUGETLB_16MB] = {
>                         .name = "anonymous_hugetlb_16mb",
> -                       .flag = MAP_HUGETLB | MAP_HUGE_16MB,
> +                       .flag = anon_huge_flags | MAP_HUGE_16MB,
>                 },
>                 [VM_MEM_SRC_ANONYMOUS_HUGETLB_32MB] = {
>                         .name = "anonymous_hugetlb_32mb",
> -                       .flag = MAP_HUGETLB | MAP_HUGE_32MB,
> +                       .flag = anon_huge_flags | MAP_HUGE_32MB,
>                 },
>                 [VM_MEM_SRC_ANONYMOUS_HUGETLB_256MB] = {
>                         .name = "anonymous_hugetlb_256mb",
> -                       .flag = MAP_HUGETLB | MAP_HUGE_256MB,
> +                       .flag = anon_huge_flags | MAP_HUGE_256MB,
>                 },
>                 [VM_MEM_SRC_ANONYMOUS_HUGETLB_512MB] = {
>                         .name = "anonymous_hugetlb_512mb",
> -                       .flag = MAP_HUGETLB | MAP_HUGE_512MB,
> +                       .flag = anon_huge_flags | MAP_HUGE_512MB,
>                 },
>                 [VM_MEM_SRC_ANONYMOUS_HUGETLB_1GB] = {
>                         .name = "anonymous_hugetlb_1gb",
> -                       .flag = MAP_HUGETLB | MAP_HUGE_1GB,
> +                       .flag = anon_huge_flags | MAP_HUGE_1GB,
>                 },
>                 [VM_MEM_SRC_ANONYMOUS_HUGETLB_2GB] = {
>                         .name = "anonymous_hugetlb_2gb",
> -                       .flag = MAP_HUGETLB | MAP_HUGE_2GB,
> +                       .flag = anon_huge_flags | MAP_HUGE_2GB,
>                 },
>                 [VM_MEM_SRC_ANONYMOUS_HUGETLB_16GB] = {
>                         .name = "anonymous_hugetlb_16gb",
> -                       .flag = MAP_HUGETLB | MAP_HUGE_16GB,
> +                       .flag = anon_huge_flags | MAP_HUGE_16GB,
> +               },
> +               [VM_MEM_SRC_SHMEM] = {
> +                       .name = "shmem",
> +                       .flag = MAP_SHARED,
>                 },
>         };
>         _Static_assert(ARRAY_SIZE(aliases) == NUM_SRC_TYPES,
> @@ -250,6 +257,7 @@ size_t get_backing_src_pagesz(uint32_t i)
>
>         switch (i) {
>         case VM_MEM_SRC_ANONYMOUS:
> +       case VM_MEM_SRC_SHMEM:
>                 return getpagesize();
>         case VM_MEM_SRC_ANONYMOUS_THP:
>                 return get_trans_hugepagesz();
> --
> 2.31.1.607.g51e8a6a459-goog
>
