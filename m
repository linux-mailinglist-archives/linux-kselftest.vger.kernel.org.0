Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BA4606EF7
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Oct 2022 06:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiJUEjL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Oct 2022 00:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiJUEjH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Oct 2022 00:39:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EA21C20B2;
        Thu, 20 Oct 2022 21:39:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 524D261CF1;
        Fri, 21 Oct 2022 04:39:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29385C433D6;
        Fri, 21 Oct 2022 04:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666327145;
        bh=rih5WqsvdYrQkFSP/RnOovfz+ozji4uXBw78mTk2NgY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R5KDFvoA6vMcVYXgFXsWFkhzTl0x2iKid3aVoNbf7Ktx+5oJW6utNHvgVV3vYFg3X
         UIsUFf2KXAE5lIOwpZDhqPTtTbz+deCpoD227Gm4Y+No0cYCIhcrUNkDJbRY05Pnaq
         wcMJrDu6NI1ex/Rzn9Hz+61uNYJUWYmUjA4T3dDw=
Date:   Fri, 21 Oct 2022 06:39:54 +0200
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
Subject: Re: [PATCH v15 2/3] virt: Add TDX guest driver
Message-ID: <Y1Iimg0WItgIGq6/@kroah.com>
References: <20221020045828.2354731-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20221020045828.2354731-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <Y1De4IyAB6n2qs4V@kroah.com>
 <34ef18d6-69f8-853a-d1ba-7023822e17ff@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34ef18d6-69f8-853a-d1ba-7023822e17ff@linux.intel.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 20, 2022 at 05:00:27PM -0700, Sathyanarayanan Kuppuswamy wrote:
> Hi,
> 
> On 10/19/22 10:38 PM, Greg Kroah-Hartman wrote:
> > On Wed, Oct 19, 2022 at 09:58:27PM -0700, Kuppuswamy Sathyanarayanan wrote:
> >> +static long tdx_get_report(void __user *argp)
> >> +{
> >> +	u8 *reportdata, *tdreport;
> >> +	struct tdx_report_req req;
> >> +	long ret;
> >> +
> >> +	if (copy_from_user(&req, argp, sizeof(req)))
> >> +		return -EFAULT;
> >> +
> >> +	/*
> >> +	 * Per TDX Module 1.0 specification, section titled
> >> +	 * "TDG.MR.REPORT", REPORTDATA length is fixed as
> >> +	 * TDX_REPORTDATA_LEN, TDREPORT length is fixed as
> >> +	 * TDX_REPORT_LEN, and TDREPORT subtype is fixed as 0.
> >> +	 */
> >> +	if (req.subtype || req.rpd_len != TDX_REPORTDATA_LEN ||
> >> +	    req.tdr_len != TDX_REPORT_LEN) {
> >> +		pr_err("TDX_CMD_GET_REPORT: invalid req: subtype:%u rpd_len:%u tdr_len:%u\n",
> >> +		       req.subtype, req.rpd_len, req.tdr_len);
> > 
> > You are allowing userspace to spam the kernel logs, please do not do
> > that.
> 
> Added it to help userspace understand the reason for the failure (only for
> the cases like request param issues and TDCALL failure). Boris recommended
> adding it in the previous review.

Again, you just created a vector for userspace to spam the kernel log.
No kernel driver should ever do that.

> >> +#ifdef MODULE
> >> +static const struct x86_cpu_id tdx_guest_ids[] = {
> >> +	X86_MATCH_FEATURE(X86_FEATURE_TDX_GUEST, NULL),
> >> +	{}
> >> +};
> >> +MODULE_DEVICE_TABLE(x86cpu, tdx_guest_ids);
> >> +#endif
> > 
> > Why the #ifdef?  Should not be needed, right?
> 
> I have added it to fix the following warning reported by 0-day.
> 
> https://lore.kernel.org/lkml/202209211607.tCtTWKbV-lkp@intel.com/
> 
> It is related to nullifying the MODULE_DEVICE_TABLE in #ifndef MODULE
> case in linux/module.h.

Then fix it properly, by correctly using that structure no matter what.
You don't do that here...

greg k-h
