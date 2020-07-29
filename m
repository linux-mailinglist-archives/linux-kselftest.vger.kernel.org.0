Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F7E232541
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jul 2020 21:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgG2TTx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Jul 2020 15:19:53 -0400
Received: from mga09.intel.com ([134.134.136.24]:6307 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726813AbgG2TTx (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Jul 2020 15:19:53 -0400
IronPort-SDR: Kbs0mnr1F0haw7UsaLZIbz4v/rDcSNWCDgtNizq3QTASpTP5uflnLBbDKhWahqdiuJvMDmYC+a
 /eXE7IoX1D0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="152719831"
X-IronPort-AV: E=Sophos;i="5.75,411,1589266800"; 
   d="scan'208";a="152719831"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 12:19:52 -0700
IronPort-SDR: 9RzVGALLuwjEf6BbEneL9Y8lhW66wiDJI9yQHUpi82JXlsMRSLvM/YpEAcDLtJ0yE68qDNGsgR
 PD7ny7XnW9OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,411,1589266800"; 
   d="scan'208";a="364941243"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 29 Jul 2020 12:19:49 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k0rcC-004ksx-SW; Wed, 29 Jul 2020 22:19:48 +0300
Date:   Wed, 29 Jul 2020 22:19:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, brendanhiggins@google.com,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        gregkh@linuxfoundation.org, tglx@linutronix.de, fkostenzer@live.at,
        geert@linux-m68k.org, paul.gortmaker@windriver.com,
        akpm@linux-foundation.org, torvalds@linux-foundation.org
Subject: Re: [PATCH v2] lib: kunit: Convert test_sort to KUnit test
Message-ID: <20200729191948.GZ3703480@smile.fi.intel.com>
References: <20200729191151.476368-1-vitor@massaru.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729191151.476368-1-vitor@massaru.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 29, 2020 at 04:11:51PM -0300, Vitor Massaru Iha wrote:
> This adds the conversion of the test_sort.c to KUnit test.
> 
> Please apply this commit first (linux-kselftest/kunit-fixes):
> 3f37d14b8a3152441f36b6bc74000996679f0998 kunit: kunit_config: Fix parsing of CONFIG options with space

Looks like you mixed up commit message and changelog / comments.

> Code Style Documentation: [0]
> 
> Fix these warnings Reported-by lkp@intel.com
> 
> WARNING: modpost: vmlinux.o(.data+0x4fc70): Section mismatch in reference from the variable sort_test_cases to the variable .init.text:sort_test
>    The variable sort_test_cases references
>    the variable __init sort_test
>    If the reference is valid then annotate the
>    variable with or __refdata (see linux/init.h) or name the variable
> 
> WARNING: modpost: lib/sort_kunit.o(.data+0x11c): Section mismatch in reference from the variable sort_test_cases to the function .init.text:sort_test()
>    The variable sort_test_cases references
>    the function __init sort_test()

> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: [0] https://lore.kernel.org/linux-kselftest/20200620054944.167330-1-davidgow@google.com/T/#u

This should be in different order: Link, Reported-by, SoB.
Also [0] is unnecessary

>  lib/{test_sort.c => sort_kunit.c} | 31 +++++++++++++++----------------

Still opened question why kunit is a suffix? Can't we leave same name? Can't we
do it rather prefix?

-- 
With Best Regards,
Andy Shevchenko


