Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CC7761BB1
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 16:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjGYOaV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 10:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjGYOaU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 10:30:20 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92077CD;
        Tue, 25 Jul 2023 07:30:18 -0700 (PDT)
X-QQ-mid: bizesmtp63t1690295407t5fn9pna
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 25 Jul 2023 22:30:06 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: 5q30pvLz2idm6eGUKnhD29MMjU+BWKNUCYmE2YhHu34X2nvYfFSUxj32XjACV
        aIqKUwI+BasNiTdoDyFtHtMkn16npcuE7XdblWOGfPHf4ZkbZjCo7hJ3GkSlHo4Uh2t8Q8U
        b1HKet2rWr8hh9CPLs69dcZanl/yKSBaNV90y6ByeNjQsqVFTbxTdo5WjgR7sr274bBfsTW
        RN1u5zi6bIZ424y091n+sUxr3DuuCsHEY14CXrHpHSN7ack5B7Kf5QkfjlYafkaq7kVM2c9
        EOuAFrZYZ5QcA4mYZVzpUEP7ucDOrQDze0K2m0FFvedKGl4okpZF/w0chsC7SVO25cqSgi1
        J07Jy6W0h15JOfh7xUof8BuCjd/IW2futU4SfuKrsKie3NwlRJvH9WcSOztnqF6zTovSoaJ
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 502512354175558940
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux@weissschuh.net,
        thomas@t-8ch.de
Subject: Re: [PATCH v1 4/8] selftests/nolibc: add extra config file customize support
Date:   Tue, 25 Jul 2023 22:30:06 +0800
Message-Id: <20230725143006.37452-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230722120037.GA17311@1wt.eu>
References: <20230722120037.GA17311@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi, Willy

> On Wed, Jul 19, 2023 at 05:14:07AM +0800, Zhangjin Wu wrote:
> > The default DEFCONFIG_<ARCH> may not always work for all architectures,
> > some architectures require to add extra kernel config options, this adds
> > a new 'extconfig' target for this requirement.
> > 
> > It allows to customize extra kernel config options via the common
> > common.config and the architecture specific <ARCH>.config, at last
> > trigger 'allnoconfig' to let them take effect with missing config
> > options as disabled.
> > 
> > The scripts/kconfig/merge_config.sh tool is used to merge the extra
> > config files.
> > 
> > Suggested-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> > Link: https://lore.kernel.org/lkml/67eb70d4-c9ff-4afc-bac7-7f36cc2c81bc@t-8ch.de/
> > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > ---
> >  tools/testing/selftests/nolibc/Makefile | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> > index f42adef87e12..08a5ca5f418b 100644
> > --- a/tools/testing/selftests/nolibc/Makefile
> > +++ b/tools/testing/selftests/nolibc/Makefile
> > @@ -39,6 +39,9 @@ DEFCONFIG_s390       = defconfig
> >  DEFCONFIG_loongarch  = defconfig
> >  DEFCONFIG            = $(DEFCONFIG_$(ARCH))
> >  
> > +# extra kernel config files under configs/, include common + architecture specific
> > +EXTCONFIG            = common.config $(ARCH).config
> > +
> >  # optional tests to run (default = all)
> >  TEST =
> >  
> > @@ -162,6 +165,10 @@ initramfs: nolibc-test
> >  defconfig:
> >  	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
> >  
> > +extconfig:
> > +	$(Q)$(srctree)/scripts/kconfig/merge_config.sh -O "$(srctree)" -m "$(srctree)/.config" $(foreach c,$(EXTCONFIG),$(wildcard $(CURDIR)/configs/$c))
> > +	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) KCONFIG_ALLCONFIG="$(srctree)/.config" allnoconfig
> > +
> 
> Please also mention this entry in the "help" message.
> Other than that, OK.
>

Willy, as we discussed in another tinyconfig series, in order to avoid
add more complexity to users, I plan to drop this standalone 'extconfig'
target and move the extra config operations to defconfig target like
this:

    defconfig:
     	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
     	$(Q)$(srctree)/scripts/kconfig/merge_config.sh -O "$(srctree)" -m "$(srctree)/.config" $(foreach c,$(EXTCONFIG),$(wildcard $(CURDIR)/configs/$c))
     	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) KCONFIG_ALLCONFIG="$(srctree)/.config" allnoconfig

This extra config options are really critical to default boot and test, so, it
should be a 'default' config action as the 'defconfig' target originally mean.

Will test carefully about this change, what's your idea?

Thanks,
Zhangjin

> Willy
