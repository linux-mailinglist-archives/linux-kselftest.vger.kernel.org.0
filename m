Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8774835A202
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Apr 2021 17:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbhDIPac (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Apr 2021 11:30:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:16319 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229665AbhDIPab (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Apr 2021 11:30:31 -0400
IronPort-SDR: /Z27a6ZsnHF4f8rKg+K51iC2sskvSL3yXgcGpxneojPDpQGZC4VGwCz6hAWItdKzaM6ZuZ/8bF
 NG9c7zIC7cZA==
X-IronPort-AV: E=McAfee;i="6000,8403,9949"; a="173263176"
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="173263176"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 08:30:16 -0700
IronPort-SDR: b9aW+JDzv/r43wIU27jokbG+2KrZhFll/ltF89ooSup2gWBscWI6bCH/m+2OFMJcRH9m3OpmqA
 RLK3rZis6txg==
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="416306861"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 08:30:14 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lUt5H-002a29-RY; Fri, 09 Apr 2021 18:30:11 +0300
Date:   Fri, 9 Apr 2021 18:30:11 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH v4] lib: add basic KUnit test for lib/math
Message-ID: <YHBzA7SwH194ywRv@smile.fi.intel.com>
References: <20210409014001.2946212-1-dlatypov@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409014001.2946212-1-dlatypov@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 08, 2021 at 06:40:01PM -0700, Daniel Latypov wrote:
> Add basic test coverage for files that don't require any config options:
> * gcd.c
> * lcm.c
> * int_sqrt.c
> * reciprocal_div.c
> (Ignored int_pow.c since it's a simple textbook algorithm.)

What about adding math.h test cases?

We have some macros there and it might be a good idea to test them, for example
that round_up() and roundup() produces the same output for the same (power of
two divisor) input.

> These tests aren't particularly interesting, but they
> * provide short and simple examples of parameterized tests
> * provide a place to add tests for any new files in this dir
> * are written so adding new test cases to cover edge cases should be easy

Yes, that's why I think macros also can be a good example how to test *macro*.

-- 
With Best Regards,
Andy Shevchenko


