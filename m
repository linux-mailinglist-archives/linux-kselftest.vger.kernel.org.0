Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4535B28F05C
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Oct 2020 12:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgJOKuH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Oct 2020 06:50:07 -0400
Received: from mga02.intel.com ([134.134.136.20]:10477 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbgJOKuH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Oct 2020 06:50:07 -0400
IronPort-SDR: PWZsg1gTud0v72FYPadAcSHLG3n6z3eVlcDoz6GmB0dEkQKoln1e4o9+uzWp35G8vSdc+cJK4y
 +gjbMLrgwGYw==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="153246165"
X-IronPort-AV: E=Sophos;i="5.77,378,1596524400"; 
   d="scan'208";a="153246165"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 03:50:07 -0700
IronPort-SDR: XRJgxpgsxB4D8wBiqZnKJX82Bk4f1AUWT+2R8p9xT6iB3rw/VzqF/BhBLRPBXaIElicUARBrwz
 Ddg00+IephIg==
X-IronPort-AV: E=Sophos;i="5.77,378,1596524400"; 
   d="scan'208";a="330757409"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 03:50:03 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kT0qf-007N8B-4h; Thu, 15 Oct 2020 13:51:05 +0300
Date:   Thu, 15 Oct 2020 13:51:05 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     kunit-dev@googlegroups.com, brendanhiggins@google.com,
        elver@google.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        geert@linux-m68k.org, paul.gortmaker@windriver.com,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        arnd@arndb.de, elfring@users.sourceforge.net, mhocko@suse.com
Subject: Re: [PATCH v2] lib: kunit: add list_sort test conversion to KUnit
Message-ID: <20201015105105.GS4077@smile.fi.intel.com>
References: <20201015014616.309000-1-vitor@massaru.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015014616.309000-1-vitor@massaru.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 14, 2020 at 10:46:16PM -0300, Vitor Massaru Iha wrote:
> This adds the conversion of the runtime tests of test_list_sort,
> from `lib/test_list_sort.c` to KUnit tests.

Please, provide better commit message. For example, add the output of _succeeded_
*and* _failed_ test cases (yes, you have to break code manually to reproduce failed
test cases) _before_ *and* _after_ the change.

W/o above information I'm going to NAK this as I promised before.

-- 
With Best Regards,
Andy Shevchenko


