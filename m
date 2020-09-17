Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA2C26E900
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Sep 2020 00:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgIQWhT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Sep 2020 18:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgIQWhT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Sep 2020 18:37:19 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5753C06174A
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Sep 2020 15:37:18 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id y1so2212212pgk.8
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Sep 2020 15:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rajz9PikgG3gC9n3hSwih8axQBgiqMcr2MSEy5EC2hE=;
        b=IKgCm7fprYE6guOBHaJ8b25mZYLlrvPk/VPKlASuNTsk3thWY4WBG1wbQ0I4h4kqt8
         n5lD/FeK/AD1anZIuSvxXr4jBDpDRzPXi5mBvjvtLegI/Nn8IIAub08KWyFywx3KhhO8
         5gvh2rLj0oWFfxECWCQCIOKizX9I7hK+h3BB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rajz9PikgG3gC9n3hSwih8axQBgiqMcr2MSEy5EC2hE=;
        b=uB+3O7lDfyxYGgDWnAs7rN3YTa1q1KK1tJbxXB9x2dd7W4cjdHLoqIdmSbqe9Wmjvb
         GDvdq1VaiSd3fsg4SQ7/cE9cLK0eqgH/oM0+AUwEBDthA82ivxZZL2pqtHPrAXPN7+QG
         KzaDDB2wwg0euJceHX+FOY91WdLGQKTU0/4DuyTz8CmKjR55LsfjnEL8fTtuoNz3oF3P
         LR46tSz0Z7QKS/Af7YhBCAZAH6YFnhn6BGEGq90TPpzgBFAj3qLNomLOUuWRdRQ5zNMA
         whhzsRxZuz6dHiawRCDA/p+i5JUBqaM8Owwd3tGBvEvq19/ZCBHVipInvIm/BsYgkrJj
         +myA==
X-Gm-Message-State: AOAM531optfj27ThBehZ5WDtDp47LHm8Sfw3GrKqqwzXVTzvvK5AGNM8
        HtW5oaxm0ph7Du3BorRgnbfn5Q==
X-Google-Smtp-Source: ABdhPJwzlNUESDRWjOLfnSZtOQ0cDxcX2YDZYAgm6TunzxQqiCRXbQqtcdHWkb5mLwZFRGGL0Tbp9g==
X-Received: by 2002:a63:3856:: with SMTP id h22mr4241223pgn.451.1600382238308;
        Thu, 17 Sep 2020 15:37:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id fs24sm652250pjb.8.2020.09.17.15.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 15:37:17 -0700 (PDT)
Date:   Thu, 17 Sep 2020 15:37:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        linux-kselftest@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] selftests/seccomp: fix ptrace tests on powerpc
Message-ID: <202009171536.7FACD19@keescook>
References: <20200630164739.1268222-1-cascardo@canonical.com>
 <202009081505.D9FE52510B@keescook>
 <20200911180637.GI4002@mussarela>
 <875z8hrh2o.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875z8hrh2o.fsf@mpe.ellerman.id.au>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Sep 13, 2020 at 10:34:23PM +1000, Michael Ellerman wrote:
> Thadeu Lima de Souza Cascardo <cascardo@canonical.com> writes:
> > On Tue, Sep 08, 2020 at 04:18:17PM -0700, Kees Cook wrote:
> >> On Tue, Jun 30, 2020 at 01:47:39PM -0300, Thadeu Lima de Souza Cascardo wrote:
> ...
> >> > @@ -1809,10 +1818,15 @@ void tracer_ptrace(struct __test_metadata *_metadata, pid_t tracee,
> >> >  	EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
> >> >  			: PTRACE_EVENTMSG_SYSCALL_EXIT, msg);
> >> >  
> >> > -	if (!entry)
> >> > +	if (!entry && !syscall_nr)
> >> >  		return;
> >> >  
> >> > -	nr = get_syscall(_metadata, tracee);
> >> > +	if (entry)
> >> > +		nr = get_syscall(_metadata, tracee);
> >> > +	else
> >> > +		nr = *syscall_nr;
> >> 
> >> This is weird? Shouldn't get_syscall() be modified to do the right thing
> >> here instead of depending on the extra arg?
> >> 
> >
> > R0 might be clobered. Same documentation mentions it as volatile. So, during
> > syscall exit, we can't tell for sure that R0 will have the original syscall
> > number. So, we need to grab it during syscall enter, save it somewhere and
> > reuse it. I used the test context/args for that.
> 
> The user r0 (in regs->gpr[0]) shouldn't be clobbered.
> 
> But it is modified if the tracer skips the syscall, by setting the
> syscall number to -1. Or if the tracer changes the syscall number.
> 
> So if you need the original syscall number in the exit path then I think
> you do need to save it at entry.

... the selftest code wants to test the updated syscall (-1 or
whatever), so this sounds correct. Was this test actually failing on
powerpc? (I'd really rather not split entry/exit if I don't have to.)

-- 
Kees Cook
