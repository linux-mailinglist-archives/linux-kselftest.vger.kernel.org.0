Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE57725124
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 02:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbjFGAeY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 20:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbjFGAeX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 20:34:23 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7231410EA;
        Tue,  6 Jun 2023 17:34:20 -0700 (PDT)
X-QQ-mid: bizesmtp80t1686098048tb6ncj0o
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 07 Jun 2023 08:34:07 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: 2qli6fYqcypcLY99/zUQyFc7OGvqHYqz5PiHI7yQ7HnWszpIoNcsoAMUj02ew
        Wey8rV7CTOMl0Y+ApPuSc3Cbnpx7QkY2Wvjso2OA5T31VwSz4Nxa/gm77aJOQBY+6Cl/hEx
        S/dvpbhonG0Fyips2ThCWreyj3PqH4IOmYOhaDoEqnqEDhW1i71CubLWPuuCrUzdMiFrLEn
        gopznRXZeMfi3ZpUvVnsBfoXIR4zUPnH8FbvFr3ONszDpMgLeOePr7UCr9ZX/Fb1xQU0k4k
        AnHSoiVH9o095/x6cDWNFOL0uZ1Yk0wXD3WOhMwW/J7SN8BF0fJSEAQNC1PIttK6Q0SPX1j
        UDZBWvKMR72PNl7m9KYNbcf7RYxdQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1982007782142480683
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 4/4] tools/nolibc: sys.h: apply __syscall() helper
Date:   Wed,  7 Jun 2023 08:34:06 +0800
Message-Id: <20230607003406.559638-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <7e76f099-4198-421c-8157-430201970c4c@t-8ch.de>
References: <7e76f099-4198-421c-8157-430201970c4c@t-8ch.de>
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

> Hi Zhangjin,
> 
> On 2023-06-06 16:17:38+0800, Zhangjin Wu wrote:
> > Use __syscall() helper to shrink 252 lines of code.
> > 
> >     $ git show HEAD^:tools/include/nolibc/sys.h | wc -l
> >     1425
> >     $ git show HEAD:tools/include/nolibc/sys.h | wc -l
> >     1173
> >     $ echo "1425-1173" | bc -l
> >     252
> > 
> > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > ---
> >  tools/include/nolibc/sys.h | 336 +++++--------------------------------
> >  1 file changed, 42 insertions(+), 294 deletions(-)
> > 
> > diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> > index f6e3168b3e50..0cfc5157845a 100644
> > --- a/tools/include/nolibc/sys.h
> > +++ b/tools/include/nolibc/sys.h
> > @@ -108,13 +108,7 @@ int sys_chdir(const char *path)
> >  static __attribute__((unused))
> >  int chdir(const char *path)
> >  {
> > -	int ret = sys_chdir(path);
> > -
> > -	if (ret < 0) {
> > -		SET_ERRNO(-ret);
> > -		ret = -1;
> > -	}
> > -	return ret;
> > +	return __syscall(chdir, path);
> 
> To be honest I'm still not a big fan of the __syscall macro.
> It's a bit too magic for too little gain.
> 
> The commit message argues that the patches make the code shorter.
> 
> However doing 
> 
> __sysret(sys_chdir(path));
> 
> instead of
> 
> __syscall(chdir, path);
> 
> is only three characters longer and the same amout of lines.
>

Yeah, I do like your version too, it looks consise too, the only not
comfortable part is there are dual calls in one line.

> Otherwise we would have syscall() _syscall() and __syscall() each doing
> different things.
>

Yes, I'm worried about this too, although the compilers may help a
little, but it is too later.

Just brain storming, What about another non-similar name, for example,
__syswrap() or __sysin() ?

Or even convert __sysret() to __sysout() and __syscall() to __sysin(),
do you like it? or even __sysexit(), __sysentry(), but the __sysexit()
may be misused with sys_exit().

    /* Syscall return helper, set errno as -ret when ret < 0 */
    static __inline__ __attribute__((unused, always_inline))
    long __sysout(long ret)
    {
    	if (ret < 0) {
    		SET_ERRNO(-ret);
    		ret = -1;
    	}
    	return ret;
    }
    
    /* Syscall call helper, use syscall name instead of syscall number */
    #define __sysin(name, ...) __sysout(sys_##name(__VA_ARGS__))

    static __attribute__((unused))
    int brk(void *addr)
    {
    	return __sysout(sys_brk(addr) ? 0 : -ENOMEM);
    }

    static __attribute__((unused))
    int chdir(const char *path)
    {
    	return __sysin(chdir, path);
    }

If we really want something like __syscall()/__sysret(), I do think they
should be a pair ;-)

> And __syscall does not behave like a regular function.
> 
> The rest of the patchset looks great.
>

Thanks for your nice review.

> Maybe Willy can break the tie?
>

If there is no better solution, I think your version is also a first
step to go.

> 
> Thomas
> 
> 
> Note: If we figure out a way to build syscall() without macros I would
> like that also :-)

Yes, but it is not easy to cope with the variable number of arguments
without a macro.

BTW, do you like to convert the my_syscallN() of sys.h to the syscall()
you added? I do worry about it will make the checking of arguments
mismatch, exspecially, the checking of number of them hardly.

Best regards,
Zhangjin
