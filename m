Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17AF6B2C59
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Mar 2023 18:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjCIRuo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Mar 2023 12:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjCIRuh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Mar 2023 12:50:37 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4537F6B43;
        Thu,  9 Mar 2023 09:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678384235; x=1709920235;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ogVypCdkPt8E5X9bDUGx7JSe5g2+nmoHHjkYAcaFWFg=;
  b=nUHKITiAJVDNLlPabHZzAzGakVZaLNBYVATMvCMy/VQYQ5c556EjDgk5
   kThnEpGQhS0KjVDgeMwN0Lp2UEvJelKHVcMA61FTMldUTcxYGt8M4vd2S
   Osd0iTjrnJjTvCiy9iFzVZBxCtv0Kc6vNAk/+Hu2MVWr2Ie0qx4/d2dKe
   hZA1/ck+HBlPt3DZOyJG1i0JtwFrrPkMGDTB76FZ91uVvoX6C70hYfz0z
   cbgVhsIYumm2pMGQCl+t1FUETTcGW0NCCN9aJDSDdYjc6iWy3PV/zZ28z
   r2n5HQusIrnh920a0s3Fcjrtqn343eoRxlOQMudp9GKDY/sn3kHc2qSaq
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="324855414"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="324855414"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 09:50:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="677462919"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="677462919"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 09 Mar 2023 09:50:32 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1paKPO-000Sb6-0d;
        Thu, 09 Mar 2023 19:50:30 +0200
Date:   Thu, 9 Mar 2023 19:50:29 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: selftests: gpio: crash on arm64
Message-ID: <ZAocZRZh4FQRH3lc@smile.fi.intel.com>
References: <CA+G9fYv94gx8+-JMzbmQaue3q3y6QdBmsGUCdD-26X5XavL3Ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYv94gx8+-JMzbmQaue3q3y6QdBmsGUCdD-26X5XavL3Ag@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 09, 2023 at 09:33:29PM +0530, Naresh Kamboju wrote:
> Following kernel warnings and crash notices on arm64 Rpi4 device while
> running selftests: gpio on Linux mainline 6.3.0-rc1 kernel and Linux next.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

...

> [   61.177432]  *** DEADLOCK ***
> [   61.177432]
> [   61.177434] 3 locks held by modprobe/510:
> [   61.177436] #0: ffff000040000698 (&n->list_lock){-.-.}-{2:2}, at:
> get_partial_node.part.0 (mm/slub.c:2271)
> [   61.177448] #1: ffff80000b227f18 (console_lock){+.+.}-{0:0}, at:
> vprintk_emit (kernel/printk/printk.c:1936 kernel/printk/printk.c:2315)
> [   61.177460] #2: ffff80000b228388 (console_srcu){....}-{0:0}, at:
> console_flush_all (include/linux/srcu.h:200 kernel/printk/printk.c:290
> kernel/printk/printk.c:2934)

How is it related to the GPIO?
Can you bisect if it's a regression somewhere?

-- 
With Best Regards,
Andy Shevchenko


