Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F04721658
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jun 2023 13:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjFDL2H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 4 Jun 2023 07:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFDL2G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 4 Jun 2023 07:28:06 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2BE17DA;
        Sun,  4 Jun 2023 04:28:04 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 354BRs1j001843;
        Sun, 4 Jun 2023 13:27:54 +0200
Date:   Sun, 4 Jun 2023 13:27:54 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Zhangjin Wu <falcon@tinylab.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v3 11/12] selftests/nolibc: add new gettimeofday test
 cases
Message-ID: <ZHx1OliMqHx9U1Lw@1wt.eu>
References: <cover.1685777982.git.falcon@tinylab.org>
 <68dace9e2532316ff454894697ecfd99e419a523.1685777982.git.falcon@tinylab.org>
 <2fccaff5-2354-4ac0-8389-1004d47d8dc9@t-8ch.de>
 <tencent_4668A50A08C3D31E7531619E@qq.com>
 <51e1db37-3981-4ea5-9348-b6f6b31ecc8a@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51e1db37-3981-4ea5-9348-b6f6b31ecc8a@app.fastmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jun 04, 2023 at 11:24:39AM +0200, Arnd Bergmann wrote:
> On Sun, Jun 4, 2023, at 10:29, ??? wrote:
> >
> > Sorry for missing part of your feedbacks, I will check if -nostdlib 
> > stops the linking of libgcc_s or my own separated test script forgot 
> > linking the libgcc_s manually.
> 
> According to the gcc documentation, -nostdlib drops libgcc.a, but
> adding -lgcc is the recommended way to bring it back.
> 
> > And as suggestion from Thomas' reply,
> >
> >>> Perhaps we really need to add the missing __divdi3 and __aeabi_ldivmod and the
> >>> ones for the other architectures, or get one from lib/math/div64.c.
> >
> >>No, these ones come from the compiler via libgcc_s, we must not try to
> > reimplement them. And we should do our best to avoid depending on them
> > to avoid the error you got above.
> >
> > So, the explicit conversion is used instead in the patch.
> 
> I think a cast to a 32-bit type is ideal when converting the
> clock_gettime() result into microseconds, since the kernel guarantees
> that the timespec value is normalized, with all zeroes in the
> upper 34 bits. Going through __aeabi_ldivmod would make the
> conversion much slower.
> 
> For user supplied non-normalized timeval values, it's not obvious
> whether we need the full 64-bit division

We don't have to care about these here for the microsecond part,
because for decades these were exclusively 32-bit. Also the only
one consuming this field would have been settimeofday() and it's
already documented as returning EINVAL if tv_usec is not within
the expected 0..999999 range.

And when in doubt we should keep in mind that nolibc's purpose is not
to become a yet-another full-blown libc alternative but just a small
piece of software allowing to produce portable and compact binaries
for testing or booting. Being a bit stricter than other libcs for the
sake of code compactness is better here. Originally for example it was
necessary to always pass the 3 arguments to open(). Over time we managed
to make simple code compile with both glibc and nolibc, but when it
comes at the cost of adding size and burden for the developers, such
as forcing them to add libgcc, I prefer that we slightly limit the
domain of application instead.

Thanks!
Willy
