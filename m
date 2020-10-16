Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB232901D8
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Oct 2020 11:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395253AbgJPJ25 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Oct 2020 05:28:57 -0400
Received: from mga05.intel.com ([192.55.52.43]:13570 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395037AbgJPJ24 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Oct 2020 05:28:56 -0400
IronPort-SDR: z5D9/KP+pmNhcaa70moi77wop+mdUAilv/JjdtIctdhF+VPUBfcRj5OgdjXOJhMnKDHykYoQMd
 y+9br7m0qlEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="251261932"
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="251261932"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 02:28:56 -0700
IronPort-SDR: h7zTjC+aeO9PvYGM43QOS/w+CpFWqgDjerEOLeAYndXpbp+nBa3Vd26uEUmm1TS57kb3n69y/1
 UdVwMJwxJKvQ==
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="319390281"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 02:28:54 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kTM3g-0088NJ-Q6; Fri, 16 Oct 2020 12:29:56 +0300
Date:   Fri, 16 Oct 2020 12:29:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     David Gow <davidgow@google.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH v2 2/3] lib/linear_ranges_kunit: Follow new file name
 convention for KUnit tests
Message-ID: <20201016092956.GI4077@smile.fi.intel.com>
References: <20201015184416.38999-1-andriy.shevchenko@linux.intel.com>
 <20201015184416.38999-2-andriy.shevchenko@linux.intel.com>
 <CABVgOSkA2mTpH7nXnL21zrAyi38xW_K=YnD85995u0+MLoDt5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSkA2mTpH7nXnL21zrAyi38xW_K=YnD85995u0+MLoDt5Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 16, 2020 at 01:02:20PM +0800, David Gow wrote:
> On Fri, Oct 16, 2020 at 2:44 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Follow new file name convention for the KUnit tests.
> > Since we have lib/*test*.c in a few variations,
> > use 'kunit' suffix to distinguish usual test cases
> > with KUnit-based ones.
> >
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Thanks. This looks good to me from an "I tested it and it worked" and
> a "matches the naming guidelines" point of view.
> 
> (Since the naming documentation isn't actually in Linus' branch yet,
> I'll drop a link to it here:
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/tree/Documentation/dev-tools/kunit/style.rst?h=kunit
> )
> 
> I'm not the test author though, and the naming doc does explicitly
> leave the possibility of keeping the old filenames for tests if
> there's a particularly good reason to (e.g., a lot depending on the
> module name).

Can you point out to this? Briefly looking into I haven't found that.

> I'm not aware of any such thing, and so am in favour of
> the rename, but will defer to the test authors on that point if they
> object.

> Either way,
> Reviewed-by: David Gow <davidgow@google.com>

Thanks!

-- 
With Best Regards,
Andy Shevchenko


