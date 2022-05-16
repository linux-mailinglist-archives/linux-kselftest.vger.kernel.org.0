Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D7352922E
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 May 2022 23:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349244AbiEPVHg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 May 2022 17:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349067AbiEPVHC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 May 2022 17:07:02 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AF74839E
        for <linux-kselftest@vger.kernel.org>; Mon, 16 May 2022 13:47:50 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2fedd26615cso54321567b3.7
        for <linux-kselftest@vger.kernel.org>; Mon, 16 May 2022 13:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MGqyWXQk2TARjeKkCKeHjMLOttRn8i8ufa722x61ENE=;
        b=Yk2K9XYvJCSidEvvixhdJ0teoCw+61LaSdXUBNS4+6t+VFoWvwDLJYYHW0WHXfWQ/u
         plLsnOinfajiNCP/UqH+sdeVVHErW/r0uaCT1fsPD4m7ycPA5zPOYe4qOS+X6hfyJ6Yl
         zZ3+rKnFoLufbaa/BXB8LN7RTNiVTyImqpeK/lKTav3Potm5En6Ol1It5BE1SrTrJXUe
         WBIzDXZmSaNXG0f2lRzQKoX6SG1hSgkA1dLIx6DUKIdUhykwq0JCa0peefZcARCWfOSW
         lHfR2QDD140c4/l9TUiiTojcymyAp4+SVWoNVnonwUxuuAInSBEfzMZuSbridm+HcD++
         IT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MGqyWXQk2TARjeKkCKeHjMLOttRn8i8ufa722x61ENE=;
        b=tEhbbXsXZjWF/FRCca3/y/3QcXb4DOjPBg8QJGyPOGANnGRWOavmUmvVvalra/f1lA
         tLUEAkSNy0+Ma9BiLy5wxeQzaoA8s+pdwsygygZgBehtZO/UIfognt+L8QjSTOXdNytA
         9+oPnAcYykn+MOuIXwyjA4V0fugTFk/pDAT7I2CYHQnvIK5LnArqfxFZsvt/GOxmnqEV
         hbVtzDdlJS/4MkPFvWTt5UKAr9WTY9bwzszW0qAysTbL1fMl/EUpd8rUeE4R+M11kGIZ
         ByA1g9wLowI0FZqaa+7BOl0FU/8kn+atRYAZRfAvbA5/kQOL1ncFLLAIHd/Tww2mH88S
         Fgog==
X-Gm-Message-State: AOAM532Cs/FwfxAkDwcsTad0XBHaS7Hzm41OZaWnzfouYCIkPOIgIOYJ
        pfCHDVA0gSPES5ok4eyRhVNJR+9JBgAurGrSGl553A==
X-Google-Smtp-Source: ABdhPJzFFItdBbTCMtdSUACREob8G8daBgY1rCO3OENvBA55zX3ZE5ERc2OyA2k979/nnQZymOszleTKcc4lLleR3OY=
X-Received: by 2002:a81:5087:0:b0:2fe:ed39:b18b with SMTP id
 e129-20020a815087000000b002feed39b18bmr8891801ywb.237.1652734069048; Mon, 16
 May 2022 13:47:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220516075538.1276644-1-surenb@google.com> <78c3a163-551b-ef53-4018-7b6ba0640757@linuxfoundation.org>
In-Reply-To: <78c3a163-551b-ef53-4018-7b6ba0640757@linuxfoundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 16 May 2022 13:47:38 -0700
Message-ID: <CAJuCfpEW3kif-QAVdFKyZikVRT5QrLGwJ5pzua+yuVq=A=bv8w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] selftests: vm: add process_mrelease tests
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>, shuah@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, May 16, 2022 at 1:29 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 5/16/22 1:55 AM, Suren Baghdasaryan wrote:
> > Introduce process_mrelease syscall sanity tests which include tests
> > which expect to fail:
> > - process_mrelease with invalid pidfd and flags inputs
> > - process_mrelease on a live process with no pending signals
> > and valid process_mrelease usage which is expected to succeed.
> > Because process_mrelease has to be used against a process with a pending
> > SIGKILL, it's possible that the process exits before process_mrelease
> > gets called. In such cases we retry the test with a victim that allocates
> > twice more memory up to 1GB. This would require the victim process to
> > spend more time during exit and process_mrelease has a better chance of
> > catching the process before it exits and succeeding.
> >
> > On success the test reports the amount of memory the child had to
> > allocate for reaping to succeed. Sample output:
> >      Success reaping a child with 1MB of memory allocations
> >
> > On failure the test reports the failure. Sample outputs:
> >      All process_mrelease attempts failed!
> >      process_mrelease: Invalid argument
> >
>
> Nit: Please format this better - include actual example output from the
> command and how to run the test examples.

Hmm... Those are the actual outputs from the command and it does not
take any input arguments. Do you mean smth like this:

$ mrelease_test
Success reaping a child with 1MB of memory allocations

$ mrelease_test
All process_mrelease attempts failed!

$ mrelease_test
process_mrelease: Invalid argument

?

>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >   tools/testing/selftests/vm/.gitignore      |   1 +
> >   tools/testing/selftests/vm/Makefile        |   1 +
> >   tools/testing/selftests/vm/mrelease_test.c | 214 +++++++++++++++++++++
> >   tools/testing/selftests/vm/run_vmtests.sh  |  16 ++
> >   4 files changed, 232 insertions(+)
> >   create mode 100644 tools/testing/selftests/vm/mrelease_test.c
> >
> > diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
> > index d7507f3c7c76..c019e53f24f9 100644
> > --- a/tools/testing/selftests/vm/.gitignore
> > +++ b/tools/testing/selftests/vm/.gitignore
> > @@ -10,6 +10,7 @@ map_populate
> >   thuge-gen
> >   compaction_test
> >   mlock2-tests
> > +mrelease_test
> >   mremap_dontunmap
> >   mremap_test
> >   on-fault-limit
> > diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> > index 04a49e876a46..733fccbff0ef 100644
> > --- a/tools/testing/selftests/vm/Makefile
> > +++ b/tools/testing/selftests/vm/Makefile
> > @@ -43,6 +43,7 @@ TEST_GEN_FILES += map_populate
> >   TEST_GEN_FILES += memfd_secret
> >   TEST_GEN_FILES += mlock-random-test
> >   TEST_GEN_FILES += mlock2-tests
> > +TEST_GEN_FILES += mrelease_test
> >   TEST_GEN_FILES += mremap_dontunmap
> >   TEST_GEN_FILES += mremap_test
> >   TEST_GEN_FILES += on-fault-limit
> > diff --git a/tools/testing/selftests/vm/mrelease_test.c b/tools/testing/selftests/vm/mrelease_test.c
> > new file mode 100644
> > index 000000000000..99680676069b
> > --- /dev/null
> > +++ b/tools/testing/selftests/vm/mrelease_test.c
> > @@ -0,0 +1,214 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2022 Google LLC
> > + */
> > +#define _GNU_SOURCE
> > +#include <errno.h>
> > +#include <stdbool.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <sys/wait.h>
> > +#include <unistd.h>
> > +
> > +#include "util.h"
> > +
> > +#include "../kselftest.h"
> > +
> > +#if defined(__NR_pidfd_open) && defined(__NR_process_mrelease)
> > +
> > +static inline int pidfd_open(pid_t pid, unsigned int flags)
> > +{
> > +     return syscall(__NR_pidfd_open, pid, flags);
> > +}
> > +
> > +static inline int process_mrelease(int pidfd, unsigned int flags)
> > +{
> > +     return syscall(__NR_process_mrelease, pidfd, flags);
> > +}
> > +
> > +static void write_fault_pages(char *addr, unsigned long nr_pages)
> > +{
> > +     unsigned long i;
> > +
> > +     for (i = 0; i < nr_pages; i++)
> > +             *((unsigned long *)(addr + (i * PAGE_SIZE))) = i;
> > +}
> > +
>
> Okay these above 3 routines are called once. I am not seeing any point
> in making these separate routines. I made the same comment on v1.

I must have misunderstood your previous comment. Will change.

>
> > +static int alloc_noexit(unsigned long nr_pages, int pipefd)
> > +{
> > +     int timeout = 10; /* 10sec timeout to get killed */
> > +     int ppid = getppid();
> > +     void *buf;
> > +
> > +     buf = mmap(NULL, nr_pages * PAGE_SIZE, PROT_READ | PROT_WRITE,
> > +                MAP_PRIVATE | MAP_ANON, 0, 0);
> > +     if (buf == MAP_FAILED) {
> > +             perror("mmap failed, halting the test");
> > +             return KSFT_FAIL;
> > +     }
> > +
> > +     write_fault_pages((char *)buf, nr_pages);
> > +
> > +     /* Signal the parent that the child is ready */
> > +     if (write(pipefd, "", 1) < 0) {
> > +             perror("write");
> > +             return KSFT_FAIL;
> > +     }
> > +
> > +     /* Wait to be killed (when reparenting happens) */
> > +     while (getppid() == ppid && timeout > 0) {
> > +             sleep(1);
> > +             timeout--;
> > +     }
> > +
> > +     munmap(buf, nr_pages * PAGE_SIZE);
> > +
> > +     return (timeout > 0) ? KSFT_PASS : KSFT_FAIL;
> > +}
> > +
> > +/* The process_mrelease calls in this test are expected to fail */
> > +void run_negative_tests(int pidfd)
> > +{
> > +     /* Test invalid flags. Expect to fail with EINVAL error code. */
> > +     if (!process_mrelease(pidfd, (unsigned int)-1) || errno != EINVAL) {
> > +             perror("process_mrelease with wrong flags");
> > +             exit(KSFT_FAIL);
> > +     }
> > +     /*
> > +      * Test reaping while process is alive with no pending SIGKILL.
> > +      * Expect to fail with EINVAL error code.
> > +      */
> > +     if (!process_mrelease(pidfd, 0) || errno != EINVAL) {
> > +             perror("process_mrelease on a live process");
> > +             exit(KSFT_FAIL);
> > +     }
> > +}
> > +
> > +#define MB(x) (x << 20)
> > +#define MAX_SIZE_MB 1024
> > +
> > +int main(void)
> > +{
> > +     int pipefd[2], pidfd;
> > +     bool success, retry;
> > +     size_t size;
> > +     pid_t pid;
> > +     char byte;
> > +     int res;
> > +
> > +     /* Test a wrong pidfd */
> > +     if (!process_mrelease(-1, 0) || errno != EBADF) {
> > +             perror("process_mrelease with wrong pidfd");
> > +             exit(KSFT_FAIL);
> > +     }
> > +
> > +     /* Start the test with 1MB child memory allocation */
> > +     size = 1;
> > +retry:
> > +     /*
> > +      * Pipe for the child to signal when it's done allocating
> > +      * memory
> > +      */
> > +     if (pipe(pipefd)) {
> > +             perror("pipe");
> > +             exit(KSFT_FAIL);
> > +     }
> > +     pid = fork();
> > +     if (pid < 0) {
> > +             perror("fork");
> > +             close(pipefd[0]);
> > +             close(pipefd[1]);
> > +             exit(KSFT_FAIL);
> > +     }
> > +
> > +     if (pid == 0) {
> > +             /*
> > +              * Child main routine:
> > +              * Allocate and fault-in memory and wait to be killed
> > +              */
> > +             close(pipefd[0]);
> > +             res = alloc_noexit(MB(size) / PAGE_SIZE, pipefd[1]);
> > +             close(pipefd[1]);
> > +             exit(res);
> > +     }
> > +
>
> Now the above code can be a separate function which will make it readable.

Ack.

>
> > +     /*
> > +      * Parent main routine:
> > +      * Wait for the child to finish allocations, then kill and reap
> > +      */
> > +     close(pipefd[1]);
> > +     /* Block until the child is ready */
> > +     res = read(pipefd[0], &byte, 1);
> > +     close(pipefd[0]);
> > +     if (res < 0) {
> > +             perror("read");
> > +             if (!kill(pid, SIGKILL))
> > +                     waitpid(pid, NULL, 0);
> > +             exit(KSFT_FAIL);
> > +     }
> > +
> > +     pidfd = pidfd_open(pid, 0);
> > +     if (pidfd < 0) {
> > +             perror("pidfd_open");
> > +             if (!kill(pid, SIGKILL))
> > +                     waitpid(pid, NULL, 0);
> > +             exit(KSFT_FAIL);
> > +     }
> > +
> > +     /* Run negative tests which require a live child */
> > +     run_negative_tests(pidfd);
> > +
> > +     if (kill(pid, SIGKILL)) {
> > +             perror("kill");
> > +             exit(KSFT_FAIL);
> > +     }
> > +
> > +     success = (process_mrelease(pidfd, 0) == 0);
> > +     if (!success) {
> > +             /*
> > +              * If we failed to reap because the child exited too soon,
> > +              * before we could call process_mrelease. Double child's memory
> > +              * which causes it to spend more time on cleanup and increases
> > +              * our chances of reaping its memory before it exits.
> > +              * Retry until we succeed or reach MAX_SIZE_MB.
> > +              */
> > +             if (errno == ESRCH) {
> > +                     retry = (size <= MAX_SIZE_MB);
> > +             } else {
> > +                     perror("process_mrelease");
> > +                     waitpid(pid, NULL, 0);
> > +                     exit(KSFT_FAIL);
> > +             }
> > +     }
> > +
> > +     /* Cleanup to prevent zombies */
> > +     if (waitpid(pid, NULL, 0) < 0) {
> > +             perror("waitpid");
> > +             exit(KSFT_FAIL);
> > +     }
> > +     close(pidfd);
> > +
> > +     if (!success) {
> > +             if (retry) {
> > +                     size *= 2;
> > +                     goto retry;
> > +             }
> > +             printf("All process_mrelease attempts failed!\n");
> > +             exit(KSFT_FAIL);
> > +     }
> > +
> > +     printf("Success reaping a child with %zuMB of memory allocations\n",
> > +            size);
> > +     return KSFT_PASS;
> > +}
> > +
> > +#else /* defined(__NR_pidfd_open) && defined(__NR_process_mrelease) */
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +     printf("skip: skipping process_mrelease test " \
> > +            "(missing __NR_pidfd_open and/or __NR_process_mrelease)\n");
> > +     return KSFT_SKIP;
> > +}
> > +
>
> Why do you need these ifdefs - syscall will return ENOSYS and you can
> key off that. Please take a look at other usages of syscall in the
> repo.

The issue is that I need to provide the syscall number when calling
syscall() (in my case __NR_pidfd_open and __NR_process_mrelease) and
if that number is not defined in the userspace headers on a given
system then what should I pass instead?
When implementing this I followed the examples of
https://elixir.bootlin.com/linux/latest/source/tools/testing/selftests/vm/memfd_secret.c#L30
and https://elixir.bootlin.com/linux/latest/source/tools/testing/selftests/vm/userfaultfd.c#L65.
My original implementation was modeled after this approach:
https://elixir.bootlin.com/linux/latest/source/tools/testing/selftests/vm/mlock2.h#L15.
If none of these are correct, could you please point me to the example
you want me to follow?

>
> > +#endif /* defined(__NR_pidfd_open) && defined(__NR_process_mrelease) */
> > diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
> > index 352ba00cf26b..1986162fea39 100755
> > --- a/tools/testing/selftests/vm/run_vmtests.sh
> > +++ b/tools/testing/selftests/vm/run_vmtests.sh
> > @@ -287,6 +287,22 @@ else
> >       echo "[PASS]"
> >   fi
> >
> > +echo "---------------------"
> > +echo "running mrelease_test"
> > +echo "---------------------"
> > +./mrelease_test
> > +ret_val=$?
> > +
> > +if [ $ret_val -eq 0 ]; then
> > +     echo "[PASS]"
> > +elif [ $ret_val -eq $ksft_skip ]; then
> > +      echo "[SKIP]"
> > +      exitcode=$ksft_skip
> > +else
> > +     echo "[FAIL]"
> > +     exitcode=1
> > +fi
> > +
> >   echo "-------------------"
> >   echo "running mremap_test"
> >   echo "-------------------"
> >
>
> thanks,
> -- Shuah
