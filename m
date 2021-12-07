Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F9D46BD1B
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Dec 2021 14:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237449AbhLGOC6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Dec 2021 09:02:58 -0500
Received: from mga03.intel.com ([134.134.136.65]:44681 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237475AbhLGOCy (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Dec 2021 09:02:54 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="237520283"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="237520283"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 05:59:21 -0800
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="611683512"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 05:59:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1muaz5-003FHL-3t;
        Tue, 07 Dec 2021 15:58:19 +0200
Date:   Tue, 7 Dec 2021 15:58:18 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v13 4/7] gpio: sim: new testing module
Message-ID: <Ya9oehdM7nCq1oPd@smile.fi.intel.com>
References: <20211207093412.27833-1-brgl@bgdev.pl>
 <20211207093412.27833-5-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207093412.27833-5-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 07, 2021 at 10:34:09AM +0100, Bartosz Golaszewski wrote:
> Implement a new, modern GPIO testing module controlled by configfs
> attributes instead of module parameters. The goal of this driver is
> to provide a replacement for gpio-mockup that will be easily extensible
> with new features and doesn't require reloading the module to change
> the setup.

A couple of nit-picks, you may fix without resend.

...

> +static const char *const gpio_sim_sysfs_pull_strings[] = {
> +	[0]	= "pull-down",
> +	[1]	= "pull-up"

+ Comma

> +};
> +
> +static ssize_t gpio_sim_sysfs_pull_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct gpio_sim_attribute *line_attr = to_gpio_sim_attr(attr);
> +	struct gpio_sim_chip *chip = dev_get_drvdata(dev);
> +	int pull;
> +
> +	mutex_lock(&chip->lock);
> +	pull = !!test_bit(line_attr->offset, chip->pull_map);
> +	mutex_unlock(&chip->lock);
> +
> +	return sysfs_emit(buf, "%s\n", gpio_sim_sysfs_pull_strings[pull]);
> +}
> +
> +static ssize_t gpio_sim_sysfs_pull_store(struct device *dev,
> +					 struct device_attribute *attr,
> +					 const char *buf, size_t len)
> +{
> +	struct gpio_sim_attribute *line_attr = to_gpio_sim_attr(attr);
> +	struct gpio_sim_chip *chip = dev_get_drvdata(dev);
> +	int ret, pull;
> +
> +	pull = sysfs_match_string(gpio_sim_sysfs_pull_strings, buf);
> +	if (pull < 0)

> +		return -EINVAL;

	return pull;

> +
> +	ret = gpio_sim_apply_pull(chip, line_attr->offset, pull);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}

-- 
With Best Regards,
Andy Shevchenko


