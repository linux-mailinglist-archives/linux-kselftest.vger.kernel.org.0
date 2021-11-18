Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F59455FD6
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Nov 2021 16:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhKRPxi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Nov 2021 10:53:38 -0500
Received: from mga12.intel.com ([192.55.52.136]:61602 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232145AbhKRPxi (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Nov 2021 10:53:38 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="214239384"
X-IronPort-AV: E=Sophos;i="5.87,245,1631602800"; 
   d="scan'208";a="214239384"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 07:47:05 -0800
X-IronPort-AV: E=Sophos;i="5.87,245,1631602800"; 
   d="scan'208";a="505823487"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 07:47:03 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mnjcm-008DQm-NG;
        Thu, 18 Nov 2021 17:46:56 +0200
Date:   Thu, 18 Nov 2021 17:46:56 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v9 0/4] gpio-sim: configfs-based GPIO simulator
Message-ID: <YZZ1cFWaexGlJL8C@smile.fi.intel.com>
References: <20211118145142.14519-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118145142.14519-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 18, 2021 at 03:51:38PM +0100, Bartosz Golaszewski wrote:
> This is another shot at the gpio-sim testing module. As there was no
> reasoning with configfs maintainers for many months, this time the whole
> concept of committable items has been dropped. Instead, each configfs
> chip item (or rather a group - more on that later) exposes a new
> attribute called 'live'. Writing 1 to it brings the chip on-line
> (registers the platform device) and writing 0 tears it down.
> 
> There are some caveats to that approach - for example: we can't block
> the user-space from deleting chip items when chips are live but is just
> handled by silently destroying the chip device in the background.
> 
> Andy (rightfully) pointed out that parsing of the lists of line names is
> awkward so in this iteration it's been replaced by a system that is more
> elegant and will allow to easily extend configuration options for
> specific GPIO lines. This is achieved by turning the chip's configfs
> item into a configfs group and allowing the user-space to create
> additional items inside it. The items must be called line<offset> (e.g.
> line0, line12 etc.) where the offset part indicates to the module the
> offset for which given item stores the configuration for. Within each
> such line item, there are additional attributes that allow specifying
> configuration for specific lines. Currently we only support the 'name'
> attribute but I plan to extend that to support GPIO hogging too.

One question here. Since you know how the driver looks like in both cases
(with and without committable items), would it be possible to modify what
you proposed here to the former one in case ConfigFS gains the feature?


-- 
With Best Regards,
Andy Shevchenko


