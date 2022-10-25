Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA1060C09C
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 03:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiJYBLX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Oct 2022 21:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbiJYBKs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Oct 2022 21:10:48 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC766554C;
        Mon, 24 Oct 2022 17:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666657256; x=1698193256;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=/1uaQ+xco441pDsJRiEwU9iBCQ5+D+oqZxL5Lt+sTaE=;
  b=ArS8VSBKMNyJufwQQ38yigOc7LfBwJHNRcfxKkWBoKkBecBzmzwhK4hD
   cRAsU7CeZyybsCoTYptqsxAEpAgBnuhKDE1BC8zP9YpC1QBie5pJ/+e8U
   qfR2vq/waV3e+C2VFVGJklm0D/9Pjf3gtqvQKTjzRaQ4G7DJSrWlrayn9
   tAD9zUkwpV78e9VOAptcF/tNU6MxxoInZy6ATQReGiRTCrfLuOtGgpgFA
   ZiEAROrj1LIX/kHU6zS+Q05qKkJOdWjmctgjOrgWotbceTxnTJdHP9cj7
   JKb0SQMz0cys3LnpFUQiOQOCGEm2mMSm6NYfwZ35MEhLfmnc04Tlmxqq+
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="290854992"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="290854992"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 17:20:55 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="720664409"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="720664409"
Received: from bmahadev-mobl.amr.corp.intel.com (HELO [10.212.216.245]) ([10.212.216.245])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 17:20:54 -0700
Message-ID: <0f4d9817-6a8a-225e-5322-db4fd9a4aabb@linux.intel.com>
Date:   Mon, 24 Oct 2022 17:20:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v15 2/3] virt: Add TDX guest driver
To:     Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20221020045828.2354731-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20221020045828.2354731-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <Y1De4IyAB6n2qs4V@kroah.com>
 <34ef18d6-69f8-853a-d1ba-7023822e17ff@linux.intel.com>
 <Y1Iimg0WItgIGq6/@kroah.com>
 <c09184e3-ac15-b230-6dea-d6718f6f0ab0@linux.intel.com>
 <f03f1db3-5e55-9606-1d0d-4d51213a0b1a@intel.com>
Content-Language: en-US
In-Reply-To: <f03f1db3-5e55-9606-1d0d-4d51213a0b1a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Dave,

On 10/24/22 7:17 AM, Dave Hansen wrote:
> On 10/23/22 09:13, Sathyanarayanan Kuppuswamy wrote:
>> On 10/20/22 9:39 PM, Greg Kroah-Hartman wrote:
>>>>> You are allowing userspace to spam the kernel logs, please do not do
>>>>> that.
>>>> Added it to help userspace understand the reason for the failure (only for
>>>> the cases like request param issues and TDCALL failure). Boris recommended
>>>> adding it in the previous review.
>>> Again, you just created a vector for userspace to spam the kernel log.
>>> No kernel driver should ever do that.
>>>
>> Brois, any comments? Do you also agree?
> ...
>> +	if (req.subtype || req.rpd_len != TDX_REPORTDATA_LEN ||
>> +	    req.tdr_len != TDX_REPORT_LEN) {
>> +		pr_err("TDX_CMD_GET_REPORT: invalid req: subtype:%u rpd_len:%u tdr_len:%u\n",
>> +		       req.subtype, req.rpd_len, req.tdr_len);
> 
> This is _clearly_ debugging code.  There are a billion if(foo){return
> -EINVAL;}'s in the kernel, and very few of them have printk()'s to go
> along with them.
> 
> They do help figure out what happened when userspace sees an -EINVAL and
> can't figure out what it did to cause it.  But, if the kernel spammed
> dmesg for every time userspace does something stupid, it'd be filled up
> with noise.
> 
> There are other ways to debug stuff like this if userspace gets confused.
> 
> If folks are OK with dev_dbg(), then I'd move over to that.  But,
> frankly, I don't think this rises to the level of needing its own error
> message.
> 
> Heck, I'm not even sure why this code exits in the first place.  I guess
> we don't want userspace making random requests to the host.  But, of
> course, none of _that_ information about what the code is actually there
> for made it into the patch, and it just consumes comment space
> regurgitating the TDX spec.
> 
> This branch of the thread frankly isn't about a pr_err().  It's about
> nobody really knowing (or caring) why that line of code is there, when
> it might happen, and what precise function it serves.

It is added to ensure the user does not make random requests and the user
input aligns with the defined IOCTL ABI. Returning -EINVAL for the input
parameter error will help userspace better understand the reason for the
failure than failing after making the TDCALL request.

I have added the spec reference mainly for the reader to understand the
origin of the checks involved. Would you prefer a comment like "Check for
valid user input"?

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
