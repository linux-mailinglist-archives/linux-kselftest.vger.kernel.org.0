Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919A15A4053
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 02:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbiH2ATg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 28 Aug 2022 20:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH2ATf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 28 Aug 2022 20:19:35 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4210E0EF;
        Sun, 28 Aug 2022 17:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661732374; x=1693268374;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=B3Tev0VS3yC7o6xOlmRPAwSGDbYmtAKTYEpG1iByLA8=;
  b=Jke/eLSHQGlxEBlKr4emyWcg48DRePofsRal4SFnpXXXssS7nFIOgxYe
   zQ7h5G+umYoJ4BtNnTdSZQG+tDroT6Pw7ke2b0KUUfmhSm2dMGA81ce/S
   PmrgXklv5ulm6S6iigKzxNWeakhpBUBEXxY+Q3qJEaEk268w60sLmazR7
   0IjfeVDgDdkr9oOuTDCdeHU7WEmLWvgiEMDWIOoSYCD/1RIS8BbxgVCwZ
   ildieXL6ZX0iqOUpi1a+U5Ht1obzKA5YIpZiuACAQzR6Gt/obxV/6RbyC
   NtkaFVbBmtVQ1CRZbeq49QqCMWxlUSErwmxmWiwRLbdtPyqrLMDNEg7Ru
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="293523827"
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="293523827"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2022 17:19:34 -0700
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="587962411"
Received: from nehluza-mobl.amr.corp.intel.com (HELO [10.209.6.250]) ([10.209.6.250])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2022 17:19:33 -0700
Message-ID: <c6ccbcac-c5b1-f460-01e2-e1b6684b6e65@linux.intel.com>
Date:   Sun, 28 Aug 2022 17:19:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v11 1/3] x86/tdx: Add TDX Guest attestation interface
 driver
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
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
 <dcf53e6b-d60f-5d6b-029a-38df68d66302@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <dcf53e6b-d60f-5d6b-029a-38df68d66302@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On 8/28/22 1:14 PM, Dave Hansen wrote:
> On 8/26/22 08:06, Kuppuswamy Sathyanarayanan wrote:
>> +struct tdx_report_req {
>> +	__u8  subtype;
>> +	__u64 reportdata;
>> +	__u32 rpd_len;
>> +	__u64 tdreport;
>> +	__u32 tdr_len;
>> +};
> 
> Please do take a look at how the compiler ends up building that structure.
> 
> If you sized things to "save space", the way the compiler treats that
> structure may surprise you.  You might also want to look at how a 32-bit
> compile deals with it versus a 64-bit one.

Since it is only used in user/kernel ABI, I did not consider the size
issue. But I understand your point. The size of this struct in a 64-bit
system is 40 bytes. So we did not gain anything with using different member
sizes. In a 32-bit system, size due to padding is less compared to 64-bit.

I will re-arrange the struct as below. With this change, the size will come
down to 32 bytes.

struct tdx_report_req {
        __u64 reportdata;;
        __u64 tdreport;
        __u32 rpd_len
        __u32 tdr_len;
        __u8 subtype;
};



-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
