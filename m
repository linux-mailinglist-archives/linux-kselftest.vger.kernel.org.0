Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF9B38993C
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 May 2021 00:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhESWY0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 May 2021 18:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhESWYZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 May 2021 18:24:25 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5435EC06175F
        for <linux-kselftest@vger.kernel.org>; Wed, 19 May 2021 15:23:04 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id m1so11847542ilg.10
        for <linux-kselftest@vger.kernel.org>; Wed, 19 May 2021 15:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jigGkZnQgSorV8Mg2Cjdnn0fCjUWDFqzgL3jWN5co0M=;
        b=Z6+XBUdlLWB1ipUyyhhi144nue+BGQmkOw8zGgLR850hWI8A+CNd/bbwDXNJUXeehC
         cqwVdvJV/z8aeZ2gax/xc50dtiy7b22d+axbvN8U3cVCQCpoo+zRPz8afSqhMOFhHFu/
         DbSGfGzD/BJntFBwfkjn1iehKlaVkVTKCgh7vUrsh0aZF6q4OOkSGtQFtFVEs/h+3Zbk
         dCwUwwUVw7VScgBJSgywiigY3CBdB8uJ76CantEW8yfLf+lAe4FgocsRPdXgQysp53Rp
         tyCXjei7LLFVPW5lbAWqu66l9dJ0wcV2pjpgZ8jwtuwYFWHeyEXViGKxQ8iFHkq+QIlR
         OZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jigGkZnQgSorV8Mg2Cjdnn0fCjUWDFqzgL3jWN5co0M=;
        b=aGAZygSfJBzqZxLR8tK/a4ephkxqrtIOYR1tR9E3upiAKcl1Mq/mMeO/sdxSR4okUZ
         /djKTiIT8Kx+YRZetLoeDsa9XsMvuZwza828lmBucFo5atLn2eT/kOpNU4xuYIj/15BL
         cBoN+mcupiKXFARkBgLeMI52RxrteGmge738fuDuM0zuoeAvyWgEbR1g9Loj3elJbTqX
         +umcv0/b8Q+zgHzyMCIQoXM10c8cO/jlT7heYRK56in6sx6q1YJpOhsTUD2oahSV6Dgq
         BW47JdbwhgGoOJkHH4PN33Dev94GeGFwTy+UWXZ1rDQMAvkdzBSdFXy7uQMSolyAWyd6
         HK8g==
X-Gm-Message-State: AOAM530piiyZH9TKr6tna+KPS5cQ5qZWUxhjgxJEInHzwMh5CqDnR4qu
        OCqZDlSwVh5AeTvtM7u+scPRHpCW5Cwzqblmh0coaA==
X-Google-Smtp-Source: ABdhPJyzAvav949t4t1dqRxImvWLHNk+KnfNQNliKkI/l0/PpRi8FRrO9MEAZYkerhf6uEjacwyts5pOP/C01Gy+7lY=
X-Received: by 2002:a05:6e02:13ec:: with SMTP id w12mr1605327ilj.285.1621462983465;
 Wed, 19 May 2021 15:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210519200339.829146-1-axelrasmussen@google.com> <20210519200339.829146-11-axelrasmussen@google.com>
In-Reply-To: <20210519200339.829146-11-axelrasmussen@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Wed, 19 May 2021 15:22:52 -0700
Message-ID: <CANgfPd9EfARN3eo1SuNfvkAsY+wVh=PoJZUy6r4=S1XLib6OGA@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] KVM: selftests: add shared hugetlbfs backing
 source type
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

On Wed, May 19, 2021 at 1:04 PM Axel Rasmussen <axelrasmussen@google.com> wrote:
>
> This lets us run the demand paging test on top of a shared
> hugetlbfs-backed area. The "shared" is key, as this allows us to
> exercise userfaultfd minor faults on hugetlbfs.
>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Reviewed-by: Ben Gardon <bgardon@google.com>

> ---
>  tools/testing/selftests/kvm/demand_paging_test.c |  6 ++++--
>  tools/testing/selftests/kvm/include/test_util.h  | 11 +++++++++++
>  tools/testing/selftests/kvm/lib/kvm_util.c       |  9 +++++++--
>  tools/testing/selftests/kvm/lib/test_util.c      | 11 +++++++++++
>  4 files changed, 33 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
> index df7190261923..60d9b5223b9d 100644
> --- a/tools/testing/selftests/kvm/demand_paging_test.c
> +++ b/tools/testing/selftests/kvm/demand_paging_test.c
> @@ -485,8 +485,10 @@ int main(int argc, char *argv[])
>                 }
>         }
>
> -       TEST_ASSERT(p.uffd_mode != UFFDIO_REGISTER_MODE_MINOR || p.src_type == VM_MEM_SRC_SHMEM,
> -                   "userfaultfd MINOR mode requires shared memory; pick a different -t");
> +       if (p.uffd_mode == UFFDIO_REGISTER_MODE_MINOR &&
> +           !backing_src_is_shared(p.src_type)) {
> +               TEST_FAIL("userfaultfd MINOR mode requires shared memory; pick a different -t");
> +       }
>
>         for_each_guest_mode(run_test, &p);
>
> diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
> index 7377f00469ef..d79be15dd3d2 100644
> --- a/tools/testing/selftests/kvm/include/test_util.h
> +++ b/tools/testing/selftests/kvm/include/test_util.h
> @@ -17,6 +17,7 @@
>  #include <errno.h>
>  #include <unistd.h>
>  #include <fcntl.h>
> +#include <sys/mman.h>
>  #include "kselftest.h"
>
>  static inline int _no_printf(const char *format, ...) { return 0; }
> @@ -85,6 +86,7 @@ enum vm_mem_backing_src_type {
>         VM_MEM_SRC_ANONYMOUS_HUGETLB_2GB,
>         VM_MEM_SRC_ANONYMOUS_HUGETLB_16GB,
>         VM_MEM_SRC_SHMEM,
> +       VM_MEM_SRC_SHARED_HUGETLB,
>         NUM_SRC_TYPES,
>  };
>
> @@ -101,4 +103,13 @@ size_t get_backing_src_pagesz(uint32_t i);
>  void backing_src_help(void);
>  enum vm_mem_backing_src_type parse_backing_src_type(const char *type_name);
>
> +/*
> + * Whether or not the given source type is shared memory (as opposed to
> + * anonymous).
> + */
> +static inline bool backing_src_is_shared(enum vm_mem_backing_src_type t)
> +{
> +       return vm_mem_backing_src_alias(t)->flag & MAP_SHARED;
> +}
> +
>  #endif /* SELFTEST_KVM_TEST_UTIL_H */
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 0b88d1bbc1e0..8373aec1fb02 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -758,8 +758,13 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
>                 region->mmap_size += alignment;
>
>         region->fd = -1;
> -       if (src_type == VM_MEM_SRC_SHMEM) {
> -               region->fd = memfd_create("kvm_selftest", MFD_CLOEXEC);
> +       if (backing_src_is_shared(src_type)) {
> +               int memfd_flags = MFD_CLOEXEC;
> +
> +               if (src_type == VM_MEM_SRC_SHARED_HUGETLB)
> +                       memfd_flags |= MFD_HUGETLB;
> +
> +               region->fd = memfd_create("kvm_selftest", memfd_flags);
>                 TEST_ASSERT(region->fd != -1,
>                             "memfd_create failed, errno: %i", errno);
>
> diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
> index c7a265da5090..6ad6c8276b2e 100644
> --- a/tools/testing/selftests/kvm/lib/test_util.c
> +++ b/tools/testing/selftests/kvm/lib/test_util.c
> @@ -240,6 +240,16 @@ const struct vm_mem_backing_src_alias *vm_mem_backing_src_alias(uint32_t i)
>                         .name = "shmem",
>                         .flag = MAP_SHARED,
>                 },
> +               [VM_MEM_SRC_SHARED_HUGETLB] = {
> +                       .name = "shared_hugetlb",
> +                       /*
> +                        * No MAP_HUGETLB, we use MFD_HUGETLB instead. Since
> +                        * we're using "file backed" memory, we need to specify
> +                        * this when the FD is created, not when the area is
> +                        * mapped.
> +                        */
> +                       .flag = MAP_SHARED,
> +               },
>         };
>         _Static_assert(ARRAY_SIZE(aliases) == NUM_SRC_TYPES,
>                        "Missing new backing src types?");
> @@ -262,6 +272,7 @@ size_t get_backing_src_pagesz(uint32_t i)
>         case VM_MEM_SRC_ANONYMOUS_THP:
>                 return get_trans_hugepagesz();
>         case VM_MEM_SRC_ANONYMOUS_HUGETLB:
> +       case VM_MEM_SRC_SHARED_HUGETLB:
>                 return get_def_hugetlb_pagesz();
>         default:
>                 return MAP_HUGE_PAGE_SIZE(flag);
> --
> 2.31.1.751.gd2f1c929bd-goog
>
