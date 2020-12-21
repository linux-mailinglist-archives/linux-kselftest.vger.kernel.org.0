Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D50B2E0164
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Dec 2020 21:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbgLUUES (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Dec 2020 15:04:18 -0500
Received: from mga01.intel.com ([192.55.52.88]:16173 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbgLUUES (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Dec 2020 15:04:18 -0500
IronPort-SDR: /484xYpnXx/W+ybnGf5vCLNDbfCF4ZDsFt0g9cWT+ZcoTtN0NFI5qB7s8V3/MS9lB+BibnsP9i
 /rNuSd0zfLpA==
X-IronPort-AV: E=McAfee;i="6000,8403,9842"; a="194207035"
X-IronPort-AV: E=Sophos;i="5.78,437,1599548400"; 
   d="scan'208";a="194207035"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 12:02:33 -0800
IronPort-SDR: T9AHwNsMThiuu65qWQGXi4IgL3Er0/AeX5Ui0fIJf/1Rqosb7vJu54/GnADczns740doeHKBvp
 rYGkuCxwCsEw==
X-IronPort-AV: E=Sophos;i="5.78,437,1599548400"; 
   d="scan'208";a="416016690"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 12:02:31 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1krRP3-00GPZ3-03; Mon, 21 Dec 2020 22:03:33 +0200
Date:   Mon, 21 Dec 2020 22:03:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     brendanhiggins@google.com, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: kunit stopped working
Message-ID: <20201221200332.GB4077@smile.fi.intel.com>
References: <20201221144302.GR4077@smile.fi.intel.com>
 <20201221144510.GS4077@smile.fi.intel.com>
 <2d4b8148-48ca-290f-1d66-33e302e7571d@linuxfoundation.org>
 <20201221192757.GZ4077@smile.fi.intel.com>
 <20201221194008.GA4077@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201221194008.GA4077@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 21, 2020 at 09:40:08PM +0200, Andy Shevchenko wrote:
> +Cc people from culprit commit

Guys, revert helps. I am open to test any solution you may propose, thanks!

...

> # first bad commit: [757055ae8dedf5333af17b3b5b4b70ba9bc9da4e] init/console: Use ttynull as a fallback when there is no console

-- 
With Best Regards,
Andy Shevchenko


