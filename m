Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22E4325A4B
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Feb 2021 00:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhBYXnj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 Feb 2021 18:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbhBYXni (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 Feb 2021 18:43:38 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7B5C061574
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Feb 2021 15:42:58 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id v8so2890974ilh.12
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Feb 2021 15:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XphAUbG60f0ERLCc6OAZU4eM2wreH7bgE4/Hsccw1VQ=;
        b=tcaXJM4pFjBOUGyrlT+AD3x0gZy3lr4vUnBA82I8J97gAY/r+Wbo5KFQKNhH+QK+Ye
         VdG/gLColnZP9NkLrsMwPBxd1JZRCCLwMMPXTNtdEEaAX8zm6yM1EwFa5HUR2cFOCmyA
         D6CiUKjIVVaQ9vFZJkuNB2Oxio27nJWRGHE0f6YMoeqWiHBLRnqpzafFtV4Cv0KDcfkU
         NtlI76N7V0XVaq03BzSDZL9CAUT7Q1P8FSi5/M7aRd0X6+Fvz8mdkMtDWURV0qzichsR
         4VuqG/6nrryVSRYPcu2y5GAsQckyNFAfrag6tnoR/opBuoj+mORijIzdfptff3fU30a2
         VP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XphAUbG60f0ERLCc6OAZU4eM2wreH7bgE4/Hsccw1VQ=;
        b=ABfp+bvQQsCTocwlbYSUR2ByBGF6TSCD9tXoOUK2K2gedXEDl/Nk/yzyiiirPH3i0+
         x1S+iB11EyYWOdnCZYduWoEZ27MXb9fReSc3JyFi18DUjPWdDzoQbVh5p3ekMumW2Zaz
         a6zbqNcaBWRKT+QPYXHe3g8A7LXcz8Jv2zZpg+vo5xZLK0jyS+laHyQ3Ph/FHy+IP6LV
         1tK0Bf0Jt5jCLBXiGtowEH66FNgMZ5CDjARjLjqLUdEFpPLOlwHehrTXumR/XRzgjv2r
         K1mmhuf+AOzU8EiO/ZsPwx9FS5Bw9/nd9uCjjQVHLA3g7/I67VXIpHOcW0xwVceWR76A
         Yg0Q==
X-Gm-Message-State: AOAM530sCaOammWKBECjE/zlc7lb5fJjcYIsrWGyKe5vMZ+RqEn5F7e7
        UGdsz52mXARLkP7HgCkPG3jcdaVmibr2GSCpG7yGeg==
X-Google-Smtp-Source: ABdhPJwQ7w2IQoMoat7euNiX4ImssD6FAt3/JQV09VvimKXcYQP7Er33/aPQbraJZ7q4YqDkhK/B4o/BxAhjaB8w+oY=
X-Received: by 2002:a92:c54e:: with SMTP id a14mr119129ilj.285.1614296577593;
 Thu, 25 Feb 2021 15:42:57 -0800 (PST)
MIME-Version: 1.0
References: <20210225055940.18748-1-wangyanan55@huawei.com> <20210225055940.18748-6-wangyanan55@huawei.com>
In-Reply-To: <20210225055940.18748-6-wangyanan55@huawei.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Thu, 25 Feb 2021 15:42:46 -0800
Message-ID: <CANgfPd_UQ8p020=Rnkh4b_Atup9GAyUmYacpYP0-zBpWcsXm3Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/7] KVM: selftests: List all hugetlb src types
 specified with page sizes
To:     Yanan Wang <wangyanan55@huawei.com>
Cc:     kvm <kvm@vger.kernel.org>, linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Peter Xu <peterx@redhat.com>, Marc Zyngier <maz@kernel.org>,
        wanghaibin.wang@huawei.com, yuzenghui@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 24, 2021 at 10:03 PM Yanan Wang <wangyanan55@huawei.com> wrote:
>
> With VM_MEM_SRC_ANONYMOUS_HUGETLB, we currently can only use system
> default hugetlb pages to back the testing guest memory. In order to
> add flexibility, now list all the known hugetlb backing src types with
> different page sizes, so that we can specify use of hugetlb pages of the
> exact granularity that we want. And as all the known hugetlb page sizes
> are listed, it's appropriate for all architectures.
>
> Besides, the helper get_backing_src_pagesz() is added to get the
> granularity of different backing src types(anonumous, thp, hugetlb).
>
> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
> ---
>  .../testing/selftests/kvm/include/test_util.h | 19 ++++++-
>  tools/testing/selftests/kvm/lib/kvm_util.c    |  2 +-
>  tools/testing/selftests/kvm/lib/test_util.c   | 56 +++++++++++++++----
>  3 files changed, 63 insertions(+), 14 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
> index ef24c76ba89a..be5d08bcdca7 100644
> --- a/tools/testing/selftests/kvm/include/test_util.h
> +++ b/tools/testing/selftests/kvm/include/test_util.h
> @@ -70,16 +70,31 @@ struct timespec timespec_div(struct timespec ts, int divisor);
>  enum vm_mem_backing_src_type {
>         VM_MEM_SRC_ANONYMOUS,
>         VM_MEM_SRC_ANONYMOUS_THP,
> -       VM_MEM_SRC_ANONYMOUS_HUGETLB,
> +       VM_MEM_SRC_ANONYMOUS_HUGETLB_16KB,
> +       VM_MEM_SRC_ANONYMOUS_HUGETLB_64KB,
> +       VM_MEM_SRC_ANONYMOUS_HUGETLB_512KB,
> +       VM_MEM_SRC_ANONYMOUS_HUGETLB_1MB,
> +       VM_MEM_SRC_ANONYMOUS_HUGETLB_2MB,
> +       VM_MEM_SRC_ANONYMOUS_HUGETLB_8MB,
> +       VM_MEM_SRC_ANONYMOUS_HUGETLB_16MB,
> +       VM_MEM_SRC_ANONYMOUS_HUGETLB_32MB,
> +       VM_MEM_SRC_ANONYMOUS_HUGETLB_256MB,
> +       VM_MEM_SRC_ANONYMOUS_HUGETLB_512MB,
> +       VM_MEM_SRC_ANONYMOUS_HUGETLB_1GB,
> +       VM_MEM_SRC_ANONYMOUS_HUGETLB_2GB,
> +       VM_MEM_SRC_ANONYMOUS_HUGETLB_16GB,
> +       NUM_SRC_TYPES,
>  };
>
>  struct vm_mem_backing_src_alias {
>         const char *name;
> -       enum vm_mem_backing_src_type type;
> +       uint32_t flag;
>  };
>
>  bool thp_configured(void);
>  size_t get_trans_hugepagesz(void);
> +const struct vm_mem_backing_src_alias *vm_mem_backing_src_alias(uint32_t i);
> +size_t get_backing_src_pagesz(uint32_t i);
>  void backing_src_help(void);
>  enum vm_mem_backing_src_type parse_backing_src_type(const char *type_name);
>
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index cc22c4ab7d67..b91c8e3a7ee1 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -757,7 +757,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
>         region->mmap_start = mmap(NULL, region->mmap_size,
>                                   PROT_READ | PROT_WRITE,
>                                   MAP_PRIVATE | MAP_ANONYMOUS
> -                                 | (src_type == VM_MEM_SRC_ANONYMOUS_HUGETLB ? MAP_HUGETLB : 0),
> +                                 | vm_mem_backing_src_alias(src_type)->flag,
>                                   -1, 0);
>         TEST_ASSERT(region->mmap_start != MAP_FAILED,
>                     "test_malloc failed, mmap_start: %p errno: %i",
> diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
> index f2d133f76c67..6780aa058f35 100644
> --- a/tools/testing/selftests/kvm/lib/test_util.c
> +++ b/tools/testing/selftests/kvm/lib/test_util.c
> @@ -11,6 +11,7 @@
>  #include <stdlib.h>
>  #include <time.h>
>  #include <sys/stat.h>
> +#include <linux/mman.h>
>  #include "linux/kernel.h"
>
>  #include "test_util.h"
> @@ -112,12 +113,6 @@ void print_skip(const char *fmt, ...)
>         puts(", skipping test");
>  }
>
> -const struct vm_mem_backing_src_alias backing_src_aliases[] = {
> -       {"anonymous", VM_MEM_SRC_ANONYMOUS,},
> -       {"anonymous_thp", VM_MEM_SRC_ANONYMOUS_THP,},
> -       {"anonymous_hugetlb", VM_MEM_SRC_ANONYMOUS_HUGETLB,},
> -};
> -
>  bool thp_configured(void)
>  {
>         int ret;
> @@ -153,22 +148,61 @@ size_t get_trans_hugepagesz(void)
>         return size;
>  }
>
> +const struct vm_mem_backing_src_alias *vm_mem_backing_src_alias(uint32_t i)
> +{
> +       static const struct vm_mem_backing_src_alias aliases[] = {
> +               { "anonymous",               0                            },
> +               { "anonymous_thp",           0                            },
> +               { "anonymous_hugetlb_16kb",  MAP_HUGETLB | MAP_HUGE_16KB  },
> +               { "anonymous_hugetlb_64kb",  MAP_HUGETLB | MAP_HUGE_64KB  },
> +               { "anonymous_hugetlb_512kb", MAP_HUGETLB | MAP_HUGE_512KB },
> +               { "anonymous_hugetlb_1mb",   MAP_HUGETLB | MAP_HUGE_1MB   },
> +               { "anonymous_hugetlb_2mb",   MAP_HUGETLB | MAP_HUGE_2MB   },
> +               { "anonymous_hugetlb_8mb",   MAP_HUGETLB | MAP_HUGE_8MB   },
> +               { "anonymous_hugetlb_16mb",  MAP_HUGETLB | MAP_HUGE_16MB  },
> +               { "anonymous_hugetlb_32mb",  MAP_HUGETLB | MAP_HUGE_32MB  },
> +               { "anonymous_hugetlb_256mb", MAP_HUGETLB | MAP_HUGE_256MB },
> +               { "anonymous_hugetlb_512mb", MAP_HUGETLB | MAP_HUGE_512MB },
> +               { "anonymous_hugetlb_1gb",   MAP_HUGETLB | MAP_HUGE_1GB   },
> +               { "anonymous_hugetlb_2gb",   MAP_HUGETLB | MAP_HUGE_2GB   },
> +               { "anonymous_hugetlb_16gb",  MAP_HUGETLB | MAP_HUGE_16GB  },
> +       };
> +       _Static_assert(ARRAY_SIZE(aliases) == NUM_SRC_TYPES,
> +                      "Missing new backing src types?");
> +
> +       TEST_ASSERT(i < NUM_SRC_TYPES, "Backing src type ID %d too big", i);
> +
> +       return aliases + i;

NIT: This would be easier for me to read as return &aliases[i];


> +}
> +
> +size_t get_backing_src_pagesz(uint32_t i)
> +{
> +       uint32_t flag = vm_mem_backing_src_alias(i)->flag;
> +
> +       if (i == VM_MEM_SRC_ANONYMOUS)
> +               return getpagesize();
> +       if (i == VM_MEM_SRC_ANONYMOUS_THP)
> +               return get_trans_hugepagesz();
> +
> +       return 1ULL << (flag >> HUGETLB_FLAG_ENCODE_SHIFT);

It might also be nice to add a macro where MAP_HUGE_1GB and company
are defined to get the size for a given hugeTLB type. I think you're
mixing macros here too (which works because they're defined off one
another) but it's a little confusing.
MAP_HUGE_1GB and company are defined in
tools/include/uapi/linux/mman.h as equal to the values
HUGETLB_FLAG_ENCODE_1GB and friends in
tools/include/asm-generic/hugetlb_encode.h, but it seems like it would
be good to use MAP_HUGE_SHIFT to match in that case. I think this all
also relies on MAP_HUGETLB being in the bits less than MAP_HUGE_SHIFT
which isn't stated here. All up, I would add a macro to
tools/include/uapi/linux/mman.h:

#define MAP_HUGE_PAGE_SIZE(x) (1ULL << ((x >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK))

Or something similar, and use that here.

> +}
> +
>  void backing_src_help(void)
>  {
>         int i;
>
>         printf("Available backing src types:\n");
> -       for (i = 0; i < ARRAY_SIZE(backing_src_aliases); i++)
> -               printf("\t%s\n", backing_src_aliases[i].name);
> +       for (i = 0; i < NUM_SRC_TYPES; i++)
> +               printf("\t%s\n", vm_mem_backing_src_alias(i)->name);
>  }
>
>  enum vm_mem_backing_src_type parse_backing_src_type(const char *type_name)
>  {
>         int i;
>
> -       for (i = 0; i < ARRAY_SIZE(backing_src_aliases); i++)
> -               if (!strcmp(type_name, backing_src_aliases[i].name))
> -                       return backing_src_aliases[i].type;
> +       for (i = 0; i < NUM_SRC_TYPES; i++)
> +               if (!strcmp(type_name, vm_mem_backing_src_alias(i)->name))
> +                       return i;
>
>         backing_src_help();
>         TEST_FAIL("Unknown backing src type: %s", type_name);
> --
> 2.19.1
>
