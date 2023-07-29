Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABB67680B3
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 19:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjG2RK1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Jul 2023 13:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjG2RK0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Jul 2023 13:10:26 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3348DE75;
        Sat, 29 Jul 2023 10:10:25 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36THAHYt005396;
        Sat, 29 Jul 2023 19:10:17 +0200
Date:   Sat, 29 Jul 2023 19:10:17 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v3 3/7] selftests/nolibc: add extra configs customize
 support
Message-ID: <20230729171017.GC5219@1wt.eu>
References: <20230729162907.GA5219@1wt.eu>
 <20230729165445.88073-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729165445.88073-1-falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jul 30, 2023 at 12:54:45AM +0800, Zhangjin Wu wrote:
> > Also I find it odd to use $(ARCH) here, I would have expected $(XARCH)
> > since you probably want to distinguish ppc64 from ppc for example.
> >
> 
> Yes, we do, but the XARCH and ARCH mmapping patch is the 4th, will
> update this to XARCH, this one is the 3th one, do we need to add this
> one after the 4th one?

OK indeed it's the 4th one that will modify this one then, no need
to reorder.

> > > > something like "make nolibctestconfig" to make an existing config ready for
> > > > nolibc-test.
> > > 
> > > Do you mean rename 'defconfig' to 'nolibctestconfig'? or something
> > > nolibc-test-config:
> > > 
> > >     nolibc-test-config:
> > > 	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
> > > 	$(Q)$(srctree)/scripts/kconfig/merge_config.sh -O "$(srctree)" -m "$(srctree)/.config" $(foreach c,$(EXTRA_CONFIG),$(wildcard $(CURDIR)/configs/$c))
> > > 	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) KCONFIG_ALLCONFIG="$(srctree)/.config" allnoconfig
> > > 
> > > It looks too long ;-)
> > 
> > I think that as long as we don't claim to call topdir's makefile targets
> > from this directory, we can reuse some similarly named targets which are
> > documented in "make help" and are non-ambiguous.
> 
> Seems 'nolibc-test-config' is really more meaningful than 'defconfig', especially
> when we want to use tinyconfig through it?
> 
>     $ make nolibc-test-config DEFCONFIG=tinyconfig

As a user, I'd ask "why not make tinyconfig" ? But see my other message,
now I'm having strong doubts about the relevance of tinyconfig if it works
as bad as you described it.

Willy
