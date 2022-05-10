Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C905B522138
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 18:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347369AbiEJQeB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 12:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347389AbiEJQdz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 12:33:55 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27895201E8D
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 09:29:57 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2f7c424c66cso186332407b3.1
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 09:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aJloidsDMSjNdKsdQ92Ek2s3Nok5OpSiV08K1fKvW/c=;
        b=dU8YCmE+vqGPx/am1Kbhb9tc3zBmcw0d6Vl3xCJQ6q+au/WHtm2SixK2VdNAhZDCEH
         /3EaF/lU92QNqIrwbdEOI6NG50SdQzrrY6kY4aSqX+I9/Ndw5WSQSwB2xa2bOSQQbVDC
         y0R48jDMPXhfouEBqvaAntHHhRrjdm7QBgU4Cu6bhDfJkDcB5yM5OlrDvK4xYA+6Ym6F
         m/jvJf6l0ThPiDaUQxeHTovxDgTN9RUsYZl51ogcZCtbKDMEQv76UxfSiJw+tSyZEcXg
         CfnLQXxhv091UsiouGWzA1JQol1NdpmLtNM9cRAI4JZug617Pn7TIlZVdJp0H1DcgLvu
         mJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aJloidsDMSjNdKsdQ92Ek2s3Nok5OpSiV08K1fKvW/c=;
        b=v1U7YK9pLK0wn5at5OBrCH0Ic6uQGUDdu7WOExNFWjsrQ9TGEQ3MiriU120Uf8U/pe
         A2a4QvWhqnMAOdmfVes8umLbkRsPyHcaJHHZLrqs6eaTca6aMdhzPScenKlpy+XPitSk
         uyDnK40pJPrJ9edtZ3+w6V2XcyKYmCU2OvPQqVqj67h4MH72tiCRQBhWQ+x4Fiwfm+1L
         x+d6fpHfV903g+EMOFcfTcJJBd3NrAqaPRddfdbZx1j/7rfDrN37eY0OMu7qwTsnDkGm
         mKWMDsjruiegrc/BkgT7mWjUM84NR296rPIhl0nTYB7CA7JIyC/LjopW1xjKMlTHxX7W
         kHXQ==
X-Gm-Message-State: AOAM531ZbaitR+toBwl5tYQye3bfoYSBAZ0udoMpajqaRL/kqjEotqr6
        xykyALyWorpzupHjnWYYrwfOumDgXKeWYttd739QjQ==
X-Google-Smtp-Source: ABdhPJx5rcdrZIFfWZmVEv8aWH6L4r9FXVQPuw/X4O4oc/sxy7PZ3H8d/XVNdGArXpAoEgYI+ADW7h6XzKubzLkfI7s=
X-Received: by 2002:a0d:d543:0:b0:2f7:e554:68c with SMTP id
 x64-20020a0dd543000000b002f7e554068cmr21157189ywd.380.1652200195972; Tue, 10
 May 2022 09:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220510030014.3842475-1-surenb@google.com> <04858a5d-98c8-69be-025f-214e4b10d502@linuxfoundation.org>
In-Reply-To: <04858a5d-98c8-69be-025f-214e4b10d502@linuxfoundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 10 May 2022 09:29:44 -0700
Message-ID: <CAJuCfpEAqEEf-SCi87-VZrFYcoPff8Gkda5uF8fYRyKQo_vkjw@mail.gmail.com>
Subject: Re: [PATCH 1/3] selftests: vm: add process_mrelease tests
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 10, 2022 at 8:43 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 5/9/22 9:00 PM, Suren Baghdasaryan wrote:
> > Introduce process_mrelease syscall sanity tests. They include tests of
> > invalid pidfd and flags inputs, attempting to call process_mrelease
> > with a live process and a valid usage of process_mrelease. Because
> > process_mrelease has to be used against a process with a pending SIGKILL,
> > it's possible that the process exits before process_mrelease gets called.
> > In such cases we retry the test with a victim that allocates twice more
> > memory up to 1GB. This would require the victim process to spend more
> > time during exit and process_mrelease has a better chance of catching
> > the process before it exits.
> >
>
> +1 on Mike's comments on improving the change log. List what is getting
> tested as opposed to describing the test code.

I'll try to improve the description but IMHO it does describe what
it's testing - the process_mrelease syscall with valid and invalid
inputs. I could omit the implementation details if that helps.

>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >   tools/testing/selftests/vm/Makefile        |   1 +
> >   tools/testing/selftests/vm/mrelease_test.c | 176 +++++++++++++++++++++
> >   tools/testing/selftests/vm/run_vmtests.sh  |  16 ++
> >   3 files changed, 193 insertions(+)
> >   create mode 100644 tools/testing/selftests/vm/mrelease_test.c
>
> Please update .gitignore with the new executable.

Ack.

>
> >
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
> > index 000000000000..a61061bf8433
> > --- /dev/null
> > +++ b/tools/testing/selftests/vm/mrelease_test.c
> > @@ -0,0 +1,176 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2022 Google LLC
> > + */
> > +#define _GNU_SOURCE
> > +#include <errno.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <sys/wait.h>
> > +#include <unistd.h>
> > +
> > +#include "util.h"
> > +
> > +static inline int pidfd_open(pid_t pid, unsigned int flags)
> > +{
> > +#ifdef __NR_pidfd_open
> > +     return syscall(__NR_pidfd_open, pid, flags);
> > +#else
> > +     errno = ENOSYS;
>
> This isn't an error - this would be skip because this syscall
> isn't supported.

Ack.

>
> > +     return -1;
> > +#endif
>
> Key off of syscall return instead of these ifdefs - same comment
> on all of the ifdefs

Ack. I was using some other test as an example but I guess that was
not a good model.

>
> > +}
> > +
>
> I am not seeing any reason for breaking this code up have a separate
> routine for pidfd_open().

I'm a bit unclear what you mean. Do you mean that userspace headers
should already define pidfd_open() and I don't need to define it?

>
> > +static inline int process_mrelease(int pidfd, unsigned int flags)
> > +{
> > +#ifdef __NR_process_mrelease
> > +     return syscall(__NR_process_mrelease, pidfd, flags);
> > +#else
> > +     errno = ENOSYS;
> > +     return -1;
> > +#endif> +}
> > +
>
> Same comments on ifdefs and skips here as well.

Ack.

>
> > +static void write_fault_pages(char *addr, unsigned long nr_pages)
> > +{
> > +     unsigned long i;
> > +
> > +     for (i = 0; i < nr_pages; i++)
> > +             *((unsigned long *)(addr + (i * PAGE_SIZE))) = i;
> > +}
> > +
> > +static int alloc_noexit(unsigned long nr_pages, int pipefd)
> > +{
> > +     int ppid = getppid();
> > +     void *buf;
> > +
> > +     buf = mmap(NULL, nr_pages * PAGE_SIZE, PROT_READ | PROT_WRITE,
> > +                MAP_PRIVATE | MAP_ANON, 0, 0);
> > +     if (buf == MAP_FAILED) {
> > +             perror("mmap");
>
> A bit more descriptive message what the test would do will be helpful.
> Also consider if this should be a skip or fail for the test.

I guess the question is whether an OOM condition should be considered
a test failure? I guess we could skip since the test is specifically
for process_mrelease.

>
> > +             return 1;
> > +     }
> > +
> > +     write_fault_pages((char *)buf, nr_pages);
> > +
> > +     /* Signal the parent that the child is ready */
> > +     if (write(pipefd, "", 1) < 0) {
> > +             perror("write");
> > +             return 1;
> > +     }
> > +
> > +     /* Wait to be killed (when reparenting happens) */
> > +     while (getppid() == ppid)
> > +             sleep(1);
> > +
>
> What happens if reparenting doesn't happen? Will this loop for ever?
> This test could hang?

Technically that should not happen because we kill the child and after
that it has to reparent but to be safe I'll add a timeout to prevent
an infinite loop.

>
> > +     munmap(buf, nr_pages * PAGE_SIZE);
> > +
> > +     return 0;
> > +}
> > +
> > +
> > +#define MB(x) (x << 20)
> > +#define MAX_SIZE_MB 1024
> > +
> > +int main(void)
> > +{
> > +     int res;
> > +     int pipefd[2], pidfd;
> > +     pid_t pid;
> > +     char byte;
> > +     size_t size;
> > +     int negative_tests_done = 0;
> > +
> > +     /* Test a wrong pidfd */
> > +     if (!process_mrelease(-1, 0) || errno != EBADF) {
> > +             perror("process_mrelease with wring pidfd");
>
> Incorrect spelling "wring/wrong"

Ack.

>
> > +             exit(1);
> > +     }
> > +
> > +     /*
> > +      * Start the test with 1MB allocation and double every time
> > +      * process_mrelease fails
> > +      */
> > +     for (size = 1; size <= MAX_SIZE_MB; size *= 2) {
> > +             /*
> > +              * Pipe for the child to signal when it's done allocating
> > +              * memory
> > +              */
> > +             if (pipe(pipefd)) {
> > +                     perror("pipe");
> > +                     exit(1);
> > +             }
> > +             pid = fork();
> > +             if (pid < 0) {
> > +                     perror("fork");
>
> Close the pipe?

Ack.
Although I though all FDs are closed implicitly when the process exits
(which is the case in here).

>
> > +                     exit(1);
> > +             }
> > +
> > +             if (pid == 0) {
> > +                     close(pipefd[0]);
> > +                     res = alloc_noexit(MB(size) / PAGE_SIZE, pipefd[1]);
> > +                     close(pipefd[1]);
> > +                     exit(res);
> > +             }
> > +
> > +             close(pipefd[1]);
> > +             /* Block until the child is ready */
> > +             res = read(pipefd[0], &byte, 1);
> > +             close(pipefd[0]);
> > +             if (res < 0) {
> > +                     perror("read");
> > +                     exit(1);
> > +             }
> > +
> > +             pidfd = pidfd_open(pid, 0);
> > +             if (pidfd < 0) {
> > +                     perror("pidfd_open");
> > +                     exit(1);
> > +             }
> > +
>
> The code is very hard to read. Add comments to indicate parent and child
> paths clearly so reviewers can follow the logic and be able to do effective
> review.

Ack.

>
> > +             /* Run negative tests which require a valid child only once */
> > +             if (!negative_tests_done) {
> > +                     /* Test invalid flags */
> > +                     if (!process_mrelease(pidfd, (unsigned int)-1) ||
> > +                         errno != EINVAL) {
> > +                             perror("process_mrelease with wrong flags");
> > +                             exit(1);
>
> So is this an expected fail or a test fail?

We expect it to fail with EINVAL. We fail the test if the call
succeeds or fails for any other reason.

>
> > +                     }
> > +                     /* Test reapling while process is still alive */
> > +                     if (!process_mrelease(pidfd, 0) ||
> > +                         errno != EINVAL) {
> > +                             perror("process_mrelease on a live process");
>
> So is this an expected fail or a test fail?

Expected to fail with EINVAL.

>
> > +                             exit(1);
> > +                     }
> > +                     negative_tests_done = 1;
> > +             }
>
> Now the above negative_tests_done block could be in a separate function ---
> All the others aren't really needed. It will be good for abstraction and
> readability.

I'll separate them into a stand-alone function.

>
> > +
> > +             if (kill(pid, SIGKILL)) {
> > +                     perror("kill");
>
> Include test results in the change log - so we can see the test report.

Ack. Although the test does not print any results on success, it just
succeeds or fails with an error description. I'll add outputs for both
cases.

>
> > +                     exit(1);
> > +             }
> > +
> > +             if (!process_mrelease(pidfd, 0)) {
> > +                     /* Terminate the test once process_mrelease succeeds */
> > +                     return 0;
> > +             }
> > +
> > +             /*
> > +              * Ignore the failure if the child exited before mrelease got
> > +              * called, increase allocation size and retry the test
> > +              */
>
> Add more info. on why allocating more memory helps.

Ack.

>
> > +             if (errno != ESRCH) {
> > +                     perror("process_mrelease");
> > +                     exit(1);
> > +             }
> > +
> > +             if (waitpid(pid, NULL, 0) < 0) {
> > +                     perror("waitpid");
> > +                     exit(1);
> > +             }
> > +             close(pidfd);
> > +     }
> > +
> > +     printf("All process_mrelease attempts failed!\n");
> > +     exit(1);
> > +}
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
> In general, the code flow is hard to read to make sure resources
> are released e.g: pipefd in all the error paths. The code is broken
> up into smaller chunks where it isn't needed in some cases and left
> as a large block when it could benefit from abstraction e.g: negative
> test block.
>
> Please make changes and send v2.

Will try to refactor it for a better readability. Thanks for the review!

>
> thanks,
> -- Shuah
