Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529D1767D23
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 10:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjG2IaN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Jul 2023 04:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjG2IaL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Jul 2023 04:30:11 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F3F044A5;
        Sat, 29 Jul 2023 01:29:57 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36T8Tou8004416;
        Sat, 29 Jul 2023 10:29:50 +0200
Date:   Sat, 29 Jul 2023 10:29:50 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     Zhangjin Wu <falcon@tinylab.org>, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 08/12] selftests/nolibc: allow quit qemu-system when
 poweroff fails
Message-ID: <20230729082950.GL956@1wt.eu>
References: <cover.1690489039.git.falcon@tinylab.org>
 <4b4d792299ca5356f8f5af5fc9a27c687b0e4e38.1690489039.git.falcon@tinylab.org>
 <ac2994fd-3131-45d1-aef3-ae8a7e0c3740@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac2994fd-3131-45d1-aef3-ae8a7e0c3740@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jul 29, 2023 at 09:59:55AM +0200, Thomas Weißschuh wrote:
> On 2023-07-28 04:30:31+0800, Zhangjin Wu wrote:
> > The kernel of some architectures can not poweroff qemu-system normally,
> > especially for tinyconfig.
(...)
> This feels fairly hacky.

and totally unmaintainable in the long term. It may even fail for
some users having localization.

> Before we complicated nolibc-test to handle the no-procfs case to save a
> few seconds building the kernel and now we have fairly big timeouts.
> And a statemachine that relies on the specific strings emitted by the
> testsuite.
> 
> I would like to get back to something more deterministic and obvious,
> even at the cost of some time spent compiling the test kernels.
> (saying this as somebody developing on a 2016 ultrabook)

Agreed!

> "Since the low-level poweroff support is heavily kernel & qemu dependent"
> 
> The kernel we can control.
> 
> How common are qemus with that are missing poweroff support? 
> As this worked before I guess the only architecture where this could
> pose a problem would be ppc.
> 
> 
> An alternative I would like to put up for discussion:
> 
> qemu could provide a watchdog device that is pinged by nolibc-test for
> each testcase.
> After nolibc-test is done and didn't poweroff properly the watchdog will
> reset the machine. ( -watchog-action poweroff ).
> 
> The disadvantages are that we would need to add watchdog drivers to the
> kernels and figure out the correct watchdog devices and drivers for each arch.

It's an interesting idea, though at first glance it does not seem to
have one for PPC.

I think I have a much simpler idea: we don't care about PPC32. I mean
OK it can be supported if it happens to work, we will just not include
it in default runs, because it will require Ctrl-C to finish, and so
what ? nolibc has been in the kernel for 5 years or so, nobody ever
cared about PPC, why should we suddenly break or complicate everything
just to support a sub-arch that nobody found interesting to add till
now?

> It seems virtio-watchdog is not yet usable.

Then it might become an option for the future when it eventually works.

Thanks,
Willy
