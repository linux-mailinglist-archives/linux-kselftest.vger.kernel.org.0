Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5AC183D99
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Mar 2020 00:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgCLXvr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Mar 2020 19:51:47 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:52594 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgCLXvr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Mar 2020 19:51:47 -0400
Received: by mail-pj1-f67.google.com with SMTP id f15so3210534pjq.2
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Mar 2020 16:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0KxoRh9qG0nLMfrbberK+fO1rqVz30X/phZqryHpwoE=;
        b=hrDFZCxOoZIcuiwEPWccramEAhWr1lMdKuusoyTmE2sVv9Z09z1vKUIBrOVGra0QoW
         Iu+CfN43PYxi12Ebdq88oCKzkUWKHHwbP6LGOUeYqhvDeK58SyOfk0Hd2RUuHTnOpplY
         VrYaCA/WV4QeV4sUlJrKUygPV+W304zKjQSug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0KxoRh9qG0nLMfrbberK+fO1rqVz30X/phZqryHpwoE=;
        b=Rm4Cf7kf27cjBcezOhVpf9anMlafMw8PYPPfkwx1kKCVNDOUidCpgiVIIOx79QnBI9
         clRku02LwMJiGeyopX4aMPd9akLXpKJxpsfLyumN9hGLl1JDxezkPcCwNq2Z2GwsZzxE
         TibM4S3WQZ0MFaYHPVJ3+H8/USzK0vBkXxo0nUhONoS4i38xnOxgFaNs4N3NlRnIZrFB
         udSpYpojxjc0FzDGqiDMCYvlVyfTuqGsy/VPj1XUSMArz5ZajgEr+ykxfTi6QjVeGcf2
         +8S/RlajjgqPWFgqpmSqm/D3siJZy56yBJSv1VxtEh5Fx6ZyTU85d9bNSTtrF9LG8B9z
         m2yw==
X-Gm-Message-State: ANhLgQ2+Y4joH73uWq26qysZtQodl/mL/8AcWbZ5MA3v6TFXbKGhQgSU
        li+jeAWUKeXnWDchjAlt9eSwSQ==
X-Google-Smtp-Source: ADFU+vuYJ4FEHhqKp1ULOQP4BxWE4WCcGej1urOAm1ZQy7sOKoPH70GW5BnhRttob76Zor/FqAJANA==
X-Received: by 2002:a17:90a:345:: with SMTP id 5mr6721841pjf.134.1584057105987;
        Thu, 12 Mar 2020 16:51:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id fz3sm10018224pjb.41.2020.03.12.16.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 16:51:45 -0700 (PDT)
Date:   Thu, 12 Mar 2020 16:51:44 -0700
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
Subject: Re: [PATCH 1/3] binderfs: port tests to test harness infrastructure
Message-ID: <202003121651.149266F1@keescook>
References: <20200311105309.1742827-1-christian.brauner@ubuntu.com>
 <20200312131531.3615556-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312131531.3615556-1-christian.brauner@ubuntu.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 12, 2020 at 02:15:29PM +0100, Christian Brauner wrote:
> Makes for nicer output and prepares for additional tests.
> 
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Yay harness! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  .../selftests/filesystems/binderfs/Makefile      |  2 ++
>  .../filesystems/binderfs/binderfs_test.c         | 16 ++++++----------
>  2 files changed, 8 insertions(+), 10 deletions(-)
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
> index 8c2ed962e1c7..d03ed8eed5eb 100644
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
> @@ -252,24 +254,18 @@ static void __do_binderfs_test(void)
>  	ksft_inc_pass_cnt();
>  }
>  
> -static void binderfs_test_privileged()
> +TEST(binderfs_test_privileged)
>  {
>  	if (geteuid() != 0)
> -		ksft_print_msg(
> -			"Tests are not run as root. Skipping privileged tests\n");
> +		ksft_print_msg("Tests are not run as root. Skipping privileged tests\n");
>  	else
>  		__do_binderfs_test();
>  }
>  
> -static void binderfs_test_unprivileged()
> +TEST(binderfs_test_unprivileged)
>  {
>  	change_to_userns();
>  	__do_binderfs_test();
>  }
>  
> -int main(int argc, char *argv[])
> -{
> -	binderfs_test_privileged();
> -	binderfs_test_unprivileged();
> -	ksft_exit_pass();
> -}
> +TEST_HARNESS_MAIN
> 
> base-commit: 2c523b344dfa65a3738e7039832044aa133c75fb
> -- 
> 2.25.1
> 

-- 
Kees Cook
