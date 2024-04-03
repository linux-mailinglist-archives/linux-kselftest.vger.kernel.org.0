Return-Path: <linux-kselftest+bounces-7106-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7548897565
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 18:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F5BA282322
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 16:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F8F14A62A;
	Wed,  3 Apr 2024 16:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="f9d7h/aC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6545A1514CC
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Apr 2024 16:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712162445; cv=none; b=BV/8+4U18CBOMCV+sFs5PY/yLcOXSRIEzyGxV88zhdUA16Iw6kppqgd8Zybsn+OlXZ6mj61N/Kp7z80wQIchHiQTNw11FZZAl/IFZrz57TXUnXsRbRmTHzYjhkU8U5qEwJPlUfrI1uSukQsdoQpqJ1Ik/hHq6CDVlSAJe1B0mT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712162445; c=relaxed/simple;
	bh=2mD3wd3nmiYzDQWwIH66jr73DzAk3vQYxK4D3uGstmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYcM2y7oBCJUPH54drq+Ya1ySxMspZPZy1pEmElGBQCKFs0ccre7Q/VY/c1q6YRF779sQLhzw+hHhdhZcHaVvzqiipJ9Cq/itZzVEugJDD3H/XYiU8xfMJpJKvF5ldjjN8v5iOj26BV6MUA1wx42T4sVqKBhvfcsZ1EdUIfrdY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=f9d7h/aC; arc=none smtp.client-ip=83.166.143.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4V8qzD5W0DzJnJ;
	Wed,  3 Apr 2024 18:32:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1712161944;
	bh=2mD3wd3nmiYzDQWwIH66jr73DzAk3vQYxK4D3uGstmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f9d7h/aCKQsdTBMI+Epb4SZd4Eo/slK/sWHGQMS/E78snT9F4cU62k9vtYT7Cb0SC
	 D0Uoq2D73VwBlL4L+NHYM3SRaKTNZn7Q2msLaYzRFt/lx0jvs/FB8PMWoKJWwjhTiJ
	 6A+zBL+s1pMyFK0D6UxgQLIH5TG841e6Jj8lZ9CU=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4V8qzD0VSHz3Hw;
	Wed,  3 Apr 2024 18:32:24 +0200 (CEST)
Date: Wed, 3 Apr 2024 18:32:23 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Saasha Gupta <saashaa1122@gmail.com>
Cc: outreachy@lists.linux.dev, linux-security-module@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, alison.schofield@intel.com, paul@paul-moore.com, 
	shuah@kernel.org
Subject: Re: Subject: [PATCH] Add test for more file systems in landlock -
 ext4
Message-ID: <20240403.gaingaeR2zez@digikod.net>
References: <860c9cadb2fa06c8f10db42ad38405ee19d43a16.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <860c9cadb2fa06c8f10db42ad38405ee19d43a16.camel@gmail.com>
X-Infomaniak-Routing: alpha

On Tue, Apr 02, 2024 at 01:37:44PM +0530, Saasha Gupta wrote:
> Date: Mon, 2 Apr 2024 19:59:56 +0530
> 
> RE: This patch is now properly preformatted.
> 
> Landlock LSM, a part of the security subsystem, has some tests in place
> for synthetic filesystems such as tmpfs, proc, sysfs, etc. The goal of
> the new issue, and hence this patch is to add tests for non synthetic
> file systems, such as ext4, btrfs, etc

I agree with Julia's review.

> 
> This patch adds tests for the ext4 file system. This includes creation
> of a loop device (test-ext4.img) and formating with mkfs.
> 
> Signed-off-by: Saasha Gupta <saashaa1122@gmail.com>
> ---
>  tools/testing/selftests/landlock/fs_test.c | 65 ++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 9a6036fbf..b2f2cd5a5 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -4675,6 +4675,14 @@ FIXTURE_VARIANT_ADD(layout3_fs, hostfs) {
>  	.cwd_fs_magic = HOSTFS_SUPER_MAGIC,
>  };
>  
> +/* Add more filesystems */
> +FIXTURE_VARIANT_ADD(layout3_fs, ext4) {
> +	.mnt = {
> +		.type = "ext4",
> +	},
> +	.file_path = TMP_DIR "/dir/file",
> +};
> +
>  FIXTURE_SETUP(layout3_fs)
>  {
>  	struct stat statbuf;
> @@ -4728,6 +4736,63 @@ FIXTURE_SETUP(layout3_fs)
>  		self->has_created_file = true;
>  		clear_cap(_metadata, CAP_DAC_OVERRIDE);
>  	}
> +
> +	/* Create non synthetic file system - ext4 */
> +	if (stat(self->dir_path, &statbuf) != 0) {

dir_path should already exist with previous code right?

> +		pid_t pid = fork();
> +
> +		if (pid == -1) {
> +			perror("Failed to fork");
> +			exit(EXIT_FAILURE);
> +		} else if (pid == 0) {
> +			static const fallocate_argv[] = { "fallocate", "--length",
> +						   "4M", "test-ext4.img",
> +						   NULL };
> +			execvp(fallocate_argv[0], fallocate_argv);

Using system() would makes this much simpler (see net_test.c).

> +			perror("execvp failed");
> +			exit(EXIT_FAILURE);
> +		} else {
> +			int status;
> +
> +			if (waitpid(pid, &status, 0) == -1) {
> +				perror("waitpid failed");
> +				exit(EXIT_FAILURE);
> +			}
> +			if (!WIFEXITED(status) || WEXITSTATUS(status) != 0) {
> +				TH_LOG(stderr,
> +					"Failed to create ext4 filesystem image: fallocate failed\n");
> +				exit(EXIT_FAILURE);
> +			}
> +		}
> +	}
> +
> +	/* Formate and mount non synthetic file system - ext4 */
> +	if (stat("mnt", &statbuf) != 0) {

"mnt" never exists, so this would always run this code...

> +		pid_t pid = fork();
> +
> +		if (pid == -1) {
> +			perror("Failed to fork");
> +			exit(EXIT_FAILURE);
> +		} else if (pid == 0) {
> +			static const mkfs_argv[] = { "mkfs.ext4", "-q",
> +					      "test-ext4.img", "mnt", NULL };
> +			execvp(mkfs_argv[0], mkfs_argv);
> +			perror("execvp failed");
> +			exit(EXIT_FAILURE);
> +		} else {
> +			int status;
> +
> +			if (waitpid(pid, &status, 0) == -1) {
> +				perror("waitpid failed");
> +				exit(EXIT_FAILURE);
> +			}
> +			if (!WIFEXITED(status) || WEXITSTATUS(status) != 0) {
> +				TH_LOG(stderr,
> +					"Failed to format ext4 filesystem image: mkfs.ext4 failed\n");
> +				exit(EXIT_FAILURE);
> +			}
> +		}
> +	}
>  }
>  
>  FIXTURE_TEARDOWN(layout3_fs)
> -- 
> 2.44.0
> 
> 
> 

