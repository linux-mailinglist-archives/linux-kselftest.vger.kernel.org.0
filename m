Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCAC55A4248
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 07:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiH2F3v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 01:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiH2F3t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 01:29:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C5EB27;
        Sun, 28 Aug 2022 22:29:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D00C60FDE;
        Mon, 29 Aug 2022 05:29:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3260C433D7;
        Mon, 29 Aug 2022 05:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661750985;
        bh=hzP4nkAeBpnmq1LiTZnUTTHZIw0ee9DQKe/6c5MU3Nc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fLy5N72FEUxoJDDEA1dGVs6Pe+kHiFv+TFKmvpWj66xiNrtEZf1bDVQBzshT5kBbj
         gwHH0EDgXUafHFCW+6uSVdX4WKOWjZddJUeEm7evgpsjTz/PEuIIqLl9FuyrtjHnhE
         Lnyb9Ob2gI0UKAV2jcw7dHXhowWHZaN9p3S3Fofw=
Date:   Mon, 29 Aug 2022 07:30:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v11 1/3] x86/tdx: Add TDX Guest attestation interface
 driver
Message-ID: <YwxO2L/MtCw/OHGB@kroah.com>
References: <20220826150638.2397576-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <dcf53e6b-d60f-5d6b-029a-38df68d66302@intel.com>
 <c6ccbcac-c5b1-f460-01e2-e1b6684b6e65@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6ccbcac-c5b1-f460-01e2-e1b6684b6e65@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Aug 28, 2022 at 05:19:33PM -0700, Sathyanarayanan Kuppuswamy wrote:
> Hi,
> 
> On 8/28/22 1:14 PM, Dave Hansen wrote:
> > On 8/26/22 08:06, Kuppuswamy Sathyanarayanan wrote:
> >> +struct tdx_report_req {
> >> +	__u8  subtype;
> >> +	__u64 reportdata;
> >> +	__u32 rpd_len;
> >> +	__u64 tdreport;
> >> +	__u32 tdr_len;
> >> +};
> > 
> > Please do take a look at how the compiler ends up building that structure.
> > 
> > If you sized things to "save space", the way the compiler treats that
> > structure may surprise you.  You might also want to look at how a 32-bit
> > compile deals with it versus a 64-bit one.
> 
> Since it is only used in user/kernel ABI, I did not consider the size
> issue.

That is _EXACTLY_ why you need to consider the size issues here.

> But I understand your point. The size of this struct in a 64-bit
> system is 40 bytes. So we did not gain anything with using different member
> sizes. In a 32-bit system, size due to padding is less compared to 64-bit.

That's not the issue here, please use a tool like pahole to see the
problems with this definition.

> I will re-arrange the struct as below. With this change, the size will come
> down to 32 bytes.
> 
> struct tdx_report_req {
>         __u64 reportdata;;
>         __u64 tdreport;
>         __u32 rpd_len
>         __u32 tdr_len;
>         __u8 subtype;
> };

That's better, but again, please use pahole.

thanks,

greg k-h
