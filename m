Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94008467EA7
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Dec 2021 21:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383022AbhLCULz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Dec 2021 15:11:55 -0500
Received: from mga14.intel.com ([192.55.52.115]:24760 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1382989AbhLCULz (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Dec 2021 15:11:55 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="237272831"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="237272831"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 12:08:31 -0800
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="460151835"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 12:08:28 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mtEq5-001tXU-UU;
        Fri, 03 Dec 2021 22:07:25 +0200
Date:   Fri, 3 Dec 2021 22:07:25 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v12 4/7] gpio: sim: new testing module
Message-ID: <Yap4/VshDPNxLfOt@smile.fi.intel.com>
References: <20211203133003.31786-1-brgl@bgdev.pl>
 <20211203133003.31786-5-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203133003.31786-5-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 03, 2021 at 02:30:00PM +0100, Bartosz Golaszewski wrote:
> Implement a new, modern GPIO testing module controlled by configfs
> attributes instead of module parameters. The goal of this driver is
> to provide a replacement for gpio-mockup that will be easily extensible
> with new features and doesn't require reloading the module to change
> the setup.

...

> +**Group:** ``/config/gpio-sim/gpio-device``
> +
> +**Attribute:** ``/config/gpio-sim/gpio-device/dev_name``
> +
> +**Attribute:** ``/config/gpio-sim/gpio-device/live``
> +
> +This is a directory representing a GPIO platform device. The ``'dev_name'``
> +attribute is read-only and allows the user-space to read the platform device
> +name (e.g. ``'gpio-sim.0'``). The ``'live'`` attribute allows to trigger the
> +actual creation of the device once it's fully configured. The accepted values
> +are: ``'1'`` to enable the simulated device and ``'0'`` to disable and tear
> +it down.

Perhaps it makes sense to describe properties in the order you expect to be
used, then it will be naturally to 'read and repeat' without jumping forward
and backward through the documentation.

...

> +**Group:** ``/config/gpio-sim/gpio-device/gpio-bankX``
> +
> +**Attribute:** ``/config/gpio-sim/gpio-device/gpio-bankX/chip_name``

> +**Attribute:** ``/config/gpio-sim/gpio-device/gpio-bankX/num_lines``

Why not to use the same name as in DT, i.e. ngpios?

...

> +#include <linux/gpio/driver.h>
> +#include <linux/gpio/machine.h>

I would rather move this group below to emphasize that this is closer to GPIO
then to other APIs.

> +#include <linux/sysfs.h>
> +

...here.

> +#include "gpiolib.h"

...

> +static int gpio_sim_apply_pull(struct gpio_sim_chip *chip,
> +			       unsigned int offset, int value)

I would use up to 100 here...

> +	if (test_bit(FLAG_REQUESTED, &desc->flags) &&
> +	    !test_bit(FLAG_IS_OUT, &desc->flags)) {

...here and so on.

But it's up to you.

...

> +		curr_val = !!test_bit(offset, chip->value_map);
> +		if (curr_val == value)

Do you use curr_val anywhere else? Perhaps combine these two lines.

> +			goto set_pull;

...

> +static int gpio_sim_set_config(struct gpio_chip *gc,
> +				  unsigned int offset, unsigned long config)
> +{
> +	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
> +
> +	switch (pinconf_to_config_param(config)) {
> +	case PIN_CONFIG_BIAS_PULL_UP:
> +		return gpio_sim_apply_pull(chip, offset, 1);
> +	case PIN_CONFIG_BIAS_PULL_DOWN:
> +		return gpio_sim_apply_pull(chip, offset, 0);
> +	default:

> +		break;
> +	}
> +
> +	return -ENOTSUPP;

return directly from switch-case?

> +}

...

> +static ssize_t gpio_sim_sysfs_pull_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct gpio_sim_attribute *line_attr = to_gpio_sim_attr(attr);
> +	struct gpio_sim_chip *chip = dev_get_drvdata(dev);
> +	char *repr;
> +	int pull;

	int pull_up;

? Also, where is "pull-none"?

> +	mutex_lock(&chip->lock);
> +	pull = !!test_bit(line_attr->offset, chip->pull_map);
> +	mutex_unlock(&chip->lock);

> +	if (pull)
> +		repr = "pull-up";
> +	else
> +		repr = "pull-down";
> +
> +	return sysfs_emit(buf, "%s\n", repr);

	return sysfs_emit(buf, "%pull-s\n", pull_up ? "up" : "down");

?

> +}

...

> +static ssize_t gpio_sim_sysfs_pull_store(struct device *dev,
> +					 struct device_attribute *attr,
> +					 const char *buf, size_t len)
> +{
> +	struct gpio_sim_attribute *line_attr = to_gpio_sim_attr(attr);
> +	struct gpio_sim_chip *chip = dev_get_drvdata(dev);
> +	int ret, pull;
> +
> +	if (sysfs_streq(buf, "pull-down"))
> +		pull = 0;
> +	else if (sysfs_streq(buf, "pull-up"))
> +		pull = 1;
> +	else
> +		return -EINVAL;

sysfs_match_string() and use the very same string array in the above function
to print them?

Same question about "pull-none".

> +	ret = gpio_sim_apply_pull(chip, line_attr->offset, pull);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}

...

> +		attr_group->name = devm_kasprintf(dev, GFP_KERNEL,
> +						  "sim_gpio%u", i);

Wondering if you can use devm_kasprintf_strarray().

> +		if (!attr_group->name)
> +			return -ENOMEM;

...

> +	/* Default to input mode. */
> +	bitmap_fill(chip->direction_map, num_lines);

More accurate is to use bitmap_set(). If we ever debug this it also helpful.

...

> +	ret = devm_add_action_or_reset(dev, gpio_sim_mutex_destroy,
> +				       &chip->lock);

It's 81, fine to have on one line.

> +	if (ret)
> +		return ret;

...

> +static char *gpio_sim_strdup_trimmed(const char *str, size_t count)
> +{
> +	char *dup, *trimmed, *ret;
> +
> +	dup = kstrndup(str, count, GFP_KERNEL);
> +	if (!dup)
> +		return NULL;
> +
> +	trimmed = strstrip(dup);
> +	ret = kstrdup(trimmed, GFP_KERNEL);
> +	kfree(dup);
> +	return ret;

Why not memmove() instead of additional memory allocation?

Or if you really want to save bytes, krealloc() after?

	char *dup, *start, *ret;
	size_t len;

	dup = kstrndup(str, count, GFP_KERNEL);
	if (!dup)
		return NULL;

	start = strstrip(dup);
	len = strlen(start) - (start - dup);

	memmove(dup, start, len + 1);

	ret = krealloc(dup, len + 1, GFP_KERNEL);
	if (ret)
		return ret;

	kfree(dup);
	return NULL;

?

> +}

...

> +	return sprintf(page, "%c\n", live ? '1' : '0');

	return sprintf(page, "%d\n", live ? 1 : 0);

?

...

> +	list_for_each_entry(bank, &dev->bank_list, siblings) {
> +		list_for_each_entry(line, &bank->line_list, siblings) {
> +			if (line->hog)
> +				num_hogs++;
> +		}
> +	}

> +

No need to have a blank line here, but up to you.

> +	if (!num_hogs)
> +		return 0;

...

> +		list_for_each_entry(pos, &dev->bank_list, siblings) {
> +			if (this == pos || (!this->label || !pos->label))

Too many parentheses.

> +				continue;
> +
> +			if (strcmp(this->label, pos->label) == 0)
> +				return true;
> +		}

...

> +	ret = kstrtouint(page, 10, &live);

Why not kstrtobool() (according to the documentation)?

> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&dev->lock);
> +
> +	if ((live == 0 && !gpio_sim_device_is_live_unlocked(dev)) ||
> +	    (live == 1 && gpio_sim_device_is_live_unlocked(dev)))
> +		ret = -EPERM;
> +	else if (live == 1)
> +		ret = gpio_sim_device_activate_unlocked(dev);
> +	else if (live == 0)
> +		gpio_sim_device_deactivate_unlocked(dev);

> +	else
> +		ret = -EINVAL;

This will gone if above is being applied.

> +	mutex_unlock(&dev->lock);

...

> +	mutex_lock(&dev->lock);
> +	ret = sprintf(page, "%s\n", bank->label ?: "");

Don't we use "?" in the GPIO library for similar situations?

> +	mutex_unlock(&dev->lock);

...

> +	ret = kstrtouint(page, 10, &num_lines);

Why not allowing any digit base?

> +	if (ret)
> +		return ret;

...

> +	switch (dir) {
> +	case GPIOD_IN:
> +		repr = "input";
> +		break;
> +	case GPIOD_OUT_HIGH:
> +		repr = "output-high";
> +		break;
> +	case GPIOD_OUT_LOW:
> +		repr = "output-low";
> +		break;
> +	default:
> +		/* This would be a programmer bug. */
> +		WARN(1, "Unexpected hog direction value: %d", dir);
> +		return -EINVAL;
> +	}


> +	if (strcmp(trimmed, "input") == 0)
> +		dir = GPIOD_IN;
> +	else if (strcmp(trimmed, "output-high") == 0)
> +		dir = GPIOD_OUT_HIGH;
> +	else if (strcmp(trimmed, "output-low") == 0)
> +		dir = GPIOD_OUT_LOW;
> +	else
> +		dir = -EINVAL;


Same idea, i.e. static string array and use it above and here with help
of match_string().

...

> +static struct configfs_attribute *gpio_sim_hog_config_attrs[] = {
> +	&gpio_sim_hog_config_attr_name,
> +	&gpio_sim_hog_config_attr_direction,

> +	NULL,

Comma is not needed.

> +};

...

> +	id = ida_alloc(&gpio_sim_ida, GFP_KERNEL);
> +	if (id < 0) {
> +		kfree(dev);
> +		return ERR_PTR(id);
> +	}
> +
> +	config_group_init_type_name(&dev->group, name,
> +				    &gpio_sim_device_config_group_type);
> +	dev->id = id;

If you group this assignment with above allocation it would look better.

-- 
With Best Regards,
Andy Shevchenko


