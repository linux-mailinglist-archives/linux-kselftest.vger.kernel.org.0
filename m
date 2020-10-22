Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 184DE2964F2
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Oct 2020 21:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369843AbgJVTE1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Oct 2020 15:04:27 -0400
Received: from mga12.intel.com ([192.55.52.136]:29681 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S369842AbgJVTE0 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Oct 2020 15:04:26 -0400
IronPort-SDR: 1ZPztXO1pg7WeFbQWvdnR19QN/3scV/MyT3n823RD+ZwjE1U7JI8+2RJ/RVZrmdv25ZNcSSp3x
 C1rlyn2cAdTQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9782"; a="146872723"
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="146872723"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 12:04:26 -0700
IronPort-SDR: W9JF7A0t9YQMmFylVi0vver7sM5vwAcgBCSLRzHzTL7+3/fTF4zJZfcMvgmajOvTrzElQc4bBx
 rWzsHkck5mng==
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="534085151"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 12:04:24 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kVftu-00DVSp-Lj; Thu, 22 Oct 2020 22:05:26 +0300
Date:   Thu, 22 Oct 2020 22:05:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] lib: add basic KUnit test for lib/math
Message-ID: <20201022190526.GN4077@smile.fi.intel.com>
References: <20201019224556.3536790-1-dlatypov@google.com>
 <CABVgOS=Kucf3QV=jpo3cLDgG38WvnuKpzEdP_RkBtRwHHPLe3Q@mail.gmail.com>
 <CAGS_qxpX0Do+z-wzCC=twbt-htL=Jkqvrk4L4rKTtXFPfX-TCA@mail.gmail.com>
 <20201022150648.GH4077@smile.fi.intel.com>
 <CAFd5g45o2G-bUvHNk2ehNuCsK6zVjN+rp88TyNmuJpfLbQi07g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g45o2G-bUvHNk2ehNuCsK6zVjN+rp88TyNmuJpfLbQi07g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 22, 2020 at 11:53:50AM -0700, Brendan Higgins wrote:
> On Thu, Oct 22, 2020 at 8:06 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Oct 21, 2020 at 10:47:50AM -0700, Daniel Latypov wrote:

...

> > You need to put detailed comments in the code to have it as real example how to
> > create the KUnit test. But hey, it will mean that documentation sucks. So,
> > please update documentation to cover issues that you found and which motivated
> > you to create these test cases.
> 
> I don't entirely disagree; leaning too heavily on code examples can be
> detrimental to docs. That being said, when I use other people's code,
> I often don't even look at the docs. So, I think the ideal is to have
> both.

Why do we have docs in the first place?
For test cases I think it's a crucial part, because tests many time are written
by newbies, who would like to understand all under-the-hood stuff. You imply
that they need to drop themselves into the code directly. It's very harsh to
begin with Linux kernel development, really.

> > Summarize this, please create usable documentation first.

So, no go for this w/o documentation being up-to-date. Or be honest to
everybody, it's sucks it needs to be removed. Then I will get your point.

-- 
With Best Regards,
Andy Shevchenko


