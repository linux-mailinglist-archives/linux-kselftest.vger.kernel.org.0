Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3C977122E
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Aug 2023 22:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjHEUtC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Aug 2023 16:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjHEUtB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Aug 2023 16:49:01 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 577EAE78;
        Sat,  5 Aug 2023 13:49:00 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 375Kmj8j007515;
        Sat, 5 Aug 2023 22:48:45 +0200
Date:   Sat, 5 Aug 2023 22:48:45 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org,
        thomas@t-8ch.de
Subject: Re: [PATCH v6 8/8] selftests/nolibc: customize CROSS_COMPILE for
 32/64-bit powerpc
Message-ID: <20230805204845.GA7300@1wt.eu>
References: <cover.1691259983.git.falcon@tinylab.org>
 <2c3ac4542621ddc4b2cab006ae8e3a7b709921f1.1691259983.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c3ac4542621ddc4b2cab006ae8e3a7b709921f1.1691259983.git.falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Aug 06, 2023 at 02:47:09AM +0800, Zhangjin Wu wrote:
> The little-endian powerpc64le compilers provided by Ubuntu and Fedora
> are able to compile big endian kernel and big endian nolibc-test [1].

FWIW I'm wondering why focusing on these ones which have a different
naming from the other ones, when I think that most users rely on the
ones maintained by Arnd there:

   https://mirrors.edge.kernel.org/pub/tools/crosstool/

Yours is called powerpc64le while the one above is "powerpc64", it
requires to make an exception for this one, I find this a bit odd.

If someone wants to use their distro's cross toolchain, that's fine,
but I think that it will depend on distros anyway and some may not
even be provided (like loongarch) so I think it would make more sense
to adopt the canonical naming from Arnd's toolchains above.

It's not critical, but as you showed below, it makes building for ppc
a little bit cumbersome: those "export" lines could be dropped when
using the default names, and that's what we should document as the
recommended way to test:

> For example, it is able to build 64-bit nolibc-test with the big endian
> powerpc64-linux-gcc crosstool from [2]:
> 
>     $ wget -c https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.1.0/x86_64-gcc-13.1.0-nolibc-powerpc64-linux.tar.xz
>     $ tar xvf x86_64-gcc-13.1.0-nolibc-powerpc64-linux.tar.xz
>     $ export PATH=$PWD/gcc-13.1.0-nolibc/powerpc64-linux/bin/:$PATH
> 
>     $ export CROSS_COMPILE_ppc=powerpc64-linux-
>     $ export CROSS_COMPILE_ppc64=powerpc64-linux-
>     $ export CROSS_COMPILE_ppc64le=powerpc64-linux-
>     $ for arch in ppc ppc64 ppc64le; do \
>         make run-user XARCH=$arch | grep "status: "; \
>       done

Any opinion on this ?

Thanks,
Willy
