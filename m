Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6674B2B4144
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Nov 2020 11:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgKPKlI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Nov 2020 05:41:08 -0500
Received: from mga07.intel.com ([134.134.136.100]:53329 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727192AbgKPKlI (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Nov 2020 05:41:08 -0500
IronPort-SDR: /VdsBdkhrRbSA73CD/k5EpZpBh0ZeiuKr3qo9lNELNuu2GNzlECfKNH7v7DnMINFdaYSAutuGu
 6pm84PNkE3Yw==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="234881983"
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="234881983"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 02:41:07 -0800
IronPort-SDR: fMl7HwzPRmkIQ4P+1r9JT8orOb0MTIJsIwEtBxFP1mqU7mR8RtJljgIAmDuuEjiboDRYdvmils
 yUYDaTekGLEQ==
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="367667328"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 02:41:05 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kebxX-0072l4-B1; Mon, 16 Nov 2020 12:42:07 +0200
Date:   Mon, 16 Nov 2020 12:42:07 +0200
From:   "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "vitor@massaru.org" <vitor@massaru.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "brendanhiggins@google.com" <brendanhiggins@google.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "davidgow@google.com" <davidgow@google.com>
Subject: Re: [PATCH v4 2/6] lib/linear_ranges_kunit: Follow new file name
 convention for KUnit tests
Message-ID: <20201116104207.GW4077@smile.fi.intel.com>
References: <20201112180732.75589-1-andriy.shevchenko@linux.intel.com>
 <20201112180732.75589-2-andriy.shevchenko@linux.intel.com>
 <0204dd7bd9107b03883c4ffeb9e2bf3d467ab9a6.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0204dd7bd9107b03883c4ffeb9e2bf3d467ab9a6.camel@fi.rohmeurope.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 13, 2020 at 06:22:08AM +0000, Vaittinen, Matti wrote:
> On Thu, 2020-11-12 at 20:07 +0200, Andy Shevchenko wrote:
> > Follow new file name convention for the KUnit tests.
> > Since we have lib/*test*.c in a few variations,
> > use 'kunit' suffix to distinguish usual test cases
> > with KUnit-based ones.

> Sorry for late reaction. I need to adjust my mail filters. The KUnit
> mails evaded my inbox even when I was in CC. I have own folder for
> KUnit - which I do not look daily. (And no Brendan, the folder is not
> called "trash", its's "kunit" and I do occasionally skim through the
> mails there).
> 
> I see this was already applied so it is late - but I wanted to say
> thank you for taking care of this Andy. It looks good to me.

You are welcome!  And thanks for review.

-- 
With Best Regards,
Andy Shevchenko


