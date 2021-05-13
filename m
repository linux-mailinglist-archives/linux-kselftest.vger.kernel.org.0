Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E1737FFD9
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 May 2021 23:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbhEMVdd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 May 2021 17:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233511AbhEMVdc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 May 2021 17:33:32 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75751C061756
        for <linux-kselftest@vger.kernel.org>; Thu, 13 May 2021 14:32:22 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e14so24168979ils.12
        for <linux-kselftest@vger.kernel.org>; Thu, 13 May 2021 14:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lj2hPC9XaS5IbCouhWe8TdZQoRzw4YQucnnZ1bS+zjE=;
        b=SXX27x8C9ACEUhUfo0p/itwuM1nzK5L3HvH+friUer/vSBduS/kCeT7zdk+XA/DyZg
         vGeRq9PUyI/1ym06sLqrknnLPRI0NReo4IVMrvUJmRDVINv/S/macjS8SX+NVI+2Q2rJ
         FyhEmo8su4sdvXWa4L8W/f65FYw1j5CfxEmCJhuI2MVYGqit1hBs6BmurfQBv6Pjsxyg
         zsNADG1bOpZtKS664lvkOCweQy+SMHTG+5VytNXEaCdmFPFFCwrIRp+TBMeJTVB0d/Rt
         y+G9OnuxDci3MeINA1CpybGs5ObhRsCT2msGpq55ZjG+XgxKUr0AO5BNHbJfmuDj+xxC
         mSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lj2hPC9XaS5IbCouhWe8TdZQoRzw4YQucnnZ1bS+zjE=;
        b=uHX32wClp+7cOyJQfI0VygfJNzeAJGvdC/rPCQzOvy3EBsEtuuiNO2zk96TJfjk1Jw
         Z0GXPoBj1aA/kWLqG5uVYwgo01C/dUy0ZdfF8bDfQPjfXRwuHI9XJ7YUJbFKxUzl/2oq
         mObfB1LfHDZWkW1SFgQNZGeBXx08vfsxJ1s5a6FQ+fplcYAxxsP3XleaLtSssCHhIfdC
         C7H0LemIHOqhisBIDUtNVtOoCxueVJL/0TrO67b1QgKtyXhcDXyUDnLgHneUsDVaLTup
         3Z5+eF32GtR/vNVRO6798ixJJjvqwpLodANuzEEFdPTuYG1HwlPAmWfx5jh34RFQNW6X
         6k3Q==
X-Gm-Message-State: AOAM533b+8OR2L69pxsrAhmTVwVyzAa0haZT0IzAMSNQTvSTddOTGVCB
        KGgVxHxdEstaACTWzzEBVpIn200ohhh2T5XYk9LZxQ==
X-Google-Smtp-Source: ABdhPJyQH51RHopArddVns0tN3N+kQJGsM+a5zNqDB87uz4IYhPGnW1Qj7T3sSmD3C+mgWqKDrJ6sviFr7rLZov9GHE=
X-Received: by 2002:a92:3f08:: with SMTP id m8mr36844784ila.154.1620941541612;
 Thu, 13 May 2021 14:32:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210512214502.2047008-1-axelrasmussen@google.com> <20210512214502.2047008-2-axelrasmussen@google.com>
In-Reply-To: <20210512214502.2047008-2-axelrasmussen@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Thu, 13 May 2021 14:32:10 -0700
Message-ID: <CANgfPd8u0=_yZpkvsw-CqP_iWKbj0XQOnJCaNu4GSoFkqLpzDQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] KVM: selftests: allow different backing memory types
 for demand paging
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
> Add an argument which lets us specify a different backing memory type
> for the test. The default is just to use anonymous, matching existing
> behavior (if the argument is omitted).
>
> This is in preparation for testing UFFD minor faults. For that, we need
> to use a new backing memory type which is setup with MAP_SHARED.
>
> This notably requires one other change. Perhaps counter-intuitively,
> perf_test_args.host_page_size is the host's *native* page size, not the
> size of the pages the host is using to back the guest. This means, if we
> try to run the test with e.g. VM_MEM_SRC_ANONYMOUS_HUGETLB, we'll try to
> do demand paging with 4k pages instead of 2M hugepages.

Would it make sense to factor this change out into another commit
preceding this one? Perhaps only worth it if you send a v2.

When you say "we'll try to do demand paging with 4k pages instead of
2M hugepages," what would that mean? Would we only copy 4k worth of
the contents of the 2M page in, leading to the guest seeing bad
memory? Do we have the capability to do demand paging at a smaller
granularity than the backing page size with UFFD?

Otherwise this patch looks reasonable to me. I'll try to review the
rest of your patches today / Monday.

>
> So, convert everything to use a new demand_paging_size, computed based
> on the backing memory type.
>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  .../selftests/kvm/demand_paging_test.c        | 24 +++++++++++++------
>  1 file changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
> index 5f7a229c3af1..10c7ba76a9c6 100644
> --- a/tools/testing/selftests/kvm/demand_paging_test.c
> +++ b/tools/testing/selftests/kvm/demand_paging_test.c
> @@ -38,6 +38,7 @@
>
>  static int nr_vcpus = 1;
>  static uint64_t guest_percpu_mem_size = DEFAULT_PER_VCPU_MEM_SIZE;
> +static size_t demand_paging_size;
>  static char *guest_data_prototype;
>
>  static void *vcpu_worker(void *data)
> @@ -83,7 +84,7 @@ static int handle_uffd_page_request(int uffd, uint64_t addr)
>
>         copy.src = (uint64_t)guest_data_prototype;
>         copy.dst = addr;
> -       copy.len = perf_test_args.host_page_size;
> +       copy.len = demand_paging_size;
>         copy.mode = 0;
>
>         clock_gettime(CLOCK_MONOTONIC, &start);
> @@ -100,7 +101,7 @@ static int handle_uffd_page_request(int uffd, uint64_t addr)
>         PER_PAGE_DEBUG("UFFDIO_COPY %d \t%ld ns\n", tid,
>                        timespec_to_ns(ts_diff));
>         PER_PAGE_DEBUG("Paged in %ld bytes at 0x%lx from thread %d\n",
> -                      perf_test_args.host_page_size, addr, tid);
> +                      demand_paging_size, addr, tid);
>
>         return 0;
>  }
> @@ -250,6 +251,7 @@ static int setup_demand_paging(struct kvm_vm *vm,
>  struct test_params {
>         bool use_uffd;
>         useconds_t uffd_delay;
> +       enum vm_mem_backing_src_type src_type;
>         bool partition_vcpu_memory_access;
>  };
>
> @@ -267,14 +269,16 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>         int r;
>
>         vm = perf_test_create_vm(mode, nr_vcpus, guest_percpu_mem_size,
> -                                VM_MEM_SRC_ANONYMOUS);
> +                                p->src_type);
>
>         perf_test_args.wr_fract = 1;
>
> -       guest_data_prototype = malloc(perf_test_args.host_page_size);
> +       demand_paging_size = get_backing_src_pagesz(p->src_type);
> +
> +       guest_data_prototype = malloc(demand_paging_size);
>         TEST_ASSERT(guest_data_prototype,
>                     "Failed to allocate buffer for guest data pattern");
> -       memset(guest_data_prototype, 0xAB, perf_test_args.host_page_size);
> +       memset(guest_data_prototype, 0xAB, demand_paging_size);
>
>         vcpu_threads = malloc(nr_vcpus * sizeof(*vcpu_threads));
>         TEST_ASSERT(vcpu_threads, "Memory allocation failed");
> @@ -388,7 +392,7 @@ static void help(char *name)
>  {
>         puts("");
>         printf("usage: %s [-h] [-m mode] [-u] [-d uffd_delay_usec]\n"
> -              "          [-b memory] [-v vcpus] [-o]\n", name);
> +              "          [-b memory] [-t type] [-v vcpus] [-o]\n", name);
>         guest_modes_help();
>         printf(" -u: use User Fault FD to handle vCPU page\n"
>                "     faults.\n");
> @@ -398,6 +402,8 @@ static void help(char *name)
>         printf(" -b: specify the size of the memory region which should be\n"
>                "     demand paged by each vCPU. e.g. 10M or 3G.\n"
>                "     Default: 1G\n");
> +       printf(" -t: The type of backing memory to use. Default: anonymous\n");
> +       backing_src_help();
>         printf(" -v: specify the number of vCPUs to run.\n");
>         printf(" -o: Overlap guest memory accesses instead of partitioning\n"
>                "     them into a separate region of memory for each vCPU.\n");
> @@ -409,13 +415,14 @@ int main(int argc, char *argv[])
>  {
>         int max_vcpus = kvm_check_cap(KVM_CAP_MAX_VCPUS);
>         struct test_params p = {
> +               .src_type = VM_MEM_SRC_ANONYMOUS,
>                 .partition_vcpu_memory_access = true,
>         };
>         int opt;
>
>         guest_modes_append_default();
>
> -       while ((opt = getopt(argc, argv, "hm:ud:b:v:o")) != -1) {
> +       while ((opt = getopt(argc, argv, "hm:ud:b:t:v:o")) != -1) {
>                 switch (opt) {
>                 case 'm':
>                         guest_modes_cmdline(optarg);
> @@ -430,6 +437,9 @@ int main(int argc, char *argv[])
>                 case 'b':
>                         guest_percpu_mem_size = parse_size(optarg);
>                         break;
> +               case 't':
> +                       p.src_type = parse_backing_src_type(optarg);
> +                       break;
>                 case 'v':
>                         nr_vcpus = atoi(optarg);
>                         TEST_ASSERT(nr_vcpus > 0 && nr_vcpus <= max_vcpus,
> --
> 2.31.1.607.g51e8a6a459-goog
>
