Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B052A0EDC
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Oct 2020 20:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgJ3Ttx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Oct 2020 15:49:53 -0400
Received: from mga03.intel.com ([134.134.136.65]:1914 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgJ3Ttw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Oct 2020 15:49:52 -0400
IronPort-SDR: OnuadSQaiXRzuROhOiLb21o2GOCEvr8v+4xKY4f0dJdJG5gHQ8oYrKq/bNKk8BUSIVfsY8etNU
 JYvT7oUgUQRg==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="168754646"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="168754646"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 12:49:52 -0700
IronPort-SDR: HL+em7wt6k4nfuhlNXHYZ84kQdjR2lRG8WDL+cxPHIcI/mFZzST5MgkWuNKaIaVguqhYgS3HsE
 KFTSxwmfpIWg==
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="525987126"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 12:49:50 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kYaQG-002SQf-8y; Fri, 30 Oct 2020 21:50:52 +0200
Date:   Fri, 30 Oct 2020 21:50:52 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        kunit-dev@googlegroups.com, Shuah Khan <skhan@linuxfoundation.org>,
        Vitor Massaru Iha <vitor@massaru.org>
Cc:     Mark Brown <broonie@kernel.org>, David Gow <davidgow@google.com>
Subject: Re: [PATCH v3 1/3] lib/list_kunit: Follow new file name convention
 for KUnit tests
Message-ID: <20201030195052.GV4077@smile.fi.intel.com>
References: <20201016110836.52613-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016110836.52613-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 16, 2020 at 02:08:34PM +0300, Andy Shevchenko wrote:
> Follow new file name convention for the KUnit tests.
> Since we have lib/*test*.c in a few variations,
> use 'kunit' suffix to distinguish usual test cases
> with KUnit-based ones.

Can we get this applied?

> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: David Gow <davidgow@google.com>
> ---
> v3: added Rb (David), expanded Cc (Mark)
>  MAINTAINERS                       | 2 +-
>  lib/Makefile                      | 2 +-
>  lib/{list-test.c => list_kunit.c} | 0
>  3 files changed, 2 insertions(+), 2 deletions(-)
>  rename lib/{list-test.c => list_kunit.c} (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4538378de6f5..20facbca9388 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10188,7 +10188,7 @@ M:	David Gow <davidgow@google.com>
>  L:	linux-kselftest@vger.kernel.org
>  L:	kunit-dev@googlegroups.com
>  S:	Maintained
> -F:	lib/list-test.c
> +F:	lib/list_kunit.c
>  
>  LIVE PATCHING
>  M:	Josh Poimboeuf <jpoimboe@redhat.com>
> diff --git a/lib/Makefile b/lib/Makefile
> index 5ca03ba6ee45..1a5e6a6ebe8d 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -350,6 +350,6 @@ obj-$(CONFIG_PLDMFW) += pldmfw/
>  
>  # KUnit tests
>  obj-$(CONFIG_BITFIELD_KUNIT) += bitfield_kunit.o
> -obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
> +obj-$(CONFIG_LIST_KUNIT_TEST) += list_kunit.o
>  obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
>  obj-$(CONFIG_BITS_TEST) += test_bits.o
> diff --git a/lib/list-test.c b/lib/list_kunit.c
> similarity index 100%
> rename from lib/list-test.c
> rename to lib/list_kunit.c
> -- 
> 2.28.0
> 

-- 
With Best Regards,
Andy Shevchenko


