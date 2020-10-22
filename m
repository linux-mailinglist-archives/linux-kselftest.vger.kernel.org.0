Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C83E296512
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Oct 2020 21:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369886AbgJVTLs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Oct 2020 15:11:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:21303 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S369878AbgJVTLs (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Oct 2020 15:11:48 -0400
IronPort-SDR: ud4vSNKi5MoIzhJ1ZsXvFVfcaXTnTrHIo4UjN8QmwJR42rpWliA7VR01cFSu45gSVDGdQshOpV
 Pmh3kvPsFrbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9782"; a="164088917"
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="164088917"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 12:11:47 -0700
IronPort-SDR: W+vNVUsNCq6wWKJXfRd0xUT9Q8ThOm1PMG3sCwg4e7jKbl9prIsyK2iYgJdOBjiYMLMMSlcRCJ
 5mfOotX5O6kA==
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="534088023"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 12:11:45 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kVg12-00DVhv-Hg; Thu, 22 Oct 2020 22:12:48 +0300
Date:   Thu, 22 Oct 2020 22:12:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] lib: add basic KUnit test for lib/math
Message-ID: <20201022191248.GP4077@smile.fi.intel.com>
References: <20201019224556.3536790-1-dlatypov@google.com>
 <CABVgOS=Kucf3QV=jpo3cLDgG38WvnuKpzEdP_RkBtRwHHPLe3Q@mail.gmail.com>
 <CAGS_qxpX0Do+z-wzCC=twbt-htL=Jkqvrk4L4rKTtXFPfX-TCA@mail.gmail.com>
 <20201022150648.GH4077@smile.fi.intel.com>
 <CAGS_qxogKfYBr=5jPsON60NTAoqqSK2y+dQodnZ5r0Uo0ecJ3Q@mail.gmail.com>
 <20201022191038.GO4077@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022191038.GO4077@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 22, 2020 at 10:10:38PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 22, 2020 at 09:26:45AM -0700, Daniel Latypov wrote:
> > On Thu, Oct 22, 2020 at 8:06 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Wed, Oct 21, 2020 at 10:47:50AM -0700, Daniel Latypov wrote:

...

> > > Summarize this, please create usable documentation first.
> > 
> > Sounds good.
> > I'm generally wary people not reading the docs, and of documentation
> > examples becoming bitrotted faster than actual code.
> > But so far KUnit seems to be doing relatively well on both fronts.
> 
> Dunno. As I told, I have created first unit test based on documentation (okay,
> I looked at the code, but you may read this as ratio was 90% doc / 10% existing
> code).

Side note: some cases are not described in doc and produced "interesting"
results that I have to look a lot into KUnit Python wrapper to fix bugs in it.

You may find my patches in the KUnit mailing list.

-- 
With Best Regards,
Andy Shevchenko


