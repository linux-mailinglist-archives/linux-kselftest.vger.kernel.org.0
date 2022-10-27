Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1778260FF3B
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Oct 2022 19:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbiJ0RUv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Oct 2022 13:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235003AbiJ0RUu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Oct 2022 13:20:50 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83AE51826DB;
        Thu, 27 Oct 2022 10:20:48 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 29RHKfeK031409;
        Thu, 27 Oct 2022 19:20:41 +0200
Date:   Thu, 27 Oct 2022 19:20:41 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: add 7 tests for memcmp()
Message-ID: <20221027172041.GB30081@1wt.eu>
References: <20221021170134.GB8420@1wt.eu>
 <20221021170738.GM5600@paulmck-ThinkPad-P17-Gen-1>
 <20221021172026.GC8420@1wt.eu>
 <20221021180040.GN5600@paulmck-ThinkPad-P17-Gen-1>
 <20221022112228.GB30596@1wt.eu>
 <20221024155357.GZ5600@paulmck-ThinkPad-P17-Gen-1>
 <20221026053922.GA19206@1wt.eu>
 <a5233381-4081-afce-07b5-72d653eeeefb@rasmusvillemoes.dk>
 <20221026195224.GA24197@1wt.eu>
 <0b8feeb2-6ec6-d2af-8aa7-0bf34e7ab4b2@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b8feeb2-6ec6-d2af-8aa7-0bf34e7ab4b2@rasmusvillemoes.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Rasmus,

On Thu, Oct 27, 2022 at 11:09:55AM +0200, Rasmus Villemoes wrote:
> >> While you're at it, may I suggest also adding a few test cases where the
> >> buffers differ by 128, e.g. 0x0 v 0x80 and 0x40 v 0xc0.
> > 
> > I initially thought about it but changed my mind for +/- 0xc0 that
> > covered the same cases in my opinion. Do you have a particular error
> > case in mind that would be caught by this one that the other one does
> > not catch ?
> 
> Not really, but in a sense the opposite: for the +/- 0xc0 case, both
> ways of comparison will give the wrong sign because -192 becomes +64 and
> vice versa. For +/- 0x80, one way of doing the comparison will
> "accidentally" produce the right answer, and I thought that might also
> be a little interesting.

OK, initially I thought you were trying to make the comparison return a
match when there is none. I now see better what you mean there.

> > I'm fine for proposing a respin of the patch to improve
> > it if it brings some value,
> 
> It's your call, you can respin, do an incremental patch, or just ignore
> me :)

I would like to propose you something. Till now I'm the only one having
added tests to this file, and I'm still lacking feedback on the usability.
I would very much appreciate it if you could try to add this test case
yourself on top of existing ones (those present in Paul's rcu/next branch
here:
https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/ ).

Then your criticism of what you would find unclear, unconvenient, poorly
thought, unintuitive etc, and of course suggestions, would be welcome.
That doesn't mean I'd have a quick solution of course but the more eyes
there at the early stages, the better so that it becomes friendly to use
for other contributors. If you don't want to, that's no big deal, but if
you do I'll really appreciate it.

Thank you,
Willy
