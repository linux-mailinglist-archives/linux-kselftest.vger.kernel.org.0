Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFE0183DA0
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Mar 2020 00:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgCLXy2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Mar 2020 19:54:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46293 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgCLXy2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Mar 2020 19:54:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id c19so4063799pfo.13
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Mar 2020 16:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=96Rbgpb7kkNngUmkXNe7bOZpJgfpt4Yqk8FaCmS1/Lo=;
        b=l0YwtNPqI71Xw09yG4hemwtwExVdI9XB7wFD5olHin0gWn/deihUQpoVrrLwa1uhrK
         PcFUmte9XRW/PQalDl+tEknTm+Fv9pv/4WEV53beiRTs2FxmMZIv0yMPhSsCJ0eThRQW
         CbfbibenGXUfEefgG7Bbok+DaQh8eXNyjur6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=96Rbgpb7kkNngUmkXNe7bOZpJgfpt4Yqk8FaCmS1/Lo=;
        b=oyP3ORmevGytHjLy2aGQNPsrBd9L44RI+7DkimKk8Pi8rNMrvcbjHZ6qbZMIdVnqiK
         oxsDH09jQMiX0TRYWGT4hJg7RkFE3CB4btixKd0veCQz5zto4WfA68+K9FjY6vJmy2JJ
         TCIbbhmDKjQbFzG7tiSR3KA/8WDEczTYjeuufOeaKXhB1zK7LgQZS3HietLsOJdvrHJC
         dY9CIC1NNg4IsSt7ZOwt8TO68+zXzQQVJ7E0ammylIkIzI9E4gzW25bVNyuJ/NNLnP1E
         H2NzpeBbmL8N6Wn/Oii/nuo3kXFIToFOUN6TH5QDxc3TivmJDPgN3RoNeUn6P8BZgIB7
         PQuw==
X-Gm-Message-State: ANhLgQ20rKwaYyGQFAG+TZYGcxuDr6pIP60V5HW5kIaOiGuHetxSsGJa
        Cc0PF4dJh2fEdDpaazrxbLnxOw==
X-Google-Smtp-Source: ADFU+vsMLfAIQx/sIeqQSB45VWLXRWNP3Bc5xJpum3RASaSb4xhga1HnBfjS3CufxzfCNRQIFbd//w==
X-Received: by 2002:a62:2f82:: with SMTP id v124mr9150110pfv.120.1584057267058;
        Thu, 12 Mar 2020 16:54:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l25sm54297260pgn.47.2020.03.12.16.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 16:54:26 -0700 (PDT)
Date:   Thu, 12 Mar 2020 16:54:25 -0700
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
Subject: Re: [PATCH 3/3] binderfs_test: switch from /dev to /tmp as mountpoint
Message-ID: <202003121653.4BC2D43@keescook>
References: <20200311105309.1742827-1-christian.brauner@ubuntu.com>
 <20200312131531.3615556-1-christian.brauner@ubuntu.com>
 <20200312131531.3615556-3-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312131531.3615556-3-christian.brauner@ubuntu.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 12, 2020 at 02:15:31PM +0100, Christian Brauner wrote:
> Unprivileged users will be able to create directories in there. The
> unprivileged test for /dev wouldn't have worked on most systems.
> 
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Seems good. (Though would a dynamic location be better?
mkstemp()-style?)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  .../filesystems/binderfs/binderfs_test.c      | 30 +++++++++----------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> index 313ffad15614..d6e61998d20a 100644
> --- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> +++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> @@ -76,7 +76,7 @@ static void __do_binderfs_test(void)
>  
>  	change_mountns();
>  
> -	ret = mkdir("/dev/binderfs", 0755);
> +	ret = mkdir("/tmp/binderfs", 0755);
>  	if (ret < 0) {
>  		if (errno != EEXIST)
>  			ksft_exit_fail_msg(
> @@ -86,13 +86,13 @@ static void __do_binderfs_test(void)
>  		keep = true;
>  	}
>  
> -	ret = mount(NULL, "/dev/binderfs", "binder", 0, 0);
> +	ret = mount(NULL, "/tmp/binderfs", "binder", 0, 0);
>  	if (ret < 0) {
>  		if (errno != ENODEV)
>  			ksft_exit_fail_msg("%s - Failed to mount binderfs\n",
>  					   strerror(errno));
>  
> -		keep ? : rmdir_protect_errno("/dev/binderfs");
> +		keep ? : rmdir_protect_errno("/tmp/binderfs");
>  		ksft_exit_skip(
>  			"The Android binderfs filesystem is not available\n");
>  	}
> @@ -102,7 +102,7 @@ static void __do_binderfs_test(void)
>  
>  	memcpy(device.name, "my-binder", strlen("my-binder"));
>  
> -	fd = open("/dev/binderfs/binder-control", O_RDONLY | O_CLOEXEC);
> +	fd = open("/tmp/binderfs/binder-control", O_RDONLY | O_CLOEXEC);
>  	if (fd < 0)
>  		ksft_exit_fail_msg(
>  			"%s - Failed to open binder-control device\n",
> @@ -113,7 +113,7 @@ static void __do_binderfs_test(void)
>  	close(fd);
>  	errno = saved_errno;
>  	if (ret < 0) {
> -		keep ? : rmdir_protect_errno("/dev/binderfs");
> +		keep ? : rmdir_protect_errno("/tmp/binderfs");
>  		ksft_exit_fail_msg(
>  			"%s - Failed to allocate new binder device\n",
>  			strerror(errno));
> @@ -126,9 +126,9 @@ static void __do_binderfs_test(void)
>  	/* binder device allocation test passed */
>  	ksft_inc_pass_cnt();
>  
> -	fd = open("/dev/binderfs/my-binder", O_CLOEXEC | O_RDONLY);
> +	fd = open("/tmp/binderfs/my-binder", O_CLOEXEC | O_RDONLY);
>  	if (fd < 0) {
> -		keep ? : rmdir_protect_errno("/dev/binderfs");
> +		keep ? : rmdir_protect_errno("/tmp/binderfs");
>  		ksft_exit_fail_msg("%s - Failed to open my-binder device\n",
>  				   strerror(errno));
>  	}
> @@ -138,7 +138,7 @@ static void __do_binderfs_test(void)
>  	close(fd);
>  	errno = saved_errno;
>  	if (ret < 0) {
> -		keep ? : rmdir_protect_errno("/dev/binderfs");
> +		keep ? : rmdir_protect_errno("/tmp/binderfs");
>  		ksft_exit_fail_msg(
>  			"%s - Failed to open perform BINDER_VERSION request\n",
>  			strerror(errno));
> @@ -150,9 +150,9 @@ static void __do_binderfs_test(void)
>  	/* binder transaction with binderfs binder device passed */
>  	ksft_inc_pass_cnt();
>  
> -	ret = unlink("/dev/binderfs/my-binder");
> +	ret = unlink("/tmp/binderfs/my-binder");
>  	if (ret < 0) {
> -		keep ? : rmdir_protect_errno("/dev/binderfs");
> +		keep ? : rmdir_protect_errno("/tmp/binderfs");
>  		ksft_exit_fail_msg("%s - Failed to delete binder device\n",
>  				   strerror(errno));
>  	}
> @@ -160,12 +160,12 @@ static void __do_binderfs_test(void)
>  	/* binder device removal passed */
>  	ksft_inc_pass_cnt();
>  
> -	ret = unlink("/dev/binderfs/binder-control");
> +	ret = unlink("/tmp/binderfs/binder-control");
>  	if (!ret) {
> -		keep ? : rmdir_protect_errno("/dev/binderfs");
> +		keep ? : rmdir_protect_errno("/tmp/binderfs");
>  		ksft_exit_fail_msg("Managed to delete binder-control device\n");
>  	} else if (errno != EPERM) {
> -		keep ? : rmdir_protect_errno("/dev/binderfs");
> +		keep ? : rmdir_protect_errno("/tmp/binderfs");
>  		ksft_exit_fail_msg(
>  			"%s - Failed to delete binder-control device but exited with unexpected error code\n",
>  			strerror(errno));
> @@ -175,8 +175,8 @@ static void __do_binderfs_test(void)
>  	ksft_inc_xfail_cnt();
>  
>  on_error:
> -	ret = umount2("/dev/binderfs", MNT_DETACH);
> -	keep ?: rmdir_protect_errno("/dev/binderfs");
> +	ret = umount2("/tmp/binderfs", MNT_DETACH);
> +	keep ?: rmdir_protect_errno("/tmp/binderfs");
>  	if (ret < 0)
>  		ksft_exit_fail_msg("%s - Failed to unmount binderfs\n",
>  				   strerror(errno));
> -- 
> 2.25.1
> 

-- 
Kees Cook
