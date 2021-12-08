Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDD346CF09
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Dec 2021 09:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhLHIfw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Dec 2021 03:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhLHIfv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Dec 2021 03:35:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665A5C061574;
        Wed,  8 Dec 2021 00:32:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F23AB81FDE;
        Wed,  8 Dec 2021 08:32:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143BAC00446;
        Wed,  8 Dec 2021 08:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638952337;
        bh=pTPRnyg3v7wASuKCVAM/BPssSYioHPhROKssPQl10pM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=egyZuH8BgjVWqRS0swAoaMgfsKCSx+2ZIg3xcO0TEMwDoFI17W1N6yt5N1Y/zlgyb
         +0vlvwGqgXUZa06tcUooSn7L6XxrJmfwVGiZi/Ghb3WMMH6OSTE8hlBEvbCaYhO2nR
         AizKMAsrT7E5h1Rh8DhX4jO6SJMu5hmvV3FOGIyGmOqNxuKFSWuoJ3u3hbTdFQHYOo
         iuPbXeeVRy48ryfJhuxZ8yawdGeOIBQYr7OqTSwPoHxhAKQCAFTU9Echj8sOZKoc5H
         we0MuLEXbhUIqwZd0NDLvFQZQTHey/8+h3VKDfGyDI8+QinsYQp+5uGSAupemF9qw4
         HSue9efrmiBqA==
Date:   Wed, 8 Dec 2021 10:32:13 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "David E. Box" <david.e.box@linux.intel.com>, lee.jones@linaro.org,
        hdegoede@redhat.com, bhelgaas@google.com,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com,
        shuah@kernel.org, mgross@linux.intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [V2 2/6] driver core: auxiliary bus: Add driver data helpers
Message-ID: <YbBtjSNz8z34czeN@unreal>
References: <20211207171448.799376-1-david.e.box@linux.intel.com>
 <20211207171448.799376-3-david.e.box@linux.intel.com>
 <YbBYtJFQ47UH2h/k@unreal>
 <YbBZuwXZWMV9uRXI@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbBZuwXZWMV9uRXI@kroah.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 08, 2021 at 08:07:39AM +0100, Greg KH wrote:
> On Wed, Dec 08, 2021 at 09:03:16AM +0200, Leon Romanovsky wrote:
> > On Tue, Dec 07, 2021 at 09:14:44AM -0800, David E. Box wrote:
> > > Adds get/set driver data helpers for auxiliary devices.
> > > 
> > > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > > Reviewed-by: Mark Gross <markgross@kernel.org>
> > > ---
> > > V2
> > >   - No changes
> > > 
> > >  include/linux/auxiliary_bus.h | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > 
> > I would really like to see an explanation why such obfuscation is really
> > needed. dev_*_drvdata() is a standard way to access driver data.
> 
> Lots of busses have this helper.  This is nothing new at all, and is
> nice to have.  Look at all of the calls to dev_get_drvdata() in
> include/linux/ for the examples.

I looked and this is why I asked. From the point of person who does
reviews and refactoring, such obfuscations are evil.

If I understand your correctly, the explanation is just copy/paste, right?

Thanks

> 
> thanks,
> 
> greg k-h
