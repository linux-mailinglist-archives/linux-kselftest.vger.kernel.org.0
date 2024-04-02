Return-Path: <linux-kselftest+bounces-6982-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 728A6895236
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 13:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12E6B1F2264D
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 11:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AA969945;
	Tue,  2 Apr 2024 11:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="lUn7NZ5t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4639C2032C;
	Tue,  2 Apr 2024 11:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712058896; cv=none; b=nLqix1rEOuSrrxjfI3jQtJ4WVUgVXYxkDqI6/WYEQFzd90PJohiyYPrtdMJ4nOEUBtsbH0SrqTf7/iVMrUn0MoQkkzm3Yp/5BdL2dh8FJOgY51T2//PdJrTQEIkodupmg64qXbpc7kN8NKknVdVYW/fOQeFPcluUz+bBf24pQro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712058896; c=relaxed/simple;
	bh=AbcJNfryz3ikREq1ToLFUEKmW32S8324XKssQNFnC/o=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QUleJV6NgnmMf4R2sbHCWaea4OiYmr3e7IVIYCDnnzjdDg9yst6hKaB1m7oneVpYTE4KIWsV2La4jDA0qd65gPkxIEtBpI3vx43cJuGCYWhUgbIkN4TIN7M9oGAkvVDsZkX414e/gosKx/pDxooB87sjc0KwhlxHk5hxACCkwKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=lUn7NZ5t; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=amhJgKxkEum2SG4fYWqJx66qHnEM75pqagVaDk/5ic4=;
  b=lUn7NZ5tN794UWgWFjCP3saUsHSRGC0XLErDkfc4J6K0jEwSx/DIOfGA
   5SPa34SOq6Pks/01idfZCee6RbyGV+FUKb2zSyHo03ToV1tcIKB08bjAx
   qPD3PeiHY5xcRbZ5PR/701ROfKmj9XN2Ry33t0bbMGDzvoukVm2Np3PYn
   M=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.07,174,1708383600"; 
   d="scan'208";a="83651121"
Received: from 71-51-181-183.chvl.centurylink.net (HELO hadrien) ([71.51.181.183])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 13:54:44 +0200
Date: Tue, 2 Apr 2024 07:54:42 -0400 (EDT)
From: Julia Lawall <julia.lawall@inria.fr>
To: Saasha Gupta <saashaa1122@gmail.com>
cc: outreachy@lists.linux.dev, mic@digikod.net, 
    linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
    alison.schofield@intel.com, paul@paul-moore.com, shuah@kernel.org
Subject: Re: Subject: [PATCH] Add test for more file systems in landlock -
 ext4
In-Reply-To: <860c9cadb2fa06c8f10db42ad38405ee19d43a16.camel@gmail.com>
Message-ID: <3cdf4be4-a9ee-4e4-c839-29ae58e4c199@inria.fr>
References: <860c9cadb2fa06c8f10db42ad38405ee19d43a16.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Tue, 2 Apr 2024, Saasha Gupta wrote:

> Date: Mon, 2 Apr 2024 19:59:56 +0530
>
> RE: This patch is now properly preformatted.
>
> Landlock LSM, a part of the security subsystem, has some tests in place
> for synthetic filesystems such as tmpfs, proc, sysfs, etc. The goal of
> the new issue, and hence this patch is to add tests for non synthetic
> file systems, such as ext4, btrfs, etc

Not clear what "the new issue" could be.  Remember that the log message
will be read by people 10 years from now.  Not just by the recipientes of
the patch.

> This patch adds tests for the ext4 file system. This includes creation
> of a loop device (test-ext4.img) and formating with mkfs.

This should be "Add tests for the ext4 file system".
You seem to have joined application period quite late, but you need to
read the entirety of the tutorial and be prepared to follow it, at least
in the future.

julia

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
>

