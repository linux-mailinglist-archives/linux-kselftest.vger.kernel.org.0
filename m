Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B177A35F4
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Sep 2023 16:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbjIQOpG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 17 Sep 2023 10:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjIQOoh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 17 Sep 2023 10:44:37 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C17131;
        Sun, 17 Sep 2023 07:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1694961865;
        bh=BZcIuJ/PvMUbPWSxstQ1ZcUecybP+sAbJtOfRDESnSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FRCuTm82BJ+sdZSSgXCBZ29m8YRKQFtjy1k4g30Tj6oSZHzCEB/aMG5BxmqlJS/sU
         N1Qds28wxSv6TzDxhAVnELf5XpWwGVSgM9u7v7pU+kFoSu5ntRhObBrZ57S54riDM8
         dp9XO/yMoVpABjTuKi8fmGy4IwGjjd6wTl4hyElU=
Date:   Sun, 17 Sep 2023 16:44:22 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Shuah Khan <shuah@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] selftests/nolibc: avoid spurious kernel relinks
Message-ID: <5200f33b-f4ba-4251-bee0-3ae7257e22d2@t-8ch.de>
References: <20230916-nolibc-initramfs-v1-0-4416ecedca6d@weissschuh.net>
 <20230917032219.GH9646@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230917032219.GH9646@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_PASS,
        T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-09-17 05:22:19+0200, Willy Tarreau wrote:
> On Sat, Sep 16, 2023 at 09:13:26AM +0200, Thomas Weißschuh wrote:
> > Currently the nolibc testsuite embeds the test executable into a kernel
> > image with CONFIG_INITRAMFS_SOURCE.
> > This forces a full kernel relink everytime the test executable is
> > updated.
> > 
> > This relinking step dominates the test cycle.
> > It is slower than building and running the test in qemu together.
> > 
> > With a bit of Makefile-shuffling the relinking can be avoided.
> 
> That's pretty nice as indeed it still takes a while to relink it into
> the kernel. I agree that for running nolibc-test in qemu we don't need
> a unified image. However I've seldom used it on real hardware and I
> find it significantly more convenient to use as a single image in this
> case. Maybe we should just rename targets so that everything qemu-related
> just uses two distinct images while a "unified-image" (or anything else)
> still assembles the image into the kernel (BTW the help on the "kernel"
> target still mentions initramfs).

Sounds good, "unified-image" is a bit close to "unified kernel image"
(UKI) which is similar but different.

What about kernel-standalone?

> Note that we don't need to modify anything in the build system to create
> an initrd, I usually make them by hand using "cpio -o -H newc", we don't
> need anything else here.

I'd like to keep the build self-contained. But actually the kernel build
will always build a minimal initramfs if CONFIG_BLK_DEV_INITRD is set.
This config is needed for the nolibc testsuite in any case.

The fact that the initrd is always build means that usr/gen_init_cpio
is also always build.
So we can add "kernel" as a prerequisite to "initramfs.cpio" and
everything should work out without any buildsystem modifications.

> Regarding rerun, I'd rather keep it for the sole reason that I've used
> it to check for randomly failing errors (typically the timing-based
> ones). It's convenient to run the same image 100 times if needed. I'm
> not strongly attached to it, but if "make run" is slower, then we can
> keep it. However if you really want to drop it, it also needs to be
> dropped from the help message ;-)

Fine for me, let's keep it :-)
