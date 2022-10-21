Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853EF606C51
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Oct 2022 02:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiJUABt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Oct 2022 20:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiJUABs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Oct 2022 20:01:48 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F0B1F040A;
        Thu, 20 Oct 2022 17:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666310507; x=1697846507;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=axznp6OnV6Oaffkdp+OJ9LGPX/DGG8dLw8F0zIaw8Iw=;
  b=dHIA7wvUOGJRebCqwflVX6i2KwxXe9LNzLf9VCTHUc7Ty8GI3ieTp7tn
   Ngq1JIUhkm1aOMqtNIQQbiEUCceJ+Nri7QW70rt8k56neVCyvvP5M1s0v
   2ihTGk7Cw2a5wl6XQk4K1F0Oc68w54+M79XeALAwU8KbHEBiYtMcjT7WI
   DodF4Z9nJ8BU4le87FMGx1pOznk5JnE1f9vT4BCUExRF8VWm+4+dWoJsf
   zjo1K6/BurYaEL816eWmi3wmqQ5OuobOiQM9mWbl6ODL76fV3f4OFUQrk
   vPgcw/9T2Pn7FmIK/feL03biQRuv4UdPP2NrjOFwFrwBl9tDdy9Zr7QEj
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="368916740"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="368916740"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 17:00:33 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="805222050"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="805222050"
Received: from apattnay-mobl.amr.corp.intel.com (HELO [10.209.102.175]) ([10.209.102.175])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 17:00:27 -0700
Message-ID: <34ef18d6-69f8-853a-d1ba-7023822e17ff@linux.intel.com>
Date:   Thu, 20 Oct 2022 17:00:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH v15 2/3] virt: Add TDX guest driver
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
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
        linux-doc@vger.kernel.org
References: <20221020045828.2354731-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20221020045828.2354731-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <Y1De4IyAB6n2qs4V@kroah.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <Y1De4IyAB6n2qs4V@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On 10/19/22 10:38 PM, Greg Kroah-Hartman wrote:
> On Wed, Oct 19, 2022 at 09:58:27PM -0700, Kuppuswamy Sathyanarayanan wrote:
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
>> +	    req.tdr_len != TDX_REPORT_LEN) {
>> +		pr_err("TDX_CMD_GET_REPORT: invalid req: subtype:%u rpd_len:%u tdr_len:%u\n",
>> +		       req.subtype, req.rpd_len, req.tdr_len);
> 
> You are allowing userspace to spam the kernel logs, please do not do
> that.

Added it to help userspace understand the reason for the failure (only for
the cases like request param issues and TDCALL failure). Boris recommended
adding it in the previous review.


> 
> Also, you have a real device here, use it and call dev_*() instead of
> pr_*().  Your code should not have any pr_* calls.

Ok. I will use dev_err variant.

> 
> 
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (memchr_inv(req.reserved, 0, sizeof(req.reserved))) {
>> +		pr_err("TDX_CMD_GET_REPORT: Non zero value in reserved field\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	reportdata = kmalloc(req.rpd_len, GFP_KERNEL);
>> +	if (!reportdata)
>> +		return -ENOMEM;
>> +
>> +	tdreport = kzalloc(req.tdr_len, GFP_KERNEL);
>> +	if (!tdreport) {
>> +		ret = -ENOMEM;
>> +		goto out;
>> +	}
>> +
>> +	if (copy_from_user(reportdata, u64_to_user_ptr(req.reportdata),
>> +			   req.rpd_len)) {
>> +		ret = -EFAULT;
>> +		goto out;
>> +	}
>> +
>> +	/* Generate TDREPORT using "TDG.MR.REPORT" TDCALL */
>> +	ret = tdx_mcall_get_report(reportdata, tdreport, req.subtype);
>> +	if (ret) {
>> +		pr_err("TDX_CMD_GET_REPORT: TDCALL failed\n");
>> +		goto out;
>> +	}
>> +
>> +	if (copy_to_user(u64_to_user_ptr(req.tdreport), tdreport, req.tdr_len))
>> +		ret = -EFAULT;
>> +
>> +out:
>> +	kfree(reportdata);
>> +	kfree(tdreport);
>> +
>> +	return ret;
>> +}
>> +
>> +static long tdx_guest_ioctl(struct file *file, unsigned int cmd,
>> +			    unsigned long arg)
>> +{
>> +	switch (cmd) {
>> +	case TDX_CMD_GET_REPORT:
>> +		return tdx_get_report((void __user *)arg);
>> +	default:
>> +		return -ENOTTY;
>> +	}
>> +}
>> +
>> +static const struct file_operations tdx_guest_fops = {
>> +	.owner = THIS_MODULE,
>> +	.unlocked_ioctl = tdx_guest_ioctl,
>> +	.llseek = no_llseek,
>> +};
>> +
>> +static struct miscdevice tdx_misc_dev = {
>> +	.name = KBUILD_MODNAME,
>> +	.minor = MISC_DYNAMIC_MINOR,
>> +	.fops = &tdx_guest_fops,
>> +};
>> +
>> +static int __init tdx_guest_init(void)
>> +{
>> +	if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
>> +		return -ENODEV;
>> +
>> +	return misc_register(&tdx_misc_dev);
>> +}
>> +module_init(tdx_guest_init);
>> +
>> +static void __exit tdx_guest_exit(void)
>> +{
>> +	misc_deregister(&tdx_misc_dev);
>> +}
>> +module_exit(tdx_guest_exit);
>> +
>> +#ifdef MODULE
>> +static const struct x86_cpu_id tdx_guest_ids[] = {
>> +	X86_MATCH_FEATURE(X86_FEATURE_TDX_GUEST, NULL),
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(x86cpu, tdx_guest_ids);
>> +#endif
> 
> Why the #ifdef?  Should not be needed, right?

I have added it to fix the following warning reported by 0-day.

https://lore.kernel.org/lkml/202209211607.tCtTWKbV-lkp@intel.com/

It is related to nullifying the MODULE_DEVICE_TABLE in #ifndef MODULE
case in linux/module.h.

> 
> thanks,
> 
> greg k-h

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
