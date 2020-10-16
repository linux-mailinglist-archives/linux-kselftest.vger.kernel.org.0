Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6AB2903CD
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Oct 2020 13:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406120AbgJPLJD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Oct 2020 07:09:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:21426 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406107AbgJPLJD (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Oct 2020 07:09:03 -0400
IronPort-SDR: qcXH5Q0m15OCIWRF9KWD9xzkBgCvdenB2zFKJUWlBuSjdSiO7z5Af5ikdmLviFJ/D0AnqMHF6N
 O2Kr5miVLzxA==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="251276419"
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="251276419"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 04:09:02 -0700
IronPort-SDR: lLeoYPXZBTBGZjsgKqmVxaJF56agc3/SVJ/fwMq2fl6Ys3hJRVerDVELyi+YzJCXiN+8a4dVz0
 qDH320QWvRNQ==
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="319415660"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 04:09:01 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kTNcZ-008Bkg-Hf; Fri, 16 Oct 2020 14:10:03 +0300
Date:   Fri, 16 Oct 2020 14:10:03 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        kunit-dev@googlegroups.com, Shuah Khan <skhan@linuxfoundation.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH v2 2/3] lib/linear_ranges_kunit: Follow new file name
 convention for KUnit tests
Message-ID: <20201016111003.GK4077@smile.fi.intel.com>
References: <20201015184416.38999-1-andriy.shevchenko@linux.intel.com>
 <20201015184416.38999-2-andriy.shevchenko@linux.intel.com>
 <20201016103841.GA5274@sirena.org.uk>
 <20201016110344.GJ4077@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016110344.GJ4077@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 16, 2020 at 02:03:44PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 16, 2020 at 11:38:41AM +0100, Mark Brown wrote:
> > On Thu, Oct 15, 2020 at 09:44:15PM +0300, Andy Shevchenko wrote:

> > I'm missing the rest of this series - what's the story with dependencies
> > here?
> 
> There is a dependency in Makefile. Do you want me to send a new version with
> Cc'ing you all?

v3 has been sent.

-- 
With Best Regards,
Andy Shevchenko


