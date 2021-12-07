Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2610546BB0A
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Dec 2021 13:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhLGMbM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Dec 2021 07:31:12 -0500
Received: from mga18.intel.com ([134.134.136.126]:15932 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235422AbhLGMbL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Dec 2021 07:31:11 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="224432359"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="224432359"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 04:27:41 -0800
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="579821071"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 04:27:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1muZWF-003Dpl-L4;
        Tue, 07 Dec 2021 14:24:27 +0200
Date:   Tue, 7 Dec 2021 14:24:27 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v13 2/7] gpiolib: allow to specify the firmware node in
 struct gpio_chip
Message-ID: <Ya9Seyco7elB2on2@smile.fi.intel.com>
References: <20211207093412.27833-1-brgl@bgdev.pl>
 <20211207093412.27833-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207093412.27833-3-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 07, 2021 at 10:34:07AM +0100, Bartosz Golaszewski wrote:
> Software nodes allow us to represent hierarchies for device components
> that don't have their struct device representation yet - for instance:
> banks of GPIOs under a common GPIO expander. The core gpiolib core
> however doesn't offer any way of passing this information from the
> drivers.
> 
> This extends struct gpio_chip with a pointer to fwnode that can be set
> by the driver and used to pass device properties for child nodes.
> 
> This is similar to how we handle device-tree sub-nodes with
> CONFIG_OF_GPIO enabled.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---
>  drivers/gpio/gpiolib.c      | 7 ++++++-
>  include/linux/gpio/driver.h | 2 ++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 22b98a590a88..6af732bf4c99 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -593,13 +593,18 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
>  			       struct lock_class_key *lock_key,
>  			       struct lock_class_key *request_key)
>  {
> -	struct fwnode_handle *fwnode = gc->parent ? dev_fwnode(gc->parent) : NULL;
> +	struct fwnode_handle *fwnode = NULL;
>  	unsigned long	flags;
>  	int		ret = 0;
>  	unsigned	i;
>  	int		base = gc->base;
>  	struct gpio_device *gdev;
>  
> +	if (gc->fwnode)
> +		fwnode = gc->fwnode;
> +	else if (gc->parent)
> +		fwnode = dev_fwnode(gc->parent);
> +
>  	/*
>  	 * First: allocate and populate the internal stat container, and
>  	 * set up the struct device.
> diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
> index a673a359e20b..b0728c8ad90c 100644
> --- a/include/linux/gpio/driver.h
> +++ b/include/linux/gpio/driver.h
> @@ -289,6 +289,7 @@ struct gpio_irq_chip {
>   *	number or the name of the SoC IP-block implementing it.
>   * @gpiodev: the internal state holder, opaque struct
>   * @parent: optional parent device providing the GPIOs
> + * @fwnode: optional fwnode providing this controller's properties
>   * @owner: helps prevent removal of modules exporting active GPIOs
>   * @request: optional hook for chip-specific activation, such as
>   *	enabling module power and clock; may sleep
> @@ -377,6 +378,7 @@ struct gpio_chip {
>  	const char		*label;
>  	struct gpio_device	*gpiodev;
>  	struct device		*parent;
> +	struct fwnode_handle	*fwnode;
>  	struct module		*owner;
>  
>  	int			(*request)(struct gpio_chip *gc,
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


