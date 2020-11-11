Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A32D2AF747
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Nov 2020 18:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgKKRSW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Nov 2020 12:18:22 -0500
Received: from mga12.intel.com ([192.55.52.136]:46561 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgKKRSW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Nov 2020 12:18:22 -0500
IronPort-SDR: qlSNmnGUuuQxiX/TtWpt4tLceEcj5tplfwOPNxs5yYpPcHDSklNqu2YggqFTIrbwq8J5vLfwjC
 7aWQxrkeCtHw==
X-IronPort-AV: E=McAfee;i="6000,8403,9802"; a="149454585"
X-IronPort-AV: E=Sophos;i="5.77,470,1596524400"; 
   d="scan'208";a="149454585"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 09:18:21 -0800
IronPort-SDR: FW6FupkDln+ISNLRUPaxEThHLOuitvTSU+Gef48MNIAGnZPGpxzm0QRiJeYDFNaUM3arFMMsPH
 LPdtrT8e3EnA==
X-IronPort-AV: E=Sophos;i="5.77,470,1596524400"; 
   d="scan'208";a="473924812"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 09:18:19 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kctmD-005xtK-PH; Wed, 11 Nov 2020 19:19:21 +0200
Date:   Wed, 11 Nov 2020 19:19:21 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        SeongJae Park <sjpark@amazon.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH v2 3/3] kunit: Introduce get_file_path() helper
Message-ID: <20201111171921.GQ4077@smile.fi.intel.com>
References: <20201026165927.19020-3-andriy.shevchenko@linux.intel.com>
 <20201028092915.8053-1-sjpark@amazon.com>
 <20201103112512.GZ4077@smile.fi.intel.com>
 <CAFd5g44dLoUwfNPsMqavU_KrJ5+xoLgKT0Ec2_-pxVYxjMHiWA@mail.gmail.com>
 <20201105172855.GB4077@smile.fi.intel.com>
 <f3c2de52-5955-6392-6b10-edb4dc4cf231@linuxfoundation.org>
 <3d481d6b-c7aa-303b-841a-111aebd55a8e@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d481d6b-c7aa-303b-841a-111aebd55a8e@linuxfoundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 10, 2020 at 02:15:09PM -0700, Shuah Khan wrote:
> On 11/5/20 10:56 AM, Shuah Khan wrote:

...

> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/
> kuni-fixes branch.
> 
> I will send them up in my next pull request, probably rc5.

Thank you!

-- 
With Best Regards,
Andy Shevchenko


