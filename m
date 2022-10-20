Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11A26056D3
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Oct 2022 07:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiJTFh4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Oct 2022 01:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiJTFhz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Oct 2022 01:37:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5467929C8E;
        Wed, 19 Oct 2022 22:37:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D419F619EC;
        Thu, 20 Oct 2022 05:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9759DC433D6;
        Thu, 20 Oct 2022 05:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666244272;
        bh=7qQ3XDyP2adNDj7pP5DtvvhD4V7ZaPBw70AnqPlrap8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VVayT6V0V9cNqBeZJus2oRNv36kxRXRv8EMmwkfPA7Kyj1h6nUgIlWC1DDZdrgNn9
         5hq+7bSUqg2kVLkLtvEqXLpL05knjDNVZCT79FFQFmOrvaXg0eEe8e+m8SZ982s8Oh
         Jpf8eOrqecKQLmBJ5FuO99A4dB7mCzjYyuXRwIB4=
Date:   Thu, 20 Oct 2022 07:38:40 +0200
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
Subject: Re: [PATCH v15 2/3] virt: Add TDX guest driver
Message-ID: <Y1De4IyAB6n2qs4V@kroah.com>
References: <20221020045828.2354731-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20221020045828.2354731-3-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020045828.2354731-3-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 19, 2022 at 09:58:27PM -0700, Kuppuswamy Sathyanarayanan wrote:
> +static long tdx_get_report(void __user *argp)
> +{
> +	u8 *reportdata, *tdreport;
> +	struct tdx_report_req req;
> +	long ret;
> +
> +	if (copy_from_user(&req, argp, sizeof(req)))
> +		return -EFAULT;
> +
> +	/*
> +	 * Per TDX Module 1.0 specification, section titled
> +	 * "TDG.MR.REPORT", REPORTDATA length is fixed as
> +	 * TDX_REPORTDATA_LEN, TDREPORT length is fixed as
> +	 * TDX_REPORT_LEN, and TDREPORT subtype is fixed as 0.
> +	 */
> +	if (req.subtype || req.rpd_len != TDX_REPORTDATA_LEN ||
> +	    req.tdr_len != TDX_REPORT_LEN) {
> +		pr_err("TDX_CMD_GET_REPORT: invalid req: subtype:%u rpd_len:%u tdr_len:%u\n",
> +		       req.subtype, req.rpd_len, req.tdr_len);

You are allowing userspace to spam the kernel logs, please do not do
that.

Also, you have a real device here, use it and call dev_*() instead of
pr_*().  Your code should not have any pr_* calls.


> +		return -EINVAL;
> +	}
> +
> +	if (memchr_inv(req.reserved, 0, sizeof(req.reserved))) {
> +		pr_err("TDX_CMD_GET_REPORT: Non zero value in reserved field\n");
> +		return -EINVAL;
> +	}
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
> +	if (ret) {
> +		pr_err("TDX_CMD_GET_REPORT: TDCALL failed\n");
> +		goto out;
> +	}
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
> +static int __init tdx_guest_init(void)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
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
> +#ifdef MODULE
> +static const struct x86_cpu_id tdx_guest_ids[] = {
> +	X86_MATCH_FEATURE(X86_FEATURE_TDX_GUEST, NULL),
> +	{}
> +};
> +MODULE_DEVICE_TABLE(x86cpu, tdx_guest_ids);
> +#endif

Why the #ifdef?  Should not be needed, right?

> +
> +MODULE_AUTHOR("Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>");
> +MODULE_DESCRIPTION("TDX Guest Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/uapi/linux/tdx-guest.h b/include/uapi/linux/tdx-guest.h
> new file mode 100644
> index 000000000000..fd71774a90ac
> --- /dev/null
> +++ b/include/uapi/linux/tdx-guest.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_LINUX_TDX_GUEST_H_
> +#define _UAPI_LINUX_TDX_GUEST_H_

No Intel copyright notice?  Are you sure you ran this code through
internal Intel review properly?

{sigh}


> +
> +#include <linux/ioctl.h>
> +#include <linux/types.h>
> +
> +/* Length of the REPORTDATA used in TDG.MR.REPORT TDCALL */
> +#define TDX_REPORTDATA_LEN              64
> +
> +/* Length of TDREPORT used in TDG.MR.REPORT TDCALL */
> +#define TDX_REPORT_LEN                  1024
> +
> +/**
> + * struct tdx_report_req - Get TDREPORT using REPORTDATA as input.
> + *
> + * @reportdata: User-defined REPORTDATA to be included into TDREPORT.
> + *              Typically it can be some nonce provided by attestation
> + *              service, so the generated TDREPORT can be uniquely verified.
> + * @tdreport: TDREPORT output from TDCALL[TDG.MR.REPORT].
> + * @rpd_len: Length of the REPORTDATA (fixed as 64 bytes by the TDX Module
> + *           specification, but a parameter is added to handle future
> + *           extension).
> + * @tdr_len: Length of the TDREPORT (fixed as 1024 bytes by the TDX Module
> + *           specification, but a parameter is added to accommodate future
> + *           extension).
> + * @subtype: Subtype of TDREPORT (fixed as 0 by the TDX Module specification,
> + *           but added a parameter to handle future extension).
> + * @reserved: Reserved entries to handle future requirements. Should be

s/Should/Must/

thanks,

greg k-h
