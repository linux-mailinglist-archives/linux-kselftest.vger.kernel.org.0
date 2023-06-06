Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CDE7237FF
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 08:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjFFGpu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 02:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234634AbjFFGps (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 02:45:48 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CE6DE40;
        Mon,  5 Jun 2023 23:45:46 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3566jWuo018103;
        Tue, 6 Jun 2023 08:45:32 +0200
Date:   Tue, 6 Jun 2023 08:45:32 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: Re: [PATCH v3 0/3] nolibc: add part2 of support for rv32
Message-ID: <ZH7WDDgACvzVzV6e@1wt.eu>
References: <ZH65QKQ1dlY+HsK7@1wt.eu>
 <20230606063421.355411-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606063421.355411-1-falcon@tinylab.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 06, 2023 at 02:34:21PM +0800, Zhangjin Wu wrote:
> Willy, Thomas, Arnd
> 
> > Hi Zhangjin,
> > 
> > On Tue, Jun 06, 2023 at 12:25:35PM +0800, Zhangjin Wu wrote:
> > > The first two convert all compile failures to a return of -ENOSYS, if you do
> > > like it, welcome your Reviewed-by. These two are required by the coming new
> > > time64 syscalls for rv32, because they depends on how we cope with the
> > > unsupported syscalls, returning -ENOSYS is really better than simply fail the
> > > compiling.
> > 
> > I had a look now and I can sya that I like this. Initially the supported
> > syscalls were so restricted that it was not even imaginable to accept to
> > build without any of them, but now that we're completing the list, some
> > of them are less critical and I don't see why we'd fail to build just
> > because one is missing. So yeah, a big +1 for -ENOSYS.
> >
> 
> Cool, I will prepare the new patchsets on them, welcome your new branch
> with both of them, of course, still weclome Reviewed-by from Arnd and Thomas.

I don't even think a new branch is needed, I can take them as-is it seems.

> > > The third one is not that urgent, because some important syscalls are
> > > still missing for rv32. It is added here only for compile test.
> > 
> > I personally have no opinion on this one. I can't judge whether it will
> > make things easier or more complicated at this point. It seems to me
> > that for now it's just avoiding one extra line at the expense of some
> > $(if) on several lines. Maybe it could help add more such archs, or
> > maybe it can make them more complicated to debug, I don't know. I'm
> > interested in others' opinions as well.
> 
> As I explained why we did it in current way in this reply [1], Thomas had no
> more questions on it, so I think Thomas was happy with it now and I got his
> only left suggestion is that may be this patch should be applied after the
> missing 64bit syscalls being added for there are several important test
> failures currently, for me, it is ok before or after.
> 
> Thomas, welcome your Reviewed-by on the makefile patch itself If you are really
> happy with it now, thanks very much ;-)
> 
> Willy, I will send the v2 syscalls helpers (also required by the coming 64bit
> syscalls) and some other patches (mainly for test with faster kernel build)
> about selftests/nolibc later, because we have not enough time for v6.5 test,
> so, I suggest we can create new branch for v6.6 and my new patchsets will be
> for v6.6.

Agreed, thank you!
Willy
