Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD2D722242
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 11:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjFEJds (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 05:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjFEJdq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 05:33:46 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F08E9;
        Mon,  5 Jun 2023 02:33:39 -0700 (PDT)
X-QQ-mid: bizesmtp83t1685957608tzz4iygk
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 05 Jun 2023 17:33:26 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: UCO5VR5DCxd++cX5LQirmMNyZLC3eu9zWeL07KEu3eknxQBr52q+q6a7eYVC0
        dtrJp2eVJi4X6qKEqUYPK4FDIvve+INoQeZVxnYP/+yarKQKMWwzDdSrn58U5/RhFh2cEGl
        LdDbBTKfHa5Hxalg5LunK2UdNKAseZgqNwU7o14kBKySSWA0Yab58OxXPpWyKYkpofSQCbH
        ngn7iDU7Mjs4VDb7aSI0lTwlTtW5WRnTEEge6ry6UWZ9z4vuov7QViP2mBteIpkNdsapucN
        myI3oR5hI49TvTvcdOdQIex+dYfTag+AZhTKw721keQRG54QXdKKFFC8eGDjvRsaS3EpTbm
        Oysb54CJYT/saCkBole+iCqBt5XlTGDR9amFbG1NXrnKmAFLo9PMJooWrHMNw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6742117217107098079
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: Re: [PATCH 1/4] tools/nolibc: unistd.h: add __syscall() and __syscall_ret() helpers
Date:   Mon,  5 Jun 2023 17:33:26 +0800
Message-Id: <20230605093326.156266-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZH1+hkhiA2+ItSvX@1wt.eu>
References: <ZH1+hkhiA2+ItSvX@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> On Mon, Jun 05, 2023 at 01:58:57PM +0800, Zhangjin Wu wrote:
> > > What about something like this:
> > > 
> > > static inline long __ret_as_errno(long ret) /* or some other name */
> > > {
> > > 	if (ret < 0) {
> > > 		SET_ERRNO(-ret);
> > > 		ret = -1;
> > > 	}
> > > 	return ret;
> > > }
> > > 
> > > This avoids another macro by using a normal function.
> > >
> > 
> > It is reasonable, like it very much.
> > 
> > > Syscall return values should always fit into long, at least
> > > extra polating from syscall(2) and the fact that they are returned in
> > > registers.
> > 
> > Yes, I did use 'long' instead of 'int' for unistd.h locally, but since tried to
> > let it work with 'void *' before (e.g. sys_brk, an older version support pass
> > the errno value), so, the typeof() is used and the same to unistd.h, but at
> > last, none of (void *) return type is really used in current patchset, so, we
> > are able to use this normal function version without the checking of the type.
> > 
> > > 
> > > It would be a bit more verbose:
> > > 
> > > int chdir(const char *path)
> > > {
> > > 	return __ret_as_errno(sys_chdir(path));
> > > }
> > >
> > > But it's clear what's going on and also just one line.
> > 
> > Thanks Thomas, It looks good and I do like the 'embedded' calling of
> > sys_chrdir(path), but __syscall() looks cleaner and shorter too, let's put them
> > together:
> > 
> > int chdir(const char *path)
> > {
> > 	return __ret_as_errno(sys_chdir(path));
> > }
> > 
> > int chdir(const char *path)
> > {
> > 	return __syscall(chdir, path);
> > }
> > 
> > And even with:
> > 
> > int chdir(const char *path)
> > {
> > 	return __sysret(sys_chdir(path));
> > }
> > 
> > __syscall() works likes syscall(), and the definition is similar to syscall(),
> > but uses the syscall name instead of syscall number, If reserve __syscall(),
> > the inline function would be renamed back to __syscall_ret() or something like
> > the shorter __sysret(), to align with our new __syscall(). 
> > 
> > for sys.h:
> > 
> >     /* Syscall return helper, set errno as ret when ret < 0 */
> >     static inline long __sysret(long ret)
> >     {
> >     	if (ret < 0) {
> >     		SET_ERRNO(-ret);
> >     		ret = -1;
> >     	}
> >     	return ret;
> >     }
> > 
> >     /* Syscall call helper, use syscall name instead of syscall number */
> >     #define __syscall(name, ...) __sysret(sys_##name(__VA_ARGS__))
> > 
> > for unistd.h:
> > 
> >     #define _syscall(N, ...) __sysret(my_syscall##N(__VA_ARGS__))
> > 
> > What about this version?
> > 
> > The potential 'issue' may be mixing the use of __syscall(), _syscall() and
> > syscall(), but the compilers may help to fix up this for us, I don't think it
> > is a bottleneck.
> 
> I think that could work. However, please place __attribute__((always_inline))
> on these inline functions, as we don't want to turn them to function calls
> even at -O0.

Thanks, done.

> 
> I'm traveling today, I'll let you and Thomas debate and decide how you'd
> like this to evolve.
> 

Happy traveling.

This revision is basically derived from the 'long' type information and
__ret_as_errno() from Thomas, I will wait suggestion from Thomas and then send
v2 later.

> Also, please note that Paul is OK with merging for 6.5, but we should
> absolutely limit last-minute changes to the strict minimum we're able
> to test now.

Strongly agree, we can delay this and the left time64 syscalls to 6.6, because
they require more cleanup and discussion.

Best regards,
Zhangjin

> 
> Thanks!
> Willy
