Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1899633FE12
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Mar 2021 05:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhCREIr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Mar 2021 00:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhCREIe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Mar 2021 00:08:34 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E48C06175F
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Mar 2021 21:08:33 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id a22-20020a17090aa516b02900c1215e9b33so4313915pjq.5
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Mar 2021 21:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hny7vl6ajF37+ZTj+synxuBuVil/J+UqH55Pp7BuhGg=;
        b=NfQZb06uCe92hW/UUvraPh2kTMs1x/xN4ksqrs4ryWCyWalY5jzwLdvQSzhT13foF9
         iWwdYAYKSEnKwSVExjSFW8pVIKArgftDgygHf/46yO3P7KbWbqz6OSsroHEa5h5JfNCZ
         f6uS7+dhr7IWog9SeugnilYj0mv7raMJji34I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hny7vl6ajF37+ZTj+synxuBuVil/J+UqH55Pp7BuhGg=;
        b=JljbRlit7I8jayqCKPHMTAYtbBWXIQoKMMEeiIABbm9zr8lqk1mGU0FB1Fe45zGWbO
         i1vkzWpZk+LKoXI0F+nO0uN7b2rckP0vSvZjzY1qVv5pc9Gl/C/d3m4+8IwqjUAW3QjQ
         SOPnFPGV36mm7ky1GiEFoZEGVlftxgdfnwUFTwKuV/pr0Gnm3w/1vGf8wxYkx+4jWK4/
         XcIarJ7fv8ZS5QbsiG77I5mihktg0oNU4aqVWe2hFwhUMbFKxB2qhcMqLvdSrJYq4aWS
         ls6yPLRvouVB2HoZe87urUmOlFnufRrG4tUiAkiIQH58y9mlrPEuC1mp9rjs5i94FpDb
         sO4w==
X-Gm-Message-State: AOAM531YjzSsG1R2bNnSWfuIjTpHCZxwTDm5kadOqciS3yfBEVfRPcMd
        RoNDY5b9kkOUhDjUhuoXuCvg9CtJUArhQg==
X-Google-Smtp-Source: ABdhPJyvHru/7I9J6jT1bGusSRTW9W3+wRd9i7WKsua7MHhOYMUb5M8RQKakp6Y7zqrWsGUMYUIr8A==
X-Received: by 2002:a17:90a:670a:: with SMTP id n10mr2158281pjj.101.1616040513085;
        Wed, 17 Mar 2021 21:08:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n9sm520890pjq.38.2021.03.17.21.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 21:08:17 -0700 (PDT)
Date:   Wed, 17 Mar 2021 21:08:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     John Wood <john.wood@gmx.com>
Cc:     Jann Horn <jannh@google.com>, Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        Shuah Khan <shuah@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v6 6/8] selftests/brute: Add tests for the Brute LSM
Message-ID: <202103172105.F88F6745@keescook>
References: <20210307113031.11671-1-john.wood@gmx.com>
 <20210307113031.11671-7-john.wood@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210307113031.11671-7-john.wood@gmx.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Mar 07, 2021 at 12:30:29PM +0100, John Wood wrote:
> Add tests to check the brute LSM functionality and cover fork/exec brute
> force attacks crossing the following privilege boundaries:
> 
> 1.- setuid process
> 2.- privilege changes
> 3.- network to local
> 
> Also, as a first step check that fork/exec brute force attacks without
> crossing any privilege boundariy already commented doesn't trigger the
> detection and mitigation stage.
> 
> All the fork brute force attacks are carried out via the "exec" app to
> avoid the triggering of the "brute" LSM over the shell script running
> the tests.
> 
> Signed-off-by: John Wood <john.wood@gmx.com>

Yay tests!

> ---
>  tools/testing/selftests/Makefile         |   1 +
>  tools/testing/selftests/brute/.gitignore |   2 +
>  tools/testing/selftests/brute/Makefile   |   5 +
>  tools/testing/selftests/brute/config     |   1 +
>  tools/testing/selftests/brute/exec.c     |  44 ++
>  tools/testing/selftests/brute/test.c     | 507 +++++++++++++++++++++++
>  tools/testing/selftests/brute/test.sh    | 226 ++++++++++
>  7 files changed, 786 insertions(+)
>  create mode 100644 tools/testing/selftests/brute/.gitignore
>  create mode 100644 tools/testing/selftests/brute/Makefile
>  create mode 100644 tools/testing/selftests/brute/config
>  create mode 100644 tools/testing/selftests/brute/exec.c
>  create mode 100644 tools/testing/selftests/brute/test.c
>  create mode 100755 tools/testing/selftests/brute/test.sh
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 6c575cf34a71..d4cf9e1c0a6d 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -2,6 +2,7 @@
>  TARGETS = arm64
>  TARGETS += bpf
>  TARGETS += breakpoints
> +TARGETS += brute
>  TARGETS += capabilities
>  TARGETS += cgroup
>  TARGETS += clone3
> diff --git a/tools/testing/selftests/brute/.gitignore b/tools/testing/selftests/brute/.gitignore
> new file mode 100644
> index 000000000000..1ccc45251a1b
> --- /dev/null
> +++ b/tools/testing/selftests/brute/.gitignore
> @@ -0,0 +1,2 @@
> +exec
> +test
> diff --git a/tools/testing/selftests/brute/Makefile b/tools/testing/selftests/brute/Makefile
> new file mode 100644
> index 000000000000..52662d0b484c
> --- /dev/null
> +++ b/tools/testing/selftests/brute/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +CFLAGS += -Wall -O2
> +TEST_PROGS := test.sh
> +TEST_GEN_FILES := exec test
> +include ../lib.mk
> diff --git a/tools/testing/selftests/brute/config b/tools/testing/selftests/brute/config
> new file mode 100644
> index 000000000000..3587b7bf6c23
> --- /dev/null
> +++ b/tools/testing/selftests/brute/config
> @@ -0,0 +1 @@
> +CONFIG_SECURITY_FORK_BRUTE=y
> diff --git a/tools/testing/selftests/brute/exec.c b/tools/testing/selftests/brute/exec.c
> new file mode 100644
> index 000000000000..1bbe72f6e4bd
> --- /dev/null
> +++ b/tools/testing/selftests/brute/exec.c
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <libgen.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +
> +static __attribute__((noreturn)) void error_failure(const char *message)
> +{
> +	perror(message);
> +	exit(EXIT_FAILURE);
> +}
> +
> +#define PROG_NAME basename(argv[0])
> +
> +int main(int argc, char **argv)
> +{
> +	pid_t pid;
> +	int status;
> +
> +	if (argc < 2) {
> +		printf("Usage: %s <EXECUTABLE>\n", PROG_NAME);
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	pid = fork();
> +	if (pid < 0)
> +		error_failure("fork");
> +
> +	/* Child process */
> +	if (!pid) {
> +		execve(argv[1], &argv[1], NULL);
> +		error_failure("execve");
> +	}
> +
> +	/* Parent process */
> +	pid = waitpid(pid, &status, 0);
> +	if (pid < 0)
> +		error_failure("waitpid");
> +
> +	return EXIT_SUCCESS;
> +}
> diff --git a/tools/testing/selftests/brute/test.c b/tools/testing/selftests/brute/test.c
> new file mode 100644
> index 000000000000..44c32f446dca
> --- /dev/null
> +++ b/tools/testing/selftests/brute/test.c
> @@ -0,0 +1,507 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <arpa/inet.h>
> +#include <errno.h>
> +#include <libgen.h>
> +#include <pwd.h>
> +#include <signal.h>
> +#include <stdbool.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/socket.h>
> +#include <sys/time.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +
> +static const char *message = "message";
> +
> +enum mode {
> +	MODE_NONE,
> +	MODE_CRASH,
> +	MODE_SERVER_CRASH,
> +	MODE_CLIENT,
> +};
> +
> +enum crash_after {
> +	CRASH_AFTER_NONE,
> +	CRASH_AFTER_FORK,
> +	CRASH_AFTER_EXEC,
> +};
> +
> +enum signal_from {
> +	SIGNAL_FROM_NONE,
> +	SIGNAL_FROM_USER,
> +	SIGNAL_FROM_KERNEL,
> +};
> +
> +struct args {
> +	uint32_t ip;
> +	uint16_t port;
> +	int counter;
> +	long timeout;
> +	enum mode mode;
> +	enum crash_after crash_after;
> +	enum signal_from signal_from;
> +	unsigned char has_counter : 1;
> +	unsigned char has_change_priv : 1;
> +	unsigned char has_ip : 1;
> +	unsigned char has_port : 1;
> +	unsigned char has_timeout : 1;
> +};
> +
> +#define OPT_STRING "hm:c:s:n:Ca:p:t:"
> +
> +static void usage(const char *prog)
> +{
> +	printf("Usage: %s <OPTIONS>\n", prog);
> +	printf("OPTIONS:\n");
> +	printf("  -h: Show this help and exit. Optional.\n");
> +	printf("  -m (crash | server_crash | client): Mode. Required.\n");
> +	printf("Options for crash mode:\n");
> +	printf("  -c (fork | exec): Crash after. Optional.\n");
> +	printf("  -s (user | kernel): Signal from. Required.\n");
> +	printf("  -n counter: Number of crashes.\n");
> +	printf("              Required if the option -c is used.\n");
> +	printf("              Not used without the option -c.\n");
> +	printf("              Range from 1 to INT_MAX.\n");
> +	printf("  -C: Change privileges before crash. Optional.\n");
> +	printf("Options for server_crash mode:\n");
> +	printf("  -a ip: Ip v4 address to accept. Required.\n");
> +	printf("  -p port: Port number. Required.\n");
> +	printf("           Range from 1 to UINT16_MAX.\n");
> +	printf("  -t secs: Accept timeout. Required.\n");
> +	printf("           Range from 1 to LONG_MAX.\n");
> +	printf("  -c (fork | exec): Crash after. Required.\n");
> +	printf("  -s (user | kernel): Signal from. Required.\n");
> +	printf("  -n counter: Number of crashes. Required.\n");
> +	printf("              Range from 1 to INT_MAX.\n");
> +	printf("Options for client mode:\n");
> +	printf("  -a ip: Ip v4 address to connect. Required.\n");
> +	printf("  -p port: Port number. Required.\n");
> +	printf("           Range from 1 to UINT16_MAX.\n");
> +	printf("  -t secs: Connect timeout. Required.\n");
> +	printf("           Range from 1 to LONG_MAX.\n");
> +}
> +
> +static __attribute__((noreturn)) void info_failure(const char *message,
> +						   const char *prog)
> +{
> +	printf("%s\n", message);
> +	usage(prog);
> +	exit(EXIT_FAILURE);
> +}
> +
> +static enum mode get_mode(const char *text, const char *prog)
> +{
> +	if (!strcmp(text, "crash"))
> +		return MODE_CRASH;
> +
> +	if (!strcmp(text, "server_crash"))
> +		return MODE_SERVER_CRASH;
> +
> +	if (!strcmp(text, "client"))
> +		return MODE_CLIENT;
> +
> +	info_failure("Invalid mode option [-m].", prog);
> +}
> +
> +static enum crash_after get_crash_after(const char *text, const char *prog)
> +{
> +	if (!strcmp(text, "fork"))
> +		return CRASH_AFTER_FORK;
> +
> +	if (!strcmp(text, "exec"))
> +		return CRASH_AFTER_EXEC;
> +
> +	info_failure("Invalid crash after option [-c].", prog);
> +}
> +
> +static enum signal_from get_signal_from(const char *text, const char *prog)
> +{
> +	if (!strcmp(text, "user"))
> +		return SIGNAL_FROM_USER;
> +
> +	if (!strcmp(text, "kernel"))
> +		return SIGNAL_FROM_KERNEL;
> +
> +	info_failure("Invalid signal from option [-s]", prog);
> +}
> +
> +static int get_counter(const char *text, const char *prog)
> +{
> +	int counter;
> +
> +	counter = atoi(text);
> +	if (counter > 0)
> +		return counter;
> +
> +	info_failure("Invalid counter option [-n].", prog);
> +}
> +
> +static __attribute__((noreturn)) void error_failure(const char *message)
> +{
> +	perror(message);
> +	exit(EXIT_FAILURE);
> +}
> +
> +static uint32_t get_ip(const char *text, const char *prog)
> +{
> +	int ret;
> +	uint32_t ip;
> +
> +	ret = inet_pton(AF_INET, text, &ip);
> +	if (!ret)
> +		info_failure("Invalid ip option [-a].", prog);
> +	else if (ret < 0)
> +		error_failure("inet_pton");
> +
> +	return ip;
> +}
> +
> +static uint16_t get_port(const char *text, const char *prog)
> +{
> +	long port;
> +
> +	port = atol(text);
> +	if ((port > 0) && (port <= UINT16_MAX))
> +		return htons(port);
> +
> +	info_failure("Invalid port option [-p].", prog);
> +}
> +
> +static long get_timeout(const char *text, const char *prog)
> +{
> +	long timeout;
> +
> +	timeout = atol(text);
> +	if (timeout > 0)
> +		return timeout;
> +
> +	info_failure("Invalid timeout option [-t].", prog);
> +}
> +
> +static void check_args(const struct args *args, const char *prog)
> +{
> +	if (args->mode == MODE_CRASH && args->crash_after != CRASH_AFTER_NONE &&
> +	    args->signal_from != SIGNAL_FROM_NONE && args->has_counter &&
> +	    !args->has_ip && !args->has_port && !args->has_timeout)
> +		return;
> +
> +	if (args->mode == MODE_CRASH && args->signal_from != SIGNAL_FROM_NONE &&
> +	    args->crash_after == CRASH_AFTER_NONE && !args->has_counter &&
> +	    !args->has_ip && !args->has_port && !args->has_timeout)
> +		return;
> +
> +	if (args->mode == MODE_SERVER_CRASH && args->has_ip && args->has_port &&
> +	    args->has_timeout && args->crash_after != CRASH_AFTER_NONE &&
> +	    args->signal_from != SIGNAL_FROM_NONE && args->has_counter &&
> +	    !args->has_change_priv)
> +		return;
> +
> +	if (args->mode == MODE_CLIENT && args->has_ip && args->has_port &&
> +	    args->has_timeout && args->crash_after == CRASH_AFTER_NONE &&
> +	    args->signal_from == SIGNAL_FROM_NONE && !args->has_counter &&
> +	    !args->has_change_priv)
> +		return;
> +
> +	info_failure("Invalid use of options.", prog);
> +}
> +
> +static uid_t get_non_root_uid(void)
> +{
> +	struct passwd *pwent;
> +	uid_t uid;
> +
> +	while (true) {
> +		errno = 0;
> +		pwent = getpwent();
> +		if (!pwent) {
> +			if (errno) {
> +				perror("getpwent");
> +				endpwent();
> +				exit(EXIT_FAILURE);
> +			}
> +			break;
> +		}
> +
> +		if (pwent->pw_uid) {
> +			uid = pwent->pw_uid;
> +			endpwent();
> +			return uid;
> +		}
> +	}
> +
> +	endpwent();
> +	printf("A user different of root is needed.\n");
> +	exit(EXIT_FAILURE);
> +}
> +
> +static inline void do_sigsegv(void)
> +{
> +	int *p = NULL;
> +	*p = 0;
> +}
> +
> +static void do_sigkill(void)
> +{
> +	int ret;
> +
> +	ret = kill(getpid(), SIGKILL);
> +	if (ret)
> +		error_failure("kill");
> +}
> +
> +static void crash(enum signal_from signal_from, bool change_priv)
> +{
> +	int ret;
> +
> +	if (change_priv) {
> +		ret = setuid(get_non_root_uid());
> +		if (ret)
> +			error_failure("setuid");
> +	}
> +
> +	if (signal_from == SIGNAL_FROM_KERNEL)
> +		do_sigsegv();
> +
> +	do_sigkill();
> +}
> +
> +static void execve_crash(char *const argv[])
> +{
> +	execve(argv[0], argv, NULL);
> +	error_failure("execve");
> +}
> +
> +static void exec_crash_user(void)
> +{
> +	char *const argv[] = {
> +		"./test", "-m", "crash", "-s", "user", NULL,
> +	};
> +
> +	execve_crash(argv);
> +}
> +
> +static void exec_crash_user_change_priv(void)
> +{
> +	char *const argv[] = {
> +		"./test", "-m", "crash", "-s", "user", "-C", NULL,
> +	};
> +
> +	execve_crash(argv);
> +}
> +
> +static void exec_crash_kernel(void)
> +{
> +	char *const argv[] = {
> +		"./test", "-m", "crash", "-s", "kernel", NULL,
> +	};
> +
> +	execve_crash(argv);
> +}
> +
> +static void exec_crash_kernel_change_priv(void)
> +{
> +	char *const argv[] = {
> +		"./test", "-m", "crash", "-s", "kernel", "-C", NULL,
> +	};
> +
> +	execve_crash(argv);
> +}
> +
> +static void exec_crash(enum signal_from signal_from, bool change_priv)
> +{
> +	if (signal_from == SIGNAL_FROM_USER && !change_priv)
> +		exec_crash_user();
> +	if (signal_from == SIGNAL_FROM_USER && change_priv)
> +		exec_crash_user_change_priv();
> +	if (signal_from == SIGNAL_FROM_KERNEL && !change_priv)
> +		exec_crash_kernel();
> +	if (signal_from == SIGNAL_FROM_KERNEL && change_priv)
> +		exec_crash_kernel_change_priv();
> +}
> +
> +static void do_crash(enum crash_after crash_after, enum signal_from signal_from,
> +		     int counter, bool change_priv)
> +{
> +	pid_t pid;
> +	int status;
> +
> +	if (crash_after == CRASH_AFTER_NONE)
> +		crash(signal_from, change_priv);
> +
> +	while (counter > 0) {
> +		pid = fork();
> +		if (pid < 0)
> +			error_failure("fork");
> +
> +		/* Child process */
> +		if (!pid) {
> +			if (crash_after == CRASH_AFTER_FORK)
> +				crash(signal_from, change_priv);
> +
> +			exec_crash(signal_from, change_priv);
> +		}
> +
> +		/* Parent process */
> +		counter -= 1;
> +		pid = waitpid(pid, &status, 0);
> +		if (pid < 0)
> +			error_failure("waitpid");
> +	}
> +}
> +
> +static __attribute__((noreturn)) void error_close_failure(const char *message,
> +							  int fd)
> +{
> +	perror(message);
> +	close(fd);
> +	exit(EXIT_FAILURE);
> +}
> +
> +static void do_server(uint32_t ip, uint16_t port, long accept_timeout)
> +{
> +	int sockfd;
> +	int ret;
> +	struct sockaddr_in address;
> +	struct timeval timeout;
> +	int newsockfd;
> +
> +	sockfd = socket(AF_INET, SOCK_STREAM, 0);
> +	if (sockfd < 0)
> +		error_failure("socket");
> +
> +	address.sin_family = AF_INET;
> +	address.sin_addr.s_addr = ip;
> +	address.sin_port = port;
> +
> +	ret = bind(sockfd, (const struct sockaddr *)&address, sizeof(address));
> +	if (ret)
> +		error_close_failure("bind", sockfd);
> +
> +	ret = listen(sockfd, 1);
> +	if (ret)
> +		error_close_failure("listen", sockfd);
> +
> +	timeout.tv_sec = accept_timeout;
> +	timeout.tv_usec = 0;
> +	ret = setsockopt(sockfd, SOL_SOCKET, SO_RCVTIMEO,
> +			 (const struct timeval *)&timeout, sizeof(timeout));
> +	if (ret)
> +		error_close_failure("setsockopt", sockfd);
> +
> +	newsockfd = accept(sockfd, NULL, NULL);
> +	if (newsockfd < 0)
> +		error_close_failure("accept", sockfd);
> +
> +	close(sockfd);
> +	close(newsockfd);
> +}
> +
> +static void do_client(uint32_t ip, uint16_t port, long connect_timeout)
> +{
> +	int sockfd;
> +	int ret;
> +	struct timeval timeout;
> +	struct sockaddr_in address;
> +
> +	sockfd = socket(AF_INET, SOCK_STREAM, 0);
> +	if (sockfd < 0)
> +		error_failure("socket");
> +
> +	timeout.tv_sec = connect_timeout;
> +	timeout.tv_usec = 0;
> +	ret = setsockopt(sockfd, SOL_SOCKET, SO_SNDTIMEO,
> +			 (const struct timeval *)&timeout, sizeof(timeout));
> +	if (ret)
> +		error_close_failure("setsockopt", sockfd);
> +
> +	address.sin_family = AF_INET;
> +	address.sin_addr.s_addr = ip;
> +	address.sin_port = port;
> +
> +	ret = connect(sockfd, (const struct sockaddr *)&address,
> +		      sizeof(address));
> +	if (ret)
> +		error_close_failure("connect", sockfd);
> +
> +	ret = write(sockfd, message, strlen(message));
> +	if (ret < 0)
> +		error_close_failure("write", sockfd);
> +
> +	close(sockfd);
> +}
> +
> +#define PROG_NAME basename(argv[0])
> +
> +int main(int argc, char **argv)
> +{
> +	int opt;
> +	struct args args = {
> +		.mode = MODE_NONE,
> +		.crash_after = CRASH_AFTER_NONE,
> +		.signal_from = SIGNAL_FROM_NONE,
> +		.has_counter = false,
> +		.has_change_priv = false,
> +		.has_ip = false,
> +		.has_port = false,
> +		.has_timeout = false,
> +	};
> +
> +	while ((opt = getopt(argc, argv, OPT_STRING)) != -1) {
> +		switch (opt) {
> +		case 'h':
> +			usage(PROG_NAME);
> +			return EXIT_SUCCESS;
> +		case 'm':
> +			args.mode = get_mode(optarg, PROG_NAME);
> +			break;
> +		case 'c':
> +			args.crash_after = get_crash_after(optarg, PROG_NAME);
> +			break;
> +		case 's':
> +			args.signal_from = get_signal_from(optarg, PROG_NAME);
> +			break;
> +		case 'n':
> +			args.counter = get_counter(optarg, PROG_NAME);
> +			args.has_counter = true;
> +			break;
> +		case 'C':
> +			args.has_change_priv = true;
> +			break;
> +		case 'a':
> +			args.ip = get_ip(optarg, PROG_NAME);
> +			args.has_ip = true;
> +			break;
> +		case 'p':
> +			args.port = get_port(optarg, PROG_NAME);
> +			args.has_port = true;
> +			break;
> +		case 't':
> +			args.timeout = get_timeout(optarg, PROG_NAME);
> +			args.has_timeout = true;
> +			break;
> +		default:
> +			usage(PROG_NAME);
> +			return EXIT_FAILURE;
> +		}
> +	}
> +
> +	check_args(&args, PROG_NAME);
> +
> +	if (args.mode == MODE_CRASH) {
> +		do_crash(args.crash_after, args.signal_from, args.counter,
> +			 args.has_change_priv);
> +	} else if (args.mode == MODE_SERVER_CRASH) {
> +		do_server(args.ip, args.port, args.timeout);
> +		do_crash(args.crash_after, args.signal_from, args.counter,
> +			 false);
> +	} else if (args.mode == MODE_CLIENT) {
> +		do_client(args.ip, args.port, args.timeout);
> +	}
> +
> +	return EXIT_SUCCESS;
> +}
> diff --git a/tools/testing/selftests/brute/test.sh b/tools/testing/selftests/brute/test.sh
> new file mode 100755
> index 000000000000..f53f26ae5b96
> --- /dev/null
> +++ b/tools/testing/selftests/brute/test.sh
> @@ -0,0 +1,226 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +TCID="test.sh"
> +
> +KSFT_PASS=0
> +KSFT_FAIL=1
> +KSFT_SKIP=4
> +
> +errno=$KSFT_PASS
> +
> +check_root()
> +{
> +	local uid=$(id -u)
> +	if [ $uid -ne 0 ]; then
> +		echo $TCID: must be run as root >&2
> +		exit $KSFT_SKIP
> +	fi
> +}
> +
> +count_fork_matches()
> +{
> +	dmesg | grep "brute: Fork brute force attack detected" | wc -l

This may be unstable if the dmesg scrolls past, etc. See how
lkdtm/run.sh handles this with a temp file and "comm".

> +}
> +
> +assert_equal()
> +{
> +	local val1=$1
> +	local val2=$2
> +
> +	if [ $val1 -eq $val2 ]; then
> +		echo "$TCID: $message [PASS]"
> +	else
> +		echo "$TCID: $message [FAIL]"
> +		errno=$KSFT_FAIL
> +	fi
> +}
> +
> +test_fork_user()
> +{
> +	COUNTER=20
> +
> +	old_count=$(count_fork_matches)
> +	./exec test -m crash -c fork -s user -n $COUNTER
> +	new_count=$(count_fork_matches)
> +
> +	message="Fork attack (user signals, no bounds crossed)"
> +	assert_equal $old_count $new_count
> +}
> +
> +test_fork_kernel()
> +{
> +	old_count=$(count_fork_matches)
> +	./exec test -m crash -c fork -s kernel -n $COUNTER
> +	new_count=$(count_fork_matches)
> +
> +	message="Fork attack (kernel signals, no bounds crossed)"
> +	assert_equal $old_count $new_count
> +}
> +
> +count_exec_matches()
> +{
> +	dmesg | grep "brute: Exec brute force attack detected" | wc -l
> +}
> +
> +test_exec_user()
> +{
> +	old_count=$(count_exec_matches)
> +	./test -m crash -c exec -s user -n $COUNTER
> +	new_count=$(count_exec_matches)
> +
> +	message="Exec attack (user signals, no bounds crossed)"
> +	assert_equal $old_count $new_count
> +}
> +
> +test_exec_kernel()
> +{
> +	old_count=$(count_exec_matches)
> +	./test -m crash -c exec -s kernel -n $COUNTER
> +	new_count=$(count_exec_matches)
> +
> +	message="Exec attack (kernel signals, no bounds crossed)"
> +	assert_equal $old_count $new_count
> +}
> +
> +assert_not_equal()
> +{
> +	local val1=$1
> +	local val2=$2
> +
> +	if [ $val1 -ne $val2 ]; then
> +		echo $TCID: $message [PASS]
> +	else
> +		echo $TCID: $message [FAIL]
> +		errno=$KSFT_FAIL
> +	fi
> +}
> +
> +test_fork_kernel_setuid()
> +{
> +	old_count=$(count_fork_matches)
> +	chmod u+s test
> +	./exec test -m crash -c fork -s kernel -n $COUNTER
> +	chmod u-s test
> +	new_count=$(count_fork_matches)
> +
> +	message="Fork attack (kernel signals, setuid binary)"
> +	assert_not_equal $old_count $new_count
> +}
> +
> +test_exec_kernel_setuid()
> +{
> +	old_count=$(count_exec_matches)
> +	chmod u+s test
> +	./test -m crash -c exec -s kernel -n $COUNTER
> +	chmod u-s test
> +	new_count=$(count_exec_matches)
> +
> +	message="Exec attack (kernel signals, setuid binary)"
> +	assert_not_equal $old_count $new_count
> +}
> +
> +test_fork_kernel_change_priv()
> +{
> +	old_count=$(count_fork_matches)
> +	./exec test -m crash -c fork -s kernel -n $COUNTER -C
> +	new_count=$(count_fork_matches)
> +
> +	message="Fork attack (kernel signals, change privileges)"
> +	assert_not_equal $old_count $new_count
> +}
> +
> +test_exec_kernel_change_priv()
> +{
> +	old_count=$(count_exec_matches)
> +	./test -m crash -c exec -s kernel -n $COUNTER -C
> +	new_count=$(count_exec_matches)
> +
> +	message="Exec attack (kernel signals, change privileges)"
> +	assert_not_equal $old_count $new_count
> +}
> +
> +network_ns_setup()
> +{
> +	local vnet_name=$1
> +	local veth_name=$2
> +	local ip_src=$3
> +	local ip_dst=$4
> +
> +	ip netns add $vnet_name
> +	ip link set $veth_name netns $vnet_name
> +	ip -n $vnet_name addr add $ip_src/24 dev $veth_name
> +	ip -n $vnet_name link set $veth_name up
> +	ip -n $vnet_name route add $ip_dst/24 dev $veth_name
> +}
> +
> +network_setup()
> +{
> +	VETH0_NAME=veth0
> +	VNET0_NAME=vnet0
> +	VNET0_IP=10.0.1.0
> +	VETH1_NAME=veth1
> +	VNET1_NAME=vnet1
> +	VNET1_IP=10.0.2.0
> +
> +	ip link add $VETH0_NAME type veth peer name $VETH1_NAME
> +	network_ns_setup $VNET0_NAME $VETH0_NAME $VNET0_IP $VNET1_IP
> +	network_ns_setup $VNET1_NAME $VETH1_NAME $VNET1_IP $VNET0_IP
> +}
> +
> +test_fork_kernel_network_to_local()
> +{
> +	INADDR_ANY=0.0.0.0
> +	PORT=65535
> +	TIMEOUT=5
> +
> +	old_count=$(count_fork_matches)
> +	ip netns exec $VNET0_NAME ./exec test -m server_crash -a $INADDR_ANY \
> +		-p $PORT -t $TIMEOUT -c fork -s kernel -n $COUNTER &
> +	sleep 1
> +	ip netns exec $VNET1_NAME ./test -m client -a $VNET0_IP -p $PORT \
> +		-t $TIMEOUT
> +	sleep 1
> +	new_count=$(count_fork_matches)
> +
> +	message="Fork attack (kernel signals, network to local)"
> +	assert_not_equal $old_count $new_count
> +}
> +
> +test_exec_kernel_network_to_local()
> +{
> +	old_count=$(count_exec_matches)
> +	ip netns exec $VNET0_NAME ./test -m server_crash -a $INADDR_ANY \
> +		-p $PORT -t $TIMEOUT -c exec -s kernel -n $COUNTER &
> +	sleep 1
> +	ip netns exec $VNET1_NAME ./test -m client -a $VNET0_IP -p $PORT \
> +		-t $TIMEOUT
> +	sleep 1
> +	new_count=$(count_exec_matches)
> +
> +	message="Exec attack (kernel signals, network to local)"
> +	assert_not_equal $old_count $new_count
> +}
> +
> +network_cleanup()
> +{
> +	ip netns del $VNET0_NAME >/dev/null 2>&1
> +	ip netns del $VNET1_NAME >/dev/null 2>&1
> +	ip link delete $VETH0_NAME >/dev/null 2>&1
> +	ip link delete $VETH1_NAME >/dev/null 2>&1
> +}
> +
> +check_root
> +test_fork_user
> +test_fork_kernel
> +test_exec_user
> +test_exec_kernel
> +test_fork_kernel_setuid
> +test_exec_kernel_setuid
> +test_fork_kernel_change_priv
> +test_exec_kernel_change_priv
> +network_setup
> +test_fork_kernel_network_to_local
> +test_exec_kernel_network_to_local
> +network_cleanup
> +exit $errno
> --
> 2.25.1
> 

-- 
Kees Cook
