Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9E5463B73
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Nov 2021 17:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhK3QSb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Nov 2021 11:18:31 -0500
Received: from mga06.intel.com ([134.134.136.31]:5458 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231379AbhK3QS1 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Nov 2021 11:18:27 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="297052533"
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="297052533"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 08:15:07 -0800
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="458891500"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 08:15:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ms5lZ-000bfb-60;
        Tue, 30 Nov 2021 18:14:01 +0200
Date:   Tue, 30 Nov 2021 18:14:00 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v11 2/6] gpiolib: allow to specify the firmware node in
 struct gpio_chip
Message-ID: <YaZNyMV5gX5cZpar@smile.fi.intel.com>
References: <20211130154127.12272-1-brgl@bgdev.pl>
 <20211130154127.12272-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130154127.12272-3-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 30, 2021 at 04:41:23PM +0100, Bartosz Golaszewski wrote:
> Software nodes allow us to represent hierarchies for device components
> that don't have their struct device representation yet - for instance:
> banks of GPIOs under a common GPIO expander. The core gpiolib core

core .. core ?!

> however doesn't offer any way of passing this information from the
> drivers.
> 
> This extends struct gpio_chip with a pointer to fwnode that can be set
> by the driver and used to pass device properties for child nodes.
> 
> This is similar to how we handle device-tree sub-nodes with
> CONFIG_OF_GPIO enabled.

Not sure I understand the proposal. Can you provide couple of (simplest)
examples?

And also it sounds like reinventing a wheel. What problem do you have that you
need to solve this way?

...

> +#if IS_ENABLED(CONFIG_OF_GPIO)
> +	if (gc->of_node && gc->fwnode) {
> +		pr_err("%s: tried to set both the of_node and fwnode in gpio_chip\n",
> +		       __func__);
> +		return -EINVAL;
> +	}
> +#endif /* CONFIG_OF_GPIO */

I don't like this. It seems like a hack right now.

Is it possible to convert all GPIO controller drivers to provide an fwnode
rather than doing this? (I believe in most of the drivers we can drop
completely the of_node assignment).

-- 
With Best Regards,
Andy Shevchenko


