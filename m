Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC173898E0
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 May 2021 23:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhESVxN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 May 2021 17:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhESVxM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 May 2021 17:53:12 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B507FC061574
        for <linux-kselftest@vger.kernel.org>; Wed, 19 May 2021 14:51:52 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id n10so14551359ion.8
        for <linux-kselftest@vger.kernel.org>; Wed, 19 May 2021 14:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AD8S0PqRt8X2YnzWzcDJwsZW0R7LolCe/WFdyfKGfyk=;
        b=aWy/rO3R605QtBWXxqhKXcOIv+kLNJlvLjJsFqzQ3CmFBp0qEFCoM2XAqW1gdRzpY2
         stjWL8mY3lLwNoEmzXZRxyku0NAUnIjLY2NjnVX6MtBZwtKXa5YagGCfzpVyDop6HOrO
         q4sHNqlV2gA6I5MRWTN/jKkZu34zF3+Ik4LeChg4vWA+2Y39GNRpMRUMJH7UNhKIHlrA
         JsJyug0IHVqCuBEvF3YO0IbE66oU7RXVTasZldLU8sPxIuKdTDvFtATG5PUMpl10j7Z1
         hHq/DRgxfBDUn1QeqX+rmXcyITXpOXVpkn0H2gHi+bnMZEpQFw40VfiR8w95Qlf85sKN
         KxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AD8S0PqRt8X2YnzWzcDJwsZW0R7LolCe/WFdyfKGfyk=;
        b=pivxfSVvnnTeVlQsWhi2ZLvjozyqSIunf2yeWfsxzTByeMkvZu+q2khG/WRspQZ/co
         ONQbtRSZmDfYTwFW57OwWDGZU2dTogLRy4fifCj8/01x2+0tMvKViaARvO4Q+lbC28c7
         uPGu7kWe5mvs1G8ZyaagWS57DEvimK3ErISUvAqY3F7x1mVbXYP9rxmut3oLXMwJCbJn
         6RShaEORDGNELYiFTTho98FHlMuN+YpZc0UsHsprSQhT1fFl7DoEFpn1NcOtp3Sp00mP
         w2E0sQgzPFVyCer1GSPMLuddMn65uRuwvVsPeJWFRYHDeVSflkQOBH5AJIsZryPOrpMj
         seQA==
X-Gm-Message-State: AOAM530jDbnZH0JU7OZZmxUlKFxCzNmhHUXoq/enD/o2AFY4xA57fJt4
        qCNN+oLj/fJ40OIkjHT6OFD7y88IGlCPo3VTnItwWg==
X-Google-Smtp-Source: ABdhPJwQ/2kUTShiGx6TGIHaO461D4Z/lIu9p2sC3GCPcycwt4PJ/6HPCNbnNp2z40yoOOuAG80DXCuMwXS5/5oEx1Q=
X-Received: by 2002:a05:6638:124b:: with SMTP id o11mr1610166jas.4.1621461111941;
 Wed, 19 May 2021 14:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210519200339.829146-1-axelrasmussen@google.com> <20210519200339.829146-5-axelrasmussen@google.com>
In-Reply-To: <20210519200339.829146-5-axelrasmussen@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Wed, 19 May 2021 14:51:41 -0700
Message-ID: <CANgfPd_X7YWubJENyb5pSLjUUmUzgqcwpL2GHjyePrrQFs0pyg@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] KVM: selftests: compute correct demand paging size
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

On Wed, May 19, 2021 at 1:03 PM Axel Rasmussen <axelrasmussen@google.com> wrote:
>
> This is a preparatory commit needed before we can use different kinds of
> backing pages for guest memory.
>
> Previously, we used perf_test_args.host_page_size, which is the host's
> native page size (commonly 4K). For VM_MEM_SRC_ANONYMOUS this turns out
> to be okay, but in a follow-up commit we want to allow using different
> kinds of backing memory.
>
> Take VM_MEM_SRC_ANONYMOUS_HUGETLB for example. Without this change, if
> we used that backing page type, when we issued a UFFDIO_COPY ioctl we'd
> only do so with 4K, rather than the full 2M of a backing hugepage. In
> this case, UFFDIO_COPY returns -EINVAL (__mcopy_atomic_hugetlb checks
> the size).
>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Reviewed-by: Ben Gardon <bgardon@google.com>

> ---
>  tools/testing/selftests/kvm/demand_paging_test.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
> index 601a1df24dd2..94cf047358d5 100644
> --- a/tools/testing/selftests/kvm/demand_paging_test.c
> +++ b/tools/testing/selftests/kvm/demand_paging_test.c
> @@ -40,6 +40,7 @@
>
>  static int nr_vcpus = 1;
>  static uint64_t guest_percpu_mem_size = DEFAULT_PER_VCPU_MEM_SIZE;
> +static size_t demand_paging_size;
>  static char *guest_data_prototype;
>
>  static void *vcpu_worker(void *data)
> @@ -85,7 +86,7 @@ static int handle_uffd_page_request(int uffd, uint64_t addr)
>
>         copy.src = (uint64_t)guest_data_prototype;
>         copy.dst = addr;
> -       copy.len = perf_test_args.host_page_size;
> +       copy.len = demand_paging_size;
>         copy.mode = 0;
>
>         clock_gettime(CLOCK_MONOTONIC, &start);
> @@ -102,7 +103,7 @@ static int handle_uffd_page_request(int uffd, uint64_t addr)
>         PER_PAGE_DEBUG("UFFDIO_COPY %d \t%ld ns\n", tid,
>                        timespec_to_ns(ts_diff));
>         PER_PAGE_DEBUG("Paged in %ld bytes at 0x%lx from thread %d\n",
> -                      perf_test_args.host_page_size, addr, tid);
> +                      demand_paging_size, addr, tid);
>
>         return 0;
>  }
> @@ -261,10 +262,12 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>
>         perf_test_args.wr_fract = 1;
>
> -       guest_data_prototype = malloc(perf_test_args.host_page_size);
> +       demand_paging_size = get_backing_src_pagesz(VM_MEM_SRC_ANONYMOUS);
> +
> +       guest_data_prototype = malloc(demand_paging_size);
>         TEST_ASSERT(guest_data_prototype,
>                     "Failed to allocate buffer for guest data pattern");
> -       memset(guest_data_prototype, 0xAB, perf_test_args.host_page_size);
> +       memset(guest_data_prototype, 0xAB, demand_paging_size);
>
>         vcpu_threads = malloc(nr_vcpus * sizeof(*vcpu_threads));
>         TEST_ASSERT(vcpu_threads, "Memory allocation failed");
> --
> 2.31.1.751.gd2f1c929bd-goog
>
