Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2963E72166D
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jun 2023 13:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjFDLqW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 4 Jun 2023 07:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjFDLqV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 4 Jun 2023 07:46:21 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A32E8CD;
        Sun,  4 Jun 2023 04:46:19 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 354Bk6rF001904;
        Sun, 4 Jun 2023 13:46:06 +0200
Date:   Sun, 4 Jun 2023 13:46:06 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Zhangjin Wu <falcon@tinylab.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v3 11/12] selftests/nolibc: add new gettimeofday test
 cases
Message-ID: <ZHx5fghesYtnpPoi@1wt.eu>
References: <cover.1685777982.git.falcon@tinylab.org>
 <68dace9e2532316ff454894697ecfd99e419a523.1685777982.git.falcon@tinylab.org>
 <2fccaff5-2354-4ac0-8389-1004d47d8dc9@t-8ch.de>
 <tencent_4668A50A08C3D31E7531619E@qq.com>
 <51e1db37-3981-4ea5-9348-b6f6b31ecc8a@app.fastmail.com>
 <ZHx1OliMqHx9U1Lw@1wt.eu>
 <54edae1f-0c1c-4beb-b6ac-fcd61fc81de8@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54edae1f-0c1c-4beb-b6ac-fcd61fc81de8@app.fastmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jun 04, 2023 at 01:38:39PM +0200, Arnd Bergmann wrote:
> > Over time we managed
> > to make simple code compile with both glibc and nolibc, but when it
> > comes at the cost of adding size and burden for the developers, such
> > as forcing them to add libgcc, I prefer that we slightly limit the
> > domain of application instead.
> 
> Good point. This also reminds me that the compilers I build for
> https://mirrors.edge.kernel.org/pub/tools/crosstool/ don't always
> have every version of libgcc that may be needed, for instance
> the mips compilers only provide a big-endian libgcc and the
> arm compilers only provide a little-endian one, even though
> the compilers can build code both ways with the right flags.

That reminds me something indeed, I know that MIPS is a great platform
for testing portability due to libgcc and/or atomics not always being
complete depending how it's built. At work when I double-check that
haproxy still builds and starts on my EdgeRouter-X, then it will build
everywhere ;-)

Willy
