Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748D9260585
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Sep 2020 22:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbgIGUUm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Sep 2020 16:20:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728834AbgIGUUh (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Sep 2020 16:20:37 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBDB6215A4
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Sep 2020 20:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599510037;
        bh=uluieRHjASDijcIFo7gCF077dVcN0frnZrCkAriLSJ8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GJi1QjE/YfZNlkfZqazyPBchYHM89L/Ib8IKW/Eia/680VU0lYlG8ekUz/yktHgPk
         cu72Ky/O8tcJD9o6KawiqA0EVgH1KZECifj9Csvsh6KqFLhUTeo6fkIg7zyOIfxIhx
         AbYxFH1xbqJFjwkQBHg2Go2Razg0mEfL5JgDn6dI=
Received: by mail-wr1-f54.google.com with SMTP id c15so16851983wrs.11
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Sep 2020 13:20:36 -0700 (PDT)
X-Gm-Message-State: AOAM533u2kpioIiYPbb3rpbavTXv23m+ZrW2apU9N/eSqCpcPT4MkzcK
        xS0reECTOHMQUExrCOGcLKxzkXxO9k7CKnoiZHmnOQ==
X-Google-Smtp-Source: ABdhPJzhGTkslezk1jKgM4Z8egHoJMRpDSYgL+Hvr6rrEgC/Tq2OEQ3SAkb2T4jpoLviDEx/3tlo2KLQdnQeaVjVbwA=
X-Received: by 2002:adf:db88:: with SMTP id u8mr23050764wri.184.1599510035328;
 Mon, 07 Sep 2020 13:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200907101522.zo6qzgp4qfzkz7cs@wittgenstein> <0639209E-B6C6-4F86-84F4-04B91E1CC8AA@amacapital.net>
 <20200907142510.klojh2urwyui23ox@wittgenstein>
In-Reply-To: <20200907142510.klojh2urwyui23ox@wittgenstein>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 7 Sep 2020 13:20:23 -0700
X-Gmail-Original-Message-ID: <CALCETrUaAy7uU9jjneC9+ft-TtS+SuyWXxMCCE5dmcth3N4rHw@mail.gmail.com>
Message-ID: <CALCETrUaAy7uU9jjneC9+ft-TtS+SuyWXxMCCE5dmcth3N4rHw@mail.gmail.com>
Subject: Re: [PATCH v6 6/9] kernel: entry: Support Syscall User Dispatch for
 common syscall entry
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 7, 2020 at 7:25 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Mon, Sep 07, 2020 at 07:15:52AM -0700, Andy Lutomirski wrote:
> >
> >
> > > On Sep 7, 2020, at 3:15 AM, Christian Brauner <christian.brauner@ubun=
tu.com> wrote:
> > >
> > > =EF=BB=BFOn Fri, Sep 04, 2020 at 04:31:44PM -0400, Gabriel Krisman Be=
rtazi wrote:
> > >> Syscall User Dispatch (SUD) must take precedence over seccomp, since=
 the
> > >> use case is emulation (it can be invoked with a different ABI) such =
that
> > >> seccomp filtering by syscall number doesn't make sense in the first
> > >> place.  In addition, either the syscall is dispatched back to usersp=
ace,
> > >> in which case there is no resource for seccomp to protect, or the
> > >
> > > Tbh, I'm torn here. I'm not a super clever attacker but it feels to m=
e
> > > that this is still at least a clever way to circumvent a seccomp
> > > sandbox.
> > > If I'd be confined by a seccomp profile that would cause me to be
> > > SIGKILLed when I try do open() I could prctl() myself to do user
> > > dispatch to prevent that from happening, no?
> > >
> >
> > Not really, I think. The idea is that you didn=E2=80=99t actually do op=
en().
> > You did a SYSCALL instruction which meant something else, and the
> > syscall dispatch correctly prevented the kernel from misinterpreting
> > it as open().
>
> Right, for the case where you're e.g. emulating windows syscalls that's
> true. I was thinking when you're running natively on Linux: couldn't I
> first load a seccomp profile "kill me if someone does an open()", then
> I exec() the target binary and that binary is setup to do
> prctl(USER_DISPATCH) first thing. I guess, it's ok because as far as I
> had time to read it this is a nothing or all mechanism, i.e. _all_
> system calls are re-routed in contrast to e.g. seccomp where I could do
> this per-syscall. So for user-dispatch it wouldn't make sense to use it
> on Linux per se. Still makes me a little uneasy. :)

There's an escape hatch, so processes using this can still make syscalls.

Maybe think about it another way: a process using user dispatch should
definitely *not* trigger seccomp user notifiers, errno returns, or
ptrace events, since they'll all do the wrong thing.  IMO RET_KILL is
the same.

Barring some very severe defect, there's no way a program can use user
dispatch to escape seccomp -- a program could use user dispatch to
allow them to do:

mov $__NR_open, %rax
syscall

without dying despite the presence of a filter that would kill the
process if it tried to do open(), but this doesn't bypass the filter
at all.  The process could just as easily have done:

mov $__NR_open
jmp magic_stub(%rip)

without tripping the filter, since no system call actually happens here.

--Andy
