Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92636C9787
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Mar 2023 21:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjCZTGa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 26 Mar 2023 15:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCZTG3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 26 Mar 2023 15:06:29 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534EC55A9;
        Sun, 26 Mar 2023 12:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679857588; x=1711393588;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1coLZK2+6QhUoBhOOnCKU1bEC8YpqZMPXDexV6IJzhs=;
  b=YrudwwPJlYRpYZg7nkOzcKLyPE8CWn+WHBV5rMoH3ypwCyYKClLBL4DY
   +funzJieyW3Z1H7rDjf7xlgXaHZ0xqMQZ98g82lS/mxJc+SAdesXltyS4
   jF+tuSkGYnrB3Il4nrAlh5wWmJ5Lo9S9KmrgWIdO+ghZnH5eP24/so5JS
   PRXh2Hp4vF4CaR8bpOBnE1kMR3MSQFgwUKz7aUlCA+nCl9kp+scjl0Jap
   /hwKpcp6pmjEdz53on2QPq3XZ6MUHBReoLuCu0gS3hzM4MdLNGfGAtxNG
   yfwvPHMYMAxqCx+SeOS4AXYEiHe7FB9WQpzuSNjM1YcwM5Kn9diY38wXZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="367859501"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="367859501"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 12:06:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="660637147"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="660637147"
Received: from schilka-mobl2.amr.corp.intel.com (HELO [10.212.162.13]) ([10.212.162.13])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 12:06:27 -0700
Message-ID: <d09f30f5-23da-4fb6-141e-3dd9483217c7@linux.intel.com>
Date:   Sun, 26 Mar 2023 12:06:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v1 2/3] virt: tdx-guest: Add Quote generation support
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
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
References: <20230326062039.341479-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20230326062039.341479-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <ZB/njYsTTwgTtAeA@kroah.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <ZB/njYsTTwgTtAeA@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Greg,

Thanks for the review comments.

On 3/25/23 11:34 PM, Greg KH wrote:
> On Sat, Mar 25, 2023 at 11:20:38PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> Since GetQuote support requires usage of DMA APIs, convert TDX guest
>> driver to a platform driver.
> 
> Sorry, but that's not a valid reason to use a platform device for fake
> things like this:
> 
>> +static struct platform_device *tdx_dev;
> 
> Especially a single static one.
> 
>> +static int tdx_guest_probe(struct platform_device *pdev)
>> +{
>> +	if (tdx_register_event_irq_cb(attestation_callback_handler, pdev))
>> +		return -EIO;
>> +
>> +	return misc_register(&tdx_misc_dev);
>> +}
>> +
>> +static int tdx_guest_remove(struct platform_device *pdev)
>> +{
>> +	tdx_unregister_event_irq_cb(attestation_callback_handler, pdev);
>> +	misc_deregister(&tdx_misc_dev);
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver tdx_guest_driver = {
>> +	.probe = tdx_guest_probe,
>> +	.remove = tdx_guest_remove,
>> +	.driver.name = KBUILD_MODNAME,
>> +};
>> +
>>  static const struct x86_cpu_id tdx_guest_ids[] = {
>>  	X86_MATCH_FEATURE(X86_FEATURE_TDX_GUEST, NULL),
>>  	{}
>> @@ -84,16 +310,35 @@ MODULE_DEVICE_TABLE(x86cpu, tdx_guest_ids);
>>  
>>  static int __init tdx_guest_init(void)
>>  {
>> +	int ret;
>> +
>>  	if (!x86_match_cpu(tdx_guest_ids))
>>  		return -ENODEV;
>>  
>> -	return misc_register(&tdx_misc_dev);
>> +	ret = platform_driver_register(&tdx_guest_driver);
>> +	if (ret) {
>> +		pr_err("failed to register driver, err=%d\n", ret);
>> +		return ret;
>> +	}
> 
> No, please do not create a fake platform driver.
> 
>> +	tdx_dev = platform_device_register_simple(KBUILD_MODNAME,
>> +						  PLATFORM_DEVID_NONE,
>> +						  NULL, 0);
> 
> And please do not create a fake platform device.
> 
> As always, do not create fake platform devices for things that are NOT
> platform devices.
> 
> If this device needs DMA (but why?) then make it a real device and tie

Since the Quote generation process requires the guest and VMM to share data,
we need to use shared buffers. But in TDX guest, VMM cannot directly access
the guest private memory. Any memory that is required for communication with
the VMM must be shared explicitly. One way is to allocate the memory on
demand and share it explicitly using set_memory_decrypted() call. Although
this approach is clean, since it breaks the direct mapping, it is not
efficient. An alternative way is to reserve a pool of shared buffers during
boot time and re-use them for guest/VMM communication. Since in TDX, DMA API
is configured to tap into the SWIOTLB memory framework (which is shared by
default), we try to use dma_alloc_* APIs to allocate the shared buffers from
the shared pool without breaking the direct map.

If usage of DMA APIs / platform device is not acceptable for this use case,
an alternative approach is to allocate a fixed number of shared buffers during
the TDX guest driver probe and use it for GetQuote requests. Although it would
limit the amount of memory we can use for GetQuote requests at a time and also
reserve a chunk of memory during the init() time, I think it is an acceptable
tradeoff when compared to alternative choices. The AMD SEV guest driver also
adopts the similar approach. Please let me know if this approach is acceptable.

> it to the bus it belongs to (that it is obviously doing DMA on.)


> 
> thanks,
> 
> greg k-h

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
