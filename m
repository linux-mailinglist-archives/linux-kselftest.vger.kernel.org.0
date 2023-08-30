Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBCC78D285
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Aug 2023 05:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237719AbjH3D0T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Aug 2023 23:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjH3DZv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Aug 2023 23:25:51 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9231EAB;
        Tue, 29 Aug 2023 20:25:45 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 37U3PVPD024054;
        Wed, 30 Aug 2023 05:25:31 +0200
Date:   Wed, 30 Aug 2023 05:25:31 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tanyuan@tinylab.org, thomas@t-8ch.de
Subject: Re: [RFC] tools/nolibc: replace duplicated -ENOSYS return with
 single -ENOSYS return
Message-ID: <ZO62q1lm7HSdcILu@1wt.eu>
References: <ZO2QWPYpo1fdXjX+@1wt.eu>
 <20230830001907.67499-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830001907.67499-1-falcon@tinylab.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 30, 2023 at 08:19:07AM +0800, Zhangjin Wu wrote:
> Yes, as also suggested by Willy, the old proposed method redefined
> NOLIBC__NR_* macros for every __NR_* and it must be avoided, and now,
> the __is_nr_defined() and __get_nr() macros will simply avoid defining
> new NOLIBC__NR_* for exisitng __NR_*, they can be used to test and get
> the existing __NR_* directly.
> 
> In my local repo, we have saved 500+ lines ;-)
> 
>     $ git show nolibc/next:tools/include/nolibc/sys.h | wc -l
>     1190
>     $ cat tools/include/nolibc/sys.h | wc -l
>     690
> 
> Including all of the -ENOSYS and #ifdef's:
> 
>     $ git grep -r ENOSYS nolibc/next:tools/include/nolibc/sys.h | wc -l
>     17
>     $ git grep -Er "#ifdef|#el|#endif" nolibc/next:tools/include/nolibc/sys.h | wc -l
>     77

And how many hacks or bugs for the rare special cases ? I'm not kidding,
this obsession for removing lines has already caused us quite some trouble
around sysret() in the previous cycle, and I yet have to see the gain for
maintenance.

I do have comparable macros that I never employed in my projects just
because each time I needed them I found a corner case at one particular
optimization level or with a particular compiler version where you manage
to break them, and suddenly all the world falls apart. I'm fine for taking
that risk when there is a *real* benefit, but here we're speaking about
replacing existing, readable and auditable code by something more compact
that becomes completely unauditable. I could understand that if it was
a specific required step in a more long-term project of factorizing
something, but there still hasn't been any such project defined, so all
we're doing is "let's see if we can do this or that and see if it looks
better". I continue to strongly disagree with this approach, it causes
all of us a lot of extra work, introduces regressions and nobody sees
the benefits in the end.

Instead of using tricks here and there to remove lines, I'd rather have
an approach centered on the code's architecture and modularity to see
what are the current problems and how they should be addressed.

For now I still find it complicated to explain other maintainers how
to test their changes on all architectures. I've found it difficult to
switch between arm and thumb modes for arm when trying to explain it
lately (now with more analysis I'm seeing that I could have placed it
into CFLAGS_arm for example) so it means we're missing some doc in the
makefile itself or on the usage in general. I've faced the problem you
met with some builds failing on "you need to run mrproper first", which
makes me think that in fact it should probably be "make defconfig" or
"make prepare" that does this. Just checking the makefile and that's
already the case, yet I faced the issue, so maybe it's caused by -j
being passed through all the chain and we need to serialize the
operations, I don't know.

I would also like that we clarify some use cases. Originally the project
started as the single-file zero-installation file that allowed to build
static binaries, retrieving the linux/ subdir from wherever it was (i.e.
from the local system libc for native builds or from the toolchain used
for cross-builds). Since we've started to focus a bit too much on the
nolibc-test program only with its preparation stages, I think we've lost
this focus a little bit, and I'd like to add some tests to make sure this
continues to work (I know that my primary usage already got broken by
the statx change with the toolchain I was using).

Also, maybe it could be useful to make it easier to produce tar.gz
sysroots form tools/include/nolibc for various (even all?) archs to
make it easier for users to test their own code against it.

So in short, we need to make it easier to use and easier to test, not
to just remove lines that nobody needs to maintain.

> Yeah, for the sys_* definitions, it is ok for us to use explicit arguments
> intead of the '...'/__VA_ARGS__ to avoid losing some arguments sometimes, let's
> do it in the RFC patchset but it should come after the tinyconfig patchset.
> 
> BTW, Willy, when will you prepare the branch for v6.7 developmlent? ;-)

You can continue to use the latest branch as a starting point, we'll create
the new for-6.7 branch once 6.6-rc1 is out.

Thanks,
Willy
