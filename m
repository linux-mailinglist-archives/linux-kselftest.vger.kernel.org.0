Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6E26DE30E
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 19:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjDKRsK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 13:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjDKRsI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 13:48:08 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1AF1FE2;
        Tue, 11 Apr 2023 10:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681235273; x=1712771273;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KKWeRA+CuxLTvK4Duk5PZQYLd+mGVq75/qziJtyBITE=;
  b=GQVz/8fnhpPUn5hdsJZ6eQiWuWKYPbZLxK0K2eKHIPFuRRxiMCgebTod
   bAHc0pGTcFdX2wnJvjlMdyXcQS5UlviI3mLij78zaOEyX6e4xonvGisH2
   RzANN99mbZh/FnyIo6UWhdK+afA+OSnAnidDSDRMnqUkLdg6b3UdBBkhK
   W+5Fy5WAQ2l23N/U6FfELpTJTBkbpK2SYw9AvpNPqqiZL71LGcnoWW3DE
   p7qj2+wGSeO/HhUcNZIK4XhRbFqoEbZ/WEln0dYrTGlH+Dm9R8mLOgjd+
   NSzxKs/MCmwTTghBU7ovaJM6EtytZ6mj3tZGiBvA7lS73K4GZCPBW8R6R
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="323318923"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="323318923"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 10:47:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="934811420"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="934811420"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 11 Apr 2023 10:47:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pmI5t-00FTTX-2h;
        Tue, 11 Apr 2023 20:47:49 +0300
Date:   Tue, 11 Apr 2023 20:47:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-gpio@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bamvor Jian Zhang <bamv2005@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: Re: [PATCH v1 1/2] selftests: gpio: gpio-sim: Fix BUG: test FAILED
 due to recent change
Message-ID: <ZDWdRQmKryGjJcFD@smile.fi.intel.com>
References: <20230411171521.29678-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411171521.29678-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 11, 2023 at 08:15:20PM +0300, Andy Shevchenko wrote:
> From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>

Ah, Mirsad, I need your SoB, if you are okay with the change.
Otherwise I have to drop your authorship.

-- 
With Best Regards,
Andy Shevchenko


