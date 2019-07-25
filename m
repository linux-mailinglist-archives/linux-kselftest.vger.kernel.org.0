Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8952974294
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2019 02:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfGYAeS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Jul 2019 20:34:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45486 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfGYAeS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Jul 2019 20:34:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so48736691wre.12
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jul 2019 17:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FVjahqrOAsC+5k2LwQtzoiwOqD0DAUgbl8M0M6/MVtI=;
        b=tdSs3a/NsJXHkdnAxSHm2b3gXTNA+re5rO6dufp3Qs4u0GLKdvlr0Rz1lrX9S8qwVB
         Cfh2peXuKKrYf0slMJXvf+CS8q7URxyZ3cywWFyU6XIiaJPjMrMEY8qWKrUtWrhnka6v
         d9a+BrVW7hUuqK9BX3il4uAHXL5/FGapH2pBeQT4K34/NlKyahIjSdasLXyqgn/BVEHL
         uO6Qs/OdE3NcXQZGkd+BRRZl/BU8S1a4Ig+lgXzv9FqLJ5QpcJYtOjxygAqCK/FqXMf/
         gOjfhFYbf7IPIgX3+bzL+gVMV407g4uadyU2TPvORHVnoFlfXmZM9dlSsoON/tlPa1n7
         H4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FVjahqrOAsC+5k2LwQtzoiwOqD0DAUgbl8M0M6/MVtI=;
        b=IjiZlcyliCwhLGv243TJFFUsx7kPFJaWmwEhSz4PAIbq1RYTMEuUPB4J0gpbT6x2BV
         vHZvL0Wh347CBrjeDmXfIMkyB+e6CN2kc1DA2f3rYpRJNQGrWDf0F+ZcAr2CaQ4j8/ub
         njqFn5YdmcMN/BApan6bEvcMk9jGXJzce022EKlfOmVKC6m4/8sGoRCnoCoVIkv5MJ2x
         +Ix36ZwNDTk8yP/QY9snOJwNa3jk4BAXu4E0Wp7M8d8PxunknxWhxQ0l46Hhjmm3SrhO
         C46AFG4kCHacz7EyLHrGF3WXEeMywyeS+8dWuMRgcI41mLDBHdQ9ARmKo9F7hvQu7+Wj
         lYCg==
X-Gm-Message-State: APjAAAUTQS/lb7IEyDqgmT3Fj0yC0ePZR5Un/vX21Ry3IdvxJYesg/A+
        tuxyntVbfpwcqmu0d6GO0pH0dXG+riraC44et1/u1g==
X-Google-Smtp-Source: APXvYqx/86yi7bEi9+JJhF5n5XngaGtwIVcG3LHZ4rytdP5yc0EcYVzPipybTTrBoJ6laKO37sAwg3IlQK7g4PhU1f8=
X-Received: by 2002:a5d:46cf:: with SMTP id g15mr93568749wrs.93.1564014855955;
 Wed, 24 Jul 2019 17:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190725002204.185225-1-surenb@google.com>
In-Reply-To: <20190725002204.185225-1-surenb@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 24 Jul 2019 17:34:04 -0700
Message-ID: <CAJuCfpH0OVCjA7ST4dtQ839+gEHKT_T=t-SN=ghPO4ev-GEfYg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tests: move common definitions and functions into pidfd.h
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Christian Brauner <christian@brauner.io>, arnd@arndb.de,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>, tglx@linutronix.de,
        Jann Horn <jannh@google.com>, dhowells@redhat.com,
        mtk.manpages@gmail.com, luto@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, cyphar@cyphar.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        viro@zeniv.linux.org.uk, linux-api@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

I'm terribly sorry. I forgot to add a link to the original version of
this patch with Christian's comments. It's at:
https://lore.kernel.org/linux-kselftest/20190723173907.196488-1-surenb@google.com
and I think I addressed all comments there.
The patch should apply cleanly to the latest Linus' ToT (v5.3-rc1).
Thanks,
Suren.

On Wed, Jul 24, 2019 at 5:22 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> Move definitions and functions used across different pidfd tests into
> pidfd.h header.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
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
>         return WEXITSTATUS(status);
>  }
>
> +static inline int sys_pidfd_open(pid_t pid, unsigned int flags)
> +{
> +       return syscall(__NR_pidfd_open, pid, flags);
> +}
> +
> +static inline int sys_pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
> +                                       unsigned int flags)
> +{
> +       return syscall(__NR_pidfd_send_signal, pidfd, sig, info, flags);
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
> -       return syscall(__NR_pidfd_open, pid, flags);
> -}
> -
>  static int safe_int(const char *numstr, int *converted)
>  {
>         char *err = NULL;
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
> -                                       unsigned int flags)
> -{
> -       return syscall(__NR_pidfd_send_signal, pidfd, sig, info, flags);
> -}
> -
>  static int signal_received;
>
>  static void set_signal_received_on_sigusr1(int sig)
> --
> 2.22.0.709.g102302147b-goog
>
