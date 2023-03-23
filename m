Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E22D6C64FD
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 11:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjCWK2B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 06:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjCWK10 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 06:27:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F111B566;
        Thu, 23 Mar 2023 03:26:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6AB35B8206D;
        Thu, 23 Mar 2023 10:26:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901AEC433EF;
        Thu, 23 Mar 2023 10:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679567160;
        bh=qjuVbo/YQInc7QDqTNTVbV1FjCw1Zls8gRxxXRbt/QU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kK2s1NGslXJ89GkgaX3rOCRWahxTMYA8/zrlC+4tBPZp3ktan8xpDiP4Mb/hcl/6w
         GnaXDpKbUP+EZGb0X5WEcLfz5hjV7+cM/o7WJEKKfwFhRuUnMFRYSOu0nyghblJpq0
         8P0qfUEdtLIywvFVxzqUW9zJmXMftzrB/OYnabfw=
Date:   Thu, 23 Mar 2023 11:25:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v5 1/8] drivers: kunit: Generic helpers for test device
 creation
Message-ID: <ZBwpNcd/A15/Azjr@kroah.com>
References: <cover.1679474247.git.mazziesaccount@gmail.com>
 <bad670ee135391eb902bd34b8bcbe777afabc7fd.1679474247.git.mazziesaccount@gmail.com>
 <ZBrvhfX/NNrJefgt@kroah.com>
 <25f9758f-0010-0181-742a-b18a344110cf@gmail.com>
 <ZBtPhoelZo4U5jwC@kroah.com>
 <12ea1d68-2a3c-0aa7-976c-7bd3eef35239@fi.rohmeurope.com>
 <ZBwUp/fRIjQZtjF7@kroah.com>
 <3c09bda1-330d-6d49-ade5-aab567b3a0c4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c09bda1-330d-6d49-ade5-aab567b3a0c4@gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 23, 2023 at 11:20:33AM +0200, Matti Vaittinen wrote:
> On 3/23/23 10:58, Greg Kroah-Hartman wrote:
> > On Thu, Mar 23, 2023 at 07:17:40AM +0000, Vaittinen, Matti wrote:
> > > On 3/22/23 20:57, Greg Kroah-Hartman wrote:
> > > > On Wed, Mar 22, 2023 at 03:48:00PM +0200, Matti Vaittinen wrote:
> > > > > Hi Greg,
> > > > > 
> > > > > Thanks for looking at this.
> > > > > 
> > > > > On 3/22/23 14:07, Greg Kroah-Hartman wrote:
> > > > > > On Wed, Mar 22, 2023 at 11:05:55AM +0200, Matti Vaittinen wrote:
> 
> > > I am very conservative what comes to adding unit tests due to the huge
> > > inertia they add to any further development. I usually only add tests to
> > > APIs which I know won't require changing (I don't know such in-kernel
> > > APIs)
> > 
> > So anything that is changing doesn't get a test?
> 
> No. I think you misread me. I didn't say I don't like adding tests to code
> which changes. I said, I don't like adding tests to APIs which change.

Then you should not be writing any in-kernel tests as all of our APIs
change all the time.

>  If you only test
> > things that don't change then no tests fail, and so, why have the test
> > at all?
> 
> Because implementation cascading into functions below an API may change even
> if the API stays unchanged.

Then it needs to be fixed.

> > On the contrary, tests should be used to verify things that are changing
> > all the time, to ensure that we don't break things.
> 
> This is only true when your test code stays valid. Problem with excessive
> amount of tests is that more we have callers for an API, harder changing
> that API becomes. I've seen a point where people stop fixing "unimportant"
> things just because the amount of work fixing all impacted UT-cases would
> take. I know that many things went wrong before that project ended up to the
> point - but what I picked up with me is that carelessly added UTs do really
> hinder further development.

Again, in-kernel apis change at any moment.  I just changed one that was
over 15 years old.  Don't get stuck into thinking that you can only
write tests for stuff that is "stable" as nothing in the kernel is
"stable" and can change at any point in time.  You fix up all the
in-kernel users of the api, and the tests, and all is good.  That's how
kernel development works.

>  That's why we need
> > them, not to just validate that old code still is going ok.
> > 
> > The driver core is changing, and so, I would love to see tests for it to
> > ensure that I don't break anything over time.  That should NOT slow down
> > development but rather, speed it up as it ensures that things still work
> > properly.
> 
> I agree that there are cases where UTs are very handy and can add confidence
> that things work as intended. Still, my strong opinion is that people should
> consider what parts of code are really worth testing - and how to do the
> tests so that the amount of maintenance required by the tests stays low.
> It's definitely _not fun_ to do refactoring for minor improvement when 400+
> unit-test cases break. It's a point when many developers start seeing fixing
> this minor culprit much less important... And when people stop fixing minor
> things ... major things start to be just around the corner.

If people stop fixing minor things then the kernel development process
is dead.  Based on all the changes that go into it right now, we are far
from having that problem.

So write valid tests, if we get to the point where we have too much of a
problem fixing up the tests than the real users of apis, then we can
revisit it.  But for now, that's not an issue.

And again, remember, and api can, and will, change at any moment in
time, you can never know what will be "stable" as we do not have such a
thing.

thanks,

greg k-h
