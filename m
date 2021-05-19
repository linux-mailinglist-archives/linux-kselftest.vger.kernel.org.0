Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71248389937
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 May 2021 00:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhESWWa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 May 2021 18:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhESWW3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 May 2021 18:22:29 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34F8C061574
        for <linux-kselftest@vger.kernel.org>; Wed, 19 May 2021 15:21:07 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id n10so14616728ion.8
        for <linux-kselftest@vger.kernel.org>; Wed, 19 May 2021 15:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KVvRRELRpKXUQLuQ8nBYMLFzccyO9bAGkhuwXrumK8A=;
        b=aYS4yX1FJTFFb56tDkCDG7Caal2WEFbs+0OtmXn+BtvIIjBdGGtchM95KKAAbScnGp
         8Yp+thIsuo3hxkya5n3xVS7BRObMTVt+0gnvFvTCD51CjJRUu8PLyaT17S/yEPlcGRg3
         NfW0I1uSBWts8FxA8NBmMh3OHOP4u34poQIEHcSdocx6KryCAfc0jgG7ACPHu2FKsW4b
         j2tE7JgpMUwpfFB5Wz2dNwN44wWrJcW6D+IITIcymWhSrqg7LH/kWM4XZSc12AnER3bx
         RXJ+HsazmXjLtmhlEbbxmYNYyJ+k3Ii3eyprGiTN/oEbV7iAqL0R5G+99hjSVDQjp5+W
         n/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KVvRRELRpKXUQLuQ8nBYMLFzccyO9bAGkhuwXrumK8A=;
        b=HvjNSguEx1MxmATvGDsuX8t2QuqktSQN0Khu2bdDf9u3iXSBpAatrufEhLYUBuNZrD
         +0yAPQcm/7MA3nGXI0krTFnVXs9FK7GSVHAHdlmW0blIn9o+S0fGffZY1dFLmpeYRgG8
         67lA0T/TqcGLTckk0Uf7tpRNTPJZ23KVwTKJ3zvJ6GaueafDZ6yxPbCeCTt/ukBeFe4t
         LxUxeULGPdFA56WuKNC1Ia8eDcJszXgOsdL7mGjmUzUW3ZTZqrugxIZH6CT1hbZ5L29X
         2ugnEIQPxHV1AVUOPr+iYghogpvVszmx4o+IECCUUhJDlEuOSNdQsQH9GXVC10Zd99CQ
         gj+g==
X-Gm-Message-State: AOAM531qxuVoOqRwtqHU01CdH1DFuH5pbDBhaBmvIFNdZgjIk7c18J5X
        Wn2ReY+e3P67xBFJ/oF3SeYRKWkIeUxqD7gl0hNFvg==
X-Google-Smtp-Source: ABdhPJxl0YSm/Fe0WSmvRxeTSqJeMYk77OouENsofmQZdlIE4OVPtLRdHUQNyDn4ghIOpNVDqhA1E3L7CJNjKm7mtcU=
X-Received: by 2002:a05:6638:dd2:: with SMTP id m18mr1901237jaj.40.1621462866803;
 Wed, 19 May 2021 15:21:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210519200339.829146-1-axelrasmussen@google.com> <20210519200339.829146-10-axelrasmussen@google.com>
In-Reply-To: <20210519200339.829146-10-axelrasmussen@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Wed, 19 May 2021 15:20:56 -0700
Message-ID: <CANgfPd-O5aEvK74DSxkbJaTBv5gResLgvNSjpuzP+PJwifNmfQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] KVM: selftests: allow using UFFD minor faults
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

On Wed, May 19, 2021 at 1:04 PM Axel Rasmussen <axelrasmussen@google.com> wrote:
>
> UFFD handling of MINOR faults is a new feature whose use case is to
> speed up demand paging (compared to MISSING faults). So, it's
> interesting to let this selftest exercise this new mode.
>
> Modify the demand paging test to have the option of using UFFD minor
> faults, as opposed to missing faults. Now, when turning on userfaultfd
> with '-u', the desired mode has to be specified ("MISSING" or "MINOR").
>
> If we're in minor mode, before registering, prefault via the *alias*.
> This way, the guest will trigger minor faults, instead of missing
> faults, and we can UFFDIO_CONTINUE to resolve them.
>
> Modify the page fault handler function to use the right ioctl depending
> on the mode we're running in. In MINOR mode, use UFFDIO_CONTINUE.
>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  .../selftests/kvm/demand_paging_test.c        | 112 ++++++++++++------
>  1 file changed, 79 insertions(+), 33 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
> index 01890a7b0155..df7190261923 100644
> --- a/tools/testing/selftests/kvm/demand_paging_test.c
> +++ b/tools/testing/selftests/kvm/demand_paging_test.c
> @@ -74,33 +74,48 @@ static void *vcpu_worker(void *data)
>         return NULL;
>  }
>
> -static int handle_uffd_page_request(int uffd, uint64_t addr)
> +static int handle_uffd_page_request(int uffd_mode, int uffd, uint64_t addr)
>  {
> -       pid_t tid;
> +       pid_t tid = syscall(__NR_gettid);
>         struct timespec start;
>         struct timespec ts_diff;
> -       struct uffdio_copy copy;
>         int r;
>
> -       tid = syscall(__NR_gettid);
> +       clock_gettime(CLOCK_MONOTONIC, &start);
>
> -       copy.src = (uint64_t)guest_data_prototype;
> -       copy.dst = addr;
> -       copy.len = demand_paging_size;
> -       copy.mode = 0;
> +       if (uffd_mode == UFFDIO_REGISTER_MODE_MISSING) {
> +               struct uffdio_copy copy;
>
> -       clock_gettime(CLOCK_MONOTONIC, &start);
> +               copy.src = (uint64_t)guest_data_prototype;
> +               copy.dst = addr;
> +               copy.len = demand_paging_size;
> +               copy.mode = 0;
> +
> +               r = ioctl(uffd, UFFDIO_COPY, &copy);
> +               if (r == -1) {
> +                       pr_info("Failed UFFDIO_COPY in 0x%lx from thread %d with errno: %d\n",
> +                               addr, tid, errno);
> +                       return r;
> +               }
> +       } else if (uffd_mode == UFFDIO_REGISTER_MODE_MINOR) {
> +               struct uffdio_continue cont = {0};
> +
> +               cont.range.start = addr;
> +               cont.range.len = demand_paging_size;
>
> -       r = ioctl(uffd, UFFDIO_COPY, &copy);
> -       if (r == -1) {
> -               pr_info("Failed Paged in 0x%lx from thread %d with errno: %d\n",
> -                       addr, tid, errno);
> -               return r;
> +               r = ioctl(uffd, UFFDIO_CONTINUE, &cont);
> +               if (r == -1) {
> +                       pr_info("Failed UFFDIO_CONTINUE in 0x%lx from thread %d with errno: %d\n",
> +                               addr, tid, errno);
> +                       return r;
> +               }
> +       } else {
> +               TEST_FAIL("Invalid uffd mode %d", uffd_mode);
>         }
>
>         ts_diff = timespec_elapsed(start);
>
> -       PER_PAGE_DEBUG("UFFDIO_COPY %d \t%ld ns\n", tid,
> +       PER_PAGE_DEBUG("UFFD page-in %d \t%ld ns\n", tid,
>                        timespec_to_ns(ts_diff));
>         PER_PAGE_DEBUG("Paged in %ld bytes at 0x%lx from thread %d\n",
>                        demand_paging_size, addr, tid);
> @@ -111,6 +126,7 @@ static int handle_uffd_page_request(int uffd, uint64_t addr)
>  bool quit_uffd_thread;
>
>  struct uffd_handler_args {
> +       int uffd_mode;
>         int uffd;
>         int pipefd;
>         useconds_t delay;
> @@ -187,7 +203,7 @@ static void *uffd_handler_thread_fn(void *arg)
>                 if (delay)
>                         usleep(delay);
>                 addr =  msg.arg.pagefault.address;
> -               r = handle_uffd_page_request(uffd, addr);
> +               r = handle_uffd_page_request(uffd_args->uffd_mode, uffd, addr);
>                 if (r < 0)
>                         return NULL;
>                 pages++;
> @@ -203,13 +219,32 @@ static void *uffd_handler_thread_fn(void *arg)
>
>  static void setup_demand_paging(struct kvm_vm *vm,
>                                 pthread_t *uffd_handler_thread, int pipefd,
> -                               useconds_t uffd_delay,
> +                               int uffd_mode, useconds_t uffd_delay,
>                                 struct uffd_handler_args *uffd_args,
> -                               void *hva, uint64_t len)
> +                               void *hva, void *alias, uint64_t len)
>  {
> +       bool is_minor = (uffd_mode == UFFDIO_REGISTER_MODE_MINOR);
>         int uffd;
>         struct uffdio_api uffdio_api;
>         struct uffdio_register uffdio_register;
> +       uint64_t expected_ioctls = ((uint64_t) 1) << _UFFDIO_COPY;
> +
> +       PER_PAGE_DEBUG("Userfaultfd %s mode, faults resolved with %s\n",
> +                      is_minor ? "MINOR" : "MISSING",
> +                      is_minor ? "UFFDIO_CONINUE" : "UFFDIO_COPY");
> +
> +       /* In order to get minor faults, prefault via the alias. */
> +       if (is_minor) {
> +               size_t p;
> +
> +               expected_ioctls = ((uint64_t) 1) << _UFFDIO_CONTINUE;
> +
> +               TEST_ASSERT(alias != NULL, "Alias required for minor faults");
> +               for (p = 0; p < (len / demand_paging_size); ++p) {
> +                       memcpy(alias + (p * demand_paging_size),
> +                              guest_data_prototype, demand_paging_size);
> +               }
> +       }

Would it be worth timing this operation? I think we'd need to know how
long we spent prefaulting the memory to really be able to compare UDDF
modes using this test.

>
>         uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
>         TEST_ASSERT(uffd >= 0, "uffd creation failed, errno: %d", errno);
> @@ -222,12 +257,13 @@ static void setup_demand_paging(struct kvm_vm *vm,
>
>         uffdio_register.range.start = (uint64_t)hva;
>         uffdio_register.range.len = len;
> -       uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
> +       uffdio_register.mode = uffd_mode;
>         TEST_ASSERT(ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) != -1,
>                     "ioctl UFFDIO_REGISTER failed");
> -       TEST_ASSERT((uffdio_register.ioctls & UFFD_API_RANGE_IOCTLS) ==
> -                   UFFD_API_RANGE_IOCTLS, "unexpected userfaultfd ioctl set");
> +       TEST_ASSERT((uffdio_register.ioctls & expected_ioctls) ==
> +                   expected_ioctls, "missing userfaultfd ioctls");
>
> +       uffd_args->uffd_mode = uffd_mode;
>         uffd_args->uffd = uffd;
>         uffd_args->pipefd = pipefd;
>         uffd_args->delay = uffd_delay;
> @@ -239,7 +275,7 @@ static void setup_demand_paging(struct kvm_vm *vm,
>  }
>
>  struct test_params {
> -       bool use_uffd;
> +       int uffd_mode;
>         useconds_t uffd_delay;
>         enum vm_mem_backing_src_type src_type;
>         bool partition_vcpu_memory_access;
> @@ -276,7 +312,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>         perf_test_setup_vcpus(vm, nr_vcpus, guest_percpu_mem_size,
>                               p->partition_vcpu_memory_access);
>
> -       if (p->use_uffd) {
> +       if (p->uffd_mode) {
>                 uffd_handler_threads =
>                         malloc(nr_vcpus * sizeof(*uffd_handler_threads));
>                 TEST_ASSERT(uffd_handler_threads, "Memory allocation failed");
> @@ -290,6 +326,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>                 for (vcpu_id = 0; vcpu_id < nr_vcpus; vcpu_id++) {
>                         vm_paddr_t vcpu_gpa;
>                         void *vcpu_hva;
> +                       void *vcpu_alias;
>                         uint64_t vcpu_mem_size;
>
>
> @@ -304,8 +341,9 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>                         PER_VCPU_DEBUG("Added VCPU %d with test mem gpa [%lx, %lx)\n",
>                                        vcpu_id, vcpu_gpa, vcpu_gpa + vcpu_mem_size);
>
> -                       /* Cache the HVA pointer of the region */
> +                       /* Cache the host addresses of the region */
>                         vcpu_hva = addr_gpa2hva(vm, vcpu_gpa);
> +                       vcpu_alias = addr_gpa2alias(vm, vcpu_gpa);
>
>                         /*
>                          * Set up user fault fd to handle demand paging
> @@ -316,8 +354,9 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>                         TEST_ASSERT(!r, "Failed to set up pipefd");
>
>                         setup_demand_paging(vm, &uffd_handler_threads[vcpu_id],
> -                                           pipefds[vcpu_id * 2], p->uffd_delay,
> -                                           &uffd_args[vcpu_id], vcpu_hva,
> +                                           pipefds[vcpu_id * 2], p->uffd_mode,
> +                                           p->uffd_delay, &uffd_args[vcpu_id],
> +                                           vcpu_hva, vcpu_alias,
>                                             vcpu_mem_size);
>                 }
>         }
> @@ -346,7 +385,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>
>         pr_info("All vCPU threads joined\n");
>
> -       if (p->use_uffd) {
> +       if (p->uffd_mode) {
>                 char c;
>
>                 /* Tell the user fault fd handler threads to quit */
> @@ -368,7 +407,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>
>         free(guest_data_prototype);
>         free(vcpu_threads);
> -       if (p->use_uffd) {
> +       if (p->uffd_mode) {
>                 free(uffd_handler_threads);
>                 free(uffd_args);
>                 free(pipefds);
> @@ -378,11 +417,11 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>  static void help(char *name)
>  {
>         puts("");
> -       printf("usage: %s [-h] [-m mode] [-u] [-d uffd_delay_usec]\n"
> +       printf("usage: %s [-h] [-m mode] [-u mode] [-d uffd_delay_usec]\n"

NIT: maybe use uffd_mode or some word other than mode here to
disambiguate with -m

>                "          [-b memory] [-t type] [-v vcpus] [-o]\n", name);
>         guest_modes_help();
> -       printf(" -u: use User Fault FD to handle vCPU page\n"
> -              "     faults.\n");
> +       printf(" -u: use userfaultfd to handle vCPU page faults. Mode is a\n"
> +              "     UFFD registration mode: 'MISSING' or 'MINOR'.\n");
>         printf(" -d: add a delay in usec to the User Fault\n"
>                "     FD handler to simulate demand paging\n"
>                "     overheads. Ignored without -u.\n");
> @@ -409,13 +448,17 @@ int main(int argc, char *argv[])
>
>         guest_modes_append_default();
>
> -       while ((opt = getopt(argc, argv, "hm:ud:b:t:v:o")) != -1) {
> +       while ((opt = getopt(argc, argv, "hm:u:d:b:t:v:o")) != -1) {
>                 switch (opt) {
>                 case 'm':
>                         guest_modes_cmdline(optarg);
>                         break;
>                 case 'u':
> -                       p.use_uffd = true;
> +                       if (!strcmp("MISSING", optarg))
> +                               p.uffd_mode = UFFDIO_REGISTER_MODE_MISSING;
> +                       else if (!strcmp("MINOR", optarg))
> +                               p.uffd_mode = UFFDIO_REGISTER_MODE_MINOR;
> +                       TEST_ASSERT(p.uffd_mode, "UFFD mode must be 'MISSING' or 'MINOR'.");
>                         break;
>                 case 'd':
>                         p.uffd_delay = strtoul(optarg, NULL, 0);
> @@ -442,6 +485,9 @@ int main(int argc, char *argv[])
>                 }
>         }
>
> +       TEST_ASSERT(p.uffd_mode != UFFDIO_REGISTER_MODE_MINOR || p.src_type == VM_MEM_SRC_SHMEM,
> +                   "userfaultfd MINOR mode requires shared memory; pick a different -t");
> +
>         for_each_guest_mode(run_test, &p);
>
>         return 0;
> --
> 2.31.1.751.gd2f1c929bd-goog
>
