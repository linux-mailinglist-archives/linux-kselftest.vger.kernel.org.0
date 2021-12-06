Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFE24692E8
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Dec 2021 10:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241418AbhLFJvm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Dec 2021 04:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241402AbhLFJvl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Dec 2021 04:51:41 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40149C0613F8
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Dec 2021 01:48:13 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id x15so40636086edv.1
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Dec 2021 01:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i2FEuytFiSowjvcp5Rv5NdFthmJQ1cDHJUAzORx3/6I=;
        b=Q65eS9k44WuRQFAgSSQLVTNGd0p7s1VnrwgmPETAwikuz901K6KdPxmQlvcL4NQ2rL
         CVugMXRiWuIZ4EgSfIyUe9Ye8QeUHa5FTxxNihG6DmBZtBeKUGv9PFvgt6ChtvwkNDw5
         t/3goJnlMGN7vNLOkzCzJcCkRpKZXXOy0RXFU4quhK3HfqVZ3zDxP0obkdPQMPcFXoii
         A2TDCFQKhzXZn3Bi+VK5YwOgx2bFCUjborg3X4XucuoueW/kHtFPRkgmKiMGv9vNxLF5
         dAAIkroVyvBO2V8r7IYWaWxFJBScUVxY86ena5fohNWEXIJzDlDlKbvWpZiE48+nFsWf
         QyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i2FEuytFiSowjvcp5Rv5NdFthmJQ1cDHJUAzORx3/6I=;
        b=ZsLnDc76+/8nvEu/0lAYh1p0YYK1519wZOO5aF3UCPqO/yz2qqzp1W9T8Yh+xS5YGM
         3r+wAFRoANm3owWM2zdgyeMvu6shRjiKuYSYpoRai8DudeZ+RSyCCKo3pDrlBgZNd+/n
         ewoomrGRKwX+vJ9LT7udedmk1e5ZXAa6aFs77VjT/kFhFgJUlDh5OmBwpHqClKnH44+7
         06iI6ml9hPc7nzgOnuIYxWVhls7QwgoCHadEJmzOhwTZT6bh64ugu8IzKpgcN6LeZuEM
         ZsY7ZTH5u0VsC/cAQt6olfMmKRHQT6IuM5qDZqtb9LJ9KnMH6FpTwIdxmV2MPZzsQPp7
         uOjg==
X-Gm-Message-State: AOAM530yPN3ToWh4dz9l6eT+lEqO0yiBRsAMsfKDcKzWA69d/s6gI2YF
        frMxqYMfU3S33uYW/dz2WaemUkQNpE8+DpFiWgRqpw==
X-Google-Smtp-Source: ABdhPJxOF6SEkRteu/rWArlHJHXXw9oWh0j1m0pf0+M871EzFmhcSKh8Njf98gugc61JW7S0Nd6JR5Mpp07N46B+Mc4=
X-Received: by 2002:a05:6402:354e:: with SMTP id f14mr52176492edd.245.1638784091692;
 Mon, 06 Dec 2021 01:48:11 -0800 (PST)
MIME-Version: 1.0
References: <20211203133003.31786-1-brgl@bgdev.pl> <20211203133003.31786-5-brgl@bgdev.pl>
 <Yap4/VshDPNxLfOt@smile.fi.intel.com>
In-Reply-To: <Yap4/VshDPNxLfOt@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 6 Dec 2021 10:48:00 +0100
Message-ID: <CAMRc=MegnF-VZswJym7np4sBMyFf0=gqeFGdKS0xytnmQOhUpw@mail.gmail.com>
Subject: Re: [PATCH v12 4/7] gpio: sim: new testing module
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 3, 2021 at 9:08 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Dec 03, 2021 at 02:30:00PM +0100, Bartosz Golaszewski wrote:
> > Implement a new, modern GPIO testing module controlled by configfs
> > attributes instead of module parameters. The goal of this driver is
> > to provide a replacement for gpio-mockup that will be easily extensible
> > with new features and doesn't require reloading the module to change
> > the setup.
>
> ...
>
> > +**Group:** ``/config/gpio-sim/gpio-device``
> > +
> > +**Attribute:** ``/config/gpio-sim/gpio-device/dev_name``
> > +
> > +**Attribute:** ``/config/gpio-sim/gpio-device/live``
> > +
> > +This is a directory representing a GPIO platform device. The ``'dev_name'``
> > +attribute is read-only and allows the user-space to read the platform device
> > +name (e.g. ``'gpio-sim.0'``). The ``'live'`` attribute allows to trigger the
> > +actual creation of the device once it's fully configured. The accepted values
> > +are: ``'1'`` to enable the simulated device and ``'0'`` to disable and tear
> > +it down.
>
> Perhaps it makes sense to describe properties in the order you expect to be
> used, then it will be naturally to 'read and repeat' without jumping forward
> and backward through the documentation.
>

This is such order though. You naturally configure the device, then
bank, then lines, then hogs.

> ...
>
> > +**Group:** ``/config/gpio-sim/gpio-device/gpio-bankX``
> > +
> > +**Attribute:** ``/config/gpio-sim/gpio-device/gpio-bankX/chip_name``
>
> > +**Attribute:** ``/config/gpio-sim/gpio-device/gpio-bankX/num_lines``
>
> Why not to use the same name as in DT, i.e. ngpios?
>

This would be the only attribute that follows the DT naming, the
label, line names etc. wouldn't use the same name anyway. I don't see
any advantage of it as num_lines is actually more intuitive than
ngpios IMO.

> ...
>
> > +#include <linux/gpio/driver.h>
> > +#include <linux/gpio/machine.h>
>
> I would rather move this group below to emphasize that this is closer to GPIO
> then to other APIs.
>
> > +#include <linux/sysfs.h>
> > +
>
> ...here.
>

With the number of headers in this file, I'd stick with alphabetical order.

> > +#include "gpiolib.h"
>
> ...
>
> > +static int gpio_sim_apply_pull(struct gpio_sim_chip *chip,
> > +                            unsigned int offset, int value)
>
> I would use up to 100 here...
>
> > +     if (test_bit(FLAG_REQUESTED, &desc->flags) &&
> > +         !test_bit(FLAG_IS_OUT, &desc->flags)) {
>
> ...here and so on.
>
> But it's up to you.
>

Nah, the lines are broken just fine. Let's not overuse the limit.

> ...
>
> > +             curr_val = !!test_bit(offset, chip->value_map);
> > +             if (curr_val == value)
>
> Do you use curr_val anywhere else? Perhaps combine these two lines.
>
> > +                     goto set_pull;
>

Good point.

> ...
>
> > +static int gpio_sim_set_config(struct gpio_chip *gc,
> > +                               unsigned int offset, unsigned long config)
> > +{
> > +     struct gpio_sim_chip *chip = gpiochip_get_data(gc);
> > +
> > +     switch (pinconf_to_config_param(config)) {
> > +     case PIN_CONFIG_BIAS_PULL_UP:
> > +             return gpio_sim_apply_pull(chip, offset, 1);
> > +     case PIN_CONFIG_BIAS_PULL_DOWN:
> > +             return gpio_sim_apply_pull(chip, offset, 0);
> > +     default:
>
> > +             break;
> > +     }
> > +
> > +     return -ENOTSUPP;
>
> return directly from switch-case?
>

This may be a personal preference but I don't like returning functions
without a return at the end. Always looks wrong at first glance. I'd
like to keep it.

> > +}
>
> ...
>
> > +static ssize_t gpio_sim_sysfs_pull_show(struct device *dev,
> > +                                     struct device_attribute *attr,
> > +                                     char *buf)
> > +{
> > +     struct gpio_sim_attribute *line_attr = to_gpio_sim_attr(attr);
> > +     struct gpio_sim_chip *chip = dev_get_drvdata(dev);
> > +     char *repr;
> > +     int pull;
>
>         int pull_up;
>
> ? Also, where is "pull-none"?
>

There isn't. If it's ever needed, we can extend the driver but so far
there hasn't been a need for it when testing from user-space.

> > +     mutex_lock(&chip->lock);
> > +     pull = !!test_bit(line_attr->offset, chip->pull_map);
> > +     mutex_unlock(&chip->lock);
>
> > +     if (pull)
> > +             repr = "pull-up";
> > +     else
> > +             repr = "pull-down";
> > +
> > +     return sysfs_emit(buf, "%s\n", repr);
>
>         return sysfs_emit(buf, "%pull-s\n", pull_up ? "up" : "down");
>
> ?

Sure.

>
> > +}
>
> ...
>
> > +static ssize_t gpio_sim_sysfs_pull_store(struct device *dev,
> > +                                      struct device_attribute *attr,
> > +                                      const char *buf, size_t len)
> > +{
> > +     struct gpio_sim_attribute *line_attr = to_gpio_sim_attr(attr);
> > +     struct gpio_sim_chip *chip = dev_get_drvdata(dev);
> > +     int ret, pull;
> > +
> > +     if (sysfs_streq(buf, "pull-down"))
> > +             pull = 0;
> > +     else if (sysfs_streq(buf, "pull-up"))
> > +             pull = 1;
> > +     else
> > +             return -EINVAL;
>
> sysfs_match_string() and use the very same string array in the above function
> to print them?
>
> Same question about "pull-none".
>
> > +     ret = gpio_sim_apply_pull(chip, line_attr->offset, pull);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return len;
> > +}
>
> ...
>
> > +             attr_group->name = devm_kasprintf(dev, GFP_KERNEL,
> > +                                               "sim_gpio%u", i);
>
> Wondering if you can use devm_kasprintf_strarray().
>

I would need to do that in a separate loop and handle the new array, I
think it's an overkill here.

> > +             if (!attr_group->name)
> > +                     return -ENOMEM;
>
> ...
>
> > +     /* Default to input mode. */
> > +     bitmap_fill(chip->direction_map, num_lines);
>
> More accurate is to use bitmap_set(). If we ever debug this it also helpful.
>

I'm not sure what you mean, this sets all bits to 1.

> ...
>
> > +     ret = devm_add_action_or_reset(dev, gpio_sim_mutex_destroy,
> > +                                    &chip->lock);
>
> It's 81, fine to have on one line.
>
> > +     if (ret)
> > +             return ret;
>
> ...
>
> > +static char *gpio_sim_strdup_trimmed(const char *str, size_t count)
> > +{
> > +     char *dup, *trimmed, *ret;
> > +
> > +     dup = kstrndup(str, count, GFP_KERNEL);
> > +     if (!dup)
> > +             return NULL;
> > +
> > +     trimmed = strstrip(dup);
> > +     ret = kstrdup(trimmed, GFP_KERNEL);
> > +     kfree(dup);
> > +     return ret;
>
> Why not memmove() instead of additional memory allocation?
>
> Or if you really want to save bytes, krealloc() after?
>
>         char *dup, *start, *ret;
>         size_t len;
>
>         dup = kstrndup(str, count, GFP_KERNEL);
>         if (!dup)
>                 return NULL;
>
>         start = strstrip(dup);
>         len = strlen(start) - (start - dup);
>
>         memmove(dup, start, len + 1);
>
>         ret = krealloc(dup, len + 1, GFP_KERNEL);
>         if (ret)
>                 return ret;
>
>         kfree(dup);
>         return NULL;
>
> ?
>
> > +}
>
> ...
>
> > +     return sprintf(page, "%c\n", live ? '1' : '0');
>
>         return sprintf(page, "%d\n", live ? 1 : 0);
>
> ?
>
> ...
>
> > +     list_for_each_entry(bank, &dev->bank_list, siblings) {
> > +             list_for_each_entry(line, &bank->line_list, siblings) {
> > +                     if (line->hog)
> > +                             num_hogs++;
> > +             }
> > +     }
>
> > +
>
> No need to have a blank line here, but up to you.
>
> > +     if (!num_hogs)
> > +             return 0;
>
> ...
>
> > +             list_for_each_entry(pos, &dev->bank_list, siblings) {
> > +                     if (this == pos || (!this->label || !pos->label))
>
> Too many parentheses.
>

No, this is the logic here. Skip either if both pointers point to the
same object or check if the labels are missing in at least one.

> > +                             continue;
> > +
> > +                     if (strcmp(this->label, pos->label) == 0)
> > +                             return true;
> > +             }
>
> ...
>
> > +     ret = kstrtouint(page, 10, &live);
>
> Why not kstrtobool() (according to the documentation)?
>

Sure.

> > +     if (ret)
> > +             return ret;
> > +
> > +     mutex_lock(&dev->lock);
> > +
> > +     if ((live == 0 && !gpio_sim_device_is_live_unlocked(dev)) ||
> > +         (live == 1 && gpio_sim_device_is_live_unlocked(dev)))
> > +             ret = -EPERM;
> > +     else if (live == 1)
> > +             ret = gpio_sim_device_activate_unlocked(dev);
> > +     else if (live == 0)
> > +             gpio_sim_device_deactivate_unlocked(dev);
>
> > +     else
> > +             ret = -EINVAL;
>
> This will gone if above is being applied.
>
> > +     mutex_unlock(&dev->lock);
>
> ...
>
> > +     mutex_lock(&dev->lock);
> > +     ret = sprintf(page, "%s\n", bank->label ?: "");
>
> Don't we use "?" in the GPIO library for similar situations?
>

We use it in gpiolib to indicate a lack of label but here, it's the
configuration part. I think an empty string works fine.

> > +     mutex_unlock(&dev->lock);
>
> ...
>
> > +     ret = kstrtouint(page, 10, &num_lines);
>
> Why not allowing any digit base?
>

Sure.

> > +     if (ret)
> > +             return ret;
>
> ...
>
> > +     switch (dir) {
> > +     case GPIOD_IN:
> > +             repr = "input";
> > +             break;
> > +     case GPIOD_OUT_HIGH:
> > +             repr = "output-high";
> > +             break;
> > +     case GPIOD_OUT_LOW:
> > +             repr = "output-low";
> > +             break;
> > +     default:
> > +             /* This would be a programmer bug. */
> > +             WARN(1, "Unexpected hog direction value: %d", dir);
> > +             return -EINVAL;
> > +     }
>
>
> > +     if (strcmp(trimmed, "input") == 0)
> > +             dir = GPIOD_IN;
> > +     else if (strcmp(trimmed, "output-high") == 0)
> > +             dir = GPIOD_OUT_HIGH;
> > +     else if (strcmp(trimmed, "output-low") == 0)
> > +             dir = GPIOD_OUT_LOW;
> > +     else
> > +             dir = -EINVAL;
>
>
> Same idea, i.e. static string array and use it above and here with help
> of match_string().
>

It would be great but GPIOD_IN etc. are bit flags and not sequence enums.

> ...
>
> > +static struct configfs_attribute *gpio_sim_hog_config_attrs[] = {
> > +     &gpio_sim_hog_config_attr_name,
> > +     &gpio_sim_hog_config_attr_direction,
>
> > +     NULL,
>
> Comma is not needed.
>
> > +};
>
> ...
>
> > +     id = ida_alloc(&gpio_sim_ida, GFP_KERNEL);
> > +     if (id < 0) {
> > +             kfree(dev);
> > +             return ERR_PTR(id);
> > +     }
> > +
> > +     config_group_init_type_name(&dev->group, name,
> > +                                 &gpio_sim_device_config_group_type);
> > +     dev->id = id;
>
> If you group this assignment with above allocation it would look better.
>

Actually I think it looks better now with allocating the resources
first, then setting up the structure.

Bart

> --
> With Best Regards,
> Andy Shevchenko
>
>
