Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800585B65CD
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Sep 2022 04:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiIMCoa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Sep 2022 22:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiIMCoK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Sep 2022 22:44:10 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A958C5300C;
        Mon, 12 Sep 2022 19:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663037049; x=1694573049;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Vqfi05Z4Z8Qp9L70ig4iz7+6GxG0pFYgY4ZoQ6Q11gU=;
  b=Kc1V5lSixuFAf1ri10Syf7qJOTUbqMjc6Oi8Sb6N3FhdR93FzNxwDxPu
   zSdmHOe2yOKZgU5PcSKJVwzVjYYe6ijz0gRZhlTjk0qShyAUqdcnng6pr
   lGDK5nIC5Li2CZZBIcCe/Nqm4Fd3C6HQYI+bXjbiwNegr8rq0YiOQO08r
   m4fotT3qfIbG4rMW4HzwJj0T6qqmfwEd6OqcTPYUWgDOQ7InBAgW+YVg/
   mtJqPyad8aX4dH82gRJd+zxDwLb3AJ/Oa5tL+9jbT8zM5tIfGu1tRSU5z
   gyidq2vlTW5FKm8YCXFxmsPGxhRuv/wKHmvw0/zXD1uFT/IZA/QrDJhwA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="384316195"
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="384316195"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 19:44:09 -0700
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="646733909"
Received: from liweian-mobl.amr.corp.intel.com (HELO [10.209.26.112]) ([10.209.26.112])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 19:44:08 -0700
Message-ID: <d67b4273-e0a6-6b24-b96c-7a3193ae52f9@linux.intel.com>
Date:   Mon, 12 Sep 2022 19:44:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v13 1/3] x86/tdx: Add TDX Guest attestation interface
 driver
Content-Language: en-US
To:     "Huang, Kai" <kai.huang@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "wander@redhat.com" <wander@redhat.com>,
        "tim.gardner@canonical.com" <tim.gardner@canonical.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "khalid.elmously@canonical.com" <khalid.elmously@canonical.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "Cox, Philip" <philip.cox@canonical.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <20220909192708.1113126-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220909192708.1113126-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <f85dbb3636ad199ff5f6ea9bdf5e17261f66945d.camel@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <f85dbb3636ad199ff5f6ea9bdf5e17261f66945d.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 9/12/22 6:25 PM, Huang, Kai wrote:
>> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
>> index 928dcf7a20d9..8b5c59110321 100644
>> --- a/arch/x86/coco/tdx/tdx.c
>> +++ b/arch/x86/coco/tdx/tdx.c
>> @@ -5,16 +5,21 @@
>>  #define pr_fmt(fmt)     "tdx: " fmt
>>  
>>  #include <linux/cpufeature.h>
>> +#include <linux/miscdevice.h>
>> +#include <linux/mm.h>
>> +#include <linux/io.h>
> Sorry perhaps I am missing something, but what is the reason to include
> <linux/mm.h>?

It is included for kmalloc/kfree, file related structs and copy_{from|to}_user().

> 
> <linux/io.h> is for virt_to_phys()?

Yes

> 
> And should we explicitly include <linux/uaccess.h> for copy_{from|to}_user(),

mm.h covers it. So I don't think we should explicitly include it.

> and include the header (<linux/string.h> ?) for memchr_inv()?

One of the previous headers includes linux/string.h (I am not sure which one).
So why include it explicitly?

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
