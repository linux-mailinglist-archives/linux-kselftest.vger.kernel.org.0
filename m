Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7425C2E00F7
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Dec 2020 20:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbgLUT2m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Dec 2020 14:28:42 -0500
Received: from mga05.intel.com ([192.55.52.43]:31285 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbgLUT2m (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Dec 2020 14:28:42 -0500
IronPort-SDR: 3OictlTh1ShKlNy0cf8Kb95+8I6zCYR2uGFahXOWkJ7XhegWH/9LcfkIBZoV4igSm52UUEgZSv
 GfQwAxma/qKA==
X-IronPort-AV: E=McAfee;i="6000,8403,9842"; a="260502724"
X-IronPort-AV: E=Sophos;i="5.78,437,1599548400"; 
   d="scan'208";a="260502724"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 11:26:56 -0800
IronPort-SDR: 7T0uR/q/oDH7Ctwuc8U4KyEFlEEJN10pj4m7apogZXUS13/mkMny+qk3PB/lFomf6/SJFRGMDR
 +77239pX1dHA==
X-IronPort-AV: E=Sophos;i="5.78,437,1599548400"; 
   d="scan'208";a="456783652"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 11:26:55 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1krQqb-00GPDA-CS; Mon, 21 Dec 2020 21:27:57 +0200
Date:   Mon, 21 Dec 2020 21:27:57 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     brendanhiggins@google.com, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org
Subject: Re: kunit stopped working
Message-ID: <20201221192757.GZ4077@smile.fi.intel.com>
References: <20201221144302.GR4077@smile.fi.intel.com>
 <20201221144510.GS4077@smile.fi.intel.com>
 <2d4b8148-48ca-290f-1d66-33e302e7571d@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d4b8148-48ca-290f-1d66-33e302e7571d@linuxfoundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 21, 2020 at 11:37:44AM -0700, Shuah Khan wrote:
> On 12/21/20 7:45 AM, Andy Shevchenko wrote:
> > On Mon, Dec 21, 2020 at 04:43:02PM +0200, Andy Shevchenko wrote:
> > > Hi!
> > > 
> > > For last few weeks KUnit stopped working. Any insight?
> > > 
> > > P.S. I guess no need to tell that my kernel on which I run tests has not been
> > > changed as well as command line for wrapper:
> > > 
> > > 	tools/testing/kunit/kunit.py run --build_dir ~/$OUT_DIR
> > 
> > Current output (expected 18 tests to be run from several modules):
> > 
> > $ tools/testing/kunit/kunit.py run --build_dir ~/$OUT_DIR
> > [16:42:24] Configuring KUnit Kernel ...
> > [16:42:24] Building KUnit Kernel ...
> > [16:42:28] Starting KUnit Kernel ...
> > [ERROR] no tests run!
> > [16:42:28] ============================================================
> > [16:42:28] Testing complete. 0 tests run. 0 failed. 0 crashed.
> > [16:42:28] Elapsed time: 3.563s total, 0.002s configuring, 3.441s building, 0.000s running

> Please give more details on which repo you are using and the what's
> the top commit.

v5.10 - OK

[21:24:14] Testing complete. 14 tests run. 0 failed. 0 crashed.

Linux Next 20201221 - Not OK.

I'm expecting that v5.11-rc1 will be broken.

-- 
With Best Regards,
Andy Shevchenko


