Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBDB768401
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Jul 2023 08:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjG3GSQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 30 Jul 2023 02:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjG3GSP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 30 Jul 2023 02:18:15 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F085D1BD4;
        Sat, 29 Jul 2023 23:18:11 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36U6I14S007721;
        Sun, 30 Jul 2023 08:18:01 +0200
Date:   Sun, 30 Jul 2023 08:18:01 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v3 3/7] selftests/nolibc: add extra configs customize
 support
Message-ID: <20230730061801.GA7690@1wt.eu>
References: <20230730045407.8804-1-falcon@tinylab.org>
 <20230730060131.10061-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230730060131.10061-1-falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin,

On Sun, Jul 30, 2023 at 02:01:31PM +0800, Zhangjin Wu wrote:
> > > > Seems 'nolibc-test-config' is really more meaningful than 'defconfig', especially
> > > > when we want to use tinyconfig through it?
> > > > 
> > > >     $ make nolibc-test-config DEFCONFIG=tinyconfig
> > > 
> > > As a user, I'd ask "why not make tinyconfig" ? But see my other message,
> > > now I'm having strong doubts about the relevance of tinyconfig if it works
> > > as bad as you described it.
> > >
> > 
> > I have added a nolibc tinyconfig target before, as the same reason,
> > based on your suggestion, I have removed the tinyconfig target and even
> > moved the extconfig to this defconfig to avoid add more similar or extra
> > complex targets in nolibc Makefile. before, tinyconfig + extconfig
> > together work for nolibc-test, so, tinyconfig is the same as the
> > top-level one, it should be removed as your suggested.
> > 
> > But since now, we are ready to get a real different target from the
> > top-level one, we may be able to have different targets for
> > 'defconfig+EXTRA_CONFIG' and 'tinyconfig+EXTRA_CONFIG' like this:
> > 
> >     nolibc-test-config:
> >             $(Q)echo $(MAKE_KERNEL) mrproper $(or $(CONFIG),defconfig)
> 
> It should be $(or $(CONFIG),$(DEFCONFIG))
> 
> >             $(Q)echo $(srctree)/scripts/kconfig/merge_config.sh -Q -O "$(objtree)" -m "$(KERNEL_CONFIG)" $(foreach c,$(EXTRA_CONFIG),$(wildcard $(CURDIR)/configs/$c))
> >             $(Q)echo $(MAKE_KERNEL) KCONFIG_ALLCONFIG="$(KERNEL_CONFIG)" allnoconfig
> >             $(Q)echo $(MAKE_KERNEL) prepare
> > 
> >     nolibc-test-defconfig nolibc-test-tinyconfig: nolibc-test-config
> >     nolibc-test-tinyconfig: CONFIG=tinyconfig
> >
> 
> The above two are not really required in this powerpc series, let's delay them
> to the next tinyconfig part1 series.
> 
> In this series, we only need:
> 
>      nolibc-test-config:
>              $(Q)$(MAKE_KERNEL) mrproper $(or $(CONFIG),$(DEFCONFIG))
>              $(Q)$(srctree)/scripts/kconfig/merge_config.sh -Q -O "$(objtree)" -m "$(KERNEL_CONFIG)" $(foreach c,$(EXTRA_CONFIG),$(wildcard $(CURDIR)/configs/$c))
>              $(Q)$(MAKE_KERNEL) KCONFIG_ALLCONFIG="$(KERNEL_CONFIG)" allnoconfig
>              $(Q)$(MAKE_KERNEL) prepare
> 
> And this:
> 
>     # extra configs/ files appended to .config during the nolibc-test-config target
>     # include common + architecture specific
>     EXTRA_CONFIG         = common.config $(XARCH).config
> 
> And the update of the help target too.
> 
> If both of you are happy with this? let's do it ;-)

Well, I understand "nolibc-test-config" as "the config suitable to
correctly run nolibc-test". In that case I agree. We can indeed start
from the defconfig, and if we manage to refine it we can later map it
to anything else that's known to work. And if we eventually split
nolibc-test into multiple tests (libc, syscalls, ipc, network, whatever)
then we might as well adopt different configs in the future. I'd also
want to keep defconfig on its own because it relies on each arch's
defconfig and is a simple way to verify they work (as they should).
As I said, till now I haven't met issues with defconfig so probably
we don't need to patch it, but we could revisit that option later if
needed.

I'm still having that question about your "make allnoconfig" at the
end, which for me simply replaces the config you've just created, thus
which makes no sense. There might be a trick that I'm missing but if so
it should be explained there because the only situation where anybody
should start a question with "why" when reading code is when they
discovered a bug.

Also please split the mrproper and defconfig on two distinc lines, as
there's no point anymore in keeping them as a single one.

Since you're using the extra options for nolibc-test-config, I think
they should be called "nolibc-test-common.config" and
"nolibc-test-$XARCH.config" so that we don't restart with tons of
"if" and macros when adding a new target.

Thomas, are you also OK with this ?

Thanks,
Willy
