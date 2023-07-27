Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187F17654E5
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 15:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjG0NYn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 09:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjG0NYj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 09:24:39 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B84F271D;
        Thu, 27 Jul 2023 06:24:37 -0700 (PDT)
X-QQ-mid: bizesmtp91t1690464264t6ba04bc
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 27 Jul 2023 21:24:23 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000B00A0000000
X-QQ-FEAT: +ynUkgUhZJlPcLo2L82mSALBkA/DiMtCgLjD0C7cQYqRPdo832+NVjxmjea1d
        xsxaF9IRTavQ+hveYD01x/hM87H7JDeodA/iw2ImSsPbQ7v3KV9mJVZR80wCLgFZw6MavDP
        7IKQprNbhH7PXchzJ8Yek1rjYYwriiKL9U3uiixpUdEwJKaknZLkiAizIjoiy69iZW7bFh1
        UIQKfOEQUXVdzwUPXBN61kcBXjuAy79/VMax523twViH1VocY45j34aa2s5H2M+gEoz17xT
        TFIRh8qX4J07T9xkCEpZ2/yFcZS+J30KuFOgC+7f64IXYaL9Jho/UrIW1s+0uINgu12EtuY
        u19EysC//h+kaQAXprCkSKSA327yWIxEkqTUix/
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4414270907926096569
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v2 05/14] selftests/nolibc: add menuconfig for development
Date:   Thu, 27 Jul 2023 21:24:18 +0800
Message-Id: <20230727132418.117924-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230725135106.36543-1-falcon@tinylab.org>
References: <20230725135106.36543-1-falcon@tinylab.org>
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

Hi, Willy

> > On Wed, Jul 19, 2023 at 09:22:37PM +0800, Zhangjin Wu wrote:
> > > The default DEFCONFIG_<ARCH> may not always work for all architectures,
> > > let's allow users to tune some kernel config options with 'menuconfig'.
> > > 
> > > This is important when porting nolibc to a new architecture, it also
> > > allows to speed up nolibc 'run' target testing via manually disabling
> > > tons of unnecessary kernel config options.
> > > 
> > > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > > ---
> > >  tools/testing/selftests/nolibc/Makefile | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> > > index 058e7be070ea..06954b4b3885 100644
> > > --- a/tools/testing/selftests/nolibc/Makefile
> > > +++ b/tools/testing/selftests/nolibc/Makefile
> > > @@ -202,6 +202,9 @@ KERNEL_IMAGE  = $(objtree)/$(IMAGE)
> > >  defconfig:
> > >  	$(Q)$(MAKE_KERNEL) mrproper $(DEFCONFIG) prepare
> > >  
> > > +menuconfig:
> > > +	$(Q)$(MAKE_KERNEL) menuconfig
> > 
> > What is the real benefit of this compared to just running the
> > standard "make menuconfig" ? We should avoid adding makefile targets
> > that do not bring value on top of that the top-level makefile does,
> > because it will make the useful ones much harder to spot, and will
> > tend to encourage users to use only that makefile during the tests,
> > which is a bad practice since many targets will always be missing
> > or work differently. It's important in my opinion that we strictly
> > stick to what is useful to operate the tests themselves and this
> > one doesn't make me feel like it qualifies as such.
> 
> Ok, get it.
> 
> I did like develop nolibc in tools/testing/selftests/nolibc/ without
> changing directories frequently or specifying the "-C" option
> unnecessary ;-) 
>
> Since "make menuconfig" is only required during the first porting of a new
> architecture, so, it is ok to drop this patch.
>

Oh, Willy, I did find this is very important again.

I just want to check and test if we need to disable vsx for 32-bit
powerpc too, so, I plan to re-configure kernel via menuconfig to disable
VSX in kernel side, and forcely enable vsx in application side, but it
was very 'painful' when I was running something like this:

    $ make defconfig ARCH=ppc CROSS_COMPILE=powerpc-linux-gnu-

To do a further menuconfig, I must switch to something else:

    $ make menuconfig ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- -C ../../../../

Especially, our test is able to accept ARCH=ppc, but the top-level
kernel still only accept powerpc, it makes the development very
comfortable, of course, the typing of the relative or absolute path
every time is either not a good idea.

so, this doesn't simply duplicate with the one from top-level, it can
get the right ARCH, srctree for us, and this is heavily used by our
tinyconfig development to tune the config options very frequently, so,
let's still add this one in the new revision?

But I plan to merge the mrproper targets here to save another patch,
what about your idea?

    menuconfig mrproper:
	$(Q)$(MAKE_KERNEL) $@

Thanks,
Zhangjin

> Thanks,
> Zhangjin
> 
> > 
> > Willy
