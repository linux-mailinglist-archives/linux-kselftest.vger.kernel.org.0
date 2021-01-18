Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA6E2FAB96
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Jan 2021 21:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388475AbhARUfZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Jan 2021 15:35:25 -0500
Received: from mga02.intel.com ([134.134.136.20]:11904 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388424AbhARKiI (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Jan 2021 05:38:08 -0500
IronPort-SDR: yGk6tcRyZRs1Q0B032xLaLWbEgekjpMixndMTbkdbTYlT0mycpLSAhPD9LfgXKyivEpkI28ITi
 YgmRd1HnUS0Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9867"; a="165875879"
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="165875879"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 02:35:52 -0800
IronPort-SDR: X4B8qIGOxOm+Yepnyf4oX6+9r9d4Zwpv/E8Y92Chk7pAiXf5ypFJkqHdeZNq7dRfU3dIh15kFR
 1WmqdiMFtrZQ==
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="426096392"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 02:35:51 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l1Ru1-0020YC-Og; Mon, 18 Jan 2021 12:36:53 +0200
Date:   Mon, 18 Jan 2021 12:36:53 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, brendanhiggins@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Subject: Re: [PATCH v2] lib: add basic KUnit test for lib/math
Message-ID: <20210118103653.GA4077@smile.fi.intel.com>
References: <20210114182700.1298392-1-dlatypov@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114182700.1298392-1-dlatypov@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 14, 2021 at 10:27:00AM -0800, Daniel Latypov wrote:
> Add basic test coverage for files that don't require any config options:
> * gcd.c
> * lcm.c
> * int_sqrt.c
> * reciprocal_div.c
> (Ignored int_pow.c since it's a simple textbook algorithm.)
> 
> These tests aren't particularly interesting, but they
> * provide a place to add tests for any new files in this dir
> * are written so adding new test cases to cover edge cases should be easy


>  lib/math/math_test.c | 197 +++++++++++++++++++++++++++++++++++++++++++

Can it have _kunit instead of _test?


-- 
With Best Regards,
Andy Shevchenko


