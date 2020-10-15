Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4FD528F883
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Oct 2020 20:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbgJOS1u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Oct 2020 14:27:50 -0400
Received: from mga11.intel.com ([192.55.52.93]:30955 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727468AbgJOS1u (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Oct 2020 14:27:50 -0400
IronPort-SDR: GEiG+tUgnJt3zzaJyubbqSesl68zbmQn4jv99ZnDc/LZisxMeoBxapLp7Twj7zYJaMQ1D1VAy2
 3fbwsKU0TIyQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="162956854"
X-IronPort-AV: E=Sophos;i="5.77,379,1596524400"; 
   d="scan'208";a="162956854"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 11:27:49 -0700
IronPort-SDR: oQzVxkm4YzuM9HZArQwQD9sk+RYThewSVVCAoZiGsXPtKf2yH1yIW3vtgv6eg73dOqezO3COMU
 +5DIlZoh9KOQ==
X-IronPort-AV: E=Sophos;i="5.77,379,1596524400"; 
   d="scan'208";a="521943142"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 11:27:48 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kT7zf-007dBX-Mc; Thu, 15 Oct 2020 21:28:51 +0300
Date:   Thu, 15 Oct 2020 21:28:51 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     David Gow <davidgow@google.com>, linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        kunit-dev@googlegroups.com
Subject: Re: [PATCH v1] lib/test_list: Follow existing pattern for a file name
Message-ID: <20201015182851.GB4077@smile.fi.intel.com>
References: <20201015135908.36628-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015135908.36628-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 15, 2020 at 04:59:08PM +0300, Andy Shevchenko wrote:
> Test in lib/ either KUnit or not are named in the same pattern,
> i.e. test_*.c, except few ones. Rename list-test.c to test_list.c
> to follow this pattern.
> 
> Note, current documentation doesn't specify any file name conventions,
> and we glad to stick with a current one in the subsystem.

Okay, according to new convention it should be either _test or _kunit. Still
not clear where to put it. New convention tell about nearby to the module it
tests, but this is header file!

Please, update documentation accordingly.

-- 
With Best Regards,
Andy Shevchenko


