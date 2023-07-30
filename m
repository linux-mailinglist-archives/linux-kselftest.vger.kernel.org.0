Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C6A7683F5
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Jul 2023 08:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjG3GBr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 30 Jul 2023 02:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjG3GBr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 30 Jul 2023 02:01:47 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7FAE54;
        Sat, 29 Jul 2023 23:01:44 -0700 (PDT)
X-QQ-mid: bizesmtp74t1690696892th7eegw6
Received: from linux-lab-host.localdomain ( [61.141.77.223])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 30 Jul 2023 14:01:31 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: C46Rb8GPIEe/Ikyn45rvImSQRmKMGeZXGbSZG+6+Ymz5ZfNw+uXbW0qXtNpGb
        g4I2VVzUTF/tTxAxbLCKC3o55t48nividTiInTMxDeBinUNWOLyukoFUtIZhn5Xhz6vEmQa
        IvMiDFmX9ZGVZf4gswOtNf+6hthjFubCq8f7GCitA9us0gduWv5Ef8tobRkgNd6s7L+zMQF
        +ci2uxWD/zoUYvY/OahWfyg+6IUR1Sdv4JdlcUXZw3jBfcOgs/R2wiRjSuPL1f2UVPK5Br1
        mQXPNZf/Qf0UK9btzbvBRSfdGugbOgHjGyyaWnnl0VYf8pMVLpxyrDARq93hle3q4YO8Awv
        50n0I8XTPHrUH1K7xCowZ+KmkDl2Nk/M6JI1WUPJ0eHryt/KTfMq6WYPqDmew==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2246986968494971703
From:   Zhangjin Wu <falcon@tinylab.org>
To:     falcon@tinylab.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de, w@1wt.eu
Subject: Re: [PATCH v3 3/7] selftests/nolibc: add extra configs customize support
Date:   Sun, 30 Jul 2023 14:01:31 +0800
Message-Id: <20230730060131.10061-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230730045407.8804-1-falcon@tinylab.org>
References: <20230730045407.8804-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy, Thomas

> > On Sun, Jul 30, 2023 at 12:54:45AM +0800, Zhangjin Wu wrote:
> > > > Also I find it odd to use $(ARCH) here, I would have expected $(XARCH)
> > > > since you probably want to distinguish ppc64 from ppc for example.
> > > >
> > > 
> > > Yes, we do, but the XARCH and ARCH mmapping patch is the 4th, will
> > > update this to XARCH, this one is the 3rd one, do we need to add this
> > > one after the 4th one?
> > 
> > OK indeed it's the 4th one that will modify this one then, no need
> > to reorder.
> > 
> > > > > > something like "make nolibctestconfig" to make an existing config ready for
> > > > > > nolibc-test.
> > > > > 
> > > > > Do you mean rename 'defconfig' to 'nolibctestconfig'? or something
> > > > > nolibc-test-config:
> > > > > 
> > > > >     nolibc-test-config:
> > > > > 	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
> > > > > 	$(Q)$(srctree)/scripts/kconfig/merge_config.sh -O "$(srctree)" -m "$(srctree)/.config" $(foreach c,$(EXTRA_CONFIG),$(wildcard $(CURDIR)/configs/$c))
> > > > > 	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) KCONFIG_ALLCONFIG="$(srctree)/.config" allnoconfig
> > > > > 
> > > > > It looks too long ;-)
> > > > 
> > > > I think that as long as we don't claim to call topdir's makefile targets
> > > > from this directory, we can reuse some similarly named targets which are
> > > > documented in "make help" and are non-ambiguous.
> > > 
> > > Seems 'nolibc-test-config' is really more meaningful than 'defconfig', especially
> > > when we want to use tinyconfig through it?
> > > 
> > >     $ make nolibc-test-config DEFCONFIG=tinyconfig
> > 
> > As a user, I'd ask "why not make tinyconfig" ? But see my other message,
> > now I'm having strong doubts about the relevance of tinyconfig if it works
> > as bad as you described it.
> >
> 
> I have added a nolibc tinyconfig target before, as the same reason,
> based on your suggestion, I have removed the tinyconfig target and even
> moved the extconfig to this defconfig to avoid add more similar or extra
> complex targets in nolibc Makefile. before, tinyconfig + extconfig
> together work for nolibc-test, so, tinyconfig is the same as the
> top-level one, it should be removed as your suggested.
> 
> But since now, we are ready to get a real different target from the
> top-level one, we may be able to have different targets for
> 'defconfig+EXTRA_CONFIG' and 'tinyconfig+EXTRA_CONFIG' like this:
> 
>     nolibc-test-config:
>             $(Q)echo $(MAKE_KERNEL) mrproper $(or $(CONFIG),defconfig)

It should be $(or $(CONFIG),$(DEFCONFIG))

>             $(Q)echo $(srctree)/scripts/kconfig/merge_config.sh -Q -O "$(objtree)" -m "$(KERNEL_CONFIG)" $(foreach c,$(EXTRA_CONFIG),$(wildcard $(CURDIR)/configs/$c))
>             $(Q)echo $(MAKE_KERNEL) KCONFIG_ALLCONFIG="$(KERNEL_CONFIG)" allnoconfig
>             $(Q)echo $(MAKE_KERNEL) prepare
> 
>     nolibc-test-defconfig nolibc-test-tinyconfig: nolibc-test-config
>     nolibc-test-tinyconfig: CONFIG=tinyconfig
>

The above two are not really required in this powerpc series, let's delay them
to the next tinyconfig part1 series.

In this series, we only need:

     nolibc-test-config:
             $(Q)$(MAKE_KERNEL) mrproper $(or $(CONFIG),$(DEFCONFIG))
             $(Q)$(srctree)/scripts/kconfig/merge_config.sh -Q -O "$(objtree)" -m "$(KERNEL_CONFIG)" $(foreach c,$(EXTRA_CONFIG),$(wildcard $(CURDIR)/configs/$c))
             $(Q)$(MAKE_KERNEL) KCONFIG_ALLCONFIG="$(KERNEL_CONFIG)" allnoconfig
             $(Q)$(MAKE_KERNEL) prepare

And this:

    # extra configs/ files appended to .config during the nolibc-test-config target
    # include common + architecture specific
    EXTRA_CONFIG         = common.config $(XARCH).config

And the update of the help target too.

If both of you are happy with this? let's do it ;-)

Best regards,
Zhangjin

> The complexity here is we have planned to support both defconfig and
> tinyconfig, what about this solution?
> 
> Thanks,
> Zhangjin
>
> > Willy
