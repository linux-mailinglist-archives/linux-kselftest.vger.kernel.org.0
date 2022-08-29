Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3925A4136
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 05:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiH2DF2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 28 Aug 2022 23:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiH2DF0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 28 Aug 2022 23:05:26 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DF013CD1;
        Sun, 28 Aug 2022 20:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661742324; x=1693278324;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bxnklHPfkkZ2myEOBs5S+1zOu/lBODzvnWmseu9Xcto=;
  b=LRc1tNY9bwwtHuOc9yx7pqig87wamfjYmORE24nCJ7F3Uw+AlGfiiLOT
   lK53smnllVK/5/wqzo+95P1tCfOxi6abYZ1SCmgy8tcfnMYJjH1gyldBi
   azJ3e7F1Qv+5RUdLP3txLJMTgk7YxtrbSGXA3EHZfCvQCnKkfthI1neYP
   InPcrlWaG476gVP6O+o7a0QyrtWY4eOGEGsLeTkE2X72rJlvtOYj0q0jt
   Ith21zZ1/IbfOL5BRTOmwu6ysWnmx6+btUOfVD+eo2s1dJ2/lHl02gXPz
   FUPkpOjsU5M97FsQp0B1x0WtMMlvyzfkXNGL8weTLGEo6VO3gUKpYE/iv
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="281767337"
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="281767337"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2022 20:05:23 -0700
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="587997169"
Received: from nehluza-mobl.amr.corp.intel.com (HELO [10.209.6.250]) ([10.209.6.250])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2022 20:05:22 -0700
Message-ID: <17611541-38a7-7100-aa49-5321c1613fce@linux.intel.com>
Date:   Sun, 28 Aug 2022 20:05:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v11 3/3] Documentation/x86: Document TDX attestation
 process
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
References: <20220826150638.2397576-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220826150638.2397576-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YwwpdsNazNBjRnVU@debian.me>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <YwwpdsNazNBjRnVU@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 8/28/22 7:50 PM, Bagas Sanjaya wrote:
> On Fri, Aug 26, 2022 at 08:06:38AM -0700, Kuppuswamy Sathyanarayanan wrote:
>> +Input parameters: Parameters passed to the IOCTL and related details.
>> +Output          : Details about output data and return value (with details
>> +                  about the non common error values).
>> +
>> +TDX_CMD_GET_REPORT
>> +------------------
>> +
>> +:Input parameters: struct tdx_report_req
>> +:Output          : Upon successful execution, TDREPORT data is copied to
>> +                   tdx_report_req.tdreport and returns 0 or returns
>> +                   -EIO on TDCALL failure and standard error number on
>> +                   other common failures.
> 
> Hi,
> 
> The field lists above trigger htmldocs warnings:
> 
> Documentation/x86/tdx.rst:269: WARNING: Unexpected indentation.
> Documentation/x86/tdx.rst:275: WARNING: Field list ends without a blank line; unexpected unindent.
> 
> I have applied the fixup:

Thanks. I will include it in next version.

> 
> ---- >8 ----
> diff --git a/Documentation/x86/tdx.rst b/Documentation/x86/tdx.rst
> index 45db1201b62433..c9e3ecf86e0b43 100644
> --- a/Documentation/x86/tdx.rst
> +++ b/Documentation/x86/tdx.rst
> @@ -264,18 +264,18 @@ device to allow user space to get certain TDX guest specific details
>  In this section, for each supported IOCTL, following information is
>  provided along with generic description.
>  
> -Input parameters: Parameters passed to the IOCTL and related details.
> -Output          : Details about output data and return value (with details
> -                  about the non common error values).
> +:Input parameters: Parameters passed to the IOCTL and related details.
> +:Output: Details about output data and return value (with details
> +         about the non common error values).
>  
>  TDX_CMD_GET_REPORT
>  ------------------
>  
>  :Input parameters: struct tdx_report_req
> -:Output          : Upon successful execution, TDREPORT data is copied to
> -                   tdx_report_req.tdreport and returns 0 or returns
> -                   -EIO on TDCALL failure and standard error number on
> -                   other common failures.
> +:Output: Upon successful execution, TDREPORT data is copied to
> +         tdx_report_req.tdreport and returns 0 or returns
> +         -EIO on TDCALL failure and standard error number on
> +         other common failures.
>  
>  The TDX_CMD_GET_REPORT IOCTL can be used by the attestation software to
>  get the TDX guest measurements data (with few other info) in the format
> 
> Thanks.
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
