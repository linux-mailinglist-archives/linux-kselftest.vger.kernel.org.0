Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975BA721DF9
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 08:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjFEGUT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 02:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjFEGUS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 02:20:18 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73A6BE9;
        Sun,  4 Jun 2023 23:20:13 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3556Jors005856;
        Mon, 5 Jun 2023 08:19:50 +0200
Date:   Mon, 5 Jun 2023 08:19:50 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     thomas@t-8ch.de, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/4] tools/nolibc: unistd.h: add __syscall() and
 __syscall_ret() helpers
Message-ID: <ZH1+hkhiA2+ItSvX@1wt.eu>
References: <ea4e7442-7223-4211-ba29-70821e907888@t-8ch.de>
 <20230605055857.135286-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605055857.135286-1-falcon@tinylab.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 05, 2023 at 01:58:57PM +0800, Zhangjin Wu wrote:
> > What about something like this:
> > 
> > static inline long __ret_as_errno(long ret) /* or some other name */
> > {
> > 	if (ret < 0) {
> > 		SET_ERRNO(-ret);
> > 		ret = -1;
> > 	}
> > 	return ret;
> > }
> > 
> > This avoids another macro by using a normal function.
> >
> 
> It is reasonable, like it very much.
> 
> > Syscall return values should always fit into long, at least
> > extra polating from syscall(2) and the fact that they are returned in
> > registers.
> 
> Yes, I did use 'long' instead of 'int' for unistd.h locally, but since tried to
> let it work with 'void *' before (e.g. sys_brk, an older version support pass
> the errno value), so, the typeof() is used and the same to unistd.h, but at
> last, none of (void *) return type is really used in current patchset, so, we
> are able to use this normal function version without the checking of the type.
> 
> > 
> > It would be a bit more verbose:
> > 
> > int chdir(const char *path)
> > {
> > 	return __ret_as_errno(sys_chdir(path));
> > }
> >
> > But it's clear what's going on and also just one line.
> 
> Thanks Thomas, It looks good and I do like the 'embedded' calling of
> sys_chrdir(path), but __syscall() looks cleaner and shorter too, let's put them
> together:
> 
> int chdir(const char *path)
> {
> 	return __ret_as_errno(sys_chdir(path));
> }
> 
> int chdir(const char *path)
> {
> 	return __syscall(chdir, path);
> }
> 
> And even with:
> 
> int chdir(const char *path)
> {
> 	return __sysret(sys_chdir(path));
> }
> 
> __syscall() works likes syscall(), and the definition is similar to syscall(),
> but uses the syscall name instead of syscall number, If reserve __syscall(),
> the inline function would be renamed back to __syscall_ret() or something like
> the shorter __sysret(), to align with our new __syscall(). 
> 
> for sys.h:
> 
>     /* Syscall return helper, set errno as ret when ret < 0 */
>     static inline long __sysret(long ret)
>     {
>     	if (ret < 0) {
>     		SET_ERRNO(-ret);
>     		ret = -1;
>     	}
>     	return ret;
>     }
> 
>     /* Syscall call helper, use syscall name instead of syscall number */
>     #define __syscall(name, ...) __sysret(sys_##name(__VA_ARGS__))
> 
> for unistd.h:
> 
>     #define _syscall(N, ...) __sysret(my_syscall##N(__VA_ARGS__))
> 
> What about this version?
> 
> The potential 'issue' may be mixing the use of __syscall(), _syscall() and
> syscall(), but the compilers may help to fix up this for us, I don't think it
> is a bottleneck.

I think that could work. However, please place __attribute__((always_inline))
on these inline functions, as we don't want to turn them to function calls
even at -O0.

I'm traveling today, I'll let you and Thomas debate and decide how you'd
like this to evolve.

Also, please note that Paul is OK with merging for 6.5, but we should
absolutely limit last-minute changes to the strict minimum we're able
to test now.

Thanks!
Willy
