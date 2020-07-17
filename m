Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04FDA22329F
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jul 2020 06:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgGQEtE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Jul 2020 00:49:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbgGQEtE (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Jul 2020 00:49:04 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FC5F20759
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Jul 2020 04:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594961343;
        bh=L8lqW9YWkE3hJz0DUPCXPBOUMOfpaEoI1neX+lDtyvg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=z+rxNg5B7H9LBiuCEGSsYkwL9ZF4xQttstyNOv5daewr6uRVvV0RTLNULbosy1E9N
         Vhu5hMpGIe1oZVg3fh4HYZG85X2rKvhv0B8b0BzkagdSZSIQEkWUvdZylWNngfYD+x
         bcy8bAPyvAY6E0fcQPXj1THHopL4WDv956NUyA3Y=
Received: by mail-wr1-f51.google.com with SMTP id f7so9652002wrw.1
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jul 2020 21:49:03 -0700 (PDT)
X-Gm-Message-State: AOAM530bLuDUlCX9ICzD5h7PK7CaaUfJaEb/deyJg/Wh9iN83B5/RJvk
        aRbPFYhFlnRlY9levAjI3cGSRr4V4XQJQl0tf2ruSA==
X-Google-Smtp-Source: ABdhPJzQESTGfxYiW9og3fovzkL8ddBdcbKVxaRNke/i3V8sGRfmoTqbfEkdzzQ6x54hKLx40ei42WzpRDA0hhz0RHM=
X-Received: by 2002:adf:f707:: with SMTP id r7mr8291178wrp.70.1594961341827;
 Thu, 16 Jul 2020 21:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200716193141.4068476-1-krisman@collabora.com>
 <20200716193141.4068476-2-krisman@collabora.com> <CALCETrWdCN5KsRUkrb8VoYGRBhy71P-MAHGWhuJ5y4Z3vByyvg@mail.gmail.com>
 <87wo32j394.fsf@collabora.com>
In-Reply-To: <87wo32j394.fsf@collabora.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 16 Jul 2020 21:48:50 -0700
X-Gmail-Original-Message-ID: <CALCETrUOe=a35rb-o44vLOSHmQ45EuommwoL2quowzw3h+J2gg@mail.gmail.com>
Message-ID: <CALCETrUOe=a35rb-o44vLOSHmQ45EuommwoL2quowzw3h+J2gg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] kernel: Implement selective syscall userspace redirection
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, kernel@collabora.com,
        Matthew Wilcox <willy@infradead.org>,
        Paul Gofman <gofmanp@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 16, 2020 at 7:15 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Andy Lutomirski <luto@kernel.org> writes:
>
> > On Thu, Jul 16, 2020 at 12:31 PM Gabriel Krisman Bertazi
> > <krisman@collabora.com> wrote:
> >>
> >
> > This is quite nice.  I have a few comments, though:
> >
> > You mentioned rt_sigreturn().  Should this automatically exempt the
> > kernel-provided signal restorer on architectures (e.g. x86_32) that
> > provide one?
>
> That seems reasonable.  Not sure how easy it is to do it, though.

For better or for worse, it's currently straightforward because the code is:

__kernel_sigreturn:
.LSTART_sigreturn:
        popl %eax               /* XXX does this mean it needs unwind info? */
        movl $__NR_sigreturn, %eax
        SYSCALL_ENTER_KERNEL

and SYSCALL_ENTER_KERNEL is hardwired as int $0x80.  (The latter is
probably my fault, for better or for worse.)  So this would change to:

__vdso32_sigreturn_syscall:
  SYSCALL_ENTER_KERNEL

and vdso2c would wire up __vdso32_sigreturn_syscall.  Then there would
be something like:

bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs);

and that would be that.  Does anyone have an opinion as to whether
this is a good idea?  Modern glibc shouldn't be using this mechanism,
I think, but I won't swear to it.

>
> > The amount of syscall entry wiring that arches need to do is IMO
> > already a bit out of hand.  Should we instead rename TIF_SECCOMP to
> > TIF_SYSCALL_INTERCEPTION and have one generic callback that handles
> > seccomp and this new thing?
>
> Considering the previous suggestion from Kees to hide it inside the
> tracehook and Thomas rework of this path, I'm not sure what is the best
> solution here, but some rework of these flags is due.  Thomas suggested
> expanding these flags to 64 bits and having some arch specific and
> arch-agnostic flags.  With the storage expansion and arch-agnostic flags,
> would this still be desirable?

I think it would be desirable to consolidate this to avoid having
multiple arches need to separately wire up all of these mechanisms.
I'm not sure that the initial upstream implementation needs this, but
it might be nice to support this out of the box on all arches with
seccomp support.

>
> >> +int do_syscall_user_dispatch(struct pt_regs *regs)
> >> +{
> >> +       struct syscall_user_dispatch *sd = &current->syscall_dispatch;
> >> +       unsigned long ip = instruction_pointer(regs);
> >> +       char state;
> >> +
> >> +       if (likely(ip >= sd->dispatcher_start && ip <= sd->dispatcher_end))
> >> +               return 0;
> >> +
> >> +       if (likely(sd->selector)) {
> >> +               if (unlikely(__get_user(state, sd->selector)))
> >> +                       do_exit(SIGSEGV);
> >> +
> >> +               if (likely(state == 0))
> >> +                       return 0;
> >> +
> >> +               if (state != 1)
> >> +                       do_exit(SIGSEGV);
> >
> > This seems a bit extreme and hard to debug if it ever happens.
>
> Makes sense, but I don't see a better way to return the error here.
> Maybe a SIGSYS with a different si_errno?  Alternatively, we could
> revert to the previous behavior of allowing syscalls on state != 0, that
> existed in v1.  What do you think?
>

I don't have a strong opinion.  SIGSYS with different si_errno is
probably reasonable.

--Andy
