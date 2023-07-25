Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20A4761B55
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 16:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbjGYOVW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 10:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbjGYOU5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 10:20:57 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8901FEF;
        Tue, 25 Jul 2023 07:20:29 -0700 (PDT)
X-QQ-mid: bizesmtp67t1690294818typdvcig
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 25 Jul 2023 22:20:17 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: rZJGTgY0+YMrG+DMayZFHWr3g2fYbpAptcGKdz0egT1ykSckqxUfDj7OQ6IRC
        umcKcFKk2oSR6PmRpl5Gd0Gk43QZ0LZIpZONyq753h+NYoqYNQHUAMAD+CVcgSzGJBVJawt
        tf9K/LFH4zuq6vU6Ciz+ScDdptaygQpWGqQce3cQqkZA9q91SWJW+vbOJAgucsPSs9uhNu+
        nSXF8xvfU+nj0e5HN96//GvtYNIdRuEhB3Y9LLDjCvHrvTRz+K8MhLvvbgK0LycE7H2Ye8t
        l6T4kHHhIG7lDiDE67E9OwZEfdVJvKnnO387F0xmiBxM0DJXPjDNx+1UL2BHdAN91KzH898
        JayfiLnehO2ke3rjwBYvuBKFRkR43xloig2pynOfzP9NOSMcq7YO291jkvgZQ5grXTvP5/b
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8411398485758775704
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v2 08/14] selftests/nolibc: string the core targets
Date:   Tue, 25 Jul 2023 22:20:17 +0800
Message-Id: <20230725142017.37103-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230722125758.GJ17311@1wt.eu>
References: <20230722125758.GJ17311@1wt.eu>
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

> On Wed, Jul 19, 2023 at 09:26:01PM +0800, Zhangjin Wu wrote:
> > To avoid run targets one by one manually and boringly, let's string them
> > with IMAGE and .config, the MAKE command will trigger the dependencies
> > for us.
> > 
> > Note, to allow do menuconfig before extconfig manually, only trigger
> > defconfig while the .config is not there, it means only trigger
> > defconfig for the first run or after a mrproper.
> > 
> > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > ---
> >  tools/testing/selftests/nolibc/Makefile | 18 +++++++++++++-----
> >  1 file changed, 13 insertions(+), 5 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> > index 83cb4b017bef..541f3565e584 100644
> > --- a/tools/testing/selftests/nolibc/Makefile
> > +++ b/tools/testing/selftests/nolibc/Makefile
> (...)
> > -extconfig:
> > +extconfig: $(KERNEL_CONFIG)
> >  	$(Q)$(srctree)/scripts/kconfig/merge_config.sh -O "$(objtree)" -m "$(KERNEL_CONFIG)" $(foreach c,$(EXTCONFIG),$(wildcard $(CURDIR)/configs/$c))
> >  	$(Q)$(MAKE_KERNEL) KCONFIG_ALLCONFIG="$(KERNEL_CONFIG)" allnoconfig
> >  
> > -kernel: initramfs
> > +kernel: extconfig
> > +	$(Q)$(MAKE) --no-print-directory initramfs
> 
> There seems to be something wrong here. From what I'm seeing, now if I
> run "make kernel" it will run extconfig and possibly change the config
> I just edited.
>

Yeah, extconfig will run for every 'make kernel', it is ok for us to
let kernel depends on $(KERNEL_CONFIG), but this requires users to run
extconfig explictly, the solution may be:

- move extconfig operations to defconfig target and future tinyconfig target (it looks cleaner ...)

    - but it is not convenient to trigger additional changes introduced by
      extconfig, not necessary, but really helpful, something like 'menuconfig'

- let users run extconfig manually after a defconfig or tinyconfig (it is a little complex)

    - this make users hard to learn what to do, should give up this method

- run extconfig for every 'make kernel' as it currently do

    - this may change something after a menuconfig, but it only trigger minimal
      required options, the 'hurt' should be minimal, but of course, it may confuse sometimes ;-(

As a summary, let's remove 'extconfig' and move its operations to the defconfig
and the future tinyconfig targets? 'extconfig' should be a 'default' config
action, let users apply additional ones manually from the top-level 'make
menuconfig', what's your idea?

> Or am I missing something ? I must confess all of this is becoming more
> and more obscure :-(

Yeah ... let's find a better solution ;-)

Best regards,
Zhangjin

> 
> Willy
