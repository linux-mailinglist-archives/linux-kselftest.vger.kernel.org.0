Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6BF77B9C8
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 15:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjHNNWr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 09:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjHNNWe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 09:22:34 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B8C5E77;
        Mon, 14 Aug 2023 06:22:31 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 37EDM8bS019276;
        Mon, 14 Aug 2023 15:22:08 +0200
Date:   Mon, 14 Aug 2023 15:22:08 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "'Zhangjin Wu'" <falcon@tinylab.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "thomas@t-8ch.de" <thomas@t-8ch.de>
Subject: Re: [PATCH v5] tools/nolibc: fix up size inflate regression
Message-ID: <20230814132208.GC18837@1wt.eu>
References: <20230814082224.GA16761@1wt.eu>
 <20230814104226.7094-1-falcon@tinylab.org>
 <6fef903020954515abdcee7261918903@AcuMS.aculab.com>
 <20230814120941.GA18837@1wt.eu>
 <e3a6bd5b7a4d4ac2bccbaac21e0fc1a0@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3a6bd5b7a4d4ac2bccbaac21e0fc1a0@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 14, 2023 at 12:27:48PM +0000, David Laight wrote:
> From: Willy Tarreau
> > Sent: 14 August 2023 13:10
> > 
> > Hi David,
> > 
> > On Mon, Aug 14, 2023 at 11:15:51AM +0000, David Laight wrote:
> > > From: Zhangjin Wu
> > > > Sent: 14 August 2023 11:42
> > > ...
> > > > [...]
> > > > > > > Sure it's not pretty, and I'd rather just go back to SET_ERRNO() to be
> > > > > > > honest, because we're there just because of the temptation to remove
> > > > > > > lines that were not causing any difficulties :-/
> > > > > > >
> > > > > > > I think we can do something in-between and deal only with signed returns,
> > > > > > > and explicitly place the test for MAX_ERRNO on the two unsigned ones
> > > > > > > (brk and mmap). It should look approximately like this:
> > > > > > >
> > > > > > >  #define __sysret(arg)                                                \
> > > > > > >  ({                                                                   \
> > > > > > >  	__typeof__(arg) __sysret_arg = (arg);                           \
> > > > > > >  	(__sysret_arg < 0) ? ({           /* error ? */                 \
> > > > > > >  		SET_ERRNO(-__sysret_arg); /* yes: errno != -ret */      \
> > > > > > >  		((__typeof__(arg)) -1);   /*      return -1 */          \
> > >
> > > I'm pretty sure you don't need the explicit cast.
> > > (It would be needed for a pointer type.)
> > > Can you use __arg < ? SET_ERRNO(-__arg), -1 : __arg
> > >
> > > Thinking, maybe it should be:
> > >
> > > #define __sysret(syscall_fn_args)
> > > ({
> > > 	__typeof__(syscall_fn_args) __rval = syscall_fn_args;
> > > 	__rval >= 0 ? __rval : SET_ERRNO(-__rval), -1;
> > > })
> > 
> > Yeah almost, since arg is necessarily signed in this version, it's
> > just that I manually edited the previous macro in the mail and limited
> > the amount of changes to what was necessary. It's just that SET_ERRNO
> > only is an instruction, not an expression:
> > 
> >    #define SET_ERRNO(v) do { errno = (v); } while (0)
> > 
> > Thus the return value doesn't even pass through it. That's why it was
> > so much simpler before. The rationale behind this was to bring the
> > ability to completely drop errno for programs where you didn't care
> > about it. It's particularly interesting when you don't need any other
> > data either as the program gets strunk from a complete section.
> 
> Actually something like:
> 
> #define SET_ERRNO(v) (errno = -(long)(v), __typeof__(v)-1)
> 
> seems to work and allows the errno assignment be removed.
> Also works for pointer types (after a different compare).

Yes, that's something we can do (with the parenthesis around
__typeof__(v) though).

> A quick check with godbolt doesn't show any sign extensions happening.

I agree there's none here. 

Willy
