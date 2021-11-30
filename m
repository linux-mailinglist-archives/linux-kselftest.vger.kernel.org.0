Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD863463B96
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Nov 2021 17:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbhK3QXk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Nov 2021 11:23:40 -0500
Received: from mga18.intel.com ([134.134.136.126]:60499 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230361AbhK3QXj (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Nov 2021 11:23:39 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="223130858"
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="223130858"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 08:20:18 -0800
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="595494813"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 08:20:16 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ms5qa-000bqW-LJ;
        Tue, 30 Nov 2021 18:19:12 +0200
Date:   Tue, 30 Nov 2021 18:19:12 +0200
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
Message-ID: <YaZPACT53i4LovrM@smile.fi.intel.com>
References: <20211130154127.12272-1-brgl@bgdev.pl>
 <20211130154127.12272-3-brgl@bgdev.pl>
 <YaZNyMV5gX5cZpar@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaZNyMV5gX5cZpar@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 30, 2021 at 06:14:01PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 30, 2021 at 04:41:23PM +0100, Bartosz Golaszewski wrote:

...

> Not sure I understand the proposal. Can you provide couple of (simplest)
> examples?
> 
> And also it sounds like reinventing a wheel. What problem do you have that you
> need to solve this way?

Have you seen these:
	drivers/gpio/gpio-dwapb.c
	drivers/mfd/intel_quark_i2c_gpio.c
?

GPIO driver has a main (controller level) node along with children on per bank
basis. Currently it works with the provided approach (see second driver).

-- 
With Best Regards,
Andy Shevchenko


