Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E14377A5C1
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Aug 2023 11:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjHMJIk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 13 Aug 2023 05:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjHMJIk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 13 Aug 2023 05:08:40 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 436EE10FA;
        Sun, 13 Aug 2023 02:08:42 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 37D98UQM008629;
        Sun, 13 Aug 2023 11:08:30 +0200
Date:   Sun, 13 Aug 2023 11:08:30 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     david.laight@aculab.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tanyuan@tinylab.org, thomas@t-8ch.de
Subject: Re: [PATCH v6 0/2] tools/nolibc: fix up size inflat regression
Message-ID: <20230813090830.GF8237@1wt.eu>
References: <cover.1691788036.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1691788036.git.falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Aug 12, 2023 at 05:49:36AM +0800, Zhangjin Wu wrote:
> After these two patches, will send the proposed my_syscall() patchset
> tomorrow, it can even further reduce more type conversions and therefore
> reduce more binary bytes, here is a preview of the testing result:
> 
>    // with the coming my_syscall() patchset, sys_* from functionsn to macros
>      i386: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 19250
>    x86_64: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 21733
(...)
> It can also shrink the whole sys.h from 1171 lines to around 738 lines.

Please, Zhangjin, please. Let's stop constantly speaking about potential
future improvements when the present is broken. It needlessly adds a lot
of noise in the discussion and tends to encourage you to explore areas
that are incompatible with what is required to fix the breakage, and
very likely steers your approach to fixes in a direction that you think
is compatible with such future paths. But as long as existing code is
broken you cannot speculate on how better the next iteration will be,
because it's built on a broken basis. And I would like to remind that
the *only* reason for the current breakage is this attempt to save even
more code lines, that was not a requirement at all in the first place!
Sure it can be fine to remove code when possible, but not at the cost of
trying to force squares to enter round holes like this. The reality is
that *some* syscalls are different and *some* archs are different, and
these differences have to be taken into account, and if we keep exceptions
it's fine.

So let's only speak about this later once the issue is completely solved.

Thanks,
Willy
