Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F497770759
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 19:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjHDRyp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 13:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjHDRyo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 13:54:44 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E6A7198B;
        Fri,  4 Aug 2023 10:54:42 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 374HsTm7031321;
        Fri, 4 Aug 2023 19:54:29 +0200
Date:   Fri, 4 Aug 2023 19:54:29 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     Zhangjin Wu <falcon@tinylab.org>, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tanyuan@tinylab.org
Subject: Re: [PATCH v1 2/3] selftests/nolibc: fix up O= option support
Message-ID: <20230804175429.GC31163@1wt.eu>
References: <500504f6-fed1-45a4-a518-4631a6f3e463@t-8ch.de>
 <20230804162910.305533-1-falcon@tinylab.org>
 <d909cf7d-a7b0-4830-89cf-64e8980c4c32@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d909cf7d-a7b0-4830-89cf-64e8980c4c32@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 04, 2023 at 07:51:50PM +0200, Thomas Weißschuh wrote:
> On 2023-08-05 00:29:10+0800, Zhangjin Wu wrote:
> > > On 2023-08-04 23:52:18+0800, Zhangjin Wu wrote:
> > > > > On 2023-08-04 15:43:42+0800, Zhangjin Wu wrote:
> > > > > > Hi, Thomas
> > > > > > 
> > > > > > > On 2023-08-03 22:45:52+0800, Zhangjin Wu wrote:
> > > > > > > > To avoid pollute the source code tree and avoid mrproper for every
> > > > > > > > architecture switch, the O= argument must be supported.
> > > > > > > > 
> > > > > > > > Both IMAGE and .config are from the building directory, let's use
> > > > > > > > objtree instead of srctree for them.
> > > > > > > > 
> > > > > > > > If no O= option specified, means building kernel in source code tree,
> > > > > > > > objtree should be srctree in such case.
> > > > > > > > 
> > > > > > > > Suggested-by: Willy Tarreau <w@1wt.eu>
> > > > > > > > Link: https://lore.kernel.org/lkml/ZK0AB1OXH1s2xYsh@1wt.eu/
> > > > > > > > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > > > > > > > ---
> > > > > > > >  tools/testing/selftests/nolibc/Makefile | 7 +++++--
> > > > > > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > > > > > > 
> > > > > > > > diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> > > > > > > > index 51fef5e6a152..af590aee063a 100644
> > > > > > > > --- a/tools/testing/selftests/nolibc/Makefile
> > > > > > > > +++ b/tools/testing/selftests/nolibc/Makefile
> > > > > > > > @@ -9,6 +9,9 @@ ifeq ($(srctree),)
> > > > > > > >  srctree := $(patsubst %/tools/testing/selftests/,%,$(dir $(CURDIR)))
> > > > > > > >  endif
> > > > > > > >  
> > > > > > > > +# add objtree for O= argument, required by IMAGE and .config
> > > > > > > > +objtree ?= $(srctree)
> > > > > > > 
> > > > > > > Isn't this already set by the included tools/scripts/Makefile.include?
> > > > > > >
> > > > > > 
> > > > > > Good question, but it is empty if no O= specified, checked it several
> > > > > > times before ;-)
> > > > > 
> > > > > For me it is not empty when I am in tools/testing/selftests/nolibc/.
> > > > >
> > > > 
> > > > Interesting, here is the code I added to check the value:
> > > > 
> > > >     diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> > > >     index 22f1e1d73fa8..1ae19e896e24 100644
> > > >     --- a/tools/testing/selftests/nolibc/Makefile
> > > >     +++ b/tools/testing/selftests/nolibc/Makefile
> > > >     @@ -12,6 +12,8 @@ include $(srctree)/scripts/subarch.include
> > > >      ARCH = $(SUBARCH)
> > > >      endif
> > > >     
> > > >     +$(error objtree=$(objtree), srctree=$(srctree))
> > > >     +
> > > > 
> > > > Whenever I do defconfig or run,
> > > > 
> > > >     $ make help
> > > >     Makefile:15: *** objtree=, srctree=/labs/linux-lab/src/linux-stable.  Stop.
> > > > 
> > > > It is only not empty when we pass O explicitly:
> > > > 
> > > >     $ mkdir out
> > > >     $ make help O=out
> > > >     Makefile:15: *** objtree=out, srctree=/labs/linux-lab/src/linux-stable.  Stop.
> > > >     $ make help O=$PWD/out
> > > >     Makefile:15: *** objtree=/labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/out, srctree=/labs/linux-lab/src/linux-stable.  Stop.
> > > 
> > > Welp, now it's the same for me.
> > > I guess I messed it up before, maybe I forgot to remove your changes
> > > while testing?
> > > 
> > > Anyways instead of having to manually do stuff with $(objtree) we could
> > > also use $(OUTPUT)$(IMAGE) to always get the correct image.
> > >
> > 
> > Do you mean here?
> > 
> >     # kernel image names by architecture
> >     IMAGE_i386    = arch/x86/boot/bzImage
> >     IMAGE_x86     = arch/x86/boot/bzImage
> >     IMAGE_arm64   = arch/arm64/boot/Image
> >     IMAGE_arm     = arch/arm/boot/zImage
> >     IMAGE_mips    = vmlinuz
> >     IMAGE_riscv   = arch/riscv/boot/Image
> >     IMAGE         = $(IMAGE_$(ARCH))
> >     IMAGE_NAME    = $(notdir $(IMAGE))
> > 
> > It does save another KERNEL_IMAGE macro in my future patch ;-)
> > 
> > But without O=, OUTPUT is also empty like objtree and when empty, it is
> > assigned as $(CURDIR), not $(srctree) as we expected for IMAGE and .config. To
> > be cleaner, objtree should also be used:
> > 
> >     - IMAGE         = $(IMAGE_$(ARCH))
> >     + IMAGE         = $(objtree)/$(IMAGE_$(ARCH))
> > 
> > Is this what you want?
> 
> More like:
> 
> -	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
> +	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(OUTPUT)$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
> 
> My assumption was that it's weird that we need to define such variables
> ourselves.
> 
> Using an empty $(OUTPUT) would have been fine if make is run from the
> root of the kernel tree. But that is not the case.
> 
> It still feels weird but I can't think of a nicer way, and it's not
> a big issue. So let's keep that part the same.
> 
> Or maybe Willy has a better idea.

I've just glanced over the discussion, but I'm wondering, why not
"$(objtree)/$(IMAGE)" instead ?

Willy
