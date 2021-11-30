Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A416463C5B
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Nov 2021 17:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238166AbhK3RAM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Nov 2021 12:00:12 -0500
Received: from mga07.intel.com ([134.134.136.100]:42072 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244462AbhK3RAB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Nov 2021 12:00:01 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="299652138"
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="299652138"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 08:56:25 -0800
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="459671782"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 08:56:23 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ms6PX-000cax-Io;
        Tue, 30 Nov 2021 18:55:19 +0200
Date:   Tue, 30 Nov 2021 18:55:19 +0200
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
Message-ID: <YaZXd6XM0yL3C9vp@smile.fi.intel.com>
References: <20211130154127.12272-1-brgl@bgdev.pl>
 <20211130154127.12272-3-brgl@bgdev.pl>
 <YaZNyMV5gX5cZpar@smile.fi.intel.com>
 <YaZPACT53i4LovrM@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaZPACT53i4LovrM@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 30, 2021 at 06:19:12PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 30, 2021 at 06:14:01PM +0200, Andy Shevchenko wrote:
> > On Tue, Nov 30, 2021 at 04:41:23PM +0100, Bartosz Golaszewski wrote:
> 
> ...
> 
> > Not sure I understand the proposal. Can you provide couple of (simplest)
> > examples?
> > 
> > And also it sounds like reinventing a wheel. What problem do you have that you
> > need to solve this way?
> 
> Have you seen these:
> 	drivers/gpio/gpio-dwapb.c
> 	drivers/mfd/intel_quark_i2c_gpio.c
> ?
> 
> GPIO driver has a main (controller level) node along with children on per bank
> basis. Currently it works with the provided approach (see second driver).

Btw, may be helpful to debug swnodes application
https://lore.kernel.org/lkml/20210327222012.54103-3-andriy.shevchenko@linux.intel.com/#t

-- 
With Best Regards,
Andy Shevchenko


