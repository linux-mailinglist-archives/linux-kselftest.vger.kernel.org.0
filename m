Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4022E012C
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Dec 2020 20:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgLUTk6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Dec 2020 14:40:58 -0500
Received: from mga07.intel.com ([134.134.136.100]:17892 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbgLUTk5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Dec 2020 14:40:57 -0500
IronPort-SDR: wFxzt4UKkEB2SV/H6lPRAQjMxymAJI+KQbLRrQj1syBRSDGOml4q8/E+FcOgoap5JyA3FXcRee
 NnpSODX0UJTQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9842"; a="239858179"
X-IronPort-AV: E=Sophos;i="5.78,437,1599548400"; 
   d="scan'208";a="239858179"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 11:39:11 -0800
IronPort-SDR: XhtXtfuhJPRfhR+ziFkK7TA6uVcY8k1BPGHDlB9qIKsp4ZiTe1rZuw2CRWM6hiwrgDq9xo6JVO
 ay+DdyUMuvrg==
X-IronPort-AV: E=Sophos;i="5.78,437,1599548400"; 
   d="scan'208";a="416011232"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 11:39:09 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1krR2O-00GPKY-4E; Mon, 21 Dec 2020 21:40:08 +0200
Date:   Mon, 21 Dec 2020 21:40:08 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     brendanhiggins@google.com, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: kunit stopped working
Message-ID: <20201221194008.GA4077@smile.fi.intel.com>
References: <20201221144302.GR4077@smile.fi.intel.com>
 <20201221144510.GS4077@smile.fi.intel.com>
 <2d4b8148-48ca-290f-1d66-33e302e7571d@linuxfoundation.org>
 <20201221192757.GZ4077@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201221192757.GZ4077@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

+Cc people from culprit commit

On Mon, Dec 21, 2020 at 09:27:57PM +0200, Andy Shevchenko wrote:
> On Mon, Dec 21, 2020 at 11:37:44AM -0700, Shuah Khan wrote:
> > On 12/21/20 7:45 AM, Andy Shevchenko wrote:
> > > On Mon, Dec 21, 2020 at 04:43:02PM +0200, Andy Shevchenko wrote:
> > > > Hi!
> > > > 
> > > > For last few weeks KUnit stopped working. Any insight?
> > > > 
> > > > P.S. I guess no need to tell that my kernel on which I run tests has not been
> > > > changed as well as command line for wrapper:
> > > > 
> > > > 	tools/testing/kunit/kunit.py run --build_dir ~/$OUT_DIR
> > > 
> > > Current output (expected 18 tests to be run from several modules):
> > > 
> > > $ tools/testing/kunit/kunit.py run --build_dir ~/$OUT_DIR
> > > [16:42:24] Configuring KUnit Kernel ...
> > > [16:42:24] Building KUnit Kernel ...
> > > [16:42:28] Starting KUnit Kernel ...
> > > [ERROR] no tests run!
> > > [16:42:28] ============================================================
> > > [16:42:28] Testing complete. 0 tests run. 0 failed. 0 crashed.
> > > [16:42:28] Elapsed time: 3.563s total, 0.002s configuring, 3.441s building, 0.000s running
> 
> > Please give more details on which repo you are using and the what's
> > the top commit.
> 
> v5.10 - OK
> 
> [21:24:14] Testing complete. 14 tests run. 0 failed. 0 crashed.
> 
> Linux Next 20201221 - Not OK.
> 
> I'm expecting that v5.11-rc1 will be broken.

Luckily it's easy to bisect:

# bad: [3b45c156c48f6fa078789df83c3174f96d01ecb8] defconfig: remove everything that is not needed for netboot
# good: [2c85ebc57b3e1817b6ce1a6b703928e113a90442] Linux 5.10
# good: [2cffa11e2aa76a0560c890f057858b68fe744d03] Merge tag 'irq-core-2020-12-15' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
# bad: [9805529ec544ea7a82d891d5239a8ebd3dbb2a3e] Merge tag 'arm-soc-dt-5.11' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
# bad: [ac7ac4618cf25e0d5cd8eba83d5f600084b65b9a] Merge tag 'for-5.11/block-2020-12-14' of git://git.kernel.dk/linux-block
# good: [8958b2491104d7f254cff0698505392582dbc13a] mm: fix some spelling mistakes in comments
# good: [6febd8bef36e64fc1f4aaff1f6302be5c653ad64] Merge branch 'signal-for-v5.11' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace
# bad: [8312f41f08edc641aa927d31fb71319694ae9c42] Merge tag 'mips_5.11' of git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux
# bad: [ca5b877b6ccc7b989614f3f541e9a1fe2ff7f75a] Merge tag 'selinux-pr-20201214' of git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux
# good: [157807123c94acc8dcddd08a2335bd0173c5d68d] Merge tag 'asm-generic-mmu-context-5.11' of git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic
# good: [7194850efa47c8dac6e805087dd23c7b03af019d] Merge tag 'linux-kselftest-next-5.11-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
# bad: [d3eb52113d162cc88975fbd03c9e6f9cf2f8a771] Merge tag 'printk-for-5.11' of git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux
# good: [5e60366d56c630e32befce7ef05c569e04391ca3] Merge tag 'fallthrough-fixes-clang-5.11-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux
# bad: [5f3b8d398601055f29f32986a94d55955cd48f09] Merge branch 'for-5.11-null-console' into for-linus
# bad: [3cffa06aeef7ece30f6b5ac0ea51f264e8fea4d0] printk/console: Allow to disable console output by using console="" or console=null
# bad: [757055ae8dedf5333af17b3b5b4b70ba9bc9da4e] init/console: Use ttynull as a fallback when there is no console
# first bad commit: [757055ae8dedf5333af17b3b5b4b70ba9bc9da4e] init/console: Use ttynull as a fallback when there is no console



-- 
With Best Regards,
Andy Shevchenko


