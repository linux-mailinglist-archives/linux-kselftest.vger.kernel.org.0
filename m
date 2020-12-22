Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC962E095E
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Dec 2020 12:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgLVLLs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Dec 2020 06:11:48 -0500
Received: from mga11.intel.com ([192.55.52.93]:59960 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbgLVLLs (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Dec 2020 06:11:48 -0500
IronPort-SDR: 4SmKW9mHX43zEDD9gF2ztnQpkenjk3rd8LSKPbXBVU+4002QEfp+iSkTuJUO5xMmQe8/6wxZAr
 MY7Dw5aEFI9A==
X-IronPort-AV: E=McAfee;i="6000,8403,9842"; a="172342971"
X-IronPort-AV: E=Sophos;i="5.78,438,1599548400"; 
   d="scan'208";a="172342971"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2020 03:10:02 -0800
IronPort-SDR: xejfehk0d88A6yQrfKVc8UtAOaWxGdogAvpcAz5zG67R9KrHTpSVJ1+Cdos5CrmvSSo4zHaHy/
 QRYMmtezbW3A==
X-IronPort-AV: E=Sophos;i="5.78,438,1599548400"; 
   d="scan'208";a="416468213"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2020 03:10:00 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1krfZG-00GXwb-4i; Tue, 22 Dec 2020 13:11:02 +0200
Date:   Tue, 22 Dec 2020 13:11:02 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kunit: tool: Force the use of the 'tty' console for UML
Message-ID: <20201222111102.GC4077@smile.fi.intel.com>
References: <20201222073900.3490607-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222073900.3490607-1-davidgow@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 21, 2020 at 11:39:00PM -0800, David Gow wrote:
> kunit_tool relies on the UML console outputting printk() output to the
> tty in order to get results. Since the default console driver could
> change, pass 'console=tty' to the kernel.
> 
> This is triggered by a change[1] to use ttynull as a fallback console
> driver which -- by chance or by design -- seems to have changed the
> default console output on UML, breaking kunit_tool. While this may be
> fixed, we should be less fragile to such changes in the default.
> 
> [1]:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=757055ae8dedf5333af17b3b5b4b70ba9bc9da4e

Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks!

> Signed-off-by: David Gow <davidgow@google.com>
> Fixes: 757055ae8ded ("init/console: Use ttynull as a fallback when there is no console")


> ---
>  tools/testing/kunit/kunit_kernel.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index 57c1724b7e5d..698358c9c0d6 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -198,7 +198,7 @@ class LinuxSourceTree(object):
>  		return self.validate_config(build_dir)
>  
>  	def run_kernel(self, args=[], build_dir='', timeout=None):
> -		args.extend(['mem=1G'])
> +		args.extend(['mem=1G', 'console=tty'])
>  		self._ops.linux_bin(args, timeout, build_dir)
>  		outfile = get_outfile_path(build_dir)
>  		subprocess.call(['stty', 'sane'])
> -- 
> 2.29.2.729.g45daf8777d-goog
> 

-- 
With Best Regards,
Andy Shevchenko


