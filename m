Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA59227F97
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jul 2020 14:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgGUMGv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Jul 2020 08:06:51 -0400
Received: from foss.arm.com ([217.140.110.172]:38418 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726919AbgGUMGv (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Jul 2020 08:06:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68636D6E;
        Tue, 21 Jul 2020 05:06:50 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.3.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9AF633F66E;
        Tue, 21 Jul 2020 05:06:47 -0700 (PDT)
Date:   Tue, 21 Jul 2020 13:06:41 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, kernel@collabora.com,
        Matthew Wilcox <willy@infradead.org>,
        Paul Gofman <gofmanp@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        will@kernel.org, catalin.marinas@arm.com
Subject: Re: [PATCH v4 1/2] kernel: Implement selective syscall userspace
 redirection
Message-ID: <20200721120516.GA84703@C02TD0UTHF1T.local>
References: <20200716193141.4068476-1-krisman@collabora.com>
 <20200716193141.4068476-2-krisman@collabora.com>
 <CALCETrWdCN5KsRUkrb8VoYGRBhy71P-MAHGWhuJ5y4Z3vByyvg@mail.gmail.com>
 <87wo32j394.fsf@collabora.com>
 <CALCETrUOe=a35rb-o44vLOSHmQ45EuommwoL2quowzw3h+J2gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUOe=a35rb-o44vLOSHmQ45EuommwoL2quowzw3h+J2gg@mail.gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 16, 2020 at 09:48:50PM -0700, Andy Lutomirski wrote:
> On Thu, Jul 16, 2020 at 7:15 PM Gabriel Krisman Bertazi
> <krisman@collabora.com> wrote:
> >
> > Andy Lutomirski <luto@kernel.org> writes:
> >
> > > On Thu, Jul 16, 2020 at 12:31 PM Gabriel Krisman Bertazi
> > > <krisman@collabora.com> wrote:
> > >>
> > >
> > > This is quite nice.  I have a few comments, though:
> > >
> > > You mentioned rt_sigreturn().  Should this automatically exempt the
> > > kernel-provided signal restorer on architectures (e.g. x86_32) that
> > > provide one?
> >
> > That seems reasonable.  Not sure how easy it is to do it, though.
> 
> For better or for worse, it's currently straightforward because the code is:
> 
> __kernel_sigreturn:
> .LSTART_sigreturn:
>         popl %eax               /* XXX does this mean it needs unwind info? */
>         movl $__NR_sigreturn, %eax
>         SYSCALL_ENTER_KERNEL
> 
> and SYSCALL_ENTER_KERNEL is hardwired as int $0x80.  (The latter is
> probably my fault, for better or for worse.)  So this would change to:
> 
> __vdso32_sigreturn_syscall:
>   SYSCALL_ENTER_KERNEL
> 
> and vdso2c would wire up __vdso32_sigreturn_syscall.  Then there would
> be something like:
> 
> bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs);
> 
> and that would be that.  Does anyone have an opinion as to whether
> this is a good idea?  Modern glibc shouldn't be using this mechanism,
> I think, but I won't swear to it.

On arm64 sigreturn is always through the vdso, so IIUC we'd certainly
need something like this. Otherwise it'd be the user's responsibility to
register the vdso sigtramp range when making the prctl, and flip the
selector in each signal handler, which sounds both painful and fragile.

Mark.
