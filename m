Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFEA77BC52
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 17:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjHNPEH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 11:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjHNPED (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 11:04:03 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB4918F;
        Mon, 14 Aug 2023 08:04:00 -0700 (PDT)
X-QQ-mid: bizesmtp90t1692025423t74pom02
Received: from linux-lab-host.localdomain ( [116.30.128.116])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 14 Aug 2023 23:03:42 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: RmDZc/K2LPHIjGTliFn1MDalUgmywfpO1nPYPxXK2+N9HkXb4PP3jEx+fNN8p
        ApphuAIN7plJLg6eY7lsSN3/PzoYcbgDk0lSIP+R+RJadbOuP+8ZmlxyOQDgwppi/SKVSJ1
        SeoLvcWKtlmw7tCCgv+igmP6lTBgCnNszNNThTgkbE8AHMwoBkQ4m3fwV7ItQtyFhQo/xsd
        UImBYDa4O+x3NlfoB5Kdx5aG7AI8MKPmdXfWLY9nwRNdLmOC1kXmPQ2b1drvH/s4SmiIFXA
        brCyq8wsU+YR5H4Ign2y8RWJT93HX8Jew4xQ9GaDOgDBaPD26kLiYnMPyNLiiNfkeuAb2mU
        8y8RmPW+k01PCb5NjKizGQ+JwpYmUj56mYEodA1Gr98WPOc+r5J62V6rNj0VA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6938916050489271949
From:   Zhangjin Wu <falcon@tinylab.org>
To:     falcon@tinylab.org
Cc:     David.Laight@ACULAB.COM, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        thomas@t-8ch.de, w@1wt.eu
Subject: Re: [PATCH v5] tools/nolibc: fix up size inflate regression
Date:   Mon, 14 Aug 2023 23:03:41 +0800
Message-Id: <20230814150341.203817-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230814141831.163031-1-falcon@tinylab.org>
References: <20230814141831.163031-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> > On Mon, Aug 14, 2023 at 12:27:48PM +0000, David Laight wrote:
> > > From: Willy Tarreau
> > > > Sent: 14 August 2023 13:10
> > > > 
> > > > Hi David,
> > > > 
> > > > On Mon, Aug 14, 2023 at 11:15:51AM +0000, David Laight wrote:
> > > > > From: Zhangjin Wu
> > > > > > Sent: 14 August 2023 11:42
> > > > > ...
> > > > > > [...]
> > > > > > > > > Sure it's not pretty, and I'd rather just go back to SET_ERRNO() to be
> > > > > > > > > honest, because we're there just because of the temptation to remove
> > > > > > > > > lines that were not causing any difficulties :-/
> > > > > > > > >
> > > > > > > > > I think we can do something in-between and deal only with signed returns,
> > > > > > > > > and explicitly place the test for MAX_ERRNO on the two unsigned ones
> > > > > > > > > (brk and mmap). It should look approximately like this:
> > > > > > > > >
> > > > > > > > >  #define __sysret(arg)                                                \
> > > > > > > > >  ({                                                                   \
> > > > > > > > >  	__typeof__(arg) __sysret_arg = (arg);                           \
> > > > > > > > >  	(__sysret_arg < 0) ? ({           /* error ? */                 \
> > > > > > > > >  		SET_ERRNO(-__sysret_arg); /* yes: errno != -ret */      \
> > > > > > > > >  		((__typeof__(arg)) -1);   /*      return -1 */          \
> > > > >
> > > > > I'm pretty sure you don't need the explicit cast.
> > > > > (It would be needed for a pointer type.)
> > > > > Can you use __arg < ? SET_ERRNO(-__arg), -1 : __arg
> > > > >
> > > > > Thinking, maybe it should be:
> > > > >
> > > > > #define __sysret(syscall_fn_args)
> > > > > ({
> > > > > 	__typeof__(syscall_fn_args) __rval = syscall_fn_args;
> > > > > 	__rval >= 0 ? __rval : SET_ERRNO(-__rval), -1;
> > > > > })
> > > > 
> > > > Yeah almost, since arg is necessarily signed in this version, it's
> > > > just that I manually edited the previous macro in the mail and limited
> > > > the amount of changes to what was necessary. It's just that SET_ERRNO
> > > > only is an instruction, not an expression:
> > > > 
> > > >    #define SET_ERRNO(v) do { errno = (v); } while (0)
> > > > 
> > > > Thus the return value doesn't even pass through it. That's why it was
> > > > so much simpler before. The rationale behind this was to bring the
> > > > ability to completely drop errno for programs where you didn't care
> > > > about it. It's particularly interesting when you don't need any other
> > > > data either as the program gets strunk from a complete section.
> > > 
> > > Actually something like:
> > > 
> > > #define SET_ERRNO(v) (errno = -(long)(v), __typeof__(v)-1)
> > > 
> > > seems to work and allows the errno assignment be removed.
> > > Also works for pointer types (after a different compare).
> > 
> > Yes, that's something we can do (with the parenthesis around
> > __typeof__(v) though).
> >
> 
> Yes, we need the parenthesis, this works:
> 
>     #define SET_ERRNO(v) ( errno = -(long)(v), ((__typeof__(v))-1))
>

Willy, David, We still need "({})":

	#define SET_ERRNO(v) ({ errno = -(long)(v); (__typeof__(v))-1; })

to silence the warning:

	sysroot/x86_64/include/errno.h:13:42: warning: right-hand operand of comma expression has no effect [-Wunused-value]
	   13 | #define SET_ERRNO(v) ( errno = -(long)(v), (__typeof__(v))-1)
	      |                      ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~

BR,
Zhangjin

>     #define __is_unsigned_type(v) ((__typeof__(v))(-1) > (__typeof__(v))1)
>     #define __is_syserr(v)        (__is_unsigned_type(v) ? (long)v & ~(-4095UL) : (v + 1 < (__typeof__(v))1))
> 
>     #define __sysret(arg)                                                          \
>     ({                                                                             \
>             __typeof__(arg) __sysret_arg = (arg);                                  \
>             (!__is_syserr(__sysret_arg)) ? __sysret_arg : SET_ERRNO(__sysret_arg); \
>     })
> 
> It looks better now, even for 'void *'.
> 
> '(long)x & ~(-4095UL)' saves another 2+ bytes in some architectures:
> 
>      i386: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 19256
>    x86_64: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 21740
>     arm64: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 25812
>       arm: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 22856
>      mips: 160 test(s): 157 passed,   3 skipped,   0 failed => status: warning 22756
>       ppc: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 26380
>     ppc64: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 26756
>   ppc64le: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 27364
>     riscv: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 21758
>      s390: 160 test(s): 157 passed,   3 skipped,   0 failed => status: warning 21936
> 
> BR,
> Zhangjin
