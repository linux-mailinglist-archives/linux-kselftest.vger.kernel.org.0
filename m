Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D0746CF49
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Dec 2021 09:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbhLHIrP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Dec 2021 03:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhLHIrO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Dec 2021 03:47:14 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEC2C061574;
        Wed,  8 Dec 2021 00:43:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A718DCE2047;
        Wed,  8 Dec 2021 08:43:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D21AC00446;
        Wed,  8 Dec 2021 08:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638953019;
        bh=pX6fUkTa7i3JJ/g9wo3OcRP1y21D2J3XbQ7gr4Uwbl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F7nqlhpZzGaFWLGHse34ObY5rffytFT3kVD/Giqj3SO8aJhfskvF4BcS/xUOOhHTq
         qCAhA5Q/EXZd/KqnaP+w/8nQQipZAY8Hry0Bc4Ai7P0f/bXOHw2X1BGj+5rG/14nlp
         cyxdnk6VDFalkhti/FeORQPEVrM94HRidg/4UUUI=
Date:   Wed, 8 Dec 2021 09:43:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     "David E. Box" <david.e.box@linux.intel.com>, lee.jones@linaro.org,
        hdegoede@redhat.com, bhelgaas@google.com,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com,
        shuah@kernel.org, mgross@linux.intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [V2 2/6] driver core: auxiliary bus: Add driver data helpers
Message-ID: <YbBwOb6JvWkT3JWI@kroah.com>
References: <20211207171448.799376-1-david.e.box@linux.intel.com>
 <20211207171448.799376-3-david.e.box@linux.intel.com>
 <YbBYtJFQ47UH2h/k@unreal>
 <YbBZuwXZWMV9uRXI@kroah.com>
 <YbBtjSNz8z34czeN@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbBtjSNz8z34czeN@unreal>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 08, 2021 at 10:32:13AM +0200, Leon Romanovsky wrote:
> On Wed, Dec 08, 2021 at 08:07:39AM +0100, Greg KH wrote:
> > On Wed, Dec 08, 2021 at 09:03:16AM +0200, Leon Romanovsky wrote:
> > > On Tue, Dec 07, 2021 at 09:14:44AM -0800, David E. Box wrote:
> > > > Adds get/set driver data helpers for auxiliary devices.
> > > > 
> > > > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > > > Reviewed-by: Mark Gross <markgross@kernel.org>
> > > > ---
> > > > V2
> > > >   - No changes
> > > > 
> > > >  include/linux/auxiliary_bus.h | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > 
> > > I would really like to see an explanation why such obfuscation is really
> > > needed. dev_*_drvdata() is a standard way to access driver data.
> > 
> > Lots of busses have this helper.  This is nothing new at all, and is
> > nice to have.  Look at all of the calls to dev_get_drvdata() in
> > include/linux/ for the examples.
> 
> I looked and this is why I asked. From the point of person who does
> reviews and refactoring, such obfuscations are evil.

Then you must consider about 80 busses evil :)

Again, this is a very common helper pattern in the kernel, one that we
have had for decades now.  It allows a driver writer to only worry about
the bus apis for that specific bus, and not have to dive down into the
driver core functions at all.  What is wrong with that?

> If I understand your correctly, the explanation is just copy/paste, right?

I do not understand what you mean by this, sorry.

greg k-h
