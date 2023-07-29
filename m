Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DEA768019
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 16:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjG2Oj4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Jul 2023 10:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjG2Ojz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Jul 2023 10:39:55 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9366DA8;
        Sat, 29 Jul 2023 07:39:50 -0700 (PDT)
X-QQ-mid: bizesmtp89t1690641579tn77zvfz
Received: from linux-lab-host.localdomain ( [61.141.77.223])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 29 Jul 2023 22:39:38 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: znfcQSa1hKZjpiViFTuRWgMEpZKqDhj3nqrRmmPNH/9FoLxdi73LZbL0g0Mga
        R//aZMcwmBMTcm8ilVjK5zeJIboc8LnqP8vcqiu1Ho8ij2UcgmV8U2dR6qJO0Id9UZOJ0k9
        0PYj3E+a90C1/ScWOfm+3A4YsDPBro49/x6NoIv1gM5wcJaf1FOILqiycHxUx+fOc+3ulHl
        bh/eYK2PFnZFgDaP2pRwNX4ayGwXfzwPp+afTxfatZsi2tqRInSyLnJThd+Is4hz+lQTt7z
        z9ZFo7NzfKzZtI8y/ABBrh2u/1abHFCPue+O4ejL6ElsLXFx/bZCNmmQT/2C7Mc18zWb9Xf
        sCXE2RyliOGgt1GswldDXLAchMIOU5PAjC7S1mdiah7L6Qw5xaO1RD1lfPnW61Gx91nWEng
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11904508795394247973
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, w@1wt.eu
Subject: Re: [PATCH v3 3/7] selftests/nolibc: add extra configs customize support
Date:   Sat, 29 Jul 2023 22:39:33 +0800
Message-Id: <20230729143933.14462-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <74f6a3b5-666c-41e9-a3d5-0ed5457f20f5@t-8ch.de>
References: <74f6a3b5-666c-41e9-a3d5-0ed5457f20f5@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

> On 2023-07-27 23:02:02+0800, Zhangjin Wu wrote:
> > The default DEFCONFIG_<ARCH> may not always work for all architectures,
> > some architectures require to add extra kernel config options, this
> > allows to add extra options in the defconfig target.
> > 
> > Based on the .config generated from DEFCONFIG_<ARCH>, It allows to
> > customize extra kernel config options via both the common common.config
> > and the architecture specific <ARCH>.config, at last trigger
> > 'allnoconfig' to let them take effect with missing config options as
> > disabled.
> > 
> > The scripts/kconfig/merge_config.sh tool is used to merge the extra
> > config files.
> > 
> > Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
> > Link: https://lore.kernel.org/lkml/67eb70d4-c9ff-4afc-bac7-7f36cc2c81bc@t-8ch.de/
> > Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
> > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > ---
> >  tools/testing/selftests/nolibc/Makefile | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> > index f42adef87e12..9576f1a0a98d 100644
> > --- a/tools/testing/selftests/nolibc/Makefile
> > +++ b/tools/testing/selftests/nolibc/Makefile
> > @@ -39,6 +39,9 @@ DEFCONFIG_s390       = defconfig
> >  DEFCONFIG_loongarch  = defconfig
> >  DEFCONFIG            = $(DEFCONFIG_$(ARCH))
> >  
> > +# extra kernel config files under configs/, include common + architecture specific
> > +EXTCONFIG            = common.config $(ARCH).config
> 
> As this series seems to need a respin anyways:
> 
> extconfig means "extended config", correct?
> That is fairly nondescript.
>

It is more about 'extra' as commented (or 'additional'), for both
defconfig (may) and tinyconfig (must) require more options to make boot
and print work for nolibc-test.
         
    defconfig ------\
                     \
                      \
                      EXTCONFIG ----> a working .config for nolibc-test
                      /
                     /
    tinyconfig------/

> I would prefer something like "NOLIBC_TEST_CONFIG"
>

Using NOLIBC_TEST_CONFIG is ok, but with this name, do we still only put
the 'additional' options there? or we simply use EXTRA_CONFIG instead?

    # extra kernel config files under configs/, include common + architecture specific
    EXTRA_CONFIG       = common.config $(ARCH).config

From the name, NOLIBC_TEST_CONFIG should be a standalone config file to
include all necessary options? but as Willy suggested, he want to
reserve defconfig as an optional target, and tinyconfig does may be more
easier to fail than defconfig, if only consider tinyconfig, it is ok for
us to put all of the .config generated from tinyconfig + extra config to
NOLIBC_TEST_CONFIG.

   NOLIBC_TEST_CONFIG = tinyconfig + common.config + $(ARCH).config

But it may be harder to maintain a standalone config than an additional
config file.

> something like "make nolibctestconfig" to make an existing config ready for
> nolibc-test.

Do you mean rename 'defconfig' to 'nolibctestconfig'? or something
nolibc-test-config:

    nolibc-test-config:
	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
	$(Q)$(srctree)/scripts/kconfig/merge_config.sh -O "$(srctree)" -m "$(srctree)/.config" $(foreach c,$(EXTRA_CONFIG),$(wildcard $(CURDIR)/configs/$c))
	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) KCONFIG_ALLCONFIG="$(srctree)/.config" allnoconfig

It looks too long ;-)

Currently, we use 'defconfig' by default and we use 'make defconfig
DEFCONFIG=tinyconfig' to switch to tinyconfig, in the next weeks, when
all of the nolibc supported architectures have tinyconfig support, it is
able to switch 'tinyconfig' as the default config target.

    PHONY += $(KERNEL_CONFIG)
    $(KERNEL_CONFIG):
    	$(Q)if [ ! -f "$(KERNEL_CONFIG)" ]; then $(MAKE) --no-print-directory defconfig DEFCONFIG=tinyconfig; fi

    kernel: $(KERNEL_CONFIG)
    	$(Q)$(MAKE) --no-print-directory initramfs
    	$(Q)$(MAKE_KERNEL) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs

Welcome more discussion.

Thanks,
Zhangjin

> > +
> >  # optional tests to run (default = all)
> >  TEST =
> >  
> > @@ -161,6 +164,8 @@ initramfs: nolibc-test
> >  
> >  defconfig:
> >  	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
> > +	$(Q)$(srctree)/scripts/kconfig/merge_config.sh -O "$(srctree)" -m "$(srctree)/.config" $(foreach c,$(EXTCONFIG),$(wildcard $(CURDIR)/configs/$c))
> > +	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) KCONFIG_ALLCONFIG="$(srctree)/.config" allnoconfig
> >  
> >  kernel: initramfs
> >  	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs
> > -- 
> > 2.25.1
> > 
> 
