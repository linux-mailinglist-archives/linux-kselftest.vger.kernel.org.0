Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1871B5B9EAC
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Sep 2022 17:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiIOPXv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Sep 2022 11:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiIOPXW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Sep 2022 11:23:22 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6B81E3F2;
        Thu, 15 Sep 2022 08:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663255360; x=1694791360;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2mRF8w8hL1HBMWIlqV+SFW8gKa3TqIUcCL/Ln8KWTlo=;
  b=WLKsNPDzK7AXBjvTZpnJuif9g9Fg9x3PHxdrOWnoLElToOhTkXdWqk8y
   KrLTqd2tBQ4ttorZyhNNvLuqfHiSV8eIvyqq9MDDvZlgLke4UunkHpXlk
   XDn41iaJ3WyWI6Z8mCn9iGijUFOPrVRBApCasdtiYM0rX5RWmk3dEArmb
   MwkfW7At6qq+lyqxFiy5OyfSTx80fZwNbUNH4zXt6TftWwF+gLy4pCsVc
   FjXvEVj2JuRVpT1y4Dz9VZhM2I4yIH7C96JLDI3MDdSzzEkw7Ki3LhxJ3
   4jTuGmq0EziPYJvEblIvUD8f6hzU8evUFWQwuXUpBrL8e2aay1403tOeK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="285785144"
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="285785144"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 08:22:38 -0700
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="679560931"
Received: from vasanth1-mobl.amr.corp.intel.com (HELO [10.255.231.111]) ([10.255.231.111])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 08:22:37 -0700
Message-ID: <208a847e-92eb-0590-b498-e34d59b1cf34@linux.intel.com>
Date:   Thu, 15 Sep 2022 08:22:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v13 1/3] x86/tdx: Add TDX Guest attestation interface
 driver
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
References: <20220909192708.1113126-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220909192708.1113126-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YyMH37G2CTuVCbLM@kroah.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <YyMH37G2CTuVCbLM@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On 9/15/22 4:09 AM, Greg Kroah-Hartman wrote:
> On Fri, Sep 09, 2022 at 12:27:06PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> +static int __init tdx_guest_init(void)
>> +{
>> +	int ret;
>> +
>> +	if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
>> +		return -EIO;
>> +
>> +	ret = misc_register(&tdx_misc_dev);
>> +	if (ret) {
>> +		pr_err("misc device registration failed\n");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +device_initcall(tdx_guest_init)
> 
> As mentioned elsewhere, make this a normal module_init() format and only
> load the module if the hardware is present.  Don't just always be

This feature needs to be enabled by default for all valid TDX guests.

If TDX support is enabled and the guest is a valid TDX guest, the
"X86 FEATURE TDX GUEST" feature flag will be set. So looking for
"if(!cpu feature enabled(X86 FEATURE TDX GUEST))" will ensure that
the interface is only created in a valid TDX guest.

Even if we make it into a separate driver and use module init(), we'll
have to use the same "if(!cpu feature enabled(X86 FEATURE TDX GUEST))"
check to create and load the device. This approach was used in earlier
versions of this driver. We later changed it to initcall because it
appeared to be a roundabout approach.

Let me know if you still suggest to use module_init() model.

Following is the sample implementation with module_init() and this code
will be compiled with CONFIG_INTEL_TDX_GUEST=y.

+static struct platform_driver tdx_attest_driver = {
+	.probe		= tdx_attest_probe,
+	.remove		= tdx_attest_remove,
+	.driver		= {
+		.name	= DRIVER_NAME,
+	},
+};
+
+static int __init tdx_attest_init(void)
+{
+	int ret;
+
+	/* Make sure we are in a valid TDX platform */
+	if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return -EIO;
+
+	ret = platform_driver_register(&tdx_attest_driver);
+	if (ret) {
+		pr_err("failed to register driver, err=%d\n", ret);
+		return ret;
+	}
+
+	pdev = platform_device_register_simple(DRIVER_NAME, -1, NULL, 0);
+	if (IS_ERR(pdev)) {
+		ret = PTR_ERR(pdev);
+		pr_err("failed to allocate device, err=%d\n", ret);
+		platform_driver_unregister(&tdx_attest_driver);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void __exit tdx_attest_exit(void)
+{
+	platform_device_unregister(pdev);
+	platform_driver_unregister(&tdx_attest_driver);
+}
+
+module_init(tdx_attest_init);
+module_exit(tdx_attest_exit);

> built/loaded, that's not ok.



> 
> thanks,
> 
> greg k-h

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
