Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3806F183D9E
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Mar 2020 00:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgCLXxW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Mar 2020 19:53:22 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38051 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgCLXxV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Mar 2020 19:53:21 -0400
Received: by mail-pf1-f195.google.com with SMTP id z5so4075144pfn.5
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Mar 2020 16:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OCwJQwO9OgqrcAMfCYKRyMushG3X+7R4kYs3kAo+xdY=;
        b=TbTKG0v0AweRsPMDZ+ke2UU+ZqqSc3hE3yHa6bE8XQ/5zOn2ToMVuGuF2FSjTVr8t4
         C5qp1eFTBLyIVesM+BEsPt4cfLuRTgupWaVIk2Xf5BvZ+o/vbggETTs1nscyDBi6LB8N
         bwsePSKOGaB5i7OXcEhW1eS3uNfGIDhXoV4I4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OCwJQwO9OgqrcAMfCYKRyMushG3X+7R4kYs3kAo+xdY=;
        b=oX208DoCss1ad9kVnx9Kc3r49i4AqqPl6d6FY4KiOUZf6OzAxm7bPRKmzOFQG8OV+k
         uM9dgMXXzQPINsqj8YfofSi3bbJcuNfLFcDJdZT5QaqRa+yLLMKMlfPkttkoT5yoOm0H
         Utjcu6S+47kuaGFSZtWftoJxT63Ua2hQJAx4vJUWHzuvaP5nWwIXpPFOIxLHNvjQJ0RZ
         zsqxvaAShOn5gStMmsnaYpwIsRGS0eZ8s2rmZgjr54pBF4a+d+pDvW8GFpDKpXeodeo4
         pFqfxyA26agb9vwyXvnKYRMmVgVgUfyWMBPvgRiUOJDE0X2jVwGSSKJzhFh1nL1YeBSP
         SWvg==
X-Gm-Message-State: ANhLgQ3HEqh/rZ62Dvj8+XsgkNuFW2xH2S3zFX8vTfAwAqzqs7yrIe+T
        dmexpPTwLqyjhGJOeIBiKgeEHA==
X-Google-Smtp-Source: ADFU+vt/RUxFOvqFBVWAo7f5EK13v/8A4S+4tvDlR0DGnVcszk6K9gVnjF+mVOH+WasIoDThXdAlUg==
X-Received: by 2002:a63:68a:: with SMTP id 132mr10361807pgg.12.1584057199020;
        Thu, 12 Mar 2020 16:53:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w124sm5726643pfd.71.2020.03.12.16.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 16:53:18 -0700 (PDT)
Date:   Thu, 12 Mar 2020 16:53:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Todd Kjos <tkjos@android.com>, ard.biesheuvel@linaro.org,
        ardb@kernel.org, john.stultz@linaro.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        naresh.kamboju@linaro.org, shuah@kernel.org,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>, hridya@google.com,
        kernel-team@android.com
Subject: Re: [PATCH 2/3] binderfs: add stress test for binderfs binder devices
Message-ID: <202003121652.00BBA1D98@keescook>
References: <20200311105309.1742827-1-christian.brauner@ubuntu.com>
 <20200312131531.3615556-1-christian.brauner@ubuntu.com>
 <20200312131531.3615556-2-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312131531.3615556-2-christian.brauner@ubuntu.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 12, 2020 at 02:15:30PM +0100, Christian Brauner wrote:
> This adds a stress test that should hopefully help us catch regressions
> for [1], [2], and [3].
> 
> [1]: 2669b8b0c798 ("binder: prevent UAF for binderfs devices")
> [2]: f0fe2c0f050d ("binder: prevent UAF for binderfs devices II")
> [3]: 211b64e4b5b6 ("binderfs: use refcount for binder control devices too")
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Do you care about 80-char line limits? (Or does the selftest tree? There
are a few in here...)

Otherwise, seems reasonable:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  .../selftests/filesystems/binderfs/Makefile   |   2 +-
>  .../filesystems/binderfs/binderfs_test.c      | 416 ++++++++++++++----
>  2 files changed, 325 insertions(+), 93 deletions(-)
> 
> diff --git a/tools/testing/selftests/filesystems/binderfs/Makefile b/tools/testing/selftests/filesystems/binderfs/Makefile
> index 75315d9ba7a9..8af25ae96049 100644
> --- a/tools/testing/selftests/filesystems/binderfs/Makefile
> +++ b/tools/testing/selftests/filesystems/binderfs/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -CFLAGS += -I../../../../../usr/include/
> +CFLAGS += -I../../../../../usr/include/ -pthread
>  TEST_GEN_PROGS := binderfs_test
>  
>  binderfs_test: binderfs_test.c ../../kselftest.h ../../kselftest_harness.h
> diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> index d03ed8eed5eb..313ffad15614 100644
> --- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> +++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> @@ -3,15 +3,20 @@
>  #define _GNU_SOURCE
>  #include <errno.h>
>  #include <fcntl.h>
> +#include <pthread.h>
>  #include <sched.h>
>  #include <stdbool.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> +#include <sys/fsuid.h>
>  #include <sys/ioctl.h>
>  #include <sys/mount.h>
> +#include <sys/socket.h>
>  #include <sys/stat.h>
> +#include <sys/sysinfo.h>
>  #include <sys/types.h>
> +#include <sys/wait.h>
>  #include <unistd.h>
>  #include <linux/android/binder.h>
>  #include <linux/android/binderfs.h>
> @@ -19,100 +24,26 @@
>  #include "../../kselftest.h"
>  #include "../../kselftest_harness.h"
>  
> -static ssize_t write_nointr(int fd, const void *buf, size_t count)
> -{
> -	ssize_t ret;
> -again:
> -	ret = write(fd, buf, count);
> -	if (ret < 0 && errno == EINTR)
> -		goto again;
> +#define DEFAULT_THREADS 4
>  
> -	return ret;
> -}
> +#define PTR_TO_INT(p) ((int)((intptr_t)(p)))
> +#define INT_TO_PTR(u) ((void *)((intptr_t)(u)))
>  
> -static void write_to_file(const char *filename, const void *buf, size_t count,
> -			  int allowed_errno)
> -{
> -	int fd, saved_errno;
> -	ssize_t ret;
> -
> -	fd = open(filename, O_WRONLY | O_CLOEXEC);
> -	if (fd < 0)
> -		ksft_exit_fail_msg("%s - Failed to open file %s\n",
> -				   strerror(errno), filename);
> -
> -	ret = write_nointr(fd, buf, count);
> -	if (ret < 0) {
> -		if (allowed_errno && (errno == allowed_errno)) {
> -			close(fd);
> -			return;
> -		}
> -
> -		goto on_error;
> +#define close_prot_errno_disarm(fd) \
> +	if (fd >= 0) {              \
> +		int _e_ = errno;    \
> +		close(fd);          \
> +		errno = _e_;        \
> +		fd = -EBADF;        \
>  	}
>  
> -	if ((size_t)ret != count)
> -		goto on_error;
> -
> -	close(fd);
> -	return;
> -
> -on_error:
> -	saved_errno = errno;
> -	close(fd);
> -	errno = saved_errno;
> -
> -	if (ret < 0)
> -		ksft_exit_fail_msg("%s - Failed to write to file %s\n",
> -				   strerror(errno), filename);
> +#define log_exit(format, ...)                                                  \
> +	({                                                                     \
> +		fprintf(stderr, format "\n", ##__VA_ARGS__);                   \
> +		exit(EXIT_FAILURE);                                            \
> +	})
>  
> -	ksft_exit_fail_msg("Failed to write to file %s\n", filename);
> -}
> -
> -static void change_to_userns(void)
> -{
> -	int ret;
> -	uid_t uid;
> -	gid_t gid;
> -	/* {g,u}id_map files only allow a max of 4096 bytes written to them */
> -	char idmap[4096];
> -
> -	uid = getuid();
> -	gid = getgid();
> -
> -	ret = unshare(CLONE_NEWUSER);
> -	if (ret < 0)
> -		ksft_exit_fail_msg("%s - Failed to unshare user namespace\n",
> -				   strerror(errno));
> -
> -	write_to_file("/proc/self/setgroups", "deny", strlen("deny"), ENOENT);
> -
> -	ret = snprintf(idmap, sizeof(idmap), "0 %d 1", uid);
> -	if (ret < 0 || (size_t)ret >= sizeof(idmap))
> -		ksft_exit_fail_msg("%s - Failed to prepare uid mapping\n",
> -				   strerror(errno));
> -
> -	write_to_file("/proc/self/uid_map", idmap, strlen(idmap), 0);
> -
> -	ret = snprintf(idmap, sizeof(idmap), "0 %d 1", gid);
> -	if (ret < 0 || (size_t)ret >= sizeof(idmap))
> -		ksft_exit_fail_msg("%s - Failed to prepare uid mapping\n",
> -				   strerror(errno));
> -
> -	write_to_file("/proc/self/gid_map", idmap, strlen(idmap), 0);
> -
> -	ret = setgid(0);
> -	if (ret)
> -		ksft_exit_fail_msg("%s - Failed to setgid(0)\n",
> -				   strerror(errno));
> -
> -	ret = setuid(0);
> -	if (ret)
> -		ksft_exit_fail_msg("%s - Failed to setgid(0)\n",
> -				   strerror(errno));
> -}
> -
> -static void change_to_mountns(void)
> +static void change_mountns(void)
>  {
>  	int ret;
>  
> @@ -143,7 +74,7 @@ static void __do_binderfs_test(void)
>  	struct binderfs_device device = { 0 };
>  	struct binder_version version = { 0 };
>  
> -	change_to_mountns();
> +	change_mountns();
>  
>  	ret = mkdir("/dev/binderfs", 0755);
>  	if (ret < 0) {
> @@ -254,6 +185,283 @@ static void __do_binderfs_test(void)
>  	ksft_inc_pass_cnt();
>  }
>  
> +static int wait_for_pid(pid_t pid)
> +{
> +	int status, ret;
> +
> +again:
> +	ret = waitpid(pid, &status, 0);
> +	if (ret == -1) {
> +		if (errno == EINTR)
> +			goto again;
> +
> +		return -1;
> +	}
> +
> +	if (!WIFEXITED(status))
> +		return -1;
> +
> +	return WEXITSTATUS(status);
> +}
> +
> +static int setid_userns_root(void)
> +{
> +	if (setuid(0))
> +		return -1;
> +	if (setgid(0))
> +		return -1;
> +
> +	setfsuid(0);
> +	setfsgid(0);
> +
> +	return 0;
> +}
> +
> +enum idmap_type {
> +	UID_MAP,
> +	GID_MAP,
> +};
> +
> +static ssize_t read_nointr(int fd, void *buf, size_t count)
> +{
> +	ssize_t ret;
> +again:
> +	ret = read(fd, buf, count);
> +	if (ret < 0 && errno == EINTR)
> +		goto again;
> +
> +	return ret;
> +}
> +
> +static ssize_t write_nointr(int fd, const void *buf, size_t count)
> +{
> +	ssize_t ret;
> +again:
> +	ret = write(fd, buf, count);
> +	if (ret < 0 && errno == EINTR)
> +		goto again;
> +
> +	return ret;
> +}
> +
> +static int write_id_mapping(enum idmap_type type, pid_t pid, const char *buf,
> +			    size_t buf_size)
> +{
> +	int fd;
> +	int ret;
> +	char path[4096];
> +
> +	if (type == GID_MAP) {
> +		int setgroups_fd;
> +
> +		snprintf(path, sizeof(path), "/proc/%d/setgroups", pid);
> +		setgroups_fd = open(path, O_WRONLY | O_CLOEXEC | O_NOFOLLOW);
> +		if (setgroups_fd < 0 && errno != ENOENT)
> +			return -1;
> +
> +		if (setgroups_fd >= 0) {
> +			ret = write_nointr(setgroups_fd, "deny", sizeof("deny") - 1);
> +			close_prot_errno_disarm(setgroups_fd);
> +			if (ret != sizeof("deny") - 1)
> +				return -1;
> +		}
> +	}
> +
> +	switch (type) {
> +	case UID_MAP:
> +		ret = snprintf(path, sizeof(path), "/proc/%d/uid_map", pid);
> +		break;
> +	case GID_MAP:
> +		ret = snprintf(path, sizeof(path), "/proc/%d/gid_map", pid);
> +		break;
> +	default:
> +		return -1;
> +	}
> +	if (ret < 0 || ret >= sizeof(path))
> +		return -E2BIG;
> +
> +	fd = open(path, O_WRONLY | O_CLOEXEC | O_NOFOLLOW);
> +	if (fd < 0)
> +		return -1;
> +
> +	ret = write_nointr(fd, buf, buf_size);
> +	close_prot_errno_disarm(fd);
> +	if (ret != buf_size)
> +		return -1;
> +
> +	return 0;
> +}
> +
> +static void change_userns(int syncfds[2])
> +{
> +	int ret;
> +	char buf;
> +
> +	close_prot_errno_disarm(syncfds[1]);
> +
> +	ret = unshare(CLONE_NEWUSER);
> +	if (ret < 0)
> +		ksft_exit_fail_msg("%s - Failed to unshare user namespace\n",
> +				   strerror(errno));
> +
> +	ret = write_nointr(syncfds[0], "1", 1);
> +	if (ret != 1)
> +		ksft_exit_fail_msg("write_nointr() failed\n");
> +
> +	ret = read_nointr(syncfds[0], &buf, 1);
> +	if (ret != 1)
> +		ksft_exit_fail_msg("read_nointr() failed\n");
> +
> +	close_prot_errno_disarm(syncfds[0]);
> +
> +	if (setid_userns_root())
> +		ksft_exit_fail_msg("setid_userns_root() failed");
> +}
> +
> +static void change_idmaps(int syncfds[2], pid_t pid)
> +{
> +	int ret;
> +	char buf;
> +	char id_map[4096];
> +
> +	close_prot_errno_disarm(syncfds[0]);
> +
> +	ret = read_nointr(syncfds[1], &buf, 1);
> +	if (ret != 1)
> +		ksft_exit_fail_msg("read_nointr() failed\n");
> +
> +	snprintf(id_map, sizeof(id_map), "0 %d 1\n", getuid());
> +	ret = write_id_mapping(UID_MAP, pid, id_map, strlen(id_map));
> +	if (ret)
> +		ksft_exit_fail_msg("write_id_mapping(UID_MAP) failed");
> +
> +	snprintf(id_map, sizeof(id_map), "0 %d 1\n", getgid());
> +	ret = write_id_mapping(GID_MAP, pid, id_map, strlen(id_map));
> +	if (ret)
> +		ksft_exit_fail_msg("write_id_mapping(GID_MAP) failed");
> +
> +	ret = write_nointr(syncfds[1], "1", 1);
> +	if (ret != 1)
> +		ksft_exit_fail_msg("write_nointr() failed");
> +
> +	close_prot_errno_disarm(syncfds[1]);
> +}
> +
> +static void *binder_version_thread(void *data)
> +{
> +	int fd = PTR_TO_INT(data);
> +	struct binder_version version = { 0 };
> +	int ret;
> +
> +	ret = ioctl(fd, BINDER_VERSION, &version);
> +	if (ret < 0)
> +		ksft_print_msg("%s - Failed to open perform BINDER_VERSION request\n", strerror(errno));
> +
> +	pthread_exit(data);
> +}
> +
> +/*
> + * Regression test:
> + * 2669b8b0c798 ("binder: prevent UAF for binderfs devices")
> + * f0fe2c0f050d ("binder: prevent UAF for binderfs devices II")
> + * 211b64e4b5b6 ("binderfs: use refcount for binder control devices too")
> + */
> +TEST(binderfs_stress)
> +{
> +	int fds[1000];
> +	int syncfds[2];
> +	pid_t pid;
> +	int fd, ret;
> +	size_t len;
> +	struct binderfs_device device = { 0 };
> +
> +	ret = socketpair(PF_LOCAL, SOCK_STREAM | SOCK_CLOEXEC, 0, syncfds);
> +	if (ret < 0)
> +		ksft_exit_fail_msg("%s - Failed to create socket pair", strerror(errno));
> +
> +	pid = fork();
> +	if (pid < 0) {
> +		close_prot_errno_disarm(syncfds[0]);
> +		close_prot_errno_disarm(syncfds[1]);
> +		ksft_exit_fail_msg("%s - Failed to fork", strerror(errno));
> +	}
> +
> +	if (pid == 0) {
> +		int i, j, k, nthreads;
> +		pthread_attr_t attr;
> +		pthread_t threads[DEFAULT_THREADS];
> +		change_userns(syncfds);
> +		change_mountns();
> +
> +		ret = mkdir("/tmp/binderfs", 0755);
> +		if (ret < 0 && errno != EEXIST)
> +			log_exit("%s - Failed to create binderfs mountpoint\n", strerror(errno));
> +
> +		ret = mount(NULL, "/tmp/binderfs", "binder", 0, 0);
> +		if (ret < 0)
> +			log_exit("%s - Failed to mount binderfs\n", strerror(errno));
> +
> +		for (int i = 0; i < ARRAY_SIZE(fds); i++) {
> +			char path[4096];
> +
> +			fd = open("/tmp/binderfs/binder-control", O_RDONLY | O_CLOEXEC);
> +			if (fd < 0)
> +				log_exit("%s - Failed to open binder-control device\n", strerror(errno));
> +
> +			memset(&device, 0, sizeof(device));
> +			snprintf(device.name, sizeof(device.name), "%d", i);
> +			ret = ioctl(fd, BINDER_CTL_ADD, &device);
> +			close_prot_errno_disarm(fd);
> +			if (ret < 0)
> +				log_exit("%s - Failed to allocate new binder device\n", strerror(errno));
> +
> +			snprintf(path, sizeof(path), "/tmp/binderfs/%d", i);
> +			fds[i] = open(path, O_RDONLY | O_CLOEXEC);
> +			if (fds[i] < 0)
> +				log_exit("%s - Failed to open binder device\n", strerror(errno));
> +		}
> +
> +		ret = umount2("/tmp/binderfs", MNT_DETACH);
> +		if (ret < 0)
> +			log_exit("%s - Failed to unmount binderfs\n", strerror(errno));
> +
> +		nthreads = get_nprocs_conf();
> +		if (nthreads > DEFAULT_THREADS)
> +			nthreads = DEFAULT_THREADS;
> +
> +		pthread_attr_init(&attr);
> +		for (k = 0; k < ARRAY_SIZE(fds); k++) {
> +			for (i = 0; i < nthreads; i++) {
> +				ret = pthread_create(&threads[i], &attr, binder_version_thread, INT_TO_PTR(fds[k]));
> +				if (ret) {
> +					ksft_print_msg("%s - Failed to create thread %d\n", strerror(errno), i);
> +					break;
> +				}
> +			}
> +
> +			for (j = 0; j < i; j++) {
> +				void *fdptr = NULL;
> +
> +				ret = pthread_join(threads[j], &fdptr);
> +				if (ret)
> +					ksft_print_msg("%s - Failed to join thread %d for fd %d\n", strerror(errno), j, PTR_TO_INT(fdptr));
> +			}
> +		}
> +		pthread_attr_destroy(&attr);
> +
> +		for (k = 0; k < ARRAY_SIZE(fds); k++)
> +			close(fds[k]);
> +
> +		exit(EXIT_SUCCESS);
> +	}
> +
> +	change_idmaps(syncfds, pid);
> +
> +	ret = wait_for_pid(pid);
> +	if (ret)
> +		ksft_exit_fail_msg("wait_for_pid() failed");
> +}
> +
>  TEST(binderfs_test_privileged)
>  {
>  	if (geteuid() != 0)
> @@ -264,8 +472,32 @@ TEST(binderfs_test_privileged)
>  
>  TEST(binderfs_test_unprivileged)
>  {
> -	change_to_userns();
> -	__do_binderfs_test();
> +	int ret;
> +	int syncfds[2];
> +	pid_t pid;
> +
> +	ret = socketpair(PF_LOCAL, SOCK_STREAM | SOCK_CLOEXEC, 0, syncfds);
> +	if (ret < 0)
> +		ksft_exit_fail_msg("%s - Failed to create socket pair", strerror(errno));
> +
> +	pid = fork();
> +	if (pid < 0) {
> +		close_prot_errno_disarm(syncfds[0]);
> +		close_prot_errno_disarm(syncfds[1]);
> +		ksft_exit_fail_msg("%s - Failed to fork", strerror(errno));
> +	}
> +
> +	if (pid == 0) {
> +		change_userns(syncfds);
> +		__do_binderfs_test();
> +		exit(EXIT_SUCCESS);
> +	}
> +
> +	change_idmaps(syncfds, pid);
> +
> +	ret = wait_for_pid(pid);
> +	if (ret)
> +		ksft_exit_fail_msg("wait_for_pid() failed");
>  }
>  
>  TEST_HARNESS_MAIN
> -- 
> 2.25.1
> 

-- 
Kees Cook
