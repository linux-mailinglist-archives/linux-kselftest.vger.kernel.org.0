Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845EA3286BF
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Mar 2021 18:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237977AbhCARNy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Mar 2021 12:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237243AbhCARKp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Mar 2021 12:10:45 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C47C06178B
        for <linux-kselftest@vger.kernel.org>; Mon,  1 Mar 2021 09:10:03 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id f10so14795021ilq.5
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Mar 2021 09:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bQgYIg4zhdvSpGnEowkoL04hHhHEJOWJMqg5awL7BDY=;
        b=d9A/gfZarMTVNipXu9nwbk447hKb3TB5K+Ut7F6XcapVYXKyr73IAWrR0nixbPfKXp
         7eQTdbFasIJg53ECMUhHPO+vF2BOIme5lNjjjzi9GzAFanlm/eF2n5YNa0fp2/ham944
         6lhwukyxGDfNNj4E4w6WahKKQMMdWw5mq9a0v94Tjz8bONJti70oLnCwEkB3UAnWXWTh
         FQ82texUehuhQv9PzOGwfNwBEVAM9wOIoagaXvV6MnmPcjKIJ7KttblCsrZdAU0KdGbX
         XoL9sMUJupzCA6p4TZfoqj+LHWZZuQbu3F9NW6la/c5LzVGh1uNyd84r5q+JduCud3Hm
         Mudw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bQgYIg4zhdvSpGnEowkoL04hHhHEJOWJMqg5awL7BDY=;
        b=C82pgx0Sg3wuMSms30DBH3db8zPEOJWxmuCGWKY0cDtAFSRFEpksPFCH/6TZfWkDgR
         L7UJYCHN5Y0XlECrt3V76DQUPXUPP6kLptYKxHfnNRh26Xu6ENixU1kVwwXvDoHPDqgu
         kBf7xZk1jOKQ6go/DLOIOF1pokPkJL5WNcrIDbEApeWLYQ0OSlyIvBfsNNWDMfMPfGfE
         BjPaqIsp77YkpIiqySec0HgHzVp7OvEn/4Ylp8WVTHaVimdbHFyp2bNTfoxatcfjyBX4
         EuY4iQ3PvDdIOriLth6g3R6RQfyXqDukrOSaIyieXZ0bV8h5PGuDTtt/Txj9KVXiCtgq
         JGeg==
X-Gm-Message-State: AOAM531l5/mTIlD/7yaJN8d8QZoXagB739ThWdM9opELPWImnhDzhyQq
        Nu2MTGQAiE6GN1X9vTbb0644ntt4ncqfIdBlX6RQsQ==
X-Google-Smtp-Source: ABdhPJw6OunxtvxRUyqOdVO6ukZrzTJd6/hnwbS2wbieJGYzz/Nhxp74HGy1tQLd/1xxe5II7r9xGQIphFuu+pUhYXc=
X-Received: by 2002:a92:6408:: with SMTP id y8mr13854048ilb.203.1614618602337;
 Mon, 01 Mar 2021 09:10:02 -0800 (PST)
MIME-Version: 1.0
References: <20210301065916.11484-1-wangyanan55@huawei.com> <20210301065916.11484-7-wangyanan55@huawei.com>
In-Reply-To: <20210301065916.11484-7-wangyanan55@huawei.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Mon, 1 Mar 2021 09:09:51 -0800
Message-ID: <CANgfPd_edxLBBgdnXHiq-pr=6iVf_n8qxSYQeq9JZgK05DwDRQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 6/8] KVM: selftests: List all hugetlb src types
 specified with page sizes
To:     Yanan Wang <wangyanan55@huawei.com>
Cc:     kvm <kvm@vger.kernel.org>, linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Xu <peterx@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        wanghaibin.wang@huawei.com, yezengruan@huawei.com,
        yuzenghui@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Feb 28, 2021 at 11:00 PM Yanan Wang <wangyanan55@huawei.com> wrote:
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
> Suggested-by: Ben Gardon <bgardon@google.com>
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

I apologize I didn't catch this in v2, but it looks like this patch
removes a default hugetlb size option. I could see this being
intentional if we want to force developers to think about there being
multiple page sizes, but it might also be nice for folks to have an
option to use the system default hugepage size.

Otherwise, this series looks good to me. Please feel free to add
Reviewed-by: Ben Gardon <bgardon@google.com>.

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
> index f2d133f76c67..1f5e7241c80e 100644
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
> +       return &aliases[i];
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
> +       return MAP_HUGE_PAGE_SIZE(flag);
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
> 2.23.0
>
