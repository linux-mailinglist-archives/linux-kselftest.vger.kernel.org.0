Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63417725B00
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 11:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240162AbjFGJqi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 05:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240145AbjFGJqf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 05:46:35 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783B61BC8;
        Wed,  7 Jun 2023 02:46:32 -0700 (PDT)
X-QQ-mid: bizesmtp86t1686131182tizfen7e
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 07 Jun 2023 17:46:21 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: I8hG9CuxGDJk1fb1IN/SHwwA7W3iabws+Ljo1O5lGLOabbtj4wHDtc/pIMsVD
        K/5K4WpXf8Bjmy/z1AokS/VELvcZm8oZdJ0D7hKtcx4ZbZd1k3hSFXS/KGoHmc+6CiIl92n
        yFR9amAcb4g777EfAWm7DFivWENOYmuR6NDo/JIs+3HKMNvvChe1p3uZxFLqqK+t7x26bAh
        QLHHPc8qwVdqxF7lGiqzZIEXqULfWrh5GYLklTHOg0Gfc4+PhLLGe3GQ0VKOYaD2SB+dRdb
        FOxv/JUNmGfJAeWr7pTQPT2fwYuFJuEcwHRLU14vCNLXUT7yIhkDwcmlokgb/WVbGwOFliK
        zfwhB+ri1vhbd07NfeieOivOuZ4i3rwBu5xBryvtuieuotZ6K41wH8CFCtS4D0JM0XMgSES
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11605753545439782903
From:   Zhangjin Wu <falcon@tinylab.org>
To:     arnd@arndb.de
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de, w@1wt.eu
Subject: Re: [PATCH v3 1/3] tools/nolibc: fix up #error compile failures with -ENOSYS
Date:   Wed,  7 Jun 2023 17:46:15 +0800
Message-Id: <20230607094615.792013-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <b80f021a-30b7-47e9-8455-3844be157cc2@app.fastmail.com>
References: <b80f021a-30b7-47e9-8455-3844be157cc2@app.fastmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> On Wed, Jun 7, 2023, at 07:19, Zhangjin Wu wrote:
> >> On Sat, Jun 3, 2023, at 11:01, Zhangjin Wu wrote:
> >
> > Yeah, agreed, we can clean up them one by one, If split them to their own
> > syscalls, I have two questions (for Arnd, and Willy too):
> >
> > 1. do we need to add the corresponding library routines at the same time?
> >
> >   Use llseek() as an example, there will be llseek() and lsee64(). If off_t
> >   would be converted to 64bit, then, they can be simply added as follows:
> >
> >     #define lseek64 lseek
> >     #define llseek lseek
> >
> >   Or something like this:
> >
> >     static __attribute__((unused))
> >     loff_t lseek(int fd, loff_t offset, int whence)
> >     {
> >     	return lseek(fd, offset, whence);
> >     }
> >
> >     static __attribute__((unused))
> >     off64_t lseek(int fd, off64_t offset, int whence)
> >     {
> >     	return lseek(fd, offset, whence);
> >     }
> >
> >   This one aligns with the other already added library routines.
> >
> >   Which one do you like more?
> 
> lseek() is probably not a good example, as the llseek and lseek64
> library functions are both nonstandard, and I'd suggest leaving them
> out of nolibc altogether.
>

Ok, agree, as the 64bit version of lseek may be enough for nolibc, if a target
application really require, they can add the alias themselves.

> Are there any examples of functions where we actually want mulitple
> versions?
>

For example, the following ones are related to the syscalls being added,
all of them have similar library routines in current sys.h:

* waitid, https://linux.die.net/man/2/waitid
* ppoll, https://linux.die.net/man/2/ppoll
* pselect, https://linux.die.net/man/2/pselect6
* clock_gettime, https://linux.die.net/man/2/clock_gettime

The similar routines are put in right side:

* waitid --> waitpid, wait, wait4
* ppoll --> poll
* pselect --> select
* clock_gettime --> gettimeofday

For the clock_gettime, it may also let us think about if we need to add
its friends (clock_getres, clock_settime) together.

> > 2. If so, how to cope with the new types when add the library routines?
> >
> >   Still use the above llseek() as an example, If not use '#define' method,
> >   We may need to declare loff_t and off64_t in std.h too:
> >
> >     #define off64_t off_t
> >     #define loff_t off_t
> >
> >   Or align with the other new types, use 'typedef' instead of '#define'.
> 
> If we do want to include the explicit off64_t interfaces from glibc,
> I'd suggest doing it the same way as musl:
> https://git.musl-libc.org/cgit/musl/tree/include/unistd.h#n201
>

Thanks.

> >
> >> This patch is a step in that direction though, so I think that's
> >> totally fine.
> >
> > Thanks, so, can I pick your Reviewed-by for the first two patches? I'm ready to
> > send v4 now ;-)
> 
> Yes, please do.
>

Thanks very much, just added the Reviewed-by lines in v4 and have
already sent v4 out, welcome your review on the revision of the 3rd one,
it is almost consistent with the original Makefile now.

Best regards,
Zhangjin

>      Arnd
