Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3F82E0AE9
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Dec 2020 14:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgLVNfe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Dec 2020 08:35:34 -0500
Received: from mga03.intel.com ([134.134.136.65]:34116 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727206AbgLVNfd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Dec 2020 08:35:33 -0500
IronPort-SDR: 9DCQOnaVJDqa8UAFB13B+C8yIcZRjofVieTLa0+bCxie46+8iy53TBxhyRr+IGcPABw+Ymjqw6
 mDG/pKwtM0Hw==
X-IronPort-AV: E=McAfee;i="6000,8403,9842"; a="175966754"
X-IronPort-AV: E=Sophos;i="5.78,438,1599548400"; 
   d="scan'208";a="175966754"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2020 05:33:47 -0800
IronPort-SDR: Yp9xLDlUE44BIbvp4i10xtRt5UMVdEQAgvpoSv+idTY5J1DtkLh/B8z7QrL8XfElIe2oERtDru
 fuRABSelxFdA==
X-IronPort-AV: E=Sophos;i="5.78,438,1599548400"; 
   d="scan'208";a="341605384"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2020 05:33:45 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1krhoM-00GZrW-LM; Tue, 22 Dec 2020 15:34:46 +0200
Date:   Tue, 22 Dec 2020 15:34:46 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-um <linux-um@lists.infradead.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: kunit stopped working
Message-ID: <20201222133446.GG4077@smile.fi.intel.com>
References: <20201221144302.GR4077@smile.fi.intel.com>
 <20201221144510.GS4077@smile.fi.intel.com>
 <2d4b8148-48ca-290f-1d66-33e302e7571d@linuxfoundation.org>
 <20201221192757.GZ4077@smile.fi.intel.com>
 <20201221194008.GA4077@smile.fi.intel.com>
 <20201221200332.GB4077@smile.fi.intel.com>
 <CABVgOS=tz-611qhrn-pcgokyJeS_NStfxPRBnT60KpPhBVPGpA@mail.gmail.com>
 <CABVgOSnGnFf_LUhcbPxDYYq8q1f3aC228k2kas8=uXMvwVORLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSnGnFf_LUhcbPxDYYq8q1f3aC228k2kas8=uXMvwVORLQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 22, 2020 at 03:26:24PM +0800, David Gow wrote:
> On Tue, Dec 22, 2020 at 9:43 AM David Gow <davidgow@google.com> wrote:
> > On Tue, Dec 22, 2020 at 4:02 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Mon, Dec 21, 2020 at 09:40:08PM +0200, Andy Shevchenko wrote:

...

> > > Guys, revert helps. I am open to test any solution you may propose, thanks!

...

> I'll send this out properly as a patch to kunit_tool: while I still
> think that the default console on UML shouldn't change, it probably
> makes sense for KUnit to not rely on the default.

Thanks for fast response. I have tested and answered to the patch.

-- 
With Best Regards,
Andy Shevchenko


