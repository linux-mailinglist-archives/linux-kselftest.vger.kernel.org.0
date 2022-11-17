Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0261462E4AD
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Nov 2022 19:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240715AbiKQSoL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Nov 2022 13:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240579AbiKQSn7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Nov 2022 13:43:59 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209BB7A35F;
        Thu, 17 Nov 2022 10:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668710638; x=1700246638;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2GXtbg89YeODqFpqT9naISwspE1iONVHN77+IyVVVsc=;
  b=bysL5qg0EIAMjytEfHSgaUUABswmpVL4E/c22lKF4UxSPREPCMRBYhBF
   lOTcy4yX+fT+nAD+B197VyFptPERoWwbeIg9lckDxnFBiHnSYiKoWNSaB
   oYABHwB9OlhBXvhmdwR0kqtoofCZCD59kTdPeixa3LSH2Kv1PDQGxOMdB
   hp1MSaRXgs6FIxwZECKCN0syGKlROucozf2wXc+XTv4Kz4gDFg9LqcQYl
   LukfEKiCfiXBFOtsxH9WB6Suxo8QbfKZXnp0iLmC6GZTDdDsfH8zUgj4C
   L+5f1Md0EvhoHxdK6PEsah0S/zKsSlrdvDI3UcsnB8VU7GKb3j1Xx59+B
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="300474667"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="300474667"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 10:43:57 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="814623941"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="814623941"
Received: from vrgatne-mobl4.amr.corp.intel.com (HELO [10.209.115.197]) ([10.209.115.197])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 10:43:57 -0800
Message-ID: <d6c82cd9-3c8d-8ced-0499-e5e9da91c000@intel.com>
Date:   Thu, 17 Nov 2022 10:43:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC PATCH v3] selftest/x86/meltdown: Add a selftest for meltdown
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Aaron Lu <aaron.lu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Y3L2Jx3Kx9q8Dv55@ziqianlu-desk1> <Y3M3sZSARXxLTKao@kroah.com>
 <f8c3da3a-4d19-60c6-66d3-afd0d56ef102@intel.com> <Y3XQZFyiXYc9mJ1Y@kroah.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Y3XQZFyiXYc9mJ1Y@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/16/22 22:10, Greg KH wrote:
> On Wed, Nov 16, 2022 at 02:57:22PM -0800, Dave Hansen wrote:
>> On 11/14/22 22:54, Greg KH wrote:
>>> On Tue, Nov 15, 2022 at 10:15:03AM +0800, Aaron Lu wrote:
>>>> I came to the conclusion that this work is OK to submit with all of the
>>>> steps I listed above (copyright notices, license terms and relicensing)
>>>> by strictly following all of the processes required by my employer.
>>>>
>>>> This does not include a Signed-off-by from a corporate attorney.
>>> Please get that, as that is what I asked for in order for us to be able
>>> to accept this type of change.
>> Hi Greg,
>>
>> Can you share any more of what triggered this new requirement?
> You are taking source from a non-Intel developer under a different
> license and adding copyright and different license information to it.
> Because of all of that, I have the requirement that I want to know that
> Intel legal has vetted all of this and agrees with the conclusions that
> you all are stating.

I rarely speak "for Intel".  But, this is one case where I believe that
I can.  The Intel processes have been thoroughly and diligently followed
here.  Speaking for Intel: yes, this has been vetted and those
statements are as official as a statement from Intel can be.

Also, to reiterate my earlier offer: I believe Aaron can be flexible in
both the license under which this is submitted and the presence of an
explicit Intel copyright notice.  If modifications there would help ease
your concerns, we'd be happy to explore changes.

I also recognize that there can be legitimate differences of opinion
about what constitutes a 'valid' licensing decision.  It's quite
possible that the advice we're getting from folks at Intel differs the
advise that others get.  If that's happening, I'd love to find a way
forward that allows that legitimate difference of opinion to persist
while also getting a selftest in the kernel that I believe will find
real bugs.
