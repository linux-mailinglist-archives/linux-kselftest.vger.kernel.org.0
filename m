Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6AC771482
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Aug 2023 13:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjHFLVq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 6 Aug 2023 07:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjHFLVq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 6 Aug 2023 07:21:46 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9AEE11D;
        Sun,  6 Aug 2023 04:21:38 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 376BLNHo013027;
        Sun, 6 Aug 2023 13:21:23 +0200
Date:   Sun, 6 Aug 2023 13:21:23 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     thomas@t-8ch.de, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH v2 3/3] selftests/nolibc: fix up O= option support
Message-ID: <20230806112122.GF10627@1wt.eu>
References: <cover.1691215074.git.falcon@tinylab.org>
 <06d96bd81fe812a9718098a383678ad3beba98b1.1691215074.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06d96bd81fe812a9718098a383678ad3beba98b1.1691215074.git.falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Aug 05, 2023 at 02:13:11PM +0800, Zhangjin Wu wrote:
> To avoid pollute the source code tree and avoid mrproper for every
> architecture switch, the O= argument must be supported.
> 
> Both IMAGE and .config are from the building directory, let's use
> objtree instead of srctree for them.
> 
> If no O= option specified, means building kernel in source code tree,
> objtree should be srctree in such case.
> 
> To support relative path, as suggested by Thomas, $(COMMAND_O) is used
> to pass the O=$(ABSOLUTE_O) to the $(MAKE) commands.

Zhangjin, I cannot get this one to work, regardless of what I try:

   $ make -j8 O=$PWD/output-i386 nolibc-test XARCH=i386 CROSS_COMPILE=/f/tc/nolibc/gcc-12.3.0-nolibc/i386-linux/bin/i386-linux- CC=/f/tc/nolibc/gcc-12.3.0-nolibc/i386-linux/bin/i386-linux-gcc
   (...)
   CC      nolibc-test
   In file included from sysroot/i386/include/stdio.h:14,
                    from nolibc-test.c:13:
   sysroot/i386/include/errno.h:10:10: fatal error: asm/errno.h: No such file or directory
      10 | #include <asm/errno.h>
         |          ^~~~~~~~~~~~~
   compilation terminated.

I'll leave it aside for now as I've spent way longer than I hoped on
these series. I could take the previous two patches however.

Thanks,
Willy
