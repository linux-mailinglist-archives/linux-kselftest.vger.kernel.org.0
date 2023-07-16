Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52BF754D58
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Jul 2023 06:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjGPEu3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 16 Jul 2023 00:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjGPEu2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 16 Jul 2023 00:50:28 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A77E10F8;
        Sat, 15 Jul 2023 21:50:27 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36G4oFVC028846;
        Sun, 16 Jul 2023 06:50:15 +0200
Date:   Sun, 16 Jul 2023 06:50:15 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v4 00/18] tools/nolibc: shrink arch support
Message-ID: <20230716045015.GA28761@1wt.eu>
References: <20230715222658.GA27708@1wt.eu>
 <20230716011744.499597-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230716011744.499597-1-falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jul 16, 2023 at 09:17:44AM +0800, Zhangjin Wu wrote:
> > I finally found that it's due to the lack of -Isysroot/x86/include, so
> > it used to get linux includes from those provided by glibc and these ones
> > were missing statx since packaged for an older kernel.
> >
> 
> So, your local glibc may be older than 2.28 (The one we mentioned in the
> commit message who supports statx)? mine 2.31 glibc is ok:

Oh definitely! It's a 2.23, and on another machine I'm having a 2.27
on an ubuntu 18 but it was built against a more recent kernel so its
linux/stat.h has the required entries, and on another one I'm having
a 2.17 which was built against a 3.10 kernel.

> For older Linux systems without a newer libc may really require the
> installation of the linux sysroot (linux/uapi).

Yes. My point was that it wasn't very hard to already spot breakage
on existing code built on existing setups.

> > I knew that sooner or later I'd have to reinstall this machine but I
> > can't get out of my head that to date I have yet not been convinced by
> > the absolute necessity of this modification which is progressively adding
> > more burden :-/  Time will tell...
> >
> 
> This may also let us think about the removing of <linux/xxx.h> from our
> nolibc headers? just like musl does ;-)
> 
>     $ grep "include <linux" -ur ../../../include/nolibc/
>     ../../../include/nolibc/stdlib.h:#include <linux/auxvec.h>
>     ../../../include/nolibc/sys.h:#include <linux/fs.h>
>     ../../../include/nolibc/sys.h:#include <linux/loop.h>
>     ../../../include/nolibc/sys.h:#include <linux/time.h>
>     ../../../include/nolibc/sys.h:#include <linux/auxvec.h>
>     ../../../include/nolibc/sys.h:#include <linux/fcntl.h> /* for O_* and AT_* */
>     ../../../include/nolibc/sys.h:#include <linux/stat.h>  /* for statx() */
>     ../../../include/nolibc/sys.h:#include <linux/prctl.h>
>     ../../../include/nolibc/types.h:#include <linux/mman.h>
>     ../../../include/nolibc/types.h:#include <linux/reboot.h> /* for LINUX_REBOOT_* */
>     ../../../include/nolibc/types.h:#include <linux/stat.h>
>     ../../../include/nolibc/types.h:#include <linux/time.h>
> 
> If simply put all of them to types.h, it may be too much, a new "sys/"
> directory with almost the same Linux type files may be required, but as
> an in-kernel libc, this duplication may be a "big" issue too, so, adding
> minimal required macros and structs in types.h may be another choice.
(...)
> The required new macros and structs may be around 100-300 lines? but it may
> help to avoid the installation of sysroot completely and also avoid the cross
> including the linux-libc-dev package used by glibc?

No, really, that's what we used to do previously. If you remember we
recently removed lots of structs and defines from various files because
they used to regularly conflict with linux/foo.h (that we can't prevent
users from including), while not always being 100% up-to-date. It's
particularly annoying when there are typedefs for example because it's
difficult to detect them, and if you redefine them you end up with build
errors. We should only keep that for absolute necessity. In fact, maybe
we could have these few ones precisely for statx, right after including
linux/stat.h (which is supposed to provide them):

  #ifndef STATX_BASIC_STATS
    /* pre-4.10 linux uapi headers present, missing statx that we need */
    #define STATX_BASIC_STATS xxx
    struct statx {
        ...
    };
  #endif

I may give this a try to see if it's sufficient to fix the build on
these machines. But it's not critical anyway. I might try once I'm
bored of seeing build failures.

Cheers,
Willy
