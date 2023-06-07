Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A34725377
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 07:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjFGFjk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 01:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbjFGFjj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 01:39:39 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF3119AE;
        Tue,  6 Jun 2023 22:39:34 -0700 (PDT)
X-QQ-mid: bizesmtp83t1686116362t3310e0v
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 07 Jun 2023 13:39:20 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: pQPC2yl/OPKHnEh0fu3Xx+jOViHnsOolz5ZP698W9YEzxBo2d2Sj6Ako9agp4
        HhQVLy0P7NcbJ7WM0j4C3bDh/L8eXj+GG1DSBNrSLdzg2dKC+5AVjps/hs2AZ3xvav4rrzn
        +uqbh8unqZcF3L3nLpALMjPc3b8Rd5uKcGNjAlWKL3X4fOx3z7GUDvl+JPaRAfjDuOPGY3x
        CvKdR2AIXZC4lIVJ6zxzCagzEnKLVbtSjFO1nLsguI7TD1LSLS6Q/H2DvhyTt289oT5S59m
        WnfHrmKJBe/9JCs5ANlhvxI39JeQN+OpjK1iZUTr2XAKVYRBVhpfTMiKlL1YpWC9Vh0GVok
        CvhcpaK8f8l3eZIlic8EbIV8Y6mYv60VyZRxr8L/jKdbMZ0l9PWr2/WJa96AJsDrbjEY0a9
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 287981042937728525
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: Re: [PATCH v2 4/4] tools/nolibc: sys.h: apply __syscall() helper
Date:   Wed,  7 Jun 2023 13:39:20 +0800
Message-Id: <20230607053920.667272-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZIAB7bFYegCuXT9g@1wt.eu>
References: <ZIAB7bFYegCuXT9g@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> On Wed, Jun 07, 2023 at 08:34:06AM +0800, Zhangjin Wu wrote:
> > > Hi Zhangjin,
> > > 
> > > On 2023-06-06 16:17:38+0800, Zhangjin Wu wrote:
> > > > Use __syscall() helper to shrink 252 lines of code.
> > > > 
> > > >     $ git show HEAD^:tools/include/nolibc/sys.h | wc -l
> > > >     1425
> > > >     $ git show HEAD:tools/include/nolibc/sys.h | wc -l
> > > >     1173
> > > >     $ echo "1425-1173" | bc -l
> > > >     252
> > > > 
> > > > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > > > ---
> > > >  tools/include/nolibc/sys.h | 336 +++++--------------------------------
> > > >  1 file changed, 42 insertions(+), 294 deletions(-)
> > > > 
> > > > diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> > > > index f6e3168b3e50..0cfc5157845a 100644
> > > > --- a/tools/include/nolibc/sys.h
> > > > +++ b/tools/include/nolibc/sys.h
> > > > @@ -108,13 +108,7 @@ int sys_chdir(const char *path)
> > > >  static __attribute__((unused))
> > > >  int chdir(const char *path)
> > > >  {
> > > > -	int ret = sys_chdir(path);
> > > > -
> > > > -	if (ret < 0) {
> > > > -		SET_ERRNO(-ret);
> > > > -		ret = -1;
> > > > -	}
> > > > -	return ret;
> > > > +	return __syscall(chdir, path);
> > > 
> > > To be honest I'm still not a big fan of the __syscall macro.
> > > It's a bit too magic for too little gain.
> > > 
> > > The commit message argues that the patches make the code shorter.
> > > 
> > > However doing 
> > > 
> > > __sysret(sys_chdir(path));
> > > 
> > > instead of
> > > 
> > > __syscall(chdir, path);
> > > 
> > > is only three characters longer and the same amout of lines.
> > >
> > 
> > Yeah, I do like your version too, it looks consise too, the only not
> > comfortable part is there are dual calls in one line.
> 
> For those who want to debug, having less macros or magic stuff is always
> better, and in this essence I too find that Thomas' version is more
> expressive about what is being done. Also, if some syscalls require a
> specific handling (e.g. mmap() needs to return MAP_FAILED instead), it's
> much easier to change only the code dealing with the return value and
> errno setting than having to guess how to reimplement what was magically
> done in a macro.
>

Ok, so, let's go with Thomas' version ;-)

> > > Otherwise we would have syscall() _syscall() and __syscall() each doing
> > > different things.
> > >
> > 
> > Yes, I'm worried about this too, although the compilers may help a
> > little, but it is too later.
> 
> The issue is for the person who remembers "I need to use 'syscall'" but
> never remembering the number of underscores nor the variations.

Yeah, it is hard to remember.

> 
> > Just brain storming, What about another non-similar name, for example,
> > __syswrap() or __sysin() ?
> > 
> > Or even convert __sysret() to __sysout() and __syscall() to __sysin(),
> > do you like it? or even __sysexit(), __sysentry(), but the __sysexit()
> > may be misused with sys_exit().
> 
> I'd rather use "__set_errno()" to explicitly mention that it's only
> used to set errno, but sysret would be fine as well IMHO as if we're
> purist, it also normalizes the return value.
>

Ok, let's take the shorter sysret() seems no similar sys_xxx calls.

> >     /* Syscall return helper, set errno as -ret when ret < 0 */
> >     static __inline__ __attribute__((unused, always_inline))
> >     long __sysout(long ret)
> >     {
> >     	if (ret < 0) {
> >     		SET_ERRNO(-ret);
> >     		ret = -1;
> >     	}
> >     	return ret;
> >     }
> >     
> >     /* Syscall call helper, use syscall name instead of syscall number */
> >     #define __sysin(name, ...) __sysout(sys_##name(__VA_ARGS__))
> > 
> >     static __attribute__((unused))
> >     int brk(void *addr)
> >     {
> >     	return __sysout(sys_brk(addr) ? 0 : -ENOMEM);
> >     }
> > 
> >     static __attribute__((unused))
> >     int chdir(const char *path)
> >     {
> >     	return __sysin(chdir, path);
> >     }
> 
> I still don't find this intuitive at all.
> 
> > If we really want something like __syscall()/__sysret(), I do think they
> > should be a pair ;-)
> 
> Then one being called "call" while the other one being "ret" do form a
> pair, no ?

The 'ret' currently is a part of our old '__syscall', seems not that like a
'pair', it differs from entry/exit ;-)

As a summary, will use 'sysret()' and something like:

   static __attribute__((unused))
   int chdir(const char *path)
   {
   	return sysret(chdir(path));
   }

to renew the syscall helper patchset, Thanks you very much.

Best regards,
Zhangjin

> 
> Thanks,
> Willy
