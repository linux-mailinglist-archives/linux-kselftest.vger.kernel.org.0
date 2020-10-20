Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A4429366F
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Oct 2020 10:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387422AbgJTIIp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Oct 2020 04:08:45 -0400
Received: from mga04.intel.com ([192.55.52.120]:28580 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727761AbgJTIIm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Oct 2020 04:08:42 -0400
IronPort-SDR: FKg5ojdE59EwWR4Yb7ofH7SQoSyPQXrPcof6D1I88vRIbuYFU8UzRZrOuq7uGRkDR0v0qQKpEb
 ykEzH5JegmjA==
X-IronPort-AV: E=McAfee;i="6000,8403,9779"; a="164562994"
X-IronPort-AV: E=Sophos;i="5.77,396,1596524400"; 
   d="scan'208";a="164562994"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 01:08:42 -0700
IronPort-SDR: fi4SDY4KZtt7W2/BqYzzEnZn9S/MCUh+oO49ItV0Bq3+40Vn4cWi5agurP4DDcGN7kBoGD9JFw
 owWP7wAvoTOA==
X-IronPort-AV: E=Sophos;i="5.77,396,1596524400"; 
   d="scan'208";a="523420990"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 01:08:40 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kUmiF-00BHRg-Dx; Tue, 20 Oct 2020 11:09:43 +0300
Date:   Tue, 20 Oct 2020 11:09:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Subject: Re: [PATCH] lib: add basic KUnit test for lib/math
Message-ID: <20201020080943.GY4077@smile.fi.intel.com>
References: <20201019224556.3536790-1-dlatypov@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019224556.3536790-1-dlatypov@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 19, 2020 at 03:45:56PM -0700, Daniel Latypov wrote:
> Add basic test coverage for files that don't require any config options:
> * gcd.c
> * lcm.c
> * int_sqrt.c
> * reciprocal_div.c
> (Ignored int_pow.c since it's a simple textbook algorithm.)
> 
> These tests aren't particularly interesting, but
> * they're chosen as easy to understand examples of how to write tests
> * provides a place to add tests for any new files in this dir
> * written so adding new test cases to cover edge cases should be easy

Is documentation not enough?

I have recently wrote my first KUnit test and I found documentation pretty good
for the start. I think we actually need more complex examples in the code (and
useful).

So, I'm in doubt these test are a good point to start with.

-- 
With Best Regards,
Andy Shevchenko


