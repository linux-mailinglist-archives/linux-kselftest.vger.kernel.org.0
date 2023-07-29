Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E3B767D1D
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 10:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjG2IWQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Jul 2023 04:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjG2IWQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Jul 2023 04:22:16 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D073A4223;
        Sat, 29 Jul 2023 01:22:14 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36T8M63x004391;
        Sat, 29 Jul 2023 10:22:06 +0200
Date:   Sat, 29 Jul 2023 10:22:06 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v2 05/14] selftests/nolibc: add menuconfig for development
Message-ID: <20230729082206.GK956@1wt.eu>
References: <20230725135106.36543-1-falcon@tinylab.org>
 <20230727132418.117924-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727132418.117924-1-falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin,

On Thu, Jul 27, 2023 at 09:24:18PM +0800, Zhangjin Wu wrote:
> Hi, Willy
> 
> > > On Wed, Jul 19, 2023 at 09:22:37PM +0800, Zhangjin Wu wrote:
> > > > The default DEFCONFIG_<ARCH> may not always work for all architectures,
> > > > let's allow users to tune some kernel config options with 'menuconfig'.
> > > > 
> > > > This is important when porting nolibc to a new architecture, it also
> > > > allows to speed up nolibc 'run' target testing via manually disabling
> > > > tons of unnecessary kernel config options.
> > > > 
> > > > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > > > ---
> > > >  tools/testing/selftests/nolibc/Makefile | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> > > > index 058e7be070ea..06954b4b3885 100644
> > > > --- a/tools/testing/selftests/nolibc/Makefile
> > > > +++ b/tools/testing/selftests/nolibc/Makefile
> > > > @@ -202,6 +202,9 @@ KERNEL_IMAGE  = $(objtree)/$(IMAGE)
> > > >  defconfig:
> > > >  	$(Q)$(MAKE_KERNEL) mrproper $(DEFCONFIG) prepare
> > > >  
> > > > +menuconfig:
> > > > +	$(Q)$(MAKE_KERNEL) menuconfig
> > > 
> > > What is the real benefit of this compared to just running the
> > > standard "make menuconfig" ? We should avoid adding makefile targets
> > > that do not bring value on top of that the top-level makefile does,
> > > because it will make the useful ones much harder to spot, and will
> > > tend to encourage users to use only that makefile during the tests,
> > > which is a bad practice since many targets will always be missing
> > > or work differently. It's important in my opinion that we strictly
> > > stick to what is useful to operate the tests themselves and this
> > > one doesn't make me feel like it qualifies as such.
> > 
> > Ok, get it.
> > 
> > I did like develop nolibc in tools/testing/selftests/nolibc/ without
> > changing directories frequently or specifying the "-C" option
> > unnecessary ;-) 
> >
> > Since "make menuconfig" is only required during the first porting of a new
> > architecture, so, it is ok to drop this patch.
> >
> 
> Oh, Willy, I did find this is very important again.
> 
> I just want to check and test if we need to disable vsx for 32-bit
> powerpc too, so, I plan to re-configure kernel via menuconfig to disable
> VSX in kernel side, and forcely enable vsx in application side, but it
> was very 'painful' when I was running something like this:
> 
>     $ make defconfig ARCH=ppc CROSS_COMPILE=powerpc-linux-gnu-
> 
> To do a further menuconfig, I must switch to something else:
> 
>     $ make menuconfig ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- -C ../../../../
> 
> Especially, our test is able to accept ARCH=ppc, but the top-level
> kernel still only accept powerpc, it makes the development very
> comfortable, of course, the typing of the relative or absolute path
> every time is either not a good idea.

It is "able" but that's not what ought to be used, since it's going to
be remapped to "powerpc". You're supposed to use XARCH for this one
since it's a variant (we could find other names if needed). I suspect
it just shows that the "override ARCH :=" is excessive and should not
be there. Usually when you put override in a makefile, it's going to
pop up as a bug elsewhere. Thus actually you could very well have :

   make ARCH=powerpc XARCH=ppc CROSS_COMPILE=powerpc-linux-gnu-

as the prefix for all your commands. Some will prefer to work directly
from the kernel dir:

 $ make ARCH=powerpc XARCH=ppc CROSS_COMPILE=powerpc-linux-gnu- -C tools/testing/selftests/nolibc-test defconfig
 $ make ARCH=powerpc XARCH=ppc CROSS_COMPILE=powerpc-linux-gnu- menuconfig

Others would do it from the nolibc-test dir as you did above.

> so, this doesn't simply duplicate with the one from top-level, it can
> get the right ARCH, srctree for us, and this is heavily used by our
> tinyconfig development to tune the config options very frequently, so,
> let's still add this one in the new revision?

I'm not *fundamentally* opposed to menuconfig, I just think that it's
appearing at the wrong place. Why not oldconfig, allmodconfig, randconfig,
allnoconfig etc then ? There is nothing in the test directory that is
supposed to be used interactively, either it's run in a batch for cross-
arch testing, or you use it to validate your kernel when you're working
on it. It feels strange that one would want to configure their kernel
from this sub-dir.

> But I plan to merge the mrproper targets here to save another patch,
> what about your idea?
> 
>     menuconfig mrproper:
> 	$(Q)$(MAKE_KERNEL) $@

Please no. Someone doing that in hope to clean only the result of
the tests would in fact ruin their config:

  $ make -C tools/testing/selftests/nolibc-test mrproper

This is another reason for not encouraging users to develop from
within that dir.

Willy
