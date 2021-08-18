Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83803F08E9
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Aug 2021 18:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbhHRQVE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Aug 2021 12:21:04 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42338 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhHRQVE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Aug 2021 12:21:04 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 97D4A1F427CD
Subject: Re: [PATCH v5 02/11] futex2: Implement vectorized wait
To:     Arnd Bergmann <arnd@arndb.de>
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
References: <20210709001328.329716-1-andrealmeid@collabora.com>
 <20210709001328.329716-3-andrealmeid@collabora.com>
 <CAK8P3a0MO1qJLRkCH8KrZ3+=L66KOsMRmcbrUvYdMoKykdKoyQ@mail.gmail.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <d2bfc20e-6ea8-8422-7dee-6687e50f3709@collabora.com>
Date:   Wed, 18 Aug 2021 13:20:16 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0MO1qJLRkCH8KrZ3+=L66KOsMRmcbrUvYdMoKykdKoyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Arnd,

Thank you for your feedback.

Às 05:50 de 17/08/21, Arnd Bergmann escreveu:
> On Fri, Jul 9, 2021 at 2:13 AM André Almeida <andrealmeid@collabora.com> wrote:
>>
>> Add support to wait on multiple futexes. This is the interface
>> implemented by this syscall:
>>
>> futex_waitv(struct futex_waitv *waiters, unsigned int nr_futexes,
>>             unsigned int flags, struct timespec *timo)
>>
>> struct futex_waitv {
>>         __u64 val;
>>         void *uaddr;
>>         unsigned int flags;
>> };
> 
> You should generally try to avoid structures with implicit padding
> like this one.
> 
>>  arch/x86/entry/syscalls/syscall_32.tbl |   1 +
>>  arch/x86/entry/syscalls/syscall_64.tbl |   1 +
>>  include/linux/compat.h                 |   9 +
>>  include/linux/futex.h                  | 108 ++++++--
>>  include/uapi/asm-generic/unistd.h      |   4 +-
> 
> I would split out the syscall table changes from the implementation, but then
> do the table changes for all architectures, at least when you get to a version
> that gets close to being accepted.
> 

Ok, I'll make sure to do that.

>> +#ifdef CONFIG_COMPAT
>> +/**
>> + * compat_futex_parse_waitv - Parse a waitv array from userspace
>> + * @futexv:    Kernel side list of waiters to be filled
>> + * @uwaitv:     Userspace list to be parsed
>> + * @nr_futexes: Length of futexv
>> + *
>> + * Return: Error code on failure, pointer to a prepared futexv otherwise
>> + */
>> +static int compat_futex_parse_waitv(struct futex_vector *futexv,
>> +                                   struct compat_futex_waitv __user *uwaitv,
>> +                                   unsigned int nr_futexes)
>> +{
>> +       struct compat_futex_waitv aux;
>> +       unsigned int i;
>> +
>> +       for (i = 0; i < nr_futexes; i++) {
>> +               if (copy_from_user(&aux, &uwaitv[i], sizeof(aux)))
>> +                       return -EFAULT;
>> +
>> +               if ((aux.flags & ~FUTEXV_WAITER_MASK) ||
>> +                   (aux.flags & FUTEX_SIZE_MASK) != FUTEX_32)
>> +                       return -EINVAL;
>> +
>> +               futexv[i].w.flags = aux.flags;
>> +               futexv[i].w.val = aux.val;
>> +               futexv[i].w.uaddr = compat_ptr(aux.uaddr);
>> +               futexv[i].q = futex_q_init;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +COMPAT_SYSCALL_DEFINE4(futex_waitv, struct compat_futex_waitv __user *, waiters,
>> +                      unsigned int, nr_futexes, unsigned int, flags,
>> +                      struct __kernel_timespec __user *, timo)
>> +{
>> +       struct hrtimer_sleeper to;
>> +       struct futex_vector *futexv;
>> +       struct timespec64 ts;
>> +       ktime_t time;
>> +       int ret;
> 
> It would be nice to reduce the duplication a little. compat_sys_futex_waitv()
> and sys_futex_waitv() only differ by a single line, in which they call
> a different
> parse function, and the two parse functions only differ in the layout of the
> user space structure. The get_timespec64() call already has an
> in_compat_syscall() check in it, so I would suggest having a single entry
> point for native and compat mode, but either having the parse function
> add another such check or making the structure layout compatible.
> 
> The normal way of doing this is to have a __u64 value instead of the pointer,
> and then using u64_to_uptr() for the conversion. It might be nice to
> add a global
> 
> typedef __u64 __kernel_uptr_t;
> 
> for this purpose.
> 

You're right, I could save a lot of lines doing that. I wasn't aware
that get_timespec64() was "compat-aware". I'll apply those changes for
my next version.

>        Arnd
> 
