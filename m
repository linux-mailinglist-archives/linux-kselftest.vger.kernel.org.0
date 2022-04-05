Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F0C4F4CF8
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Apr 2022 03:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351844AbiDEXgr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Apr 2022 19:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392189AbiDEPft (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Apr 2022 11:35:49 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518DA12D;
        Tue,  5 Apr 2022 06:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1649166488;
  x=1680702488;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=79rrKpJvSV/IyMMLjk1fyhAdjuzODykc4KbTAF2mUFs=;
  b=FiOVSqtEplqlpGbV24QKDAr+i8WFGbW038mF84zzzjMGLHloCAF5NPgY
   spNiGw/JW64vBk2PDKMYeRrzNnvvX9UHBY/B/HepKgx6Ad8lZokZPYdBy
   7OpaZ9BsvHs1aZCwW+kuNlJhW2Z2+5tJgZDQoPpNYBx3HZTZqRoW8yTb2
   L/kbhgJPZ67FRSZN5VimMCXaFg5e7MBpW2w5kOfvVuD4jRmwgAUY0TEzv
   O9FAaZn51Fi/MSdDTB4FNunqqBA9Ty8O7mk1/2xsvz1tde3N99GsfhgrV
   4GYLxtosbMlYV/YxgZvfwIh/MPM7kvdpyaf1CLkQR25ioPVRlRFcC7BrW
   w==;
Date:   Tue, 5 Apr 2022 15:48:05 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "brendanhiggins@google.com" <brendanhiggins@google.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [RFC v1 08/10] iio: light: vcnl4000: add roadtest
Message-ID: <20220405134805.GA28574@axis.com>
References: <20220311162445.346685-1-vincent.whitchurch@axis.com>
 <20220311162445.346685-9-vincent.whitchurch@axis.com>
 <20220320170253.5b946c84@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220320170253.5b946c84@jic23-huawei>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Mar 20, 2022 at 06:02:53PM +0100, Jonathan Cameron wrote:
> Very interesting bit of work. My current approach for similar testing
> is to write a qemu model for the hardware, but that currently
> requires carefully crafted tests. Most of the time I'm only doing
> that to verify refactoring of existing drivers. 

Thank you for taking a look!

> One thing that makes me nervous here is the python element though
> as I've not written significant python in about 20 years.
> That is going to be a burden for kernel developers and maintainers...
> Nothing quite like badly written tests to make for a mess in the long run
> and I suspect my python for example would be very very badly written :)

There's a bunch of static checkers to ensure that the code follows some
basic guidelines, and CI can check that the tests work consistently, and
also calculate metrics such as test execution time and code coverage, so
even non-idiomatic Python in the tests wouldn't be entirely broken.

And unlike driver code, if the tests for a particular driver later do
turn out to be bad (in what way?), we could just throw those particular
tests out without breaking anybody's system.

> Cut and paste will of course get us a long way...

Isn't some amount of copy/paste followed by modification to be expected
even if the framework is written in say C (just as there's already
copy/paste + modification involved when writing drivers)?

As for the core logic of individual driver tests excluding the framework
bits, I have a hard time imagining what Python syntax looks like to
someone with no knowledge of Python, so yes, I guess it's going to be
harder to review.

> I dream of a world where every driver is testable by people with out hardware
> but I fear it may be a while yet.  Hopefully this will get us a little
> closer!
> 
> I more or less follow what is going on here (good docs btw in the earlier
> patch definitely helped).
> 
> So far I'm thoroughly in favour of road test subject to actually being
> able to review the tests or getting sufficient support to do so.
> It's a 'how to scale it' question really...

Would rewriting the framework in C and forcing tests to be written in
that language mean that maintainers would be able to review tests
without external support?
