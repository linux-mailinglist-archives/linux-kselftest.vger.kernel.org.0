Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADFA45A7AF
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Nov 2021 17:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbhKWQd2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Nov 2021 11:33:28 -0500
Received: from mga11.intel.com ([192.55.52.93]:38175 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233425AbhKWQd1 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Nov 2021 11:33:27 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="232547348"
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="232547348"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 08:30:18 -0800
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="606866089"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 08:30:15 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mpYgN-009ptR-H8;
        Tue, 23 Nov 2021 18:30:11 +0200
Date:   Tue, 23 Nov 2021 18:30:11 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Cc:     Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v1 1/1] kunit: Replace kernel.h with the necessary
 inclusions
Message-ID: <YZ0XE9rdudT0DOPl@smile.fi.intel.com>
References: <20211110103552.60181-1-andriy.shevchenko@linux.intel.com>
 <YZJFsFmvdyfblf/k@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZJFsFmvdyfblf/k@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 15, 2021 at 01:34:08PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 10, 2021 at 12:35:52PM +0200, Andy Shevchenko wrote:
> > When kernel.h is used in the headers it adds a lot into dependency hell,
> > especially when there are circular dependencies are involved.
> > 
> > Replace kernel.h inclusion with the list of what is really being used.
> 
> Can it be applied now?

Any news so far? Should I do anything about this patch?

-- 
With Best Regards,
Andy Shevchenko


