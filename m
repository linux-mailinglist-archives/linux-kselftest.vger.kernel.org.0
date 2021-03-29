Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE4334D14B
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Mar 2021 15:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhC2Ng6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Mar 2021 09:36:58 -0400
Received: from mga09.intel.com ([134.134.136.24]:31833 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231650AbhC2Ngw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Mar 2021 09:36:52 -0400
IronPort-SDR: svhutYRDrxRmUVufpF1L/Y4SyUsezzL29KwbMTlFSbQFE8qtLycFaLdFepL2rvrdtbY2VU9pcA
 0/Xdl/pBssrw==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="191648475"
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="191648475"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 06:36:52 -0700
IronPort-SDR: v+D+pZwVI4TovMEJ7F0yqJodzYypb5nEhQ6RTZHPxQKaz11RYGmvF/BLvL80xnzMUw4a72gKba
 1zNAwoLfr1qg==
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="393178570"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 06:36:50 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lQs4V-00H25j-5V; Mon, 29 Mar 2021 16:36:47 +0300
Date:   Mon, 29 Mar 2021 16:36:47 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, linux@rasmusvillemoes.dk,
        shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v7 2/4] lib: vsprintf: Fix handling of number field
 widths in vsscanf
Message-ID: <YGHX73vumna0AfwD@smile.fi.intel.com>
References: <20210329120824.3006-1-rf@opensource.cirrus.com>
 <20210329120824.3006-2-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329120824.3006-2-rf@opensource.cirrus.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 29, 2021 at 01:08:22PM +0100, Richard Fitzgerald wrote:
> The existing code attempted to handle numbers by doing a strto[u]l(),
> ignoring the field width, and then repeatedly dividing to extract the
> field out of the full converted value. If the string contains a run of
> valid digits longer than will fit in a long or long long, this would
> overflow and no amount of dividing can recover the correct value.
> 
> This patch fixes vsscanf() to obey number field widths when parsing
> the number.
> 
> A new _parse_integer_limit() is added that takes a limit for the number
> of characters to parse. The number field conversion in vsscanf is changed
> to use this new function.
> 
> If a number starts with a radix prefix, the field width  must be long
> enough for at last one digit after the prefix. If not, it will be handled
> like this:
> 
>  sscanf("0x4", "%1i", &i): i=0, scanning continues with the 'x'
>  sscanf("0x4", "%2i", &i): i=0, scanning continues with the '4'
> 
> This is consistent with the observed behaviour of userland sscanf.
> 
> Note that this patch does NOT fix the problem of a single field value
> overflowing the target type. So for example:
> 
>   sscanf("123456789abcdef", "%x", &i);
> 
> Will not produce the correct result because the value obviously overflows
> INT_MAX. But sscanf will report a successful conversion.
> 
> Note that where a very large number is used to mean "unlimited", the value
> INT_MAX is used for consistency with the behaviour of vsnprintf().

...

>  unsigned long simple_strtoul(const char *cp, char **endp, unsigned int base)
>  {
> -	return simple_strtoull(cp, endp, base);
> +	return simple_strntoull(cp, INT_MAX, endp, base);

Why do you need this change?


-- 
With Best Regards,
Andy Shevchenko


