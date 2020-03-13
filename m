Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAA9185210
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Mar 2020 00:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgCMXHL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Mar 2020 19:07:11 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34847 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgCMXHK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Mar 2020 19:07:10 -0400
Received: by mail-pl1-f195.google.com with SMTP id g6so5021255plt.2
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Mar 2020 16:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YjbeAASRxVOPMkN7/k08zahcNwyqWMrHIMLC8DbMIpM=;
        b=YslUW2pfVMnfg1Z7vDx7kVxYX7M8lA3l4iX8R/tJALOvRGhfxMpSgqh9M8lDsJxNqe
         V9kfWy3gw7ciHNeZVKFvSAxfmIkXhs74LtvdU9OF7EXCBnmmPYorlpfXFP3mE7FsutK4
         +U3C8q3UhMA3xOgGnTvDMh4Ggx3Quw6NUPvwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YjbeAASRxVOPMkN7/k08zahcNwyqWMrHIMLC8DbMIpM=;
        b=JjMc9KEqURSokFcldRQc/dpi28fYM20DYpl0BlOlSDodJeg5wQnKQwKvbAxzedJNuQ
         4zEs/flsEBvr/3n3fVbxNNw8JhdyLjyYkm2ogW3M/qJXYxVdoezjpEM9IHbkZjIZfboj
         BRdd9sQmUT3wfHDcJWmfg9V2X6UmSIkC0B2RyhdnHCRfWp/clVMEOyPwwpKjXDdNc9yh
         ySCo/2ujvoJn5uCR7N2t/P9Zj6Wj+yBvSU6v+pymnMxigWmuaYTAIpguDewEPx0NSwPF
         sLirjajgreLmaCgLY/G3glLYLVvFYxnMpFvXObZJCpbK49vq4NU7QfmkVJ8DI13ADytJ
         wjwA==
X-Gm-Message-State: ANhLgQ1+xnsN9QPO6Rp8U/YYPjFCk9a17LJdUT9VAvm8YqudP4xz2yGS
        5WMN4c9Cu/KPuwE+buuQaV2RuA==
X-Google-Smtp-Source: ADFU+vsjpJFbDTmP2Mj6kKU9HPiCTTc9F4IfGANT420mBIsMskEl9ufDcLy386Y8WDgYY6BqxsKbQg==
X-Received: by 2002:a17:902:6ac7:: with SMTP id i7mr15101905plt.66.1584140827565;
        Fri, 13 Mar 2020 16:07:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t142sm48696399pgb.31.2020.03.13.16.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 16:07:06 -0700 (PDT)
Date:   Fri, 13 Mar 2020 16:07:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     gregkh@linuxfoundation.org, tkjos@android.com,
        linux-kernel@vger.kernel.org, ard.biesheuvel@linaro.org,
        ardb@kernel.org, arve@android.com, hridya@google.com,
        joel@joelfernandes.org, john.stultz@linaro.org,
        kernel-team@android.com, linux-kselftest@vger.kernel.org,
        maco@android.com, naresh.kamboju@linaro.org, shuah@kernel.org
Subject: Re: [PATCH v2 1/3] binderfs: port tests to test harness
 infrastructure
Message-ID: <202003131607.BA18A88D2F@keescook>
References: <20200312131531.3615556-1-christian.brauner@ubuntu.com>
 <20200313152420.138777-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313152420.138777-1-christian.brauner@ubuntu.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 13, 2020 at 04:24:18PM +0100, Christian Brauner wrote:
> Makes for nicer output and prepares for additional tests.
> 
> Cc: Kees Cook <keescook@chromium.org>:
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
> /* v2 */
> - Kees Cook <keescook@chromium.org>:
>   - Switch to XFAIL() to skip tests.
> ---
>  .../selftests/filesystems/binderfs/Makefile   |  2 ++
>  .../filesystems/binderfs/binderfs_test.c      | 31 +++++++++----------
>  2 files changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/testing/selftests/filesystems/binderfs/Makefile b/tools/testing/selftests/filesystems/binderfs/Makefile
> index 58cb659b56b4..75315d9ba7a9 100644
> --- a/tools/testing/selftests/filesystems/binderfs/Makefile
> +++ b/tools/testing/selftests/filesystems/binderfs/Makefile
> @@ -3,4 +3,6 @@
>  CFLAGS += -I../../../../../usr/include/
>  TEST_GEN_PROGS := binderfs_test
>  
> +binderfs_test: binderfs_test.c ../../kselftest.h ../../kselftest_harness.h
> +
>  include ../../lib.mk
> diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> index 8c2ed962e1c7..0cfca65e095a 100644
> --- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> +++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> @@ -15,7 +15,9 @@
>  #include <unistd.h>
>  #include <linux/android/binder.h>
>  #include <linux/android/binderfs.h>
> +
>  #include "../../kselftest.h"
> +#include "../../kselftest_harness.h"
>  
>  static ssize_t write_nointr(int fd, const void *buf, size_t count)
>  {
> @@ -132,7 +134,7 @@ static void rmdir_protect_errno(const char *dir)
>  	errno = saved_errno;
>  }
>  
> -static void __do_binderfs_test(void)
> +static int __do_binderfs_test(void)
>  {
>  	int fd, ret, saved_errno;
>  	size_t len;
> @@ -160,8 +162,7 @@ static void __do_binderfs_test(void)
>  					   strerror(errno));
>  
>  		keep ? : rmdir_protect_errno("/dev/binderfs");
> -		ksft_exit_skip(
> -			"The Android binderfs filesystem is not available\n");
> +		return 1;
>  	}
>  
>  	/* binderfs mount test passed */
> @@ -250,26 +251,24 @@ static void __do_binderfs_test(void)
>  
>  	/* binderfs unmount test passed */
>  	ksft_inc_pass_cnt();
> +	return 0;
>  }
>  
> -static void binderfs_test_privileged()
> +TEST(binderfs_test_privileged)
>  {
>  	if (geteuid() != 0)
> -		ksft_print_msg(
> -			"Tests are not run as root. Skipping privileged tests\n");
> -	else
> -		__do_binderfs_test();
> +		XFAIL(return, "Tests are not run as root. Skipping privileged tests");
> +
> +	if (__do_binderfs_test() == 1)
> +		XFAIL(return, "The Android binderfs filesystem is not available");
>  }
>  
> -static void binderfs_test_unprivileged()
> +TEST(binderfs_test_unprivileged)
>  {
>  	change_to_userns();
> -	__do_binderfs_test();
> -}
>  
> -int main(int argc, char *argv[])
> -{
> -	binderfs_test_privileged();
> -	binderfs_test_unprivileged();
> -	ksft_exit_pass();
> +	if (__do_binderfs_test() == 1)
> +		XFAIL(return, "The Android binderfs filesystem is not available");
>  }
> +
> +TEST_HARNESS_MAIN
> 
> base-commit: 2c523b344dfa65a3738e7039832044aa133c75fb
> -- 
> 2.25.1
> 

-- 
Kees Cook
