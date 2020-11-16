Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE7E2B4143
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Nov 2020 11:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgKPKkc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Nov 2020 05:40:32 -0500
Received: from mga05.intel.com ([192.55.52.43]:26654 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbgKPKkc (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Nov 2020 05:40:32 -0500
IronPort-SDR: 9Ju7kNzu2bmRnu4jQamY5Nyke2JazcP8pGSSyjG7cljIDLZkwRrm2UvmWkut/nv3aeHtGd2xyE
 tfF4P3JIptWA==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="255438745"
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="255438745"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 02:40:31 -0800
IronPort-SDR: mx1MWvy1HrbMK1TmFk4eudKO/yoaASYcuDtX85paTx7UaDLSTooKqauhyqDBQxLf8RjUiTdwz1
 pn0R6uBTZ+ow==
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="358419371"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 02:40:29 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kebwx-0072kf-GG; Mon, 16 Nov 2020 12:41:31 +0200
Date:   Mon, 16 Nov 2020 12:41:31 +0200
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
Message-ID: <20201116104131.GV4077@smile.fi.intel.com>
References: <20201112180732.75589-1-andriy.shevchenko@linux.intel.com>
 <20201112180732.75589-6-andriy.shevchenko@linux.intel.com>
 <20201112191025.bd5df6a1f1f6b0419980da1a@linux-foundation.org>
 <20201116095309.GR4077@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116095309.GR4077@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 16, 2020 at 11:53:09AM +0200, Andy Shevchenko wrote:
> On Thu, Nov 12, 2020 at 07:10:25PM -0800, Andrew Morton wrote:
> > On Thu, 12 Nov 2020 20:07:32 +0200 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > 
> > > Test get_option() for a starter which is provided by cmdline.c.
> > > 
> > > ...
> > >
> > >  lib/cmdline_kunit.c | 98 +++++++++++++++++++++++++++++++++++++++++++++
> 
> First of all, thanks for taking care of this!
> 
> > The spectacular warning storm which this produces makes me wonder if
> > you sent the correct version?  I mean, the cmdline_test_values[]
> > definition wasn't even close.
> 
> This now puzzles me, what happened. I will check my branches, because certainly
> I was not only compiled that, but actually run those test cases.

David, Brendan, can we somehow make those warnings visible when run test suite
via kunit Python wrapper?

It seems to me that I run test cases only via wrapper and I have got no
warnings which are ones that must be fixed before submission. It's actual
disadvantage of the framework (use of it via wrapper) that makes me feel
like I would rather not hurry up with KUnit.

-- 
With Best Regards,
Andy Shevchenko


