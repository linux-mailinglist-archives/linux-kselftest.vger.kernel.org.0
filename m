Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44894723672
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 06:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjFFEn1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 00:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjFFEn0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 00:43:26 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76895187;
        Mon,  5 Jun 2023 21:43:24 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3564geIU017411;
        Tue, 6 Jun 2023 06:42:40 +0200
Date:   Tue, 6 Jun 2023 06:42:40 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: Re: [PATCH v3 0/3] nolibc: add part2 of support for rv32
Message-ID: <ZH65QKQ1dlY+HsK7@1wt.eu>
References: <cover.1685780412.git.falcon@tinylab.org>
 <20230606042535.354118-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606042535.354118-1-falcon@tinylab.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin,

On Tue, Jun 06, 2023 at 12:25:35PM +0800, Zhangjin Wu wrote:
> The first two convert all compile failures to a return of -ENOSYS, if you do
> like it, welcome your Reviewed-by. These two are required by the coming new
> time64 syscalls for rv32, because they depends on how we cope with the
> unsupported syscalls, returning -ENOSYS is really better than simply fail the
> compiling.

I had a look now and I can sya that I like this. Initially the supported
syscalls were so restricted that it was not even imaginable to accept to
build without any of them, but now that we're completing the list, some
of them are less critical and I don't see why we'd fail to build just
because one is missing. So yeah, a big +1 for -ENOSYS.

> The third one is not that urgent, because some important syscalls are
> still missing for rv32. It is added here only for compile test.

I personally have no opinion on this one. I can't judge whether it will
make things easier or more complicated at this point. It seems to me
that for now it's just avoiding one extra line at the expense of some
$(if) on several lines. Maybe it could help add more such archs, or
maybe it can make them more complicated to debug, I don't know. I'm
interested in others' opinions as well.

Thanks,
Willy
