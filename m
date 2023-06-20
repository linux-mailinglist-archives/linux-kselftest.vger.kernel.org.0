Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9E17371EC
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jun 2023 18:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjFTQlh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Jun 2023 12:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFTQlg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Jun 2023 12:41:36 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F8DC0;
        Tue, 20 Jun 2023 09:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687279296; x=1718815296;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Ixbk6Is2biXcZua8H62STJO3xjYtt2Imiuj7LbOAMf0=;
  b=YRidF2qtcMHUUCSDF55mqav/cTHpZyUphHHo/v5i1lNkQ+W0Eby9nHYV
   MuVyO9pXiAT59lj23oUJt+l3Klr3XPWLJG9NQx+DXjQnpRl6/icF+cl+A
   RS7WInxh4fwhVICYC7pMF+hmVespcrRD3f81xZGLRCfXkg+cXrM7eNteu
   erZelrLMmHvuBtRbG2p/M4gUSuh761kb45B4gM4bGVMp4IyCHMlV9VtaF
   mgkEOKicot/8x8umWWu0CiHcLnt4Ss3r24+upJXOGvHl0gtN0xUcKfnXb
   BAPIla23RyxNJMqOBJoTxU/q+F1GEgDVZKhpxovHhFBIAUBqrS7aAykrL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="358785603"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="358785603"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 09:40:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="743838745"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="743838745"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 20 Jun 2023 09:40:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qBeOz-005Ikn-2E;
        Tue, 20 Jun 2023 19:40:21 +0300
Date:   Tue, 20 Jun 2023 19:40:21 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pengfei Xu <pengfei.xu@intel.com>, yi1.lai@intel.com
Subject: Re: selftests: gpio: crash on arm64
Message-ID: <ZJHWdcP+PDaNrw07@smile.fi.intel.com>
References: <CA+G9fYv94gx8+-JMzbmQaue3q3y6QdBmsGUCdD-26X5XavL3Ag@mail.gmail.com>
 <ZAocZRZh4FQRH3lc@smile.fi.intel.com>
 <CA+G9fYsOttth+k3Ki8LK_ZiayvXa0bAg-DmQAaFHZeEyR=6Lrw@mail.gmail.com>
 <CACRpkdbUYWcFiRh+Y=MOekv2RjSP4sB2t5tVrSsz54Eez6wmVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdbUYWcFiRh+Y=MOekv2RjSP4sB2t5tVrSsz54Eez6wmVg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 11, 2023 at 10:57:28AM +0200, Linus Walleij wrote:
> On Mon, Apr 10, 2023 at 11:16 AM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:

...

> Add a pr_info() devm_gpio_chip_release() in drivers/gpio/gpiolib-devres.c
> and see if the callback is even called. I think this could be the
> problem: if that isn't cleaned up, there will be dangling references.

Side note: Since we have devres tracepoints, your patch seems an overkill :-)
Just enable devres tracepoints and filter out by the function name. I believe
that should work.

-- 
With Best Regards,
Andy Shevchenko


