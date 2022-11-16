Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEAA62CE22
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 23:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbiKPW5Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 17:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbiKPW5Y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 17:57:24 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E1C682B2;
        Wed, 16 Nov 2022 14:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668639443; x=1700175443;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vw2Jf9KAz2tAppAkTOl7aLJxcwQUAiscRykKsAiXlTQ=;
  b=N9uagWlrl/GqTjiNLWJw+IoOuDNajM/z/XCThJgPdFT1KFY+S5j3wplc
   5WTgM2b5JQ3j4fulQtU/Ww4wPl/VP0Niai+p92HFs9HwtvMyK7jxcBwnX
   P5FG+hk0KXrgGPpHDxBw3bRzeLnZLLz2xzRRrZICuuDCbYymK05Ih4Ewg
   UI1oEQMcJnA257Gqh0Vb9atRjD46QR6KsXjhYUqJzhuTCKsvdNRCdDH8D
   i6ODu+2bIdM2PQ+8wGcraadk/xsCBXo0AzDjC3fj7JPRpt+cDCGegJXJq
   8gl4ycUQWPWrNonSiz/OPc8GGVehXKz0+ofrBnLbeVhW1Ft83wwG4bqFr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="310320072"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="310320072"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 14:57:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="617357897"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="617357897"
Received: from aagbadea-mobl.amr.corp.intel.com (HELO [10.252.138.56]) ([10.252.138.56])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 14:57:23 -0800
Message-ID: <f8c3da3a-4d19-60c6-66d3-afd0d56ef102@intel.com>
Date:   Wed, 16 Nov 2022 14:57:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC PATCH v3] selftest/x86/meltdown: Add a selftest for meltdown
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>, Aaron Lu <aaron.lu@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Y3L2Jx3Kx9q8Dv55@ziqianlu-desk1> <Y3M3sZSARXxLTKao@kroah.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Y3M3sZSARXxLTKao@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/14/22 22:54, Greg KH wrote:
> On Tue, Nov 15, 2022 at 10:15:03AM +0800, Aaron Lu wrote:
>> I came to the conclusion that this work is OK to submit with all of the
>> steps I listed above (copyright notices, license terms and relicensing)
>> by strictly following all of the processes required by my employer.
>>
>> This does not include a Signed-off-by from a corporate attorney.
> Please get that, as that is what I asked for in order for us to be able
> to accept this type of change.

Hi Greg,

Can you share any more of what triggered this new requirement?

We can, for instance, be flexible on the license that this is submitted
with (original zlib versus GPLv2).  I've also been in contact with the
(presumed) original authors of this code in the past.  If there are
concerns about its provenance, I'd be happy to try to work with them to
get it in to shape.

But, I feel like I'm poking around in the dark here.  I'm not quite sure
what triggered this new requirement or quite how to remedy it.

I'm also a _bit_ worried that I as a maintainer was about to do
something wrong here.  Personally, I'm quite happy with Aaron's due
diligence here and I was *really* close to merging this code.  Is there
some documentation that could be improved here?
