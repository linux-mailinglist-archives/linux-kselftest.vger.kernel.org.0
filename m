Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB7D37FFF1
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 May 2021 00:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhEMWEQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 May 2021 18:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbhEMWEQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 May 2021 18:04:16 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BB1C061574
        for <linux-kselftest@vger.kernel.org>; Thu, 13 May 2021 15:03:06 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id a11so26368764ioo.0
        for <linux-kselftest@vger.kernel.org>; Thu, 13 May 2021 15:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T/ZWfzVFcxgYSarPowOvBUX0uVefuthIIQJ8YRw+u1E=;
        b=SEnnq54LGYEDzdIATveL857bcri0Ioy5Q+U/lfOeOH9dSYnNYa74k2y62SW45oazHA
         kB/x3qXa0x8MPi7UQ+D31bFmlOSaWl9d/1Mm844HEJbuiQoXUbVymjAkucZ+nkXDjHqA
         bxWbaYl78xIQdSKNy9OQp7f7BZ1jlF8JkQDJxclKDzawo8iPljCMz6vLWDGkYW5OkS1c
         buM4bXPIajmE69xuKEGLZTDjbAt3dUGF7YERXq9q5BxMh7jYJYuSgTzLE0MAH5AXISDc
         3GO2n9YyFwtiCO2atxl/MMmyYmJyGv2ot9mRWegQWj7fbto/WdIsg4sCLAshTm6FDykU
         kzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T/ZWfzVFcxgYSarPowOvBUX0uVefuthIIQJ8YRw+u1E=;
        b=k4jvV1I9QGMOtLtk2lEdFMQNH5rqIJcWHL1NQvVYkQw7upoRqHmK3fIhH9UoXdm8LJ
         cO5GmiTlxm/Tz804j6vT/rjxxd5asnLVJPjYneBTl5g4GFrLOqSyGDhVIXU41ei55zhc
         DztaZz1p0t9J01DZToguwVlTd3AXdlPzb1phLz//dsdpCXgemPHWdt24iprNFdyVu859
         S2wYJUl+o8zJgIISkoz44gMAyBpq5elYBs7gRqG0TaWPvdhQjjKGLaW3VtM54lWJl70H
         t9wpYXX1Gn/0fTli9I9yIAItwpR4F67bSSyMiIxjFMHlBBKjmzcBYMunXXfOSPoB3mYj
         /yew==
X-Gm-Message-State: AOAM533IjkZbtrOmjlr+npVzir8xR8pzrapTsicS+Fo6CPVcZ0P5Pbfg
        FgQAlBzdV45oiO0IomVgrcIWTBCFPeEz8pNdjr0VFQ==
X-Google-Smtp-Source: ABdhPJwFSeuV8HG27grrM0xnFPqsKC+UL3zivh2UTRi7VTA0Fg/WDh6PBYorrZ3JqFuXwg4z7RX+/y4VIXWMYWs8vOI=
X-Received: by 2002:a6b:b409:: with SMTP id d9mr31259682iof.57.1620943385135;
 Thu, 13 May 2021 15:03:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210512214502.2047008-1-axelrasmussen@google.com>
 <20210512214502.2047008-2-axelrasmussen@google.com> <CANgfPd8u0=_yZpkvsw-CqP_iWKbj0XQOnJCaNu4GSoFkqLpzDQ@mail.gmail.com>
In-Reply-To: <CANgfPd8u0=_yZpkvsw-CqP_iWKbj0XQOnJCaNu4GSoFkqLpzDQ@mail.gmail.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 13 May 2021 15:02:28 -0700
Message-ID: <CAJHvVchQUz9VnpSsh_3jJ7o6qKMF0-NWhw42E7tO8m6+R9Uf8g@mail.gmail.com>
Subject: Re: [PATCH 1/5] KVM: selftests: allow different backing memory types
 for demand paging
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

On Thu, May 13, 2021 at 2:32 PM Ben Gardon <bgardon@google.com> wrote:
>
> On Wed, May 12, 2021 at 2:45 PM Axel Rasmussen <axelrasmussen@google.com> wrote:
> >
> > Add an argument which lets us specify a different backing memory type
> > for the test. The default is just to use anonymous, matching existing
> > behavior (if the argument is omitted).
> >
> > This is in preparation for testing UFFD minor faults. For that, we need
> > to use a new backing memory type which is setup with MAP_SHARED.
> >
> > This notably requires one other change. Perhaps counter-intuitively,
> > perf_test_args.host_page_size is the host's *native* page size, not the
> > size of the pages the host is using to back the guest. This means, if we
> > try to run the test with e.g. VM_MEM_SRC_ANONYMOUS_HUGETLB, we'll try to
> > do demand paging with 4k pages instead of 2M hugepages.
>
> Would it make sense to factor this change out into another commit
> preceding this one? Perhaps only worth it if you send a v2.
>
> When you say "we'll try to do demand paging with 4k pages instead of
> 2M hugepages," what would that mean? Would we only copy 4k worth of
> the contents of the 2M page in, leading to the guest seeing bad
> memory? Do we have the capability to do demand paging at a smaller
> granularity than the backing page size with UFFD?

Basically I think the existing behavior is to always use 4k - so we
UFFDIO_COPY that size at a time.

This is totally fine for anonymous, or even for THPs. But, once we're
using hugetlbfs, the UFFDIO_COPY ioctl will just fail unless we do 2M
(or some multiple thereof) at a time. If memory serves it returns
-EINVAL in this case.

It wouldn't be so much trouble to factor it out, so just let me know
what is preferred. For now, I'll do it if a v2 is needed for other
reasons.

>
> Otherwise this patch looks reasonable to me. I'll try to review the
> rest of your patches today / Monday.
>
> >
> > So, convert everything to use a new demand_paging_size, computed based
> > on the backing memory type.
> >
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > ---
> >  .../selftests/kvm/demand_paging_test.c        | 24 +++++++++++++------
> >  1 file changed, 17 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
> > index 5f7a229c3af1..10c7ba76a9c6 100644
> > --- a/tools/testing/selftests/kvm/demand_paging_test.c
> > +++ b/tools/testing/selftests/kvm/demand_paging_test.c
> > @@ -38,6 +38,7 @@
> >
> >  static int nr_vcpus = 1;
> >  static uint64_t guest_percpu_mem_size = DEFAULT_PER_VCPU_MEM_SIZE;
> > +static size_t demand_paging_size;
> >  static char *guest_data_prototype;
> >
> >  static void *vcpu_worker(void *data)
> > @@ -83,7 +84,7 @@ static int handle_uffd_page_request(int uffd, uint64_t addr)
> >
> >         copy.src = (uint64_t)guest_data_prototype;
> >         copy.dst = addr;
> > -       copy.len = perf_test_args.host_page_size;
> > +       copy.len = demand_paging_size;
> >         copy.mode = 0;
> >
> >         clock_gettime(CLOCK_MONOTONIC, &start);
> > @@ -100,7 +101,7 @@ static int handle_uffd_page_request(int uffd, uint64_t addr)
> >         PER_PAGE_DEBUG("UFFDIO_COPY %d \t%ld ns\n", tid,
> >                        timespec_to_ns(ts_diff));
> >         PER_PAGE_DEBUG("Paged in %ld bytes at 0x%lx from thread %d\n",
> > -                      perf_test_args.host_page_size, addr, tid);
> > +                      demand_paging_size, addr, tid);
> >
> >         return 0;
> >  }
> > @@ -250,6 +251,7 @@ static int setup_demand_paging(struct kvm_vm *vm,
> >  struct test_params {
> >         bool use_uffd;
> >         useconds_t uffd_delay;
> > +       enum vm_mem_backing_src_type src_type;
> >         bool partition_vcpu_memory_access;
> >  };
> >
> > @@ -267,14 +269,16 @@ static void run_test(enum vm_guest_mode mode, void *arg)
> >         int r;
> >
> >         vm = perf_test_create_vm(mode, nr_vcpus, guest_percpu_mem_size,
> > -                                VM_MEM_SRC_ANONYMOUS);
> > +                                p->src_type);
> >
> >         perf_test_args.wr_fract = 1;
> >
> > -       guest_data_prototype = malloc(perf_test_args.host_page_size);
> > +       demand_paging_size = get_backing_src_pagesz(p->src_type);
> > +
> > +       guest_data_prototype = malloc(demand_paging_size);
> >         TEST_ASSERT(guest_data_prototype,
> >                     "Failed to allocate buffer for guest data pattern");
> > -       memset(guest_data_prototype, 0xAB, perf_test_args.host_page_size);
> > +       memset(guest_data_prototype, 0xAB, demand_paging_size);
> >
> >         vcpu_threads = malloc(nr_vcpus * sizeof(*vcpu_threads));
> >         TEST_ASSERT(vcpu_threads, "Memory allocation failed");
> > @@ -388,7 +392,7 @@ static void help(char *name)
> >  {
> >         puts("");
> >         printf("usage: %s [-h] [-m mode] [-u] [-d uffd_delay_usec]\n"
> > -              "          [-b memory] [-v vcpus] [-o]\n", name);
> > +              "          [-b memory] [-t type] [-v vcpus] [-o]\n", name);
> >         guest_modes_help();
> >         printf(" -u: use User Fault FD to handle vCPU page\n"
> >                "     faults.\n");
> > @@ -398,6 +402,8 @@ static void help(char *name)
> >         printf(" -b: specify the size of the memory region which should be\n"
> >                "     demand paged by each vCPU. e.g. 10M or 3G.\n"
> >                "     Default: 1G\n");
> > +       printf(" -t: The type of backing memory to use. Default: anonymous\n");
> > +       backing_src_help();
> >         printf(" -v: specify the number of vCPUs to run.\n");
> >         printf(" -o: Overlap guest memory accesses instead of partitioning\n"
> >                "     them into a separate region of memory for each vCPU.\n");
> > @@ -409,13 +415,14 @@ int main(int argc, char *argv[])
> >  {
> >         int max_vcpus = kvm_check_cap(KVM_CAP_MAX_VCPUS);
> >         struct test_params p = {
> > +               .src_type = VM_MEM_SRC_ANONYMOUS,
> >                 .partition_vcpu_memory_access = true,
> >         };
> >         int opt;
> >
> >         guest_modes_append_default();
> >
> > -       while ((opt = getopt(argc, argv, "hm:ud:b:v:o")) != -1) {
> > +       while ((opt = getopt(argc, argv, "hm:ud:b:t:v:o")) != -1) {
> >                 switch (opt) {
> >                 case 'm':
> >                         guest_modes_cmdline(optarg);
> > @@ -430,6 +437,9 @@ int main(int argc, char *argv[])
> >                 case 'b':
> >                         guest_percpu_mem_size = parse_size(optarg);
> >                         break;
> > +               case 't':
> > +                       p.src_type = parse_backing_src_type(optarg);
> > +                       break;
> >                 case 'v':
> >                         nr_vcpus = atoi(optarg);
> >                         TEST_ASSERT(nr_vcpus > 0 && nr_vcpus <= max_vcpus,
> > --
> > 2.31.1.607.g51e8a6a459-goog
> >
