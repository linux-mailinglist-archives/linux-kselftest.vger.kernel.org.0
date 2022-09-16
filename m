Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9615BA7D7
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Sep 2022 10:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiIPILm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Sep 2022 04:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiIPILj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Sep 2022 04:11:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CC252E70;
        Fri, 16 Sep 2022 01:11:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 107F1B8240A;
        Fri, 16 Sep 2022 08:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CCBDC4314B;
        Fri, 16 Sep 2022 08:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663315894;
        bh=UjrJ6rV6Smlr80CPMv/VjhqDaYwm1rHtI46H63PMjMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y2Aq472hCkCe877D/8cXUKgjyP37uokYLKVT88+4PyqAQkm+Vegp7D6VXcOO1g2Zb
         r77qN0g5yhXJX0jR9aIFdqpklsL4R2oRq8HySr8TINdrXsi6thXNyKhsTviMY/dS5s
         lylvKBokAv6+cs01qZl07dV5jK8B/jH4shDsPuHE=
Date:   Fri, 16 Sep 2022 10:12:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <YyQv0JS6dDcn364X@kroah.com>
References: <20220909192708.1113126-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220909192708.1113126-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YyMH37G2CTuVCbLM@kroah.com>
 <208a847e-92eb-0590-b498-e34d59b1cf34@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <208a847e-92eb-0590-b498-e34d59b1cf34@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 15, 2022 at 08:22:37AM -0700, Sathyanarayanan Kuppuswamy wrote:
> Hi,
> 
> On 9/15/22 4:09 AM, Greg Kroah-Hartman wrote:
> > On Fri, Sep 09, 2022 at 12:27:06PM -0700, Kuppuswamy Sathyanarayanan wrote:
> >> +static int __init tdx_guest_init(void)
> >> +{
> >> +	int ret;
> >> +
> >> +	if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
> >> +		return -EIO;
> >> +
> >> +	ret = misc_register(&tdx_misc_dev);
> >> +	if (ret) {
> >> +		pr_err("misc device registration failed\n");
> >> +		return ret;
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +device_initcall(tdx_guest_init)
> > 
> > As mentioned elsewhere, make this a normal module_init() format and only
> > load the module if the hardware is present.  Don't just always be
> 
> This feature needs to be enabled by default for all valid TDX guests.

Why?  What is so needed by userspace to require this brand new char
device node just to use TDX?

> If TDX support is enabled and the guest is a valid TDX guest, the
> "X86 FEATURE TDX GUEST" feature flag will be set. So looking for
> "if(!cpu feature enabled(X86 FEATURE TDX GUEST))" will ensure that
> the interface is only created in a valid TDX guest.

Yes, but that's not the point.  We don't just "build all drivers into
the kernel and only bind to hardware we actually have".  That's not how
Linux works, sorry.

> Even if we make it into a separate driver and use module init(), we'll
> have to use the same "if(!cpu feature enabled(X86 FEATURE TDX GUEST))"
> check to create and load the device. This approach was used in earlier
> versions of this driver. We later changed it to initcall because it
> appeared to be a roundabout approach.

Sorry, no, do it properly, have it be autoloaded only on the systems
that have the cpu feature.

> Let me know if you still suggest to use module_init() model.

Yes, it is a requirement.  Do you want every driver to try to copy what
you are doing here?

> Following is the sample implementation with module_init() and this code
> will be compiled with CONFIG_INTEL_TDX_GUEST=y.
> 
> +static struct platform_driver tdx_attest_driver = {
> +	.probe		= tdx_attest_probe,
> +	.remove		= tdx_attest_remove,
> +	.driver		= {
> +		.name	= DRIVER_NAME,
> +	},
> +};
> +
> +static int __init tdx_attest_init(void)
> +{
> +	int ret;
> +
> +	/* Make sure we are in a valid TDX platform */
> +	if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
> +		return -EIO;
> +
> +	ret = platform_driver_register(&tdx_attest_driver);
> +	if (ret) {
> +		pr_err("failed to register driver, err=%d\n", ret);
> +		return ret;
> +	}
> +
> +	pdev = platform_device_register_simple(DRIVER_NAME, -1, NULL, 0);
> +	if (IS_ERR(pdev)) {
> +		ret = PTR_ERR(pdev);
> +		pr_err("failed to allocate device, err=%d\n", ret);
> +		platform_driver_unregister(&tdx_attest_driver);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void __exit tdx_attest_exit(void)
> +{
> +	platform_device_unregister(pdev);
> +	platform_driver_unregister(&tdx_attest_driver);
> +}
> +
> +module_init(tdx_attest_init);
> +module_exit(tdx_attest_exit);

Sorry, no, this too is not ok as you are not telling userspace if it
needs to load your driver or not automatically.  Please do this
properly.

Basic issues like this shouldn't be showing up in v13 of a patch series.
Please take the time and start over and go and get a lot of internal
review before sending anything out again.

thanks,

greg k-h
