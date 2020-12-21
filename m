Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C648B2DFCFE
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Dec 2020 15:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgLUOp7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Dec 2020 09:45:59 -0500
Received: from mga17.intel.com ([192.55.52.151]:60992 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726844AbgLUOp6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Dec 2020 09:45:58 -0500
IronPort-SDR: WI1BBSIjx9B+LYQ8ZP7/iIspD1EUlRZkJqkKI+r9M9//sJpGYgbZeMkMI1kI31VbQNSEHLV4Xz
 GFhDfYGgd7xg==
X-IronPort-AV: E=McAfee;i="6000,8403,9841"; a="155526560"
X-IronPort-AV: E=Sophos;i="5.78,436,1599548400"; 
   d="scan'208";a="155526560"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 06:44:13 -0800
IronPort-SDR: zM73jmrnyeSrBSSpM7tOXMvoj0q1D6xLAAYeZAzMa7vNftyNBKRfb15n/M86nkAIvSr2mGwz79
 +MBEnVYTtVbw==
X-IronPort-AV: E=Sophos;i="5.78,436,1599548400"; 
   d="scan'208";a="355683373"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 06:44:11 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1krMQw-00GLi9-9Q; Mon, 21 Dec 2020 16:45:10 +0200
Date:   Mon, 21 Dec 2020 16:45:10 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     brendanhiggins@google.com, skhan@linuxfoundation.org
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org
Subject: Re: kunit stopped working
Message-ID: <20201221144510.GS4077@smile.fi.intel.com>
References: <20201221144302.GR4077@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201221144302.GR4077@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 21, 2020 at 04:43:02PM +0200, Andy Shevchenko wrote:
> Hi!
> 
> For last few weeks KUnit stopped working. Any insight?
> 
> P.S. I guess no need to tell that my kernel on which I run tests has not been
> changed as well as command line for wrapper:
> 
> 	tools/testing/kunit/kunit.py run --build_dir ~/$OUT_DIR

Current output (expected 18 tests to be run from several modules):

$ tools/testing/kunit/kunit.py run --build_dir ~/$OUT_DIR
[16:42:24] Configuring KUnit Kernel ...
[16:42:24] Building KUnit Kernel ...
[16:42:28] Starting KUnit Kernel ...
[ERROR] no tests run!
[16:42:28] ============================================================
[16:42:28] Testing complete. 0 tests run. 0 failed. 0 crashed.
[16:42:28] Elapsed time: 3.563s total, 0.002s configuring, 3.441s building, 0.000s running



-- 
With Best Regards,
Andy Shevchenko


