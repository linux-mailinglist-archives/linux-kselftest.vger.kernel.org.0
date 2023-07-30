Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07B07683B5
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Jul 2023 06:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjG3EyX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 30 Jul 2023 00:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjG3EyW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 30 Jul 2023 00:54:22 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE5B210B;
        Sat, 29 Jul 2023 21:54:19 -0700 (PDT)
X-QQ-mid: bizesmtp85t1690692849tj81rdk5
Received: from linux-lab-host.localdomain ( [61.141.77.223])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 30 Jul 2023 12:54:07 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: HIVLo4mOhq424Et56kvGrPQKRRrEGuy362sgJ5tS+pZFVUKO2Et4LfRgKZ6dR
        vEzeOtI7p/kpYXbebFYLhvICN92nhNG3TZ795I4HnIkum6oTuSvj7e6Mijkn+qL/ONhFCJ9
        e6Kv7OK1ZGX6drUWPBGzSWCFChEOhgnAmtULMVKr6vtvwa7ip9A92oE8rwC7I9eGdAf9Rsi
        EZahsLSUI91Rpa2t/Letv5I/XrxlBPMoyR5DxC85vO7g3uy4mXX523aNLjHhlkkztjUGtOd
        UDPOQnhHdEEpm44vZkv21K6H8RKpGRWOoSqJxQpppU6oi0lxjdLZjCSLNEiF4aqWOau808w
        oPoXwpW/sP36ipH26p+Xhf6tdyzj4rvh/95e+ABgjgYOLvYz0y3qO+W6QCTGQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17043835208750504561
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v3 3/7] selftests/nolibc: add extra configs customize support
Date:   Sun, 30 Jul 2023 12:54:07 +0800
Message-Id: <20230730045407.8804-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230729171017.GC5219@1wt.eu>
References: <20230729171017.GC5219@1wt.eu>
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

> On Sun, Jul 30, 2023 at 12:54:45AM +0800, Zhangjin Wu wrote:
> > > Also I find it odd to use $(ARCH) here, I would have expected $(XARCH)
> > > since you probably want to distinguish ppc64 from ppc for example.
> > >
> > 
> > Yes, we do, but the XARCH and ARCH mmapping patch is the 4th, will
> > update this to XARCH, this one is the 3rd one, do we need to add this
> > one after the 4th one?
> 
> OK indeed it's the 4th one that will modify this one then, no need
> to reorder.
> 
> > > > > something like "make nolibctestconfig" to make an existing config ready for
> > > > > nolibc-test.
> > > > 
> > > > Do you mean rename 'defconfig' to 'nolibctestconfig'? or something
> > > > nolibc-test-config:
> > > > 
> > > >     nolibc-test-config:
> > > > 	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
> > > > 	$(Q)$(srctree)/scripts/kconfig/merge_config.sh -O "$(srctree)" -m "$(srctree)/.config" $(foreach c,$(EXTRA_CONFIG),$(wildcard $(CURDIR)/configs/$c))
> > > > 	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) KCONFIG_ALLCONFIG="$(srctree)/.config" allnoconfig
> > > > 
> > > > It looks too long ;-)
> > > 
> > > I think that as long as we don't claim to call topdir's makefile targets
> > > from this directory, we can reuse some similarly named targets which are
> > > documented in "make help" and are non-ambiguous.
> > 
> > Seems 'nolibc-test-config' is really more meaningful than 'defconfig', especially
> > when we want to use tinyconfig through it?
> > 
> >     $ make nolibc-test-config DEFCONFIG=tinyconfig
> 
> As a user, I'd ask "why not make tinyconfig" ? But see my other message,
> now I'm having strong doubts about the relevance of tinyconfig if it works
> as bad as you described it.
>

I have added a nolibc tinyconfig target before, as the same reason,
based on your suggestion, I have removed the tinyconfig target and even
moved the extconfig to this defconfig to avoid add more similar or extra
complex targets in nolibc Makefile. before, tinyconfig + extconfig
together work for nolibc-test, so, tinyconfig is the same as the
top-level one, it should be removed as your suggested.

But since now, we are ready to get a real different target from the
top-level one, we may be able to have different targets for
'defconfig+EXTRA_CONFIG' and 'tinyconfig+EXTRA_CONFIG' like this:

    nolibc-test-config:
            $(Q)echo $(MAKE_KERNEL) mrproper $(or $(CONFIG),defconfig)
            $(Q)echo $(srctree)/scripts/kconfig/merge_config.sh -Q -O "$(objtree)" -m "$(KERNEL_CONFIG)" $(foreach c,$(EXTRA_CONFIG),$(wildcard $(CURDIR)/configs/$c))
            $(Q)echo $(MAKE_KERNEL) KCONFIG_ALLCONFIG="$(KERNEL_CONFIG)" allnoconfig
            $(Q)echo $(MAKE_KERNEL) prepare

    nolibc-test-defconfig nolibc-test-tinyconfig: nolibc-test-config
    nolibc-test-tinyconfig: CONFIG=tinyconfig

The complexity here is we have planned to support both defconfig and
tinyconfig, what about this solution?

Thanks,
Zhangjin

> Willy
