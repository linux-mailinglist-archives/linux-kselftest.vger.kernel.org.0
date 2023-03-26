Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEB66C92D6
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Mar 2023 08:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjCZGfC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 26 Mar 2023 02:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjCZGfB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 26 Mar 2023 02:35:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6951A5FDE;
        Sat, 25 Mar 2023 23:35:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0162BB801C0;
        Sun, 26 Mar 2023 06:34:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019D8C433D2;
        Sun, 26 Mar 2023 06:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679812497;
        bh=jr13vMuf/WaHi5CBNG+X2Brpbr1MnZxbiMHYOEZyZVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eTIMMVczZqjaFFjFea7FxGinqMwyKi5ehjeZtYZt0iztBREcv6eiTgOszrG/eZ2cE
         n/c/vwh+0PMqajzLshr0kG/lz8zHju9wAGv+SY2TiYEcsPO3+c288/Wetnm9VoGi3s
         /j4Me3rpKvEU6uIRun8B/CigylfUrb+ZEwjh4Fes=
Date:   Sun, 26 Mar 2023 08:34:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
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
        Wander Lairson Costa <wander@redhat.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        Du Fan <fan.du@intel.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 2/3] virt: tdx-guest: Add Quote generation support
Message-ID: <ZB/njYsTTwgTtAeA@kroah.com>
References: <20230326062039.341479-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20230326062039.341479-3-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230326062039.341479-3-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Mar 25, 2023 at 11:20:38PM -0700, Kuppuswamy Sathyanarayanan wrote:
> Since GetQuote support requires usage of DMA APIs, convert TDX guest
> driver to a platform driver.

Sorry, but that's not a valid reason to use a platform device for fake
things like this:

> +static struct platform_device *tdx_dev;

Especially a single static one.

> +static int tdx_guest_probe(struct platform_device *pdev)
> +{
> +	if (tdx_register_event_irq_cb(attestation_callback_handler, pdev))
> +		return -EIO;
> +
> +	return misc_register(&tdx_misc_dev);
> +}
> +
> +static int tdx_guest_remove(struct platform_device *pdev)
> +{
> +	tdx_unregister_event_irq_cb(attestation_callback_handler, pdev);
> +	misc_deregister(&tdx_misc_dev);
> +	return 0;
> +}
> +
> +static struct platform_driver tdx_guest_driver = {
> +	.probe = tdx_guest_probe,
> +	.remove = tdx_guest_remove,
> +	.driver.name = KBUILD_MODNAME,
> +};
> +
>  static const struct x86_cpu_id tdx_guest_ids[] = {
>  	X86_MATCH_FEATURE(X86_FEATURE_TDX_GUEST, NULL),
>  	{}
> @@ -84,16 +310,35 @@ MODULE_DEVICE_TABLE(x86cpu, tdx_guest_ids);
>  
>  static int __init tdx_guest_init(void)
>  {
> +	int ret;
> +
>  	if (!x86_match_cpu(tdx_guest_ids))
>  		return -ENODEV;
>  
> -	return misc_register(&tdx_misc_dev);
> +	ret = platform_driver_register(&tdx_guest_driver);
> +	if (ret) {
> +		pr_err("failed to register driver, err=%d\n", ret);
> +		return ret;
> +	}

No, please do not create a fake platform driver.

> +	tdx_dev = platform_device_register_simple(KBUILD_MODNAME,
> +						  PLATFORM_DEVID_NONE,
> +						  NULL, 0);

And please do not create a fake platform device.

As always, do not create fake platform devices for things that are NOT
platform devices.

If this device needs DMA (but why?) then make it a real device and tie
it to the bus it belongs to (that it is obviously doing DMA on.)

But as-is, this isn't ok, sorry.

thanks,

greg k-h
