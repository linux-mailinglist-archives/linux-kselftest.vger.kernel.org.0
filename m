Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31817615C2B
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Nov 2022 07:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiKBGSr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Nov 2022 02:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiKBGSf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Nov 2022 02:18:35 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE1F25EBB;
        Tue,  1 Nov 2022 23:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667369910; x=1698905910;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pEWjkZqQxuIkuHHzF4BhxNUgWNmPWXIV6oZqI6S3AV8=;
  b=S/CIADRpM6IKxvtDlekmHyLgbbSWlndUnqVgezaDzvQQNm2usg/4hU0W
   L0IWnFMKw1CHNbwEJN9ehZKKYMN3PHcghtFcSpgZtIgAbTReT37JqniUk
   8+hAp0RcPeg7gXwKOnEKyJu0XtAIDPPwkFTOyAUnjQ3pGSiUeP3ECGuU8
   4DT7Vscet4kq+GnM7Uvj31KKJJgEZPRCnnlWi4uCSC52nYDTmB8JrIpJv
   W6Pqj/6/X8AMzy9whKMxfVHdQ8wlylII9lDyPrRjBDRDPuPuhO/15H/mj
   g+ALq4iCgMUW63mF3ocPNFzxI5hk7YlFHspp+mia67hl3UzHHALwKyy+M
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="309321159"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="309321159"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 23:18:29 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="585278798"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="585278798"
Received: from rossschx-mobl1.amr.corp.intel.com (HELO [10.209.44.13]) ([10.209.44.13])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 23:18:29 -0700
Message-ID: <55497719-4c51-e209-dd10-0f4ee0d95ad5@linux.intel.com>
Date:   Tue, 1 Nov 2022 23:18:29 -0700
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
 <01f437c1-9330-6fb5-d692-6cd500d8adf8@linux.intel.com>
 <Y14fX1Ni1taUxtFk@kroah.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <Y14fX1Ni1taUxtFk@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Greg,

On 10/29/22 11:53 PM, Greg Kroah-Hartman wrote:
> On Sat, Oct 29, 2022 at 04:17:39PM -0700, Sathyanarayanan Kuppuswamy wrote:
>> Hi Greg
>>
>> On 10/27/22 11:25 PM, Greg Kroah-Hartman wrote:
>>> On Thu, Oct 27, 2022 at 05:28:19PM -0700, Kuppuswamy Sathyanarayanan wrote:
>>
>>>> +
>>>> +static long tdx_guest_ioctl(struct file *file, unsigned int cmd,
>>>> +			    unsigned long arg)
>>>> +{
>>>> +	switch (cmd) {
>>>> +	case TDX_CMD_GET_REPORT:
>>>> +		return tdx_get_report((void __user *)arg);
>>>
>>> You know the type of this pointer here, why not cast it instead of
>>> having to cast it from void * again?
>>
>> The only place we use arg pointer is in copy_from_user() function,
>> which expects void __user * pointer. So why cast it as struct
>> tdx_report_req * here?
> 
> Because then your function will show the true type and you don't have to
> cast it again.
> 
>>>> +MODULE_AUTHOR("Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>");
>>>> +MODULE_DESCRIPTION("TDX Guest Driver");
>>>> +MODULE_LICENSE("GPL");
>>>> diff --git a/include/uapi/linux/tdx-guest.h b/include/uapi/linux/tdx-guest.h
>>>> new file mode 100644
>>>> index 000000000000..29453e6a7ced
>>>> --- /dev/null
>>>> +++ b/include/uapi/linux/tdx-guest.h
>>>> @@ -0,0 +1,55 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>>>> +/*
>>>> + * Userspace interface for TDX guest driver
>>>> + *
>>>> + * Copyright (C) 2022 Intel Corporation
>>>> + */
>>>> +
>>>> +#ifndef _UAPI_LINUX_TDX_GUEST_H_
>>>> +#define _UAPI_LINUX_TDX_GUEST_H_
>>>> +
>>>> +#include <linux/ioctl.h>
>>>> +#include <linux/types.h>
>>>> +
>>>> +/* Length of the REPORTDATA used in TDG.MR.REPORT TDCALL */
>>>> +#define TDX_REPORTDATA_LEN              64
>>>> +
>>>> +/* Length of TDREPORT used in TDG.MR.REPORT TDCALL */
>>>> +#define TDX_REPORT_LEN                  1024
>>>
>>> As these are fixed values, why do you have to say them again in the
>>> structure?
>>
>> These length recommendations are provided by the TDX Module, and there is
>> a slight possibility that the TDX Module will increase the maximum size
>> of the REPORTDATA and TDREPORT in the future.
> 
> We do not write kernel code for "slight possibilities sometime in the
> future".
> 
>> To handle such length
>> changes, rather than inventing a new IOCTL for it in the future, making
>> the current one flexible to handle such changes seems better.
> 
> Please work through the code and see how that would really look, and
> what would break if you were to change that in the future (remember
> kernel code and userspace code is not upgraded at the same time.)
> 
>> One less ABI
>> to maintain is always better, right? My initial design did use fixed size
>> buffers like you have recommended, but later changed it as per review
>> suggestion to make the ABI flexible.
> 
> Again, work through and try to determine if the added complexity will
> really work here.
> 
> What is wrong with just adding a new ioctl if in the future, you really
> do need to change something?  That way you are sure that nothing will
> break and userspace will be finen with it.  It is not like you are
> forbidden to add new ioctls later, you would have to change the kernel
> code no matter what anyway.
> 
> Keep it simple please.


The following are potential solutions to the possible kernel/userspace
mix/match issue that may arise in the future if the acceptable reportdata
length, tdreport length, or subtype values change.

I've attempted to do a sample implementation as you have suggested to
check the pros and cons for both solutions. Please let me know what you
think. Personally I prefer solution 2, as it handles the issue you have
raised and also keeps the ABI flexible.

Solution 1:
------------

This is based on your suggestion. I have dropped the IOCTL req members for
reportdata length (rpd_len), tdreport length (tdr_len) and subtype. I have
also used fixed size buffers to handle the current requirements.

Pros: Implementation is simple and clean.

Cons: May need to add new IOCTL for any future requirement updates.

Following are the ABI and IOCTL handler implementation details (Note: it
is not the complete code, only included required details to show how the
implementation looks):

--- /dev/null
+++ b/include/uapi/linux/tdx-guest.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Userspace interface for TDX guest driver
+ *
+ * Copyright (C) 2022 Intel Corporation
+ */
+
+#ifndef _UAPI_LINUX_TDX_GUEST_H_
+#define _UAPI_LINUX_TDX_GUEST_H_
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+/* Length of the REPORTDATA used in TDG.MR.REPORT TDCALL */
+#define TDX_REPORTDATA_LEN              64
+
+/* Length of TDREPORT used in TDG.MR.REPORT TDCALL */
+#define TDX_REPORT_LEN                  1024
+
+/**
+ * struct tdx_report_req - Request struct for TDX_CMD_GET_REPORT IOCTL.
+ *
+ * @reportdata: User buffer with REPORTDATA to be included into TDREPORT.
+ *              Typically it can be some nonce provided by attestation
+ *              service, so the generated TDREPORT can be uniquely verified.
+ * @tdreport: User buffer to store TDREPORT output from TDCALL[TDG.MR.REPORT].
+ */
+struct tdx_report_req {
+       __u8 reportdata[TDX_REPORTDATA_LEN];
+       __u8 tdreport[TDX_REPORT_LEN];
+};

--- /dev/null
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TDX guest user interface driver
+ *
+ * Copyright (C) 2022 Intel Corporation
+ */
+
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+
+#include <uapi/linux/tdx-guest.h>
+
+#include <asm/cpu_device_id.h>
+#include <asm/tdx.h>
+
+static long tdx_get_report(struct tdx_report_req __user *ureq)
+{
+       u8 *reportdata, *tdreport;
+       long ret;
+
+       reportdata = kmalloc(TDX_REPORTDATA_LEN, GFP_KERNEL);
+       if (!reportdata)
+               return -ENOMEM;
+
+       tdreport = kzalloc(TDX_REPORT_LEN, GFP_KERNEL);
+       if (!tdreport) {
+               ret = -ENOMEM;
+               goto out;
+       }
+
+       if (copy_from_user(reportdata, ureq->reportdata, TDX_REPORTDATA_LEN)) {
+               ret = -EFAULT;
+               goto out;
+       }
+
+       /* Generate TDREPORT using "TDG.MR.REPORT" TDCALL */
+       ret = tdx_mcall_get_report(reportdata, tdreport);
+       if (ret)
+               goto out;
+
+       if (copy_to_user(ureq->tdreport, tdreport, TDX_REPORT_LEN))
+               ret = -EFAULT;
+
+out:
+       kfree(reportdata);
+       kfree(tdreport);
+
+       return ret;
+}
+
+static long tdx_guest_ioctl(struct file *file, unsigned int cmd,
+                           unsigned long arg)
+{
+       switch (cmd) {
+       case TDX_CMD_GET_REPORT:
+               return tdx_get_report((struct tdx_report_req __user *)arg);
+       default:
+               return -ENOTTY;
+       }
+}

Solution 2:
-----------

In this version, I removed all length and subtype related checks in the
kernel (in tdx get report()) and instead passed the user input directly
to TDG.MR.TDCALL, allowing the TDX Module to return success or failure
based on the user input. Because the kernel does not directly impose any
length or subtype constraints, the userspace/kernel mix/match issue will
not occur.

Pros:

ABI is flexible and we don't have to add new IOCTL if the acceptable
reportlength ,tdreport length or subtype values are changed by the
TDX Module in the future.

Cons:

For now, userspace will pass fixed values to length and subtype members. So
they not currently useful.

Following are the ABI and IOCTL handler implementation details (Note: it
is not the complete code, only included required details to show how the
implementation looks):

--- /dev/null
+++ b/include/uapi/linux/tdx-guest.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Userspace interface for TDX guest driver
+ *
+ * Copyright (C) 2022 Intel Corporation
+ */
+
+#ifndef _UAPI_LINUX_TDX_GUEST_H_
+#define _UAPI_LINUX_TDX_GUEST_H_
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+/**
+ * struct tdx_report_req - Request struct for TDX_CMD_GET_REPORT IOCTL.
+ *
+ * @reportdata: Address of user buffer with user-defined REPORTDATA to be
+ *              included into TDREPORT. Typically it can be some nonce
+ *              provided by attestation service, so the generated TDREPORT
+ *              can be uniquely verified.
+ * @tdreport: Address of user buffer to store TDREPORT output from
+ *            TDCALL[TDG.MR.REPORT].
+ * @rpd_len: Length of the REPORTDATA. For acceptable values, refer to TDX
+ *           module specification v1.0 sec titled "TDG.MR.REPORT Leaf".
+ * @tdr_len: Length of the TDREPORT. For acceptable values, refer to TDX
+ *           module specification v1.0 sec titled "TDG.MR.REPORT Leaf".
+ * @subtype: Subtype of TDREPORT. For acceptable values, refer to TDX
+ *           module specification v1.0 sec titled "TDG.MR.REPORT Leaf".
+ * @reserved: Reserved entries to handle future requirements. Must be filled
+ *            with zeroes.
+ */
+struct tdx_report_req {
+       __u64 reportdata;
+       __u64 tdreport;
+       __u32 rpd_len;
+       __u32 tdr_len;
+       __u8 subtype;
+       __u8 reserved[7];
+};

--- /dev/null
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TDX guest user interface driver
+ *
+ * Copyright (C) 2022 Intel Corporation
+ */
+
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+
+#include <uapi/linux/tdx-guest.h>
+
+#include <asm/cpu_device_id.h>
+#include <asm/tdx.h>
+
+static long tdx_get_report(struct tdx_report_req __user *argp)
+{
+       u8 *reportdata, *tdreport;
+       struct tdx_report_req req;
+       long ret;
+
+       if (copy_from_user(&req, argp, sizeof(req)))
+               return -EFAULT;
+
+       if (memchr_inv(req.reserved, 0, sizeof(req.reserved)))
+               return -EINVAL;
+
+       reportdata = kmalloc(req.rpd_len, GFP_KERNEL);
+       if (!reportdata)
+               return -ENOMEM;
+
+       tdreport = kzalloc(req.tdr_len, GFP_KERNEL);
+       if (!tdreport) {
+               ret = -ENOMEM;
+               goto out;
+       }
+
+       if (copy_from_user(reportdata, u64_to_user_ptr(req.reportdata),
+                          req.rpd_len)) {
+               ret = -EFAULT;
+               goto out;
+       }
+
+       /* Generate TDREPORT using "TDG.MR.REPORT" TDCALL */
+       ret = tdx_mcall_get_report(reportdata, tdreport, req.subtype);
+       if (ret)
+               goto out;
+
+       if (copy_to_user(u64_to_user_ptr(req.tdreport), tdreport, req.tdr_len))
+               ret = -EFAULT;
+
+out:
+       kfree(reportdata);
+       kfree(tdreport);
+
+       return ret;
+}
+
+static long tdx_guest_ioctl(struct file *file, unsigned int cmd,
+                           unsigned long arg)
+{
+       switch (cmd) {
+       case TDX_CMD_GET_REPORT:
+               return tdx_get_report((struct tdx_report_req __user *)arg);
+       default:
+               return -ENOTTY;
+       }
+}


> 
> greg k-h

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
