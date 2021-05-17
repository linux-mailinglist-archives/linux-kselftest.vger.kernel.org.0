Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEBB2386DFC
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 May 2021 01:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344714AbhEQX7H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 May 2021 19:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344653AbhEQX7G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 May 2021 19:59:06 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC53C06175F
        for <linux-kselftest@vger.kernel.org>; Mon, 17 May 2021 16:57:48 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id c16so7605867ilo.1
        for <linux-kselftest@vger.kernel.org>; Mon, 17 May 2021 16:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vOazABg9O+2XA5M9CuZX/N0TNZ6RBivTs+Mo+Q+WgWs=;
        b=KmRIRoilurSyzHxqWjtm94m0ajkMPMP3RarWiSMgcfsV4vufHyJFf64a4L8+tpY4OM
         wpqYdIxQ1vny3/no9PGGwuMFpDztqBc3weA9Xwt7Zg4tI/zMi66/ZZijXKZNLSVqkmrS
         LYXEQvEDFjbni661NfXnOxfk2zmaPrQ3+vDPLfGHDncfGUXfHT02GIF7ricWHFYhQZNM
         6nTVCMCSRBVq0DhwKVP//mkTY72d7m6bUtkt5ZDW6dBvL34Xlu7AtzUGUjRi2UayPrV1
         JeXj7KTRY1XIatq7pq++OFnkbo9S5+UgGNZsyX3cp/axcZj2YzeIbDy0ntm8p52VPFY3
         ukUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vOazABg9O+2XA5M9CuZX/N0TNZ6RBivTs+Mo+Q+WgWs=;
        b=Jnd2AtAyk0oVVapxsmUZxSGefjNUcCkj+chBXmbgGy2JrQBWp/CZ3gBagJFDNI3JQF
         510z8D5/XbAOjLclBCXAqxXm6/4KQvMftiPAWjiVTplHuXt2dff+C7yBdF4FzMvmFohP
         PsQah466R2gT77jpIA1eFjRQUDOuURvTH3LowjOcO6GZQgyqXvGjg+/7mh3fVyeWQp99
         +Ros5id3y7s8Bfbod5xrzph7Y7F5jBF/b7GIpGqcAmrOeN74xt5u/pxfHy1qKT9ID32S
         PISFeXtzCLLqrn+yxZjJSQ2e3iAvGkBd4+6E1F7b7kJv/M3vXsmBztgKE6cPVY8fpZgt
         cWgw==
X-Gm-Message-State: AOAM533Vn93dq4M7/iEFX6z89syb15JjBrKS2oQyTA3VefB1iKfj/y1U
        M9F5ltcvYFVEgfaMUNbORXyyD9DkL8lQwKqJUrsWQQ==
X-Google-Smtp-Source: ABdhPJxcMcCrR9keQbmzXUQr9lFt5sFgF2BdB25XfuMyFNfSbZddtliDhmfMSVEEhhKqyUGgR6F2DwK2DZR3zWhzgQw=
X-Received: by 2002:a05:6e02:1a49:: with SMTP id u9mr1959195ilv.306.1621295867710;
 Mon, 17 May 2021 16:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210512214502.2047008-1-axelrasmussen@google.com> <20210512214502.2047008-6-axelrasmussen@google.com>
In-Reply-To: <20210512214502.2047008-6-axelrasmussen@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Mon, 17 May 2021 16:57:37 -0700
Message-ID: <CANgfPd9tQ0vdKsf2vJn5QD+oDajWCyq_ShLPPpfsUum46tWHAg@mail.gmail.com>
Subject: Re: [PATCH 5/5] KVM: selftests: add shared hugetlbfs backing source type
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
> This lets us run the demand paging test on top of a shared
> hugetlbfs-backed area. The "shared" is key, as this allows us to
> exercise userfaultfd minor faults on hugetlbfs.
>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  tools/testing/selftests/kvm/demand_paging_test.c |  6 ++++--
>  tools/testing/selftests/kvm/include/test_util.h  | 10 ++++++++++
>  tools/testing/selftests/kvm/lib/kvm_util.c       |  9 +++++++--
>  tools/testing/selftests/kvm/lib/test_util.c      |  6 ++++++
>  4 files changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
> index ff29aaea3120..32942c9e0376 100644
> --- a/tools/testing/selftests/kvm/demand_paging_test.c
> +++ b/tools/testing/selftests/kvm/demand_paging_test.c
> @@ -502,8 +502,10 @@ int main(int argc, char *argv[])
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
> index 7377f00469ef..852d6d2cc285 100644
> --- a/tools/testing/selftests/kvm/include/test_util.h
> +++ b/tools/testing/selftests/kvm/include/test_util.h
> @@ -85,9 +85,19 @@ enum vm_mem_backing_src_type {
>         VM_MEM_SRC_ANONYMOUS_HUGETLB_2GB,
>         VM_MEM_SRC_ANONYMOUS_HUGETLB_16GB,
>         VM_MEM_SRC_SHMEM,
> +       VM_MEM_SRC_SHARED_HUGETLB,
>         NUM_SRC_TYPES,
>  };
>
> +/*
> + * Whether or not the given source type is shared memory (as opposed to
> + * anonymous).
> + */
> +static inline bool backing_src_is_shared(enum vm_mem_backing_src_type t)
> +{
> +       return t == VM_MEM_SRC_SHMEM || t == VM_MEM_SRC_SHARED_HUGETLB;
> +}

Would it make sense to check (vm_mem_backing_src_alias(t)->flag &
MAP_SHARED) == MAP_SHARED instead?

> +
>  struct vm_mem_backing_src_alias {
>         const char *name;
>         uint32_t flag;
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 838d58633f7e..fed02153c919 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -756,8 +756,13 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
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
> index c7a265da5090..65fb8b43782c 100644
> --- a/tools/testing/selftests/kvm/lib/test_util.c
> +++ b/tools/testing/selftests/kvm/lib/test_util.c
> @@ -240,6 +240,11 @@ const struct vm_mem_backing_src_alias *vm_mem_backing_src_alias(uint32_t i)
>                         .name = "shmem",
>                         .flag = MAP_SHARED,
>                 },
> +               [VM_MEM_SRC_SHARED_HUGETLB] = {
> +                       .name = "shared_hugetlb",
> +                       /* No MAP_HUGETLB, we use MFD_HUGETLB instead. */

Is it worth calling out the difference between the two flags here?

> +                       .flag = MAP_SHARED,
> +               },
>         };
>         _Static_assert(ARRAY_SIZE(aliases) == NUM_SRC_TYPES,
>                        "Missing new backing src types?");
> @@ -262,6 +267,7 @@ size_t get_backing_src_pagesz(uint32_t i)
>         case VM_MEM_SRC_ANONYMOUS_THP:
>                 return get_trans_hugepagesz();
>         case VM_MEM_SRC_ANONYMOUS_HUGETLB:
> +       case VM_MEM_SRC_SHARED_HUGETLB:
>                 return get_def_hugetlb_pagesz();
>         default:
>                 return MAP_HUGE_PAGE_SIZE(flag);
> --
> 2.31.1.607.g51e8a6a459-goog
>
