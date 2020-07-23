Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3204B22AA4E
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jul 2020 10:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgGWIEu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jul 2020 04:04:50 -0400
Received: from mga18.intel.com ([134.134.136.126]:59156 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgGWIEu (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jul 2020 04:04:50 -0400
IronPort-SDR: rrZ+scjNfuk1lDb9hf8nl2RkFJDv8BG7g3qzfWpNsGdS8EYbNK1cHb5TyiN4ZX3cTQuxN+xa0n
 bDS+j0CRKG0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="137981058"
X-IronPort-AV: E=Sophos;i="5.75,386,1589266800"; 
   d="scan'208";a="137981058"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 01:04:48 -0700
IronPort-SDR: 4g07lofFm/wx2Qvqdq5W0HHQtsEwXsbuBkxr+Ya88F0tNcUn942NqXJvZVUK5IX5NFfF4tr4H3
 zATUMg/MTEjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,386,1589266800"; 
   d="scan'208";a="310940898"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 23 Jul 2020 01:04:45 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jyWDc-003PA8-G0; Thu, 23 Jul 2020 11:04:44 +0300
Date:   Thu, 23 Jul 2020 11:04:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, brendanhiggins@google.com,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        gregkh@linuxfoundation.org, tglx@linutronix.de, fkostenzer@live.at,
        geert@linux-m68k.org, paul.gortmaker@windriver.com,
        akpm@linux-foundation.org, torvalds@linux-foundation.org
Subject: Re: [PATCH] lib: kunit: Convert test_sort to KUnit test
Message-ID: <20200723080444.GE3703480@smile.fi.intel.com>
References: <20200723000807.171940-1-vitor@massaru.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723000807.171940-1-vitor@massaru.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 22, 2020 at 09:08:07PM -0300, Vitor Massaru Iha wrote:
> This adds the conversion of the test_sort.c to KUnit test.
> 
> Please apply this commit first (linux-kselftest/kunit-fixes):
> 3f37d14b8a3152441f36b6bc74000996679f0998 kunit: kunit_config: Fix parsing of CONFIG options with space

...

>  lib/{test_sort.c => sort_kunit.c} | 31 +++++++++++++++----------------

Is it established practice to put kunit as a suffix?
For me much better to do
	ls .../test* # and note shell completions
then drop shell completions and always do something like
	ls .../*_kunit.[cSsh]

Consider this, please.

P.S. Same question to KUnit folks.

-- 
With Best Regards,
Andy Shevchenko


