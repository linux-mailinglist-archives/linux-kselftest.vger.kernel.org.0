Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2519767CFA
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 09:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjG2Hyo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Jul 2023 03:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjG2Hym (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Jul 2023 03:54:42 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3464149E3;
        Sat, 29 Jul 2023 00:54:06 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36T7roZS004303;
        Sat, 29 Jul 2023 09:53:50 +0200
Date:   Sat, 29 Jul 2023 09:53:50 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v2 08/14] selftests/nolibc: string the core targets
Message-ID: <20230729075350.GI956@1wt.eu>
References: <20230722125758.GJ17311@1wt.eu>
 <20230725142017.37103-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725142017.37103-1-falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 25, 2023 at 10:20:17PM +0800, Zhangjin Wu wrote:
> > On Wed, Jul 19, 2023 at 09:26:01PM +0800, Zhangjin Wu wrote:
> > > To avoid run targets one by one manually and boringly, let's string them
> > > with IMAGE and .config, the MAKE command will trigger the dependencies
> > > for us.
> > > 
> > > Note, to allow do menuconfig before extconfig manually, only trigger
> > > defconfig while the .config is not there, it means only trigger
> > > defconfig for the first run or after a mrproper.
> > > 
> > > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > > ---
> > >  tools/testing/selftests/nolibc/Makefile | 18 +++++++++++++-----
> > >  1 file changed, 13 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> > > index 83cb4b017bef..541f3565e584 100644
> > > --- a/tools/testing/selftests/nolibc/Makefile
> > > +++ b/tools/testing/selftests/nolibc/Makefile
> > (...)
> > > -extconfig:
> > > +extconfig: $(KERNEL_CONFIG)
> > >  	$(Q)$(srctree)/scripts/kconfig/merge_config.sh -O "$(objtree)" -m "$(KERNEL_CONFIG)" $(foreach c,$(EXTCONFIG),$(wildcard $(CURDIR)/configs/$c))
> > >  	$(Q)$(MAKE_KERNEL) KCONFIG_ALLCONFIG="$(KERNEL_CONFIG)" allnoconfig
> > >  
> > > -kernel: initramfs
> > > +kernel: extconfig
> > > +	$(Q)$(MAKE) --no-print-directory initramfs
> > 
> > There seems to be something wrong here. From what I'm seeing, now if I
> > run "make kernel" it will run extconfig and possibly change the config
> > I just edited.
> >
> 
> Yeah, extconfig will run for every 'make kernel', it is ok for us to
> let kernel depends on $(KERNEL_CONFIG), but this requires users to run
> extconfig explictly, the solution may be:
> 
> - move extconfig operations to defconfig target and future tinyconfig target (it looks cleaner ...)
> 
>     - but it is not convenient to trigger additional changes introduced by
>       extconfig, not necessary, but really helpful, something like 'menuconfig'
> 
> - let users run extconfig manually after a defconfig or tinyconfig (it is a little complex)
> 
>     - this make users hard to learn what to do, should give up this method
> 
> - run extconfig for every 'make kernel' as it currently do
> 
>     - this may change something after a menuconfig, but it only trigger minimal
>       required options, the 'hurt' should be minimal, but of course, it may confuse sometimes ;-(
> 
> As a summary, let's remove 'extconfig' and move its operations to the defconfig
> and the future tinyconfig targets? 'extconfig' should be a 'default' config
> action, let users apply additional ones manually from the top-level 'make
> menuconfig', what's your idea?

Well, it's important to apply the principle of least surprise for the
user. You're a developer who spent time working on your config, you
believe it's OK and you just remind that you've heard about that nolibc
test thing recently and you think "why not give it a try in case it spots
something I forgot in my config". Then you just run the test there and
once done your config was secretly modified. This is exactly an example
of what *not* to do. We should never modify user's config nor files in
general without an explicit request from the user. If the user types
"make defconfig", they're implicitly requesting to replace the config,
so we can do what we want with it. If they type "make kernel", they
expect to make a kernel based on this config, not to mollest this
precious config file and then make a kernel out of it.

So I'm fine with the idea of adding config snippets on top of defconfig
and tinyconfig to allow the user to generate a working config for a
given architecture, but not for modifying their config without their
consent.

Willy
