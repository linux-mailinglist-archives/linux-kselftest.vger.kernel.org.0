Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7142620FE
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Sep 2020 22:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbgIHUWD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Sep 2020 16:22:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54167 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbgIHUWA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Sep 2020 16:22:00 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kFk7h-0007qP-BQ; Tue, 08 Sep 2020 20:21:49 +0000
Date:   Tue, 8 Sep 2020 22:21:48 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Robert O'Callahan <robert@ocallahan.org>,
        Christian Brauner <christian@brauner.io>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/seccomp: Add test for unknown SECCOMP_RET kill
 behavior
Message-ID: <20200908202148.hiuqdbxzdjyrco2k@wittgenstein>
References: <202009081232.92206075F7@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202009081232.92206075F7@keescook>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 08, 2020 at 12:35:18PM -0700, Kees Cook wrote:
> While we testing for the behavior of unknown seccomp filter return

s/we/we're/

> values, there was no test for how it acted in a thread group. Add
> a test in the thread group tests for this.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> (This is going via the seccomp tree.)
> ---

Thanks!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

>  tools/testing/selftests/seccomp/seccomp_bpf.c | 43 ++++++++++++++++---
>  1 file changed, 37 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 7a6d40286a42..bfb382580493 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -774,8 +774,15 @@ void *kill_thread(void *data)
>  	return (void *)SIBLING_EXIT_UNKILLED;
>  }
>  
> +enum kill_t {
> +	KILL_THREAD,
> +	KILL_PROCESS,
> +	RET_UNKNOWN
> +};
> +
>  /* Prepare a thread that will kill itself or both of us. */
> -void kill_thread_or_group(struct __test_metadata *_metadata, bool kill_process)
> +void kill_thread_or_group(struct __test_metadata *_metadata,
> +			  enum kill_t kill_how)
>  {
>  	pthread_t thread;
>  	void *status;
> @@ -791,11 +798,12 @@ void kill_thread_or_group(struct __test_metadata *_metadata, bool kill_process)
>  		.len = (unsigned short)ARRAY_SIZE(filter_thread),
>  		.filter = filter_thread,
>  	};
> +	int kill = kill_how == KILL_PROCESS ? SECCOMP_RET_KILL_PROCESS : 0xAAAAAAAAA;
>  	struct sock_filter filter_process[] = {
>  		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
>  			offsetof(struct seccomp_data, nr)),
>  		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_prctl, 0, 1),
> -		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_KILL_PROCESS),
> +		BPF_STMT(BPF_RET|BPF_K, kill),
>  		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
>  	};
>  	struct sock_fprog prog_process = {
> @@ -808,13 +816,15 @@ void kill_thread_or_group(struct __test_metadata *_metadata, bool kill_process)
>  	}
>  
>  	ASSERT_EQ(0, seccomp(SECCOMP_SET_MODE_FILTER, 0,
> -			     kill_process ? &prog_process : &prog_thread));
> +			     kill_how == KILL_THREAD ? &prog_thread
> +						     : &prog_process));
>  
>  	/*
>  	 * Add the KILL_THREAD rule again to make sure that the KILL_PROCESS
>  	 * flag cannot be downgraded by a new filter.
>  	 */
> -	ASSERT_EQ(0, seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog_thread));
> +	if (kill_how == KILL_PROCESS)
> +		ASSERT_EQ(0, seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog_thread));

(Ok, meaning that you still need to observe that the thread-group gets
taken down not just a single thread.)

>  
>  	/* Start a thread that will exit immediately. */
>  	ASSERT_EQ(0, pthread_create(&thread, NULL, kill_thread, (void *)false));
> @@ -842,7 +852,7 @@ TEST(KILL_thread)
>  	child_pid = fork();
>  	ASSERT_LE(0, child_pid);
>  	if (child_pid == 0) {
> -		kill_thread_or_group(_metadata, false);
> +		kill_thread_or_group(_metadata, KILL_THREAD);
>  		_exit(38);
>  	}
>  
> @@ -861,7 +871,7 @@ TEST(KILL_process)
>  	child_pid = fork();
>  	ASSERT_LE(0, child_pid);
>  	if (child_pid == 0) {
> -		kill_thread_or_group(_metadata, true);
> +		kill_thread_or_group(_metadata, KILL_PROCESS);
>  		_exit(38);
>  	}
>  
> @@ -872,6 +882,27 @@ TEST(KILL_process)
>  	ASSERT_EQ(SIGSYS, WTERMSIG(status));
>  }
>  
> +TEST(KILL_unknown)
> +{
> +	int status;
> +	pid_t child_pid;
> +
> +	child_pid = fork();
> +	ASSERT_LE(0, child_pid);
> +	if (child_pid == 0) {
> +		kill_thread_or_group(_metadata, RET_UNKNOWN);
> +		_exit(38);
> +	}
> +
> +	ASSERT_EQ(child_pid, waitpid(child_pid, &status, 0));
> +
> +	/* If the entire process was killed, we'll see SIGSYS. */
> +	EXPECT_TRUE(WIFSIGNALED(status)) {
> +		TH_LOG("Unknown SECCOMP_RET is only killing the thread?");
> +	}
> +	ASSERT_EQ(SIGSYS, WTERMSIG(status));
> +}
> +
>  /* TODO(wad) add 64-bit versus 32-bit arg tests. */
>  TEST(arg_out_of_range)
>  {
> -- 
> 2.25.1
> 
> 
> -- 
> Kees Cook
