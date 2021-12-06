Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9FF4469781
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Dec 2021 14:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244842AbhLFNxM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Dec 2021 08:53:12 -0500
Received: from mga07.intel.com ([134.134.136.100]:26242 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244804AbhLFNxM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Dec 2021 08:53:12 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="300699248"
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="300699248"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 05:49:43 -0800
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="678988796"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 05:49:40 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1muEMB-002nVh-Ul;
        Mon, 06 Dec 2021 15:48:39 +0200
Date:   Mon, 6 Dec 2021 15:48:39 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v12 3/7] gpiolib: of: make fwnode take precedence in
 struct gpio_chip
Message-ID: <Ya4Ut9ECbYhBkke5@smile.fi.intel.com>
References: <20211203133003.31786-1-brgl@bgdev.pl>
 <20211203133003.31786-4-brgl@bgdev.pl>
 <YapnTHQZyNCZXrgp@smile.fi.intel.com>
 <YapoW+DL4jPo69u8@smile.fi.intel.com>
 <Yapp4vakFxH7JV5B@smile.fi.intel.com>
 <CAMRc=MeWfKHWFKwRjaqczrfwhAodpDLgrWKF-zqXCsjd=gMv3g@mail.gmail.com>
 <Yap5ctmlw6NeNM+7@smile.fi.intel.com>
 <CAMRc=MffmFgCZFRziw-QJ+Y3WobJZzUh1Nbp2oym6JLqfnZCdQ@mail.gmail.com>
 <Ya4RHA91Ow9frP8t@smile.fi.intel.com>
 <CAMRc=MeqGuVsydk4ZKiEKPUv32FdaOUHg7Ee3efUda==RhjXdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MeqGuVsydk4ZKiEKPUv32FdaOUHg7Ee3efUda==RhjXdg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 06, 2021 at 02:40:36PM +0100, Bartosz Golaszewski wrote:
> On Mon, Dec 6, 2021 at 2:34 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Mon, Dec 06, 2021 at 09:41:33AM +0100, Bartosz Golaszewski wrote:
> > > On Fri, Dec 3, 2021 at 9:10 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> >
> > ...
> >
> > > This series concerns the gpio-sim driver and it only uses configfs
> > > (with manually created platform devices) or device-tree. I would
> > > prefer to do ACPI separately and I'd like you to lead that because I
> > > neither have any HW to test nor claim to understand it. :)
> >
> > Please, mention this in the commit message that ACPI is not covered (yet).
> 
> But the commit message says: "gpiolib: of: make fwnode take precedence
> in struct gpio_chip" - it says OF right here. :)

It implies that reader should have a 6th sense to know about ACPI and what
else? Please, be explicit over implicit.

-- 
With Best Regards,
Andy Shevchenko


