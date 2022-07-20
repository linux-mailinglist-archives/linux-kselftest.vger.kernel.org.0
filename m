Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC10457AF74
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Jul 2022 05:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236159AbiGTD0Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 23:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234254AbiGTD0Y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 23:26:24 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6C2142AD5;
        Tue, 19 Jul 2022 20:26:22 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 26K3QCwg003120;
        Wed, 20 Jul 2022 05:26:12 +0200
Date:   Wed, 20 Jul 2022 05:26:12 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Pranith Kumar <bobby.prani@gmail.com>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Mark Brown <broonie@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/17] nolibc: add preliminary self tests
Message-ID: <20220720032612.GA3106@1wt.eu>
References: <20220719214449.2520-1-w@1wt.eu>
 <20220719224947.GX1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719224947.GX1790663@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 19, 2022 at 03:49:47PM -0700, Paul E. McKenney wrote:
> But I do get "71 test(s) passed." when running on x86.  I will let you
> decide whether that constitutes all being well or indicates a bug in
> the tests.   ;-)

Technically speaking both are possible, but one is more likely :-)

> > The program can automatically modulate QEMU's return value on x86 when
> > QEMU is run with the appropriate options, but for now I'm not using it
> > as I felt like it didn't bring much value, and the output is more useful.
> > That's debatable, and maybe some might want to use it in bisect scripts
> > for example. It's too early to say IMHO.
> 
> For the moment, grepping the output works.  And perhaps indefinitely.

That's my intuition as well, given that there will always be a bit of
scripting around that anyway.

> This series is now on the -rcu tree's "dev" branch.

Thank you!

> I got two almost
> identical copies of patch 7, so I took the later of the two.  Please let
> me know if I guessed wrong.

Oh you're right, I'm sorry about that. I adjusted one commit message late
and failed to erase the previous one from the directory. In either case
we really don't care but I thought that the one mentioning "stdlib" which
is the term used in the test was better.

Thanks again for your time,
Willy
