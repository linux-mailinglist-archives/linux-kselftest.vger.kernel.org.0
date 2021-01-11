Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110BD2F10E4
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Jan 2021 12:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbhAKLN4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Jan 2021 06:13:56 -0500
Received: from mga06.intel.com ([134.134.136.31]:52483 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727143AbhAKLN4 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Jan 2021 06:13:56 -0500
IronPort-SDR: oc8yQTos5UGbXtQRsbLfnmW/D5NMm6buzMPB1Bc1BR8h8nGvKvBknQNcRqoATcrMZ1uQlSNGaD
 L51U24Os/CNQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9860"; a="239384620"
X-IronPort-AV: E=Sophos;i="5.79,338,1602572400"; 
   d="scan'208";a="239384620"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 03:13:10 -0800
IronPort-SDR: QttBTfr48Xyi6MyBpwAiEQudiv/a2xDxer/36n8OAkM1vYyTsJHuEg2qeUTwTUwYM7wA0B57Dx
 hWeE/gc4+ypA==
X-IronPort-AV: E=Sophos;i="5.79,338,1602572400"; 
   d="scan'208";a="464131003"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 03:13:08 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1kyv9F-00A8Xk-5t; Mon, 11 Jan 2021 13:14:09 +0200
Date:   Mon, 11 Jan 2021 13:14:09 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Shuah Khan <shuah@kernel.org>, patches@opensource.cirrus.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v3 1/4] lib: vsprintf: scanf: Negative number must have
 field width > 1
Message-ID: <20210111111409.GW4077@smile.fi.intel.com>
References: <20201217180057.23786-1-rf@opensource.cirrus.com>
 <X/wnoJLEt0zQskDU@alley>
 <CAHp75VfeccM8D=DT-j4ApPAbDhDgV_M_FKOyXEMP8YBJZMed=g@mail.gmail.com>
 <f9aa8622-0c64-072b-dc44-e550460cf57f@opensource.cirrus.com>
 <395b37b8-d9b2-1825-8e57-9e1b74aa7502@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <395b37b8-d9b2-1825-8e57-9e1b74aa7502@opensource.cirrus.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 11, 2021 at 10:43:17AM +0000, Richard Fitzgerald wrote:
> On 11/01/2021 10:39, Richard Fitzgerald wrote:
> > On 11/01/2021 10:36, Andy Shevchenko wrote:
> > > On Mon, Jan 11, 2021 at 12:28 PM Petr Mladek <pmladek@suse.com> wrote:
> > > > 
> > > > Sigh, I have just realized that Andy and Rasmus, the other
> > > > vsprintf maintainers and reviewers, were not in CC.
> > > > I am sorry for not noticing this earlier.
> > > > 
> > > > The patchset is ready for 5.12 from my POV.
> > > 
> > > Thanks, Petr!
> > > 
> > > I have one question, do we have a test case for that? If not, I prefer
> > > defer until a test case will be provided.
> > > 
> > 
> > See patch 3, numbers_prefix_overflow()
> 
> Sorry, I missed you off the original mailing so you won't have
> seen the other patches.
> Patch 3 with the test cases is here:
> https://lore.kernel.org/lkml/X%2FwnoJLEt0zQskDU@alley/T/#mf2ffba20126e438bea7af171bc78fdbebdb40027

Good, you did it!
Couple of remarks:
 - free resources in the same function where you allocated them
 - use post increment where it doesn't matter (like total_test)


-- 
With Best Regards,
Andy Shevchenko


