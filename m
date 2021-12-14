Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03E24741FA
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Dec 2021 13:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhLNMFD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Dec 2021 07:05:03 -0500
Received: from mga12.intel.com ([192.55.52.136]:40125 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231710AbhLNMFC (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Dec 2021 07:05:02 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="218979108"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="218979108"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 04:05:01 -0800
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="682028690"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 04:04:58 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mx6XJ-0066uK-VO;
        Tue, 14 Dec 2021 14:04:01 +0200
Date:   Tue, 14 Dec 2021 14:04:01 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH -next] selftests: gpio: gpio-sim: avoid forking test twice
Message-ID: <YbiIMcf3VGCkPrdc@smile.fi.intel.com>
References: <20211214080919.22616-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214080919.22616-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 14, 2021 at 09:09:19AM +0100, Bartosz Golaszewski wrote:
> Use '-o' within [] in order to avoid spawning two processes for test.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks!

> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---
>  tools/testing/selftests/gpio/gpio-sim.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/gpio/gpio-sim.sh b/tools/testing/selftests/gpio/gpio-sim.sh
> index c913d5aec768..341e3de00896 100755
> --- a/tools/testing/selftests/gpio/gpio-sim.sh
> +++ b/tools/testing/selftests/gpio/gpio-sim.sh
> @@ -23,7 +23,7 @@ remove_chip() {
>  
>  	for FILE in $CONFIGFS_DIR/$CHIP/*; do
>  		BANK=`basename $FILE`
> -		if [ "$BANK" = "live" ] || [ "$BANK" = "dev_name" ]; then
> +		if [ "$BANK" = "live" -o "$BANK" = "dev_name" ]; then
>  			continue
>  		fi
>  
> -- 
> 2.30.1
> 

-- 
With Best Regards,
Andy Shevchenko


