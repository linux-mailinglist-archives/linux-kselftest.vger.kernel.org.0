Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216F6271C34
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Sep 2020 09:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgIUHoA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Sep 2020 03:44:00 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49268 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgIUHoA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Sep 2020 03:44:00 -0400
Received: from ip5f5af089.dynamic.kabel-deutschland.de ([95.90.240.137] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kKGUN-0001LG-Cy; Mon, 21 Sep 2020 07:43:55 +0000
Date:   Mon, 21 Sep 2020 09:43:54 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christian Brauner <christian@brauner.io>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-xtensa@linux-xtensa.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/4] selftests/seccomp: Record syscall during ptrace
 entry
Message-ID: <20200921074354.6shkt2e5yhzhj3sn@wittgenstein>
References: <20200919080637.259478-1-keescook@chromium.org>
 <20200919080637.259478-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200919080637.259478-2-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Sep 19, 2020 at 01:06:34AM -0700, Kees Cook wrote:
> In preparation for performing actions during ptrace syscall exit, save
> the syscall number during ptrace syscall entry. Some architectures do
> no have the syscall number available during ptrace syscall exit.
> 
> Suggested-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> Link: https://lore.kernel.org/linux-kselftest/20200911181012.171027-1-cascardo@canonical.com/
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 40 +++++++++++++------
>  1 file changed, 27 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index bc0fb463c709..c0311b4c736b 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -1949,12 +1949,19 @@ void tracer_seccomp(struct __test_metadata *_metadata, pid_t tracee,
>  
>  }
>  
> +FIXTURE(TRACE_syscall) {
> +	struct sock_fprog prog;
> +	pid_t tracer, mytid, mypid, parent;
> +	long syscall_nr;
> +};
> +
>  void tracer_ptrace(struct __test_metadata *_metadata, pid_t tracee,
>  		   int status, void *args)
>  {
> -	int ret, nr;
> +	int ret;
>  	unsigned long msg;
>  	static bool entry;
> +	FIXTURE_DATA(TRACE_syscall) *self = args;
>  
>  	/*
>  	 * The traditional way to tell PTRACE_SYSCALL entry/exit
> @@ -1968,24 +1975,31 @@ void tracer_ptrace(struct __test_metadata *_metadata, pid_t tracee,
>  	EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
>  			: PTRACE_EVENTMSG_SYSCALL_EXIT, msg);
>  
> -	if (!entry)
> +	/*
> +	 * Some architectures only support setting return values during
> +	 * syscall exit under ptrace, and on exit the syscall number may
> +	 * no longer be available. Therefore, save the initial sycall

s/sycall/syscall/

Otherwise looks good. Thanks!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

> +	 * number here, so it can be examined during both entry and exit
> +	 * phases.
> +	 */
> +	if (entry)
> +		self->syscall_nr = get_syscall(_metadata, tracee);
> +	else
>  		return;
>  
> -	nr = get_syscall(_metadata, tracee);
> -
> -	if (nr == __NR_getpid)
> +	switch (self->syscall_nr) {
> +	case __NR_getpid:
>  		change_syscall(_metadata, tracee, __NR_getppid, 0);
> -	if (nr == __NR_gettid)
> +		break;
> +	case __NR_gettid:
>  		change_syscall(_metadata, tracee, -1, 45000);
> -	if (nr == __NR_openat)
> +		break;
> +	case __NR_openat:
>  		change_syscall(_metadata, tracee, -1, -ESRCH);
> +		break;
> +	}
>  }
>  
> -FIXTURE(TRACE_syscall) {
> -	struct sock_fprog prog;
> -	pid_t tracer, mytid, mypid, parent;
> -};
> -
>  FIXTURE_VARIANT(TRACE_syscall) {
>  	/*
>  	 * All of the SECCOMP_RET_TRACE behaviors can be tested with either
> @@ -2044,7 +2058,7 @@ FIXTURE_SETUP(TRACE_syscall)
>  	self->tracer = setup_trace_fixture(_metadata,
>  					   variant->use_ptrace ? tracer_ptrace
>  							       : tracer_seccomp,
> -					   NULL, variant->use_ptrace);
> +					   self, variant->use_ptrace);
>  
>  	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
>  	ASSERT_EQ(0, ret);
> -- 
> 2.25.1
> 
