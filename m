Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668765FC9DE
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Oct 2022 19:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiJLRZ6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Oct 2022 13:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiJLRZ5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Oct 2022 13:25:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6FA65F2;
        Wed, 12 Oct 2022 10:25:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE4A66159D;
        Wed, 12 Oct 2022 17:25:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F68C433C1;
        Wed, 12 Oct 2022 17:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665595554;
        bh=MMFc4+K+Q6mOheB5DwwpXSmMWP8NWqwwuVAZZnhkzII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tKtR2yI+k0/m6+A8H+5vuaCWjpi3NiYFNMZkCLE+SGSPIcuUhz9ghPsUswTvp6q1J
         Bda/P/PfCUPes/e3/xoraij45hGjO+T2WKQBPyYU3d8MdAknHSoXj3UjVeJDm/mp2u
         QEj9mPcIokiggE8fPftsD504kkGEvXo86dqeZ2r0=
Date:   Wed, 12 Oct 2022 19:26:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
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
Subject: Re: [PATCH v14 1/3] x86/tdx: Make __tdx_module_call() usable in
 driver module
Message-ID: <Y0b4zrOTU6adb0xi@kroah.com>
References: <20220928215535.26527-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220928215535.26527-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <Y0aUb3n7ouaeAt2a@zn.tnic>
 <acc212d6-782b-a398-825a-212849beba00@linux.intel.com>
 <Y0bOtzlrkKzHmQVZ@zn.tnic>
 <6759025f-fc08-74f0-efd7-2331110dec0c@linux.intel.com>
 <Y0bqA8+Xi1kLchxh@kroah.com>
 <62ef9740-64f0-ee60-71fa-80cc90da435c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62ef9740-64f0-ee60-71fa-80cc90da435c@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 12, 2022 at 10:13:50AM -0700, Sathyanarayanan Kuppuswamy wrote:
> Hi,
> 
> On 10/12/22 9:23 AM, Greg Kroah-Hartman wrote:
> > On Wed, Oct 12, 2022 at 08:44:04AM -0700, Sathyanarayanan Kuppuswamy wrote:
> >>
> >>
> >> On 10/12/22 7:27 AM, Borislav Petkov wrote:
> >>> On Wed, Oct 12, 2022 at 06:35:56AM -0700, Sathyanarayanan Kuppuswamy wrote:
> >>>> So we should create a new wrapper for this use case or use
> >>>
> >>> Yes, you got it - a new wrapper pls.
> >>
> >> Ok. I will add a new wrapper to get the TDREPORT. 
> >>
> >> +/*
> >>
> >> + * Add a wrapper for TDG.MR.REPORT TDCALL. It is used in TDX guest
> >>
> >> + * driver module to get the TDREPORT.
> >>
> >> + */
> >>
> >> +long tdx_mcall_get_report(void *reportdata, void *tdreport, u8 subtype)
> > 
> > Why "long"?
> 
> We used long because __tdx_module_call() call returns u64 value.

Great, then use u64 please.  Or if you are returning negative errors,
use s64 to be specific.

> Alternatively, we can also check for return value of __tdx_module_call() here
> and return 0/-EIO as return values. In this case we can change return value
> to int.

That would make more sense, right?

> > 
> > Why void *?  Don't you have real types for these?
> 
> We use these buffers as an intermediary to transfer data between userspace and
> the TDX module. In the kernel we don't consume these datas. So we did not define
> the type of the data.

Then these are userspace pointers?  Why are they not marked as such?

thanks,

greg k-h
