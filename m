Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210F44B01F2
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 02:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbiBJBWU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Feb 2022 20:22:20 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbiBJBWS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Feb 2022 20:22:18 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8130C765F
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Feb 2022 17:22:20 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id s18so5471922ioa.12
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Feb 2022 17:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5+tRnd8Xg9x7mgUqVVo/liOxPoi3ep4CbmXvpW+HjwM=;
        b=Ss+PDDj7oCnQ2KGPqPfYltHXga74jpfEV9BYRBNQLvQeUZiGNb42fWTGaxTwOMbW8i
         S5DV/SFS/4P68yIivGidmgElaG8YYaIWt85HeKtSQ3N5sSuKOdAihDva6swjbgLOgXR3
         8b4t6WXF7CD1MmibvwSV+6SKpy/0viLlZC4Tk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5+tRnd8Xg9x7mgUqVVo/liOxPoi3ep4CbmXvpW+HjwM=;
        b=mCd2VNuJ5YPcKGzri9nqpBZVc/vZTlT2Zcl8izvY8r5iXDrzmFD9JdiREeqCsuGVA2
         jTMeat08RR926Mjl9JOHFWQH929plSLTHT9zVELOeob6k+i2Y0ex6UUYK3NXbjg/Zelk
         E3tYUomMx4eBzbprrf4x8029Rlo64nTXIB3gPbK672487ioLwZo3QAmNSO6IFqQNWnXD
         QXzutPvAx4hsOkcISJG/ZoqFoeKWZ/+Z5DW2YttkegdoG7XXy2t6vxOGfa+MWEXbkXwQ
         ovkAxbPLxpa1q+E+3ckFecqGnulKbGaOXyyt8FEFJFtVKJ8YWCT+InQysHkowqTZIH2/
         drNw==
X-Gm-Message-State: AOAM53307k4UuikiZo8dMQCSfA0tclPwVLVwwtMmnrilL9YU4XRBZ/yI
        I8N+leujuaq4shKkYvycv37VK+/AzTuLzQ==
X-Google-Smtp-Source: ABdhPJw0YIqTMBAlse9jZaw+UpEJ52/QSYtS9ASvHdFodInCPfAzt5hFgsIVmrYAIw6G2I7NeaRPOg==
X-Received: by 2002:a05:6638:22ce:: with SMTP id j14mr2844023jat.225.1644456139851;
        Wed, 09 Feb 2022 17:22:19 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id ay35sm10631712iob.3.2022.02.09.17.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 17:22:19 -0800 (PST)
Subject: Re: [RFC PATCH 5/6] selftests: Challenge RLIMIT_NPROC in user
 namespaces
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Solar Designer <solar@openwall.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220207121800.5079-1-mkoutny@suse.com>
 <20220207121800.5079-6-mkoutny@suse.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f0585ae4-5642-361f-11d6-9399bd9cc550@linuxfoundation.org>
Date:   Wed, 9 Feb 2022 18:22:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220207121800.5079-6-mkoutny@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/7/22 5:17 AM, Michal Koutný wrote:
> The services are started in descendant user namepaces, each of them
> should honor the RLIMIT_NPROC that's passed during user namespace
> creation.
> 
> 	main [user_ns_0]
> 	  ` service [user_ns_1]
> 	    ` worker 1
> 	    ` worker 2
> 	    ...
> 	    ` worker k
> 	  ...
> 	  ` service [user_ns_n]
> 	    ` worker 1
> 	    ` worker 2
> 	    ...
> 	    ` worker k
> 
> Test uses explicit synchronization, to make sure original parent's limit
> does not interfere with descendants.
> 

Thank you for updating the test with the kernel updates. Please see
comments below. A bit of a concern with how long this test will run.
Did you time it?

> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>   .../selftests/rlimits/rlimits-per-userns.c    | 154 ++++++++++++++----
>   1 file changed, 125 insertions(+), 29 deletions(-)
> 
> diff --git a/tools/testing/selftests/rlimits/rlimits-per-userns.c b/tools/testing/selftests/rlimits/rlimits-per-userns.c
> index 26dc949e93ea..54c1b345e42b 100644
> --- a/tools/testing/selftests/rlimits/rlimits-per-userns.c
> +++ b/tools/testing/selftests/rlimits/rlimits-per-userns.c
> @@ -9,7 +9,9 @@
>   #include <sys/resource.h>
>   #include <sys/prctl.h>
>   #include <sys/stat.h>
> +#include <sys/socket.h>
>   
> +#include <assert.h>
>   #include <unistd.h>
>   #include <stdlib.h>
>   #include <stdio.h>
> @@ -21,38 +23,74 @@
>   #include <errno.h>
>   #include <err.h>
>   
> -#define NR_CHILDS 2
> +#define THE_LIMIT 4
> +#define NR_CHILDREN 5
> +
> +static_assert(NR_CHILDREN >= THE_LIMIT-1, "Need slots for limit-1 children.");
>   
>   static char *service_prog;
>   static uid_t user   = 60000;
>   static uid_t group  = 60000;
> +static struct rlimit saved_limit;
> +
> +/* Two uses: main and service */
> +static pid_t child[NR_CHILDREN];
> +static pid_t pid;
>   
>   static void setrlimit_nproc(rlim_t n)
>   {
> -	pid_t pid = getpid();
>   	struct rlimit limit = {
>   		.rlim_cur = n,
>   		.rlim_max = n
>   	};
> -
> -	warnx("(pid=%d): Setting RLIMIT_NPROC=%ld", pid, n);
> +	if (getrlimit(RLIMIT_NPROC, &saved_limit) < 0)
> +		err(EXIT_FAILURE, "(pid=%d): getrlimit(RLIMIT_NPROC)", pid);
>   
>   	if (setrlimit(RLIMIT_NPROC, &limit) < 0)
>   		err(EXIT_FAILURE, "(pid=%d): setrlimit(RLIMIT_NPROC)", pid);
> +
> +	warnx("(pid=%d): Set RLIMIT_NPROC=%ld", pid, n);
> +}
> +
> +static void restore_rlimit_nproc(void)
> +{
> +	if (setrlimit(RLIMIT_NPROC, &saved_limit) < 0)
> +		err(EXIT_FAILURE, "(pid=%d): setrlimit(RLIMIT_NPROC, saved)", pid);
> +	warnx("(pid=%d) Restored RLIMIT_NPROC", pid);
>   }
>   
> -static pid_t fork_child(void)
> +enum msg_sync {
> +	UNSHARE,
> +	RLIMIT_RESTORE,
> +};
> +
> +static void sync_notify(int fd, enum msg_sync m)
>   {
> -	pid_t pid = fork();
> +	char tmp = m;
> +
> +	if (write(fd, &tmp, 1) < 0)
> +		warnx("(pid=%d): failed sync-write", pid);
> +}
>   
> -	if (pid < 0)
> +static void sync_wait(int fd, enum msg_sync m)
> +{
> +	char tmp;
> +
> +	if (read(fd, &tmp, 1) < 0)
> +		warnx("(pid=%d): failed sync-read", pid);
> +}
> +
> +static pid_t fork_child(int control_fd)
> +{
> +	pid_t new_pid = fork();
> +
> +	if (new_pid < 0)
>   		err(EXIT_FAILURE, "fork");
>   
> -	if (pid > 0)
> -		return pid;
> +	if (new_pid > 0)
> +		return new_pid;
>   
>   	pid = getpid();
> -
>   	warnx("(pid=%d): New process starting ...", pid);
>   
>   	if (prctl(PR_SET_PDEATHSIG, SIGKILL) < 0)
> @@ -73,6 +111,9 @@ static pid_t fork_child(void)
>   	if (unshare(CLONE_NEWUSER) < 0)
>   		err(EXIT_FAILURE, "unshare(CLONE_NEWUSER)");
>   
> +	sync_notify(control_fd, UNSHARE);
> +	sync_wait(control_fd, RLIMIT_RESTORE);
> +
>   	char *const argv[] = { "service", NULL };
>   	char *const envp[] = { "I_AM_SERVICE=1", NULL };
>   
> @@ -82,37 +123,92 @@ static pid_t fork_child(void)
>   	err(EXIT_FAILURE, "(pid=%d): execve", pid);
>   }
>   
> +static void run_service(void)
> +{
> +	size_t i;
> +	int ret = EXIT_SUCCESS;
> +	struct rlimit limit;
> +	char user_ns[PATH_MAX];
> +
> +	if (getrlimit(RLIMIT_NPROC, &limit) < 0)
> +		err(EXIT_FAILURE, "(pid=%d) failed getrlimit", pid);
> +	if (readlink("/proc/self/ns/user", user_ns, PATH_MAX) < 0)
> +		err(EXIT_FAILURE, "(pid=%d) failed readlink", pid);
> +
> +	warnx("(pid=%d) Service instance attempts %i children, limit %lu:%lu, ns=%s",
> +	      pid, THE_LIMIT, limit.rlim_cur, limit.rlim_max, user_ns);
> +
> +	/* test rlimit inside the service, effectively THE_LIMIT-1 becaue of service itself */
> +	for (i = 0; i < THE_LIMIT; i++) {
> +		child[i] = fork();
> +		if (child[i] == 0) {
> +			/* service child */
> +			pause();
> +			exit(EXIT_SUCCESS);
> +		}
> +		if (child[i] < 0) {
> +			warnx("(pid=%d) service fork %lu failed, errno = %i", pid, i+1, errno);
> +			if (!(i == THE_LIMIT-1 && errno == EAGAIN))
> +				ret = EXIT_FAILURE;
> +		} else if (i == THE_LIMIT-1) {
> +			warnx("(pid=%d) RLIMIT_NPROC not honored", pid);
> +			ret = EXIT_FAILURE;
> +		}
> +	}
> +
> +	/* service cleanup */
> +	for (i = 0; i < THE_LIMIT; i++)
> +		if (child[i] > 0)
> +			kill(child[i], SIGUSR1);
> +
> +	for (i = 0; i < THE_LIMIT; i++)
> +		if (child[i] > 0)
> +			waitpid(child[i], NULL, WNOHANG);
> +
> +	if (ret)
> +		exit(ret);
> +	pause();
> +}
> +
>   int main(int argc, char **argv)
>   {
>   	size_t i;
> -	pid_t child[NR_CHILDS];
> -	int wstatus[NR_CHILDS];
> -	int childs = NR_CHILDS;
> -	pid_t pid;
> +	int control_fd[NR_CHILDREN];
> +	int wstatus[NR_CHILDREN];
> +	int children = NR_CHILDREN;
> +	int sockets[2];
> +
> +	pid = getpid();
>   
>   	if (getenv("I_AM_SERVICE")) {
> -		pause();
> -		exit(EXIT_SUCCESS);
> +		run_service();
> +		exit(EXIT_FAILURE);

Why is this a failure unconditionally?

>   	}
>   
>   	service_prog = argv[0];
> -	pid = getpid();
>   
>   	warnx("(pid=%d) Starting testcase", pid);
>   
> -	/*
> -	 * This rlimit is not a problem for root because it can be exceeded.
> -	 */
> -	setrlimit_nproc(1);
> -
> -	for (i = 0; i < NR_CHILDS; i++) {
> -		child[i] = fork_child();
> +	setrlimit_nproc(THE_LIMIT);
> +	for (i = 0; i < NR_CHILDREN; i++) {
> +		if (socketpair(AF_UNIX, SOCK_DGRAM | SOCK_CLOEXEC, 0, sockets) < 0)
> +			err(EXIT_FAILURE, "(pid=%d) socketpair failed", pid);
> +		control_fd[i] = sockets[0];
> +		child[i] = fork_child(sockets[1]);
>   		wstatus[i] = 0;
> +	}
> +
> +	for (i = 0; i < NR_CHILDREN; i++)
> +		sync_wait(control_fd[i], UNSHARE);
> +	restore_rlimit_nproc();
> +
> +	for (i = 0; i < NR_CHILDREN; i++) {
> +		sync_notify(control_fd[i], RLIMIT_RESTORE);
>   		usleep(250000);

How long does this test now run for with this loop?

>   	}
>   
>   	while (1) {
> -		for (i = 0; i < NR_CHILDS; i++) {
> +		for (i = 0; i < NR_CHILDREN; i++) {
>   			if (child[i] <= 0)
>   				continue;
>   
> @@ -126,22 +222,22 @@ int main(int argc, char **argv)
>   				warn("(pid=%d): waitpid(%d)", pid, child[i]);
>   
>   			child[i] *= -1;
> -			childs -= 1;
> +			children -= 1;
>   		}
>   
> -		if (!childs)
> +		if (!children)
>   			break;
>   
>   		usleep(250000);
>   
> -		for (i = 0; i < NR_CHILDS; i++) {
> +		for (i = 0; i < NR_CHILDREN; i++) {
>   			if (child[i] <= 0)
>   				continue;
>   			kill(child[i], SIGUSR1);
>   		}
>   	}
>   
> -	for (i = 0; i < NR_CHILDS; i++) {
> +	for (i = 0; i < NR_CHILDREN; i++) {
>   		if (WIFEXITED(wstatus[i]))
>   			warnx("(pid=%d): pid %d exited, status=%d",
>   				pid, -child[i], WEXITSTATUS(wstatus[i]));
> 

Please a add few more comments in the code path.

thanks,
-- Shuah
