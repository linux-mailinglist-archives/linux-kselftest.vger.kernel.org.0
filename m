Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8F25FC926
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Oct 2022 18:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiJLQXQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Oct 2022 12:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiJLQXJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Oct 2022 12:23:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886E9F41A5;
        Wed, 12 Oct 2022 09:22:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE4426153D;
        Wed, 12 Oct 2022 16:22:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F2FC433D7;
        Wed, 12 Oct 2022 16:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665591767;
        bh=UjNgOOyW8/JL74ooqVzEOOqGR0npOCxfJs6SbJ73/wI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l46iHQyNjBQ6EU86JIYM2uyZ18tQwF/6wGiGuRSEzRyPeOOiJday862Gc4rb6DLWs
         VZiLZ0oE286XiZ9XGG8TvG0FWkLm+BkFQPeIH206m/CCWU5i8m13MNF9ICuNxNz7fw
         /NVgy9W5SpN3W6kWvx/8RIojMjHSjfAdBJWw5EyQ=
Date:   Wed, 12 Oct 2022 18:23:31 +0200
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
Message-ID: <Y0bqA8+Xi1kLchxh@kroah.com>
References: <20220928215535.26527-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220928215535.26527-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <Y0aUb3n7ouaeAt2a@zn.tnic>
 <acc212d6-782b-a398-825a-212849beba00@linux.intel.com>
 <Y0bOtzlrkKzHmQVZ@zn.tnic>
 <6759025f-fc08-74f0-efd7-2331110dec0c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6759025f-fc08-74f0-efd7-2331110dec0c@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 12, 2022 at 08:44:04AM -0700, Sathyanarayanan Kuppuswamy wrote:
> 
> 
> On 10/12/22 7:27 AM, Borislav Petkov wrote:
> > On Wed, Oct 12, 2022 at 06:35:56AM -0700, Sathyanarayanan Kuppuswamy wrote:
> >> So we should create a new wrapper for this use case or use
> > 
> > Yes, you got it - a new wrapper pls.
> 
> Ok. I will add a new wrapper to get the TDREPORT. 
> 
> +/*
> 
> + * Add a wrapper for TDG.MR.REPORT TDCALL. It is used in TDX guest
> 
> + * driver module to get the TDREPORT.
> 
> + */
> 
> +long tdx_mcall_get_report(void *reportdata, void *tdreport, u8 subtype)

Why "long"?

Why void *?  Don't you have real types for these?



> 
> +{
> 
> +       if (subtype || !reportdata || !tdreport)
> 
> +               return -EINVAL;

How could that happen if you control all callers?



> 
> +
> 
> +       /*
> 
> +        * Generate TDREPORT using "TDG.MR.REPORT" TDCALL.
> 
> +        *
> 
> +        * Get the TDREPORT using REPORTDATA as input. Refer to
> 
> +        * section 22.3.3 TDG.MR.REPORT leaf in the TDX Module 1.0
> 
> +        * specification for detailed information.
> 
> +        */
> 
> +       return __tdx_module_call(TDX_GET_REPORT, virt_to_phys(tdreport),
> 
> +                       virt_to_phys(reportdata), subtype, 0, NULL);

If you check for NULL, why are you not validating that these are valid
pointers as well?  You can't have it both ways.

thanks,

greg k-h
