Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37261767DB6
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 11:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjG2JoD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Jul 2023 05:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbjG2Jn6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Jul 2023 05:43:58 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D6C421E;
        Sat, 29 Jul 2023 02:43:52 -0700 (PDT)
X-QQ-mid: bizesmtp69t1690623820t9fq1ksx
Received: from linux-lab-host.localdomain ( [61.141.77.223])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 29 Jul 2023 17:43:39 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: ZkxZBO9qcf524DNJP6sWoIuH7Engece/jg2w/GVDidzBTt8zNz48mPafsj+gF
        0u5KGqbwCfl1qMkMbGSBa5iXRRVcIphnvGtjbgrlU99G5As1TCuU/SDvKC5onBCVpsQOApq
        3OfcMckJ9p3x2Ll0vIBN0UP5JUtOLdFltddHn3M4vYNDiW2HsxZCHM+ab7sbf/xE/Ec9v6f
        D8qXvX5/3O8RH10R9NOVN0AT0UadpgvrtScxGgk8UgqwB7o8/zjXodXtM9I4CZdis5PPvQ+
        xvxeW4nMtilLyJY7S/cpGMRfYWL2Y9Yz07pOCovvJwSUo3+tGmcrtsg7h5a8xIo9NSYTFGn
        qM2ZGgpHkfWS52sWBjNObbzTXDiejuN2H3DhI0A/AN+oXarqM2K8FKg1FIlgskqOK96+PAd
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13123960040625592504
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux@weissschuh.net,
        thomas@t-8ch.de
Subject: Re: [PATCH v1 4/8] selftests/nolibc: add extra config file customize support
Date:   Sat, 29 Jul 2023 17:43:39 +0800
Message-Id: <20230729094339.9274-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230729074518.GH956@1wt.eu>
References: <20230729074518.GH956@1wt.eu>
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

> Hi Zhangjin,
> 
> On Tue, Jul 25, 2023 at 10:30:06PM +0800, Zhangjin Wu wrote:
> > Hi, Willy
> > 
> > > On Wed, Jul 19, 2023 at 05:14:07AM +0800, Zhangjin Wu wrote:
> > > > The default DEFCONFIG_<ARCH> may not always work for all architectures,
> > > > some architectures require to add extra kernel config options, this adds
> > > > a new 'extconfig' target for this requirement.
> > > > 
> > > > It allows to customize extra kernel config options via the common
> > > > common.config and the architecture specific <ARCH>.config, at last
> > > > trigger 'allnoconfig' to let them take effect with missing config
> > > > options as disabled.
> > > > 
> > > > The scripts/kconfig/merge_config.sh tool is used to merge the extra
> > > > config files.
> > > > 
> > > > Suggested-by: Thomas Wei?schuh <linux@weissschuh.net>
> > > > Link: https://lore.kernel.org/lkml/67eb70d4-c9ff-4afc-bac7-7f36cc2c81bc@t-8ch.de/
> > > > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > > > ---
> > > >  tools/testing/selftests/nolibc/Makefile | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > > 
> > > > diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> > > > index f42adef87e12..08a5ca5f418b 100644
> > > > --- a/tools/testing/selftests/nolibc/Makefile
> > > > +++ b/tools/testing/selftests/nolibc/Makefile
> > > > @@ -39,6 +39,9 @@ DEFCONFIG_s390       = defconfig
> > > >  DEFCONFIG_loongarch  = defconfig
> > > >  DEFCONFIG            = $(DEFCONFIG_$(ARCH))
> > > >  
> > > > +# extra kernel config files under configs/, include common + architecture specific
> > > > +EXTCONFIG            = common.config $(ARCH).config
> > > > +
> > > >  # optional tests to run (default = all)
> > > >  TEST =
> > > >  
> > > > @@ -162,6 +165,10 @@ initramfs: nolibc-test
> > > >  defconfig:
> > > >  	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
> > > >  
> > > > +extconfig:
> > > > +	$(Q)$(srctree)/scripts/kconfig/merge_config.sh -O "$(srctree)" -m "$(srctree)/.config" $(foreach c,$(EXTCONFIG),$(wildcard $(CURDIR)/configs/$c))
> > > > +	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) KCONFIG_ALLCONFIG="$(srctree)/.config" allnoconfig
> > > > +
> > > 
> > > Please also mention this entry in the "help" message.
> > > Other than that, OK.
> > >
> > 
> > Willy, as we discussed in another tinyconfig series, in order to avoid
> > add more complexity to users, I plan to drop this standalone 'extconfig'
> > target and move the extra config operations to defconfig target like
> > this:
> > 
> >     defconfig:
> >      	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
> >      	$(Q)$(srctree)/scripts/kconfig/merge_config.sh -O "$(srctree)" -m "$(srctree)/.config" $(foreach c,$(EXTCONFIG),$(wildcard $(CURDIR)/configs/$c))
> >      	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) KCONFIG_ALLCONFIG="$(srctree)/.config" allnoconfig
> > 
> > This extra config options are really critical to default boot and test, so, it
> > should be a 'default' config action as the 'defconfig' target originally mean.
> > 
> > Will test carefully about this change, what's your idea?
> 
> Well, *iff* we need to have per-arch config settings, probably to better
> support Qemu, the console output, etc, then indeed we'd rather add them
> to all configs indeed. However the example above is bogus. First you
> create a default config, then prepare the rest of the kernel , then
> merge that config with the extensions (based on the arch and not the
> sub-arch BTW) then erase everything to restart from an allnoconfig.
>

allnoconfig is based on the "$(srctree)/.config" generated by defconfig
plus the extra ARCH specific config options, so, it should be additional?

Btw, what do you mean? "based on the arch and not the sub-arch BTW", in
reality, the ARCH will be changed to XARCH, so, this is sub-arch/variant
specific.

> Also if you're using merge_config you'll need -Q to disable warning
> about overridden options since you're starting from a defconfig which
> contains plenty of them.

Yeah, we do need this to silence some warnings.

> Usually I just do defconfig, append the few
> changes, then oldconfig and that's done.

I have used olddefconfig (similar to oldconfig but without prompts)
before, but allnoconfig is used to mainly to only compile the ones we
explicitly enable, with the new additional options as No, which may be
more deterministic, it should not touch the old configured ones in
.config? I have learned its usage from the merge_config.sh

> But merge_config can probably
> be fine as well. Also make prepare should be done last, to make sure
> that if it depends on anything in the config (e.g. 32 vs 64 bit etc)
> it's up to date.
>

Ok, let's move 'prepare' at the end of all above.

And also add the -Q option to silence the potential warnings:

    defconfig:
      	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG)
      	$(Q)$(srctree)/scripts/kconfig/merge_config.sh -Q -O "$(srctree)" -m "$(srctree)/.config" $(foreach c,$(EXTCONFIG),$(wildcard $(CURDIR)/configs/$c))
      	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) KCONFIG_ALLCONFIG="$(srctree)/.config" allnoconfig
      	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) prepare

We may still need to clear the usage of allnoconfig, In my test, it does
work as I explained above. If I really misused it, let's change it back
to olddefconfig.

Thanks,
Zhangjin

> Willy
