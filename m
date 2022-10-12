Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F565FCEB2
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Oct 2022 01:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJLXBi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Oct 2022 19:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiJLXBh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Oct 2022 19:01:37 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4C4E4A;
        Wed, 12 Oct 2022 16:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665615696; x=1697151696;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=TQ4RFyACq3aRPxcEOgfEBDFxfsmGybilFCWDTC8Y6+s=;
  b=A4TxOIb850nBBeQK2X2xNSWTztiBE0duuxCxpjvla0O91JOogQu9i0Ay
   jNjA7Pfb4dyLnz8oxEoUjxYaN222yPVB6MkEeQPmwaRA/T+G2xWxIhPji
   gZk1Dg1CP+uRRCmiEV9HrMpGERcHyxhQym2nxWgV4ODV+DP/dL+XQQH8o
   ddjdZ/c9D8o9hFaMqaEx2CoogjM3vO/QtV4P1DQv2jMDOkkQLcQrW5gHQ
   l8qsycbI5fFUPmKRG6fm4jX7tEtOrLRVkYVOxM9JukRNa4CkdjDJHdBEN
   a1ZGeUM+H6wTbi7li+HAzJsZjtK7l+d5HcC9ffgtrA3jvhF11K8+Dwc4Y
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="305988543"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="305988543"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 16:01:34 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="695652822"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="695652822"
Received: from jbrolli1-mobl.amr.corp.intel.com (HELO [10.212.174.189]) ([10.212.174.189])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 16:01:32 -0700
Message-ID: <adc0987a-70f5-4203-c741-978d7d89cf76@linux.intel.com>
Date:   Wed, 12 Oct 2022 16:01:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v14 2/3] virt: Add TDX guest driver
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
 <20220928215535.26527-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <Y0bhkVYfYhzkmrjp@zn.tnic>
Content-Language: en-US
In-Reply-To: <Y0bhkVYfYhzkmrjp@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 10/12/22 8:47 AM, Borislav Petkov wrote:
> On Wed, Sep 28, 2022 at 02:55:34PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> +static long tdx_get_report(void __user *argp)
>> +{
>> +	u8 *reportdata, *tdreport;
>> +	struct tdx_report_req req;
>> +	long ret;
>> +
>> +	if (copy_from_user(&req, argp, sizeof(req)))
>> +		return -EFAULT;
>> +
>> +	/*
>> +	 * Per TDX Module 1.0 specification, section titled
>> +	 * "TDG.MR.REPORT", REPORTDATA length is fixed as
>> +	 * TDX_REPORTDATA_LEN, TDREPORT length is fixed as
>> +	 * TDX_REPORT_LEN, and TDREPORT subtype is fixed as 0.
>> +	 */
>> +	if (req.subtype || req.rpd_len != TDX_REPORTDATA_LEN ||
>> +	    req.tdr_len != TDX_REPORT_LEN)
>> +		return -EINVAL;
>> +
>> +	if (memchr_inv(req.reserved, 0, sizeof(req.reserved)))
> 
> I'm guessing we should issue something here to userspace to let it know
> why the it fails getting the report.

I am fine with adding an error message here. What about the above -EINVAL
case? Do you suggest adding it there as well?

> 
> Otherwise it is starting to look good and boring. :)
> 
> Thx.
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
