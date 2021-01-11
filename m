Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2DB2F10E9
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Jan 2021 12:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbhAKLPy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Jan 2021 06:15:54 -0500
Received: from mga14.intel.com ([192.55.52.115]:47306 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728511AbhAKLPy (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Jan 2021 06:15:54 -0500
IronPort-SDR: MKpLopQDdwi0MHADgC3NQOl6pVuZrMDqYutGjrZ7BIFGN24jBi1l9O+PXnGORY2PNiY6HQmzk5
 R2nuHKxfFoCQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9860"; a="177064952"
X-IronPort-AV: E=Sophos;i="5.79,338,1602572400"; 
   d="scan'208";a="177064952"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 03:14:06 -0800
IronPort-SDR: iTcvsU/SDg8Uqm1mchUyA/qxuKcBDJ3k58vzplfAE9ZddYiDDFMt4ofikuflqwePinBkXyAdMF
 PKYBjLiRFMVg==
X-IronPort-AV: E=Sophos;i="5.79,338,1602572400"; 
   d="scan'208";a="464131212"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 03:14:04 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kyvAA-00A8bW-2w; Mon, 11 Jan 2021 13:15:06 +0200
Date:   Mon, 11 Jan 2021 13:15:06 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Petr Mladek <pmladek@suse.com>, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, shuah@kernel.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v3 1/4] lib: vsprintf: scanf: Negative number must have
 field width > 1
Message-ID: <20210111111506.GX4077@smile.fi.intel.com>
References: <20201217180057.23786-1-rf@opensource.cirrus.com>
 <X/wnoJLEt0zQskDU@alley>
 <6e390f96-b813-fcf8-f159-c22595b563a3@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e390f96-b813-fcf8-f159-c22595b563a3@opensource.cirrus.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 11, 2021 at 10:37:59AM +0000, Richard Fitzgerald wrote:
> On 11/01/2021 10:25, Petr Mladek wrote:
> > Sigh, I have just realized that Andy and Rasmus, the other
> > vsprintf maintainers and reviewers, were not in CC.
> 
> Sorry, probably my fault. I sent to the maintainers and lists reported
> by get_maintainers.sh. I guess I missed that "reviewers" should also
> be directly mailed.

I usually use the following (not 100% guarantee, but quite close):

  scripts/get_maintainer.pl --git --git-min-percent=67


-- 
With Best Regards,
Andy Shevchenko


