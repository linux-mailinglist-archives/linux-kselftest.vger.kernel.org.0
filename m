Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2201389974
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 May 2021 00:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhESWri (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 May 2021 18:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhESWri (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 May 2021 18:47:38 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8007C06175F
        for <linux-kselftest@vger.kernel.org>; Wed, 19 May 2021 15:46:17 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id k132so1064545iof.4
        for <linux-kselftest@vger.kernel.org>; Wed, 19 May 2021 15:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kaZvs44f9LdUeTBO7ubqTc/0m6N4WK+KhqPPWVqkHq0=;
        b=gdpX3Ml4J3iKyD7UeOT7J6HjxTMEwk4t49N0R+0ygfH71Q6xK2C54oVgJIwq2Yfk7J
         Zcb0dV9PDwH49kzyWmSCXylVr36xX1dmISbb1E6GKt/kfvU3dkltmGENysOtCHw+FDSZ
         bbfQ3iORAYb3B110Q223uWbCwuYIsTtT4HryijnJ5lb2swF/HPOJjJsupCnDS+rUXXAO
         0u3+PIrnECw389nd4H9myxosdV5lon6SjEiHb5wP8Pg5V5EROGXtH7Rz75QjlTu/2Ig1
         Oe8NmloJlyLaV+eb8Yavk5eSwC1OtPuhQvG7hETs8+XDwW+dXfeOt/1xRdn3T/8Ym1LB
         nE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kaZvs44f9LdUeTBO7ubqTc/0m6N4WK+KhqPPWVqkHq0=;
        b=hfb/cToasuDzC1CzlqDJ3h+z/ZFBsyXySpfqEqyfRsbQpr/UYvSnfv77SoLQjtC6Ur
         5m9gK1BlI4TBBL/Ch/LOMC9xYwI4UnWuvu6gCfRFqaJp+5jS+L8j+UbDsCLUikICHXX9
         vGJyr/FDIB+lZ0mFn+kYbkfjCQDKIkOzZ+Sfu2IRYoAuChup5N5+E9vJd0MWEO6S1Upu
         nDGky1dhqVAbHkLaQ21cJ3fP9NdQdmgAHreo1qBF3jteKflpcrq4DtH3PyCOUUA4dXTc
         irq8VBIq5iF+RVtCSiYztGtfHcwggy4waQ/0C6WdJoLkQA8io0h8M1jRd5QAS3kVTMrr
         o2BA==
X-Gm-Message-State: AOAM533oiRoTBZfMHAQICeilCFPO8UZnm7lV4HFuGJPFqA9G+SiomQtT
        hyU2P5QR5GQRk5oSWG/IHZvbvn5q30zG+azISw2QJg==
X-Google-Smtp-Source: ABdhPJx0ibYvNR5zDkHTj55LSlXiUC5MqC/YCfZ2cMcpewaM0jPGPcPuADYK5tVgyP+yffxaEA7dqL+EDFGw9MdGkoU=
X-Received: by 2002:a05:6638:76d:: with SMTP id y13mr1872964jad.25.1621464376804;
 Wed, 19 May 2021 15:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210519210437.1688484-1-jthoughton@google.com> <20210519210437.1688484-2-jthoughton@google.com>
In-Reply-To: <20210519210437.1688484-2-jthoughton@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Wed, 19 May 2021 15:46:06 -0700
Message-ID: <CANgfPd8oS7WJq9gbhK7rV3562KQM8xGXG981m=gq84dfcitYUA@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: selftests: Add UFFD_FEATURE_SIGBUS page-in tests
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        Jue Wang <juew@google.com>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 19, 2021 at 2:04 PM James Houghton <jthoughton@google.com> wrote:
>
> This exercises the KVM userfaultfd SIGBUS path to perform page-ins.
> This patch is based on Axel Rasmussen's patches that enable testing with
> HugeTLBFS:
> (https://lore.kernel.org/patchwork/patch/1432055/).
>
> This allows me to easily verify that the KVM patch does indeed work for
> anonymous, shmem-backed, and hugetlbfs-backed pages.
>
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  .../selftests/kvm/demand_paging_test.c        | 193 +++++++++++++-----

If you'd be willing to split this patch up into a few smaller patches,
I'd find it much easier to review.
Thank you for updating this test with your SIGBUS patch.

>  1 file changed, 138 insertions(+), 55 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
> index 60d9b5223b9d..fe5f6fdf4b28 100644
> --- a/tools/testing/selftests/kvm/demand_paging_test.c
> +++ b/tools/testing/selftests/kvm/demand_paging_test.c
> @@ -10,6 +10,7 @@
>  #define _GNU_SOURCE /* for pipe2 */
>
>  #include <inttypes.h>
> +#include <stdatomic.h>
>  #include <stdint.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> @@ -17,6 +18,7 @@
>  #include <poll.h>
>  #include <pthread.h>
>  #include <linux/userfaultfd.h>
> +#include <signal.h>
>  #include <sys/syscall.h>
>
>  #include "kvm_util.h"
> @@ -43,37 +45,25 @@ static uint64_t guest_percpu_mem_size = DEFAULT_PER_VCPU_MEM_SIZE;
>  static size_t demand_paging_size;
>  static char *guest_data_prototype;
>
> -static void *vcpu_worker(void *data)
> -{
> -       int ret;
> -       struct perf_test_vcpu_args *vcpu_args = (struct perf_test_vcpu_args *)data;
> -       int vcpu_id = vcpu_args->vcpu_id;
> -       struct kvm_vm *vm = perf_test_args.vm;
> -       struct kvm_run *run;
> -       struct timespec start;
> -       struct timespec ts_diff;
> -
> -       vcpu_args_set(vm, vcpu_id, 1, vcpu_id);
> -       run = vcpu_state(vm, vcpu_id);
> -
> -       clock_gettime(CLOCK_MONOTONIC, &start);
> -
> -       /* Let the guest access its memory */
> -       ret = _vcpu_run(vm, vcpu_id);
> -       TEST_ASSERT(ret == 0, "vcpu_run failed: %d\n", ret);
> -       if (get_ucall(vm, vcpu_id, NULL) != UCALL_SYNC) {
> -               TEST_ASSERT(false,
> -                           "Invalid guest sync status: exit_reason=%s\n",
> -                           exit_reason_str(run->exit_reason));
> -       }
> +__thread uint64_t sigbus_address;
> +__thread atomic_bool sigbus_pending_fault;
>
> -       ts_diff = timespec_elapsed(start);
> -       PER_VCPU_DEBUG("vCPU %d execution time: %ld.%.9lds\n", vcpu_id,
> -                      ts_diff.tv_sec, ts_diff.tv_nsec);
> +static void handle_uffd_sigbus(int signum, siginfo_t *info, void *ctx)
> +{
> +       // Round down address.
> +       uint64_t mask = ~(demand_paging_size - 1);
>
> -       return NULL;
> +       sigbus_address = (unsigned long long)(info->si_addr) & mask;
> +       atomic_store_explicit(&sigbus_pending_fault, true, memory_order_release);
>  }
>
> +struct vcpu_worker_args {
> +       struct perf_test_vcpu_args *vcpu_args;
> +       int uffd;
> +       int uffd_mode;
> +       bool use_uffd_sigbus;
> +};
> +
>  static int handle_uffd_page_request(int uffd_mode, int uffd, uint64_t addr)
>  {
>         pid_t tid = syscall(__NR_gettid);
> @@ -123,6 +113,53 @@ static int handle_uffd_page_request(int uffd_mode, int uffd, uint64_t addr)
>         return 0;
>  }
>
> +static void *vcpu_worker(void *data)
> +{
> +       int ret;
> +       struct vcpu_worker_args *vcpu_worker_args =
> +           (struct vcpu_worker_args *)data;
> +       struct perf_test_vcpu_args *vcpu_args = vcpu_worker_args->vcpu_args;
> +       int vcpu_id = vcpu_args->vcpu_id;
> +       struct kvm_vm *vm = perf_test_args.vm;
> +       struct kvm_run *run;
> +       struct timespec start;
> +       struct timespec ts_diff;
> +
> +       vcpu_args_set(vm, vcpu_id, 1, vcpu_id);
> +       run = vcpu_state(vm, vcpu_id);
> +
> +       clock_gettime(CLOCK_MONOTONIC, &start);
> +
> +       /* Let the guest access its memory */
> +       for (;;) {
> +               ret = _vcpu_run(vm, vcpu_id);
> +               if (vcpu_worker_args->use_uffd_sigbus &&
> +                   atomic_load_explicit(&sigbus_pending_fault,
> +                                        memory_order_acquire)) {
> +                       int r = handle_uffd_page_request(
> +                                       vcpu_worker_args->uffd_mode,
> +                                       vcpu_worker_args->uffd, sigbus_address);
> +                       TEST_ASSERT(r == 0, "handle_uffd_page_request failed");
> +                       atomic_store_explicit(&sigbus_pending_fault, false,
> +                                             memory_order_relaxed);
> +               } else
> +                       break;
> +       }
> +
> +       TEST_ASSERT(ret == 0, "vcpu_run failed: %d\n", ret);
> +       if (get_ucall(vm, vcpu_id, NULL) != UCALL_SYNC) {
> +               TEST_ASSERT(false,
> +                           "Invalid guest sync status: exit_reason=%s\n",
> +                           exit_reason_str(run->exit_reason));
> +       }
> +
> +       ts_diff = timespec_elapsed(start);
> +       PER_VCPU_DEBUG("vCPU %d execution time: %ld.%.9lds\n", vcpu_id,
> +                      ts_diff.tv_sec, ts_diff.tv_nsec);
> +
> +       return NULL;
> +}
> +
>  bool quit_uffd_thread;
>
>  struct uffd_handler_args {
> @@ -217,11 +254,8 @@ static void *uffd_handler_thread_fn(void *arg)
>         return NULL;
>  }
>
> -static void setup_demand_paging(struct kvm_vm *vm,
> -                               pthread_t *uffd_handler_thread, int pipefd,
> -                               int uffd_mode, useconds_t uffd_delay,
> -                               struct uffd_handler_args *uffd_args,
> -                               void *hva, void *alias, uint64_t len)
> +static int create_userfaultfd(int uffd_mode, bool use_uffd_sigbus,
> +                             void *hva, void *alias, uint64_t len)
>  {
>         bool is_minor = (uffd_mode == UFFDIO_REGISTER_MODE_MINOR);
>         int uffd;
> @@ -250,7 +284,7 @@ static void setup_demand_paging(struct kvm_vm *vm,
>         TEST_ASSERT(uffd >= 0, "uffd creation failed, errno: %d", errno);
>
>         uffdio_api.api = UFFD_API;
> -       uffdio_api.features = 0;
> +       uffdio_api.features = use_uffd_sigbus ? UFFD_FEATURE_SIGBUS : 0;
>         TEST_ASSERT(ioctl(uffd, UFFDIO_API, &uffdio_api) != -1,
>                     "ioctl UFFDIO_API failed: %" PRIu64,
>                     (uint64_t)uffdio_api.api);
> @@ -263,19 +297,29 @@ static void setup_demand_paging(struct kvm_vm *vm,
>         TEST_ASSERT((uffdio_register.ioctls & expected_ioctls) ==
>                     expected_ioctls, "missing userfaultfd ioctls");
>
> +       return uffd;
> +}
> +
> +static void start_uffd_thread(pthread_t *uffd_handler_thread, int *pipefds,
> +                             int uffd, int uffd_mode, useconds_t uffd_delay,
> +                             struct uffd_handler_args *uffd_args)
> +{
> +       int r;
> +
> +       r = pipe2(pipefds, O_CLOEXEC | O_NONBLOCK);
> +       TEST_ASSERT(!r, "Failed to set up pipefd");
> +
>         uffd_args->uffd_mode = uffd_mode;
>         uffd_args->uffd = uffd;
> -       uffd_args->pipefd = pipefd;
> +       uffd_args->pipefd = pipefds[0];
>         uffd_args->delay = uffd_delay;
>         pthread_create(uffd_handler_thread, NULL, uffd_handler_thread_fn,
>                        uffd_args);
> -
> -       PER_VCPU_DEBUG("Created uffd thread for HVA range [%p, %p)\n",
> -                      hva, hva + len);
>  }
>
>  struct test_params {
>         int uffd_mode;
> +       bool use_uffd_sigbus;
>         useconds_t uffd_delay;
>         enum vm_mem_backing_src_type src_type;
>         bool partition_vcpu_memory_access;
> @@ -286,6 +330,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>         struct test_params *p = arg;
>         pthread_t *vcpu_threads;
>         pthread_t *uffd_handler_threads = NULL;
> +       struct vcpu_worker_args *vcpu_worker_args = NULL;
>         struct uffd_handler_args *uffd_args = NULL;
>         struct timespec start;
>         struct timespec ts_diff;
> @@ -293,6 +338,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>         struct kvm_vm *vm;
>         int vcpu_id;
>         int r;
> +       bool uffd_threads_needed;
>
>         vm = perf_test_create_vm(mode, nr_vcpus, guest_percpu_mem_size,
>                                  p->src_type);
> @@ -309,10 +355,16 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>         vcpu_threads = malloc(nr_vcpus * sizeof(*vcpu_threads));
>         TEST_ASSERT(vcpu_threads, "Memory allocation failed");
>
> +       vcpu_worker_args = malloc(nr_vcpus * sizeof(*vcpu_worker_args));
> +       TEST_ASSERT(vcpu_worker_args, "Memory allocation failed");
> +
>         perf_test_setup_vcpus(vm, nr_vcpus, guest_percpu_mem_size,
>                               p->partition_vcpu_memory_access);
>
> -       if (p->uffd_mode) {
> +       uffd_threads_needed = p->uffd_mode && !p->use_uffd_sigbus;
> +       if (uffd_threads_needed) {
> +               // Handler threads are not necessary when using
> +               // UFFD_FEATURE_SIGBUS.
>                 uffd_handler_threads =
>                         malloc(nr_vcpus * sizeof(*uffd_handler_threads));
>                 TEST_ASSERT(uffd_handler_threads, "Memory allocation failed");
> @@ -322,6 +374,21 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>
>                 pipefds = malloc(sizeof(int) * nr_vcpus * 2);
>                 TEST_ASSERT(pipefds, "Unable to allocate memory for pipefd");
> +       }
> +
> +       if (p->use_uffd_sigbus) {
> +               struct sigaction action;
> +
> +               memset(&action, 0, sizeof(action));
> +               action.sa_sigaction = handle_uffd_sigbus;
> +               action.sa_flags = SA_SIGINFO;
> +               if (sigaction(SIGBUS, &action, NULL) < 0) {
> +                       perror("Failed to set sigaction");
> +                       return;
> +               }
> +       }
> +
> +       if (p->uffd_mode) {
>
>                 for (vcpu_id = 0; vcpu_id < nr_vcpus; vcpu_id++) {
>                         vm_paddr_t vcpu_gpa;
> @@ -329,7 +396,6 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>                         void *vcpu_alias;
>                         uint64_t vcpu_mem_size;
>
> -
>                         if (p->partition_vcpu_memory_access) {
>                                 vcpu_gpa = guest_test_phys_mem +
>                                            (vcpu_id * guest_percpu_mem_size);
> @@ -339,7 +405,8 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>                                 vcpu_mem_size = guest_percpu_mem_size * nr_vcpus;
>                         }
>                         PER_VCPU_DEBUG("Added VCPU %d with test mem gpa [%lx, %lx)\n",
> -                                      vcpu_id, vcpu_gpa, vcpu_gpa + vcpu_mem_size);
> +                                      vcpu_id, vcpu_gpa,
> +                                      vcpu_gpa + vcpu_mem_size);
>
>                         /* Cache the host addresses of the region */
>                         vcpu_hva = addr_gpa2hva(vm, vcpu_gpa);
> @@ -349,28 +416,39 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>                          * Set up user fault fd to handle demand paging
>                          * requests.
>                          */
> -                       r = pipe2(&pipefds[vcpu_id * 2],
> -                                 O_CLOEXEC | O_NONBLOCK);
> -                       TEST_ASSERT(!r, "Failed to set up pipefd");
> -
> -                       setup_demand_paging(vm, &uffd_handler_threads[vcpu_id],
> -                                           pipefds[vcpu_id * 2], p->uffd_mode,
> -                                           p->uffd_delay, &uffd_args[vcpu_id],
> -                                           vcpu_hva, vcpu_alias,
> -                                           vcpu_mem_size);
> +                       r = create_userfaultfd(p->uffd_mode, p->use_uffd_sigbus,
> +                                              vcpu_hva, vcpu_alias,
> +                                              vcpu_mem_size);
> +                       if (r < 0)
> +                               exit(-r);
> +
> +                       if (uffd_threads_needed) {
> +                               start_uffd_thread(&uffd_handler_threads[vcpu_id],
> +                                                 &pipefds[vcpu_id * 2],
> +                                                 r, p->uffd_mode, p->uffd_delay,
> +                                                 &uffd_args[vcpu_id]);
> +                               PER_VCPU_DEBUG("Created uffd thread for HVA range [%p, %p)\n",
> +                                              vcpu_hva, vcpu_hva + vcpu_mem_size);
> +                       }
> +
> +                       vcpu_worker_args[vcpu_id].uffd = r;
>                 }
>         }
>
>         /* Export the shared variables to the guest */
>         sync_global_to_guest(vm, perf_test_args);
>
> -       pr_info("Finished creating vCPUs and starting uffd threads\n");
> +       pr_info("Finished creating vCPUs\n");
>
>         clock_gettime(CLOCK_MONOTONIC, &start);
>
>         for (vcpu_id = 0; vcpu_id < nr_vcpus; vcpu_id++) {
> +               vcpu_worker_args[vcpu_id].vcpu_args =
> +                               &perf_test_args.vcpu_args[vcpu_id];
> +               vcpu_worker_args[vcpu_id].use_uffd_sigbus = p->use_uffd_sigbus;
> +               vcpu_worker_args[vcpu_id].uffd_mode = p->uffd_mode;
>                 pthread_create(&vcpu_threads[vcpu_id], NULL, vcpu_worker,
> -                              &perf_test_args.vcpu_args[vcpu_id]);
> +                              &vcpu_worker_args[vcpu_id]);
>         }
>
>         pr_info("Started all vCPUs\n");
> @@ -385,7 +463,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>
>         pr_info("All vCPU threads joined\n");
>
> -       if (p->uffd_mode) {
> +       if (uffd_threads_needed) {
>                 char c;
>
>                 /* Tell the user fault fd handler threads to quit */
> @@ -407,7 +485,8 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>
>         free(guest_data_prototype);
>         free(vcpu_threads);
> -       if (p->uffd_mode) {
> +       free(vcpu_worker_args);
> +       if (uffd_threads_needed) {
>                 free(uffd_handler_threads);
>                 free(uffd_args);
>                 free(pipefds);
> @@ -417,11 +496,12 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>  static void help(char *name)
>  {
>         puts("");
> -       printf("usage: %s [-h] [-m mode] [-u mode] [-d uffd_delay_usec]\n"
> +       printf("usage: %s [-h] [-m mode] [-u mode] [-s] [-d uffd_delay_usec]\n"
>                "          [-b memory] [-t type] [-v vcpus] [-o]\n", name);
>         guest_modes_help();
>         printf(" -u: use userfaultfd to handle vCPU page faults. Mode is a\n"
>                "     UFFD registration mode: 'MISSING' or 'MINOR'.\n");
> +       printf(" -s: use UFFD_FEATURE_SIGBUS to perform page-ins.\n");
>         printf(" -d: add a delay in usec to the User Fault\n"
>                "     FD handler to simulate demand paging\n"
>                "     overheads. Ignored without -u.\n");
> @@ -448,7 +528,7 @@ int main(int argc, char *argv[])
>
>         guest_modes_append_default();
>
> -       while ((opt = getopt(argc, argv, "hm:u:d:b:t:v:o")) != -1) {
> +       while ((opt = getopt(argc, argv, "hm:u:sd:b:t:v:o")) != -1) {
>                 switch (opt) {
>                 case 'm':
>                         guest_modes_cmdline(optarg);
> @@ -460,6 +540,9 @@ int main(int argc, char *argv[])
>                                 p.uffd_mode = UFFDIO_REGISTER_MODE_MINOR;
>                         TEST_ASSERT(p.uffd_mode, "UFFD mode must be 'MISSING' or 'MINOR'.");
>                         break;
> +               case 's':
> +                       p.use_uffd_sigbus = true;
> +                       break;
>                 case 'd':
>                         p.uffd_delay = strtoul(optarg, NULL, 0);
>                         TEST_ASSERT(p.uffd_delay >= 0, "A negative UFFD delay is not supported.");
> --
> 2.31.1.751.gd2f1c929bd-goog
>
