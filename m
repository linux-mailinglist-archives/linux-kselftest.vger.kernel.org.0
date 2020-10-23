Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2827296BA6
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Oct 2020 11:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461026AbgJWJB0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Oct 2020 05:01:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:23238 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S461025AbgJWJB0 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Oct 2020 05:01:26 -0400
IronPort-SDR: CIFz7M4xkK2hJSSYccB1wWaT/6Vd7/MZ7j7RwPVrCaqxfZGaTTDFqU4WC5Kt7+yrN1fDFSJ/JX
 1BoBxNEyNiFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9782"; a="231840766"
X-IronPort-AV: E=Sophos;i="5.77,407,1596524400"; 
   d="scan'208";a="231840766"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2020 02:01:21 -0700
IronPort-SDR: i3SWmya743zVVazoHQs8wNWqqa8Qz6PMQjBNo1vAo4isqGXlOIatvdRXSjj0Sa+fjknEcLWddH
 eS9BjPGET3Bw==
X-IronPort-AV: E=Sophos;i="5.77,407,1596524400"; 
   d="scan'208";a="467003027"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2020 02:01:19 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kVsxo-00Dxdu-Ib; Fri, 23 Oct 2020 12:02:20 +0300
Date:   Fri, 23 Oct 2020 12:02:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] lib: add basic KUnit test for lib/math
Message-ID: <20201023090220.GU4077@smile.fi.intel.com>
References: <20201019224556.3536790-1-dlatypov@google.com>
 <CABVgOS=Kucf3QV=jpo3cLDgG38WvnuKpzEdP_RkBtRwHHPLe3Q@mail.gmail.com>
 <CAGS_qxpX0Do+z-wzCC=twbt-htL=Jkqvrk4L4rKTtXFPfX-TCA@mail.gmail.com>
 <20201022150648.GH4077@smile.fi.intel.com>
 <CAFd5g45o2G-bUvHNk2ehNuCsK6zVjN+rp88TyNmuJpfLbQi07g@mail.gmail.com>
 <20201022190526.GN4077@smile.fi.intel.com>
 <CAFd5g46RBSgqujAbPSKasP5B6ufojHwTztvOWjSg3Lxk5QGHxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g46RBSgqujAbPSKasP5B6ufojHwTztvOWjSg3Lxk5QGHxw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 22, 2020 at 02:21:40PM -0700, Brendan Higgins wrote:
> On Thu, Oct 22, 2020 at 12:04 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Oct 22, 2020 at 11:53:50AM -0700, Brendan Higgins wrote:
> > > On Thu, Oct 22, 2020 at 8:06 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:

...

> > Why do we have docs in the first place?
> > For test cases I think it's a crucial part, because tests many time are written
> > by newbies, who would like to understand all under-the-hood stuff. You imply
> 
> Good point. Yeah, we don't really have any documentation that explains
> the internals at all. I agree: we need to fix that.
> 
> > that they need to drop themselves into the code directly. It's very harsh to
> > begin with Linux kernel development, really.
> 
> No, I was not trying to imply that everyone should just jump in the
> code and ignore the docs. I was just trying to point out that some
> people - myself included - rather see code than docs. Clearly some
> people prefer docs over code as well. Thus, I was trying to argue that
> both are appropriate.
> 
> Nevertheless, based on the other comments you sent, I don't think
> that's what we are talking about: sounds like you just want us to
> improve the docs first to make sure we do it. That's fine with me.

Right. What confused me is that test cases for math were pushed as a good
example how to create a test case, but at the same time docs left untouched.

-- 
With Best Regards,
Andy Shevchenko


