Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CF461288C
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Oct 2022 07:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiJ3G4o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 30 Oct 2022 02:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiJ3G4V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 30 Oct 2022 02:56:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBAF333;
        Sat, 29 Oct 2022 23:52:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FE2860BFB;
        Sun, 30 Oct 2022 06:52:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68823C433D6;
        Sun, 30 Oct 2022 06:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667112745;
        bh=yomI6F9Y3LwhNQMorNUN+vA+i2WvoLw+J1a7/DIVcyI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H+Fgf8yjoaCbUT0f/bxb6gFZc257QhfT5b8WbJr1t8H+Zh008oKw05OhNRQ7Qt0cu
         Vfw/krsoTWsSZfi4PJstfSW4oS7aOO23FtpUcNq99wJknPdT0cB/EXtC2+3BLY5Jol
         kCkqzCpvLMEAeKb+bxpmnd0pkH+X/eblVgREAzWI=
Date:   Sun, 30 Oct 2022 07:53:19 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sathyanarayanan Kuppuswamy 
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
Message-ID: <Y14fX1Ni1taUxtFk@kroah.com>
References: <20221028002820.3303030-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20221028002820.3303030-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <Y1t18Aw2RbP+oj9D@kroah.com>
 <01f437c1-9330-6fb5-d692-6cd500d8adf8@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01f437c1-9330-6fb5-d692-6cd500d8adf8@linux.intel.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Oct 29, 2022 at 04:17:39PM -0700, Sathyanarayanan Kuppuswamy wrote:
> Hi Greg
> 
> On 10/27/22 11:25 PM, Greg Kroah-Hartman wrote:
> > On Thu, Oct 27, 2022 at 05:28:19PM -0700, Kuppuswamy Sathyanarayanan wrote:
> 
> >> +
> >> +static long tdx_guest_ioctl(struct file *file, unsigned int cmd,
> >> +			    unsigned long arg)
> >> +{
> >> +	switch (cmd) {
> >> +	case TDX_CMD_GET_REPORT:
> >> +		return tdx_get_report((void __user *)arg);
> > 
> > You know the type of this pointer here, why not cast it instead of
> > having to cast it from void * again?
> 
> The only place we use arg pointer is in copy_from_user() function,
> which expects void __user * pointer. So why cast it as struct
> tdx_report_req * here?

Because then your function will show the true type and you don't have to
cast it again.

> >> +MODULE_AUTHOR("Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>");
> >> +MODULE_DESCRIPTION("TDX Guest Driver");
> >> +MODULE_LICENSE("GPL");
> >> diff --git a/include/uapi/linux/tdx-guest.h b/include/uapi/linux/tdx-guest.h
> >> new file mode 100644
> >> index 000000000000..29453e6a7ced
> >> --- /dev/null
> >> +++ b/include/uapi/linux/tdx-guest.h
> >> @@ -0,0 +1,55 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> >> +/*
> >> + * Userspace interface for TDX guest driver
> >> + *
> >> + * Copyright (C) 2022 Intel Corporation
> >> + */
> >> +
> >> +#ifndef _UAPI_LINUX_TDX_GUEST_H_
> >> +#define _UAPI_LINUX_TDX_GUEST_H_
> >> +
> >> +#include <linux/ioctl.h>
> >> +#include <linux/types.h>
> >> +
> >> +/* Length of the REPORTDATA used in TDG.MR.REPORT TDCALL */
> >> +#define TDX_REPORTDATA_LEN              64
> >> +
> >> +/* Length of TDREPORT used in TDG.MR.REPORT TDCALL */
> >> +#define TDX_REPORT_LEN                  1024
> > 
> > As these are fixed values, why do you have to say them again in the
> > structure?
> 
> These length recommendations are provided by the TDX Module, and there is
> a slight possibility that the TDX Module will increase the maximum size
> of the REPORTDATA and TDREPORT in the future.

We do not write kernel code for "slight possibilities sometime in the
future".

> To handle such length
> changes, rather than inventing a new IOCTL for it in the future, making
> the current one flexible to handle such changes seems better.

Please work through the code and see how that would really look, and
what would break if you were to change that in the future (remember
kernel code and userspace code is not upgraded at the same time.)

> One less ABI
> to maintain is always better, right? My initial design did use fixed size
> buffers like you have recommended, but later changed it as per review
> suggestion to make the ABI flexible.

Again, work through and try to determine if the added complexity will
really work here.

What is wrong with just adding a new ioctl if in the future, you really
do need to change something?  That way you are sure that nothing will
break and userspace will be finen with it.  It is not like you are
forbidden to add new ioctls later, you would have to change the kernel
code no matter what anyway.

Keep it simple please.

greg k-h
