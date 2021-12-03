Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9370A467D9F
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Dec 2021 19:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241824AbhLCTA7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Dec 2021 14:00:59 -0500
Received: from mga09.intel.com ([134.134.136.24]:61157 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242291AbhLCTA4 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Dec 2021 14:00:56 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="236850775"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="236850775"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 10:57:32 -0800
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="610513407"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 10:57:29 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mtDjP-001sHM-ES;
        Fri, 03 Dec 2021 20:56:27 +0200
Date:   Fri, 3 Dec 2021 20:56:27 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v12 3/7] gpiolib: of: make fwnode take precedence in
 struct gpio_chip
Message-ID: <YapoW+DL4jPo69u8@smile.fi.intel.com>
References: <20211203133003.31786-1-brgl@bgdev.pl>
 <20211203133003.31786-4-brgl@bgdev.pl>
 <YapnTHQZyNCZXrgp@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YapnTHQZyNCZXrgp@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 03, 2021 at 08:51:56PM +0200, Andy Shevchenko wrote:
> On Fri, Dec 03, 2021 at 02:29:59PM +0100, Bartosz Golaszewski wrote:

...

> >  	if (gc->parent)
> >  		gdev->dev.of_node = gc->parent->of_node;
> >  
> > +	if (gc->fwnode)
> > +		gc->of_node = to_of_node(gc->fwnode);
> > +
> >  	/* If the gpiochip has an assigned OF node this takes precedence */
> >  	if (gc->of_node)
> >  		gdev->dev.of_node = gc->of_node;
> 
> Similar should be done in acpi_gpio_dev_init():
> 
> 	if (gc->fwnode)
> 		device_set_node(&gdev->dev, gc->fwnode);

Hmm... On the second though this should be rather

	if (gc->fwnode)
		set_secondary_fwnode(&gdev->dev, gc->fwnode);

So the logic will be that:
 - if we have parent, set primary fwnode to it
 - if we have fwnode, set secondary one to it
 - otherwise do nothing

-- 
With Best Regards,
Andy Shevchenko


