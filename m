Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB576608245
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Oct 2022 01:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJUXvj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Oct 2022 19:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiJUXvi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Oct 2022 19:51:38 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EB0F53DF;
        Fri, 21 Oct 2022 16:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666396296; x=1697932296;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FfuVcGdiPTAK5k1d7MIsjDwLmLyP3F5o7OxDOtjkzOg=;
  b=XI8w6OGEH+vAHed6PvoGTPGplssGn4XPr+oOG0s6bV/oisw4hUuxcqtv
   xDD1C3UVXjvc5/5ps1Ys7fswxf76Zs/KQfVCGgiQvor2BXOZ3qRq9f9zH
   xKAHkRnKPMNr0optV8dmKZ7InHPRh8DcQINs84p9wlJ0cifdqI19XKMax
   HwlKR4D6IuT7nFgID+IFJ1sAMRGSCS/J5k4DUNjHU7AEcLYqPssl5D135
   CQvDfkoJwr/0sc1fXt4KO6UCOUjZRzPTq6ooUTJmnO3hl5J5UaDt3/L/b
   Maf2dy3TUkLmvaeBWHFDnuznWDKzCiz8zEm1N/6eOMiYJ+wPp+ulp2KFa
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="307122256"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="307122256"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 16:51:35 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="693913352"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="693913352"
Received: from sabravo-mobl.amr.corp.intel.com (HELO [10.209.25.112]) ([10.209.25.112])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 16:51:35 -0700
Message-ID: <13adfc8d-8118-2fd7-3a66-98dfbf8037a9@linux.intel.com>
Date:   Fri, 21 Oct 2022 16:51:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH v15 2/3] virt: Add TDX guest driver
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
References: <20221020045828.2354731-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20221020045828.2354731-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <Y1De4IyAB6n2qs4V@kroah.com>
 <34ef18d6-69f8-853a-d1ba-7023822e17ff@linux.intel.com>
 <Y1Iimg0WItgIGq6/@kroah.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <Y1Iimg0WItgIGq6/@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Greg,

On 10/20/22 9:39 PM, Greg Kroah-Hartman wrote:
>>>> +#ifdef MODULE
>>>> +static const struct x86_cpu_id tdx_guest_ids[] = {
>>>> +	X86_MATCH_FEATURE(X86_FEATURE_TDX_GUEST, NULL),
>>>> +	{}
>>>> +};
>>>> +MODULE_DEVICE_TABLE(x86cpu, tdx_guest_ids);
>>>> +#endif
>>> Why the #ifdef?  Should not be needed, right?
>> I have added it to fix the following warning reported by 0-day.
>>
>> https://lore.kernel.org/lkml/202209211607.tCtTWKbV-lkp@intel.com/
>>
>> It is related to nullifying the MODULE_DEVICE_TABLE in #ifndef MODULE
>> case in linux/module.h.
> Then fix it properly, by correctly using that structure no matter what.
> You don't do that here...

I think we can use __maybe_unused attribute to fix this warning like
mentioned below. Are you fine with it?

--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -118,13 +118,11 @@ static void __exit tdx_guest_exit(void)
 }
 module_exit(tdx_guest_exit);
 
-#ifdef MODULE
-static const struct x86_cpu_id tdx_guest_ids[] = {
+static const struct x86_cpu_id __maybe_unused tdx_guest_ids[] = {
        X86_MATCH_FEATURE(X86_FEATURE_TDX_GUEST, NULL),
        {}
 };
 MODULE_DEVICE_TABLE(x86cpu, tdx_guest_ids);
-#endif

Solution 2:
-----------

We can also modify the code to use this structure in all cases like
below. But it requires me to use slower x86_match_cpu() in place of 
cpu_feature_enabled() which I think is unnecessary.

--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -103,9 +103,15 @@ static struct miscdevice tdx_misc_dev = {
        .fops = &tdx_guest_fops,
 };
 
+static const struct x86_cpu_id tdx_guest_ids[] = {
+       X86_MATCH_FEATURE(X86_FEATURE_TDX_GUEST, NULL),
+       {}
+};
+MODULE_DEVICE_TABLE(x86cpu, tdx_guest_ids);
+
 static int __init tdx_guest_init(void)
 {
-       if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+       if (!x86_match_cpu(tdx_guest_ids))
                return -ENODEV;
 
        return misc_register(&tdx_misc_dev);
@@ -118,14 +124,6 @@ static void __exit tdx_guest_exit(void)
 }
 module_exit(tdx_guest_exit);
 
-#ifdef MODULE
-static const struct x86_cpu_id tdx_guest_ids[] = {
-       X86_MATCH_FEATURE(X86_FEATURE_TDX_GUEST, NULL),
-       {}
-};
-MODULE_DEVICE_TABLE(x86cpu, tdx_guest_ids);
-#endif

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
