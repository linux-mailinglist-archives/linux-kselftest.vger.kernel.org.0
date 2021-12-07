Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFAAA46BB0D
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Dec 2021 13:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbhLGMbl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Dec 2021 07:31:41 -0500
Received: from mga03.intel.com ([134.134.136.65]:38155 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231467AbhLGMbk (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Dec 2021 07:31:40 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="237506411"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="237506411"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 04:28:09 -0800
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="579821149"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 04:28:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1muZWj-003Dq2-Ex;
        Tue, 07 Dec 2021 14:24:57 +0200
Date:   Tue, 7 Dec 2021 14:24:57 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v13 3/7] gpiolib: of: make fwnode take precedence in
 struct gpio_chip
Message-ID: <Ya9SmcbJdHMnvg0y@smile.fi.intel.com>
References: <20211207093412.27833-1-brgl@bgdev.pl>
 <20211207093412.27833-4-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207093412.27833-4-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 07, 2021 at 10:34:08AM +0100, Bartosz Golaszewski wrote:
> If the driver sets the fwnode in struct gpio_chip, let it take
> precedence over the of_node. This only affects OF-based systems,
> ACPI needs to be converted separately.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks!

> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---
>  drivers/gpio/gpiolib-of.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index 0ad288ab6262..91dcf2c6cdd8 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -1046,6 +1046,9 @@ void of_gpio_dev_init(struct gpio_chip *gc, struct gpio_device *gdev)
>  	if (gc->parent)
>  		gdev->dev.of_node = gc->parent->of_node;
>  
> +	if (gc->fwnode)
> +		gc->of_node = to_of_node(gc->fwnode);
> +
>  	/* If the gpiochip has an assigned OF node this takes precedence */
>  	if (gc->of_node)
>  		gdev->dev.of_node = gc->of_node;
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


