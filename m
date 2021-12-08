Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1EEA46D0BF
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Dec 2021 11:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhLHKTR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Dec 2021 05:19:17 -0500
Received: from mga06.intel.com ([134.134.136.31]:61533 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229515AbhLHKTR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Dec 2021 05:19:17 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="298595931"
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; 
   d="scan'208";a="298595931"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 02:15:45 -0800
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; 
   d="scan'208";a="606246767"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 02:15:41 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mutyD-003bOW-Of;
        Wed, 08 Dec 2021 12:14:41 +0200
Date:   Wed, 8 Dec 2021 12:14:41 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "David E. Box" <david.e.box@linux.intel.com>, lee.jones@linaro.org,
        hdegoede@redhat.com, bhelgaas@google.com,
        srinivas.pandruvada@intel.com, shuah@kernel.org,
        mgross@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [V2 2/6] driver core: auxiliary bus: Add driver data helpers
Message-ID: <YbCFkQZvIDLtPJTR@smile.fi.intel.com>
References: <20211207171448.799376-1-david.e.box@linux.intel.com>
 <20211207171448.799376-3-david.e.box@linux.intel.com>
 <YbBYtJFQ47UH2h/k@unreal>
 <YbBZuwXZWMV9uRXI@kroah.com>
 <YbBtjSNz8z34czeN@unreal>
 <YbBwOb6JvWkT3JWI@kroah.com>
 <YbB29BaOWibImGf5@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbB29BaOWibImGf5@unreal>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 08, 2021 at 11:12:20AM +0200, Leon Romanovsky wrote:
> On Wed, Dec 08, 2021 at 09:43:37AM +0100, Greg KH wrote:

...

> The idea that you have two APIs which do the same thing, one is
> obfuscated version of another.
> 
> If you don't want from people to use driver core function and structures,
> you shouldn't expose them in global headers.

For all these APIs the rationale is very simple. If you have callback that
takes a pointer to the container (*), you better use the APIs related to
this container (no need to have an explicit dereferencing). Otherwise you
use dev_*() APIs (when it's pointer to the pure struct device).

The value is to have coherent APIs around struct device containers.

*) under container here I assume the data structure that has the embedded
   struct device in it.

-- 
With Best Regards,
Andy Shevchenko


