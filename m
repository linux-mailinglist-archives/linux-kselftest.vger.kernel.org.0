Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEC37252A6
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 06:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240422AbjFGEFo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 00:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240903AbjFGEF2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 00:05:28 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75F3419B9;
        Tue,  6 Jun 2023 21:05:23 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3574515M030733;
        Wed, 7 Jun 2023 06:05:01 +0200
Date:   Wed, 7 Jun 2023 06:05:01 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     thomas@t-8ch.de, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 4/4] tools/nolibc: sys.h: apply __syscall() helper
Message-ID: <ZIAB7bFYegCuXT9g@1wt.eu>
References: <7e76f099-4198-421c-8157-430201970c4c@t-8ch.de>
 <20230607003406.559638-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607003406.559638-1-falcon@tinylab.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On Wed, Jun 07, 2023 at 08:34:06AM +0800, Zhangjin Wu wrote:
> > Hi Zhangjin,
> > 
> > On 2023-06-06 16:17:38+0800, Zhangjin Wu wrote:
> > > Use __syscall() helper to shrink 252 lines of code.
> > > 
> > >     $ git show HEAD^:tools/include/nolibc/sys.h | wc -l
> > >     1425
> > >     $ git show HEAD:tools/include/nolibc/sys.h | wc -l
> > >     1173
> > >     $ echo "1425-1173" | bc -l
> > >     252
> > > 
> > > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > > ---
> > >  tools/include/nolibc/sys.h | 336 +++++--------------------------------
> > >  1 file changed, 42 insertions(+), 294 deletions(-)
> > > 
> > > diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> > > index f6e3168b3e50..0cfc5157845a 100644
> > > --- a/tools/include/nolibc/sys.h
> > > +++ b/tools/include/nolibc/sys.h
> > > @@ -108,13 +108,7 @@ int sys_chdir(const char *path)
> > >  static __attribute__((unused))
> > >  int chdir(const char *path)
> > >  {
> > > -	int ret = sys_chdir(path);
> > > -
> > > -	if (ret < 0) {
> > > -		SET_ERRNO(-ret);
> > > -		ret = -1;
> > > -	}
> > > -	return ret;
> > > +	return __syscall(chdir, path);
> > 
> > To be honest I'm still not a big fan of the __syscall macro.
> > It's a bit too magic for too little gain.
> > 
> > The commit message argues that the patches make the code shorter.
> > 
> > However doing 
> > 
> > __sysret(sys_chdir(path));
> > 
> > instead of
> > 
> > __syscall(chdir, path);
> > 
> > is only three characters longer and the same amout of lines.
> >
> 
> Yeah, I do like your version too, it looks consise too, the only not
> comfortable part is there are dual calls in one line.

For those who want to debug, having less macros or magic stuff is always
better, and in this essence I too find that Thomas' version is more
expressive about what is being done. Also, if some syscalls require a
specific handling (e.g. mmap() needs to return MAP_FAILED instead), it's
much easier to change only the code dealing with the return value and
errno setting than having to guess how to reimplement what was magically
done in a macro.

> > Otherwise we would have syscall() _syscall() and __syscall() each doing
> > different things.
> >
> 
> Yes, I'm worried about this too, although the compilers may help a
> little, but it is too later.

The issue is for the person who remembers "I need to use 'syscall'" but
never remembering the number of underscores nor the variations.

> Just brain storming, What about another non-similar name, for example,
> __syswrap() or __sysin() ?
> 
> Or even convert __sysret() to __sysout() and __syscall() to __sysin(),
> do you like it? or even __sysexit(), __sysentry(), but the __sysexit()
> may be misused with sys_exit().

I'd rather use "__set_errno()" to explicitly mention that it's only
used to set errno, but sysret would be fine as well IMHO as if we're
purist, it also normalizes the return value.

>     /* Syscall return helper, set errno as -ret when ret < 0 */
>     static __inline__ __attribute__((unused, always_inline))
>     long __sysout(long ret)
>     {
>     	if (ret < 0) {
>     		SET_ERRNO(-ret);
>     		ret = -1;
>     	}
>     	return ret;
>     }
>     
>     /* Syscall call helper, use syscall name instead of syscall number */
>     #define __sysin(name, ...) __sysout(sys_##name(__VA_ARGS__))
> 
>     static __attribute__((unused))
>     int brk(void *addr)
>     {
>     	return __sysout(sys_brk(addr) ? 0 : -ENOMEM);
>     }
> 
>     static __attribute__((unused))
>     int chdir(const char *path)
>     {
>     	return __sysin(chdir, path);
>     }

I still don't find this intuitive at all.

> If we really want something like __syscall()/__sysret(), I do think they
> should be a pair ;-)

Then one being called "call" while the other one being "ret" do form a
pair, no ?

Thanks,
Willy
