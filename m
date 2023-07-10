Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BBE74CCF8
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jul 2023 08:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjGJGar (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 02:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjGJGap (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 02:30:45 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10F4E123;
        Sun,  9 Jul 2023 23:30:43 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 36A6URIR016678;
        Mon, 10 Jul 2023 08:30:27 +0200
Date:   Mon, 10 Jul 2023 08:30:27 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v1 4/5] selftests/nolibc: report: extrude the test status
 line
Message-ID: <ZKulgwwDjubkZuTa@1wt.eu>
References: <20230709085453.GB9321@1wt.eu>
 <20230709192652.97668-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230709192652.97668-1-falcon@tinylab.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin,

On Mon, Jul 10, 2023 at 03:26:52AM +0800, Zhangjin Wu wrote:
> > On Thu, Jul 06, 2023 at 05:11:17PM +0800, Zhangjin Wu wrote:
> > > two newlines are added around the test summary line to extrude the test
> > > status.
> > 
> > But then we're back to making it annoying to check, having to figure
> > if we need to grep -A or grep -B etc. With grep 'status:' we would get
> > a synthetic status and the counters together. Why do you think it's
> > not convenient ? Or am I the only one considering it useful to just
> > run grep "status:" on all output files and figure a global status at
> > once ?
> 
> Sorry, Willy, my commit message may mislead you a little.
> 
> The newlines are added around the whole test summary line (with the
> status info), not only around the 'status info' ;-)

Ah OK, thanks for clarifying this!

> It is not for status grep, it is for developers to easily see the whole
> summary line at a glance

I understand but both work hand-in-hand, as every time you'll perform
a slight change, you'll necessarily rerun the whole series on all archs
to confirm, which is why I'm particularly annoying about the ability to
grep!

> And further, if not consider pure-text, the colors may be more helpful,
> for example, red for failed/failure, yellow for skipped/warning, green
> for passed/success, for example:
> 
>     $ echo | awk 'END{printf("138 test(s): \033[32m135\033[0m passed, \033[33m  2\033[0m skipped, \033[31m  1\033[0m failed => status: \033[31mfailure\033[0m\n");}'
>     138 test(s): 135 passed,   2 skipped,   1 failed => status: failure
> 
> But as we can see, the color control code is not readable and it may
> break the simple "status: failure" grep, we should use something like
> "status: .*failure" ;-)

Colors may only be used when stdout is a terminal, and still, some might
find it annonying (for example some distros use unreadably dark colors
that were apparently never tested over a black background, forcing users
to highlight the text by selecting it with the mouse to read it). Better
not start to play with this IMO, that's not really needed and may be more
annoying to some than helpful to most.

Thanks,
Willy
