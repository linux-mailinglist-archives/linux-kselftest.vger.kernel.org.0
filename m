Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4E1758189
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 17:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjGRP7U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 11:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjGRP7U (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 11:59:20 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 903BCA9;
        Tue, 18 Jul 2023 08:59:18 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 36IFx6cO013674;
        Tue, 18 Jul 2023 17:59:06 +0200
Date:   Tue, 18 Jul 2023 17:59:06 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     Zhangjin Wu <falcon@tinylab.org>, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 00/22] selftests/nolibc: add minimal kernel config
 support
Message-ID: <ZLa2yoyJUH8rF29l@1wt.eu>
References: <20230711193608.GD31402@1wt.eu>
 <20230718134323.14819-1-falcon@tinylab.org>
 <67eb70d4-c9ff-4afc-bac7-7f36cc2c81bc@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67eb70d4-c9ff-4afc-bac7-7f36cc2c81bc@t-8ch.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin, Thomas,

Just a quick response below on one point.

On Tue, Jul 18, 2023 at 05:19:50PM +0200, Thomas Weißschuh wrote:

> > The first architectures plan to support are powerpc + powerpc64, powerpc does
> > require extra kernel config options even with defconfig, so, it is a very good
> > first example, and the extconfig target will be added together.
> 
> Are you planning to do powerpc and tinyconfig support in one series?
> Splitting it would be better in my opinion.

I agree for splitting.

(...)
> > To only test nolibc itself, I do think tinyconfig with the above
> > extconfig support is enough, even if we need more, we can update the
> > EXTCONFIG_COMMON and EXTCONFIG_<ARCH> in the future.
> 
> IMO tinyconfig is enough, defconfig doesn't seem to be necessary then.

This is a point where I think I disagree. In fact the important feature
of defconfig, for any arch, is that it's supposed to work out of the box.
If we need to add extra options on top of tiny config, someone will
regularly have to maintain this set of options up to date when more are
added or when they're split. It could even start to fire back to a few
developers who want to make the config more modular and are forced to
update these ones without knowing well how to proceed with nolibc. Thus
I would suggest that defconfig remains available (as a make target) for
when we want to rely on a safe config, and that tinyconfig + local tuning
is available for those like us who tend to spend more time on nolibc and
who don't care much about having to tweak some options once in a while.

Just my two cents,
Willy
