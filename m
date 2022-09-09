Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593D45B4052
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 22:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiIIUHc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Sep 2022 16:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiIIUHb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Sep 2022 16:07:31 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A32ACCD7D;
        Fri,  9 Sep 2022 13:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662754050; x=1694290050;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oxcGdpzGuPvSalr55BaYS9QZ2APctMGWYr460kANP7M=;
  b=cBWQ94VyXEr86Y7l8VWDb0u0scoOJI0lGN2wbtdUfhPj7ukSmjfxQr+z
   zYSW6i1t+ZUjAi3ccio7sr7K8o1Z7CRXFC1xrbFonvFRpylJFsbdRhVZq
   Z+DQjrVes0X1NeW5M/XN84lLoRlyPyR620jlcI14fLeb3irRHaWTEnMVJ
   GsE9peVij9w2AJYe6UGTvgVzRGkJJUiimw8jRkj9NMc0O2qdCswvWvLek
   yFRyiDscZLU5qMoaK9JrxIRK7QYe97ddyJvCkOkwB0l+D2284dMdWTzbz
   h80rboLVyxyJgNJQfOrStoHweTdUxc8QXS3cPwPhDMg7DVn4CEGKJkJgh
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="277294485"
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="277294485"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 13:07:29 -0700
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="592731467"
Received: from hmadupal-mobl1.amr.corp.intel.com (HELO [10.251.6.204]) ([10.251.6.204])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 13:07:29 -0700
Message-ID: <c289f18c-1276-eaa8-739e-4fb530eace91@linux.intel.com>
Date:   Fri, 9 Sep 2022 13:07:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v13 1/3] x86/tdx: Add TDX Guest attestation interface
 driver
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
References: <20220909192708.1113126-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220909192708.1113126-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <1942be91-ec18-5fb3-9fcd-6ffcfaf9f36c@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <1942be91-ec18-5fb3-9fcd-6ffcfaf9f36c@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 9/9/22 12:41 PM, Dave Hansen wrote:
> On 9/9/22 12:27, Kuppuswamy Sathyanarayanan wrote:
>> +	u8 reserved[7] = {0};
> ...
>> +	if (!req.reportdata || !req.tdreport || req.subtype ||
>> +		req.rpd_len != TDX_REPORTDATA_LEN ||
>> +		req.tdr_len != TDX_REPORT_LEN ||
>> +		memcmp(req.reserved, reserved, 7))
>> +		return -EINVAL;
> 
> Huh, so to look for 0's, you:
> 
> 1. Declare an on-stack structure with a hard coded, magic numbered field
>    that has to be zeroed.
> 2. memcmp() that structure
> 3. Feed memcmp() with another hard coded magic number
> 
> I've gotta ask: did you have any reservations writing this code?  Were
> there any alarm bells going off saying that something might be wrong?
> 
> Using memcmp() itself is probably forgivable.  But, the two magic
> numbers are pretty mortal sins in my book.  What's going to happen the
> first moment someone wants to repurpose a reserved byte?  They're going
> to do:
> 
> -	__u8 reserved[7];
> +	__u8 my_new_byte;
> +	__u8 reserved[6];
> 
> What's going to happen to the code you wrote?  Will it continue to work?
>  Or will the memcmp() silently start doing crazy stuff as it overruns
> the structure into garbage land?
> 
> What's wrong with:
> 
> 	memchr_inv(&req.reserved, sizeof(req.reserved), 0)

I did not consider the hard coding issue. It is a mistake. Your suggestion
looks better. I will use it.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
