Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52ECD3EE8E0
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Aug 2021 10:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239136AbhHQIwJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Aug 2021 04:52:09 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:34217 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239349AbhHQIvr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Aug 2021 04:51:47 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MaInF-1mccmC2Ekf-00WEWx; Tue, 17 Aug 2021 10:51:13 +0200
Received: by mail-wr1-f44.google.com with SMTP id u16so10302086wrn.5;
        Tue, 17 Aug 2021 01:51:13 -0700 (PDT)
X-Gm-Message-State: AOAM532RCyQ7ad0IJuH95R9ZM5ZqSjQNUXmeO9E55jg4GQqcjfiCFt/z
        Mtl+KfaInwS9i9VyfcrPLYivejFeD4iRNtaYO3s=
X-Google-Smtp-Source: ABdhPJxy0S3dgbrbB+2nYK7McLmi6W/2RjAdWpCVrlXTpjcij9P5V8Nqaanw785zBrA27G7kE8fatC0nUCf8MIMztug=
X-Received: by 2002:a5d:4b86:: with SMTP id b6mr2726669wrt.286.1629190273176;
 Tue, 17 Aug 2021 01:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210709001328.329716-1-andrealmeid@collabora.com> <20210709001328.329716-3-andrealmeid@collabora.com>
In-Reply-To: <20210709001328.329716-3-andrealmeid@collabora.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 17 Aug 2021 10:50:57 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0MO1qJLRkCH8KrZ3+=L66KOsMRmcbrUvYdMoKykdKoyQ@mail.gmail.com>
Message-ID: <CAK8P3a0MO1qJLRkCH8KrZ3+=L66KOsMRmcbrUvYdMoKykdKoyQ@mail.gmail.com>
Subject: Re: [PATCH v5 02/11] futex2: Implement vectorized wait
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Collabora kernel ML <kernel@collabora.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        pgriffais@valvesoftware.com, z.figura12@gmail.com,
        Joel Fernandes <joel@joelfernandes.org>,
        malteskarupke@fastmail.fm, Linux API <linux-api@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Oskolkov <posk@posk.io>,
        Andrey Semashev <andrey.semashev@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:UISJMkl+IaBsSotgyl9AZQDkgjgU/btUkhlQoMCvDrc2FeOQO++
 DsOC/69f8AAXV5IjbQOXUcsDP22sJQRcNJmIXPjP19dq3At8k7v4Mis8ZCn3VyYJHV9F4Tf
 kMrR7xSmtcTwxYdGPkMdYS2nYmuyh2YwFkuXhjhBvVjrLisEV7xxOmlVoTuBx2LBQSfwkkK
 ClbEeRBgBfk6nJEO6Z/FQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:c0Ovau80hZI=:FTgVn/JcfGlpaD7+Z8o+og
 7uZ4MWCcs3tJhgIM4cEgcRNy0E5PIWHo43uxLgzQ6rsuvxsdbOvz9U3DpDnX1jYN11W6rmkBt
 iO1LlKWUGOYjYe4I1Mny4y6rGfXnhFi9TbSMdZduBJbUd74m0S9LxW3BtoMRnuqerZz2vL9oQ
 RMXoiRA/P1HUxbN0NbCvB3bDIRfGLRRVodN0XtvA6HbSoVKZ07iQTS8A2XC22X49paWV0EpEi
 1FS7ljhHlH3OHPcvDpVVYLW6GgBstPVLrFHC9/1RpzyI585yN13MEobYLojSdkdGw360/zraU
 h7ZGEE9ViP2yUS2dvoXRzT3rTuc/EKrNcXOLutlu2+XZ5s8UjXPvg8nzkgs2G9yCcHlBRgYpz
 +8tOnr8/i4CiZMVzoEQ0c9rPlbk4qpMfjMTSq6EJAExVwjBJqVkI+cgYVo2poNPbKnZLqkfMl
 gKGg912NmkL3oYbj8IspQl625IwIQ/PmgcjUcdLOdTObTGb4cCfxWJX6zHNoWhlhYZH961t5U
 29viLW8tq/a0kqxU7aMYDyHXWJzBDpv/2RoR7nQGNAOrwrkiDzccTlqR0xNtKC2xA1dpKZ2ut
 +9JGdRHxbWL0UXyUI1Sz7yLmRoFofOkDcWNrVAcpD0OB0Ye4pYsKK0Ee8IdJlW5t6qlzj5Zlm
 d3wpAdhAIwcnYkfqFDnoKAE/eDVO2/0yo7Si55yywh1ggopJImTqwdgxwTWL2XDkzG2p8XsDa
 NLqclA/8FJJ6poaey4mt49/wx0o/wabQ9mJM6JN3fU40QBNOTsQ/Q/QDOXwgqOyQexxx6MTc9
 1f+ZJE1DMJX0SvtWIVYviNqrg911TsRkcD1jV3MO9xnup/VnMFimnUpER1mm2HZeGGbR4PlGl
 GaAfn7rx6FuydsTY4nqP5Lf4z58pXbcRZ8l+3fYQYC9Ns1hYdXc+IuVqAaL8ov/xvOMsBq/Q3
 oQq4bH1C4jIH07410vqiKKEDeyVPbDhqHJZBXSoEYdtEccY4dszy1
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 9, 2021 at 2:13 AM André Almeida <andrealmeid@collabora.com> wrote:
>
> Add support to wait on multiple futexes. This is the interface
> implemented by this syscall:
>
> futex_waitv(struct futex_waitv *waiters, unsigned int nr_futexes,
>             unsigned int flags, struct timespec *timo)
>
> struct futex_waitv {
>         __u64 val;
>         void *uaddr;
>         unsigned int flags;
> };

You should generally try to avoid structures with implicit padding
like this one.

>  arch/x86/entry/syscalls/syscall_32.tbl |   1 +
>  arch/x86/entry/syscalls/syscall_64.tbl |   1 +
>  include/linux/compat.h                 |   9 +
>  include/linux/futex.h                  | 108 ++++++--
>  include/uapi/asm-generic/unistd.h      |   4 +-

I would split out the syscall table changes from the implementation, but then
do the table changes for all architectures, at least when you get to a version
that gets close to being accepted.

> +#ifdef CONFIG_COMPAT
> +/**
> + * compat_futex_parse_waitv - Parse a waitv array from userspace
> + * @futexv:    Kernel side list of waiters to be filled
> + * @uwaitv:     Userspace list to be parsed
> + * @nr_futexes: Length of futexv
> + *
> + * Return: Error code on failure, pointer to a prepared futexv otherwise
> + */
> +static int compat_futex_parse_waitv(struct futex_vector *futexv,
> +                                   struct compat_futex_waitv __user *uwaitv,
> +                                   unsigned int nr_futexes)
> +{
> +       struct compat_futex_waitv aux;
> +       unsigned int i;
> +
> +       for (i = 0; i < nr_futexes; i++) {
> +               if (copy_from_user(&aux, &uwaitv[i], sizeof(aux)))
> +                       return -EFAULT;
> +
> +               if ((aux.flags & ~FUTEXV_WAITER_MASK) ||
> +                   (aux.flags & FUTEX_SIZE_MASK) != FUTEX_32)
> +                       return -EINVAL;
> +
> +               futexv[i].w.flags = aux.flags;
> +               futexv[i].w.val = aux.val;
> +               futexv[i].w.uaddr = compat_ptr(aux.uaddr);
> +               futexv[i].q = futex_q_init;
> +       }
> +
> +       return 0;
> +}
> +
> +COMPAT_SYSCALL_DEFINE4(futex_waitv, struct compat_futex_waitv __user *, waiters,
> +                      unsigned int, nr_futexes, unsigned int, flags,
> +                      struct __kernel_timespec __user *, timo)
> +{
> +       struct hrtimer_sleeper to;
> +       struct futex_vector *futexv;
> +       struct timespec64 ts;
> +       ktime_t time;
> +       int ret;

It would be nice to reduce the duplication a little. compat_sys_futex_waitv()
and sys_futex_waitv() only differ by a single line, in which they call
a different
parse function, and the two parse functions only differ in the layout of the
user space structure. The get_timespec64() call already has an
in_compat_syscall() check in it, so I would suggest having a single entry
point for native and compat mode, but either having the parse function
add another such check or making the structure layout compatible.

The normal way of doing this is to have a __u64 value instead of the pointer,
and then using u64_to_uptr() for the conversion. It might be nice to
add a global

typedef __u64 __kernel_uptr_t;

for this purpose.

       Arnd
