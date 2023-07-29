Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DAD767DC0
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 11:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjG2JzH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Jul 2023 05:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjG2JzG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Jul 2023 05:55:06 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FA0DE;
        Sat, 29 Jul 2023 02:55:03 -0700 (PDT)
X-QQ-mid: bizesmtp80t1690624492t9pb4m4v
Received: from linux-lab-host.localdomain ( [61.141.77.223])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 29 Jul 2023 17:54:51 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: +ynUkgUhZJlUWjmJrhkR8ZfRuQvnzOPLsUO0Ksbrk8ZQRWIPtYKYajNJkh2An
        YaXO2deswIQaTG9PPFNidjEJBs7cBZDgQ6dcwkHlf/na0TOINStKPkSXGSNrfiBwcAI0M0e
        Hl/i0XBsFWc1A8KyAoP5V/d85FwboZ5VOrBwgXh8LwDLojZWK5yw6EBBYImNHAkzlq4NueX
        ZQsl2t6Bhw9+Qafp9M7aMxHxeWnXLsSY/8jVS1QarMR39sLRCfm+sjpNw4Gnmv4l99IjHBY
        TsRFJbBYcUSE1HtqIPANZMRhKp83B3PYs3QTLH2PvkbAnUIsIL5Gys3EDWIBPUReuuJo+kY
        snQD/nuJ92GGCIbC64zOd9wYnJpylQEG3tIv+qvLpq/cbrfkdo02CSb5H9tUsSneXqr3Nb0
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18287168896968025951
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v2 08/14] selftests/nolibc: string the core targets
Date:   Sat, 29 Jul 2023 17:54:47 +0800
Message-Id: <20230729095447.9414-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230729075350.GI956@1wt.eu>
References: <20230729075350.GI956@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> On Tue, Jul 25, 2023 at 10:20:17PM +0800, Zhangjin Wu wrote:
> > > On Wed, Jul 19, 2023 at 09:26:01PM +0800, Zhangjin Wu wrote:
> > > > To avoid run targets one by one manually and boringly, let's string them
> > > > with IMAGE and .config, the MAKE command will trigger the dependencies
> > > > for us.
> > > > 
> > > > Note, to allow do menuconfig before extconfig manually, only trigger
> > > > defconfig while the .config is not there, it means only trigger
> > > > defconfig for the first run or after a mrproper.
> > > > 
> > > > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > > > ---
> > > >  tools/testing/selftests/nolibc/Makefile | 18 +++++++++++++-----
> > > >  1 file changed, 13 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> > > > index 83cb4b017bef..541f3565e584 100644
> > > > --- a/tools/testing/selftests/nolibc/Makefile
> > > > +++ b/tools/testing/selftests/nolibc/Makefile
> > > (...)
> > > > -extconfig:
> > > > +extconfig: $(KERNEL_CONFIG)
> > > >  	$(Q)$(srctree)/scripts/kconfig/merge_config.sh -O "$(objtree)" -m "$(KERNEL_CONFIG)" $(foreach c,$(EXTCONFIG),$(wildcard $(CURDIR)/configs/$c))
> > > >  	$(Q)$(MAKE_KERNEL) KCONFIG_ALLCONFIG="$(KERNEL_CONFIG)" allnoconfig
> > > >  
> > > > -kernel: initramfs
> > > > +kernel: extconfig
> > > > +	$(Q)$(MAKE) --no-print-directory initramfs
> > > 
> > > There seems to be something wrong here. From what I'm seeing, now if I
> > > run "make kernel" it will run extconfig and possibly change the config
> > > I just edited.
> > >
> > 
> > Yeah, extconfig will run for every 'make kernel', it is ok for us to
> > let kernel depends on $(KERNEL_CONFIG), but this requires users to run
> > extconfig explictly, the solution may be:
> > 
> > - move extconfig operations to defconfig target and future tinyconfig target (it looks cleaner ...)
> > 
> >     - but it is not convenient to trigger additional changes introduced by
> >       extconfig, not necessary, but really helpful, something like 'menuconfig'
> > 
> > - let users run extconfig manually after a defconfig or tinyconfig (it is a little complex)
> > 
> >     - this make users hard to learn what to do, should give up this method
> > 
> > - run extconfig for every 'make kernel' as it currently do
> > 
> >     - this may change something after a menuconfig, but it only trigger minimal
> >       required options, the 'hurt' should be minimal, but of course, it may confuse sometimes ;-(
> > 
> > As a summary, let's remove 'extconfig' and move its operations to the defconfig
> > and the future tinyconfig targets? 'extconfig' should be a 'default' config
> > action, let users apply additional ones manually from the top-level 'make
> > menuconfig', what's your idea?
> 
> Well, it's important to apply the principle of least surprise for the
> user. You're a developer who spent time working on your config, you
> believe it's OK and you just remind that you've heard about that nolibc
> test thing recently and you think "why not give it a try in case it spots
> something I forgot in my config". Then you just run the test there and
> once done your config was secretly modified. This is exactly an example
> of what *not* to do. We should never modify user's config nor files in
> general without an explicit request from the user. If the user types
> "make defconfig", they're implicitly requesting to replace the config,
> so we can do what we want with it. If they type "make kernel", they
> expect to make a kernel based on this config, not to mollest this
> precious config file and then make a kernel out of it.
> 
> So I'm fine with the idea of adding config snippets on top of defconfig
> and tinyconfig to allow the user to generate a working config for a
> given architecture, but not for modifying their config without their
> consent.
>

Agree, seems our additional config snippets are minimal and 'necessary'
for boot and print, so, I ignored the override issue before.

What about the version in v3 here:
    https://lore.kernel.org/lkml/9b52e26748eda1ac108d569207bf428bf37b3bbc.1690489039.git.falcon@tinylab.org/

The 'defconfig' will only be triggered while there is no .config there,
I do think it is important, at the first time of using nolibc, I
directly run kernel but it fails for it has a manual defconfig
requirement every time, so, I do think a default defconfig for kernel
for the first run or after a mrproper is helpful, it doesn't modify any
.config for there is no one there.

    +PHONY += $(KERNEL_CONFIG)
    +$(KERNEL_CONFIG):
    +	$(Q)if [ ! -f "$(KERNEL_CONFIG)" ]; then $(MAKE) --no-print-directory defconfig; fi
    +
    +kernel: $(KERNEL_CONFIG)
    +	$(Q)$(MAKE) --no-print-directory initramfs
     	$(Q)$(MAKE_KERNEL) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs

Thanks,
Zhangjin

> Willy
