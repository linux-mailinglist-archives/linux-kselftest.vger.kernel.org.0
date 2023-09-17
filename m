Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622227A33A6
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Sep 2023 05:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjIQDWo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 16 Sep 2023 23:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjIQDWn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 16 Sep 2023 23:22:43 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88891CC8;
        Sat, 16 Sep 2023 20:22:36 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 38H3MJrr010050;
        Sun, 17 Sep 2023 05:22:19 +0200
Date:   Sun, 17 Sep 2023 05:22:19 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Shuah Khan <shuah@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] selftests/nolibc: avoid spurious kernel relinks
Message-ID: <20230917032219.GH9646@1wt.eu>
References: <20230916-nolibc-initramfs-v1-0-4416ecedca6d@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230916-nolibc-initramfs-v1-0-4416ecedca6d@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Sep 16, 2023 at 09:13:26AM +0200, Thomas Weißschuh wrote:
> Currently the nolibc testsuite embeds the test executable into a kernel
> image with CONFIG_INITRAMFS_SOURCE.
> This forces a full kernel relink everytime the test executable is
> updated.
> 
> This relinking step dominates the test cycle.
> It is slower than building and running the test in qemu together.
> 
> With a bit of Makefile-shuffling the relinking can be avoided.

That's pretty nice as indeed it still takes a while to relink it into
the kernel. I agree that for running nolibc-test in qemu we don't need
a unified image. However I've seldom used it on real hardware and I
find it significantly more convenient to use as a single image in this
case. Maybe we should just rename targets so that everything qemu-related
just uses two distinct images while a "unified-image" (or anything else)
still assembles the image into the kernel (BTW the help on the "kernel"
target still mentions initramfs).

Note that we don't need to modify anything in the build system to create
an initrd, I usually make them by hand using "cpio -o -H newc", we don't
need anything else here.

Regarding rerun, I'd rather keep it for the sole reason that I've used
it to check for randomly failing errors (typically the timing-based
ones). It's convenient to run the same image 100 times if needed. I'm
not strongly attached to it, but if "make run" is slower, then we can
keep it. However if you really want to drop it, it also needs to be
dropped from the help message ;-)

Cheers,
Willy
