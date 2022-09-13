Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0695B79F8
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Sep 2022 20:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbiIMSqG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Sep 2022 14:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbiIMSpl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Sep 2022 14:45:41 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF2D7B2A4;
        Tue, 13 Sep 2022 11:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663093533; x=1694629533;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UblfnalyvGKyzOm1JXwjImFfqo89UXQzpAJ/gqq3rxM=;
  b=kwlm2fhz1G36SiEAWp+TpWcgKAyaeZejAO3NJ9OmC/sgxQ3JkrHvvnKw
   qQQW3xuFQ2iUkp+nzYW9XxFqRlNx1+BF+riFybks1ThzW01Oz642hurxi
   6BsrWeV4LZ94YBMzaqIRrzp6TFWXD1bvUxPIkq9yB6LjWSCVB3uI4UCIW
   mofIXTM6f3LtNnhmcTGq47v2NrupUnmfyqn5Sx3jQIefRqnZenIT5elfV
   bGtQFLBX2TKjTgmzhaXVWO+nFPgIs+bQsT/9o9YUHYApHIOoRtt+ku2/z
   PMRH4tosrz2w+5/GOHxTTdAM4JhjoZ4nmaBzvq0t3zZh0kkyN4Jsv911N
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="299554408"
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="299554408"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 11:25:32 -0700
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="792030996"
Received: from ewcubbag-mobl2.amr.corp.intel.com (HELO [10.209.57.220]) ([10.209.57.220])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 11:25:31 -0700
Message-ID: <a687a458-9bd2-472f-2243-9ab0fea8b8c4@linux.intel.com>
Date:   Tue, 13 Sep 2022 11:25:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v13 3/3] Documentation/x86: Document TDX attestation
 process
Content-Language: en-US
To:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
 <20220909192708.1113126-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220913175440.wahcdmaumeqjgzmh@box>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220913175440.wahcdmaumeqjgzmh@box>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 9/13/22 10:54 AM, Kirill A . Shutemov wrote:
> On Fri, Sep 09, 2022 at 12:27:08PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> Document details about TDX attestation process and related user API
>> support.
> 
> "related user API support" sounds wrong to me.
> 
> Maybe just "related userspace API"?

Ok

> 
>> Attestation details can be found in Guest-Host-Communication Interface
>> (GHCI) for Intel Trust Domain Extensions (TDX), section titled "TD
>> attestation".
>>
>> [Bagas Sanjaya fixed htmldocs warning]
>> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>
>> Change since v12:
>>  * None
>>
>> Changes since v11:
>>  * Fixed htmldocs warnings.
>>
>>  Documentation/x86/tdx.rst | 75 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 75 insertions(+)
>>
>> diff --git a/Documentation/x86/tdx.rst b/Documentation/x86/tdx.rst
>> index b8fa4329e1a5..c9e3ecf86e0b 100644
>> --- a/Documentation/x86/tdx.rst
>> +++ b/Documentation/x86/tdx.rst
>> @@ -210,6 +210,81 @@ converted to shared on boot.
>>  For coherent DMA allocation, the DMA buffer gets converted on the
>>  allocation. Check force_dma_unencrypted() for details.
>>  
>> +Attestation
>> +===========
>> +
>> +Attestation is used to verify the TDX guest trustworthiness to other
>> +entities before provisioning secrets to the guest. For example, a key
>> +server may request for attestation before releasing the encryption keys
>> +to mount the encrypted rootfs or secondary drive.
> 
> Maybe "may request attestation quote before ..."?
> 
>> +TDX module records the state of the TDX guest in various stages of guest
>> +boot process using build time measurement register (MRTD) and runtime
>> +measurement registers (RTMR). Measurements related to guest initial
>> +configuration and firmware image is recorded in the MRTD register.
>> +Measurements related to initial state, kernel image, firmware image,
>> +command line options, initrd, ACPI tables, etc are recorded in RTMR
>> +registers. For more details, please refer to TDX Virtual Firmware design
>> +specification, sec titled "TD Measurement".
>> +
>> +At TDX guest runtime, the Intel TDX module reuses the Intel SGX attestation
>> +infrastructure to provide support for attesting to these measurements as
>> +described below.
>> +
>> +The attestation process consists of two steps: TDREPORT generation and
>> +Quote generation.
>> +
>> +TDX guest uses TDCALL[TDG.MR.REPORT] to get the TDREPORT (TDREPORT_STRUCT)
>> +from the TDX module. TDREPORT is a fixed-size data structure generated by
>> +the TDX module which contains guest-specific information (such as build
>> +and boot measurements), platform security version, and the MAC to protect
>> +the integrity of the TDREPORT.
>> +
>> +After getting the TDREPORT, the second step of the attestation process
>> +is to send it to the QE to generate the Quote. TDREPORT by design can only
> 
> The first use of QE abbreviation is before it is defined. -EPARSE.

Yes. I already noticed it and fixed it.

> 
>> +be verified on local platform as the MAC key is bound to the platform. To
>> +support remote verification of the TDREPORT, TDX leverages Intel SGX Quote
>> +Enclave (QE) to verify the TDREPORT locally and convert it to a remote
>> +verifiable Quote. Method of sending TDREPORT to QE is implemenentation
>> +specific. Attestation software can choose whatever communication channel
>> +available (i.e. vsock or hypercall) to send the TDREPORT to QE and receive
>> +the Quote.
>> +
>> +To allow userspace attestation agent get the TDREPORT, TDX guest driver
>> +exposes an IOCTL (TDX_CMD_GET_REPORT) interface via /dev/tdx-guest misc
>> +device.
>> +
>> +TDX Guest driver
>> +================
>> +
>> +The TDX guest driver exposes IOCTL interfaces via /dev/tdx-guest misc
>> +device to allow user space to get certain TDX guest specific details
>> +(like attestation report, attestation quote or storage keys, etc).
>> +
>> +In this section, for each supported IOCTL, following information is
>> +provided along with generic description.
> 
> "for each" looks strange as we only have single IOCTL.

I just want to give an overview of IOCTL documentation. Although we have
only one IOCTL now, we have plans to extend it in near future. At least
VERIFYEREPORT IOCTL will be added soon. Do you think I should still
fix it? How about the following?

In this section, in addition to generic information of IOCTL, following
details are provided.

> 
>> +:Input parameters: Parameters passed to the IOCTL and related details.
>> +:Output: Details about output data and return value (with details
>> +         about the non common error values).
>> +
>> +TDX_CMD_GET_REPORT
>> +------------------
>> +
>> +:Input parameters: struct tdx_report_req
>> +:Output: Upon successful execution, TDREPORT data is copied to
>> +         tdx_report_req.tdreport and returns 0 or returns
>> +         -EIO on TDCALL failure and standard error number on
>> +         other common failures.
>> +
>> +The TDX_CMD_GET_REPORT IOCTL can be used by the attestation software to
>> +get the TDX guest measurements data (with few other info) in the format
>> +of TDREPORT_STRUCT. It uses TDCALL[TDG.MR.REPORT] to get the TDREPORT
>> +from the TDX Module.
>> +
>> +Format of TDREPORT_STRUCT can be found in TDX 1.0 Module specification,
>> +sec titled "TDREPORT_STRUCT".
>> +
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
