Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52DB42A4421
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Nov 2020 12:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbgKCLYO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Nov 2020 06:24:14 -0500
Received: from mga14.intel.com ([192.55.52.115]:55749 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726058AbgKCLYO (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Nov 2020 06:24:14 -0500
IronPort-SDR: Y/Ng25F4348VVQH9JSY/rf0KVlsNTh9kLuFjxOdU42H447Gs6aou3zcY1R2ROaDwHCS2Ran/n/
 GaGKvY/mvCQA==
X-IronPort-AV: E=McAfee;i="6000,8403,9793"; a="168253596"
X-IronPort-AV: E=Sophos;i="5.77,447,1596524400"; 
   d="scan'208";a="168253596"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 03:24:13 -0800
IronPort-SDR: V41Q/pYKLp7Z/xscgwnUb/7VPD8izzzzizYpXOGAh9oW/WstKlMLb5RrQpJJJ0lU1/IBs0Rk8S
 YhHTgl5Ljh3w==
X-IronPort-AV: E=Sophos;i="5.77,447,1596524400"; 
   d="scan'208";a="470758494"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 03:24:10 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kZuR6-003Sw1-EO; Tue, 03 Nov 2020 13:25:12 +0200
Date:   Tue, 3 Nov 2020 13:25:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     SeongJae Park <sjpark@amazon.com>
Cc:     linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, SeongJae Park <sjpark@amazon.de>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v2 3/3] kunit: Introduce get_file_path() helper
Message-ID: <20201103112512.GZ4077@smile.fi.intel.com>
References: <20201026165927.19020-3-andriy.shevchenko@linux.intel.com>
 <20201028092915.8053-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028092915.8053-1-sjpark@amazon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 28, 2020 at 10:29:15AM +0100, SeongJae Park wrote:
> On Mon, 26 Oct 2020 18:59:27 +0200 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Helper allows to derive file names depending on --build_dir argument.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> > Tested-by: Brendan Higgins <brendanhiggins@google.com>
> 
> Reviewed-by: SeongJae Park <sjpark@amazon.de>

Thanks!

Brendan, Shuah, can we get this series applied, please?

-- 
With Best Regards,
Andy Shevchenko


