Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7DE767FC5
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 15:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjG2Nyk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Jul 2023 09:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjG2Nyj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Jul 2023 09:54:39 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B83B8;
        Sat, 29 Jul 2023 06:54:36 -0700 (PDT)
X-QQ-mid: bizesmtp76t1690638865t7y7lyb3
Received: from linux-lab-host.localdomain ( [61.141.77.223])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 29 Jul 2023 21:54:24 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: bhet8yMU7vmXO6srFPfWrmjrGvIDttEZmei+OFZ8bQvYf5yZDhGm6YPOH44Qk
        3pWyMwPEgBze739hyG1FT2noI2Fhhzz3gSE2REGaLW1wQGZwmPOCV+XFJ4h76s5GsE7K227
        RC9ni1qHy7UQHpl9Zx8dNIq7MuRsGjp8+Jf5Op3HiRcX6jIMBkHp5gqPWdZcIRcZfu+g4ec
        okV/5HMKjsU441au6uvGyoluTyA0P4F+hPRAnvnOTMtIW/KdPxyDZ9BfKfEgyp3PMeNb74J
        a7frMtz+PtFyJzYRgDYdJQfpJzNUToCLw8OYVuYblZypaWdiODtk21Q5rZhf5lx7Fa0jmmy
        gqhmSov1prMn4CkTkSrs4eGVTZj8TZJJhwmmJ1Bs1YQpvj8gSI=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11926532670641688291
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v2 05/14] selftests/nolibc: add menuconfig for development
Date:   Sat, 29 Jul 2023 21:54:23 +0800
Message-Id: <20230729135423.14026-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230729082206.GK956@1wt.eu>
References: <20230729082206.GK956@1wt.eu>
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

Hi, Willy

[...]
> > > > 
> > > > What is the real benefit of this compared to just running the
> > > > standard "make menuconfig" ? We should avoid adding makefile targets
> > > > that do not bring value on top of that the top-level makefile does,
> > > > because it will make the useful ones much harder to spot, and will
> > > > tend to encourage users to use only that makefile during the tests,
> > > > which is a bad practice since many targets will always be missing
> > > > or work differently. It's important in my opinion that we strictly
> > > > stick to what is useful to operate the tests themselves and this
> > > > one doesn't make me feel like it qualifies as such.
> > > 
> > > Ok, get it.
> > > 
> > > I did like develop nolibc in tools/testing/selftests/nolibc/ without
> > > changing directories frequently or specifying the "-C" option
> > > unnecessary ;-) 
> > >
> > > Since "make menuconfig" is only required during the first porting of a new
> > > architecture, so, it is ok to drop this patch.
> > >
> > 
> > Oh, Willy, I did find this is very important again.
> > 
> > I just want to check and test if we need to disable vsx for 32-bit
> > powerpc too, so, I plan to re-configure kernel via menuconfig to disable
> > VSX in kernel side, and forcely enable vsx in application side, but it
> > was very 'painful' when I was running something like this:
> > 
> >     $ make defconfig ARCH=ppc CROSS_COMPILE=powerpc-linux-gnu-
> > 
> > To do a further menuconfig, I must switch to something else:
> > 
> >     $ make menuconfig ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- -C ../../../../
> > 
> > Especially, our test is able to accept ARCH=ppc, but the top-level
> > kernel still only accept powerpc, it makes the development very
> > comfortable, of course, the typing of the relative or absolute path
> > every time is either not a good idea.
> 
> It is "able" but that's not what ought to be used, since it's going to
> be remapped to "powerpc". You're supposed to use XARCH for this one
> since it's a variant (we could find other names if needed). I suspect
> it just shows that the "override ARCH :=" is excessive and should not
> be there. Usually when you put override in a makefile, it's going to
> pop up as a bug elsewhere. Thus actually you could very well have :
> 
>    make ARCH=powerpc XARCH=ppc CROSS_COMPILE=powerpc-linux-gnu-
>

Oh, Seems I have misunderstood your suggestions in another reply, you
recommended to add ARCH variable to the help target, at last, I thought
it was better to only reserve ARCH as the consistent variable to users,
so, the 'override' keyword is added to allow passing anyone of powerpc,
ppc, ppc64 and ppc64le to ARCH, since XARCH only accept ppc, ppc64 and
ppc64le.

Further passing 'ARCH=powerpc XARCH=ppc' is also ok, but the combination
of ARCH and XARCH may require more time to teach a new user, is ok for
me to remove the override and carefully document this usage in Makefile.

Seems 'override' is really required, without it, when users wrongly try
ARCH=ppc, ARCH=ppc64, ARCH=ppc64le, the ARCH passed to kernel will be
completely wrong, it may mislead users ...

With this 'override', it is ok for users to use ARCH only, or XARCH or even
together with both of them, no failure and happy, to myself, I'm ok to remove
the 'override' keyword, ;-)

> as the prefix for all your commands. Some will prefer to work directly
> from the kernel dir:
> 
>  $ make ARCH=powerpc XARCH=ppc CROSS_COMPILE=powerpc-linux-gnu- -C tools/testing/selftests/nolibc-test defconfig
>  $ make ARCH=powerpc XARCH=ppc CROSS_COMPILE=powerpc-linux-gnu- menuconfig
> 
> Others would do it from the nolibc-test dir as you did above.
>

Yeah, we still need one more -C, but it is of course ok to do this in a
standalone script as you mentioned before.

> > so, this doesn't simply duplicate with the one from top-level, it can
> > get the right ARCH, srctree for us, and this is heavily used by our
> > tinyconfig development to tune the config options very frequently, so,
> > let's still add this one in the new revision?
> 
> I'm not *fundamentally* opposed to menuconfig, I just think that it's
> appearing at the wrong place. Why not oldconfig, allmodconfig, randconfig,
> allnoconfig etc then ? There is nothing in the test directory that is
> supposed to be used interactively, either it's run in a batch for cross-
> arch testing, or you use it to validate your kernel when you're working
> on it. It feels strange that one would want to configure their kernel
> from this sub-dir.

Ok, it is reasonable ;-)

> 
> > But I plan to merge the mrproper targets here to save another patch,
> > what about your idea?
> > 
> >     menuconfig mrproper:
> > 	$(Q)$(MAKE_KERNEL) $@
> 
> Please no. Someone doing that in hope to clean only the result of
> the tests would in fact ruin their config:
> 
>   $ make -C tools/testing/selftests/nolibc-test mrproper
>

Yeah, really a good reason to not add mrproper there.

> This is another reason for not encouraging users to develop from
> within that dir.
>

Thanks,
Zhangjin

> Willy
