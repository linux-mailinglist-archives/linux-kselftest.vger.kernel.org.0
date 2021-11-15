Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF1145038F
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Nov 2021 12:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhKOLin (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Nov 2021 06:38:43 -0500
Received: from mga11.intel.com ([192.55.52.93]:30043 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231383AbhKOLiL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Nov 2021 06:38:11 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="230884121"
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="230884121"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 03:34:18 -0800
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="671473514"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 03:34:16 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mmaFU-0072lE-Cb;
        Mon, 15 Nov 2021 13:34:08 +0200
Date:   Mon, 15 Nov 2021 13:34:08 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Cc:     Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v1 1/1] kunit: Replace kernel.h with the necessary
 inclusions
Message-ID: <YZJFsFmvdyfblf/k@smile.fi.intel.com>
References: <20211110103552.60181-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110103552.60181-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 10, 2021 at 12:35:52PM +0200, Andy Shevchenko wrote:
> When kernel.h is used in the headers it adds a lot into dependency hell,
> especially when there are circular dependencies are involved.
> 
> Replace kernel.h inclusion with the list of what is really being used.

Can it be applied now?

-- 
With Best Regards,
Andy Shevchenko


