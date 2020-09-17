Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422A826E944
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Sep 2020 01:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgIQXJH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Sep 2020 19:09:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49135 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgIQXJH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Sep 2020 19:09:07 -0400
X-Greylist: delayed 1063 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 19:09:05 EDT
Received: from [179.93.159.205] (helo=mussarela)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <cascardo@canonical.com>)
        id 1kJ2kJ-00013f-1k; Thu, 17 Sep 2020 22:51:21 +0000
Date:   Thu, 17 Sep 2020 19:51:00 -0300
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linux-kselftest@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] selftests/seccomp: fix ptrace tests on powerpc
Message-ID: <20200917225100.GG314880@mussarela>
References: <20200630164739.1268222-1-cascardo@canonical.com>
 <202009081505.D9FE52510B@keescook>
 <20200911180637.GI4002@mussarela>
 <875z8hrh2o.fsf@mpe.ellerman.id.au>
 <202009171536.7FACD19@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202009171536.7FACD19@keescook>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 17, 2020 at 03:37:16PM -0700, Kees Cook wrote:
> On Sun, Sep 13, 2020 at 10:34:23PM +1000, Michael Ellerman wrote:
> > Thadeu Lima de Souza Cascardo <cascardo@canonical.com> writes:
> > > On Tue, Sep 08, 2020 at 04:18:17PM -0700, Kees Cook wrote:
> > >> On Tue, Jun 30, 2020 at 01:47:39PM -0300, Thadeu Lima de Souza Cascardo wrote:
> > ...
> > >> > @@ -1809,10 +1818,15 @@ void tracer_ptrace(struct __test_metadata *_metadata, pid_t tracee,
> > >> >  	EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
> > >> >  			: PTRACE_EVENTMSG_SYSCALL_EXIT, msg);
> > >> >  
> > >> > -	if (!entry)
> > >> > +	if (!entry && !syscall_nr)
> > >> >  		return;
> > >> >  
> > >> > -	nr = get_syscall(_metadata, tracee);
> > >> > +	if (entry)
> > >> > +		nr = get_syscall(_metadata, tracee);
> > >> > +	else
> > >> > +		nr = *syscall_nr;
> > >> 
> > >> This is weird? Shouldn't get_syscall() be modified to do the right thing
> > >> here instead of depending on the extra arg?
> > >> 
> > >
> > > R0 might be clobered. Same documentation mentions it as volatile. So, during
> > > syscall exit, we can't tell for sure that R0 will have the original syscall
> > > number. So, we need to grab it during syscall enter, save it somewhere and
> > > reuse it. I used the test context/args for that.
> > 
> > The user r0 (in regs->gpr[0]) shouldn't be clobbered.
> > 
> > But it is modified if the tracer skips the syscall, by setting the
> > syscall number to -1. Or if the tracer changes the syscall number.
> > 
> > So if you need the original syscall number in the exit path then I think
> > you do need to save it at entry.
> 
> ... the selftest code wants to test the updated syscall (-1 or
> whatever), so this sounds correct. Was this test actually failing on
> powerpc? (I'd really rather not split entry/exit if I don't have to.)
> 
> -- 
> Kees Cook

Yes, it started failing when the return code started being changed as well.
Though ptrace can change the syscall at entry (IIRC), it can't change the
return code. And that is part of the ABI. If ppc is changed so it allows
changing the return code during ptrace entry, some strace uses will break. So
that is not an option.

Cascardo.
