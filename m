Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F48477057A
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 18:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjHDQCm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 12:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjHDQCl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 12:02:41 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B171449E0;
        Fri,  4 Aug 2023 09:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1691164956; bh=SqKltnePnG5igiH9/TdmZdpA8qWi1qiP8QCMK6xqfE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MZZIBjWNTJxjh4631yY9m8aJZu1q6/H0WRp7ZjKXlwictQe7TtJmdw4xBEZo79qL7
         4iN50vJ2vbgM9A7k0r1AUpAHa9eDdQHWN3kccfqRguCHjr4nnwFl5KvFQs8gViZZxW
         bs+hhbAUUUU1pM4yUJQX+Ax6q2AtNvEVruALSNQM=
Date:   Fri, 4 Aug 2023 18:02:35 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org, w@1wt.eu
Subject: Re: [PATCH v1 2/3] selftests/nolibc: fix up O= option support
Message-ID: <500504f6-fed1-45a4-a518-4631a6f3e463@t-8ch.de>
References: <058a264d-45bd-4f1f-8af3-56ed337b3251@t-8ch.de>
 <20230804155218.293995-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804155218.293995-1-falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-08-04 23:52:18+0800, Zhangjin Wu wrote:
> > On 2023-08-04 15:43:42+0800, Zhangjin Wu wrote:
> > > Hi, Thomas
> > > 
> > > > On 2023-08-03 22:45:52+0800, Zhangjin Wu wrote:
> > > > > To avoid pollute the source code tree and avoid mrproper for every
> > > > > architecture switch, the O= argument must be supported.
> > > > > 
> > > > > Both IMAGE and .config are from the building directory, let's use
> > > > > objtree instead of srctree for them.
> > > > > 
> > > > > If no O= option specified, means building kernel in source code tree,
> > > > > objtree should be srctree in such case.
> > > > > 
> > > > > Suggested-by: Willy Tarreau <w@1wt.eu>
> > > > > Link: https://lore.kernel.org/lkml/ZK0AB1OXH1s2xYsh@1wt.eu/
> > > > > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > > > > ---
> > > > >  tools/testing/selftests/nolibc/Makefile | 7 +++++--
> > > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> > > > > index 51fef5e6a152..af590aee063a 100644
> > > > > --- a/tools/testing/selftests/nolibc/Makefile
> > > > > +++ b/tools/testing/selftests/nolibc/Makefile
> > > > > @@ -9,6 +9,9 @@ ifeq ($(srctree),)
> > > > >  srctree := $(patsubst %/tools/testing/selftests/,%,$(dir $(CURDIR)))
> > > > >  endif
> > > > >  
> > > > > +# add objtree for O= argument, required by IMAGE and .config
> > > > > +objtree ?= $(srctree)
> > > > 
> > > > Isn't this already set by the included tools/scripts/Makefile.include?
> > > >
> > > 
> > > Good question, but it is empty if no O= specified, checked it several
> > > times before ;-)
> > 
> > For me it is not empty when I am in tools/testing/selftests/nolibc/.
> >
> 
> Interesting, here is the code I added to check the value:
> 
>     diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
>     index 22f1e1d73fa8..1ae19e896e24 100644
>     --- a/tools/testing/selftests/nolibc/Makefile
>     +++ b/tools/testing/selftests/nolibc/Makefile
>     @@ -12,6 +12,8 @@ include $(srctree)/scripts/subarch.include
>      ARCH = $(SUBARCH)
>      endif
>     
>     +$(error objtree=$(objtree), srctree=$(srctree))
>     +
> 
> Whenever I do defconfig or run,
> 
>     $ make help
>     Makefile:15: *** objtree=, srctree=/labs/linux-lab/src/linux-stable.  Stop.
> 
> It is only not empty when we pass O explicitly:
> 
>     $ mkdir out
>     $ make help O=out
>     Makefile:15: *** objtree=out, srctree=/labs/linux-lab/src/linux-stable.  Stop.
>     $ make help O=$PWD/out
>     Makefile:15: *** objtree=/labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/out, srctree=/labs/linux-lab/src/linux-stable.  Stop.

Welp, now it's the same for me.
I guess I messed it up before, maybe I forgot to remove your changes
while testing?

Anyways instead of having to manually do stuff with $(objtree) we could
also use $(OUTPUT)$(IMAGE) to always get the correct image.

> [..]
> 
> After align the empty objtree value with you, will renew this patch.

Thanks!
Thomas
