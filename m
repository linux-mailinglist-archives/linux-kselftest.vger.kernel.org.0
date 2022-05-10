Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE13521F3C
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 17:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346123AbiEJPrc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 11:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346108AbiEJPrb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 11:47:31 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCAD269EF5
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 08:43:32 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id e15so18955469iob.3
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 08:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X7HPPummtVT1Cpry90v/glBuyXh4uT47kyH0y1UUgaY=;
        b=Uc7pkau17EpYJQhbTAIrqfH1vsSsm9BU5xXIoSfOd+odUD5uLfxvMbeckrt1do7sgf
         hgtf9g0Stj+DxnPYF1j0fTWtnBjXms9b8D2wBzRo68PJUWd8lWEBlfMpcf7z0JKSpTQT
         sJlr9MvJ+uK8n/qePydSHov2/4p3MDPX8KFfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X7HPPummtVT1Cpry90v/glBuyXh4uT47kyH0y1UUgaY=;
        b=CKLCj1FcTXVupzgrFhm4huck1/sSawRiS6tWfPRFj98U/qQLr4j+WhPGqHAuagF+9y
         VDodGOh0pzj+iJGy5ojE7QgQjwY9+lpWw055Poc+G/u4gURCW9/8CQ6Hosx9EUaZQPtY
         N8UFKKYpH6AT1rujXx3HyXnTt/c0Dt4cnnxEkgv5/+5wVzrh8r6IlMKuSNYMdvODtyW7
         DrWe7ikEYoJ2iugNE8HQVbjYaNEmJL0OVX8FGc8PfHv/2pVF2aylTHyQ3VgvGTJwA0ql
         suu2rysY1v6McC5L0n8KAKLQv7MHcgXUJX79s3zf/QYHTjsbrxgQg9xDje7dXvJwi/G8
         BIDQ==
X-Gm-Message-State: AOAM531DqYA5kuXRGU5kN3eVPpMDURhJXEKy6H2r0f9BNY5pu3rd0Dj+
        kUP9C7CFJyLgyFuNfff0lzbq7A==
X-Google-Smtp-Source: ABdhPJylSpHzUSDTC4Rxwdlw3wUpVna0DXNxoiRAgXeke4nsyFa6/Po/Dx3GI9Cfe2SXWYKqXHpHIA==
X-Received: by 2002:a05:6638:37a8:b0:32b:5d5c:7f9d with SMTP id w40-20020a05663837a800b0032b5d5c7f9dmr10371462jal.3.1652197409849;
        Tue, 10 May 2022 08:43:29 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id q19-20020a02c8d3000000b0032b3a781744sm4453024jao.8.2022.05.10.08.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 08:43:29 -0700 (PDT)
Subject: Re: [PATCH 1/3] selftests: vm: add process_mrelease tests
To:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc:     mhocko@suse.com, rientjes@google.com, willy@infradead.org,
        hannes@cmpxchg.org, guro@fb.com, minchan@kernel.org,
        kirill@shutemov.name, aarcange@redhat.com, brauner@kernel.org,
        hch@infradead.org, oleg@redhat.com, david@redhat.com,
        jannh@google.com, shakeelb@google.com, peterx@redhat.com,
        jhubbard@nvidia.com, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220510030014.3842475-1-surenb@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <04858a5d-98c8-69be-025f-214e4b10d502@linuxfoundation.org>
Date:   Tue, 10 May 2022 09:43:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220510030014.3842475-1-surenb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/9/22 9:00 PM, Suren Baghdasaryan wrote:
> Introduce process_mrelease syscall sanity tests. They include tests of
> invalid pidfd and flags inputs, attempting to call process_mrelease
> with a live process and a valid usage of process_mrelease. Because
> process_mrelease has to be used against a process with a pending SIGKILL,
> it's possible that the process exits before process_mrelease gets called.
> In such cases we retry the test with a victim that allocates twice more
> memory up to 1GB. This would require the victim process to spend more
> time during exit and process_mrelease has a better chance of catching
> the process before it exits.
> 

+1 on Mike's comments on improving the change log. List what is getting
tested as opposed to describing the test code.

> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>   tools/testing/selftests/vm/Makefile        |   1 +
>   tools/testing/selftests/vm/mrelease_test.c | 176 +++++++++++++++++++++
>   tools/testing/selftests/vm/run_vmtests.sh  |  16 ++
>   3 files changed, 193 insertions(+)
>   create mode 100644 tools/testing/selftests/vm/mrelease_test.c

Please update .gitignore with the new executable.

> 
> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> index 04a49e876a46..733fccbff0ef 100644
> --- a/tools/testing/selftests/vm/Makefile
> +++ b/tools/testing/selftests/vm/Makefile
> @@ -43,6 +43,7 @@ TEST_GEN_FILES += map_populate
>   TEST_GEN_FILES += memfd_secret
>   TEST_GEN_FILES += mlock-random-test
>   TEST_GEN_FILES += mlock2-tests
> +TEST_GEN_FILES += mrelease_test
>   TEST_GEN_FILES += mremap_dontunmap
>   TEST_GEN_FILES += mremap_test
>   TEST_GEN_FILES += on-fault-limit
> diff --git a/tools/testing/selftests/vm/mrelease_test.c b/tools/testing/selftests/vm/mrelease_test.c
> new file mode 100644
> index 000000000000..a61061bf8433
> --- /dev/null
> +++ b/tools/testing/selftests/vm/mrelease_test.c
> @@ -0,0 +1,176 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2022 Google LLC
> + */
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +
> +#include "util.h"
> +
> +static inline int pidfd_open(pid_t pid, unsigned int flags)
> +{
> +#ifdef __NR_pidfd_open
> +	return syscall(__NR_pidfd_open, pid, flags);
> +#else
> +	errno = ENOSYS;

This isn't an error - this would be skip because this syscall
isn't supported.

> +	return -1;
> +#endif

Key off of syscall return instead of these ifdefs - same comment
on all of the ifdefs

> +}
> +

I am not seeing any reason for breaking this code up have a separate
routine for pidfd_open().

> +static inline int process_mrelease(int pidfd, unsigned int flags)
> +{
> +#ifdef __NR_process_mrelease
> +	return syscall(__NR_process_mrelease, pidfd, flags);
> +#else
> +	errno = ENOSYS;
> +	return -1;
> +#endif> +}
> +

Same comments on ifdefs and skips here as well.

> +static void write_fault_pages(char *addr, unsigned long nr_pages)
> +{
> +	unsigned long i;
> +
> +	for (i = 0; i < nr_pages; i++)
> +		*((unsigned long *)(addr + (i * PAGE_SIZE))) = i;
> +}
> +
> +static int alloc_noexit(unsigned long nr_pages, int pipefd)
> +{
> +	int ppid = getppid();
> +	void *buf;
> +
> +	buf = mmap(NULL, nr_pages * PAGE_SIZE, PROT_READ | PROT_WRITE,
> +		   MAP_PRIVATE | MAP_ANON, 0, 0);
> +	if (buf == MAP_FAILED) {
> +		perror("mmap");

A bit more descriptive message what the test would do will be helpful.
Also consider if this should be a skip or fail for the test.

> +		return 1;
> +	}
> +
> +	write_fault_pages((char *)buf, nr_pages);
> +
> +	/* Signal the parent that the child is ready */
> +	if (write(pipefd, "", 1) < 0) {
> +		perror("write");
> +		return 1;
> +	}
> +
> +	/* Wait to be killed (when reparenting happens) */
> +	while (getppid() == ppid)
> +		sleep(1);
> +

What happens if reparenting doesn't happen? Will this loop for ever?
This test could hang?

> +	munmap(buf, nr_pages * PAGE_SIZE);
> +
> +	return 0;
> +}
> +
> +
> +#define MB(x) (x << 20)
> +#define MAX_SIZE_MB 1024
> +
> +int main(void)
> +{
> +	int res;
> +	int pipefd[2], pidfd;
> +	pid_t pid;
> +	char byte;
> +	size_t size;
> +	int negative_tests_done = 0;
> +
> +	/* Test a wrong pidfd */
> +	if (!process_mrelease(-1, 0) || errno != EBADF) {
> +		perror("process_mrelease with wring pidfd");

Incorrect spelling "wring/wrong"

> +		exit(1);
> +	}
> +
> +	/*
> +	 * Start the test with 1MB allocation and double every time
> +	 * process_mrelease fails
> +	 */
> +	for (size = 1; size <= MAX_SIZE_MB; size *= 2) {
> +		/*
> +		 * Pipe for the child to signal when it's done allocating
> +		 * memory
> +		 */
> +		if (pipe(pipefd)) {
> +			perror("pipe");
> +			exit(1);
> +		}
> +		pid = fork();
> +		if (pid < 0) {
> +			perror("fork");

Close the pipe?

> +			exit(1);
> +		}
> +
> +		if (pid == 0) {
> +			close(pipefd[0]);
> +			res = alloc_noexit(MB(size) / PAGE_SIZE, pipefd[1]);
> +			close(pipefd[1]);
> +			exit(res);
> +		}
> +
> +		close(pipefd[1]);
> +		/* Block until the child is ready */
> +		res = read(pipefd[0], &byte, 1);
> +		close(pipefd[0]);
> +		if (res < 0) {
> +			perror("read");
> +			exit(1);
> +		}
> +
> +		pidfd = pidfd_open(pid, 0);
> +		if (pidfd < 0) {
> +			perror("pidfd_open");
> +			exit(1);
> +		}
> +

The code is very hard to read. Add comments to indicate parent and child
paths clearly so reviewers can follow the logic and be able to do effective
review.

> +		/* Run negative tests which require a valid child only once */
> +		if (!negative_tests_done) {
> +			/* Test invalid flags */
> +			if (!process_mrelease(pidfd, (unsigned int)-1) ||
> +			    errno != EINVAL) {
> +				perror("process_mrelease with wrong flags");
> +				exit(1);

So is this an expected fail or a test fail?

> +			}
> +			/* Test reapling while process is still alive */
> +			if (!process_mrelease(pidfd, 0) ||
> +			    errno != EINVAL) {
> +				perror("process_mrelease on a live process");

So is this an expected fail or a test fail?

> +				exit(1);
> +			}
> +			negative_tests_done = 1;
> +		}

Now the above negative_tests_done block could be in a separate function ---
All the others aren't really needed. It will be good for abstraction and
readability.

> +
> +		if (kill(pid, SIGKILL)) {
> +			perror("kill");

Include test results in the change log - so we can see the test report.

> +			exit(1);
> +		}
> +
> +		if (!process_mrelease(pidfd, 0)) {
> +			/* Terminate the test once process_mrelease succeeds */
> +			return 0;
> +		}
> +
> +		/*
> +		 * Ignore the failure if the child exited before mrelease got
> +		 * called, increase allocation size and retry the test
> +		 */

Add more info. on why allocating more memory helps.

> +		if (errno != ESRCH) {
> +			perror("process_mrelease");
> +			exit(1);
> +		}
> +
> +		if (waitpid(pid, NULL, 0) < 0) {
> +			perror("waitpid");
> +			exit(1);
> +		}
> +		close(pidfd);
> +	}
> +
> +	printf("All process_mrelease attempts failed!\n");
> +	exit(1);
> +}
> diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
> index 352ba00cf26b..1986162fea39 100755
> --- a/tools/testing/selftests/vm/run_vmtests.sh
> +++ b/tools/testing/selftests/vm/run_vmtests.sh
> @@ -287,6 +287,22 @@ else
>   	echo "[PASS]"
>   fi
>   
> +echo "---------------------"
> +echo "running mrelease_test"
> +echo "---------------------"
> +./mrelease_test
> +ret_val=$?
> +
> +if [ $ret_val -eq 0 ]; then
> +	echo "[PASS]"
> +elif [ $ret_val -eq $ksft_skip ]; then
> +	 echo "[SKIP]"
> +	 exitcode=$ksft_skip
> +else
> +	echo "[FAIL]"
> +	exitcode=1
> +fi
> +
>   echo "-------------------"
>   echo "running mremap_test"
>   echo "-------------------"
> 

In general, the code flow is hard to read to make sure resources
are released e.g: pipefd in all the error paths. The code is broken
up into smaller chunks where it isn't needed in some cases and left
as a large block when it could benefit from abstraction e.g: negative
test block.

Please make changes and send v2.

thanks,
-- Shuah
