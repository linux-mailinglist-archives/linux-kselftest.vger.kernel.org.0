Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE3646D0C3
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Dec 2021 11:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbhLHKUY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Dec 2021 05:20:24 -0500
Received: from mga02.intel.com ([134.134.136.20]:60059 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231377AbhLHKUX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Dec 2021 05:20:23 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="225060189"
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; 
   d="scan'208";a="225060189"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 02:16:52 -0800
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; 
   d="scan'208";a="612044887"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 02:16:48 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mutzI-003bQu-Jr;
        Wed, 08 Dec 2021 12:15:48 +0200
Date:   Wed, 8 Dec 2021 12:15:48 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Leon Romanovsky <leon@kernel.org>,
        "David E. Box" <david.e.box@linux.intel.com>, hdegoede@redhat.com,
        bhelgaas@google.com, srinivas.pandruvada@intel.com,
        shuah@kernel.org, mgross@linux.intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [V2 2/6] driver core: auxiliary bus: Add driver data helpers
Message-ID: <YbCF1DbDF/yTZPNN@smile.fi.intel.com>
References: <20211207171448.799376-1-david.e.box@linux.intel.com>
 <20211207171448.799376-3-david.e.box@linux.intel.com>
 <YbBYtJFQ47UH2h/k@unreal>
 <YbBZuwXZWMV9uRXI@kroah.com>
 <YbBwSV2IwDHNUrFH@google.com>
 <YbBxPPPaQwlcgz/c@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbBxPPPaQwlcgz/c@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 08, 2021 at 09:47:56AM +0100, Greg KH wrote:
> On Wed, Dec 08, 2021 at 08:43:53AM +0000, Lee Jones wrote:
> > On Wed, 08 Dec 2021, Greg KH wrote:
> > 
> > > On Wed, Dec 08, 2021 at 09:03:16AM +0200, Leon Romanovsky wrote:
> > > > On Tue, Dec 07, 2021 at 09:14:44AM -0800, David E. Box wrote:
> > > > > Adds get/set driver data helpers for auxiliary devices.
> > > > > 
> > > > > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > > > > Reviewed-by: Mark Gross <markgross@kernel.org>
> > > > > ---
> > > > > V2
> > > > >   - No changes
> > > > > 
> > > > >  include/linux/auxiliary_bus.h | 10 ++++++++++
> > > > >  1 file changed, 10 insertions(+)
> > > > 
> > > > I would really like to see an explanation why such obfuscation is really
> > > > needed. dev_*_drvdata() is a standard way to access driver data.
> > 
> > I wouldn't call it obfuscation, but it does looks like abstraction for
> > the sake of abstraction, which I usually push back on.  What are the
> > technical benefits over using the dev_*() variant?
> 
> See my response at:
> 	https://lore.kernel.org/r/YbBwOb6JvWkT3JWI@kroah.com
> for why it is a good thing to do.
> 
> In short, driver authors should not have to worry about mixing
> bus-specific and low-level driver core functions.

Right! I just answered to Leon with the similar view behind (using
different words).

-- 
With Best Regards,
Andy Shevchenko


