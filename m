Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A11622F3A
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Nov 2022 16:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbiKIPmU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Nov 2022 10:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiKIPmT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Nov 2022 10:42:19 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7405713CEE;
        Wed,  9 Nov 2022 07:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668008538; x=1699544538;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oD611UU0ogsZ7u6HMPN6XGOfS1dmGrEttDxsVcnMFIQ=;
  b=D8QkJfQXLDgl6mpFMqX9nOfhCnDT+nPFFx+/Gjw6H236Tt4lU0s5Ccb+
   OGj+xdNYYNC71UxM5q1VKkzDWqAVAVU7uZiLNzRuP6v0GrC0nDnVoVCcz
   4bjmHvp/buQv0qWCeGh13ZognxwLmTLYnPcVjNmZZVPW310FA3J0QT+Il
   RgN8L/YszNMYz+TsJ8Up5Zg2AcUfc9BXU4IAWwBFzJIGqiUpQiUtSteK3
   9ldFblps/FbJxNZES3F0XYRDBJzOk+d9saxZGA7D2gG+L3M+GFSZfAR7d
   k5vTiQfp+eGqAGEDl1W/6IZDwjP5eXRuqx5gkU3ujST0x+I226M+DsEXu
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="311005228"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="311005228"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 07:36:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="742439061"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="742439061"
Received: from dmurray1-mobl1.amr.corp.intel.com (HELO [10.209.100.117]) ([10.209.100.117])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 07:36:22 -0800
Message-ID: <ccbbb331-80c5-75bf-cd5d-82748ad63a60@linux.intel.com>
Date:   Wed, 9 Nov 2022 07:36:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH v17 2/3] virt: Add TDX guest driver
Content-Language: en-US
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20221104032355.227814-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20221104032355.227814-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20221109142431.ffkhouuxewjajp6g@fedora>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20221109142431.ffkhouuxewjajp6g@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 11/9/22 6:24 AM, Wander Lairson Costa wrote:
>> +	reportdata = kmalloc(TDX_REPORTDATA_LEN, GFP_KERNEL);
>> +	if (!reportdata)
>> +		return -ENOMEM;
>> +
>> +	tdreport = kzalloc(TDX_REPORT_LEN, GFP_KERNEL);
>> +	if (!tdreport) {
>> +		ret = -ENOMEM;
>> +		goto out;
>> +	}
> Isn't simpler just allocating a struct tdx_report_req? You would save
> one allocation and a few lines of code.
> 

TDG.MR.TDCALL expects reportdata and tdreport buffers to be size aligned. So,
allocating them together with sizeof(struct tdx report req) will not work. We
can get around this by allocating a slightly larger buffer size. However, because
it is not a time-critical path, I believe that allocating two separate buffers
for input/output is simpler.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
