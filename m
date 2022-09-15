Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574685B9950
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Sep 2022 13:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiIOLGo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Sep 2022 07:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiIOLGm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Sep 2022 07:06:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5BB9A987;
        Thu, 15 Sep 2022 04:06:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31DFBB81F8A;
        Thu, 15 Sep 2022 11:06:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D067C433C1;
        Thu, 15 Sep 2022 11:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663239998;
        bh=ZIFotHUugfjczGXzVpaayucTOv/a8Z+G34K/xXDTAxA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zMGEuCDWqMWpwwGn/0OvjUA/wc12taaOSDPSbhsLTs2klmo2Q7L7IzqXUkqLu9N4P
         5F4jIH3KN2MwxqQJ99bM2/ZquSVS2vWmzojAPWslqH/l/YLNRW/FaKIWyu+xTflPSp
         V6p86CUP7ntzOof2wbiEYRosPdLvsQelJbUqwlJQ=
Date:   Thu, 15 Sep 2022 13:07:05 +0200
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
Subject: Re: [PATCH v13 1/3] x86/tdx: Add TDX Guest attestation interface
 driver
Message-ID: <YyMHWQYUJHyIJMfA@kroah.com>
References: <20220909192708.1113126-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220909192708.1113126-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <7c3cc265-869b-b2fc-43f2-d2cbd0bc142c@intel.com>
 <1182ef92-cae3-b7c1-8339-8e8bfa48f2e3@linux.intel.com>
 <d238f235-5623-d152-c0d3-2ef851f88473@intel.com>
 <d5b54f8c-2e03-4ac8-8b8a-605c7f0f601b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5b54f8c-2e03-4ac8-8b8a-605c7f0f601b@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 14, 2022 at 05:30:45PM -0700, Sathyanarayanan Kuppuswamy wrote:
> I have also included info about why we don't use a separate config
> option for it.
> 
> The code for the SEV equivalent of this TDX attestation functionality
> can be found in drivers/virt/coco/sev-guest/. It is implemented as a
> platform module driver, and it can be enabled using the CONFIG_SEV_GUEST
> config option. However, in the case of TDX, it is implemented as a
> built-in driver in the arch/x86/coco/tdx/tdx.c because of the following
> reasons:
> 
> 1. Attestation is expected to be needed by all distributions that support
>    TDX. Therefore, using a separate configuration option is not necessary.
>    With TDX support, it can be enabled by default, and a built-in driver
>    model will work better in this use case.

No, that's not valid.  Distros want to enable everything, but only load
stuff that is only present.  You don't allow this for this code, which
isn't ok.

> 2. Since it is not a conventional device driver and the code is very simple,
>    creating an individual driver for it may be an overkill.

"simple" is not the issue, again, this should be a "normal" driver that
autoloads when the hardware is present and not load when the hardware is
not present.  This is not "special" to avoid the normal functionality of
all other drivers.

So again, no, this is not ok, fix this properly, don't be lazy.

thanks,

greg k-h
