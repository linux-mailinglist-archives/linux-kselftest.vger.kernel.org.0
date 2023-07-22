Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6DA75DCAD
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jul 2023 14:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjGVMqT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 22 Jul 2023 08:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGVMqS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 22 Jul 2023 08:46:18 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5866210DE;
        Sat, 22 Jul 2023 05:46:17 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36MCk3ZR017430;
        Sat, 22 Jul 2023 14:46:03 +0200
Date:   Sat, 22 Jul 2023 14:46:03 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     thomas@t-8ch.de, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 07/14] selftests/nolibc: defconfig: remove mrproper
 target
Message-ID: <20230722124603.GI17311@1wt.eu>
References: <cover.1689759351.git.falcon@tinylab.org>
 <ba8ce60152aa03c73f9b33960d3be8af0e377a49.1689759351.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba8ce60152aa03c73f9b33960d3be8af0e377a49.1689759351.git.falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 19, 2023 at 09:24:54PM +0800, Zhangjin Wu wrote:
> The O=/path/to/kernel-<ARCH> option allows to build kernel for different
> architectures in different output directories, in this scene, it doesn't
> need the mrproper operation for defconfig anymore.
> 
> If really require to clean up the source code tree, let users run the
> standalone mrproper target on demand.

But that's precisely what's going to make it more and more annoying
to run simple tests. The mrproper was there precisely because one
config at a time was being used, so without it we'll restart to see
plenty of failures as it used to be before mrproper was added. I
understand what you're trying to do with the O=, but then if you're
already passing "O=", why not also pass "defconfig" ?

I mean, let's make sure this makefile is only used to manipulate
the tests. It must not become a huge wrapper for the kernel makefile
otherwise it will become extremely complicated to use to run just a
simple test. And with this one and the last few ones, I'm starting
to sense that I'll have to read a README to figure how to reliably
run a test.

In my opinion, there are mainly two use cases :
  - user, manually: commands should be short, forgiving to user
    mistakes, and easy to remember. I.e. they're compatible with
    upper-arrow, then enter.

  - scripts: these are the ones already running in loops with tons
    of variables, setting object directories with O=$arch/... and
    taking care of their own cleanups. These ones will already be
    user-specific and can very well accomodate one or two extra
    lines for a make mrproper or make defconfig if needed.

The second ones deserve thinking and control anyway. The first ones
should mostly not fail for a user mistake and in the worst case waste
a bit of their time by rebuilding something that could have been
avoided. But I do want to prioritize the user here. And that's also
why I want the makefile to be easy to read with as few macros as
possible, because once it works for you, it's easy to figure what is
being done, and how to exploit it from your scripts. The opposite is
not true. Nobody reads a makefile full of macros to try to figure how
to run their first test or why a test that worked once now fails.

Thanks,
Willy
