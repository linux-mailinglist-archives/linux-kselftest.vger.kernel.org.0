Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2974F2EB2E3
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Jan 2021 19:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbhAES6S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Jan 2021 13:58:18 -0500
Received: from mga18.intel.com ([134.134.136.126]:20188 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbhAES6S (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Jan 2021 13:58:18 -0500
IronPort-SDR: skxWC0dT+DAXK79/famgBeVPElHRmoebQSwhxVx75wJzxovfaHg1KWca3SOUBvqfFAhDEet9kW
 0mchsn5iJtvQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9855"; a="164862199"
X-IronPort-AV: E=Sophos;i="5.78,477,1599548400"; 
   d="scan'208";a="164862199"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 10:56:31 -0800
IronPort-SDR: jV3VpsYgemPdSpXkTfxzlrnY5JBAvHeFX19eOeNvrfOSTxqSSlwrNUCmOjAcj07LB4z9uBY6ut
 yB97IkjFbdNA==
X-IronPort-AV: E=Sophos;i="5.78,477,1599548400"; 
   d="scan'208";a="565549167"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 10:56:29 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kwrWN-002Oni-6x; Tue, 05 Jan 2021 20:57:31 +0200
Date:   Tue, 5 Jan 2021 20:57:31 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Petr Mladek <pmladek@suse.com>, David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kunit: tool: Force the use of the 'tty' console for UML
Message-ID: <20210105185731.GT4077@smile.fi.intel.com>
References: <20201222073900.3490607-1-davidgow@google.com>
 <20201222111102.GC4077@smile.fi.intel.com>
 <4ae7779c-15c5-0474-5840-44531dcf1d94@linuxfoundation.org>
 <X/SSJQ+I5zEMaYYJ@alley>
 <3828c7ee-52b0-42f9-5771-74ef9386756c@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3828c7ee-52b0-42f9-5771-74ef9386756c@linuxfoundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 05, 2021 at 09:34:33AM -0700, Shuah Khan wrote:
> On 1/5/21 9:21 AM, Petr Mladek wrote:
> > On Mon 2021-01-04 09:23:57, Shuah Khan wrote:
> > > On 12/22/20 4:11 AM, Andy Shevchenko wrote:
> > > > On Mon, Dec 21, 2020 at 11:39:00PM -0800, David Gow wrote:
> > > > > kunit_tool relies on the UML console outputting printk() output to the
> > > > > tty in order to get results. Since the default console driver could
> > > > > change, pass 'console=tty' to the kernel.
> > > > > 
> > > > > This is triggered by a change[1] to use ttynull as a fallback console
> > > > > driver which -- by chance or by design -- seems to have changed the
> > > > > default console output on UML, breaking kunit_tool. While this may be
> > > > > fixed, we should be less fragile to such changes in the default.
> > > > > 
> > > > > [1]:
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=757055ae8dedf5333af17b3b5b4b70ba9bc9da4e
> > > > 
> > > > Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > 
> > > 
> > > Thank you all. Now in linux-kselftest kunit-fixes branch.
> > > 
> > > Will send this up for rc3.
> > > 
> > > Sorry for the delay - have been away from the keyboard for a
> > > bit.
> > 
> > JFYI, I am not sure that this is the right solution. I am
> > looking into it, see
> > https://lore.kernel.org/linux-kselftest/X%2FSRA1P8t+ONZFKb@alley/
> > for more details.
> > 
> 
> Thanks Petr. I will hold off on sending the patch up to Linus and
> let you find a the right solution.

Please. leave it in Linux Next at least. Otherwise kunit will be broken for a
long time which is not good.


-- 
With Best Regards,
Andy Shevchenko


