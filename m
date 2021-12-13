Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136814731F8
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Dec 2021 17:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240709AbhLMQj6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Dec 2021 11:39:58 -0500
Received: from mga07.intel.com ([134.134.136.100]:14541 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240919AbhLMQj5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Dec 2021 11:39:57 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="302153291"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="302153291"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 08:39:38 -0800
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="582966588"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 08:39:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mwoLW-005ghv-4L;
        Mon, 13 Dec 2021 18:38:38 +0200
Date:   Mon, 13 Dec 2021 18:38:37 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH -next] selftests: gpio: gpio-sim: remove bashisms
Message-ID: <Ybd3DT5e3fCP5JiS@smile.fi.intel.com>
References: <20211213162625.18081-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213162625.18081-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 13, 2021 at 05:26:25PM +0100, Bartosz Golaszewski wrote:
> '==' is a bashisms and not understood by POSIX shell. Drop it from
> gpio-sim selftests.

> -		if [ "$BANK" == "live" ] || [ "$BANK" == "dev_name" ]; then
> +		if [ "$BANK" = "live" ] || [ "$BANK" = "dev_name" ]; then

While at it, no need to fork `test` twice, isn't it?

		if [ "$BANK" = "live" -o "$BANK" = "dev_name" ]; then

-- 
With Best Regards,
Andy Shevchenko


