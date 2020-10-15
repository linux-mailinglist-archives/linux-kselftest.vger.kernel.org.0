Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387F628F7C6
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Oct 2020 19:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgJORr0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Oct 2020 13:47:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:32994 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727075AbgJORr0 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Oct 2020 13:47:26 -0400
IronPort-SDR: igmKU7yu0+izzJKoDjQp/H2C/N8FsP369G8ePpY/xY8Ve7LzOAfsFdzhrCcRbcKdRIvcJPRnjz
 JYnHbN47ur0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="230613597"
X-IronPort-AV: E=Sophos;i="5.77,379,1596524400"; 
   d="scan'208";a="230613597"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 10:47:25 -0700
IronPort-SDR: uj7jgB5lvFEh0uZigekgd0cyAEwHYHRAu6g3y4YTb3ilDNYILx9xY9e8dOdFWCL2V/97kv346+
 CcHtSY00NZKA==
X-IronPort-AV: E=Sophos;i="5.77,379,1596524400"; 
   d="scan'208";a="314597964"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 10:47:21 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kT7MV-007boE-5R; Thu, 15 Oct 2020 20:48:23 +0300
Date:   Thu, 15 Oct 2020 20:48:23 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     kunit-dev@googlegroups.com, brendanhiggins@google.com,
        elver@google.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        geert@linux-m68k.org, paul.gortmaker@windriver.com,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        arnd@arndb.de, elfring@users.sourceforge.net, mhocko@suse.com
Subject: Re: [PATCH v2] lib: kunit: add list_sort test conversion to KUnit
Message-ID: <20201015174823.GY4077@smile.fi.intel.com>
References: <20201015014616.309000-1-vitor@massaru.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015014616.309000-1-vitor@massaru.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 14, 2020 at 10:46:16PM -0300, Vitor Massaru Iha wrote:
> This adds the conversion of the runtime tests of test_list_sort,
> from `lib/test_list_sort.c` to KUnit tests.

>  rename lib/{test_list_sort.c => list_sort_kunit.c} (62%)

One more thing. The documentation [1] doesn't specify any name conventions.
So, please leave file name untouched.

[1]: https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html

-- 
With Best Regards,
Andy Shevchenko


