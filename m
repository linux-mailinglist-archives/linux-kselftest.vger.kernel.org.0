Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A99C610A49
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Oct 2022 08:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiJ1GZH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Oct 2022 02:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ1GZG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Oct 2022 02:25:06 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829A360EAF;
        Thu, 27 Oct 2022 23:25:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E55F0CE2980;
        Fri, 28 Oct 2022 06:25:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6497CC433D6;
        Fri, 28 Oct 2022 06:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666938299;
        bh=k7aN7LYX9/gz2U+HjzOWTMv69r/tY13JXJiMdzAVc2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1g6XHY0pwYkq83qgpbDX0T6QIA/iiU9TMz6NuPje492ONdpgC+ehO7JqQg2ibWhm5
         btjZF+CXQYSJivO+Bo0Zk5x6IOML4+VZnIL5W0KfA8PSlAvc3OTYuzqEQRSbpNK/pz
         +3OkpGZWgr8urS4woQW3OEMOtLRQv00/Egq9FP0s=
Date:   Fri, 28 Oct 2022 08:25:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
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
Subject: Re: [PATCH v16 2/3] virt: Add TDX guest driver
Message-ID: <Y1t18Aw2RbP+oj9D@kroah.com>
References: <20221028002820.3303030-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20221028002820.3303030-3-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028002820.3303030-3-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 27, 2022 at 05:28:19PM -0700, Kuppuswamy Sathyanarayanan wrote:
> +	/*
> +	 * Check for valid input values. Per TDX Module 1.0
> +	 * specification, section titled "TDG.MR.REPORT",
> +	 * REPORTDATA length is fixed as TDX_REPORTDATA_LEN,

If this length is fixed, then you can never change it, so why have it at
all?

> +	 * TDREPORT length is fixed as TDX_REPORT_LEN, and
> +	 * TDREPORT subtype is fixed as 0.
> +	 */
> +	if (req.subtype || req.rpd_len != TDX_REPORTDATA_LEN ||
> +	    req.tdr_len != TDX_REPORT_LEN)
> +		return -EINVAL;
> +
> +	if (memchr_inv(req.reserved, 0, sizeof(req.reserved)))
> +		return -EINVAL;
> +
> +	reportdata = kmalloc(req.rpd_len, GFP_KERNEL);
> +	if (!reportdata)
> +		return -ENOMEM;
> +
> +	tdreport = kzalloc(req.tdr_len, GFP_KERNEL);
> +	if (!tdreport) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	if (copy_from_user(reportdata, u64_to_user_ptr(req.reportdata),
> +			   req.rpd_len)) {
> +		ret = -EFAULT;
> +		goto out;
> +	}
> +
> +	/* Generate TDREPORT using "TDG.MR.REPORT" TDCALL */
> +	ret = tdx_mcall_get_report(reportdata, tdreport, req.subtype);
> +	if (ret)
> +		goto out;
> +
> +	if (copy_to_user(u64_to_user_ptr(req.tdreport), tdreport, req.tdr_len))
> +		ret = -EFAULT;
> +
> +out:
> +	kfree(reportdata);
> +	kfree(tdreport);
> +
> +	return ret;
> +}
> +
> +static long tdx_guest_ioctl(struct file *file, unsigned int cmd,
> +			    unsigned long arg)
> +{
> +	switch (cmd) {
> +	case TDX_CMD_GET_REPORT:
> +		return tdx_get_report((void __user *)arg);

You know the type of this pointer here, why not cast it instead of
having to cast it from void * again?

> +	default:
> +		return -ENOTTY;
> +	}
> +}
> +
> +static const struct file_operations tdx_guest_fops = {
> +	.owner = THIS_MODULE,
> +	.unlocked_ioctl = tdx_guest_ioctl,
> +	.llseek = no_llseek,
> +};
> +
> +static struct miscdevice tdx_misc_dev = {
> +	.name = KBUILD_MODNAME,
> +	.minor = MISC_DYNAMIC_MINOR,
> +	.fops = &tdx_guest_fops,
> +};
> +
> +static const struct x86_cpu_id tdx_guest_ids[] = {
> +	X86_MATCH_FEATURE(X86_FEATURE_TDX_GUEST, NULL),
> +	{}
> +};
> +MODULE_DEVICE_TABLE(x86cpu, tdx_guest_ids);
> +
> +static int __init tdx_guest_init(void)
> +{
> +	if (!x86_match_cpu(tdx_guest_ids))
> +		return -ENODEV;
> +
> +	return misc_register(&tdx_misc_dev);
> +}
> +module_init(tdx_guest_init);
> +
> +static void __exit tdx_guest_exit(void)
> +{
> +	misc_deregister(&tdx_misc_dev);
> +}
> +module_exit(tdx_guest_exit);
> +
> +MODULE_AUTHOR("Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>");
> +MODULE_DESCRIPTION("TDX Guest Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/uapi/linux/tdx-guest.h b/include/uapi/linux/tdx-guest.h
> new file mode 100644
> index 000000000000..29453e6a7ced
> --- /dev/null
> +++ b/include/uapi/linux/tdx-guest.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Userspace interface for TDX guest driver
> + *
> + * Copyright (C) 2022 Intel Corporation
> + */
> +
> +#ifndef _UAPI_LINUX_TDX_GUEST_H_
> +#define _UAPI_LINUX_TDX_GUEST_H_
> +
> +#include <linux/ioctl.h>
> +#include <linux/types.h>
> +
> +/* Length of the REPORTDATA used in TDG.MR.REPORT TDCALL */
> +#define TDX_REPORTDATA_LEN              64
> +
> +/* Length of TDREPORT used in TDG.MR.REPORT TDCALL */
> +#define TDX_REPORT_LEN                  1024

As these are fixed values, why do you have to say them again in the
structure?

If you ever change them, wonderful, make a new ioctl.  You can't change
this one as userspace would have to also change, there is no way you
could mix/match kernel versions and userspace and not have problems.

So just fix these values, like you have, and remove them from the
structure definition as there's no way you can change them anyway.

> +
> +/**
> + * struct tdx_report_req - Request struct for TDX_CMD_GET_REPORT IOCTL.
> + *
> + * @reportdata: User-defined REPORTDATA to be included into TDREPORT.
> + *              Typically it can be some nonce provided by attestation
> + *              service, so the generated TDREPORT can be uniquely verified.
> + * @tdreport: TDREPORT output from TDCALL[TDG.MR.REPORT].

These are userspace pointers, document them as such please.

> + * @rpd_len: Length of the REPORTDATA (fixed as 64 bytes by the TDX Module
> + *           specification, but a parameter is added to handle future
> + *           extension).

As I say above, this can't be changed, right?

> + * @tdr_len: Length of the TDREPORT (fixed as 1024 bytes by the TDX Module
> + *           specification, but a parameter is added to accommodate future
> + *           extension).

Again, can't be changed.

> + * @subtype: Subtype of TDREPORT (fixed as 0 by the TDX Module specification,
> + *           but added a parameter to handle future extension).

If this too is fixed, you can't change it.

thanks,

greg k-h
