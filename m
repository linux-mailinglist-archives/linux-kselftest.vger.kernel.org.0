Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6915B63E0
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Sep 2022 01:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiILXAU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Sep 2022 19:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiILXAT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Sep 2022 19:00:19 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5257911448;
        Mon, 12 Sep 2022 16:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663023617; x=1694559617;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=thPFt9IiVCTuA7wvm1pCWtZQz+jCRM4O9S7KZyeOYj8=;
  b=Q8laEirpzQM5Cj6AnJM9eAFyJlXPiHvc3cAN6cRoFRdrSkz6VKH5ZD0T
   nmLDpOe+Z2p0IokadpvaBSi8n1IthYvW6AhUg2ZMpG65iogyPUX3bkzON
   Q//pM9MtZfpeE7ivElG0JY/XHkaj2fXbSyIVvXAFGUbtETfU2heQLm1yX
   SS08MY87G2d47xJX3UgX5wpIaLeS05op5VMyuG/qLNPg1NoVJ5/FULczg
   gJVBZ3tByZ57efce2XxrjCJkGI2xxPEZsUKFo8lX65d3HIS93O8WuM/G+
   hKZOb+bjNBPlb1C6xWAFRhxzCvVjhmtDAyyN2uPuk5x2UO8xzGRHUJyjL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="296723980"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="296723980"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 16:00:17 -0700
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="618711926"
Received: from mdejong-mobl.amr.corp.intel.com (HELO [10.209.13.71]) ([10.209.13.71])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 16:00:16 -0700
Message-ID: <c0688bd1-58a5-d818-06a6-6659d88ce31e@linux.intel.com>
Date:   Mon, 12 Sep 2022 16:00:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v13 1/3] x86/tdx: Add TDX Guest attestation interface
 driver
Content-Language: en-US
To:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
 <20220912222217.u4oc6fry2pvp342v@box.shutemov.name>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220912222217.u4oc6fry2pvp342v@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 9/12/22 3:22 PM, Kirill A . Shutemov wrote:
> On Fri, Sep 09, 2022 at 12:27:06PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
>> index 928dcf7a20d9..8b5c59110321 100644
>> --- a/arch/x86/coco/tdx/tdx.c
>> +++ b/arch/x86/coco/tdx/tdx.c
>> @@ -5,16 +5,21 @@
>>  #define pr_fmt(fmt)     "tdx: " fmt
>>  
>>  #include <linux/cpufeature.h>
>> +#include <linux/miscdevice.h>
>> +#include <linux/mm.h>
>> +#include <linux/io.h>
>>  #include <asm/coco.h>
>>  #include <asm/tdx.h>
>>  #include <asm/vmx.h>
>>  #include <asm/insn.h>
>>  #include <asm/insn-eval.h>
>>  #include <asm/pgtable.h>
>> +#include <uapi/asm/tdx.h>
>>  
>>  /* TDX module Call Leaf IDs */
>>  #define TDX_GET_INFO			1
>>  #define TDX_GET_VEINFO			3
>> +#define TDX_GET_REPORT			4
>>  #define TDX_ACCEPT_PAGE			6
>>  
>>  /* TDX hypercall Leaf IDs */
>> @@ -775,3 +780,113 @@ void __init tdx_early_init(void)
>>  
>>  	pr_info("Guest detected\n");
>>  }
>> +
>> +static long tdx_get_report(void __user *argp)
>> +{
>> +	u8 *reportdata, *tdreport;
>> +	struct tdx_report_req req;
>> +	u8 reserved[7] = {0};
>> +	long ret;
>> +
>> +	if (copy_from_user(&req, argp, sizeof(req)))
>> +		return -EFAULT;
>> +
>> +	/*
>> +	 * Per TDX Module 1.0 specification, section titled
>> +	 * "TDG.MR.REPORT", REPORTDATA length is fixed as
>> +	 * TDX_REPORTDATA_LEN, TDREPORT length is fixed as
>> +	 * TDX_REPORT_LEN, and TDREPORT subtype is fixed as
>> +	 * 0. Also check for valid user pointers and make sure
>> +	 * reserved entries values are zero.
>> +	 */
>> +	if (!req.reportdata || !req.tdreport || req.subtype ||
>> +		req.rpd_len != TDX_REPORTDATA_LEN ||
>> +		req.tdr_len != TDX_REPORT_LEN ||
>> +		memcmp(req.reserved, reserved, 7))
>> +		return -EINVAL;
> 
> Maybe make several checks instead of the monstrous one?

Agree. I will split it into two checks. One for spec related
checks and another for ABI validation.

> 
> !req.reportdata and !req.tdreport look redundant. copy_from/to_user() will
> catch them (and other bad address cases). And -EFAULT is more appropriate
> in this case.

We don't have to allocate kernel memory if we check it here. But I am not against
letting copy_from/to_user() handle it. I will remove the NULL check.

> 
>> +
>> +	reportdata = kmalloc(req.rpd_len, GFP_KERNEL);
>> +	if (!reportdata)
>> +		return -ENOMEM;
>> +
>> +	tdreport = kzalloc(req.tdr_len, GFP_KERNEL);
>> +	if (!tdreport) {
>> +		kfree(reportdata);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	if (copy_from_user(reportdata, u64_to_user_ptr(req.reportdata),
>> +			   req.rpd_len)) {
>> +		ret = -EFAULT;
>> +		goto out;
>> +	}
>> +
>> +	/*
>> +	 * Generate TDREPORT using "TDG.MR.REPORT" TDCALL.
>> +	 *
>> +	 * Get the TDREPORT using REPORTDATA as input. Refer to
>> +	 * section 22.3.3 TDG.MR.REPORT leaf in the TDX Module 1.0
>> +	 * Specification for detailed information.
>> +	 */
>> +	ret = __tdx_module_call(TDX_GET_REPORT, virt_to_phys(tdreport),
>> +				virt_to_phys(reportdata), req.subtype,
>> +				0, NULL);
>> +	if (ret) {
>> +		ret = -EIO;
> 
> The spec says that it generate an error if invalid operand or busy. Maybe
> translate the TDX error codes to errnos?

User space has no need to know about the error code. In both error cases, if user
wants report, request has to re-submitted. So there is no use in translating
the error codes.

> 
> BTW, regarding busy case: do we want to protect against two parallel
> TDX_GET_REPORT? What happens if we run the second TDX_GET_REPORT when the
> first hasn't complete?

We don't have to protect against it here. It is a blocking call. So if user
makes a parallel request, we will wait for TDX Module to service them
in sequence.

> 
>> +		goto out;
>> +	}
>> +
>> +	if (copy_to_user(u64_to_user_ptr(req.tdreport), tdreport, req.tdr_len))
>> +		ret = -EFAULT;
>> +
>> +out:
>> +	kfree(reportdata);
>> +	kfree(tdreport);
>> +	return ret;
>> +}
>> +static long tdx_guest_ioctl(struct file *file, unsigned int cmd,
>> +			    unsigned long arg)
>> +{
>> +	void __user *argp = (void __user *)arg;
>> +	long ret = -ENOTTY;
> 
> Not a typewriter? Huh?

It is the recommended return code for invalid IOCTL commands.

https://www.kernel.org/doc/html/latest/driver-api/ioctl.html

> 
>> +
>> +	switch (cmd) {
>> +	case TDX_CMD_GET_REPORT:
>> +		ret = tdx_get_report(argp);
>> +		break;
>> +	default:
>> +		pr_debug("cmd %d not supported\n", cmd);
>> +		break;
>> +	}
>> +
>> +	return ret;
>> +}
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
