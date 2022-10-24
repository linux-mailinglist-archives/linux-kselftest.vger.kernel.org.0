Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820AD60B3EE
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Oct 2022 19:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiJXRWH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Oct 2022 13:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbiJXRVg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Oct 2022 13:21:36 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1481E12275A;
        Mon, 24 Oct 2022 08:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666626978; x=1698162978;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R6eLt+eaBNx47iW0+GZUQaBnxc2a9sA6IRLpogRPtC8=;
  b=huyA2vr67ohtqIw0SkvIn0jAuo8wl6H2UCld9XAq0Okyy5NGfZQkefAc
   RPArSrIcAK6FQkYx1kiph6YFf7MPc4RclGCoN8XeplZuv9Xq+LJ9NePuJ
   a/oZqVmGQ0wV+FEJmSelHq6x3tVbJJkMnxiSkU5imVWnI8GiNIP65RhPi
   zHTM81Z6E6/2pMGshkNL3fy/C9/bG3BtFqauWqzSkTslqVnBG02iNKDgb
   yLMXHnSx8a+P1FiTXk+Jg0O3YFlaxy8ZNUREPlGCcHxRIT/ZoUJc+QBhP
   Z0j5Xx3j/I1/2t5IOh9N/P5RrywrE9OPVB3l/8P4kNrGYOPb3ikmIt6sq
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="287822959"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="287822959"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 07:17:24 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="876448167"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="876448167"
Received: from csun9-mobl.amr.corp.intel.com (HELO [10.209.104.152]) ([10.209.104.152])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 07:17:23 -0700
Message-ID: <f03f1db3-5e55-9606-1d0d-4d51213a0b1a@intel.com>
Date:   Mon, 24 Oct 2022 07:17:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v15 2/3] virt: Add TDX guest driver
Content-Language: en-US
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
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
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <c09184e3-ac15-b230-6dea-d6718f6f0ab0@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/23/22 09:13, Sathyanarayanan Kuppuswamy wrote:
> On 10/20/22 9:39 PM, Greg Kroah-Hartman wrote:
>>>> You are allowing userspace to spam the kernel logs, please do not do
>>>> that.
>>> Added it to help userspace understand the reason for the failure (only for
>>> the cases like request param issues and TDCALL failure). Boris recommended
>>> adding it in the previous review.
>> Again, you just created a vector for userspace to spam the kernel log.
>> No kernel driver should ever do that.
>>
> Brois, any comments? Do you also agree?
...
> +	if (req.subtype || req.rpd_len != TDX_REPORTDATA_LEN ||
> +	    req.tdr_len != TDX_REPORT_LEN) {
> +		pr_err("TDX_CMD_GET_REPORT: invalid req: subtype:%u rpd_len:%u tdr_len:%u\n",
> +		       req.subtype, req.rpd_len, req.tdr_len);

This is _clearly_ debugging code.  There are a billion if(foo){return
-EINVAL;}'s in the kernel, and very few of them have printk()'s to go
along with them.

They do help figure out what happened when userspace sees an -EINVAL and
can't figure out what it did to cause it.  But, if the kernel spammed
dmesg for every time userspace does something stupid, it'd be filled up
with noise.

There are other ways to debug stuff like this if userspace gets confused.

If folks are OK with dev_dbg(), then I'd move over to that.  But,
frankly, I don't think this rises to the level of needing its own error
message.

Heck, I'm not even sure why this code exits in the first place.  I guess
we don't want userspace making random requests to the host.  But, of
course, none of _that_ information about what the code is actually there
for made it into the patch, and it just consumes comment space
regurgitating the TDX spec.

This branch of the thread frankly isn't about a pr_err().  It's about
nobody really knowing (or caring) why that line of code is there, when
it might happen, and what precise function it serves.
