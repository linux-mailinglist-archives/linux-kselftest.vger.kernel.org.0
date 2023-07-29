Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A34A7680A5
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 18:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjG2QzH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Jul 2023 12:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjG2QzG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Jul 2023 12:55:06 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6742D54;
        Sat, 29 Jul 2023 09:55:03 -0700 (PDT)
X-QQ-mid: bizesmtp69t1690649693td9lhmbx
Received: from linux-lab-host.localdomain ( [61.141.77.223])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 30 Jul 2023 00:54:52 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: pVSBwIr5Ck/hWsOQZZGD2ywSC42wKWeZyFyoFfy3Qx2xcdkDLhUYOKLvfc6gd
        3UAbjcnYGu47bezZHMm/EpnCl0msf668Op55WVUtLxwXvJbJsHIQThUOrRmYtqAQV3bOa8z
        Qbjxp2qLAo7t5ngoA8IMi/OxYl7br8y5zSxwH4JHd6hKZExaKUvsk5ysRyT2NflIcJLBWXM
        BH8q2AS5JZHeWp7JcJjJsMrE3RT1tFsfWOuoXvL5tJjubEeqgFTG7gZceVsmcpLIU60EX4f
        0gbuTAEDcrRbRy6kkPzDe5FPMXCF/PFM2TEdVv/dGvH1DxYSXB6F/KZQzdsBUwRgO+YplGY
        7N5DTidNM0guwBwLdY=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15089285918231050864
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v3 3/7] selftests/nolibc: add extra configs customize support
Date:   Sun, 30 Jul 2023 00:54:45 +0800
Message-Id: <20230729165445.88073-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230729162907.GA5219@1wt.eu>
References: <20230729162907.GA5219@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> On Sat, Jul 29, 2023 at 10:39:33PM +0800, Zhangjin Wu wrote:
> > > > diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> > > > index f42adef87e12..9576f1a0a98d 100644
> > > > --- a/tools/testing/selftests/nolibc/Makefile
> > > > +++ b/tools/testing/selftests/nolibc/Makefile
> > > > @@ -39,6 +39,9 @@ DEFCONFIG_s390       = defconfig
> > > >  DEFCONFIG_loongarch  = defconfig
> > > >  DEFCONFIG            = $(DEFCONFIG_$(ARCH))
> > > >  
> > > > +# extra kernel config files under configs/, include common + architecture specific
> > > > +EXTCONFIG            = common.config $(ARCH).config
> > > 
> > > As this series seems to need a respin anyways:
> > > 
> > > extconfig means "extended config", correct?
> > > That is fairly nondescript.
> > >
> > 
> > It is more about 'extra' as commented (or 'additional'), for both
> > defconfig (may) and tinyconfig (must) require more options to make boot
> > and print work for nolibc-test.
> >          
> >     defconfig ------\
> >                      \
> >                       \
> >                       EXTCONFIG ----> a working .config for nolibc-test
> >                       /
> >                      /
> >     tinyconfig------/
> > 
> > > I would prefer something like "NOLIBC_TEST_CONFIG"
> > >
> > 
> > Using NOLIBC_TEST_CONFIG is ok, but with this name, do we still only put
> > the 'additional' options there? or we simply use EXTRA_CONFIG instead?
> > 
> >     # extra kernel config files under configs/, include common + architecture specific
> >     EXTRA_CONFIG       = common.config $(ARCH).config
> 
> Either are fine to me. The most important is to mention that these
> configs are appended to the config during the defconfig and tinyconfig
> targets.
>

Ok, will update the comment to something like this:

     # extra configs/ files appended to .config during the defconfig and tinyconfig targets
     # include common parts + architecture specific parts
     EXTRA_CONFIG       = common.config $(ARCH).config


> Also I find it odd to use $(ARCH) here, I would have expected $(XARCH)
> since you probably want to distinguish ppc64 from ppc for example.
>

Yes, we do, but the XARCH and ARCH mmapping patch is the 4th, will
update this to XARCH, this one is the 3th one, do we need to add this
one after the 4th one?

> > > something like "make nolibctestconfig" to make an existing config ready for
> > > nolibc-test.
> > 
> > Do you mean rename 'defconfig' to 'nolibctestconfig'? or something
> > nolibc-test-config:
> > 
> >     nolibc-test-config:
> > 	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
> > 	$(Q)$(srctree)/scripts/kconfig/merge_config.sh -O "$(srctree)" -m "$(srctree)/.config" $(foreach c,$(EXTRA_CONFIG),$(wildcard $(CURDIR)/configs/$c))
> > 	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) KCONFIG_ALLCONFIG="$(srctree)/.config" allnoconfig
> > 
> > It looks too long ;-)
> 
> I think that as long as we don't claim to call topdir's makefile targets
> from this directory, we can reuse some similarly named targets which are
> documented in "make help" and are non-ambiguous.

Seems 'nolibc-test-config' is really more meaningful than 'defconfig', especially
when we want to use tinyconfig through it?

    $ make nolibc-test-config DEFCONFIG=tinyconfig

> 
> > Currently, we use 'defconfig' by default and we use 'make defconfig
> > DEFCONFIG=tinyconfig' to switch to tinyconfig, in the next weeks, when
> > all of the nolibc supported architectures have tinyconfig support, it is
> > able to switch 'tinyconfig' as the default config target.
> 
> As long as it doesn't require to locally maintain too many options, I
> think I'm fine with that. But we'll see.

Ok.

Thanks,
Zhangjin

> 
> Willy
