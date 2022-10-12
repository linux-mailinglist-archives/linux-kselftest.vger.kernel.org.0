Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70F65FC692
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Oct 2022 15:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJLNgB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Oct 2022 09:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJLNf7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Oct 2022 09:35:59 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765F1AC397;
        Wed, 12 Oct 2022 06:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665581758; x=1697117758;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8xYxlUm+MGiT1FvcaNdZ+RqLNhLPP9G29jYSgD4vhhk=;
  b=frVNzTDe9W6qdbSYbRsJ0KxcUA1Jl2sU7wUl6/ZJk1p0eYQjzyeUuN19
   AeVWp5B/ijeMl79VSc0v+WGiRFtTb3Cqao8apgjDjNvTWpzRygCcNLlIw
   djQa6wRe0f9C9qzJYIfaRo75kJmFCY2tKDHXkk5NuzQH6MaEhHL7UkWJ4
   7CWqPPw0UePKAj/3LQvs2gex9wkEkDQXeK1sMB8jXdJ/T+EzTJv6qbxfc
   2cgr+BeVcu/dUYxs43hlrcNsJCJ1N+cd7xCiEnOI943eNk68PGkNbnO0Q
   3R6IGd6jS7DqlnEg83o6Ubv+tV6QcJCGt7KkjYO32yG3I1taGAsxsDy4D
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="391099733"
X-IronPort-AV: E=Sophos;i="5.95,179,1661842800"; 
   d="scan'208";a="391099733"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 06:35:58 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="955754152"
X-IronPort-AV: E=Sophos;i="5.95,179,1661842800"; 
   d="scan'208";a="955754152"
Received: from mmarathe-mobl3.amr.corp.intel.com (HELO [10.209.65.51]) ([10.209.65.51])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 06:35:56 -0700
Message-ID: <acc212d6-782b-a398-825a-212849beba00@linux.intel.com>
Date:   Wed, 12 Oct 2022 06:35:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v14 1/3] x86/tdx: Make __tdx_module_call() usable in
 driver module
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20220928215535.26527-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220928215535.26527-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <Y0aUb3n7ouaeAt2a@zn.tnic>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <Y0aUb3n7ouaeAt2a@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 10/12/22 3:18 AM, Borislav Petkov wrote:
> On Wed, Sep 28, 2022 at 02:55:33PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> To support TDX attestation, the TDX guest user interface driver must
>> use the __tdx module_call() function in the driver to allow the user to
>> obtain the TDREPORT.
>>
>> So export the __tdx_module_call() and move the TDX Module IDs to
>> asm/tdx.h.
> 
> The functions with the __ prefix are usually lower-level interfaces
> which should be internal. Usually.
> 
> Why aren't you exporting the tdx_module_call() one instead?

tdx_module_call() calls panic() on a non-zero error value. So it is only
used for cases where failure is fatal to the guest. But in the case of
TDG.MR.REPORT TDCALL, there are valid cases for failure (like invalid
param or busy condition) and the failure is non-fatal.

So we should create a new wrapper for this use case or use
__tdx_module_call() which is already exposed in asm/tdx.h.

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
