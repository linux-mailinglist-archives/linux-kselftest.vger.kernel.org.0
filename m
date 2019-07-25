Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A69E74CF6
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2019 13:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391741AbfGYLXy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 Jul 2019 07:23:54 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:47035 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391270AbfGYLXy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 Jul 2019 07:23:54 -0400
Received: by mail-ed1-f68.google.com with SMTP id d4so49919505edr.13
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Jul 2019 04:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R4X4dIvgC7aHDnggel6jNUiHPO07ZamRAm1AnpEU6C4=;
        b=B7SEKAH2l3txcMK9IQ8ysWmU/wtKk0uJqs1w331GUvqy2Lfz/cvtyyyV+c9wSyXfOJ
         auTKJ2ERAPRPE+7EGT0NpeUEbX3QORh42rwZY/kJFyu1BYlBRtqhwZqk8vdlG88IW6Np
         Yw9eSmF0PPz7t45gLoBb7wUjLaCmeMQkhLHUc/o0NvZ4lefuvTTpzKGEyb8AeElPA1Ie
         F2DWs0hH1+Ff/BnXvG6NCJg7ikyn7iU1oa6cdnoDjoRXbnp4ch6lfvqoSM4Mow2SiMp2
         IDeBWtqNF9bii5b5MqS8iTZs/KxkWmeJUcW+E9qG/JTqB1IQa/xLwDABlqBMmqR6AJji
         R65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R4X4dIvgC7aHDnggel6jNUiHPO07ZamRAm1AnpEU6C4=;
        b=o1+WufNuIgygUC2BCWFKYMCJ/bXZi1b8tiKuPCUv5HUlwXPE/btxmoAZ/q5kZDf1A4
         osp9EeJTWJY+/2UzvEF4UdeaCmfreahKBP5vC9fhqQiEJNTjlK6dofAjLw9bjjSMZcpD
         fSH7b50xwGkaUB+KO5YX+Ph5ymDC4dZnqN1u7MDZTYXTvNN5JodbJKpmil5h5wRZXp0M
         IibvlUx4wtXqTBZ/UHKYDSU7ew7nyjEpYkER+2hapV/zh4q2PeSlVnqdt8CMTTezSE8u
         58QR2HlA6gWrw9H8HUYivrGmoR2Ae6o+Ztn6xFULzRMIH8Sx1SPPOLFe/NWjYP1IK8nL
         0AtA==
X-Gm-Message-State: APjAAAXlNlZ5kjRufrGktykFSJTaI1wRq9qcE40ZUcNNIdxbsPQdZ28i
        oOUxV0fo7c3fmQqOkw8l2Vs=
X-Google-Smtp-Source: APXvYqxUAFmz4cYMDK6MBsWYvmxoGli2NOMyXBcsXSZuxTH6/fv4cqIIp3v8wen2g1a7iIqYxpE11Q==
X-Received: by 2002:a50:a56d:: with SMTP id z42mr77579614edb.241.1564053832148;
        Thu, 25 Jul 2019 04:23:52 -0700 (PDT)
Received: from brauner.io (ip5b40f7ec.dynamic.kabel-deutschland.de. [91.64.247.236])
        by smtp.gmail.com with ESMTPSA id ni7sm6444396ejb.57.2019.07.25.04.23.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 04:23:52 -0700 (PDT)
Date:   Thu, 25 Jul 2019 13:23:50 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        joel@joelfernandes.org, dancol@google.com, tglx@linutronix.de,
        jannh@google.com, dhowells@redhat.com, mtk.manpages@gmail.com,
        luto@kernel.org, akpm@linux-foundation.org, oleg@redhat.com,
        cyphar@cyphar.com, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, linux-api@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 1/2] tests: move common definitions and functions into
 pidfd.h
Message-ID: <20190725112350.fspfvv7encmmdvqv@brauner.io>
References: <20190725002204.185225-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190725002204.185225-1-surenb@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 24, 2019 at 05:22:03PM -0700, Suren Baghdasaryan wrote:
> Move definitions and functions used across different pidfd tests into
> pidfd.h header.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Christian Brauner <christian@brauner.io>

> ---
>  tools/testing/selftests/pidfd/pidfd.h          | 18 ++++++++++++++++++
>  .../testing/selftests/pidfd/pidfd_open_test.c  |  5 -----
>  tools/testing/selftests/pidfd/pidfd_test.c     | 10 ----------
>  3 files changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
> index 8452e910463f..db4377af6be7 100644
> --- a/tools/testing/selftests/pidfd/pidfd.h
> +++ b/tools/testing/selftests/pidfd/pidfd.h
> @@ -16,6 +16,14 @@
>  
>  #include "../kselftest.h"
>  
> +#ifndef __NR_pidfd_open
> +#define __NR_pidfd_open -1
> +#endif
> +
> +#ifndef __NR_pidfd_send_signal
> +#define __NR_pidfd_send_signal -1
> +#endif
> +
>  /*
>   * The kernel reserves 300 pids via RESERVED_PIDS in kernel/pid.c
>   * That means, when it wraps around any pid < 300 will be skipped.
> @@ -53,5 +61,15 @@ int wait_for_pid(pid_t pid)
>  	return WEXITSTATUS(status);
>  }
>  
> +static inline int sys_pidfd_open(pid_t pid, unsigned int flags)
> +{
> +	return syscall(__NR_pidfd_open, pid, flags);
> +}
> +
> +static inline int sys_pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
> +					unsigned int flags)
> +{
> +	return syscall(__NR_pidfd_send_signal, pidfd, sig, info, flags);
> +}
>  
>  #endif /* __PIDFD_H */
> diff --git a/tools/testing/selftests/pidfd/pidfd_open_test.c b/tools/testing/selftests/pidfd/pidfd_open_test.c
> index 0377133dd6dc..b9fe75fc3e51 100644
> --- a/tools/testing/selftests/pidfd/pidfd_open_test.c
> +++ b/tools/testing/selftests/pidfd/pidfd_open_test.c
> @@ -22,11 +22,6 @@
>  #include "pidfd.h"
>  #include "../kselftest.h"
>  
> -static inline int sys_pidfd_open(pid_t pid, unsigned int flags)
> -{
> -	return syscall(__NR_pidfd_open, pid, flags);
> -}
> -
>  static int safe_int(const char *numstr, int *converted)
>  {
>  	char *err = NULL;
> diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
> index 7eaa8a3de262..17b2fd621726 100644
> --- a/tools/testing/selftests/pidfd/pidfd_test.c
> +++ b/tools/testing/selftests/pidfd/pidfd_test.c
> @@ -21,10 +21,6 @@
>  #include "pidfd.h"
>  #include "../kselftest.h"
>  
> -#ifndef __NR_pidfd_send_signal
> -#define __NR_pidfd_send_signal -1
> -#endif
> -
>  #define str(s) _str(s)
>  #define _str(s) #s
>  #define CHILD_THREAD_MIN_WAIT 3 /* seconds */
> @@ -47,12 +43,6 @@ static pid_t pidfd_clone(int flags, int *pidfd, int (*fn)(void *))
>  #endif
>  }
>  
> -static inline int sys_pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
> -					unsigned int flags)
> -{
> -	return syscall(__NR_pidfd_send_signal, pidfd, sig, info, flags);
> -}
> -
>  static int signal_received;
>  
>  static void set_signal_received_on_sigusr1(int sig)
> -- 
> 2.22.0.709.g102302147b-goog
> 
