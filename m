Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC4C71391F
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 May 2023 13:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjE1LDU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 28 May 2023 07:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjE1LDU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 28 May 2023 07:03:20 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D4CDBAC;
        Sun, 28 May 2023 04:03:18 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 34SB35t5002033;
        Sun, 28 May 2023 13:03:05 +0200
Date:   Sun, 28 May 2023 13:03:05 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Zhangjin Wu <falcon@tinylab.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH 09/13] tools/nolibc: sys_poll: riscv: use
 __NR_ppoll_time64 for rv32
Message-ID: <20230528110305.GI1956@1wt.eu>
References: <83ab9f47-e1ed-463c-a717-26aad6bf2b71@app.fastmail.com>
 <20230528082509.293250-1-falcon@tinylab.org>
 <20230528102947.GH1956@1wt.eu>
 <afc4944f-9494-4367-906d-06ac47648ab7@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afc4944f-9494-4367-906d-06ac47648ab7@app.fastmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, May 28, 2023 at 12:55:47PM +0200, Arnd Bergmann wrote:
> On Sun, May 28, 2023, at 12:29, Willy Tarreau wrote:
> > On Sun, May 28, 2023 at 04:25:09PM +0800, Zhangjin Wu wrote:
> >> 
> >> * Use __kernel_timespec as timespec
> >> * Use 64bit time_t based struct timeval
> >>     * Disable gettimeofday syscall completely for 32bit platforms
> >>         * And disable the gettimeofday_bad1/2 test case too
> >
> > When you say "disable", you mean "remap", right ? Or do you mean
> > "break in 2023 code that was expected to break only in 2038 after
> 
> clock_gettime() has been supported for a very long time, so both
> time() and gettimeofday() can be trivial wrappers around that.

OK, that's what I wanted to clarify. I understood "drop" in the sense
of, well, "drop" :-)

> Nothing really should be using the timezone argument, so I'd
> just ignore that in nolibc. (it's a little trickier for /sbin/init
> setting the initial timezone, but I hope we can ignore that here).

Yes I'm fine with this approach.

> clock_gettime() as a function call that takes a timespec argument
> in turn should be a wrapper around either sys_clock_gettime64 (on
> 32-bit architectures) or sys_clock_gettime_old() (on 64-bit
> architectures, or as a fallback on old 32-bit kernels after
> clock_gettime64 fails).

Sounds good to me.

> On normal libc implementations, the low-level
> sys_clock_gettime64() and sys_clock_gettime_old(), whatever
> they are named, would call vdso first and then fall back
> to the syscall, but I don't think that's necessary for nolibc.

Indeed, we don't exploit the VDSO here since it's essentially useful
for performance and that's not what we're seeking.

> I'd define them the same as the kernel, with
> sys_clock_gettime64() taking a __kernel_timespec, and
> sys_clock_gettime_old() takeing a __kernel_old_timespec.

Sounds good, thanks Arnd!
Willy
