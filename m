Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FD17705FC
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 18:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjHDQ3f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 12:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjHDQ3a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 12:29:30 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18E149D4;
        Fri,  4 Aug 2023 09:29:26 -0700 (PDT)
X-QQ-mid: bizesmtp63t1691166555tdpbv9cd
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 05 Aug 2023 00:29:14 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: LE7C6P2vL8RUuavYw7rhI2XUZwK4snUu5RXWraK2h7oK/GpZAwUMcj6ycz+kn
        wnzQN8dCxuAjmJxlQrxyDF8Nvjjgh1yYNHWVyuNOdtu5lFYcp4XTe+6bKE9kdj8BpmdoRoj
        WYU+gB09ya1aLyEaGN2SK8jhuLOLqnJ0f8od7k9sXFvXD6HdEGu7qz8w9eukFTpRkK5o0Hq
        K01RoKSV1XoLW47pueOV8xWxjehzfJaXnEDlxIeAvyQHMI2EfOEWfE/6xqz5nj7LBax2meX
        xfI953exVCEW1lClszFQF8tzDM4f1vULbrV1ZW0BeksYPyABvEgf/1RzF988K+c8ky3u7pa
        tkk+p0jkwC3+3GYtqdqy6wnAoM+SmCZs+bqmngI
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12427017400466547691
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org, w@1wt.eu
Subject: Re: [PATCH v1 2/3] selftests/nolibc: fix up O= option support
Date:   Sat,  5 Aug 2023 00:29:10 +0800
Message-Id: <20230804162910.305533-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <500504f6-fed1-45a4-a518-4631a6f3e463@t-8ch.de>
References: <500504f6-fed1-45a4-a518-4631a6f3e463@t-8ch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> On 2023-08-04 23:52:18+0800, Zhangjin Wu wrote:
> > > On 2023-08-04 15:43:42+0800, Zhangjin Wu wrote:
> > > > Hi, Thomas
> > > > 
> > > > > On 2023-08-03 22:45:52+0800, Zhangjin Wu wrote:
> > > > > > To avoid pollute the source code tree and avoid mrproper for every
> > > > > > architecture switch, the O= argument must be supported.
> > > > > > 
> > > > > > Both IMAGE and .config are from the building directory, let's use
> > > > > > objtree instead of srctree for them.
> > > > > > 
> > > > > > If no O= option specified, means building kernel in source code tree,
> > > > > > objtree should be srctree in such case.
> > > > > > 
> > > > > > Suggested-by: Willy Tarreau <w@1wt.eu>
> > > > > > Link: https://lore.kernel.org/lkml/ZK0AB1OXH1s2xYsh@1wt.eu/
> > > > > > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > > > > > ---
> > > > > >  tools/testing/selftests/nolibc/Makefile | 7 +++++--
> > > > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> > > > > > index 51fef5e6a152..af590aee063a 100644
> > > > > > --- a/tools/testing/selftests/nolibc/Makefile
> > > > > > +++ b/tools/testing/selftests/nolibc/Makefile
> > > > > > @@ -9,6 +9,9 @@ ifeq ($(srctree),)
> > > > > >  srctree := $(patsubst %/tools/testing/selftests/,%,$(dir $(CURDIR)))
> > > > > >  endif
> > > > > >  
> > > > > > +# add objtree for O= argument, required by IMAGE and .config
> > > > > > +objtree ?= $(srctree)
> > > > > 
> > > > > Isn't this already set by the included tools/scripts/Makefile.include?
> > > > >
> > > > 
> > > > Good question, but it is empty if no O= specified, checked it several
> > > > times before ;-)
> > > 
> > > For me it is not empty when I am in tools/testing/selftests/nolibc/.
> > >
> > 
> > Interesting, here is the code I added to check the value:
> > 
> >     diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> >     index 22f1e1d73fa8..1ae19e896e24 100644
> >     --- a/tools/testing/selftests/nolibc/Makefile
> >     +++ b/tools/testing/selftests/nolibc/Makefile
> >     @@ -12,6 +12,8 @@ include $(srctree)/scripts/subarch.include
> >      ARCH = $(SUBARCH)
> >      endif
> >     
> >     +$(error objtree=$(objtree), srctree=$(srctree))
> >     +
> > 
> > Whenever I do defconfig or run,
> > 
> >     $ make help
> >     Makefile:15: *** objtree=, srctree=/labs/linux-lab/src/linux-stable.  Stop.
> > 
> > It is only not empty when we pass O explicitly:
> > 
> >     $ mkdir out
> >     $ make help O=out
> >     Makefile:15: *** objtree=out, srctree=/labs/linux-lab/src/linux-stable.  Stop.
> >     $ make help O=$PWD/out
> >     Makefile:15: *** objtree=/labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/out, srctree=/labs/linux-lab/src/linux-stable.  Stop.
> 
> Welp, now it's the same for me.
> I guess I messed it up before, maybe I forgot to remove your changes
> while testing?
> 
> Anyways instead of having to manually do stuff with $(objtree) we could
> also use $(OUTPUT)$(IMAGE) to always get the correct image.
>

Do you mean here?

    # kernel image names by architecture
    IMAGE_i386    = arch/x86/boot/bzImage
    IMAGE_x86     = arch/x86/boot/bzImage
    IMAGE_arm64   = arch/arm64/boot/Image
    IMAGE_arm     = arch/arm/boot/zImage
    IMAGE_mips    = vmlinuz
    IMAGE_riscv   = arch/riscv/boot/Image
    IMAGE         = $(IMAGE_$(ARCH))
    IMAGE_NAME    = $(notdir $(IMAGE))

It does save another KERNEL_IMAGE macro in my future patch ;-)

But without O=, OUTPUT is also empty like objtree and when empty, it is
assigned as $(CURDIR), not $(srctree) as we expected for IMAGE and .config. To
be cleaner, objtree should also be used:

    - IMAGE         = $(IMAGE_$(ARCH))
    + IMAGE         = $(objtree)/$(IMAGE_$(ARCH))

Is this what you want?

Thanks!
Zhangjin

> > [..]
> > 
> > After align the empty objtree value with you, will renew this patch.
> 
> Thanks!
> Thomas
