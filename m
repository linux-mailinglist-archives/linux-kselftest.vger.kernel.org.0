Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288C41F7CCA
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jun 2020 20:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgFLSVK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Jun 2020 14:21:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45380 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgFLSVK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Jun 2020 14:21:10 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jjoIc-0005i8-Gf; Fri, 12 Jun 2020 18:21:06 +0000
Date:   Fri, 12 Jun 2020 20:21:05 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        linux-kselftest@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] selftests: Remove unneeded selftest API headers
Message-ID: <20200612182105.w22td5jb5g6iltd7@wittgenstein>
References: <20200611224028.3275174-1-keescook@chromium.org>
 <20200611224028.3275174-3-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200611224028.3275174-3-keescook@chromium.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 11, 2020 at 03:40:23PM -0700, Kees Cook wrote:
> Remove unused includes of the kselftest.h header.
> 
> Cc: Christian Brauner <christian@brauner.io>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

Thanks!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

>  tools/testing/selftests/pid_namespace/regression_enomem.c | 1 -
>  tools/testing/selftests/pidfd/pidfd_getfd_test.c          | 1 -
>  tools/testing/selftests/pidfd/pidfd_setns_test.c          | 1 -
>  tools/testing/selftests/uevent/uevent_filtering.c         | 1 -
>  4 files changed, 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/pid_namespace/regression_enomem.c b/tools/testing/selftests/pid_namespace/regression_enomem.c
> index 73d532556d17..7d84097ad45c 100644
> --- a/tools/testing/selftests/pid_namespace/regression_enomem.c
> +++ b/tools/testing/selftests/pid_namespace/regression_enomem.c
> @@ -11,7 +11,6 @@
>  #include <syscall.h>
>  #include <sys/wait.h>
>  
> -#include "../kselftest.h"
>  #include "../kselftest_harness.h"
>  #include "../pidfd/pidfd.h"
>  
> diff --git a/tools/testing/selftests/pidfd/pidfd_getfd_test.c b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
> index 401a7c1d0312..eecbf18510fd 100644
> --- a/tools/testing/selftests/pidfd/pidfd_getfd_test.c
> +++ b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
> @@ -18,7 +18,6 @@
>  #include <linux/kcmp.h>
>  
>  #include "pidfd.h"
> -#include "../kselftest.h"
>  #include "../kselftest_harness.h"
>  
>  /*
> diff --git a/tools/testing/selftests/pidfd/pidfd_setns_test.c b/tools/testing/selftests/pidfd/pidfd_setns_test.c
> index 133ec5b6cda8..f66861cf9c4d 100644
> --- a/tools/testing/selftests/pidfd/pidfd_setns_test.c
> +++ b/tools/testing/selftests/pidfd/pidfd_setns_test.c
> @@ -20,7 +20,6 @@
>  
>  #include "pidfd.h"
>  #include "../clone3/clone3_selftests.h"
> -#include "../kselftest.h"
>  #include "../kselftest_harness.h"
>  
>  enum {
> diff --git a/tools/testing/selftests/uevent/uevent_filtering.c b/tools/testing/selftests/uevent/uevent_filtering.c
> index f83391aa42cf..5cebfb356345 100644
> --- a/tools/testing/selftests/uevent/uevent_filtering.c
> +++ b/tools/testing/selftests/uevent/uevent_filtering.c
> @@ -19,7 +19,6 @@
>  #include <sys/wait.h>
>  #include <unistd.h>
>  
> -#include "../kselftest.h"
>  #include "../kselftest_harness.h"
>  
>  #define __DEV_FULL "/sys/devices/virtual/mem/full/uevent"
> -- 
> 2.25.1
> 
