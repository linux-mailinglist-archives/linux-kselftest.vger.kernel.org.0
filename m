Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F362744E9B
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Jul 2023 18:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjGBQ2n (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 2 Jul 2023 12:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjGBQ2m (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 2 Jul 2023 12:28:42 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A246FE61;
        Sun,  2 Jul 2023 09:28:41 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 362GS2oc016328;
        Sun, 2 Jul 2023 18:28:02 +0200
Date:   Sun, 2 Jul 2023 18:28:02 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: Re: [PATCH v2 07/13] tools/nolibc: sys_lseek: add pure 64bit lseek
Message-ID: <20230702162802.GA16233@1wt.eu>
References: <5e7d2adf-e96f-41ca-a4c6-5c87a25d4c9c@app.fastmail.com>
 <20230530135433.405051-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530135433.405051-1-falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin, Arnd,

On Tue, May 30, 2023 at 09:54:33PM +0800, Zhangjin Wu wrote:
> > And then do the selection inside of the actual lseek,
> > something like
> > 
> > static __attribute__((unused))
> > off_t lseek(int fd, off_t offset, int whence)
> > {
> >         off_t ret = -ENOSYS;
> > 
> >         if (BITS_PER_LONG == 32)
> >                ret = sys_llseek(fd, offset, whence);
> > 
> >         if (ret == -ENOSYS)
> >                ret = sys_lseek(fd, offset, whence);
> > 
> >         if (ret < 0) {
> >                 SET_ERRNO(-ret);
> >                 ret = -1;
> >         }
> >         return ret;
> >        
> > }
> 
> Yes, It is clearer, thanks. will learn carefully about the kernel types.

I, too, like Arnd's proposal here. I tend to use a similar approach in
other projects when possible. Often the limit is the types definition,
which is necessary to define even empty static inline functions. The
only thing is that due to the reliance on -ENOSYS above, the compiler
cannot fully optimize the code away, particularly when both syscalls
are defined, which may result in the compiler emitting the code for
both calls on 32-bit platforms. But the idea is there anyway, and it
may possibly just need a few adjustments based on BITS_PER_LONG after
checking the emitted code.

> > For the loff_t selection, there is no real need to handle the
> > fallback, so this could just be an if()/else to select 32-bit
> > or 64-bit, but for the time_t ones the fallback is required
> > for pre-5.6 kernels.
> >
> 
> Ok, will test it on the pre-5.6 versions too.
> 
> Hi, Willy, what's your suggestion about the oldest kernel versions we plan to
> support? ;-)

Like I said last time, since the code is included in the kernel, we
expect userland developers to use this one to build their code, even
if it's meant to work on older kernels. At the very least I want that
supported kernels continue to work, and then as long as it does not
require particular efforts, it's nice to continue to work on older
ones (think LTS distros, late upgraders of legacy systems etc).

Thanks,
Willy
