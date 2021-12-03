Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE80D467EAF
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Dec 2021 21:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383034AbhLCUOu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Dec 2021 15:14:50 -0500
Received: from mga06.intel.com ([134.134.136.31]:27304 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1382989AbhLCUOu (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Dec 2021 15:14:50 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="297847521"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="297847521"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 12:11:25 -0800
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="561875929"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 12:11:23 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mtEsu-001tb7-QI;
        Fri, 03 Dec 2021 22:10:20 +0200
Date:   Fri, 3 Dec 2021 22:10:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v12 0/7] gpio-sim: configfs-based GPIO simulator
Message-ID: <Yap5rKFwsGHvwCu9@smile.fi.intel.com>
References: <20211203133003.31786-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203133003.31786-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 03, 2021 at 02:29:56PM +0100, Bartosz Golaszewski wrote:
> Another iteration of gpio-sim patches. This time the changes are quite
> small. I removed the ifdefs from gpiolib.c as requested by Andy. In this
> version gpiolib-of will also prefer fwnodes over of_nodes and - if set -
> will convert them to of_nodes before proceeding.
> 
> Tested both with configfs as well as device-tree.

After addressing a comment in patch 3:
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
for patches 1-3.
Patch 4 has got full review but nothing specifically critical there.

-- 
With Best Regards,
Andy Shevchenko


