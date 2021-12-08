Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A124C46CF6E
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Dec 2021 09:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhLHIve (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Dec 2021 03:51:34 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34158 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhLHIvc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Dec 2021 03:51:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DDF5AB81FFF;
        Wed,  8 Dec 2021 08:47:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF038C341C6;
        Wed,  8 Dec 2021 08:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638953278;
        bh=j+ELKp8cy5a8YsOPMeIQNskvCN6ZFQzu5BiPuknPhXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XFB9ZJDZ8cSLj49JLwu9bV/KTnkTDavnPdzW1evXB6S+ZDVQ8tGx64kfS+WwnsWfU
         92H1+w8DHews+bQD911bNCdPmxKKlNe3IQicoaVF+SMGkIIyR3/gQmjUNKXC7o7fug
         L3eSFKz6Q6dczsnzRMZuSe4hGmGcQBfByLGQvHDE=
Date:   Wed, 8 Dec 2021 09:47:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "David E. Box" <david.e.box@linux.intel.com>, hdegoede@redhat.com,
        bhelgaas@google.com, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, shuah@kernel.org,
        mgross@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [V2 2/6] driver core: auxiliary bus: Add driver data helpers
Message-ID: <YbBxPPPaQwlcgz/c@kroah.com>
References: <20211207171448.799376-1-david.e.box@linux.intel.com>
 <20211207171448.799376-3-david.e.box@linux.intel.com>
 <YbBYtJFQ47UH2h/k@unreal>
 <YbBZuwXZWMV9uRXI@kroah.com>
 <YbBwSV2IwDHNUrFH@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbBwSV2IwDHNUrFH@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 08, 2021 at 08:43:53AM +0000, Lee Jones wrote:
> On Wed, 08 Dec 2021, Greg KH wrote:
> 
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
> 
> I wouldn't call it obfuscation, but it does looks like abstraction for
> the sake of abstraction, which I usually push back on.  What are the
> technical benefits over using the dev_*() variant?

See my response at:
	https://lore.kernel.org/r/YbBwOb6JvWkT3JWI@kroah.com
for why it is a good thing to do.

In short, driver authors should not have to worry about mixing
bus-specific and low-level driver core functions.

thanks,

greg k-h
