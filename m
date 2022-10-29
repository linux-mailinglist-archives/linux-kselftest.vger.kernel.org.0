Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D69612661
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Oct 2022 01:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJ2XRp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Oct 2022 19:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ2XRl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Oct 2022 19:17:41 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC732EF73;
        Sat, 29 Oct 2022 16:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667085460; x=1698621460;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZWyz83Ng/7FZvaGgwW6td6tKaOxX5oJfVXpiK7HPDLo=;
  b=ixdTBnAqrVBC0YM0QkR5j+o7ThlKB3eac26qulLMOJWZJS0+1BerEJu3
   w9rtX31yZEGY6QhWpYZcegeGc9zHIdr6FyOwCvWN72cd9V3X8EFJiJJ+G
   AJMj2Aqy/NpQHc0VSvo3TlBpiZXE7+cJcGuCXZ79aLfTwdAgJ+TTlB9Qq
   TirCwi+uNR4Mw2g22Z+sGCHoMKvujJZTko27hbpn3SiNZ4lW5pRnjK4+W
   HVLRRLfDpPqNl1cDk6ycB4dG0mP2OIgdplKCFM3/alsZbN9N+q+cXLSu6
   3SJpwLDmm4F4m8czzbYpWp+n9apdGAStuADrUYWpvOqi20EI5+IQyWCrl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10515"; a="289093934"
X-IronPort-AV: E=Sophos;i="5.95,224,1661842800"; 
   d="scan'208";a="289093934"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2022 16:17:40 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10515"; a="664388070"
X-IronPort-AV: E=Sophos;i="5.95,224,1661842800"; 
   d="scan'208";a="664388070"
Received: from guangna1-mobl.amr.corp.intel.com (HELO [10.209.109.108]) ([10.209.109.108])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2022 16:17:39 -0700
Message-ID: <01f437c1-9330-6fb5-d692-6cd500d8adf8@linux.intel.com>
Date:   Sat, 29 Oct 2022 16:17:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH v16 2/3] virt: Add TDX guest driver
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
References: <20221028002820.3303030-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20221028002820.3303030-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <Y1t18Aw2RbP+oj9D@kroah.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <Y1t18Aw2RbP+oj9D@kroah.com>
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

Hi Greg

On 10/27/22 11:25 PM, Greg Kroah-Hartman wrote:
> On Thu, Oct 27, 2022 at 05:28:19PM -0700, Kuppuswamy Sathyanarayanan wrote:

>> +
>> +static long tdx_guest_ioctl(struct file *file, unsigned int cmd,
>> +			    unsigned long arg)
>> +{
>> +	switch (cmd) {
>> +	case TDX_CMD_GET_REPORT:
>> +		return tdx_get_report((void __user *)arg);
> 
> You know the type of this pointer here, why not cast it instead of
> having to cast it from void * again?

The only place we use arg pointer is in copy_from_user() function,
which expects void __user * pointer. So why cast it as struct
tdx_report_req * here?


>> +
>> +MODULE_AUTHOR("Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>");
>> +MODULE_DESCRIPTION("TDX Guest Driver");
>> +MODULE_LICENSE("GPL");
>> diff --git a/include/uapi/linux/tdx-guest.h b/include/uapi/linux/tdx-guest.h
>> new file mode 100644
>> index 000000000000..29453e6a7ced
>> --- /dev/null
>> +++ b/include/uapi/linux/tdx-guest.h
>> @@ -0,0 +1,55 @@
>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>> +/*
>> + * Userspace interface for TDX guest driver
>> + *
>> + * Copyright (C) 2022 Intel Corporation
>> + */
>> +
>> +#ifndef _UAPI_LINUX_TDX_GUEST_H_
>> +#define _UAPI_LINUX_TDX_GUEST_H_
>> +
>> +#include <linux/ioctl.h>
>> +#include <linux/types.h>
>> +
>> +/* Length of the REPORTDATA used in TDG.MR.REPORT TDCALL */
>> +#define TDX_REPORTDATA_LEN              64
>> +
>> +/* Length of TDREPORT used in TDG.MR.REPORT TDCALL */
>> +#define TDX_REPORT_LEN                  1024
> 
> As these are fixed values, why do you have to say them again in the
> structure?

These length recommendations are provided by the TDX Module, and there is
a slight possibility that the TDX Module will increase the maximum size
of the REPORTDATA and TDREPORT in the future. To handle such length
changes, rather than inventing a new IOCTL for it in the future, making
the current one flexible to handle such changes seems better. One less ABI
to maintain is always better, right? My initial design did use fixed size
buffers like you have recommended, but later changed it as per review
suggestion to make the ABI flexible.


> 
> If you ever change them, wonderful, make a new ioctl.  You can't change
> this one as userspace would have to also change, there is no way you
> could mix/match kernel versions and userspace and not have problems.


Removing the length based checks in the kernel (in tdx_get_report()) and
directly passing the user input to the TDX Module can also avoid the 
usespace/kernel version mix/match issues you have mentioned. Does such
a solution acceptable?

> 
> So just fix these values, like you have, and remove them from the
> structure definition as there's no way you can change them anyway.
> 

With above details, if you think it is still better to remove the length
params, I can make the change.


>> +
>> +/**
>> + * struct tdx_report_req - Request struct for TDX_CMD_GET_REPORT IOCTL.
>> + *
>> + * @reportdata: User-defined REPORTDATA to be included into TDREPORT.
>> + *              Typically it can be some nonce provided by attestation
>> + *              service, so the generated TDREPORT can be uniquely verified.
>> + * @tdreport: TDREPORT output from TDCALL[TDG.MR.REPORT].
> 
> These are userspace pointers, document them as such please.

Will following change do?

@reportdata: Address of the user buffer with user-defined REPORTDATA to be
             included into TDREPORT.
@tdreport: Address of the user buffer to store TDREPORT output from TDCALL[TDG.MR.REPORT]


> 
> thanks,
> 
> greg k-h

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
