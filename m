Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A376460E99D
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Oct 2022 21:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbiJZTwd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Oct 2022 15:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbiJZTwd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Oct 2022 15:52:33 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E550F07F7;
        Wed, 26 Oct 2022 12:52:31 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 29QJqO0F024214;
        Wed, 26 Oct 2022 21:52:24 +0200
Date:   Wed, 26 Oct 2022 21:52:24 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: add 7 tests for memcmp()
Message-ID: <20221026195224.GA24197@1wt.eu>
References: <20221021060340.7515-1-w@1wt.eu>
 <20221021155645.GK5600@paulmck-ThinkPad-P17-Gen-1>
 <20221021170134.GB8420@1wt.eu>
 <20221021170738.GM5600@paulmck-ThinkPad-P17-Gen-1>
 <20221021172026.GC8420@1wt.eu>
 <20221021180040.GN5600@paulmck-ThinkPad-P17-Gen-1>
 <20221022112228.GB30596@1wt.eu>
 <20221024155357.GZ5600@paulmck-ThinkPad-P17-Gen-1>
 <20221026053922.GA19206@1wt.eu>
 <a5233381-4081-afce-07b5-72d653eeeefb@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5233381-4081-afce-07b5-72d653eeeefb@rasmusvillemoes.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 26, 2022 at 11:08:41AM +0200, Rasmus Villemoes wrote:
> On 26/10/2022 07.39, Willy Tarreau wrote:
> > 
> > No more false positives nor false negatives anymore. I'm sending you
> > the patch separately.
> 
> While you're at it, may I suggest also adding a few test cases where the
> buffers differ by 128, e.g. 0x0 v 0x80 and 0x40 v 0xc0.

I initially thought about it but changed my mind for +/- 0xc0 that
covered the same cases in my opinion. Do you have a particular error
case in mind that would be caught by this one that the other one does
not catch ? I'm fine for proposing a respin of the patch to improve
it if it brings some value, but I'm still failing to figure when that
would be the case.

Thanks,
Willy
