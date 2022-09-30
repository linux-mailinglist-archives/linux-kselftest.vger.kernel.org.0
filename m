Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3DE5F0ED3
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Sep 2022 17:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiI3P2F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Sep 2022 11:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbiI3P1n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Sep 2022 11:27:43 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31062184820;
        Fri, 30 Sep 2022 08:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664551662; x=1696087662;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pdBa67z24rRy+FxC1HOkaJMDCnc29Jo4VuWC2sxPlkc=;
  b=GJGl1Mub2QQcekcktEJSjl+k6U0TUhm4519eUlCUgwsg2GZG8qA6YYOw
   V9JgBTZ2a9WDwrKQnMhNWZ/kZBjjQw7rzfrZ5fOZp/mp2rRwEPCCNQtbo
   /dSq6D7lp45sZsZpWVG4bNBmIC6jFPw/+Ab+RI5Hy2JZfdTh0T5Jgb6j1
   Nq7KyYqxpdwtn/SezQW6sl6lCaDoPXY97WGKE8+oKbcNq9bhl9KqDDWsf
   VHy6GznfA5uKvPTr1Iaqo8lNenxi5RBpRdRo6Zta+KpzNIneLuKsasO7L
   /B+Kzosbaej7zbqbSWU9qEeZvX7ShYnd4E+IPAuWuXY+lDM7YAhTeAsFx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="289377080"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="289377080"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 08:27:41 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="685320052"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="685320052"
Received: from lventrap-mobl2.amr.corp.intel.com (HELO [10.251.23.225]) ([10.251.23.225])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 08:27:40 -0700
Message-ID: <c0e8ccaa-46b8-061b-f035-cd6a984a25b6@linux.intel.com>
Date:   Fri, 30 Sep 2022 08:27:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v14 2/3] virt: Add TDX guest driver
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20220928215535.26527-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220928215535.26527-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YzXduIn83E1oood8@fedora>
 <665a4db2-a342-43ba-38a0-715c34709729@linux.intel.com>
 <YzbflIZzANjAgN9d@kroah.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <YzbflIZzANjAgN9d@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 9/30/22 5:22 AM, Greg Kroah-Hartman wrote:
> On Thu, Sep 29, 2022 at 11:11:47AM -0700, Sathyanarayanan Kuppuswamy wrote:
>>
>>
>> On 9/29/22 11:02 AM, Wander Lairson Costa wrote:
>>>> +#define TDX_GUEST_DEVICE                "tdx-guest"
>>> nit: I think now we can use KBUILD_MODNAME, can't we?
>>>
>>
>> Yes. We can use it. But I thought user can use this macro
>> and avoid hard coding the device name.
> 
> What user?  Please use KBUILD_MODNAME now instead.

Ok. I will change it.

> 
> thanks,
> 
> greg k-h

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
