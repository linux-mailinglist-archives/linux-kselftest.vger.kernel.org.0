Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5044366B260
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jan 2023 17:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjAOQDh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Jan 2023 11:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjAOQDF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Jan 2023 11:03:05 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A12B1815A;
        Sun, 15 Jan 2023 08:01:23 -0800 (PST)
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.183.184])
        by gnuweeb.org (Postfix) with ESMTPSA id 5318E7E795;
        Sun, 15 Jan 2023 16:01:10 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1673798473;
        bh=CV1abQ9gGejZbJXQ/TOIyi+DJk5vgSgg0ar02f3kMKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dFsocE8EW0qbhPz0n26OQwMnwu76IzrCvnr4FOc4u5uziFcMMynAhfQ4Zc6w+P4Tr
         aHymi2PXurC5HHVEt2e5UONi/CvZx+IKvg1En8NTgUTJkPH8XxNrFue57W6zpKdujz
         OPx4EcOS+7SUEau5p3KZ4PWQAea576m7P18DipeA9uWIxwNeGzkbsI+UQEZgjjCQ+T
         I9e7XgxNebR5TxGb2jQsDlz6uVGTSGI8eHpu5rEEz9pIhOsjqcjIddLUEIm/hr2/TG
         CBJ1xd+VdLgbkRZB2/NKeoEmOMAMnMWuoALxY2bFHgiAscBhP6/nhAjVcsDiu5XA44
         ors9p4Tsg1y9g==
Date:   Sun, 15 Jan 2023 23:01:06 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Shuah Khan <shuah@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Gilang Fachrezy <gilang4321@gmail.com>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] nolibc signal handling support
Message-ID: <Y8QjQnkPxVyEOxPz@biznet-home.integral.gnuweeb.org>
References: <20230108135904.851762-1-ammar.faizi@intel.com>
 <20230108175842.GB18859@1wt.eu>
 <Y7sL9U1dYkuWJ8rS@biznet-home.integral.gnuweeb.org>
 <20230108184930.GC18859@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230108184930.GC18859@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jan 08, 2023 at 07:49:30PM +0100, Willy Tarreau wrote:
> On Mon, Jan 09, 2023 at 01:31:17AM +0700, Ammar Faizi wrote:
> > I'll be pondering this code this week (to follow what actually the
> > rt_sigaction wants on i386 and arm):
> > 
> >   https://github.com/torvalds/linux/blob/v6.2-rc3/kernel/signal.c#L4404-L4434
> 
> Seems like it could simply be a matter of sigsetsize, which is the
> first one returning -EINVAL.
> 
> > Hopefully, I can get it sorted before the weekend.
> 
> OK!

I couldn't dedicate much time to this, but I looked into it, and here's
my report on the progress. I didn't manage to find a proper solution to
this. But yes, you're right. It's a matter of 'sizeof(sigset_t)'.

So here is my observation. Currently, nolibc's sys.h includes this:

    #include <asm/signal.h>

The definition of 'sigset_t' in that header is: 

    typedef unsigned long sigset_t;

On i386, 'sizeof(unsigned long)' is 4, but on x86-64 it's 8.

That is not the 'sigset_t' that the kernel wants. The kernel wants the
'sigset_t' that is in <asm-generic/signal.h>:

    #define _NSIG       64
    #define _NSIG_BPW   __BITS_PER_LONG      // this 64 on x86-64, but 32 on i386.
    #define _NSIG_WORDS (_NSIG / _NSIG_BPW)

    typedef struct {
        unsigned long sig[_NSIG_WORDS];
    } sigset_t;

The above struct is always 8 bytes in size. In other words:

    _NSIG_WORDS == 2 on i386
    _NSIG_WORDS == 1 on x86-64
    sizeof(unsigned long) == 4 on i386
    sizeof(unsigned long) == 8 on x86-64

Therefore, sizeof(unsigned long [_NSIG_WORDS]) is always 8 on both
architectures. That's the correct size.

I tried to #include <asm-generic/signal.h> but it conflicts with the
other 'sigset_t' definition. So I can't do that.

Why are there two different definitions of 'sigset_t'? I don't know.

I probably should read the story behind this syscall to get it
implemented right. Let me ponder this again on Monday. But at least I
tell what I have found so people can give some comments on it...

-- 
Ammar Faizi

