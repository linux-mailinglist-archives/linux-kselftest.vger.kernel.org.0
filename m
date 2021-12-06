Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21901469923
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Dec 2021 15:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344441AbhLFOkm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Dec 2021 09:40:42 -0500
Received: from mga18.intel.com ([134.134.136.126]:2250 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244773AbhLFOkl (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Dec 2021 09:40:41 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="224193513"
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="224193513"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 06:37:12 -0800
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="679008209"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 06:37:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1muF67-002oKr-TQ;
        Mon, 06 Dec 2021 16:36:07 +0200
Date:   Mon, 6 Dec 2021 16:36:07 +0200
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
Message-ID: <Ya4f1/8N9AQUyY9J@smile.fi.intel.com>
References: <20211203133003.31786-1-brgl@bgdev.pl>
 <20211203133003.31786-4-brgl@bgdev.pl>
 <Ya4WASlzYGOFWORk@smile.fi.intel.com>
 <CAMRc=MeLVsy3hfVdQdofk+m7VcTYYKLKGyeoyK7T4r87qn6sbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MeLVsy3hfVdQdofk+m7VcTYYKLKGyeoyK7T4r87qn6sbA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 06, 2021 at 03:03:31PM +0100, Bartosz Golaszewski wrote:
> On Mon, Dec 6, 2021 at 2:55 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Fri, Dec 03, 2021 at 02:29:59PM +0100, Bartosz Golaszewski wrote:
> > > If the driver sets the fwnode in struct gpio_chip, let it take
> > > precedence over the of_node.
> >
> > By the way, have you tried this on pure DT-less/ACPI-less platform
> > (CONFIG_OF=n, CONFIG_ACPI=n)? I believe gpio-sim in that case won't work,
> > because this doesn't affect swnode case, right?
> >
> 
> Works just fine on a BeagleBone Black - both the regular GPIO
> controllers as well as DT-instantiated gpio-sim.

Yeah, I realized that myself why.

-- 
With Best Regards,
Andy Shevchenko


