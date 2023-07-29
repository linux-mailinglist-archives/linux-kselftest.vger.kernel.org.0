Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED386768098
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 18:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjG2Q3T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Jul 2023 12:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjG2Q3T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Jul 2023 12:29:19 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A989D1FF0;
        Sat, 29 Jul 2023 09:29:17 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36TGT7bV005278;
        Sat, 29 Jul 2023 18:29:07 +0200
Date:   Sat, 29 Jul 2023 18:29:07 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     thomas@t-8ch.de, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 3/7] selftests/nolibc: add extra configs customize
 support
Message-ID: <20230729162907.GA5219@1wt.eu>
References: <74f6a3b5-666c-41e9-a3d5-0ed5457f20f5@t-8ch.de>
 <20230729143933.14462-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729143933.14462-1-falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jul 29, 2023 at 10:39:33PM +0800, Zhangjin Wu wrote:
> > > diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> > > index f42adef87e12..9576f1a0a98d 100644
> > > --- a/tools/testing/selftests/nolibc/Makefile
> > > +++ b/tools/testing/selftests/nolibc/Makefile
> > > @@ -39,6 +39,9 @@ DEFCONFIG_s390       = defconfig
> > >  DEFCONFIG_loongarch  = defconfig
> > >  DEFCONFIG            = $(DEFCONFIG_$(ARCH))
> > >  
> > > +# extra kernel config files under configs/, include common + architecture specific
> > > +EXTCONFIG            = common.config $(ARCH).config
> > 
> > As this series seems to need a respin anyways:
> > 
> > extconfig means "extended config", correct?
> > That is fairly nondescript.
> >
> 
> It is more about 'extra' as commented (or 'additional'), for both
> defconfig (may) and tinyconfig (must) require more options to make boot
> and print work for nolibc-test.
>          
>     defconfig ------\
>                      \
>                       \
>                       EXTCONFIG ----> a working .config for nolibc-test
>                       /
>                      /
>     tinyconfig------/
> 
> > I would prefer something like "NOLIBC_TEST_CONFIG"
> >
> 
> Using NOLIBC_TEST_CONFIG is ok, but with this name, do we still only put
> the 'additional' options there? or we simply use EXTRA_CONFIG instead?
> 
>     # extra kernel config files under configs/, include common + architecture specific
>     EXTRA_CONFIG       = common.config $(ARCH).config

Either are fine to me. The most important is to mention that these
configs are appended to the config during the defconfig and tinyconfig
targets.

Also I find it odd to use $(ARCH) here, I would have expected $(XARCH)
since you probably want to distinguish ppc64 from ppc for example.

> > something like "make nolibctestconfig" to make an existing config ready for
> > nolibc-test.
> 
> Do you mean rename 'defconfig' to 'nolibctestconfig'? or something
> nolibc-test-config:
> 
>     nolibc-test-config:
> 	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
> 	$(Q)$(srctree)/scripts/kconfig/merge_config.sh -O "$(srctree)" -m "$(srctree)/.config" $(foreach c,$(EXTRA_CONFIG),$(wildcard $(CURDIR)/configs/$c))
> 	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) KCONFIG_ALLCONFIG="$(srctree)/.config" allnoconfig
> 
> It looks too long ;-)

I think that as long as we don't claim to call topdir's makefile targets
from this directory, we can reuse some similarly named targets which are
documented in "make help" and are non-ambiguous.

> Currently, we use 'defconfig' by default and we use 'make defconfig
> DEFCONFIG=tinyconfig' to switch to tinyconfig, in the next weeks, when
> all of the nolibc supported architectures have tinyconfig support, it is
> able to switch 'tinyconfig' as the default config target.

As long as it doesn't require to locally maintain too many options, I
think I'm fine with that. But we'll see.

Willy
