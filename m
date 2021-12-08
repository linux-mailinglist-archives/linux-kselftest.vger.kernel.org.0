Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334CA46CFEB
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Dec 2021 10:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhLHJWM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Dec 2021 04:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbhLHJWM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Dec 2021 04:22:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DAFC061746;
        Wed,  8 Dec 2021 01:18:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0AE7BB8200D;
        Wed,  8 Dec 2021 09:18:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1332C341C3;
        Wed,  8 Dec 2021 09:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638955117;
        bh=rdVg3VWa1um6V8JdDhtynquK+COZiesUPvhcitWSMP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hiSpUKqH4tMcBEBYlETNrzFsj29YqW8Lagp1h/wmrAgmhuUykdKHGt+IFomcoWRjv
         OLVqFmTsBUJgq+FneRJ9j1z8srKV/bfiFi+qJQwquD8KNKjCCUmJJ6jXmHSpOAY0V3
         9X3e2xcJiAMPkAJN8VYj8jEFcCVZgAoX6WVIuc9NJsF51/aDH1HChMj4snRID2lzDd
         tb4W+sIk3z4tifR1lzEpk9ZdQnfvL2csMffsokvZUlu4KYgdUdfsJm3O2yf6jpuRf2
         DIkucb/lcfJF9NpZtiHOrdG1pikkuF64bYTG6a3SGzZaZR1UptUEV92u9Z0okU5NIK
         PP+KHBJxr4r+A==
Date:   Wed, 8 Dec 2021 11:18:33 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "David E. Box" <david.e.box@linux.intel.com>, hdegoede@redhat.com,
        bhelgaas@google.com, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, shuah@kernel.org,
        mgross@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [V2 2/6] driver core: auxiliary bus: Add driver data helpers
Message-ID: <YbB4aYK4fOESbbMl@unreal>
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

You can see it in Greg's answer, there is no technical benefits in any
variant. It is simple copy/paste pattern from other buses.

Maybe it is not clear from my response, I don't care if this patch is
going to be applied or not, but I would like to hear someone explains
to me what are the benefits of such one liners.

Thanks
