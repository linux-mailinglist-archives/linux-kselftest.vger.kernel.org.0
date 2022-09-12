Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60545B6344
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Sep 2022 00:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiILWGE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Sep 2022 18:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiILWGE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Sep 2022 18:06:04 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666FF4D248;
        Mon, 12 Sep 2022 15:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663020363; x=1694556363;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Yx4/GXFazlfNJRTspmVJbE3Rv6hXYzUYBI4/8V8bsLc=;
  b=lV6daXjg2sCV8QhfoqVTomkgDT2/zD9kdPXLuAZRHwNtKvlE9obr/dt8
   DgYYe4iS2+FIFU6HMcCzIHvaCFasthCqPXvkcMPnS15EVMbGpcDfEvLK8
   2FArGpOKKgIlYCDJA7M2POpJLiII7gnwEVFjpw6R+9h7tKGRtKpd8dXMW
   EWgKTyPuny3nEp0xoAP8AWREzI/elhdzz4vuEwIY36qZS2D4JzAY6orto
   fVql+Q4l/khdxvESFXKQ+R9LayRDqG+SR0siFpyCj/k/fJaCucvYaueGP
   PNkoQvHqBpW5IzLIUM/actISyi52776acTkV77a6eXj8Myurbq2XmYLT+
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="277714597"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="277714597"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 15:06:03 -0700
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="618701352"
Received: from mdejong-mobl.amr.corp.intel.com (HELO [10.209.13.71]) ([10.209.13.71])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 15:06:02 -0700
Message-ID: <7600f26c-d107-a0ec-f601-9bd8c203fc81@linux.intel.com>
Date:   Mon, 12 Sep 2022 15:06:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v13 2/3] selftests: tdx: Test TDX attestation GetReport
 support
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
 <20220909192708.1113126-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <73c43175226bb0f9a9dcae8ba953b213db47fbc8.camel@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <73c43175226bb0f9a9dcae8ba953b213db47fbc8.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Kai,

On 9/12/22 12:17 AM, Huang, Kai wrote:
> On Fri, 2022-09-09 at 12:27 -0700, Kuppuswamy Sathyanarayanan wrote:
>> Attestation is used to verify the trustworthiness of a TDX guest.
>> During the guest bring-up, Intel TDX module measures and records
>> the initial contents and configuration of the guest, and at runtime,
>> guest software uses runtime measurement registers (RMTRs) to measure
>> and record details related to kernel image, command line params, ACPI
>> tables, initrd, etc. At TDX guest runtime, Intel SGX attestation
>> infrastructure is re-used to attest to these measurement data.
> 
> Similar the comment to patch 3, I don't particularly like "to attest" part as
> only the verification service can truly _attest_ somthing (I suppose the "SGX
> infrastructure" here you mean SGX QE to generate the Quote). 
> 
> I think you can just say something like "TDX leverages SGX Quote mechanism to
> support remote attestation of TDX guests".  And you can combine this with below
> paragraph.

The part about leveraging the SGX infrastructure is not very important. We can
even drop it. But I want to add some details about what we do with this measurement
data. In the first paragraph, we have started with collection of measurements data.
If we directly jump to attestation process without explaining the need for collecting
measurements, it will be a bit confusing.

How about following version?

Attestation is used to verify the trustworthiness of a TDX guest.

During the guest bring-up, Intel TDX module measures and records

the initial contents and configuration of the guest, and at runtime,

guest software uses runtime measurement registers (RMTRs) to measure

and record details related to kernel image, command line params, ACPI

tables, initrd, etc. At guest runtime, the attestation process is used
to
 attest to these measurements.

  

> 
>>
>> First step in the TDX attestation process is to get the TDREPORT data.
>> It is a fixed size data structure generated by the TDX module which
>> includes the above mentioned measurements data, a MAC to protect the
>> integerity of the TDREPORT, and a 64-Byte of user specified data passed
>> during TDREPORT request which can uniquely identify the TDREPORT.
>>
>> Intel's TDX guest driver exposes TDX_CMD_GET_REPORT IOCTL interface to
>> get the TDREPORT from the user space.
>>
>> Add a kernel selftest module to test this ABI and verify the validity
>> of generated TDREPORT.
>>
>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Anyway (although still not sure all the definitions of TDX architectural data
> structures are needed):
> 
> Acked-by: Kai Huang <kai.huang@intel.com>
> 
> 
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
