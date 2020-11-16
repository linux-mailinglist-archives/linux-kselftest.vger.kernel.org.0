Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFCF2B404C
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Nov 2020 10:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbgKPJwM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Nov 2020 04:52:12 -0500
Received: from mga04.intel.com ([192.55.52.120]:26471 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728572AbgKPJwM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Nov 2020 04:52:12 -0500
IronPort-SDR: M+WLh1fUPgsWpbxm0TrDo/sZS1/tVq2PKeDA26/wKkxBxi9u4DdI6MMOaFDNdMdNsD4tqNIsQs
 qvuIuU5smcQw==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="168146641"
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="168146641"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 01:52:10 -0800
IronPort-SDR: J+4O3QEsjsB2rZ2LCU9CBwJcLtZrMhowaL6Hkn2bd9mn1bOo+Mi+r+EO/Z2qZ2RBFV/uAmrGcC
 JPmq+Cf/Z3ew==
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="329633501"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 01:52:07 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kebC9-0072Lc-O8; Mon, 16 Nov 2020 11:53:09 +0200
Date:   Mon, 16 Nov 2020 11:53:09 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Shuah Khan <skhan@linuxfoundation.org>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Mark Brown <broonie@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>
Subject: Re: [PATCH v4 6/6] lib/cmdline_kunit: Add a new test suite for
 cmdline API
Message-ID: <20201116095309.GR4077@smile.fi.intel.com>
References: <20201112180732.75589-1-andriy.shevchenko@linux.intel.com>
 <20201112180732.75589-6-andriy.shevchenko@linux.intel.com>
 <20201112191025.bd5df6a1f1f6b0419980da1a@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112191025.bd5df6a1f1f6b0419980da1a@linux-foundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 12, 2020 at 07:10:25PM -0800, Andrew Morton wrote:
> On Thu, 12 Nov 2020 20:07:32 +0200 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Test get_option() for a starter which is provided by cmdline.c.
> > 
> > ...
> >
> >  lib/cmdline_kunit.c | 98 +++++++++++++++++++++++++++++++++++++++++++++

First of all, thanks for taking care of this!

> The spectacular warning storm which this produces makes me wonder if
> you sent the correct version?  I mean, the cmdline_test_values[]
> definition wasn't even close.

This now puzzles me, what happened. I will check my branches, because certainly
I was not only compiled that, but actually run those test cases.

There is warning about license, I'm going to address right now.

-- 
With Best Regards,
Andy Shevchenko


