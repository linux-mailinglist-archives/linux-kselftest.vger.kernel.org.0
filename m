Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C02D5B2A9D
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 01:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiIHXxV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Sep 2022 19:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiIHXxU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Sep 2022 19:53:20 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D04AB1AB;
        Thu,  8 Sep 2022 16:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662681199; x=1694217199;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=T283FVBX95jJVUVJfhotCzb7jPZ3g0V6CxJ2ND8P1Xo=;
  b=aqFvPstsjpwf/OsJeCQs8kht7C6+5zNKuF6HNb5dPDhdKegl2Weis97K
   MZ2oEmqF11JlcKyCHBTgQVg8X7S022SgpWavsp3p8WOq2zcVbqBL4vzsB
   zTU82WiSD5PQCPwC4M9cSejUCcowqI9UR66Ew4JxZabJvHrV8tlmvlZHZ
   J2NyJJm2mXHa5QKx+fghmZznwFyG13HXKEBnWe9FZV7dbKTz3QIqXL7QS
   WHkwhahANlpYQwMPjTtd9B7DkU4gD3guvMyg3bQ8FY83jJfx4rKrytxuJ
   PjeiaXlM8t3+9gQ+LkwyLt0baqATTTnLC+3Pgzqk7EnUMzt9xIqdTyH/X
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="284372755"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="284372755"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 16:53:18 -0700
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="740864197"
Received: from duttamou-mobl1.amr.corp.intel.com (HELO [10.209.109.184]) ([10.209.109.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 16:53:18 -0700
Message-ID: <49f7bb67-2f4f-8e06-5420-5b279fdf3199@linux.intel.com>
Date:   Thu, 8 Sep 2022 16:53:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v12 1/3] x86/tdx: Add TDX Guest attestation interface
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
References: <20220908002723.923241-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220908002723.923241-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <Yxl+PE4A+WUfQ7bl@kroah.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <Yxl+PE4A+WUfQ7bl@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Dave/Greg,

On 9/7/22 10:31 PM, Greg Kroah-Hartman wrote:
> On Wed, Sep 07, 2022 at 05:27:20PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> +	/*
>> +	 * Per TDX Module 1.0 specification, section titled
>> +	 * "TDG.MR.REPORT", REPORTDATA length is fixed as
>> +	 * TDX_REPORTDATA_LEN, TDREPORT length is fixed as
>> +	 * TDX_REPORT_LEN, and TDREPORT subtype is fixed as
>> +	 * 0. Also check for valid user pointers.
>> +	 */
>> +	if (!req.reportdata || !req.tdreport || req.subtype ||
>> +		req.rpd_len != TDX_REPORTDATA_LEN ||
>> +		req.tdr_len != TDX_REPORT_LEN)
>> +		return -EINVAL;
> 
> You never verify that your reserved[7] fields are actually set to 0,
> which means you can never use them in the future :(
> 
> Please fix that up, thanks.

Would you prefer a new posting (v12.1 or v13) with this change, or do you
want to continue the review in the same version?

> 
> greg k-h

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
