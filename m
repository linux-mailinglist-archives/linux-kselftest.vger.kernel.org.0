Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D792128F866
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Oct 2020 20:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbgJOSWb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Oct 2020 14:22:31 -0400
Received: from mga18.intel.com ([134.134.136.126]:15889 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgJOSWb (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Oct 2020 14:22:31 -0400
IronPort-SDR: g6db8tmLVNsA3WguSQbz1OaIiqLuG9+oAKN4lNVG2cU1NgneeezaaBTlApLUmFCy+g55NEcu3b
 p8AQjnw53t+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="154245935"
X-IronPort-AV: E=Sophos;i="5.77,379,1596524400"; 
   d="scan'208";a="154245935"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 11:22:30 -0700
IronPort-SDR: r1XJlOIB6GjyjRP48YPoOq+HgmYrTrhpKoPNzRrPd0zwFUbHWNsgKJ7S2tMqjeVk5thVRFqjzL
 0Qi5UeA0AOfg==
X-IronPort-AV: E=Sophos;i="5.77,379,1596524400"; 
   d="scan'208";a="521941691"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 11:22:25 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kT7uR-007d0I-CY; Thu, 15 Oct 2020 21:23:27 +0300
Date:   Thu, 15 Oct 2020 21:23:27 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Marco Elver <elver@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        tglx@linutronix.de, geert@linux-m68k.org,
        paul.gortmaker@windriver.com, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, arnd@arndb.de,
        elfring@users.sourceforge.net, mhocko@suse.com
Subject: Re: [PATCH v2] lib: kunit: add list_sort test conversion to KUnit
Message-ID: <20201015182327.GA4077@smile.fi.intel.com>
References: <20201015014616.309000-1-vitor@massaru.org>
 <20201015174823.GY4077@smile.fi.intel.com>
 <CADQ6JjVYiDQOJt1apsygEUK=530hfF9V+8QSZ_ntgvwYYoYqfQ@mail.gmail.com>
 <20201015182121.GZ4077@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015182121.GZ4077@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 15, 2020 at 09:21:21PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 15, 2020 at 02:59:05PM -0300, Vitor Massaru Iha wrote:
> > On Thu, Oct 15, 2020 at 2:47 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Wed, Oct 14, 2020 at 10:46:16PM -0300, Vitor Massaru Iha wrote:
> > > > This adds the conversion of the runtime tests of test_list_sort,
> > > > from `lib/test_list_sort.c` to KUnit tests.
> > >
> > > >  rename lib/{test_list_sort.c => list_sort_kunit.c} (62%)
> > >
> > > One more thing. The documentation [1] doesn't specify any name conventions.
> > > So, please leave file name untouched.
> > >
> > > [1]: https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html
> > 
> > This convention hasn't yet entered the Torvaldos tree, but it is in
> > the Shuah tree: [1]
> > 
> > +Test File and Module Names
> > +==========================
> > +
> > +KUnit tests can often be compiled as a module. These modules should be named
> > +after the test suite, followed by ``_test``. If this is likely to conflict with
> > +non-KUnit tests, the suffix ``_kunit`` can also be used.
> > +
> > +The easiest way of achieving this is to name the file containing the test suite
> > +``<suite>_test.c`` (or, as above, ``<suite>_kunit.c``). This file should be
> > +placed next to the code under test.
> > +
> > +If the suite name contains some or all of the name of the test's parent
> > +directory, it may make sense to modify the source filename to reduce
> > redundancy.
> > +For example, a ``foo_firmware`` suite could be in the ``foo/firmware_test.c``
> > +file.
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit&id=2a41fc52c21b6ece49921716bd289bfebaadcc04
> 
> I see.
> 
> Can the rest of documentation be consistent with this? It seems half-baked,
> since examples show something different.
> 
> (Entire documentation if full of example-test.c)

Also it doesn't really clear about the test cases against header files, like
for list.h or bits.h. (There is no c-file and I'm not sure one desires to have
include/linux/*_kunit.c)

-- 
With Best Regards,
Andy Shevchenko


