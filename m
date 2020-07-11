Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738C321C4F9
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jul 2020 18:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgGKQB1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 11 Jul 2020 12:01:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54020 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbgGKQB1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 11 Jul 2020 12:01:27 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1juHwK-00005T-1N; Sat, 11 Jul 2020 16:01:24 +0000
Date:   Sat, 11 Jul 2020 18:01:23 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Will Deacon <will@kernel.org>, Tycho Andersen <tycho@tycho.ws>,
        Shuah Khan <shuah@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next/seccomp v2 1/2] selftests/seccomp: Add SKIPs for
 failed unshare()
Message-ID: <20200711160123.eqqrkiz6olc4ofly@wittgenstein>
References: <20200710230107.2528890-1-keescook@chromium.org>
 <20200710230107.2528890-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200710230107.2528890-2-keescook@chromium.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 10, 2020 at 04:01:06PM -0700, Kees Cook wrote:
> Running the seccomp tests as a regular user shouldn't just fail tests
> that require CAP_SYS_ADMIN (for getting a PID namespace). Instead,
> detect those cases and SKIP them. Additionally, gracefully SKIP missing
> CONFIG_USER_NS (and add to "config" since we'd prefer to actually test
> this case).
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

Just a comment, otherwise:
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

>  tools/testing/selftests/seccomp/config        |  1 +
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 10 ++++++++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/seccomp/config b/tools/testing/selftests/seccomp/config
> index db1e11b08c8a..64c19d8eba79 100644
> --- a/tools/testing/selftests/seccomp/config
> +++ b/tools/testing/selftests/seccomp/config
> @@ -1,2 +1,3 @@
>  CONFIG_SECCOMP=y
>  CONFIG_SECCOMP_FILTER=y
> +CONFIG_USER_NS=y
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index c0aa46ce14f6..14b038361549 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -3439,7 +3439,10 @@ TEST(user_notification_child_pid_ns)
>  	struct seccomp_notif req = {};
>  	struct seccomp_notif_resp resp = {};
>  
> -	ASSERT_EQ(unshare(CLONE_NEWUSER | CLONE_NEWPID), 0);
> +	ASSERT_EQ(unshare(CLONE_NEWUSER | CLONE_NEWPID), 0) {
> +		if (errno == EINVAL)
> +			SKIP(return, "kernel missing CLONE_NEWUSER support");

That would be either CLONE_NEWUSER or CLONE_NEWPID, right? :)
Maybe just do:
"kernel misses necessary namespace support"


> +	};
>  
>  	listener = user_trap_syscall(__NR_getppid,
>  				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
> @@ -3504,7 +3507,10 @@ TEST(user_notification_sibling_pid_ns)
>  	}
>  
>  	/* Create the sibling ns, and sibling in it. */
> -	ASSERT_EQ(unshare(CLONE_NEWPID), 0);
> +	ASSERT_EQ(unshare(CLONE_NEWPID), 0) {
> +		if (errno == EPERM)
> +			SKIP(return, "CLONE_NEWPID requires CAP_SYS_ADMIN");
> +	}
>  	ASSERT_EQ(errno, 0);
>  
>  	pid2 = fork();
> -- 
> 2.25.1
> 
