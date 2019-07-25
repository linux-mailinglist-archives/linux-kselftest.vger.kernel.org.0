Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2738974D0A
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2019 13:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391855AbfGYL0u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 Jul 2019 07:26:50 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46321 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391453AbfGYL0u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 Jul 2019 07:26:50 -0400
Received: by mail-ed1-f67.google.com with SMTP id d4so49928842edr.13
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Jul 2019 04:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+MsnDi3TdRcq0Eiuzr/rb//Hp/GfDkvda3lMlcb36Ks=;
        b=b/F4JcUQl83tPVozzBu5F9CU6h56hPODr0mGZNR3LS2W1DigF6WZyQ1Wks10OG77RM
         ckhQKX98WXTd3txW7lrs8/1wPcu84MqzzBLPVp+W0HggS+piHzProvl9Yefm0tbMUO3c
         HCIWDdnfYUgWQ8DuHLkq+bxMt9aymj1cv5EjKVTXdVN+umIqXRzWfmV2gL+fR2xbLrPj
         RY+uBQJTSqrMPGstXND4j9tXDhOZiw6ZWCzlF9jKnI5+VVTAor4tLuUcOZuhItlcPX+q
         aT9qRsem1N8MNkIsGMNlQcu7EY2qA7FVjApRXDuTnBgZJEbsOylvGLs8coztlZ7csFi+
         RkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+MsnDi3TdRcq0Eiuzr/rb//Hp/GfDkvda3lMlcb36Ks=;
        b=Sand/gU4xFkPIx/4V++xrEsCY69ws8Ac4cYYf6eyMNDthVJQ3gunGorOHj2lwzjdwb
         /N6K+dR3p8AGK7JI0/sny32o55/755y99wSPrZWXuP0OKNeN1OsazKuM1TXPcsA6q+b6
         h0FL1sXZoQglnor8WSuw+zmcJ6N3mwGln3XJcR8534Cj8/IEX0qonXsp+KIe0hv+/QFB
         Ym9cN2B6uFCoSFCDZ3UzslL0DZaUuN+muGgsHlrpyYNVhTNyPAvggiP1Xj87/GbbNRgu
         XA/OVi/zZphofj5LUGzV0nCNWIn1RSVFWKfASsDqVk6GuRKtak1K1M6QrcwisFEzbNl1
         Ling==
X-Gm-Message-State: APjAAAWjsR8nBlBbRzH76u0xcwsgtFSKC+9/DFMPWdd4/aeRO/w5Yt/K
        JopkND538BGMfJxi4pXFpP8=
X-Google-Smtp-Source: APXvYqz45wZYr+xYJObGRvEU/ruW0IkRbuAamHnnWi+3R/3sSwJnF6NiNimeicSeNqg9xlFNrUb92g==
X-Received: by 2002:a50:974b:: with SMTP id d11mr76228953edb.24.1564054008153;
        Thu, 25 Jul 2019 04:26:48 -0700 (PDT)
Received: from brauner.io (ip5b40f7ec.dynamic.kabel-deutschland.de. [91.64.247.236])
        by smtp.gmail.com with ESMTPSA id m32sm13387538edc.89.2019.07.25.04.26.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 04:26:47 -0700 (PDT)
Date:   Thu, 25 Jul 2019 13:26:46 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     arnd@arndb.de, "Eric W. Biederman" <ebiederm@xmission.com>,
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
Subject: Re: [PATCH v2 1/2] tests: move common definitions and functions into
 pidfd.h
Message-ID: <20190725112645.m6hushfosm62nfwt@brauner.io>
References: <20190725002204.185225-1-surenb@google.com>
 <CAJuCfpH0OVCjA7ST4dtQ839+gEHKT_T=t-SN=ghPO4ev-GEfYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJuCfpH0OVCjA7ST4dtQ839+gEHKT_T=t-SN=ghPO4ev-GEfYg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 24, 2019 at 05:34:04PM -0700, Suren Baghdasaryan wrote:
> I'm terribly sorry. I forgot to add a link to the original version of

No worries!

> this patch with Christian's comments. It's at:
> https://lore.kernel.org/linux-kselftest/20190723173907.196488-1-surenb@google.com
> and I think I addressed all comments there.
> The patch should apply cleanly to the latest Linus' ToT (v5.3-rc1).
> Thanks,
> Suren.

I'll pick this up.

Thanks!
Christian

> 
> On Wed, Jul 24, 2019 at 5:22 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > Move definitions and functions used across different pidfd tests into
> > pidfd.h header.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  tools/testing/selftests/pidfd/pidfd.h          | 18 ++++++++++++++++++
> >  .../testing/selftests/pidfd/pidfd_open_test.c  |  5 -----
> >  tools/testing/selftests/pidfd/pidfd_test.c     | 10 ----------
> >  3 files changed, 18 insertions(+), 15 deletions(-)
> >
> > diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
> > index 8452e910463f..db4377af6be7 100644
> > --- a/tools/testing/selftests/pidfd/pidfd.h
> > +++ b/tools/testing/selftests/pidfd/pidfd.h
> > @@ -16,6 +16,14 @@
> >
> >  #include "../kselftest.h"
> >
> > +#ifndef __NR_pidfd_open
> > +#define __NR_pidfd_open -1
> > +#endif
> > +
> > +#ifndef __NR_pidfd_send_signal
> > +#define __NR_pidfd_send_signal -1
> > +#endif
> > +
> >  /*
> >   * The kernel reserves 300 pids via RESERVED_PIDS in kernel/pid.c
> >   * That means, when it wraps around any pid < 300 will be skipped.
> > @@ -53,5 +61,15 @@ int wait_for_pid(pid_t pid)
> >         return WEXITSTATUS(status);
> >  }
> >
> > +static inline int sys_pidfd_open(pid_t pid, unsigned int flags)
> > +{
> > +       return syscall(__NR_pidfd_open, pid, flags);
> > +}
> > +
> > +static inline int sys_pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
> > +                                       unsigned int flags)
> > +{
> > +       return syscall(__NR_pidfd_send_signal, pidfd, sig, info, flags);
> > +}
> >
> >  #endif /* __PIDFD_H */
> > diff --git a/tools/testing/selftests/pidfd/pidfd_open_test.c b/tools/testing/selftests/pidfd/pidfd_open_test.c
> > index 0377133dd6dc..b9fe75fc3e51 100644
> > --- a/tools/testing/selftests/pidfd/pidfd_open_test.c
> > +++ b/tools/testing/selftests/pidfd/pidfd_open_test.c
> > @@ -22,11 +22,6 @@
> >  #include "pidfd.h"
> >  #include "../kselftest.h"
> >
> > -static inline int sys_pidfd_open(pid_t pid, unsigned int flags)
> > -{
> > -       return syscall(__NR_pidfd_open, pid, flags);
> > -}
> > -
> >  static int safe_int(const char *numstr, int *converted)
> >  {
> >         char *err = NULL;
> > diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
> > index 7eaa8a3de262..17b2fd621726 100644
> > --- a/tools/testing/selftests/pidfd/pidfd_test.c
> > +++ b/tools/testing/selftests/pidfd/pidfd_test.c
> > @@ -21,10 +21,6 @@
> >  #include "pidfd.h"
> >  #include "../kselftest.h"
> >
> > -#ifndef __NR_pidfd_send_signal
> > -#define __NR_pidfd_send_signal -1
> > -#endif
> > -
> >  #define str(s) _str(s)
> >  #define _str(s) #s
> >  #define CHILD_THREAD_MIN_WAIT 3 /* seconds */
> > @@ -47,12 +43,6 @@ static pid_t pidfd_clone(int flags, int *pidfd, int (*fn)(void *))
> >  #endif
> >  }
> >
> > -static inline int sys_pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
> > -                                       unsigned int flags)
> > -{
> > -       return syscall(__NR_pidfd_send_signal, pidfd, sig, info, flags);
> > -}
> > -
> >  static int signal_received;
> >
> >  static void set_signal_received_on_sigusr1(int sig)
> > --
> > 2.22.0.709.g102302147b-goog
> >
