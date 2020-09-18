Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C587326F5D6
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Sep 2020 08:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgIRGWi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Sep 2020 02:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgIRGWi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Sep 2020 02:22:38 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177F5C06174A
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Sep 2020 23:22:38 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Bt3fL2Pwyz9sRR;
        Fri, 18 Sep 2020 16:22:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1600410154;
        bh=APF+Hu9MA5D4HnG4laKM+f7u7SvD7NRYuT//39Fs6VQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=l7dNtbkM9rdm64fN3MmtDmKbUJqqvo0XqjGPRY26OL/JuHsWcWAlU+fdVo9xHrHxR
         caKYIUL9BQg7CZQRu3ZxFtppBVoehgNzeHtHE8TpT95SV3M/T7SLVcAq6TW3wW5rqq
         dTAUGu3j0ue7ItvpsE6ERycHGQSWthnScq0Y+cte/bB+gJufIcwj8OQG9BknS5z/h4
         yUTALq2hbVNaQsWK0QW/kSxY//EkirQ7SA8bG5s/Iy1LHP7cr7TX947UBgh2LkCJbZ
         fbmJEMNRZur46nOD0pNayZUFMWdSq3EHlgf3jfGFg9f3Jd1sFexgRhz1+MoRu/nLi0
         sJFYRAP0mGe4g==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kselftest@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] selftests/seccomp: fix ptrace tests on powerpc
In-Reply-To: <20200917225100.GG314880@mussarela>
References: <20200630164739.1268222-1-cascardo@canonical.com> <202009081505.D9FE52510B@keescook> <20200911180637.GI4002@mussarela> <875z8hrh2o.fsf@mpe.ellerman.id.au> <202009171536.7FACD19@keescook> <20200917225100.GG314880@mussarela>
Date:   Fri, 18 Sep 2020 16:22:31 +1000
Message-ID: <87imcbob88.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Thadeu Lima de Souza Cascardo <cascardo@canonical.com> writes:
> On Thu, Sep 17, 2020 at 03:37:16PM -0700, Kees Cook wrote:
>> On Sun, Sep 13, 2020 at 10:34:23PM +1000, Michael Ellerman wrote:
>> > Thadeu Lima de Souza Cascardo <cascardo@canonical.com> writes:
>> > > On Tue, Sep 08, 2020 at 04:18:17PM -0700, Kees Cook wrote:
>> > >> On Tue, Jun 30, 2020 at 01:47:39PM -0300, Thadeu Lima de Souza Cascardo wrote:
>> > ...
>> > >> > @@ -1809,10 +1818,15 @@ void tracer_ptrace(struct __test_metadata *_metadata, pid_t tracee,
>> > >> >  	EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
>> > >> >  			: PTRACE_EVENTMSG_SYSCALL_EXIT, msg);
>> > >> >  
>> > >> > -	if (!entry)
>> > >> > +	if (!entry && !syscall_nr)
>> > >> >  		return;
>> > >> >  
>> > >> > -	nr = get_syscall(_metadata, tracee);
>> > >> > +	if (entry)
>> > >> > +		nr = get_syscall(_metadata, tracee);
>> > >> > +	else
>> > >> > +		nr = *syscall_nr;
>> > >> 
>> > >> This is weird? Shouldn't get_syscall() be modified to do the right thing
>> > >> here instead of depending on the extra arg?
>> > >> 
>> > >
>> > > R0 might be clobered. Same documentation mentions it as volatile. So, during
>> > > syscall exit, we can't tell for sure that R0 will have the original syscall
>> > > number. So, we need to grab it during syscall enter, save it somewhere and
>> > > reuse it. I used the test context/args for that.
>> > 
>> > The user r0 (in regs->gpr[0]) shouldn't be clobbered.
>> > 
>> > But it is modified if the tracer skips the syscall, by setting the
>> > syscall number to -1. Or if the tracer changes the syscall number.
>> > 
>> > So if you need the original syscall number in the exit path then I think
>> > you do need to save it at entry.
>> 
>> ... the selftest code wants to test the updated syscall (-1 or
>> whatever), so this sounds correct. Was this test actually failing on
>> powerpc? (I'd really rather not split entry/exit if I don't have to.)
>
> Yes, it started failing when the return code started being changed as well.
> Though ptrace can change the syscall at entry (IIRC), it can't change the
> return code. And that is part of the ABI. If ppc is changed so it allows
> changing the return code during ptrace entry, some strace uses will break. So
> that is not an option.

Yep.

I don't know that it would break anything to change that part of the
ptrace ABI, but it definitely could break things and it would be subtle,
so it's not really an option.

So for powerpc we do need the return code change done in the exit hook,
sorry.

cheers
