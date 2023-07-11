Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E91C74F871
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jul 2023 21:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjGKTgT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jul 2023 15:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjGKTgS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jul 2023 15:36:18 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1B3410C2;
        Tue, 11 Jul 2023 12:36:16 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36BJa8De006394;
        Tue, 11 Jul 2023 21:36:08 +0200
Date:   Tue, 11 Jul 2023 21:36:08 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v1 00/22] selftests/nolibc: add minimal kernel config
 support
Message-ID: <20230711193608.GD31402@1wt.eu>
References: <ZK0AB1OXH1s2xYsh@1wt.eu>
 <20230711171826.10480-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711171826.10480-1-falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 12, 2023 at 01:18:26AM +0800, Zhangjin Wu wrote:
> > > With the new patchset, it is able to rebuild and rerun everything in several
> > > minutes, it may make people very happy to develop nolibc itself and also make
> > > people to work on linux with nolibc, especially for developing and testing a
> > > new kernel feature ;-)
> > 
> > I doubt it. Rebuilding everything is not what most developers need. What
> > they need is to just fix a missing parenthesis that broke the build and
> > rebuild the strict minimum, restarting from where they left. And they
> > need to be able to figure what caused that "FAILED" output, disassemble
> > the output, re-run it manually under qemu-user, rebuild the .c manually
> > after copy-pasting the whole command line via "V=1", etc.
> >
> 
> It is mainly for a cross arch change, like the _start_c() patchset we
> just discuss. This may also happen for every release (not that helpful,
> for a new release, a mrproper or distclean may be required).

Maybe, but let's focus on fixing what's really annoying before trying
to improve things that work. If you find yourself failing to do certain
things, annoyed with some flags that are forced on you etc, not finding
a way to work with multiple output dirs, these are good reasons for
applying changes. But thinking that it will likely be better organized
this or that way tends to make us forget what we're relying on and that
we might lose by accident.

> > Keep in mind that the purpose of a selftest is not to optimize the case
> > where it works fine, but to optimize the developer's work when it fails.
> > This is something that a lot of people tend to get wrong. They're proud
> > of a "make world" that does everything including delivering them pizzas
> > to wait for the builds to complete, and they say "hey, impressed?". But
> > when someone else reports "I'm getting this strange error I don't
> > understand", they can hardly suggest more than "hmmm run make clean, try
> > again, or use the same distro as me because it works for me".
> >
> 
> Parts of them do want to meet the 'optimize the developer's work when it
> fails', for example, new developers may be hard to find a loongarch or
> riscv bios, or find a toolchain for the not frequently used
> architecture, to avoid introduce many bug reports about "strange errors"
> outside of our core functions, perhaps we'd better do these in a nolibc
> doc under Documentation/, tell people how to prepare the develop and
> test environment of nolibc and how to use nolibc there.

Reading the beginning of the sentence made me immediately think that it's
what doc is for. You know, if you give a fish to a hungry man he eats one
day, if you teach him to fish he eats every day. Knowing what to download
from where is much more instructive than running "make download" or even
worse, "make" and having the downloads secretly succeed (or fail). If you
think the doc is hard to find I'm also fine with a patch for makefile
and/or nolibc-test passing a pointer to its location as a reminding
comment for example.

> > And I think that helping the user
> > prepare certain steps or iterate over architectures *is* useful. When
> > you do it in two layers (the script replacing the user, the makefile
> > doing the build job), it remains easy and convenient to use, and you
> > can pick only what you need (e.g. "please build musl for me"). And if
> > something goes wrong, it's simple for the user to takeover and complete
> > that failed task by changing an arch name, a directory or anything, and
> > have their tools ready. Let's just never make that automatic for the
> > sake of everyone's health!
> 
> Ok, the revision will align with the original Makefile and remove the automatic
> parts and no change about the OUTPUT.

Just check that you can force it from your script on the make command
line. If you see that it's not possible, we should do something because
I don't want to force you to make distclean all the time if not needed.
But if you find that passing certain options (O=, OUTPUT= or anything
else) does the job, it only needs to be documented.

Thanks,
Willy
