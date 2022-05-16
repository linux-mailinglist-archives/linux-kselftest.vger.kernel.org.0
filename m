Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B65652926D
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 May 2022 23:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348393AbiEPUzN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 May 2022 16:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348433AbiEPUzD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 May 2022 16:55:03 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4BA5799F
        for <linux-kselftest@vger.kernel.org>; Mon, 16 May 2022 13:29:31 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id i5so11342958ilv.0
        for <linux-kselftest@vger.kernel.org>; Mon, 16 May 2022 13:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PuGRloH+u//5P3OkmnMmlEby0yqxvVnIUa5L9jcPsdk=;
        b=RY1D1CY+8krhSzbUeWDMzOa9FavmzBLKPQtUl5pg2+7b6qNZMTn70+YB5utQBDcWp4
         nuhw7s+55rfZg8oIoS4sWRVudrNrtRd0fUUuxHQ3HQAFvfDN7AgA+TtH4qnb688OWfHl
         6gIJidMUTrSCGHsy0ey/3BkGw/O/SwCdeeVFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PuGRloH+u//5P3OkmnMmlEby0yqxvVnIUa5L9jcPsdk=;
        b=25UenyfZ+GTkKS502L9rXarMo1vdm/VwNGw6wnhtTyVYCNfBE5MoWNI6mXebUAlOyN
         yOkbaOFnbihKKl1K5faKcEss7afztrdFJ8nheaSs4Y0c6ag1gh1sIfDohMA2NPX9MUXK
         h1ji7H6P2EX4YZhDLbjmkIwpvJRHX8cUJIzzq8uRQUWpY84dKl/eJdhcFvFHYyCBMPsQ
         ZKx87FYZEpbg427Ngbv5pstUXrraP2EWoUmHbBxb5NcQt4/69a4RRxxsgeQ/FbapD3Bl
         HXbNskhl5FzDFQSAZGWCiTQDlv7MEWrfIx1a+tr+14iIFUQjwn6/oTW8b0SfTAONkPK8
         y3Vg==
X-Gm-Message-State: AOAM5335AHjBqhhZOXD0Oh0meLYhy60St37ZYKa/xms7ewbLQ+j8Yw0Z
        8uWQEh1h5K63qEKkXY8U7d6AZw==
X-Google-Smtp-Source: ABdhPJyldnuTvbYecoeyyA+wf0fkMZWqof2al8Hkgx7lnjrTOa2jkrma+O46KdTf+mLt+UsgDuUnNg==
X-Received: by 2002:a05:6e02:12c7:b0:2cf:7989:2d09 with SMTP id i7-20020a056e0212c700b002cf79892d09mr10023926ilm.48.1652732970525;
        Mon, 16 May 2022 13:29:30 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id c7-20020a6bfd07000000b0065a989b183asm94531ioi.41.2022.05.16.13.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 13:29:30 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] selftests: vm: add process_mrelease tests
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
References: <20220516075538.1276644-1-surenb@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <78c3a163-551b-ef53-4018-7b6ba0640757@linuxfoundation.org>
Date:   Mon, 16 May 2022 14:29:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220516075538.1276644-1-surenb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/16/22 1:55 AM, Suren Baghdasaryan wrote:
> Introduce process_mrelease syscall sanity tests which include tests
> which expect to fail:
> - process_mrelease with invalid pidfd and flags inputs
> - process_mrelease on a live process with no pending signals
> and valid process_mrelease usage which is expected to succeed.
> Because process_mrelease has to be used against a process with a pending
> SIGKILL, it's possible that the process exits before process_mrelease
> gets called. In such cases we retry the test with a victim that allocates
> twice more memory up to 1GB. This would require the victim process to
> spend more time during exit and process_mrelease has a better chance of
> catching the process before it exits and succeeding.
> 
> On success the test reports the amount of memory the child had to
> allocate for reaping to succeed. Sample output:
>      Success reaping a child with 1MB of memory allocations
> 
> On failure the test reports the failure. Sample outputs:
>      All process_mrelease attempts failed!
>      process_mrelease: Invalid argument
> 

Nit: Please format this better - include actual example output from the
command and how to run the test examples.

> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>   tools/testing/selftests/vm/.gitignore      |   1 +
>   tools/testing/selftests/vm/Makefile        |   1 +
>   tools/testing/selftests/vm/mrelease_test.c | 214 +++++++++++++++++++++
>   tools/testing/selftests/vm/run_vmtests.sh  |  16 ++
>   4 files changed, 232 insertions(+)
>   create mode 100644 tools/testing/selftests/vm/mrelease_test.c
> 
> diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
> index d7507f3c7c76..c019e53f24f9 100644
> --- a/tools/testing/selftests/vm/.gitignore
> +++ b/tools/testing/selftests/vm/.gitignore
> @@ -10,6 +10,7 @@ map_populate
>   thuge-gen
>   compaction_test
>   mlock2-tests
> +mrelease_test
>   mremap_dontunmap
>   mremap_test
>   on-fault-limit
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
> index 000000000000..99680676069b
> --- /dev/null
> +++ b/tools/testing/selftests/vm/mrelease_test.c
> @@ -0,0 +1,214 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2022 Google LLC
> + */
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +
> +#include "util.h"
> +
> +#include "../kselftest.h"
> +
> +#if defined(__NR_pidfd_open) && defined(__NR_process_mrelease)
> +
> +static inline int pidfd_open(pid_t pid, unsigned int flags)
> +{
> +	return syscall(__NR_pidfd_open, pid, flags);
> +}
> +
> +static inline int process_mrelease(int pidfd, unsigned int flags)
> +{
> +	return syscall(__NR_process_mrelease, pidfd, flags);
> +}
> +
> +static void write_fault_pages(char *addr, unsigned long nr_pages)
> +{
> +	unsigned long i;
> +
> +	for (i = 0; i < nr_pages; i++)
> +		*((unsigned long *)(addr + (i * PAGE_SIZE))) = i;
> +}
> +

Okay these above 3 routines are called once. I am not seeing any point
in making these separate routines. I made the same comment on v1.

> +static int alloc_noexit(unsigned long nr_pages, int pipefd)
> +{
> +	int timeout = 10; /* 10sec timeout to get killed */
> +	int ppid = getppid();
> +	void *buf;
> +
> +	buf = mmap(NULL, nr_pages * PAGE_SIZE, PROT_READ | PROT_WRITE,
> +		   MAP_PRIVATE | MAP_ANON, 0, 0);
> +	if (buf == MAP_FAILED) {
> +		perror("mmap failed, halting the test");
> +		return KSFT_FAIL;
> +	}
> +
> +	write_fault_pages((char *)buf, nr_pages);
> +
> +	/* Signal the parent that the child is ready */
> +	if (write(pipefd, "", 1) < 0) {
> +		perror("write");
> +		return KSFT_FAIL;
> +	}
> +
> +	/* Wait to be killed (when reparenting happens) */
> +	while (getppid() == ppid && timeout > 0) {
> +		sleep(1);
> +		timeout--;
> +	}
> +
> +	munmap(buf, nr_pages * PAGE_SIZE);
> +
> +	return (timeout > 0) ? KSFT_PASS : KSFT_FAIL;
> +}
> +
> +/* The process_mrelease calls in this test are expected to fail */
> +void run_negative_tests(int pidfd)
> +{
> +	/* Test invalid flags. Expect to fail with EINVAL error code. */
> +	if (!process_mrelease(pidfd, (unsigned int)-1) || errno != EINVAL) {
> +		perror("process_mrelease with wrong flags");
> +		exit(KSFT_FAIL);
> +	}
> +	/*
> +	 * Test reaping while process is alive with no pending SIGKILL.
> +	 * Expect to fail with EINVAL error code.
> +	 */
> +	if (!process_mrelease(pidfd, 0) || errno != EINVAL) {
> +		perror("process_mrelease on a live process");
> +		exit(KSFT_FAIL);
> +	}
> +}
> +
> +#define MB(x) (x << 20)
> +#define MAX_SIZE_MB 1024
> +
> +int main(void)
> +{
> +	int pipefd[2], pidfd;
> +	bool success, retry;
> +	size_t size;
> +	pid_t pid;
> +	char byte;
> +	int res;
> +
> +	/* Test a wrong pidfd */
> +	if (!process_mrelease(-1, 0) || errno != EBADF) {
> +		perror("process_mrelease with wrong pidfd");
> +		exit(KSFT_FAIL);
> +	}
> +
> +	/* Start the test with 1MB child memory allocation */
> +	size = 1;
> +retry:
> +	/*
> +	 * Pipe for the child to signal when it's done allocating
> +	 * memory
> +	 */
> +	if (pipe(pipefd)) {
> +		perror("pipe");
> +		exit(KSFT_FAIL);
> +	}
> +	pid = fork();
> +	if (pid < 0) {
> +		perror("fork");
> +		close(pipefd[0]);
> +		close(pipefd[1]);
> +		exit(KSFT_FAIL);
> +	}
> +
> +	if (pid == 0) {
> +		/*
> +		 * Child main routine:
> +		 * Allocate and fault-in memory and wait to be killed
> +		 */
> +		close(pipefd[0]);
> +		res = alloc_noexit(MB(size) / PAGE_SIZE, pipefd[1]);
> +		close(pipefd[1]);
> +		exit(res);
> +	}
> +

Now the above code can be a separate function which will make it readable.

> +	/*
> +	 * Parent main routine:
> +	 * Wait for the child to finish allocations, then kill and reap
> +	 */
> +	close(pipefd[1]);
> +	/* Block until the child is ready */
> +	res = read(pipefd[0], &byte, 1);
> +	close(pipefd[0]);
> +	if (res < 0) {
> +		perror("read");
> +		if (!kill(pid, SIGKILL))
> +			waitpid(pid, NULL, 0);
> +		exit(KSFT_FAIL);
> +	}
> +
> +	pidfd = pidfd_open(pid, 0);
> +	if (pidfd < 0) {
> +		perror("pidfd_open");
> +		if (!kill(pid, SIGKILL))
> +			waitpid(pid, NULL, 0);
> +		exit(KSFT_FAIL);
> +	}
> +
> +	/* Run negative tests which require a live child */
> +	run_negative_tests(pidfd);
> +
> +	if (kill(pid, SIGKILL)) {
> +		perror("kill");
> +		exit(KSFT_FAIL);
> +	}
> +
> +	success = (process_mrelease(pidfd, 0) == 0);
> +	if (!success) {
> +		/*
> +		 * If we failed to reap because the child exited too soon,
> +		 * before we could call process_mrelease. Double child's memory
> +		 * which causes it to spend more time on cleanup and increases
> +		 * our chances of reaping its memory before it exits.
> +		 * Retry until we succeed or reach MAX_SIZE_MB.
> +		 */
> +		if (errno == ESRCH) {
> +			retry = (size <= MAX_SIZE_MB);
> +		} else {
> +			perror("process_mrelease");
> +			waitpid(pid, NULL, 0);
> +			exit(KSFT_FAIL);
> +		}
> +	}
> +
> +	/* Cleanup to prevent zombies */
> +	if (waitpid(pid, NULL, 0) < 0) {
> +		perror("waitpid");
> +		exit(KSFT_FAIL);
> +	}
> +	close(pidfd);
> +
> +	if (!success) {
> +		if (retry) {
> +			size *= 2;
> +			goto retry;
> +		}
> +		printf("All process_mrelease attempts failed!\n");
> +		exit(KSFT_FAIL);
> +	}
> +
> +	printf("Success reaping a child with %zuMB of memory allocations\n",
> +	       size);
> +	return KSFT_PASS;
> +}
> +
> +#else /* defined(__NR_pidfd_open) && defined(__NR_process_mrelease) */
> +
> +int main(int argc, char *argv[])
> +{
> +	printf("skip: skipping process_mrelease test " \
> +	       "(missing __NR_pidfd_open and/or __NR_process_mrelease)\n");
> +	return KSFT_SKIP;
> +}
> +

Why do you need these ifdefs - syscall will return ENOSYS and you can
key off that. Please take a look at other usages of syscall in the
repo.
  
> +#endif /* defined(__NR_pidfd_open) && defined(__NR_process_mrelease) */
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

thanks,
-- Shuah
