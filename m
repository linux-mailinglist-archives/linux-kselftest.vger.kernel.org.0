Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDE07A3503
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Sep 2023 11:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbjIQJtW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 17 Sep 2023 05:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236387AbjIQJtA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 17 Sep 2023 05:49:00 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E6E7193;
        Sun, 17 Sep 2023 02:48:49 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 38H9mRSk011095;
        Sun, 17 Sep 2023 11:48:27 +0200
Date:   Sun, 17 Sep 2023 11:48:27 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/4] tools/nolibc: avoid unused parameter warnings for
 ENOSYS fallbacks
Message-ID: <20230917094827.GA11081@1wt.eu>
References: <20230914-nolibc-syscall-nr-v1-0-e50df410da11@weissschuh.net>
 <20230914-nolibc-syscall-nr-v1-2-e50df410da11@weissschuh.net>
 <20230917025851.GE9646@1wt.eu>
 <2bd688b7-5f1b-44ca-a41b-6e90dc3e8557@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2bd688b7-5f1b-44ca-a41b-6e90dc3e8557@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Sep 17, 2023 at 07:49:57AM +0200, Thomas Weißschuh wrote:
> On 2023-09-17 04:58:51+0200, Willy Tarreau wrote:
> > On Thu, Sep 14, 2023 at 06:01:18PM +0200, Thomas Weißschuh wrote:
> > > The ENOSYS fallback code does not use its functions parameters.
> > > This can lead to compiler warnings about unused parameters.
> > > 
> > > Explicitly avoid these warnings.
> > 
> > Just out of curiosity, did you find a valid case for enabling this
> > warning or were you trying various combinations ? I'm asking because
> > I've never seen it enabled anywhere given that it's probably the most 
> > useless and unusable warning: as soon as you're dealing with function
> > pointers, you start to have multiple functions with a similar
> > prototype, some of which just don't need certain arguments, and the
> > only way to shut the warning is to significantly uglify the code.
> 
> nolibc-test uses it currently and I also used it in some projects.

OK then let's handle it.

> >   @@ -934,6 +960,11 @@ int sys_select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeva
> >    #endif
> >    	return my_syscall5(__NR__newselect, nfds, rfds, wfds, efds, timeout);
> >    #else
> >   +	return no_syscall5(nfds, rfds, wfds, efds, timeout);
> >   -	return -ENOSYS;
> >    #endif
> > 
> > What do you think ?
> 
> The idea sounds good. But "no_syscall5" sounds a bit non-obvious to me.

Of course, I was just trying to illustrate. I'm never good at giving
names.

> Maybe the macro-equivalent of this?
> 
> static inline int __nolibc_enosys(...)
> {
> 	return -ENOSYS;
> }
> 
> The only-vararg function unfortunately needs C23 so we can't use it.
>
> It's clear to the users that this is about ENOSYS and we don't need a
> bunch of new macros similar.

I like it, I didn't think about varargs, it's an excellent idea! Let's
just do simpler, start with a first arg "syscall_num" that we may later
reuse for debugging, and just mark this one unused:

  static inline int __nolibc_enosys(int syscall_num, ...)
  {
	(void)syscall_num;
  	return -ENOSYS;
  }

Willy
