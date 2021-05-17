Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC31386DEB
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 May 2021 01:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344645AbhEQXw5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 May 2021 19:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239081AbhEQXw5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 May 2021 19:52:57 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A601C061756
        for <linux-kselftest@vger.kernel.org>; Mon, 17 May 2021 16:51:40 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e14so7529825ils.12
        for <linux-kselftest@vger.kernel.org>; Mon, 17 May 2021 16:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y+YiKpIXzIpDVyJC4NldUMZBwXLo+6dDm4EaQY5Cc04=;
        b=p4haCn5TT/IsAqP8RJjQKGgGlpz8PfWDOtdEKoD/12uagP3I3Z9yuEJcezzI61rbBT
         Q4s/5wRRxxO/jgAikAAQQg8RL9tQpLHfJPAiLYjA4SCzr8I0IbP7Ww3bz2uwDF/27K3x
         XOcFncKpl2tfjfbmj+C1x+XmHXTZsoGRre6hilQXc0J8BqTMbrXz7vTXgXHW1YXwoElx
         ZlMVAg8Aj7S1XwZcEbRlIj6D4Xu0/A96IhIXIs17d64v2aO7BJaYqSBEnRHRg4HVl1WZ
         yzVNGOYsIq6zicKR4+w1t8VuMX7eKTFgw8j8h8WgqOXmswBTA+a8nzb96U9LmWBEubOr
         a+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y+YiKpIXzIpDVyJC4NldUMZBwXLo+6dDm4EaQY5Cc04=;
        b=b8Wzt5tTekHk2gCMY8+pQP3hnLTqzMDgtcWb8W3S1sj3UZXO5l9KHjZ3D8DAqMr/B2
         92XP4IIP0vz1vXHelBu2SjJs2kd7ylxuzbcAclJavGOPfA3CFw8tjwcKtPjtcM2FLy9+
         MO0bXv7KQrTIe2KCtJnN0qhWk8oRSRcrNenHdTjTiUj3y5eUyuCqeHa0VLPSQ4eDlCYU
         9BHTX5V6vG6HaDgXQrsTAAm482FxAxIwCXBdGLyAf/yyfs5Lsj1MBp6/JFrjLJv+s5e3
         ZYaVACKh9M1hATz/t/CbX9uv+2vEyGk5IB+/Eavq/ePMa8ENigjreBs439s3kg1md3Bm
         JE/g==
X-Gm-Message-State: AOAM531vBPCC8mDr7SE7B+o+Oux7UlZcCq9Iyr+vcycVl/nZw84UxtiK
        PvI/tS4kq3Ey7MgDizVVfXvgnkdGn3OxekdDxgq3+w==
X-Google-Smtp-Source: ABdhPJxPbgXdH/PL2M1TVOHFQ3ZKDhcLnL+maWXEPgiZ226LFSmBobRkl40wng44SwbTh1aCymbTP5qAcqVwuQ8U0ug=
X-Received: by 2002:a05:6e02:1a49:: with SMTP id u9mr1941934ilv.306.1621295499328;
 Mon, 17 May 2021 16:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210512214502.2047008-1-axelrasmussen@google.com> <20210512214502.2047008-5-axelrasmussen@google.com>
In-Reply-To: <20210512214502.2047008-5-axelrasmussen@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Mon, 17 May 2021 16:51:28 -0700
Message-ID: <CANgfPd8Z0coniYhVNr1WR0Odob+aT10rqJWYKkzAqeP78Rczag@mail.gmail.com>
Subject: Re: [PATCH 4/5] KVM: selftests: allow using UFFD minor faults for
 demand paging
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
>  .../selftests/kvm/demand_paging_test.c        | 124 ++++++++++++------
>  1 file changed, 87 insertions(+), 37 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
> index 10c7ba76a9c6..ff29aaea3120 100644
> --- a/tools/testing/selftests/kvm/demand_paging_test.c
> +++ b/tools/testing/selftests/kvm/demand_paging_test.c
> @@ -72,33 +72,57 @@ static void *vcpu_worker(void *data)
>         return NULL;
>  }
>
> -static int handle_uffd_page_request(int uffd, uint64_t addr)
> +static int handle_uffd_page_request(int uffd_mode, int uffd, uint64_t addr)
>  {
> -       pid_t tid;
> +       const char *ioctl_name;
> +       pid_t tid = syscall(__NR_gettid);
>         struct timespec start;
>         struct timespec ts_diff;
> -       struct uffdio_copy copy;
>         int r;
>
> -       tid = syscall(__NR_gettid);
> +       if (uffd_mode == UFFDIO_REGISTER_MODE_MISSING) {
> +               struct uffdio_copy copy;
>
> -       copy.src = (uint64_t)guest_data_prototype;
> -       copy.dst = addr;
> -       copy.len = demand_paging_size;
> -       copy.mode = 0;
> +               ioctl_name = "UFFDIO_COPY";
>
> -       clock_gettime(CLOCK_MONOTONIC, &start);
> +               copy.src = (uint64_t)guest_data_prototype;
> +               copy.dst = addr;
> +               copy.len = demand_paging_size;
> +               copy.mode = 0;
>
> -       r = ioctl(uffd, UFFDIO_COPY, &copy);
> -       if (r == -1) {
> -               pr_info("Failed Paged in 0x%lx from thread %d with errno: %d\n",
> -                       addr, tid, errno);
> -               return r;
> -       }
> +               clock_gettime(CLOCK_MONOTONIC, &start);

Nit: It'd probably be fine to factor the timing calls out of the if
statement to deduplicate.

>
> -       ts_diff = timespec_elapsed(start);
> +               r = ioctl(uffd, UFFDIO_COPY, &copy);
> +               if (r == -1) {
> +                       pr_info("Failed UFFDIO_COPY in 0x%lx from thread %d with errno: %d\n",
> +                               addr, tid, errno);
> +                       return r;
> +               }
> +
> +               ts_diff = timespec_elapsed(start);
> +       } else if (uffd_mode == UFFDIO_REGISTER_MODE_MINOR) {
> +               struct uffdio_continue cont = {0};
> +
> +               ioctl_name = "UFFDIO_CONTINUE";
> +
> +               cont.range.start = addr;
> +               cont.range.len = demand_paging_size;
> +
> +               clock_gettime(CLOCK_MONOTONIC, &start);
> +
> +               r = ioctl(uffd, UFFDIO_CONTINUE, &cont);
> +               if (r == -1) {
> +                       pr_info("Failed UFFDIO_CONTINUE in 0x%lx from thread %d with errno: %d\n",
> +                               addr, tid, errno);
> +                       return r;
> +               }
>
> -       PER_PAGE_DEBUG("UFFDIO_COPY %d \t%ld ns\n", tid,
> +               ts_diff = timespec_elapsed(start);
> +       } else {
> +               TEST_FAIL("Invalid uffd mode %d", uffd_mode);
> +       }
> +
> +       PER_PAGE_DEBUG("%s %d \t%ld ns\n", ioctl_name, tid,
>                        timespec_to_ns(ts_diff));

As far as I can see this is the only use of ioctl_name and it's not
going to change in a test run, so it might make sense to not print the
ioctl name here and just do it once somewhere else.

>         PER_PAGE_DEBUG("Paged in %ld bytes at 0x%lx from thread %d\n",
>                        demand_paging_size, addr, tid);
> @@ -109,6 +133,7 @@ static int handle_uffd_page_request(int uffd, uint64_t addr)
>  bool quit_uffd_thread;
>
>  struct uffd_handler_args {
> +       int uffd_mode;
>         int uffd;
>         int pipefd;
>         useconds_t delay;
> @@ -170,7 +195,7 @@ static void *uffd_handler_thread_fn(void *arg)
>                 if (r == -1) {
>                         if (errno == EAGAIN)
>                                 continue;
> -                       pr_info("Read of uffd gor errno %d", errno);
> +                       pr_info("Read of uffd got errno %d\n", errno);

If you end up doing some kind of cleanups patch, it might be worth
moving this in there.

>                         return NULL;
>                 }
>
> @@ -185,7 +210,7 @@ static void *uffd_handler_thread_fn(void *arg)
>                 if (delay)
>                         usleep(delay);
>                 addr =  msg.arg.pagefault.address;
> -               r = handle_uffd_page_request(uffd, addr);
> +               r = handle_uffd_page_request(uffd_args->uffd_mode, uffd, addr);
>                 if (r < 0)
>                         return NULL;
>                 pages++;
> @@ -201,17 +226,32 @@ static void *uffd_handler_thread_fn(void *arg)
>
>  static int setup_demand_paging(struct kvm_vm *vm,
>                                pthread_t *uffd_handler_thread, int pipefd,
> +                              int uffd_mode,
>                                useconds_t uffd_delay,
>                                struct uffd_handler_args *uffd_args,
> -                              void *hva, uint64_t len)
> +                              void *hva, void *alias, uint64_t len)
>  {
>         int uffd;
>         struct uffdio_api uffdio_api;
>         struct uffdio_register uffdio_register;
> +       uint64_t expected_ioctls = ((uint64_t) 1) << _UFFDIO_COPY;
> +
> +       /* In order to get minor faults, prefault via the alias. */
> +       if (uffd_mode == UFFDIO_REGISTER_MODE_MINOR) {
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
>
>         uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
>         if (uffd == -1) {
> -               pr_info("uffd creation failed\n");
> +               pr_info("uffd creation failed, errno: %d\n", errno);
>                 return -1;
>         }

Huh, I wonder why I put all these return -1 statements in here. The
caller just does exit(-r) if r < 0. Seems like these could all just be
converted to TEST_ASSERTs.

>
> @@ -224,18 +264,18 @@ static int setup_demand_paging(struct kvm_vm *vm,
>
>         uffdio_register.range.start = (uint64_t)hva;
>         uffdio_register.range.len = len;
> -       uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
> +       uffdio_register.mode = uffd_mode;
>         if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) == -1) {
>                 pr_info("ioctl uffdio_register failed\n");
>                 return -1;
>         }
>
> -       if ((uffdio_register.ioctls & UFFD_API_RANGE_IOCTLS) !=
> -                       UFFD_API_RANGE_IOCTLS) {
> -               pr_info("unexpected userfaultfd ioctl set\n");
> +       if ((uffdio_register.ioctls & expected_ioctls) != expected_ioctls) {
> +               pr_info("missing userfaultfd ioctls\n");
>                 return -1;
>         }
>
> +       uffd_args->uffd_mode = uffd_mode;
>         uffd_args->uffd = uffd;
>         uffd_args->pipefd = pipefd;
>         uffd_args->delay = uffd_delay;
> @@ -249,7 +289,7 @@ static int setup_demand_paging(struct kvm_vm *vm,
>  }
>
>  struct test_params {
> -       bool use_uffd;
> +       int uffd_mode;
>         useconds_t uffd_delay;
>         enum vm_mem_backing_src_type src_type;
>         bool partition_vcpu_memory_access;
> @@ -286,7 +326,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>         perf_test_setup_vcpus(vm, nr_vcpus, guest_percpu_mem_size,
>                               p->partition_vcpu_memory_access);
>
> -       if (p->use_uffd) {
> +       if (p->uffd_mode) {
>                 uffd_handler_threads =
>                         malloc(nr_vcpus * sizeof(*uffd_handler_threads));
>                 TEST_ASSERT(uffd_handler_threads, "Memory allocation failed");
> @@ -300,6 +340,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>                 for (vcpu_id = 0; vcpu_id < nr_vcpus; vcpu_id++) {
>                         vm_paddr_t vcpu_gpa;
>                         void *vcpu_hva;
> +                       void *vcpu_alias;
>                         uint64_t vcpu_mem_size;
>
>
> @@ -314,8 +355,9 @@ static void run_test(enum vm_guest_mode mode, void *arg)
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
> @@ -327,9 +369,10 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>
>                         r = setup_demand_paging(vm,
>                                                 &uffd_handler_threads[vcpu_id],
> -                                               pipefds[vcpu_id * 2],
> +                                               pipefds[vcpu_id * 2], p->uffd_mode,
>                                                 p->uffd_delay, &uffd_args[vcpu_id],
> -                                               vcpu_hva, vcpu_mem_size);
> +                                               vcpu_hva, vcpu_alias,
> +                                               vcpu_mem_size);
>                         if (r < 0)
>                                 exit(-r);
>                 }
> @@ -359,7 +402,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>
>         pr_info("All vCPU threads joined\n");
>
> -       if (p->use_uffd) {
> +       if (p->uffd_mode) {
>                 char c;
>
>                 /* Tell the user fault fd handler threads to quit */
> @@ -381,7 +424,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>
>         free(guest_data_prototype);
>         free(vcpu_threads);
> -       if (p->use_uffd) {
> +       if (p->uffd_mode) {
>                 free(uffd_handler_threads);
>                 free(uffd_args);
>                 free(pipefds);
> @@ -391,11 +434,11 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>  static void help(char *name)
>  {
>         puts("");
> -       printf("usage: %s [-h] [-m mode] [-u] [-d uffd_delay_usec]\n"
> +       printf("usage: %s [-h] [-m mode] [-u mode] [-d uffd_delay_usec]\n"
>                "          [-b memory] [-t type] [-v vcpus] [-o]\n", name);
>         guest_modes_help();
> -       printf(" -u: use User Fault FD to handle vCPU page\n"
> -              "     faults.\n");
> +       printf(" -u: use userfaultfd to handle vCPU page faults. Mode is a\n"
> +              "     UFFD registration mode: 'MISSING' or 'MINOR'.\n");
>         printf(" -d: add a delay in usec to the User Fault\n"
>                "     FD handler to simulate demand paging\n"
>                "     overheads. Ignored without -u.\n");
> @@ -422,13 +465,17 @@ int main(int argc, char *argv[])
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
> @@ -455,6 +502,9 @@ int main(int argc, char *argv[])
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
> 2.31.1.607.g51e8a6a459-goog
>
