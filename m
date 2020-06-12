Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7071F7CC6
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jun 2020 20:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgFLSTI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Jun 2020 14:19:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45328 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgFLSTI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Jun 2020 14:19:08 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jjoGb-0005WX-1L; Fri, 12 Jun 2020 18:19:01 +0000
Date:   Fri, 12 Jun 2020 20:19:00 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] selftests/binderfs: Fix harness API usage
Message-ID: <20200612181900.6kyhxevm6ebhu43d@wittgenstein>
References: <20200611224028.3275174-1-keescook@chromium.org>
 <20200611224028.3275174-4-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200611224028.3275174-4-keescook@chromium.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 11, 2020 at 03:40:24PM -0700, Kees Cook wrote:
> The binderfs test mixed the full harness API and the selftest API.
> Adjust to use only the harness API so that the harness API can switch
> to using the selftest API internally in future patches.
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

I had this on my TODO but never actually got around to it, so thanks!

In all honesty, I've done a "Does this overall look sane?" review.
Simply because I lack the time to do this in more detail right now but
I'm happy this work is done and so overall:

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

>  .../filesystems/binderfs/binderfs_test.c      | 284 +++++++++---------
>  1 file changed, 146 insertions(+), 138 deletions(-)
> 
> diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> index 8a6b507e34a8..1d27f52c61e6 100644
> --- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> +++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> @@ -21,7 +21,6 @@
>  #include <linux/android/binder.h>
>  #include <linux/android/binderfs.h>
>  
> -#include "../../kselftest.h"
>  #include "../../kselftest_harness.h"
>  
>  #define DEFAULT_THREADS 4
> @@ -37,37 +36,26 @@
>  		fd = -EBADF;        \
>  	}
>  
> -#define log_exit(format, ...)                                                  \
> -	({                                                                     \
> -		fprintf(stderr, format "\n", ##__VA_ARGS__);                   \
> -		exit(EXIT_FAILURE);                                            \
> -	})
> -
> -static void change_mountns(void)
> +static void change_mountns(struct __test_metadata *_metadata)
>  {
>  	int ret;
>  
>  	ret = unshare(CLONE_NEWNS);
> -	if (ret < 0)
> -		ksft_exit_fail_msg("%s - Failed to unshare mount namespace\n",
> -				   strerror(errno));
> +	ASSERT_EQ(ret, 0) {
> +		TH_LOG("%s - Failed to unshare mount namespace",
> +			strerror(errno));
> +	}
>  
>  	ret = mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
> -	if (ret < 0)
> -		ksft_exit_fail_msg("%s - Failed to mount / as private\n",
> -				   strerror(errno));
> -}
> -
> -static void rmdir_protect_errno(const char *dir)
> -{
> -	int saved_errno = errno;
> -	(void)rmdir(dir);
> -	errno = saved_errno;
> +	ASSERT_EQ(ret, 0) {
> +		TH_LOG("%s - Failed to mount / as private",
> +			strerror(errno));
> +	}
>  }
>  
> -static int __do_binderfs_test(void)
> +static int __do_binderfs_test(struct __test_metadata *_metadata)
>  {
> -	int fd, ret, saved_errno;
> +	int fd, ret, saved_errno, result = 1;
>  	size_t len;
>  	ssize_t wret;
>  	struct binderfs_device device = { 0 };
> @@ -75,113 +63,107 @@ static int __do_binderfs_test(void)
>  	char binderfs_mntpt[] = P_tmpdir "/binderfs_XXXXXX",
>  		device_path[sizeof(P_tmpdir "/binderfs_XXXXXX/") + BINDERFS_MAX_NAME];
>  
> -	change_mountns();
> +	change_mountns(_metadata);
>  
> -	if (!mkdtemp(binderfs_mntpt))
> -		ksft_exit_fail_msg(
> -			"%s - Failed to create binderfs mountpoint\n",
> +	EXPECT_NE(mkdtemp(binderfs_mntpt), NULL) {
> +		TH_LOG("%s - Failed to create binderfs mountpoint",
>  			strerror(errno));
> +		goto out;
> +	}
>  
>  	ret = mount(NULL, binderfs_mntpt, "binder", 0, 0);
> -	if (ret < 0) {
> -		if (errno != ENODEV)
> -			ksft_exit_fail_msg("%s - Failed to mount binderfs\n",
> -					   strerror(errno));
> -
> -		rmdir_protect_errno(binderfs_mntpt);
> -		return 1;
> +	EXPECT_EQ(ret, 0) {
> +		if (errno == ENODEV)
> +			XFAIL(goto out, "binderfs missing");
> +		TH_LOG("%s - Failed to mount binderfs", strerror(errno));
> +		goto rmdir;
>  	}
>  
> -	/* binderfs mount test passed */
> -	ksft_inc_pass_cnt();
> +	/* success: binderfs mounted */
>  
>  	memcpy(device.name, "my-binder", strlen("my-binder"));
>  
>  	snprintf(device_path, sizeof(device_path), "%s/binder-control", binderfs_mntpt);
>  	fd = open(device_path, O_RDONLY | O_CLOEXEC);
> -	if (fd < 0)
> -		ksft_exit_fail_msg(
> -			"%s - Failed to open binder-control device\n",
> +	EXPECT_GE(fd, 0) {
> +		TH_LOG("%s - Failed to open binder-control device",
>  			strerror(errno));
> +		goto umount;
> +	}
>  
>  	ret = ioctl(fd, BINDER_CTL_ADD, &device);
>  	saved_errno = errno;
>  	close(fd);
>  	errno = saved_errno;
> -	if (ret < 0) {
> -		rmdir_protect_errno(binderfs_mntpt);
> -		ksft_exit_fail_msg(
> -			"%s - Failed to allocate new binder device\n",
> +	EXPECT_GE(ret, 0) {
> +		TH_LOG("%s - Failed to allocate new binder device",
>  			strerror(errno));
> +		goto umount;
>  	}
>  
> -	ksft_print_msg(
> -		"Allocated new binder device with major %d, minor %d, and name %s\n",
> +	TH_LOG("Allocated new binder device with major %d, minor %d, and name %s",
>  		device.major, device.minor, device.name);
>  
> -	/* binder device allocation test passed */
> -	ksft_inc_pass_cnt();
> +	/* success: binder device allocation */
>  
>  	snprintf(device_path, sizeof(device_path), "%s/my-binder", binderfs_mntpt);
>  	fd = open(device_path, O_CLOEXEC | O_RDONLY);
> -	if (fd < 0) {
> -		rmdir_protect_errno(binderfs_mntpt);
> -		ksft_exit_fail_msg("%s - Failed to open my-binder device\n",
> -				   strerror(errno));
> +	EXPECT_GE(fd, 0) {
> +		TH_LOG("%s - Failed to open my-binder device",
> +			strerror(errno));
> +		goto umount;
>  	}
>  
>  	ret = ioctl(fd, BINDER_VERSION, &version);
>  	saved_errno = errno;
>  	close(fd);
>  	errno = saved_errno;
> -	if (ret < 0) {
> -		rmdir_protect_errno(binderfs_mntpt);
> -		ksft_exit_fail_msg(
> -			"%s - Failed to open perform BINDER_VERSION request\n",
> +	EXPECT_GE(ret, 0) {
> +		TH_LOG("%s - Failed to open perform BINDER_VERSION request",
>  			strerror(errno));
> +		goto umount;
>  	}
>  
> -	ksft_print_msg("Detected binder version: %d\n",
> -		       version.protocol_version);
> +	TH_LOG("Detected binder version: %d", version.protocol_version);
>  
> -	/* binder transaction with binderfs binder device passed */
> -	ksft_inc_pass_cnt();
> +	/* success: binder transaction with binderfs binder device */
>  
>  	ret = unlink(device_path);
> -	if (ret < 0) {
> -		rmdir_protect_errno(binderfs_mntpt);
> -		ksft_exit_fail_msg("%s - Failed to delete binder device\n",
> -				   strerror(errno));
> +	EXPECT_EQ(ret, 0) {
> +		TH_LOG("%s - Failed to delete binder device",
> +			strerror(errno));
> +		goto umount;
>  	}
>  
> -	/* binder device removal passed */
> -	ksft_inc_pass_cnt();
> +	/* success: binder device removal */
>  
>  	snprintf(device_path, sizeof(device_path), "%s/binder-control", binderfs_mntpt);
>  	ret = unlink(device_path);
> -	if (!ret) {
> -		rmdir_protect_errno(binderfs_mntpt);
> -		ksft_exit_fail_msg("Managed to delete binder-control device\n");
> -	} else if (errno != EPERM) {
> -		rmdir_protect_errno(binderfs_mntpt);
> -		ksft_exit_fail_msg(
> -			"%s - Failed to delete binder-control device but exited with unexpected error code\n",
> +	EXPECT_NE(ret, 0) {
> +		TH_LOG("Managed to delete binder-control device");
> +		goto umount;
> +	}
> +	EXPECT_EQ(errno, EPERM) {
> +		TH_LOG("%s - Failed to delete binder-control device but exited with unexpected error code",
>  			strerror(errno));
> +		goto umount;
>  	}
>  
> -	/* binder-control device removal failed as expected */
> -	ksft_inc_xfail_cnt();
> +	/* success: binder-control device removal failed as expected */
> +	result = 0;
>  
> -on_error:
> +umount:
>  	ret = umount2(binderfs_mntpt, MNT_DETACH);
> -	rmdir_protect_errno(binderfs_mntpt);
> -	if (ret < 0)
> -		ksft_exit_fail_msg("%s - Failed to unmount binderfs\n",
> -				   strerror(errno));
> -
> -	/* binderfs unmount test passed */
> -	ksft_inc_pass_cnt();
> -	return 0;
> +	EXPECT_EQ(ret, 0) {
> +		TH_LOG("%s - Failed to unmount binderfs", strerror(errno));
> +	}
> +rmdir:
> +	ret = rmdir(binderfs_mntpt);
> +	EXPECT_EQ(ret, 0) {
> +		TH_LOG("%s - Failed to rmdir binderfs mount", strerror(errno));
> +	}
> +out:
> +	return result;
>  }
>  
>  static int wait_for_pid(pid_t pid)
> @@ -291,7 +273,7 @@ static int write_id_mapping(enum idmap_type type, pid_t pid, const char *buf,
>  	return 0;
>  }
>  
> -static void change_userns(int syncfds[2])
> +static void change_userns(struct __test_metadata *_metadata, int syncfds[2])
>  {
>  	int ret;
>  	char buf;
> @@ -299,25 +281,29 @@ static void change_userns(int syncfds[2])
>  	close_prot_errno_disarm(syncfds[1]);
>  
>  	ret = unshare(CLONE_NEWUSER);
> -	if (ret < 0)
> -		ksft_exit_fail_msg("%s - Failed to unshare user namespace\n",
> -				   strerror(errno));
> +	ASSERT_EQ(ret, 0) {
> +		TH_LOG("%s - Failed to unshare user namespace",
> +			strerror(errno));
> +	}
>  
>  	ret = write_nointr(syncfds[0], "1", 1);
> -	if (ret != 1)
> -		ksft_exit_fail_msg("write_nointr() failed\n");
> +	ASSERT_EQ(ret, 1) {
> +		TH_LOG("write_nointr() failed");
> +	}
>  
>  	ret = read_nointr(syncfds[0], &buf, 1);
> -	if (ret != 1)
> -		ksft_exit_fail_msg("read_nointr() failed\n");
> +	ASSERT_EQ(ret, 1) {
> +		TH_LOG("read_nointr() failed");
> +	}
>  
>  	close_prot_errno_disarm(syncfds[0]);
>  
> -	if (setid_userns_root())
> -		ksft_exit_fail_msg("setid_userns_root() failed");
> +	ASSERT_EQ(setid_userns_root(), 0) {
> +		TH_LOG("setid_userns_root() failed");
> +	}
>  }
>  
> -static void change_idmaps(int syncfds[2], pid_t pid)
> +static void change_idmaps(struct __test_metadata *_metadata, int syncfds[2], pid_t pid)
>  {
>  	int ret;
>  	char buf;
> @@ -326,35 +312,42 @@ static void change_idmaps(int syncfds[2], pid_t pid)
>  	close_prot_errno_disarm(syncfds[0]);
>  
>  	ret = read_nointr(syncfds[1], &buf, 1);
> -	if (ret != 1)
> -		ksft_exit_fail_msg("read_nointr() failed\n");
> +	ASSERT_EQ(ret, 1) {
> +		TH_LOG("read_nointr() failed");
> +	}
>  
>  	snprintf(id_map, sizeof(id_map), "0 %d 1\n", getuid());
>  	ret = write_id_mapping(UID_MAP, pid, id_map, strlen(id_map));
> -	if (ret)
> -		ksft_exit_fail_msg("write_id_mapping(UID_MAP) failed");
> +	ASSERT_EQ(ret, 0) {
> +		TH_LOG("write_id_mapping(UID_MAP) failed");
> +	}
>  
>  	snprintf(id_map, sizeof(id_map), "0 %d 1\n", getgid());
>  	ret = write_id_mapping(GID_MAP, pid, id_map, strlen(id_map));
> -	if (ret)
> -		ksft_exit_fail_msg("write_id_mapping(GID_MAP) failed");
> +	ASSERT_EQ(ret, 0) {
> +		TH_LOG("write_id_mapping(GID_MAP) failed");
> +	}
>  
>  	ret = write_nointr(syncfds[1], "1", 1);
> -	if (ret != 1)
> -		ksft_exit_fail_msg("write_nointr() failed");
> +	ASSERT_EQ(ret, 1) {
> +		TH_LOG("write_nointr() failed");
> +	}
>  
>  	close_prot_errno_disarm(syncfds[1]);
>  }
>  
> +struct __test_metadata *_thread_metadata;
>  static void *binder_version_thread(void *data)
>  {
> +	struct __test_metadata *_metadata = _thread_metadata;
>  	int fd = PTR_TO_INT(data);
>  	struct binder_version version = { 0 };
>  	int ret;
>  
>  	ret = ioctl(fd, BINDER_VERSION, &version);
>  	if (ret < 0)
> -		ksft_print_msg("%s - Failed to open perform BINDER_VERSION request\n", strerror(errno));
> +		TH_LOG("%s - Failed to open perform BINDER_VERSION request\n",
> +			strerror(errno));
>  
>  	pthread_exit(data);
>  }
> @@ -377,68 +370,79 @@ TEST(binderfs_stress)
>  		device_path[sizeof(P_tmpdir "/binderfs_XXXXXX/") + BINDERFS_MAX_NAME];
>  
>  	ret = socketpair(PF_LOCAL, SOCK_STREAM | SOCK_CLOEXEC, 0, syncfds);
> -	if (ret < 0)
> -		ksft_exit_fail_msg("%s - Failed to create socket pair", strerror(errno));
> +	ASSERT_EQ(ret, 0) {
> +		TH_LOG("%s - Failed to create socket pair", strerror(errno));
> +	}
>  
>  	pid = fork();
> -	if (pid < 0) {
> +	ASSERT_GE(pid, 0) {
> +		TH_LOG("%s - Failed to fork", strerror(errno));
>  		close_prot_errno_disarm(syncfds[0]);
>  		close_prot_errno_disarm(syncfds[1]);
> -		ksft_exit_fail_msg("%s - Failed to fork", strerror(errno));
>  	}
>  
>  	if (pid == 0) {
>  		int i, j, k, nthreads;
>  		pthread_attr_t attr;
>  		pthread_t threads[DEFAULT_THREADS];
> -		change_userns(syncfds);
> -		change_mountns();
> +		change_userns(_metadata, syncfds);
> +		change_mountns(_metadata);
>  
> -		if (!mkdtemp(binderfs_mntpt))
> -			log_exit("%s - Failed to create binderfs mountpoint\n",
> -				 strerror(errno));
> +		ASSERT_NE(mkdtemp(binderfs_mntpt), NULL) {
> +			TH_LOG("%s - Failed to create binderfs mountpoint",
> +				strerror(errno));
> +		}
>  
>  		ret = mount(NULL, binderfs_mntpt, "binder", 0, 0);
> -		if (ret < 0)
> -			log_exit("%s - Failed to mount binderfs\n", strerror(errno));
> +		ASSERT_EQ(ret, 0) {
> +			TH_LOG("%s - Failed to mount binderfs", strerror(errno));
> +		}
>  
>  		for (int i = 0; i < ARRAY_SIZE(fds); i++) {
>  
>  			snprintf(device_path, sizeof(device_path),
>  				 "%s/binder-control", binderfs_mntpt);
>  			fd = open(device_path, O_RDONLY | O_CLOEXEC);
> -			if (fd < 0)
> -				log_exit("%s - Failed to open binder-control device\n", strerror(errno));
> +			ASSERT_GE(fd, 0) {
> +				TH_LOG("%s - Failed to open binder-control device",
> +					strerror(errno));
> +			}
>  
>  			memset(&device, 0, sizeof(device));
>  			snprintf(device.name, sizeof(device.name), "%d", i);
>  			ret = ioctl(fd, BINDER_CTL_ADD, &device);
>  			close_prot_errno_disarm(fd);
> -			if (ret < 0)
> -				log_exit("%s - Failed to allocate new binder device\n", strerror(errno));
> +			ASSERT_EQ(ret, 0) {
> +				TH_LOG("%s - Failed to allocate new binder device",
> +					strerror(errno));
> +			}
>  
>  			snprintf(device_path, sizeof(device_path), "%s/%d",
>  				 binderfs_mntpt, i);
>  			fds[i] = open(device_path, O_RDONLY | O_CLOEXEC);
> -			if (fds[i] < 0)
> -				log_exit("%s - Failed to open binder device\n", strerror(errno));
> +			ASSERT_GE(fds[i], 0) {
> +				TH_LOG("%s - Failed to open binder device", strerror(errno));
> +			}
>  		}
>  
>  		ret = umount2(binderfs_mntpt, MNT_DETACH);
> -		rmdir_protect_errno(binderfs_mntpt);
> -		if (ret < 0)
> -			log_exit("%s - Failed to unmount binderfs\n", strerror(errno));
> +		ASSERT_EQ(ret, 0) {
> +			TH_LOG("%s - Failed to unmount binderfs", strerror(errno));
> +			rmdir(binderfs_mntpt);
> +		}
>  
>  		nthreads = get_nprocs_conf();
>  		if (nthreads > DEFAULT_THREADS)
>  			nthreads = DEFAULT_THREADS;
>  
> +		_thread_metadata = _metadata;
>  		pthread_attr_init(&attr);
>  		for (k = 0; k < ARRAY_SIZE(fds); k++) {
>  			for (i = 0; i < nthreads; i++) {
>  				ret = pthread_create(&threads[i], &attr, binder_version_thread, INT_TO_PTR(fds[k]));
>  				if (ret) {
> -					ksft_print_msg("%s - Failed to create thread %d\n", strerror(errno), i);
> +					TH_LOG("%s - Failed to create thread %d",
> +						strerror(errno), i);
>  					break;
>  				}
>  			}
> @@ -448,7 +452,8 @@ TEST(binderfs_stress)
>  
>  				ret = pthread_join(threads[j], &fdptr);
>  				if (ret)
> -					ksft_print_msg("%s - Failed to join thread %d for fd %d\n", strerror(errno), j, PTR_TO_INT(fdptr));
> +					TH_LOG("%s - Failed to join thread %d for fd %d",
> +						strerror(errno), j, PTR_TO_INT(fdptr));
>  			}
>  		}
>  		pthread_attr_destroy(&attr);
> @@ -459,11 +464,12 @@ TEST(binderfs_stress)
>  		exit(EXIT_SUCCESS);
>  	}
>  
> -	change_idmaps(syncfds, pid);
> +	change_idmaps(_metadata, syncfds, pid);
>  
>  	ret = wait_for_pid(pid);
> -	if (ret)
> -		ksft_exit_fail_msg("wait_for_pid() failed");
> +	ASSERT_EQ(ret, 0) {
> +		TH_LOG("wait_for_pid() failed");
> +	}
>  }
>  
>  TEST(binderfs_test_privileged)
> @@ -471,7 +477,7 @@ TEST(binderfs_test_privileged)
>  	if (geteuid() != 0)
>  		XFAIL(return, "Tests are not run as root. Skipping privileged tests");
>  
> -	if (__do_binderfs_test() == 1)
> +	if (__do_binderfs_test(_metadata))
>  		XFAIL(return, "The Android binderfs filesystem is not available");
>  }
>  
> @@ -482,31 +488,33 @@ TEST(binderfs_test_unprivileged)
>  	pid_t pid;
>  
>  	ret = socketpair(PF_LOCAL, SOCK_STREAM | SOCK_CLOEXEC, 0, syncfds);
> -	if (ret < 0)
> -		ksft_exit_fail_msg("%s - Failed to create socket pair", strerror(errno));
> +	ASSERT_EQ(ret, 0) {
> +		TH_LOG("%s - Failed to create socket pair", strerror(errno));
> +	}
>  
>  	pid = fork();
> -	if (pid < 0) {
> +	ASSERT_GE(pid, 0) {
>  		close_prot_errno_disarm(syncfds[0]);
>  		close_prot_errno_disarm(syncfds[1]);
> -		ksft_exit_fail_msg("%s - Failed to fork", strerror(errno));
> +		TH_LOG("%s - Failed to fork", strerror(errno));
>  	}
>  
>  	if (pid == 0) {
> -		change_userns(syncfds);
> -		if (__do_binderfs_test() == 1)
> +		change_userns(_metadata, syncfds);
> +		if (__do_binderfs_test(_metadata))
>  			exit(2);
>  		exit(EXIT_SUCCESS);
>  	}
>  
> -	change_idmaps(syncfds, pid);
> +	change_idmaps(_metadata, syncfds, pid);
>  
>  	ret = wait_for_pid(pid);
>  	if (ret) {
>  		if (ret == 2)
>  			XFAIL(return, "The Android binderfs filesystem is not available");
> -		else
> -			ksft_exit_fail_msg("wait_for_pid() failed");
> +		ASSERT_EQ(ret, 0) {
> +			TH_LOG("wait_for_pid() failed");
> +		}
>  	}
>  }
>  
> -- 
> 2.25.1
> 
