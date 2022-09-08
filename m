Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951D45B27D8
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Sep 2022 22:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiIHUpX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Sep 2022 16:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiIHUpW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Sep 2022 16:45:22 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD7152FE7;
        Thu,  8 Sep 2022 13:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662669920; x=1694205920;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=trJg9IQop4EvJ5Exf6dImqRzP+GEfhRt13bo6iZ+hU8=;
  b=TAGiqDlxQlSjItHT5C+1znO7G1NIEuCAxWaK7N5o5LGagGG5KUioAKmD
   k/8KkieNKxhsoyilQFdu2SOA72nHWgXQCR1ClURnJns9K54js18qJjPkQ
   mpJz92uCApHi4xnzp/sVY+bTpJBAGjvPYLVp+YF+oBLRpCUYheKzK575D
   6hMuQIXPbss36X9vwo58Qix0ZnPzqK9/yD9JrNu0b2mXxf7aAcYpVkABk
   gCmLQxRqbbvH2HuXJR50rTe9UhUluEAJKqp5yzbivXOEsfB98UpTvyeP8
   4EITwj449+77nEJSNOde6gYvC690PbC7B4W7kt9LjzFB+BBDVxl6gBXxW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="298657908"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="298657908"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 13:45:20 -0700
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="740814983"
Received: from duttamou-mobl1.amr.corp.intel.com (HELO [10.209.109.184]) ([10.209.109.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 13:45:19 -0700
Message-ID: <19dfab3e-8ab4-87ee-fadf-a1a58ae3d2d7@linux.intel.com>
Date:   Thu, 8 Sep 2022 13:45:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v12 1/3] x86/tdx: Add TDX Guest attestation interface
 driver
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20220908002723.923241-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220908002723.923241-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <Yxl+PE4A+WUfQ7bl@kroah.com>
 <6cf407ed-95c7-0db4-d581-b85efad13239@linux.intel.com>
 <ac10ec37-91c8-031e-b3d3-843eaf28f0ee@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <ac10ec37-91c8-031e-b3d3-843eaf28f0ee@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 9/8/22 1:36 PM, Dave Hansen wrote:
> On 9/8/22 12:07, Sathyanarayanan Kuppuswamy wrote:
>> On 9/7/22 10:31 PM, Greg Kroah-Hartman wrote:
>>> On Wed, Sep 07, 2022 at 05:27:20PM -0700, Kuppuswamy Sathyanarayanan wrote:
>>>> +	/*
>>>> +	 * Per TDX Module 1.0 specification, section titled
>>>> +	 * "TDG.MR.REPORT", REPORTDATA length is fixed as
>>>> +	 * TDX_REPORTDATA_LEN, TDREPORT length is fixed as
>>>> +	 * TDX_REPORT_LEN, and TDREPORT subtype is fixed as
>>>> +	 * 0. Also check for valid user pointers.
>>>> +	 */
>>>> +	if (!req.reportdata || !req.tdreport || req.subtype ||
>>>> +		req.rpd_len != TDX_REPORTDATA_LEN ||
>>>> +		req.tdr_len != TDX_REPORT_LEN)
>>>> +		return -EINVAL;
>>> You never verify that your reserved[7] fields are actually set to 0,
>>> which means you can never use them in the future :(
>> Currently, we don't use those fields in our code. Why do we have to
>> make sure they are set to zero?
> 
> Yes.
> 
>> Can't we add checks when we really use them in future?
> 
> No.
> 
> This has been a hard learned lesson both by people writing software and
> designing hardware interfaces: if you _let_ folks pass garbage you have
> to _keep_ letting them pass garbage forever.  It becomes part of the ABI.
> 
> I'm sorry you missed the memo on this one.  But, this is one million
> percent a best practice across the industry.  Please do it.

Ok. Thanks for clarifying it. I will fix it in next version.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
